Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbRETAxJ>; Sat, 19 May 2001 20:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbRETAww>; Sat, 19 May 2001 20:52:52 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:2989 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S261190AbRETAwk>;
	Sat, 19 May 2001 20:52:40 -0400
Message-ID: <3B07154E.2877BFF0@mandrakesoft.com>
Date: Sat, 19 May 2001 20:52:30 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.LNX.4.21.0105191728140.15174-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------5DC60E00EC3EAE4FA814E478"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5DC60E00EC3EAE4FA814E478
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> There are some strong arguments that we should have filesystem
> "backdoors" for maintenance purposes, including backup.

I think I agree with something Al said over IRC, that fs-level snapshots
are preferred over block level snapshots.

fs-level snapshots should become easy if you have a generic transaction
layer.  The OS spits out file ops, which get processed into a set of fs
transactions.  (remember that fs-level stuff like "change this block
bitmap" is also a transaction, just like the more generic "update this
inode's mtime")

Also, I think there should be generic block allocation strategies that
fs's can use.  Implementing fs-specific strategies such as ext2's
readahead or XFS's delayed allocation is not a solution, IMHO, but
working towards solving the real problem.
</ramble>


> You can, of course, so parts of this on a LVM level, and doing backups
> with "disk snapshots" may be a valid approach. However, even that is
> debatable: there is very little that says that the disk image has to be
> up-to-date at any particular point in time, so even with a disk snapshot
> capability (which is not necessarily reasonable under all circumstances)
> there are arguments for maintenance interfaces.

I've been hacking on the attached, a snapshot block device driver, which
doesn't require LVM at all.  (warning: compiled and updated per outside
review, but very alpha...  do not apply)

The point of the driver is to provide a sync point at snapshot time, at
which all metadata and data is flushed to the block device.

My question... is there a fundamental flaw in this plan?  Ideally when
userspace says "start snapshot", the fsync_dev occurs [a
simplification].  At that point, userspace can safely run dump or tar or
whatever on the virtual snapshot device.

-- 
Jeff Garzik      | "Do you have to make light of everything?!"
Building 1024    | "I'm extremely serious about nailing your
MandrakeSoft     |  step-daughter, but other than that, yes."
--------------5DC60E00EC3EAE4FA814E478
Content-Type: text/plain; charset=us-ascii;
 name="snap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snap.patch"

Index: linux_2_4/drivers/block/Config.in
diff -u linux_2_4/drivers/block/Config.in:1.1.1.44 linux_2_4/drivers/block/Config.in:1.1.1.44.4.1
--- linux_2_4/drivers/block/Config.in:1.1.1.44	Tue May 15 04:43:24 2001
+++ linux_2_4/drivers/block/Config.in	Wed May 16 15:44:59 2001
@@ -46,4 +46,6 @@
 fi
 dep_bool '  Initial RAM disk (initrd) support' CONFIG_BLK_DEV_INITRD $CONFIG_BLK_DEV_RAM
 
+tristate 'Snapshot device support' CONFIG_BLK_DEV_SNAP
+
 endmenu
Index: linux_2_4/drivers/block/Makefile
diff -u linux_2_4/drivers/block/Makefile:1.1.1.46 linux_2_4/drivers/block/Makefile:1.1.1.46.4.1
--- linux_2_4/drivers/block/Makefile:1.1.1.46	Tue May 15 04:43:24 2001
+++ linux_2_4/drivers/block/Makefile	Wed May 16 15:44:59 2001
@@ -31,6 +31,7 @@
 obj-$(CONFIG_BLK_DEV_DAC960)	+= DAC960.o
 
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
+obj-$(CONFIG_BLK_DEV_SNAP)	+= snap.o
 
 subdir-$(CONFIG_PARIDE) += paride
 
