Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWCBLUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWCBLUd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 06:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbWCBLUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 06:20:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45318 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751456AbWCBLUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 06:20:32 -0500
Date: Thu, 2 Mar 2006 12:19:46 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] bsg, block layer sg
Message-ID: <20060302111945.GG4329@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After all that SG_IO and cdrecord talk, I decided to brush off the bsg
driver I wrote some time ago. Basically this is a full (aims to be at
least, probably still some minor bits missing) SG v3 interface. It
supports both SG_IO (which we just pass through for now), as well as
read/write and readv/writev of sg_io_hdr structures.

What's new in this area is that the bsg character device is closely tied
to the block device. This relationsship is depicted in sysfs. bsg
devices will show up in /sys/class/bsg/<devname>, and there is a link
from /sys/block/<devname>/queue/bsg to that directory. With some
udev/hotplug magic, it should create device nodes for you automatically.

TODO:

- Fold block/scsi_ioctl.c and block/bsg.c into one
- Further improve the sysfs relations between a device and bsg
- Test and so on

Probably some bugs still pending, it works for me though.

---

 block/Kconfig            |    7 
 block/Makefile           |    3 
 block/bsg.c              | 1259 ++++++++++++++++++++++++++++++++++++++++++++++
 block/ll_rw_blk.c        |    8 
 block/scsi_ioctl.c       |  165 ++++--
 drivers/ide/ide-floppy.c |   29 +
 drivers/ide/ide.c        |   10 
 include/linux/blkdev.h   |   12 
 include/linux/bsg.h      |   21 +
 include/linux/genhd.h    |    2 
 10 files changed, 1432 insertions(+), 84 deletions(-)
 create mode 100644 block/bsg.c
 create mode 100644 include/linux/bsg.h

42b7b79f6f42e12e584f7b5e44c5c968a8acc304
diff --git a/block/Kconfig b/block/Kconfig
index 377f6dd..f124079 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -11,4 +11,11 @@ config LBD
 	  your machine, or if you want to have a raid or loopback device
 	  bigger than 2TB.  Otherwise say N.
 
+config BLK_DEV_BSG
+	bool "Block layer SG support"
+	default y
+	---help---
+	Saying Y here will enable generic SG (SCSI generic) v3
+	support for any block device.
+
 source block/Kconfig.iosched
diff --git a/block/Makefile b/block/Makefile
index 7e4f93e..edacc3e 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -2,8 +2,9 @@
 # Makefile for the kernel block layer
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
+obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o bsg.o
 
+obj-$(CONFIG_BLK_DEV_BSG)	+= bsg.o
 obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
 obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o
