Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266570AbUGUUz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266570AbUGUUz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 16:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUGUUz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 16:55:57 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:29313 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266570AbUGUUyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 16:54:44 -0400
Date: Wed, 21 Jul 2004 15:54:41 -0500
To: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org,
       antonb@samba.org, paulus@samba.org, paulus@au1.ibm.com
Subject: Resending [PATCH] 2.6 ppc64 Test for EEH error in PCI Config-Read path
Message-ID: <20040721205441.GH13171@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Resending, struggling with failed email deleivery system

--linas

----- Forwarded message from Mail Delivery System <Mailer-Daemon@bilge> -----
------ This is a copy of the message, including all the headers. ------

Return-path: <linas@bilge>
Received: from linas by bilge with local (Exim 3.36 #1 (Debian))
	id 1BmbiT-0001zP-00; Mon, 19 Jul 2004 12:14:17 -0500
Date: Mon, 19 Jul 2004 12:14:16 -0500
To: paulus@au1.ibm.com, paulus@samba.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
	antonb@samba.org
Subject: [PATCH] 2.6 ppc64 Test for EEH error in PCI Config-Read path
Message-ID: <20040719171416.GC7544@bilge>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Linas Vepstas <linas@bilge>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

Resending patch from 9 July;
I haven't received any comments on it; please forward upstream.

--linas

> Paul,
> 
> This patch adds explicit checking for EEH slot isolation events into the 
> PCI config space read path.  The change itself would have been minor,
> except that pci config reads don't have a pointer to a struct pci_dev.
> Thus, I had to restructure the eeh code to accomodate this, which
> seems to be a good thing anyway, making it a tad cleaner.   This patch
> presumes the earlier patches i.e. the notifier-call chain patch) have
> been applied.
> 
> Signed-off-by: Linas Vepstas <linas@linas.org>
> 
> --linas 

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eeh-config-read.patch"

===== arch/ppc64/kernel/eeh.c 1.27 vs edited =====
--- 1.27/arch/ppc64/kernel/eeh.c	Thu Jul  8 12:04:25 2004
+++ edited/arch/ppc64/kernel/eeh.c	Thu Jul  8 17:40:42 2004
@@ -399,7 +399,7 @@
  * @dev pci device that had an eeh event
  * @reset_state current reset state of the device slot
  */
-static void eeh_panic(struct pci_dev *dev, int reset_state)
+static void eeh_panic(struct device_node *dn, int reset_state)
 {
 	/*
 	 * XXX We should create a seperate sysctl for this.
@@ -408,12 +408,12 @@
 	 * in light of potential corruption, we can use it here.
 	 */
 	if (panic_on_oops)
-		panic("EEH: MMIO failure (%d) on device:%s %s\n", reset_state,
-		      pci_name(dev), pci_pretty_name(dev));
+		panic("EEH: MMIO failure (%d) on device:%s %s\n", 
+		      reset_state, dn->name, dn->full_name);
 	else {
 		__get_cpu_var(ignored_failures)++;
 		printk(KERN_INFO "EEH: Ignored MMIO failure (%d) on device:%s %s\n",
-		       reset_state, pci_name(dev), pci_pretty_name(dev));
+		      reset_state, dn->name, dn->full_name);
 	}
 }
 
@@ -447,7 +447,7 @@
 		    strcmp(event->dn->name, "ethernet") == 0) {
 			printk(KERN_INFO "EEH: MMIO failure (%d), notifiying device "
 				"%s %s\n", event->reset_state,
-				pci_name(event->dev), pci_pretty_name(event->dev));
+				event->dn->name, event->dn->full_name);
 
 			notifier_call_chain (&eeh_notifier_chain, 
 			                     EEH_NOTIFY_FREEZE, event);
@@ -457,11 +457,12 @@
 		} else {
 			printk(KERN_ERR "EEH: MMIO failure (%d), recovery not supported "
 				"%s %s\n", event->reset_state,
-				pci_name(event->dev), pci_pretty_name(event->dev));
-			eeh_panic(event->dev, event->reset_state);
+				event->dn->name, event->dn->full_name);
+			eeh_panic(event->dn, event->reset_state);
 		}
 
-		pci_dev_put(event->dev);
+		if (event->dev) 
+			pci_dev_put(event->dev);
 		kfree(event);
 	}
 }
@@ -474,7 +475,7 @@
  * ths routine does *not* convert I/O BAR addresses (which start
  * with 0xE...) to phys addresses!
  */
-static unsigned long eeh_token_to_phys(unsigned long token)
+static inline unsigned long eeh_token_to_phys(unsigned long token)
 {
 	pte_t *ptep;
 	unsigned long pa, vaddr;
@@ -491,54 +492,41 @@
 }
 
 /**
- * eeh_check_failure - check if all 1's data is due to EEH slot freeze
- * @token i/o token, should be address in the form 0xA....
- * @val value, should be all 1's (XXX why do we need this arg??)
+ * eeh_dn_check_failure - check if all 1's data is due to EEH slot freeze
+ * @dn device node
+ * @dev pci device, if known
  *
- * Check for an eeh failure at the given token address.
- * The given value has been read and it should be 1's (0xff, 0xffff or
- * 0xffffffff).
+ * Check for an EEH failure for the given device node.  Call this
+ * routine if the result of a read was all 0xff's and you want to 
+ * find out if this is due to an EEH slot freeze event.  This routine
+ * will query firmware for the EEH status. 
  *
- * Probe to determine if an error actually occurred.  If not return val.
- * Otherwise panic.
+ * Returns 0 if there has not been an EEH error; otherwise returns
+ * an error code.
  *
  * Note this routine is safe to call in an interrupt context.
  */
