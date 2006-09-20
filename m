Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWITS4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWITS4z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWITS4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:56:55 -0400
Received: from ns1.coraid.com ([65.14.39.133]:44920 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932245AbWITS4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:56:54 -0400
Message-ID: <26e1949f75c6bb97e78dd93e9a7de9dd@coraid.com>
Date: Wed, 20 Sep 2006 14:36:49 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [07/14]: jumbo frame support 2 of 2
References: <E1GQ6uv-0001qi-00@kokone>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for jumbo ethernet frames.
(This patch follows patch 5.)

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
---

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c	2006-09-20 14:29:35.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c	2006-09-20 14:29:36.000000000 -0400
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
