Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVJYPWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVJYPWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 11:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVJYPVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 11:21:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:14311 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932185AbVJYPVt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 11:21:49 -0400
Subject: [PATCH 6 of 6] tpm: move infineon driver off pci_dev
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Marcel Selhorst <selhorst@crypto.rub.de>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 10:22:18 -0500
Message-Id: <1130253738.4839.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the infineon driver from a pci driver to a pnp
driver.  This is possible because the infineon chip, unlike the other
1.1 chips, is supporting the 1.2 concepts of registering the device in
ACPI.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---

--- linux-2.6.14-rc4/drivers/char/tpm/tpm_infineon.c	2005-10-19 17:03:52.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm_infineon.c	2005-10-21 13:07:24.000000000 -0500
@@ -14,6 +14,7 @@
  * License.
  */
 
+#include <acpi/acpi_bus.h>
 #include <linux/pnp.h>
 #include "tpm.h"
 
@@ -28,10 +29,9 @@
 #define	TPM_MAX_TRIES		5000
 #define	TPM_INFINEON_DEV_VEN_VALUE	0x15D1
 
-/* These values will be filled after PnP-call */
+/* These values will be filled after ACPI-call */
 static int TPM_INF_DATA = 0;
 static int TPM_INF_ADDR = 0;
-static int pnp_registered = 0;
 
 /* TPM header definitions */
 enum infineon_tpm_header {
@@ -362,31 +362,10 @@ static const struct pnp_device_id tpm_pn
 	{"IFX0102", 0},
 	{"", 0}
 };
-MODULE_DEVICE_TABLE(pnp, tpm_pnp_tbl);
 
