Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422842AbWJRULL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422842AbWJRULL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422826AbWJRUKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:10:00 -0400
Received: from cantor2.suse.de ([195.135.220.15]:27882 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422824AbWJRUJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:25 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 6/15] aoe: clean up printks via macros
Date: Wed, 18 Oct 2006 13:08:57 -0700
Message-Id: <11612021641240-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021601016-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com> <11612021491255-git-send-email-greg@kroah.com> <1161202152750-git-send-email-greg@kroah.com> <11612021563910-git-send-email-greg@kroah.com> <11612021601016-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

Use simple macros to clean up the printks.
(This patch is reverted by the 14th patch to follow.)

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoe.h     |    5 ++++
 drivers/block/aoe/aoeblk.c  |   16 +++++-------
 drivers/block/aoe/aoechr.c  |   13 ++++------
 drivers/block/aoe/aoecmd.c  |   57 ++++++++++++++++++++-----------------------
 drivers/block/aoe/aoedev.c  |    2 +-
 drivers/block/aoe/aoemain.c |    8 ++----
 drivers/block/aoe/aoenet.c  |    7 ++---
 7 files changed, 50 insertions(+), 58 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 1cec199..4d79f1e 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -10,6 +10,11 @@ #ifndef AOE_PARTITIONS
 #define AOE_PARTITIONS (16)
 #endif
 
