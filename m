Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVEETkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVEETkj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVEETkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:40:24 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:57310 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262193AbVEETK6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 15:10:58 -0400
Date: Thu, 5 May 2005 14:10:46 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
To: akpm@osdl.org
cc: jgarzik@pobox.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4 of 12] Fix TPM driver -- read return code issue
Message-ID: <Pine.LNX.4.62.0505051327480.5303@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply these fixes to the Tpm driver.  I am resubmitting the entire
patch set that was orginally sent to LKML on April 27 with the changes
that were requested fixed.

Thanks,
Kylie

On Wed, 9 Mar 2005, Jeff Garzik wrote:
> Greg KH wrote:

<snip>

> > +ssize_t tpm_read(struct file * file, char __user * buf,
> > +		 size_t size, loff_t * off)
> > +{
> > +	struct tpm_chip *chip = file->private_data;
> > +	int ret_size = -ENODATA;
> > +
> > +	if (atomic_read(&chip->data_pending) != 0) {	/* Result available */
> > +		down(&chip->timer_manipulation_mutex);
> > +		del_singleshot_timer_sync(&chip->user_read_timer);
> > +		up(&chip->timer_manipulation_mutex);
> > +
> > +		down(&chip->buffer_mutex);
> > +
> > +		ret_size = atomic_read(&chip->data_pending);
> > +		atomic_set(&chip->data_pending, 0);
> > +
> > +		if (ret_size == 0)	/* timeout just occurred */
> > +			ret_size = -ETIME;
> > +		else if (ret_size > 0) {	/* relay data */
> > +			if (size < ret_size)
> > +				ret_size = size;
> > +
> > +			if (copy_to_user((void __user *) buf,
> > +					 chip->data_buffer, ret_size)) {
> > +				ret_size = -EFAULT;
> > +			}
> > +		}
> > +		up(&chip->buffer_mutex);
> > +	}
> > +
> > +	return ret_size;
> 
> POSIX violation -- when there is no data available, returning a non-standard
> error is silly

<snip>

The patch below fixes this erroneous return code when no data is 
available.

Signed-of-by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-21 17:36:59.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c	2005-04-21 17:57:39.000000000 -0500
@@ -483,29 +483,19 @@ ssize_t tpm_read(struct file * file, cha
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
 
