Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSJNWXL>; Mon, 14 Oct 2002 18:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262226AbSJNWXK>; Mon, 14 Oct 2002 18:23:10 -0400
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:15878 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S262224AbSJNWXF>; Mon, 14 Oct 2002 18:23:05 -0400
Date: Mon, 14 Oct 2002 23:28:43 +0100
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@redhat.com>, Jens Axboe <axboe@suse.de>
Subject: Re: Linux v2.5.42
Message-ID: <20021014222843.GA15383@fib011235813.fsnet.co.uk>
References: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com> <20021014100150.GC2518@fib011235813.fsnet.co.uk> <20021014202158.A27076@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014202158.A27076@infradead.org>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

Thanks for finding time to go through the code.  I've just dropped a
lot of patches in

  http://people.sistina.com/~thornber/patches/2.5-unstable/

which address the following points of yours (more email after the list):

12.patch
  Leave checking for a NULL pointer to the free functions.

13.patch
  Use the ARRAY_SIZE() macro

14.patch
  Don't reimplement the BLKGETSIZE ioctls

15.patch
  Run source through unexpand(1)

16.patch
  Use atomic_set rather than casting ATOMIC_INIT()

17.patch
  Split dm_set_ro(md, flag) into dm_set_ro(md) and dm_set_rw(md).

18.patch
  Move header files out of dm.h to the sources that really need them.

19.patch
  Formatting.

20.patch
  Remove the dm_flag functions and use the standard bitop ones instead.

21.patch
  No need to use __init in a declaration.  Remove inclusion of 
  linux/init.h

22.patch
  No need for MOD_INC_USE_COUNT etc.
  
  Move root check to ioctl fn, rather than open.

23.patch
  No need to bdput after a failed blkdev_get.


On to the slightly more interesting points:

On Mon, Oct 14, 2002 at 08:21:58PM +0100, Christoph Hellwig wrote:
> 01.patch
> 
> 	Looks fine, but I wonder whether we really want the
> 	zeroing in kernel mode (yes, I know userspace calloc
> 	does it)

ok, if we don't zero we better not call it calloc, any preference for
the new name ?

> +/*-----------------------------------------------------------------
> + * Code for looking up the device by kdev_t.
> + *---------------------------------------------------------------*/
> +static struct hash_cell *__get_dev_cell(kdev_t dev)
> +{
> +	struct list_head *tmp;
> +	struct hash_cell *hc;
> +	unsigned int h = hash_dev(dev);
> +
> +	list_for_each (tmp, _dev_buckets + h) {
> +		hc = list_entry(tmp, struct hash_cell, list);
> +		if (kdev_same(hc->md->dev, dev))
> +			return hc;
> +	}
> +
> +	return NULL;
> +}
> 
> As the argument is purely a hash value I'd suggest to
> use a dev_t.  Maybe pass in a struct block_device for
> consistency.

I'm trying to keep dev_ts strictly within the interface (dm-ioctl in
this case).  So dm-ioctl will get the dev_t from the ioctl args and
then convert it to a kdev_t for the look up.  I'll think more about
this, I am going to remove kdev_ts from all but dm-ioctl.c and
dm-hash.c at some point (ie. when I can).

