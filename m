Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422814AbWJRUKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422814AbWJRUKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422821AbWJRUKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:10:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:25834 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422814AbWJRUJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:20 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 5/15] aoe: jumbo frame support 1 of 2
Date: Wed, 18 Oct 2006 13:08:56 -0700
Message-Id: <11612021601016-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021563910-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com> <11612021491255-git-send-email-greg@kroah.com> <1161202152750-git-send-email-greg@kroah.com> <11612021563910-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

Add support for jumbo ethernet frames.
(This patch depends on patch 7 to follow.)

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoe.h    |   11 +++++-
 drivers/block/aoe/aoechr.c |    1 +
 drivers/block/aoe/aoecmd.c |   77 ++++++++++++++++++++++++++++++++++++--------
 3 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index fa2d804..1cec199 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -65,7 +65,7 @@ struct aoe_atahdr {
 struct aoe_cfghdr {
 	__be16 bufcnt;
 	__be16 fwver;
-	unsigned char res;
+	unsigned char scnt;
 	unsigned char aoeccmd;
 	unsigned char cslen[2];
 };
@@ -78,12 +78,13 @@ enum {
 	DEVFL_GDALLOC = (1<<4),	/* need to alloc gendisk */
 	DEVFL_PAUSE = (1<<5),
 	DEVFL_NEWSIZE = (1<<6),	/* need to update dev size in block layer */
+	DEVFL_MAXBCNT = (1<<7), /* d->maxbcnt is not changeable */
 
 	BUFFL_FAIL = 1,
 };
 
 enum {
-	MAXATADATA = 1024,
+	DEFAULTBCNT = 2 * 512,	/* 2 sectors */
 	NPERSHELF = 16,		/* number of slots per shelf address */
 	FREETAG = -1,
 	MIN_BUFS = 8,
@@ -107,6 +108,8 @@ struct frame {
 	ulong waited;
 	struct buf *buf;
 	char *bufaddr;
+	ulong bcnt;
+	sector_t lba;
 	struct sk_buff *skb;
 };
 
@@ -120,6 +123,7 @@ struct aoedev {
 	ulong nopen;		/* (bd_openers isn't available without sleeping) */
 	ulong rttavg;		/* round trip average of requests/responses */
 	u16 fw_ver;		/* version of blade's firmware */
+	u16 maxbcnt;
 	struct work_struct work;/* disk create work struct */
 	struct gendisk *gd;
 	request_queue_t blkq;
@@ -134,7 +138,8 @@ struct aoedev {
 	struct list_head bufq;	/* queue of bios to work on */
 	struct buf *inprocess;	/* the one we're currently working on */
 	ulong lasttag;		/* last tag sent */
-	ulong nframes;		/* number of frames below */
+	ushort lostjumbo;
+	ushort nframes;		/* number of frames below */
 	struct frame *frames;
 };
 
diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index 0c543d3..2b5256c 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -89,6 +89,7 @@ revalidate(const char __user *str, size_
 		return -EINVAL;
 
 	spin_lock_irqsave(&d->lock, flags);
+	d->flags &= ~DEVFL_MAXBCNT;
 	d->flags |= DEVFL_PAUSE;
 	spin_unlock_irqrestore(&d->lock, flags);
 	aoecmd_cfg(major, minor);
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 1aeb296..666797d 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -83,6 +83,17 @@ aoehdr_atainit(struct aoedev *d, struct 
 	return host_tag;
 }
 
+static inline void
+put_lba(struct aoe_atahdr *ah, sector_t lba)
+{
+	ah->lba0 = lba;
+	ah->lba1 = lba >>= 8;
+	ah->lba2 = lba >>= 8;
+	ah->lba3 = lba >>= 8;
+	ah->lba4 = lba >>= 8;
+	ah->lba5 = lba >>= 8;
+}
+
 static void
 aoecmd_ata_rw(struct aoedev *d, struct frame *f)
 {
@@ -101,8 +112,8 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 
 	sector = buf->sector;
 	bcnt = buf->bv_resid;
-	if (bcnt > MAXATADATA)
-		bcnt = MAXATADATA;
+	if (bcnt > d->maxbcnt)
+		bcnt = d->maxbcnt;
 
 	/* initialize the headers & frame */
 	skb = f->skb;
@@ -114,17 +125,14 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 	f->waited = 0;
 	f->buf = buf;
 	f->bufaddr = buf->bufaddr;
+	f->bcnt = bcnt;
+	f->lba = sector;
 
 	/* set up ata header */
 	ah->scnt = bcnt >> 9;
-	ah->lba0 = sector;
-	ah->lba1 = sector >>= 8;
-	ah->lba2 = sector >>= 8;
-	ah->lba3 = sector >>= 8;
+	put_lba(ah, sector);
 	if (d->flags & DEVFL_EXT) {
 		ah->aflags |= AOEAFL_EXT;
-		ah->lba4 = sector >>= 8;
-		ah->lba5 = sector >>= 8;
 	} else {
 		extbit = 0;
 		ah->lba3 &= 0x0f;
@@ -251,6 +259,7 @@ rexmit(struct aoedev *d, struct frame *f
 {
 	struct sk_buff *skb;
 	struct aoe_hdr *h;
+	struct aoe_atahdr *ah;
 	char buf[128];
 	u32 n;
 
@@ -264,11 +273,27 @@ rexmit(struct aoedev *d, struct frame *f
 
 	skb = f->skb;
 	h = (struct aoe_hdr *) skb->mac.raw;
+	ah = (struct aoe_atahdr *) (h+1);
 	f->tag = n;
 	h->tag = cpu_to_be32(n);
 	memcpy(h->dst, d->addr, sizeof h->dst);
 	memcpy(h->src, d->ifp->dev_addr, sizeof h->src);
 
+	n = DEFAULTBCNT / 512;
+	if (ah->scnt > n) {
+		ah->scnt = n;
+		if (ah->aflags & AOEAFL_WRITE)
+			skb_fill_page_desc(skb, 0, virt_to_page(f->bufaddr),
+				offset_in_page(f->bufaddr), DEFAULTBCNT);
+		if (++d->lostjumbo > (d->nframes << 1))
+		if (d->maxbcnt != DEFAULTBCNT) {
+			printk(KERN_INFO "aoe: rexmit: too many lost jumbo.  "
+				"dropping back to 1KB frames.\n");
+			d->maxbcnt = DEFAULTBCNT;
+			d->flags |= DEVFL_MAXBCNT;
+		}
+	}
+
 	skb->dev = d->ifp;
 	skb_get(skb);
 	skb->next = NULL;
@@ -506,10 +531,10 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 		if (buf)
 			buf->flags |= BUFFL_FAIL;
 	} else {
+		n = ahout->scnt << 9;
 		switch (ahout->cmdstat) {
 		case WIN_READ:
 		case WIN_READ_EXT:
-			n = ahout->scnt << 9;
 			if (skb->len - sizeof *hin - sizeof *ahin < n) {
 				printk(KERN_CRIT "aoe: aoecmd_ata_rsp: runt "
 					"ata data size in read.  skb->len=%d\n",
@@ -521,6 +546,22 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 			memcpy(f->bufaddr, ahin+1, n);
 		case WIN_WRITE:
 		case WIN_WRITE_EXT:
+			if (f->bcnt -= n) {
+				f->bufaddr += n;
+				put_lba(ahout, f->lba += ahout->scnt);
+				n = f->bcnt > DEFAULTBCNT ? DEFAULTBCNT : f->bcnt;
+				ahout->scnt = n >> 9;
+				if (ahout->aflags & AOEAFL_WRITE)
+					skb_fill_page_desc(f->skb, 0, virt_to_page(f->bufaddr),
+						offset_in_page(f->bufaddr), n);
+				skb_get(f->skb);
+				f->skb->next = NULL;
+				spin_unlock_irqrestore(&d->lock, flags);
+				aoenet_xmit(f->skb);
+				return;
+			}
+			if (n > DEFAULTBCNT)
+				d->lostjumbo = 0;
 			break;
 		case WIN_IDENTIFY:
 			if (skb->len - sizeof *hin - sizeof *ahin < 512) {
@@ -628,9 +669,9 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	struct aoe_hdr *h;
 	struct aoe_cfghdr *ch;
 	ulong flags, sysminor, aoemajor;
-	u16 bufcnt;
 	struct sk_buff *sl;
 	enum { MAXFRAMES = 16 };
+	u16 n;
 
 	h = (struct aoe_hdr *) skb->mac.raw;
 	ch = (struct aoe_cfghdr *) (h+1);
@@ -654,11 +695,11 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 		return;
 	}
 
-	bufcnt = be16_to_cpu(ch->bufcnt);
-	if (bufcnt > MAXFRAMES)	/* keep it reasonable */
-		bufcnt = MAXFRAMES;
+	n = be16_to_cpu(ch->bufcnt);
+	if (n > MAXFRAMES)	/* keep it reasonable */
+		n = MAXFRAMES;
 
-	d = aoedev_by_sysminor_m(sysminor, bufcnt);
+	d = aoedev_by_sysminor_m(sysminor, n);
 	if (d == NULL) {
 		printk(KERN_INFO "aoe: aoecmd_cfg_rsp: device sysminor_m failure\n");
 		return;
@@ -669,6 +710,14 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	/* permit device to migrate mac and network interface */
 	d->ifp = skb->dev;
 	memcpy(d->addr, h->src, sizeof d->addr);
+	if (!(d->flags & DEVFL_MAXBCNT)) {
+		n = d->ifp->mtu;
+		n -= sizeof (struct aoe_hdr) + sizeof (struct aoe_atahdr);
+		n /= 512;
+		if (n > ch->scnt)
+			n = ch->scnt;
+		d->maxbcnt = n ? n * 512 : DEFAULTBCNT;
+	}
 
 	/* don't change users' perspective */
 	if (d->nopen && !(d->flags & DEVFL_PAUSE)) {
-- 
1.4.2.4

