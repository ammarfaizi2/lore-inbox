Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753164AbWKGVcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbWKGVcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbWKGVcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:32:15 -0500
Received: from mx.pathscale.com ([64.160.42.68]:16079 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1753164AbWKGVcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:32:14 -0500
Message-ID: <4550FB5D.5010804@serpentine.com>
Date: Tue, 07 Nov 2006 13:32:13 -0800
From: "Bryan O'Sullivan" <bos@serpentine.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       olson@pathscale.com, akpm@osdl.org
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>	<20061105064801.GV13381@stusta.de>	<m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>	<20061107042214.GC8099@stusta.de> <45501730.8020802@serpentine.com>	<m1psbzbpxw.fsf@ebiederm.dsl.xmission.com>	<4550B22C.1060307@serpentine.com> <m18xinb1qn.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m18xinb1qn.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/mixed;
 boundary="------------030902000004060509010107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030902000004060509010107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Eric W. Biederman wrote:

> If you really need to write to both the config space registers and your
> magic shadow copy of the register I can certainly do the config space
> writes for you.

Here's an updated copy of your second patch that does just that.

I've also included a preview of the ipath patch that depends on this. 
With your original patch, my rework of your second patch, and the new 
ipath patch, the driver is back to working happily for me on top of 
current -git.

I need to test the ipath patch on powerpc before I consider it cooked, 
but I won't have time to do that today.

	<b

--------------030902000004060509010107
Content-Type: text/x-patch;
 name*0="htirq-allow-buggy-drivers-of-buggy-hardware-to-write-the-registe";
 name*1="rs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="htirq-allow-buggy-drivers-of-buggy-hardware-to-write-the-reg";
 filename*1="isters.patch"

From: ebiederm@xmission.com (Eric W. Biederman)

This patch adds a variant of ht_create_irq, __ht_create_irq, that takes
an additional parameter, update, that is a function that is called after
we have updated a driver's htirq configuration registers.

This is needed to support the ipath_iba6110, which has an interrupt
config register that is not connected to the hardware that controls
interrupt delivery.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>
Cc: Dave Olson <dave.olson@qlogic.com>

diff -r 5f5c47730ce4 drivers/pci/htirq.c
--- a/drivers/pci/htirq.c	Tue Nov 07 07:45:59 2006 -0800
+++ b/drivers/pci/htirq.c	Tue Nov 07 11:33:27 2006 -0800
@@ -25,6 +25,8 @@ static DEFINE_SPINLOCK(ht_irq_lock);
 
 struct ht_irq_cfg {
 	struct pci_dev *dev;
+	 /* Update callback used to cope with buggy hardware */
+	ht_irq_update_t *update;
 	unsigned pos;
 	unsigned idx;
 	struct ht_irq_msg msg;
@@ -44,6 +46,8 @@ void write_ht_irq_msg(unsigned int irq, 
 		pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx + 1);
 		pci_write_config_dword(cfg->dev, cfg->pos + 4, msg->address_hi);
 	}
+	if (cfg->update)
+		cfg->update(cfg->dev, irq, msg);
 	spin_unlock_irqrestore(&ht_irq_lock, flags);
 	cfg->msg = *msg;
 }
@@ -79,16 +83,14 @@ void unmask_ht_irq(unsigned int irq)
 }
 
 /**
- * ht_create_irq - create an irq and attach it to a device.
+ * __ht_create_irq - create an irq and attach it to a device.
  * @dev: The hypertransport device to find the irq capability on.
  * @idx: Which of the possible irqs to attach to.
- *
- * ht_create_irq is needs to be called for all hypertransport devices
- * that generate irqs.
+ * @update: Function to be called when changing the htirq message
  *
  * The irq number of the new irq or a negative error value is returned.
  */
