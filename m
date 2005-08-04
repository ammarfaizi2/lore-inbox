Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbVHDKbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVHDKbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 06:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVHDKbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 06:31:09 -0400
Received: from pip252.ish.de ([80.69.98.252]:30164 "EHLO mail01.ish.de")
	by vger.kernel.org with ESMTP id S262463AbVHDKbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 06:31:07 -0400
Message-ID: <42F1EE69.4000108@crypto.rub.de>
Date: Thu, 04 Aug 2005 12:31:05 +0200
From: Marcel Selhorst <selhorst@crypto.rub.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Kylene Jo Hall <kjhall@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] tpm_infineon: Support for new TPM 1.2 and PNPACPI
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-14; AVE: 6.31.1.0; VDF: 6.31.1.54; host: mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML,

Changelog:
This patch includes support for the new Infineon Trusted Platform Module
SLB 9635 TT 1.2 and does further include ACPI-support for both chip versions
(SLD 9630 TT 1.1 and SLB9635 TT 1.2). Since the ioports and configuration
registers are not correctly set on some machines, the configuration is now
done via PNPACPI, which reads out the correct values out of the DSDT-table.
Note that you have to have CONFIG_PNP, CONFIG_ACPI_BUS and CONFIG_PNPACPI
enabled to run this driver (assuming that mainbaords including a TPM do have
the need for ACPI anyway).

Signed-off-by: Marcel Selhorst <selhorst@crypto.rub.de>
---

diff -pruN linux-2.6.13-rc4-mm1/drivers/char/tpm/Kconfig
linux-new/drivers/char/tpm/Kconfig
--- linux-2.6.13-rc4-mm1/drivers/char/tpm/Kconfig	2005-08-03 20:07:34.000000000 +0200
+++ linux-new/drivers/char/tpm/Kconfig	2005-08-04 10:39:08.000000000 +0200
@@ -17,6 +17,8 @@ config TCG_TPM
 	  obtained at: <http://sourceforge.net/projects/trousers>.  To
 	  compile this driver as a module, choose M here; the module
 	  will be called tpm. If unsure, say N.
+	  Note: For more TPM drivers enable CONFIG_PNP, CONFIG_ACPI_BUS
+	  and CONFIG_PNPACPI.

 config TCG_NSC
 	tristate "National Semiconductor TPM Interface"
@@ -36,12 +38,13 @@ config TCG_ATMEL
 	  as a module, choose M here; the module will be called tpm_atmel.

 config TCG_INFINEON
-	tristate "Infineon Technologies SLD 9630 TPM Interface"
-	depends on TCG_TPM
+	tristate "Infineon Technologies TPM Interface"
+	depends on TCG_TPM && PNPACPI
 	---help---
-	  If you have a TPM security chip from Infineon Technologies
-	  say Yes and it will be accessible from within Linux.  To
-	  compile this driver as a module, choose M here; the module
+	  If you have a TPM security chip from Infineon Technologies
+	  (either SLD 9630 TT 1.1 or SLB 9635 TT 1.2) say Yes and it
+	  will be accessible from within Linux.
+	  To compile this driver as a module, choose M here; the module
 	  will be called tpm_infineon.
 	  Further information on this driver and the supported hardware
 	  can be found at http://www.prosec.rub.de/tpm
diff -pruN linux-2.6.13-rc4-mm1/drivers/char/tpm/tpm_infineon.c
linux-new/drivers/char/tpm/tpm_infineon.c
--- linux-2.6.13-rc4-mm1/drivers/char/tpm/tpm_infineon.c	2005-08-03
20:07:34.000000000 +0200
+++ linux-new/drivers/char/tpm/tpm_infineon.c	2005-08-04 12:19:47.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * Description:
  * Device Driver for the Infineon Technologies
- * SLD 9630 TT Trusted Platform Module
+ * SLD 9630 TT 1.1 and SLB 9635 TT 1.2 Trusted Platform Module
  * Specifications at www.trustedcomputinggroup.org
  *
  * Copyright (C) 2005, Marcel Selhorst <selhorst@crypto.rub.de>
@@ -12,9 +12,10 @@
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation, version 2 of the
  * License.
- *
  */

+#include <acpi/acpi_bus.h>
+#include <linux/pnp.h>
 #include "tpm.h"

 /* Infineon specific definitions */
