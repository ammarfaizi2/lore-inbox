Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWHRSzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWHRSzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbWHRSzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:55:24 -0400
Received: from ns1.coraid.com ([65.14.39.133]:57957 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161076AbWHRSy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:54:56 -0400
Message-ID: <a5ef0a9b1537170df7875313c09e62b8@coraid.com>
Date: Fri, 18 Aug 2006 13:39:42 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [09/13]: zero copy write 2 of 2
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Avoid memory copy on writes.
(This patch follows patch 4.)

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoe.h 2.6.18-rc4-aoe/drivers/block/aoe/aoe.h
--- 2.6.18-rc4-orig/drivers/block/aoe/aoe.h	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoe.h	2006-08-17 16:45:34.000000000 -0400
@@ -84,6 +84,7 @@ enum {
 	DEVFL_PAUSE = (1<<5),
 	DEVFL_NEWSIZE = (1<<6),	/* need to update dev size in block layer */
 	DEVFL_MAXBCNT = (1<<7), /* d->maxbcnt is not changeable */
+	DEVFL_KICKME = (1<<8),
 
 	BUFFL_FAIL = 1,
 };
diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
@@ -120,7 +120,7 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 	h = (struct aoe_hdr *) skb->mac.raw;
 	ah = (struct aoe_atahdr *) (h+1);
 	skb->len = sizeof *h + sizeof *ah;
-	memset(h, 0, skb->len);
+	memset(h, 0, ETH_ZLEN);
 	f->tag = aoehdr_atainit(d, h);
 	f->waited = 0;
 	f->buf = buf;
@@ -143,8 +143,9 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 		skb_fill_page_desc(skb, 0, virt_to_page(f->bufaddr),
 			offset_in_page(f->bufaddr), bcnt);
 		ah->aflags |= AOEAFL_WRITE;
+		skb->len += bcnt;
+		skb->data_len = bcnt;
 	} else {
-		skb_shinfo(skb)->nr_frags = 0;
 		skb->len = ETH_ZLEN;
 		writebit = 0;
 	}
@@ -167,8 +168,9 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 	}
 
 	skb->dev = d->ifp;
-	skb_get(skb);
-	skb->next = NULL;
+	skb = skb_clone(skb, GFP_ATOMIC);
+	if (skb == NULL)	
+		return;
 	if (d->sendq_hd)
 		d->sendq_tl->next = skb;
 	else
@@ -224,6 +226,29 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigne
 	return sl;
 }
 
+static struct frame *
+freeframe(struct aoedev *d)
+{
+	struct frame *f, *e;
+	int n = 0;
+
+	f = d->frames;
+	e = f + d->nframes;
+	for (; f<e; f++) {
+		if (f->tag != FREETAG)
+			continue;
+		if (atomic_read(&skb_shinfo(f->skb)->dataref) == 1) {
+			skb_shinfo(f->skb)->nr_frags = f->skb->data_len = 0;
+			return f;
+		}
+		n++;
+	}
+	if (n == d->nframes)	/* wait for network layer */
+		d->flags |= DEVFL_KICKME;
+
+	return NULL;
+}
+
 /* enters with d->lock held */
 void
 aoecmd_work(struct aoedev *d)
@@ -239,7 +264,7 @@ aoecmd_work(struct aoedev *d)
 	}
 
 loop:
-	f = getframe(d, FREETAG);
+	f = freeframe(d);
 	if (f == NULL)
 		return;
 	if (d->inprocess == NULL) {
@@ -282,20 +307,25 @@ rexmit(struct aoedev *d, struct frame *f
 	n = DEFAULTBCNT / 512;
 	if (ah->scnt > n) {
 		ah->scnt = n;
-		if (ah->aflags & AOEAFL_WRITE)
+		if (ah->aflags & AOEAFL_WRITE) {
 			skb_fill_page_desc(skb, 0, virt_to_page(f->bufaddr),
 				offset_in_page(f->bufaddr), DEFAULTBCNT);
+			skb->len = sizeof *h + sizeof *ah + DEFAULTBCNT;
+			skb->data_len = DEFAULTBCNT;
+		}
 		if (++d->lostjumbo > (d->nframes << 1))
 		if (d->maxbcnt != DEFAULTBCNT) {
-			iprintk("too many lost jumbo - using 1KB frames.\n");
+			iprintk("e%ld.%ld: too many lost jumbo on %s - using 1KB frames.\n",
+				d->aoemajor, d->aoeminor, d->ifp->name);
 			d->maxbcnt = DEFAULTBCNT;
 			d->flags |= DEVFL_MAXBCNT;
 		}
 	}
 
 	skb->dev = d->ifp;
-	skb_get(skb);
-	skb->next = NULL;
+	skb = skb_clone(skb, GFP_ATOMIC);
+	if (skb == NULL)
+		return;
 	if (d->sendq_hd)
 		d->sendq_tl->next = skb;
 	else
@@ -350,6 +380,10 @@ rexmit_timer(ulong vp)
 			rexmit(d, f);
 		}
 	}
