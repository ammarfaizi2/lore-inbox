Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265871AbUGDXun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbUGDXun (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 19:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbUGDXun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 19:50:43 -0400
Received: from av5-1-sn3.vrr.skanova.net ([81.228.9.113]:61344 "EHLO
	av5-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S265871AbUGDXuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 19:50:01 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
References: <m2lli36ec9.fsf@telia.com> <20040704130544.GA3825@infradead.org>
From: Peter Osterlund <petero2@telia.com>
Date: 05 Jul 2004 01:49:43 +0200
In-Reply-To: <20040704130544.GA3825@infradead.org>
Message-ID: <m2llhz5o4o.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks a lot for reviewing the patch.

Christoph Hellwig <hch@infradead.org> writes:

> > + * - Generic interface for UDF to submit large packets for variable length
> > + *   packet writing
> 
> Huh, what's bad about bios?

Nothing, that comment is a leftover from before bios existed. Fixed.

> > +#include <linux/buffer_head.h>
> 
> Where do you need buffer_head.h?

For fsync_bdev(), which you say is not needed anyway. Also for the
invalidate_bdev() call in pkt_remove_dev(). The loop driver is also
calling invalidate_bdev() in its loop_clr_fd() function, so I guess
that call is needed.

> > +#define SCSI_IOCTL_SEND_COMMAND	1
> 
> Please include scsi_ioctl.h instead of duplicating it.

Done.

> > +static struct gendisk *disks[MAX_WRITERS];
> 
> Please add a pointer to the gendisk to struct pktcdvd_device instead
> of a global array

Done.

> > +
> > +static struct pktcdvd_device *pkt_find_dev(request_queue_t *q)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < MAX_WRITERS; i++)
> > +		if (pkt_devs[i].bdev && bdev_get_queue(pkt_devs[i].bdev) == q)
> > +			return &pkt_devs[i];
> > +
> > +	return NULL;
> > +}
> 
> Please just store the pktcdvd_device * in q->queuedata.

I don't think that's possible, because q is the queue for the device
this device is attached to, and the driver for that device might use
queuedata for something else.

> > +	sprintf(current->comm, pd->name);
> 
> not needed, saemonize does it for you.

Fixed.

> > +static int pkt_get_minor(struct pktcdvd_device *pd)
> > +{
> > +	int minor;
> > +	for (minor = 0; minor < MAX_WRITERS; minor++)
> > +		if (pd == &pkt_devs[minor])
> > +			break;
> > +	BUG_ON(minor == MAX_WRITERS);
> > +	return minor;
> > +}
> 
> Shouldn't be needed at all.

Removed.

> > +	pd->cdrw.elv_merge_fn = q->elevator.elevator_merge_fn;
> > +	pd->cdrw.elv_completed_req_fn = q->elevator.elevator_completed_req_fn;
> > +	pd->cdrw.merge_requests_fn = q->merge_requests_fn;
> > +	q->elevator.elevator_merge_fn = pkt_lowlevel_elv_merge_fn;
> > +	q->elevator.elevator_completed_req_fn = pkt_lowlevel_elv_completed_req_fn;
> 
> This looks really really fishy.  Playing with other drivers' elevator settings
> can't be safe.  I'd say wait for the runtime selectable I/O scheduler that's
> planned for a while and add a special packetwriting scheduler that you switch
> to.

OK, I'll wait. ;)

