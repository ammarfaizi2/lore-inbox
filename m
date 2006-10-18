Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422861AbWJRUNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422861AbWJRUNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422836AbWJRUN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:13:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:46314 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422866AbWJRUJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:52 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 14/15] aoe: revert printk macros
Date: Wed, 18 Oct 2006 13:09:05 -0700
Message-Id: <11612021913873-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021882386-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com> <11612021491255-git-send-email-greg@kroah.com> <1161202152750-git-send-email-greg@kroah.com> <11612021563910-git-send-email-greg@kroah.com> <11612021601016-git-send-email-greg@kroah.com> <11612021641240-git-send-email-greg@kroah.com> <11612021682148-git-send-email-greg@kroah.com> <1161202171977-git-send-email-greg@kroah.com> <11612021753859-git-send-email-greg@kroah.com> <1161202179462-git-send-email-greg@kroah.com> <11612021821994-git-send-email-greg@kroah.com> <1161202185862-git-send-email-greg@kroah.com> <11612021882386-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

This patch addresses the concern that the aoe driver should
not introduce unecessary conventions that must be learned by
the reader.  It reverts patch 6.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoe.h     |    5 -----
 drivers/block/aoe/aoeblk.c  |   11 ++++++-----
 drivers/block/aoe/aoechr.c  |   11 ++++++-----
 drivers/block/aoe/aoecmd.c  |   35 ++++++++++++++++++++---------------
 drivers/block/aoe/aoedev.c  |    2 +-
 drivers/block/aoe/aoemain.c |    6 +++---
 drivers/block/aoe/aoenet.c  |    6 +++---
 7 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 188bf09..6d11122 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -10,11 +10,6 @@ #ifndef AOE_PARTITIONS
 #define AOE_PARTITIONS (16)
 #endif
 
