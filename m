Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbVJ0W01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbVJ0W01 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbVJ0W01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:26:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751596AbVJ0W01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:26:27 -0400
Date: Thu, 27 Oct 2005 15:26:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: kjhall@us.ibm.com, selhorst@crypto.rub.de, linux-kernel@vger.kernel.org,
       castet.matthieu@free.fr
Subject: Re: [PATCH] Infineon TPM: move infineon driver off pci_dev
Message-Id: <20051027152635.11b0f389.akpm@osdl.org>
In-Reply-To: <52zmouvcqi.fsf@cisco.com>
References: <435FB8A5.803@crypto.rub.de>
	<435FBFC4.5060508@free.fr>
	<4360B889.1010502@crypto.rub.de>
	<1130422052.4839.134.camel@localhost.localdomain>
	<20051027145535.0741b647.akpm@osdl.org>
	<52zmouvcqi.fsf@cisco.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
> Andrew, a few comments on your trivial comments:
> 
>     > -static int tpm_atml_send(struct tpm_chip *chip, u8 * buf, size_t count)
>     > +static int tpm_atml_send(struct tpm_chip *chip, u8  *buf, size_t count)
> 
> There's still an extra space there I think.

yup.

>     > -	data = kmalloc(READ_PUBEK_RESULT_SIZE, GFP_KERNEL);
>     > +	data = kxalloc(READ_PUBEK_RESULT_SIZE, GFP_KERNEL);
> 
> When did we add kxalloc()?  And what does it do?

I type with my heels.

