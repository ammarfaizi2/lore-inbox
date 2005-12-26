Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVLZWw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVLZWw5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 17:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVLZWw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 17:52:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53440 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751090AbVLZWw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 17:52:56 -0500
Date: Mon, 26 Dec 2005 14:52:28 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Dave Jones <davej@redhat.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, zaitcev@redhat.com,
       jgarzik@pobox.com
Subject: Re: 2.6.15rc5git1 cfq related spinlock bad magic
Message-Id: <20051226145228.6eba3980.zaitcev@redhat.com>
In-Reply-To: <20051209185521.GC7473@redhat.com>
References: <20051208045048.GC24356@redhat.com>
	<20051209104150.GF26185@suse.de>
	<20051209185521.GC7473@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.8; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2005 13:55:21 -0500, Dave Jones <davej@redhat.com> wrote:

>  > > [311578.273186] BUG: spinlock bad magic on CPU#1, pdflush/30788 (Not tainted)
>[...]
>  > > [311578.499972] RIP: 0010:[<ffffffff8021f8bd>] <ffffffff8021f8bd>{spin_bug+138}
>  > > [311578.798449] Call Trace:<ffffffff8021fbdb>{_raw_spin_lock+25} <ffffffff802174a4>{cfq_exit_single_io_context+85}
>  > > [311578.828782]        <ffffffff80217527>{cfq_exit_io_context+33} <ffffffff8020d07d>{exit_io_context+137}
>  > > [311578.856762]        <ffffffff8013f937>{do_exit+183} <ffffffff80152c90>{keventd_create_kthread+0}
>  > > [311578.883192]        <ffffffff80110c25>{child_rip+15} <ffffffff80152c90>{keventd_create_kthread+0}
>  > > [311578.909852]        <ffffffff80152d86>{kthread+0} <ffffffff80110c16>{child_rip+0}

> Hmm, I may have also been experimenting at the time with Pete Zaitcev's
> ub driver. Pete, could ub have been doing something bad here?

Yes, this is ub's fault. I thought that blk_cleanup_queue frees the queue,
but this is not the case. In recent kernels, it only decrements its refcount.
If CFQ is around, it keeps the queue pinned and uses the queue's spinlock.
But when ub calls blk_init_queue(), it passes a spinlock located in its data
structure (ub_dev), which corresponds to a device. The ub_dev is refcounted
and freed when the device is disconnected or closed. As you can see, this
leaves the queue's spinlock pointer dangling.

The code was taken from Carmel, and it used to work fine for a long time.
I suspect now that Carmel is vulnerable, if it's hot-removed while open.
Maybe Jeff wants to look into it.

The usb-storage is immune to this problem, because SCSI passes NULL to
blk_init_queue.

Schedulers other than CFQ use their own spinlocks, so they do not hit
this problem.

The attached patch works around this issue by using spinlocks which are
static to the ub module. Thus, it places ub into the same group as floppy.
This is not ideal, in case someone manages to remove the module yet have
queues remaining... But I am reluctant to copy what scsi_request_fn is
doing. After all, ub is supposed to be simpler.

Any comments before I send this to Greg?

With Christmas cheers,
-- Pete

