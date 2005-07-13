Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVGMMqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVGMMqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 08:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVGMMqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 08:46:13 -0400
Received: from pip249.ish.de ([80.69.98.249]:37754 "EHLO mail01.ish.de")
	by vger.kernel.org with ESMTP id S262628AbVGMMqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 08:46:12 -0400
Message-ID: <42D50D12.8070509@crypto.rub.de>
Date: Wed, 13 Jul 2005 14:46:10 +0200
From: Marcel Selhorst <selhorst@crypto.rub.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050625)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Kylene Jo Hall <kjhall@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] tpm: Support for Infineon TPM
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-14; AVE: 6.31.0.9; VDF: 6.31.0.198; host: mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML,

after further iterations with reviews and corrections, here is
a fresh patch for the Infineon Trusted Platform Module SLD 9630 (TPM 1.1b).

Best Regards,
Marcel Selhorst

Signed-off-by: Marcel Selhorst <selhorst@crypto.rub.de>
---

diff -pruN linux-2.6.13-rc2-mm2/drivers/char/tpm/Kconfig linux/drivers/char/tpm/Kconfig
--- linux-2.6.13-rc2-mm2/drivers/char/tpm/Kconfig	2005-07-13 13:15:51.000000000 +0200
+++ linux/drivers/char/tpm/Kconfig	2005-07-13 11:51:56.000000000 +0200
@@ -35,5 +35,16 @@ config TCG_ATMEL
 	  will be accessible from within Linux.  To compile this driver
 	  as a module, choose M here; the module will be called tpm_atmel.

+config TCG_INFINEON
+	tristate "Infineon Technologies SLD 9630 TPM Interface"
+	depends on TCG_TPM
+	---help---
+	  If you have a TPM security chip from Infineon Technologies
+	  say Yes and it will be accessible from within Linux.  To
+	  compile this driver as a module, choose M here; the module
+	  will be called tpm_infineon.
+	  Further information on this driver and the supported hardware
+	  can be found at http://www.prosec.rub.de/tpm
+
 endmenu

diff -pruN linux-2.6.13-rc2-mm2/drivers/char/tpm/Makefile linux/drivers/char/tpm/Makefile
--- linux-2.6.13-rc2-mm2/drivers/char/tpm/Makefile	2005-07-13 13:15:51.000000000 +0200
+++ linux/drivers/char/tpm/Makefile	2005-07-13 11:52:08.000000000 +0200
@@ -4,4 +4,4 @@
 obj-$(CONFIG_TCG_TPM) += tpm.o
 obj-$(CONFIG_TCG_NSC) += tpm_nsc.o
 obj-$(CONFIG_TCG_ATMEL) += tpm_atmel.o
