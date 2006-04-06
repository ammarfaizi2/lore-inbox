Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWDFLC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWDFLC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 07:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWDFLC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 07:02:58 -0400
Received: from pip252.ish.de ([80.69.98.252]:40832 "EHLO mail01.ish.de")
	by vger.kernel.org with ESMTP id S1751039AbWDFLC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 07:02:57 -0400
Message-ID: <4434F551.8000905@crypto.rub.de>
Date: Thu, 06 Apr 2006 13:02:41 +0200
From: Marcel Selhorst <selhorst@crypto.rub.de>
User-Agent: Mail/News 1.5 (X11/20060401)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: kjhall@us.ibm.com, akpm@osdl.org
Subject: [PATCH] tpm: tpm_infineon updated to latest interface changes
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-14; AVE: 6.34.0.24; VDF: 6.34.0.151; host: mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear LKML,

this patch applies the latest changes in the TPM interface
(as posted by Kylene Hall yesterday - see below) to the Infineon TPM-driver.

> Kylene Jo Hall wrote:
> To assist with chip management and better support the possibility of
> having multiple TPMs in the system of the same kind, the struct
> tpm_vendor_specific member of the tpm_chip was changed from a pointer to
> an instance.  This patch changes that declaration and fixes up all
> accesses to the structure member except in tpm_infineon which is coming
> in a patch from Marcel Selhorst.
> 
> Changes in the 1.2 TPM Specification make it necessary to update some
> fields of the chip structure in the initialization function after it is
> registered with tpm.c thus tpm_register_hardware was modified to return
> a pointer to the structure.  This patch makes that change and the
> associated changes in tpm_atmel and tpm_nsc.  The changes to
> tpm_infineon will be coming in a patch from Marcel Selhorst.