--- linux-2.6.15-rc7/drivers/block/ub.c	2005-12-26 01:25:03.000000000 -0800
+++ linux-2.6.15-rc7-locktest/drivers/block/ub.c	2005-12-26 13:56:09.000000000 -0800
@@ -356,7 +356,7 @@ struct ub_lun {
  * The USB device instance.
  */
 struct ub_dev {
-	spinlock_t lock;
+	spinlock_t *lock;
 	atomic_t poison;		/* The USB device is disconnected */
 	int openc;			/* protected by ub_lock! */
 					/* kref is too implicit for our taste */
@@ -440,6 +440,10 @@ MODULE_DEVICE_TABLE(usb, ub_usb_ids);
 #define UB_MAX_HOSTS  26
 static char ub_hostv[UB_MAX_HOSTS];
 
+#define UB_QLOCK_NUM 5
+static spinlock_t ub_qlockv[UB_QLOCK_NUM];
+static int ub_qlock_next = 0;
+
 static DEFINE_SPINLOCK(ub_lock);	/* Locks globals and ->openc */
 
 /*
@@ -519,7 +523,7 @@ static ssize_t ub_diag_show(struct devic
 		return 0;
 
 	cnt = 0;
-	spin_lock_irqsave(&sc->lock, flags);
+	spin_lock_irqsave(sc->lock, flags);
 
 	cnt += sprintf(page + cnt,
 	    "qlen %d qmax %d\n",
@@ -564,7 +568,7 @@ static ssize_t ub_diag_show(struct devic
 		if (++nc == SCMD_TRACE_SZ) nc = 0;
 	}
 
-	spin_unlock_irqrestore(&sc->lock, flags);
+	spin_unlock_irqrestore(sc->lock, flags);
 	return cnt;
 }
 
@@ -612,6 +616,24 @@ static void ub_id_put(int id)
 }
 
 /*
+ * This is necessitated by the fact that blk_cleanup_queue does not
+ * necesserily destroy the queue. Instead, it may merely decrease q->refcnt.
+ * Since our blk_init_queue() passes a spinlock common with ub_dev,
+ * we have life time issues when ub_cleanup frees ub_dev.
+ */
+static spinlock_t *ub_next_lock(void)
+{
+	unsigned long flags;
+	spinlock_t *ret;
+
+	spin_lock_irqsave(&ub_lock, flags);
+	ret = &ub_qlockv[ub_qlock_next];
+	ub_qlock_next = (ub_qlock_next + 1) % UB_QLOCK_NUM;
+	spin_unlock_irqrestore(&ub_lock, flags);
+	return ret;
+}
+
+/*
  * Downcount for deallocation. This rides on two assumptions:
  *  - once something is poisoned, its refcount cannot grow
  *  - opens cannot happen at this time (del_gendisk was done)
@@ -1039,9 +1061,9 @@ static void ub_urb_timeout(unsigned long
 	struct ub_dev *sc = (struct ub_dev *) arg;
 	unsigned long flags;
 
-	spin_lock_irqsave(&sc->lock, flags);
+	spin_lock_irqsave(sc->lock, flags);
 	usb_unlink_urb(&sc->work_urb);
-	spin_unlock_irqrestore(&sc->lock, flags);
+	spin_unlock_irqrestore(sc->lock, flags);
 }
 
 /*
@@ -1064,10 +1086,10 @@ static void ub_scsi_action(unsigned long
 	struct ub_dev *sc = (struct ub_dev *) _dev;
 	unsigned long flags;
 
-	spin_lock_irqsave(&sc->lock, flags);
+	spin_lock_irqsave(sc->lock, flags);
 	del_timer(&sc->work_timer);
 	ub_scsi_dispatch(sc);
-	spin_unlock_irqrestore(&sc->lock, flags);
+	spin_unlock_irqrestore(sc->lock, flags);
 }
 
 static void ub_scsi_dispatch(struct ub_dev *sc)
@@ -1836,11 +1858,11 @@ static int ub_sync_tur(struct ub_dev *sc
 	cmd->done = ub_probe_done;
 	cmd->back = &compl;
 
-	spin_lock_irqsave(&sc->lock, flags);
+	spin_lock_irqsave(sc->lock, flags);
 	cmd->tag = sc->tagcnt++;
 
 	rc = ub_submit_scsi(sc, cmd);
-	spin_unlock_irqrestore(&sc->lock, flags);
+	spin_unlock_irqrestore(sc->lock, flags);
 
 	if (rc != 0) {
 		printk("ub: testing ready: submit error (%d)\n", rc); /* P3 */
@@ -1898,11 +1920,11 @@ static int ub_sync_read_cap(struct ub_de
 	cmd->done = ub_probe_done;
 	cmd->back = &compl;
 
-	spin_lock_irqsave(&sc->lock, flags);
+	spin_lock_irqsave(sc->lock, flags);
 	cmd->tag = sc->tagcnt++;
 
 	rc = ub_submit_scsi(sc, cmd);
-	spin_unlock_irqrestore(&sc->lock, flags);
+	spin_unlock_irqrestore(sc->lock, flags);
 
 	if (rc != 0) {
 		printk("ub: reading capacity: submit error (%d)\n", rc); /* P3 */
@@ -2176,7 +2198,7 @@ static int ub_probe(struct usb_interface
 	if ((sc = kmalloc(sizeof(struct ub_dev), GFP_KERNEL)) == NULL)
 		goto err_core;
 	memset(sc, 0, sizeof(struct ub_dev));
-	spin_lock_init(&sc->lock);
+	sc->lock = ub_next_lock();
 	INIT_LIST_HEAD(&sc->luns);
 	usb_init_urb(&sc->work_urb);
 	tasklet_init(&sc->tasklet, ub_scsi_action, (unsigned long)sc);
@@ -2322,7 +2344,7 @@ static int ub_probe_lun(struct ub_dev *s
 	disk->driverfs_dev = &sc->intf->dev;
 
 	rc = -ENOMEM;
-	if ((q = blk_init_queue(ub_request_fn, &sc->lock)) == NULL)
+	if ((q = blk_init_queue(ub_request_fn, sc->lock)) == NULL)
 		goto err_blkqinit;
 
 	disk->queue = q;
@@ -2388,7 +2410,7 @@ static void ub_disconnect(struct usb_int
 	 * and the whole queue drains. So, we just use this code to
 	 * print warnings.
 	 */
-	spin_lock_irqsave(&sc->lock, flags);
+	spin_lock_irqsave(sc->lock, flags);
 	{
 		struct ub_scsi_cmd *cmd;
 		int cnt = 0;
@@ -2405,7 +2427,7 @@ static void ub_disconnect(struct usb_int
 			    "%d was queued after shutdown\n", sc->name, cnt);
 		}
 	}
-	spin_unlock_irqrestore(&sc->lock, flags);
+	spin_unlock_irqrestore(sc->lock, flags);
 
 	/*
 	 * Unregister the upper layer.
@@ -2424,19 +2446,15 @@ static void ub_disconnect(struct usb_int
 	}
 
 	/*
-	 * Taking a lock on a structure which is about to be freed
-	 * is very nonsensual. Here it is largely a way to do a debug freeze,
-	 * and a bracket which shows where the nonsensual code segment ends.
-	 *
 	 * Testing for -EINPROGRESS is always a bug, so we are bending
 	 * the rules a little.
 	 */
-	spin_lock_irqsave(&sc->lock, flags);
+	spin_lock_irqsave(sc->lock, flags);
 	if (sc->work_urb.status == -EINPROGRESS) {	/* janitors: ignore */
 		printk(KERN_WARNING "%s: "
 		    "URB is active after disconnect\n", sc->name);
 	}
-	spin_unlock_irqrestore(&sc->lock, flags);
+	spin_unlock_irqrestore(sc->lock, flags);
 
 	/*
 	 * There is virtually no chance that other CPU runs times so long
@@ -2471,6 +2489,10 @@ static struct usb_driver ub_driver = {
 static int __init ub_init(void)
 {
 	int rc;
+	int i;
+
+	for (i = 0; i < UB_QLOCK_NUM; i++)
+		spin_lock_init(&ub_qlockv[i]);
 
 	if ((rc = register_blkdev(UB_MAJOR, DRV_NAME)) != 0)
 		goto err_regblkdev;
