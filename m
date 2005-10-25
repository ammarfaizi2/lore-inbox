Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVJYPVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVJYPVY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 11:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVJYPVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 11:21:24 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:8125 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932180AbVJYPVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 11:21:22 -0400
Subject: [PATCH 2 of 6] tpm: remove pci dependency
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Date: Tue, 25 Oct 2005 10:21:51 -0500
Message-Id: <1130253711.4839.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the tpm does not have it's own pci id we have been consuming the
lpc bus.  This is not correct and causes problems to support non lpc bus
chips.  This patch removes the dependency on pci_dev from tpm.c  The
subsequent patches will stop the supported chips from registering as pci
drivers.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---

diff -uprN --exclude='.*' --exclude='*.o' --exclude='*.ko' linux-2.6.13/drivers/char/tpm/tpm_atmel.c linux-2.6.13-tpm/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.13/drivers/char/tpm/tpm_atmel.c	2005-09-12 10:44:08.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm_atmel.c	2005-09-09 12:43:10.000000000 -0500
@@ -54,7 +54,7 @@ static int tpm_atml_recv(struct tpm_chip
 	for (i = 0; i < 6; i++) {
 		status = inb(chip->vendor->base + 1);
 		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
-			dev_err(&chip->pci_dev->dev,
+			dev_err(chip->dev,
 				"error reading header\n");
 			return -EIO;
 		}
@@ -66,12 +66,12 @@ static int tpm_atml_recv(struct tpm_chip
 	size = be32_to_cpu(*native_size);
 
 	if (count < size) {
-		dev_err(&chip->pci_dev->dev,
+		dev_err(chip->dev,
 			"Recv size(%d) less than available space\n", size);
 		for (; i < size; i++) {	/* clear the waiting data anyway */
 			status = inb(chip->vendor->base + 1);
 			if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
-				dev_err(&chip->pci_dev->dev,
+				dev_err(chip->dev,
 					"error reading data\n");
 				return -EIO;
 			}
@@ -83,7 +83,7 @@ static int tpm_atml_recv(struct tpm_chip
 	for (; i < size; i++) {
 		status = inb(chip->vendor->base + 1);
 		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
-			dev_err(&chip->pci_dev->dev,
+			dev_err(chip->dev,
 				"error reading data\n");
 			return -EIO;
 		}
@@ -93,7 +93,7 @@ static int tpm_atml_recv(struct tpm_chip
 	/* make sure data available is gone */
 	status = inb(chip->vendor->base + 1);
 	if (status & ATML_STATUS_DATA_AVAIL) {
-		dev_err(&chip->pci_dev->dev, "data available is stuck\n");
+		dev_err(chip->dev, "data available is stuck\n");
 		return -EIO;
 	}
 
@@ -104,9 +104,9 @@ static int tpm_atml_send(struct tpm_chip
 {
 	int i;
 
-	dev_dbg(&chip->pci_dev->dev, "tpm_atml_send: ");
+	dev_dbg(chip->dev, "tpm_atml_send:\n");
 	for (i = 0; i < count; i++) {
-		dev_dbg(&chip->pci_dev->dev, "0x%x(%d) ", buf[i], buf[i]);
+		dev_dbg(chip->dev, "%d 0x%x(%d)\n",  i, buf[i], buf[i]);
 		outb(buf[i], chip->vendor->base);
 	}
 
@@ -193,7 +193,7 @@ static int __devinit tpm_atml_init(struc
 		goto out_err;
 	}
 
-	if ((rc = tpm_register_hardware(pci_dev, &tpm_atmel)) < 0)
+	if ((rc = tpm_register_hardware(&pci_dev->dev, &tpm_atmel)) < 0)
 		goto out_err;
 
 	dev_info(&pci_dev->dev,
@@ -206,6 +206,14 @@ out_err:
 	return rc;
 }
 
+static void __devexit tpm_atml_remove(struct pci_dev *pci_dev) 
+{
+	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+
+	if ( chip )
+		tpm_remove_hardware(chip->dev);
+}
+
 static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
@@ -223,7 +231,7 @@ static struct pci_driver atmel_pci_drive
 	.name = "tpm_atmel",
 	.id_table = tpm_pci_tbl,
 	.probe = tpm_atml_init,
-	.remove = __devexit_p(tpm_remove),
+	.remove = __devexit_p(tpm_atml_remove),
 	.suspend = tpm_pm_suspend,
 	.resume = tpm_pm_resume,
 };
diff -uprN --exclude='.*' --exclude='*.o' --exclude='*.ko' linux-2.6.13/drivers/char/tpm/tpm.c linux-2.6.13-tpm/drivers/char/tpm/tpm.c
--- linux-2.6.13/drivers/char/tpm/tpm.c	2005-09-12 10:44:08.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm.c	2005-09-09 12:31:26.000000000 -0500
@@ -64,7 +64,7 @@ static ssize_t tpm_transmit(struct tpm_c
 	if (count == 0)
 		return -ENODATA;
 	if (count > bufsiz) {
-		dev_err(&chip->pci_dev->dev,
+		dev_err(chip->dev,
 			"invalid count value %x %zx \n", count, bufsiz);
 		return -E2BIG;
 	}
@@ -72,7 +72,7 @@ static ssize_t tpm_transmit(struct tpm_c
 	down(&chip->tpm_mutex);
 
 	if ((rc = chip->vendor->send(chip, (u8 *) buf, count)) < 0) {
-		dev_err(&chip->pci_dev->dev,
+		dev_err(chip->dev,
 			"tpm_transmit: tpm_send: error %zd\n", rc);
 		goto out;
 	}
@@ -86,7 +86,7 @@ static ssize_t tpm_transmit(struct tpm_c
 		}
 
 		if ((status == chip->vendor->req_canceled)) {
-			dev_err(&chip->pci_dev->dev, "Operation Canceled\n");
+			dev_err(chip->dev, "Operation Canceled\n");
 			rc = -ECANCELED;
 			goto out;
 		}
@@ -97,14 +97,14 @@ static ssize_t tpm_transmit(struct tpm_c
 
 
 	chip->vendor->cancel(chip);
-	dev_err(&chip->pci_dev->dev, "Operation Timed out\n");
+	dev_err(chip->dev, "Operation Timed out\n");
 	rc = -ETIME;
 	goto out;
 
 out_recv:
 	rc = chip->vendor->recv(chip, (u8 *) buf, bufsiz);
 	if (rc < 0)
-		dev_err(&chip->pci_dev->dev,
+		dev_err(chip->dev,
 			"tpm_transmit: tpm_recv: error %zd\n", rc);
 out:
 	up(&chip->tpm_mutex);
@@ -139,15 +139,14 @@ ssize_t tpm_show_pcrs(struct device *dev
 	__be32 index;
 	char *str = buf;
 
-	struct tpm_chip *chip =
-	    pci_get_drvdata(to_pci_dev(dev));
+	struct tpm_chip *chip = dev_get_drvdata(dev);
 	if (chip == NULL)
 		return -ENODEV;
 
 	memcpy(data, cap_pcr, sizeof(cap_pcr));
 	if ((len = tpm_transmit(chip, data, sizeof(data)))
 	    < CAP_PCR_RESULT_SIZE) {
-		dev_dbg(&chip->pci_dev->dev, "A TPM error (%d) occurred "
+		dev_dbg(chip->dev, "A TPM error (%d) occurred "
 				"attempting to determine the number of PCRS\n",
 			be32_to_cpu(*((__be32 *) (data + 6))));
 		return 0;
@@ -161,7 +160,7 @@ ssize_t tpm_show_pcrs(struct device *dev
 		memcpy(data + 10, &index, 4);
 		if ((len = tpm_transmit(chip, data, sizeof(data)))
 		    < READ_PCR_RESULT_SIZE){
-			dev_dbg(&chip->pci_dev->dev, "A TPM error (%d) occurred"
+			dev_dbg(chip->dev, "A TPM error (%d) occurred"
 				" attempting to read PCR %d of %d\n",
 				be32_to_cpu(*((__be32 *) (data + 6))), i, num_pcrs);
 			goto out;
@@ -191,8 +190,7 @@ ssize_t tpm_show_pubek(struct device *de
 	int i, rc;
 	char *str = buf;
 
-	struct tpm_chip *chip =
-	    pci_get_drvdata(to_pci_dev(dev));
+	struct tpm_chip *chip = dev_get_drvdata(dev);
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -205,7 +203,7 @@ ssize_t tpm_show_pubek(struct device *de
 
 	if ((len = tpm_transmit(chip, data, READ_PUBEK_RESULT_SIZE)) <
 	    READ_PUBEK_RESULT_SIZE) {
-		dev_dbg(&chip->pci_dev->dev, "A TPM error (%d) occurred "
+		dev_dbg(chip->dev, "A TPM error (%d) occurred "
 				"attempting to read the PUBEK\n",
 			    be32_to_cpu(*((__be32 *) (data + 6))));
 		rc = 0;
@@ -274,8 +272,7 @@ ssize_t tpm_show_caps(struct device *dev
 	ssize_t len;
 	char *str = buf;
 
-	struct tpm_chip *chip =
-	    pci_get_drvdata(to_pci_dev(dev));
+	struct tpm_chip *chip = dev_get_drvdata(dev);
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -339,21 +336,21 @@ int tpm_open(struct inode *inode, struct
 	}
 
 	if (chip->num_opens) {
-		dev_dbg(&chip->pci_dev->dev,
+		dev_dbg(chip->dev,
 			"Another process owns this TPM\n");
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
 
@@ -378,7 +375,7 @@ int tpm_release(struct inode *inode, str
 	chip->num_opens--;
 	del_singleshot_timer_sync(&chip->user_read_timer);
 	atomic_set(&chip->data_pending, 0);
-	pci_dev_put(chip->pci_dev);
+	put_device(chip->dev);
 	kfree(chip->data_buffer);
 	spin_unlock(&driver_lock);
 	return 0;
@@ -447,12 +444,12 @@ ssize_t tpm_read(struct file * file, cha
 
 EXPORT_SYMBOL_GPL(tpm_read);
 
-void __devexit tpm_remove(struct pci_dev *pci_dev)
+void tpm_remove_hardware(struct device *dev)
 {
-	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+	struct tpm_chip *chip = dev_get_drvdata(dev);
 
 	if (chip == NULL) {
-		dev_err(&pci_dev->dev, "No device data found\n");
+		dev_err(dev, "No device data found\n");
 		return;
 	}
 
@@ -462,22 +459,20 @@ void __devexit tpm_remove(struct pci_dev
 
 	spin_unlock(&driver_lock);
 
-	pci_set_drvdata(pci_dev, NULL);
+	dev_set_drvdata(dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
 	kfree(chip->vendor->miscdev.name);
 
-	sysfs_remove_group(&pci_dev->dev.kobj, chip->vendor->attr_group);
-
-	pci_disable_device(pci_dev);
+	sysfs_remove_group(&dev->kobj, chip->vendor->attr_group);
 
 	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES ] &= !(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
 
 	kfree(chip);
 
-	pci_dev_put(pci_dev);
+	put_device(dev);
 }
 
-EXPORT_SYMBOL_GPL(tpm_remove);
+EXPORT_SYMBOL_GPL(tpm_remove_hardware);
 
 static u8 savestate[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
@@ -524,7 +519,7 @@ EXPORT_SYMBOL_GPL(tpm_pm_resume);
  * upon errant exit from this function specific probe function should call
  * pci_disable_device
  */
-int tpm_register_hardware(struct pci_dev *pci_dev,
+int tpm_register_hardware(struct device *dev,
 			  struct tpm_vendor_specific *entry)
 {
 #define DEVNAME_SIZE 7
@@ -563,7 +558,7 @@ int tpm_register_hardware(struct pci_dev
 
 dev_num_search_complete:
 	if (chip->dev_num < 0) {
-		dev_err(&pci_dev->dev,
+		dev_err(dev,
 			"No available tpm device numbers\n");
 		kfree(chip);
 		return -ENODEV;
@@ -576,15 +571,15 @@ dev_num_search_complete:
 	scnprintf(devname, DEVNAME_SIZE, "%s%d", "tpm", chip->dev_num);
 	chip->vendor->miscdev.name = devname;
 
-	chip->vendor->miscdev.dev = &(pci_dev->dev);
-	chip->pci_dev = pci_dev_get(pci_dev);
+	chip->vendor->miscdev.dev = dev;
+	chip->dev = get_device(dev);
 
 	if (misc_register(&chip->vendor->miscdev)) {
-		dev_err(&chip->pci_dev->dev,
+		dev_err(chip->dev,
 			"unable to misc_register %s, minor %d\n",
 			chip->vendor->miscdev.name,
 			chip->vendor->miscdev.minor);
-		pci_dev_put(pci_dev);
+		put_device(dev);
 		kfree(chip);
 		dev_mask[i] &= !(1 << j);
 		return -ENODEV;
@@ -592,13 +587,13 @@ dev_num_search_complete:
 
 	spin_lock(&driver_lock);
 
-	pci_set_drvdata(pci_dev, chip);
+	dev_set_drvdata(dev, chip);
 
 	list_add(&chip->list, &tpm_chip_list);
 
 	spin_unlock(&driver_lock);
 
-	sysfs_create_group(&pci_dev->dev.kobj, chip->vendor->attr_group);
+	sysfs_create_group(&dev->kobj, chip->vendor->attr_group);
 
 	return 0;
 }
diff -uprN --exclude='.*' --exclude='*.o' --exclude='*.ko' linux-2.6.13/drivers/char/tpm/tpm.h linux-2.6.13-tpm/drivers/char/tpm/tpm.h
--- linux-2.6.13/drivers/char/tpm/tpm.h	2005-09-12 10:44:08.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm.h	2005-09-09 12:42:37.000000000 -0500
@@ -61,7 +61,7 @@ struct tpm_vendor_specific {
 };
 
 struct tpm_chip {
-	struct pci_dev *pci_dev;	/* PCI device stuff */
+	struct device *dev;	/* Device stuff */
 
 	int dev_num;		/* /dev/tpm# */
 	int num_opens;		/* only one allowed */
@@ -92,13 +92,13 @@ static inline void tpm_write_index(int b
 	outb(value & 0xFF, base+1);
 }
 
-extern int tpm_register_hardware(struct pci_dev *,
+extern int tpm_register_hardware(struct device *,
 				 struct tpm_vendor_specific *);
 extern int tpm_open(struct inode *, struct file *);
 extern int tpm_release(struct inode *, struct file *);
 extern ssize_t tpm_write(struct file *, const char __user *, size_t,
 			 loff_t *);
 extern ssize_t tpm_read(struct file *, char __user *, size_t, loff_t *);
-extern void __devexit tpm_remove(struct pci_dev *);
+extern void tpm_remove_hardware(struct device *);
 extern int tpm_pm_suspend(struct pci_dev *, pm_message_t);
 extern int tpm_pm_resume(struct pci_dev *);
diff -uprN --exclude='.*' --exclude='*.o' --exclude='*.ko' linux-2.6.13/drivers/char/tpm/tpm_infineon.c linux-2.6.13-tpm/drivers/char/tpm/tpm_infineon.c
--- linux-2.6.13/drivers/char/tpm/tpm_infineon.c	2005-09-12 10:44:08.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm_infineon.c	2005-09-09 16:44:53.000000000 -0500
@@ -143,10 +143,10 @@ static int wait(struct tpm_chip *chip, i
 	}
 	if (i == TPM_MAX_TRIES) {	/* timeout occurs */
 		if (wait_for_bit == STAT_XFE)
-			dev_err(&chip->pci_dev->dev,
+			dev_err(chip->dev,
 				"Timeout in wait(STAT_XFE)\n");
 		if (wait_for_bit == STAT_RDA)
-			dev_err(&chip->pci_dev->dev,
+			dev_err(chip->dev,
 				"Timeout in wait(STAT_RDA)\n");
 		return -EIO;
 	}
@@ -170,7 +170,7 @@ static void wait_and_send(struct tpm_chi
 static void tpm_wtx(struct tpm_chip *chip)
 {
 	number_of_wtx++;
-	dev_info(&chip->pci_dev->dev, "Granting WTX (%02d / %02d)\n",
+	dev_info(chip->dev, "Granting WTX (%02d / %02d)\n",
 		 number_of_wtx, TPM_MAX_WTX_PACKAGES);
 	wait_and_send(chip, TPM_VL_VER);
 	wait_and_send(chip, TPM_CTRL_WTX);
@@ -181,7 +181,7 @@ static void tpm_wtx(struct tpm_chip *chi
 
 static void tpm_wtx_abort(struct tpm_chip *chip)
 {
-	dev_info(&chip->pci_dev->dev, "Aborting WTX\n");
+	dev_info(chip->dev, "Aborting WTX\n");
 	wait_and_send(chip, TPM_VL_VER);
 	wait_and_send(chip, TPM_CTRL_WTX_ABORT);
 	wait_and_send(chip, 0x00);
@@ -206,7 +206,7 @@ recv_begin:
 	}
 
 	if (buf[0] != TPM_VL_VER) {
-		dev_err(&chip->pci_dev->dev,
+		dev_err(chip->dev,
 			"Wrong transport protocol implementation!\n");
 		return -EIO;
 	}
@@ -221,7 +221,7 @@ recv_begin:
 		}
 
 		if ((size == 0x6D00) && (buf[1] == 0x80)) {
-			dev_err(&chip->pci_dev->dev,
+			dev_err(chip->dev,
 				"Error handling on vendor layer!\n");
 			return -EIO;
 		}
@@ -234,7 +234,7 @@ recv_begin:
 	}
 
 	if (buf[1] == TPM_CTRL_WTX) {
-		dev_info(&chip->pci_dev->dev, "WTX-package received\n");
+		dev_info(chip->dev, "WTX-package received\n");
 		if (number_of_wtx < TPM_MAX_WTX_PACKAGES) {
 			tpm_wtx(chip);
 			goto recv_begin;
@@ -245,14 +245,14 @@ recv_begin:
 	}
 
 	if (buf[1] == TPM_CTRL_WTX_ABORT_ACK) {
-		dev_info(&chip->pci_dev->dev, "WTX-abort acknowledged\n");
+		dev_info(chip->dev, "WTX-abort acknowledged\n");
 		return size;
 	}
 
 	if (buf[1] == TPM_CTRL_ERROR) {
-		dev_err(&chip->pci_dev->dev, "ERROR-package received:\n");
+		dev_err(chip->dev, "ERROR-package received:\n");
 		if (buf[4] == TPM_INF_NAK)
-			dev_err(&chip->pci_dev->dev,
+			dev_err(chip->dev,
 				"-> Negative acknowledgement"
 				" - retransmit command!\n");
 		return -EIO;
@@ -271,7 +271,7 @@ static int tpm_inf_send(struct tpm_chip 
 
 	ret = empty_fifo(chip, 1);
 	if (ret) {
-		dev_err(&chip->pci_dev->dev, "Timeout while clearing FIFO\n");
+		dev_err(chip->dev, "Timeout while clearing FIFO\n");
 		return -EIO;
 	}
 
@@ -484,6 +484,6 @@ static int __devinit tpm_inf_probe(struc
 			 vendorid[0], vendorid[1],
 			 productid[0], productid[1], chipname);
 
-		rc = tpm_register_hardware(pci_dev, &tpm_inf);
+		rc = tpm_register_hardware(&pci_dev->dev, &tpm_inf);
 		if (rc < 0)
 			goto error;
@@ -497,6 +497,14 @@ static int __devinit tpm_inf_probe(struc
 	}
 }
 
+static __devexit void tpm_inf_remove(struct pci_dev* pci_dev) 
+{
+	struct tpm_chip* chip = pci_get_drvdata(pci_dev);
+	
+	if( chip )
+		tpm_remove_hardware(chip->dev);
+}
+
 static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
@@ -515,7 +523,7 @@ static struct pci_driver inf_pci_driver 
 	.name = "tpm_inf",
 	.id_table = tpm_pci_tbl,
 	.probe = tpm_inf_probe,
-	.remove = __devexit_p(tpm_remove),
+	.remove = __devexit_p(tpm_inf_remove),
 	.suspend = tpm_pm_suspend,
 	.resume = tpm_pm_resume,
 };
diff -uprN --exclude='.*' --exclude='*.o' --exclude='*.ko' linux-2.6.13/drivers/char/tpm/tpm_nsc.c linux-2.6.13-tpm/drivers/char/tpm/tpm_nsc.c
--- linux-2.6.13/drivers/char/tpm/tpm_nsc.c	2005-09-12 10:44:08.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm_nsc.c	2005-09-09 12:42:56.000000000 -0500
@@ -111,7 +111,7 @@ static int nsc_wait_for_ready(struct tpm
 	}
 	while (time_before(jiffies, stop));
 
-	dev_info(&chip->pci_dev->dev, "wait for ready failed\n");
+	dev_info(chip->dev, "wait for ready failed\n");
 	return -EBUSY;
 }
 
@@ -127,12 +127,12 @@ static int tpm_nsc_recv(struct tpm_chip 
 		return -EIO;
 
 	if (wait_for_stat(chip, NSC_STATUS_F0, NSC_STATUS_F0, &data) < 0) {
-		dev_err(&chip->pci_dev->dev, "F0 timeout\n");
+		dev_err(chip->dev, "F0 timeout\n");
 		return -EIO;
 	}
 	if ((data =
 	     inb(chip->vendor->base + NSC_DATA)) != NSC_COMMAND_NORMAL) {
-		dev_err(&chip->pci_dev->dev, "not in normal mode (0x%x)\n",
+		dev_err(chip->dev, "not in normal mode (0x%x)\n",
 			data);
 		return -EIO;
 	}
@@ -141,7 +141,7 @@ static int tpm_nsc_recv(struct tpm_chip 
 	for (p = buffer; p < &buffer[count]; p++) {
 		if (wait_for_stat
 		    (chip, NSC_STATUS_OBF, NSC_STATUS_OBF, &data) < 0) {
-			dev_err(&chip->pci_dev->dev,
+			dev_err(chip->dev,
 				"OBF timeout (while reading data)\n");
 			return -EIO;
 		}
@@ -152,11 +152,11 @@ static int tpm_nsc_recv(struct tpm_chip 
 
 	if ((data & NSC_STATUS_F0) == 0 &&
 	(wait_for_stat(chip, NSC_STATUS_F0, NSC_STATUS_F0, &data) < 0)) {
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
@@ -187,19 +187,19 @@ static int tpm_nsc_send(struct tpm_chip 
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
@@ -207,7 +207,7 @@ static int tpm_nsc_send(struct tpm_chip 
 	}
 
 	if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
-		dev_err(&chip->pci_dev->dev, "IBF timeout\n");
+		dev_err(chip->dev, "IBF timeout\n");
 		return -EIO;
 	}
 	outb(NSC_COMMAND_EOC, chip->vendor->base + NSC_COMMAND);
@@ -325,7 +325,7 @@ static int __devinit tpm_nsc_init(struct
 	/* enable the DPM module */
 	tpm_write_index(nscAddrBase, NSC_LDC_INDEX, 0x01);
 
-	if ((rc = tpm_register_hardware(pci_dev, &tpm_nsc)) < 0)
+	if ((rc = tpm_register_hardware(&pci_dev->dev, &tpm_nsc)) < 0)
 		goto out_err;
 
 	return 0;
@@ -335,6 +335,14 @@ out_err:
 	return rc;
 }
 
+static void __devexit tpm_nsc_remove(struct pci_dev *pci_dev) 
+{
+	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+
+	if ( chip )
+		tpm_remove_hardware(chip->dev);
+}
+
 static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
@@ -354,7 +362,7 @@ static struct pci_driver nsc_pci_driver 
 	.name = "tpm_nsc",
 	.id_table = tpm_pci_tbl,
 	.probe = tpm_nsc_init,
-	.remove = __devexit_p(tpm_remove),
+	.remove = __devexit_p(tpm_nsc_remove),
 	.suspend = tpm_pm_suspend,
 	.resume = tpm_pm_resume,
 };


