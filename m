Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267584AbUIBF4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267584AbUIBF4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 01:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267596AbUIBF4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 01:56:12 -0400
Received: from ozlabs.org ([203.10.76.45]:26507 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267480AbUIBFzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 01:55:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16694.46636.123776.684449@cargo.ozlabs.ibm.com>
Date: Thu, 2 Sep 2004 15:57:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linas@austin.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Test for EEH error in PCI Config-Read path
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds explicit checking for EEH slot isolation events into the 
PCI config space read path.  The change itself would have been minor,
except that pci config reads don't have a pointer to a struct pci_dev.
Thus, I had to restructure the eeh code to accomodate this, which
seems to be a good thing anyway, making it a tad cleaner.   

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/eeh.c akpm/arch/ppc64/kernel/eeh.c
--- linux-2.5/arch/ppc64/kernel/eeh.c	2004-08-24 07:22:47.000000000 +1000
+++ akpm/arch/ppc64/kernel/eeh.c	2004-09-01 21:46:25.000000000 +1000
@@ -348,7 +348,7 @@
  * ths routine does *not* convert I/O BAR addresses (which start
  * with 0xE...) to phys addresses!
  */
-static unsigned long eeh_token_to_phys(unsigned long token)
+static inline unsigned long eeh_token_to_phys(unsigned long token)
 {
 	pte_t *ptep;
 	unsigned long pa, vaddr;
@@ -365,24 +365,22 @@
 }
 
 /**
- * eeh_check_failure - check if all 1's data is due to EEH slot freeze
- * @token i/o token, should be address in the form 0xA....
- * @val value, should be all 1's (XXX why do we need this arg??)
+ * eeh_dn_check_failure - check if all 1's data is due to EEH slot freeze
+ * @dn device node
+ * @dev pci device, if known
+ *
+ * Check for an EEH failure for the given device node.  Call this
+ * routine if the result of a read was all 0xff's and you want to
+ * find out if this is due to an EEH slot freeze event.  This routine
+ * will query firmware for the EEH status.
  *
- * Check for an eeh failure at the given token address.
- * The given value has been read and it should be 1's (0xff, 0xffff or
- * 0xffffffff).
+ * Returns 0 if there has not been an EEH error; otherwise returns
+ * an error code.
  *
- * Probe to determine if an error actually occurred.  If not return val.
- * Otherwise panic.
- *
- * Note this routine might be called in an interrupt context ...
+ * It is safe to call this routine in an interrupt context.
  */
-unsigned long eeh_check_failure(void *token, unsigned long val)
+int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 {
-	unsigned long addr;
-	struct pci_dev *dev;
-	struct device_node *dn;
 	int ret;
 	int rets[2];
 	unsigned long flags;
@@ -390,30 +388,19 @@
 	__get_cpu_var(total_mmio_ffs)++;
 
 	if (!eeh_subsystem_enabled)
-		return val;
-
-	/* Finding the phys addr + pci device; this is pretty quick. */
-	addr = eeh_token_to_phys((unsigned long)token);
-	dev = pci_get_device_by_addr(addr);
-	if (!dev)
-		return val;
+		return 0;
 
-	dn = pci_device_to_OF_node(dev);
-	if (!dn) {
-		pci_dev_put(dev);
-		return val;
-	}
+	if (!dn) 
+		return 0;
 
 	/* Access to IO BARs might get this far and still not want checking. */
 	if (!(dn->eeh_mode & EEH_MODE_SUPPORTED) ||
 	    dn->eeh_mode & EEH_MODE_NOCHECK) {
-		pci_dev_put(dev);
-		return val;
+		return 0;
 	}
 
 	if (!dn->eeh_config_addr) {
-		pci_dev_put(dev);
-		return val;
+		return 0;
 	}
 
 	/*
@@ -439,7 +426,7 @@
 		                      BUID_LO(dn->phb->buid), NULL, 0,
 		                      virt_to_phys(slot_errbuf),
 		                      eeh_error_buf_size,
-		                      2 /* Permanent Error */);
+		                      1 /* Temporary Error */);
 
 		if (log_event == 0)
 			log_error(slot_errbuf, ERR_TYPE_RTAS_LOG,
@@ -456,19 +443,53 @@
 		 */
 		if (panic_on_oops) {
 			panic("EEH: MMIO failure (%d) on device:%s %s\n",
-			      rets[0], pci_name(dev), pci_pretty_name(dev));
+			      rets[0], dn->name, dn->full_name);
 		} else {
 			__get_cpu_var(ignored_failures)++;
 			printk(KERN_INFO "EEH: MMIO failure (%d) on device:%s %s\n",
-			       rets[0], pci_name(dev), pci_pretty_name(dev));
+			       rets[0], dn->name, dn->full_name);
 		}
 	} else {
 		__get_cpu_var(false_positives)++;
 	}
 
