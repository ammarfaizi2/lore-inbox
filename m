Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWDCQm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWDCQm6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWDCQm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:42:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:17377 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751398AbWDCQly
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:41:54 -0400
Subject: [PATCH 4/7] tpm: return chip from tpm_register_hardware
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       Marcel Selhorst <selhorst@crypto.rub.de>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 11:42:34 -0500
Message-Id: <1144082554.29910.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in the 1.2 TPM Specification make it necessary to update some
fields of the chip structure in the initialization function after it is
registered with tpm.c thus tpm_register_hardware was modified to return
a pointer to the structure.  This patch makes that change and the
associated changes in tpm_atmel and tpm_nsc.  The changes to
tpm_infineon will be coming in a patch from Marcel Selhorst.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
drivers/char/tpm/tpm.c       |   11 ++++++-----
drivers/char/tpm/tpm.h       |   10 +++++-----
drivers/char/tpm/tpm_atmel.c |   32 ++++++++++++++++++++++----------
drivers/char/tpm/tpm_atmel.h |   25 +++++++++++--------------
drivers/char/tpm/tpm_nsc.c   |   17 +++++++++++------
5 files changed, 55 insertions(+), 40 deletions(-)

--- linux-2.6.16/drivers/char/tpm/tpm.c	2006-03-30 15:39:35.320462000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm.c	2006-03-30 16:28:14.690911250 -0600
@@ -558,7 +1095,8 @@ EXPORT_SYMBOL_GPL(tpm_pm_resume);
  * upon errant exit from this function specific probe function should call
  * pci_disable_device
  */
-int tpm_register_hardware(struct device *dev, struct tpm_vendor_specific *entry)
+struct tpm_chip *tpm_register_hardware(struct device *dev, const struct tpm_vendor_specific
+				       *entry)
 {
 #define DEVNAME_SIZE 7
 
@@ -569,7 +1107,7 @@ int tpm_register_hardware(struct device 
 	/* Driver specific per-device data */
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
-		return -ENOMEM;
+		return NULL;
 
 	init_MUTEX(&chip->buffer_mutex);
 	init_MUTEX(&chip->tpm_mutex);
@@ -598,7 +1136,7 @@ dev_num_search_complete:
 	if (chip->dev_num < 0) {
 		dev_err(dev, "No available tpm device numbers\n");
 		kfree(chip);
-		return -ENODEV;
+		return NULL;
 	} else if (chip->dev_num == 0)
 		chip->vendor.miscdev.minor = TPM_MINOR;
 	else
@@ -619,7 +1157,7 @@ dev_num_search_complete:
 		put_device(dev);
 		kfree(chip);
 		dev_mask[i] &= !(1 << j);
-		return -ENODEV;
+		return NULL;
 	}
 
 	spin_lock(&driver_lock);
@@ -634,7 +1172,7 @@ dev_num_search_complete:
 
 	chip->bios_dir = tpm_bios_log_setup(devname);
 
-	return 0;
+	return chip;
 }
 EXPORT_SYMBOL_GPL(tpm_register_hardware);
 
