Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVCXPit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVCXPit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVCXPgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:36:16 -0500
Received: from geode.he.net ([216.218.230.98]:2833 "HELO noserose.net")
	by vger.kernel.org with SMTP id S262526AbVCXPcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:32:16 -0500
From: ecashin@noserose.net
Message-Id: <1111678333.1305@geode.he.net>
Date: Thu, 24 Mar 2005 07:32:13 -0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] aoe [12/12]: send outgoing packets in order
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't use list.h, since sk_buff doesn't have a list_head but instead
has two struct sk_buff pointers, and I want to avoid any extra memory
allocation.

send outgoing packets in order

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h	2005-03-10 12:20:02.000000000 -0500
+++ b/drivers/block/aoe/aoe.h	2005-03-10 12:20:04.000000000 -0500
@@ -132,7 +132,8 @@ struct aoedev {
 	struct timer_list timer;
 	spinlock_t lock;
 	struct net_device *ifp;	/* interface ed is attached to */
-	struct sk_buff *skblist;/* packets needing to be sent */
+	struct sk_buff *sendq_hd; /* packets needing to be sent, list head */
+	struct sk_buff *sendq_tl;
 	mempool_t *bufpool;	/* for deadlock-free Buf allocation */
 	struct list_head bufq;	/* queue of bios to work on */
 	struct buf *inprocess;	/* the one we're currently working on */
diff -uprN a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
--- a/drivers/block/aoe/aoeblk.c	2005-03-10 12:20:02.000000000 -0500
+++ b/drivers/block/aoe/aoeblk.c	2005-03-10 12:20:04.000000000 -0500
@@ -147,8 +147,8 @@ aoeblk_make_request(request_queue_t *q, 
 	list_add_tail(&buf->bufs, &d->bufq);
 	aoecmd_work(d);
 
-	sl = d->skblist;
-	d->skblist = NULL;
+	sl = d->sendq_hd;
+	d->sendq_hd = d->sendq_tl = NULL;
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
diff -uprN a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
--- a/drivers/block/aoe/aoecmd.c	2005-03-10 12:20:02.000000000 -0500
+++ b/drivers/block/aoe/aoecmd.c	2005-03-10 12:20:04.000000000 -0500
@@ -178,8 +178,12 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 
 	skb = skb_prepare(d, f);
 	if (skb) {
-		skb->next = d->skblist;
-		d->skblist = skb;
+		skb->next = NULL;
+		if (d->sendq_hd)
+			d->sendq_tl->next = skb;
+		else
+			d->sendq_hd = skb;
+		d->sendq_tl = skb;
 	}
 }
 
@@ -227,8 +231,12 @@ rexmit(struct aoedev *d, struct frame *f
 
 	skb = skb_prepare(d, f);
 	if (skb) {
-		skb->next = d->skblist;
-		d->skblist = skb;
+		skb->next = NULL;
+		if (d->sendq_hd)
+			d->sendq_tl->next = skb;
+		else
+			d->sendq_hd = skb;
+		d->sendq_tl = skb;
 	}
 }
 
@@ -280,8 +288,8 @@ tdie:		spin_unlock_irqrestore(&d->lock, 
 		}
 	}
 
-	sl = d->skblist;
-	d->skblist = NULL;
+	sl = d->sendq_hd;
+	d->sendq_hd = d->sendq_tl = NULL;
 	if (sl) {
 		n = d->rttavg <<= 1;
 		if (n > MAXTIMER)
@@ -481,8 +489,8 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 
 	aoecmd_work(d);
 
-	sl = d->skblist;
-	d->skblist = NULL;
+	sl = d->sendq_hd;
+	d->sendq_hd = d->sendq_tl = NULL;
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
@@ -531,7 +539,7 @@ aoecmd_cfg(ushort aoemajor, unsigned cha
  
 /*
  * Since we only call this in one place (and it only prepares one frame)
- * we just return the skb.  Usually we'd chain it up to the d->skblist.
+ * we just return the skb.  Usually we'd chain it up to the aoedev sendq.
  */
 static struct sk_buff *
 aoecmd_ata_id(struct aoedev *d)


-- 
  Ed L. Cashin <ecashin@coraid.com>
