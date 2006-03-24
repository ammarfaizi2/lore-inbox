Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423183AbWCXGP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423183AbWCXGP7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWCXGME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:12:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:41946 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161017AbWCXGLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:11:53 -0500
Cc: "Ed L. Cashin" <ecashin@coraid.com>, "Ed L. Cashin" <ecashin@coraid.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/12] aoe [1/3]: support multiple AoE listeners
In-Reply-To: <1143180654198-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 22:10:54 -0800
Message-Id: <1143180654720-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Always clone incoming skbs, allowing other AoE listeners
to exist in the kernel.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/block/aoe/aoenet.c |   22 +++++-----------------
 1 files changed, 5 insertions(+), 17 deletions(-)

5dc401ee74c5d6a24867acd8302c55da9ae4f0ce
diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 4be9769..fdff774 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
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
1.2.4


