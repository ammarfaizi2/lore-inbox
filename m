Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUGCCpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUGCCpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 22:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUGCCpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 22:45:45 -0400
Received: from ozlabs.org ([203.10.76.45]:5335 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265041AbUGCCpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 22:45:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16614.2839.493260.484934@cargo.ozlabs.ibm.com>
Date: Sat, 3 Jul 2004 11:25:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linas@linas.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 2.6 remove deprecated firmware API
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Linas Vepstas <linas@austin.ibm.com>

This patch eliminates the usage of the deprecated ibm,fw-phb-id 
token for idnetifying PCI bus heads in favor of the documented, 
offically supported mechanism for obtaining this info.  Please 
note that some versions of firmware may return incorrect values 
for the ibm,fw-phb-id token.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/eeh.c test25/arch/ppc64/kernel/eeh.c
--- linux-2.5/arch/ppc64/kernel/eeh.c	2004-07-03 08:37:48.172936760 +1000
+++ test25/arch/ppc64/kernel/eeh.c	2004-07-03 11:17:39.251929856 +1000
@@ -543,7 +543,7 @@
 			       dn->full_name);
 #endif
 		} else {
-			printk(KERN_WARNING "EEH: %s: rtas_call failed.\n",
+			printk(KERN_WARNING "EEH: %s: could not enable EEH, rtas_call failed.\n",
 			       dn->full_name);
 		}
 	} else {
@@ -588,24 +588,17 @@
 	}
 
 	/* Enable EEH for all adapters.  Note that eeh requires buid's */
+	init_pci_config_tokens();
 	for (phb = of_find_node_by_name(NULL, "pci"); phb;
 	     phb = of_find_node_by_name(phb, "pci")) {
-		int len;
-		int *buid_vals;
+		unsigned long buid;
 
-		buid_vals = (int *)get_property(phb, "ibm,fw-phb-id", &len);
-		if (!buid_vals)
+		buid = get_phb_buid(phb);
+		if (buid == 0) 
 			continue;
-		if (len == sizeof(int)) {
-			info.buid_lo = buid_vals[0];
-			info.buid_hi = 0;
-		} else if (len == sizeof(int)*2) {
-			info.buid_hi = buid_vals[0];
-			info.buid_lo = buid_vals[1];
-		} else {
-			printk(KERN_INFO "EEH: odd ibm,fw-phb-id len returned: %d\n", len);
-			continue;
-		}
+		
+		info.buid_lo = BUID_LO(buid);
+		info.buid_hi = BUID_HI(buid);
 		traverse_pci_devices(phb, early_enable_eeh, NULL, &info);
 	}
 
diff -urN linux-2.5/arch/ppc64/kernel/pSeries_pci.c test25/arch/ppc64/kernel/pSeries_pci.c
--- linux-2.5/arch/ppc64/kernel/pSeries_pci.c	2004-07-03 08:37:48.188934328 +1000
+++ test25/arch/ppc64/kernel/pSeries_pci.c	2004-07-03 11:17:39.258928792 +1000
@@ -355,14 +355,51 @@
 	iounmap(chip_regs);
 }
 
-struct pci_controller *alloc_phb(struct device_node *dev,
+void __init init_pci_config_tokens (void)
+{
+	read_pci_config = rtas_token("read-pci-config");
+	write_pci_config = rtas_token("write-pci-config");
+	ibm_read_pci_config = rtas_token("ibm,read-pci-config");
+	ibm_write_pci_config = rtas_token("ibm,write-pci-config");
+}
+
+unsigned long __init get_phb_buid (struct device_node *phb)
+{
+	int addr_cells;
+	unsigned int *buid_vals;
+	unsigned int len;
+	unsigned long buid;
+
+	if (ibm_read_pci_config == -1) return 0;
+
+	/* PHB's will always be children of the root node,
+	 * or so it is promised by the current firmware. */
+	if (phb->parent == NULL) 
+		return 0;
+	if (phb->parent->parent) 
+		return 0;
+
+	buid_vals = (unsigned int *) get_property(phb, "reg", &len);
+	if (buid_vals == NULL) 
+		return 0;
+
+	addr_cells = prom_n_addr_cells(phb);
+	if (addr_cells == 1) {
+		buid = (unsigned long) buid_vals[0];
+	} else {
+		buid = (((unsigned long)buid_vals[0]) << 32UL) |
+			(((unsigned long)buid_vals[1]) & 0xffffffff);
+	}
+	return buid;
+}
+
+static struct pci_controller * __init alloc_phb(struct device_node *dev,
 				 unsigned int addr_size_words)
 {
 	struct pci_controller *phb;
 	unsigned int *ui_ptr = NULL, len;
 	struct reg_property64 reg_struct;
 	int *bus_range;
-	int *buid_vals;
 	char *model;
 	enum phb_types phb_type;
  	struct property *of_prop;
@@ -433,18 +470,7 @@
 	phb->arch_data   = dev;
 	phb->ops = &rtas_pci_ops;
 
-	buid_vals = (int *) get_property(dev, "ibm,fw-phb-id", &len);
-
-	if (buid_vals == NULL) {
-		phb->buid = 0;
-	} else {
-		if (len < 2 * sizeof(int))
-			// Support for new OF that only has 1 integer for buid.
-			phb->buid = (unsigned long)buid_vals[0];
-		else
-			phb->buid = (((unsigned long)buid_vals[0]) << 32UL) |
-				(((unsigned long)buid_vals[1]) & 0xffffffff);
-	}
+	phb->buid = get_phb_buid(dev);
 
 	return phb;
 }
@@ -458,11 +484,6 @@
 	unsigned int *opprop;
 	struct device_node *root = of_find_node_by_path("/");
 
-	read_pci_config = rtas_token("read-pci-config");
-	write_pci_config = rtas_token("write-pci-config");
-	ibm_read_pci_config = rtas_token("ibm,read-pci-config");
-	ibm_write_pci_config = rtas_token("ibm,write-pci-config");
-
 	if (naca->interrupt_controller == IC_OPEN_PIC) {
 		opprop = (unsigned int *)get_property(root,
 				"platform-open-pic", NULL);
diff -urN linux-2.5/arch/ppc64/kernel/pci.h test25/arch/ppc64/kernel/pci.h
--- linux-2.5/arch/ppc64/kernel/pci.h	2004-03-17 22:09:23.000000000 +1100
+++ test25/arch/ppc64/kernel/pci.h	2004-07-03 11:17:39.286924536 +1000
@@ -47,4 +47,9 @@
 void pci_addr_cache_insert_device(struct pci_dev *dev);
 void pci_addr_cache_remove_device(struct pci_dev *dev);
 
+/* From pSeries_pci.h */
+void init_pci_config_tokens (void);
+unsigned long get_phb_buid (struct device_node *);
+
+
 #endif /* __PPC_KERNEL_PCI_H__ */
