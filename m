Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVKKUKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVKKUKi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVKKUKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:10:38 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:32424 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751130AbVKKUKh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:10:37 -0500
Subject: [PATCH] TPM: cleanups
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Marcel Selhorst <selhorst@crypto.rub.de>, linux-kernel@vger.kernel.org,
       castet.matthieu@free.fr
In-Reply-To: <20051027145535.0741b647.akpm@osdl.org>
References: <435FB8A5.803@crypto.rub.de> <435FBFC4.5060508@free.fr>
	 <4360B889.1010502@crypto.rub.de>
	 <1130422052.4839.134.camel@localhost.localdomain>
	 <20051027145535.0741b647.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 14:11:03 -0600
Message-Id: <1131739863.5048.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to clean up a couple of issues recently pointed out with the
driver.  The fix for issue (c) was also pointed out by Steve Tate on the
tpm-devel list.


On Thu, 2005-10-27 at 14:55 -0700, Andrew Morton wrote: 
> Have just taken a wander through the TPM driver.  I couldn't help myself - are
> you OK with the below trivial changes?
> 
> Other things:
> 
> a)
> 
> ssize_t tpm_read(struct file * file, char __user *buf,
> 		 size_t size, loff_t * off)
> {
> f	struct tpm_chip *chip = file->private_data;
> 	int ret_size;
> 
> 	del_singleshot_timer_sync(&chip->user_read_timer);
> 	ret_size = atomic_read(&chip->data_pending);
> 	atomic_set(&chip->data_pending, 0);
> 	if (ret_size > 0) {	/* relay data */
> 		if (size < ret_size)
> 			ret_size = size;
> 
> 		down(&chip->buffer_mutex);
> 		if (copy_to_user
> 		    ((void __user *) buf, chip->data_buffer, ret_size))
> 			ret_size = -EFAULT;
> 
> Why is the first arg to copy_to_user() typecast in this manner?  I don't
> think the cast needs to be there?
> 
Fixed in the patch below.

> 
> b) user_reader_timeout does down() from within a timer handler!  That's
>    deadlocky and is illegal - timer handlers are run from interrupt
>    context.
> 
>    This should have generated a storm of runtime warnings if tested with
>    CONFIG_PREEMPT and CONFIG_DEBUG_SPINLOCK_SLEEP.  Developers really should
>    enable all the kernel debug options during development - they find bugs.
> 
>    Suggest you convert this to using schedule_work() or
>    schedule_delayed_work(). 
> 
I'll look into this.

> c) In tpm_remove_hardware():
> 
> 	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES ] &= !(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
> 
>    Is that `!' supposed to be there?   Looks odd.
> 
Fixed in the patch below.

> d) How did this happen?
> 
>    int tpm_pm_suspend(struct device *dev, pm_message_t pm_state, u32 level)
> 
>    device_driver.suspend() only takes two arguments nowadays.
> 
> 
> e)
> 
> 	int tpm_pm_resume(struct device *dev, u32 level)
> 
>    Ditto
> 

>

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.14/drivers/char/tpm/tpm.c.orig	2005-11-11 14:08:48.000000000 -0600
+++ linux-2.6.14/drivers/char/tpm/tpm.c	2005-11-11 14:09:47.000000000
-0600
@@ -428,8 +428,7 @@ ssize_t tpm_read(struct file * file, cha
 			ret_size = size;
 
 		down(&chip->buffer_mutex);
-		if (copy_to_user
-		    ((void __user *) buf, chip->data_buffer, ret_size))
+		if (copy_to_user(buf, chip->data_buffer, ret_size))
 			ret_size = -EFAULT;
 		up(&chip->buffer_mutex);
 	}
@@ -460,7 +459,7 @@ void tpm_remove_hardware(struct device *
 	sysfs_remove_group(&dev->kobj, chip->vendor->attr_group);
 
 	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES ] &=
-		!(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
+		~(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
 
 	kfree(chip);
 


