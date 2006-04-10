Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWDJOgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWDJOgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 10:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWDJOg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 10:36:26 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:40668 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751179AbWDJOgW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 10:36:22 -0400
Subject: [PATCH 3/7] tpm: chip struct update
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Mon, 10 Apr 2006 09:37:08 -0500
Message-Id: <1144679828.4917.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To assist with chip management and better support the possibility of
having multiple TPMs in the system of the same kind, the struct
tpm_vendor_specific member of the tpm_chip was changed from a pointer to
an instance.  This patch changes that declaration and fixes up all
accesses to the structure member except in tpm_infineon which is coming
in a patch from Marcel Selhorst.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
drivers/char/tpm/tpm.c       |   48 +++++++++++++++------------------
drivers/char/tpm/tpm.h       |    2 -
drivers/char/tpm/tpm_atmel.c |   26 ++++++++---------
drivers/char/tpm/tpm_nsc.c   |   32 +++++++++++-----------
4 files changed, 53 insertions(+), 55 deletions(-)

--- linux-2.6.16/drivers/char/tpm/tpm.c	2006-03-30 15:08:43.400724250 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm.c	2006-03-29 14:17:14.421822250 -0600
@@ -78,21 +385,20 @@ static ssize_t tpm_transmit(struct tpm_c
 
 	down(&chip->tpm_mutex);
 
-	if ((rc = chip->vendor->send(chip, (u8 *) buf, count)) < 0) {
+	if ((rc = chip->vendor.send(chip, (u8 *) buf, count)) < 0) {
 		dev_err(chip->dev,
 			"tpm_transmit: tpm_send: error %zd\n", rc);
 		goto out;
 	}
 
	stop = jiffies + 2 * 60 * HZ;
 	do {
-		u8 status = chip->vendor->status(chip);
-		if ((status & chip->vendor->req_complete_mask) ==
-		    chip->vendor->req_complete_val) {
+		u8 status = chip->vendor.status(chip);
+		if ((status & chip->vendor.req_complete_mask) ==
+		    chip->vendor.req_complete_val)
 			goto out_recv;
-		}
 
-		if ((status == chip->vendor->req_canceled)) {
+		if ((status == chip->vendor.req_canceled)) {
 			dev_err(chip->dev, "Operation Canceled\n");
 			rc = -ECANCELED;
 			goto out;
@@ -102,14 +411,13 @@ static ssize_t tpm_transmit(struct tpm_c
 		rmb();
 	} while (time_before(jiffies, stop));
 
-
-	chip->vendor->cancel(chip);
+	chip->vendor.cancel(chip);
 	dev_err(chip->dev, "Operation Timed out\n");
 	rc = -ETIME;
 	goto out;
 
 out_recv:
-	rc = chip->vendor->recv(chip, (u8 *) buf, bufsiz);
+	rc = chip->vendor.recv(chip, (u8 *) buf, bufsiz);
 	if (rc < 0)
 		dev_err(chip->dev,
 			"tpm_transmit: tpm_recv: error %zd\n", rc);
@@ -344,7 +832,7 @@ ssize_t tpm_store_cancel(struct device *dev
 	if (chip == NULL)
 		return 0;
 
-	chip->vendor->cancel(chip);
+	chip->vendor.cancel(chip);
 	return count;
 }
 EXPORT_SYMBOL_GPL(tpm_store_cancel);
@@ -369,7 +913,7 @@ int tpm_open(struct inode *inode, struct
 	spin_lock(&driver_lock);
 
 	list_for_each_entry(pos, &tpm_chip_list, list) {
-		if (pos->vendor->miscdev.minor == minor) {
+		if (pos->vendor.miscdev.minor == minor) {
 			chip = pos;
 			break;
 		}
@@ -502,14 +1049,14 @@ void tpm_remove_hardware(struct device *
 	spin_unlock(&driver_lock);
 
 	dev_set_drvdata(dev, NULL);
-	misc_deregister(&chip->vendor->miscdev);
-	kfree(chip->vendor->miscdev.name);
+	misc_deregister(&chip->vendor.miscdev);
+	kfree(chip->vendor.miscdev.name);
 
-	sysfs_remove_group(&dev->kobj, chip->vendor->attr_group);
+	sysfs_remove_group(&dev->kobj, chip->vendor.attr_group);
 	tpm_bios_log_teardown(chip->bios_dir);
 
-	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES ] &=
-		~(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
+	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES] &=
+	    ~(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
 
 	kfree(chip);
 
@@ -583,7 +1134,7 @@ int tpm_register_hardware(struct device 
 	chip->user_read_timer.function = user_reader_timeout;
 	chip->user_read_timer.data = (unsigned long) chip;
 
-	chip->vendor = entry;
+	memcpy(&chip->vendor, entry, sizeof(struct tpm_vendor_specific));
 
 	chip->dev_num = -1;
 
@@ -602,22 +1153,22 @@ dev_num_search_complete:
 		kfree(chip);
 		return -ENODEV;
 	} else if (chip->dev_num == 0)
-		chip->vendor->miscdev.minor = TPM_MINOR;
+		chip->vendor.miscdev.minor = TPM_MINOR;
 	else
-		chip->vendor->miscdev.minor = MISC_DYNAMIC_MINOR;
+		chip->vendor.miscdev.minor = MISC_DYNAMIC_MINOR;
 
 	devname = kmalloc(DEVNAME_SIZE, GFP_KERNEL);
 	scnprintf(devname, DEVNAME_SIZE, "%s%d", "tpm", chip->dev_num);
-	chip->vendor->miscdev.name = devname;
+	chip->vendor.miscdev.name = devname;
 
-	chip->vendor->miscdev.dev = dev;
+	chip->vendor.miscdev.dev = dev;
 	chip->dev = get_device(dev);
 
-	if (misc_register(&chip->vendor->miscdev)) {
+	if (misc_register(&chip->vendor.miscdev)) {
 		dev_err(chip->dev,
 			"unable to misc_register %s, minor %d\n",
-			chip->vendor->miscdev.name,
-			chip->vendor->miscdev.minor);
+			chip->vendor.miscdev.name,
+			chip->vendor.miscdev.minor);
 		put_device(dev);
 		kfree(chip);
 		dev_mask[i] &= !(1 << j);
@@ -632,7 +1183,7 @@ dev_num_search_complete:
 
 	spin_unlock(&driver_lock);
 
-	sysfs_create_group(&dev->kobj, chip->vendor->attr_group);
+	sysfs_create_group(&dev->kobj, chip->vendor.attr_group);
 
 	chip->bios_dir = tpm_bios_log_setup(devname);
 
--- linux-2.6.16/drivers/char/tpm/tpm_atmel.c	2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm_atmel.c	2006-03-02 15:04:40.663271500 -0600
@@ -47,12 +47,12 @@ static int tpm_atml_recv(struct tpm_chip
 		return -EIO;
 
 	for (i = 0; i < 6; i++) {
-		status = ioread8(chip->vendor->iobase + 1);
+		status = ioread8(chip->vendor.iobase + 1);
 		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
 			dev_err(chip->dev, "error reading header\n");
 			return -EIO;
 		}
-		*buf++ = ioread8(chip->vendor->iobase);
+		*buf++ = ioread8(chip->vendor.iobase);
 	}
 
 	/* size of the data received */
@@ -63,7 +63,7 @@ static int tpm_atml_recv(struct tpm_chip
 		dev_err(chip->dev,
 			"Recv size(%d) less than available space\n", size);
 		for (; i < size; i++) {	/* clear the waiting data anyway */
-			status = ioread8(chip->vendor->iobase + 1);
+			status = ioread8(chip->vendor.iobase + 1);
 			if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
 				dev_err(chip->dev, "error reading data\n");
 				return -EIO;
@@ -74,16 +74,16 @@ static int tpm_atml_recv(struct tpm_chip
 
 	/* read all the data available */
 	for (; i < size; i++) {
-		status = ioread8(chip->vendor->iobase + 1);
+		status = ioread8(chip->vendor.iobase + 1);
 		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
 			dev_err(chip->dev, "error reading data\n");
 			return -EIO;
 		}
-		*buf++ = ioread8(chip->vendor->iobase);
+		*buf++ = ioread8(chip->vendor.iobase);
 	}
 
 	/* make sure data available is gone */
-	status = ioread8(chip->vendor->iobase + 1);
+	status = ioread8(chip->vendor.iobase + 1);
 
 	if (status & ATML_STATUS_DATA_AVAIL) {
 		dev_err(chip->dev, "data available is stuck\n");
@@ -100,7 +100,7 @@ static int tpm_atml_send(struct tpm_chip
 	dev_dbg(chip->dev, "tpm_atml_send:\n");
 	for (i = 0; i < count; i++) {
 		dev_dbg(chip->dev, "%d 0x%x(%d)\n",  i, buf[i], buf[i]);
- 		iowrite8(buf[i], chip->vendor->iobase);
+ 		iowrite8(buf[i], chip->vendor.iobase);
 	}
 
 	return count;
@@ -108,12 +108,12 @@ static int tpm_atml_send(struct tpm_chip
 
 static void tpm_atml_cancel(struct tpm_chip *chip)
 {
-	iowrite8(ATML_STATUS_ABORT, chip->vendor->iobase + 1);
+	iowrite8(ATML_STATUS_ABORT, chip->vendor.iobase + 1);
 }
 
 static u8 tpm_atml_status(struct tpm_chip *chip)
 {
-	return ioread8(chip->vendor->iobase + 1);
+	return ioread8(chip->vendor.iobase + 1);
 }
 
 static struct file_operations atmel_ops = {
@@ -159,10 +159,10 @@ static void atml_plat_remove(void)
 	struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
 
 	if (chip) {
-		if (chip->vendor->have_region)
-			atmel_release_region(chip->vendor->base,
-					     chip->vendor->region_size);
-		atmel_put_base_addr(chip->vendor);
+		if (chip->vendor.have_region)
+			atmel_release_region(chip->vendor.base,
+					     chip->vendor.region_size);
+		atmel_put_base_addr(chip->vendor.iobase);
 		tpm_remove_hardware(chip->dev);
 		platform_device_unregister(pdev);
 	}
--- linux-2.6.16/drivers/char/tpm/tpm_nsc.c	2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm_nsc.c	2006-03-02 15:06:07.188679000 -0600
@@ -71,7 +71,7 @@ static int wait_for_stat(struct tpm_chip
 	unsigned long stop;
 
 	/* status immediately available check */
-	*data = inb(chip->vendor->base + NSC_STATUS);
+	*data = inb(chip->vendor.base + NSC_STATUS);
 	if ((*data & mask) == val)
 		return 0;
 
@@ -79,7 +79,7 @@ static int wait_for_stat(struct tpm_chip
 	stop = jiffies + 10 * HZ;
 	do {
 		msleep(TPM_TIMEOUT);
-		*data = inb(chip->vendor->base + 1);
+		*data = inb(chip->vendor.base + 1);
 		if ((*data & mask) == val)
 			return 0;
 	}
@@ -94,9 +94,9 @@ static int nsc_wait_for_ready(struct tpm
 	unsigned long stop;
 
 	/* status immediately available check */
-	status = inb(chip->vendor->base + NSC_STATUS);
+	status = inb(chip->vendor.base + NSC_STATUS);
 	if (status & NSC_STATUS_OBF)
-		status = inb(chip->vendor->base + NSC_DATA);
+		status = inb(chip->vendor.base + NSC_DATA);
 	if (status & NSC_STATUS_RDY)
 		return 0;
 
@@ -104,9 +104,9 @@ static int nsc_wait_for_ready(struct tpm
 	stop = jiffies + 100;
 	do {
 		msleep(TPM_TIMEOUT);
-		status = inb(chip->vendor->base + NSC_STATUS);
+		status = inb(chip->vendor.base + NSC_STATUS);
 		if (status & NSC_STATUS_OBF)
-			status = inb(chip->vendor->base + NSC_DATA);
+			status = inb(chip->vendor.base + NSC_DATA);
 		if (status & NSC_STATUS_RDY)
 			return 0;
 	}
@@ -132,7 +132,7 @@ static int tpm_nsc_recv(struct tpm_chip 
 		return -EIO;
 	}
 	if ((data =
-	     inb(chip->vendor->base + NSC_DATA)) != NSC_COMMAND_NORMAL) {
+	     inb(chip->vendor.base + NSC_DATA)) != NSC_COMMAND_NORMAL) {
 		dev_err(chip->dev, "not in normal mode (0x%x)\n",
 			data);
 		return -EIO;
@@ -148,7 +148,7 @@ static int tpm_nsc_recv(struct tpm_chip 
 		}
 		if (data & NSC_STATUS_F0)
 			break;
-		*p = inb(chip->vendor->base + NSC_DATA);
+		*p = inb(chip->vendor.base + NSC_DATA);
 	}
 
 	if ((data & NSC_STATUS_F0) == 0 &&
@@ -156,7 +156,7 @@ static int tpm_nsc_recv(struct tpm_chip 
 		dev_err(chip->dev, "F0 not set\n");
 		return -EIO;
 	}
-	if ((data = inb(chip->vendor->base + NSC_DATA)) != NSC_COMMAND_EOC) {
+	if ((data = inb(chip->vendor.base + NSC_DATA)) != NSC_COMMAND_EOC) {
 		dev_err(chip->dev,
 			"expected end of command(0x%x)\n", data);
 		return -EIO;
@@ -182,7 +182,7 @@ static int tpm_nsc_send(struct tpm_chip 
 	 * fix it. Not sure why this is needed, we followed the flow
 	 * chart in the manual to the letter.
 	 */
-	outb(NSC_COMMAND_CANCEL, chip->vendor->base + NSC_COMMAND);
+	outb(NSC_COMMAND_CANCEL, chip->vendor.base + NSC_COMMAND);
 
 	if (nsc_wait_for_ready(chip) != 0)
 		return -EIO;
@@ -192,7 +192,7 @@ static int tpm_nsc_send(struct tpm_chip 
 		return -EIO;
 	}
 
-	outb(NSC_COMMAND_NORMAL, chip->vendor->base + NSC_COMMAND);
+	outb(NSC_COMMAND_NORMAL, chip->vendor.base + NSC_COMMAND);
 	if (wait_for_stat(chip, NSC_STATUS_IBR, NSC_STATUS_IBR, &data) < 0) {
 		dev_err(chip->dev, "IBR timeout\n");
 		return -EIO;
@@ -204,26 +204,26 @@ static int tpm_nsc_send(struct tpm_chip 
 				"IBF timeout (while writing data)\n");
 			return -EIO;
 		}
-		outb(buf[i], chip->vendor->base + NSC_DATA);
+		outb(buf[i], chip->vendor.base + NSC_DATA);
 	}
 
 	if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
 		dev_err(chip->dev, "IBF timeout\n");
 		return -EIO;
 	}
-	outb(NSC_COMMAND_EOC, chip->vendor->base + NSC_COMMAND);
+	outb(NSC_COMMAND_EOC, chip->vendor.base + NSC_COMMAND);
 
 	return count;
 }
 
 static void tpm_nsc_cancel(struct tpm_chip *chip)
 {
-	outb(NSC_COMMAND_CANCEL, chip->vendor->base + NSC_COMMAND);
+	outb(NSC_COMMAND_CANCEL, chip->vendor.base + NSC_COMMAND);
 }
 
 static u8 tpm_nsc_status(struct tpm_chip *chip)
 {
-	return inb(chip->vendor->base + NSC_STATUS);
+	return inb(chip->vendor.base + NSC_STATUS);
 }
 
 static struct file_operations nsc_ops = {
@@ -268,7 +268,7 @@ static void __devexit tpm_nsc_remove(str
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
 	if ( chip ) {
-		release_region(chip->vendor->base, 2);
+		release_region(chip->vendor.base, 2);
 		tpm_remove_hardware(chip->dev);
 	}
 }
--- linux-2.6.16/drivers/char/tpm/tpm.h	2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm.h	2006-03-29 14:16:30.119053500 -0600
@@ -80,7 +93,7 @@ struct tpm_chip {
 	struct work_struct work;
 	struct semaphore tpm_mutex;	/* tpm is processing */
 
-	struct tpm_vendor_specific *vendor;
+	struct tpm_vendor_specific vendor;
 
 	struct dentry **bios_dir;
 


