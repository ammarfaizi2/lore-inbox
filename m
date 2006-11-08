Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161746AbWKHWVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161746AbWKHWVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161745AbWKHWVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:21:20 -0500
Received: from mx.pathscale.com ([64.160.42.68]:32469 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161742AbWKHWVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:21:17 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH] IB/ipath - program intconfig register using new HT irq hook
X-Mercurial-Node: 545156d49f883c43af7067bb9bb963d5636026b4
Message-Id: <545156d49f883c43af70.1163024486@localhost.localdomain>
Date: Wed, 08 Nov 2006 14:21:26 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: rdreier@cisco.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric's changes to the htirq infrastructure require corresponding
modifications to the ipath HT driver code so that interrupts are still
delivered properly.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Roland Dreier <rdreier@cisco.com>

diff -r 69779e2890e3 -r 545156d49f88 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Nov 08 14:17:04 2006 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Nov 08 14:19:27 2006 -0800
@@ -304,7 +304,7 @@ static int __devinit ipath_init_one(stru
 	}
 	addr = pci_resource_start(pdev, 0);
 	len = pci_resource_len(pdev, 0);
-	ipath_cdbg(VERBOSE, "regbase (0) %llx len %d irq %x, vend %x/%x "
+	ipath_cdbg(VERBOSE, "regbase (0) %llx len %d pdev->irq %d, vend %x/%x "
 		   "driver_data %lx\n", addr, len, pdev->irq, ent->vendor,
 		   ent->device, ent->driver_data);
 
@@ -467,15 +467,15 @@ static int __devinit ipath_init_one(stru
 	 * check 0 irq after we return from chip-specific bus setup, since
 	 * that can affect this due to setup
 	 */
-	if (!pdev->irq)
+	if (!dd->ipath_irq)
 		ipath_dev_err(dd, "irq is 0, BIOS error?  Interrupts won't "
 			      "work\n");
 	else {
-		ret = request_irq(pdev->irq, ipath_intr, IRQF_SHARED,
+		ret = request_irq(dd->ipath_irq, ipath_intr, IRQF_SHARED,
 				  IPATH_DRV_NAME, dd);
 		if (ret) {
 			ipath_dev_err(dd, "Couldn't setup irq handler, "
-				      "irq=%u: %d\n", pdev->irq, ret);
+				      "irq=%d: %d\n", dd->ipath_irq, ret);
 			goto bail_iounmap;
 		}
 	}
@@ -637,11 +637,10 @@ static void __devexit ipath_remove_one(s
 	 * free up port 0 (kernel) rcvhdr, egr bufs, and eventually tid bufs
 	 * for all versions of the driver, if they were allocated
 	 */
-	if (pdev->irq) {
-		ipath_cdbg(VERBOSE,
-			   "unit %u free_irq of irq %x\n",
-			   dd->ipath_unit, pdev->irq);
-		free_irq(pdev->irq, dd);
+	if (dd->ipath_irq) {
+		ipath_cdbg(VERBOSE, "unit %u free irq %d\n",
+			   dd->ipath_unit, dd->ipath_irq);
+		dd->ipath_f_free_irq(dd);
 	} else
 		ipath_dbg("irq is 0, not doing free_irq "
 			  "for unit %u\n", dd->ipath_unit);
diff -r 69779e2890e3 -r 545156d49f88 drivers/infiniband/hw/ipath/ipath_iba6110.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6110.c	Wed Nov 08 14:17:04 2006 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_iba6110.c	Wed Nov 08 14:19:27 2006 -0800
@@ -38,6 +38,7 @@
 
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/htirq.h>
 
 #include "ipath_kernel.h"
 #include "ipath_registers.h"
@@ -913,49 +914,40 @@ static void slave_or_pri_blk(struct ipat
 	}
 }
 
-static int set_int_handler(struct ipath_devdata *dd, struct pci_dev *pdev,
-			    int pos)
-{
-	u32 int_handler_addr_lower;
-	u32 int_handler_addr_upper;
-	u64 ihandler;
-	u32 intvec;
-
-	/* use indirection register to get the intr handler */
-	pci_write_config_byte(pdev, pos + HT_INTR_REG_INDEX, 0x10);
-	pci_read_config_dword(pdev, pos + 4, &int_handler_addr_lower);
-	pci_write_config_byte(pdev, pos + HT_INTR_REG_INDEX, 0x11);
-	pci_read_config_dword(pdev, pos + 4, &int_handler_addr_upper);
-
-	ihandler = (u64) int_handler_addr_lower |
-		((u64) int_handler_addr_upper << 32);
-
-	/*
-	 * kernels with CONFIG_PCI_MSI set the vector in the irq field of
-	 * struct pci_device, so we use that to program the internal
-	 * interrupt register (not config space) with that value. The BIOS
-	 * must still have done the basic MSI setup.
-	 */
-	intvec = pdev->irq;
-	/*
-	 * clear any vector bits there; normally not set but we'll overload
-	 * this for some debug purposes (setting the HTC debug register
-	 * value from software, rather than GPIOs), so it might be set on a
-	 * driver reload.
-	 */
-	ihandler &= ~0xff0000;
-	/* x86 vector goes in intrinfo[23:16] */
-	ihandler |= intvec << 16;
-	ipath_cdbg(VERBOSE, "ihandler lower %x, upper %x, intvec %x, "
-		   "interruptconfig %llx\n", int_handler_addr_lower,
-		   int_handler_addr_upper, intvec,
-		   (unsigned long long) ihandler);
-
-	/* can't program yet, so save for interrupt setup */
-	dd->ipath_intconfig = ihandler;
-	/* keep going, so we find link control stuff also */
-
-	return ihandler != 0;
+static int ipath_ht_intconfig(struct ipath_devdata *dd)
+{
+	int ret;
+
+	if (dd->ipath_intconfig) {
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_interruptconfig,
+				 dd->ipath_intconfig);	/* interrupt address */
+		ret = 0;
+	} else {
+		ipath_dev_err(dd, "No interrupts enabled, couldn't setup "
+			      "interrupt address\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static void ipath_ht_irq_update(struct pci_dev *dev, int irq,
+				struct ht_irq_msg *msg)
+{
+	struct ipath_devdata *dd = pci_get_drvdata(dev);
+	u64 prev_intconfig = dd->ipath_intconfig;
+
+	dd->ipath_intconfig = msg->address_lo;
+	dd->ipath_intconfig |= ((u64) msg->address_hi) << 32;
+
+	/*
+	 * If the previous value of dd->ipath_intconfig is zero, we're
+	 * getting configured for the first time, and must not program the
+	 * intconfig register here (it will be programmed later, when the
+	 * hardware is ready).  Otherwise, we should.
+	 */
+	if (prev_intconfig)
+		ipath_ht_intconfig(dd);
 }
 
 /**
@@ -971,12 +963,19 @@ static int ipath_setup_ht_config(struct 
 static int ipath_setup_ht_config(struct ipath_devdata *dd,
 				 struct pci_dev *pdev)
 {
-	int pos, ret = 0;
-	int ihandler = 0;
-
-	/*
-	 * Read the capability info to find the interrupt info, and also
-	 * handle clearing CRC errors in linkctrl register if necessary.  We
+	int pos, ret;
+
+	ret = __ht_create_irq(pdev, 0, ipath_ht_irq_update);
+	if (ret < 0) {
+		ipath_dev_err(dd, "Couldn't create interrupt handler: "
+			      "err %d\n", ret);
+		goto bail;
+	}
+	dd->ipath_irq = ret;
+	ret = 0;
+
+	/*
+	 * Handle clearing CRC errors in linkctrl register if necessary.  We
 	 * do this early, before we ever enable errors or hardware errors,
 	 * mostly to avoid causing the chip to enter freeze mode.
 	 */
@@ -1000,16 +999,8 @@ static int ipath_setup_ht_config(struct 
 		}
 		if (!(cap_type & 0xE0))
 			slave_or_pri_blk(dd, pdev, pos, cap_type);
-		else if (cap_type == HT_INTR_DISC_CONFIG)
-			ihandler = set_int_handler(dd, pdev, pos);
 	} while ((pos = pci_find_next_capability(pdev, pos,
 						 PCI_CAP_ID_HT)));
-
-	if (!ihandler) {
-		ipath_dev_err(dd, "Couldn't find interrupt handler in "
-			      "config space\n");
-		ret = -ENODEV;
-	}
 
 bail:
 	return ret;
@@ -1360,25 +1351,6 @@ static void ipath_ht_quiet_serdes(struct
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_serdesconfig0, val);
 }
 
-static int ipath_ht_intconfig(struct ipath_devdata *dd)
-{
-	int ret;
-
-	if (!dd->ipath_intconfig) {
-		ipath_dev_err(dd, "No interrupts enabled, couldn't setup "
-			      "interrupt address\n");
-		ret = 1;
-		goto bail;
-	}
-
-	ipath_write_kreg(dd, dd->ipath_kregs->kr_interruptconfig,
-			 dd->ipath_intconfig);	/* interrupt address */
-	ret = 0;
-
-bail:
-	return ret;
-}
-
 /**
  * ipath_pe_put_tid - write a TID in chip
  * @dd: the infinipath device
@@ -1575,6 +1547,14 @@ static int ipath_ht_get_base_info(struct
 	return 0;
 }
 
+static void ipath_ht_free_irq(struct ipath_devdata *dd)
+{
+	free_irq(dd->ipath_irq, dd);
+	ht_destroy_irq(dd->ipath_irq);
+	dd->ipath_irq = 0;
+	dd->ipath_intconfig = 0;
+}
+
 /**
  * ipath_init_iba6110_funcs - set up the chip-specific function pointers
  * @dd: the infinipath device
@@ -1598,6 +1578,7 @@ void ipath_init_iba6110_funcs(struct ipa
 	dd->ipath_f_cleanup = ipath_setup_ht_cleanup;
 	dd->ipath_f_setextled = ipath_setup_ht_setextled;
 	dd->ipath_f_get_base_info = ipath_ht_get_base_info;
+	dd->ipath_f_free_irq = ipath_ht_free_irq;
 
 	/*
 	 * initialize chip-specific variables
diff -r 69779e2890e3 -r 545156d49f88 drivers/infiniband/hw/ipath/ipath_iba6120.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6120.c	Wed Nov 08 14:17:04 2006 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c	Wed Nov 08 14:19:27 2006 -0800
@@ -851,6 +851,7 @@ static int ipath_setup_pe_config(struct 
 	int pos, ret;
 
 	dd->ipath_msi_lo = 0;	/* used as a flag during reset processing */
+	dd->ipath_irq = pdev->irq;
 	ret = pci_enable_msi(dd->pcidev);
 	if (ret)
 		ipath_dev_err(dd, "pci_enable_msi failed: %d, "
@@ -1323,6 +1324,12 @@ done:
 	return 0;
 }
 
+static void ipath_pe_free_irq(struct ipath_devdata *dd)
+{
+	free_irq(dd->ipath_irq, dd);
+	dd->ipath_irq = 0;
+}
+
 /**
  * ipath_init_iba6120_funcs - set up the chip-specific function pointers
  * @dd: the infinipath device
@@ -1349,6 +1356,7 @@ void ipath_init_iba6120_funcs(struct ipa
 	dd->ipath_f_cleanup = ipath_setup_pe_cleanup;
 	dd->ipath_f_setextled = ipath_setup_pe_setextled;
 	dd->ipath_f_get_base_info = ipath_pe_get_base_info;
+	dd->ipath_f_free_irq = ipath_pe_free_irq;
 
 	/* initialize chip-specific variables */
 	dd->ipath_f_tidtemplate = ipath_pe_tidtemplate;
diff -r 69779e2890e3 -r 545156d49f88 drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Wed Nov 08 14:17:04 2006 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Wed Nov 08 14:19:27 2006 -0800
@@ -710,14 +710,14 @@ static void ipath_bad_intr(struct ipath_
 			 * linuxbios development work, and it may happen in
 			 * the future again.
 			 */
-			if (dd->pcidev && dd->pcidev->irq) {
+			if (dd->pcidev && dd->ipath_irq) {
 				ipath_dev_err(dd, "Now %u unexpected "
 					      "interrupts, unregistering "
 					      "interrupt handler\n",
 					      *unexpectp);
-				ipath_dbg("free_irq of irq %x\n",
-					  dd->pcidev->irq);
-				free_irq(dd->pcidev->irq, dd);
+				ipath_dbg("free_irq of irq %d\n",
+					  dd->ipath_irq);
+				dd->ipath_f_free_irq(dd);
 			}
 		}
 		if (ipath_read_kreg32(dd, dd->ipath_kregs->kr_intmask)) {
@@ -753,7 +753,7 @@ static void ipath_bad_regread(struct ipa
 		if (allbits == 2) {
 			ipath_dev_err(dd, "Still bad interrupt status, "
 				      "unregistering interrupt\n");
-			free_irq(dd->pcidev->irq, dd);
+			dd->ipath_f_free_irq(dd);
 		} else if (allbits > 2) {
 			if ((allbits % 10000) == 0)
 				printk(".");
diff -r 69779e2890e3 -r 545156d49f88 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Wed Nov 08 14:17:04 2006 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Wed Nov 08 14:19:27 2006 -0800
@@ -213,6 +213,8 @@ struct ipath_devdata {
 	void (*ipath_f_setextled)(struct ipath_devdata *, u64, u64);
 	/* fill out chip-specific fields */
 	int (*ipath_f_get_base_info)(struct ipath_portdata *, void *);
+	/* free irq */
+	void (*ipath_f_free_irq)(struct ipath_devdata *);
 	struct ipath_ibdev *verbs_dev;
 	struct timer_list verbs_timer;
 	/* total dwords sent (summed from counter) */
@@ -328,6 +330,8 @@ struct ipath_devdata {
 	/* so we can rewrite it after a chip reset */
 	u32 ipath_pcibar1;
 
+	/* interrupt number */
+	int ipath_irq;
 	/* HT/PCI Vendor ID (here for NodeInfo) */
 	u16 ipath_vendorid;
 	/* HT/PCI Device ID (here for NodeInfo) */
