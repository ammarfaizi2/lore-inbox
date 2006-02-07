Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWBGQfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWBGQfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWBGQff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:35:35 -0500
Received: from ns1.coraid.com ([65.14.39.133]:50818 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932107AbWBGQff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:35:35 -0500
Message-ID: <169b5d8496ed632078ff173d03178ede@coraid.com>
Date: Tue, 7 Feb 2006 11:26:39 -0500
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.16-rc2-git2-gkh] aoe [1/3]: support multiple AoE listeners
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Always clone incoming skbs, allowing other AoE listeners
to exist in the kernel.

diff -upr 2.6.16-rc2-git2-gkh-orig/drivers/block/aoe/aoenet.c 2.6.16-rc2-git2-gkh-aoe/drivers/block/aoe/aoenet.c
--- 2.6.16-rc2-git2-gkh-orig/drivers/block/aoe/aoenet.c	2006-02-06 17:41:05.000000000 -0500
+++ 2.6.16-rc2-git2-gkh-aoe/drivers/block/aoe/aoenet.c	2006-02-06 17:56:59.000000000 -0500
@@ -92,18 +92,6 @@ mac_addr(char addr[6])
 	return __be64_to_cpu(n);
 }
 
-static struct sk_buff *
-skb_check(struct sk_buff *skb)
-{
-	if (skb_is_nonlinear(skb))
-	if ((skb = skb_share_check(skb, GFP_ATOMIC)))
-	if (skb_linearize(skb, GFP_ATOMIC) < 0) {
-		dev_kfree_skb(skb);
-		return NULL;
-	}
-	return skb;
-}
-
 void
 aoenet_xmit(struct sk_buff *sl)
 {
@@ -125,14 +113,14 @@ aoenet_rcv(struct sk_buff *skb, struct n
 	struct aoe_hdr *h;
 	u32 n;
 
-	skb = skb_check(skb);
-	if (!skb)
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (skb == NULL)
 		return 0;
-
+	if (skb_is_nonlinear(skb))
+	if (skb_linearize(skb, GFP_ATOMIC) < 0)
+		goto exit;
 	if (!is_aoe_netif(ifp))
 		goto exit;
-
-	//skb->len += ETH_HLEN;	/* (1) */
 	skb_push(skb, ETH_HLEN);	/* (1) */
 
 	h = (struct aoe_hdr *) skb->mac.raw;


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
