Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267252AbUGNAHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267252AbUGNAHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 20:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUGNAHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 20:07:37 -0400
Received: from av7-1-sn1.fre.skanova.net ([81.228.11.113]:38076 "EHLO
	av7-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S267252AbUGNAGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 20:06:46 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH] Control pktcdvd with an auxiliary character device
References: <m2lli36ec9.fsf@telia.com> <m2llhz5o4o.fsf@telia.com>
	<m2fz875nkv.fsf@telia.com> <200407110120.47256.arnd@arndb.de>
	<20040710232714.GA21633@infradead.org> <m2r7rjpd24.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jul 2004 02:06:17 +0200
In-Reply-To: <m2r7rjpd24.fsf@telia.com>
Message-ID: <m2vfgro3k6.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Sun, Jul 11, 2004 at 01:20:45AM +0200, Arnd Bergmann wrote:
> > > These are actually incorrect definitions since the ioctl argument is
> > > not a pointer to unsigned int but instead just an int. However, that's
> > > too late to fix without breaking the existing tools.
> > 
> > The tools need to change anyway to get away from the broken behaviour to
> > issue in ioctl on the actual block device to bind it..
> 
> OK, I'll create a patch that gets rid of the ioctl interface and uses
> an auxiliary character device instead to control device bindings.

Here is a patch for 2.6.7-mm7 that does that. The driver creates a
misc character device and bind/unbind of the block devices are
controlled by ioctl commands on the char device.

This patch needs corresponding changes in the pktsetup user space
program. I'll post a patch for pktsetup as a separate message.

The driver no longer uses reserved device numbers. Instead, pktsetup
reads /proc/misc to find the pktcdvd char device.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/Documentation/cdrom/packet-writing.txt |   18 
 linux-petero/drivers/block/pktcdvd.c                |  588 ++++++++++----------
 linux-petero/include/linux/compat_ioctl.h           |    2 
 linux-petero/include/linux/major.h                  |    2 
 linux-petero/include/linux/pktcdvd.h                |   54 -
 5 files changed, 341 insertions(+), 323 deletions(-)

diff -puN Documentation/cdrom/packet-writing.txt~packet-char-dev Documentation/cdrom/packet-writing.txt
--- linux/Documentation/cdrom/packet-writing.txt~packet-char-dev	2004-07-14 01:02:38.256478896 +0200
+++ linux-petero/Documentation/cdrom/packet-writing.txt	2004-07-14 01:02:38.268477072 +0200
@@ -13,13 +13,11 @@ Getting started quick
   as appropriate):
 	# cdrwtool -d /dev/hdc -q
 
-- Make sure that /dev/pktcdvd0 exists (mknod /dev/pktcdvd0 b 97 0)
-
 - Setup your writer
-	# pktsetup /dev/pktcdvd0 /dev/hdc
+	# pktsetup dev_name /dev/hdc
 
-- Now you can mount /dev/pktcdvd0 and copy files to it. Enjoy!
-	# mount /dev/pktcdvd0 /cdrom -t udf -o rw,noatime
+- Now you can mount /dev/pktcdvd/dev_name and copy files to it. Enjoy!
+	# mount /dev/pktcdvd/dev_name /cdrom -t udf -o rw,noatime
 
 
 Packet writing for DVD-RW media
@@ -33,8 +31,8 @@ overwrite mode, run:
 
 You can then use the disc the same way you would use a CD-RW disc:
 
-	# pktsetup /dev/pktcdvd0 /dev/hdc
-	# mount /dev/pktcdvd0 /cdrom -t udf -o rw,noatime
+	# pktsetup dev_name /dev/hdc
+	# mount /dev/pktcdvd/dev_name /cdrom -t udf -o rw,noatime
 
 
 Packet writing for DVD+RW media
@@ -56,9 +54,9 @@ writes are not 32KB aligned.
 Both problems can be solved by using the pktcdvd driver, which always
 generates aligned writes.
 
-	# pktsetup /dev/pktcdvd0 /dev/hdc
-	# mkudffs /dev/pktcdvd0
-	# mount /dev/pktcdvd0 /cdrom -t udf -o rw,noatime
+	# pktsetup dev_name /dev/hdc
+	# mkudffs /dev/pktcdvd/dev_name
+	# mount /dev/pktcdvd/dev_name /cdrom -t udf -o rw,noatime
 
 
 Notes
@@ -76,7 +74,7 @@ Notes
   device, you can put any filesystem you like on the disc. For
   example, run:
 
-	# /sbin/mke2fs /dev/pktcdvd0
+	# /sbin/mke2fs /dev/pktcdvd/dev_name
 
   to create an ext2 filesystem on the disc.
 
diff -puN drivers/block/pktcdvd.c~packet-char-dev drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-char-dev	2004-07-14 01:02:38.246480416 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-07-14 01:02:38.266477376 +0200
@@ -31,7 +31,7 @@
  *
  *************************************************************************/
 
