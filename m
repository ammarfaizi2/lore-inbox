Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVBIUgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVBIUgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVBIUgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:36:14 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:54418 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261786AbVBIUfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:35:48 -0500
Date: Wed, 9 Feb 2005 14:35:34 -0600 (CST)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
Subject: Re: [tpmdd-devel] Re: [PATCH 1/1] tpm: update tpm sysfs file ownership
 - updated version
In-Reply-To: <20050209181736.GA23422@kroah.com>
Message-ID: <Pine.LNX.4.58.0502091431160.4398@jo.austin.ibm.com>
References: <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501181735110.13908@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501281539340.6360@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501311322380.9872@jo.austin.ibm.com>
 <Pine.LNX.4.58.0502031034290.18135@jo.austin.ibm.com>
 <Pine.LNX.4.58.0502041405230.22211@jo.austin.ibm.com> <20050204205226.GA26780@kroah.com>
 <1107553040.22140.30.camel@jo.austin.ibm.com> <20050204215134.GA27433@kroah.com>
 <Pine.LNX.4.58.0502091201110.3969@jo.austin.ibm.com> <20050209181736.GA23422@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005, Greg KH wrote:
> On Wed, Feb 09, 2005 at 12:05:42PM -0600, Kylene Hall wrote:
> > @@ -539,9 +551,8 @@ void tpm_remove_hardware(struct device *
> >  	dev_set_drvdata(dev, NULL);
> >  	misc_deregister(&chip->vendor->miscdev);
> >  
> > -	device_remove_file(dev, &dev_attr_pubek);
> > -	device_remove_file(dev, &dev_attr_pcrs);
> > -	device_remove_file(dev, &dev_attr_caps);
> > +	for ( i = 0; i < TPM_ATTRS; i++ ) 
> > +		device_remove_file(dev, &chip->attr[i]);
> >  
> >  	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
> >  
> 
> This code works?
> 
> > @@ -608,6 +619,11 @@ int tpm_register_hardware(struct device 
> >  	struct tpm_chip *chip;
> >  	int i, j;
> >  
> > +	DEVICE_ATTR(pcrs, S_IRUGO, show_pcrs, NULL);
> > +	DEVICE_ATTR(pubek, S_IRUGO, show_pubek, NULL);
> > +	DEVICE_ATTR(caps, S_IRUGO, show_caps, NULL);
> > +	DEVICE_ATTR(cancel, S_IWUSR | S_IWGRP, NULL, store_cancel);
> > +
> >  	/* Driver specific per-device data */
> >  	chip = kmalloc(sizeof(*chip), GFP_KERNEL);
> >  	if (chip == NULL)
> 
> You do realize you just created those attributes on the stack?  And then
> you try to remove them from within a different scope above?
>
I didn't realize their was a string in the structure that wouldn't get 
copied when I made the copy to the kmalloc'd struct.  Here is an alternate 
implementation that pushes the initialization into the respective specific 
drivers via a MACRO which has the added benefit of getting the owner field 
right from the start.
 
> thanks,
> 
> greg k-h

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---

diff -uprN linux-2.6.10/drivers/char/tpm/tpm_atmel.c linux-2.6.10-tpm/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.10/drivers/char/tpm/tpm_atmel.c	2005-02-04 15:03:03.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm_atmel.c	2005-02-09 14:12:30.711621784 -0600
@@ -131,6 +131,7 @@ static struct tpm_vendor_specific tpm_at
 	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
 	.req_complete_val = ATML_STATUS_DATA_AVAIL,
 	.base = TPM_ATML_BASE,
+	.attr = TPM_DEVICE_ATTRS,
 	.miscdev.fops = &atmel_ops,
 };
 
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.c linux-2.6.10-tpm/drivers/char/tpm/tpm.c
--- linux-2.6.10/drivers/char/tpm/tpm.c	2005-02-04 15:03:03.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.c	2005-02-09 14:12:30.695624216 -0600
@@ -213,7 +213,7 @@ static u8 pcrread[] = {
 	0, 0, 0, 0		/* PCR index */
 };
 
-static ssize_t show_pcrs(struct device *dev, char *buf)
+ssize_t show_pcrs(struct device *dev, char *buf)
 {
 	u8 data[READ_PCR_RESULT_SIZE];
 	ssize_t len;
@@ -245,8 +245,7 @@ static ssize_t show_pcrs(struct device *
 	}
 	return str - buf;
 }
-
-static DEVICE_ATTR(pcrs, S_IRUGO, show_pcrs, NULL);
+EXPORT_SYMBOL_GPL(show_pcrs);
 
 #define  READ_PUBEK_RESULT_SIZE 314
 static u8 readpubek[] = {
@@ -255,7 +254,7 @@ static u8 readpubek[] = {
 	0, 0, 0, 124,		/* TPM_ORD_ReadPubek */
 };
 
-static ssize_t show_pubek(struct device *dev, char *buf)
+ssize_t show_pubek(struct device *dev, char *buf)
 {
 	u8 data[READ_PUBEK_RESULT_SIZE];
 	ssize_t len;
@@ -308,7 +307,7 @@ static ssize_t show_pubek(struct device 
 	return str - buf;
 }
 
-static DEVICE_ATTR(pubek, S_IRUGO, show_pubek, NULL);
+EXPORT_SYMBOL_GPL(show_pubek);
 
 #define CAP_VER_RESULT_SIZE 18
 static u8 cap_version[] = {
@@ -329,7 +328,7 @@ static u8 cap_manufacturer[] = {
 	0, 0, 1, 3
 };
 
-static ssize_t show_caps(struct device *dev, char *buf)
+ssize_t show_caps(struct device *dev, char *buf)
 {
 	u8 data[READ_PUBEK_RESULT_SIZE];
 	ssize_t len;
@@ -362,7 +361,26 @@ static ssize_t show_caps(struct device *
 	return str - buf;
 }
 
-static DEVICE_ATTR(caps, S_IRUGO, show_caps, NULL);
+EXPORT_SYMBOL_GPL(show_caps);
+
+ssize_t store_cancel(struct device *dev, const char *buf,
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
+
+EXPORT_SYMBOL_GPL(store_cancel);
 
 /*
  * Device file system interface to the TPM
@@ -524,6 +542,7 @@ EXPORT_SYMBOL_GPL(tpm_read);
 void tpm_remove_hardware(struct device *dev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
+	int i;
 
 	if (chip == NULL) {
 		dev_err(dev, "No device data found\n");
@@ -539,9 +558,8 @@ void tpm_remove_hardware(struct device *
 	dev_set_drvdata(dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
 
-	device_remove_file(dev, &dev_attr_pubek);
-	device_remove_file(dev, &dev_attr_pcrs);
-	device_remove_file(dev, &dev_attr_caps);
+	for ( i = 0; i < TPM_NUM_ATTR; i++ ) 
+		device_remove_file(dev, &chip->vendor->attr[i]);
 
 	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
 
@@ -663,10 +681,9 @@ dev_num_search_complete:
 
 	list_add(&chip->list, &tpm_chip_list);
 
-	device_create_file(dev, &dev_attr_pubek);
-	device_create_file(dev, &dev_attr_pcrs);
-	device_create_file(dev, &dev_attr_caps);
-
+	for ( i = 0; i < TPM_NUM_ATTR; i++ ) 
+		device_create_file(dev, &chip->vendor->attr[i]);		
+		
 	return 0;
 }
 
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.h linux-2.6.10-tpm/drivers/char/tpm/tpm.h
--- linux-2.6.10/drivers/char/tpm/tpm.h	2005-02-04 15:03:03.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.h	2005-02-09 14:12:30.702623152 -0600
@@ -25,11 +25,23 @@
 #include <linux/miscdevice.h>
 
 #define TPM_TIMEOUT msecs_to_jiffies(5)
+#define TPM_NUM_ATTR 4
 
 /* TPM addresses */
 #define	TPM_ADDR			0x4E
 #define	TPM_DATA			0x4F
 
+extern ssize_t show_pubek(struct device *, char *);
+extern ssize_t show_pcrs(struct device *, char *);
+extern ssize_t show_caps(struct device *, char *);
+extern ssize_t store_cancel(struct device *, const char *, size_t);
+
+#define TPM_DEVICE_ATTRS { \
+	__ATTR(pubek, S_IRUGO, show_pubek, NULL), \
+	__ATTR(pcrs, S_IRUGO, show_pcrs, NULL), \
+	__ATTR(caps, S_IRUGO, show_caps, NULL), \
+	__ATTR(cancel, S_IWUSR | S_IWGRP, NULL, store_cancel) }
+
 struct tpm_chip;
 
 struct tpm_vendor_specific {
@@ -42,6 +54,7 @@ struct tpm_vendor_specific {
 	void (*cancel) (struct tpm_chip *);
 	u8 (*status) (struct tpm_chip *);
 	struct miscdevice miscdev;
+	struct device_attribute attr[TPM_NUM_ATTR];
 };
 
 struct tpm_chip {
diff -uprN linux-2.6.10/drivers/char/tpm/tpm_nsc.c linux-2.6.10-tpm/drivers/char/tpm/tpm_nsc.c
--- linux-2.6.10/drivers/char/tpm/tpm_nsc.c	2005-02-04 15:03:03.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm_nsc.c	2005-02-09 14:12:30.728619200 -0600
@@ -241,6 +241,7 @@ static struct tpm_vendor_specific tpm_ns
 	.req_complete_mask = NSC_STATUS_OBF,
 	.req_complete_val = NSC_STATUS_OBF,
 	.base = TPM_NSC_BASE,
+	.attr = TPM_DEVICE_ATTRS,
 	.miscdev.fops = &nsc_ops,
 };
 