-static int __devinit tpm_inf_pnp_probe(struct pnp_dev *dev,
+static int __devinit tpm_inf_acpi_probe(struct pnp_dev *dev,
 					const struct pnp_device_id *dev_id)
 {
-	if (pnp_port_valid(dev, 0)) {
-		TPM_INF_ADDR = (pnp_port_start(dev, 0) & 0xff);
-		TPM_INF_DATA = ((TPM_INF_ADDR + 1) & 0xff);
-		tpm_inf.base = pnp_port_start(dev, 1);
-		dev_info(&dev->dev, "Found %s with ID %s\n",
-		dev->name, dev_id->id);
-		return 0;
-	}
-	return -ENODEV;
-}
-
-static struct pnp_driver tpm_inf_pnp = {
-	.name = "tpm_inf_pnp",
-	.id_table = tpm_pnp_tbl,
-	.probe = tpm_inf_pnp_probe,
-};
-
-static int __devinit tpm_inf_probe(struct pci_dev *pci_dev,
-				   const struct pci_device_id *pci_id)
-{
 	int rc = 0;
 	u8 iol, ioh;
 	int vendorid[2];
@@ -394,30 +373,19 @@ static int __devinit tpm_inf_probe(struc
 	int productid[2];
 	char chipname[20];
 
-	rc = pci_enable_device(pci_dev);
-	if (rc)
-		return rc;
-
-	dev_info(&pci_dev->dev, "LPC-bus found at 0x%x\n", pci_id->device);
-
-	/* read IO-ports from PnP */
-	rc = pnp_register_driver(&tpm_inf_pnp);
-	if (rc < 0) {
-		dev_err(&pci_dev->dev,
-			"Error %x from pnp_register_driver!\n",rc);
-		goto error2;
-	}
-	if (!rc) {
-		dev_info(&pci_dev->dev, "No Infineon TPM found!\n");
-		goto error;
-	} else {
-		pnp_registered = 1;
-	}
+
+	/* read IO-ports from ACPI */
+	TPM_INF_ADDR = (pnp_port_start(dev, 0) & 0xff);
+	TPM_INF_DATA = ((TPM_INF_ADDR + 1) & 0xff);
+	tpm_inf.base = pnp_port_start(dev, 1);
+	dev_info(&dev->dev, "Found %s with ID %s\n",
+		 dev->name, dev_id->id);
+	if (!((tpm_inf.base >> 8) & 0xff))
+		tpm_inf.base = 0;
 
 	/* Make sure, we have received valid config ports */
 	if (!TPM_INF_ADDR) {
-		dev_err(&pci_dev->dev, "No valid IO-ports received!\n");
-		goto error;
+		return -EIO;
 	}
 
 	/* query chip for its vendor, its version number a.s.o. */
@@ -437,21 +405,22 @@ static int __devinit tpm_inf_probe(struc
 
 	switch ((productid[0] << 8) | productid[1]) {
 	case 6:
-		snprintf(chipname, sizeof(chipname), " (SLD 9630 TT 1.1)");
+		sprintf(chipname, " (SLD 9630 TT 1.1)");
 		break;
 	case 11:
-		snprintf(chipname, sizeof(chipname), " (SLB 9635 TT 1.2)");
+		sprintf(chipname, " (SLB 9635 TT 1.2)");
 		break;
 	default:
-		snprintf(chipname, sizeof(chipname), " (unknown chip)");
+		sprintf(chipname, " (unknown chip)");
 		break;
 	}
+	chipname[19] = 0;
 
 	if ((vendorid[0] << 8 | vendorid[1]) == (TPM_INFINEON_DEV_VEN_VALUE)) {
 
 		if (tpm_inf.base == 0) {
-			dev_err(&pci_dev->dev, "No IO-ports found!\n");
-			goto error;
+			dev_err(&dev->dev, "No IO-ports found!\n");
+			return -EIO;
 		}
 		/* configure TPM with IO-ports */
 		outb(IOLIMH, TPM_INF_ADDR);
@@ -466,10 +435,10 @@ static int __devinit tpm_inf_probe(struc
 		iol = inb(TPM_INF_DATA);
 
 		if ((ioh << 8 | iol) != tpm_inf.base) {
-			dev_err(&pci_dev->dev,
+			dev_err(&dev->dev,
 				"Could not set IO-ports to %04x\n",
 				tpm_inf.base);
-			goto error;
+			return -EIO;
 		}
 
 		/* activate register */
@@ -481,7 +450,7 @@ static int __devinit tpm_inf_probe(struc
 		outb(RESET_LP_IRQC_DISABLE, tpm_inf.base + CMD);
 
 		/* Finally, we're done, print some infos */
-		dev_info(&pci_dev->dev, "TPM found: "
+		dev_info(&dev->dev, "TPM found: "
 			 "config base 0x%x, "
 			 "io base 0x%x, "
 			 "chip version %02x%02x, "
@@ -494,62 +463,42 @@ static int __devinit tpm_inf_probe(struc
 			 vendorid[0], vendorid[1],
 			 productid[0], productid[1], chipname);
 
-		rc = tpm_register_hardware(&pci_dev->dev, &tpm_inf);
-		if (rc < 0)
-			goto error;
+		rc = tpm_register_hardware(&dev->dev, &tpm_inf);
+		if (rc < 0) {
+			return -ENODEV;
+		}
 		return 0;
 	} else {
-		dev_info(&pci_dev->dev, "No Infineon TPM found!\n");
-error:
-		pnp_unregister_driver(&tpm_inf_pnp);
-error2:
-		pci_disable_device(pci_dev);
-		pnp_registered = 0;
+		dev_info(&dev->dev, "No Infineon TPM found!\n");
 		return -ENODEV;
 	}
 }
 
-static __devexit void tpm_inf_remove(struct pci_dev* pci_dev) 
+static __devexit void tpm_inf_remove(struct pnp_dev* dev) 
 {
-	struct tpm_chip* chip = pci_get_drvdata(pci_dev);
+	struct tpm_chip* chip = pnp_get_drvdata(dev);
 	
 	if( chip )
 		tpm_remove_hardware(chip->dev);
 }
 
-static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2)},
-	{0,}
-};
-
-MODULE_DEVICE_TABLE(pci, tpm_pci_tbl);
-
-static struct pci_driver inf_pci_driver = {
-	.name = "tpm_inf",
-	.id_table = tpm_pci_tbl,
-	.probe = tpm_inf_probe,
-	.remove = __devexit_p(tpm_inf_remove),
-	.suspend = tpm_pm_suspend,
-	.resume = tpm_pm_resume,
+static struct pnp_driver tpm_inf_pnp = {
+	.name = "tpm_inf_pnp",
+	.id_table = tpm_pnp_tbl,
+	.probe = tpm_inf_acpi_probe,
+	.remove = tpm_inf_remove,
+	.driver.suspend = tpm_pm_suspend,
+	.driver.resume = tpm_pm_resume,
 };
 
 static int __init init_inf(void)
 {
-	return pci_register_driver(&inf_pci_driver);
+	return pnp_register_driver(&tpm_inf_pnp);
 }
 
 static void __exit cleanup_inf(void)
 {
-	if (pnp_registered)
-		pnp_unregister_driver(&tpm_inf_pnp);
-	pci_unregister_driver(&inf_pci_driver);
+	pnp_unregister_driver(&tpm_inf_pnp);
 }
 
 module_init(init_inf);


