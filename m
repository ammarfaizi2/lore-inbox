Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbULFV45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbULFV45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbULFV45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:56:57 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:55510 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261668AbULFV4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:56:47 -0500
Date: Mon, 6 Dec 2004 13:54:57 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Message-ID: <20041206215456.GB10499@kroah.com>
References: <87acsrqval.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87acsrqval.fsf@coraid.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 10:51:46AM -0500, Ed L Cashin wrote:
> +CREATING DEVICE NODES
> +
> +  Two scripts are in scripts/aoe for assisting in creating device
> +  nodes for using the aoe driver.  Usage is as follows.
> +
> +    rm -rf /dev/etherd
> +    sh scripts/mkdevs /dev/etherd

If you use the /sys/class interface properly, and udev, you don't need
this script at all.  Care to add sysfs support to the driver so that
people don't have to rely on this?

> +USING DEVICE NODES
> +
> +  "cat /dev/etherd/stat" shows the status of discovered AoE devices on
> +  your LAN:
> +
> +	root@nai root# cat /dev/etherd/stat
> +	/dev/etherd/e15.3       eth0    up
> +	/dev/etherd/e6.2        eth3    up
> +	/dev/etherd/e6.4        eth3    up
> +	/dev/etherd/e6.3        eth3    up
> +	/dev/etherd/e6.9        eth3    up
> +	/dev/etherd/e6.5        eth3    up
> +	/dev/etherd/e6.7        eth3    up
> +	/dev/etherd/e6.6        eth3    up
> +	/dev/etherd/e6.8        eth3    up
> +	/dev/etherd/e6.0        eth3    up
> +	/dev/etherd/e6.1        eth3    up

