Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWDKW7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWDKW7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWDKW7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:59:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751315AbWDKW7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:59:54 -0400
Date: Tue, 11 Apr 2006 16:02:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH] tpm: use clear_bit
Message-Id: <20060411160206.4bffa1c2.akpm@osdl.org>
In-Reply-To: <1144795345.12054.36.camel@localhost.localdomain>
References: <1144679828.4917.11.camel@localhost.localdomain>
	<20060410145030.0b719e18.akpm@osdl.org>
	<1144795345.12054.36.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Jo Hall <kjhall@us.ibm.com> wrote:
>
> On Mon, 2006-04-10 at 14:50 -0700, Andrew Morton wrote:
> > Kylene Jo Hall <kjhall@us.ibm.com> wrote:
> > >
> > > +	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES] &=
> > >  +	    ~(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
> > 
> > If you were to make dev_mask[] an array of longs, this could perhaps become
> > 
> > 	clear_bit(dev_mask, chip->dev_num);
> > 
> 
> Use set_bit and clear_bit for dev_mask manipulation.
> 
> Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
> ---
>  drivers/char/tpm/tpm.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
> 
> --- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm.c	2006-04-11 17:30:57.612009250 -0500
> +++ linux-2.6.17-rc1/drivers/char/tpm/tpm.c	2006-04-11 17:47:23.097598250 -0500
> @@ -32,7 +32,7 @@ enum tpm_const {
>  	TPM_MINOR = 224,	/* officially assigned */
>  	TPM_BUFSIZE = 2048,
>  	TPM_NUM_DEVICES = 256,
> -	TPM_NUM_MASK_ENTRIES = TPM_NUM_DEVICES / (8 * sizeof(int))
> +	TPM_NUM_MASK_ENTRIES = TPM_NUM_DEVICES / (8 * sizeof(unsigned long))
>  };
>  
>  enum tpm_duration {
> @@ -48,7 +48,7 @@ enum tpm_duration {
>  
>  static LIST_HEAD(tpm_chip_list);
>  static DEFINE_SPINLOCK(driver_lock);
> -static int dev_mask[TPM_NUM_MASK_ENTRIES];
> +static unsigned long dev_mask[TPM_NUM_MASK_ENTRIES];
>  
>  /*
>   * Array with one entry per ordinal defining the maximum amount
> @@ -1033,8 +1033,7 @@ void tpm_remove_hardware(struct device *
>  	sysfs_remove_group(&dev->kobj, chip->vendor.attr_group);
>  	tpm_bios_log_teardown(chip->bios_dir);
>  
> -	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES] &=
> -	    ~(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
> +	clear_bit(chip->dev_num , dev_mask);
>  
>  	kfree(chip);
>  
> @@ -1118,7 +1117,7 @@ struct tpm_chip *tpm_register_hardware(s
>  			if ((dev_mask[i] & (1 << j)) == 0) {
>  				chip->dev_num =
>  				    i * TPM_NUM_MASK_ENTRIES + j;
> -				dev_mask[i] |= 1 << j;
> +				set_bit(chip->dev_num, dev_mask);
>  				goto dev_num_search_complete;
>  			}
>  

It should use test_bit() as well.    How's this?



--- 25/drivers/char/tpm/tpm.c~tpm-use-clear_bit-fix	Tue Apr 11 15:52:55 2006
+++ 25-akpm/drivers/char/tpm/tpm.c	Tue Apr 11 16:01:38 2006
@@ -32,7 +32,6 @@ enum tpm_const {
 	TPM_MINOR = 224,	/* officially assigned */
 	TPM_BUFSIZE = 2048,
 	TPM_NUM_DEVICES = 256,
-	TPM_NUM_MASK_ENTRIES = TPM_NUM_DEVICES / (8 * sizeof(unsigned long))
 };
 
 enum tpm_duration {
@@ -48,7 +47,8 @@ enum tpm_duration {
 
 static LIST_HEAD(tpm_chip_list);
 static DEFINE_SPINLOCK(driver_lock);
-static unsigned long dev_mask[TPM_NUM_MASK_ENTRIES];
+static unsigned long dev_mask[(TPM_NUM_DEVICES + BITS_PER_LONG - 1) /
+				BITS_PER_LONG];
 
 /*
  * Array with one entry per ordinal defining the maximum amount
@@ -1032,7 +1032,7 @@ void tpm_remove_hardware(struct device *
 	sysfs_remove_group(&dev->kobj, chip->vendor.attr_group);
 	tpm_bios_log_teardown(chip->bios_dir);
 
-	clear_bit(chip->dev_num , dev_mask);
+	clear_bit(chip->dev_num, dev_mask);
 
 	kfree(chip);
 
@@ -1090,7 +1090,7 @@ struct tpm_chip *tpm_register_hardware(s
 
 	char *devname;
 	struct tpm_chip *chip;
-	int i, j;
+	int dev_num;
 
 	/* Driver specific per-device data */
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
@@ -1111,16 +1111,15 @@ struct tpm_chip *tpm_register_hardware(s
 
 	chip->dev_num = -1;
 
-	for (i = 0; i < TPM_NUM_MASK_ENTRIES; i++)
-		for (j = 0; j < 8 * sizeof(int); j++)
-			if ((dev_mask[i] & (1 << j)) == 0) {
-				chip->dev_num =
-				    i * TPM_NUM_MASK_ENTRIES + j;
-				set_bit(chip->dev_num, dev_mask);
-				goto dev_num_search_complete;
-			}
+	/* This should use find_first_zero_bit() */
+	for (dev_num = 0; dev_num < TPM_NUM_DEVICES; dev_num++) {
+		if (!test_bit(dev_num, dev_mask)) {
+			chip->dev_num = dev_num;
+			set_bit(dev_num, dev_mask);
+			break;
+		}
+	}
 
-dev_num_search_complete:
 	if (chip->dev_num < 0) {
 		dev_err(dev, "No available tpm device numbers\n");
 		kfree(chip);
@@ -1144,7 +1143,7 @@ dev_num_search_complete:
 			chip->vendor.miscdev.minor);
 		put_device(dev);
 		kfree(chip);
-		dev_mask[i] &= !(1 << j);
+		clear_bit(dev_num, dev_mask);
 		return NULL;
 	}
 
_

