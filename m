Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTBFECy>; Wed, 5 Feb 2003 23:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbTBFECx>; Wed, 5 Feb 2003 23:02:53 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:42768 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265339AbTBFECv>;
	Wed, 5 Feb 2003 23:02:51 -0500
Subject: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <20030206040341.GA23658@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
X-mailer: gregkh_patchbomb
Message-id: <1044504483994@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.947.23.1, 2003/02/05 17:15:13+11:00, greg@kroah.com

[PATCH] PCI Hotplug: dereference null variable cleanup patches.

These were pointed out by "dan carpenter" <error27@email.com>
from his smatch tool.


diff -Nru a/drivers/hotplug/cpci_hotplug_pci.c b/drivers/hotplug/cpci_hotplug_pci.c
--- a/drivers/hotplug/cpci_hotplug_pci.c	Thu Feb  6 14:52:28 2003
+++ b/drivers/hotplug/cpci_hotplug_pci.c	Thu Feb  6 14:52:28 2003
@@ -395,6 +395,8 @@
 	/* Scan behind bridge */
 	n = pci_scan_bridge(bus, dev, max, 2);
 	child = pci_find_bus(max + 1);
+	if (!child)
+		return -ENODEV;
 #ifdef CONFIG_PROC_FS
 	pci_proc_attach_bus(child);
 #endif
diff -Nru a/drivers/hotplug/cpqphp_core.c b/drivers/hotplug/cpqphp_core.c
--- a/drivers/hotplug/cpqphp_core.c	Thu Feb  6 14:52:28 2003
+++ b/drivers/hotplug/cpqphp_core.c	Thu Feb  6 14:52:28 2003
@@ -488,6 +488,8 @@
 	bridgeSlot = 0xFF;
 
 	PCIIRQRoutingInfoLength = pcibios_get_irq_routing_table();
+	if (!PCIIRQRoutingInfoLength)
+		return -1;
 
 	len = (PCIIRQRoutingInfoLength->size -
 	       sizeof(struct irq_routing_table)) / sizeof(struct irq_info);
diff -Nru a/drivers/hotplug/cpqphp_ctrl.c b/drivers/hotplug/cpqphp_ctrl.c
--- a/drivers/hotplug/cpqphp_ctrl.c	Thu Feb  6 14:52:28 2003
+++ b/drivers/hotplug/cpqphp_ctrl.c	Thu Feb  6 14:52:28 2003
@@ -188,6 +188,8 @@
 			rc++;
 
 			p_slot = find_slot(ctrl, hp_slot + (readb(ctrl->hpc_reg + SLOT_MASK) >> 4));
+			if (!p_slot)
+				return 0;
 
 			// If the switch closed, must be a button
 			// If not in button mode, nevermind
@@ -1799,8 +1801,12 @@
 				hp_slot = ctrl->event_queue[loop].hp_slot;
 
 				func = cpqhp_slot_find(ctrl->bus, (hp_slot + ctrl->slot_device_offset), 0);
+				if (!func)
+					return;
 
 				p_slot = find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
+				if (!p_slot)
+					return;
 
 				dbg("hp_slot %d, func %p, p_slot %p\n",
 				    hp_slot, func, p_slot);
@@ -2511,8 +2517,14 @@
 		// Setup the IO, memory, and prefetchable windows
 
 		io_node = get_max_resource(&(resources->io_head), 0x1000);
+		if (!io_node)
+			return -ENOMEM;
 		mem_node = get_max_resource(&(resources->mem_head), 0x100000);
+		if (!mem_node)
+			return -ENOMEM;
 		p_mem_node = get_max_resource(&(resources->p_mem_head), 0x100000);
+		if (!p_mem_node)
+			return -ENOMEM;
 		dbg("Setup the IO, memory, and prefetchable windows\n");
 		dbg("io_node\n");
 		dbg("(base, len, next) (%x, %x, %p)\n", io_node->base, io_node->length, io_node->next);
diff -Nru a/drivers/hotplug/cpqphp_pci.c b/drivers/hotplug/cpqphp_pci.c
--- a/drivers/hotplug/cpqphp_pci.c	Thu Feb  6 14:52:28 2003
+++ b/drivers/hotplug/cpqphp_pci.c	Thu Feb  6 14:52:28 2003
@@ -435,6 +435,8 @@
 	u8 tbus, tdevice, tslot;
 
 	PCIIRQRoutingInfoLength = pcibios_get_irq_routing_table();
+	if (!PCIIRQRoutingInfoLength)
+		return -1;
 
 	len = (PCIIRQRoutingInfoLength->size -
 	       sizeof(struct irq_routing_table)) / sizeof(struct irq_info);
diff -Nru a/drivers/hotplug/cpqphp_proc.c b/drivers/hotplug/cpqphp_proc.c
--- a/drivers/hotplug/cpqphp_proc.c	Thu Feb  6 14:52:28 2003
+++ b/drivers/hotplug/cpqphp_proc.c	Thu Feb  6 14:52:28 2003
@@ -113,6 +113,8 @@
 
 	while (slot) {
 		new_slot = cpqhp_slot_find(slot->bus, slot->device, 0);
+		if (!new_slot)
+			break;
 		out += sprintf(out, "assigned resources: memory\n");
 		index = 11;
 		res = new_slot->mem_head;
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Thu Feb  6 14:52:28 2003
+++ b/drivers/hotplug/ibmphp_core.c	Thu Feb  6 14:52:28 2003
@@ -1057,6 +1057,8 @@
 
 	if (func->dev == NULL) {
 		dev0.bus = ibmphp_find_bus (func->busno);
+		if (!dev0.bus)
+			return 0;
 		dev0.devfn = ((func->device << 3) + (func->function & 0x7));
 		dev0.sysdata = dev0.bus->sysdata;
 
@@ -1097,6 +1099,8 @@
 			continue;
 		}
 		tmp_slot = ibmphp_get_slot_from_physical_num (i);
+		if (!tmp_slot)
+			return 0;
 		rc = slot_update (&tmp_slot);
 		if (rc)
 			return 0;
@@ -1219,6 +1223,8 @@
 
 	for (i = slot_cur->bus_on->slot_min; i <= slot_cur->bus_on->slot_max; i++) {
 		tmp_slot = ibmphp_get_slot_from_physical_num (i);
+		if (!tmp_slot)
+			return -ENODEV;
 		if ((SLOT_PWRGD (tmp_slot->status)) && !(SLOT_CONNECT (tmp_slot->status))) 
 			count++;
 	}

