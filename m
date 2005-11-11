Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVKKUGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVKKUGL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVKKUGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:06:11 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:56262 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751129AbVKKUGJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:06:09 -0500
Subject: [PATCH 2 of 2] tpm: updates for new hardware
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linuxppc64-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Jake Moilanen <moilanen@us.ibm.com>, Tom Lendacky <toml@us.ibm.com>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 14:06:34 -0600
Message-Id: <1131739595.5048.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support TPMs on power ppc hardware.  It has been
reworked as requested to remove the need for messing with the io page
mask by just using ioremap.
 
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---

diff -uprN --exclude='*.o' --exclude='*.ko' --exclude='.*' --exclude='*~' --exclude='*infineon*' --exclude='*nsc*' --exclude='*mod*' --exclude='*.rej' --exclude='*.orig' linux-2.6.14/drivers/char/tpm/tpm_atmel.c linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.14/drivers/char/tpm/tpm_atmel.c	2005-11-11 11:12:38.000000000 -0600
+++ linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm_atmel.c	2005-11-11 09:42:49.000000000 -0600
@@ -19,14 +19,8 @@
  * 
  */
 
-#include <linux/platform_device.h>
 #include "tpm.h"
-
-/* Atmel definitions */
-enum tpm_atmel_addr {
-	TPM_ATMEL_BASE_ADDR_LO = 0x08,
-	TPM_ATMEL_BASE_ADDR_HI = 0x09
-};
+#include "tpm_atmel.h"
 
 /* write status bits */
 enum tpm_atmel_write_status {
@@ -53,13 +47,13 @@ static int tpm_atml_recv(struct tpm_chip
 		return -EIO;
 
 	for (i = 0; i < 6; i++) {
-		status = inb(chip->vendor->base + 1);
+		status = atmel_getb(chip, 1);
 		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
 			dev_err(chip->dev,
 				"error reading header\n");
 			return -EIO;
 		}
-		*buf++ = inb(chip->vendor->base);
+		*buf++ = atmel_getb(chip, 0);
 	}
 
 	/* size of the data received */
@@ -70,7 +64,7 @@ static int tpm_atml_recv(struct tpm_chip
 		dev_err(chip->dev,
 			"Recv size(%d) less than available space\n", size);
 		for (; i < size; i++) {	/* clear the waiting data anyway */
-			status = inb(chip->vendor->base + 1);
+			status = atmel_getb(chip, 1);
 			if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
 				dev_err(chip->dev,
 					"error reading data\n");
@@ -82,17 +76,17 @@ static int tpm_atml_recv(struct tpm_chip
 
 	/* read all the data available */
 	for (; i < size; i++) {
-		status = inb(chip->vendor->base + 1);
+		status = atmel_getb(chip, 1);
 		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
 			dev_err(chip->dev,
 				"error reading data\n");
 			return -EIO;
 		}
-		*buf++ = inb(chip->vendor->base);
+		*buf++ = atmel_getb(chip, 0);
 	}
 
 	/* make sure data available is gone */
-	status = inb(chip->vendor->base + 1);
+	status = atmel_getb(chip, 1);
 	if (status & ATML_STATUS_DATA_AVAIL) {
 		dev_err(chip->dev, "data available is stuck\n");
 		return -EIO;
@@ -108,7 +102,7 @@ static int tpm_atml_send(struct tpm_chip
 	dev_dbg(chip->dev, "tpm_atml_send:\n");
 	for (i = 0; i < count; i++) {
 		dev_dbg(chip->dev, "%d 0x%x(%d)\n",  i, buf[i], buf[i]);
-		outb(buf[i], chip->vendor->base);
+		atmel_putb(buf[i], chip, 0);
 	}
 
 	return count;
@@ -116,12 +110,12 @@ static int tpm_atml_send(struct tpm_chip
 
 static void tpm_atml_cancel(struct tpm_chip *chip)
 {
-	outb(ATML_STATUS_ABORT, chip->vendor->base + 1);
+	atmel_putb(ATML_STATUS_ABORT, chip, 1);
 }
 
 static u8 tpm_atml_status(struct tpm_chip *chip)
 {
-	return inb(chip->vendor->base + 1);
+	return atmel_getb(chip, 1);
 }
 
 static struct file_operations atmel_ops = {
@@ -162,12 +156,16 @@ static struct tpm_vendor_specific tpm_at
 
 static struct platform_device *pdev;
 
-static void __devexit tpm_atml_remove(struct device *dev)
+static void atml_plat_remove(void)
 {
-	struct tpm_chip *chip = dev_get_drvdata(dev);
+	struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
+
 	if (chip) {
-		release_region(chip->vendor->base, 2);
+		if (chip->vendor->have_region)
+			atmel_release_region(chip->vendor->base, chip->vendor->region_size);
+		atmel_put_base_addr(chip->vendor);	
 		tpm_remove_hardware(chip->dev);
+		platform_device_unregister(pdev);
 	}
 }
 
@@ -182,72 +180,40 @@ static struct device_driver atml_drv = {
 static int __init init_atmel(void)
 {
 	int rc = 0;
-	int lo, hi;
 
 	driver_register(&atml_drv);
 
-	lo = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
-	hi = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
-
-	tpm_atmel.base = (hi<<8)|lo;
-
-	/* verify that it is an Atmel part */
-	if (tpm_read_index(TPM_ADDR, 4) != 'A' || tpm_read_index(TPM_ADDR, 5) != 'T'
-	    || tpm_read_index(TPM_ADDR, 6) != 'M' || tpm_read_index(TPM_ADDR, 7) != 'L') {
-		return -ENODEV;
+	if (atmel_get_base_addr(&tpm_atmel) != 0) {
+		rc = -ENODEV;
+		goto err_unreg_drv;
 	}
 
-	/* verify chip version number is 1.1 */
-	if (	(tpm_read_index(TPM_ADDR, 0x00) != 0x01) ||
-		(tpm_read_index(TPM_ADDR, 0x01) != 0x01 ))
-		return -ENODEV;
-
-	pdev = kzalloc(sizeof(struct platform_device), GFP_KERNEL);
-	if ( !pdev )
-		return -ENOMEM;
-
-	pdev->name = "tpm_atmel0";
-	pdev->id = -1;
-	pdev->num_resources = 0;
-	pdev->dev.release = tpm_atml_remove;
-	pdev->dev.driver = &atml_drv;
+	tpm_atmel.have_region = (atmel_request_region( tpm_atmel.base, tpm_atmel.region_size, "tpm_atmel0") == NULL) ? 0 : 1;
 
-	if ((rc = platform_device_register(pdev)) < 0) {
-		kfree(pdev);
-		pdev = NULL;
-		return rc;
+	if (IS_ERR(pdev = platform_device_register_simple("tpm_atmel", -1, NULL, 0 ))) {
+		rc = PTR_ERR(pdev);
+		goto err_rel_reg;
 	}
 
-	if (request_region(tpm_atmel.base, 2, "tpm_atmel0") == NULL ) {
-		platform_device_unregister(pdev);
-		kfree(pdev);
-		pdev = NULL;
-		return -EBUSY;
-	}
-
-	if ((rc = tpm_register_hardware(&pdev->dev, &tpm_atmel)) < 0) {
-		release_region(tpm_atmel.base, 2);
-		platform_device_unregister(pdev);
-		kfree(pdev);
-		pdev = NULL;
-		return rc;
-	}
-
-	dev_info(&pdev->dev, "Atmel TPM 1.1, Base Address: 0x%x\n",
-			tpm_atmel.base);
+	if ((rc = tpm_register_hardware(&pdev->dev, &tpm_atmel)) < 0) 
+		goto err_unreg_dev;
 	return 0;
+
+err_unreg_dev:
+	platform_device_unregister(pdev);
+err_rel_reg:
+	if (tpm_atmel.have_region)
+		atmel_release_region(tpm_atmel.base, tpm_atmel.region_size);
+	atmel_put_base_addr(&tpm_atmel);
+err_unreg_drv:
+	driver_unregister(&atml_drv);
+	return rc;
 }
 
 static void __exit cleanup_atmel(void)
 {
-	if (pdev) {
-		tpm_atml_remove(&pdev->dev);
-		platform_device_unregister(pdev);
-		kfree(pdev);
-		pdev = NULL;
-	}
-
 	driver_unregister(&atml_drv);
+	atml_plat_remove();
 }
 
 module_init(init_atmel);
diff -uprN --exclude='*.o' --exclude='*.ko' --exclude='.*' --exclude='*~' --exclude='*infineon*' --exclude='*nsc*' --exclude='*mod*' --exclude='*.rej' --exclude='*.orig' linux-2.6.14/drivers/char/tpm/tpm_atmel.h linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm_atmel.h
--- linux-2.6.14/drivers/char/tpm/tpm_atmel.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm_atmel.h	2005-11-11 10:46:58.000000000 -0600
@@ -0,0 +1,129 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Maintained by: <tpmdd_devel@lists.sourceforge.net>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org	 
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * These difference are required on power because the device must be
+ * discovered through the device tree and iomap must be used to get 
+ * around the need for holes in the io_page_mask.  This does not happen 
+ * automatically because the tpm is not a normal pci device and lives 
+ * under the root node.
+ *
+ */
+
+#ifdef CONFIG_PPC64
+#define atmel_getb(chip, offset) readb(chip->vendor->iobase + offset);
+#define atmel_putb(val, chip, offset) writeb(val, chip->vendor->iobase + offset)
+#define atmel_request_region request_mem_region
+#define atmel_release_region release_mem_region
+static inline void atmel_put_base_addr(struct tpm_vendor_specific *vendor)
+{
+	iounmap(vendor->iobase);
+}
+
+static int atmel_get_base_addr(struct tpm_vendor_specific *vendor)
+{
+	struct device_node *dn;
+	unsigned long address, size;
+	unsigned int *reg;
+	int reglen;
+	int naddrc;
+	int nsizec;
+
+	dn = of_find_node_by_name(NULL, "tpm");
+
+	if (!dn)
+		return 1;
+
+	if (!device_is_compatible(dn, "AT97SC3201")) {
+		of_node_put(dn);
+		return 1;
+	}
+
+	reg = (unsigned int *) get_property(dn, "reg", &reglen);
+	naddrc = prom_n_addr_cells(dn);
+	nsizec = prom_n_size_cells(dn);
+
+	of_node_put(dn);
+
+
+	if (naddrc == 2)
+		address = ((unsigned long) reg[0] << 32) | reg[1];
+	else
+		address = reg[0];
+
+	if (nsizec == 2)
+		size =
+		    ((unsigned long) reg[naddrc] << 32) | reg[naddrc + 1];
+	else
+		size = reg[naddrc];
+
+	vendor->base = address;
+	vendor->region_size = size;
+	vendor->iobase = ioremap(address, size);
+	return 0;
+}
+#else
+#define atmel_getb(chip, offset) inb(chip->vendor->base + offset)
+#define atmel_putb(val, chip, offset) outb(val, chip->vendor->base + offset)
+#define atmel_request_region request_region
+#define atmel_release_region release_region
+/* Atmel definitions */
+enum tpm_atmel_addr {
+	TPM_ATMEL_BASE_ADDR_LO = 0x08,
+	TPM_ATMEL_BASE_ADDR_HI = 0x09
+};
+
+/* Verify this is a 1.1 Atmel TPM */
+static int atmel_verify_tpm11(void)
+{
+
+	/* verify that it is an Atmel part */
+	if (tpm_read_index(TPM_ADDR, 4) != 'A' ||
+	    tpm_read_index(TPM_ADDR, 5) != 'T' ||
+	    tpm_read_index(TPM_ADDR, 6) != 'M' ||
+	    tpm_read_index(TPM_ADDR, 7) != 'L')
+		return 1;
+
+	/* query chip for its version number */
+	if (tpm_read_index(TPM_ADDR, 0x00) != 1 ||
+	    tpm_read_index(TPM_ADDR, 0x01) != 1)
+		return 1;
+
+	/* This is an atmel supported part */
+	return 0;
+}
+
+static inline void atmel_put_base_addr(struct tpm_vendor_specific *vendor)
+{
+}
+
+/* Determine where to talk to device */
+static unsigned long atmel_get_base_addr(struct tpm_vendor_specific
+					 *vendor)
+{
+	int lo, hi;
+
+	if (atmel_verify_tpm11() != 0)
+		return 1;
+
+	lo = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
+	hi = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
+
+	vendor->base = (hi << 8) | lo;
+	vendor->region_size = 2;
+
+	return 0;
+}
+#endif
diff -uprN --exclude='*.o' --exclude='*.ko' --exclude='.*' --exclude='*~' --exclude='*infineon*' --exclude='*nsc*' --exclude='*mod*' --exclude='*.rej' --exclude='*.orig' linux-2.6.14/drivers/char/tpm/tpm.h linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm.h
--- linux-2.6.14/drivers/char/tpm/tpm.h	2005-11-11 11:12:38.000000000 -0600
+++ linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm.h	2005-11-11 09:36:34.000000000 -0600
@@ -50,7 +50,11 @@ struct tpm_vendor_specific {
 	u8 req_complete_mask;
 	u8 req_complete_val;
 	u8 req_canceled;
-	u16 base;		/* TPM base address */
+	void __iomem *iobase;		/* ioremapped address */
+	unsigned long base;		/* TPM base address */
+
+	int region_size;
+	int have_region;
 
 	int (*recv) (struct tpm_chip *, u8 *, size_t);
 	int (*send) (struct tpm_chip *, u8 *, size_t);