@@ -26,8 +27,11 @@
 #define	TPM_MSLEEP_TIME 	3
 /* gives number of max. msleep()-calls before throwing timeout */
 #define	TPM_MAX_TRIES		5000
-#define	TCPA_INFINEON_DEV_VEN_VALUE	0x15D1
-#define	TPM_DATA 			(TPM_ADDR + 1) & 0xff
+#define	TPM_INFINEON_DEV_VEN_VALUE	0x15D1
+
+/* These values will be filled after ACPI-call */
+static int TPM_INF_DATA = 0;
+static int TPM_INF_ADDR = 0;

 /* TPM header definitions */
 enum infineon_tpm_header {
@@ -305,9 +309,10 @@ static int tpm_inf_send(struct tpm_chip

 static void tpm_inf_cancel(struct tpm_chip *chip)
 {
-	/* Nothing yet!
-	   This has something to do with the internal functions
-	   of the TPM. Abort isn't really necessary...
+	/*
+	   Since we are using the legacy mode to communicate
+	   with the TPM, we have no cancel functions, but have
+	   a workaround for interrupting the TPM through WTX.
 	 */
 }

@@ -345,6 +350,32 @@ static struct tpm_vendor_specific tpm_in
 	.miscdev = {.fops = &inf_ops,},
 };

+static const struct pnp_device_id tpm_pnp_tbl[] = {
+	/* Infineon TPMs */
+	{"IFX0101", 0},
+	{"IFX0102", 0},
+	{"", 0}
+};
+
+static int __devinit tpm_inf_acpi_probe(struct pnp_dev *dev,
+					const struct pnp_device_id *dev_id)
+{
+	TPM_INF_ADDR = (pnp_port_start(dev, 0) & 0xff);
+	TPM_INF_DATA = ((TPM_INF_ADDR + 1) & 0xff);
+	tpm_inf.base = pnp_port_start(dev, 1);
+	dev_info(&dev->dev, "Found %s with ID %s\n",
+		 dev->name, dev_id->id);
+	if (!((tpm_inf.base >> 8) & 0xff))
+		tpm_inf.base = 0;
+	return 0;
+}
+
+static struct pnp_driver tpm_inf_pnp = {
+	.name = "tpm_inf_pnp",
+	.id_table = tpm_pnp_tbl,
+	.probe = tpm_inf_acpi_probe,
+};
+
 static int __devinit tpm_inf_probe(struct pci_dev *pci_dev,
 				   const struct pci_device_id *pci_id)
 {
@@ -353,64 +384,99 @@ static int __devinit tpm_inf_probe(struc
 	int vendorid[2];
 	int version[2];
 	int productid[2];
+	char chipname[20];

 	if (pci_enable_device(pci_dev))
 		return -EIO;

 	dev_info(&pci_dev->dev, "LPC-bus found at 0x%x\n", pci_id->device);

+	/* read IO-ports from ACPI */
+	pnp_register_driver(&tpm_inf_pnp);
+	pnp_unregister_driver(&tpm_inf_pnp);
+
+	/* Make sure, we have received valid config ports */
+	if (!TPM_INF_ADDR) {
+		pci_disable_device(pci_dev);
+		return -EIO;
+	}
+
 	/* query chip for its vendor, its version number a.s.o. */
-	outb(ENABLE_REGISTER_PAIR, TPM_ADDR);
-	outb(IDVENL, TPM_ADDR);
-	vendorid[1] = inb(TPM_DATA);
-	outb(IDVENH, TPM_ADDR);
-	vendorid[0] = inb(TPM_DATA);
-	outb(IDPDL, TPM_ADDR);
-	productid[1] = inb(TPM_DATA);
-	outb(IDPDH, TPM_ADDR);
-	productid[0] = inb(TPM_DATA);
-	outb(CHIP_ID1, TPM_ADDR);
-	version[1] = inb(TPM_DATA);
-	outb(CHIP_ID2, TPM_ADDR);
-	version[0] = inb(TPM_DATA);
-
-	if ((vendorid[0] << 8 | vendorid[1]) == (TCPA_INFINEON_DEV_VEN_VALUE)) {
-
-		/* read IO-ports from TPM */
-		outb(IOLIMH, TPM_ADDR);
-		ioh = inb(TPM_DATA);
-		outb(IOLIML, TPM_ADDR);
-		iol = inb(TPM_DATA);
-		tpm_inf.base = (ioh << 8) | iol;
+	outb(ENABLE_REGISTER_PAIR, TPM_INF_ADDR);
+	outb(IDVENL, TPM_INF_ADDR);
+	vendorid[1] = inb(TPM_INF_DATA);
+	outb(IDVENH, TPM_INF_ADDR);
+	vendorid[0] = inb(TPM_INF_DATA);
+	outb(IDPDL, TPM_INF_ADDR);
+	productid[1] = inb(TPM_INF_DATA);
+	outb(IDPDH, TPM_INF_ADDR);
+	productid[0] = inb(TPM_INF_DATA);
+	outb(CHIP_ID1, TPM_INF_ADDR);
+	version[1] = inb(TPM_INF_DATA);
+	outb(CHIP_ID2, TPM_INF_ADDR);
+	version[0] = inb(TPM_INF_DATA);
+
+	switch ((productid[0] << 8) | productid[1]) {
+	case 6:
+		sprintf(chipname, " (SLD 9630 TT 1.1)");
+		break;
+	case 11:
+		sprintf(chipname, " (SLB 9635 TT 1.2)");
+		break;
+	default:
+		sprintf(chipname, " (unknown chip)");
+		break;
+	}
+	chipname[19] = 0;
+
+	if ((vendorid[0] << 8 | vendorid[1]) == (TPM_INFINEON_DEV_VEN_VALUE)) {

 		if (tpm_inf.base == 0) {
-			dev_err(&pci_dev->dev, "No IO-ports set!\n");
+			dev_err(&pci_dev->dev, "No IO-ports found!\n");
 			pci_disable_device(pci_dev);
-			return -ENODEV;
+			return -EIO;
+		}
+		/* configure TPM with IO-ports */
+		outb(IOLIMH, TPM_INF_ADDR);
+		outb(((tpm_inf.base >> 8) & 0xff), TPM_INF_DATA);
+		outb(IOLIML, TPM_INF_ADDR);
+		outb((tpm_inf.base & 0xff), TPM_INF_DATA);
+
+		/* control if IO-ports are set correctly */
+		outb(IOLIMH, TPM_INF_ADDR);
+		ioh = inb(TPM_INF_DATA);
+		outb(IOLIML, TPM_INF_ADDR);
+		iol = inb(TPM_INF_DATA);
+
+		if ((ioh << 8 | iol) != tpm_inf.base) {
+			dev_err(&pci_dev->dev,
+				"Could not set IO-ports to %04x\n",
+				tpm_inf.base);
+			pci_disable_device(pci_dev);
+			return -EIO;
 		}

 		/* activate register */
-		outb(TPM_DAR, TPM_ADDR);
-		outb(0x01, TPM_DATA);
-		outb(DISABLE_REGISTER_PAIR, TPM_ADDR);
+		outb(TPM_DAR, TPM_INF_ADDR);
+		outb(0x01, TPM_INF_DATA);
+		outb(DISABLE_REGISTER_PAIR, TPM_INF_ADDR);

 		/* disable RESET, LP and IRQC */
 		outb(RESET_LP_IRQC_DISABLE, tpm_inf.base + CMD);

 		/* Finally, we're done, print some infos */
 		dev_info(&pci_dev->dev, "TPM found: "
+			 "config base 0x%x, "
 			 "io base 0x%x, "
 			 "chip version %02x%02x, "
 			 "vendor id %x%x (Infineon), "
 			 "product id %02x%02x"
 			 "%s\n",
+			 TPM_INF_ADDR,
 			 tpm_inf.base,
 			 version[0], version[1],
 			 vendorid[0], vendorid[1],
-			 productid[0], productid[1], ((productid[0] == 0)
-						      && (productid[1] ==
-							  6)) ?
-			 " (SLD 9630 TT 1.1)" : "");
+			 productid[0], productid[1], chipname);

 		rc = tpm_register_hardware(pci_dev, &tpm_inf);
 		if (rc < 0) {
@@ -462,6 +528,6 @@ module_init(init_inf);
 module_exit(cleanup_inf);

 MODULE_AUTHOR("Marcel Selhorst <selhorst@crypto.rub.de>");
-MODULE_DESCRIPTION("Driver for Infineon TPM SLD 9630 TT");
-MODULE_VERSION("1.4");
+MODULE_DESCRIPTION("Driver for Infineon TPM SLD 9630 TT 1.1 / SLB 9635 TT 1.2");
+MODULE_VERSION("1.5");
 MODULE_LICENSE("GPL");