-#define VERSION_CODE	"v0.1.6a 2004-07-01 Jens Axboe (axboe@suse.de) and petero2@telia.com"
+#define VERSION_CODE	"v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com"
 
 #include <linux/pktcdvd.h>
 #include <linux/config.h>
@@ -44,26 +44,43 @@
 #include <linux/file.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/buffer_head.h>		/* for invalidate_bdev() */
-#include <linux/devfs_fs_kernel.h>
 #include <linux/suspend.h>
+#include <linux/miscdevice.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_ioctl.h>
 
 #include <asm/uaccess.h>
 
+#if PACKET_DEBUG
+#define DPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+#if PACKET_DEBUG > 1
+#define VPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
+#else
+#define VPRINTK(fmt, args...)
+#endif
+
 #define ZONE(sector, pd) (((sector) + (pd)->offset) & ~((pd)->settings.size - 1))
 
-static struct pktcdvd_device *pkt_devs;
+
+static struct pktcdvd_device *pkt_devs[MAX_WRITERS];
 static struct proc_dir_entry *pkt_proc;
+static int pkt_major;
+static struct semaphore ctl_mutex;	/* Serialize open/close/setup/teardown */
+
 
 static struct pktcdvd_device *pkt_find_dev(request_queue_t *q)
 {
 	int i;
 
-	for (i = 0; i < MAX_WRITERS; i++)
-		if (pkt_devs[i].bdev && bdev_get_queue(pkt_devs[i].bdev) == q)
-			return &pkt_devs[i];
+	for (i = 0; i < MAX_WRITERS; i++) {
+		struct pktcdvd_device *pd = pkt_devs[i];
+		if (pd && bdev_get_queue(pd->bdev) == q)
+			return pd;
+	}
 
 	return NULL;
 }
