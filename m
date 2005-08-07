Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752339AbVHGQyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbVHGQyL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 12:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbVHGQyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 12:54:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752338AbVHGQyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 12:54:10 -0400
Date: Sun, 7 Aug 2005 09:52:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcel Selhorst <selhorst@crypto.rub.de>
Cc: torvalds@osdl.org, kjhall@us.ibm.com, castet.matthieu@free.fr,
       alex.williamson@hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_infineon: Bugfix in PNPACPI-handling
Message-Id: <20050807095232.1d7c8384.akpm@osdl.org>
In-Reply-To: <42F5F768.3000204@crypto.rub.de>
References: <42F5F768.3000204@crypto.rub.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Selhorst <selhorst@crypto.rub.de> wrote:
>
> 
>  This patch corrects the PNP-handling inside the tpm-driver
>  and some minor coding style bugs.

But the patch adds lots of new coding style bugs!

> ...
>  @@ -356,24 +356,26 @@ static const struct pnp_device_id tpm_pn
>   	{"IFX0102", 0},
>   	{"", 0}
>   };
>  +MODULE_DEVICE_TABLE(pnp, tpm_pnp_tbl);
> 
>  -static int __devinit tpm_inf_acpi_probe(struct pnp_dev *dev,
>  +static int __devinit tpm_inf_pnp_probe(struct pnp_dev *dev,
>   					const struct pnp_device_id *dev_id)
>   {
>  -	TPM_INF_ADDR = (pnp_port_start(dev, 0) & 0xff);
>  -	TPM_INF_DATA = ((TPM_INF_ADDR + 1) & 0xff);
>  -	tpm_inf.base = pnp_port_start(dev, 1);
>  -	dev_info(&dev->dev, "Found %s with ID %s\n",
>  +	if (pnp_port_valid(dev, 0)) {
>  +	    TPM_INF_ADDR = (pnp_port_start(dev, 0) & 0xff);
>  +	    TPM_INF_DATA = ((TPM_INF_ADDR + 1) & 0xff);
>  +	    tpm_inf.base = pnp_port_start(dev, 1);
>  +	    dev_info(&dev->dev, "Found %s with ID %s\n",
>   		 dev->name, dev_id->id);

We use hard tabs for indentation at eight columns each, not four-spaces.

Fixed-up version:


diff -puN drivers/char/tpm/tpm_infineon.c~tpm_infineon-bugfix-in-pnpacpi-handling drivers/char/tpm/tpm_infineon.c
--- devel/drivers/char/tpm/tpm_infineon.c~tpm_infineon-bugfix-in-pnpacpi-handling	2005-08-07 09:50:06.000000000 -0700
+++ devel-akpm/drivers/char/tpm/tpm_infineon.c	2005-08-07 09:51:50.000000000 -0700
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
-		 dev->name, dev_id->id);
-	if (!((tpm_inf.base >> 8) & 0xff))
-		tpm_inf.base = 0;
-	return 0;
+	if (pnp_port_valid(dev, 0)) {
+		TPM_INF_ADDR = (pnp_port_start(dev, 0) & 0xff);
+		TPM_INF_DATA = ((TPM_INF_ADDR + 1) & 0xff);
+		tpm_inf.base = pnp_port_start(dev, 1);
+		dev_info(&dev->dev, "Found %s with ID %s\n",
+		dev->name, dev_id->id);
+		return 0;
+	}
+	return -ENODEV;
 }
 
 static struct pnp_driver tpm_inf_pnp = {
 	.name = "tpm_inf_pnp",
 	.id_table = tpm_pnp_tbl,
-	.probe = tpm_inf_acpi_probe,
+	.probe = tpm_inf_pnp_probe,
 };
 
 static int __devinit tpm_inf_probe(struct pci_dev *pci_dev,
@@ -386,19 +388,30 @@ static int __devinit tpm_inf_probe(struc
 	int productid[2];
 	char chipname[20];
 
-	if (pci_enable_device(pci_dev))
-		return -EIO;
+	rc = pci_enable_device(pci_dev);
+	if (rc)
+		return rc;
 
 	dev_info(&pci_dev->dev, "LPC-bus found at 0x%x\n", pci_id->device);
 
-	/* read IO-ports from ACPI */
-	pnp_register_driver(&tpm_inf_pnp);
-	pnp_unregister_driver(&tpm_inf_pnp);
+	/* read IO-ports from PnP */
+	rc = pnp_register_driver(&tpm_inf_pnp);
+	if (rc < 0) {
+		dev_err(&pci_dev->dev,
+			"Error %x from pnp_register_driver!\n",rc);
+		goto error2;
+	}
+	if (!rc) {
+		dev_info(&pci_dev->dev, "No Infineon TPM found!\n");
+		goto error;
+	} else {
+		pnp_registered = 1;
+	}
 
 	/* Make sure, we have received valid config ports */
 	if (!TPM_INF_ADDR) {
-		pci_disable_device(pci_dev);
-		return -EIO;
+		dev_err(&pci_dev->dev, "No valid IO-ports received!\n");
+		goto error;
 	}
 
 	/* query chip for its vendor, its version number a.s.o. */
@@ -418,23 +431,21 @@ static int __devinit tpm_inf_probe(struc
 
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
 			dev_err(&pci_dev->dev, "No IO-ports found!\n");
-			pci_disable_device(pci_dev);
-			return -EIO;
+			goto error;
 		}
 		/* configure TPM with IO-ports */
 		outb(IOLIMH, TPM_INF_ADDR);
@@ -452,8 +463,7 @@ static int __devinit tpm_inf_probe(struc
 			dev_err(&pci_dev->dev,
 				"Could not set IO-ports to %04x\n",
 				tpm_inf.base);
-			pci_disable_device(pci_dev);
-			return -EIO;
+			goto error;
 		}
 
 		/* activate register */
@@ -479,14 +489,16 @@ static int __devinit tpm_inf_probe(struc
 			 productid[0], productid[1], chipname);
 
 		rc = tpm_register_hardware(pci_dev, &tpm_inf);
-		if (rc < 0) {
-			pci_disable_device(pci_dev);
-			return -ENODEV;
-		}
+		if (rc < 0)
+			goto error;
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
@@ -521,6 +533,8 @@ static int __init init_inf(void)
 
 static void __exit cleanup_inf(void)
 {
+	if (pnp_registered)
+		pnp_unregister_driver(&tpm_inf_pnp);
 	pci_unregister_driver(&inf_pci_driver);
 }
 
_

