Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbULIRIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbULIRIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 12:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbULIRHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 12:07:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:10191 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261525AbULIRGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 12:06:36 -0500
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement
From: Kylie Hall <kjhall@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, sailer@watson.ibm.com,
       leendert@watson.ibm.com, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
In-Reply-To: <1102607309.2784.40.camel@laptop.fenrus.org>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
	 <1102607309.2784.40.camel@laptop.fenrus.org>
Content-Type: text/plain
Message-Id: <1102611986.29492.17.camel@jo.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Dec 2004 11:06:27 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 09:48, Arjan van de Ven wrote: 
> On Thu, 2004-12-09 at 09:25 -0600, Kylene Hall wrote:
> > +	/* wait for status */
> > +	add_timer(&status_timer);
> > +	do {
> > +		schedule();
> > +		*data = inb(chip->base + 1);
> > +		if ((*data & mask) == val) {
> > +			del_singleshot_timer_sync(&status_timer);
> > +			return 0;
> > +		}
> > +	} while (!expired);
> 
> this is busy waiting. Can't you do it with msleep() or some such ?
> Or like 100 iterations without delays (in case the chip returns fast),
> and then start sleeping, but please do sleep for a real time, not just
> yield the cpu. Powermanagement and lots of other things really like to
> see that.
I don't see a problem with changing the schedule to an msleep.  I'll
change it.

> > +	/* wait for status */
> > +	add_timer(&status_timer);
> > +	do {
> > +		schedule();
> > +		status = inb(chip->base + NSC_STATUS);
> > +		if (status & NSC_STATUS_OBF)
> > +			status = inb(chip->base + NSC_DATA);
> > +		if (status & NSC_STATUS_RDY) {
> > +			del_singleshot_timer_sync(&status_timer);
> > +			return 0;
> > +		}
> > +	} while (!expired);
> 
> same comment. Also the timer handling looks suspect... can you guarantee
> 100% sure that the timer is gone when the while falls through ?
> 
Since the only way that expired becomes non-zero is for the timer to
expire and since the function that the timer calls on expiration does
not restart the timer the timer will be gone when the while falls
through.

> 
> > +	chip->userspace_buffer =
> > +	    kmalloc(TPM_BUFSIZE * sizeof(u8), GFP_KERNEL);
> 
> that sounds like a really deceptive name to me ... since it's kernel
> memory ;)
Agreed.  It will be changed.

> > +static int tpm_release(struct inode *inode, struct file *file)
> > +{
> > +	struct tpm_chip *chip = file->private_data;
> > +
> > +	if (chip == NULL)
> > +		return -ENODEV;
> > +
> > +	spin_lock(&driver_lock);
> > +	chip->num_opens--;
> 
> why do you need to keep track of the number of openers? Can't you have
> the kernel fs layer keep track of this ?
The specification only allows the Trusted Software Stack (TSS)
application to open/read/write to the device.  I am keeping track of the
number of opens to only allow one open (for the TSS).

> > +	chip->user_read_timer.function = user_reader_timeout;
> > +	chip->user_read_timer.data = (unsigned long) chip;
> > +	chip->user_read_timer.expires = jiffies + (60 * HZ);
> > +	add_timer(&chip->user_read_timer);
> > +
> > +	atomic_set(&chip->data_pending, out_size);
> > +
> > +	return size;
> 
> what prevents the module from being unloaded ?
> (eg user calls write(); close(); and then does rmmod before the timer
> expires )
> 
You're right this is a problem.  I think the solution is to put locks around the timer 
manipulation code and make a call to timer_pending in the close function.  If the timer
is pending I will then call del_timer from close.  Sound reasonable?
> 
> > +/*
> > + * Resume from a power safe. The BIOS already restored
> > + * the TPM state.
> > + */
> 
> are there any special security things needed after resume ?
> Or maybe at suspend time, to wipe secrets from the TPM or somesuch..
> 
Nothing that I am aware of.

Thanks,
Kylene