Why not just put this info in the /sys/class/block/eX.X files (with a
symlink to the ethX device for the "device" symlink, and the status as
another single file?

> +typedef struct Buf Buf;

This driver should not create _any_ new typedefs, please fix this.

> +typedef struct Bufq Bufq;
> +struct Bufq {
> +	Buf *head, *tail;
> +};

What's wrong with the in-kernel list structures that you need to create
your own?

> +enum { FQUOTE = (1<<0), FEMPTY = (1<<1) };
> +int getfields(char *, char **, int, char *, int);
> +#define tokenize(A, B, C) getfields(A, B, C, " \t\r\n", FQUOTE)

"getfields" is a pretty "generic" symbol name that you are adding to the
global symbol table.  Are you sure that there's nothing already in the
kernel tree for this?

> +static int
> +aoeblk_release(struct inode *inode, struct file *filp)
> +{
> +	Aoedev *d;
> +	ulong flags;
> +
> +	d = (Aoedev *) inode->i_bdev->bd_disk->private_data;
> +
> +	spin_lock_irqsave(&d->lock, flags);
> +	if (--d->nopen == 0)
> +	if ((d->flags & DEVFL_CLOSEWAIT)) {
> +		d->flags &= ~DEVFL_CLOSEWAIT;
> +		spin_unlock_irqrestore(&d->lock, flags);
> +		aoecmd_cfg(d->aoemajor, d->aoeminor);
> +		return 0;
> +	}
> +	spin_unlock_irqrestore(&d->lock, flags);

Looks like you didn't indent properly for the two if() statments.

> +static int
> +aoeblk_ioctl(struct inode *inode, struct file *filp, uint cmd, ulong arg)
> +{
> +	Aoedev *d;
> +
> +	if (!arg)
> +		return -EINVAL;
> +
> +	d = (Aoedev *) inode->i_bdev->bd_disk->private_data;
> +	if ((d->flags & DEVFL_UP) == 0) {
> +		printk(KERN_ERR "aoe: aoeblk_ioctl: disk not up\n");
> +		return -ENODEV;
> +	}
> +
> +	if (cmd == HDIO_GETGEO) {
> +		d->geo.start = get_start_sect(inode->i_bdev);
> +		if (!copy_to_user((void *) arg, &d->geo, sizeof d->geo))
> +			return 0;
> +		return -EFAULT;
> +	}
> +	printk(KERN_INFO "aoe: aoeblk_ioctl: unknown ioctl %d\n", cmd);

So I can flood the syslog by sending improper ioctls to the driver?
That's not nice...

> +	/* We should return -ENOTTY for unrecognized ioctls later
> +	 * when everyone's running kernels that support it.  See,
> +                * e.g., BLKFLSBUF in ioctl.c:blkdev_ioctl.
> +                */
> +	return -EINVAL;

Is this, 2.6.10-rc2 kernel sufficiently "later"?  :)

> +static int
> +interfaces_cmd(int argc, char **argv)
> +{
> +	if (set_aoe_iflist(argc, argv)) {
> +		printk(KERN_CRIT
> +		       "%s: could not set inteface list: %s\n",
> +		       __FUNCTION__, "too many interfaces");
> +		return -1;

-EINVAL?

> +ssize_t
> +aoechr_write(struct file *filp, const char *buf, size_t cnt, loff_t *offp)
> +{
> +	char *argv[NARGS];
> +	char *str = kallocz(cnt+1, GFP_KERNEL);
> +	int argc;
> +	int ret = -1;

-1 isn't a good "default" error return value, try picking the correct
values.

> +
> +	if (!str) {
> +		printk(KERN_CRIT "aoe: aoechr_write: cannot allocate memory\n");
> +		return ret;

-ENOMEM is better.

> +	}
> +
> +	if (copy_from_user(str, buf, cnt)) {
> +		printk(KERN_INFO "aoe: aoechr_write: copy from user failed\n");
> +		goto out;

-EFAULT is the proper return value for this error.

> +int
> +aoechr_open(struct inode *inode, struct file *filp)
> +{
> +	int n;
> +
> +	n = MINOR(inode->i_rdev);
> +	filp->private_data = (void *) (unsigned long) n;
> +
> +	switch (n) {
> +	case MINOR_CTL:
> +	case MINOR_ERR:
> +	case MINOR_STAT:
> +		return 0;
> +	}
> +	return -1;

-EINVAL?

Oh, you have a lot of global functions that can be made static (like
this one.  Please make them static.

> diff -urpN linux-2.6.9/drivers/block/aoe/aoeutils.c linux-2.6.9-aoe/drivers/block/aoe/aoeutils.c
> --- linux-2.6.9/drivers/block/aoe/aoeutils.c	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.9-aoe/drivers/block/aoe/aoeutils.c	2004-12-06 10:40:00.000000000 -0500
> @@ -0,0 +1,183 @@
> +/*
> + * utils.c
> + * utility functions that have no place in other modules.

I think this whole file can be deleted and the driver converted to use
the functions already present in the kernel.  Please don't reinvent the
wheel...

> +void *
> +kallocz(ulong sz, ulong kmem)
> +{
> +	void *d;
> +
> +	d = kmalloc(sz, kmem);
> +	if (d)
> +		memset(d, 0, sz);
> +	return d;
> +}

What's wrong kcalloc() instead of creating your own?

> diff -urpN linux-2.6.9/drivers/block/aoe/u.h linux-2.6.9-aoe/drivers/block/aoe/u.h
> --- linux-2.6.9/drivers/block/aoe/u.h	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.9-aoe/drivers/block/aoe/u.h	2004-12-06 10:40:01.000000000 -0500
> @@ -0,0 +1,10 @@
> +
> +/*
> +typedef unsigned short ushort;
> +typedef unsigned int uint;
> +typedef unsigned long ulong;
> +typedef long long vlong;
> +typedef unsigned long long uvlong;
> +*/
> +typedef unsigned char uchar;

These are not needed at all, use the proper kernel versions (u32, u16,
etc.)

> diff -urpN linux-2.6.9/scripts/aoe/autoload linux-2.6.9-aoe/scripts/aoe/autoload
> --- linux-2.6.9/scripts/aoe/autoload	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.9-aoe/scripts/aoe/autoload	2004-12-06 10:40:01.000000000 -0500

Shouldn't this go into Documentation/aoe/ instead?  I thought the
scripts directory was for scripts needed when building the kernel
source.

thanks,

greg k-h
