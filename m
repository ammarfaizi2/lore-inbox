Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262110AbSJNTQS>; Mon, 14 Oct 2002 15:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262111AbSJNTQS>; Mon, 14 Oct 2002 15:16:18 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:40463 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262110AbSJNTQL>; Mon, 14 Oct 2002 15:16:11 -0400
Date: Mon, 14 Oct 2002 20:21:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@redhat.com>, Jens Axboe <axboe@suse.de>
Subject: Re: Linux v2.5.42
Message-ID: <20021014202158.A27076@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joe Thornber <joe@fib011235813.fsnet.co.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@redhat.com>, Jens Axboe <axboe@suse.de>
References: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com> <20021014100150.GC2518@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021014100150.GC2518@fib011235813.fsnet.co.uk>; from joe@fib011235813.fsnet.co.uk on Mon, Oct 14, 2002 at 11:01:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 11:01:50AM +0100, Joe Thornber wrote:
> Yes, there has been a lot more discussion of EVMS than device-mapper
> in the last couple of weeks, however not much of it was complimentary.
> I feel like adding some obvious design flaws to device-mapper so that
> Christoph will give me some free publicity too ;)

Haven't found that big design issues yet, but a number of small
and medium implementation issues and some style nitpicking :)

Comments are against dm_2002-10-09.tar.bz2:

00.patch

	Looks fine.  Useful for other code (like EVMS..), too.

01.patch

	Looks fine, but I wonder whether we really want the
	zeroing in kernel mode (yes, I know userspace calloc
	does it)

02.patch

	It starts to get interesting:

+#define NUM_BUCKETS 64
+#define MASK_BUCKETS (NUM_BUCKETS - 1)
+#define HASH_MULT 2654435387U
+static struct list_head *_dev_buckets;
+static struct list_head *_name_buckets;
+static struct list_head *_uuid_buckets;
+
+/*
+ * Guards access to all three tables.
+ */
+static DECLARE_RWSEM(_hash_lock);

Your heavy _ prefix looks a bit strange from the normal
kernel coding style perspective.  It's fine with me as long
as it's consistant with itself (and it is).

+/*-----------------------------------------------------------------
+ * Init/exit code
+ *---------------------------------------------------------------*/
+void dm_hash_exit(void)
+{
+	if (_dev_buckets)
+		kfree(_dev_buckets);
+
+	if (_name_buckets)
+		kfree(_name_buckets);
+
+	if (_uuid_buckets)
+		kfree(_uuid_buckets);
+}

kfree(NULL) is fine.

+/*-----------------------------------------------------------------
+ * Code for looking up the device by kdev_t.
+ *---------------------------------------------------------------*/
+static struct hash_cell *__get_dev_cell(kdev_t dev)
+{
+	struct list_head *tmp;
+	struct hash_cell *hc;
+	unsigned int h = hash_dev(dev);
+
+	list_for_each (tmp, _dev_buckets + h) {
+		hc = list_entry(tmp, struct hash_cell, list);
+		if (kdev_same(hc->md->dev, dev))
+			return hc;
+	}
+
+	return NULL;
+}

As the argument is purely a hash value I'd suggest to
use a dev_t.  Maybe pass in a struct block_device for
consistency.

+
+struct mapped_device *dm_get_r(kdev_t dev)
+{
+	struct hash_cell *hc;
+	struct mapped_device *md = NULL;
+
+	down_read(&_hash_lock);
+	hc = __get_dev_cell(dev);
+	if (hc && dm_flag(hc->md, DMF_VALID)) {
+		md = hc->md;
+		down_read(&md->lock);
+	}
+	up_read(&_hash_lock);
+
+	return md;
+}

Dito (and some more).

+/*
+ * Convert a device path to a kdev_t.
+ */
+int lookup_device(const char *path, kdev_t *dev)
+{
+	int r;
+	struct nameidata nd;
+	struct inode *inode;
+
+	if ((r = path_lookup(path, LOOKUP_FOLLOW, &nd)))
+		return r;
+
+	inode = nd.dentry->d_inode;
+	if (!inode) {
+		r = -ENOENT;
+		goto out;
+	}
+
+	if (!S_ISBLK(inode->i_mode)) {
+		r = -EINVAL;
+		goto out;
+	}
+
+	*dev = inode->i_rdev;
+
+ out:
+	path_release(&nd);
+	return r;
+}

What about resolving directly to a struct block_device?
And yes, this name -> struct block_Device thing is duplicated
a few times.  Al & I need to look into factoring out.

+ * Open a device so we can use it as a map destination.
+ */
+static int open_dev(struct dm_dev *d)
+{
+	int r;
+
+	if (d->bdev)
+		BUG();
+
+	if (!(d->bdev = bdget(kdev_t_to_nr(d->dev))))
+		return -ENOMEM;
+
+ 	r = blkdev_get(d->bdev, d->mode, 0, BDEV_RAW);
+	if (r) {
+		bdput(d->bdev);
+		return r;
+	}
+
+	return 0;
+}

bd_claim is missing..

+/*
+ * Close a device that we've been using.
+ */
+static void close_dev(struct dm_dev *d)
+{
+	if (!d->bdev)
+		return;
+
+	blkdev_put(d->bdev, BDEV_RAW);
+	d->bdev = NULL;
+}

And bd_unclaim here.

+
+	if (sscanf(path, "%x:%x", &major, &minor) == 2) {
+		/* Extract the major/minor numbers */
+		dev = mk_kdev(major, minor);
+	} else {
+		/* convert the path to a device */
+		if ((r = lookup_device(path, &dev)))
+			return r;
+	}

What do you need the major/minor version for?

