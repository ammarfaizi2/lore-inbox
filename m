Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWAXVL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWAXVL5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWAXVL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:11:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750719AbWAXVLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:11:55 -0500
Date: Tue, 24 Jan 2006 13:13:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-Id: <20060124131312.0545262d.akpm@osdl.org>
In-Reply-To: <200601240929.37676.rjw@sisk.pl>
References: <200601240929.37676.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Hi,
> 
> This patch introduces a user space interface for swsusp.

How will we know if/when this feature is ready for mainline?  What criteria
can we use to judge that?

Will you be developing and long-term maintaining the userspace tools?  Is
it your expectation/hope that distros will migrate onto using them?  etc.

> +
> +static int snapshot_open(struct inode *inode, struct file *filp)
> +{
> +	struct snapshot_data *data;
> +
> +	if (!atomic_dec_and_test(&device_available)) {
> +		atomic_inc(&device_available);

You may find that atomic_add_unless(..., -1, ...) is neater here, and
closes the tiny race.

> +		return -EBUSY;
> +	}
> +
> +	if ((filp->f_flags & O_ACCMODE) == O_RDWR)
> +		return -ENOSYS;
> +
> +	nonseekable_open(inode, filp);
> +	data = &snapshot_state;
> +	filp->private_data = data;
> +	memset(&data->handle, 0, sizeof(struct snapshot_handle));

<goes off hunting elsewhere for the defn of data->handle.  grr>

> +static ssize_t snapshot_read(struct file *filp, char __user *buf,
> +                             size_t count, loff_t *offp)
> +{
> +	struct snapshot_data *data;
> +	ssize_t res;
> +
> +	data = filp->private_data;
> +	res = snapshot_read_next(&data->handle, count);
> +	if (res > 0) {
> +		if (copy_to_user(buf, data_of(data->handle), res))
> +			res = -EFAULT;
> +		else
> +			*offp = data->handle.offset;
> +	}
> +	return res;
> +}

It's more conventional for a read() to return less-than-was-asked-for when
it hits a fault.  Doesn't matter though - lots of drivers do it this way.

> +static ssize_t snapshot_write(struct file *filp, const char __user *buf,
> +                              size_t count, loff_t *offp)
> +{
> +	struct snapshot_data *data;
> +	ssize_t res;
> +
> +	data = filp->private_data;
> +	res = snapshot_write_next(&data->handle, count);
> +	if (res > 0) {
> +		if (copy_from_user(data_of(data->handle), buf, res))
> +			res = -EFAULT;
> +		else
> +			*offp = data->handle.offset;
> +	}
> +	return res;
> +}

Ditto.

> +static int snapshot_ioctl(struct inode *inode, struct file *filp,
> +                          unsigned int cmd, unsigned long arg)
> +{
>
> ...
>
> +	case SNAPSHOT_ATOMIC_RESTORE:
> +		if (data->mode != O_WRONLY || !data->frozen ||
> +		    !snapshot_image_loaded(&data->handle)) {
> +			error = -EPERM;
> +			break;
> +		}
> +		down(&pm_sem);
> +		pm_prepare_console();
> +		error = device_suspend(PMSG_FREEZE);
> +		if (!error) {
> +			mb();
> +			error = swsusp_resume();
> +			device_resume();
> +		}

whee, what does the mystery barrier do?  It'd be nice to comment this
(please always comment open-coded barriers).

> +	case SNAPSHOT_GET_SWAP_PAGE:
> +		if (!access_ok(VERIFY_WRITE, (unsigned long __user *)arg, _IOC_SIZE(cmd))) {
> +			error = -EINVAL;
> +			break;
> +		}

Why do we need an access_ok() here?

Should it return -EFAULT?


