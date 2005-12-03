Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVLCBkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVLCBkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVLCBkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:40:35 -0500
Received: from havoc.gtf.org ([69.61.125.42]:45728 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751137AbVLCBke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:40:34 -0500
Date: Fri, 2 Dec 2005 20:40:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, ak@suse.de
Subject: [PATCH 3/3] x86 PCI domain support: the meat
Message-ID: <20051203014033.GC2663@havoc.gtf.org>
References: <20051203013904.GA2560@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203013904.GA2560@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



commit 31c93c154ca9a86a865b4ef28b7ba5d8e48f7b13
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Fri Dec 2 20:30:48 2005 -0500

    [x86, PCI] add PCI domain support
    
    * Store PCI domain in struct pci_sysdata
    * Add magic inlines to pass PCI domain to read/write config hooks
    * Support ACPI's notion of PCI domains (PCI segments)

 arch/i386/pci/acpi.c     |   20 ++++++++++++++++++--
 include/asm-i386/pci.h   |   14 ++++++++++++++
 include/asm-x86_64/pci.h |   14 ++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)


31c93c154ca9a86a865b4ef28b7ba5d8e48f7b13
diff --git a/arch/i386/pci/acpi.c b/arch/i386/pci/acpi.c
index 107b18d..38a752d 100644
--- a/arch/i386/pci/acpi.c
+++ b/arch/i386/pci/acpi.c
@@ -8,18 +8,34 @@
 struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_device *device, int domain, int busnum)
 {
 	struct pci_bus *bus;
+	struct pci_sysdata *sd;
 
+	/* Allocate per-root-bus (not per bus) arch-specific data.
+	 * TODO: leak; this memory is never freed.
+	 * It's arguable whether it's worth the trouble to care.
+	 */
+	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
+	if (!sd) {
+		printk(KERN_ERR "PCI: OOM, not probing PCI bus %02x\n", busnum);
+		return NULL;
+	}
+
+#ifdef CONFIG_PCI_DOMAINS
+	sd->domain = domain;
+#else
 	if (domain != 0) {
 		printk(KERN_WARNING "PCI: Multiple domains not supported\n");
 		return NULL;
 	}
+#endif /* CONFIG_PCI_DOMAINS */
 
-	bus = pcibios_scan_root(busnum);
+	bus = pci_scan_bus_parented(NULL, busnum, &pci_root_ops, sd);
+	if (!bus)
+		kfree(sd);
 #ifdef CONFIG_ACPI_NUMA
 	if (bus != NULL) {
 		int pxm = acpi_get_pxm(device->handle);
 		if (pxm >= 0) {
-			struct pci_sysdata *sd = bus->sysdata;
 			sd->node = pxm_to_node(pxm);
 			printk("bus %d -> pxm %d -> node %d\n",
 				busnum, pxm, sd->node);
diff --git a/include/asm-i386/pci.h b/include/asm-i386/pci.h
index f56a158..4068d1c 100644
--- a/include/asm-i386/pci.h
+++ b/include/asm-i386/pci.h
@@ -6,9 +6,23 @@
 #ifdef __KERNEL__
 
 struct pci_sysdata {
+	int		domain;		/* PCI domain */
 	int		node;		/* NUMA node */
 };
 
+#ifdef CONFIG_PCI_DOMAINS
+static inline int pci_domain_nr(struct pci_bus *bus)
+{
+	struct pci_sysdata *sd = bus->sysdata;
+	return sd->domain;
+}
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	return pci_domain_nr(bus);
+}
+#endif /* CONFIG_PCI_DOMAINS */
+
 #include <linux/mm.h>		/* for struct page */
 
 /* Can be used to override the logic in pci_scan_bus for skipping
diff --git a/include/asm-x86_64/pci.h b/include/asm-x86_64/pci.h
index 424c1ee..bcbf9aa 100644
--- a/include/asm-x86_64/pci.h
+++ b/include/asm-x86_64/pci.h
@@ -7,9 +7,23 @@
 #ifdef __KERNEL__
 
 struct pci_sysdata {
+	int		domain;		/* PCI domain */
 	int		node;		/* NUMA node */
 };
 
+#ifdef CONFIG_PCI_DOMAINS
+static inline int pci_domain_nr(struct pci_bus *bus)
+{
+	struct pci_sysdata *sd = bus->sysdata;
+	return sd->domain;
+}
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	return pci_domain_nr(bus);
+}
+#endif /* CONFIG_PCI_DOMAINS */
+
 #include <linux/mm.h> /* for struct page */
 
 /* Can be used to override the logic in pci_scan_bus for skipping
