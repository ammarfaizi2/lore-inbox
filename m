Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVJYPWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVJYPWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 11:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVJYPVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 11:21:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:39910 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932182AbVJYPVc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 11:21:32 -0400
Subject: [PATCH 4 of 6] tpm: move atmel driver off pci_dev
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Date: Tue, 25 Oct 2005 10:22:02 -0500
Message-Id: <1130253722.4839.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the atmel driver from a pci driver to a platform
driver.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---

--- linux-2.6.14-rc4/drivers/char/tpm/tpm_atmel.c	2005-10-19 17:03:52.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm_atmel.c	2005-10-19 14:23:24.000000000 -0500
@@ -159,94 +159,95 @@ static struct tpm_vendor_specific tpm_at
 	.miscdev = { .fops = &atmel_ops, },
 };
 
-static int __devinit tpm_atml_init(struct pci_dev *pci_dev,
-				   const struct pci_device_id *pci_id)
+static struct platform_device *pdev = NULL;
+
+static void __devexit tpm_atml_remove(struct device *dev) 
+{
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	if ( chip ) {
+		release_region(chip->vendor->base, 2);
+		tpm_remove_hardware(chip->dev);
+	}
+}
+
+static struct device_driver atml_drv = {
+	.name = "tpm_atmel",
+	.bus = &platform_bus_type,
+	.owner = THIS_MODULE,
+	.suspend = tpm_pm_suspend,
+	.resume = tpm_pm_resume,
+};
+
+static int __init init_atmel(void)
 {
-	u8 version[4];
 	int rc = 0;
 	int lo, hi;
 
-	if (pci_enable_device(pci_dev))
-		return -EIO;
+	driver_register(&atml_drv);
 
 	lo = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
 	hi = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
 
 	tpm_atmel.base = (hi<<8)|lo;
-	dev_dbg( &pci_dev->dev, "Operating with base: 0x%x\n", tpm_atmel.base);
 
 	/* verify that it is an Atmel part */
 	if (tpm_read_index(TPM_ADDR, 4) != 'A' || tpm_read_index(TPM_ADDR, 5) != 'T'
 	    || tpm_read_index(TPM_ADDR, 6) != 'M' || tpm_read_index(TPM_ADDR, 7) != 'L') {
-		rc = -ENODEV;
-		goto out_err;
+		return -ENODEV;
 	}
 
-	/* query chip for its version number */
-	if ((version[0] = tpm_read_index(TPM_ADDR, 0x00)) != 0xFF) {
-		version[1] = tpm_read_index(TPM_ADDR, 0x01);
-		version[2] = tpm_read_index(TPM_ADDR, 0x02);
-		version[3] = tpm_read_index(TPM_ADDR, 0x03);
-	} else {
-		dev_info(&pci_dev->dev, "version query failed\n");
-		rc = -ENODEV;
-		goto out_err;
-	}
-
-	if ((rc = tpm_register_hardware(&pci_dev->dev, &tpm_atmel)) < 0)
-		goto out_err;
-
-	dev_info(&pci_dev->dev,
-		 "Atmel TPM version %d.%d.%d.%d\n", version[0], version[1],
-		 version[2], version[3]);
-
-	return 0;
-out_err:
-	pci_disable_device(pci_dev);
-	return rc;
-}
-
-static void __devexit tpm_atml_remove(struct pci_dev *pci_dev) 
-{
-	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
-
-	if ( chip )
-		tpm_remove_hardware(chip->dev);
-}
-
-static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
-	{PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6LPC)},
-	{0,}
-};
+	/* verify chip version number is 1.1 */
+	if (	(tpm_read_index(TPM_ADDR, 0x00) != 0x01) ||
+		(tpm_read_index(TPM_ADDR, 0x01) != 0x01 ))
+		return -ENODEV;
+	
+	pdev = kmalloc(sizeof(struct platform_device), GFP_KERNEL);
+	if ( !pdev ) 
+		return -ENOMEM;
+
+	memset(pdev, 0, sizeof(struct platform_device));
+
+	pdev->name = "tpm_atmel0";
+	pdev->id = -1;
+	pdev->num_resources = 0;
+	pdev->dev.release = tpm_atml_remove;	
+	pdev->dev.driver = &atml_drv;
+
+	if ((rc=platform_device_register(pdev)) < 0) {
+		kfree(pdev);
+		pdev = NULL;
+		return rc;
+	}
 
-MODULE_DEVICE_TABLE(pci, tpm_pci_tbl);
+	if (request_region(tpm_atmel.base, 2, "tpm_atmel0") == NULL ) {
+		platform_device_unregister(pdev);
+		kfree(pdev);
+		pdev = NULL;
+		return -EBUSY;
+	}
 
-static struct pci_driver atmel_pci_driver = {
-	.name = "tpm_atmel",
-	.id_table = tpm_pci_tbl,
-	.probe = tpm_atml_init,
-	.remove = __devexit_p(tpm_atml_remove),
-	.suspend = tpm_pm_suspend,
-	.resume = tpm_pm_resume,
-};
+	if ((rc = tpm_register_hardware(&pdev->dev, &tpm_atmel)) < 0) {
+		release_region(tpm_atmel.base, 2);
+		platform_device_unregister(pdev);
+		kfree(pdev);
+		pdev = NULL;
+		return rc;
+	}
 
-static int __init init_atmel(void)
-{
-	return pci_register_driver(&atmel_pci_driver);
+	dev_info(&pdev->dev, "Atmel TPM 1.1, Base Address: 0x%x\n", tpm_atmel.base);
+	return 0;
 }
 
 static void __exit cleanup_atmel(void)
 {
-	pci_unregister_driver(&atmel_pci_driver);
+	if (pdev) {
+		tpm_atml_remove(&pdev->dev);
+		platform_device_unregister(pdev);
+		kfree(pdev);
+		pdev = NULL;
+	}
+
+	driver_unregister(&atml_drv);
 }
 
 module_init(init_atmel);