-unsigned long eeh_check_failure(void *token, unsigned long val)
+int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 {
-	unsigned long addr;
-	struct pci_dev *dev;
-	struct device_node *dn;
 	int ret;
 	int rets[2];
 
 	__get_cpu_var(total_mmio_ffs)++;
 
 	if (!eeh_subsystem_enabled)
-		return val;
+		return 0;
 
-	/* Finding the phys addr + pci device; this is pretty quick. */
-	addr = eeh_token_to_phys((unsigned long)token);
-	dev = pci_get_device_by_addr(addr);
-	if (!dev)
-		return val;
-
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
@@ -566,13 +554,13 @@
 		                      BUID_LO(dn->phb->buid), NULL, 0,
 		                      virt_to_phys(slot_errbuf),
 		                      eeh_error_buf_size,
-		                      2 /* Permanent Error */);
+		                      1 /* Temporary Error */);
 
 		if (rc == 0)
 			log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
 		spin_unlock_irqrestore(&slot_errbuf_lock, flags);
 
-		/* prevent repeated reports of this failure */
+		/* Prevent repeated reports of this failure */
 		dn->eeh_mode |= EEH_MODE_NOCHECK;
 		
 		/* Some errors are recoverable; we handle those
@@ -582,11 +570,12 @@
 
 			event = kmalloc(sizeof(*event), GFP_ATOMIC);
 			if (event == NULL) {
-				eeh_panic(dev, reset_state);
-				pci_dev_put(dev);
-				return val;
+				eeh_panic(dn, reset_state);
+				return -EIO;
 			}
 	
+			if (dev) 
+				pci_dev_get (dev);
 			event->dev = dev;
 			event->dn = dn;
 			event->reset_state = reset_state;
@@ -607,14 +596,45 @@
 			/* For non-recoverable errors, we panic now.  This
 			 * prevents the device driver from getting tangled 
 			 * in its own shorts.  */
-			eeh_panic(dev, reset_state);
-			pci_dev_put(dev);
-			return val;
+			eeh_panic(dn, reset_state);
 		}
+		return -EIO;
 	} else {
 		__get_cpu_var(false_positives)++;
 	}
 
+	return 0;
+}
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
===== arch/ppc64/kernel/pSeries_pci.c 1.38 vs edited =====
--- 1.38/arch/ppc64/kernel/pSeries_pci.c	Thu Jul  8 10:44:42 2004
+++ edited/arch/ppc64/kernel/pSeries_pci.c	Thu Jul  8 17:38:16 2004
@@ -68,7 +68,11 @@
 	int ret;
 
 	if (!dn)
-		return -2;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	if ((size == 2) && (where & 0x1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	if ((size == 4) && (where & 0x3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	addr = (dn->busno << 16) | (dn->devfn << 8) | where;
 	buid = dn->phb->buid;
@@ -79,7 +83,18 @@
 		ret = rtas_call(read_pci_config, 2, 2, &returnval, addr, size);
 	}
 	*val = returnval;
-	return ret;
+
+	if (ret) 
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if ((EEH_POSSIBLE_IO_ERROR(returnval, u8) && (size==1)) ||
+	    (EEH_POSSIBLE_IO_ERROR(returnval, u16) && (size==2)) ||
+	    (EEH_POSSIBLE_IO_ERROR(returnval, u32) && (size==4))) {
+		
+		if (eeh_dn_check_failure (dn, NULL))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+	return PCIBIOS_SUCCESSFUL;
 }
 
 static int rtas_pci_read_config(struct pci_bus *bus,
@@ -106,7 +121,11 @@
 	int ret;
 
 	if (!dn)
-		return -2;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	if ((size == 2) && (where & 0x1)) 
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	if ((size == 4) && (where & 0x3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	addr = (dn->busno << 16) | (dn->devfn << 8) | where;
 	buid = dn->phb->buid;
@@ -115,7 +134,11 @@
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
===== include/asm-ppc64/eeh.h 1.13 vs edited =====
--- 1.13/include/asm-ppc64/eeh.h	Thu Jul  8 10:22:23 2004
+++ edited/include/asm-ppc64/eeh.h	Thu Jul  8 17:17:27 2004
@@ -45,6 +45,7 @@
 
 extern void __init eeh_init(void);
 unsigned long eeh_check_failure(void *token, unsigned long val);
+int eeh_dn_check_failure (struct device_node *dn, struct pci_dev *dev);
 void *eeh_ioremap(unsigned long addr, void *vaddr);
 void __init pci_addr_cache_build(void);
 

--pWyiEgJYm5f9v55/--

----- End forwarded message -----