-
+obj-$(CONFIG_TCG_INFINEON) += tpm_infineon.o
diff -pruN linux-2.6.13-rc2-mm2/drivers/char/tpm/tpm_infineon.c
linux/drivers/char/tpm/tpm_infineon.c
--- linux-2.6.13-rc2-mm2/drivers/char/tpm/tpm_infineon.c	1970-01-01
01:00:00.000000000 +0100
+++ linux/drivers/char/tpm/tpm_infineon.c	2005-07-13 13:06:29.000000000 +0200
@@ -0,0 +1,467 @@
+/*
+ * Description:
+ * Device Driver for the Infineon Technologies
+ * SLD 9630 TT Trusted Platform Module
+ * Specifications at www.trustedcomputinggroup.org
+ *
+ * Copyright (C) 2005, Marcel Selhorst <selhorst@crypto.rub.de>
+ * Applied Data Security Group, Ruhr-University Bochum, Germany
+ * Project-Homepage: http://www.prosec.rub.de/tpm
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ */
+
+#include "tpm.h"
+
+/* Infineon specific definitions */
+/* maximum number of WTX-packages */
+#define	TPM_MAX_WTX_PACKAGES 	50
+/* msleep-Time for WTX-packages */
+#define	TPM_WTX_MSLEEP_TIME 	20
+/* msleep-Time --> Interval to check status register */
+#define	TPM_MSLEEP_TIME 	3
+/* gives number of max. msleep()-calls before throwing timeout */
+#define	TPM_MAX_TRIES		5000
+#define	TCPA_INFINEON_DEV_VEN_VALUE	0x15D1
+#define	TPM_DATA 			(TPM_ADDR + 1) & 0xff
+
+/* TPM header definitions */
+enum infineon_tpm_header {
+	TPM_VL_VER = 0x01,
+	TPM_VL_CHANNEL_CONTROL = 0x07,
+	TPM_VL_CHANNEL_PERSONALISATION = 0x0A,
+	TPM_VL_CHANNEL_TPM = 0x0B,
+	TPM_VL_CONTROL = 0x00,
+	TPM_INF_NAK = 0x15,
+	TPM_CTRL_WTX = 0x10,
+	TPM_CTRL_WTX_ABORT = 0x18,
+	TPM_CTRL_WTX_ABORT_ACK = 0x18,
+	TPM_CTRL_ERROR = 0x20,
+	TPM_CTRL_CHAININGACK = 0x40,
+	TPM_CTRL_CHAINING = 0x80,
+	TPM_CTRL_DATA = 0x04,
+	TPM_CTRL_DATA_CHA = 0x84,
+	TPM_CTRL_DATA_CHA_ACK = 0xC4
+};
+
+enum infineon_tpm_register {
+	WRFIFO = 0x00,
+	RDFIFO = 0x01,
+	STAT = 0x02,
+	CMD = 0x03
+};
+
+enum infineon_tpm_command_bits {
+	CMD_DIS = 0x00,
+	CMD_LP = 0x01,
+	CMD_RES = 0x02,
+	CMD_IRQC = 0x06
+};
+
+enum infineon_tpm_status_bits {
+	STAT_XFE = 0x00,
+	STAT_LPA = 0x01,
+	STAT_FOK = 0x02,
+	STAT_TOK = 0x03,
+	STAT_IRQA = 0x06,
+	STAT_RDA = 0x07
+};
+
+/* some outgoing values */
+enum infineon_tpm_values {
+	CHIP_ID1 = 0x20,
+	CHIP_ID2 = 0x21,
+	DAR = 0x30,
+	RESET_LP_IRQC_DISABLE = 0x41,
+	ENABLE_REGISTER_PAIR = 0x55,
+	IOLIMH = 0x60,
+	IOLIML = 0x61,
+	DISABLE_REGISTER_PAIR = 0xAA,
+	IDVENL = 0xF1,
+	IDVENH = 0xF2,
+	IDPDL = 0xF3,
+	IDPDH = 0xF4
+};
+
+static int number_of_wtx;
+
+static int empty_fifo(struct tpm_chip *chip, int clear_wrfifo)
+{
+	int status;
+	int check = 0;
+	int i;
+
+	if (clear_wrfifo) {
+		for (i = 0; i < 4096; i++) {
+			status = inb(chip->vendor->base + WRFIFO);
+			if (status == 0xff) {
+				if (check == 5)
+					break;
+				else
+					check++;
+			}
+		}
+	}
+	/* Note: The values which are currently in the FIFO of the TPM
+	   are thrown away since there is no usage for them. Usually,
+	   this has nothing to say, since the TPM will give its answer
+	   immediately or will be aborted anyway, so the data here is
+	   usually garbage and useless.
+	   We have to clean this, because the next communication with
+	   the TPM would be rubbish, if there is still some old data
+	   in the Read FIFO.
+	 */
+	i = 0;
+	do {
+		status = inb(chip->vendor->base + RDFIFO);
+		status = inb(chip->vendor->base + STAT);
+		i++;
+		if (i == TPM_MAX_TRIES)
+			return -EIO;
+	} while ((status & (1 << STAT_RDA)) != 0);
+	return 0;
+}
+
+static int wait(struct tpm_chip *chip, int wait_for_bit)
+{
+	int status;
+	int i;
+	for (i = 0; i < TPM_MAX_TRIES; i++) {
+		status = inb(chip->vendor->base + STAT);
+		/* check the status-register if wait_for_bit is set */
+		if (status & 1 << wait_for_bit)
+			break;
+		msleep(TPM_MSLEEP_TIME);
+	}
+	if (i == TPM_MAX_TRIES) {	/* timeout occurs */
+		if (wait_for_bit == STAT_XFE)
+			dev_err(&chip->pci_dev->dev,
+				"Timeout in wait(STAT_XFE)\n");
+		if (wait_for_bit == STAT_RDA)
+			dev_err(&chip->pci_dev->dev,
+				"Timeout in wait(STAT_RDA)\n");
+		return -EIO;
+	}
+	return 0;
+};
+
+static void wait_and_send(struct tpm_chip *chip, u8 sendbyte)
+{
+	wait(chip, STAT_XFE);
+	outb(sendbyte, chip->vendor->base + WRFIFO);
+}
+
+    /* Note: WTX means Waiting-Time-Extension. Whenever the TPM needs more
+       calculation time, it sends a WTX-package, which has to be acknowledged
+       or aborted. This usually occurs if you are hammering the TPM with key
+       creation. Set the maximum number of WTX-packages in the definitions
+       above, if the number is reached, the waiting-time will be denied
+       and the TPM command has to be resend.
+     */
+
+static void tpm_wtx(struct tpm_chip *chip)
+{
+	number_of_wtx++;
+	dev_info(&chip->pci_dev->dev, "Granting WTX (%02d / %02d)\n",
+		 number_of_wtx, TPM_MAX_WTX_PACKAGES);
+	wait_and_send(chip, TPM_VL_VER);
+	wait_and_send(chip, TPM_CTRL_WTX);
+	wait_and_send(chip, 0x00);
+	wait_and_send(chip, 0x00);
+	msleep(TPM_WTX_MSLEEP_TIME);
+}
+
+static void tpm_wtx_abort(struct tpm_chip *chip)
+{
+	dev_info(&chip->pci_dev->dev, "Aborting WTX\n");
+	wait_and_send(chip, TPM_VL_VER);
+	wait_and_send(chip, TPM_CTRL_WTX_ABORT);
+	wait_and_send(chip, 0x00);
+	wait_and_send(chip, 0x00);
+	number_of_wtx = 0;
+	msleep(TPM_WTX_MSLEEP_TIME);
+}
+
+static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
+{
+	int i;
+	int ret;
+	u32 size = 0;
+
+recv_begin:
+	/* start receiving header */
+	for (i = 0; i < 4; i++) {
+		ret = wait(chip, STAT_RDA);
+		if (ret)
+			return -EIO;
+		buf[i] = inb(chip->vendor->base + RDFIFO);
+	}
+
+	if (buf[0] != TPM_VL_VER) {
+		dev_err(&chip->pci_dev->dev,
+			"Wrong transport protocol implementation!\n");
+		return -EIO;
+	}
+
+	if (buf[1] == TPM_CTRL_DATA) {
+		/* size of the data received */
+		size = ((buf[2] << 8) | buf[3]);
+
+		for (i = 0; i < size; i++) {
+			wait(chip, STAT_RDA);
+			buf[i] = inb(chip->vendor->base + RDFIFO);
+		}
+
+		if ((size == 0x6D00) && (buf[1] == 0x80)) {
+			dev_err(&chip->pci_dev->dev,
+				"Error handling on vendor layer!\n");
+			return -EIO;
+		}
+
+		for (i = 0; i < size; i++)
+			buf[i] = buf[i + 6];
+
+		size = size - 6;
+		return size;
+	}
+
+	if (buf[1] == TPM_CTRL_WTX) {
+		dev_info(&chip->pci_dev->dev, "WTX-package received\n");
+		if (number_of_wtx < TPM_MAX_WTX_PACKAGES) {
+			tpm_wtx(chip);
+			goto recv_begin;
+		} else {
+			tpm_wtx_abort(chip);
+			goto recv_begin;
+		}
+	}
+
+	if (buf[1] == TPM_CTRL_WTX_ABORT_ACK) {
+		dev_info(&chip->pci_dev->dev, "WTX-abort acknowledged\n");
+		return size;
+	}
+
+	if (buf[1] == TPM_CTRL_ERROR) {
+		dev_err(&chip->pci_dev->dev, "ERROR-package received:\n");
+		if (buf[4] == TPM_INF_NAK)
+			dev_err(&chip->pci_dev->dev,
+				"-> Negative acknowledgement"
+				" - retransmit command!\n");
+		return -EIO;
+	}
+	return -EIO;
+}
+
+static int tpm_inf_send(struct tpm_chip *chip, u8 * buf, size_t count)
+{
+	int i;
+	int ret;
+	u8 count_high, count_low, count_4, count_3, count_2, count_1;
+
+	/* Disabling Reset, LP and IRQC */
+	outb(RESET_LP_IRQC_DISABLE, chip->vendor->base + CMD);
+
+	ret = empty_fifo(chip, 1);
+	if (ret) {
+		dev_err(&chip->pci_dev->dev, "Timeout while clearing FIFO\n");
+		return -EIO;
+	}
+
+	ret = wait(chip, STAT_XFE);
+	if (ret)
+		return -EIO;
+
+	count_4 = (count & 0xff000000) >> 24;
+	count_3 = (count & 0x00ff0000) >> 16;
+	count_2 = (count & 0x0000ff00) >> 8;
+	count_1 = (count & 0x000000ff);
+	count_high = ((count + 6) & 0xffffff00) >> 8;
+	count_low = ((count + 6) & 0x000000ff);
+
+	/* Sending Header */
+	wait_and_send(chip, TPM_VL_VER);
+	wait_and_send(chip, TPM_CTRL_DATA);
+	wait_and_send(chip, count_high);
+	wait_and_send(chip, count_low);
+
+	/* Sending Data Header */
+	wait_and_send(chip, TPM_VL_VER);
+	wait_and_send(chip, TPM_VL_CHANNEL_TPM);
+	wait_and_send(chip, count_4);
+	wait_and_send(chip, count_3);
+	wait_and_send(chip, count_2);
+	wait_and_send(chip, count_1);
+
+	/* Sending Data */
+	for (i = 0; i < count; i++) {
+		wait_and_send(chip, buf[i]);
+	}
+	return count;
+}
+
+static void tpm_inf_cancel(struct tpm_chip *chip)
+{
+	/* Nothing yet!
+	   This has something to do with the internal functions
+	   of the TPM. Abort isn't really necessary...
+	 */
+}
+
+static DEVICE_ATTR(pubek, S_IRUGO, tpm_show_pubek, NULL);
+static DEVICE_ATTR(pcrs, S_IRUGO, tpm_show_pcrs, NULL);
+static DEVICE_ATTR(caps, S_IRUGO, tpm_show_caps, NULL);
+static DEVICE_ATTR(cancel, S_IWUSR | S_IWGRP, NULL, tpm_store_cancel);
+
+static struct attribute *inf_attrs[] = {
+	&dev_attr_pubek.attr,
+	&dev_attr_pcrs.attr,
+	&dev_attr_caps.attr,
+	&dev_attr_cancel.attr,
+	NULL,
+};
+
+static struct attribute_group inf_attr_grp = {.attrs = inf_attrs };
+
+static struct file_operations inf_ops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.open = tpm_open,
+	.read = tpm_read,
+	.write = tpm_write,
+	.release = tpm_release,
+};
+
+static struct tpm_vendor_specific tpm_inf = {
+	.recv = tpm_inf_recv,
+	.send = tpm_inf_send,
+	.cancel = tpm_inf_cancel,
+	.req_complete_mask = 0,
+	.req_complete_val = 0,
+	.attr_group = &inf_attr_grp,
+	.miscdev = {.fops = &inf_ops,},
+};
+
+static int __devinit tpm_inf_probe(struct pci_dev *pci_dev,
+				   const struct pci_device_id *pci_id)
+{
+	int rc = 0;
+	u8 iol, ioh;
+	int vendorid[2];
+	int version[2];
+	int productid[2];
+
+	if (pci_enable_device(pci_dev))
+		return -EIO;
+
+	dev_info(&pci_dev->dev, "LPC-bus found at 0x%x\n", pci_id->device);
+
+	/* query chip for its vendor, its version number a.s.o. */
+	outb(ENABLE_REGISTER_PAIR, TPM_ADDR);
+	outb(IDVENL, TPM_ADDR);
+	vendorid[1] = inb(TPM_DATA);
+	outb(IDVENH, TPM_ADDR);
+	vendorid[0] = inb(TPM_DATA);
+	outb(IDPDL, TPM_ADDR);
+	productid[1] = inb(TPM_DATA);
+	outb(IDPDH, TPM_ADDR);
+	productid[0] = inb(TPM_DATA);
+	outb(CHIP_ID1, TPM_ADDR);
+	version[1] = inb(TPM_DATA);
+	outb(CHIP_ID2, TPM_ADDR);
+	version[0] = inb(TPM_DATA);
+
+	if ((vendorid[0] << 8 | vendorid[1]) == (TCPA_INFINEON_DEV_VEN_VALUE)) {
+
+		/* read IO-ports from TPM */
+		outb(IOLIMH, TPM_ADDR);
+		ioh = inb(TPM_DATA);
+		outb(IOLIML, TPM_ADDR);
+		iol = inb(TPM_DATA);
+		tpm_inf.base = (ioh << 8) | iol;
+
+		if (tpm_inf.base == 0) {
+			dev_err(&pci_dev->dev, "No IO-ports set!\n");
+			pci_disable_device(pci_dev);
+			return -ENODEV;
+		}
+
+		/* activate register */
+		outb(DAR, TPM_ADDR);
+		outb(0x01, TPM_DATA);
+		outb(DISABLE_REGISTER_PAIR, TPM_ADDR);
+
+		/* disable RESET, LP and IRQC */
+		outb(RESET_LP_IRQC_DISABLE, tpm_inf.base + CMD);
+
+		/* Finally, we're done, print some infos */
+		dev_info(&pci_dev->dev, "TPM found: "
+			 "io base 0x%x, "
+			 "chip version %02x%02x, "
+			 "vendor id %x%x (Infineon), "
+			 "product id %02x%02x"
+			 "%s\n",
+			 tpm_inf.base,
+			 version[0], version[1],
+			 vendorid[0], vendorid[1],
+			 productid[0], productid[1], ((productid[0] == 0)
+						      && (productid[1] ==
+							  6)) ?
+			 " (SLD 9630 TT 1.1)" : "");
+
+		rc = tpm_register_hardware(pci_dev, &tpm_inf);
+		if (rc < 0) {
+			pci_disable_device(pci_dev);
+			return -ENODEV;
+		}
+		return 0;
+	} else {
+		dev_info(&pci_dev->dev, "No Infineon TPM found!\n");
+		pci_disable_device(pci_dev);
+		return -ENODEV;
+	}
+}
+
+static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2)},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, tpm_pci_tbl);
+
+static struct pci_driver inf_pci_driver = {
+	.name = "tpm_inf",
+	.id_table = tpm_pci_tbl,
+	.probe = tpm_inf_probe,
+	.remove = __devexit_p(tpm_remove),
+	.suspend = tpm_pm_suspend,
+	.resume = tpm_pm_resume,
+};
+
+static int __init init_inf(void)
+{
+	return pci_register_driver(&inf_pci_driver);
+}
+
+static void __exit cleanup_inf(void)
+{
+	pci_unregister_driver(&inf_pci_driver);
+}
+
+module_init(init_inf);
+module_exit(cleanup_inf);
+
+MODULE_AUTHOR("Marcel Selhorst <selhorst@crypto.rub.de>");
+MODULE_DESCRIPTION("Driver for Infineon TPM SLD 9630 TT");
+MODULE_VERSION("1.4");
+MODULE_LICENSE("GPL");


