Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWGLVE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWGLVE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWGLVE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:04:27 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:64722 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932256AbWGLVE0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:04:26 -0400
Subject: [PATCH] tpm: Add force device probe option
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>, akpm@osdl.org
Content-Type: text/plain
Date: Wed, 12 Jul 2006 14:04:33 -0700
Message-Id: <1152738273.5347.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some machine manufacturers are not sticking to the TCG specifications
and including an ACPI DSDT entry for the TPM which allows PNP discovery
of the device.  This patch adds a force option that will allow users to
load the driver if they know there machine has a chip but it is not
being discovered by the normal processes.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm_tis.c |   74 ++++++++++++++++++++++++++---------
 1 files changed, 55 insertions(+), 19 deletions(-)

--- tcg/tpmdd/drivers/char/tpm/tpm_tis.c	2006-06-07 11:37:08.000000000 -0700
+++ linux-2.6.17-rc3/drivers/char/tpm/tpm_tis.c	2006-07-10 13:06:44.000000000 -0700
@@ -431,23 +431,18 @@ static int interrupts = 1;
 module_param(interrupts, bool, 0444);
 MODULE_PARM_DESC(interrupts, "Enable interrupts");
 
-static int __devinit tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
-				      const struct pnp_device_id *pnp_id)
+static int tpm_tis_init(struct device *dev, unsigned long start, unsigned long len)
 {
 	u32 vendor, intfcaps, intmask;
 	int rc, i;
-	unsigned long start, len;
 	struct tpm_chip *chip;
 
-	start = pnp_mem_start(pnp_dev, 0);
-	len = pnp_mem_len(pnp_dev, 0);
-
 	if (!start)
 		start = TIS_MEM_BASE;
 	if (!len)
 		len = TIS_MEM_LEN;
 
-	if (!(chip = tpm_register_hardware(&pnp_dev->dev, &tpm_tis)))
+	if (!(chip = tpm_register_hardware(dev, &tpm_tis)))
 		return -ENODEV;
 
 	chip->vendor.iobase = ioremap(start, len);
@@ -464,7 +460,7 @@ static int __devinit tpm_tis_pnp_init(st
 	chip->vendor.timeout_c = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
 	chip->vendor.timeout_d = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
 
-	dev_info(&pnp_dev->dev,
+	dev_info(dev,
 		 "1.2 TPM (device-id 0x%X, rev-id %d)\n",
 		 vendor >> 16, ioread8(chip->vendor.iobase + TPM_RID(0)));
 
@@ -472,26 +468,26 @@ static int __devinit tpm_tis_pnp_init(st
 	intfcaps =
 	    ioread32(chip->vendor.iobase +
 		     TPM_INTF_CAPS(chip->vendor.locality));
-	dev_dbg(&pnp_dev->dev, "TPM interface capabilities (0x%x):\n",
+	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
 		intfcaps);
 	if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
-		dev_dbg(&pnp_dev->dev, "\tBurst Count Static\n");
+		dev_dbg(dev, "\tBurst Count Static\n");
 	if (intfcaps & TPM_INTF_CMD_READY_INT)
-		dev_dbg(&pnp_dev->dev, "\tCommand Ready Int Support\n");
+		dev_dbg(dev, "\tCommand Ready Int Support\n");
 	if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
-		dev_dbg(&pnp_dev->dev, "\tInterrupt Edge Falling\n");
+		dev_dbg(dev, "\tInterrupt Edge Falling\n");
 	if (intfcaps & TPM_INTF_INT_EDGE_RISING)
-		dev_dbg(&pnp_dev->dev, "\tInterrupt Edge Rising\n");
+		dev_dbg(dev, "\tInterrupt Edge Rising\n");
 	if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
-		dev_dbg(&pnp_dev->dev, "\tInterrupt Level Low\n");
+		dev_dbg(dev, "\tInterrupt Level Low\n");
 	if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
-		dev_dbg(&pnp_dev->dev, "\tInterrupt Level High\n");
+		dev_dbg(dev, "\tInterrupt Level High\n");
 	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
-		dev_dbg(&pnp_dev->dev, "\tLocality Change Int Support\n");
+		dev_dbg(dev, "\tLocality Change Int Support\n");
 	if (intfcaps & TPM_INTF_STS_VALID_INT)
-		dev_dbg(&pnp_dev->dev, "\tSts Valid Int Support\n");
+		dev_dbg(dev, "\tSts Valid Int Support\n");
 	if (intfcaps & TPM_INTF_DATA_AVAIL_INT)
-		dev_dbg(&pnp_dev->dev, "\tData Avail Int Support\n");
+		dev_dbg(dev, "\tData Avail Int Support\n");
 
 	if (request_locality(chip, 0) != 0) {
 		rc = -ENODEV;
@@ -594,6 +590,16 @@ out_err:
 	return rc;
 }
 
+static int __devinit tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
+				      const struct pnp_device_id *pnp_id)
+{
+	unsigned long start, len;
+	start = pnp_mem_start(pnp_dev, 0);
+	len = pnp_mem_len(pnp_dev, 0);
+
+	return tpm_tis_init(&pnp_dev->dev, start, len);
+}
+
 static int tpm_tis_pnp_suspend(struct pnp_dev *dev, pm_message_t msg)
 {
 	return tpm_pm_suspend(&dev->dev, msg);
@@ -628,8 +634,34 @@ module_param_string(hid, tpm_pnp_tbl[TIS
 		    sizeof(tpm_pnp_tbl[TIS_HID_USR_IDX].id), 0444);
 MODULE_PARM_DESC(hid, "Set additional specific HID for this driver to probe");
 
+static struct device_driver tis_drv = {
+	.name = "tpm_tis",
+	.bus = &platform_bus_type,
+	.owner = THIS_MODULE,
+	.suspend = tpm_pm_suspend,
+	.resume = tpm_pm_resume,
+};
+
+static struct platform_device *pdev;
+
+static int force = 0;
+module_param(force, bool, 0444);
+MODULE_PARM_DESC(force, "Force device probe rather than using ACPI entry");
 static int __init init_tis(void)
 {
+	int rc;
+
+	if (force) {
+		driver_register(&tis_drv);
+		if (IS_ERR(pdev=platform_device_register_simple("tpm_tis", -1, NULL, 0)))
+			return PTR_ERR(pdev);
+		if((rc=tpm_tis_init(&pdev->dev, 0, 0)) != 0) {
+			platform_device_unregister(pdev);
+			driver_unregister(&tis_drv);
+		}
+		return rc;
+	}
+
 	return pnp_register_driver(&tis_pnp_driver);
 }
 
@@ -654,7 +687,12 @@ static void __exit cleanup_tis(void)
 		tpm_remove_hardware(chip->dev);
 	}
 	spin_unlock(&tis_lock);
-	pnp_unregister_driver(&tis_pnp_driver);
+	if (force) {
+		platform_device_unregister(pdev);
+		driver_unregister(&tis_drv);
+	}
+	else 
+		pnp_unregister_driver(&tis_pnp_driver);
 }
 
 module_init(init_tis);