> +/*
> + * Convert a device path to a kdev_t.
> + */
> +int lookup_device(const char *path, kdev_t *dev)
> +{
> +	int r;
> +	struct nameidata nd;
> +	struct inode *inode;
> +
> +	if ((r = path_lookup(path, LOOKUP_FOLLOW, &nd)))
> +		return r;
> +
> +	inode = nd.dentry->d_inode;
> +	if (!inode) {
> +		r = -ENOENT;
> +		goto out;
> +	}
> +
> +	if (!S_ISBLK(inode->i_mode)) {
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	*dev = inode->i_rdev;
> +
> + out:
> +	path_release(&nd);
> +	return r;
> +}
> 
> What about resolving directly to a struct block_device?
> And yes, this name -> struct block_Device thing is duplicated
> a few times.  Al & I need to look into factoring out.

Agreed.  I'll look at this tomorrow when I'm more awake.


> + * Open a device so we can use it as a map destination.
> + */
> +static int open_dev(struct dm_dev *d)
> +{
> +	int r;
> +
> +	if (d->bdev)
> +		BUG();
> +
> +	if (!(d->bdev = bdget(kdev_t_to_nr(d->dev))))
> +		return -ENOMEM;
> +
> + 	r = blkdev_get(d->bdev, d->mode, 0, BDEV_RAW);
> +	if (r) {
> +		bdput(d->bdev);
> +		return r;
> +	}
> +
> +	return 0;
> +}
> 
> bd_claim is missing..

I don't think so, we don't want to claim the whole device, only the
sectors we are using.  Another md table might be using other parts of
the dev.

> +static void close_dev(struct dm_dev *d)
> +{
> +	if (!d->bdev)
> +		return;
> +
> +	blkdev_put(d->bdev, BDEV_RAW);
> +	d->bdev = NULL;
> +}
> 
> And bd_unclaim here.

Ditto

> +	if (sscanf(path, "%x:%x", &major, &minor) == 2) {
> +		/* Extract the major/minor numbers */
> +		dev = mk_kdev(major, minor);
> +	} else {
> +		/* convert the path to a device */
> +		if ((r = lookup_device(path, &dev)))
> +			return r;
> +	}
> 
> What do you need the major/minor version for?

Someone wanted to specify major/minor pairs in the tables provided to
dmsetup rather than a path.

> +	add_wait_queue(&md->wait, &wait);
> +	while (1) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		if (!atomic_read(&md->pending))
> +			break;
> +
> +		yield();
> +	}
> +
> +	current->state = TASK_RUNNING;
> +	remove_wait_queue(&md->wait, &wait);
> 
> Hmm, the yield() looks strange and INTERRUPTIBLE without
> a check for signals, too.  Switch to wait_event_interruptible?

Also agreed, will look at tomorrow.

> 
> +int dm_resume(kdev_t dev)
> 
> struct block_Device?

I changed these this afternoon to take a struct mapped_device the same
as the other dm.c functions (see 11.patch).

> +static inline char *dm_strdup(const char *str)
> +{
> +	char *r = kmalloc(strlen(str) + 1, GFP_KERNEL);
> +	if (r)
> +		strcpy(r, str);
> +	return r;
> +}
> 
> What about the following in kernel.h instead?:

I'm wary of including linux/slab.h in kernel.h.

> 04.patch
> 
> 	Look fine.  I wonder whether they want to be separate modules?

I decided not, they're tiny, and nobody is likely to want to run dm
without them.


> +	r = devfs_generate_path(_dm_misc.devfs_handle, rname + 3,
> +				sizeof rname - 3);
> +	if (r == -ENOSYS)
> +		return 0;	/* devfs not present */
> +
> +	if (r < 0) {
> +		DMERR("devfs_generate_path failed for control device");
> +		goto failed;
> +	}
> +
> +	strncpy(rname + r, "../", 3);
> +	r = devfs_mk_symlink(NULL, DM_DIR "/control",
> +			     DEVFS_FL_DEFAULT, rname + r, &_ctl_handle, NULL);
> 
> Looks a bit crude.  Why do you need this symlink?

This just links /dev/mapper/control -> /dev/misc/device-mapper, I
think it's neater that way.  If it looks crude blame devfs.

> 
> +	__kernel_dev_t dev;	/* in/out */
> 
> Hmm.  Can't you just do every ioctl on the actually affected
> block device node instead of the character ones?

Yes I could, the only reason I'm not is that I'm keeping all the
interface stuff completely seperate in dm-ioctl.c

> And I must admit I don't really like the ioctl interface.  But at least
> it's separated out properly.

Nobody likes ioctl interfaces.  About a year ago we had a filesystem
interface to device mapper instead, however I thought there would be
more opposition to that approach so we switched to the nasty ioctl
interface.  If l-k can agree on a better interface method I'd be happy
to write a new interface module.

- Joe
