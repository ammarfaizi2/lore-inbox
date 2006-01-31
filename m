Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWAaHHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWAaHHc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 02:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWAaHHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 02:07:32 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:31907
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030303AbWAaHHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 02:07:30 -0500
Date: Mon, 30 Jan 2006 23:07:25 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.15.2
Message-ID: <20060131070725.GB25015@kroah.com>
References: <20060131070642.GA25015@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131070642.GA25015@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index bbaa2fb..76a00d4 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 15
-EXTRAVERSION = .1
+EXTRAVERSION = .2
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 459c8fb..a22930d 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -280,9 +280,9 @@ static struct sparc64_tick_ops stick_ope
  * Since STICK is constantly updating, we have to access it carefully.
  *
  * The sequence we use to read is:
- * 1) read low
- * 2) read high
- * 3) read low again, if it rolled over increment high by 1
+ * 1) read high
+ * 2) read low
+ * 3) read high again, if it rolled re-read both low and high again.
  *
  * Writing STICK safely is also tricky:
  * 1) write low to zero
@@ -295,18 +295,18 @@ static struct sparc64_tick_ops stick_ope
 static unsigned long __hbird_read_stick(void)
 {
 	unsigned long ret, tmp1, tmp2, tmp3;
-	unsigned long addr = HBIRD_STICK_ADDR;
+	unsigned long addr = HBIRD_STICK_ADDR+8;
 
-	__asm__ __volatile__("ldxa	[%1] %5, %2\n\t"
-			     "add	%1, 0x8, %1\n\t"
-			     "ldxa	[%1] %5, %3\n\t"
+	__asm__ __volatile__("ldxa	[%1] %5, %2\n"
+			     "1:\n\t"
 			     "sub	%1, 0x8, %1\n\t"
+			     "ldxa	[%1] %5, %3\n\t"
+			     "add	%1, 0x8, %1\n\t"
 			     "ldxa	[%1] %5, %4\n\t"
 			     "cmp	%4, %2\n\t"
-			     "blu,a,pn	%%xcc, 1f\n\t"
-			     " add	%3, 1, %3\n"
-			     "1:\n\t"
-			     "sllx	%3, 32, %3\n\t"
+			     "bne,a,pn	%%xcc, 1b\n\t"
+			     " mov	%4, %2\n\t"
+			     "sllx	%4, 32, %4\n\t"
 			     "or	%3, %4, %0\n\t"
 			     : "=&r" (ret), "=&r" (addr),
 			       "=&r" (tmp1), "=&r" (tmp2), "=&r" (tmp3)
diff --git a/arch/x86_64/kernel/pci-gart.c b/arch/x86_64/kernel/pci-gart.c
index 2e28e85..b27b0ff 100644
--- a/arch/x86_64/kernel/pci-gart.c
+++ b/arch/x86_64/kernel/pci-gart.c
@@ -244,6 +244,7 @@ dma_alloc_coherent(struct device *dev, s
 					   get_order(size));
 
 				if (swiotlb) {
+					gfp &= ~(GFP_DMA32|GFP_DMA);
 					return
 					swiotlb_alloc_coherent(dev, size,
 							       dma_handle,
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 99c9ca6..bde9c4b 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -2609,30 +2609,6 @@ static inline int attempt_front_merge(re
 	return 0;
 }
 
-/**
- * blk_attempt_remerge  - attempt to remerge active head with next request
- * @q:    The &request_queue_t belonging to the device
- * @rq:   The head request (usually)
- *
- * Description:
- *    For head-active devices, the queue can easily be unplugged so quickly
- *    that proper merging is not done on the front request. This may hurt
- *    performance greatly for some devices. The block layer cannot safely
- *    do merging on that first request for these queues, but the driver can
- *    call this function and make it happen any way. Only the driver knows
- *    when it is safe to do so.
- **/
-void blk_attempt_remerge(request_queue_t *q, struct request *rq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	attempt_back_merge(q, rq);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-}
-
-EXPORT_SYMBOL(blk_attempt_remerge);
-
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
 	struct request *req;
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index b4d7a3e..741816a 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1332,8 +1332,6 @@ static ide_startstop_t cdrom_start_read 
 	if (cdrom_read_from_buffer(drive))
 		return ide_stopped;
 
-	blk_attempt_remerge(drive->queue, rq);
-
 	/* Clear the local sector buffer. */
 	info->nsectors_buffered = 0;
 
@@ -1874,14 +1872,6 @@ static ide_startstop_t cdrom_start_write
 		return ide_stopped;
 	}
 
-	/*
-	 * for dvd-ram and such media, it's a really big deal to get
-	 * big writes all the time. so scour the queue and attempt to
-	 * remerge requests, often the plugging will not have had time
-	 * to do this properly
-	 */
-	blk_attempt_remerge(drive->queue, rq);
-
 	info->nsectors_buffered = 0;
 
 	/* use dma, if possible. we don't need to check more, since we
diff --git a/drivers/message/i2o/i2o_scsi.c b/drivers/message/i2o/i2o_scsi.c
index 9f1744c..1c5c6c7 100644
--- a/drivers/message/i2o/i2o_scsi.c
+++ b/drivers/message/i2o/i2o_scsi.c
@@ -729,7 +729,7 @@ static int i2o_scsi_abort(struct scsi_cm
 	       &msg->u.head[1]);
 	writel(i2o_cntxt_list_get_ptr(c, SCpnt), &msg->body[0]);
 
-	if (i2o_msg_post_wait(c, m, I2O_TIMEOUT_SCSI_SCB_ABORT))
+	if (!i2o_msg_post_wait(c, msg, I2O_TIMEOUT_SCSI_SCB_ABORT))
 		status = SUCCESS;
 
 	return status;
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 3e9accf..f4424cf 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -515,6 +515,7 @@ static void ax_encaps(struct net_device 
 			count = kiss_esc(p, (unsigned char *)ax->xbuff, len);
 		}
   	}
+	spin_unlock_bh(&ax->buflock);
 
 	set_bit(TTY_DO_WRITE_WAKEUP, &ax->tty->flags);
 	actual = ax->tty->driver->write(ax->tty, ax->xbuff, count);
diff --git a/drivers/usb/input/pid.c b/drivers/usb/input/pid.c
index 19e015d..d9d9f65 100644
--- a/drivers/usb/input/pid.c
+++ b/drivers/usb/input/pid.c
@@ -259,7 +259,7 @@ static int hid_pid_upload_effect(struct 
 int hid_pid_init(struct hid_device *hid)
 {
 	struct hid_ff_pid *private;
-	struct hid_input *hidinput = list_entry(&hid->inputs, struct hid_input, list);
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
 	struct input_dev *input_dev = hidinput->input;
 
 	private = hid->ff_private = kzalloc(sizeof(struct hid_ff_pid), GFP_KERNEL);
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 42afb5b..9c38f10 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1131,7 +1131,7 @@ static void handle_attrs(struct super_bl
 			REISERFS_SB(s)->s_mount_opt &= ~(1 << REISERFS_ATTRS);
 		}
 	} else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) {
-		REISERFS_SB(s)->s_mount_opt |= REISERFS_ATTRS;
+		REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_ATTRS);
 	}
 }
 
diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index b264007..e45ad53 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -255,8 +255,8 @@ extern void _ubh_memcpyubh_(struct ufs_s
 	((struct ufs_super_block_first *)((ubh)->bh[0]->b_data))
 
 #define ubh_get_usb_second(ubh) \
-	((struct ufs_super_block_second *)(ubh)-> \
-	bh[UFS_SECTOR_SIZE >> uspi->s_fshift]->b_data + (UFS_SECTOR_SIZE & ~uspi->s_fmask))
+	((struct ufs_super_block_second *)((ubh)->\
+	bh[UFS_SECTOR_SIZE >> uspi->s_fshift]->b_data + (UFS_SECTOR_SIZE & ~uspi->s_fmask)))
 
 #define ubh_get_usb_third(ubh) \
 	((struct ufs_super_block_third *)((ubh)-> \
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a33a31e..4be1139 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -559,7 +559,6 @@ extern void register_disk(struct gendisk
 extern void generic_make_request(struct bio *bio);
 extern void blk_put_request(struct request *);
 extern void blk_end_sync_rq(struct request *rq);
-extern void blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, gfp_t);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_requeue_request(request_queue_t *, struct request *);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8c5d600..c461bc5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -927,7 +927,7 @@ static inline int skb_tailroom(const str
  *	Increase the headroom of an empty &sk_buff by reducing the tail
  *	room. This is only allowed for an empty buffer.
  */
-static inline void skb_reserve(struct sk_buff *skb, unsigned int len)
+static inline void skb_reserve(struct sk_buff *skb, int len)
 {
 	skb->data += len;
 	skb->tail += len;
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index c8943b5..565b2fa 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -598,15 +598,16 @@ static int mq_attr_ok(struct mq_attr *at
 static struct file *do_create(struct dentry *dir, struct dentry *dentry,
 			int oflag, mode_t mode, struct mq_attr __user *u_attr)
 {
-	struct file *filp;
 	struct mq_attr attr;
 	int ret;
 
-	if (u_attr != NULL) {
+	if (u_attr) {
+		ret = -EFAULT;
 		if (copy_from_user(&attr, u_attr, sizeof(attr)))
-			return ERR_PTR(-EFAULT);
+			goto out;
+		ret = -EINVAL;
 		if (!mq_attr_ok(&attr))
-			return ERR_PTR(-EINVAL);
+			goto out;
 		/* store for use during create */
 		dentry->d_fsdata = &attr;
 	}
@@ -615,13 +616,14 @@ static struct file *do_create(struct den
 	ret = vfs_create(dir->d_inode, dentry, mode, NULL);
 	dentry->d_fsdata = NULL;
 	if (ret)
-		return ERR_PTR(ret);
+		goto out;
 
-	filp = dentry_open(dentry, mqueue_mnt, oflag);
-	if (!IS_ERR(filp))
-		dget(dentry);
+	return dentry_open(dentry, mqueue_mnt, oflag);
 
-	return filp;
+out:
+	dput(dentry);
+	mntput(mqueue_mnt);
+	return ERR_PTR(ret);
 }
 
 /* Opens existing queue */
@@ -629,20 +631,20 @@ static struct file *do_open(struct dentr
 {
 static int oflag2acc[O_ACCMODE] = { MAY_READ, MAY_WRITE,
 					MAY_READ | MAY_WRITE };
-	struct file *filp;
 
-	if ((oflag & O_ACCMODE) == (O_RDWR | O_WRONLY))
+	if ((oflag & O_ACCMODE) == (O_RDWR | O_WRONLY)) {
+		dput(dentry);
+		mntput(mqueue_mnt);
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (permission(dentry->d_inode, oflag2acc[oflag & O_ACCMODE], NULL))
+	if (permission(dentry->d_inode, oflag2acc[oflag & O_ACCMODE], NULL)) {
+		dput(dentry);
+		mntput(mqueue_mnt);
 		return ERR_PTR(-EACCES);
+	}
 
-	filp = dentry_open(dentry, mqueue_mnt, oflag);
-
-	if (!IS_ERR(filp))
-		dget(dentry);
-
-	return filp;
+	return dentry_open(dentry, mqueue_mnt, oflag);
 }
 
 asmlinkage long sys_mq_open(const char __user *u_name, int oflag, mode_t mode,
@@ -670,17 +672,20 @@ asmlinkage long sys_mq_open(const char _
 
 	if (oflag & O_CREAT) {
 		if (dentry->d_inode) {	/* entry already exists */
-			filp = (oflag & O_EXCL) ? ERR_PTR(-EEXIST) :
-					do_open(dentry, oflag);
+			error = -EEXIST;
+			if (oflag & O_EXCL)
+				goto out;
+			filp = do_open(dentry, oflag);
 		} else {
 			filp = do_create(mqueue_mnt->mnt_root, dentry,
 						oflag, mode, u_attr);
 		}
-	} else
-		filp = (dentry->d_inode) ? do_open(dentry, oflag) :
-					ERR_PTR(-ENOENT);
-
-	dput(dentry);
+	} else {
+		error = -ENOENT;
+		if (!dentry->d_inode)
+			goto out;
+		filp = do_open(dentry, oflag);
+	}
 
 	if (IS_ERR(filp)) {
 		error = PTR_ERR(filp);
@@ -691,8 +696,10 @@ asmlinkage long sys_mq_open(const char _
 	fd_install(fd, filp);
 	goto out_upsem;
 
-out_putfd:
+out:
+	dput(dentry);
 	mntput(mqueue_mnt);
+out_putfd:
 	put_unused_fd(fd);
 out_err:
 	fd = error;
diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index 99dae02..78b0316 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -480,22 +480,38 @@ static int retire_playback_sync_urb_hs(s
 /*
  * Prepare urb for streaming before playback starts.
  *
- * We don't care about (or have) any data, so we just send a transfer delimiter.
+ * We don't yet have data, so we send a frame of silence.
  */
 static int prepare_startup_playback_urb(snd_usb_substream_t *subs,
 					snd_pcm_runtime_t *runtime,
 					struct urb *urb)
 {
-	unsigned int i;
+	unsigned int i, offs, counts;
 	snd_urb_ctx_t *ctx = urb->context;
+	int stride = runtime->frame_bits >> 3;
 
+	offs = 0;
 	urb->dev = ctx->subs->dev;
 	urb->number_of_packets = subs->packs_per_ms;
 	for (i = 0; i < subs->packs_per_ms; ++i) {
-		urb->iso_frame_desc[i].offset = 0;
-		urb->iso_frame_desc[i].length = 0;
+		/* calculate the size of a packet */
+		if (subs->fill_max)
+			counts = subs->maxframesize; /* fixed */
+		else {
+			subs->phase = (subs->phase & 0xffff)
+				+ (subs->freqm << subs->datainterval);
+			counts = subs->phase >> 16;
+			if (counts > subs->maxframesize)
+				counts = subs->maxframesize;
+		}
+		urb->iso_frame_desc[i].offset = offs * stride;
+		urb->iso_frame_desc[i].length = counts * stride;
+		offs += counts;
 	}
-	urb->transfer_buffer_length = 0;
+	urb->transfer_buffer_length = offs * stride;
+	memset(urb->transfer_buffer,
+	       subs->cur_audiofmt->format == SNDRV_PCM_FORMAT_U8 ? 0x80 : 0,
+	       offs * stride);
 	return 0;
 }
 