>     > -ssize_t tpm_write(struct file * file, const char __user * buf,
>     > +ssize_t tpm_write(struct file * file, const char __user *buf,
> 
> Why delete one space between * and buf but not the one between * and file?


diff -puN drivers/char/tpm/tpm_atmel.c~tpm-tidies drivers/char/tpm/tpm_atmel.c
--- 25/drivers/char/tpm/tpm_atmel.c~tpm-tidies	Thu Oct 27 14:52:43 2005
+++ 25-akpm/drivers/char/tpm/tpm_atmel.c	Thu Oct 27 14:52:43 2005
@@ -40,7 +40,7 @@ enum tpm_atmel_read_status {
 	ATML_STATUS_READY = 0x08
 };
 
-static int tpm_atml_recv(struct tpm_chip *chip, u8 * buf, size_t count)
+static int tpm_atml_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	u8 status, *hdr = buf;
 	u32 size;
@@ -100,7 +100,7 @@ static int tpm_atml_recv(struct tpm_chip
 	return size;
 }
 
-static int tpm_atml_send(struct tpm_chip *chip, u8 * buf, size_t count)
+static int tpm_atml_send(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	int i;
 
@@ -159,12 +159,12 @@ static struct tpm_vendor_specific tpm_at
 	.miscdev = { .fops = &atmel_ops, },
 };
 
-static struct platform_device *pdev = NULL;
+static struct platform_device *pdev;
 
 static void __devexit tpm_atml_remove(struct device *dev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
-	if ( chip ) {
+	if (chip) {
 		release_region(chip->vendor->base, 2);
 		tpm_remove_hardware(chip->dev);
 	}
@@ -201,19 +201,17 @@ static int __init init_atmel(void)
 		(tpm_read_index(TPM_ADDR, 0x01) != 0x01 ))
 		return -ENODEV;
 
-	pdev = kmalloc(sizeof(struct platform_device), GFP_KERNEL);
+	pdev = kzalloc(sizeof(struct platform_device), GFP_KERNEL);
 	if ( !pdev )
 		return -ENOMEM;
 
-	memset(pdev, 0, sizeof(struct platform_device));
-
 	pdev->name = "tpm_atmel0";
 	pdev->id = -1;
 	pdev->num_resources = 0;
 	pdev->dev.release = tpm_atml_remove;
 	pdev->dev.driver = &atml_drv;
 
-	if ((rc=platform_device_register(pdev)) < 0) {
+	if ((rc = platform_device_register(pdev)) < 0) {
 		kfree(pdev);
 		pdev = NULL;
 		return rc;
@@ -234,7 +232,8 @@ static int __init init_atmel(void)
 		return rc;
 	}
 
-	dev_info(&pdev->dev, "Atmel TPM 1.1, Base Address: 0x%x\n", tpm_atmel.base);
+	dev_info(&pdev->dev, "Atmel TPM 1.1, Base Address: 0x%x\n",
+			tpm_atmel.base);
 	return 0;
 }
 
diff -puN drivers/char/tpm/tpm.c~tpm-tidies drivers/char/tpm/tpm.c
--- 25/drivers/char/tpm/tpm.c~tpm-tidies	Thu Oct 27 14:52:43 2005
+++ 25-akpm/drivers/char/tpm/tpm.c	Thu Oct 27 14:52:43 2005
@@ -162,7 +162,8 @@ ssize_t tpm_show_pcrs(struct device *dev
 		    < READ_PCR_RESULT_SIZE){
 			dev_dbg(chip->dev, "A TPM error (%d) occurred"
 				" attempting to read PCR %d of %d\n",
-				be32_to_cpu(*((__be32 *) (data + 6))), i, num_pcrs);
+				be32_to_cpu(*((__be32 *) (data + 6))),
+				i, num_pcrs);
 			goto out;
 		}
 		str += sprintf(str, "PCR-%02d: ", i);
@@ -194,12 +195,11 @@ ssize_t tpm_show_pubek(struct device *de
 	if (chip == NULL)
 		return -ENODEV;
 
-	data = kmalloc(READ_PUBEK_RESULT_SIZE, GFP_KERNEL);
+	data = kzalloc(READ_PUBEK_RESULT_SIZE, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	memcpy(data, readpubek, sizeof(readpubek));
-	memset(data + sizeof(readpubek), 0, 20);	/* zero nonce */
 
 	if ((len = tpm_transmit(chip, data, READ_PUBEK_RESULT_SIZE)) <
 	    READ_PUBEK_RESULT_SIZE) {
@@ -243,7 +243,6 @@ out:
 	kfree(data);
 	return rc;
 }
-
 EXPORT_SYMBOL_GPL(tpm_show_pubek);
 
 #define CAP_VER_RESULT_SIZE 18
@@ -312,7 +311,6 @@ ssize_t tpm_store_cancel(struct device *
 }
 EXPORT_SYMBOL_GPL(tpm_store_cancel);
 
-
 /*
  * Device file system interface to the TPM
  */
@@ -336,8 +334,7 @@ int tpm_open(struct inode *inode, struct
 	}
 
 	if (chip->num_opens) {
-		dev_dbg(chip->dev,
-			"Another process owns this TPM\n");
+		dev_dbg(chip->dev, "Another process owns this TPM\n");
 		rc = -EBUSY;
 		goto err_out;
 	}
@@ -363,7 +360,6 @@ err_out:
 	spin_unlock(&driver_lock);
 	return rc;
 }
-
 EXPORT_SYMBOL_GPL(tpm_open);
 
 int tpm_release(struct inode *inode, struct file *file)
@@ -380,10 +376,9 @@ int tpm_release(struct inode *inode, str
 	spin_unlock(&driver_lock);
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(tpm_release);
 
-ssize_t tpm_write(struct file * file, const char __user * buf,
+ssize_t tpm_write(struct file *file, const char __user *buf,
 		  size_t size, loff_t * off)
 {
 	struct tpm_chip *chip = file->private_data;
@@ -419,7 +414,7 @@ ssize_t tpm_write(struct file * file, co
 
 EXPORT_SYMBOL_GPL(tpm_write);
 
-ssize_t tpm_read(struct file * file, char __user * buf,
+ssize_t tpm_read(struct file * file, char __user *buf,
 		 size_t size, loff_t * off)
 {
 	struct tpm_chip *chip = file->private_data;
@@ -441,7 +436,6 @@ ssize_t tpm_read(struct file * file, cha
 
 	return ret_size;
 }
-
 EXPORT_SYMBOL_GPL(tpm_read);
 
 void tpm_remove_hardware(struct device *dev)
@@ -465,13 +459,13 @@ void tpm_remove_hardware(struct device *
 
 	sysfs_remove_group(&dev->kobj, chip->vendor->attr_group);
 
-	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES ] &= !(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
+	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES ] &=
+		!(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
 
 	kfree(chip);
 
 	put_device(dev);
 }
-
 EXPORT_SYMBOL_GPL(tpm_remove_hardware);
 
 static u8 savestate[] = {
@@ -493,7 +487,6 @@ int tpm_pm_suspend(struct device *dev, p
 	tpm_transmit(chip, savestate, sizeof(savestate));
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(tpm_pm_suspend);
 
 /*
@@ -509,7 +502,6 @@ int tpm_pm_resume(struct device *dev, u3
 
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
 
 /*
@@ -519,8 +511,7 @@ EXPORT_SYMBOL_GPL(tpm_pm_resume);
  * upon errant exit from this function specific probe function should call
  * pci_disable_device
  */
-int tpm_register_hardware(struct device *dev,
-			  struct tpm_vendor_specific *entry)
+int tpm_register_hardware(struct device *dev, struct tpm_vendor_specific *entry)
 {
 #define DEVNAME_SIZE 7
 
@@ -529,12 +520,10 @@ int tpm_register_hardware(struct device 
 	int i, j;
 
 	/* Driver specific per-device data */
-	chip = kmalloc(sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
-	memset(chip, 0, sizeof(struct tpm_chip));
-
 	init_MUTEX(&chip->buffer_mutex);
 	init_MUTEX(&chip->tpm_mutex);
 	INIT_LIST_HEAD(&chip->list);
@@ -558,8 +547,7 @@ int tpm_register_hardware(struct device 
 
 dev_num_search_complete:
 	if (chip->dev_num < 0) {
-		dev_err(dev,
-			"No available tpm device numbers\n");
+		dev_err(dev, "No available tpm device numbers\n");
 		kfree(chip);
 		return -ENODEV;
 	} else if (chip->dev_num == 0)
@@ -597,7 +585,6 @@ dev_num_search_complete:
 
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(tpm_register_hardware);
 
 MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
diff -puN drivers/char/tpm/tpm_infineon.c~tpm-tidies drivers/char/tpm/tpm_infineon.c
--- 25/drivers/char/tpm/tpm_infineon.c~tpm-tidies	Thu Oct 27 14:52:43 2005
+++ 25-akpm/drivers/char/tpm/tpm_infineon.c	Thu Oct 27 14:52:43 2005
@@ -30,10 +30,10 @@
 #define	TPM_INFINEON_DEV_VEN_VALUE	0x15D1
 
 /* These values will be filled after PnP-call */
-static int TPM_INF_DATA = 0;
-static int TPM_INF_ADDR = 0;
-static int TPM_INF_BASE = 0;
-static int TPM_INF_PORT_LEN = 0;
+static int TPM_INF_DATA;
+static int TPM_INF_ADDR;
+static int TPM_INF_BASE;
+static int TPM_INF_PORT_LEN;
 
 /* TPM header definitions */
 enum infineon_tpm_header {
_

