Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268297AbUIKTlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268297AbUIKTlw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 15:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268299AbUIKTlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 15:41:52 -0400
Received: from stingr.net ([212.193.32.15]:49896 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S268297AbUIKTlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 15:41:14 -0400
Date: Sat, 11 Sep 2004 23:41:08 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [RFC] Support for wccp version 1 and 2 in ip_gre.c
Message-ID: <20040911194108.GS28258@stingr.sgu.ru>
Mail-Followup-To: netdev@oss.sgi.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Some time ago I posted the following patch.
It indeed adds support for wccp version 1 and 2 decapsulation in
ip_gre.c. But there is an open question.
I surrounded all decapsulation stuff in if (1).
Which knob I should use instead of that 1 to make this change
acceptable into mainline kernel?

Thanks in advance.

diff -urN linux-2.6.6-1.435/net/ipv4/ip_gre.c linux-2.6.6-1.435a/net/ipv4/ip_gre.c
--- linux-2.6.6-1.435/net/ipv4/ip_gre.c	2004-05-10 06:32:54.000000000 +0400
+++ linux-2.6.6-1.435a/net/ipv4/ip_gre.c	2004-06-30 16:38:43.781838344 +0400
@@ -553,6 +553,8 @@
 	return INET_ECN_encapsulate(tos, inner);
 }
 
+#define ETH_P_WCCP 0x883E
+
 int ipgre_rcv(struct sk_buff *skb)
 {
 	struct iphdr *iph;
@@ -605,13 +607,21 @@
 	if ((tunnel = ipgre_tunnel_lookup(iph->saddr, iph->daddr, key)) != NULL) {
 		secpath_reset(skb);
 
+		skb->protocol = *(u16*)(h + 2);
+		if (1) {
+			if ((flags == 0) && (skb->protocol == __constant_htons(ETH_P_WCCP))) {
+				skb->protocol = __constant_htons(ETH_P_IP);
+				if ((*(h + offset) & 0xF0) != 0x40) 
+					offset += 4;
+			}
+		}
+
 		skb->mac.raw = skb->nh.raw;
 		skb->nh.raw = __pskb_pull(skb, offset);
 		memset(&(IPCB(skb)->opt), 0, sizeof(struct ip_options));
 		if (skb->ip_summed == CHECKSUM_HW)
 			skb->csum = csum_sub(skb->csum,
 					     csum_partial(skb->mac.raw, skb->nh.raw-skb->mac.raw, 0));
-		skb->protocol = *(u16*)(h + 2);
 		skb->pkt_type = PACKET_HOST;
 #ifdef CONFIG_NET_IPGRE_BROADCAST
 		if (MULTICAST(iph->daddr)) {

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
