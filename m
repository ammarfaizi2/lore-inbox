Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVD0W07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVD0W07 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVD0WZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:25:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:25039 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262055AbVD0WS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:18:28 -0400
Date: Wed, 27 Apr 2005 17:18:13 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6 of 12] Fix TPM driver -- how timer is initialized
In-Reply-To: <422FC42B.7@pobox.com>
Message-ID: <Pine.LNX.4.61.0504271449300.3929@jo.austin.ibm.com>
References: <1110415321526@kroah.com> <422FC42B.7@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Jeff Garzik wrote:
> Greg KH wrote:

<snip>
> > +
> > +	down(&chip->timer_manipulation_mutex);
> > +	chip->time_expired = 0;
> > +	init_timer(&chip->device_timer);
> > +	chip->device_timer.function = tpm_time_expired;
> > +	chip->device_timer.expires = jiffies + 2 * 60 * HZ;
> > +	chip->device_timer.data = (unsigned long) &chip->time_expired;
> > +	add_timer(&chip->device_timer);
> 
> very wrong.  you init_timer() when you initialize 'chip'... once.  then during
> the device lifetime you add/mod/del the timer.
> 
> calling init_timer() could lead to corruption of state.
> 

<snip>

> > +	/* Set a timeout by which the reader must come claim the result */
> > +	down(&chip->timer_manipulation_mutex);
> > +	init_timer(&chip->user_read_timer);
> > +	chip->user_read_timer.function = user_reader_timeout;
> > +	chip->user_read_timer.data = (unsigned long) chip;
> > +	chip->user_read_timer.expires = jiffies + (60 * HZ);
> > +	add_timer(&chip->user_read_timer);
> 
> again, don't repeatedly init_timer()

<snip>

> > +int tpm_register_hardware(struct pci_dev *pci_dev,
> > +			  struct tpm_vendor_specific *entry)
> > +{
> > +	char devname[7];
> > +	struct tpm_chip *chip;
> > +	int i, j;
> > +
> > +	/* Driver specific per-device data */
> > +	chip = kmalloc(sizeof(*chip), GFP_KERNEL);
> > +	if (chip == NULL)
> > +		return -ENOMEM;
> > +
> > +	memset(chip, 0, sizeof(struct tpm_chip));
> > +

> > +	init_MUTEX(&chip->buffer_mutex);
> > +	init_MUTEX(&chip->tpm_mutex);
> > +	init_MUTEX(&chip->timer_manipulation_mutex);
> > +	INIT_LIST_HEAD(&chip->list);
> 
> timer init should be here

<snip>

Fix the timer to be inited and modified properly.  This work depends on 
the fixing of the msleep stuff which was submitted in a patch by Nish 
Aravamudan on March 10.

Signed-of-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -urpN --exclude='*.orig' linux-2.6.12-rc2/drivers/char/tpm/tpm.c linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-25 18:49:08.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c	2005-04-26 12:47:20.000000000 -0500
@@ -456,16 +456,7 @@ int tpm_release(struct inode *inode, str
 
 	spin_lock(&driver_lock);
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
 
 	pci_dev_put(chip->pci_dev);
@@ -504,13 +495,7 @@ tpm_write(struct file * file, const char
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
@@ -639,9 +624,12 @@ int tpm_register_hardware(struct pci_dev
 
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
diff -urpN --exclude='*.orig' linux-2.6.12-rc2/drivers/char/tpm/tpm.h linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.h
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.h	2005-04-25 18:49:08.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.h	2005-04-26 12:53:29.000000000 -0500
@@ -76,8 +76,6 @@ struct tpm_chip {
 
 	struct timer_list user_read_timer;	/* user needs to claim result */
 	struct semaphore tpm_mutex;	/* tpm is processing */
-	struct timer_list device_timer;	/* tpm is processing */
-	struct semaphore timer_manipulation_mutex;
 
 	struct tpm_vendor_specific *vendor;
 
