Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVJ0L1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVJ0L1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 07:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVJ0L1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 07:27:54 -0400
Received: from pip252.ish.de ([80.69.98.252]:28440 "EHLO mail01.ish.de")
	by vger.kernel.org with ESMTP id S1750726AbVJ0L1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 07:27:54 -0400
Message-ID: <4360B889.1010502@crypto.rub.de>
Date: Thu, 27 Oct 2005 13:22:49 +0200
From: Marcel Selhorst <selhorst@crypto.rub.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051026)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: matthieu castet <castet.matthieu@free.fr>, Andrew Morton <akpm@osdl.org>,
       Kylene Jo Hall <kjhall@us.ibm.com>
Subject: Re: [PATCH] Infineon TPM: move infineon driver off pci_dev
References: <435FB8A5.803@crypto.rub.de> <435FBFC4.5060508@free.fr>
In-Reply-To: <435FBFC4.5060508@free.fr>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-14; AVE: 6.32.0.8; VDF: 6.32.0.119; host: mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

the following patch moves the Infineon TPM driver off pci device
and makes it a pure pnp-driver. It was tested with IFX0101 and
IFX0102 and is now based on the new tpm patchset (1 to 5) from Kylene
Hall submitted two days ago. It now also includes pnp-port validation
and region requesting.

Best regards,

Marcel Selhorst

Signed-off-by: Marcel Selhorst <selhorst@crypto.rub.de>
---

diff -pruN linux-2.6.14-rc5.ibm/drivers/char/tpm/tpm_infineon.c
linux-2.6.14-rc5.infineon-v1.6/drivers/char/tpm/tpm_infineon.c
--- linux-2.6.14-rc5.ibm/drivers/char/tpm/tpm_infineon.c	2005-10-27
13:28:54.000000000 +0200
+++ linux-2.6.14-rc5.infineon-v1.6/drivers/char/tpm/tpm_infineon.c	2005-10-27
13:25:19.000000000 +0200
@@ -5,6 +5,7 @@
  * Specifications at www.trustedcomputinggroup.org
  *
  * Copyright (C) 2005, Marcel Selhorst <selhorst@crypto.rub.de>
+ * Sirrix AG - security technologies, http://www.sirrix.com and
  * Applied Data Security Group, Ruhr-University Bochum, Germany
  * Project-Homepage: http://www.prosec.rub.de/tpm
  *
@@ -31,7 +32,8 @@
 /* These values will be filled after PnP-call */
 static int TPM_INF_DATA = 0;
 static int TPM_INF_ADDR = 0;
-static int pnp_registered = 0;
+static int TPM_INF_BASE = 0;
+static int TPM_INF_PORT_LEN = 0;

 /* TPM header definitions */
 enum infineon_tpm_header {
@@ -143,11 +145,9 @@ static int wait(struct tpm_chip *chip, i
 	}
 	if (i == TPM_MAX_TRIES) {	/* timeout occurs */
 		if (wait_for_bit == STAT_XFE)
-			dev_err(chip->dev,
-				"Timeout in wait(STAT_XFE)\n");
+			dev_err(chip->dev, "Timeout in wait(STAT_XFE)\n");
 		if (wait_for_bit == STAT_RDA)
-			dev_err(chip->dev,
-				"Timeout in wait(STAT_RDA)\n");
+			dev_err(chip->dev, "Timeout in wait(STAT_RDA)\n");
 		return -EIO;
 	}
 	return 0;
@@ -221,8 +221,7 @@ recv_begin:
 		}

 		if ((size == 0x6D00) && (buf[1] == 0x80)) {
-			dev_err(chip->dev,
-				"Error handling on vendor layer!\n");
+			dev_err(chip->dev, "Error handling on vendor layer!\n");
 			return -EIO;
 		}

@@ -318,7 +317,7 @@ static void tpm_inf_cancel(struct tpm_ch

 static u8 tpm_inf_status(struct tpm_chip *chip)
 {
-	return inb(chip->vendor->base + 1);
+	return inb(chip->vendor->base + STAT);
 }

 static DEVICE_ATTR(pubek, S_IRUGO, tpm_show_pubek, NULL);
@@ -362,30 +361,11 @@ static const struct pnp_device_id tpm_pn
 	{"IFX0102", 0},
 	{"", 0}
 };