+	return 0;
+}
+
+EXPORT_SYMBOL(eeh_dn_check_failure);
+
+/**
+ * eeh_check_failure - check if all 1's data is due to EEH slot freeze
+ * @token i/o token, should be address in the form 0xA....
+ * @val value, should be all 1's (XXX why do we need this arg??)
+ *
+ * Check for an eeh failure at the given token address.
+ * Check for an EEH failure at the given token address.  Call this
+ * routine if the result of a read was all 0xff's and you want to
+ * find out if this is due to an EEH slot freeze event.  This routine
+ * will query firmware for the EEH status.
+ *
+ * Note this routine is safe to call in an interrupt context.
+ */
+unsigned long eeh_check_failure(void *token, unsigned long val)
+{
+	unsigned long addr;
+	struct pci_dev *dev;
+	struct device_node *dn;
+
+	/* Finding the phys addr + pci device; this is pretty quick. */
+	addr = eeh_token_to_phys((unsigned long)token);
+	dev = pci_get_device_by_addr(addr);
+	if (!dev)
+		return val;
+
+	dn = pci_device_to_OF_node(dev);
+	eeh_dn_check_failure (dn, dev);
+
 	pci_dev_put(dev);
 	return val;
 }
+
 EXPORT_SYMBOL(eeh_check_failure);
 
 struct eeh_early_enable_info {
diff -urN linux-2.5/arch/ppc64/kernel/pSeries_pci.c akpm/arch/ppc64/kernel/pSeries_pci.c
--- linux-2.5/arch/ppc64/kernel/pSeries_pci.c	2004-08-25 07:48:20.000000000 +1000
+++ akpm/arch/ppc64/kernel/pSeries_pci.c	2004-09-02 15:49:38.754334712 +1000
@@ -68,7 +68,9 @@
 	int ret;
 
 	if (!dn)
-		return -2;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (where & (size - 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	addr = (dn->busno << 16) | (dn->devfn << 8) | where;
 	buid = dn->phb->buid;
@@ -79,7 +81,15 @@
 		ret = rtas_call(read_pci_config, 2, 2, &returnval, addr, size);
 	}
 	*val = returnval;
-	return ret;
+
+	if (ret)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (returnval == EEH_IO_ERROR_VALUE(size)
+	    && eeh_dn_check_failure (dn, NULL))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return PCIBIOS_SUCCESSFUL;
 }
 
 static int rtas_pci_read_config(struct pci_bus *bus,
@@ -106,7 +116,9 @@
 	int ret;
 
 	if (!dn)
-		return -2;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (where & (size - 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	addr = (dn->busno << 16) | (dn->devfn << 8) | where;
 	buid = dn->phb->buid;
@@ -115,7 +127,11 @@
 	} else {
 		ret = rtas_call(write_pci_config, 3, 1, NULL, addr, size, (ulong)val);
 	}
-	return ret;
+
+	if (ret)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return PCIBIOS_SUCCESSFUL;
 }
 
 static int rtas_pci_write_config(struct pci_bus *bus,
diff -urN linux-2.5/include/asm-ppc64/eeh.h akpm/include/asm-ppc64/eeh.h
--- linux-2.5/include/asm-ppc64/eeh.h	2004-08-24 07:22:48.000000000 +1000
+++ akpm/include/asm-ppc64/eeh.h	2004-09-02 15:50:37.460330760 +1000
@@ -44,6 +44,7 @@
 
 extern void __init eeh_init(void);
 unsigned long eeh_check_failure(void *token, unsigned long val);
+int eeh_dn_check_failure (struct device_node *dn, struct pci_dev *dev);
 void *eeh_ioremap(unsigned long addr, void *vaddr);
 void __init pci_addr_cache_build(void);
 
@@ -89,7 +90,15 @@
  */
 #define EEH_POSSIBLE_IO_ERROR(val, type)	((val) == (type)~0)
 
-/* The vaddr will equal the addr if EEH checking is disabled for
+/*
+ * Reads from a device which has been isolated by EEH will return
+ * all 1s.  This macro gives an all-1s value of the given size (in
+ * bytes: 1, 2, or 4) for comparing with the result of a read.
+ */
+#define EEH_IO_ERROR_VALUE(size)	(~0U >> ((4 - (size)) * 8))
+
+/*
+ * The vaddr will equal the addr if EEH checking is disabled for
  * this device.  This is because eeh_ioremap() will not have
  * remapped to 0xA0, and thus both vaddr and addr will be 0xE0...
  */
