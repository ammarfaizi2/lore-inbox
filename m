Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVJaOh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVJaOh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVJaOh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:37:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:2785 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932271AbVJaOh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:37:27 -0500
Subject: [PATCH] tpm: support PPC64 hardware
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, moilanen@austin.ibm.com
Content-Type: text/plain
Date: Mon, 31 Oct 2005 08:37:59 -0600
Message-Id: <1130769479.4882.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The TPM is discovered differently on PPC64 because the device must be
discovered through the device tree in order to open the proper holes in
the io_page_mask for reading and writing in the low memory space.  This
does not happen automatically like most devices because the tpm is not a
normal pci device and lives under the root node.

This patch contains the necessary changes to the tpm logic.

This depends on patches submitted by Jake Moilanen (10/28) to allow for
the opening of holes in the io_page_mask for this device.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>

--- 
diff -uprN --exclude='*.ko' --exclude='*.o' --exclude='.*' --exclude='*mod*' linux-2.6.14-rc4/drivers/char/tpm/tpm_atmel.c linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.14-rc4/drivers/char/tpm/tpm_atmel.c	2005-10-28 14:34:47.000000000 +0200
+++ linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm_atmel.c	2005-10-28 14:34:07.000000000 +0200
@@ -20,10 +20,5 @@
  */
 
 #include "tpm.h"
- 
-/* Atmel definitions */
-enum tpm_atmel_addr {
-	TPM_ATMEL_BASE_ADDR_LO = 0x08,
-	TPM_ATMEL_BASE_ADDR_HI = 0x09
-};
+#include "tpm_atmel.h"

@@ -165,7 +166,7 @@ static void __devexit tpm_atml_remove(st
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
 	if (chip) {
-		release_region(chip->vendor->base, 2);
+		atmel_release_region(chip->vendor->base, 2);
 		tpm_remove_hardware(chip->dev);
 	}
 }