> > +/*
> > + * called when the device is closed. makes sure that the device flushes
> > + * the internal cache before we close.
> > + */
> > +static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
> > +{
> > +	struct block_device *bdev;
> > +
> > +	atomic_dec(&pd->refcnt);
> > +	if (atomic_read(&pd->refcnt) > 0)
> > +		return;
> > +
> > +	bdev = bdget(pd->pkt_dev);
> > +	if (bdev) {
> 
> You reallu should keep a reference to the underlying bdev as long as you use
> it, aka bdev_get + blkdev_get in ->open, blkdev_put in ->release

I'll work on this tomorrow.

> > +		fsync_bdev(bdev);
> 
> fs/block_dev.c already does a sync_blockdev() on last close, that should
> be enough.

OK, removed.

> > +static int pkt_proc_device(struct pktcdvd_device *pd, char *buf)
> > +{
> 
> seq_file interface please, or even better a one value per file sysfs
> interface.

I'll work on this tomorrow too.

> > +	pd->cdrw.pid = kernel_thread(kcdrwd, pd, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
> 
> please use the kernel/ktread.c infastructure.

Fixed.

> > +static int pkt_setup_dev(struct pktcdvd_device *pd, unsigned int arg)
> > +{
> > +	struct inode *inode;
> > +	struct file *file;
> > +	int ret;
> > +
> > +	if ((file = fget(arg)) == NULL) {
> > +		printk("pktcdvd: bad file descriptor passed\n");
> > +		return -EBADF;
> > +	}
> > +
> > +	ret = -EINVAL;
> > +	if ((inode = file->f_dentry->d_inode) == NULL) {
> > +		printk("pktcdvd: huh? file descriptor contains no inode?\n");
> > +		goto out;
> > +	}
> 
> If fget is successfull file->f_dentry->d_inode can't be NULL.

Fixed.

> > +	case BLKROSET:
> > +		if (capable(CAP_SYS_ADMIN))
> > +			clear_bit(PACKET_WRITABLE, &pd->flags);
> > +	case BLKROGET:
> > +	case BLKSSZGET:
> > +	case BLKFLSBUF:
> > +		if (!pd->bdev)
> > +			return -ENXIO;
> > +		return -EINVAL;		    /* Handled by blkdev layer */
> > +
> 
> These aren't handled by drivers anyore in 2.6

OK, removed.

> > +	for (i = 0; i < MAX_WRITERS; i++) {
> > +		disks[i] = alloc_disk(1);
> > +		if (!disks[i])
> > +			goto out_mem2;
> > +	}
> > +
> > +	for (i = 0; i < MAX_WRITERS; i++) {
> > +		struct pktcdvd_device *pd = &pkt_devs[i];
> > +		struct gendisk *disk = disks[i];
> > +		disk->major = PACKET_MAJOR;
> > +		disk->first_minor = i;
> > +		disk->fops = &pktcdvd_ops;
> > +		disk->flags = GENHD_FL_REMOVABLE;
> > +		sprintf(disk->disk_name, "pktcdvd%d", i);
> > +		sprintf(disk->devfs_name, "pktcdvd/%d", i);
> > +		disk->private_data = pd;
> > +		disk->queue = blk_alloc_queue(GFP_KERNEL);
> > +		if (!disk->queue)
> > +			goto out_mem3;
> > +		add_disk(disk);
> > +	}
> 
> Please allocate all these on demand only when you actually attach
> a device.

But I need to open the device to be able to perform the ioctl to
attach a device, and I can't open the device until add_disk() has been
called. The loop device does the same thing.

> All in all I really wonder whether a separate driver is really that
> a good fit for the functionality or whether it should be more
> integrated with the block layer, ala drivers/block/scsi_ioctl.c

Jens is probably better suited than me to comment on that.


Here is an incremental patch that goes on top all patches I've posted
previously.

---------------

Various cleanups in the pktcdvd driver suggested by Christoph Hellwig.

- Removed obsolete comment.
- Don't redefine SCSI_IOCTL_SEND_COMMAND locally, use the proper
  #include instead.
- Removed the disks[] gendisk* array and added a gendisk pointer to
  struct pktcdvd_device instead.
- No need to set current->comm in kcdrwd, since daemonize does that by
  itself.
- No need to call fsync_bdev() in pkt_release_dev(), because it is
  handled by fs/block_dev.c.
- After a successful fget(), file->f_dentry->d_inode can't be NULL, so
  kill the useless check.
- The BLKROSET, BLKROGET, BLKSSZGET and BLKFLSBUF ioctls aren't
  handled by drivers any more in 2.6.
- Removed no longer needed function pkt_get_minor().
- Use the kernel/kthread.c infrastructure in the pktcdvd driver.


Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/drivers/block/pktcdvd.c |  117 ++++++++---------------------------
 linux-petero/include/linux/pktcdvd.h |    5 -
 2 files changed, 31 insertions(+), 91 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-cleanup drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-cleanup	2004-07-05 01:38:40.535610008 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-07-05 01:39:06.680635360 +0200
@@ -12,8 +12,6 @@
  * TODO: (circa order of when I will fix it)
  * - Only able to write on CD-RW media right now.
  * - check host application code on media and set it in write page
- * - Generic interface for UDF to submit large packets for variable length
- *   packet writing
  * - interface for UDF <-> packet to negotiate a new location when a write
  *   fails.
  * - handle OPC, especially for -RW media
@@ -40,24 +38,23 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/kthread.h>
 #include <linux/errno.h>
 #include <linux/spinlock.h>
 #include <linux/file.h>
 #include <linux/proc_fs.h>
-#include <linux/buffer_head.h>
+#include <linux/buffer_head.h>		/* for invalidate_bdev() */
 #include <linux/devfs_fs_kernel.h>
 #include <linux/suspend.h>
 #include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_ioctl.h>
 
 #include <asm/uaccess.h>
 
-#define SCSI_IOCTL_SEND_COMMAND	1
-
 #define ZONE(sector, pd) (((sector) + (pd)->offset) & ~((pd)->settings.size - 1))
 
 static struct pktcdvd_device *pkt_devs;
 static struct proc_dir_entry *pkt_proc;
-static struct gendisk *disks[MAX_WRITERS];
 
 static struct pktcdvd_device *pkt_find_dev(request_queue_t *q)
 {
@@ -1170,19 +1167,7 @@ static int kcdrwd(void *foobar)
 	struct packet_data *pkt;
 	long min_sleep_time, residue;
 
-	/*
-	 * exit_files, mm (move to lazy-tlb, so context switches are come
-	 * extremely cheap) etc
-	 */
-	daemonize(pd->name);
-
 	set_user_nice(current, -20);
-	sprintf(current->comm, pd->name);
-
-	siginitsetinv(&current->blocked, sigmask(SIGKILL));
-	flush_signals(current);
-
-	up(&pd->cdrw.thr_sem);
 
 	for (;;) {
 		DECLARE_WAITQUEUE(wait, current);
@@ -1250,14 +1235,14 @@ static int kcdrwd(void *foobar)
 			if (signal_pending(current)) {
 				flush_signals(current);
 			}
-			if (pd->cdrw.time_to_die)
+			if (kthread_should_stop())
 				break;
 		}
 work_to_do:
 		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&pd->wqueue, &wait);
 
-		if (pd->cdrw.time_to_die)
+		if (kthread_should_stop())
 			break;
 
 		/*
@@ -1278,7 +1263,6 @@ work_to_do:
 		pkt_iosched_process_queue(pd);
 	}
 
-	up(&pd->cdrw.thr_sem);
 	return 0;
 }
 
@@ -1898,16 +1882,6 @@ static int pkt_open_write(struct pktcdvd
 	return 0;
 }
 
-static int pkt_get_minor(struct pktcdvd_device *pd)
-{
-	int minor;
-	for (minor = 0; minor < MAX_WRITERS; minor++)
-		if (pd == &pkt_devs[minor])
-			break;
-	BUG_ON(minor == MAX_WRITERS);
-	return minor;
-}
-
 /*
  * called at open time.
  */
@@ -1938,7 +1912,7 @@ static int pkt_open_dev(struct pktcdvd_d
 		return ret;
 	}
 
-	set_capacity(disks[pkt_get_minor(pd)], lba << 2);
+	set_capacity(pd->disk, lba << 2);
 
 	/*
 	 * The underlying block device needs to have its merge logic
@@ -1996,14 +1970,6 @@ restore_queue:
  */
 static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
 {
-	struct block_device *bdev;
-
-	bdev = bdget(pd->pkt_dev);
-	if (bdev) {
-		fsync_bdev(bdev);
-		bdput(bdev);
-	}
-
 	if (flush && pkt_flush_cache(pd))
 		DPRINTK("pktcdvd: %s not flushing cache\n", pd->name);
 
@@ -2300,7 +2266,7 @@ static int pkt_merge_bvec(request_queue_
 
 static void pkt_init_queue(struct pktcdvd_device *pd)
 {
-	request_queue_t *q = disks[pkt_get_minor(pd)]->queue;
+	request_queue_t *q = pd->disk->queue;
 
 	blk_queue_make_request(q, pkt_make_request);
 	blk_queue_hardsect_size(q, CD_FRAMESIZE);
@@ -2390,19 +2356,17 @@ static int pkt_read_proc(char *page, cha
 static int pkt_new_dev(struct pktcdvd_device *pd, struct block_device *bdev)
 {
 	dev_t dev = bdev->bd_dev;
-	int minor;
+	int i;
 	int ret = 0;
 	char b[BDEVNAME_SIZE];
 
-	for (minor = 0; minor < MAX_WRITERS; minor++) {
-		if (pkt_devs[minor].dev == dev) {
+	for (i = 0; i < MAX_WRITERS; i++) {
+		if (pkt_devs[i].dev == dev) {
 			printk("pktcdvd: %s already setup\n", bdevname(bdev, b));
 			return -EBUSY;
 		}
 	}
 
-	minor = pkt_get_minor(pd);
-
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
@@ -2420,17 +2384,15 @@ static int pkt_new_dev(struct pktcdvd_de
 
 	pkt_init_queue(pd);
 
-	pd->cdrw.time_to_die = 0;
-	pd->cdrw.pid = kernel_thread(kcdrwd, pd, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
-	if (pd->cdrw.pid < 0) {
+	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
+	if (IS_ERR(pd->cdrw.thread)) {
 		printk("pktcdvd: can't start kernel thread\n");
-		ret = -EBUSY;
+		ret = -ENOMEM;
 		goto out_thread;
 	}
-	down(&pd->cdrw.thr_sem);
 
 	create_proc_read_entry(pd->name, 0, pkt_proc, pkt_read_proc, pd);
-	DPRINTK("pktcdvd: writer %d mapped to %s\n", minor, bdevname(bdev, b));
+	DPRINTK("pktcdvd: writer %s mapped to %s\n", pd->name, bdevname(bdev, b));
 	return 0;
 
 out_thread:
@@ -2455,11 +2417,7 @@ static int pkt_setup_dev(struct pktcdvd_
 		return -EBADF;
 	}
 
-	ret = -EINVAL;
-	if ((inode = file->f_dentry->d_inode) == NULL) {
-		printk("pktcdvd: huh? file descriptor contains no inode?\n");
-		goto out;
-	}
+	inode = file->f_dentry->d_inode;
 	ret = -ENOTBLK;
 	if (!S_ISBLK(inode->i_mode)) {
 		printk("pktcdvd: device is not a block device (duh)\n");
@@ -2480,18 +2438,9 @@ out:
 static int pkt_remove_dev(struct pktcdvd_device *pd)
 {
 	struct block_device *bdev;
-	int ret;
 
-	if (pd->cdrw.pid >= 0) {
-		pd->cdrw.time_to_die = 1;
-		wmb();
-		ret = kill_proc(pd->cdrw.pid, SIGKILL, 1);
-		if (ret) {
-			printk("pkt_remove_dev: can't kill kernel thread\n");
-			return ret;
-		}
-		down(&pd->cdrw.thr_sem);
-	}
+	if (!IS_ERR(pd->cdrw.thread))
+		kthread_stop(pd->cdrw.thread);
 
 	/*
 	 * will also invalidate buffers for CD-ROM
@@ -2506,7 +2455,7 @@ static int pkt_remove_dev(struct pktcdvd
 
 	remove_proc_entry(pd->name, pkt_proc);
 	pd->dev = 0;
-	DPRINTK("pktcdvd: writer %d unmapped\n", pkt_get_minor(pd));
+	DPRINTK("pktcdvd: writer %s unmapped\n", pd->name);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	return 0;
@@ -2566,16 +2515,6 @@ static int pkt_ioctl(struct inode *inode
 		up(&pd->ctl_mutex);
 		return ret;
 
-	case BLKROSET:
-		if (capable(CAP_SYS_ADMIN))
-			clear_bit(PACKET_WRITABLE, &pd->flags);
-	case BLKROGET:
-	case BLKSSZGET:
-	case BLKFLSBUF:
-		if (!pd->bdev)
-			return -ENXIO;
-		return -EINVAL;		    /* Handled by blkdev layer */
-
 	/*
 	 * forward selected CDROM ioctls to CD-ROM, for UDF
 	 */
@@ -2630,21 +2569,22 @@ int pkt_init(void)
 	memset(pkt_devs, 0, MAX_WRITERS * sizeof(struct pktcdvd_device));
 
 	for (i = 0; i < MAX_WRITERS; i++) {
-		disks[i] = alloc_disk(1);
-		if (!disks[i])
+		struct pktcdvd_device *pd = &pkt_devs[i];
+
+		pd->disk = alloc_disk(1);
+		if (!pd->disk)
 			goto out_mem2;
 	}
 
 	for (i = 0; i < MAX_WRITERS; i++) {
 		struct pktcdvd_device *pd = &pkt_devs[i];
-		struct gendisk *disk = disks[i];
+		struct gendisk *disk = pd->disk;
 
 		spin_lock_init(&pd->lock);
 		spin_lock_init(&pd->iosched.lock);
 		pd->pkt_dev = MKDEV(PACKET_MAJOR, i);
 		sprintf(pd->name, "pktcdvd%d", i);
 		init_waitqueue_head(&pd->wqueue);
-		init_MUTEX_LOCKED(&pd->cdrw.thr_sem);
 		init_MUTEX(&pd->ctl_mutex);
 
 		disk->major = PACKET_MAJOR;
@@ -2667,11 +2607,11 @@ int pkt_init(void)
 
 out_mem3:
 	while (i--)
-		blk_put_queue(disks[i]->queue);
+		blk_put_queue(pkt_devs[i].disk->queue);
 	i = MAX_WRITERS;
 out_mem2:
 	while (i--)
-		put_disk(disks[i]);
+		put_disk(pkt_devs[i].disk);
 	kfree(pkt_devs);
 out_mem:
 	printk("pktcdvd: out of memory\n");
@@ -2684,9 +2624,10 @@ void pkt_exit(void)
 {
 	int i;
 	for (i = 0; i < MAX_WRITERS; i++) {
-		del_gendisk(disks[i]);
-		blk_put_queue(disks[i]->queue);
-		put_disk(disks[i]);
+		struct gendisk *disk = pkt_devs[i].disk;
+		del_gendisk(disk);
+		blk_put_queue(disk->queue);
+		put_disk(disk);
 	}
 
 	devfs_remove("pktcdvd");
diff -puN include/linux/pktcdvd.h~packet-cleanup include/linux/pktcdvd.h
--- linux/include/linux/pktcdvd.h~packet-cleanup	2004-07-05 01:38:40.538609552 +0200
+++ linux-petero/include/linux/pktcdvd.h	2004-07-05 01:39:06.681635208 +0200
@@ -138,9 +138,7 @@ struct packet_cdrw
 	struct list_head	pkt_free_list;
 	struct list_head	pkt_active_list;
 	spinlock_t		active_list_lock; /* Serialize access to pkt_active_list */
-	pid_t			pid;
-	int			time_to_die;
-	struct semaphore	thr_sem;
+	struct task_struct	*thread;
 	elevator_merge_fn	*elv_merge_fn;
 	elevator_completed_req_fn *elv_completed_req_fn;
 	merge_requests_fn	*merge_requests_fn;
@@ -256,6 +254,7 @@ struct pktcdvd_device
 	atomic_t		scan_queue;	/* Set to non-zero when pkt_handle_queue */
 						/* needs to be run. */
 	struct packet_iosched   iosched;
+	struct gendisk		*disk;
 };
 
 #endif /* __KERNEL__ */
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
