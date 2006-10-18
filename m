Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422812AbWJRUQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422812AbWJRUQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422829AbWJRUQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:16:34 -0400
Received: from cantor2.suse.de ([195.135.220.15]:23786 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422813AbWJRUJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:17 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 4/15] aoe: zero copy write 1 of 2
Date: Wed, 18 Oct 2006 13:08:55 -0700
Message-Id: <11612021563910-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <1161202152750-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com> <11612021491255-git-send-email-greg@kroah.com> <1161202152750-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

Avoid memory copy on writes.
(This patch depends on fixes in patch 9 to follow.)

Although skb->len should not be set when working with linear skbuffs,
the skb->tail pointer maintained by skb_put/skb_trim is not relevant
to what happens when the skb_fill_page_desc function is called.  This
issue was raised without comment in linux-kernel and netdev earlier
this month:

  http://thread.gmane.org/gmane.linux.kernel/446474/
  http://thread.gmane.org/gmane.linux.network/45444/

So until there is something analogous to skb_put that works for
zero-copy write skbuffs, we will do what the other callers of
skb_fill_page_desc are doing.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoe.h    |    7 +--
 drivers/block/aoe/aoecmd.c |   94 +++++++++++++++++---------------------------
 drivers/block/aoe/aoedev.c |   42 ++++++++++++++------
 3 files changed, 69 insertions(+), 74 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 507c377..fa2d804 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -107,11 +107,7 @@ struct frame {
 	ulong waited;
 	struct buf *buf;
 	char *bufaddr;
-	int writedatalen;
-	int ndata;
-
-	/* largest possible */
-	unsigned char data[sizeof(struct aoe_hdr) + sizeof(struct aoe_atahdr)];
+	struct sk_buff *skb;
 };
 
 struct aoedev {
@@ -157,6 +153,7 @@ void aoecmd_cfg(ushort aoemajor, unsigne
 void aoecmd_ata_rsp(struct sk_buff *);
 void aoecmd_cfg_rsp(struct sk_buff *);
 void aoecmd_sleepwork(void *vp);
+struct sk_buff *new_skb(ulong);
 
 int aoedev_init(void);
 void aoedev_exit(void);
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index d1d8759..1aeb296 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -17,15 +17,14 @@ #define MINTIMER (2 * TIMERTICK)
 #define MAXTIMER (HZ << 1)
 #define MAXWAIT (60 * 3)	/* After MAXWAIT seconds, give up and fail dev */
 
-static struct sk_buff *
-new_skb(struct net_device *if_dev, ulong len)
+struct sk_buff *
+new_skb(ulong len)
 {
 	struct sk_buff *skb;
 
 	skb = alloc_skb(len, GFP_ATOMIC);
 	if (skb) {
 		skb->nh.raw = skb->mac.raw = skb->data;
-		skb->dev = if_dev;
 		skb->protocol = __constant_htons(ETH_P_AOE);
 		skb->priority = 0;
 		skb_put(skb, len);
@@ -40,29 +39,6 @@ new_skb(struct net_device *if_dev, ulong
 	return skb;
 }
 
-static struct sk_buff *
-skb_prepare(struct aoedev *d, struct frame *f)
-{
-	struct sk_buff *skb;
-	char *p;
-
-	skb = new_skb(d->ifp, f->ndata + f->writedatalen);
-	if (!skb) {
-		printk(KERN_INFO "aoe: skb_prepare: failure to allocate skb\n");
-		return NULL;
-	}
-
-	p = skb->mac.raw;
-	memcpy(p, f->data, f->ndata);
-
-	if (f->writedatalen) {
-		p += sizeof(struct aoe_hdr) + sizeof(struct aoe_atahdr);
-		memcpy(p, f->bufaddr, f->writedatalen);
-	}
-
-	return skb;
-}
-
 static struct frame *
 getframe(struct aoedev *d, int tag)
 {
@@ -129,10 +105,11 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 		bcnt = MAXATADATA;
 
 	/* initialize the headers & frame */
-	h = (struct aoe_hdr *) f->data;
+	skb = f->skb;
+	h = (struct aoe_hdr *) skb->mac.raw;
 	ah = (struct aoe_atahdr *) (h+1);
-	f->ndata = sizeof *h + sizeof *ah;
-	memset(h, 0, f->ndata);
+	skb->len = sizeof *h + sizeof *ah;
+	memset(h, 0, skb->len);
 	f->tag = aoehdr_atainit(d, h);
 	f->waited = 0;
 	f->buf = buf;
@@ -155,11 +132,13 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 	}
 
 	if (bio_data_dir(buf->bio) == WRITE) {
+		skb_fill_page_desc(skb, 0, virt_to_page(f->bufaddr),
+			offset_in_page(f->bufaddr), bcnt);
 		ah->aflags |= AOEAFL_WRITE;
-		f->writedatalen = bcnt;
 	} else {
+		skb_shinfo(skb)->nr_frags = 0;
+		skb->len = ETH_ZLEN;
 		writebit = 0;
-		f->writedatalen = 0;
 	}
 
 	ah->cmdstat = WIN_READ | writebit | extbit;
@@ -179,15 +158,14 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 		buf->bufaddr = page_address(buf->bv->bv_page) + buf->bv->bv_offset;
 	}
 
-	skb = skb_prepare(d, f);
-	if (skb) {
-		skb->next = NULL;
-		if (d->sendq_hd)
-			d->sendq_tl->next = skb;
-		else
-			d->sendq_hd = skb;
-		d->sendq_tl = skb;
-	}
+	skb->dev = d->ifp;
+	skb_get(skb);
+	skb->next = NULL;
+	if (d->sendq_hd)
+		d->sendq_tl->next = skb;
+	else
+		d->sendq_hd = skb;
+	d->sendq_tl = skb;
 }
 
 /* some callers cannot sleep, and they can call this function,
@@ -209,11 +187,12 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigne
 		if (!is_aoe_netif(ifp))
 			continue;
 
-		skb = new_skb(ifp, sizeof *h + sizeof *ch);
+		skb = new_skb(sizeof *h + sizeof *ch);
 		if (skb == NULL) {
 			printk(KERN_INFO "aoe: aoecmd_cfg: skb alloc failure\n");
 			continue;
 		}
+		skb->dev = ifp;
 		if (sl_tail == NULL)
 			sl_tail = skb;
 		h = (struct aoe_hdr *) skb->mac.raw;
@@ -283,21 +262,21 @@ rexmit(struct aoedev *d, struct frame *f
 		d->aoemajor, d->aoeminor, f->tag, jiffies, n);
 	aoechr_error(buf);
 
-	h = (struct aoe_hdr *) f->data;
+	skb = f->skb;
+	h = (struct aoe_hdr *) skb->mac.raw;
 	f->tag = n;
 	h->tag = cpu_to_be32(n);
 	memcpy(h->dst, d->addr, sizeof h->dst);
 	memcpy(h->src, d->ifp->dev_addr, sizeof h->src);
 
-	skb = skb_prepare(d, f);
-	if (skb) {
-		skb->next = NULL;
-		if (d->sendq_hd)
-			d->sendq_tl->next = skb;
-		else
-			d->sendq_hd = skb;
-		d->sendq_tl = skb;
-	}
+	skb->dev = d->ifp;
+	skb_get(skb);
+	skb->next = NULL;
+	if (d->sendq_hd)
+		d->sendq_tl->next = skb;
+	else
+		d->sendq_hd = skb;
+	d->sendq_tl = skb;
 }
 
 static int
@@ -514,7 +493,7 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 	calc_rttavg(d, tsince(f->tag));
 
 	ahin = (struct aoe_atahdr *) (hin+1);
-	ahout = (struct aoe_atahdr *) (f->data + sizeof(struct aoe_hdr));
+	ahout = (struct aoe_atahdr *) (f->skb->mac.raw + sizeof(struct aoe_hdr));
 	buf = f->buf;
 
 	if (ahout->cmdstat == WIN_IDENTIFY)
@@ -620,20 +599,21 @@ aoecmd_ata_id(struct aoedev *d)
 	}
 
 	/* initialize the headers & frame */
-	h = (struct aoe_hdr *) f->data;
+	skb = f->skb;
+	h = (struct aoe_hdr *) skb->mac.raw;
 	ah = (struct aoe_atahdr *) (h+1);
-	f->ndata = sizeof *h + sizeof *ah;
-	memset(h, 0, f->ndata);
+	skb->len = sizeof *h + sizeof *ah;
+	memset(h, 0, skb->len);
 	f->tag = aoehdr_atainit(d, h);
 	f->waited = 0;
-	f->writedatalen = 0;
 
 	/* set up ata header */
 	ah->scnt = 1;
 	ah->cmdstat = WIN_IDENTIFY;
 	ah->lba3 = 0xa0;
 
-	skb = skb_prepare(d, f);
+	skb->dev = d->ifp;
+	skb_get(skb);
 
 	d->rttavg = MAXTIMER;
 	d->timer.function = rexmit_timer;
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index c7e05ed..abf1d3c 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -63,22 +63,32 @@ aoedev_newdev(ulong nframes)
 	struct frame *f, *e;
 
 	d = kzalloc(sizeof *d, GFP_ATOMIC);
-	if (d == NULL)
-		return NULL;
 	f = kcalloc(nframes, sizeof *f, GFP_ATOMIC);
-	if (f == NULL) {
-		kfree(d);
+ 	switch (!d || !f) {
+ 	case 0:
+ 		d->nframes = nframes;
+ 		d->frames = f;
+ 		e = f + nframes;
+ 		for (; f<e; f++) {
+ 			f->tag = FREETAG;
+ 			f->skb = new_skb(ETH_ZLEN);
+ 			if (!f->skb)
+ 				break;
+ 		}
+ 		if (f == e)
+ 			break;
+ 		while (f > d->frames) {
+ 			f--;
+ 			dev_kfree_skb(f->skb);
+ 		}
+ 	default:
+ 		if (f)
+ 			kfree(f);
+ 		if (d)
+ 			kfree(d);
 		return NULL;
 	}
-
 	INIT_WORK(&d->work, aoecmd_sleepwork, d);
-
-	d->nframes = nframes;
-	d->frames = f;
-	e = f + nframes;
-	for (; f<e; f++)
-		f->tag = FREETAG;
-
 	spin_lock_init(&d->lock);
 	init_timer(&d->timer);
 	d->timer.data = (ulong) d;
@@ -160,11 +170,19 @@ aoedev_by_sysminor_m(ulong sysminor, ulo
 static void
 aoedev_freedev(struct aoedev *d)
 {
+	struct frame *f, *e;
+
 	if (d->gd) {
 		aoedisk_rm_sysfs(d);
 		del_gendisk(d->gd);
 		put_disk(d->gd);
 	}
+	f = d->frames;
+	e = f + d->nframes;
+	for (; f<e; f++) {
+		skb_shinfo(f->skb)->nr_frags = 0;
+		dev_kfree_skb(f->skb);
+	}
 	kfree(d->frames);
 	if (d->bufpool)
 		mempool_destroy(d->bufpool);
-- 
1.4.2.4