diff --git a/block/bsg.c b/block/bsg.c
new file mode 100644
index 0000000..22b66ac
--- /dev/null
+++ b/block/bsg.c
@@ -0,0 +1,1259 @@
+/*
+ * bsg.c - block layer implementation of the sg v3 interface
+ *
+ * Copyright (C) 2004 Jens Axboe <axboe@suse.de> SUSE Labs
+ * Copyright (C) 2004 Peter M. Jones <pjones@redhat.com>
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License version 2.  See the file "COPYING" in the main directory of this
+ *  archive for more details.
+ *
+ */
+/*
+ * TODO
+ *	- Should this get merged, block/scsi_ioctl.c will be migrated into
+ *	  this file. To keep maintenance down, it's easier to have them
+ *	  seperated right now.
+ *
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/file.h>
+#include <linux/blkdev.h>
+#include <linux/poll.h>
+#include <linux/cdev.h>
+#include <linux/percpu.h>
+#include <linux/uio.h>
+#include <linux/bsg.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_ioctl.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/sg.h>
+
+static char bsg_version[] = "block layer sg (bsg) 0.4";
+
+struct bsg_command;
+
+struct bsg_device {
+	struct gendisk *disk;
+	request_queue_t *queue;
+	spinlock_t lock;
+	struct list_head busy_list;
+	struct list_head done_list;
+	struct hlist_node dev_list;
+	atomic_t ref_count;
+	int minor;
+	int queued_cmds;
+	int done_cmds;
+	unsigned long *cmd_bitmap;
+	struct bsg_command *cmd_map;
+	wait_queue_head_t wq_done;
+	wait_queue_head_t wq_free;
+	char name[BDEVNAME_SIZE];
+	int max_queue;
+	unsigned long flags;
+};
+
+enum {
+	BSG_F_BLOCK		= 1,
+	BSG_F_WRITE_PERM	= 2,
+};
+
+/*
+ * command allocation bitmap defines
+ */
+#define BSG_CMDS_PAGE_ORDER	(1)
+#define BSG_CMDS_PER_LONG	(sizeof(unsigned long) * 8)
+#define BSG_CMDS_MASK		(BSG_CMDS_PER_LONG - 1)
+#define BSG_CMDS_BYTES		(PAGE_SIZE * (1 << BSG_CMDS_PAGE_ORDER))
+#define BSG_CMDS		(BSG_CMDS_BYTES / sizeof(struct bsg_command))
+
+/*
+ * arbitrary limit, mapping bio's will reveal true device limit
+ */
+#define BSG_MAX_VECS		(128)
+
+#undef BSG_DEBUG
+
+#ifdef BSG_DEBUG
+#define dprintk(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ##args)
+#else
+#define dprintk(fmt, args...)
+#endif
+
+#define list_entry_bc(entry)	list_entry((entry), struct bsg_command, list)
+
+/*
+ * just for testing
+ */
+#define BSG_MAJOR	(240)
+
+static DEFINE_MUTEX(bsg_mutex);
+static int bsg_device_nr;
+
+#define BSG_LIST_SIZE	(8)
+#define bsg_list_idx(minor)	((minor) & (BSG_LIST_SIZE - 1))
+static struct hlist_head bsg_device_list[BSG_LIST_SIZE];
+
+static struct class *bsg_class;
+static LIST_HEAD(bsg_class_list);
+
+/*
+ * our internal command type
+ */
+struct bsg_command {
+	struct bsg_device *bd;
+	struct list_head list;
+	struct request *rq;
+	struct bio *bio;
+	int err;
+	struct sg_io_hdr hdr;
+	struct sg_io_hdr __user *uhdr;
+	char sense[SCSI_SENSE_BUFFERSIZE];
+};
+
+static void bsg_free_command(struct bsg_command *bc)
+{
+	struct bsg_device *bd = bc->bd;
+	unsigned long bitnr = bc - bd->cmd_map;
+	unsigned long flags;
+
+	dprintk("%s: command bit offset %lu\n", bd->name, bitnr);
+
+	spin_lock_irqsave(&bd->lock, flags);
+	bd->queued_cmds--;
+	__clear_bit(bitnr, bd->cmd_bitmap);
+	spin_unlock_irqrestore(&bd->lock, flags);
+
+	wake_up(&bd->wq_free);
+}
+
+static struct bsg_command *__bsg_alloc_command(struct bsg_device *bd)
+{
+	struct bsg_command *bc = NULL;
+	unsigned long *map;
+	int free_nr;
+
+	spin_lock_irq(&bd->lock);
+
+	if (bd->queued_cmds >= bd->max_queue)
+		goto out;
+
+	for (free_nr = 0, map = bd->cmd_bitmap; *map == ~0UL; map++)
+		free_nr += BSG_CMDS_PER_LONG;
+
+	BUG_ON(*map == ~0UL);
+			
+	bd->queued_cmds++;
+	free_nr += ffz(*map);
+	__set_bit(free_nr, bd->cmd_bitmap);
+	spin_unlock_irq(&bd->lock);
+
+	bc = bd->cmd_map + free_nr;
+	memset(bc, 0, sizeof(*bc));
+	bc->bd = bd;
+	INIT_LIST_HEAD(&bc->list);
+	dprintk("%s: returning free cmd %p (bit %d)\n", bd->name, bc, free_nr);
+	return bc;
+out:
+	dprintk("%s: failed (depth %d)\n", bd->name, bd->queued_cmds);
+	spin_unlock_irq(&bd->lock);
+	return bc;
+}
+
+static inline void
+bsg_del_done_cmd(struct bsg_device *bd, struct bsg_command *bc)
+{
+	bd->done_cmds--;
+	list_del(&bc->list);
+}
+
+static inline void
+bsg_add_done_cmd(struct bsg_device *bd, struct bsg_command *bc)
+{
+	bd->done_cmds++;
+	list_add_tail(&bc->list, &bd->done_list);
+	wake_up(&bd->wq_done);
+}
+
+static inline int bsg_io_schedule(struct bsg_device *bd, int state)
+{
+	DEFINE_WAIT(wait);
+	int ret = 0;
+
+	spin_lock_irq(&bd->lock);
+
+	BUG_ON(bd->done_cmds > bd->queued_cmds);
+
+	/*
+	 * -ENOSPC or -ENODATA?  I'm going for -ENODATA, meaning "I have no
+	 * work to do", even though we return -ENOSPC after this same test
+	 * during bsg_write() -- there, it means our buffer can't have more
+	 * bsg_commands added to it, thus has no space left.
+	 */
+	if (bd->done_cmds == bd->queued_cmds) {
+		ret = -ENODATA;
+		goto unlock;
+	}
+
+	if (!test_bit(BSG_F_BLOCK, &bd->flags)) {
+		ret = -EAGAIN;
+		goto unlock;
+	}
+
+	spin_unlock_irq(&bd->lock);
+	prepare_to_wait(&bd->wq_done, &wait, state);
+	io_schedule();
+	finish_wait(&bd->wq_done, &wait);
+
+	if ((state == TASK_INTERRUPTIBLE) && signal_pending(current))
+		ret = -ERESTARTSYS;
+
+	return ret;
+unlock:
+	spin_unlock_irq(&bd->lock);
+	return ret;
+}
+
+/*
+ * get a new free command, blocking if needed and specified
+ */
+static struct bsg_command *bsg_get_command(struct bsg_device *bd)
+{
+	struct bsg_command *bc;
+	int ret;
+
+	do {
+		bc = __bsg_alloc_command(bd);
+		if (bc)
+			break;
+			
+		ret = bsg_io_schedule(bd, TASK_INTERRUPTIBLE);
+		if (ret) {
+			bc = ERR_PTR(ret);
+			break;
+		}
+
+	} while (1);
+
+	return bc;
+}
+
+/*
+ * Check if sg_io_hdr from user is allowed and valid
+ */
+static int
+bsg_validate_sghdr(request_queue_t *q, struct sg_io_hdr *hdr, int *rw)
+{
+	if (hdr->interface_id != 'S')
+		return -EINVAL;
+	if (hdr->cmd_len > BLK_MAX_CDB)
+		return -EINVAL;
+	if (hdr->iovec_count > BSG_MAX_VECS)
+		return -EINVAL;
+	if (hdr->dxfer_len > (q->max_sectors << 9))
+		return -EIO;
+
+	/*
+	 * looks sane, if no data then it should be fine from our POV
+	 */
+	if (!hdr->dxfer_len)
+		return 0;
+
+	switch (hdr->dxfer_direction) {
+		case SG_DXFER_TO_FROM_DEV:
+		case SG_DXFER_FROM_DEV:
+			*rw = READ;
+			break;
+		case SG_DXFER_TO_DEV:
+			*rw = WRITE;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * map sg_io_hdr to a request. for scatter-gather sg_io_hdr, we map
+ * each segment to a bio and string multiple bio's to the request
+ */
+static struct request *
+bsg_map_hdr(request_queue_t *q, int rw, struct sg_io_hdr *hdr)
+{
+	struct sg_iovec iov;
+	struct sg_iovec __user *u_iov;
+	struct request *rq;
+	struct bio *bio;
+	int ret, i = 0;
+
+	dprintk("map hdr %p/%d/%d\n", hdr->dxferp, hdr->dxfer_len,
+					hdr->iovec_count);
+
+	ret = bsg_validate_sghdr(q, hdr, &rw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/*
+	 * map scatter-gather elements seperately and string them to request
+	 */
+	rq = blk_get_request(q, rw, __GFP_WAIT);
+
+	if (!hdr->iovec_count) {
+		ret = blk_rq_map_user(q, rq, hdr->dxferp, hdr->dxfer_len);
+		if (ret)
+			goto out;
+	}
+
+	u_iov = hdr->dxferp;
+	for (ret = 0, i = 0; i < hdr->iovec_count; i++, u_iov++) {
+		int to_vm = rw == READ;
+		unsigned long uaddr;
+
+		if (copy_from_user(&iov, u_iov, sizeof(iov))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (!iov.iov_len || !iov.iov_base) {
+			ret = -EINVAL;
+			break;
+		}
+
+		uaddr = (unsigned long) iov.iov_base;
+		if (!(uaddr & queue_dma_alignment(q))
+		    && !(iov.iov_len & queue_dma_alignment(q)))
+			bio = bio_map_user(q, NULL, uaddr, iov.iov_len, to_vm);
+		else
+			bio = bio_copy_user(q, uaddr, iov.iov_len, to_vm);
+
+		if (IS_ERR(bio)) {
+			ret = PTR_ERR(bio);
+			bio = NULL;
+			break;
+		}
+
+		dprintk("bsg: adding segment %d\n", i);
+
+		if (rq->bio) {
+			/*
+			 * for most (all? don't know of any) queues we could
+			 * skip grabbing the queue lock here. only drivers with
+			 * funky private ->back_merge_fn() function could be
+			 * problematic.
+			 */
+			spin_lock_irq(q->queue_lock);
+			ret = q->back_merge_fn(q, rq, bio);
+			spin_unlock_irq(q->queue_lock);
+
+			rq->biotail->bi_next = bio;
+			rq->biotail = bio;
+
+			/*
+			 * break after adding bio, so we don't have to special
+			 * case the cleanup too much
+			 */
+			if (!ret) {
+				ret = -EINVAL;
+				break;
+			}
+
+			/*
+			 * merged ok, update state
+			 */
+			rq->nr_sectors += bio_sectors(bio);
+			rq->hard_nr_sectors = rq->nr_sectors;
+			rq->data_len += bio->bi_size;
+		} else {
+			/*
+			 * first bio, setup rq state
+			 */
+			blk_rq_bio_prep(q, rq, bio);
+		}
+		ret = 0;
+	}
+
+	/*
+	 * bugger, cleanup
+	 */
+	if (ret) {
+out:
+		dprintk("failed map at %d: %d\n", i, ret);
+		blk_unmap_sghdr_rq(rq, hdr);
+		rq = ERR_PTR(ret);
+	}
+
+	return rq;
+}
+
+/*
+ * async completion call-back from the block layer, when scsi/ide/whatever
+ * calls end_that_request_last() on a request
+ */
+static void bsg_rq_end_io(struct request *rq, int uptodate)
+{
+	struct bsg_command *bc = rq->end_io_data;
+	struct bsg_device *bd = bc->bd;
+	unsigned long flags;
+
+	dprintk("%s: finished rq %p bio %p, bc %p offset %ld stat %d\n",
+			bd->name, rq, bc, bc->bio, bc - bd->cmd_map, uptodate);
+
+	bc->hdr.duration = jiffies_to_msecs(jiffies - bc->hdr.duration);
+
+	spin_lock_irqsave(&bd->lock, flags);
+	list_del(&bc->list);
+	bsg_add_done_cmd(bd, bc);
+	spin_unlock_irqrestore(&bd->lock, flags);
+}
+
+/*
+ * do final setup of a 'bc' and submit the matching 'rq' to the block
+ * layer for io
+ */
+static void bsg_add_command(struct bsg_device *bd, request_queue_t *q,
+			    struct bsg_command *bc, struct request *rq)
+{
+	rq->sense = bc->sense;
+	rq->sense_len = 0;
+
+	rq->rq_disk = bd->disk;
+	rq->end_io_data = bc;
+	rq->end_io = bsg_rq_end_io;
+
+	/*
+	 * add bc command to busy queue and submit rq for io
+	 */
+	bc->rq = rq;
+	bc->bio = rq->bio;
+	bc->hdr.duration = jiffies;
+	spin_lock_irq(&bd->lock);
+	list_add_tail(&bc->list, &bd->busy_list);
+	spin_unlock_irq(&bd->lock);
+
+	dprintk("%s: queueing rq %p, bc %p\n", bd->name, rq, bc);
+
+	elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
+	generic_unplug_device(q);
+}
+
+static inline struct bsg_command *bsg_next_done_cmd(struct bsg_device *bd)
+{
+	struct bsg_command *bc = NULL;
+
+	spin_lock_irq(&bd->lock);
+	if (bd->done_cmds) {
+		bc = list_entry_bc(bd->done_list.next);
+		bsg_del_done_cmd(bd, bc);
+	}
+	spin_unlock_irq(&bd->lock);
+
+	return bc;
+}
+
+/*
+ * Get a finished command from the done list
+ */
+static struct bsg_command *__bsg_get_done_cmd(struct bsg_device *bd, int state)
+{
+	struct bsg_command *bc;
+	int ret;
+
+	do {
+		bc = bsg_next_done_cmd(bd);
+		if (bc)
+			break;
+
+		ret = bsg_io_schedule(bd, state);
+		if (ret) {
+			bc = ERR_PTR(ret);
+			break;
+		}
+	} while (1);
+
+	dprintk("%s: returning done %p\n", bd->name, bc);
+
+	return bc;
+}
+
+static struct bsg_command *
+bsg_get_done_cmd(struct bsg_device *bd, const struct iovec *iov)
+{
+	return __bsg_get_done_cmd(bd, TASK_INTERRUPTIBLE);
+}
+
+static struct bsg_command *
+bsg_get_done_cmd_nosignals(struct bsg_device *bd)
+{
+	return __bsg_get_done_cmd(bd, TASK_UNINTERRUPTIBLE);
+}
+
+static int bsg_complete_all_commands(struct bsg_device *bd)
+{
+	struct bsg_command *bc;
+	int ret, tret;
+
+	dprintk("%s: entered\n", bd->name);
+
+	set_bit(BSG_F_BLOCK, &bd->flags);
+
+	/*
+	 * wait for all commands to complete
+	 */
+	ret = 0;
+	do {
+		ret = bsg_io_schedule(bd, TASK_UNINTERRUPTIBLE);
+		/*
+		 * look for -ENODATA specifically -- we'll sometimes get
+		 * -ERESTARTSYS when we've taken a signal, but we can't
+		 * return until we're done freeing the queue, so ignore
+		 * it.  The signal will get handled when we're done freeing
+		 * the bsg_device.
+		 */
+	} while (ret != -ENODATA);
+
+	/*
+	 * discard done commands
+	 */
+	ret = 0;
+	do {
+		bc = bsg_get_done_cmd_nosignals(bd);
+
+		/*
+		 * we _must_ complete before restarting, because
+		 * bsg_release can't handle this failing.
+		 */
+		if (PTR_ERR(bc) == -ERESTARTSYS)
+			continue;
+		if (PTR_ERR(bc)) {
+			ret = PTR_ERR(bc);
+			break;
+		}
+
+		/*
+		 * If we get any other error, bd->queued_cmds is wrong.
+		 */
+		BUG_ON(IS_ERR(bc));
+
+		tret = blk_complete_sghdr_rq(bc->rq, &bc->hdr, bc->bio);
+		if (!ret)
+			ret = tret;
+
+		bsg_free_command(bc);
+	} while (1);
+
+	return ret;
+}
+
+typedef struct bsg_command *(*bsg_command_callback)(struct bsg_device *bd, const struct iovec *iov);
+
+static ssize_t
+__bsg_read(char __user *buf, size_t count, bsg_command_callback get_bc,
+	   struct bsg_device *bd, const struct iovec *iov, ssize_t *bytes_read)
+{
+	struct bsg_command *bc;
+	int nr_commands, ret;
+
+	if (count % sizeof(struct sg_io_hdr))
+		return -EINVAL;
+
+	ret = 0;
+	nr_commands = count / sizeof(struct sg_io_hdr);
+	while (nr_commands) {
+		bc = get_bc(bd, iov);
+		if (IS_ERR(bc)) {
+			ret = PTR_ERR(bc);
+			break;
+		}
+
+		/*
+		 * this is the only case where we need to copy data back
+		 * after completing the request. so do that here,
+		 * bsg_complete_work() cannot do that for us
+		 */
+		ret = blk_complete_sghdr_rq(bc->rq, &bc->hdr, bc->bio);
+	
+		if (copy_to_user(buf, (char *) &bc->hdr, sizeof(bc->hdr)))
+			ret = -EFAULT;
+
+		bsg_free_command(bc);
+
+		if (ret)
+			break;
+
+		buf += sizeof(struct sg_io_hdr);
+		*bytes_read += sizeof(struct sg_io_hdr);
+		nr_commands--;
+	}
+
+	return ret;
+}
+
+static inline void bsg_set_block(struct bsg_device *bd, struct file *file)
+{
+	if (file->f_flags & O_NONBLOCK)
+		clear_bit(BSG_F_BLOCK, &bd->flags);
+	else
+		set_bit(BSG_F_BLOCK, &bd->flags);
+}
+
+static inline void bsg_set_write_perm(struct bsg_device *bd, struct file *file)
+{
+	if (file->f_mode & FMODE_WRITE)
+		set_bit(BSG_F_WRITE_PERM, &bd->flags);
+	else
+		clear_bit(BSG_F_WRITE_PERM, &bd->flags);
+}
+
+#define err_block_err(ret)	\
+	((ret) && (ret) != -ENOSPC && (ret) != -ENODATA && (ret) != -EAGAIN)
+
+static ssize_t
+bsg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct bsg_device *bd = file->private_data;
+	int ret;
+	ssize_t bytes_read;
+
+	if (unlikely(!bd))
+		return -ENXIO;
+
+	dprintk("%s: read %lu bytes\n", bd->name, count);
+
+	bsg_set_block(bd, file);
+	bytes_read = 0;
+	ret = __bsg_read(buf, count, bsg_get_done_cmd,
+			bd, NULL, &bytes_read);
+	*ppos = bytes_read;
+
+	if (!bytes_read || (bytes_read && err_block_err(ret)))
+		bytes_read = ret;
+
+	return bytes_read;
+}
+
+static int
+bsg_readv_validate_iovec(struct bsg_command *bc, const struct iovec *iov)
+{
+	/*
+	 * Here we just check that we weren't given some random weird wacky
+	 * values.  The values must be the same as in the original sg_io_hdr.
+	 * We use -ENXIO to say the address is bad, so we can try the next
+	 * bsg_command instead of erroring immediately.
+	 */
+	dprintk("iov[0] = {%p, %Zu}, bc->uhdr = {%p, %Zu}\n",
+		iov[0].iov_base, iov[0].iov_len,
+		bc->uhdr, sizeof(struct sg_io_hdr));
+	if (iov[0].iov_base != bc->uhdr)
+		return -ENXIO;
+	if (iov[0].iov_len != sizeof(struct sg_io_hdr))
+		return -EINVAL;
+	dprintk("iov[1] = {%p, %lu}, bc->hdr.dxferp = {%p, %u}\n",
+		iov[1].iov_base, iov[1].iov_len,
+		bc->hdr.dxferp, bc->hdr.dxfer_len);
+	if (iov[1].iov_base != bc->hdr.dxferp)
+		return -EINVAL;
+	if (iov[1].iov_len != bc->hdr.dxfer_len)
+		return -EINVAL;
+	dprintk("iov[2] = {%p, %lu}, bc->hdr.sbp = {%p, %u}\n",
+		iov[2].iov_base, iov[2].iov_len,
+		bc->hdr.sbp, bc->hdr.sb_len_wr);
+	if (iov[2].iov_base != bc->hdr.sbp)
+		return -EINVAL;
+	if (iov[2].iov_len != bc->hdr.sb_len_wr)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct bsg_command *
+__get_cmd_by_hdr(struct bsg_device *bd, const struct iovec *iov)
+{
+	struct bsg_command *bc;
+	int ret;
+
+	spin_lock_irq(&bd->lock);
+
+	while (!bd->done_cmds && bd->queued_cmds) {
+		dprintk("done list is empty, but commands are queued\n");
+
+		spin_unlock_irq(&bd->lock);
+
+		ret = bsg_io_schedule(bd, TASK_INTERRUPTIBLE);
+		if (ret) {
+			bc = ERR_PTR(ret);
+			goto out;
+		}
+
+		spin_lock_irq(&bd->lock);
+	}
+
+	if (!bd->done_cmds) {
+		bc = ERR_PTR(-ENODATA);
+		goto unlock;
+	}
+
+	list_for_each_entry(bc, &bd->done_list, list) {
+		ret = bsg_readv_validate_iovec(bc, iov);
+		if (ret == -ENXIO)
+			continue;
+		if (ret) {
+			bc = ERR_PTR(ret);
+			break;
+		}
+		bsg_del_done_cmd(bd, bc);
+		break;
+	}
+unlock:
+	spin_unlock_irq(&bd->lock);
+out:
+	return bc;
+}
+
+static ssize_t
+bsg_readv(struct file *file, const struct iovec *iov, unsigned long nr_segs,
+	  loff_t *ppos)
+{
+	struct bsg_device *bd = file->private_data;
+	int ret = 0;
+	ssize_t bytes_read = 0;
+
+	if (unlikely(!bd))
+		return -ENXIO;
+
+	dprintk("%s: readv %lu regions\n", bd->name, nr_segs);
+
+	if (nr_segs != 3)
+		return -EINVAL;
+
+	bsg_set_block(bd, file);
+
+	ret = __bsg_read(iov->iov_base, iov->iov_len, __get_cmd_by_hdr, bd, iov,
+			 &bytes_read);
+	*ppos = bytes_read;
+
+	if (!bytes_read || (bytes_read && err_block_err(ret)))
+		bytes_read = ret;
+	
+	return bytes_read;
+}
+
+static ssize_t __bsg_write(struct bsg_device *bd, const char __user *buf,
+			   size_t count, ssize_t *bytes_read)
+{
+	struct bsg_command *bc;
+	struct request *rq;
+	int ret, nr_commands;
+
+	if (count % sizeof(struct sg_io_hdr))
+		return -EINVAL;
+
+	nr_commands = count / sizeof(struct sg_io_hdr);
+	rq = NULL;
+	bc = NULL;
+	ret = 0;
+	while (nr_commands) {
+		request_queue_t *q = bd->queue;
+		int rw = READ;
+
+		bc = bsg_get_command(bd);
+		if (!bc)
+			break;
+		if (IS_ERR(bc)) {
+			ret = PTR_ERR(bc);
+			bc = NULL;
+			break;
+		}
+
+		bc->uhdr = (struct sg_io_hdr __user *) buf;
+		if (copy_from_user(&bc->hdr, buf, sizeof(bc->hdr))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		/*
+		 * get a request, fill in the blanks, and add to request queue
+		 */
+		rq = bsg_map_hdr(q, rw, &bc->hdr);
+		if (IS_ERR(rq)) {
+			ret = PTR_ERR(rq);
+			rq = NULL;
+			break;
+		}
+
+		ret = blk_fill_sghdr_rq(q, rq, &bc->hdr, test_bit(BSG_F_WRITE_PERM, &bd->flags));
+		if (ret)
+			break;
+
+		bsg_add_command(bd, q, bc, rq);
+		bc = NULL;
+		rq = NULL;
+		nr_commands--;
+		buf += sizeof(struct sg_io_hdr);
+		*bytes_read += sizeof(struct sg_io_hdr);
+	}
+
+	if (rq)
+		blk_unmap_sghdr_rq(rq, &bc->hdr);
+	if (bc)
+		bsg_free_command(bc);
+	
+	return ret;
+}
+
+static ssize_t
+bsg_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct bsg_device *bd = file->private_data;
+	ssize_t bytes_read;
+	int ret;
+
+	if (unlikely(!bd))
+		return -ENXIO;
+
+	dprintk("%s: write %lu bytes\n", bd->name, count);
+
+	bsg_set_block(bd, file);
+	bsg_set_write_perm(bd, file);
+
+	bytes_read = 0;
+	ret = __bsg_write(bd, buf, count, &bytes_read);
+	*ppos = bytes_read;
+
+	/*
+	 * return bytes written on non-fatal errors
+	 */
+	if (!bytes_read || (bytes_read && err_block_err(ret)))
+		bytes_read = ret;
+
+	dprintk("%s: returning %lu\n", bd->name, bytes_read);
+	return bytes_read;
+}
+
+static int bsg_writev_validate_iovec(const struct iovec *iov)
+{
+	struct sg_io_hdr hdr;
+
+	dprintk("iov[0] = {%p, %Zu}, sizeof(struct sg_io_hdr) = %Zu\n",
+		iov[0].iov_base, iov[0].iov_len, sizeof(struct sg_io_hdr));
+	if (iov[0].iov_len != sizeof(struct sg_io_hdr))
+		return -EINVAL;
+
+	/*
+	 * I really don't like doing this copy twice, but I don't see a good
+	 * way around it...
+	 */
+	if (copy_from_user(&hdr, iov[0].iov_base, sizeof(struct sg_io_hdr)))
+		return -EFAULT;
+
+	dprintk("iov[1] = {%p, %lu}, hdr->cmdp = {%p, %u}\n",
+		iov[1].iov_base, iov[1].iov_len,
+		hdr.cmdp, hdr.cmd_len);
+	if (iov[1].iov_base != hdr.cmdp)
+		return -EINVAL;
+	if (iov[1].iov_len != hdr.cmd_len)
+		return -EINVAL;
+
+	dprintk("iov[2] = {%p, %lu}, hdr->dxferp = {%p, %u}\n",
+		iov[1].iov_base, iov[1].iov_len,
+		hdr.dxferp, hdr.dxfer_len);
+	if (iov[2].iov_base != hdr.dxferp)
+		return -EINVAL;
+	if (iov[2].iov_len != hdr.dxfer_len)
+		return -EINVAL;
+
+	return 0;
+}
+
+static ssize_t
+bsg_writev(struct file *file, const struct iovec *iov, unsigned long nr_segs,
+	   loff_t *ppos)
+{
+	struct bsg_device *bd = file->private_data;
+	int ret = 0;
+	size_t bytes_read;
+
+	if (unlikely(!bd))
+		return -ENXIO;
+
+	dprintk("%s: writev %lu regions\n", bd->name, nr_segs);
+
+	if (nr_segs != 3)
+		return -EINVAL;
+
+	bsg_set_block(bd, file);
+	bsg_set_write_perm(bd, file);
+
+	ret = bsg_writev_validate_iovec(iov);
+	if (ret)
+		return ret;
+
+	bytes_read = 0;
+	ret = __bsg_write(bd, iov->iov_base, iov->iov_len, &bytes_read);
+	*ppos = bytes_read;
+
+	if (!bytes_read || (bytes_read && err_block_err(ret)))
+		bytes_read = ret;
+
+	dprintk("%s: returning %lu\n", bd->name, bytes_read);
+	return bytes_read;
+}
+
+static void bsg_free_device(struct bsg_device *bd)
+{
+	if (bd->cmd_map)
+		free_pages((unsigned long) bd->cmd_map, BSG_CMDS_PAGE_ORDER);
+
+	kfree(bd->cmd_bitmap);
+	bd->cmd_bitmap = NULL;
+	bd->disk = NULL;
+	bd->queue = NULL;
+	bd->cmd_map = NULL;
+	kfree(bd);
+}
+
+static struct bsg_device *bsg_alloc_device(void)
+{
+	struct bsg_device *bd = kmalloc(sizeof(struct bsg_device), GFP_KERNEL);
+	struct bsg_command *cmd_map;
+	unsigned long *cmd_bitmap;
+	int bits;
+
+	if (unlikely(!bd))
+		return NULL;
+
+	memset(bd, 0, sizeof(struct bsg_device));
+	spin_lock_init(&bd->lock);
+
+	bd->max_queue = BSG_CMDS;
+
+	bits = (BSG_CMDS / BSG_CMDS_PER_LONG) + 1;
+	cmd_bitmap = kmalloc(bits * sizeof(unsigned long), GFP_KERNEL);
+	if (!cmd_bitmap)
+		goto out_free_bd;
+	bd->cmd_bitmap = cmd_bitmap;
+
+	cmd_map = (struct bsg_command *) __get_free_pages(GFP_KERNEL,
+							  BSG_CMDS_PAGE_ORDER);
+	if (!cmd_map)
+		goto out_free_bitmap;
+	bd->cmd_map = cmd_map;
+
+	memset(cmd_map, 0, BSG_CMDS_BYTES);
+	memset(cmd_bitmap, 0, bits * sizeof(unsigned long));
+	INIT_LIST_HEAD(&bd->busy_list);
+	INIT_LIST_HEAD(&bd->done_list);
+	INIT_HLIST_NODE(&bd->dev_list);
+	
+	init_waitqueue_head(&bd->wq_free);
+	init_waitqueue_head(&bd->wq_done);
+	return bd;
+
+out_free_bitmap:
+	kfree(cmd_bitmap);
+out_free_bd:
+	kfree(bd);
+	return NULL;
+}
+
+static int bsg_put_device(struct bsg_device *bd)
+{
+	int ret;
+
+	if (!atomic_dec_and_test(&bd->ref_count))
+		return 0;
+
+	mutex_lock(&bsg_mutex);
+
+	dprintk("%s: tearing down\n", bd->name);
+
+	/*
+	 * close can always block
+	 */
+	set_bit(BSG_F_BLOCK, &bd->flags);
+
+	/*
+	 * correct error detection baddies here again. it's the responsibility
+	 * of the app to properly reap commands before close() if it wants
+	 * fool-proof error detection
+	 */
+	ret = bsg_complete_all_commands(bd);
+
+	blk_cleanup_queue(bd->queue);
+	hlist_del(&bd->dev_list);
+	bsg_free_device(bd);
+	mutex_unlock(&bsg_mutex);
+	return ret;
+}
+
+static struct bsg_device *bsg_add_device(struct inode *inode,
+					 struct gendisk *disk,
+					 struct file *file)
+{
+	struct bsg_device *bd = NULL;
+#ifdef BSG_DEBUG
+	unsigned char buf[32];
+#endif
+	int ret;
+
+	mutex_lock(&bsg_mutex);
+
+	ret = -ENOMEM;
+	bd = bsg_alloc_device();
+	if (!bd)
+		goto out;
+
+	bd->disk = disk;
+	bd->queue = disk->queue;
+	atomic_inc(&disk->queue->refcnt);
+	bsg_set_block(bd, file);
+
+	atomic_set(&bd->ref_count, 1);
+	bd->minor = iminor(inode);
+	hlist_add_head(&bd->dev_list,&bsg_device_list[bsg_list_idx(bd->minor)]);
+
+	strncpy(bd->name, disk->disk_name, sizeof(bd->name));
+	dprintk("bound to <%s>, max queue %d\n",
+		format_dev_t(buf, i->i_rdev), bd->max_queue);
+
+	mutex_unlock(&bsg_mutex);
+	return bd;
+out:
+	if (bd)
+		bsg_free_device(bd);
+	mutex_unlock(&bsg_mutex);
+	return ERR_PTR(ret);
+}
+
+static struct bsg_device *__bsg_get_device(int minor)
+{
+	struct hlist_head *list = &bsg_device_list[bsg_list_idx(minor)];
+	struct bsg_device *bd = NULL;
+	struct hlist_node *entry;
+
+	mutex_lock(&bsg_mutex);
+
+	hlist_for_each(entry, list) {
+		bd = hlist_entry(entry, struct bsg_device, dev_list);
+		if (bd->minor == minor) {
+			atomic_inc(&bd->ref_count);
+			break;
+		}
+
+		bd = NULL;
+	}
+
+	mutex_unlock(&bsg_mutex);
+	return bd;
+}
+
+static struct bsg_device *bsg_get_device(struct inode *inode, struct file *file)
+{
+	struct bsg_device *bd = __bsg_get_device(iminor(inode));
+	struct bsg_class_device *bcd, *__bcd;
+
+	if (bd)
+		return bd;
+
+	/*
+	 * find the class device
+	 */
+	bcd = NULL;
+	mutex_lock(&bsg_mutex);
+	list_for_each_entry(__bcd, &bsg_class_list, list) {
+		if (__bcd->minor == iminor(inode)) {
+			bcd = __bcd;
+			break;
+		}
+	}
+	mutex_unlock(&bsg_mutex);
+
+	if (!bcd)
+		return ERR_PTR(-ENODEV);
+
+	return bsg_add_device(inode, bcd->disk, file);
+}
+
+static int bsg_open(struct inode *inode, struct file *file)
+{
+	struct bsg_device *bd = bsg_get_device(inode, file);
+
+	if (IS_ERR(bd))
+		return PTR_ERR(bd);
+
+	file->private_data = bd;
+	return 0;
+}
+
+static int bsg_release(struct inode *inode, struct file *file)
+{
+	struct bsg_device *bd = file->private_data;
+
+	if (unlikely(!bd))
+		return -ENXIO;
+
+	file->private_data = NULL;
+	return bsg_put_device(bd);
+}
+
+static unsigned int bsg_poll(struct file *file, poll_table *wait)
+{
+	struct bsg_device *bd = file->private_data;
+	unsigned int mask = 0;
+
+	if (unlikely(!bd))
+		return -ENXIO;
+
+	poll_wait(file, &bd->wq_done, wait);
+	poll_wait(file, &bd->wq_free, wait);
+
+	spin_lock_irq(&bd->lock);
+	if (!list_empty(&bd->done_list))
+		mask |= POLLIN | POLLRDNORM;
+	if (bd->queued_cmds >= bd->max_queue)
+		mask |= POLLOUT;
+	spin_unlock_irq(&bd->lock);
+
+	return mask;
+}
+
+static int
+bsg_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	  unsigned long arg)
+{
+	struct bsg_device *bd = file->private_data;
+	int __user *uarg = (int __user *) arg;
+
+	if (!bd)
+		return -ENXIO;
+
+	switch (cmd) {
+		/*
+		 * our own ioctls
+		 */
+		case SG_GET_COMMAND_Q:
+			return put_user(bd->max_queue, uarg);
+		case SG_SET_COMMAND_Q: {
+			int queue;
+
+			if (get_user(queue, uarg))
+				return -EFAULT;
+			if (queue > BSG_CMDS || queue < 1)
+				return -EINVAL;
+
+			bd->max_queue = queue;
+			return 0;
+		}
+
+		/*
+		 * SCSI/sg ioctls
+		 */
+		case SG_GET_VERSION_NUM:
+		case SCSI_IOCTL_GET_IDLUN:
+		case SCSI_IOCTL_GET_BUS_NUMBER:
+		case SG_SET_TIMEOUT:
+		case SG_GET_TIMEOUT:
+		case SG_GET_RESERVED_SIZE:
+		case SG_SET_RESERVED_SIZE:
+		case SG_EMULATED_HOST:
+		case SG_IO:
+		case SCSI_IOCTL_SEND_COMMAND: {
+			void __user *uarg = (void __user *) arg;
+			return scsi_cmd_ioctl(file, bd->disk, cmd, uarg);
+		}
+		/*
+		 * block device ioctls
+		 */
+		default:
+#if 0
+			return ioctl_by_bdev(bd->bdev, cmd, arg);
+#else
+			return -ENOTTY;
+#endif
+	}
+}
+
+static struct file_operations bsg_fops = {
+	.read		=	bsg_read,
+	.write		=	bsg_write,
+	.poll		=	bsg_poll,
+	.open		=	bsg_open,
+	.release	=	bsg_release,
+	.ioctl		=	bsg_ioctl,
+	.readv		=	bsg_readv,
+	.writev		=	bsg_writev,
+	.owner		=	THIS_MODULE,
+};
+
+void bsg_unregister_disk(struct gendisk *disk)
+{
+	struct bsg_class_device *bcd = &disk->bsg_dev;
+
+	if (!bcd->class_dev)
+		return;
+
+	mutex_lock(&bsg_mutex);
+	sysfs_remove_link(&bcd->disk->queue->kobj, "bsg");
+	class_device_destroy(bsg_class, MKDEV(BSG_MAJOR, bcd->minor));
+	bcd->class_dev = NULL;
+	list_del_init(&bcd->list);
+	mutex_unlock(&bsg_mutex);
+}
+
+int bsg_register_disk(struct gendisk *disk)
+{
+	request_queue_t *q = disk->queue;
+	struct bsg_class_device *bcd;
+	dev_t dev;
+
+	/*
+	 * we need a proper transport to send commands, not a stacked device
+	 */
+	if (!q->request_fn)
+		return 0;
+
+	bcd = &disk->bsg_dev;
+	memset(bcd, 0, sizeof(*bcd));
+	INIT_LIST_HEAD(&bcd->list);
+
+	mutex_lock(&bsg_mutex);
+	dev = MKDEV(BSG_MAJOR, bsg_device_nr);
+	bcd->minor = bsg_device_nr;
+	bsg_device_nr++;
+	bcd->disk = disk;
+	bcd->class_dev = class_device_create(bsg_class, NULL, dev, bcd->dev, "%s", disk->disk_name);
+	list_add_tail(&bcd->list, &bsg_class_list);
+	sysfs_create_link(&q->kobj, &bcd->class_dev->kobj, "bsg");
+	mutex_unlock(&bsg_mutex);
+	return 0;
+}
+
+static int __init bsg_init(void)
+{
+	int ret, i;
+
+	for (i = 0; i < BSG_LIST_SIZE; i++)
+		INIT_HLIST_HEAD(&bsg_device_list[i]);
+
+	bsg_class = class_create(THIS_MODULE, "bsg");
+	if (IS_ERR(bsg_class))
+		return PTR_ERR(bsg_class);
+
+	ret = register_chrdev(BSG_MAJOR, "bsg", &bsg_fops);
+	if (ret) {
+		class_destroy(bsg_class);
+		return ret;
+	}
+
+	printk(KERN_INFO "%s loaded\n", bsg_version);
+	return 0;
+}
+
+MODULE_AUTHOR("Jens Axboe");
+MODULE_DESCRIPTION("Block layer SGSI generic (sg) driver");
+MODULE_LICENSE("GPL");
+
+subsys_initcall(bsg_init);
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 03d9c82..8ff5bbd 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -3812,6 +3812,13 @@ int blk_register_queue(struct gendisk *d
 		return ret;
 	}
 
+	ret = bsg_register_disk(disk);
+	if (ret) {
+		elv_unregister_queue(q);
+		kobject_unregister(&q->kobj);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -3820,6 +3827,7 @@ void blk_unregister_queue(struct gendisk
 	request_queue_t *q = disk->queue;
 
 	if (q && q->request_fn) {
+		bsg_unregister_disk(disk);
 		elv_unregister_queue(q);
 
 		kobject_unregister(&q->kobj);
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 24f7af9..cd6566c 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -41,8 +41,6 @@ const unsigned char scsi_command_size[8]
 
 EXPORT_SYMBOL(scsi_command_size);
 
-#define BLK_DEFAULT_TIMEOUT	(60 * HZ)
-
 #include <scsi/sg.h>
 
 static int sg_get_version(int __user *p)
@@ -112,7 +110,7 @@ static int sg_emulated_host(request_queu
 #define safe_for_read(cmd)	[cmd] = CMD_READ_SAFE
 #define safe_for_write(cmd)	[cmd] = CMD_WRITE_SAFE
 
-static int verify_command(struct file *file, unsigned char *cmd)
+static int verify_command(unsigned char *cmd, int has_write_perm)
 {
 	static unsigned char cmd_type[256] = {
 
@@ -191,18 +189,11 @@ static int verify_command(struct file *f
 		safe_for_write(GPCMD_SET_STREAMING),
 	};
 	unsigned char type = cmd_type[cmd[0]];
-	int has_write_perm = 0;
 
 	/* Anybody who can open the device can do a read-safe command */
 	if (type & CMD_READ_SAFE)
 		return 0;
 
-	/*
-	 * file can be NULL from ioctl_by_bdev()...
-	 */
-	if (file)
-		has_write_perm = file->f_mode & FMODE_WRITE;
-
 	/* Write-safe commands just require a writable open.. */
 	if ((type & CMD_WRITE_SAFE) && has_write_perm)
 		return 0;
@@ -220,24 +211,103 @@ static int verify_command(struct file *f
 	return -EPERM;
 }
 
+int blk_fill_sghdr_rq(request_queue_t *q, struct request *rq,
+		      struct sg_io_hdr *hdr, int has_write_perm)
+{
+	if (copy_from_user(rq->cmd, hdr->cmdp, hdr->cmd_len))
+		return -EFAULT;
+	if (verify_command(rq->cmd, has_write_perm))
+		return -EPERM;
+
+	/*
+	 * fill in request structure
+	 */
+	rq->cmd_len = hdr->cmd_len;
+	if (sizeof(rq->cmd) != hdr->cmd_len) {
+		unsigned end = sizeof(rq->cmd) - hdr->cmd_len;
+		memset(rq->cmd + hdr->cmd_len, 0, end);
+	}
+
+	rq->flags |= REQ_BLOCK_PC;
+
+	rq->timeout = (hdr->timeout * HZ) / 1000;
+	if (!rq->timeout)
+		rq->timeout = q->sg_timeout;
+	if (!rq->timeout)
+		rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
+
+	return 0;
+}
+EXPORT_SYMBOL(blk_fill_sghdr_rq);
+
+/*
+ * unmap a request that was previously mapped to this sg_io_hdr. handles
+ * both sg and non-sg sg_io_hdr.
+ */
+int blk_unmap_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr)
+{
+	struct bio *bio = rq->bio;
+
+	/*
+	 * also releases request
+	 */
+	if (!hdr->iovec_count)
+		return blk_rq_unmap_user(bio, hdr->dxfer_len);
+
+	while ((bio = rq->bio)) {
+		rq->bio = bio->bi_next;
+		bio->bi_next = NULL;
+
+		bio_unmap_user(bio);
+	}
+
+	blk_put_request(rq);
+	return 0;
+}
+EXPORT_SYMBOL(blk_unmap_sghdr_rq);
+
+int blk_complete_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr,
+			  struct bio *bio)
+{
+	/*
+	 * fill in all the output members
+	 */
+	hdr->status = rq->errors & 0xff;
+	hdr->masked_status = status_byte(rq->errors);
+	hdr->msg_status = msg_byte(rq->errors);
+	hdr->host_status = host_byte(rq->errors);
+	hdr->driver_status = driver_byte(rq->errors);
+	hdr->info = 0;
+	if (hdr->masked_status || hdr->host_status || hdr->driver_status)
+		hdr->info |= SG_INFO_CHECK;
+	hdr->resid = rq->data_len;
+	hdr->sb_len_wr = 0;
+
+	if (rq->sense_len && hdr->sbp) {
+		int len = min((unsigned int) hdr->mx_sb_len, rq->sense_len);
+
+		if (!copy_to_user(hdr->sbp, rq->sense, len))
+			hdr->sb_len_wr = len;
+	}
+
+	rq->bio = bio;
+	return blk_unmap_sghdr_rq(rq, hdr);
+}
+EXPORT_SYMBOL(blk_complete_sghdr_rq);
+
 static int sg_io(struct file *file, request_queue_t *q,
 		struct gendisk *bd_disk, struct sg_io_hdr *hdr)
 {
 	unsigned long start_time;
-	int writing = 0, ret = 0;
+	int writing = 0, ret = 0, has_write_perm = 0;
 	struct request *rq;
 	struct bio *bio;
 	char sense[SCSI_SENSE_BUFFERSIZE];
-	unsigned char cmd[BLK_MAX_CDB];
 
 	if (hdr->interface_id != 'S')
 		return -EINVAL;
 	if (hdr->cmd_len > BLK_MAX_CDB)
 		return -EINVAL;
-	if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
-		return -EFAULT;
-	if (verify_command(file, cmd))
-		return -EPERM;
 
 	if (hdr->dxfer_len > (q->max_hw_sectors << 9))
 		return -EIO;
@@ -282,33 +352,20 @@ static int sg_io(struct file *file, requ
 	if (ret)
 		goto out;
 
-	/*
-	 * fill in request structure
-	 */
-	rq->cmd_len = hdr->cmd_len;
-	memcpy(rq->cmd, cmd, hdr->cmd_len);
-	if (sizeof(rq->cmd) != hdr->cmd_len)
-		memset(rq->cmd + hdr->cmd_len, 0, sizeof(rq->cmd) - hdr->cmd_len);
-
-	memset(sense, 0, sizeof(sense));
-	rq->sense = sense;
-	rq->sense_len = 0;
+	if (file)
+		has_write_perm = file->f_mode & FMODE_WRITE;
 
-	rq->flags |= REQ_BLOCK_PC;
 	bio = rq->bio;
 
-	/*
-	 * bounce this after holding a reference to the original bio, it's
-	 * needed for proper unmapping
-	 */
-	if (rq->bio)
-		blk_queue_bounce(q, &rq->bio);
+	if (blk_fill_sghdr_rq(q, rq, hdr, has_write_perm)) {
+		blk_rq_unmap_user(bio, hdr->dxfer_len);
+		blk_put_request(rq);
+		return -EFAULT;
+	}
 
-	rq->timeout = (hdr->timeout * HZ) / 1000;
-	if (!rq->timeout)
-		rq->timeout = q->sg_timeout;
-	if (!rq->timeout)
-		rq->timeout = BLK_DEFAULT_TIMEOUT;
+	memset(sense, 0, sizeof(sense));
+	rq->sense = sense;
+	rq->sense_len = 0;
 
 	rq->retries = 0;
 
@@ -320,31 +377,9 @@ static int sg_io(struct file *file, requ
 	 */
 	blk_execute_rq(q, bd_disk, rq, 0);
 
-	/* write to all output members */
-	hdr->status = 0xff & rq->errors;
-	hdr->masked_status = status_byte(rq->errors);
-	hdr->msg_status = msg_byte(rq->errors);
-	hdr->host_status = host_byte(rq->errors);
-	hdr->driver_status = driver_byte(rq->errors);
-	hdr->info = 0;
-	if (hdr->masked_status || hdr->host_status || hdr->driver_status)
-		hdr->info |= SG_INFO_CHECK;
-	hdr->resid = rq->data_len;
 	hdr->duration = ((jiffies - start_time) * 1000) / HZ;
-	hdr->sb_len_wr = 0;
-
-	if (rq->sense_len && hdr->sbp) {
-		int len = min((unsigned int) hdr->mx_sb_len, rq->sense_len);
-
-		if (!copy_to_user(hdr->sbp, rq->sense, len))
-			hdr->sb_len_wr = len;
-	}
-
-	if (blk_rq_unmap_user(bio, hdr->dxfer_len))
-		ret = -EFAULT;
 
-	/* may not have succeeded, but output values written to control
-	 * structure (struct sg_io_hdr).  */
+	return blk_complete_sghdr_rq(rq, hdr, bio);
 out:
 	blk_put_request(rq);
 	return ret;
@@ -396,7 +431,7 @@ static int sg_scsi_ioctl(struct file *fi
 	if (copy_from_user(buffer, sic->data + cmdlen, in_len))
 		goto error;
 
-	err = verify_command(file, rq->cmd);
+	err = verify_command(rq->cmd, file->f_mode & FMODE_WRITE);
 	if (err)
 		goto error;
 
@@ -418,7 +453,7 @@ static int sg_scsi_ioctl(struct file *fi
 			rq->timeout = READ_DEFECT_DATA_TIMEOUT;
 			break;
 		default:
-			rq->timeout = BLK_DEFAULT_TIMEOUT;
+			rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
 			break;
 	}
 
@@ -462,7 +497,7 @@ static int __blk_send_generic(request_qu
 	rq->flags |= REQ_BLOCK_PC;
 	rq->data = NULL;
 	rq->data_len = 0;
-	rq->timeout = BLK_DEFAULT_TIMEOUT;
+	rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 	rq->cmd[0] = cmd;
 	rq->cmd[4] = data;
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 1f8db9a..e398cfd 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1261,19 +1261,25 @@ static void idefloppy_create_rw_cmd (ide
 	set_bit(PC_DMA_RECOMMENDED, &pc->flags);
 }
 
-static int
+static void
 idefloppy_blockpc_cmd(idefloppy_floppy_t *floppy, idefloppy_pc_t *pc, struct request *rq)
 {
-	/*
-	 * just support eject for now, it would not be hard to make the
-	 * REQ_BLOCK_PC support fully-featured
-	 */
-	if (rq->cmd[0] != IDEFLOPPY_START_STOP_CMD)
-		return 1;
-
 	idefloppy_init_pc(pc);
+	pc->callback = &idefloppy_rw_callback;
 	memcpy(pc->c, rq->cmd, sizeof(pc->c));
-	return 0;
+	pc->rq = rq;
+	pc->b_count = rq->data_len;
+	if (rq->data_len && rq_data_dir(rq) == WRITE)
+		set_bit(PC_WRITING, &pc->flags);
+	pc->buffer = rq->data;
+	if (rq->bio)
+		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
+		
+	/*
+	 * possibly problematic, doesn't look like ide-floppy correctly
+	 * handled scattered requests if dma fails...
+	 */
+	pc->request_transfer = pc->buffer_size = rq->data_len;
 }
 
 /*
@@ -1321,10 +1327,7 @@ static ide_startstop_t idefloppy_do_requ
 		pc = (idefloppy_pc_t *) rq->buffer;
 	} else if (rq->flags & REQ_BLOCK_PC) {
 		pc = idefloppy_next_pc_storage(drive);
-		if (idefloppy_blockpc_cmd(floppy, pc, rq)) {
-			idefloppy_do_end_request(drive, 0, 0);
-			return ide_stopped;
-		}
+		idefloppy_blockpc_cmd(floppy, pc, rq);
 	} else {
 		blk_dump_rq_flags(rq,
 			"ide-floppy: unsupported command in queue");
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index b2cc437..0b9575b 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1256,8 +1256,12 @@ int generic_ide_ioctl(ide_drive_t *drive
 {
 	ide_settings_t *setting;
 	ide_driver_t *drv;
-	int err = 0;
 	void __user *p = (void __user *)arg;
+	int err;
+
+	err = scsi_cmd_ioctl(file, bdev->bd_disk, cmd, p);
+	if (err != -ENOTTY)
+		return err;
 
 	down(&ide_setting_sem);
 	if ((setting = ide_find_setting_by_ioctl(drive, cmd)) != NULL) {
@@ -1379,10 +1383,6 @@ int generic_ide_ioctl(ide_drive_t *drive
 			return 0;
 		}
 
-		case CDROMEJECT:
-		case CDROMCLOSETRAY:
-			return scsi_cmd_ioctl(file, bdev->bd_disk, cmd, p);
-
 		case HDIO_GET_BUSSTATE:
 			if (!capable(CAP_SYS_ADMIN))
 				return -EACCES;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 860e7a4..ad47cc4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -22,6 +22,8 @@ typedef struct request_queue request_que
 struct elevator_queue;
 typedef struct elevator_queue elevator_t;
 struct request_pm_state;
+struct request;
+struct sg_io_hdr;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
@@ -566,6 +568,11 @@ extern unsigned long blk_max_low_pfn, bl
 #define BLK_BOUNCE_ANY		((u64)blk_max_pfn << PAGE_SHIFT)
 #define BLK_BOUNCE_ISA		(ISA_DMA_THRESHOLD)
 
+/*
+ * default timeout for SG_IO if none specified
+ */
+#define BLK_DEFAULT_SG_TIMEOUT	(60 * HZ)
+
 #ifdef CONFIG_MMU
 extern int init_emergency_isa_pool(void);
 extern void blk_queue_bounce(request_queue_t *q, struct bio **bio);
@@ -616,6 +623,11 @@ extern int blk_execute_rq(request_queue_
 			  struct request *, int);
 extern void blk_execute_rq_nowait(request_queue_t *, struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
+extern int blk_fill_sghdr_rq(request_queue_t *, struct request *,
+		      struct sg_io_hdr *, int);
+extern int blk_unmap_sghdr_rq(struct request *, struct sg_io_hdr *);
+extern int blk_complete_sghdr_rq(struct request *, struct sg_io_hdr *,
+			  struct bio *);
 
 static inline request_queue_t *bdev_get_queue(struct block_device *bdev)
 {
diff --git a/include/linux/bsg.h b/include/linux/bsg.h
new file mode 100644
index 0000000..dc0d728
--- /dev/null
+++ b/include/linux/bsg.h
@@ -0,0 +1,21 @@
+#ifndef BSG_H
+#define BSG_H
+
+#if defined(CONFIG_BLK_DEV_BSG)
+struct bsg_class_device {
+	struct class_device *class_dev;
+	struct device *dev;
+	int minor;
+	struct gendisk *disk;
+	struct list_head list;
+};
+
+extern int bsg_register_disk(struct gendisk *);
+extern void bsg_unregister_disk(struct gendisk *);
+#else
+struct bsg_class_device { };
+#define bsg_register_disk(disk)		(0)
+#define bsg_unregister_disk(disk)	do { } while (0)
+#endif
+
+#endif
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index eef5ccd..ea9eda9 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 #include <linux/string.h>
 #include <linux/fs.h>
+#include <linux/bsg.h>
 
 enum {
 /* These three have identical behaviour; use the second one if DOS FDISK gets
@@ -126,6 +127,7 @@ struct gendisk {
 #else
 	struct disk_stats dkstats;
 #endif
+	struct bsg_class_device bsg_dev;
 };
 
 /* Structure for sysfs attributes on block devices */
-- 
1.2.3.g2cf3


-- 
Jens Axboe

