Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422641AbWJOVaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbWJOVaq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 17:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161178AbWJOVaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 17:30:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:24283 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161174AbWJOVap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 17:30:45 -0400
Date: Sun, 15 Oct 2006 22:30:39 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH] bnep endianness annotations
Message-ID: <20061015213039.GT29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/bluetooth/bnep/bnep.h   |    8 ++++----
 net/bluetooth/bnep/core.c   |   12 ++++++------
 net/bluetooth/bnep/netdev.c |    4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
index bbb1ed7..9ffaf1d 100644
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
@@ -143,8 +143,8 @@ struct bnep_connlist_req {
 };
 
 struct bnep_proto_filter {
-	__u16 start;
-	__u16 end;
+	__be16 start;
+	__be16 end;
 };
 
 int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock);
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 2312d05..f0fbee3 100644
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
 
diff --git a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
index 7f7b27d..916172d 100644
--- a/net/bluetooth/bnep/netdev.c
+++ b/net/bluetooth/bnep/netdev.c
@@ -155,7 +155,7 @@ #endif
 
 #ifdef CONFIG_BT_BNEP_PROTO_FILTER
 /* Determine ether protocol. Based on eth_type_trans. */
-static inline u16 bnep_net_eth_proto(struct sk_buff *skb)
+static inline __be16 bnep_net_eth_proto(struct sk_buff *skb)
 {
 	struct ethhdr *eh = (void *) skb->data;
 	
@@ -170,7 +170,7 @@ static inline u16 bnep_net_eth_proto(str
 
 static inline int bnep_net_proto_filter(struct sk_buff *skb, struct bnep_session *s)
 {
-	u16 proto = bnep_net_eth_proto(skb);
+	__be16 proto = bnep_net_eth_proto(skb);
 	struct bnep_proto_filter *f = s->proto_filter;
 	int i;
 	
-- 
1.4.2.GIT

