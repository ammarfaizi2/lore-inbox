Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263684AbVBCQn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263684AbVBCQn4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbVBCQnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:43:42 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36490 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263403AbVBCQk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:40:28 -0500
Date: Thu, 3 Feb 2005 10:40:19 -0600 (CST)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: [PATCH 1/1] tpm: remove pci specific stuff from the underlying
 generic driver
In-Reply-To: <Pine.LNX.4.58.0501311322380.9872@jo.austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0502031034290.18135@jo.austin.ibm.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com>
 <29495f1d041221085144b08901@mail.gmail.com> <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501181735110.13908@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501281539340.6360@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501311322380.9872@jo.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since future versions of this chip might not be pci devices and the 
generic tpm driver does not need access to the pci related fields, 
I updated the structures and functions to use struct device and related functions 
rather than the pci equivalents.  This simplifies many things including 
dev_dbg and dev_err calls which were pulling the dev structure out of the 
pci_dev everytime.  Also pci calls to get and set driver data were merely 
pulling this structure out and passing it on as well.  Now only the vendor 
specific drivers (atmel and national at this time) will know about the pci 
device stuff and future non-pci chips can easily be connected to the 
architecture.

Thanks,
Kylie

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN linux-2.6.10/drivers/char/tpm/tpm_atmel.c linux-2.6.10-tpm/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.10/drivers/char/tpm/tpm_atmel.c	2005-02-01 11:08:44.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm_atmel.c	2005-02-01 11:27:58.000000000 -0600
@@ -48,8 +48,7 @@ static int tpm_atml_recv(struct tpm_chip
 	for (i = 0; i < 6; i++) {
 		status = inb(chip->vendor->base + 1);
 		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
-			dev_err(&chip->pci_dev->dev,
-				"error reading header\n");
+			dev_err(chip->dev, "error reading header\n");
 			return -EIO;
 		}
 		*buf++ = inb(chip->vendor->base);
@@ -60,13 +59,12 @@ static int tpm_atml_recv(struct tpm_chip
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
@@ -77,8 +75,7 @@ static int tpm_atml_recv(struct tpm_chip
 	for (; i < size; i++) {
 		status = inb(chip->vendor->base + 1);
 		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
-			dev_err(&chip->pci_dev->dev,
-				"error reading data\n");
+			dev_err(chip->dev, "error reading data\n");
 			return -EIO;
 		}
 		*buf++ = inb(chip->vendor->base);
@@ -87,7 +84,7 @@ static int tpm_atml_recv(struct tpm_chip
 	/* make sure data available is gone */
 	status = inb(chip->vendor->base + 1);
 	if (status & ATML_STATUS_DATA_AVAIL) {
-		dev_err(&chip->pci_dev->dev, "data available is stuck\n");
+		dev_err(chip->dev, "data available is stuck\n");
 		return -EIO;
 	}
 
@@ -98,9 +95,9 @@ static int tpm_atml_send(struct tpm_chip
 {
 	int i;
 
-	dev_dbg(&chip->pci_dev->dev, "tpm_atml_send: ");
+	dev_dbg(chip->dev, "tpm_atml_send: ");
 	for (i = 0; i < count; i++) {
-		dev_dbg(&chip->pci_dev->dev, "0x%x(%d) ", buf[i], buf[i]);
+		dev_dbg(chip->dev, "0x%x(%d) ", buf[i], buf[i]);
 		outb(buf[i], chip->vendor->base);
 	}
 
@@ -114,7 +111,7 @@ static void tpm_atml_cancel(struct tpm_c
 
 static u8 tpm_atml_status(struct tpm_chip *chip)
 {
-	return inb( chip->vendor->base + 1);
+	return inb(chip->vendor->base + 1);
 }
 
 static struct file_operations atmel_ops = {
@@ -169,7 +166,7 @@ static int __devinit tpm_atml_init(struc
 		goto out_err;
 	}
 
-	if ((rc = tpm_register_hardware(pci_dev, &tpm_atmel)) < 0)
+	if ((rc = tpm_register_hardware(&pci_dev->dev, &tpm_atmel)) < 0)
 		goto out_err;
 
 	dev_info(&pci_dev->dev,
@@ -182,6 +179,12 @@ out_err:
 	return rc;
 }
 
+static void __devexit tpm_atml_remove(struct pci_dev *pci_dev)
+{
+	tpm_remove_hardware(&pci_dev->dev);
+	pci_disable_device(pci_dev);
+}
+
 static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
@@ -198,7 +201,7 @@ static struct pci_driver atmel_pci_drive
 	.name = "tpm_atmel",
 	.id_table = tpm_pci_tbl,
 	.probe = tpm_atml_init,
-	.remove = __devexit_p(tpm_remove),
+	.remove = __devexit_p(tpm_atml_remove),
 	.suspend = tpm_pm_suspend,
 	.resume = tpm_pm_resume,
 };
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.c linux-2.6.10-tpm/drivers/char/tpm/tpm.c
--- linux-2.6.10/drivers/char/tpm/tpm.c	2005-02-01 11:08:44.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.c	2005-02-01 11:27:40.000000000 -0600
@@ -142,7 +141,7 @@ static ssize_t tpm_transmit(struct tpm_c
 	if (count == 0)
 		return -ENODATA;
 	if (count > bufsiz) {
-		dev_err(&chip->pci_dev->dev,
+		dev_err(chip->dev,
 			"invalid count value %x %x \n", count, bufsiz);
 		return -E2BIG;
 	}
@@ -150,7 +149,7 @@ static ssize_t tpm_transmit(struct tpm_c
 	down(&chip->tpm_mutex);
 
 	if ((len = chip->vendor->send(chip, (u8 *) buf, count)) < 0) {
-		dev_err(&chip->pci_dev->dev,
+		dev_err(chip->dev,
 			"tpm_transmit: tpm_send: error %d\n", len);
 		up(&chip->tpm_mutex);
 		return len;
@@ -181,14 +180,14 @@ static ssize_t tpm_transmit(struct tpm_c
 
 
 	chip->vendor->cancel(chip);
-	dev_err(&chip->pci_dev->dev, "Time expired\n");
+	dev_err(chip->dev, "Time expired\n");
 	up(&chip->tpm_mutex);
 	return -EIO;
 
 out_recv:
 	len = chip->vendor->recv(chip, (u8 *) buf, bufsiz);
 	if (len < 0)
-		dev_err(&chip->pci_dev->dev,
+		dev_err(chip->dev,
 			"tpm_transmit: tpm_recv: error %d\n", len);
 	up(&chip->tpm_mutex);
 	return len;
@@ -220,8 +219,7 @@ static ssize_t show_pcrs(struct device *
 	int i, j, index, num_pcrs;
 	char *str = buf;
 
-	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	struct tpm_chip *chip = dev_get_drvdata(dev);
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -264,8 +262,7 @@ static ssize_t show_pubek(struct device 
 	int i;
 	char *str = buf;
 
-	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	struct tpm_chip *chip = dev_get_drvdata(dev);
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -337,8 +334,7 @@ static ssize_t show_caps(struct device *
 	ssize_t len;
 	char *str = buf;
 
-	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	struct tpm_chip *chip = dev_get_drvdata(dev);
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -390,21 +386,20 @@ int tpm_open(struct inode *inode, struct
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
 
@@ -423,7 +418,7 @@ EXPORT_SYMBOL_GPL(tpm_open);
 int tpm_release(struct inode *inode, struct file *file)
 {
 	struct tpm_chip *chip = file->private_data;
-	
+
 	file->private_data = NULL;
 
 	spin_lock(&driver_lock);
@@ -440,7 +435,7 @@ int tpm_release(struct inode *inode, str
 	kfree(chip->data_buffer);
 	atomic_set(&chip->data_pending, 0);
 
-	pci_dev_put(chip->pci_dev);
+	put_device(chip->dev);
 	return 0;
 }
 
@@ -525,12 +520,12 @@ ssize_t tpm_read(struct file * file, cha
 
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
 
@@ -540,23 +535,21 @@ void __devexit tpm_remove(struct pci_dev
 
 	spin_unlock(&driver_lock);
 
-	pci_set_drvdata(pci_dev, NULL);
+	dev_set_drvdata(dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
 
-	device_remove_file(&pci_dev->dev, &dev_attr_pubek);
-	device_remove_file(&pci_dev->dev, &dev_attr_pcrs);
-	device_remove_file(&pci_dev->dev, &dev_attr_caps);
-
-	pci_disable_device(pci_dev);
+	device_remove_file(dev, &dev_attr_pubek);
+	device_remove_file(dev, &dev_attr_pcrs);
+	device_remove_file(dev, &dev_attr_caps);
 
 	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
 
 	kfree(chip);
 
-	pci_dev_put(pci_dev);
+	put_device(dev);
 }
 
-EXPORT_SYMBOL_GPL(tpm_remove);
+EXPORT_SYMBOL_GPL(tpm_remove_hardware);
 
 static u8 savestate[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
@@ -607,7 +600,7 @@ EXPORT_SYMBOL_GPL(tpm_pm_resume);
  * upon errant exit from this function specific probe function should call
  * pci_disable_device
  */
-int tpm_register_hardware(struct pci_dev *pci_dev,
+int tpm_register_hardware(struct device *dev,
 			  struct tpm_vendor_specific *entry)
 {
 	char devname[7];
@@ -640,8 +633,7 @@ int tpm_register_hardware(struct pci_dev
 
 dev_num_search_complete:
 	if (chip->dev_num < 0) {
-		dev_err(&pci_dev->dev,
-			"No available tpm device numbers\n");
+		dev_err(dev, "No available tpm device numbers\n");
 		kfree(chip);
 		return -ENODEV;
 	} else if (chip->dev_num == 0)
@@ -652,27 +644,27 @@ dev_num_search_complete:
 	snprintf(devname, sizeof(devname), "%s%d", "tpm", chip->dev_num);
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
 	}
 
-	pci_set_drvdata(pci_dev, chip);
+	dev_set_drvdata(dev, chip);
 
 	list_add(&chip->list, &tpm_chip_list);
 
-	device_create_file(&pci_dev->dev, &dev_attr_pubek);
-	device_create_file(&pci_dev->dev, &dev_attr_pcrs);
-	device_create_file(&pci_dev->dev, &dev_attr_caps);
+	device_create_file(dev, &dev_attr_pubek);
+	device_create_file(dev, &dev_attr_pcrs);
+	device_create_file(dev, &dev_attr_caps);
 
 	return 0;
 }
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.h linux-2.6.10-tpm/drivers/char/tpm/tpm.h
--- linux-2.6.10/drivers/char/tpm/tpm.h	2005-02-01 11:08:44.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.h	2005-02-01 11:28:30.000000000 -0600
@@ -45,7 +45,7 @@ struct tpm_vendor_specific {
 };
 
 struct tpm_chip {
-	struct pci_dev *pci_dev;	/* PCI device stuff */
+	struct device *dev;	/* PCI device stuff */
 
 	int dev_num;		/* /dev/tpm# */
 	int num_opens;		/* only one allowed */
@@ -81,13 +81,13 @@ static inline void tpm_write_index(int i
 extern void tpm_time_expired(unsigned long);
 extern int tpm_lpc_bus_init(struct pci_dev *, u16);
 
-extern int tpm_register_hardware(struct pci_dev *,
+extern int tpm_register_hardware(struct device *,
 				 struct tpm_vendor_specific *);
+extern void tpm_remove_hardware(struct device *);
 extern int tpm_open(struct inode *, struct file *);
 extern int tpm_release(struct inode *, struct file *);
 extern ssize_t tpm_write(struct file *, const char __user *, size_t,
 			 loff_t *);
 extern ssize_t tpm_read(struct file *, char __user *, size_t, loff_t *);
-extern void __devexit tpm_remove(struct pci_dev *);
 extern int tpm_pm_suspend(struct pci_dev *, u32);
 extern int tpm_pm_resume(struct pci_dev *);
diff -uprN linux-2.6.10/drivers/char/tpm/tpm_nsc.c linux-2.6.10-tpm/drivers/char/tpm/tpm_nsc.c
--- linux-2.6.10/drivers/char/tpm/tpm_nsc.c	2005-02-01 11:08:44.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm_nsc.c	2005-02-01 11:28:14.000000000 -0600
@@ -111,7 +111,7 @@ static int nsc_wait_for_ready(struct tpm
 	}
 	while (!expired);
 
-	dev_info(&chip->pci_dev->dev, "wait for ready failed\n");
+	dev_info(chip->dev, "wait for ready failed\n");
 	return -EBUSY;
 }
 
@@ -127,13 +127,12 @@ static int tpm_nsc_recv(struct tpm_chip 
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
 
@@ -141,7 +140,7 @@ static int tpm_nsc_recv(struct tpm_chip 
 	for (p = buffer; p < &buffer[count]; p++) {
 		if (wait_for_stat
 		    (chip, NSC_STATUS_OBF, NSC_STATUS_OBF, &data) < 0) {
-			dev_err(&chip->pci_dev->dev,
+			dev_err(chip->dev,
 				"OBF timeout (while reading data)\n");
 			return -EIO;
 		}
@@ -151,11 +150,11 @@ static int tpm_nsc_recv(struct tpm_chip 
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
@@ -186,19 +185,19 @@ static int tpm_nsc_send(struct tpm_chip 
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
@@ -206,7 +205,7 @@ static int tpm_nsc_send(struct tpm_chip 
 	}
 
 	if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
-		dev_err(&chip->pci_dev->dev, "IBF timeout\n");
+		dev_err(chip->dev, "IBF timeout\n");
 		return -EIO;
 	}
 	outb(NSC_COMMAND_EOC, chip->vendor->base + NSC_COMMAND);
@@ -329,7 +328,7 @@ static int __devinit tpm_nsc_init(struct
 	tpm_write_index(NSC_LDC_INDEX, 0x01);
 	tpm_read_index(NSC_LDC_INDEX);
 
-	if ((rc = tpm_register_hardware(pci_dev, &tpm_nsc)) < 0)
+	if ((rc = tpm_register_hardware(&pci_dev->dev, &tpm_nsc)) < 0)
 		goto out_err;
 
 	return 0;
@@ -339,6 +338,12 @@ out_err:
 	return rc;
 }
 
+static void __devexit tpm_nsc_remove(struct pci_dev *pci_dev)
+{
+	tpm_remove_hardware(&pci_dev->dev);
+	pci_disable_device(pci_dev);
+}
+
 static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
@@ -355,7 +360,7 @@ static struct pci_driver nsc_pci_driver 
 	.name = "tpm_nsc",
 	.id_table = tpm_pci_tbl,
 	.probe = tpm_nsc_init,
-	.remove = __devexit_p(tpm_remove),
+	.remove = __devexit_p(tpm_nsc_remove),
 	.suspend = tpm_pm_suspend,
 	.resume = tpm_pm_resume,
 };
