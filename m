Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVCRS1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVCRS1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 13:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVCRS1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 13:27:10 -0500
Received: from dd3624.kasserver.com ([81.209.188.85]:41947 "EHLO
	dd3624.kasserver.com") by vger.kernel.org with ESMTP
	id S262007AbVCRSZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 13:25:52 -0500
From: Sven Henkel <shenkel@gmail.com>
Message-ID: <16955.7466.627773.654710@gargle.gargle.HOWL>
Date: Fri, 18 Mar 2005 19:25:46 +0100
To: maxk@qualcomm.com, vtun@office.satix.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix alignment in tun_get_user
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
X-Spam-Flag: NO
X-Spam-score: -1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch fixes an alignment-problem in tun_get_user: Only
ethernet-frames need to be headed by 2 bytes (due to their size of 14
bytes), IP-frames should not be touched. The patch changes
tun_get_user to reserve 2 bytes of the skb for TUN_TAP_DEVs and 0
bytes otherwise.

Ciao,
Sven

--- linux-2.6.11.2/drivers/net/tun.c	2005-03-09 09:11:32.000000000 +0100
+++ mylinux-2.6.11.2/drivers/net/tun.c	2005-03-18 18:19:02.906871952 +0100
@@ -226,7 +226,7 @@ static __inline__ ssize_t tun_get_user(s
 {
 	struct tun_pi pi = { 0, __constant_htons(ETH_P_IP) };
 	struct sk_buff *skb;
-	size_t len = count;
+	size_t len = count, align = 0;
 
 	if (!(tun->flags & TUN_NO_PI)) {
 		if ((len -= sizeof(pi)) > len)
@@ -235,13 +235,17 @@ static __inline__ ssize_t tun_get_user(s
 		if(memcpy_fromiovec((void *)&pi, iv, sizeof(pi)))
 			return -EFAULT;
 	}
+
+	if ((tun->flags & TUN_TYPE_MASK) == TUN_TAP_DEV)
+		align = NET_IP_ALIGN;
  
-	if (!(skb = alloc_skb(len + 2, GFP_KERNEL))) {
+	if (!(skb = alloc_skb(len + align, GFP_KERNEL))) {
 		tun->stats.rx_dropped++;
 		return -ENOMEM;
 	}
 
-	skb_reserve(skb, 2);
+	if (align)
+		skb_reserve(skb, align);
 	if (memcpy_fromiovec(skb_put(skb, len), iv, len))
 		return -EFAULT;
 

