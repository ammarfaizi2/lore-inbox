Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWJ3KhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWJ3KhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161228AbWJ3KhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:37:18 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:30390 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161225AbWJ3KhQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:37:16 -0500
To: marcel@holtmann.org
Subject: [PATCH] bnep endianness annotations
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Message-Id: <E1GeUW3-0002Wk-Su@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 30 Oct 2006 10:37:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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
index 4e822f0..7ba6470 100644
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


