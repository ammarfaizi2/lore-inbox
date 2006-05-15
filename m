Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965263AbWEOV7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbWEOV7d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965265AbWEOV7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:59:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965263AbWEOV7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:59:31 -0400
Date: Mon, 15 May 2006 15:02:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Buesch <mb@bu3sch.de>
Cc: dsaxena@plexity.net, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, vsu@altlinux.ru, mb@bu3sch.de
Subject: Re: [patch 2/9] Add new generic HW RNG core
Message-Id: <20060515150202.0835232d.akpm@osdl.org>
In-Reply-To: <20060515145316.089681000@bu3sch.de>
References: <20060515145243.905923000@bu3sch.de>
	<20060515145316.089681000@bu3sch.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <mb@bu3sch.de> wrote:
>
> ...
>
> +static inline
> +int hwrng_init(struct hwrng *rng)
> +static inline
> +void hwrng_cleanup(struct hwrng *rng)
> +static inline
> +int hwrng_data_present(struct hwrng *rng)
> +static inline
> +int hwrng_data_read(struct hwrng *rng, u32 *data)

Lose the newlines, please.

> +static int rng_dev_open(struct inode *inode, struct file *filp)

Like that.

> +static ssize_t rng_dev_read(struct file *filp, char __user *buf,
> +			    size_t size, loff_t *offp)
> +{
> +	int have_data;
> +	u32 data;
> +	ssize_t ret = 0;
> +	int i, err = 0;
> +
> +	while (size) {
> +		err = -ERESTARTSYS;
> +		if (mutex_lock_interruptible(&rng_mutex))
> +			goto out;
> +		if (!current_rng) {
> +			mutex_unlock(&rng_mutex);
> +			err = -ENODEV;
> +			goto out;
> +		}
> +		have_data = 0;
> +		if (hwrng_data_present(current_rng))
> +			have_data = hwrng_data_read(current_rng, &data);
> +		mutex_unlock(&rng_mutex);
> +
> +		err = -EFAULT;
> +		while (have_data && size) {
> +			if (put_user((u8)data, buf++))
> +				goto out;
> +			size--;
> +			ret++;
> +			have_data--;
> +			data >>= 8;
> +		}
> +
> +		err = -EAGAIN;
> +		if (filp->f_flags & O_NONBLOCK)
> +			goto out;
> +
> +		err = -ERESTARTSYS;
> +		if (need_resched()) {
> +			if (schedule_timeout_interruptible(1))
> +				goto out;
> +		} else {
> +			if (mutex_lock_interruptible(&rng_mutex))
> +				goto out;
> +			if (!current_rng) {
> +				mutex_unlock(&rng_mutex);
> +				err = -ENODEV;
> +				goto out;
> +			}
> +			for (i = 0; i < 20; i++) {
> +				if (hwrng_data_present(current_rng))
> +					break;
> +				udelay(10);
> +			}
> +			mutex_unlock(&rng_mutex);
> +		}
> +		if (signal_pending(current))
> +			goto out;
> +	}
> +out:
> +	return ret ? : err;
> +}

What's going on with the need_resched() tricks in there?  (Unobvious, needs
a comment).  From my reading, it'll cause a caller to this function to hang
for arbitrary periods of time if something if causing heavy scheduling
pressure.

What's the polling of hwrng_data_present() doing in here?  (Unobvious,
needs a comment).

> +static ssize_t hwrng_attr_current_store(struct class_device *class,
> +					const char *buf, size_t len)
> +{
> +	int err;
> +	struct hwrng *rng;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;

Are the sysfs permissions not adequate?

> +MODULE_AUTHOR("The Linux Kernel team");

Mutter.  Might as well remove this.

A MAINTAINERS record would be nice.