+	if (d->flags & DEVFL_KICKME) {
+		d->flags &= ~DEVFL_KICKME;
+		aoecmd_work(d);
+	}
 
 	sl = d->sendq_hd;
 	d->sendq_hd = d->sendq_tl = NULL;
@@ -552,23 +586,27 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 		case WIN_WRITE:
 		case WIN_WRITE_EXT:
 			if (f->bcnt -= n) {
+				skb = f->skb;
 				f->bufaddr += n;
 				put_lba(ahout, f->lba += ahout->scnt);
 				n = f->bcnt;
 				if (n > DEFAULTBCNT)
 					n = DEFAULTBCNT;
 				ahout->scnt = n >> 9;
-				if (ahout->aflags & AOEAFL_WRITE)
-					skb_fill_page_desc(f->skb, 0, 
+				if (ahout->aflags & AOEAFL_WRITE) {
+					skb_fill_page_desc(skb, 0, 
 						virt_to_page(f->bufaddr),
 						offset_in_page(f->bufaddr), n);
+					skb->len = sizeof *hout + sizeof *ahout + n;
+					skb->data_len = n;
+				}
 				f->tag = newtag(d);
 				hout->tag = cpu_to_be32(f->tag);
 				skb->dev = d->ifp;
-				skb_get(f->skb);
-				f->skb->next = NULL;
+				skb = skb_clone(skb, GFP_ATOMIC);
 				spin_unlock_irqrestore(&d->lock, flags);
-				aoenet_xmit(f->skb);
+				if (skb)
+					aoenet_xmit(skb);
 				return;
 			}
 			if (n > DEFAULTBCNT)
@@ -642,7 +680,7 @@ aoecmd_ata_id(struct aoedev *d)
 	struct frame *f;
 	struct sk_buff *skb;
 
-	f = getframe(d, FREETAG);
+	f = freeframe(d);
 	if (f == NULL) {
 		eprintk("can't get a frame. This shouldn't happen.\n");
 		return NULL;
@@ -652,8 +690,8 @@ aoecmd_ata_id(struct aoedev *d)
 	skb = f->skb;
 	h = (struct aoe_hdr *) skb->mac.raw;
 	ah = (struct aoe_atahdr *) (h+1);
-	skb->len = sizeof *h + sizeof *ah;
-	memset(h, 0, skb->len);
+	skb->len = ETH_ZLEN;
+	memset(h, 0, ETH_ZLEN);
 	f->tag = aoehdr_atainit(d, h);
 	f->waited = 0;
 
@@ -663,12 +701,11 @@ aoecmd_ata_id(struct aoedev *d)
 	ah->lba3 = 0xa0;
 
 	skb->dev = d->ifp;
-	skb_get(skb);
 
 	d->rttavg = MAXTIMER;
 	d->timer.function = rexmit_timer;
 
-	return skb;
+	return skb_clone(skb, GFP_ATOMIC);
 }
  
 void
@@ -724,7 +761,12 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 		n /= 512;
 		if (n > ch->scnt)
 			n = ch->scnt;
-		d->maxbcnt = n ? n * 512 : DEFAULTBCNT;
+		n = n ? n * 512 : DEFAULTBCNT;
+		if (n != d->maxbcnt) {
+			iprintk("e%ld.%ld: setting %d byte data frames on %s\n",
+				d->aoemajor, d->aoeminor, n, d->ifp->name);
+			d->maxbcnt = n;
+		}
 	}
 
 	/* don't change users' perspective */
diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoedev.c 2.6.18-rc4-aoe/drivers/block/aoe/aoedev.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoedev.c	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoedev.c	2006-08-17 16:45:34.000000000 -0400
@@ -121,6 +121,7 @@ aoedev_downdev(struct aoedev *d)
 			mempool_free(buf, d->bufpool);
 			bio_endio(bio, bio->bi_size, -EIO);
 		}
+		skb_shinfo(f->skb)->nr_frags = f->skb->data_len = 0;
 	}
 	d->inprocess = NULL;
 


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
