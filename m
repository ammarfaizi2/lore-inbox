Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269517AbUIZMVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269517AbUIZMVR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 08:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269518AbUIZMVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 08:21:17 -0400
Received: from verein.lst.de ([213.95.11.210]:37772 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269517AbUIZMVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 08:21:02 -0400
Date: Sun, 26 Sep 2004 14:20:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: anton@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] reduce ifdef clutter in arch/ppc64/kernel/pci.c
Message-ID: <20040926122059.GB2179@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This file would greatly benefit from splitting the (new) big
CONFIG_PPC_MULTIPLATFORM block into a separate file, so if someone is
bored..


--- 1.46/arch/ppc64/kernel/pci.c	2004-09-21 10:14:56 +02:00
+++ edited/arch/ppc64/kernel/pci.c	2004-09-25 17:16:44 +02:00
@@ -256,18 +256,6 @@
 		pcibios_claim_one_bus(child_bus);
 }
 
-#ifndef CONFIG_PPC_ISERIES
-static void __init pcibios_claim_of_setup(void)
-{
-	struct list_head *lb;
-
-	for (lb = pci_root_buses.next; lb != &pci_root_buses; lb = lb->next) {
-		struct pci_bus *b = pci_bus_b(lb);
-		pcibios_claim_one_bus(b);
-	}
-}
-#endif
-
 static int __init pcibios_init(void)
 {
 	struct pci_controller *hose, *tmp;
@@ -289,13 +277,17 @@
 	}
 
 #ifndef CONFIG_PPC_ISERIES
-	if (pci_probe_only)
-		pcibios_claim_of_setup();
-	else
+	if (pci_probe_only) {
+		struct pci_bus *b;
+
+		list_for_each_entry(b, &pci_root_buses, node)
+			pcibios_claim_one_bus(b);
+	} else {
 		/* FIXME: `else' will be removed when
 		   pci_assign_unassigned_resources() is able to work
 		   correctly with [partially] allocated PCI tree. */
 		pci_assign_unassigned_resources();
+	}
 #endif /* !CONFIG_PPC_ISERIES */
 
 	/* Call machine dependent final fixup */
@@ -350,37 +342,6 @@
 }
 
 /*
- * Return the domain number for this bus.
- */
-int pci_domain_nr(struct pci_bus *bus)
-{
-#ifdef CONFIG_PPC_ISERIES
-	return 0;
-#else
-	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
-
-	return hose->global_number;
-#endif
-}
-
-EXPORT_SYMBOL(pci_domain_nr);
-
-/* Set the name of the bus as it appears in /proc/bus/pci */
-int pci_name_bus(char *name, struct pci_bus *bus)
-{
-#ifndef CONFIG_PPC_ISERIES
-	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
-
-	if (hose->buid)
-		sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
-	else
-#endif
-		sprintf(name, "%02x", bus->number);
-
-	return 0;
-}
-
-/*
  * Platform support for /proc/bus/pci/X/Y mmap()s,
  * modelled on the sparc64 implementation by Dave Miller.
  *  -- paulus.
@@ -508,6 +469,29 @@
 }
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
+
+/* Return the domain number for this bus. */
+int pci_domain_nr(struct pci_bus *bus)
+{
+	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
+
+	return hose->global_number;
+}
+EXPORT_SYMBOL(pci_domain_nr);
+
+/* Set the name of the bus as it appears in /proc/bus/pci */
+int pci_name_bus(char *name, struct pci_bus *bus)
+{
+	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
+
+	if (hose->buid)
+		sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
+	else
+		sprintf(name, "%02x", bus->number);
+
+	return 0;
+}
+
 static ssize_t pci_show_devspec(struct device *dev, char *buf)
 {
 	struct pci_dev *pdev;
@@ -520,17 +504,13 @@
 	return sprintf(buf, "%s", np->full_name);
 }
 static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
-#endif /* CONFIG_PPC_MULTIPLATFORM */
+
 
 void pcibios_add_platform_entries(struct pci_dev *pdev)
 {
-#ifdef CONFIG_PPC_MULTIPLATFORM
 	device_create_file(&pdev->dev, &dev_attr_devspec);
-#endif /* CONFIG_PPC_MULTIPLATFORM */
 }
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
-
 #define ISA_SPACE_MASK 0x1
 #define ISA_SPACE_IO 0x1
 
@@ -845,4 +825,20 @@
 }
 EXPORT_SYMBOL(pci_read_irq_line);
 
+#else 
+int pci_domain_nr(struct pci_bus *bus)
+{
+	return 0;
+}
+EXPORT_SYMBOL(pci_domain_nr);
+
+int pci_name_bus(char *name, struct pci_bus *bus)
+{
+	sprintf(name, "%02x", bus->number);
+	return 0;
+}
+
+void pcibios_add_platform_entries(struct pci_dev *pdev)
+{
+}
 #endif /* CONFIG_PPC_MULTIPLATFORM */
