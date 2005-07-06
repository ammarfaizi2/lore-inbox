Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVGFSd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVGFSd7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 14:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVGFSd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 14:33:59 -0400
Received: from ns2.suse.de ([195.135.220.15]:47036 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261983AbVGFNct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:32:49 -0400
Date: Wed, 6 Jul 2005 15:32:48 +0200
From: Andi Kleen <ak@suse.de>
To: christoph@lameter.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, gregkh@suse.de
Subject: [PATCH] Run PCI driver initialization on local node
Message-ID: <20050706133248.GG21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Run PCI driver initialization on local node

Instead of adding messy kmalloc_node()s everywhere run the 
PCI driver probe on the node local to the device.
Then the normal NUMA aware allocators do the right thing.

This would not have helped for IDE, but should for 
other more clean drivers that do more initialization in probe().
It won't help for drivers that do most of the work
on first open (like many network drivers)

Signed-off-by: Andi Kleen <ak@suse.de> 
cc: christoph@lameter.com

Index: linux/drivers/pci/pci-driver.c
===================================================================
--- linux.orig/drivers/pci/pci-driver.c
+++ linux/drivers/pci/pci-driver.c
@@ -167,6 +167,27 @@ const struct pci_device_id *pci_match_de
 	return NULL;
 }
 
+static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev, 
+			  const struct pci_device_id *id)
+{
+	int error;
+#ifdef CONFIG_NUMA
+	/* Execute driver initialization on node where the 
+	   device's bus is attached to.  This way the driver likely
+	   allocates its local memory on the right node without
+	   any need to change it. */
+	cpumask_t oldmask = current->cpus_allowed;
+	int node = pcibus_to_node(dev->bus);
+	if (node >= 0 && node_online(node))
+	    set_cpus_allowed(current, node_to_cpumask(node));	
+#endif
+	error = drv->probe(dev, id);
+#ifdef CONFIG_NUMA
+	set_cpus_allowed(current, oldmask);
+#endif
+	return error;
+}
+
 /**
  * __pci_device_probe()
  * 
@@ -184,7 +205,7 @@ __pci_device_probe(struct pci_driver *dr
 
 		id = pci_match_device(drv, pci_dev);
 		if (id)
-			error = drv->probe(pci_dev, id);
+			error = pci_call_probe(drv, pci_dev, id);
 		if (error >= 0) {
 			pci_dev->driver = drv;
 			error = 0;
