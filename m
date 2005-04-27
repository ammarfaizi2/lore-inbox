Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVD0WSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVD0WSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVD0WRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:17:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:34018 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262052AbVD0WQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:16:34 -0400
Date: Wed, 27 Apr 2005 17:16:22 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4 of 12] Fix TPM driver -- read return code issue
In-Reply-To: <422FC42B.7@pobox.com>
Message-ID: <Pine.LNX.4.61.0504271439140.3929@jo.austin.ibm.com>
References: <1110415321526@kroah.com> <422FC42B.7@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
 