Signed-off-by: Marcel Selhorst <selhorst@crypto.rub.de>
---
--- linux-old/drivers/char/tpm/tpm_infineon.c	2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16-rc3/drivers/char/tpm/tpm_infineon.c	2006-04-06 11:37:24.000000000 +0000
@@ -104,7 +104,7 @@ static int empty_fifo(struct tpm_chip *c

 	if (clear_wrfifo) {
 		for (i = 0; i < 4096; i++) {
-			status = inb(chip->vendor->base + WRFIFO);
+			status = inb(chip->vendor.base + WRFIFO);
 			if (status == 0xff) {
 				if (check == 5)
 					break;
@@ -124,8 +124,8 @@ static int empty_fifo(struct tpm_chip *c
 	 */
 	i = 0;
 	do {
-		status = inb(chip->vendor->base + RDFIFO);
-		status = inb(chip->vendor->base + STAT);
+		status = inb(chip->vendor.base + RDFIFO);
+		status = inb(chip->vendor.base + STAT);
 		i++;
 		if (i == TPM_MAX_TRIES)
 			return -EIO;
@@ -138,7 +138,7 @@ static int wait(struct tpm_chip *chip, i
 	int status;
 	int i;
 	for (i = 0; i < TPM_MAX_TRIES; i++) {
-		status = inb(chip->vendor->base + STAT);
+		status = inb(chip->vendor.base + STAT);
 		/* check the status-register if wait_for_bit is set */
 		if (status & 1 << wait_for_bit)
 			break;
@@ -157,7 +157,7 @@ static int wait(struct tpm_chip *chip, i
 static void wait_and_send(struct tpm_chip *chip, u8 sendbyte)
 {
 	wait(chip, STAT_XFE);
-	outb(sendbyte, chip->vendor->base + WRFIFO);
+	outb(sendbyte, chip->vendor.base + WRFIFO);
 }

     /* Note: WTX means Waiting-Time-Extension. Whenever the TPM needs more
@@ -204,7 +204,7 @@ recv_begin:
 		ret = wait(chip, STAT_RDA);
 		if (ret)
 			return -EIO;
-		buf[i] = inb(chip->vendor->base + RDFIFO);
+		buf[i] = inb(chip->vendor.base + RDFIFO);
 	}

 	if (buf[0] != TPM_VL_VER) {
@@ -219,7 +219,7 @@ recv_begin:

 		for (i = 0; i < size; i++) {
 			wait(chip, STAT_RDA);
-			buf[i] = inb(chip->vendor->base + RDFIFO);
+			buf[i] = inb(chip->vendor.base + RDFIFO);
 		}

 		if ((size == 0x6D00) && (buf[1] == 0x80)) {
@@ -268,7 +268,7 @@ static int tpm_inf_send(struct tpm_chip
 	u8 count_high, count_low, count_4, count_3, count_2, count_1;

 	/* Disabling Reset, LP and IRQC */
-	outb(RESET_LP_IRQC_DISABLE, chip->vendor->base + CMD);
+	outb(RESET_LP_IRQC_DISABLE, chip->vendor.base + CMD);

 	ret = empty_fifo(chip, 1);
 	if (ret) {
@@ -319,7 +319,7 @@ static void tpm_inf_cancel(struct tpm_ch

 static u8 tpm_inf_status(struct tpm_chip *chip)
 {
-	return inb(chip->vendor->base + STAT);
+	return inb(chip->vendor.base + STAT);
 }

 static DEVICE_ATTR(pubek, S_IRUGO, tpm_show_pubek, NULL);
@@ -346,7 +346,7 @@ static struct file_operations inf_ops =
 	.release = tpm_release,
 };

-static struct tpm_vendor_specific tpm_inf = {
+static const struct tpm_vendor_specific tpm_inf = {
 	.recv = tpm_inf_recv,
 	.send = tpm_inf_send,
 	.cancel = tpm_inf_cancel,
@@ -375,6 +375,7 @@ static int __devinit tpm_inf_pnp_probe(s
 	int version[2];
 	int productid[2];
 	char chipname[20];
+	struct tpm_chip *chip;

 	/* read IO-ports through PnP */
 	if (pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) &&
@@ -395,14 +396,13 @@ static int __devinit tpm_inf_pnp_probe(s
 			goto err_last;
 		}
 		/* publish my base address and request region */
-		tpm_inf.base = TPM_INF_BASE;
 		if (request_region
-		    (tpm_inf.base, TPM_INF_PORT_LEN, "tpm_infineon0") == NULL) {
+		    (TPM_INF_BASE, TPM_INF_PORT_LEN, "tpm_infineon0") == NULL) {
 			rc = -EINVAL;
 			goto err_last;
 		}
-		if (request_region(TPM_INF_ADDR, TPM_INF_ADDR_LEN,
-				"tpm_infineon0") == NULL) {
+		if (request_region
+		    (TPM_INF_ADDR, TPM_INF_ADDR_LEN, "tpm_infineon0") == NULL) {
 			rc = -EINVAL;
 			goto err_last;
 		}
@@ -442,9 +442,9 @@ static int __devinit tpm_inf_pnp_probe(s

 		/* configure TPM with IO-ports */
 		outb(IOLIMH, TPM_INF_ADDR);
-		outb(((tpm_inf.base >> 8) & 0xff), TPM_INF_DATA);
+		outb(((TPM_INF_BASE >> 8) & 0xff), TPM_INF_DATA);
 		outb(IOLIML, TPM_INF_ADDR);
-		outb((tpm_inf.base & 0xff), TPM_INF_DATA);
+		outb((TPM_INF_BASE & 0xff), TPM_INF_DATA);

 		/* control if IO-ports are set correctly */
 		outb(IOLIMH, TPM_INF_ADDR);
@@ -452,10 +452,10 @@ static int __devinit tpm_inf_pnp_probe(s
 		outb(IOLIML, TPM_INF_ADDR);
 		iol = inb(TPM_INF_DATA);

-		if ((ioh << 8 | iol) != tpm_inf.base) {
+		if ((ioh << 8 | iol) != TPM_INF_BASE) {
 			dev_err(&dev->dev,
-				"Could not set IO-ports to 0x%lx\n",
-				tpm_inf.base);
+				"Could not set IO-ports to 0x%x\n",
+				TPM_INF_BASE);
 			rc = -EIO;
 			goto err_release_region;
 		}
@@ -466,15 +466,15 @@ static int __devinit tpm_inf_pnp_probe(s
 		outb(DISABLE_REGISTER_PAIR, TPM_INF_ADDR);

 		/* disable RESET, LP and IRQC */
-		outb(RESET_LP_IRQC_DISABLE, tpm_inf.base + CMD);
+		outb(RESET_LP_IRQC_DISABLE, TPM_INF_BASE + CMD);

 		/* Finally, we're done, print some infos */
 		dev_info(&dev->dev, "TPM found: "
 			 "config base 0x%x, "
 			 "io base 0x%x, "
-			 "chip version %02x%02x, "
-			 "vendor id %x%x (Infineon), "
-			 "product id %02x%02x"
+			 "chip version 0x%02x%02x, "
+			 "vendor id 0x%x%x (Infineon), "
+			 "product id 0x%02x%02x"
 			 "%s\n",
 			 TPM_INF_ADDR,
 			 TPM_INF_BASE,
@@ -482,11 +482,10 @@ static int __devinit tpm_inf_pnp_probe(s
 			 vendorid[0], vendorid[1],
 			 productid[0], productid[1], chipname);

-		rc = tpm_register_hardware(&dev->dev, &tpm_inf);
-		if (rc < 0) {
-			rc = -ENODEV;
+		if (!(chip = tpm_register_hardware(&dev->dev, &tpm_inf))) {
 			goto err_release_region;
 		}
+		chip->vendor.base = TPM_INF_BASE;
 		return 0;
 	} else {
 		rc = -ENODEV;
@@ -494,7 +493,7 @@ static int __devinit tpm_inf_pnp_probe(s
 	}

 err_release_region:
-	release_region(tpm_inf.base, TPM_INF_PORT_LEN);
+	release_region(TPM_INF_BASE, TPM_INF_PORT_LEN);
 	release_region(TPM_INF_ADDR, TPM_INF_ADDR_LEN);

 err_last:
@@ -506,7 +505,8 @@ static __devexit void tpm_inf_pnp_remove
 	struct tpm_chip *chip = pnp_get_drvdata(dev);

 	if (chip) {
-		release_region(chip->vendor->base, TPM_INF_PORT_LEN);
+		release_region(TPM_INF_BASE, TPM_INF_PORT_LEN);
+		release_region(TPM_INF_ADDR, TPM_INF_ADDR_LEN);
 		tpm_remove_hardware(chip->dev);
 	}
 }
@@ -538,5 +538,5 @@ module_exit(cleanup_inf);

 MODULE_AUTHOR("Marcel Selhorst <selhorst@crypto.rub.de>");
 MODULE_DESCRIPTION("Driver for Infineon TPM SLD 9630 TT 1.1 / SLB 9635 TT 1.2");
-MODULE_VERSION("1.7");
+MODULE_VERSION("1.8");
 MODULE_LICENSE("GPL");