-int ht_create_irq(struct pci_dev *dev, int idx)
+int __ht_create_irq(struct pci_dev *dev, int idx, ht_irq_update_t *update)
 {
 	struct ht_irq_cfg *cfg;
 	unsigned long flags;
@@ -123,6 +125,7 @@ int ht_create_irq(struct pci_dev *dev, i
 		return -ENOMEM;
 
 	cfg->dev = dev;
+	cfg->update = update;
 	cfg->pos = pos;
 	cfg->idx = 0x10 + (idx * 2);
 	/* Initialize msg to a value that will never match the first write. */
@@ -145,6 +148,21 @@ int ht_create_irq(struct pci_dev *dev, i
 }
 
 /**
+ * ht_create_irq - create an irq and attach it to a device.
+ * @dev: The hypertransport device to find the irq capability on.
+ * @idx: Which of the possible irqs to attach to.
+ *
+ * ht_create_irq needs to be called for all hypertransport devices
+ * that generate irqs.
+ *
+ * The irq number of the new irq or a negative error value is returned.
+ */
+int ht_create_irq(struct pci_dev *dev, int idx)
+{
+	return __ht_create_irq(dev, idx, NULL);
+}
+
+/**
  * ht_destroy_irq - destroy an irq created with ht_create_irq
  *
  * This reverses ht_create_irq removing the specified irq from
@@ -162,5 +180,6 @@ void ht_destroy_irq(unsigned int irq)
 	kfree(cfg);
 }
 
+EXPORT_SYMBOL(__ht_create_irq);
 EXPORT_SYMBOL(ht_create_irq);
 EXPORT_SYMBOL(ht_destroy_irq);
diff -r 5f5c47730ce4 include/linux/htirq.h
--- a/include/linux/htirq.h	Tue Nov 07 07:45:59 2006 -0800
+++ b/include/linux/htirq.h	Tue Nov 07 11:33:34 2006 -0800
@@ -15,4 +15,9 @@ void unmask_ht_irq(unsigned int irq);
 /* The arch hook for getting things started */
 int arch_setup_ht_irq(unsigned int irq, struct pci_dev *dev);
 
+/* For drivers of buggy hardware */
+typedef void (ht_irq_update_t)(struct pci_dev *dev, int irq,
+			       struct ht_irq_msg *msg);
+int __ht_create_irq(struct pci_dev *dev, int idx, ht_irq_update_t *update);
+
 #endif /* LINUX_HTIRQ_H */

--------------030902000004060509010107
Content-Type: text/x-patch;
 name="ipath-htirq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipath-htirq.patch"

IB/ipath - program interrupt control register using new htirq hook

Eric's changes to the htirq infrastructure require corresponding
modifications to the ipath HT driver code so that interrupts are still
delivered properly.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>
Cc: Eric W. Biedermann <ebiederm@xmission.com>

diff -r bb12c8d85f7c drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Tue Nov 07 11:35:24 2006 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Tue Nov 07 11:44:23 2006 -0800
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
@@ -615,12 +615,15 @@ static void __devexit ipath_remove_one(s
 static void __devexit ipath_remove_one(struct pci_dev *pdev)
 {
 	struct ipath_devdata *dd = pci_get_drvdata(pdev);
+	int irq;
 
 	ipath_cdbg(VERBOSE, "removing, pdev=%p, dd=%p\n", pdev, dd);
 
 	if (dd->verbs_dev)
 		ipath_unregister_ib_device(dd->verbs_dev);
 
+	irq = dd->ipath_irq;
+	
 	ipath_diag_remove(dd);
 	ipath_user_remove(dd);
 	ipathfs_remove_device(dd);
@@ -637,11 +640,11 @@ static void __devexit ipath_remove_one(s
 	 * free up port 0 (kernel) rcvhdr, egr bufs, and eventually tid bufs
 	 * for all versions of the driver, if they were allocated
 	 */
-	if (pdev->irq) {
+	if (irq) {
 		ipath_cdbg(VERBOSE,
-			   "unit %u free_irq of irq %x\n",
-			   dd->ipath_unit, pdev->irq);
-		free_irq(pdev->irq, dd);
+			   "unit %u free_irq of irq %d\n",
+			   dd->ipath_unit, irq);
+		free_irq(irq, dd);
 	} else
 		ipath_dbg("irq is 0, not doing free_irq "
 			  "for unit %u\n", dd->ipath_unit);
diff -r bb12c8d85f7c drivers/infiniband/hw/ipath/ipath_iba6110.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6110.c	Tue Nov 07 11:35:24 2006 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_iba6110.c	Tue Nov 07 11:44:23 2006 -0800
@@ -38,6 +38,7 @@
 
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/htirq.h>
 
 #include "ipath_kernel.h"
 #include "ipath_registers.h"
@@ -913,49 +914,13 @@ static void slave_or_pri_blk(struct ipat
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
+static void ipath_ht_irq_update(struct pci_dev *dev, int irq,
+				struct ht_irq_msg *msg)
+{
+	struct ipath_devdata *dd = pci_get_drvdata(dev);
+
+	dd->ipath_intconfig = msg->address_lo;
+	dd->ipath_intconfig |= ((u64) msg->address_hi) << 32;
 }
 
 /**
@@ -971,12 +936,19 @@ static int ipath_setup_ht_config(struct 
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
@@ -1000,16 +972,8 @@ static int ipath_setup_ht_config(struct 
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
diff -r bb12c8d85f7c drivers/infiniband/hw/ipath/ipath_iba6120.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6120.c	Tue Nov 07 11:35:24 2006 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c	Tue Nov 07 11:45:00 2006 -0800
@@ -851,6 +851,7 @@ static int ipath_setup_pe_config(struct 
 	int pos, ret;
 
 	dd->ipath_msi_lo = 0;	/* used as a flag during reset processing */
+	dd->ipath_irq = pdev->irq;
 	ret = pci_enable_msi(dd->pcidev);
 	if (ret)
 		ipath_dev_err(dd, "pci_enable_msi failed: %d, "
diff -r bb12c8d85f7c drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Tue Nov 07 11:35:24 2006 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Tue Nov 07 11:44:23 2006 -0800
@@ -328,6 +328,7 @@ struct ipath_devdata {
 	/* so we can rewrite it after a chip reset */
 	u32 ipath_pcibar1;
 
+	int ipath_irq;
 	/* HT/PCI Vendor ID (here for NodeInfo) */
 	u16 ipath_vendorid;
 	/* HT/PCI Device ID (here for NodeInfo) */

--------------030902000004060509010107--