-#define xprintk(L, fmt, arg...) printk(L "aoe: " "%s: " fmt, __func__, ## arg)
-#define iprintk(fmt, arg...) xprintk(KERN_INFO, fmt, ## arg)
-#define eprintk(fmt, arg...) xprintk(KERN_ERR, fmt, ## arg)
-#define dprintk(fmt, arg...) xprintk(KERN_DEBUG, fmt, ## arg)
-
 #define SYSMINOR(aoemajor, aoeminor) ((aoemajor) * NPERSHELF + (aoeminor))
 #define AOEMAJOR(sysminor) ((sysminor) / NPERSHELF)
 #define AOEMINOR(sysminor) ((sysminor) % NPERSHELF)
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 088acf4..4259b52 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -131,7 +131,7 @@ aoeblk_make_request(request_queue_t *q, 
 	d = bio->bi_bdev->bd_disk->private_data;
 	buf = mempool_alloc(d->bufpool, GFP_NOIO);
 	if (buf == NULL) {
-		iprintk("buf allocation failure\n");
+		printk(KERN_INFO "aoe: buf allocation failure\n");
 		bio_endio(bio, bio->bi_size, -ENOMEM);
 		return 0;
 	}
@@ -149,7 +149,8 @@ aoeblk_make_request(request_queue_t *q, 
 	spin_lock_irqsave(&d->lock, flags);
 
 	if ((d->flags & DEVFL_UP) == 0) {
-		iprintk("device %ld.%ld is not up\n", d->aoemajor, d->aoeminor);
+		printk(KERN_INFO "aoe: device %ld.%ld is not up\n",
+			d->aoemajor, d->aoeminor);
 		spin_unlock_irqrestore(&d->lock, flags);
 		mempool_free(buf, d->bufpool);
 		bio_endio(bio, bio->bi_size, -ENXIO);
@@ -174,7 +175,7 @@ aoeblk_getgeo(struct block_device *bdev,
 	struct aoedev *d = bdev->bd_disk->private_data;
 
 	if ((d->flags & DEVFL_UP) == 0) {
-		eprintk("disk not up\n");
+		printk(KERN_ERR "aoe: disk not up\n");
 		return -ENODEV;
 	}
 
@@ -201,7 +202,7 @@ aoeblk_gdalloc(void *vp)
 
 	gd = alloc_disk(AOE_PARTITIONS);
 	if (gd == NULL) {
-		eprintk("cannot allocate disk structure for %ld.%ld\n",
+		printk(KERN_ERR "aoe: cannot allocate disk structure for %ld.%ld\n",
 			d->aoemajor, d->aoeminor);
 		spin_lock_irqsave(&d->lock, flags);
 		d->flags &= ~DEVFL_GDALLOC;
@@ -211,7 +212,7 @@ aoeblk_gdalloc(void *vp)
 
 	d->bufpool = mempool_create_slab_pool(MIN_BUFS, buf_pool_cache);
 	if (d->bufpool == NULL) {
-		eprintk("cannot allocate bufpool for %ld.%ld\n",
+		printk(KERN_ERR "aoe: cannot allocate bufpool for %ld.%ld\n",
 			d->aoemajor, d->aoeminor);
 		put_disk(gd);
 		spin_lock_irqsave(&d->lock, flags);
diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index f5cab69..e22b4c9 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -55,7 +55,8 @@ static int
 interfaces(const char __user *str, size_t size)
 {
 	if (set_aoe_iflist(str, size)) {
-		eprintk("could not set interface list: too many interfaces\n");
+		printk(KERN_ERR
+			"aoe: could not set interface list: too many interfaces\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -78,7 +79,7 @@ revalidate(const char __user *str, size_
 	/* should be e%d.%d format */
 	n = sscanf(buf, "e%d.%d", &major, &minor);
 	if (n != 2) {
-		eprintk("invalid device specification\n");
+		printk(KERN_ERR "aoe: invalid device specification\n");
 		return -EINVAL;
 	}
 	d = aoedev_by_aoeaddr(major, minor);
@@ -113,7 +114,7 @@ bail:		spin_unlock_irqrestore(&emsgs_loc
 
 	mp = kmalloc(n, GFP_ATOMIC);
 	if (mp == NULL) {
-		eprintk("allocation failure, len=%ld\n", n);
+		printk(KERN_ERR "aoe: allocation failure, len=%ld\n", n);
 		goto bail;
 	}
 
@@ -138,7 +139,7 @@ aoechr_write(struct file *filp, const ch
 
 	switch ((unsigned long) filp->private_data) {
 	default:
-		iprintk("can't write to that file.\n");
+		printk(KERN_INFO "aoe: can't write to that file.\n");
 		break;
 	case MINOR_DISCOVER:
 		ret = discover();
@@ -247,7 +248,7 @@ aoechr_init(void)
 
 	n = register_chrdev(AOE_MAJOR, "aoechr", &aoe_fops);
 	if (n < 0) { 
-		eprintk("can't register char device\n");
+		printk(KERN_ERR "aoe: can't register char device\n");
 		return n;
 	}
 	sema_init(&emsgs_sema, 0);
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 2d0bcdd..8a13b1a 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -159,7 +159,7 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 	buf->nframesout += 1;
 	buf->bufaddr += bcnt;
 	buf->bv_resid -= bcnt;
-/* dprintk("bv_resid=%ld\n", buf->bv_resid); */
+/* printk(KERN_DEBUG "aoe: bv_resid=%ld\n", buf->bv_resid); */
 	buf->resid -= bcnt;
 	buf->sector += bcnt >> 9;
 	if (buf->resid == 0) {
@@ -203,7 +203,7 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigne
 
 		skb = new_skb(sizeof *h + sizeof *ch);
 		if (skb == NULL) {
-			iprintk("skb alloc failure\n");
+			printk(KERN_INFO "aoe: skb alloc failure\n");
 			continue;
 		}
 		skb->dev = ifp;
@@ -276,7 +276,7 @@ loop:
 			return;
 		buf = container_of(d->bufq.next, struct buf, bufs);
 		list_del(d->bufq.next);
-/*dprintk("bi_size=%ld\n", buf->bio->bi_size); */
+/*printk(KERN_DEBUG "aoe: bi_size=%ld\n", buf->bio->bi_size); */
 		d->inprocess = buf;
 	}
 	aoecmd_ata_rw(d, f);
@@ -319,7 +319,7 @@ rexmit(struct aoedev *d, struct frame *f
 		}
 		if (++d->lostjumbo > (d->nframes << 1))
 		if (d->maxbcnt != DEFAULTBCNT) {
-			iprintk("e%ld.%ld: too many lost jumbo on %s - using 1KB frames.\n",
+			printk(KERN_INFO "aoe: e%ld.%ld: too many lost jumbo on %s - using 1KB frames.\n",
 				d->aoemajor, d->aoeminor, d->ifp->name);
 			d->maxbcnt = DEFAULTBCNT;
 			d->flags |= DEVFL_MAXBCNT;
@@ -472,7 +472,7 @@ ataid_complete(struct aoedev *d, unsigne
 	}
 
 	if (d->ssize != ssize)
-		iprintk("%012llx e%lu.%lu v%04x has %llu sectors\n",
+		printk(KERN_INFO "aoe: %012llx e%lu.%lu v%04x has %llu sectors\n",
 			(unsigned long long)mac_addr(d->addr),
 			d->aoemajor, d->aoeminor,
 			d->fw_ver, (long long)ssize);
@@ -483,7 +483,7 @@ ataid_complete(struct aoedev *d, unsigne
 		d->flags |= DEVFL_NEWSIZE;
 	} else {
 		if (d->flags & DEVFL_GDALLOC) {
-			eprintk("can't schedule work for e%lu.%lu, %s\n",
+			printk(KERN_ERR "aoe: can't schedule work for e%lu.%lu, %s\n",
 			       d->aoemajor, d->aoeminor,
 			       "it's already on!  This shouldn't happen.\n");
 			return;
@@ -569,7 +569,8 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 	if (ahout->cmdstat == WIN_IDENTIFY)
 		d->flags &= ~DEVFL_PAUSE;
 	if (ahin->cmdstat & 0xa9) {	/* these bits cleared on success */
-		eprintk("ata error cmd=%2.2Xh stat=%2.2Xh from e%ld.%ld\n",
+		printk(KERN_ERR
+			"aoe: ata error cmd=%2.2Xh stat=%2.2Xh from e%ld.%ld\n",
 			ahout->cmdstat, ahin->cmdstat,
 			d->aoemajor, d->aoeminor);
 		if (buf)
@@ -580,7 +581,8 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 		case WIN_READ:
 		case WIN_READ_EXT:
 			if (skb->len - sizeof *hin - sizeof *ahin < n) {
-				eprintk("runt data size in read.  skb->len=%d\n",
+				printk(KERN_ERR
+					"aoe: runt data size in read.  skb->len=%d\n",
 					skb->len);
 				/* fail frame f?  just returning will rexmit. */
 				spin_unlock_irqrestore(&d->lock, flags);
@@ -618,7 +620,8 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 			break;
 		case WIN_IDENTIFY:
 			if (skb->len - sizeof *hin - sizeof *ahin < 512) {
-				iprintk("runt data size in ataid.  skb->len=%d\n",
+				printk(KERN_INFO
+					"aoe: runt data size in ataid.  skb->len=%d\n",
 					skb->len);
 				spin_unlock_irqrestore(&d->lock, flags);
 				return;
@@ -626,7 +629,8 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 			ataid_complete(d, (char *) (ahin+1));
 			break;
 		default:
-			iprintk("unrecognized ata command %2.2Xh for %d.%d\n",
+			printk(KERN_INFO
+				"aoe: unrecognized ata command %2.2Xh for %d.%d\n",
 				ahout->cmdstat,
 				be16_to_cpu(hin->major),
 				hin->minor);
@@ -686,7 +690,7 @@ aoecmd_ata_id(struct aoedev *d)
 
 	f = freeframe(d);
 	if (f == NULL) {
-		eprintk("can't get a frame. This shouldn't happen.\n");
+		printk(KERN_ERR "aoe: can't get a frame. This shouldn't happen.\n");
 		return NULL;
 	}
 
@@ -732,14 +736,14 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	 */
 	aoemajor = be16_to_cpu(h->major);
 	if (aoemajor == 0xfff) {
-		eprintk("Warning: shelf address is all ones.  "
+		printk(KERN_ERR "aoe: Warning: shelf address is all ones.  "
 			"Check shelf dip switches.\n");
 		return;
 	}
 
 	sysminor = SYSMINOR(aoemajor, h->minor);
 	if (sysminor * AOE_PARTITIONS + AOE_PARTITIONS > MINORMASK) {
-		iprintk("e%ld.%d: minor number too large\n",
+		printk(KERN_INFO "aoe: e%ld.%d: minor number too large\n",
 			aoemajor, (int) h->minor);
 		return;
 	}
@@ -750,7 +754,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 
 	d = aoedev_by_sysminor_m(sysminor, n);
 	if (d == NULL) {
-		iprintk("device sysminor_m failure\n");
+		printk(KERN_INFO "aoe: device sysminor_m failure\n");
 		return;
 	}
 
@@ -767,7 +771,8 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 			n = ch->scnt;
 		n = n ? n * 512 : DEFAULTBCNT;
 		if (n != d->maxbcnt) {
-			iprintk("e%ld.%ld: setting %d byte data frames on %s\n",
+			printk(KERN_INFO
+				"aoe: e%ld.%ld: setting %d byte data frames on %s\n",
 				d->aoemajor, d->aoeminor, n, d->ifp->name);
 			d->maxbcnt = n;
 		}
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 7fd63d4..6125921 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -156,7 +156,7 @@ aoedev_by_sysminor_m(ulong sysminor, ulo
 		d = aoedev_newdev(bufcnt);
 	 	if (d == NULL) {
 			spin_unlock_irqrestore(&devlist_lock, flags);
-			iprintk("aoedev_newdev failure.\n");
+			printk(KERN_INFO "aoe: aoedev_newdev failure.\n");
 			return NULL;
 		}
 		d->sysminor = sysminor;
diff --git a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
index 13e634d..a04b7d6 100644
--- a/drivers/block/aoe/aoemain.c
+++ b/drivers/block/aoe/aoemain.c
@@ -84,11 +84,11 @@ aoe_init(void)
 		goto net_fail;
 	ret = register_blkdev(AOE_MAJOR, DEVICE_NAME);
 	if (ret < 0) {
-		eprintk("can't register major\n");
+		printk(KERN_ERR "aoe: can't register major\n");
 		goto blkreg_fail;
 	}
 
-	iprintk("AoE v%s initialised.\n", VERSION);
+	printk(KERN_INFO "aoe: AoE v%s initialised.\n", VERSION);
 	discover_timer(TINIT);
 	return 0;
 
@@ -101,7 +101,7 @@ aoe_init(void)
  chr_fail:
 	aoedev_exit();
 	
-	iprintk("initialisation failure.\n");
+	printk(KERN_INFO "aoe: initialisation failure.\n");
 	return ret;
 }
 
diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index f1cf266..9626e0f 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -74,7 +74,7 @@ set_aoe_iflist(const char __user *user_s
 		return -EINVAL;
 
 	if (copy_from_user(aoe_iflist, user_str, size)) {
-		iprintk("copy from user failed\n");
+		printk(KERN_INFO "aoe: copy from user failed\n");
 		return -EFAULT;
 	}
 	aoe_iflist[size] = 0x00;
@@ -132,7 +132,7 @@ aoenet_rcv(struct sk_buff *skb, struct n
 		if (n > NECODES)
 			n = 0;
 		if (net_ratelimit())
-			eprintk("error packet from %d.%d; ecode=%d '%s'\n",
+			printk(KERN_ERR "aoe: error packet from %d.%d; ecode=%d '%s'\n",
 			       be16_to_cpu(h->major), h->minor, 
 			       h->err, aoe_errlist[n]);
 		goto exit;
@@ -146,7 +146,7 @@ aoenet_rcv(struct sk_buff *skb, struct n
 		aoecmd_cfg_rsp(skb);
 		break;
 	default:
-		iprintk("unknown cmd %d\n", h->cmd);
+		printk(KERN_INFO "aoe: unknown cmd %d\n", h->cmd);
 	}
 exit:
 	dev_kfree_skb(skb);
-- 
1.4.2.4