@@ -315,11 +332,6 @@ static int pkt_generic_packet(struct pkt
 	DECLARE_COMPLETION(wait);
 	int err = 0;
 
-	if (!pd->bdev) {
-		printk("pkt_generic_packet: no bdev\n");
-		return -ENXIO;
-	}
-
 	q = bdev_get_queue(pd->bdev);
 
 	rq = blk_get_request(q, (cgc->data_direction == CGC_DATA_WRITE) ? WRITE : READ,
@@ -481,8 +493,6 @@ static void pkt_iosched_process_queue(st
 		return;
 	atomic_set(&pd->iosched.attention, 0);
 
-	if (!pd->bdev)
-		return;
 	q = bdev_get_queue(pd->bdev);
 
 	for (;;) {
@@ -1209,11 +1219,7 @@ static int kcdrwd(void *foobar)
 					min_sleep_time = pkt->sleep_time;
 			}
 
-			if (pd->bdev) {
-				request_queue_t *q;
-				q = bdev_get_queue(pd->bdev);
-				generic_unplug_device(q);
-			}
+			generic_unplug_device(bdev_get_queue(pd->bdev));
 
 			VPRINTK("kcdrwd: sleeping\n");
 			residue = schedule_timeout(min_sleep_time);
@@ -1894,23 +1900,18 @@ static int pkt_open_dev(struct pktcdvd_d
 	int i;
 	char b[BDEVNAME_SIZE];
 
-	if (!pd->dev)
-		return -ENXIO;
-
-	pd->bdev = bdget(pd->dev);
-	if (!pd->bdev) {
-		printk("pktcdvd: can't find cdrom block device\n");
-		return -ENXIO;
-	}
-
-	if ((ret = blkdev_get(pd->bdev, FMODE_READ, 0))) {
-		pd->bdev = NULL;
-		return ret;
-	}
+	/*
+	 * We need to re-open the cdrom device without O_NONBLOCK to be able
+	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
+	 * so bdget() can't fail.
+	 */
+	bdget(pd->bdev->bd_dev);
+	if ((ret = blkdev_get(pd->bdev, FMODE_READ, O_RDONLY)))
+		goto out;
 
 	if ((ret = pkt_get_last_written(pd, &lba))) {
 		printk("pktcdvd: pkt_get_last_written failed\n");
-		return ret;
+		goto out_putdev;
 	}
 
 	set_capacity(pd->disk, lba << 2);
@@ -1923,11 +1924,12 @@ static int pkt_open_dev(struct pktcdvd_d
 	 */
 	q = bdev_get_queue(pd->bdev);
 	for (i = 0; i < MAX_WRITERS; i++) {
-		if (pd == &pkt_devs[i])
+		if (pd == pkt_devs[i])
 			continue;
-		if (pkt_devs[i].bdev && bdev_get_queue(pkt_devs[i].bdev) == q) {
+		if (pkt_devs[i] && bdev_get_queue(pkt_devs[i]->bdev) == q) {
 			printk("pktcdvd: %s request queue busy\n", bdevname(pd->bdev, b));
-			return -EBUSY;
+			ret = -EBUSY;
+			goto out_putdev;
 		}
 	}
 	spin_lock_irq(q->queue_lock);
@@ -1962,6 +1964,9 @@ restore_queue:
 	q->elevator.elevator_completed_req_fn = pd->cdrw.elv_completed_req_fn;
 	q->merge_requests_fn = pd->cdrw.merge_requests_fn;
 	spin_unlock_irq(q->queue_lock);
+out_putdev:
+	blkdev_put(pd->bdev);
+out:
 	return ret;
 }
 
@@ -1971,117 +1976,80 @@ restore_queue:
  */
 static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
 {
+	request_queue_t *q;
+
 	if (flush && pkt_flush_cache(pd))
 		DPRINTK("pktcdvd: %s not flushing cache\n", pd->name);
 
-	if (pd->bdev) {
-		request_queue_t *q = bdev_get_queue(pd->bdev);
-		pkt_set_speed(pd, 0xffff, 0xffff);
-		spin_lock_irq(q->queue_lock);
-		q->elevator.elevator_merge_fn = pd->cdrw.elv_merge_fn;
-		q->elevator.elevator_completed_req_fn = pd->cdrw.elv_completed_req_fn;
-		q->merge_requests_fn = pd->cdrw.merge_requests_fn;
-		spin_unlock_irq(q->queue_lock);
-		blkdev_put(pd->bdev);
-		pd->bdev = NULL;
-	}
+	q = bdev_get_queue(pd->bdev);
+	pkt_set_speed(pd, 0xffff, 0xffff);
+	spin_lock_irq(q->queue_lock);
+	q->elevator.elevator_merge_fn = pd->cdrw.elv_merge_fn;
+	q->elevator.elevator_completed_req_fn = pd->cdrw.elv_completed_req_fn;
+	q->merge_requests_fn = pd->cdrw.merge_requests_fn;
+	spin_unlock_irq(q->queue_lock);
+	blkdev_put(pd->bdev);
+}
+
+static struct pktcdvd_device *pkt_find_dev_from_minor(int dev_minor)
+{
+	if (dev_minor >= MAX_WRITERS)
+		return NULL;
+	return pkt_devs[dev_minor];
 }
 
 static int pkt_open(struct inode *inode, struct file *file)
 {
 	struct pktcdvd_device *pd = NULL;
 	int ret;
-	int special_open, exclusive;
 
 	VPRINTK("pktcdvd: entering open\n");
 
-	if (iminor(inode) >= MAX_WRITERS) {
-		printk("pktcdvd: max %d writers supported\n", MAX_WRITERS);
+	down(&ctl_mutex);
+	pd = pkt_find_dev_from_minor(iminor(inode));
+	if (!pd) {
 		ret = -ENODEV;
 		goto out;
 	}
+	BUG_ON(pd->refcnt < 0);
 
-	special_open = 0;
-	if (((file->f_flags & O_ACCMODE) == O_RDONLY) && (file->f_flags & O_CREAT))
-		special_open = 1;
-
-	exclusive = 0;
-	if ((file->f_mode & FMODE_WRITE) || special_open)
-		exclusive = 1;
-
-	/*
-	 * either device is not configured, or pktsetup is old and doesn't
-	 * use O_CREAT to create device
-	 */
-	pd = &pkt_devs[iminor(inode)];
-	if (!pd->dev && !special_open) {
-		VPRINTK("pktcdvd: not configured and O_CREAT not set\n");
-		ret = -ENXIO;
-		goto out;
-	}
-
-	down(&pd->ctl_mutex);
 	pd->refcnt++;
-	if (pd->refcnt > 1) {
-		if (exclusive) {
-			VPRINTK("pktcdvd: busy open\n");
-			ret = -EBUSY;
-			goto out_dec;
-		}
-
-		/*
-		 * Not first open, everything is already set up
-		 */
-		goto done;
-	}
-
-	if (!special_open) {
+	if (pd->refcnt == 1) {
 		if (pkt_open_dev(pd, file->f_mode & FMODE_WRITE)) {
 			ret = -EIO;
 			goto out_dec;
 		}
+		/*
+		 * needed here as well, since ext2 (among others) may change
+		 * the blocksize at mount time
+		 */
+		set_blocksize(inode->i_bdev, CD_FRAMESIZE);
 	}
 
-	/*
-	 * needed here as well, since ext2 (among others) may change
-	 * the blocksize at mount time
-	 */
-	set_blocksize(inode->i_bdev, CD_FRAMESIZE);
-
-done:
-	up(&pd->ctl_mutex);
+	up(&ctl_mutex);
 	return 0;
 
 out_dec:
 	pd->refcnt--;
-	if (pd->refcnt == 0) {
-		if (pd->bdev) {
-			blkdev_put(pd->bdev);
-			pd->bdev = NULL;
-		}
-	}
-	up(&pd->ctl_mutex);
 out:
 	VPRINTK("pktcdvd: failed open (%d)\n", ret);
+	up(&ctl_mutex);
 	return ret;
 }
 
 static int pkt_close(struct inode *inode, struct file *file)
 {
-	struct pktcdvd_device *pd = &pkt_devs[iminor(inode)];
+	struct pktcdvd_device *pd = pkt_find_dev_from_minor(iminor(inode));
 	int ret = 0;
 
-	down(&pd->ctl_mutex);
+	down(&ctl_mutex);
 	pd->refcnt--;
 	BUG_ON(pd->refcnt < 0);
-	if (pd->refcnt > 0)
-		goto out;
-	if (pd->dev) {
+	if (pd->refcnt == 0) {
 		int flush = test_bit(PACKET_WRITABLE, &pd->flags);
 		pkt_release_dev(pd, flush);
 	}
-out:
-	up(&pd->ctl_mutex);
+	up(&ctl_mutex);
 	return ret;
 }
 
@@ -2099,11 +2067,6 @@ static int pkt_make_request(request_queu
 		goto end_io;
 	}
 
-	if (!pd->dev) {
-		printk("pktcdvd: request received for non-active pd\n");
-		goto end_io;
-	}
-
 	/*
 	 * quick remap a READ
 	 */
@@ -2243,7 +2206,7 @@ end_io:
 
 static int pkt_merge_bvec(request_queue_t *q, struct bio *bio, struct bio_vec *bvec)
 {
-	struct pktcdvd_device *pd = &pkt_devs[MINOR(bio->bi_bdev->bd_dev)];
+	struct pktcdvd_device *pd = q->queuedata;
 	sector_t zone = ZONE(bio->bi_sector, pd);
 	int used = ((bio->bi_sector - zone) << 9) + bio->bi_size;
 	int remaining = (pd->settings.size << 9) - used;
@@ -2279,7 +2242,7 @@ static int pkt_seq_show(struct seq_file 
 	int states[PACKET_NUM_STATES];
 
 	seq_printf(m, "Writer %s mapped to %s:\n", pd->name,
-		   __bdevname(pd->dev, bdev_buf));
+		   bdevname(pd->bdev, bdev_buf));
 
 	seq_printf(m, "\nSettings:\n");
 	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
@@ -2340,35 +2303,50 @@ static struct file_operations pkt_proc_f
 	.release = single_release
 };
 
-static int pkt_new_dev(struct pktcdvd_device *pd, struct block_device *bdev)
+static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 {
-	dev_t dev = bdev->bd_dev;
 	int i;
 	int ret = 0;
 	char b[BDEVNAME_SIZE];
 	struct proc_dir_entry *proc;
+	struct block_device *bdev;
 
+	if (pd->pkt_dev == dev) {
+		printk("pktcdvd: Recursive setup not allowed\n");
+		return -EBUSY;
+	}
 	for (i = 0; i < MAX_WRITERS; i++) {
-		if (pkt_devs[i].dev == dev) {
-			printk("pktcdvd: %s already setup\n", bdevname(bdev, b));
+		struct pktcdvd_device *pd2 = pkt_devs[i];
+		if (!pd2)
+			continue;
+		if (pd2->bdev->bd_dev == dev) {
+			printk("pktcdvd: %s already setup\n", bdevname(pd2->bdev, b));
+			return -EBUSY;
+		}
+		if (pd2->pkt_dev == dev) {
+			printk("pktcdvd: Can't chain pktcdvd devices\n");
 			return -EBUSY;
 		}
 	}
 
+	bdev = bdget(dev);
+	if (!bdev)
+		return -ENOMEM;
+	ret = blkdev_get(bdev, FMODE_READ, O_RDONLY | O_NONBLOCK);
+	if (ret)
+		return ret;
+
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
-	memset(&pd->stats, 0, sizeof(struct packet_stats));
-
 	if (!pkt_grow_pktlist(pd, CONFIG_CDROM_PKTCDVD_BUFFERS)) {
 		printk("pktcdvd: not enough memory for buffers\n");
 		ret = -ENOMEM;
 		goto out_mem;
 	}
 
+	pd->bdev = bdev;
 	set_blocksize(bdev, CD_FRAMESIZE);
-	pd->dev = dev;
-	BUG_ON(pd->bdev);
 
 	pkt_init_queue(pd);
 
@@ -2390,60 +2368,43 @@ static int pkt_new_dev(struct pktcdvd_de
 out_thread:
 	pkt_shrink_pktlist(pd);
 out_mem:
+	blkdev_put(bdev);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	return ret;
 }
 
-/*
- * arg contains file descriptor of CD-ROM device.
- */
-static int pkt_setup_dev(struct pktcdvd_device *pd, unsigned int arg)
+static int pkt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct inode *inode;
-	struct file *file;
-	int ret;
-
-	if ((file = fget(arg)) == NULL) {
-		printk("pktcdvd: bad file descriptor passed\n");
-		return -EBADF;
-	}
-
-	inode = file->f_dentry->d_inode;
-	ret = -ENOTBLK;
-	if (!S_ISBLK(inode->i_mode)) {
-		printk("pktcdvd: device is not a block device (duh)\n");
-		goto out;
-	}
-	ret = -EROFS;
-	if (IS_RDONLY(inode)) {
-		printk("pktcdvd: Can't write to read-only dev\n");
-		goto out;
-	}
-	ret = pkt_new_dev(pd, inode->i_bdev);
-
-out:
-	fput(file);
-	return ret;
-}
+	struct pktcdvd_device *pd = pkt_find_dev_from_minor(iminor(inode));
 
-static int pkt_remove_dev(struct pktcdvd_device *pd, struct block_device *bdev)
-{
-	if (!IS_ERR(pd->cdrw.thread))
-		kthread_stop(pd->cdrw.thread);
+	VPRINTK("pkt_ioctl: cmd %x, dev %d:%d\n", cmd, imajor(inode), iminor(inode));
+	BUG_ON(!pd);
 
+	switch (cmd) {
 	/*
-	 * will also invalidate buffers for CD-ROM
+	 * forward selected CDROM ioctls to CD-ROM, for UDF
 	 */
-	invalidate_bdev(bdev, 1);
+	case CDROMMULTISESSION:
+	case CDROMREADTOCENTRY:
+	case CDROM_LAST_WRITTEN:
+	case CDROM_SEND_PACKET:
+	case SCSI_IOCTL_SEND_COMMAND:
+		return ioctl_by_bdev(pd->bdev, cmd, arg);
 
-	pkt_shrink_pktlist(pd);
+	case CDROMEJECT:
+		/*
+		 * The door gets locked when the device is opened, so we
+		 * have to unlock it or else the eject command fails.
+		 */
+		pkt_lock_door(pd, 0);
+		return ioctl_by_bdev(pd->bdev, cmd, arg);
+
+	default:
+		printk("pktcdvd: Unknown ioctl for %s (%x)\n", pd->name, cmd);
+		return -ENOTTY;
+	}
 
-	remove_proc_entry(pd->name, pkt_proc);
-	pd->dev = 0;
-	DPRINTK("pktcdvd: writer %s unmapped\n", pd->name);
-	/* This is safe: open() is still holding a reference. */
-	module_put(THIS_MODULE);
 	return 0;
 }
 
@@ -2462,164 +2423,223 @@ static int pkt_media_changed(struct gend
 	return attached_disk->fops->media_changed(attached_disk);
 }
 
-static int pkt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+static struct block_device_operations pktcdvd_ops = {
+	.owner =		THIS_MODULE,
+	.open =			pkt_open,
+	.release =		pkt_close,
+	.ioctl =		pkt_ioctl,
+	.media_changed =	pkt_media_changed,
+};
+
+/*
+ * Set up mapping from pktcdvd device to CD-ROM device.
+ */
+static int pkt_setup_dev(struct pkt_ctrl_command *ctrl_cmd)
 {
-	struct pktcdvd_device *pd = &pkt_devs[iminor(inode)];
-	int ret;
+	int idx;
+	int ret = -ENOMEM;
+	struct pktcdvd_device *pd;
+	struct gendisk *disk;
+	dev_t dev = new_decode_dev(ctrl_cmd->dev);
 
-	VPRINTK("pkt_ioctl: cmd %x, dev %d:%d\n", cmd, imajor(inode), iminor(inode));
+	for (idx = 0; idx < MAX_WRITERS; idx++)
+		if (!pkt_devs[idx])
+			break;
+	if (idx == MAX_WRITERS) {
+		printk("pktcdvd: max %d writers supported\n", MAX_WRITERS);
+		return -EBUSY;
+	}
+
+	pd = kmalloc(sizeof(struct pktcdvd_device), GFP_KERNEL);
+	if (!pd)
+		return ret;
+	memset(pd, 0, sizeof(struct pktcdvd_device));
+
+	disk = alloc_disk(1);
+	if (!disk)
+		goto out_mem;
+	pd->disk = disk;
+
+	spin_lock_init(&pd->lock);
+	spin_lock_init(&pd->iosched.lock);
+	sprintf(pd->name, "pktcdvd%d", idx);
+	init_waitqueue_head(&pd->wqueue);
+
+	disk->major = pkt_major;
+	disk->first_minor = idx;
+	disk->fops = &pktcdvd_ops;
+	disk->flags = GENHD_FL_REMOVABLE;
+	sprintf(disk->disk_name, "pktcdvd%d", idx);
+	disk->private_data = pd;
+	disk->queue = blk_alloc_queue(GFP_KERNEL);
+	if (!disk->queue)
+		goto out_mem2;
+
+	pd->pkt_dev = MKDEV(disk->major, disk->first_minor);
+	ret = pkt_new_dev(pd, dev);
+	if (ret)
+		goto out_new_dev;
+
+	add_disk(disk);
+	pkt_devs[idx] = pd;
+	ctrl_cmd->pkt_dev = new_encode_dev(pd->pkt_dev);
+	return 0;
+
+out_new_dev:
+	blk_put_queue(disk->queue);
+out_mem2:
+	put_disk(disk);
+out_mem:
+	kfree(pd);
+	return ret;
+}
+
+/*
+ * Tear down mapping from pktcdvd device to CD-ROM device.
+ */
+static int pkt_remove_dev(struct pkt_ctrl_command *ctrl_cmd)
+{
+	struct pktcdvd_device *pd;
+	int idx;
+	dev_t pkt_dev = new_decode_dev(ctrl_cmd->pkt_dev);
 
-	if ((cmd != PACKET_SETUP_DEV) && !pd->dev) {
+	for (idx = 0; idx < MAX_WRITERS; idx++) {
+		pd = pkt_devs[idx];
+		if (pd && (pd->pkt_dev == pkt_dev))
+			break;
+	}
+	if (idx == MAX_WRITERS) {
 		DPRINTK("pktcdvd: dev not setup\n");
 		return -ENXIO;
 	}
 
-	switch (cmd) {
-	case PACKET_GET_STATS:
-		if (copy_to_user(&arg, &pd->stats, sizeof(struct packet_stats)))
-			return -EFAULT;
-		break;
+	if (pd->refcnt > 0)
+		return -EBUSY;
 
-	case PACKET_SETUP_DEV:
-		if (pd->dev) {
-			printk("pktcdvd: dev already setup\n");
-			return -EBUSY;
-		}
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		return pkt_setup_dev(pd, arg);
+	if (!IS_ERR(pd->cdrw.thread))
+		kthread_stop(pd->cdrw.thread);
 
-	case PACKET_TEARDOWN_DEV:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		down(&pd->ctl_mutex);
-		BUG_ON(pd->refcnt < 1);
-		if (pd->refcnt != 1)
-			ret = -EBUSY;
-		else
-			ret = pkt_remove_dev(pd, inode->i_bdev);
-		up(&pd->ctl_mutex);
-		return ret;
+	blkdev_put(pd->bdev);
 
-	/*
-	 * forward selected CDROM ioctls to CD-ROM, for UDF
-	 */
-	case CDROMMULTISESSION:
-	case CDROMREADTOCENTRY:
-	case CDROM_LAST_WRITTEN:
-	case CDROM_SEND_PACKET:
-	case SCSI_IOCTL_SEND_COMMAND:
-		if (!pd->bdev)
-			return -ENXIO;
-		return ioctl_by_bdev(pd->bdev, cmd, arg);
+	pkt_shrink_pktlist(pd);
 
-	case CDROMEJECT:
-		if (!pd->bdev)
-			return -ENXIO;
-		/*
-		 * The door gets locked when the device is opened, so we
-		 * have to unlock it or else the eject command fails.
-		 */
-		pkt_lock_door(pd, 0);
-		return ioctl_by_bdev(pd->bdev, cmd, arg);
+	remove_proc_entry(pd->name, pkt_proc);
+	DPRINTK("pktcdvd: writer %s unmapped\n", pd->name);
+
+	del_gendisk(pd->disk);
+	blk_put_queue(pd->disk->queue);
+	put_disk(pd->disk);
+
+	pkt_devs[idx] = NULL;
+	kfree(pd);
+
+	/* This is safe: open() is still holding a reference. */
+	module_put(THIS_MODULE);
+	return 0;
+}
+
+static void pkt_get_status(struct pkt_ctrl_command *ctrl_cmd)
+{
+	struct pktcdvd_device *pd = pkt_find_dev_from_minor(ctrl_cmd->dev_index);
+	if (pd) {
+		ctrl_cmd->dev = new_encode_dev(pd->bdev->bd_dev);
+		ctrl_cmd->pkt_dev = new_encode_dev(pd->pkt_dev);
+	} else {
+		ctrl_cmd->dev = 0;
+		ctrl_cmd->pkt_dev = 0;
+	}
+	ctrl_cmd->num_devices = MAX_WRITERS;
+}
+
+static int pkt_ctl_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	struct pkt_ctrl_command ctrl_cmd;
+	int ret = 0;
+
+	if (cmd != PACKET_CTRL_CMD)
+		return -ENOTTY;
 
+	if (copy_from_user(&ctrl_cmd, argp, sizeof(struct pkt_ctrl_command)))
+		return -EFAULT;
+
+	switch (ctrl_cmd.command) {
+	case PKT_CTRL_CMD_SETUP:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		down(&ctl_mutex);
+		ret = pkt_setup_dev(&ctrl_cmd);
+		up(&ctl_mutex);
+		break;
+	case PKT_CTRL_CMD_TEARDOWN:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		down(&ctl_mutex);
+		ret = pkt_remove_dev(&ctrl_cmd);
+		up(&ctl_mutex);
+		break;
+	case PKT_CTRL_CMD_STATUS:
+		down(&ctl_mutex);
+		pkt_get_status(&ctrl_cmd);
+		up(&ctl_mutex);
+		break;
 	default:
-		printk("pktcdvd: Unknown ioctl for %s (%x)\n", pd->name, cmd);
 		return -ENOTTY;
 	}
 
-	return 0;
+	if (copy_to_user(argp, &ctrl_cmd, sizeof(struct pkt_ctrl_command)))
+		return -EFAULT;
+	return ret;
 }
 
-static struct block_device_operations pktcdvd_ops = {
-	.owner =		THIS_MODULE,
-	.open =			pkt_open,
-	.release =		pkt_close,
-	.ioctl =		pkt_ioctl,
-	.media_changed =	pkt_media_changed,
+
+static struct file_operations pkt_ctl_fops = {
+	.ioctl	 = pkt_ctl_ioctl,
+	.owner	 = THIS_MODULE,
+};
+
+static struct miscdevice pkt_misc = {
+	.minor 		= MISC_DYNAMIC_MINOR,
+	.name  		= "pktcdvd",
+	.devfs_name 	= "pktcdvd/control",
+	.fops  		= &pkt_ctl_fops
 };
 
 int pkt_init(void)
 {
-	int i;
+	int ret;
 
-	devfs_mk_dir("pktcdvd");
-	if (register_blkdev(PACKET_MAJOR, "pktcdvd")) {
-		printk("unable to register pktcdvd device\n");
-		return -EIO;
+	ret = register_blkdev(pkt_major, "pktcdvd");
+	if (ret < 0) {
+		printk("pktcdvd: Unable to register block device\n");
+		return ret;
 	}
+	if (!pkt_major)
+		pkt_major = ret;
 
-	pkt_devs = kmalloc(MAX_WRITERS * sizeof(struct pktcdvd_device), GFP_KERNEL);
-	if (pkt_devs == NULL)
-		goto out_mem;
-	memset(pkt_devs, 0, MAX_WRITERS * sizeof(struct pktcdvd_device));
-
-	for (i = 0; i < MAX_WRITERS; i++) {
-		struct pktcdvd_device *pd = &pkt_devs[i];
-
-		pd->disk = alloc_disk(1);
-		if (!pd->disk)
-			goto out_mem2;
+	ret = misc_register(&pkt_misc);
+	if (ret) {
+		printk("pktcdvd: Unable to register misc device\n");
+		goto out;
 	}
 
-	for (i = 0; i < MAX_WRITERS; i++) {
-		struct pktcdvd_device *pd = &pkt_devs[i];
-		struct gendisk *disk = pd->disk;
-
-		spin_lock_init(&pd->lock);
-		spin_lock_init(&pd->iosched.lock);
-		sprintf(pd->name, "pktcdvd%d", i);
-		init_waitqueue_head(&pd->wqueue);
-		init_MUTEX(&pd->ctl_mutex);
-
-		disk->major = PACKET_MAJOR;
-		disk->first_minor = i;
-		disk->fops = &pktcdvd_ops;
-		disk->flags = GENHD_FL_REMOVABLE;
-		sprintf(disk->disk_name, "pktcdvd%d", i);
-		sprintf(disk->devfs_name, "pktcdvd/%d", i);
-		disk->private_data = pd;
-		disk->queue = blk_alloc_queue(GFP_KERNEL);
-		if (!disk->queue)
-			goto out_mem3;
-		add_disk(disk);
-	}
+	init_MUTEX(&ctl_mutex);
 
 	pkt_proc = proc_mkdir("pktcdvd", proc_root_driver);
 
 	DPRINTK("pktcdvd: %s\n", VERSION_CODE);
 	return 0;
 
-out_mem3:
-	while (i--)
-		blk_put_queue(pkt_devs[i].disk->queue);
-	i = MAX_WRITERS;
-out_mem2:
-	while (i--)
-		put_disk(pkt_devs[i].disk);
-	kfree(pkt_devs);
-out_mem:
-	printk("pktcdvd: out of memory\n");
-	devfs_remove("pktcdvd");
-	unregister_blkdev(PACKET_MAJOR, "pktcdvd");
-	return -ENOMEM;
+out:
+	unregister_blkdev(pkt_major, "pktcdvd");
+	return ret;
 }
 
 void pkt_exit(void)
 {
-	int i;
-	for (i = 0; i < MAX_WRITERS; i++) {
-		struct gendisk *disk = pkt_devs[i].disk;
-		del_gendisk(disk);
-		blk_put_queue(disk->queue);
-		put_disk(disk);
-	}
-
-	devfs_remove("pktcdvd");
-	unregister_blkdev(PACKET_MAJOR, "pktcdvd");
-
 	remove_proc_entry("pktcdvd", proc_root_driver);
-	kfree(pkt_devs);
+	misc_deregister(&pkt_misc);
+	unregister_blkdev(pkt_major, "pktcdvd");
 }
 
 MODULE_DESCRIPTION("Packet writing layer for CD/DVD drives");
@@ -2628,5 +2648,3 @@ MODULE_LICENSE("GPL");
 
 module_init(pkt_init);
 module_exit(pkt_exit);
-
-MODULE_ALIAS_BLOCKDEV_MAJOR(PACKET_MAJOR);
diff -puN include/linux/compat_ioctl.h~packet-char-dev include/linux/compat_ioctl.h
--- linux/include/linux/compat_ioctl.h~packet-char-dev	2004-07-14 01:02:38.251479656 +0200
+++ linux-petero/include/linux/compat_ioctl.h	2004-07-14 01:02:38.267477224 +0200
@@ -382,6 +382,8 @@ COMPATIBLE_IOCTL(CDROMREADALL)
 COMPATIBLE_IOCTL(DVD_READ_STRUCT)
 COMPATIBLE_IOCTL(DVD_WRITE_STRUCT)
 COMPATIBLE_IOCTL(DVD_AUTH)
+/* pktcdvd */
+COMPATIBLE_IOCTL(PACKET_CTRL_CMD)
 /* Big L */
 ULONG_IOCTL(LOOP_SET_FD)
 COMPATIBLE_IOCTL(LOOP_CLR_FD)
diff -puN include/linux/major.h~packet-char-dev include/linux/major.h
--- linux/include/linux/major.h~packet-char-dev	2004-07-14 01:02:38.258478592 +0200
+++ linux-petero/include/linux/major.h	2004-07-14 01:02:38.269476920 +0200
@@ -111,8 +111,6 @@
 
 #define MDISK_MAJOR		95
 
-#define PACKET_MAJOR		97
-
 #define UBD_MAJOR		98
 
 #define JSFD_MAJOR		99
diff -puN include/linux/pktcdvd.h~packet-char-dev include/linux/pktcdvd.h
--- linux/include/linux/pktcdvd.h~packet-char-dev	2004-07-14 01:02:38.253479352 +0200
+++ linux-petero/include/linux/pktcdvd.h	2004-07-14 01:02:38.268477072 +0200
@@ -12,6 +12,8 @@
 #ifndef __PKTCDVD_H
 #define __PKTCDVD_H
 
+#include <linux/types.h>
+
 /*
  * 1 for normal debug messages, 2 is very verbose. 0 to turn it off.
  */
@@ -40,18 +42,6 @@
  * No user-servicable parts beyond this point ->
  */
 
-#if PACKET_DEBUG
-#define DPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
-#else
-#define DPRINTK(fmt, args...)
-#endif
-
-#if PACKET_DEBUG > 1
-#define VPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
-#else
-#define VPRINTK(fmt, args...)
-#endif
-
 /*
  * device types
  */
@@ -97,25 +87,24 @@
 
 #undef PACKET_USE_LS
 
-/*
- * Very crude stats for now
- */
-struct packet_stats
-{
-	unsigned long		pkt_started;
-	unsigned long		pkt_ended;
-	unsigned long		secs_w;
-	unsigned long		secs_rg;
-	unsigned long		secs_r;
+#define PKT_CTRL_CMD_SETUP	0
+#define PKT_CTRL_CMD_TEARDOWN	1
+#define PKT_CTRL_CMD_STATUS	2
+
+struct pkt_ctrl_command {
+	__u32 command;				/* in: Setup, teardown, status */
+	__u32 dev_index;			/* in/out: Device index */
+	__u32 dev;				/* in/out: Device nr for cdrw device */
+	__u32 pkt_dev;				/* in/out: Device nr for packet device */
+	__u32 num_devices;			/* out: Largest device index + 1 */
+	__u32 padding;				/* Not used */
 };
 
 /*
  * packet ioctls
  */
 #define PACKET_IOCTL_MAGIC	('X')
-#define PACKET_GET_STATS	_IOR(PACKET_IOCTL_MAGIC, 0, struct packet_stats)
-#define PACKET_SETUP_DEV	_IOW(PACKET_IOCTL_MAGIC, 1, unsigned int)
-#define PACKET_TEARDOWN_DEV	_IOW(PACKET_IOCTL_MAGIC, 2, unsigned int)
+#define PACKET_CTRL_CMD		_IOWR(PACKET_IOCTL_MAGIC, 1, struct pkt_ctrl_command)
 
 #ifdef __KERNEL__
 #include <linux/blkdev.h>
@@ -133,6 +122,18 @@ struct packet_settings
 	__u8			block_mode;
 };
 
+/*
+ * Very crude stats for now
+ */
+struct packet_stats
+{
+	unsigned long		pkt_started;
+	unsigned long		pkt_ended;
+	unsigned long		secs_w;
+	unsigned long		secs_rg;
+	unsigned long		secs_r;
+};
+
 struct packet_cdrw
 {
 	struct list_head	pkt_free_list;
@@ -229,11 +230,10 @@ struct packet_data
 struct pktcdvd_device
 {
 	struct block_device	*bdev;		/* dev attached */
-	dev_t			dev;		/* dev attached */
+	dev_t			pkt_dev;	/* our dev */
 	char			name[20];
 	struct packet_settings	settings;
 	struct packet_stats	stats;
-	struct semaphore	ctl_mutex;	/* Serialize access to refcnt */
 	int			refcnt;		/* Open count */
 	__u8			write_speed;	/* current write speed */
 	__u8			read_speed;	/* current read speed */
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