@@ -181,59 +182,54 @@ static struct device_driver atml_drv = {
 static int __init init_atmel(void)
 {
 	int rc = 0;
-	int lo, hi;
 
+	if ( atmel_verify_tpm11() != 0 )
+		return -ENODEV;
+
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
+	tpm_atmel.base = atmel_get_base_addr(TPM_ADDR, 2);
+	if (tpm_atmel.base == 0) {
+		rc = -ENODEV;
+		goto err_unreg_drv;
 	}
 
-	/* verify chip version number is 1.1 */
-	if (	(tpm_read_index(TPM_ADDR, 0x00) != 0x01) ||
-		(tpm_read_index(TPM_ADDR, 0x01) != 0x01 ))
-		return -ENODEV;
-	
 	pdev = kzalloc(sizeof(struct platform_device), GFP_KERNEL);
-	if ( !pdev ) 
-		return -ENOMEM;
+	if ( !pdev ) {
+		rc = -ENOMEM; 
+		goto err_unreg_drv;
+	}
 
 	pdev->name = "tpm_atmel0";
 	pdev->id = -1;
 	pdev->num_resources = 0;
-	pdev->dev.release = tpm_atml_remove;	
+	pdev->dev.release = tpm_atml_remove;
 	pdev->dev.driver = &atml_drv;
 
-	if ((rc = platform_device_register(pdev)) < 0) {
-		kfree(pdev);
-		pdev = NULL;
-		return rc;
-	}
+	if ((rc = platform_device_register(pdev)) < 0) 
+		goto err_free_dev;
 
-	if (request_region(tpm_atmel.base, 2, "tpm_atmel0") == NULL ) {
-		platform_device_unregister(pdev);
-		kfree(pdev);
-		pdev = NULL;
-		return -EBUSY;
+	if (atmel_request_region(tpm_atmel.base, 2, "tpm_atmel0") == NULL ) {
+		rc = -EBUSY;
+		goto err_unreg_dev;
 	}
 
-	if ((rc = tpm_register_hardware(&pdev->dev, &tpm_atmel)) < 0) {
-		release_region(tpm_atmel.base, 2);
-		platform_device_unregister(pdev);
-		kfree(pdev);
-		pdev = NULL;
-		return rc;
-	}
+	if ((rc = tpm_register_hardware(&pdev->dev, &tpm_atmel)) < 0) 
+		goto err_rel_reg;
 
	dev_info(&pdev->dev, "Atmel TPM 1.1, Base Address: 0x%x\n",
			tpm_atmel.base);
 	return 0;
+
+err_rel_reg:
+	atmel_release_region(tpm_atmel.base, 2);
+err_unreg_dev:
+	platform_device_unregister(pdev);
+err_free_dev:
+	kfree(pdev);
+	pdev = NULL;
+err_unreg_drv:
+	driver_unregister(&atml_drv);
+	return rc;
 }
 
 static void __exit cleanup_atmel(void)
diff -uprN --exclude='*.ko' --exclude='*.o' --exclude='.*' --exclude='*mod*' linux-2.6.14-rc4/drivers/char/tpm/tpm_atmel.h linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm_atmel.h
--- linux-2.6.14-rc4/drivers/char/tpm/tpm_atmel.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm_atmel.h	2005-10-28 13:32:04.000000000 +0200
@@ -0,0 +1,137 @@
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
+ * These differences are required on power because the device must be
+ * discovered through the device tree in order to open the proper holes 
+ * in the io_page_mask for reading and writing in the low memory space.  
+ * This does not happen automatically like most devices because the tpm 
+ * is not a normal pci device and lives under the root node.
+ *
+ */
+
+#ifdef CONFIG_PPC64
+#define atmel_request_region request_mem_region
+#define atmel_release_region release_mem_region
+
+/* Verify this is a 1.1 Atmel TPM */
+static int atmel_verify_tpm11(void)
+{
+	struct device_node * dn;
+	char *compat;
+	int compat_len;
+
+	dn = find_devices("tpm");
+
+	if (!dn)
+		return 1;
+
+	compat = (char *) get_property(dn, "compatible", &compat_len);
+	if (!compat)
+		return 1;
+
+	if ( strcmp( compat,"AT97SC3201_r") == 0 )
+		return 0;
+
+	return 1;
+}
+
+static unsigned long atmel_get_base_addr(unsigned long base_addr, 
+					unsigned long base_size)
+{
+	struct device_node * dn;
+	unsigned long address, size;
+	unsigned int * reg;
+	long tpm_addr = 0;
+	int reglen;
+	int naddrc;
+	int nsizec;
+	int i;
+
+	dn = find_devices("tpm");
+
+	if (!dn)
+		return 0;
+
+	reg = (unsigned int *) get_property(dn, "reg", &reglen);
+	naddrc = prom_n_addr_cells(dn);
+	nsizec = prom_n_size_cells(dn);
+
+	for (i = 0; i < reglen; i = i + naddrc + nsizec) {
+
+		if (naddrc == 2)
+			address = ((unsigned long)reg[i] << 32) | reg[i+1];
+		else
+			address = reg[i];
+
+		address = address - pci_io_base_phys;
+
+		/* Use the first address */
+		if (tpm_addr == 0)
+			tpm_addr = address;
+
+		if (nsizec == 2)
+			size = ((unsigned long)reg[naddrc] << 32) | reg[naddrc+1];
+		else
+			size = reg[naddrc];
+
+		allow_isa_address(address, address+size-1);
+	}
+
+	return tpm_addr;
+
+}
+#else
+/* Atmel definitions */
+enum tpm_atmel_addr {
+	TPM_ATMEL_BASE_ADDR_LO = 0x08,
+	TPM_ATMEL_BASE_ADDR_HI = 0x09
+};
+
+#define atmel_request_region request_region
+#define atmel_release_region release_region
+
+/* Verify this is a 1.1 Atmel TPM */
+static int atmel_verify_tpm11(void)
+{
+
+	/* verify that it is an Atmel part */
+	if (	tpm_read_index(TPM_ADDR, 4) != 'A' || 
+		tpm_read_index(TPM_ADDR, 5) != 'T' ||
+		tpm_read_index(TPM_ADDR, 6) != 'M' || 
+		tpm_read_index(TPM_ADDR, 7) != 'L') 
+		return 1;
+
+	/* query chip for its version number */
+	if (	tpm_read_index(TPM_ADDR, 0x00) != 1 ||
+		tpm_read_index(TPM_ADDR, 0x01) != 1 )
+		return 1;
+
+	/* This is an atmel supported part */
+	return 0;
+}
+
+/* Determine where to talk to device */
+static unsigned long atmel_get_base_addr(unsigned long base_addr, 
+					unsigned long size)
+{
+	int lo, hi;
+
+	lo = tpm_read_index(base_addr, TPM_ATMEL_BASE_ADDR_LO);
+	hi = tpm_read_index(base_addr, TPM_ATMEL_BASE_ADDR_HI);
+
+	return (hi<<8)|lo;
+}
+#endif


