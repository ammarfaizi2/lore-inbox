Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422871AbWJRUOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422871AbWJRUOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422858AbWJRUJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:47 -0400
Received: from ns2.suse.de ([195.135.220.15]:35818 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422837AbWJRUJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:35 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 9/15] aoe: zero copy write 2 of 2
Date: Wed, 18 Oct 2006 13:09:00 -0700
Message-Id: <11612021753859-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <1161202171977-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com> <11612021491255-git-send-email-greg@kroah.com> <1161202152750-git-send-email-greg@kroah.com> <11612021563910-git-send-email-greg@kroah.com> <11612021601016-git-send-email-greg@kroah.com> <11612021641240-git-send-email-greg@kroah.com> <11612021682148-git-send-email-greg@kroah.com> <1161202171977-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

Avoid memory copy on writes.
(This patch follows patch 4.)

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoe.h    |    1 +
 drivers/block/aoe/aoecmd.c |   82 +++++++++++++++++++++++++++++++++-----------
 drivers/block/aoe/aoedev.c |    1 +
 3 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 7b11217..b41fdfe 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -84,6 +84,7 @@ enum {
 	DEVFL_PAUSE = (1<<5),
 	DEVFL_NEWSIZE = (1<<6),	/* need to update dev size in block layer */
 	DEVFL_MAXBCNT = (1<<7), /* d->maxbcnt is not changeable */
+	DEVFL_KICKME = (1<<8),
 
 	BUFFL_FAIL = 1,
 };
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index c0bdc1f..9ebc98a 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
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
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index f51d87b..7fd63d4 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -121,6 +121,7 @@ aoedev_downdev(struct aoedev *d)
 			mempool_free(buf, d->bufpool);
 			bio_endio(bio, bio->bi_size, -EIO);
 		}
+		skb_shinfo(f->skb)->nr_frags = f->skb->data_len = 0;
 	}
 	d->inprocess = NULL;
 
-- 
1.4.2.4

