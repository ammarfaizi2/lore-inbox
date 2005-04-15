Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVDOWIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVDOWIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 18:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVDOWIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 18:08:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:2518 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261984AbVDOWGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 18:06:32 -0400
Date: Fri, 15 Apr 2005 17:06:06 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@dyn95395164
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, jgarzik@pobox.com
Subject: [PATCH] tpm: Stop taking over the non-unique lpc bus PCI ID, Also
 timer, stack and enum fixes
Message-ID: <Pine.LNX.4.61.0504151611390.24192@dyn95395164>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against the 2.6.12-rc2 kernel source.  It changes the tpm 
drivers from defining a pci driver structure to a format similar to the 
drivers/char/watchdog/i8xx_tco driver.  This is necessary because the 
lpc_bus only has one PCI ID and claiming that ID in the pci driver probe 
process prevents other drivers from finding their hardware.  This patch 
also fixes numerous problems that were pointed out with timer 
manipulations, large stack objects, lack of enums and defined constants.

Still lingering:

How can I receive Hotplug and ACPI events without being a PCI driver?

The first person to the lpc bus needs to call pci_enable_device and the 
last to leave one should call pci_disable_device, how as a device driver 
on this bus do I know if I am the first or last one and need to make the 
appropriate call?

Thanks,
Kylie Hall

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN linux-2.6.12-rc2/drivers/char/tpm/tpm_atmel.c linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.12-rc2/drivers/char/tpm/tpm_atmel.c	2005-04-15 16:31:21.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_atmel.c	2005-04-15 16:26:17.000000000 -0500
@@ -22,17 +22,22 @@
 #include "tpm.h"
 
 /* Atmel definitions */
-#define	TPM_ATML_BASE			0x400
+enum {
+	TPM_ATML_BASE = 0x400
+};
 
 /* write status bits */
-#define	ATML_STATUS_ABORT		0x01
-#define	ATML_STATUS_LASTBYTE		0x04
-
+enum {
+	ATML_STATUS_ABORT = 0x01,
+	ATML_STATUS_LASTBYTE = 0x04
+};
 /* read status bits */
