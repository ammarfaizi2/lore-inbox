Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbWHRSzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWHRSzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWHRSz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:55:28 -0400
Received: from ns1.coraid.com ([65.14.39.133]:56933 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161070AbWHRSyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:54:52 -0400
Message-ID: <89aa13bbceac9f7580cfa29d3a05a236@coraid.com>
Date: Fri, 18 Aug 2006 13:39:28 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [07/13]: jumbo frame support 2 of 2
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Add support for jumbo ethernet frames.
(This patch follows patch 5.)

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
@@ -28,7 +28,7 @@ new_skb(ulong len)
 		skb->protocol = __constant_htons(ETH_P_AOE);
 		skb->priority = 0;
 		skb_put(skb, len);
-		memset(skb->head, 0, len);
+		memset(skb->head, 0, ETH_ZLEN);
 		skb->next = skb->prev = NULL;
 
 		/* tell the network layer not to perform IP checksums
@@ -475,7 +475,7 @@ void
 aoecmd_ata_rsp(struct sk_buff *skb)
 {
 	struct aoedev *d;
-	struct aoe_hdr *hin;
+	struct aoe_hdr *hin, *hout;
 	struct aoe_atahdr *ahin, *ahout;
 	struct frame *f;
 	struct buf *buf;
@@ -515,7 +515,8 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 	calc_rttavg(d, tsince(f->tag));
 
 	ahin = (struct aoe_atahdr *) (hin+1);
-	ahout = (struct aoe_atahdr *) (f->skb->mac.raw + sizeof(struct aoe_hdr));
+	hout = (struct aoe_hdr *) f->skb->mac.raw;
+	ahout = (struct aoe_atahdr *) (hout+1);
 	buf = f->buf;
 
 	if (ahout->cmdstat == WIN_IDENTIFY)
@@ -552,6 +553,9 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 					skb_fill_page_desc(f->skb, 0, 
 						virt_to_page(f->bufaddr),
 						offset_in_page(f->bufaddr), n);
+				f->tag = newtag(d);
+				hout->tag = cpu_to_be32(f->tag);
+				skb->dev = d->ifp;
 				skb_get(f->skb);
 				f->skb->next = NULL;
 				spin_unlock_irqrestore(&d->lock, flags);


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
