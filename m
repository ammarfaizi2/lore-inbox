Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVJOUrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVJOUrW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 16:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVJOUrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 16:47:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36500 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751237AbVJOUrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 16:47:21 -0400
Message-Id: <200510152047.j9FKlDGb022996@shell0.pdx.osdl.net>
Subject: + revert-orinoco-information-leakage-due-to-incorrect-padding.patch added to -mm tree
To: linux-kernel@vger.kernel.org, alan@redhat.com, mm-commits@vger.kernel.org
From: akpm@osdl.org
Date: Sat, 15 Oct 2005 13:46:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch titled

     revert "orinoco: Information leakage due to incorrect padding"

has been added to the -mm tree.  Its filename is

     revert-orinoco-information-leakage-due-to-incorrect-padding.patch


From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Cc: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/net/wireless/orinoco.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff -puN drivers/net/wireless/orinoco.c~revert-orinoco-information-leakage-due-to-incorrect-padding drivers/net/wireless/orinoco.c
--- devel/drivers/net/wireless/orinoco.c~revert-orinoco-information-leakage-due-to-incorrect-padding	2005-10-15 13:46:12.000000000 -0700
+++ devel-akpm/drivers/net/wireless/orinoco.c	2005-10-15 13:46:37.000000000 -0700
@@ -503,14 +503,9 @@ static int orinoco_xmit(struct sk_buff *
 		return 0;
 	}
 
-	/* Check packet length, pad short packets, round up odd length */
-	len = max_t(int, ALIGN(skb->len, 2), ETH_ZLEN);
-	if (skb->len < len) {
-		skb = skb_padto(skb, len);
-		if (skb == NULL)
-			goto fail;
-	}
-	len -= ETH_HLEN;
+	/* Length of the packet body */
+	/* FIXME: what if the skb is smaller than this? */
+	len = max_t(int,skb->len - ETH_HLEN, ETH_ZLEN - ETH_HLEN);
 
 	eh = (struct ethhdr *)skb->data;
 
@@ -562,7 +557,8 @@ static int orinoco_xmit(struct sk_buff *
 		p = skb->data;
 	}
 
-	err = hermes_bap_pwrite(hw, USER_BAP, p, data_len,
+	/* Round up for odd length packets */
+	err = hermes_bap_pwrite(hw, USER_BAP, p, ALIGN(data_len, 2),
 				txfid, data_off);
 	if (err) {
 		printk(KERN_ERR "%s: Error %d writing packet to BAP\n",
_

Patches currently in -mm which might be from linux-kernel@vger.kernel.org are

revert-orinoco-information-leakage-due-to-incorrect-padding.patch
reiser4-only.patch

