ANSIBLE=ansible-playbook -i ansible_hosts --private-key vagrant_private_key

.PHONY: all vms controller keystone glance nova-controller vms compute destroy run

all: vms controller compute run

controller: vms keystone glance nova-controller

keystone:
	$(ANSIBLE) playbooks/keystone/setup.yaml

glance:
	$(ANSIBLE) playbooks/glance/setup.yaml

nova-controller:
	$(ANSIBLE) playbooks/nova/controller.yaml

vms:
	cd vms; vagrant up

compute:
	$(ANSIBLE) playbooks/nova/compute-host.yaml

cinder:
	$(ANSIBLE) playbooks/cinder/setup.yaml

destroy:
	cd vms; vagrant destroy --force

run:
	./boot-cirros.sh

