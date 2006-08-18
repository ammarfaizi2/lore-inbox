Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbWHRSyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWHRSyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWHRSyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:54:47 -0400
Received: from ns1.coraid.com ([65.14.39.133]:55397 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161072AbWHRSyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:54:46 -0400
Message-ID: <f262a8dec6bec42dce9e5723ff332f5d@coraid.com>
Date: Fri, 18 Aug 2006 13:39:09 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [04/13]: zero copy write 1 of 2
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Avoid memory copy on writes.
(This patch depends on fixes in patch 9 to follow.)

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoe.h 2.6.18-rc4-aoe/drivers/block/aoe/aoe.h
--- 2.6.18-rc4-orig/drivers/block/aoe/aoe.h	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoe.h	2006-08-17 16:45:34.000000000 -0400
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
diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
@@ -17,15 +17,14 @@
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
diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoedev.c 2.6.18-rc4-aoe/drivers/block/aoe/aoedev.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoedev.c	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoedev.c	2006-08-17 16:45:34.000000000 -0400
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
  "Ed L. Cashin" <ecashin@coraid.com>
