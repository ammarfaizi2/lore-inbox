Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWJPAUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWJPAUR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 20:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWJPAUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 20:20:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56230 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932216AbWJPAUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 20:20:15 -0400
Date: Mon, 16 Oct 2006 01:20:10 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linus Torvalds <torvalds@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] bnep endianness bug: filtering by packet type
Message-ID: <20061016002010.GB29920@ftp.linux.org.uk>
References: <20061015213125.GU29920@ftp.linux.org.uk> <1160955253.14340.15.camel@localhost> <20061015235148.GZ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061015235148.GZ29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sun, 15 Oct 2006 20:13:58 -0400
Subject: [PATCH] bnep endianness bug: filtering by packet type

<= and => don't work well on net-endian...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/bluetooth/bnep/core.c   |   16 ++++++++--------
 net/bluetooth/bnep/netdev.c |   11 ++++++-----
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 2312d05..b3f0b2b 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -117,14 +117,14 @@ #ifdef CONFIG_BT_BNEP_PROTO_FILTER
 static inline void bnep_set_default_proto_filter(struct bnep_session *s)
 {
 	/* (IPv4, ARP)  */
-	s->proto_filter[0].start = htons(0x0800);
-	s->proto_filter[0].end   = htons(0x0806);
+	s->proto_filter[0].start = ETH_P_IP;
+	s->proto_filter[0].end   = ETH_P_ARP;
 	/* (RARP, AppleTalk) */
-	s->proto_filter[1].start = htons(0x8035);
-	s->proto_filter[1].end   = htons(0x80F3);
+	s->proto_filter[1].start = ETH_P_RARP;
+	s->proto_filter[1].end   = ETH_P_AARP;
 	/* (IPX, IPv6) */
-	s->proto_filter[2].start = htons(0x8137);
-	s->proto_filter[2].end   = htons(0x86DD);
+	s->proto_filter[2].start = ETH_P_IPX;
+	s->proto_filter[2].end   = ETH_P_IPV6;
 }
 #endif
 
@@ -150,8 +150,8 @@ #ifdef CONFIG_BT_BNEP_PROTO_FILTER
 		int i;
 
 		for (i = 0; i < n; i++) {
-			f[i].start = get_unaligned(data++);
-			f[i].end   = get_unaligned(data++);
+			f[i].start = ntohs(get_unaligned(data++));
+			f[i].end   = ntohs(get_unaligned(data++));
 
 			BT_DBG("proto filter start %d end %d",
 				f[i].start, f[i].end);
diff --git a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
index 7f7b27d..67a002a 100644
--- a/net/bluetooth/bnep/netdev.c
+++ b/net/bluetooth/bnep/netdev.c
@@ -158,14 +158,15 @@ #ifdef CONFIG_BT_BNEP_PROTO_FILTER
 static inline u16 bnep_net_eth_proto(struct sk_buff *skb)
 {
 	struct ethhdr *eh = (void *) skb->data;
+	u16 proto = ntohs(eh->h_proto);
 	
-	if (ntohs(eh->h_proto) >= 1536)
-		return eh->h_proto;
+	if (proto >= 1536)
+		return proto;
 		
-	if (get_unaligned((u16 *) skb->data) == 0xFFFF)
-		return htons(ETH_P_802_3);
+	if (get_unaligned((__be16 *) skb->data) == htons(0xFFFF))
+		return ETH_P_802_3;
 		
-	return htons(ETH_P_802_2);
+	return ETH_P_802_2;
 }
 
 static inline int bnep_net_proto_filter(struct sk_buff *skb, struct bnep_session *s)
-- 
1.4.2.GIT
