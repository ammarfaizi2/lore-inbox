Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266337AbUGAXQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266337AbUGAXQw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 19:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266350AbUGAXQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 19:16:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:37804 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266337AbUGAXQt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 19:16:49 -0400
Date: Thu, 1 Jul 2004 18:16:05 -0500
From: linas@austin.ibm.com
To: Greg KH <greg@kroah.com>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6 PCI Hotplug null pointer deref
Message-ID: <20040701181605.M21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg,

Please review the attached patch and, if acceptable, apply to the 
akpm/otrvalds/bkbits kernel tree.

This patch fixes a null-pointer dereference when hot-plug operations 
are performed on a machine that has virtual-io devices in it.  
Virtual i/o devices to not have pci bridges associated with them.
It also corrects an ordering problem during hotplug remove.

This patch was previously reviewed/tested by Linda Xie, the current
rpaphp maintainer.

--linas

Signed-off-by: Linas Vepstas <linas@linas.org>


===== drivers/pci/hotplug/rpaphp_pci.c 1.8 vs edited =====
--- 1.8/drivers/pci/hotplug/rpaphp_pci.c	Tue Jun  8 17:53:59 2004
+++ edited/drivers/pci/hotplug/rpaphp_pci.c	Thu Jul  1 18:03:57 2004
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