-#define	ATML_STATUS_BUSY		0x01
-#define	ATML_STATUS_DATA_AVAIL		0x02
-#define	ATML_STATUS_REWRITE		0x04
-
+enum {
+	ATML_STATUS_BUSY = 0x01,
+	ATML_STATUS_DATA_AVAIL = 0x02,
+	ATML_STATUS_REWRITE = 0x04,
+	ATML_STATUS_READY = 0x08
+};
 
 static int tpm_atml_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 {
@@ -48,8 +53,7 @@ static int tpm_atml_recv(struct tpm_chip
 	for (i = 0; i < 6; i++) {
 		status = inb(chip->vendor->base + 1);
 		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
-			dev_err(&chip->pci_dev->dev,
-				"error reading header\n");
+			dev_err(chip->dev, "error reading header\n");
 			return -EIO;
 		}
 		*buf++ = inb(chip->vendor->base);
@@ -60,13 +64,12 @@ static int tpm_atml_recv(struct tpm_chip
 	size = be32_to_cpu(*native_size);
 
 	if (count < size) {
-		dev_err(&chip->pci_dev->dev,
+		dev_err(chip->dev,
 			"Recv size(%d) less than available space\n", size);
 		for (; i < size; i++) {	/* clear the waiting data anyway */
 			status = inb(chip->vendor->base + 1);
 			if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
-				dev_err(&chip->pci_dev->dev,
-					"error reading data\n");
+				dev_err(chip->dev, "error reading data\n");
 				return -EIO;
 			}
 		}
@@ -77,8 +80,7 @@ static int tpm_atml_recv(struct tpm_chip
 	for (; i < size; i++) {
 		status = inb(chip->vendor->base + 1);
 		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
-			dev_err(&chip->pci_dev->dev,
-				"error reading data\n");
+			dev_err(chip->dev, "error reading data\n");
 			return -EIO;
 		}
 		*buf++ = inb(chip->vendor->base);
@@ -87,7 +89,7 @@ static int tpm_atml_recv(struct tpm_chip
 	/* make sure data available is gone */
 	status = inb(chip->vendor->base + 1);
 	if (status & ATML_STATUS_DATA_AVAIL) {
-		dev_err(&chip->pci_dev->dev, "data available is stuck\n");
+		dev_err(chip->dev, "data available is stuck\n");
 		return -EIO;
 	}
 
@@ -98,9 +100,9 @@ static int tpm_atml_send(struct tpm_chip
 {
 	int i;
 
-	dev_dbg(&chip->pci_dev->dev, "tpm_atml_send: ");
+	dev_dbg(chip->dev, "tpm_atml_send: ");
 	for (i = 0; i < count; i++) {
-		dev_dbg(&chip->pci_dev->dev, "0x%x(%d) ", buf[i], buf[i]);
+		dev_dbg(chip->dev, "0x%x(%d) ", buf[i], buf[i]);
 		outb(buf[i], chip->vendor->base);
 	}
 
@@ -112,6 +114,27 @@ static void tpm_atml_cancel(struct tpm_c
 	outb(ATML_STATUS_ABORT, chip->vendor->base + 1);
 }
 
+static u8 tpm_atml_status(struct tpm_chip *chip)
+{
+	u8 status;
+
+	status = inb(chip->vendor->base + 1);
+
+	return status;
+}
+
+static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, tpm_pci_tbl);
+
 static struct file_operations atmel_ops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
@@ -125,22 +148,37 @@ static struct tpm_vendor_specific tpm_at
 	.recv = tpm_atml_recv,
 	.send = tpm_atml_send,
 	.cancel = tpm_atml_cancel,
+	.status = tpm_atml_status,
 	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
 	.req_complete_val = ATML_STATUS_DATA_AVAIL,
+	.req_canceled = ATML_STATUS_READY,
 	.base = TPM_ATML_BASE,
-	.miscdev = {.fops = &atmel_ops,},
+	.attr = TPM_DEVICE_ATTRS,
+	.miscdev.fops = &atmel_ops,
 };
 
-static int __devinit tpm_atml_init(struct pci_dev *pci_dev,
-				   const struct pci_device_id *pci_id)
+static struct pci_dev *atmel_tpm;
+
+static int __init init_atmel(void)
 {
 	u8 version[4];
 	int rc = 0;
+	struct pci_dev *dev = NULL;
 
-	if (pci_enable_device(pci_dev))
-		return -EIO;
+	while ((dev =
+		pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+		if (pci_match_device(tpm_pci_tbl, dev)) {
+			atmel_tpm = dev;
+			break;
+		}
 
-	if (tpm_lpc_bus_init(pci_dev, TPM_ATML_BASE)) {
+	if (!atmel_tpm)
+		return -ENODEV;
+
+	if (pci_enable_device(atmel_tpm))
+		return -EIO;;
+
+	if (tpm_lpc_bus_init(atmel_tpm, TPM_ATML_BASE)) {
 		rc = -ENODEV;
 		goto out_err;
 	}
@@ -158,53 +196,28 @@ static int __devinit tpm_atml_init(struc
 		version[2] = tpm_read_index(0x02);
 		version[3] = tpm_read_index(0x03);
 	} else {
-		dev_info(&pci_dev->dev, "version query failed\n");
+		dev_info(&atmel_tpm->dev, "version query failed\n");
 		rc = -ENODEV;
 		goto out_err;
 	}
 
-	if ((rc = tpm_register_hardware(pci_dev, &tpm_atmel)) < 0)
+	if ((rc = tpm_register_hardware(&atmel_tpm->dev, &tpm_atmel)) < 0)
 		goto out_err;
 
-	dev_info(&pci_dev->dev,
+	dev_info(&atmel_tpm->dev,
 		 "Atmel TPM version %d.%d.%d.%d\n", version[0], version[1],
 		 version[2], version[3]);
 
 	return 0;
 out_err:
-	pci_disable_device(pci_dev);
+	pci_disable_device(atmel_tpm);
 	return rc;
 }
 
-static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
-	{0,}
-};
-
-MODULE_DEVICE_TABLE(pci, tpm_pci_tbl);
-
-static struct pci_driver atmel_pci_driver = {
-	.name = "tpm_atmel",
-	.id_table = tpm_pci_tbl,
-	.probe = tpm_atml_init,
-	.remove = __devexit_p(tpm_remove),
-	.suspend = tpm_pm_suspend,
-	.resume = tpm_pm_resume,
-};
-
-static int __init init_atmel(void)
-{
-	return pci_register_driver(&atmel_pci_driver);
-}
-
 static void __exit cleanup_atmel(void)
 {
-	pci_unregister_driver(&atmel_pci_driver);
+	tpm_remove_hardware(&atmel_tpm->dev);
+	pci_disable_device(atmel_tpm);
 }
 
 module_init(init_atmel);
diff -uprN linux-2.6.12-rc2/drivers/char/tpm/tpm.c linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-15 16:30:55.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c	2005-04-15 16:28:55.000000000 -0500
@@ -28,19 +28,35 @@
 #include <linux/spinlock.h>
 #include "tpm.h"
 
-#define	TPM_MINOR			224	/* officially assigned */
+enum {
+	TPM_MINOR = 224,	/* officially assigned */
+	TPM_BUFSIZE = 2048,
+	TPM_NUM_DEVICES = 256,
+	TPM_NUM_MASK_ENTRIES = TPM_NUM_DEVICES / (8 * sizeof(int))
+};
 
-#define	TPM_BUFSIZE			2048
+  /* PCI configuration addresses */
+enum {
+	PCI_GEN_PMCON_1 = 0xA0,
+	PCI_GEN1_DEC = 0xE4,
+	PCI_LPC_EN = 0xE6,
+	PCI_GEN2_DEC = 0xEC
+};
+
+enum {
+	TPM_LOCK_REG = 0x0D,
+	TPM_INTERUPT_REG = 0x0A,
+	TPM_BASE_ADDR_LO = 0x08,
+	TPM_BASE_ADDR_HI = 0x09,
+	TPM_UNLOCK_VALUE = 0x55,
+	TPM_LOCK_VALUE = 0xAA,
+	TPM_DISABLE_INTERUPT_VALUE = 0x00
+};
 
-/* PCI configuration addresses */
-#define	PCI_GEN_PMCON_1			0xA0
-#define	PCI_GEN1_DEC			0xE4
-#define	PCI_LPC_EN			0xE6
-#define	PCI_GEN2_DEC			0xEC
 
 static LIST_HEAD(tpm_chip_list);
 static DEFINE_SPINLOCK(driver_lock);
-static int dev_mask[32];
+static int dev_mask[TPM_NUM_MASK_ENTRIES];
 
 static void user_reader_timeout(unsigned long ptr)
 {
@@ -102,11 +118,11 @@ int tpm_lpc_bus_init(struct pci_dev *pci
 			pci_write_config_dword(pci_dev, PCI_GEN_PMCON_1,
 					       tmp);
 		}
-		tpm_write_index(0x0D, 0x55);	/* unlock 4F */
-		tpm_write_index(0x0A, 0x00);	/* int disable */
-		tpm_write_index(0x08, base);	/* base addr lo */
-		tpm_write_index(0x09, (base & 0xFF00) >> 8);	/* base addr hi */
-		tpm_write_index(0x0D, 0xAA);	/* lock 4F */
+		tpm_write_index(TPM_LOCK_REG, TPM_UNLOCK_VALUE);
+		tpm_write_index(TPM_INTERUPT_REG, TPM_DISABLE_INTERUPT_VALUE);
+		tpm_write_index(TPM_BASE_ADDR_LO, base);
+		tpm_write_index(TPM_BASE_ADDR_HI, (base & 0xFF00) >> 8); 
+		tpm_write_index(TPM_LOCK_REG, TPM_LOCK_VALUE);
 		break;
 	case PCI_VENDOR_ID_AMD:
 		/* nothing yet */
@@ -121,31 +137,34 @@ EXPORT_SYMBOL_GPL(tpm_lpc_bus_init);
 /*
  * Internal kernel interface to transmit TPM commands
  */
-static ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
-			    size_t bufsiz)
+static ssize_t
+tpm_transmit(struct tpm_chip *chip, const char *buf, size_t bufsiz)
 {
-	ssize_t len;
+	ssize_t rc;
 	u32 count;
-	__be32 *native_size;
 	unsigned long stop;
 
-	native_size = (__force __be32 *) (buf + 2);
-	count = be32_to_cpu(*native_size);
+	count = be32_to_cpu(*((__be32 *) (buf + 2)));
 
 	if (count == 0)
 		return -ENODATA;
 	if (count > bufsiz) {
-		dev_err(&chip->pci_dev->dev,
+		dev_err(chip->dev,
 			"invalid count value %x %Zx\n", count, bufsiz);
 		return -E2BIG;
 	}
 
+	dev_dbg(chip->dev, "TPM Ordinal: %d\n",
+		be32_to_cpu(*((__be32 *) (buf + 6))));
+	dev_dbg(chip->dev, "Chip Status: %x\n",
+		inb(chip->vendor->base + 1));
+
 	down(&chip->tpm_mutex);
 
-	if ((len = chip->vendor->send(chip, (u8 *) buf, count)) < 0) {
-		dev_err(&chip->pci_dev->dev,
-			"tpm_transmit: tpm_send: error %Zd\n", len);
-		return len;
+	if ((rc = chip->vendor->send(chip, (u8 *) buf, count)) < 0) {
+		dev_err(chip->dev,
+			"tpm_transmit: tpm_send: error %Zd\n", rc);
+		return rc;
 	}
 
 	stop = jiffies + 2 * 60 * HZ;
@@ -155,28 +174,37 @@ static ssize_t tpm_transmit(struct tpm_c
 		    chip->vendor->req_complete_val) {
 			goto out_recv;
 		}
+
+		if ((status == chip->vendor->req_canceled)) {
+			dev_err(chip->dev, "Operation Canceled\n");
+			rc = -ECANCELED;
+			goto out;
+		}
+
 		msleep(TPM_TIMEOUT);	/* CHECK */
 		rmb();
-	} while (time_before(jiffies, stop));
+	}
+	while (time_before(jiffies, stop));
 
 
 	chip->vendor->cancel(chip);
-	dev_err(&chip->pci_dev->dev, "Time expired\n");
-	up(&chip->tpm_mutex);
-	return -EIO;
+	dev_err(chip->dev, "Operation Timed out\n");
+	rc = -ETIME;
+	goto out;
 
 out_recv:
-	len = chip->vendor->recv(chip, (u8 *) buf, bufsiz);
-	if (len < 0)
-		dev_err(&chip->pci_dev->dev,
-			"tpm_transmit: tpm_recv: error %Zd\n", len);
+	rc = chip->vendor->recv(chip, (u8 *) buf, bufsiz);
+	if (rc < 0)
+		dev_err(chip->dev,
+			"tpm_transmit: tpm_recv: error %Zd\n", rc);
+out:
 	up(&chip->tpm_mutex);
-	return len;
+	return rc;
 }
 
 #define TPM_DIGEST_SIZE 20
 #define CAP_PCR_RESULT_SIZE 18
-static u8 cap_pcr[] = {
+static const u8 cap_pcr[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 22,		/* length */
 	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
@@ -186,31 +214,31 @@ static u8 cap_pcr[] = {
 };
 
 #define READ_PCR_RESULT_SIZE 30
-static u8 pcrread[] = {
+static const u8 pcrread[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 14,		/* length */
 	0, 0, 0, 21,		/* TPM_ORD_PcrRead */
 	0, 0, 0, 0		/* PCR index */
 };
 
-static ssize_t show_pcrs(struct device *dev, char *buf)
+ssize_t tpm_show_pcrs(struct device *dev, char *buf)
 {
 	u8 data[READ_PCR_RESULT_SIZE];
 	ssize_t len;
-	int i, j, index, num_pcrs;
+	int i, j, num_pcrs;
+	__be32 index;
 	char *str = buf;
 
-	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	struct tpm_chip *chip = dev_get_drvdata(dev);
 	if (chip == NULL)
 		return -ENODEV;
 
 	memcpy(data, cap_pcr, sizeof(cap_pcr));
-	if ((len = tpm_transmit(chip, data, sizeof(data)))
-	    < CAP_PCR_RESULT_SIZE)
+	if ((len =
+	     tpm_transmit(chip, data, sizeof(data))) < CAP_PCR_RESULT_SIZE)
 		return len;
 
-	num_pcrs = be32_to_cpu(*((__force __be32 *) (data + 14)));
+	num_pcrs = be32_to_cpu(*((__be32 *) (data + 14)));
 
 	for (i = 0; i < num_pcrs; i++) {
 		memcpy(data, pcrread, sizeof(pcrread));
@@ -227,34 +255,38 @@ static ssize_t show_pcrs(struct device *
 	return str - buf;
 }
 
-static DEVICE_ATTR(pcrs, S_IRUGO, show_pcrs, NULL);
+EXPORT_SYMBOL_GPL(tpm_show_pcrs);
 
 #define  READ_PUBEK_RESULT_SIZE 314
-static u8 readpubek[] = {
+static const u8 readpubek[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 30,		/* length */
 	0, 0, 0, 124,		/* TPM_ORD_ReadPubek */
 };
 
-static ssize_t show_pubek(struct device *dev, char *buf)
+ssize_t tpm_show_pubek(struct device *dev, char *buf)
 {
-	u8 data[READ_PUBEK_RESULT_SIZE];
+	u8 *data;
 	ssize_t len;
-	__be32 *native_val;
-	int i;
+	int i, rc;
 	char *str = buf;
 
-	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	struct tpm_chip *chip = dev_get_drvdata(dev);
 	if (chip == NULL)
 		return -ENODEV;
 
+	data = kmalloc(READ_PUBEK_RESULT_SIZE, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	memcpy(data, readpubek, sizeof(readpubek));
 	memset(data + sizeof(readpubek), 0, 20);	/* zero nonce */
 
-	if ((len = tpm_transmit(chip, data, sizeof(data))) <
-	    READ_PUBEK_RESULT_SIZE)
-		return len;
+	if ((len = tpm_transmit(chip, data, READ_PUBEK_RESULT_SIZE)) <
+	    READ_PUBEK_RESULT_SIZE) {
+		rc = len;
+		goto out;
+	}
 
 	/* 
 	   ignore header 10 bytes
@@ -267,8 +299,6 @@ static ssize_t show_pubek(struct device 
 	   ignore checksum 20 bytes
 	 */
 
-	native_val = (__force __be32 *) (data + 34);
-
 	str +=
 	    sprintf(str,
 		    "Algorithm: %02X %02X %02X %02X\nEncscheme: %02X %02X\n"
@@ -279,21 +309,23 @@ static ssize_t show_pubek(struct device 
 		    data[15], data[16], data[17], data[22], data[23],
 		    data[24], data[25], data[26], data[27], data[28],
 		    data[29], data[30], data[31], data[32], data[33],
-		    be32_to_cpu(*native_val)
-	    );
+		    be32_to_cpu(*((__be32 *) (data + 32))));
 
 	for (i = 0; i < 256; i++) {
 		str += sprintf(str, "%02X ", data[i + 39]);
 		if ((i + 1) % 16 == 0)
 			str += sprintf(str, "\n");
 	}
-	return str - buf;
+	rc = str - buf;
+      out:
+	kfree(data);
+	return rc;
 }
 
-static DEVICE_ATTR(pubek, S_IRUGO, show_pubek, NULL);
+EXPORT_SYMBOL_GPL(tpm_show_pubek);
 
 #define CAP_VER_RESULT_SIZE 18
-static u8 cap_version[] = {
+static const u8 cap_version[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 18,		/* length */
 	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
@@ -302,7 +334,7 @@ static u8 cap_version[] = {
 };
 
 #define CAP_MANUFACTURER_RESULT_SIZE 18
-static u8 cap_manufacturer[] = {
+static const u8 cap_manufacturer[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 22,		/* length */
 	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
@@ -311,14 +343,13 @@ static u8 cap_manufacturer[] = {
 	0, 0, 1, 3
 };
 
-static ssize_t show_caps(struct device *dev, char *buf)
+ssize_t tpm_show_caps(struct device *dev, char *buf)
 {
-	u8 data[READ_PUBEK_RESULT_SIZE];
+	u8 data[sizeof(cap_manufacturer)];
 	ssize_t len;
 	char *str = buf;
 
-	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	struct tpm_chip *chip = dev_get_drvdata(dev);
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -329,12 +360,12 @@ static ssize_t show_caps(struct device *
 		return len;
 
 	str += sprintf(str, "Manufacturer: 0x%x\n",
-		       be32_to_cpu(*(data + 14)));
+		       be32_to_cpu(*((__be32 *) (data + 14))));
 
 	memcpy(data, cap_version, sizeof(cap_version));
 
-	if ((len = tpm_transmit(chip, data, sizeof(data))) <
-	    CAP_VER_RESULT_SIZE)
+	if ((len =
+	     tpm_transmit(chip, data, sizeof(data))) < CAP_VER_RESULT_SIZE)
 		return len;
 
 	str +=
@@ -345,7 +376,21 @@ static ssize_t show_caps(struct device *
 	return str - buf;
 }
 
-static DEVICE_ATTR(caps, S_IRUGO, show_caps, NULL);
+EXPORT_SYMBOL_GPL(tpm_show_caps);
+
+ssize_t tpm_store_cancel(struct device * dev, const char *buf,
+			 size_t count)
+{
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	if (chip == NULL)
+		return 0;
+
+	chip->vendor->cancel(chip);
+	return count;
+}
+
+EXPORT_SYMBOL_GPL(tpm_store_cancel);
+
 
 /*
  * Device file system interface to the TPM
@@ -370,21 +415,20 @@ int tpm_open(struct inode *inode, struct
 	}
 
 	if (chip->num_opens) {
-		dev_dbg(&chip->pci_dev->dev,
-			"Another process owns this TPM\n");
+		dev_dbg(chip->dev, "Another process owns this TPM\n");
 		rc = -EBUSY;
 		goto err_out;
 	}
 
 	chip->num_opens++;
-	pci_dev_get(chip->pci_dev);
+	get_device(chip->dev);
 
 	spin_unlock(&driver_lock);
 
 	chip->data_buffer = kmalloc(TPM_BUFSIZE * sizeof(u8), GFP_KERNEL);
 	if (chip->data_buffer == NULL) {
 		chip->num_opens--;
-		pci_dev_put(chip->pci_dev);
+		put_device(chip->dev);
 		return -ENOMEM;
 	}
 
@@ -404,30 +448,22 @@ int tpm_release(struct inode *inode, str
 {
 	struct tpm_chip *chip = file->private_data;
 
-	file->private_data = NULL;
-
 	spin_lock(&driver_lock);
+	file->private_data = NULL;
 	chip->num_opens--;
-	spin_unlock(&driver_lock);
-
-	down(&chip->timer_manipulation_mutex);
-	if (timer_pending(&chip->user_read_timer))
-		del_singleshot_timer_sync(&chip->user_read_timer);
-	else if (timer_pending(&chip->device_timer))
-		del_singleshot_timer_sync(&chip->device_timer);
-	up(&chip->timer_manipulation_mutex);
-
-	kfree(chip->data_buffer);
+	del_singleshot_timer_sync(&chip->user_read_timer);
 	atomic_set(&chip->data_pending, 0);
-
-	pci_dev_put(chip->pci_dev);
+	put_device(chip->dev);
+	kfree(chip->data_buffer);
+	spin_unlock(&driver_lock);
 	return 0;
 }
 
 EXPORT_SYMBOL_GPL(tpm_release);
 
-ssize_t tpm_write(struct file * file, const char __user * buf,
-		  size_t size, loff_t * off)
+ssize_t
+tpm_write(struct file * file, const char __user * buf,
+	  size_t size, loff_t * off)
 {
 	struct tpm_chip *chip = file->private_data;
 	int in_size = size, out_size;
@@ -455,46 +491,30 @@ ssize_t tpm_write(struct file * file, co
 	up(&chip->buffer_mutex);
 
 	/* Set a timeout by which the reader must come claim the result */
-	down(&chip->timer_manipulation_mutex);
-	init_timer(&chip->user_read_timer);
-	chip->user_read_timer.function = user_reader_timeout;
-	chip->user_read_timer.data = (unsigned long) chip;
-	chip->user_read_timer.expires = jiffies + (60 * HZ);
-	add_timer(&chip->user_read_timer);
-	up(&chip->timer_manipulation_mutex);
+	mod_timer(&chip->user_read_timer, jiffies + (60 * HZ));
 
 	return in_size;
 }
 
 EXPORT_SYMBOL_GPL(tpm_write);
 
-ssize_t tpm_read(struct file * file, char __user * buf,
-		 size_t size, loff_t * off)
+ssize_t
+tpm_read(struct file * file, char __user * buf, size_t size, loff_t * off)
 {
 	struct tpm_chip *chip = file->private_data;
-	int ret_size = -ENODATA;
+	int ret_size;
 
-	if (atomic_read(&chip->data_pending) != 0) {	/* Result available */
-		down(&chip->timer_manipulation_mutex);
-		del_singleshot_timer_sync(&chip->user_read_timer);
-		up(&chip->timer_manipulation_mutex);
+	del_singleshot_timer_sync(&chip->user_read_timer);
+	ret_size = atomic_read(&chip->data_pending);
+	atomic_set(&chip->data_pending, 0);
+	if (ret_size > 0) {	/* relay data */
+		if (size < ret_size)
+			ret_size = size;
 
 		down(&chip->buffer_mutex);
-
-		ret_size = atomic_read(&chip->data_pending);
-		atomic_set(&chip->data_pending, 0);
-
-		if (ret_size == 0)	/* timeout just occurred */
-			ret_size = -ETIME;
-		else if (ret_size > 0) {	/* relay data */
-			if (size < ret_size)
-				ret_size = size;
-
-			if (copy_to_user((void __user *) buf,
-					 chip->data_buffer, ret_size)) {
-				ret_size = -EFAULT;
-			}
-		}
+		if (copy_to_user
+		    ((void __user *) buf, chip->data_buffer, ret_size))
+			ret_size = -EFAULT;
 		up(&chip->buffer_mutex);
 	}
 
@@ -503,12 +523,13 @@ ssize_t tpm_read(struct file * file, cha
 
 EXPORT_SYMBOL_GPL(tpm_read);
 
-void __devexit tpm_remove(struct pci_dev *pci_dev)
+void tpm_remove_hardware(struct device *dev)
 {
-	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	int i;
 
 	if (chip == NULL) {
-		dev_err(&pci_dev->dev, "No device data found\n");
+		dev_err(dev, "No device data found\n");
 		return;
 	}
 
@@ -518,23 +539,20 @@ void __devexit tpm_remove(struct pci_dev
 
 	spin_unlock(&driver_lock);
 
-	pci_set_drvdata(pci_dev, NULL);
+	dev_set_drvdata(dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
 
-	device_remove_file(&pci_dev->dev, &dev_attr_pubek);
-	device_remove_file(&pci_dev->dev, &dev_attr_pcrs);
-	device_remove_file(&pci_dev->dev, &dev_attr_caps);
-
-	pci_disable_device(pci_dev);
+	for (i = 0; i < TPM_NUM_ATTR; i++)
+		device_remove_file(dev, &chip->vendor->attr[i]);
 
 	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
 
 	kfree(chip);
 
-	pci_dev_put(pci_dev);
+	put_device(dev);
 }
 
-EXPORT_SYMBOL_GPL(tpm_remove);
+EXPORT_SYMBOL_GPL(tpm_remove_hardware);
 
 static u8 savestate[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
@@ -565,7 +583,6 @@ EXPORT_SYMBOL_GPL(tpm_pm_suspend);
 int tpm_pm_resume(struct pci_dev *pci_dev)
 {
 	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
-
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -585,8 +602,9 @@ EXPORT_SYMBOL_GPL(tpm_pm_resume);
  * upon errant exit from this function specific probe function should call
  * pci_disable_device
  */
-int tpm_register_hardware(struct pci_dev *pci_dev,
-			  struct tpm_vendor_specific *entry)
+int
+tpm_register_hardware(struct device *dev,
+		      struct tpm_vendor_specific *entry)
 {
 	char devname[7];
 	struct tpm_chip *chip;
@@ -601,25 +619,28 @@ int tpm_register_hardware(struct pci_dev
 
 	init_MUTEX(&chip->buffer_mutex);
 	init_MUTEX(&chip->tpm_mutex);
-	init_MUTEX(&chip->timer_manipulation_mutex);
 	INIT_LIST_HEAD(&chip->list);
 
+	init_timer(&chip->user_read_timer);
+	chip->user_read_timer.function = user_reader_timeout;
+	chip->user_read_timer.data = (unsigned long) chip;
+
 	chip->vendor = entry;
 
 	chip->dev_num = -1;
 
-	for (i = 0; i < 32; i++)
-		for (j = 0; j < 8; j++)
+	for (i = 0; i < TPM_NUM_MASK_ENTRIES; i++)
+		for (j = 0; j < 8 * sizeof(int); j++)
 			if ((dev_mask[i] & (1 << j)) == 0) {
-				chip->dev_num = i * 32 + j;
+				chip->dev_num =
+				    i * TPM_NUM_MASK_ENTRIES + j;
 				dev_mask[i] |= 1 << j;
 				goto dev_num_search_complete;
 			}
 
 dev_num_search_complete:
 	if (chip->dev_num < 0) {
-		dev_err(&pci_dev->dev,
-			"No available tpm device numbers\n");
+		dev_err(dev, "No available tpm device numbers\n");
 		kfree(chip);
 		return -ENODEV;
 	} else if (chip->dev_num == 0)
@@ -630,46 +651,36 @@ dev_num_search_complete:
 	snprintf(devname, sizeof(devname), "%s%d", "tpm", chip->dev_num);
 	chip->vendor->miscdev.name = devname;
 
-	chip->vendor->miscdev.dev = &(pci_dev->dev);
-	chip->pci_dev = pci_dev_get(pci_dev);
+	chip->vendor->miscdev.dev = dev;
+	chip->dev = get_device(dev);
+
+	spin_lock(&driver_lock);
 
 	if (misc_register(&chip->vendor->miscdev)) {
-		dev_err(&chip->pci_dev->dev,
+		dev_err(chip->dev,
 			"unable to misc_register %s, minor %d\n",
 			chip->vendor->miscdev.name,
 			chip->vendor->miscdev.minor);
-		pci_dev_put(pci_dev);
+		put_device(dev);
+		spin_unlock(&driver_lock);
 		kfree(chip);
 		dev_mask[i] &= !(1 << j);
 		return -ENODEV;
 	}
 
-	pci_set_drvdata(pci_dev, chip);
+	dev_set_drvdata(dev, chip);
 
 	list_add(&chip->list, &tpm_chip_list);
 
-	device_create_file(&pci_dev->dev, &dev_attr_pubek);
-	device_create_file(&pci_dev->dev, &dev_attr_pcrs);
-	device_create_file(&pci_dev->dev, &dev_attr_caps);
+	for (i = 0; i < TPM_NUM_ATTR; i++)
+		device_create_file(dev, &chip->vendor->attr[i]);
 
+	spin_unlock(&driver_lock);
 	return 0;
 }
 
 EXPORT_SYMBOL_GPL(tpm_register_hardware);
 
-static int __init init_tpm(void)
-{
-	return 0;
-}
-
-static void __exit cleanup_tpm(void)
-{
-
-}
-
-module_init(init_tpm);
-module_exit(cleanup_tpm);
-
 MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
 MODULE_DESCRIPTION("TPM Driver");
 MODULE_VERSION("2.0");
diff -uprN linux-2.6.12-rc2/drivers/char/tpm/tpm.h linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.h
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.h	2005-04-15 15:13:29.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.h	2005-04-15 16:25:18.000000000 -0500
@@ -25,27 +25,46 @@
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 
-#define TPM_TIMEOUT    5       /* msecs */
+enum {
+	TPM_TIMEOUT = 5,	/* msecs */
+	TPM_NUM_ATTR = 4
+};
 
 /* TPM addresses */
-#define	TPM_ADDR			0x4E
-#define	TPM_DATA			0x4F
+enum {
+	TPM_ADDR = 0x4E,
+	TPM_DATA = 0x4F
+};
+
+extern ssize_t tpm_show_pubek(struct device *, char *);
+extern ssize_t tpm_show_pcrs(struct device *, char *);
+extern ssize_t tpm_show_caps(struct device *, char *);
+extern ssize_t tpm_store_cancel(struct device *, const char *, size_t);
+
+#define TPM_DEVICE_ATTRS { \
+        __ATTR(pubek, S_IRUGO, tpm_show_pubek, NULL), \
+        __ATTR(pcrs, S_IRUGO, tpm_show_pcrs, NULL), \
+        __ATTR(caps, S_IRUGO, tpm_show_caps, NULL), \
+        __ATTR(cancel, S_IWUSR | S_IWGRP, NULL, tpm_store_cancel) }
 
 struct tpm_chip;
 
 struct tpm_vendor_specific {
 	u8 req_complete_mask;
 	u8 req_complete_val;
+	u8 req_canceled;
 	u16 base;		/* TPM base address */
 
 	int (*recv) (struct tpm_chip *, u8 *, size_t);
 	int (*send) (struct tpm_chip *, u8 *, size_t);
 	void (*cancel) (struct tpm_chip *);
+	 u8(*status) (struct tpm_chip *);
 	struct miscdevice miscdev;
+	struct device_attribute attr[TPM_NUM_ATTR];
 };
 
 struct tpm_chip {
-	struct pci_dev *pci_dev;	/* PCI device stuff */
+	struct device *dev;	/* device stuff */
 
 	int dev_num;		/* /dev/tpm# */
 	int num_opens;		/* only one allowed */
@@ -58,8 +77,6 @@ struct tpm_chip {
 
 	struct timer_list user_read_timer;	/* user needs to claim result */
 	struct semaphore tpm_mutex;	/* tpm is processing */
-	struct timer_list device_timer;	/* tpm is processing */
-	struct semaphore timer_manipulation_mutex;
 
 	struct tpm_vendor_specific *vendor;
 
@@ -80,8 +97,9 @@ static inline void tpm_write_index(int i
 
 extern int tpm_lpc_bus_init(struct pci_dev *, u16);
 
-extern int tpm_register_hardware(struct pci_dev *,
+extern int tpm_register_hardware(struct device *,
 				 struct tpm_vendor_specific *);
+extern void tpm_remove_hardware(struct device *);
 extern int tpm_open(struct inode *, struct file *);
 extern int tpm_release(struct inode *, struct file *);
 extern ssize_t tpm_write(struct file *, const char __user *, size_t,
diff -uprN linux-2.6.12-rc2/drivers/char/tpm/tpm_nsc.c linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_nsc.c
--- linux-2.6.12-rc2/drivers/char/tpm/tpm_nsc.c	2005-04-15 16:31:31.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_nsc.c	2005-04-15 16:26:28.000000000 -0500
@@ -22,34 +22,42 @@
 #include "tpm.h"
 
 /* National definitions */
-#define	TPM_NSC_BASE			0x360
-#define	TPM_NSC_IRQ			0x07
+enum {
+	TPM_NSC_BASE = 0x360,
+	TPM_NSC_IRQ = 0x07
+};
 
-#define	NSC_LDN_INDEX			0x07
-#define	NSC_SID_INDEX			0x20
-#define	NSC_LDC_INDEX			0x30
-#define	NSC_DIO_INDEX			0x60
-#define	NSC_CIO_INDEX			0x62
-#define	NSC_IRQ_INDEX			0x70
-#define	NSC_ITS_INDEX			0x71
-
-#define	NSC_STATUS			0x01
-#define	NSC_COMMAND			0x01
-#define	NSC_DATA			0x00
+enum {
+	NSC_LDN_INDEX = 0x07,
+	NSC_SID_INDEX = 0x20,
+	NSC_LDC_INDEX = 0x30,
+	NSC_DIO_INDEX = 0x60,
+	NSC_CIO_INDEX = 0x62,
+	NSC_IRQ_INDEX = 0x70,
+	NSC_ITS_INDEX = 0x71
+};
 
-/* status bits */
-#define	NSC_STATUS_OBF			0x01	/* output buffer full */
-#define	NSC_STATUS_IBF			0x02	/* input buffer full */
-#define	NSC_STATUS_F0			0x04	/* F0 */
-#define	NSC_STATUS_A2			0x08	/* A2 */
-#define	NSC_STATUS_RDY			0x10	/* ready to receive command */
-#define	NSC_STATUS_IBR			0x20	/* ready to receive data */
+enum {
+	NSC_STATUS = 0x01,
+	NSC_COMMAND = 0x01,
+	NSC_DATA = 0x00
+};
 
+/* status bits */
+enum {
+	NSC_STATUS_OBF = 0x01,	/* output buffer full */
+	NSC_STATUS_IBF = 0x02,	/* input buffer full */
+	NSC_STATUS_F0 = 0x04,	/* F0 */
+	NSC_STATUS_A2 = 0x08,	/* A2 */
+	NSC_STATUS_RDY = 0x10,	/* ready to receive command */
+	NSC_STATUS_IBR = 0x20	/* ready to receive data */
+};
 /* command bits */
-#define	NSC_COMMAND_NORMAL		0x01	/* normal mode */
-#define	NSC_COMMAND_EOC			0x03
-#define	NSC_COMMAND_CANCEL		0x22
-
+enum {
+	NSC_COMMAND_NORMAL = 0x01,	/* normal mode */
+	NSC_COMMAND_EOC = 0x03,
+	NSC_COMMAND_CANCEL = 0x22
+};
 /*
  * Wait for a certain status to appear
  */
@@ -99,7 +107,7 @@ static int nsc_wait_for_ready(struct tpm
 	}
 	while (time_before(jiffies, stop));
 
-	dev_info(&chip->pci_dev->dev, "wait for ready failed\n");
+	dev_info(chip->dev, "wait for ready failed\n");
 	return -EBUSY;
 }
 
@@ -115,13 +123,12 @@ static int tpm_nsc_recv(struct tpm_chip 
 		return -EIO;
 
 	if (wait_for_stat(chip, NSC_STATUS_F0, NSC_STATUS_F0, &data) < 0) {
-		dev_err(&chip->pci_dev->dev, "F0 timeout\n");
+		dev_err(chip->dev, "F0 timeout\n");
 		return -EIO;
 	}
 	if ((data =
 	     inb(chip->vendor->base + NSC_DATA)) != NSC_COMMAND_NORMAL) {
-		dev_err(&chip->pci_dev->dev, "not in normal mode (0x%x)\n",
-			data);
+		dev_err(chip->dev, "not in normal mode (0x%x)\n", data);
 		return -EIO;
 	}
 
@@ -129,7 +136,7 @@ static int tpm_nsc_recv(struct tpm_chip 
 	for (p = buffer; p < &buffer[count]; p++) {
 		if (wait_for_stat
 		    (chip, NSC_STATUS_OBF, NSC_STATUS_OBF, &data) < 0) {
-			dev_err(&chip->pci_dev->dev,
+			dev_err(chip->dev,
 				"OBF timeout (while reading data)\n");
 			return -EIO;
 		}
@@ -139,11 +146,11 @@ static int tpm_nsc_recv(struct tpm_chip 
 	}
 
 	if ((data & NSC_STATUS_F0) == 0) {
-		dev_err(&chip->pci_dev->dev, "F0 not set\n");
+		dev_err(chip->dev, "F0 not set\n");
 		return -EIO;
 	}
 	if ((data = inb(chip->vendor->base + NSC_DATA)) != NSC_COMMAND_EOC) {
-		dev_err(&chip->pci_dev->dev,
+		dev_err(chip->dev,
 			"expected end of command(0x%x)\n", data);
 		return -EIO;
 	}
@@ -174,19 +181,19 @@ static int tpm_nsc_send(struct tpm_chip 
 		return -EIO;
 
 	if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
-		dev_err(&chip->pci_dev->dev, "IBF timeout\n");
+		dev_err(chip->dev, "IBF timeout\n");
 		return -EIO;
 	}
 
 	outb(NSC_COMMAND_NORMAL, chip->vendor->base + NSC_COMMAND);
 	if (wait_for_stat(chip, NSC_STATUS_IBR, NSC_STATUS_IBR, &data) < 0) {
-		dev_err(&chip->pci_dev->dev, "IBR timeout\n");
+		dev_err(chip->dev, "IBR timeout\n");
 		return -EIO;
 	}
 
 	for (i = 0; i < count; i++) {
 		if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
-			dev_err(&chip->pci_dev->dev,
+			dev_err(chip->dev,
 				"IBF timeout (while writing data)\n");
 			return -EIO;
 		}
@@ -194,7 +201,7 @@ static int tpm_nsc_send(struct tpm_chip 
 	}
 
 	if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
-		dev_err(&chip->pci_dev->dev, "IBF timeout\n");
+		dev_err(chip->dev, "IBF timeout\n");
 		return -EIO;
 	}
 	outb(NSC_COMMAND_EOC, chip->vendor->base + NSC_COMMAND);
@@ -207,6 +214,11 @@ static void tpm_nsc_cancel(struct tpm_ch
 	outb(NSC_COMMAND_CANCEL, chip->vendor->base + NSC_COMMAND);
 }
 
+static u8 tpm_nsc_status(struct tpm_chip *chip)
+{
+	return inb(chip->vendor->base + NSC_STATUS);
+}
+
 static struct file_operations nsc_ops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
@@ -220,22 +232,48 @@ static struct tpm_vendor_specific tpm_ns
 	.recv = tpm_nsc_recv,
 	.send = tpm_nsc_send,
 	.cancel = tpm_nsc_cancel,
+	.status = tpm_nsc_status,
 	.req_complete_mask = NSC_STATUS_OBF,
 	.req_complete_val = NSC_STATUS_OBF,
+	.req_canceled = NSC_STATUS_RDY,
 	.base = TPM_NSC_BASE,
-	.miscdev = {.fops = &nsc_ops,},
+	.attr = TPM_DEVICE_ATTRS,
+	.miscdev.fops = &nsc_ops,
+};
 
+static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
+	{0,}
 };
 
-static int __devinit tpm_nsc_init(struct pci_dev *pci_dev,
-				  const struct pci_device_id *pci_id)
+MODULE_DEVICE_TABLE(pci, tpm_pci_tbl);
+
+static struct pci_dev *nsc_tpm;
+
+static int __init init_nsc(void)
 {
 	int rc = 0;
+	struct pci_dev *dev = NULL;
+
+	while ((dev =
+		pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+		if (pci_match_device(tpm_pci_tbl, dev)) {
+			nsc_tpm = dev;
+			break;
+		}
+
+	if (!nsc_tpm)
+		return -ENODEV;
 
-	if (pci_enable_device(pci_dev))
+	if (pci_enable_device(nsc_tpm))
 		return -EIO;
 
-	if (tpm_lpc_bus_init(pci_dev, TPM_NSC_BASE)) {
+	if (tpm_lpc_bus_init(nsc_tpm, TPM_NSC_BASE)) {
 		rc = -ENODEV;
 		goto out_err;
 	}
@@ -246,27 +284,27 @@ static int __devinit tpm_nsc_init(struct
 		goto out_err;
 	}
 
-	dev_dbg(&pci_dev->dev, "NSC TPM detected\n");
-	dev_dbg(&pci_dev->dev,
+	dev_dbg(&nsc_tpm->dev, "NSC TPM detected\n");
+	dev_dbg(&nsc_tpm->dev,
 		"NSC LDN 0x%x, SID 0x%x, SRID 0x%x\n",
 		tpm_read_index(0x07), tpm_read_index(0x20),
 		tpm_read_index(0x27));
-	dev_dbg(&pci_dev->dev,
+	dev_dbg(&nsc_tpm->dev,
 		"NSC SIOCF1 0x%x SIOCF5 0x%x SIOCF6 0x%x SIOCF8 0x%x\n",
 		tpm_read_index(0x21), tpm_read_index(0x25),
 		tpm_read_index(0x26), tpm_read_index(0x28));
-	dev_dbg(&pci_dev->dev, "NSC IO Base0 0x%x\n",
+	dev_dbg(&nsc_tpm->dev, "NSC IO Base0 0x%x\n",
 		(tpm_read_index(0x60) << 8) | tpm_read_index(0x61));
-	dev_dbg(&pci_dev->dev, "NSC IO Base1 0x%x\n",
+	dev_dbg(&nsc_tpm->dev, "NSC IO Base1 0x%x\n",
 		(tpm_read_index(0x62) << 8) | tpm_read_index(0x63));
-	dev_dbg(&pci_dev->dev, "NSC Interrupt number and wakeup 0x%x\n",
+	dev_dbg(&nsc_tpm->dev, "NSC Interrupt number and wakeup 0x%x\n",
 		tpm_read_index(0x70));
-	dev_dbg(&pci_dev->dev, "NSC IRQ type select 0x%x\n",
+	dev_dbg(&nsc_tpm->dev, "NSC IRQ type select 0x%x\n",
 		tpm_read_index(0x71));
-	dev_dbg(&pci_dev->dev,
+	dev_dbg(&nsc_tpm->dev,
 		"NSC DMA channel select0 0x%x, select1 0x%x\n",
 		tpm_read_index(0x74), tpm_read_index(0x75));
-	dev_dbg(&pci_dev->dev,
+	dev_dbg(&nsc_tpm->dev,
 		"NSC Config "
 		"0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
 		tpm_read_index(0xF0), tpm_read_index(0xF1),
@@ -275,12 +313,12 @@ static int __devinit tpm_nsc_init(struct
 		tpm_read_index(0xF6), tpm_read_index(0xF7),
 		tpm_read_index(0xF8), tpm_read_index(0xF9));
 
-	dev_info(&pci_dev->dev,
+	dev_info(&nsc_tpm->dev,
 		 "NSC PC21100 TPM revision %d\n",
 		 tpm_read_index(0x27) & 0x1F);
 
 	if (tpm_read_index(NSC_LDC_INDEX) == 0)
-		dev_info(&pci_dev->dev, ": NSC TPM not active\n");
+		dev_info(&nsc_tpm->dev, ": NSC TPM not active\n");
 
 	/* select PM channel 1 */
 	tpm_write_index(NSC_LDN_INDEX, 0x12);
@@ -311,45 +349,20 @@ static int __devinit tpm_nsc_init(struct
 	tpm_write_index(NSC_LDC_INDEX, 0x01);
 	tpm_read_index(NSC_LDC_INDEX);
 
-	if ((rc = tpm_register_hardware(pci_dev, &tpm_nsc)) < 0)
+	if ((rc = tpm_register_hardware(&nsc_tpm->dev, &tpm_nsc)) < 0)
 		goto out_err;
 
 	return 0;
 
 out_err:
-	pci_disable_device(pci_dev);
+	pci_disable_device(nsc_tpm);
 	return rc;
 }
 
-static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
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
-	.remove = __devexit_p(tpm_remove),
-	.suspend = tpm_pm_suspend,
-	.resume = tpm_pm_resume,
-};
-
-static int __init init_nsc(void)
-{
-	return pci_register_driver(&nsc_pci_driver);
-}
-
 static void __exit cleanup_nsc(void)
 {
-	pci_unregister_driver(&nsc_pci_driver);
+	tpm_remove_hardware(&nsc_tpm->dev);
+	pci_disable_device(nsc_tpm);
 }
 
 module_init(init_nsc);
diff -uprN linux-2.6.12-rc2/MAINTAINERS linux-2.6.12-rc2-tpmdd/MAINTAINERS
--- linux-2.6.12-rc2/MAINTAINERS	2005-04-04 11:38:36.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/MAINTAINERS	2005-04-14 14:45:57.000000000 -0500
@@ -2116,6 +2116,13 @@ M:	perex@suse.cz
 L:	alsa-devel@alsa-project.org
 S:	Maintained
 
+TPM DEVICE DRIVER
+P:	Kylene Hall
+M:	kjhall@us.ibm.com
+W:	http://tpmdd.sourceforge.net
+L:	tpmdd-devel@lists.sourceforge.net
+S:	Maintained
+
 UltraSPARC (sparc64):
 P:	David S. Miller
 M:	davem@davemloft.net
