Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVJYPVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVJYPVo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 11:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVJYPVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 11:21:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:44740 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932183AbVJYPVi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 11:21:38 -0400
Subject: [PATCH 5 of 6] tpm: move nsc driver off pci_dev
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Date: Tue, 25 Oct 2005 10:22:07 -0500
Message-Id: <1130253727.4839.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the nsc driver from a pci driver to a platform
driver.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---

--- linux-2.6.14-rc4/drivers/char/tpm/tpm_nsc.c	2005-10-19 17:03:52.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm_nsc.c	2005-10-21 09:43:17.000000000 -0500
@@ -261,16 +261,32 @@ static struct tpm_vendor_specific tpm_ns
 	.miscdev = { .fops = &nsc_ops, },
 };
 
-static int __devinit tpm_nsc_init(struct pci_dev *pci_dev,
-				  const struct pci_device_id *pci_id)
+static struct platform_device *pdev = NULL;
+
+static void __devexit tpm_nsc_remove(struct device *dev) 
+{
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	if ( chip ) {
+		release_region(chip->vendor->base, 2);
+		tpm_remove_hardware(chip->dev);
+	}
+}
+
+static struct device_driver nsc_drv = {
+	.name = "tpm_nsc",
+	.bus = &platform_bus_type,
+	.owner = THIS_MODULE,
+	.suspend = tpm_pm_suspend,
+	.resume = tpm_pm_resume,
+};
+
+static int __init init_nsc(void)
 {
 	int rc = 0;
 	int lo, hi;
 	int nscAddrBase = TPM_ADDR;
 
-
-	if (pci_enable_device(pci_dev))
-		return -EIO;
+	driver_register(&nsc_drv);
 
 	/* select PM channel 1 */
 	tpm_write_index(nscAddrBase,NSC_LDN_INDEX, 0x12);
@@ -279,37 +295,71 @@ static int __devinit tpm_nsc_init(struct
 	if (tpm_read_index(TPM_ADDR, NSC_SID_INDEX) != 0xEF) {
 		nscAddrBase = (tpm_read_index(TPM_SUPERIO_ADDR, 0x2C)<<8)|
 			(tpm_read_index(TPM_SUPERIO_ADDR, 0x2B)&0xFE);
-		if (tpm_read_index(nscAddrBase, NSC_SID_INDEX) != 0xF6) {
-			rc = -ENODEV;
-			goto out_err;
-		}
+		if (tpm_read_index(nscAddrBase, NSC_SID_INDEX) != 0xF6)
+			return -ENODEV;
 	}
 
 	hi = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_HI);
 	lo = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_LO);
 	tpm_nsc.base = (hi<<8) | lo;
 
