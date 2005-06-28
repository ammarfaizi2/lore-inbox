Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVF1PMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVF1PMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 11:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVF1PMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 11:12:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:62171 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262023AbVF1PJJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 11:09:09 -0400
Subject: Re: 2.6.12 breaks 8139cp
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com, tpmdd-devel@lists.sourceforge.net
In-Reply-To: <42C16162.2070208@drzeus.cx>
References: <42B9D21F.7040908@drzeus.cx>
	 <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx>
	 <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx>
	 <42C0EE1A.9050809@drzeus.cx>  <42C1434F.2010003@drzeus.cx>
	 <1119967788.6382.7.camel@localhost.localdomain>
	 <42C16162.2070208@drzeus.cx>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 10:08:59 -0500
Message-Id: <1119971339.6382.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You wouldn't happen to have just your patches available?

Here is the tpm portion of -mm patch

--- linux-2.6.12/drivers/char/tpm/tpm_atmel.c	2005-06-17 16:03:59.000000000 -0700
+++ 25/drivers/char/tpm/tpm_atmel.c	2005-06-26 02:20:35.000000000 -0700
@@ -22,17 +22,23 @@
 #include "tpm.h"
 
 /* Atmel definitions */
-#define	TPM_ATML_BASE			0x400
+enum tpm_atmel_addr {
+	TPM_ATMEL_BASE_ADDR_LO = 0x08,
+	TPM_ATMEL_BASE_ADDR_HI = 0x09
+};
 
 /* write status bits */
-#define	ATML_STATUS_ABORT		0x01
-#define	ATML_STATUS_LASTBYTE		0x04
-
+enum tpm_atmel_write_status {
+	ATML_STATUS_ABORT = 0x01,
+	ATML_STATUS_LASTBYTE = 0x04
+};
 /* read status bits */
-#define	ATML_STATUS_BUSY		0x01
-#define	ATML_STATUS_DATA_AVAIL		0x02
-#define	ATML_STATUS_REWRITE		0x04
-
+enum tpm_atmel_read_status {
+	ATML_STATUS_BUSY = 0x01,
+	ATML_STATUS_DATA_AVAIL = 0x02,
+	ATML_STATUS_REWRITE = 0x04,
+	ATML_STATUS_READY = 0x08
+};
 
 static int tpm_atml_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 {
@@ -121,13 +127,29 @@ static struct file_operations atmel_ops 
 	.release = tpm_release,
 };
 
+static DEVICE_ATTR(pubek, S_IRUGO, tpm_show_pubek, NULL);
+static DEVICE_ATTR(pcrs, S_IRUGO, tpm_show_pcrs, NULL);
+static DEVICE_ATTR(caps, S_IRUGO, tpm_show_caps, NULL);
+static DEVICE_ATTR(cancel, S_IWUSR |S_IWGRP, NULL, tpm_store_cancel);
+
+static struct attribute* atmel_attrs[] = {
+	&dev_attr_pubek.attr,
+	&dev_attr_pcrs.attr,
+	&dev_attr_caps.attr,
+	&dev_attr_cancel.attr,
+	0,
+};
+
+static struct attribute_group atmel_attr_grp = { .attrs = atmel_attrs };
+
 static struct tpm_vendor_specific tpm_atmel = {
 	.recv = tpm_atml_recv,
 	.send = tpm_atml_send,
 	.cancel = tpm_atml_cancel,
 	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
 	.req_complete_val = ATML_STATUS_DATA_AVAIL,
-	.base = TPM_ATML_BASE,
+	.req_canceled = ATML_STATUS_READY,
+	.attr_group = &atmel_attr_grp,
 	.miscdev = { .fops = &atmel_ops, },
 };
 
