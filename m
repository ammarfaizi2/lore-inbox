Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUGBVmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUGBVmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbUGBVko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:40:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:31122 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264991AbUGBVkb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:40:31 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] More PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <10888043523764@kroah.com>
Date: Fri, 2 Jul 2004 14:39:12 -0700
Message-Id: <1088804352811@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1787, 2004/07/02 13:33:23-07:00, linas@austin.ibm.com

[PATCH] PCI Hotplug: rpaphp null pointer deref

This patch fixes a null-pointer dereference when hot-plug operations
are performed on a machine that has virtual-io devices in it.
Virtual i/o devices to not have pci bridges associated with them.
It also corrects an ordering problem during hotplug remove.

This patch was previously reviewed/tested by Linda Xie, the current
rpaphp maintainer.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/rpaphp_pci.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
--- a/drivers/pci/hotplug/rpaphp_pci.c	2004-07-02 14:24:33 -07:00
+++ b/drivers/pci/hotplug/rpaphp_pci.c	2004-07-02 14:24:33 -07:00
@@ -378,8 +378,8 @@
 	
 		func = list_entry(ln, struct rpaphp_pci_func, sibling);
 		if (func->pci_dev) {
-			rpaphp_eeh_remove_bus_device(func->pci_dev);
 			pci_remove_bus_device(func->pci_dev); 
+			rpaphp_eeh_remove_bus_device(func->pci_dev);
 		}
 		kfree(func);
 	}
@@ -513,9 +513,18 @@
 		struct list_head *ln;
 
 		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
+		if (slot->bridge == NULL) {
+			if (slot->dev_type == PCI_DEV) {
+				printk(KERN_WARNING "PCI slot missing bridge %s %s \n", 
+				                    slot->name, slot->location);
+			}
+			continue;
+		}
+
 		bus = slot->bridge->subordinate;
-		if (!bus)
-			return NULL; /* shouldn't be here */
+		if (!bus) {
+			continue;  /* should never happen? */
+		}
 		for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
                                 struct pci_dev *pdev = pci_dev_b(ln);
 				if (pdev == dev)

