Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWJPAU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWJPAU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 20:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWJPAU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 20:20:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57254 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932219AbWJPAUz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 20:20:55 -0400
Date: Mon, 16 Oct 2006 01:20:50 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linus Torvalds <torvalds@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] bnep endianness bug: filtering by packet type
Message-ID: <20061016002050.GC29920@ftp.linux.org.uk>
References: <20061015213125.GU29920@ftp.linux.org.uk> <1160955253.14340.15.camel@localhost> <20061015235148.GZ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061015235148.GZ29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Thu, 16 Feb 2006 02:47:56 -0500
Subject: [PATCH] bnep endianness annotations

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/bluetooth/bnep/bnep.h |    4 ++--
 net/bluetooth/bnep/core.c |   12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
index bbb1ed7..0b6cd0e 100644
--- a/net/bluetooth/bnep/bnep.h
+++ b/net/bluetooth/bnep/bnep.h
@@ -95,14 +95,14 @@ struct bnep_setup_conn_req {
 struct bnep_set_filter_req {
 	__u8  type;
 	__u8  ctrl;
-	__u16 len;
+	__be16 len;
 	__u8  list[0];
 } __attribute__((packed));
 
 struct bnep_control_rsp {
 	__u8  type;
 	__u8  ctrl;
-	__u16 resp;
+	__be16 resp;
 } __attribute__((packed));
 
 struct bnep_ext_hdr {
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index b3f0b2b..3d8d97a 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -128,7 +128,7 @@ static inline void bnep_set_default_prot
 }
 #endif
 
-static int bnep_ctrl_set_netfilter(struct bnep_session *s, u16 *data, int len)
+static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data, int len)
 {
 	int n;
 
@@ -180,7 +180,7 @@ static int bnep_ctrl_set_mcfilter(struct
 	if (len < 2)
 		return -EILSEQ;
 
-	n = ntohs(get_unaligned((u16 *) data)); 
+	n = ntohs(get_unaligned((__be16 *) data));
 	data += 2; len -= 2;
 
 	if (len < n)
@@ -332,7 +332,7 @@ static inline int bnep_rx_frame(struct b
 	if (!skb_pull(skb, __bnep_rx_hlen[type & BNEP_TYPE_MASK]))
 		goto badframe;
 
-	s->eh.h_proto = get_unaligned((u16 *) (skb->data - 2));
+	s->eh.h_proto = get_unaligned((__be16 *) (skb->data - 2));
 
 	if (type & BNEP_EXT_HEADER) {
 		if (bnep_rx_extension(s, skb) < 0)
@@ -343,7 +343,7 @@ static inline int bnep_rx_frame(struct b
 	if (ntohs(s->eh.h_proto) == 0x8100) {
 		if (!skb_pull(skb, 4))
 			goto badframe;
-		s->eh.h_proto = get_unaligned((u16 *) (skb->data - 2));
+		s->eh.h_proto = get_unaligned((__be16 *) (skb->data - 2));
 	}
 	
 	/* We have to alloc new skb and copy data here :(. Because original skb
@@ -365,7 +365,7 @@ static inline int bnep_rx_frame(struct b
 	case BNEP_COMPRESSED_SRC_ONLY:
 		memcpy(__skb_put(nskb, ETH_ALEN), s->eh.h_dest, ETH_ALEN);
 		memcpy(__skb_put(nskb, ETH_ALEN), skb->mac.raw, ETH_ALEN);
-		put_unaligned(s->eh.h_proto, (u16 *) __skb_put(nskb, 2));
+		put_unaligned(s->eh.h_proto, (__be16 *) __skb_put(nskb, 2));
 		break;
 
 	case BNEP_COMPRESSED_DST_ONLY:
@@ -375,7 +375,7 @@ static inline int bnep_rx_frame(struct b
 
 	case BNEP_GENERAL:
 		memcpy(__skb_put(nskb, ETH_ALEN * 2), skb->mac.raw, ETH_ALEN * 2);
-		put_unaligned(s->eh.h_proto, (u16 *) __skb_put(nskb, 2));
+		put_unaligned(s->eh.h_proto, (__be16 *) __skb_put(nskb, 2));
 		break;
 	}
 
-- 
1.4.2.GIT