@@ -136,27 +158,29 @@ static int __devinit tpm_atml_init(struc
 {
 	u8 version[4];
 	int rc = 0;
+	int lo, hi;
 
 	if (pci_enable_device(pci_dev))
 		return -EIO;
 
-	if (tpm_lpc_bus_init(pci_dev, TPM_ATML_BASE)) {
-		rc = -ENODEV;
-		goto out_err;
-	}
+	lo = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
+	hi = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
+
+	tpm_atmel.base = (hi<<8)|lo;
+	dev_dbg( &pci_dev->dev, "Operating with base: 0x%x\n", tpm_atmel.base);
 
 	/* verify that it is an Atmel part */
-	if (tpm_read_index(4) != 'A' || tpm_read_index(5) != 'T'
-	    || tpm_read_index(6) != 'M' || tpm_read_index(7) != 'L') {
+	if (tpm_read_index(TPM_ADDR, 4) != 'A' || tpm_read_index(TPM_ADDR, 5) != 'T'
+	    || tpm_read_index(TPM_ADDR, 6) != 'M' || tpm_read_index(TPM_ADDR, 7) != 'L') {
 		rc = -ENODEV;
 		goto out_err;
 	}
 
 	/* query chip for its version number */
-	if ((version[0] = tpm_read_index(0x00)) != 0xFF) {
-		version[1] = tpm_read_index(0x01);
-		version[2] = tpm_read_index(0x02);
-		version[3] = tpm_read_index(0x03);
+	if ((version[0] = tpm_read_index(TPM_ADDR, 0x00)) != 0xFF) {
+		version[1] = tpm_read_index(TPM_ADDR, 0x01);
+		version[2] = tpm_read_index(TPM_ADDR, 0x02);
+		version[3] = tpm_read_index(TPM_ADDR, 0x03);
 	} else {
 		dev_info(&pci_dev->dev, "version query failed\n");
 		rc = -ENODEV;
@@ -183,6 +207,7 @@ static struct pci_device_id tpm_pci_tbl[
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
+	{PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6LPC)},
 	{0,}
 };
 
--- linux-2.6.12/drivers/char/tpm/tpm.c	2005-06-17 16:03:59.000000000 -0700
+++ 25/drivers/char/tpm/tpm.c	2005-06-26 02:20:35.000000000 -0700
@@ -19,7 +19,7 @@
  * 
  * Note, the TPM chip is not interrupt driven (only polling)
  * and can have very long timeouts (minutes!). Hence the unusual
- * calls to schedule_timeout.
+ * calls to msleep.
  *
  */
 
@@ -28,19 +28,16 @@
 #include <linux/spinlock.h>
 #include "tpm.h"
 
-#define	TPM_MINOR			224	/* officially assigned */
-
-#define	TPM_BUFSIZE			2048
-
-/* PCI configuration addresses */
-#define	PCI_GEN_PMCON_1			0xA0
-#define	PCI_GEN1_DEC			0xE4
-#define	PCI_LPC_EN			0xE6
-#define	PCI_GEN2_DEC			0xEC
+enum tpm_const {
+	TPM_MINOR = 224,	/* officially assigned */
+	TPM_BUFSIZE = 2048,
+	TPM_NUM_DEVICES = 256,
+	TPM_NUM_MASK_ENTRIES = TPM_NUM_DEVICES / (8 * sizeof(int))
+};
 
 static LIST_HEAD(tpm_chip_list);
 static DEFINE_SPINLOCK(driver_lock);
-static int dev_mask[32];
+static int dev_mask[TPM_NUM_MASK_ENTRIES];
 
 static void user_reader_timeout(unsigned long ptr)
 {
@@ -52,92 +49,17 @@ static void user_reader_timeout(unsigned
 	up(&chip->buffer_mutex);
 }
 
-void tpm_time_expired(unsigned long ptr)
-{
-	int *exp = (int *) ptr;
-	*exp = 1;
-}
-
-EXPORT_SYMBOL_GPL(tpm_time_expired);
-
-/*
- * Initialize the LPC bus and enable the TPM ports
- */
-int tpm_lpc_bus_init(struct pci_dev *pci_dev, u16 base)
-{
-	u32 lpcenable, tmp;
-	int is_lpcm = 0;
-
-	switch (pci_dev->vendor) {
-	case PCI_VENDOR_ID_INTEL:
-		switch (pci_dev->device) {
-		case PCI_DEVICE_ID_INTEL_82801CA_12:
-		case PCI_DEVICE_ID_INTEL_82801DB_12:
-			is_lpcm = 1;
-			break;
-		}
-		/* init ICH (enable LPC) */
-		pci_read_config_dword(pci_dev, PCI_GEN1_DEC, &lpcenable);
-		lpcenable |= 0x20000000;
-		pci_write_config_dword(pci_dev, PCI_GEN1_DEC, lpcenable);
-
-		if (is_lpcm) {
-			pci_read_config_dword(pci_dev, PCI_GEN1_DEC,
-					      &lpcenable);
-			if ((lpcenable & 0x20000000) == 0) {
-				dev_err(&pci_dev->dev,
-					"cannot enable LPC\n");
-				return -ENODEV;
-			}
-		}
-
-		/* initialize TPM registers */
-		pci_read_config_dword(pci_dev, PCI_GEN2_DEC, &tmp);
-
-		if (!is_lpcm)
-			tmp = (tmp & 0xFFFF0000) | (base & 0xFFF0);
-		else
-			tmp =
-			    (tmp & 0xFFFF0000) | (base & 0xFFF0) |
-			    0x00000001;
-
-		pci_write_config_dword(pci_dev, PCI_GEN2_DEC, tmp);
-
-		if (is_lpcm) {
-			pci_read_config_dword(pci_dev, PCI_GEN_PMCON_1,
-					      &tmp);
-			tmp |= 0x00000004;	/* enable CLKRUN */
-			pci_write_config_dword(pci_dev, PCI_GEN_PMCON_1,
-					       tmp);
-		}
-		tpm_write_index(0x0D, 0x55);	/* unlock 4F */
-		tpm_write_index(0x0A, 0x00);	/* int disable */
-		tpm_write_index(0x08, base);	/* base addr lo */
-		tpm_write_index(0x09, (base & 0xFF00) >> 8);	/* base addr hi */
-		tpm_write_index(0x0D, 0xAA);	/* lock 4F */
-		break;
-	case PCI_VENDOR_ID_AMD:
-		/* nothing yet */
-		break;
-	}
-
-	return 0;
-}
-
-EXPORT_SYMBOL_GPL(tpm_lpc_bus_init);
-
 /*
  * Internal kernel interface to transmit TPM commands
  */
 static ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
 			    size_t bufsiz)
 {
-	ssize_t len;
+	ssize_t rc;
 	u32 count;
-	__be32 *native_size;
+	unsigned long stop;
 
-	native_size = (__force __be32 *) (buf + 2);
-	count = be32_to_cpu(*native_size);
+	count = be32_to_cpu(*((__be32 *) (buf + 2)));
 
 	if (count == 0)
 		return -ENODATA;
@@ -149,53 +71,49 @@ static ssize_t tpm_transmit(struct tpm_c
 
 	down(&chip->tpm_mutex);
 
-	if ((len = chip->vendor->send(chip, (u8 *) buf, count)) < 0) {
+	if ((rc = chip->vendor->send(chip, (u8 *) buf, count)) < 0) {
 		dev_err(&chip->pci_dev->dev,
-			"tpm_transmit: tpm_send: error %zd\n", len);
-		return len;
+			"tpm_transmit: tpm_send: error %zd\n", rc);
+		goto out;
 	}
 
-	down(&chip->timer_manipulation_mutex);
-	chip->time_expired = 0;
-	init_timer(&chip->device_timer);
-	chip->device_timer.function = tpm_time_expired;
-	chip->device_timer.expires = jiffies + 2 * 60 * HZ;
-	chip->device_timer.data = (unsigned long) &chip->time_expired;
-	add_timer(&chip->device_timer);
-	up(&chip->timer_manipulation_mutex);
-
+	stop = jiffies + 2 * 60 * HZ;
 	do {
 		u8 status = inb(chip->vendor->base + 1);
 		if ((status & chip->vendor->req_complete_mask) ==
 		    chip->vendor->req_complete_val) {
-			down(&chip->timer_manipulation_mutex);
-			del_singleshot_timer_sync(&chip->device_timer);
-			up(&chip->timer_manipulation_mutex);
 			goto out_recv;
 		}
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(TPM_TIMEOUT);
+
+		if ((status == chip->vendor->req_canceled)) {
+			dev_err(&chip->pci_dev->dev, "Operation Canceled\n");
+			rc = -ECANCELED;
+			goto out;
+		}
+
+		msleep(TPM_TIMEOUT);	/* CHECK */
 		rmb();
-	} while (!chip->time_expired);
+	} while (time_before(jiffies, stop));
 
 
 	chip->vendor->cancel(chip);
-	dev_err(&chip->pci_dev->dev, "Time expired\n");
-	up(&chip->tpm_mutex);
-	return -EIO;
+	dev_err(&chip->pci_dev->dev, "Operation Timed out\n");
+	rc = -ETIME;
+	goto out;
 
 out_recv:
-	len = chip->vendor->recv(chip, (u8 *) buf, bufsiz);
-	if (len < 0)
+	rc = chip->vendor->recv(chip, (u8 *) buf, bufsiz);
+	if (rc < 0)
 		dev_err(&chip->pci_dev->dev,
-			"tpm_transmit: tpm_recv: error %zd\n", len);
+			"tpm_transmit: tpm_recv: error %zd\n", rc);
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
@@ -205,75 +123,94 @@ static u8 cap_pcr[] = {
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
+ssize_t tpm_show_pcrs(struct device *dev, struct device_attribute *attr,
+		      char *buf)
 {
 	u8 data[READ_PCR_RESULT_SIZE];
 	ssize_t len;
-	int i, j, index, num_pcrs;
+	int i, j, num_pcrs;
+	__be32 index;
 	char *str = buf;
 
 	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	    pci_get_drvdata(to_pci_dev(dev));
 	if (chip == NULL)
 		return -ENODEV;
 
 	memcpy(data, cap_pcr, sizeof(cap_pcr));
 	if ((len = tpm_transmit(chip, data, sizeof(data)))
-	    < CAP_PCR_RESULT_SIZE)
-		return len;
+	    < CAP_PCR_RESULT_SIZE) {
+		dev_dbg(&chip->pci_dev->dev, "A TPM error (%d) occurred "
+				"attempting to determine the number of PCRS\n",
+			be32_to_cpu(*((__be32 *) (data + 6))));
+		return 0;
+	}
 
-	num_pcrs = be32_to_cpu(*((__force __be32 *) (data + 14)));
+	num_pcrs = be32_to_cpu(*((__be32 *) (data + 14)));
 
 	for (i = 0; i < num_pcrs; i++) {
 		memcpy(data, pcrread, sizeof(pcrread));
 		index = cpu_to_be32(i);
 		memcpy(data + 10, &index, 4);
 		if ((len = tpm_transmit(chip, data, sizeof(data)))
-		    < READ_PCR_RESULT_SIZE)
-			return len;
+		    < READ_PCR_RESULT_SIZE){
+			dev_dbg(&chip->pci_dev->dev, "A TPM error (%d) occurred"
+				" attempting to read PCR %d of %d\n",
+				be32_to_cpu(*((__be32 *) (data + 6))), i, num_pcrs);
+			goto out;
+		}
 		str += sprintf(str, "PCR-%02d: ", i);
 		for (j = 0; j < TPM_DIGEST_SIZE; j++)
 			str += sprintf(str, "%02X ", *(data + 10 + j));
 		str += sprintf(str, "\n");
 	}
+out:
 	return str - buf;
 }
-
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
+ssize_t tpm_show_pubek(struct device *dev, struct device_attribute *attr,
+		       char *buf)
 {
-	u8 data[READ_PUBEK_RESULT_SIZE];
+	u8 *data;
 	ssize_t len;
-	__be32 *native_val;
-	int i;
+	int i, rc;
 	char *str = buf;
 
 	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	    pci_get_drvdata(to_pci_dev(dev));
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
+		dev_dbg(&chip->pci_dev->dev, "A TPM error (%d) occurred "
+				"attempting to read the PUBEK\n",
+			    be32_to_cpu(*((__be32 *) (data + 6))));
+		rc = 0;
+		goto out;
+	}
 
 	/* 
 	   ignore header 10 bytes
@@ -286,8 +223,6 @@ static ssize_t show_pubek(struct device 
 	   ignore checksum 20 bytes
 	 */
 
-	native_val = (__force __be32 *) (data + 34);
-
 	str +=
 	    sprintf(str,
 		    "Algorithm: %02X %02X %02X %02X\nEncscheme: %02X %02X\n"
@@ -298,21 +233,23 @@ static ssize_t show_pubek(struct device 
 		    data[15], data[16], data[17], data[22], data[23],
 		    data[24], data[25], data[26], data[27], data[28],
 		    data[29], data[30], data[31], data[32], data[33],
-		    be32_to_cpu(*native_val)
-	    );
+		    be32_to_cpu(*((__be32 *) (data + 34))));
 
 	for (i = 0; i < 256; i++) {
-		str += sprintf(str, "%02X ", data[i + 39]);
+		str += sprintf(str, "%02X ", data[i + 38]);
 		if ((i + 1) % 16 == 0)
 			str += sprintf(str, "\n");
 	}
-	return str - buf;
+	rc = str - buf;
+out:
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
@@ -321,7 +258,7 @@ static u8 cap_version[] = {
 };
 
 #define CAP_MANUFACTURER_RESULT_SIZE 18
-static u8 cap_manufacturer[] = {
+static const u8 cap_manufacturer[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 22,		/* length */
 	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
@@ -330,14 +267,15 @@ static u8 cap_manufacturer[] = {
 	0, 0, 1, 3
 };
 
-static ssize_t show_caps(struct device *dev, char *buf)
+ssize_t tpm_show_caps(struct device *dev, struct device_attribute *attr,
+		      char *buf)
 {
-	u8 data[READ_PUBEK_RESULT_SIZE];
+	u8 data[sizeof(cap_manufacturer)];
 	ssize_t len;
 	char *str = buf;
 
 	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	    pci_get_drvdata(to_pci_dev(dev));
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -348,7 +286,7 @@ static ssize_t show_caps(struct device *
 		return len;
 
 	str += sprintf(str, "Manufacturer: 0x%x\n",
-		       be32_to_cpu(*(data + 14)));
+		       be32_to_cpu(*((__be32 *) (data + 14))));
 
 	memcpy(data, cap_version, sizeof(cap_version));
 
@@ -363,8 +301,20 @@ static ssize_t show_caps(struct device *
 
 	return str - buf;
 }
+EXPORT_SYMBOL_GPL(tpm_show_caps);
+
+ssize_t tpm_store_cancel(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	if (chip == NULL)
+		return 0;
+
+	chip->vendor->cancel(chip);
+	return count;
+}
+EXPORT_SYMBOL_GPL(tpm_store_cancel);
 
-static DEVICE_ATTR(caps, S_IRUGO, show_caps, NULL);
 
 /*
  * Device file system interface to the TPM
@@ -422,24 +372,15 @@ EXPORT_SYMBOL_GPL(tpm_open);
 int tpm_release(struct inode *inode, struct file *file)
 {
 	struct tpm_chip *chip = file->private_data;
-	
-	file->private_data = NULL;
 
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
 	pci_dev_put(chip->pci_dev);
+	kfree(chip->data_buffer);
+	spin_unlock(&driver_lock);
 	return 0;
 }
 
@@ -453,10 +394,8 @@ ssize_t tpm_write(struct file * file, co
 
 	/* cannot perform a write until the read has cleared
 	   either via tpm_read or a user_read_timer timeout */
-	while (atomic_read(&chip->data_pending) != 0) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(TPM_TIMEOUT);
-	}
+	while (atomic_read(&chip->data_pending) != 0)
+		msleep(TPM_TIMEOUT);
 
 	down(&chip->buffer_mutex);
 
@@ -476,13 +415,7 @@ ssize_t tpm_write(struct file * file, co
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
@@ -493,29 +426,19 @@ ssize_t tpm_read(struct file * file, cha
 		 size_t size, loff_t * off)
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
 
@@ -541,14 +464,13 @@ void __devexit tpm_remove(struct pci_dev
 
 	pci_set_drvdata(pci_dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
+	kfree(&chip->vendor->miscdev.name);
 
-	device_remove_file(&pci_dev->dev, &dev_attr_pubek);
-	device_remove_file(&pci_dev->dev, &dev_attr_pcrs);
-	device_remove_file(&pci_dev->dev, &dev_attr_caps);
+	sysfs_remove_group(&pci_dev->dev.kobj, chip->vendor->attr_group);
 
 	pci_disable_device(pci_dev);
 
-	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
+	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES ] &= !(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
 
 	kfree(chip);
 
@@ -590,10 +512,6 @@ int tpm_pm_resume(struct pci_dev *pci_de
 	if (chip == NULL)
 		return -ENODEV;
 
-	spin_lock(&driver_lock);
-	tpm_lpc_bus_init(pci_dev, chip->vendor->base);
-	spin_unlock(&driver_lock);
-
 	return 0;
 }
 
@@ -609,7 +527,9 @@ EXPORT_SYMBOL_GPL(tpm_pm_resume);
 int tpm_register_hardware(struct pci_dev *pci_dev,
 			  struct tpm_vendor_specific *entry)
 {
-	char devname[7];
+#define DEVNAME_SIZE 7
+
+	char *devname;
 	struct tpm_chip *chip;
 	int i, j;
 
@@ -622,17 +542,21 @@ int tpm_register_hardware(struct pci_dev
 
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
@@ -648,7 +572,8 @@ dev_num_search_complete:
 	else
 		chip->vendor->miscdev.minor = MISC_DYNAMIC_MINOR;
 
-	snprintf(devname, sizeof(devname), "%s%d", "tpm", chip->dev_num);
+	devname = kmalloc(DEVNAME_SIZE, GFP_KERNEL);
+	scnprintf(devname, DEVNAME_SIZE, "%s%d", "tpm", chip->dev_num);
 	chip->vendor->miscdev.name = devname;
 
 	chip->vendor->miscdev.dev = &(pci_dev->dev);
@@ -665,31 +590,20 @@ dev_num_search_complete:
 		return -ENODEV;
 	}
 
+	spin_lock(&driver_lock);
+
 	pci_set_drvdata(pci_dev, chip);
 
 	list_add(&chip->list, &tpm_chip_list);
 
-	device_create_file(&pci_dev->dev, &dev_attr_pubek);
-	device_create_file(&pci_dev->dev, &dev_attr_pcrs);
-	device_create_file(&pci_dev->dev, &dev_attr_caps);
-
-	return 0;
-}
+	spin_unlock(&driver_lock);
 
-EXPORT_SYMBOL_GPL(tpm_register_hardware);
+	sysfs_create_group(&pci_dev->dev.kobj, chip->vendor->attr_group);
 
-static int __init init_tpm(void)
-{
 	return 0;
 }
 
-static void __exit cleanup_tpm(void)
-{
-
-}
-
-module_init(init_tpm);
-module_exit(cleanup_tpm);
+EXPORT_SYMBOL_GPL(tpm_register_hardware);
 
 MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
 MODULE_DESCRIPTION("TPM Driver");
--- linux-2.6.12/drivers/char/tpm/tpm.h	2005-06-17 16:03:59.000000000 -0700
+++ 25/drivers/char/tpm/tpm.h	2005-06-26 02:20:35.000000000 -0700
@@ -25,23 +25,38 @@
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 
-#define TPM_TIMEOUT msecs_to_jiffies(5)
+enum tpm_timeout {
+	TPM_TIMEOUT = 5,	/* msecs */
+};
 
 /* TPM addresses */
-#define	TPM_ADDR			0x4E
-#define	TPM_DATA			0x4F
+enum tpm_addr {
+	TPM_SUPERIO_ADDR = 0x2E,
+	TPM_ADDR = 0x4E,
+};
+
+extern ssize_t tpm_show_pubek(struct device *, struct device_attribute *attr,
+				char *);
+extern ssize_t tpm_show_pcrs(struct device *, struct device_attribute *attr,
+				char *);
+extern ssize_t tpm_show_caps(struct device *, struct device_attribute *attr,
+				char *);
+extern ssize_t tpm_store_cancel(struct device *, struct device_attribute *attr,
+				const char *, size_t);
 
 struct tpm_chip;
 
 struct tpm_vendor_specific {
 	u8 req_complete_mask;
 	u8 req_complete_val;
+	u8 req_canceled;
 	u16 base;		/* TPM base address */
 
 	int (*recv) (struct tpm_chip *, u8 *, size_t);
 	int (*send) (struct tpm_chip *, u8 *, size_t);
 	void (*cancel) (struct tpm_chip *);
 	struct miscdevice miscdev;
+	struct attribute_group *attr_group;
 };
 
 struct tpm_chip {
@@ -58,29 +73,24 @@ struct tpm_chip {
 
 	struct timer_list user_read_timer;	/* user needs to claim result */
 	struct semaphore tpm_mutex;	/* tpm is processing */
-	struct timer_list device_timer;	/* tpm is processing */
-	struct semaphore timer_manipulation_mutex;
 
 	struct tpm_vendor_specific *vendor;
 
 	struct list_head list;
 };
 
-static inline int tpm_read_index(int index)
+static inline int tpm_read_index(int base, int index)
 {
-	outb(index, TPM_ADDR);
-	return inb(TPM_DATA) & 0xFF;
+	outb(index, base);
+	return inb(base+1) & 0xFF;
 }
 
-static inline void tpm_write_index(int index, int value)
+static inline void tpm_write_index(int base, int index, int value)
 {
-	outb(index, TPM_ADDR);
-	outb(value & 0xFF, TPM_DATA);
+	outb(index, base);
+	outb(value & 0xFF, base+1);
 }
 
-extern void tpm_time_expired(unsigned long);
-extern int tpm_lpc_bus_init(struct pci_dev *, u16);
-
 extern int tpm_register_hardware(struct pci_dev *,
 				 struct tpm_vendor_specific *);
 extern int tpm_open(struct inode *, struct file *);
--- linux-2.6.12/drivers/char/tpm/tpm_nsc.c	2005-06-17 16:03:59.000000000 -0700
+++ 25/drivers/char/tpm/tpm_nsc.c	2005-06-26 02:20:35.000000000 -0700
@@ -22,43 +22,52 @@
 #include "tpm.h"
 
 /* National definitions */
-#define	TPM_NSC_BASE			0x360
-#define	TPM_NSC_IRQ			0x07
+enum tpm_nsc_addr{
+	TPM_NSC_IRQ = 0x07,
+	TPM_NSC_BASE0_HI = 0x60,
+	TPM_NSC_BASE0_LO = 0x61,
+	TPM_NSC_BASE1_HI = 0x62,
+	TPM_NSC_BASE1_LO = 0x63
+};
+
+enum tpm_nsc_index {
+	NSC_LDN_INDEX = 0x07,
+	NSC_SID_INDEX = 0x20,
+	NSC_LDC_INDEX = 0x30,
+	NSC_DIO_INDEX = 0x60,
+	NSC_CIO_INDEX = 0x62,
+	NSC_IRQ_INDEX = 0x70,
+	NSC_ITS_INDEX = 0x71
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
+enum tpm_nsc_status_loc {
+	NSC_STATUS = 0x01,
+	NSC_COMMAND = 0x01,
+	NSC_DATA = 0x00
+};
 
 /* status bits */
-#define	NSC_STATUS_OBF			0x01	/* output buffer full */
-#define	NSC_STATUS_IBF			0x02	/* input buffer full */
-#define	NSC_STATUS_F0			0x04	/* F0 */
-#define	NSC_STATUS_A2			0x08	/* A2 */
-#define	NSC_STATUS_RDY			0x10	/* ready to receive command */
-#define	NSC_STATUS_IBR			0x20	/* ready to receive data */
+enum tpm_nsc_status {
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
+enum tpm_nsc_cmd_mode {
+	NSC_COMMAND_NORMAL = 0x01,	/* normal mode */
+	NSC_COMMAND_EOC = 0x03,
+	NSC_COMMAND_CANCEL = 0x22
+};
 /*
  * Wait for a certain status to appear
  */
 static int wait_for_stat(struct tpm_chip *chip, u8 mask, u8 val, u8 * data)
 {
-	int expired = 0;
-	struct timer_list status_timer =
-	    TIMER_INITIALIZER(tpm_time_expired, jiffies + 10 * HZ,
-			      (unsigned long) &expired);
+	unsigned long stop;
 
 	/* status immediately available check */
 	*data = inb(chip->vendor->base + NSC_STATUS);
@@ -66,17 +75,14 @@ static int wait_for_stat(struct tpm_chip
 		return 0;
 
 	/* wait for status */
-	add_timer(&status_timer);
+	stop = jiffies + 10 * HZ;
 	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(TPM_TIMEOUT);
+		msleep(TPM_TIMEOUT);
 		*data = inb(chip->vendor->base + 1);
-		if ((*data & mask) == val) {
-			del_singleshot_timer_sync(&status_timer);
+		if ((*data & mask) == val)
 			return 0;
-		}
 	}
-	while (!expired);
+	while (time_before(jiffies, stop));
 
 	return -EBUSY;
 }
@@ -84,10 +90,7 @@ static int wait_for_stat(struct tpm_chip
 static int nsc_wait_for_ready(struct tpm_chip *chip)
 {
 	int status;
-	int expired = 0;
-	struct timer_list status_timer =
-	    TIMER_INITIALIZER(tpm_time_expired, jiffies + 100,
-			      (unsigned long) &expired);
+	unsigned long stop;
 
 	/* status immediately available check */
 	status = inb(chip->vendor->base + NSC_STATUS);
@@ -97,19 +100,16 @@ static int nsc_wait_for_ready(struct tpm
 		return 0;
 
 	/* wait for status */
-	add_timer(&status_timer);
+	stop = jiffies + 100;
 	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(TPM_TIMEOUT);
+		msleep(TPM_TIMEOUT);
 		status = inb(chip->vendor->base + NSC_STATUS);
 		if (status & NSC_STATUS_OBF)
 			status = inb(chip->vendor->base + NSC_DATA);
-		if (status & NSC_STATUS_RDY) {
-			del_singleshot_timer_sync(&status_timer);
+		if (status & NSC_STATUS_RDY)
 			return 0;
-		}
 	}
-	while (!expired);
+	while (time_before(jiffies, stop));
 
 	dev_info(&chip->pci_dev->dev, "wait for ready failed\n");
 	return -EBUSY;
@@ -150,7 +150,8 @@ static int tpm_nsc_recv(struct tpm_chip 
 		*p = inb(chip->vendor->base + NSC_DATA);
 	}
 
-	if ((data & NSC_STATUS_F0) == 0) {
+	if ((data & NSC_STATUS_F0) == 0 &&
+	(wait_for_stat(chip, NSC_STATUS_F0, NSC_STATUS_F0, &data) < 0)) {
 		dev_err(&chip->pci_dev->dev, "F0 not set\n");
 		return -EIO;
 	}
@@ -228,100 +229,95 @@ static struct file_operations nsc_ops = 
 	.release = tpm_release,
 };
 
+static DEVICE_ATTR(pubek, S_IRUGO, tpm_show_pubek, NULL);
+static DEVICE_ATTR(pcrs, S_IRUGO, tpm_show_pcrs, NULL);
+static DEVICE_ATTR(caps, S_IRUGO, tpm_show_caps, NULL);
+static DEVICE_ATTR(cancel, S_IWUSR|S_IWGRP, NULL, tpm_store_cancel);
+
+static struct attribute * nsc_attrs[] = {
+	&dev_attr_pubek.attr,
+	&dev_attr_pcrs.attr,
+	&dev_attr_caps.attr,
+	&dev_attr_cancel.attr,
+	0,
+};
+
+static struct attribute_group nsc_attr_grp = { .attrs = nsc_attrs };
+
 static struct tpm_vendor_specific tpm_nsc = {
 	.recv = tpm_nsc_recv,
 	.send = tpm_nsc_send,
 	.cancel = tpm_nsc_cancel,
 	.req_complete_mask = NSC_STATUS_OBF,
 	.req_complete_val = NSC_STATUS_OBF,
-	.base = TPM_NSC_BASE,
+	.req_canceled = NSC_STATUS_RDY,
+	.attr_group = &nsc_attr_grp,
 	.miscdev = { .fops = &nsc_ops, },
-	
 };
 
 static int __devinit tpm_nsc_init(struct pci_dev *pci_dev,
 				  const struct pci_device_id *pci_id)
 {
 	int rc = 0;
+	int lo, hi;
+	int nscAddrBase = TPM_ADDR;
+
 
 	if (pci_enable_device(pci_dev))
 		return -EIO;
 
-	if (tpm_lpc_bus_init(pci_dev, TPM_NSC_BASE)) {
-		rc = -ENODEV;
-		goto out_err;
-	}
+	/* select PM channel 1 */
+	tpm_write_index(nscAddrBase,NSC_LDN_INDEX, 0x12);
 
 	/* verify that it is a National part (SID) */
-	if (tpm_read_index(NSC_SID_INDEX) != 0xEF) {
-		rc = -ENODEV;
-		goto out_err;
+	if (tpm_read_index(TPM_ADDR, NSC_SID_INDEX) != 0xEF) {
+		nscAddrBase = (tpm_read_index(TPM_SUPERIO_ADDR, 0x2C)<<8)|
+			(tpm_read_index(TPM_SUPERIO_ADDR, 0x2B)&0xFE);
+		if (tpm_read_index(nscAddrBase, NSC_SID_INDEX) != 0xF6) {
+			rc = -ENODEV;
+			goto out_err;
+		}
 	}
 
+	hi = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_HI);
+	lo = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_LO);
+	tpm_nsc.base = (hi<<8) | lo;
+
 	dev_dbg(&pci_dev->dev, "NSC TPM detected\n");
 	dev_dbg(&pci_dev->dev,
 		"NSC LDN 0x%x, SID 0x%x, SRID 0x%x\n",
-		tpm_read_index(0x07), tpm_read_index(0x20),
-		tpm_read_index(0x27));
+		tpm_read_index(nscAddrBase,0x07), tpm_read_index(nscAddrBase,0x20),
+		tpm_read_index(nscAddrBase,0x27));
 	dev_dbg(&pci_dev->dev,
 		"NSC SIOCF1 0x%x SIOCF5 0x%x SIOCF6 0x%x SIOCF8 0x%x\n",
-		tpm_read_index(0x21), tpm_read_index(0x25),
-		tpm_read_index(0x26), tpm_read_index(0x28));
+		tpm_read_index(nscAddrBase,0x21), tpm_read_index(nscAddrBase,0x25),
+		tpm_read_index(nscAddrBase,0x26), tpm_read_index(nscAddrBase,0x28));
 	dev_dbg(&pci_dev->dev, "NSC IO Base0 0x%x\n",
-		(tpm_read_index(0x60) << 8) | tpm_read_index(0x61));
+		(tpm_read_index(nscAddrBase,0x60) << 8) | tpm_read_index(nscAddrBase,0x61));
 	dev_dbg(&pci_dev->dev, "NSC IO Base1 0x%x\n",
-		(tpm_read_index(0x62) << 8) | tpm_read_index(0x63));
+		(tpm_read_index(nscAddrBase,0x62) << 8) | tpm_read_index(nscAddrBase,0x63));
 	dev_dbg(&pci_dev->dev, "NSC Interrupt number and wakeup 0x%x\n",
-		tpm_read_index(0x70));
+		tpm_read_index(nscAddrBase,0x70));
 	dev_dbg(&pci_dev->dev, "NSC IRQ type select 0x%x\n",
-		tpm_read_index(0x71));
+		tpm_read_index(nscAddrBase,0x71));
 	dev_dbg(&pci_dev->dev,
 		"NSC DMA channel select0 0x%x, select1 0x%x\n",
-		tpm_read_index(0x74), tpm_read_index(0x75));
+		tpm_read_index(nscAddrBase,0x74), tpm_read_index(nscAddrBase,0x75));
 	dev_dbg(&pci_dev->dev,
 		"NSC Config "
 		"0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
-		tpm_read_index(0xF0), tpm_read_index(0xF1),
-		tpm_read_index(0xF2), tpm_read_index(0xF3),
-		tpm_read_index(0xF4), tpm_read_index(0xF5),
-		tpm_read_index(0xF6), tpm_read_index(0xF7),
-		tpm_read_index(0xF8), tpm_read_index(0xF9));
+		tpm_read_index(nscAddrBase,0xF0), tpm_read_index(nscAddrBase,0xF1),
+		tpm_read_index(nscAddrBase,0xF2), tpm_read_index(nscAddrBase,0xF3),
+		tpm_read_index(nscAddrBase,0xF4), tpm_read_index(nscAddrBase,0xF5),
+		tpm_read_index(nscAddrBase,0xF6), tpm_read_index(nscAddrBase,0xF7),
+		tpm_read_index(nscAddrBase,0xF8), tpm_read_index(nscAddrBase,0xF9));
 
 	dev_info(&pci_dev->dev,
-		 "NSC PC21100 TPM revision %d\n",
-		 tpm_read_index(0x27) & 0x1F);
-
-	if (tpm_read_index(NSC_LDC_INDEX) == 0)
-		dev_info(&pci_dev->dev, ": NSC TPM not active\n");
-
-	/* select PM channel 1 */
-	tpm_write_index(NSC_LDN_INDEX, 0x12);
-	tpm_read_index(NSC_LDN_INDEX);
-
-	/* disable the DPM module */
-	tpm_write_index(NSC_LDC_INDEX, 0);
-	tpm_read_index(NSC_LDC_INDEX);
-
-	/* set the data register base addresses */
-	tpm_write_index(NSC_DIO_INDEX, TPM_NSC_BASE >> 8);
-	tpm_write_index(NSC_DIO_INDEX + 1, TPM_NSC_BASE);
-	tpm_read_index(NSC_DIO_INDEX);
-	tpm_read_index(NSC_DIO_INDEX + 1);
-
-	/* set the command register base addresses */
-	tpm_write_index(NSC_CIO_INDEX, (TPM_NSC_BASE + 1) >> 8);
-	tpm_write_index(NSC_CIO_INDEX + 1, (TPM_NSC_BASE + 1));
-	tpm_read_index(NSC_DIO_INDEX);
-	tpm_read_index(NSC_DIO_INDEX + 1);
-
-	/* set the interrupt number to be used for the host interface */
-	tpm_write_index(NSC_IRQ_INDEX, TPM_NSC_IRQ);
-	tpm_write_index(NSC_ITS_INDEX, 0x00);
-	tpm_read_index(NSC_IRQ_INDEX);
+		 "NSC TPM revision %d\n",
+		 tpm_read_index(nscAddrBase, 0x27) & 0x1F);
 
 	/* enable the DPM module */
-	tpm_write_index(NSC_LDC_INDEX, 0x01);
-	tpm_read_index(NSC_LDC_INDEX);
+	tpm_write_index(nscAddrBase, NSC_LDC_INDEX, 0x01);
 
 	if ((rc = tpm_register_hardware(pci_dev, &tpm_nsc)) < 0)
 		goto out_err;
@@ -339,6 +335,9 @@ static struct pci_device_id tpm_pci_tbl[
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
 	{0,}
 };
--- linux-2.6.12/include/linux/pci_ids.h	2005-06-17 16:04:03.000000000 -0700
+++ 25/include/linux/pci_ids.h	2005-06-26 02:21:57.000000000 -0700
@@ -1567,6 +1571,7 @@
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4USB 0x0220
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5USB PCI_DEVICE_ID_SERVERWORKS_OSB4USB
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6USB 0x0221
+#define PCI_DEVICE_ID_SERVERWORKS_CSB6LPC 0x0227
 #define PCI_DEVICE_ID_SERVERWORKS_GCLE    0x0225
 #define PCI_DEVICE_ID_SERVERWORKS_GCLE2   0x0227
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5ISA 0x0230