-	dev_dbg(&pci_dev->dev, "NSC TPM detected\n");
-	dev_dbg(&pci_dev->dev,
+	/* enable the DPM module */
+	tpm_write_index(nscAddrBase, NSC_LDC_INDEX, 0x01);
+
+	pdev = kmalloc(sizeof(struct platform_device), GFP_KERNEL);
+	if ( !pdev ) 
+		return -ENOMEM;
+
+	memset(pdev, 0, sizeof(struct platform_device));
+
+	pdev->name = "tpm_nscl0";
+	pdev->id = -1;
+	pdev->num_resources = 0;
+	pdev->dev.release = tpm_nsc_remove;	
+	pdev->dev.driver = &nsc_drv;
+
+	if ((rc=platform_device_register(pdev)) < 0) {
+		kfree(pdev);
+		pdev = NULL;
+		return rc;
+	}
+
+	if (request_region(tpm_nsc.base, 2, "tpm_nsc0") == NULL ) {
+		platform_device_unregister(pdev);
+		kfree(pdev);
+		pdev = NULL;
+		return -EBUSY;
+	}
+
+	if ((rc = tpm_register_hardware(&pdev->dev, &tpm_nsc)) < 0) {
+		release_region(tpm_nsc.base, 2);
+		platform_device_unregister(pdev);
+		kfree(pdev);
+		pdev = NULL;
+		return rc;
+	}
+
+	dev_dbg(&pdev->dev, "NSC TPM detected\n");
+	dev_dbg(&pdev->dev,
 		"NSC LDN 0x%x, SID 0x%x, SRID 0x%x\n",
 		tpm_read_index(nscAddrBase,0x07), tpm_read_index(nscAddrBase,0x20),
 		tpm_read_index(nscAddrBase,0x27));
-	dev_dbg(&pci_dev->dev,
+	dev_dbg(&pdev->dev,
 		"NSC SIOCF1 0x%x SIOCF5 0x%x SIOCF6 0x%x SIOCF8 0x%x\n",
 		tpm_read_index(nscAddrBase,0x21), tpm_read_index(nscAddrBase,0x25),
 		tpm_read_index(nscAddrBase,0x26), tpm_read_index(nscAddrBase,0x28));
-	dev_dbg(&pci_dev->dev, "NSC IO Base0 0x%x\n",
+	dev_dbg(&pdev->dev, "NSC IO Base0 0x%x\n",
 		(tpm_read_index(nscAddrBase,0x60) << 8) | tpm_read_index(nscAddrBase,0x61));
-	dev_dbg(&pci_dev->dev, "NSC IO Base1 0x%x\n",
+	dev_dbg(&pdev->dev, "NSC IO Base1 0x%x\n",
 		(tpm_read_index(nscAddrBase,0x62) << 8) | tpm_read_index(nscAddrBase,0x63));
-	dev_dbg(&pci_dev->dev, "NSC Interrupt number and wakeup 0x%x\n",
+	dev_dbg(&pdev->dev, "NSC Interrupt number and wakeup 0x%x\n",
 		tpm_read_index(nscAddrBase,0x70));
-	dev_dbg(&pci_dev->dev, "NSC IRQ type select 0x%x\n",
+	dev_dbg(&pdev->dev, "NSC IRQ type select 0x%x\n",
 		tpm_read_index(nscAddrBase,0x71));
-	dev_dbg(&pci_dev->dev,
+	dev_dbg(&pdev->dev,
 		"NSC DMA channel select0 0x%x, select1 0x%x\n",
 		tpm_read_index(nscAddrBase,0x74), tpm_read_index(nscAddrBase,0x75));
-	dev_dbg(&pci_dev->dev,
+	dev_dbg(&pdev->dev,
 		"NSC Config "
 		"0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
 		tpm_read_index(nscAddrBase,0xF0), tpm_read_index(nscAddrBase,0xF1),
@@ -318,63 +368,23 @@ static int __devinit tpm_nsc_init(struct
 		tpm_read_index(nscAddrBase,0xF6), tpm_read_index(nscAddrBase,0xF7),
 		tpm_read_index(nscAddrBase,0xF8), tpm_read_index(nscAddrBase,0xF9));
 
-	dev_info(&pci_dev->dev,
+	dev_info(&pdev->dev,
 		 "NSC TPM revision %d\n",
 		 tpm_read_index(nscAddrBase, 0x27) & 0x1F);
 
-	/* enable the DPM module */
-	tpm_write_index(nscAddrBase, NSC_LDC_INDEX, 0x01);
-
-	if ((rc = tpm_register_hardware(&pci_dev->dev, &tpm_nsc)) < 0)
-		goto out_err;
-
 	return 0;
-
-out_err:
-	pci_disable_device(pci_dev);
-	return rc;
-}
-
-static void __devexit tpm_nsc_remove(struct pci_dev *pci_dev) 
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
-	{0,}
-};
-
-MODULE_DEVICE_TABLE(pci, tpm_pci_tbl);
-
-static struct pci_driver nsc_pci_driver = {
-	.name = "tpm_nsc",
-	.id_table = tpm_pci_tbl,
-	.probe = tpm_nsc_init,
-	.remove = __devexit_p(tpm_nsc_remove),
-	.suspend = tpm_pm_suspend,
-	.resume = tpm_pm_resume,
-};
-
-static int __init init_nsc(void)
-{
-	return pci_register_driver(&nsc_pci_driver);
 }
 
 static void __exit cleanup_nsc(void)
 {
-	pci_unregister_driver(&nsc_pci_driver);
+	if (pdev) {
+		tpm_nsc_remove(&pdev->dev);
+		platform_device_unregister(pdev);
+		kfree(pdev);
+		pdev = NULL;
+	}
+
+	driver_unregister(&nsc_drv);
 }
 
 module_init(init_nsc);


