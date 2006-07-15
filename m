Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946017AbWGOK6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946017AbWGOK6w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 06:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946021AbWGOK6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 06:58:52 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:2434 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1946017AbWGOK6v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 06:58:51 -0400
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Arjan van de Ven <arjan@linux.intel.com>, mingo@elte.hu, akpm@osdl.org,
       Kernel development list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [patch] lockdep: annotate pktcdvd natural device hierarchy
References: <448875D1.5080905@free.fr> <448D84C0.1070400@linux.intel.com>
	<m3sllxtfbf.fsf@telia.com>
	<1151000451.3120.56.camel@laptopd505.fenrus.org>
	<m3u05kqvla.fsf@telia.com>
	<1152884770.3159.37.camel@laptopd505.fenrus.org>
	<m3odvrc2vo.fsf@telia.com>
	<1152947098.3114.9.camel@laptopd505.fenrus.org>
	<44B8C506.1000009@free.fr>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Jul 2006 12:57:38 +0200
In-Reply-To: <44B8C506.1000009@free.fr>
Message-ID: <m3ac7b6spp.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard <laurent.riffard@free.fr> writes:

> Le 15.07.2006 09:04, Arjan van de Ven a écrit :
>
> Thanks Arjan, this seems to solve the initial issue of this thread, 
> which was "possible circular locking deadlock detected!" while 
> doing "pktsetup dvd /dev/dvd".
> 
> So here is the next step :-(. I'm now running 2.6.18-rc1-mm2 and I was able 
> to successfully run:
> - modprobe ptkcdvd
> - pktsetup dvd /dev/dvd
> 
> Then I inserted a UDF-formatted CD-RW in the CD/DVD burner and I typed 
> this command :
> - mount -oro -tauto /dev/pktcdvd/dvd /mnt/cdrom 
> The following happened :
> 
> pktcdvd: writer pktcdvd0 mapped to hdc
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------

I got the same problem. This patch fixes it in my case. I'm not sure
if using the *_partition() functions is the right thing to do, but the
device mapper code is using those functions in similar situations.

 drivers/block/pktcdvd.c |   12 ++++++------
 fs/block_dev.c          |    7 +++----
 include/linux/fs.h      |    1 +
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index f87d1a8..ccded00 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1922,7 +1922,7 @@ static int pkt_open_dev(struct pktcdvd_d
 	 * so bdget() can't fail.
 	 */
 	bdget(pd->bdev->bd_dev);
-	if ((ret = blkdev_get(pd->bdev, FMODE_READ, O_RDONLY)))
+	if ((ret = blkdev_get_partition(pd->bdev, FMODE_READ, O_RDONLY)))
 		goto out;
 
 	if ((ret = bd_claim(pd->bdev, pd)))
@@ -1971,7 +1971,7 @@ static int pkt_open_dev(struct pktcdvd_d
 out_unclaim:
 	bd_release(pd->bdev);
 out_putdev:
-	blkdev_put(pd->bdev);
+	blkdev_put_partition(pd->bdev);
 out:
 	return ret;
 }
@@ -1989,7 +1989,7 @@ static void pkt_release_dev(struct pktcd
 
 	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
 	bd_release(pd->bdev);
-	blkdev_put(pd->bdev);
+	blkdev_put_partition(pd->bdev);
 
 	pkt_shrink_pktlist(pd);
 }
@@ -2339,7 +2339,7 @@ static int pkt_new_dev(struct pktcdvd_de
 	bdev = bdget(dev);
 	if (!bdev)
 		return -ENOMEM;
-	ret = blkdev_get(bdev, FMODE_READ, O_RDONLY | O_NONBLOCK);
+	ret = blkdev_get_partition(bdev, FMODE_READ, O_RDONLY | O_NONBLOCK);
 	if (ret)
 		return ret;
 
@@ -2368,7 +2368,7 @@ static int pkt_new_dev(struct pktcdvd_de
 	return 0;
 
 out_mem:
-	blkdev_put(bdev);
+	blkdev_put_partition(bdev);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	return ret;
@@ -2530,7 +2530,7 @@ static int pkt_remove_dev(struct pkt_ctr
 	if (!IS_ERR(pd->cdrw.thread))
 		kthread_stop(pd->cdrw.thread);
 
-	blkdev_put(pd->bdev);
+	blkdev_put_partition(pd->bdev);
 
 	remove_proc_entry(pd->name, pkt_proc);
 	DPRINTK("pktcdvd: writer %s unmapped\n", pd->name);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index b721bb6..642e9b2 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -822,9 +822,6 @@ struct block_device *open_by_devnum(dev_
 
 EXPORT_SYMBOL(open_by_devnum);
 
-static int
-blkdev_get_partition(struct block_device *bdev, mode_t mode, unsigned flags);
-
 struct block_device *open_partition_by_devnum(dev_t dev, unsigned mode)
 {
 	struct block_device *bdev = bdget(dev);
@@ -1031,7 +1028,7 @@ blkdev_get_whole(struct block_device *bd
 	return do_open(bdev, &fake_file, BD_MUTEX_WHOLE);
 }
 
-static int
+int
 blkdev_get_partition(struct block_device *bdev, mode_t mode, unsigned flags)
 {
 	/*
@@ -1050,6 +1047,8 @@ blkdev_get_partition(struct block_device
 	return do_open(bdev, &fake_file, BD_MUTEX_PARTITION);
 }
 
+EXPORT_SYMBOL(blkdev_get_partition);
+
 static int blkdev_open(struct inode * inode, struct file * filp)
 {
 	struct block_device *bdev;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b9f1c18..10f8c56 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1455,6 +1455,7 @@ extern int ioctl_by_bdev(struct block_de
 extern int blkdev_ioctl(struct block_device *, struct file *, unsigned, unsigned long);
 extern long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 extern int blkdev_get(struct block_device *, mode_t, unsigned);
+extern int blkdev_get_partition(struct block_device *, mode_t, unsigned);
 extern int blkdev_put(struct block_device *);
 extern int blkdev_put_partition(struct block_device *);
 extern int bd_claim(struct block_device *, void *);

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
