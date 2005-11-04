Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030584AbVKDAxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030584AbVKDAxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbVKDAwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:52:41 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:3988 "EHLO
	mail.gnucash.org") by vger.kernel.org with ESMTP id S932146AbVKDAwN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:52:13 -0500
Date: Thu, 3 Nov 2005 18:52:01 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 22/42]: PCI: remove duplicted pci hotplug code
Message-ID: <20051104005201.GA27016@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

22-rpaphp-eliminate-dupe-code.patch

The RPAPHP code contains two routines that appear to be gratiuitous copies
of very similar pci code.  In particular, 
   
   rpaphp_claim_resource ~~ pci_claim_resource
   rpadlpar_claim_one_bus == pcibios_claim_one_bus

This patch removes the rpaphp versions of the code.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


Index: linux-2.6.14-git3/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/pci/hotplug/rpaphp_pci.c	2005-11-02 14:36:48.081360405 -0600
+++ linux-2.6.14-git3/drivers/pci/hotplug/rpaphp_pci.c	2005-11-02 14:36:51.785840999 -0600
@@ -62,28 +62,6 @@
 }
 EXPORT_SYMBOL_GPL(rpaphp_find_pci_bus);
 
-int rpaphp_claim_resource(struct pci_dev *dev, int resource)
-{
-	struct resource *res = &dev->resource[resource];
-	struct resource *root = pci_find_parent_resource(dev, res);
-	char *dtype = resource < PCI_BRIDGE_RESOURCES ? "device" : "bridge";
-	int err = -EINVAL;
-
-	if (root != NULL) {
-		err = request_resource(root, res);
-	}
-
-	if (err) {
-		err("PCI: %s region %d of %s %s [%lx:%lx]\n",
-		    root ? "Address space collision on" :
-		    "No parent found for",
-		    resource, dtype, pci_name(dev), res->start, res->end);
-	}
-	return err;
-}
-
-EXPORT_SYMBOL_GPL(rpaphp_claim_resource);
-
 static int rpaphp_get_sensor_state(struct slot *slot, int *state)
 {
 	int rc;
@@ -178,7 +156,7 @@
 
 				if (r->parent || !r->start || !r->flags)
 					continue;
-				rpaphp_claim_resource(dev, i);
+				pci_claim_resource(dev, i);
 			}
 		}
 	}
Index: linux-2.6.14-git3/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/pci/hotplug/rpadlpar_core.c	2005-11-02 14:35:52.800111285 -0600
+++ linux-2.6.14-git3/drivers/pci/hotplug/rpadlpar_core.c	2005-11-02 14:36:51.793839877 -0600
@@ -112,28 +112,6 @@
         return NULL;
 }
 
-static void rpadlpar_claim_one_bus(struct pci_bus *b)
-{
-	struct list_head *ld;
-	struct pci_bus *child_bus;
-
-	for (ld = b->devices.next; ld != &b->devices; ld = ld->next) {
-		struct pci_dev *dev = pci_dev_b(ld);
-		int i;
-
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *r = &dev->resource[i];
-
-			if (r->parent || !r->start || !r->flags)
-				continue;
-			rpaphp_claim_resource(dev, i);
-		}
-	}
-
-	list_for_each_entry(child_bus, &b->children, node)
-		rpadlpar_claim_one_bus(child_bus);
-}
-
 static int pci_add_secondary_bus(struct device_node *dn,
 		struct pci_dev *bridge_dev)
 {
@@ -158,7 +136,7 @@
 	pcibios_fixup_bus(child);
 
 	/* Claim new bus resources */
-	rpadlpar_claim_one_bus(bridge_dev->bus);
+	pcibios_claim_one_bus(bridge_dev->bus);
 
 	if (hose->last_busno < child->number)
 		hose->last_busno = child->number;
Index: linux-2.6.14-git3/arch/ppc64/kernel/pci.c
===================================================================
--- linux-2.6.14-git3.orig/arch/ppc64/kernel/pci.c	2005-11-02 14:28:57.119385510 -0600
+++ linux-2.6.14-git3/arch/ppc64/kernel/pci.c	2005-11-02 14:36:51.808837774 -0600
@@ -197,7 +197,7 @@
 	spin_unlock(&hose_spinlock);
 }
 
-static void __init pcibios_claim_one_bus(struct pci_bus *b)
+void __devinit pcibios_claim_one_bus(struct pci_bus *b)
 {
 	struct pci_dev *dev;
 	struct pci_bus *child_bus;
Index: linux-2.6.14-git3/include/asm-ppc64/pci.h
===================================================================
--- linux-2.6.14-git3.orig/include/asm-ppc64/pci.h	2005-11-02 14:28:57.119385510 -0600
+++ linux-2.6.14-git3/include/asm-ppc64/pci.h	2005-11-02 14:36:51.813837073 -0600
@@ -160,6 +160,8 @@
 extern void
 pcibios_fixup_device_resources(struct pci_dev *dev, struct pci_bus *bus);
 
+extern void pcibios_claim_one_bus(struct pci_bus *b);
+
 extern struct pci_controller *init_phb_dynamic(struct device_node *dn);
 
 extern int pci_read_irq_line(struct pci_dev *dev);