--- linux-2.6.16/drivers/char/tpm/tpm.h	2006-03-30 15:39:35.320462000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm.h	2006-03-29 14:16:30.119053500 -0600
@@ -41,9 +41,9 @@ extern ssize_t tpm_show_pcrs(struct devi
 struct tpm_chip;
 
 struct tpm_vendor_specific {
-	u8 req_complete_mask;
-	u8 req_complete_val;
-	u8 req_canceled;
+	const u8 req_complete_mask;
+	const u8 req_complete_val;
+	const u8 req_canceled;
 	void __iomem *iobase;		/* ioremapped address */
 	unsigned long base;		/* TPM base address */
 
@@ -99,8 +114,8 @@ static inline void tpm_write_index(int b
 	outb(value & 0xFF, base+1);
 }
 
-extern int tpm_register_hardware(struct device *,
-				 struct tpm_vendor_specific *);
+extern struct tpm_chip* tpm_register_hardware(struct device *,
+				 const struct tpm_vendor_specific *);
 extern int tpm_open(struct inode *, struct file *);
 extern int tpm_release(struct inode *, struct file *);
 extern ssize_t tpm_write(struct file *, const char __user *, size_t,
--- linux-2.6.16/drivers/char/tpm/tpm_atmel.c	2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm_atmel.c	2006-03-02 15:04:40.663271500 -0600
@@ -140,7 +140,7 @@ static struct attribute* atmel_attrs[] =
 
 static struct attribute_group atmel_attr_grp = { .attrs = atmel_attrs };
 
-static struct tpm_vendor_specific tpm_atmel = {
+static const struct tpm_vendor_specific tpm_atmel = {
 	.recv = tpm_atml_recv,
 	.send = tpm_atml_send,
 	.cancel = tpm_atml_cancel,
@@ -179,18 +179,22 @@ static struct device_driver atml_drv = {
 static int __init init_atmel(void)
 {
 	int rc = 0;
+	void __iomem *iobase = NULL;
+	int have_region, region_size;
+	unsigned long base;
+	struct  tpm_chip *chip;
 
 	driver_register(&atml_drv);
 
-	if ((tpm_atmel.iobase = atmel_get_base_addr(&tpm_atmel)) == NULL) {
+	if ((iobase = atmel_get_base_addr(&base, &region_size)) == NULL) {
 		rc = -ENODEV;
 		goto err_unreg_drv;
 	}
 
-	tpm_atmel.have_region =
+	have_region =
 	    (atmel_request_region
-	     (tpm_atmel.base, tpm_atmel.region_size,
-	      "tpm_atmel0") == NULL) ? 0 : 1;
+	     (tpm_atmel.base, region_size, "tpm_atmel0") == NULL) ? 0 : 1;
+	     
 
 	if (IS_ERR
 	    (pdev =
@@ -199,17 +203,25 @@ static int __init init_atmel(void)
 		goto err_rel_reg;
 	}
 
-	if ((rc = tpm_register_hardware(&pdev->dev, &tpm_atmel)) < 0)
+	if (!(chip = tpm_register_hardware(&pdev->dev, &tpm_atmel))) {
+		rc = -ENODEV;
 		goto err_unreg_dev;
+	}
+
+	chip->vendor.iobase = iobase;
+	chip->vendor.base = base;
+	chip->vendor.have_region = have_region;
+	chip->vendor.region_size = region_size;
+
 	return 0;
 
 err_unreg_dev:
 	platform_device_unregister(pdev);
 err_rel_reg:
-	atmel_put_base_addr(&tpm_atmel);
-	if (tpm_atmel.have_region)
-		atmel_release_region(tpm_atmel.base,
-				     tpm_atmel.region_size);
+	atmel_put_base_addr(iobase);
+	if (have_region)
+		atmel_release_region(base,
+				     region_size);
 err_unreg_drv:
 	driver_unregister(&atml_drv);
 	return rc;
--- linux-2.6.16/drivers/char/tpm/tpm_atmel.h	2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm_atmel.h	2006-03-02 14:50:27.725966250 -0600
@@ -28,13 +28,12 @@
 #define atmel_request_region request_mem_region
 #define atmel_release_region release_mem_region
 
-static inline void atmel_put_base_addr(struct tpm_vendor_specific
-					 *vendor)
+static inline void atmel_put_base_addr(void __iomem *iobase)
 {
-	iounmap(vendor->iobase);
+	iounmap(iobase);
 }
 
-static void __iomem * atmel_get_base_addr(struct tpm_vendor_specific *vendor)
+static void __iomem * atmel_get_base_addr(unsigned long *base, int *region_size)
 {
 	struct device_node *dn;
 	unsigned long address, size;
@@ -71,9 +70,9 @@ static void __iomem * atmel_get_base_add
 	else
 		size = reg[naddrc];
 
-	vendor->base = address;
-	vendor->region_size = size;
-	return ioremap(vendor->base, vendor->region_size);
+	*base = address;
+	*region_size = size;
+	return ioremap(*base, *region_size);
 }
 #else
 #define atmel_getb(chip, offset) inb(chip->vendor->base + offset)
@@ -106,14 +105,12 @@ static int atmel_verify_tpm11(void)
 	return 0;
 }
 
-static inline void atmel_put_base_addr(struct tpm_vendor_specific
-					 *vendor)
+static inline void atmel_put_base_addr(void __iomem *iobase)
 {
 }
 
 /* Determine where to talk to device */
-static void __iomem * atmel_get_base_addr(struct tpm_vendor_specific
-					 *vendor)
+static void __iomem * atmel_get_base_addr(unsigned long *base, int *region_size)
 {
 	int lo, hi;
 
@@ -123,9 +120,9 @@ static void __iomem * atmel_get_base_add
 	lo = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
 	hi = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
 
-	vendor->base = (hi << 8) | lo;
-	vendor->region_size = 2;
+	*base = (hi << 8) | lo;
+	*region_size = 2;
 
-	return ioport_map(vendor->base, vendor->region_size);
+	return ioport_map(*base, *region_size);
 }
 #endif
--- linux-2.6.16/drivers/char/tpm/tpm_nsc.c	2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm_nsc.c	2006-03-02 15:06:07.188679000 -0600
@@ -250,7 +250,7 @@ static struct attribute * nsc_attrs[] = 
 
 static struct attribute_group nsc_attr_grp = { .attrs = nsc_attrs };
 
-static struct tpm_vendor_specific tpm_nsc = {
+static const struct tpm_vendor_specific tpm_nsc = {
 	.recv = tpm_nsc_recv,
 	.send = tpm_nsc_send,
 	.cancel = tpm_nsc_cancel,
@@ -286,7 +286,8 @@ static int __init init_nsc(void)
 	int rc = 0;
 	int lo, hi;
 	int nscAddrBase = TPM_ADDR;
-
+	struct tpm_chip *chip;
+	unsigned long base;
 
 	/* verify that it is a National part (SID) */
 	if (tpm_read_index(TPM_ADDR, NSC_SID_INDEX) != 0xEF) {
@@ -300,7 +301,7 @@ static int __init init_nsc(void)
 
 	hi = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_HI);
 	lo = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_LO);
-	tpm_nsc.base = (hi<<8) | lo;
+	base = (hi<<8) | lo;
 
 	/* enable the DPM module */
 	tpm_write_index(nscAddrBase, NSC_LDC_INDEX, 0x01);
@@ -320,13 +321,15 @@ static int __init init_nsc(void)
 	if ((rc = platform_device_register(pdev)) < 0)
 		goto err_free_dev;
 
-	if (request_region(tpm_nsc.base, 2, "tpm_nsc0") == NULL ) {
+	if (request_region(base, 2, "tpm_nsc0") == NULL ) {
 		rc = -EBUSY;
 		goto err_unreg_dev;
 	}
 
-	if ((rc = tpm_register_hardware(&pdev->dev, &tpm_nsc)) < 0)
+	if (!(chip = tpm_register_hardware(&pdev->dev, &tpm_nsc))) {
+		rc = -ENODEV;
 		goto err_rel_reg;
+	}
 
 	dev_dbg(&pdev->dev, "NSC TPM detected\n");
 	dev_dbg(&pdev->dev,
@@ -361,10 +364,12 @@ static int __init init_nsc(void)
 		 "NSC TPM revision %d\n",
 		 tpm_read_index(nscAddrBase, 0x27) & 0x1F);
 
+	chip->vendor.base = base;
+
 	return 0;
 
 err_rel_reg:
-	release_region(tpm_nsc.base, 2);
+	release_region(base, 2);
 err_unreg_dev:
 	platform_device_unregister(pdev);
 err_free_dev:


