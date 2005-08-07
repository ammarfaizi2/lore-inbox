Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751753AbVHGL7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbVHGL7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 07:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbVHGL7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 07:59:04 -0400
Received: from pip251.ish.de ([80.69.98.251]:21329 "EHLO mail01.ish.de")
	by vger.kernel.org with ESMTP id S1751753AbVHGL7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 07:59:03 -0400
Message-ID: <42F5F768.3000204@crypto.rub.de>
Date: Sun, 07 Aug 2005 13:58:32 +0200
From: Marcel Selhorst <selhorst@crypto.rub.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Kylene Jo Hall <kjhall@us.ibm.com>,
       matthieu castet <castet.matthieu@free.fr>,
       Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tpm_infineon: Bugfix in PNPACPI-handling
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-14; AVE: 6.31.1.0; VDF: 6.31.1.62; host: mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

Changelog:

This patch corrects the PNP-handling inside the tpm-driver
and some minor coding style bugs.
Note: the pci-device and pnp-device mixture is currently necessary,
since the used "tpm"-interface requires a pci-dev in order to register
the driver. This will be fixed within the next iterations.

Signed-off-by: Marcel Selhorst <selhorst@crypto.rub.de>
---

diff -pruN linux-2.6.13-rc5/drivers/char/tpm/tpm_infineon.c
linux-2.6.13-rc5.new/drivers/char/tpm/tpm_infineon.c
--- linux-2.6.13-rc5/drivers/char/tpm/tpm_infineon.c	2005-08-06 17:07:55.000000000 +0000
+++ linux-2.6.13-rc5.new/drivers/char/tpm/tpm_infineon.c	2005-08-06
18:56:46.000000000 +0000
@@ -14,7 +14,6 @@
  * License.
  */

-#include <acpi/acpi_bus.h>
 #include <linux/pnp.h>
 #include "tpm.h"

@@ -29,9 +28,10 @@
 #define	TPM_MAX_TRIES		5000
 #define	TPM_INFINEON_DEV_VEN_VALUE	0x15D1

-/* These values will be filled after ACPI-call */
+/* These values will be filled after PnP-call */
 static int TPM_INF_DATA = 0;
 static int TPM_INF_ADDR = 0;
+static int pnp_registered = 0;

 /* TPM header definitions */
 enum infineon_tpm_header {
@@ -356,24 +356,26 @@ static const struct pnp_device_id tpm_pn
 	{"IFX0102", 0},
 	{"", 0}
 };
+MODULE_DEVICE_TABLE(pnp, tpm_pnp_tbl);

-static int __devinit tpm_inf_acpi_probe(struct pnp_dev *dev,
+static int __devinit tpm_inf_pnp_probe(struct pnp_dev *dev,
 					const struct pnp_device_id *dev_id)
 {
-	TPM_INF_ADDR = (pnp_port_start(dev, 0) & 0xff);
-	TPM_INF_DATA = ((TPM_INF_ADDR + 1) & 0xff);
-	tpm_inf.base = pnp_port_start(dev, 1);
-	dev_info(&dev->dev, "Found %s with ID %s\n",
+	if (pnp_port_valid(dev, 0)) {
+	    TPM_INF_ADDR = (pnp_port_start(dev, 0) & 0xff);
+	    TPM_INF_DATA = ((TPM_INF_ADDR + 1) & 0xff);
+	    tpm_inf.base = pnp_port_start(dev, 1);
+	    dev_info(&dev->dev, "Found %s with ID %s\n",
 		 dev->name, dev_id->id);
-	if (!((tpm_inf.base >> 8) & 0xff))
-		tpm_inf.base = 0;
-	return 0;
+	    return 0;
+	} else
+	    return -ENODEV;
 }

 static struct pnp_driver tpm_inf_pnp = {
 	.name = "tpm_inf_pnp",
 	.id_table = tpm_pnp_tbl,
-	.probe = tpm_inf_acpi_probe,
+	.probe = tpm_inf_pnp_probe,
 };

 static int __devinit tpm_inf_probe(struct pci_dev *pci_dev,
@@ -386,19 +388,28 @@ static int __devinit tpm_inf_probe(struc
 	int productid[2];
 	char chipname[20];

-	if (pci_enable_device(pci_dev))
-		return -EIO;
+	rc = pci_enable_device(pci_dev);
+	if (rc)
+	    return rc;

 	dev_info(&pci_dev->dev, "LPC-bus found at 0x%x\n", pci_id->device);

-	/* read IO-ports from ACPI */
-	pnp_register_driver(&tpm_inf_pnp);
-	pnp_unregister_driver(&tpm_inf_pnp);
+	/* read IO-ports from PnP */
+	rc = pnp_register_driver(&tpm_inf_pnp);
+	if (rc < 0) {
+	    dev_err(&pci_dev->dev, "Error %x from pnp_register_driver!\n",rc);
+	    goto error2;
+	}
+	if (!rc) {
+	    dev_info(&pci_dev->dev, "No Infineon TPM found!\n");
+	    goto error;
+	} else
+	    pnp_registered = 1;

 	/* Make sure, we have received valid config ports */
 	if (!TPM_INF_ADDR) {
-		pci_disable_device(pci_dev);
-		return -EIO;
+	    dev_err(&pci_dev->dev, "No valid IO-ports received!\n");
+	    goto error;
 	}

 	/* query chip for its vendor, its version number a.s.o. */
@@ -418,23 +429,21 @@ static int __devinit tpm_inf_probe(struc

 	switch ((productid[0] << 8) | productid[1]) {
 	case 6:
-		sprintf(chipname, " (SLD 9630 TT 1.1)");
+		snprintf(chipname, sizeof(chipname), " (SLD 9630 TT 1.1)");
 		break;
 	case 11:
-		sprintf(chipname, " (SLB 9635 TT 1.2)");
+		snprintf(chipname, sizeof(chipname), " (SLB 9635 TT 1.2)");
 		break;
 	default:
-		sprintf(chipname, " (unknown chip)");
+		snprintf(chipname, sizeof(chipname), " (unknown chip)");
 		break;
 	}
-	chipname[19] = 0;

 	if ((vendorid[0] << 8 | vendorid[1]) == (TPM_INFINEON_DEV_VEN_VALUE)) {

 		if (tpm_inf.base == 0) {
-			dev_err(&pci_dev->dev, "No IO-ports found!\n");
-			pci_disable_device(pci_dev);
-			return -EIO;
+		    dev_err(&pci_dev->dev, "No IO-ports found!\n");
+		    goto error;
 		}
 		/* configure TPM with IO-ports */
 		outb(IOLIMH, TPM_INF_ADDR);
@@ -452,8 +461,7 @@ static int __devinit tpm_inf_probe(struc
 			dev_err(&pci_dev->dev,
 				"Could not set IO-ports to %04x\n",
 				tpm_inf.base);
-			pci_disable_device(pci_dev);
-			return -EIO;
+		    goto error;
 		}

 		/* activate register */
@@ -479,14 +487,16 @@ static int __devinit tpm_inf_probe(struc
 			 productid[0], productid[1], chipname);

 		rc = tpm_register_hardware(pci_dev, &tpm_inf);
-		if (rc < 0) {
-			pci_disable_device(pci_dev);
-			return -ENODEV;
-		}
+		if (rc < 0)
+		    goto error;
 		return 0;
 	} else {
 		dev_info(&pci_dev->dev, "No Infineon TPM found!\n");
+error:
+		pnp_unregister_driver(&tpm_inf_pnp);
+error2:
 		pci_disable_device(pci_dev);
+		pnp_registered = 0;
 		return -ENODEV;
 	}
 }
@@ -521,6 +531,8 @@ static int __init init_inf(void)

 static void __exit cleanup_inf(void)
 {
+	if (pnp_registered)
+	    pnp_unregister_driver(&tpm_inf_pnp);	
 	pci_unregister_driver(&inf_pci_driver);
 }