+static int __init dm_init(void)
+{
+	const int count = sizeof(_inits) / sizeof(*_inits);

Use ARRAY_SIZE()?

+static int dm_blk_ioctl(struct inode *inode, struct file *file,
+			uint command, unsigned long a)
+{
+	int r;
+	sector_t size;
+	long l_size;
+	unsigned long long ll_size;
+
+	r = get_device_size(inode->i_rdev, &size);
+	if (r)
+		return r;
+
+	switch (command) {
+	case BLKGETSIZE:
+		l_size = (long) size;
+		if (copy_to_user((void *) a, &l_size, sizeof(long)))
+			return -EFAULT;
+		break;
+
+	case BLKGETSIZE64:
+		ll_size = (unsigned long long) size << 9;
+		if (put_user(ll_size, (u64 *) a))
+			return -EFAULT;
+		break;

These two are in generic code and odn't need to be implemented
by a lowlevel driver (won't ever be called).

+{
+	struct clone_info ci;
+
+        ci.md = md;
+        ci.bio = bio;
+        ci.io = alloc_io();
+        ci.io->error = 0;

Some indentation issues here (and in a lot other places).  I'd
suggest you run the file through unexpand(1)

+        ci.io->io_count = (atomic_t) ATOMIC_INIT(1);

This cast looks bogus to me.

+/*
+ * Sets or clears the read-only flag for the device.  Write lock
+ * must be held.
+ */
+void dm_set_ro(struct mapped_device *md, int ro)
+{
+	if (ro)
+		dm_set_flag(md, DMF_RO);
+	else
+		dm_clear_flag(md, DMF_RO);
+
+	set_device_ro(md->dev, ro);
+}

Split this into dm_set_ro and dm_set_rw?  Yes, set_device_ro
has the saem braindead API, but no need to do the same

+/*
+ * We need to be able to change a mapping table under a mounted
+ * filesystem.  For example we might want to move some data in
+ * the background.  Before the table can be swapped with
+ * dm_bind_table, dm_suspend must be called to flush any in
+ * flight bios and ensure that any further io gets
+ * deferred.  Write lock must be held.
+ */
+int dm_suspend(kdev_t dev)

Pass in a struct block_Device here?

+	add_wait_queue(&md->wait, &wait);
+	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (!atomic_read(&md->pending))
+			break;
+
+		yield();
+	}
+
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&md->wait, &wait);

Hmm, the yield() looks strange and INTERRUPTIBLE without
a check for signals, too.  Switch to wait_event_interruptible?

+int dm_resume(kdev_t dev)

struct block_Device?

+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/major.h>
+#include <linux/iobuf.h>

You don't actually use, do you?

+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/compatmac.h>

What do you need from this one?

+#include <linux/cache.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/ctype.h>
+#include <linux/device-mapper.h>
+#include <linux/list.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>

IMHO many of these includes should go into the individual sources
instead.  I doubt you need them in the header.

+static inline void dm_put_r(struct mapped_device *md) {
+	up_read(&md->lock);
+}

static inline void dm_put_r(struct mapped_device *md)
{
	up_read(&md->lock);
}

+
+static inline void dm_put_w(struct mapped_device *md) {
+	up_write(&md->lock);
+}

Dito.

+static inline char *dm_strdup(const char *str)
+{
+	char *r = kmalloc(strlen(str) + 1, GFP_KERNEL);
+	if (r)
+		strcpy(r, str);
+	return r;
+}

What about the following in kernel.h instead?:

static inline char *kstrdup(const char *str, unsigned int gfp_mask)
{
	char *r = kmalloc(strlen(str) + 1, gfp_mask);
	if (likely(r))
		strcpy(r, str);
	return r;
}

+
+static inline int dm_flag(struct mapped_device *md, int flag)
+{
+	return (md->flags & (1 << flag));
+}
+
+static inline void dm_set_flag(struct mapped_device *md, int flag)
+{
+	md->flags |= (1 << flag);
+}
+
+static inline void dm_clear_flag(struct mapped_device *md, int flag)
+{
+	md->flags &= ~(1 << flag);
+}

Are these performance-critial or is there another reason to not
use the generic linux/bitops.h variants?

+int __init dm_interface_init(void);

__init is not needed for the prototypes.  That way you don't need init.h
in the header.

03.patch
04.patch

	Look fine.  I wonder whether they want to be separate modules?

05.patch

+
+/*-----------------------------------------------------------------
+ * Implementation of open/close/ioctl on the special char
+ * device.
+ *---------------------------------------------------------------*/
+static int ctl_open(struct inode *inode, struct file *file)
+{
+	/* only root can open this */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;

Do you really want this in ->open and not the åctual ioctl
commands?

+
+	MOD_INC_USE_COUNT;

Not needed - that's what THIS_MODULE in struct file_operations
is for.

+static int ctl_close(struct inode *inode, struct file *file)
+{
+	MOD_DEC_USE_COUNT;
+	return 0;
+}

Method not needed at all.

+	r = devfs_generate_path(_dm_misc.devfs_handle, rname + 3,
+				sizeof rname - 3);
+	if (r == -ENOSYS)
+		return 0;	/* devfs not present */
+
+	if (r < 0) {
+		DMERR("devfs_generate_path failed for control device");
+		goto failed;
+	}
+
+	strncpy(rname + r, "../", 3);
+	r = devfs_mk_symlink(NULL, DM_DIR "/control",
+			     DEVFS_FL_DEFAULT, rname + r, &_ctl_handle, NULL);

Looks a bit crude.  Why do you need this symlink?

+	__kernel_dev_t dev;	/* in/out */

Hmm.  Can't you just do every ioctl on the actually affected
block device node instead of the character ones?  Unlike LVM1
the nodes are there in /dev/mapper and must not be created..

And I must admit I don't really like the ioctl interface.  But at least
it's separated out properly.
