Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVBISGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVBISGs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 13:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVBISGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 13:06:47 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:36563 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261869AbVBISF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 13:05:58 -0500
Date: Wed, 9 Feb 2005 12:05:42 -0600 (CST)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] tpm: update tpm sysfs file ownership
In-Reply-To: <20050204215134.GA27433@kroah.com>
Message-ID: <Pine.LNX.4.58.0502091201110.3969@jo.austin.ibm.com>
References: <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501181735110.13908@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501281539340.6360@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501311322380.9872@jo.austin.ibm.com>
 <Pine.LNX.4.58.0502031034290.18135@jo.austin.ibm.com>
 <Pine.LNX.4.58.0502041405230.22211@jo.austin.ibm.com> <20050204205226.GA26780@kroah.com>
 <1107553040.22140.30.camel@jo.austin.ibm.com> <20050204215134.GA27433@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005, Greg KH wrote:
> On Fri, Feb 04, 2005 at 03:37:20PM -0600, Kylene Hall wrote:
> > On Fri, 2005-02-04 at 14:52, Greg KH wrote:
> > > On Fri, Feb 04, 2005 at 02:12:50PM -0600, Kylene Hall wrote:
> > > > +static struct class tpm_class = {
> > > > +	.name = "tpm",
> > > > +	.class_dev_attrs = tpm_attrs,
> > > > +};
> > > 
> > > Where is your release function?  Did you see any warnings from the
> > > kernel when you removed any of these class devices?  Why did you ignore
> > > it?
> > > 
> > Sorry, I missed the warning message.  I have looked at some other
> > instances for what I might need to put in that function and I'm
> > stumped.  I didn't kmalloc my class_device structure so I don't need to
> > kfree it.
> 
> Anyway, why not try using the class_simple interface instead?  If you do
> that you don't have to worry (as much) in the reference counting logic.

Thanks for pointing me to the class in the miscdevice.  I was able to use 
that for my needs.  I do need this small patch however to get the sysfs 
file ownership correct on my sysfs files.  The patch also adds on more 
sysfs file we need.

Thanks,
Kylie

> 
> thanks,
> 
> greg k-h
> 
> 


Signed off by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.c linux-2.6.10-tpm/drivers/char/tpm/tpm.c
--- linux-2.6.10/drivers/char/tpm/tpm.c	2005-02-04 15:03:03.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.c	2005-02-09 12:23:23.137004424 -0600
@@ -246,8 +246,6 @@ static ssize_t show_pcrs(struct device *
 	return str - buf;
 }
 
-static DEVICE_ATTR(pcrs, S_IRUGO, show_pcrs, NULL);
-
 #define  READ_PUBEK_RESULT_SIZE 314
 static u8 readpubek[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
@@ -308,8 +306,6 @@ static ssize_t show_pubek(struct device 
 	return str - buf;
 }
 
-static DEVICE_ATTR(pubek, S_IRUGO, show_pubek, NULL);
-
 #define CAP_VER_RESULT_SIZE 18
 static u8 cap_version[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
@@ -362,7 +358,22 @@ static ssize_t show_caps(struct device *
 	return str - buf;
 }
 
-static DEVICE_ATTR(caps, S_IRUGO, show_caps, NULL);
+static ssize_t store_cancel(struct device *dev, const char *buf,
+			    size_t count)
+{
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	if (chip == NULL)
+		return 0;
+
+	chip->vendor->cancel(chip);
+
+	down(&chip->timer_manipulation_mutex);
+	if (timer_pending(&chip->device_timer))
+		mod_timer(&chip->device_timer, jiffies);
+	up(&chip->timer_manipulation_mutex);
+
+	return count;
+}
 
 /*
  * Device file system interface to the TPM
@@ -524,6 +535,7 @@ EXPORT_SYMBOL_GPL(tpm_read);
 void tpm_remove_hardware(struct device *dev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
+	int i;
 
 	if (chip == NULL) {
 		dev_err(dev, "No device data found\n");
@@ -539,9 +551,8 @@ void tpm_remove_hardware(struct device *
 	dev_set_drvdata(dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
 
-	device_remove_file(dev, &dev_attr_pubek);
-	device_remove_file(dev, &dev_attr_pcrs);
-	device_remove_file(dev, &dev_attr_caps);
+	for ( i = 0; i < TPM_ATTRS; i++ ) 
+		device_remove_file(dev, &chip->attr[i]);
 
 	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
 
@@ -608,6 +619,11 @@ int tpm_register_hardware(struct device 
 	struct tpm_chip *chip;
 	int i, j;
 
+	DEVICE_ATTR(pcrs, S_IRUGO, show_pcrs, NULL);
+	DEVICE_ATTR(pubek, S_IRUGO, show_pubek, NULL);
+	DEVICE_ATTR(caps, S_IRUGO, show_caps, NULL);
+	DEVICE_ATTR(cancel, S_IWUSR | S_IWGRP, NULL, store_cancel);
+
 	/* Driver specific per-device data */
 	chip = kmalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
@@ -663,10 +679,16 @@ dev_num_search_complete:
 
 	list_add(&chip->list, &tpm_chip_list);
 
-	device_create_file(dev, &dev_attr_pubek);
-	device_create_file(dev, &dev_attr_pcrs);
-	device_create_file(dev, &dev_attr_caps);
-
+	chip->attr[0] = dev_attr_pubek;
+	chip->attr[1] = dev_attr_pcrs;
+	chip->attr[2] = dev_attr_caps;
+	chip->attr[3] = dev_attr_cancel;
+
+	for ( i = 0; i < TPM_ATTRS; i++ ) {
+		chip->attr[i].attr.owner = chip->vendor->miscdev.fops->owner;
+		device_create_file(dev, &chip->attr[i]);		
+	}
+	
 	return 0;
 }
 
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.h linux-2.6.10-tpm/drivers/char/tpm/tpm.h
--- linux-2.6.10/drivers/char/tpm/tpm.h	2005-02-04 15:03:03.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.h	2005-02-09 12:23:18.244748160 -0600
@@ -25,6 +25,7 @@
 #include <linux/miscdevice.h>
 
 #define TPM_TIMEOUT msecs_to_jiffies(5)
+#define TPM_ATTRS 4
 
 /* TPM addresses */
 #define	TPM_ADDR			0x4E
@@ -46,6 +47,7 @@ struct tpm_vendor_specific {
 
 struct tpm_chip {
 	struct device *dev;	/* PCI device stuff */
+	struct device_attribute attr[4];
 
 	int dev_num;		/* /dev/tpm# */
 	int num_opens;		/* only one allowed */
