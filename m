Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbULIPts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbULIPts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 10:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbULIPts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 10:49:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9703 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261529AbULIPtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 10:49:33 -0500
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement
From: Arjan van de Ven <arjan@infradead.org>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, sailer@watson.ibm.com,
       leendert@watson.ibm.com, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1102607309.2784.40.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 09 Dec 2004 10:48:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 09:25 -0600, Kylene Hall wrote:
> +	/* wait for status */
> +	add_timer(&status_timer);
> +	do {
> +		schedule();
> +		*data = inb(chip->base + 1);
> +		if ((*data & mask) == val) {
> +			del_singleshot_timer_sync(&status_timer);
> +			return 0;
> +		}
> +	} while (!expired);

this is busy waiting. Can't you do it with msleep() or some such ?
Or like 100 iterations without delays (in case the chip returns fast),
and then start sleeping, but please do sleep for a real time, not just
yield the cpu. Powermanagement and lots of other things really like to
see that.
> +	/* wait for status */
> +	add_timer(&status_timer);
> +	do {
> +		schedule();
> +		status = inb(chip->base + NSC_STATUS);
> +		if (status & NSC_STATUS_OBF)
> +			status = inb(chip->base + NSC_DATA);
> +		if (status & NSC_STATUS_RDY) {
> +			del_singleshot_timer_sync(&status_timer);
> +			return 0;
> +		}
> +	} while (!expired);

same comment. Also the timer handling looks suspect... can you guarantee
100% sure that the timer is gone when the while falls through ?


> +	chip->userspace_buffer =
> +	    kmalloc(TPM_BUFSIZE * sizeof(u8), GFP_KERNEL);

that sounds like a really deceptive name to me ... since it's kernel
memory ;)

> +static int tpm_release(struct inode *inode, struct file *file)
> +{
> +	struct tpm_chip *chip = file->private_data;
> +
> +	if (chip == NULL)
> +		return -ENODEV;
> +
> +	spin_lock(&driver_lock);
> +	chip->num_opens--;

why do you need to keep track of the number of openers? Can't you have
the kernel fs layer keep track of this ?
> +	chip->user_read_timer.function = user_reader_timeout;
> +	chip->user_read_timer.data = (unsigned long) chip;
> +	chip->user_read_timer.expires = jiffies + (60 * HZ);
> +	add_timer(&chip->user_read_timer);
> +
> +	atomic_set(&chip->data_pending, out_size);
> +
> +	return size;

what prevents the module from being unloaded ?
(eg user calls write(); close(); and then does rmmod before the timer
expires )

> +/*
> + * Resume from a power safe. The BIOS already restored
> + * the TPM state.
> + */

are there any special security things needed after resume ?
Or maybe at suspend time, to wipe secrets from the TPM or somesuch..




