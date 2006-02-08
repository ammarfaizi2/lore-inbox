Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWBHGoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWBHGoe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbWBHGoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:44:17 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:17280 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161030AbWBHGoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:44:11 -0500
Message-Id: <20060208064909.520107000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:19 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 16/23] [PPP]: Fixed hardware RX checksum handling
Content-Disposition: inline; filename=fixed-hardware-rx-checksum-handling.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

    
When we pull the PPP protocol off the skb, we forgot to update the
hardware RX checksum.  This may lead to messages such as

	dsl0: hw csum failure.
    
Similarly, we need to clear the hardware checksum flag when we use
the existing packet to store the decompressed result.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/net/ppp_generic.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.15.3/drivers/net/ppp_generic.c
===================================================================
--- linux-2.6.15.3.orig/drivers/net/ppp_generic.c
+++ linux-2.6.15.3/drivers/net/ppp_generic.c
@@ -1610,6 +1610,8 @@ ppp_receive_nonmp_frame(struct ppp *ppp,
 		}
 		else if (!pskb_may_pull(skb, skb->len))
 			goto err;
+		else
+			skb->ip_summed = CHECKSUM_NONE;
 
 		len = slhc_uncompress(ppp->vj, skb->data + 2, skb->len - 2);
 		if (len <= 0) {
@@ -1690,6 +1692,7 @@ ppp_receive_nonmp_frame(struct ppp *ppp,
 			kfree_skb(skb);
 		} else {
 			skb_pull(skb, 2);	/* chop off protocol */
+			skb_postpull_rcsum(skb, skb->data - 2, 2);
 			skb->dev = ppp->dev;
 			skb->protocol = htons(npindex_to_ethertype[npi]);
 			skb->mac.raw = skb->data;

--