+#define xprintk(L, fmt, arg...) printk(L "aoe: " "%s: " fmt, __func__, ## arg)
+#define iprintk(fmt, arg...) xprintk(KERN_INFO, fmt, ## arg)
+#define eprintk(fmt, arg...) xprintk(KERN_ERR, fmt, ## arg)
+#define dprintk(fmt, arg...) xprintk(KERN_DEBUG, fmt, ## arg)
+
 #define SYSMINOR(aoemajor, aoeminor) ((aoemajor) * NPERSHELF + (aoeminor))
 #define AOEMAJOR(sysminor) ((sysminor) / NPERSHELF)
 #define AOEMINOR(sysminor) ((sysminor) % NPERSHELF)
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index fa0e8ca..a7dbe6f 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -132,8 +132,7 @@ aoeblk_make_request(request_queue_t *q, 
 	d = bio->bi_bdev->bd_disk->private_data;
 	buf = mempool_alloc(d->bufpool, GFP_NOIO);
 	if (buf == NULL) {
-		printk(KERN_INFO "aoe: aoeblk_make_request: buf allocation "
-			"failure\n");
+		iprintk("buf allocation failure\n");
 		bio_endio(bio, bio->bi_size, -ENOMEM);
 		return 0;
 	}
@@ -150,8 +149,7 @@ aoeblk_make_request(request_queue_t *q, 
 	spin_lock_irqsave(&d->lock, flags);
 
 	if ((d->flags & DEVFL_UP) == 0) {
-		printk(KERN_INFO "aoe: aoeblk_make_request: device %ld.%ld is not up\n",
-			d->aoemajor, d->aoeminor);
+		iprintk("device %ld.%ld is not up\n", d->aoemajor, d->aoeminor);
 		spin_unlock_irqrestore(&d->lock, flags);
 		mempool_free(buf, d->bufpool);
 		bio_endio(bio, bio->bi_size, -ENXIO);
@@ -176,7 +174,7 @@ aoeblk_getgeo(struct block_device *bdev,
 	struct aoedev *d = bdev->bd_disk->private_data;
 
 	if ((d->flags & DEVFL_UP) == 0) {
-		printk(KERN_ERR "aoe: aoeblk_ioctl: disk not up\n");
+		eprintk("disk not up\n");
 		return -ENODEV;
 	}
 
@@ -203,8 +201,8 @@ aoeblk_gdalloc(void *vp)
 
 	gd = alloc_disk(AOE_PARTITIONS);
 	if (gd == NULL) {
-		printk(KERN_ERR "aoe: aoeblk_gdalloc: cannot allocate disk "
-			"structure for %ld.%ld\n", d->aoemajor, d->aoeminor);
+		eprintk("cannot allocate disk structure for %ld.%ld\n",
+			d->aoemajor, d->aoeminor);
 		spin_lock_irqsave(&d->lock, flags);
 		d->flags &= ~DEVFL_GDALLOC;
 		spin_unlock_irqrestore(&d->lock, flags);
@@ -213,8 +211,8 @@ aoeblk_gdalloc(void *vp)
 
 	d->bufpool = mempool_create_slab_pool(MIN_BUFS, buf_pool_cache);
 	if (d->bufpool == NULL) {
-		printk(KERN_ERR "aoe: aoeblk_gdalloc: cannot allocate bufpool "
-			"for %ld.%ld\n", d->aoemajor, d->aoeminor);
+		eprintk("cannot allocate bufpool for %ld.%ld\n",
+			d->aoemajor, d->aoeminor);
 		put_disk(gd);
 		spin_lock_irqsave(&d->lock, flags);
 		d->flags &= ~DEVFL_GDALLOC;
diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index 2b5256c..f5cab69 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -55,9 +55,7 @@ static int
 interfaces(const char __user *str, size_t size)
 {
 	if (set_aoe_iflist(str, size)) {
-		printk(KERN_CRIT
-		       "%s: could not set interface list: %s\n",
-		       __FUNCTION__, "too many interfaces");
+		eprintk("could not set interface list: too many interfaces\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -80,8 +78,7 @@ revalidate(const char __user *str, size_
 	/* should be e%d.%d format */
 	n = sscanf(buf, "e%d.%d", &major, &minor);
 	if (n != 2) {
-		printk(KERN_ERR "aoe: %s: invalid device specification\n",
-			__FUNCTION__);
+		eprintk("invalid device specification\n");
 		return -EINVAL;
 	}
 	d = aoedev_by_aoeaddr(major, minor);
@@ -116,7 +113,7 @@ bail:		spin_unlock_irqrestore(&emsgs_loc
 
 	mp = kmalloc(n, GFP_ATOMIC);
 	if (mp == NULL) {
-		printk(KERN_CRIT "aoe: aoechr_error: allocation failure, len=%ld\n", n);
+		eprintk("allocation failure, len=%ld\n", n);
 		goto bail;
 	}
 
@@ -141,7 +138,7 @@ aoechr_write(struct file *filp, const ch
 
 	switch ((unsigned long) filp->private_data) {
 	default:
-		printk(KERN_INFO "aoe: aoechr_write: can't write to that file.\n");
+		iprintk("can't write to that file.\n");
 		break;
 	case MINOR_DISCOVER:
 		ret = discover();
@@ -250,7 +247,7 @@ aoechr_init(void)
 
 	n = register_chrdev(AOE_MAJOR, "aoechr", &aoe_fops);
 	if (n < 0) { 
-		printk(KERN_ERR "aoe: aoechr_init: can't register char device\n");
+		eprintk("can't register char device\n");
 		return n;
 	}
 	sema_init(&emsgs_sema, 0);
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 666797d..63c4560 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -155,7 +155,7 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 	buf->nframesout += 1;
 	buf->bufaddr += bcnt;
 	buf->bv_resid -= bcnt;
-/* printk(KERN_INFO "aoe: bv_resid=%ld\n", buf->bv_resid); */
+/* dprintk("bv_resid=%ld\n", buf->bv_resid); */
 	buf->resid -= bcnt;
 	buf->sector += bcnt >> 9;
 	if (buf->resid == 0) {
@@ -197,7 +197,7 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigne
 
 		skb = new_skb(sizeof *h + sizeof *ch);
 		if (skb == NULL) {
-			printk(KERN_INFO "aoe: aoecmd_cfg: skb alloc failure\n");
+			iprintk("skb alloc failure\n");
 			continue;
 		}
 		skb->dev = ifp;
@@ -247,7 +247,7 @@ loop:
 			return;
 		buf = container_of(d->bufq.next, struct buf, bufs);
 		list_del(d->bufq.next);
-/*printk(KERN_INFO "aoecmd_work: bi_size=%ld\n", buf->bio->bi_size); */
+/*dprintk("bi_size=%ld\n", buf->bio->bi_size); */
 		d->inprocess = buf;
 	}
 	aoecmd_ata_rw(d, f);
@@ -287,8 +287,7 @@ rexmit(struct aoedev *d, struct frame *f
 				offset_in_page(f->bufaddr), DEFAULTBCNT);
 		if (++d->lostjumbo > (d->nframes << 1))
 		if (d->maxbcnt != DEFAULTBCNT) {
-			printk(KERN_INFO "aoe: rexmit: too many lost jumbo.  "
-				"dropping back to 1KB frames.\n");
+			iprintk("too many lost jumbo - using 1KB frames.\n");
 			d->maxbcnt = DEFAULTBCNT;
 			d->flags |= DEVFL_MAXBCNT;
 		}
@@ -435,8 +434,8 @@ ataid_complete(struct aoedev *d, unsigne
 	}
 
 	if (d->ssize != ssize)
-		printk(KERN_INFO "aoe: %012llx e%lu.%lu v%04x has %llu "
-			"sectors\n", (unsigned long long)mac_addr(d->addr),
+		iprintk("%012llx e%lu.%lu v%04x has %llu sectors\n",
+			(unsigned long long)mac_addr(d->addr),
 			d->aoemajor, d->aoeminor,
 			d->fw_ver, (long long)ssize);
 	d->ssize = ssize;
@@ -446,11 +445,9 @@ ataid_complete(struct aoedev *d, unsigne
 		d->flags |= DEVFL_NEWSIZE;
 	} else {
 		if (d->flags & DEVFL_GDALLOC) {
-			printk(KERN_INFO "aoe: %s: %s e%lu.%lu, %s\n",
-			       __FUNCTION__,
-			       "can't schedule work for",
+			eprintk("can't schedule work for e%lu.%lu, %s\n",
 			       d->aoemajor, d->aoeminor,
-			       "it's already on! (This really shouldn't happen).\n");
+			       "it's already on!  This shouldn't happen.\n");
 			return;
 		}
 		d->flags |= DEVFL_GDALLOC;
@@ -524,8 +521,7 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 	if (ahout->cmdstat == WIN_IDENTIFY)
 		d->flags &= ~DEVFL_PAUSE;
 	if (ahin->cmdstat & 0xa9) {	/* these bits cleared on success */
-		printk(KERN_CRIT "aoe: aoecmd_ata_rsp: ata error cmd=%2.2Xh "
-			"stat=%2.2Xh from e%ld.%ld\n", 
+		eprintk("ata error cmd=%2.2Xh stat=%2.2Xh from e%ld.%ld\n",
 			ahout->cmdstat, ahin->cmdstat,
 			d->aoemajor, d->aoeminor);
 		if (buf)
@@ -536,8 +532,7 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 		case WIN_READ:
 		case WIN_READ_EXT:
 			if (skb->len - sizeof *hin - sizeof *ahin < n) {
-				printk(KERN_CRIT "aoe: aoecmd_ata_rsp: runt "
-					"ata data size in read.  skb->len=%d\n",
+				eprintk("runt data size in read.  skb->len=%d\n",
 					skb->len);
 				/* fail frame f?  just returning will rexmit. */
 				spin_unlock_irqrestore(&d->lock, flags);
@@ -549,10 +544,13 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 			if (f->bcnt -= n) {
 				f->bufaddr += n;
 				put_lba(ahout, f->lba += ahout->scnt);
-				n = f->bcnt > DEFAULTBCNT ? DEFAULTBCNT : f->bcnt;
+				n = f->bcnt;
+				if (n > DEFAULTBCNT)
+					n = DEFAULTBCNT;
 				ahout->scnt = n >> 9;
 				if (ahout->aflags & AOEAFL_WRITE)
-					skb_fill_page_desc(f->skb, 0, virt_to_page(f->bufaddr),
+					skb_fill_page_desc(f->skb, 0,
+						virt_to_page(f->bufaddr),
 						offset_in_page(f->bufaddr), n);
 				skb_get(f->skb);
 				f->skb->next = NULL;
@@ -565,19 +563,18 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 			break;
 		case WIN_IDENTIFY:
 			if (skb->len - sizeof *hin - sizeof *ahin < 512) {
-				printk(KERN_INFO "aoe: aoecmd_ata_rsp: runt data size "
-					"in ataid.  skb->len=%d\n", skb->len);
+				iprintk("runt data size in ataid.  skb->len=%d\n",
+					skb->len);
 				spin_unlock_irqrestore(&d->lock, flags);
 				return;
 			}
 			ataid_complete(d, (char *) (ahin+1));
 			break;
 		default:
-			printk(KERN_INFO "aoe: aoecmd_ata_rsp: unrecognized "
-			       "outbound ata command %2.2Xh for %d.%d\n", 
-			       ahout->cmdstat,
-			       be16_to_cpu(hin->major),
-			       hin->minor);
+			iprintk("unrecognized ata command %2.2Xh for %d.%d\n",
+				ahout->cmdstat,
+				be16_to_cpu(hin->major),
+				hin->minor);
 		}
 	}
 
@@ -634,8 +631,7 @@ aoecmd_ata_id(struct aoedev *d)
 
 	f = getframe(d, FREETAG);
 	if (f == NULL) {
-		printk(KERN_CRIT "aoe: aoecmd_ata_id: can't get a frame.  "
-			"This shouldn't happen.\n");
+		eprintk("can't get a frame. This shouldn't happen.\n");
 		return NULL;
 	}
 
@@ -682,15 +678,14 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	 */
 	aoemajor = be16_to_cpu(h->major);
 	if (aoemajor == 0xfff) {
-		printk(KERN_CRIT "aoe: aoecmd_cfg_rsp: Warning: shelf "
-			"address is all ones.  Check shelf dip switches\n");
+		eprintk("Warning: shelf address is all ones.  "
+			"Check shelf dip switches.\n");
 		return;
 	}
 
 	sysminor = SYSMINOR(aoemajor, h->minor);
 	if (sysminor * AOE_PARTITIONS + AOE_PARTITIONS > MINORMASK) {
-		printk(KERN_INFO
-			"aoe: e%ld.%d: minor number too large\n", 
+		iprintk("e%ld.%d: minor number too large\n",
 			aoemajor, (int) h->minor);
 		return;
 	}
@@ -701,7 +696,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 
 	d = aoedev_by_sysminor_m(sysminor, n);
 	if (d == NULL) {
-		printk(KERN_INFO "aoe: aoecmd_cfg_rsp: device sysminor_m failure\n");
+		iprintk("device sysminor_m failure\n");
 		return;
 	}
 
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index abf1d3c..f51d87b 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -155,7 +155,7 @@ aoedev_by_sysminor_m(ulong sysminor, ulo
 		d = aoedev_newdev(bufcnt);
 	 	if (d == NULL) {
 			spin_unlock_irqrestore(&devlist_lock, flags);
-			printk(KERN_INFO "aoe: aoedev_set: aoedev_newdev failure.\n");
+			iprintk("aoedev_newdev failure.\n");
 			return NULL;
 		}
 		d->sysminor = sysminor;
diff --git a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
index 727c34d..13e634d 100644
--- a/drivers/block/aoe/aoemain.c
+++ b/drivers/block/aoe/aoemain.c
@@ -84,13 +84,11 @@ aoe_init(void)
 		goto net_fail;
 	ret = register_blkdev(AOE_MAJOR, DEVICE_NAME);
 	if (ret < 0) {
-		printk(KERN_ERR "aoe: aoeblk_init: can't register major\n");
+		eprintk("can't register major\n");
 		goto blkreg_fail;
 	}
 
-	printk(KERN_INFO
-	       "aoe: aoe_init: AoE v%s initialised.\n",
-	       VERSION);
+	iprintk("AoE v%s initialised.\n", VERSION);
 	discover_timer(TINIT);
 	return 0;
 
@@ -103,7 +101,7 @@ aoe_init(void)
  chr_fail:
 	aoedev_exit();
 	
-	printk(KERN_INFO "aoe: aoe_init: initialisation failure.\n");
+	iprintk("initialisation failure.\n");
 	return ret;
 }
 
diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 1bba140..f1cf266 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -74,7 +74,7 @@ set_aoe_iflist(const char __user *user_s
 		return -EINVAL;
 
 	if (copy_from_user(aoe_iflist, user_str, size)) {
-		printk(KERN_INFO "aoe: %s: copy from user failed\n", __FUNCTION__);
+		iprintk("copy from user failed\n");
 		return -EFAULT;
 	}
 	aoe_iflist[size] = 0x00;
@@ -132,8 +132,7 @@ aoenet_rcv(struct sk_buff *skb, struct n
 		if (n > NECODES)
 			n = 0;
 		if (net_ratelimit())
-			printk(KERN_ERR "aoe: aoenet_rcv: error packet from %d.%d; "
-			       "ecode=%d '%s'\n",
+			eprintk("error packet from %d.%d; ecode=%d '%s'\n",
 			       be16_to_cpu(h->major), h->minor, 
 			       h->err, aoe_errlist[n]);
 		goto exit;
@@ -147,7 +146,7 @@ aoenet_rcv(struct sk_buff *skb, struct n
 		aoecmd_cfg_rsp(skb);
 		break;
 	default:
-		printk(KERN_INFO "aoe: aoenet_rcv: unknown cmd %d\n", h->cmd);
+		iprintk("unknown cmd %d\n", h->cmd);
 	}
 exit:
 	dev_kfree_skb(skb);
-- 
1.4.2.4