Index: linux_2_4/drivers/block/snap.c
diff -u /dev/null linux_2_4/drivers/block/snap.c:1.1.6.10
--- /dev/null	Sat May 19 17:36:30 2001
+++ linux_2_4/drivers/block/snap.c	Thu May 17 11:48:54 2001
@@ -0,0 +1,1055 @@
+/*
+   Copyright 2001 Jeff Garzik <jgarzik@mandrakesoft.com>
+   Copyright (C) 2000 Jens Axboe <axboe@suse.de>
+  
+   May be copied or modified under the terms of the GNU General Public
+   License.  See linux/COPYING for more information.
+  
+   Several ideas and some code taken from Jens Axboe's pktcdvd.c 0.0.2j.
+  
+   To-Do list:
+   * Write support.  It's easy, and might be useful in isolated circumstances.
+   * Convert MAX_SNAPDEVS to a module parameter.
+   * Wrap use of "%" operator, to prepare for 64-bit-sized blockdevs on 
+     32-bit processors
+  
+ */
+
+#define VERSION_CODE	"v0.5.0-take6  17 May 2001  Jeff Garzik <jgarzik@mandrakesoft.com>"
+#define MODNAME		"snap"
+#define PFX		MODNAME ": "
+#define MAX_SNAPDEVS	16 
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/file.h>
+#include <linux/blk.h>
+#include <linux/blkpg.h>
+#include <linux/init.h>
+#include <linux/snap.h>
+#include <asm/uaccess.h>
+
+static int *snap_sizes;
+static int *snap_blksize;
+static int *snap_readahead;
+static struct snap_device *snap_devs;
+static int snap_major = -1;
+static spinlock_t snap_lock = SPIN_LOCK_UNLOCKED;
+
+
+/*
+ * a bit of a kludge, but we want to be able to pass source, log,
+ * or snap dev and get the right one.
+ */
+static struct snap_device *snap_find_dev(kdev_t dev)
+{
+	int i, j;
+	struct snap_device *sd;
+
+	spin_lock(&snap_lock);
+
+	for (i = 0; i < MAX_SNAPDEVS; i++) {
+		sd = &snap_devs[i];
+		if ((sd->src.dev == dev) || (sd->snap_dev == dev))
+			goto out;
+		for (j = 0; j < sd->n_logs; j++)
+			if (sd->logs[j].dev == dev)
+				goto out;
+	}
+	sd = NULL;
+
+out:
+	spin_unlock(&snap_lock);
+	return sd;
+}
+
+static request_queue_t *snap_get_queue(kdev_t dev)
+{
+	struct snap_device *sd = snap_find_dev(dev);
+
+	if (!sd)
+		return NULL;
+	return &sd->q;
+}
+
+/* run through the block bitmap on each log device,
+ * checking the most recently appended log first,
+ * to see if the requested block has been remapped and stored
+ * on a log device.
+ * If block was remapped, return log device index
+ */
+static int snap_find_blk(struct snap_device *sd, unsigned long blocknr)
+{
+	unsigned int i;
+
+	for (i = sd->active_logs - 1; i >= 0; i--) {
+		unsigned long bitmap_blk = blocknr / sd->bits_per_block;
+		unsigned int bitmap_bits = blocknr % sd->bits_per_block;
+		struct buffer_head *bit_bh = bread(sd->src.dev, bitmap_blk, sd->blksz);
+		u8 *buf;
+		unsigned int in_log;
+		if (!bit_bh) {
+			printk(KERN_ERR "%s: cannot read log %u bitmap_blk %lu\n",
+			       sd->name, i, bitmap_blk);
+			return -2;
+		}
+		lock_buffer(bit_bh);
+		buf = bit_bh->b_data;
+		in_log = (buf[bitmap_bits / sizeof(u8)] & (1 << (bitmap_bits % sizeof(u8))));
+		unlock_buffer(bit_bh);
+		brelse(bit_bh);
+		if (in_log)
+			return i;
+	}
+	
+	return -1;
+}
+
+/* we have never stored a block located at src_bh->b_rsector before.
+ * allocate space on a log device, and store it.
+ */
+static int snapshot_blk(struct snap_device *sd, request_queue_t *q,
+		        struct buffer_head *src_bh)
+{
+	unsigned int log;
+	struct buffer_head old_bh_d;
+	struct buffer_head *old_bh = &old_bh_d;
+	struct buffer_head *bit_bh, *map_bh, *data_bh;
+	unsigned long bitmap_blk, map_blk, data_blk;
+	unsigned int bitmap_bits, map_ofs;
+	unsigned long blocknr = src_bh->b_rsector;
+	unsigned long *map;
+	u8 *buf;
+
+	/* get index of last active log */
+	if (sd->active_logs == 0) {
+		log = 0;
+		sd->active_logs++;
+	} else {
+		log = sd->active_logs - 1;
+	}
+	
+	/* if no free blocks in current log, move on to the next log. */
+	if (sd->logs[log].free == 0) {
+	
+		/* if no more logs, end snapshot */
+		if (sd->active_logs == sd->n_logs) {
+			request_queue_t *sq = sd->src.q;
+			spin_lock_irq(&io_request_lock);
+
+			sq->make_request_fn = sd->src.make_request_fn;
+			sd->src.make_request_fn = NULL;
+			clear_bit(SNAP_ACTIVE, &sd->flags);
+
+			spin_unlock_irq(&io_request_lock);
+			printk(KERN_WARNING "%s: device full, ending snapshot\n", sd->name);
+			return q->make_request_fn(q, WRITE, src_bh);
+		}
+
+		sd->active_logs++;
+		log++;
+	}
+
+	/* read old data from source device */
+	/* call ll_rw_blk directly on a custom bh to avoid some conflicts */
+	init_buffer(old_bh, NULL, NULL);
+	atomic_set(&old_bh->b_count, 1);
+	old_bh->b_rdev = sd->src.dev;
+	old_bh->b_rsector = blocknr;
+	old_bh->b_state = 1 << BH_Mapped;
+	old_bh->b_size = sd->blksz;
+	old_bh->b_data = kmalloc(sd->blksz, GFP_KERNEL);
+	if (!old_bh->b_data) {
+		printk(KERN_ERR "%s: memory alloc fail on srcdev blk %lu\n",
+		       sd->name, blocknr);
+		goto end_io;
+	}
+	ll_rw_block(READ, 1, &old_bh);
+	wait_on_buffer(old_bh);
+	lock_buffer(old_bh);
+
+	/* read bitmap block from log device */
+	bitmap_blk = blocknr / sd->bits_per_block;
+	bit_bh = bread(sd->logs[log].dev, bitmap_blk, sd->blksz);
+	if (!bit_bh) {
+		brelse(old_bh);
+		printk(KERN_ERR "%s: cannot read log %u bitmap_blk %lu\n",
+		       sd->name, log, bitmap_blk);
+		goto end_io;
+	}
+	lock_buffer(bit_bh);
+
+	/* read map block from log device */
+	map_blk = sd->map_base + (blocknr / sd->maps_per_block);
+	map_bh = bread(sd->logs[log].dev, map_blk, sd->blksz);
+	if (!map_bh) {
+		brelse(old_bh);
+		unlock_buffer(bit_bh);
+		brelse(bit_bh);
+		printk(KERN_ERR "%s: cannot read log %u map_blk %lu\n",
+		       sd->name, log, map_blk);
+		goto end_io;
+	}
+	lock_buffer(map_bh);
+
+	/* getblk data block from log device */
+	data_blk = sd->data_base + (sd->logs[log].data_blocks - sd->logs[log].free);
+	data_bh = getblk(sd->logs[log].dev, data_blk, sd->blksz);
+	if (!data_bh) {
+		brelse(old_bh);
+		unlock_buffer(bit_bh);
+		brelse(bit_bh);
+		unlock_buffer(map_bh);
+		brelse(map_bh);
+		printk(KERN_ERR "%s: cannot getblk log %u data_blk %lu\n",
+		       sd->name, log, data_blk);
+		goto end_io;
+	}
+	lock_buffer(data_bh);
+
+	/* write snapshot of source block to log device */
+	memcpy(data_bh->b_data, old_bh->b_data, sd->blksz);
+	mark_buffer_dirty(data_bh);
+	mark_buffer_uptodate(data_bh, 1);
+	unlock_buffer(data_bh);
+	brelse(data_bh);
+
+	unlock_buffer(old_bh);
+	brelse(old_bh);
+	kfree(old_bh->b_data);
+	
+	/* update block map on logdev to point to snapshot'd block */
+	map_ofs = blocknr % sd->maps_per_block;
+	map = (unsigned long *) map_bh->b_data;
+	map[map_ofs] = data_blk;
+	mark_buffer_dirty(map_bh);
+	mark_buffer_uptodate(map_bh, 1);
+	unlock_buffer(map_bh);
+	brelse(map_bh);
+	
+	/* update bitmap on logdev to indicate remapped block
+	 * is stored on this log device
+	 */
+	bitmap_bits = blocknr % sd->bits_per_block;
+	buf = bit_bh->b_data;
+	buf[bitmap_bits / sizeof(u8)] |= (1 << (bitmap_bits % sizeof(u8)));
+	mark_buffer_dirty(bit_bh);
+	mark_buffer_uptodate(bit_bh, 1);
+	unlock_buffer(bit_bh);
+	brelse(bit_bh);
+	
+	/* update free count */
+	sd->logs[log].free--;
+	
+	/* finally, pass the write down to the source device */
+	return sd->src.make_request_fn(q, WRITE, src_bh);
+	
+end_io:
+	buffer_IO_error(src_bh);
+	return 0;
+}
+
+/*
+ * our replacement for the source device's make_request_fn
+ */
+static int src_make_request(request_queue_t *q, int rw, struct buffer_head *bh)
+{
+	struct snap_device *sd;
+	int log;
+
+	sd = snap_find_dev(bh->b_rdev);
+	
+	/*
+	 * various sanity checks
+	 */
+
+	if (sd == NULL) {
+		printk(KERN_ERR PFX "src request routed to us by unknown snap device\n");
+		goto end_io;
+	}
+	
+	if (bh->b_size != sd->blksz) {
+		printk(KERN_ERR "%s: wrong bh size\n", sd->name);
+		goto end_io;
+	}
+
+	/* read is easy - simply pass it on through to
+	 * underlying block device
+	 */
+	if (rw == READ || rw == READA)
+		return sd->src.make_request_fn(q, rw, bh);
+
+	/* sanity check */	
+	if (rw != WRITE) {
+		printk(KERN_ERR "%s: unknown rw mode %d\n", sd->name, rw);
+		goto end_io;
+	}
+
+	/* if block was already remapped, let the write proceed
+	 * as-is.  No more work needs to be done on our part.
+	 */
+	log = snap_find_blk(sd, bh->b_rsector);
+	if (log < -1)
+		goto end_io;
+	if (log >= 0)
+		return sd->src.make_request_fn(q, rw, bh);
+
+	/* block was not already remapped, write to a log device */
+	return snapshot_blk(sd, q, bh);
+	
+end_io:
+	buffer_IO_error(bh);
+	return 0;
+}
+
+/*
+ * turns snapshotting on or off, AFTER the device has been set up
+ */
+static int snap_mode(struct snap_device *sd, unsigned int starting)
+{
+	request_queue_t *sq;
+	
+	if (!sd->src.q)
+		return -EINVAL;
+	if (starting && test_bit(SNAP_ACTIVE, &sd->flags))
+		return -EINVAL;
+	if (!starting && !test_bit(SNAP_ACTIVE, &sd->flags))
+		return -EINVAL;
+
+	sd->src.q = sq = blk_get_queue(sd->src.dev);
+	
+	/* flush outstanding I/Os for the source device.
+	 * Note that this is a race -IF- we were attempting
+	 * to ensure no I/Os occur between call to fsync_dev()
+	 * and when the swap make_request functions, below.
+	 * However, we don't care about this race since this
+	 * is just a sync point, so life is good.
+	 */
+	fsync_dev(sd->src.dev);
+
+	/* swap srcdev make_request_fn with our own
+	 */
+	spin_lock_irq(&io_request_lock);
+
+	if (starting) {
+		set_bit(SNAP_ACTIVE, &sd->flags);
+		sd->src.make_request_fn = sq->make_request_fn;
+		sq->make_request_fn = src_make_request;
+	} else {
+		sq->make_request_fn = sd->src.make_request_fn;
+		sd->src.make_request_fn = NULL;
+		clear_bit(SNAP_ACTIVE, &sd->flags);
+	}
+
+	spin_unlock_irq(&io_request_lock);
+
+	printk(KERN_INFO "%s: %sing snapshot of %s\n",
+	       sd->name, starting ? "start" : "end", bdevname(sd->src.dev));
+
+	return 0;
+}
+
+/*
+ * a read has occured on the snapshot blkdev, and we know
+ * the block has been remapped, and we know it is on log
+ * device 'log'.  Remap the read into a read of the log device.
+ */
+static int remap_to_logdev(struct snap_device *sd, unsigned int log,
+			  request_queue_t *q, int rw, struct buffer_head *bh)
+{
+	unsigned long map_blk;
+	unsigned int map_ofs;
+	struct buffer_head *map_bh;
+	unsigned long *map;
+
+	/*
+	 * calc the position in the vector of unsigned long
+	 * block numbers where remapped block number is stored
+	 */
+	map_blk = sd->map_base + (bh->b_rsector / sd->maps_per_block);
+	map_ofs = bh->b_rsector % sd->maps_per_block;
+
+	/* read the block from the vector */
+	map_bh = bread(sd->logs[log].dev, map_blk, sd->blksz);
+	if (!map_bh) {
+		printk(KERN_ERR "%s: unable to read log %u block %lu\n",
+		       sd->name, log, map_blk);
+		goto end_io;
+	}
+	lock_buffer(map_bh);
+
+	/* read remapped block number from vector */
+	map = (unsigned long *) map_bh->b_data;
+	map_blk = map[map_ofs];
+	unlock_buffer(map_bh);
+	brelse(map_bh);
+
+	/* do the remap */
+	bh->b_rdev = sd->logs[log].dev;
+	bh->b_rsector = map_blk;
+	return 1;
+
+end_io:
+	buffer_IO_error(bh);
+	return 0;
+}
+
+/*
+ * the make_request_fn for our virtual snapshot blkdev.
+ * All reads are remapped to the source device or a log device,
+ * after some I/O occurs to device where to remap the read.
+ * Writes are not currently supported.
+ */
+static int snap_make_request(request_queue_t *q, int rw, struct buffer_head *bh)
+{
+	struct snap_device *sd;
+	int log;
+
+	if (MINOR(bh->b_rdev) >= MAX_SNAPDEVS) {
+		printk(KERN_ERR PFX "%s out of range\n", kdevname(bh->b_rdev));
+		goto end_io;
+	}
+
+	sd = &snap_devs[MINOR(bh->b_rdev)];
+
+	/*
+	 * various sanity checks
+	 */
+
+	if (!sd->src.dev) {
+		printk(KERN_ERR "%s: request received for non-active sd\n", sd->name);
+		goto end_io;
+	}
+
+	if (rw != READ && rw != READA) {
+		printk(KERN_ERR "%s: non-READ[A] request\n", sd->name);
+		goto end_io;
+	}
+
+	if (bh->b_size != sd->blksz) {
+		printk(KERN_ERR "%s: wrong bh size\n", sd->name);
+		goto end_io;
+	}
+
+	log = snap_find_blk(sd, bh->b_rsector);
+	if (log < -1)
+		goto end_io;
+	if (log >= 0)
+		return remap_to_logdev(sd, log, q, rw, bh);
+	
+	/*
+	 * ok, the block was not remapped onto a log device,
+	 * so remap the request to request from the original
+	 * source device.  Since block numbers are the same
+	 * on the virtual snapdev and the srcdev, we need
+	 * only to change the device to which the read request
+	 * is targetted.
+	 */
+	bh->b_rdev = sd->src.dev;
+	return 1;
+
+end_io:
+	buffer_IO_error(bh);
+	return 0;
+}
+
+/*
+ * initialize the request queue for the snapshot blkdev
+ */
+static void snap_init_queue(struct snap_device *sd)
+{
+	request_queue_t *q = &sd->q;
+
+	blk_queue_make_request(q, snap_make_request);
+	blk_queue_headactive(q, 0);
+}
+
+/**********************************************************************
+ *
+ * Block device ioctl operation and associated functions.
+ *
+ */
+ 
+/* initialize a log device.  all we need to do is zero the bitmap
+ * that appears at the beginning of the disk
+ */
+static void snap_mkfs (struct snap_device *sd, unsigned int logidx,
+		       unsigned int bitmap_blocks)
+{
+	unsigned int i, blksz = sd->blksz;
+	
+	for (i = 0; i < bitmap_blocks; i++) {
+		struct buffer_head *bh = getblk(sd->logs[i].dev, i, blksz);
+		if (bh) {
+			lock_buffer(bh);
+			memset(bh->b_data, 0, blksz);
+			mark_buffer_dirty(bh);
+			mark_buffer_uptodate(bh, 1);
+			unlock_buffer(bh);
+			brelse(bh);
+		} else {
+			printk(KERN_ERR "%s: cannot get blk %u\n", sd->name, i);
+		}
+	}
+}
+
+/*
+ * the source and log devices have been opened and sanity-checked
+ * at this point.  initialize 'sd' based on the information provided
+ */
+static int snap_new_dev(struct snap_device *sd,
+			kdev_t src_dev, struct block_device *src_bdev,
+			unsigned int n_log_fds, struct snap_dev_init_info *sdii)
+{
+	unsigned int i;
+	unsigned long map_blocks, bitmap_blocks;
+	int ret;
+	void *log_buf;
+
+	MOD_INC_USE_COUNT;
+
+	log_buf = kmalloc(sizeof(struct snap_log) * n_log_fds, GFP_KERNEL);
+	if (!log_buf) {
+		ret = -ENOMEM;
+		goto out_bufs;
+	}
+
+	spin_lock(&snap_lock);
+
+	memset(sd, 0, sizeof(struct snap_device));
+
+	sd->src.dev = src_dev;
+	sd->src.q = blk_get_queue (sd->src.dev);
+	sd->blksz = blksize_size[MAJOR(src_dev)][MINOR(src_dev)];
+	sd->src.bdev = src_bdev;
+	sd->src.blocks = blk_size[MAJOR(src_dev)][MINOR(src_dev)];
+	
+	sd->n_logs = n_log_fds;
+	sd->logs = log_buf;
+	memset(sd->logs, 0, sizeof(struct snap_log) * n_log_fds);
+
+	sd->bits_per_block = sd->blksz * 8;
+	sd->maps_per_block = sd->blksz / (sizeof(unsigned long) * 2);
+
+	bitmap_blocks = sd->src.blocks / sd->bits_per_block;
+	if (sd->src.blocks % sd->bits_per_block)
+		bitmap_blocks++;
+
+	map_blocks = sd->src.blocks / sd->maps_per_block;
+	if (sd->src.blocks % sd->maps_per_block)
+		map_blocks++;
+	
+	sd->map_base = bitmap_blocks;
+	sd->data_base = bitmap_blocks + map_blocks;
+
+	for (i = 0; i < n_log_fds; i++) {
+		kdev_t logdev = sdii[i].inode->i_rdev;
+		sd->logs[i].dev = logdev;
+		sd->logs[i].size = blk_size[MAJOR(logdev)][MINOR(logdev)];
+
+		if (sd->logs[i].size < (sd->data_base * 2)) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		sd->logs[i].data_blocks =
+		sd->logs[i].free =
+			sd->logs[i].size - bitmap_blocks - map_blocks;
+		
+		set_blocksize(logdev, sd->blksz);
+	}
+
+	sd->snap_dev = MKDEV(snap_major, i);
+	sprintf(sd->name, "snap%d", i);
+	atomic_set(&sd->refcnt, 0);
+
+	spin_unlock(&snap_lock);
+
+	snap_init_queue(sd);
+
+	for (i = 0; i < n_log_fds; i++)
+		snap_mkfs (sd, i, bitmap_blocks);
+
+	DPRINTK(PFX "dev %s sucessfully registered\n", sd->name);
+	return 0;
+
+out_free:
+	spin_unlock(&snap_lock);
+	kfree(sd->logs);
+out_bufs:
+	MOD_DEC_USE_COUNT;
+	return ret;
+}
+
+/* clean up in the event of snap_setup_dev error exit */
+static void snap_setup_dev_cleanup (unsigned int n_log_fds, struct file *src,
+				    struct snap_dev_init_info *sdii)
+{
+	unsigned int i;
+
+	if (sdii) {
+		for (i = 0; i < n_log_fds; i++)
+			if (sdii[i].file) {
+				blkdev_put(sdii[i].inode->i_bdev, BDEV_FILE);
+				fput(sdii[i].file);
+			}
+		kfree(sdii);
+	}
+
+	if (src) {
+		blkdev_put(src->f_dentry->d_inode->i_bdev, BDEV_FILE);
+		fput(src);
+	}
+}
+
+/*
+ * called from ioctl.  verifies the passed file descriptors to
+ * be open and valid block devices, then called snap_new_dev
+ * to actually initialize the device
+ */
+static int snap_setup_dev(struct snap_device *sd, struct snap_setup *setup)
+{
+	struct snap_dev_init_info *sdii = NULL;
+	struct inode *inode_src;
+	struct file *src;
+	int ret;
+	unsigned int i, n_log_fds = setup->n_log_fds;
+
+	if ((src = fget(setup->src_fd)) == NULL) {
+		printk(KERN_ERR "%s: bad file descriptor %d passed\n", sd->name, setup->src_fd);
+		return -EBADF;
+	}
+	if ((inode_src = src->f_dentry->d_inode) == NULL) {
+		printk(PFX "huh? file descriptor %d contains no inode?\n", setup->src_fd);
+		fput(src);
+		return -EINVAL;
+	}
+	if (!S_ISBLK(inode_src->i_mode)) {
+		printk(PFX "device is not a block device (duh)\n");
+		fput(src);
+		return -ENOTBLK;
+	}
+	if (snap_find_dev(inode_src->i_rdev)) {
+		printk(PFX "source device associated with another snapshot dev\n");
+		fput(src);
+		return -EBUSY;
+	}
+	ret = blkdev_get(inode_src->i_bdev, src->f_mode, src->f_flags, BDEV_FILE);
+	if (ret) {
+		fput(src);
+		return ret;
+	}
+
+	sdii = kmalloc(sizeof(*sdii) * n_log_fds, GFP_KERNEL);
+	if (!sdii) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	memset(sdii, 0, sizeof(*sdii) * n_log_fds);
+
+	for (i = 0; i < n_log_fds; i++) {
+		struct file *logf;
+		struct inode *logi;
+
+		logf = sdii[i].file = fget(setup->log_fd[i]);
+		if (!logf) {
+			printk(PFX "bad file descriptor %d passed\n",
+			       setup->log_fd[i]);
+			ret = -EBADF;
+			goto out;
+		}
+		logi = sdii[i].inode = sdii[i].file->f_dentry->d_inode;
+		if (!logi) {
+			printk(PFX "huh? file descriptor %d contains no inode?\n",
+			       setup->log_fd[i]);
+			ret = -EINVAL;
+			goto out;
+		}
+		if (!S_ISBLK(logi->i_mode)) {
+			printk(PFX "device is not a block device\n");
+			ret = -ENOTBLK;
+			goto out;
+		}
+		if (snap_find_dev(logi->i_rdev)) {
+			printk(PFX "log device %d associated with another snapshot dev\n", i);
+			ret = -EBUSY;
+			goto out;
+		}
+		if (IS_RDONLY(logi)) {
+			printk(PFX "Can't write to read-only dev\n");
+			ret = -EROFS;
+			goto out;
+		}
+		ret = blkdev_get(logi->i_bdev, logf->f_mode,
+				 logf->f_flags, BDEV_FILE);
+		if (ret)
+			goto out;
+	}
+	
+	if ((ret = snap_new_dev(sd, inode_src->i_rdev, inode_src->i_bdev,
+				n_log_fds, sdii))) {
+		printk(PFX "all booked up\n");
+		goto out;
+	}
+	
+	sd->src.dentry = dget(src->f_dentry);
+	for (i = 0; i < n_log_fds; i++)
+		sd->logs[i].dentry = dget(sdii[i].file->f_dentry);
+	atomic_inc(&sd->refcnt);
+
+	ret = 0;
+out:
+	snap_setup_dev_cleanup(n_log_fds, src, sdii);
+	return ret;
+}
+
+/*
+ * called from ioctl.  tears down the currently
+ * setup snapshot device, and closes all open resources
+ */
+static int snap_remove_dev(struct snap_device *sd)
+{
+	unsigned int i;
+
+	/* terminate any on-going snapshot, if any */
+	snap_mode(sd, 0);
+
+	blkdev_put(sd->src.dentry->d_inode->i_bdev, BDEV_FILE);
+	dput(sd->src.dentry);
+
+	for (i = 0; i < sd->n_logs; i++) {
+		blkdev_put(sd->logs[i].dentry->d_inode->i_bdev, BDEV_FILE);
+		dput(sd->logs[i].dentry);
+		invalidate_buffers(sd->logs[i].dev);
+	}
+	kfree(sd->logs);
+
+	invalidate_buffers(sd->snap_dev);
+
+	for (i = 0; i < sd->n_logs; i++)
+		blk_cleanup_queue(blk_get_queue(sd->logs[i].dev));
+	blk_cleanup_queue(blk_get_queue(sd->src.dev));
+
+	DPRINTK(PFX "dev %s unregistered\n", sd->name);
+
+	memset(sd, 0, sizeof(struct snap_device));
+
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+static int snap_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg)
+{
+	struct snap_device *sd;
+	int err;
+
+	if (MINOR(inode->i_rdev) >= MAX_SNAPDEVS)
+		return -EINVAL;
+
+	sd = &snap_devs[MINOR(inode->i_rdev)];
+
+	if ((cmd != SNAP_SETUP_DEV) && !sd->src.dev) {
+		DPRINTK(PFX "dev not setup\n");
+		return -ENXIO;
+	}
+
+	switch (cmd) {
+	case SNAP_GET_STATS:
+		if (copy_to_user(&arg, &sd->stats, sizeof(struct snap_stats)))
+			return -EFAULT;
+
+	case SNAP_SETUP_DEV: {
+		struct snap_setup se, *sp;
+		unsigned int alloc_size;
+		
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (sd->src.dev) {
+			printk(PFX "dev already setup\n");
+			return -EBUSY;
+		}
+		if (copy_from_user(&se, &arg, sizeof(se)))
+			return -EFAULT;
+		if (se.n_log_fds == 0 || se.n_log_fds > MAX_LOGDEVS)
+			return -EINVAL;
+		alloc_size = sizeof(se) + (sizeof(int) * se.n_log_fds);
+		sp = kmalloc(alloc_size, GFP_KERNEL);
+		if (!sp)
+			return -ENOMEM;
+		if (copy_from_user(sp, &arg, alloc_size)) {
+			kfree(sp);
+			return -EFAULT;
+		}
+		err = snap_setup_dev(sd, sp);
+		kfree(sp);
+		return err;
+	}
+
+	case SNAP_TEARDOWN_DEV:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		fsync_dev(sd->src.dev); /* HACK! minimize, but not close, race */
+		if (atomic_read(&sd->refcnt) != 1)
+			return -EBUSY;
+		return snap_remove_dev(sd);
+
+	case SNAP_START:
+		return snap_mode(sd, 1);
+	case SNAP_END:
+		return snap_mode(sd, 0);
+		
+	case BLKGETSIZE:
+		return put_user(blk_size[snap_major][MINOR(inode->i_rdev)] << 1, (long *)arg);
+
+	case BLKROSET:
+	case BLKROGET:
+	case BLKSSZGET:
+	case BLKRASET:
+	case BLKRAGET:
+	case BLKFLSBUF:
+		return blk_ioctl(inode->i_rdev, cmd, arg);
+
+	/*
+	 * forward all other ioctls to src blkdev
+	 */
+	default:
+		return ioctl_by_bdev(sd->src.bdev, cmd, arg);
+	}
+
+	return 0;
+}
+
+/**********************************************************************
+ *
+ * Block device operations (open/close/check_media_change),
+ * and associated functions.
+ *
+ */
+ 
+static inline void snap_mark_readonly(struct snap_device *sd, int on)
+{
+	if (on)
+		set_bit(SNAP_READONLY, &sd->flags);
+	else
+		clear_bit(SNAP_READONLY, &sd->flags);
+}
+
+static int snap_open_dev(struct snap_device *sd, int write)
+{
+	unsigned long dev_size;
+
+	if (!sd->src.dev)
+		return 0;
+
+	dev_size = blk_size[MAJOR(sd->src.dev)][MINOR(sd->src.dev)];
+	snap_sizes[MINOR(sd->snap_dev)] = dev_size;
+
+	if (write) {
+#if 0 /* no write support */
+		if ((ret = snap_open_write(sd)))
+			return ret;
+		snap_mark_readonly(sd, 0);
+#else
+		return -EINVAL;
+#endif
+	} else {
+		snap_mark_readonly(sd, 1);
+	}
+
+	if (write)
+		printk(PFX "%lukB available on disc\n", dev_size);
+
+	return 0;
+}
+
+static int snap_open(struct inode *inode, struct file *file)
+{
+	struct snap_device *sd = NULL;
+	int ret;
+
+	VPRINTK(PFX "entering open\n");
+
+	/* remove when write mode is supported */
+	if (file->f_mode & FMODE_WRITE) {
+		printk(PFX "write mode not supported\n");
+		return -EINVAL;
+	}
+
+	MOD_INC_USE_COUNT;
+
+	if (MINOR(inode->i_rdev) >= MAX_SNAPDEVS) {
+		printk(PFX "max %d snapdevs supported\n", MAX_SNAPDEVS);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/*
+	 * either device is not configured, or pktsetup is old and doesn't
+	 * use O_CREAT to create device
+	 */
+	sd = &snap_devs[MINOR(inode->i_rdev)];
+	if (!sd->src.dev && !(file->f_flags & O_CREAT)) {
+		VPRINTK(PFX "not configured and O_CREAT not set\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	atomic_inc(&sd->refcnt);
+	if ((atomic_read(&sd->refcnt) > 1) && (file->f_mode & FMODE_WRITE)) {
+		VPRINTK(PFX "busy open for write\n");
+		ret = -EBUSY;
+		goto out_dec;
+	}
+
+	ret = snap_open_dev(sd, file->f_mode & FMODE_WRITE);
+	if (ret)
+		goto out_dec;
+
+	/*
+	 * needed here as well, since ext2 (among others) may change
+	 * the blocksize at mount time
+	 */
+	set_blocksize(sd->snap_dev, sd->blksz);
+	return 0;
+
+out_dec:
+	atomic_dec(&sd->refcnt);
+out:
+	VPRINTK(PFX "failed open (%d)\n", ret);
+	MOD_DEC_USE_COUNT;
+	return ret;
+}
+
+static void snap_release_dev(struct snap_device *sd)
+{
+	fsync_dev(sd->snap_dev);
+	invalidate_buffers(sd->snap_dev);
+
+	atomic_dec(&sd->refcnt);
+}
+
+static int snap_close(struct inode *inode, struct file *file)
+{
+	struct snap_device *sd = &snap_devs[MINOR(inode->i_rdev)];
+
+	if (sd->src.dev)
+		snap_release_dev(sd);
+
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+/* FIXME: -really- handle media change, by disabling active snapshot
+ * if source media changes, or handle fatal errors if target media
+ * changes
+ */
+static int snap_media_change(kdev_t dev)
+{
+	struct snap_device *sd = &snap_devs[MINOR(dev)];
+	return sd->src.bdev->bd_op->check_media_change(dev);
+}
+
+static struct block_device_operations snap_ops = {
+	open:			snap_open,
+	release:		snap_close,
+	ioctl:			snap_ioctl,
+	check_media_change:	snap_media_change,
+};
+
+/**********************************************************************
+ *
+ * Module initializations and cleanup
+ *
+ */
+ 
+static inline void snap_cleanup (void)
+{
+	if (snap_devs)
+		kfree(snap_devs);
+	if (snap_sizes)
+		kfree(snap_sizes);
+	if (snap_blksize)
+		kfree(snap_blksize);
+	if (snap_readahead)
+		kfree(snap_readahead);
+
+	snap_devs = NULL;
+	snap_sizes = NULL;
+	snap_blksize = NULL;
+	snap_readahead = NULL;
+	blk_size[snap_major] = NULL;
+	blksize_size[snap_major] = NULL;
+	max_readahead[snap_major] = NULL;
+	blk_dev[snap_major].queue = NULL;
+}
+
+static int __init snap_init(void)
+{
+	snap_major = devfs_register_blkdev(0, MODNAME, &snap_ops);
+	if (snap_major <= 0) { /* zero is invalid value b/c we need a major */
+		printk("unable to register snap device\n");
+		return -EIO;
+	}
+	devfs_register(NULL, MODNAME, 0, DEVFS_FL_DEFAULT, snap_major,
+		       S_IFBLK | S_IRUSR | S_IWUSR, &snap_ops, NULL);
+
+	snap_sizes = kmalloc(MAX_SNAPDEVS * sizeof(int), GFP_KERNEL);
+	if (snap_sizes == NULL)
+		goto err;
+
+	snap_blksize = kmalloc(MAX_SNAPDEVS * sizeof(int), GFP_KERNEL);
+	if (snap_blksize == NULL)
+		goto err;
+
+	snap_readahead = kmalloc(MAX_SNAPDEVS * sizeof(int), GFP_KERNEL);
+	if (snap_readahead == NULL)
+		goto err;
+
+	snap_devs = kmalloc(MAX_SNAPDEVS * sizeof(struct snap_device), GFP_KERNEL);
+	if (snap_devs == NULL)
+		goto err;
+
+	memset(snap_devs, 0, MAX_SNAPDEVS * sizeof(struct snap_device));
+	memset(snap_sizes, 0, MAX_SNAPDEVS * sizeof(int));
+	memset(snap_blksize, 0, MAX_SNAPDEVS * sizeof(int));
+	memset(snap_readahead, 0, MAX_SNAPDEVS * sizeof(int));
+
+	blk_size[snap_major] = snap_sizes;
+	blksize_size[snap_major] = snap_blksize;
+	max_readahead[snap_major] = snap_readahead;
+	read_ahead[snap_major] = 128;
+
+	blk_dev[snap_major].queue = snap_get_queue;
+
+	DPRINTK(PFX "%s\n", VERSION_CODE);
+	return 0;
+
+err:
+	printk(PFX "out of memory\n");
+	devfs_unregister(devfs_find_handle(NULL, MODNAME, 0, 0,
+		 	 DEVFS_SPECIAL_BLK, 0));
+	devfs_unregister_blkdev(snap_major, MODNAME);
+	snap_cleanup ();
+	return -ENOMEM;
+}
+
+static void __exit snap_exit(void)
+{
+	devfs_unregister(devfs_find_handle(NULL, MODNAME, 0, 0,
+		 	 DEVFS_SPECIAL_BLK, 0));
+	devfs_unregister_blkdev(snap_major, MODNAME);
+
+	snap_cleanup ();
+	snap_major = 0;
+}
+
+MODULE_DESCRIPTION("Snapshot block device");
+MODULE_AUTHOR("Jeff Garzik <jgarzik@mandrakesoft.com>");
+
+module_init(snap_init);
+module_exit(snap_exit);
Index: linux_2_4/include/linux/snap.h
diff -u /dev/null linux_2_4/include/linux/snap.h:1.1.6.5
--- /dev/null	Sat May 19 17:36:31 2001
+++ linux_2_4/include/linux/snap.h	Thu May 17 11:09:38 2001
@@ -0,0 +1,126 @@
+/*
+ * Copyright 2001 Jeff Garzik <jgarzik@mandrakesoft.com>
+ * Copyright (C) 2000 Jens Axboe <axboe@suse.de>
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License.  See linux/COPYING for more information.
+ *
+ */
+#ifndef __LINUX_SNAP_H
+#define __LINUX_SNAP_H
+
+/*
+ * 1 for normal debug messages, 2 is very verbose. 0 to turn it off.
+ */
+#define SNAP_DEBUG		1
+
+/*
+ * No user-servicable parts beyond this point ->
+ */
+
+#if SNAP_DEBUG
+#define DPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+#if SNAP_DEBUG > 1
+#define VPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
+#else
+#define VPRINTK(fmt, args...)
+#endif
+
+/* bh list unique identifier */
+#define SNAP_BUF_LIST		0x93
+
+/*
+ * flags
+ */
+#define SNAP_READONLY		1	/* read only dev */
+#define SNAP_ACTIVE		2	/* snapshot dev is active */
+
+/*
+ * Very unused stats for now
+ */
+struct snap_stats
+{
+	unsigned long		bh_s;
+	unsigned long		bh_e;
+	unsigned long		bh_cache_hits;
+	unsigned long		page_cache_hits;
+	unsigned long		secs_w;
+	unsigned long		secs_r;
+};
+
+#define MAX_LOGDEVS		512 /* arbitrary limit */
+
+struct snap_setup
+{
+	int			src_fd;
+	unsigned int		n_log_fds;
+	int			log_fd[0];
+};
+
+/*
+ * packet ioctls
+ */
+#define SNAP_IOCTL_MAGIC	('N')
+#define SNAP_GET_STATS		_IOR(SNAP_IOCTL_MAGIC, 0xE0, struct snap_stats)
+#define SNAP_SETUP_DEV		_IOW(SNAP_IOCTL_MAGIC, 0xE1, struct snap_setup)
+#define SNAP_TEARDOWN_DEV	_IOW(SNAP_IOCTL_MAGIC, 0xE2, unsigned int)
+#define SNAP_START		_IO(SNAP_IOCTL_MAGIC, 0xE3)
+#define SNAP_END		_IO(SNAP_IOCTL_MAGIC, 0xE4)
+
+#ifdef __KERNEL__
+#include <linux/blkdev.h>
+
+struct snap_dev_init_info
+{
+	struct inode *inode;
+	struct file *file;
+};
+
+struct snap_src
+{
+	request_queue_t			*q;
+	kdev_t				dev;
+
+	make_request_fn			*make_request_fn;
+
+	struct block_device		*bdev;
+	struct dentry			*dentry;
+	unsigned long			blocks;
+};
+
+struct snap_log
+{
+	kdev_t				dev;
+	struct dentry			*dentry;
+	unsigned long			size;
+	unsigned long			free;
+	unsigned long			data_blocks;
+};
+
+struct snap_device
+{
+	struct snap_src			src;
+	struct snap_log			*logs;
+	unsigned int			n_logs;
+	unsigned int			active_logs;
+	
+	request_queue_t			q;
+	atomic_t			refcnt;
+	kdev_t				snap_dev;
+	unsigned long			flags;
+	char				name[20];
+	unsigned int			bits_per_block;
+	unsigned int			maps_per_block;
+	unsigned long			map_base;
+	unsigned long			data_base;
+	unsigned int			blksz;
+	struct snap_stats		stats;
+};
+
+#endif /* __KERNEL__ */
+
+#endif /* __LINUX_SNAP_H */

--------------5DC60E00EC3EAE4FA814E478--

