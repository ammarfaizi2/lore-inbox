Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbWHRSzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbWHRSzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWHRSz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:55:26 -0400
Received: from ns1.coraid.com ([65.14.39.133]:57445 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161075AbWHRSyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:54:54 -0400
Message-ID: <4fa0d3a76693da583d088e5f79f47a2e@coraid.com>
Date: Fri, 18 Aug 2006 13:39:33 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [08/13]: improve retransmission heuristics
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Add a dynamic minimum timer for better retransmission behavior.

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoe.h 2.6.18-rc4-aoe/drivers/block/aoe/aoe.h
--- 2.6.18-rc4-orig/drivers/block/aoe/aoe.h	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoe.h	2006-08-17 16:45:34.000000000 -0400
@@ -125,8 +125,10 @@ struct aoedev {
 	ulong sysminor;
 	ulong aoemajor;
 	ulong aoeminor;
-	ulong nopen;		/* (bd_openers isn't available without sleeping) */
-	ulong rttavg;		/* round trip average of requests/responses */
+	u16 nopen;		/* (bd_openers isn't available without sleeping) */
+	u16 lasttag;		/* last tag sent */
+	u16 rttavg;		/* round trip average of requests/responses */
+	u16 mintimer;
 	u16 fw_ver;		/* version of blade's firmware */
 	u16 maxbcnt;
 	struct work_struct work;/* disk create work struct */
@@ -142,7 +144,6 @@ struct aoedev {
 	mempool_t *bufpool;	/* for deadlock-free Buf allocation */
 	struct list_head bufq;	/* queue of bios to work on */
 	struct buf *inprocess;	/* the one we're currently working on */
-	ulong lasttag;		/* last tag sent */
 	ushort lostjumbo;
 	ushort nframes;		/* number of frames below */
 	struct frame *frames;
diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
@@ -461,8 +461,15 @@ calc_rttavg(struct aoedev *d, int rtt)
 	register long n;
 
 	n = rtt;
-	if (n < MINTIMER)
-		n = MINTIMER;
+	if (n < 0) {
+		n = -rtt;
+		if (n < MINTIMER)
+			n = MINTIMER;
+		else if (n > MAXTIMER)
+			n = MAXTIMER;
+		d->mintimer += (n - d->mintimer) >> 1;
+	} else if (n < d->mintimer)
+		n = d->mintimer;
 	else if (n > MAXTIMER)
 		n = MAXTIMER;
 
@@ -498,8 +505,10 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 
 	spin_lock_irqsave(&d->lock, flags);
 
-	f = getframe(d, be32_to_cpu(hin->tag));
+	n = be32_to_cpu(hin->tag);
+	f = getframe(d, n);
 	if (f == NULL) {
+		calc_rttavg(d, -tsince(n));
 		spin_unlock_irqrestore(&d->lock, flags);
 		snprintf(ebuf, sizeof ebuf,
 			"%15s e%d.%d    tag=%08x@%08lx\n",
@@ -724,6 +733,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 		return;
 	}
 	d->flags |= DEVFL_PAUSE;	/* force pause */
+	d->mintimer = MINTIMER;
 	d->fw_ver = be16_to_cpu(ch->fwver);
 
 	/* check for already outstanding ataid */


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
