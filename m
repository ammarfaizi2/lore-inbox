Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVCPAC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVCPAC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVCPACz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:02:55 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:59833 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262173AbVCOX7q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:59:46 -0500
Subject: Re: [PATCH] Add TPM hardware enablement driver
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <422FC42B.7@pobox.com>
References: <1110415321526@kroah.com>  <422FC42B.7@pobox.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 17:59:39 -0600
Message-Id: <1110931179.3885.29.camel@jo.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the helpful comments I am working on a patch to fix your
concerns but I have a couple of questions.  

On Wed, 2005-03-09 at 22:51 -0500, Jeff Garzik wrote:
<snip>

> > +	down(&chip->timer_manipulation_mutex);
> > +	chip->time_expired = 0;
> > +	init_timer(&chip->device_timer);
> > +	chip->device_timer.function = tpm_time_expired;
> > +	chip->device_timer.expires = jiffies + 2 * 60 * HZ;
> > +	chip->device_timer.data = (unsigned long) &chip->time_expired;
> > +	add_timer(&chip->device_timer);
> 
> very wrong.  you init_timer() when you initialize 'chip'... once.  then 
> during the device lifetime you add/mod/del the timer.
> 
> calling init_timer() could lead to corruption of state.
> 
> > +	up(&chip->timer_manipulation_mutex);
When calling mod_timer and an occasional del_singleshot_timer_sync is it
necessary to protect this with a mutex like I was doing or not?


> > +	pci_dev_get(chip->pci_dev);
> > +
> > +	spin_unlock(&driver_lock);
> > +
> > +	chip->data_buffer = kmalloc(TPM_BUFSIZE * sizeof(u8), GFP_KERNEL);
> > +	if (chip->data_buffer == NULL) {
> > +		chip->num_opens--;
> > +		pci_dev_put(chip->pci_dev);
> > +		return -ENOMEM;
> > +	}
> 
> what is the purpose of this pci_dev_get/put?  attempting to prevent 
> hotplug or something?

We were doing reference counting since their is a pci_dev in the chip
structure which set to the file->private_data pointer. Not correct?

> 
> > +	}
> > +
> > +	down(&chip->buffer_mutex);
> > +
> > +	if (in_size > TPM_BUFSIZE)
> > +		in_size = TPM_BUFSIZE;
> > +
> > +	if (copy_from_user
> > +	    (chip->data_buffer, (void __user *) buf, in_size)) {
> > +		up(&chip->buffer_mutex);
> > +		return -EFAULT;
> > +	}
> > +
> > +	/* atomic tpm command send and result receive */
> > +	out_size = tpm_transmit(chip, chip->data_buffer, TPM_BUFSIZE);
> 
> major bug?  in_size may be smaller than TPM_BUFSIZE
> 
Yes in_size might be but the chip->data_buffer will always be this size since it is malloc'd in open.  The operation needs to be atomic so the tpm_transmit function is sending the command to the device and receiving the result which might be bigger than in_size.  The result is reported back to userspace from this buffer on a read.

> > +
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
> POSIX violation -- when there is no data available, returning a 
> non-standard error is silly
> 
So read should just return 0 if no data available?


Thanks,
Kylie

