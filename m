Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUG1QHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUG1QHX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267240AbUG1QHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:07:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:4258 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267254AbUG1QA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:00:29 -0400
Date: Wed, 28 Jul 2004 08:57:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg Howard <ghoward@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix system controller communication driver
Message-Id: <20040728085737.26e0bfd2.akpm@osdl.org>
In-Reply-To: <Pine.SGI.4.58.0407271457240.1364@gallifrey.americas.sgi.com>
References: <Pine.SGI.4.58.0407271457240.1364@gallifrey.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Howard <ghoward@sgi.com> wrote:
>
> Hi Andrew,
> 
> The following patch ("altix-system-controller-driver.patch")
> implements a driver that allows user applications to access the system
> controllers on SGI Altix machines.  It applies on top of the
> 2.6.8-rc-mm1 patch.
> 
>...
> +static struct file_operations scdrv_fops = {
> +	owner:THIS_MODULE,
> +	read:scdrv_read,
> +	write:scdrv_write,
> +	poll:scdrv_poll,
> +	open:scdrv_open,
> +	release:scdrv_release,
> +};

As Jes says,

	.owner	= THIS_MODULE,

is preferred here.

> +			scd =
> +			    (struct sysctl_data_s *) kmalloc
> +				(sizeof (struct sysctl_data_s), GFP_KERNEL);

There's no need to cast the return value of kmalloc.

	scd = kmalloc(sizeof(*scd), GFP_KERNEL);

would suffice here.

> +static ssize_t
> +scdrv_read(struct file *file, char *buf, size_t count, loff_t * f_pos)
> +{
> +	int status;
> +	int len;
> +	unsigned long flags;
> +	struct subch_data_s *sd = (struct subch_data_s *) file->private_data;
> +
> +	/* try to get control of the read buffer */
> +	if (down_trylock(&sd->sd_rbs)) {
> +		/* somebody else has it now;
> +		 * if we're non-blocking, then exit...
> +		 */
> +		if (file->f_flags & O_NONBLOCK) {
> +			return -EAGAIN;
> +		}

hm.  O_NONBLOCK means "don't wait for more input to arrive" rather than
"don't block if someone else is holding a lock I want".  But given that the
semaphore is held by !O_NONBLOCK readers, it has to be done this way.

I guess there's no bug here, but it's a bit odd.

> +		copy_to_user(buf, sd->sd_rb, len);

What Jes said: return -EFAULT if copy_to_user() returns non-zero.

> +static unsigned int
> +scdrv_poll(struct file *file, struct poll_table_struct *wait)
> +{
> +	unsigned int mask = 0;
> +	int status = 0;
> +	struct subch_data_s *sd = (struct subch_data_s *) file->private_data;
> +	unsigned long flags;
> +
> +	scdrv_lock_all(sd, &flags);
> +	poll_wait(file, &sd->sd_rq, wait);
> +	poll_wait(file, &sd->sd_wq, wait);

This function will sleep with spinlocks held, won't it?