+
 MODULE_DEVICE_TABLE(pnp, tpm_pnp_tbl);

 static int __devinit tpm_inf_pnp_probe(struct pnp_dev *dev,
-					const struct pnp_device_id *dev_id)
-{
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
+				       const struct pnp_device_id *dev_id)
 {
 	int rc = 0;
 	u8 iol, ioh;
@@ -394,30 +374,28 @@ static int __devinit tpm_inf_probe(struc
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
+	/* read IO-ports through PnP */
+	if (pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) &&
+	    !(pnp_port_flags(dev, 0) & IORESOURCE_DISABLED)) {
+		TPM_INF_ADDR = pnp_port_start(dev, 0);
+		TPM_INF_DATA = (TPM_INF_ADDR + 1);
+		TPM_INF_BASE = pnp_port_start(dev, 1);
+		TPM_INF_PORT_LEN = pnp_port_len(dev, 1);
+		if (!TPM_INF_PORT_LEN)
+			return -EINVAL;
+		dev_info(&dev->dev, "Found %s with ID %s\n",
+			 dev->name, dev_id->id);
+		if (!((TPM_INF_BASE >> 8) & 0xff))
+			return -EINVAL;
+		/* publish my base address and request region */
+		tpm_inf.base = TPM_INF_BASE;
+		if (request_region
+		    (tpm_inf.base, TPM_INF_PORT_LEN, "tpm_infineon0") == NULL) {
+			release_region(tpm_inf.base, TPM_INF_PORT_LEN);
+			return -EINVAL;
+		}
 	} else {
-		pnp_registered = 1;
-	}
-
-	/* Make sure, we have received valid config ports */
-	if (!TPM_INF_ADDR) {
-		dev_err(&pci_dev->dev, "No valid IO-ports received!\n");
-		goto error;
+		return -EINVAL;
 	}

 	/* query chip for its vendor, its version number a.s.o. */
@@ -449,10 +427,6 @@ static int __devinit tpm_inf_probe(struc

 	if ((vendorid[0] << 8 | vendorid[1]) == (TPM_INFINEON_DEV_VEN_VALUE)) {

-		if (tpm_inf.base == 0) {
-			dev_err(&pci_dev->dev, "No IO-ports found!\n");
-			goto error;
-		}
 		/* configure TPM with IO-ports */
 		outb(IOLIMH, TPM_INF_ADDR);
 		outb(((tpm_inf.base >> 8) & 0xff), TPM_INF_DATA);
@@ -466,10 +440,11 @@ static int __devinit tpm_inf_probe(struc
 		iol = inb(TPM_INF_DATA);

 		if ((ioh << 8 | iol) != tpm_inf.base) {
-			dev_err(&pci_dev->dev,
+			dev_err(&dev->dev,
 				"Could not set IO-ports to %04x\n",
 				tpm_inf.base);
-			goto error;
+			release_region(tpm_inf.base, TPM_INF_PORT_LEN);
+			return -EIO;
 		}

 		/* activate register */
@@ -481,7 +456,7 @@ static int __devinit tpm_inf_probe(struc
 		outb(RESET_LP_IRQC_DISABLE, tpm_inf.base + CMD);

 		/* Finally, we're done, print some infos */
-		dev_info(&pci_dev->dev, "TPM found: "
+		dev_info(&dev->dev, "TPM found: "
 			 "config base 0x%x, "
 			 "io base 0x%x, "
 			 "chip version %02x%02x, "
@@ -489,67 +464,51 @@ static int __devinit tpm_inf_probe(struc
 			 "product id %02x%02x"
 			 "%s\n",
 			 TPM_INF_ADDR,
-			 tpm_inf.base,
+			 TPM_INF_BASE,
 			 version[0], version[1],
 			 vendorid[0], vendorid[1],
 			 productid[0], productid[1], chipname);

-		rc = tpm_register_hardware(&pci_dev->dev, &tpm_inf);
-		if (rc < 0)
-			goto error;
+		rc = tpm_register_hardware(&dev->dev, &tpm_inf);
+		if (rc < 0) {
+			release_region(tpm_inf.base, TPM_INF_PORT_LEN);
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
+static __devexit void tpm_inf_pnp_remove(struct pnp_dev *dev)
 {
-	struct tpm_chip* chip = pci_get_drvdata(pci_dev);
-	
-	if( chip )
+	struct tpm_chip *chip = pnp_get_drvdata(dev);
+
+	if (chip) {
+		release_region(chip->vendor->base, TPM_INF_PORT_LEN);
 		tpm_remove_hardware(chip->dev);
+	}
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
+	.driver.owner = THIS_MODULE,
+	.id_table = tpm_pnp_tbl,
+	.probe = tpm_inf_pnp_probe,
+	.remove = tpm_inf_pnp_remove,
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
@@ -557,5 +516,5 @@ module_exit(cleanup_inf);

 MODULE_AUTHOR("Marcel Selhorst <selhorst@crypto.rub.de>");
 MODULE_DESCRIPTION("Driver for Infineon TPM SLD 9630 TT 1.1 / SLB 9635 TT 1.2");
-MODULE_VERSION("1.5");
+MODULE_VERSION("1.6");
 MODULE_LICENSE("GPL");
