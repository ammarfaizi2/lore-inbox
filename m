Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265257AbTFZAhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTFZAgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:36:13 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:21399 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265251AbTFZAfG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:35:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1056588494675@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.73
In-Reply-To: <10565884943135@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Jun 2003 17:48:14 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1429.2.5, 2003/06/25 17:08:13-07:00, willy@debian.org

[PATCH] PCI: fixes for pci/probe.c

 - Combine pci_alloc_primary_bus_parented into pci_scan_bus_parented.
 - Move the EXPORT_SYMBOL for pci_root_buses up to its definition.
 - Don't EXPORT_SYMBOL pci_scan_bus since it's a static inline.
 - Add the pci_domain_nr() to the sysfs name for this bus.


 drivers/pci/probe.c |   34 +++++++++++++++-------------------
 1 files changed, 15 insertions(+), 19 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Wed Jun 25 17:38:03 2003
+++ b/drivers/pci/probe.c	Wed Jun 25 17:38:03 2003
@@ -18,7 +18,10 @@
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
 
+/* Ugh.  Need to stop exporting this to modules. */
 LIST_HEAD(pci_root_buses);
+EXPORT_SYMBOL(pci_root_buses);
+
 LIST_HEAD(pci_devices);
 
 /*
@@ -643,7 +646,7 @@
 	return 0;
 }
 
-static struct pci_bus * __devinit pci_alloc_primary_bus_parented(struct device *parent, int bus)
+struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
 {
 	struct pci_bus *b;
 
@@ -656,46 +659,39 @@
 	b = pci_alloc_bus();
 	if (!b)
 		return NULL;
-	
+
 	b->dev = kmalloc(sizeof(*(b->dev)),GFP_KERNEL);
 	if (!b->dev){
 		kfree(b);
 		return NULL;
 	}
-	
+
+	b->sysdata = sysdata;
+	b->ops = ops;
+
 	list_add_tail(&b->node, &pci_root_buses);
 
 	memset(b->dev,0,sizeof(*(b->dev)));
-	sprintf(b->dev->bus_id,"pci%d",bus);
-	strcpy(b->dev->name,"Host/PCI Bridge");
 	b->dev->parent = parent;
+	sprintf(b->dev->bus_id,"pci%04x:%02x", pci_domain_nr(b), bus);
+	strcpy(b->dev->name,"Host/PCI Bridge");
 	device_register(b->dev);
 
 	b->number = b->secondary = bus;
 	b->resource[0] = &ioport_resource;
 	b->resource[1] = &iomem_resource;
-	return b;
-}
 
-struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
-{
-	struct pci_bus *b = pci_alloc_primary_bus_parented(parent, bus);
-	if (b) {
-		b->sysdata = sysdata;
-		b->ops = ops;
-		b->subordinate = pci_scan_child_bus(b);
-		pci_bus_add_devices(b);
-	}
+	b->subordinate = pci_scan_child_bus(b);
+
+	pci_bus_add_devices(b);
+
 	return b;
 }
 EXPORT_SYMBOL(pci_scan_bus_parented);
 
-EXPORT_SYMBOL(pci_root_buses);
-
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_add_new_bus);
 EXPORT_SYMBOL(pci_do_scan_bus);
 EXPORT_SYMBOL(pci_scan_slot);
-EXPORT_SYMBOL(pci_scan_bus);
 EXPORT_SYMBOL(pci_scan_bridge);
 #endif

