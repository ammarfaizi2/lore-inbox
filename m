Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVJFXoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVJFXoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVJFXoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:44:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:17066 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932082AbVJFXop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:44:45 -0400
Date: Thu, 6 Oct 2005 18:44:43 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 13/22] ppc64: RPAPHP duplicated code removal
Message-ID: <20051006234443.GN29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


13-rpaphp-eliminate-dupe-code.patch

The RPAPHP code contains two routines that appear to be gratiuitous copies
of very similar pci code.  In particular, 
   
   rpaphp_claim_resource ~~ pci_claim_resource
   rpadlpar_claim_one_bus == pcibios_claim_one_bus

This patch removes the rpaphp versions of the code.
This patch survived an overnight run of thousands of 
add/remove of the slots and phb.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


Index: linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/pci/hotplug/rpaphp_pci.c	2005-10-06 17:53:55.542114371 -0500
+++ linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpaphp_pci.c	2005-10-06 17:53:57.832792967 -0500
@@ -60,28 +60,6 @@
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
@@ -176,7 +154,7 @@
 
 				if (r->parent || !r->start || !r->flags)
 					continue;
-				rpaphp_claim_resource(dev, i);
+				pci_claim_resource(dev, i);
 			}
 		}
 	}
Index: linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/pci/hotplug/rpadlpar_core.c	2005-10-06 17:53:50.226860151 -0500
+++ linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpadlpar_core.c	2005-10-06 17:53:57.834792686 -0500
@@ -109,28 +109,6 @@
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
@@ -155,7 +133,7 @@
 	pcibios_fixup_bus(child);
 
 	/* Claim new bus resources */
-	rpadlpar_claim_one_bus(bridge_dev->bus);
+	pcibios_claim_one_bus(bridge_dev->bus);
 
 	if (hose->last_busno < child->number)
 		hose->last_busno = child->number;
Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/pci.c	2005-10-06 17:50:25.899529261 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci.c	2005-10-06 17:53:57.836792405 -0500
@@ -198,7 +198,7 @@
 	spin_unlock(&hose_spinlock);
 }
 
-static void __init pcibios_claim_one_bus(struct pci_bus *b)
+void __devinit pcibios_claim_one_bus(struct pci_bus *b)
 {
 	struct pci_dev *dev;
 	struct pci_bus *child_bus;
Index: linux-2.6.14-rc2-git6/include/asm-ppc64/pci.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/include/asm-ppc64/pci.h	2005-10-06 17:50:25.899529261 -0500
+++ linux-2.6.14-rc2-git6/include/asm-ppc64/pci.h	2005-10-06 17:53:57.836792405 -0500
@@ -160,6 +160,8 @@
 extern void
 pcibios_fixup_device_resources(struct pci_dev *dev, struct pci_bus *bus);
 
+extern void pcibios_claim_one_bus(struct pci_bus *b);
+
 extern struct pci_controller *init_phb_dynamic(struct device_node *dn);
 
 extern int pci_read_irq_line(struct pci_dev *dev);
