Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265644AbUGDMl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbUGDMl3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 08:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265676AbUGDMl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 08:41:29 -0400
Received: from av7-1-sn1.fre.skanova.net ([81.228.11.113]:40918 "EHLO
	av7-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S265644AbUGDMlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 08:41:18 -0400
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix open/close races in pktcdvd
References: <m2lli36ec9.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 04 Jul 2004 14:37:24 +0200
In-Reply-To: <m2lli36ec9.fsf@telia.com>
Message-ID: <m24qoouewr.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The handling of the pd->refcnt variable is racy in a number of
places. For example, running:

while true ; do usleep 10 ; pktsetup /dev/pktcdvd0 /dev/hdc ; done &
while true ; do pktsetup -d /dev/pktcdvd0 ; done

makes a pktsetup process get stuck in D state after a while.

This patch fixes it by introducing a mutex to protect the refcnt
variable and critical sections in the open/release/setup/tear-down
functions.

This patch applies cleanly on top of the "Fix race in pktcdvd kernel
thread handling" patch.


Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/drivers/block/pktcdvd.c |   88 +++++++++++++++++++++--------------
 linux-petero/include/linux/pktcdvd.h |    3 -
 2 files changed, 55 insertions(+), 36 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-open-race-fix drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-open-race-fix	2004-07-04 14:09:40.840062728 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-07-04 14:09:40.850061208 +0200
@@ -1998,10 +1998,6 @@ static void pkt_release_dev(struct pktcd
 {
 	struct block_device *bdev;
 
-	atomic_dec(&pd->refcnt);
-	if (atomic_read(&pd->refcnt) > 0)
-		return;
-
 	bdev = bdget(pd->pkt_dev);
 	if (bdev) {
 		fsync_bdev(bdev);
@@ -2029,6 +2025,7 @@ static int pkt_open(struct inode *inode,
 	struct pktcdvd_device *pd = NULL;
 	struct block_device *pkt_bdev;
 	int ret;
+	int special_open, exclusive;
 
 	VPRINTK("pktcdvd: entering open\n");
 
@@ -2038,21 +2035,30 @@ static int pkt_open(struct inode *inode,
 		goto out;
 	}
 
+	special_open = 0;
+	if (((file->f_flags & O_ACCMODE) == O_RDONLY) && (file->f_flags & O_CREAT))
+		special_open = 1;
+
+	exclusive = 0;
+	if ((file->f_mode & FMODE_WRITE) || special_open)
+		exclusive = 1;
+
 	/*
 	 * either device is not configured, or pktsetup is old and doesn't
 	 * use O_CREAT to create device
 	 */
 	pd = &pkt_devs[iminor(inode)];
-	if (!pd->dev && !(file->f_flags & O_CREAT)) {
+	if (!pd->dev && !special_open) {
 		VPRINTK("pktcdvd: not configured and O_CREAT not set\n");
 		ret = -ENXIO;
 		goto out;
 	}
 
-	atomic_inc(&pd->refcnt);
-	if (atomic_read(&pd->refcnt) > 1) {
-		if (file->f_mode & FMODE_WRITE) {
-			VPRINTK("pktcdvd: busy open for write\n");
+	down(&pd->ctl_mutex);
+	pd->refcnt++;
+	if (pd->refcnt > 1) {
+		if (exclusive) {
+			VPRINTK("pktcdvd: busy open\n");
 			ret = -EBUSY;
 			goto out_dec;
 		}
@@ -2060,10 +2066,10 @@ static int pkt_open(struct inode *inode,
 		/*
 		 * Not first open, everything is already set up
 		 */
-		return 0;
+		goto done;
 	}
 
-	if (((file->f_flags & O_ACCMODE) != O_RDONLY) || !(file->f_flags & O_CREAT)) {
+	if (!special_open) {
 		if (pkt_open_dev(pd, file->f_mode & FMODE_WRITE)) {
 			ret = -EIO;
 			goto out_dec;
@@ -2079,16 +2085,20 @@ static int pkt_open(struct inode *inode,
 		set_blocksize(pkt_bdev, CD_FRAMESIZE);
 		bdput(pkt_bdev);
 	}
+
+done:
+	up(&pd->ctl_mutex);
 	return 0;
 
 out_dec:
-	atomic_dec(&pd->refcnt);
-	if (atomic_read(&pd->refcnt) == 0) {
+	pd->refcnt--;
+	if (pd->refcnt == 0) {
 		if (pd->bdev) {
 			blkdev_put(pd->bdev);
 			pd->bdev = NULL;
 		}
 	}
+	up(&pd->ctl_mutex);
 out:
 	VPRINTK("pktcdvd: failed open (%d)\n", ret);
 	return ret;
@@ -2099,11 +2109,17 @@ static int pkt_close(struct inode *inode
 	struct pktcdvd_device *pd = &pkt_devs[iminor(inode)];
 	int ret = 0;
 
+	down(&pd->ctl_mutex);
+	pd->refcnt--;
+	BUG_ON(pd->refcnt < 0);
+	if (pd->refcnt > 0)
+		goto out;
 	if (pd->dev) {
 		int flush = test_bit(PACKET_WRITABLE, &pd->flags);
 		pkt_release_dev(pd, flush);
 	}
-
+out:
+	up(&pd->ctl_mutex);
 	return ret;
 }
 
@@ -2332,7 +2348,7 @@ static int pkt_proc_device(struct pktcdv
 	b += sprintf(b, "\tread:\t\t\t%lukB\n", pd->stats.secs_r >> 1);
 
 	b += sprintf(b, "\nMisc:\n");
-	b += sprintf(b, "\treference count:\t%d\n", atomic_read(&pd->refcnt));
+	b += sprintf(b, "\treference count:\t%d\n", pd->refcnt);
 	b += sprintf(b, "\tflags:\t\t\t0x%lx\n", pd->flags);
 	b += sprintf(b, "\tread speed:\t\t%ukB/s\n", pd->read_speed * 150);
 	b += sprintf(b, "\twrite speed:\t\t%ukB/s\n", pd->write_speed * 150);
@@ -2371,8 +2387,6 @@ static int pkt_read_proc(char *page, cha
 	return len;
 }
 
-extern struct block_device_operations pktcdvd_ops;
-
 static int pkt_new_dev(struct pktcdvd_device *pd, struct block_device *bdev)
 {
 	dev_t dev = bdev->bd_dev;
@@ -2392,10 +2406,8 @@ static int pkt_new_dev(struct pktcdvd_de
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
-	memset(pd, 0, sizeof(struct pktcdvd_device));
+	memset(&pd->stats, 0, sizeof(struct packet_stats));
 
-	spin_lock_init(&pd->lock);
-	spin_lock_init(&pd->iosched.lock);
 	if (!pkt_grow_pktlist(pd, CONFIG_CDROM_PKTCDVD_BUFFERS)) {
 		printk("pktcdvd: not enough memory for buffers\n");
 		ret = -ENOMEM;
@@ -2404,12 +2416,7 @@ static int pkt_new_dev(struct pktcdvd_de
 
 	set_blocksize(bdev, CD_FRAMESIZE);
 	pd->dev = dev;
-	pd->bdev = NULL;
-	pd->pkt_dev = MKDEV(PACKET_MAJOR, minor);
-	sprintf(pd->name, "pktcdvd%d", minor);
-	atomic_set(&pd->refcnt, 0);
-	init_waitqueue_head(&pd->wqueue);
-	init_MUTEX_LOCKED(&pd->cdrw.thr_sem);
+	BUG_ON(pd->bdev);
 
 	pkt_init_queue(pd);
 
@@ -2428,7 +2435,6 @@ static int pkt_new_dev(struct pktcdvd_de
 
 out_thread:
 	pkt_shrink_pktlist(pd);
-	memset(pd, 0, sizeof(*pd));
 out_mem:
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
@@ -2464,10 +2470,7 @@ static int pkt_setup_dev(struct pktcdvd_
 		printk("pktcdvd: Can't write to read-only dev\n");
 		goto out;
 	}
-	if ((ret = pkt_new_dev(pd, inode->i_bdev)))
-		goto out;
-
-	atomic_inc(&pd->refcnt);
+	ret = pkt_new_dev(pd, inode->i_bdev);
 
 out:
 	fput(file);
@@ -2502,8 +2505,8 @@ static int pkt_remove_dev(struct pktcdvd
 	pkt_shrink_pktlist(pd);
 
 	remove_proc_entry(pd->name, pkt_proc);
+	pd->dev = 0;
 	DPRINTK("pktcdvd: writer %d unmapped\n", pkt_get_minor(pd));
-	memset(pd, 0, sizeof(struct pktcdvd_device));
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	return 0;
@@ -2527,6 +2530,7 @@ static int pkt_media_changed(struct gend
 static int pkt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct pktcdvd_device *pd = &pkt_devs[iminor(inode)];
+	int ret;
 
 	VPRINTK("pkt_ioctl: cmd %x, dev %d:%d\n", cmd, imajor(inode), iminor(inode));
 
@@ -2553,9 +2557,14 @@ static int pkt_ioctl(struct inode *inode
 	case PACKET_TEARDOWN_DEV:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (atomic_read(&pd->refcnt) != 1)
-			return -EBUSY;
-		return pkt_remove_dev(pd);
+		down(&pd->ctl_mutex);
+		BUG_ON(pd->refcnt < 1);
+		if (pd->refcnt != 1)
+			ret = -EBUSY;
+		else
+			ret = pkt_remove_dev(pd);
+		up(&pd->ctl_mutex);
+		return ret;
 
 	case BLKROSET:
 		if (capable(CAP_SYS_ADMIN))
@@ -2629,6 +2638,15 @@ int pkt_init(void)
 	for (i = 0; i < MAX_WRITERS; i++) {
 		struct pktcdvd_device *pd = &pkt_devs[i];
 		struct gendisk *disk = disks[i];
+
+		spin_lock_init(&pd->lock);
+		spin_lock_init(&pd->iosched.lock);
+		pd->pkt_dev = MKDEV(PACKET_MAJOR, i);
+		sprintf(pd->name, "pktcdvd%d", i);
+		init_waitqueue_head(&pd->wqueue);
+		init_MUTEX_LOCKED(&pd->cdrw.thr_sem);
+		init_MUTEX(&pd->ctl_mutex);
+
 		disk->major = PACKET_MAJOR;
 		disk->first_minor = i;
 		disk->fops = &pktcdvd_ops;
diff -puN include/linux/pktcdvd.h~packet-open-race-fix include/linux/pktcdvd.h
--- linux/include/linux/pktcdvd.h~packet-open-race-fix	2004-07-04 14:09:40.843062272 +0200
+++ linux-petero/include/linux/pktcdvd.h	2004-07-04 14:09:40.850061208 +0200
@@ -236,7 +236,8 @@ struct pktcdvd_device
 	char			name[20];
 	struct packet_settings	settings;
 	struct packet_stats	stats;
-	atomic_t		refcnt;
+	struct semaphore	ctl_mutex;	/* Serialize access to refcnt */
+	int			refcnt;		/* Open count */
 	__u8			write_speed;	/* current write speed */
 	__u8			read_speed;	/* current read speed */
 	unsigned long		offset;		/* start offset */
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
