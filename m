Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbUL3Izg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbUL3Izg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 03:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUL3Ixy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 03:53:54 -0500
Received: from smtp.knology.net ([24.214.63.101]:60383 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261577AbUL3Ish (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:37 -0500
Date: Thu, 30 Dec 2004 03:48:35 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 8/22] skbuff: Add routines to manage applied offloads per skb
Message-Id: <20041230035000.17@ori.thedillows.org>
References: <20041230035000.16@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 00:40:20-05:00 dave@thedillows.org 
#   Add fields to sk_buff to track offloaded xfrm_states for this
#   packet. On Tx, these will be pointers to struct xfrm_offload.
#   On Rx, these will be a 4 bit bitfield indicating what operations
#   were performed, and the result of those operations.
#   
#   skb_push_xfrm_offload() records an offloaded xfrm on Tx. It will
#   	return an error code if it is unable to record the offload.
#   skb_get_xfrm_offload() returns the xfrm_offload struct at the
#   	given position on the stack. It will return NULL if there
#   	are no more offloads available.
#   skb_has_xfrm_offload() returns true if the sk_buff has offload
#   	information available.
#   skb_put_xfrm_result() records an offload result on Rx at the given
#   	index. It will return an error code if it is unable to
#   	record the result.
#   skb_pop_xfrm_result() pops the current offload result from the.
#   	stack. If there are no more results, it will return
#   	XFRM_OFFLOAD_NONE.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# net/core/skbuff.c
#   2004/12/30 00:40:02-05:00 dave@thedillows.org +31 -0
#   When an sk_buff is cloned, we must gain a reference to each
#   xfrm_offload that it references.
#   
#   When an sk_buff is freed, we must release our references
#   to the xfrm_offloads attached to it.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# include/net/xfrm.h
#   2004/12/30 00:40:02-05:00 dave@thedillows.org +9 -0
#   Add the values for the result bitfield.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# include/linux/skbuff.h
#   2004/12/30 00:40:02-05:00 dave@thedillows.org +55 -0
#   Add the fields and functins to track offloads and results, as
#   well as the current position in the stack.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h	2004-12-30 01:10:39 -05:00
+++ b/include/linux/skbuff.h	2004-12-30 01:10:39 -05:00
@@ -146,6 +146,14 @@
 	skb_frag_t	frags[MAX_SKB_FRAGS];
 };
 
+/* XXX UGH. We cannot include <net/xfrm.h> in this file without some
+ * header file surgery, so define our own max xfrm depth. This should
+ * be kept >= XFRM_MAX_DEPTH until we fix the includes, and it can
+ * go away.
+ */
+#define SKB_XFRM_MAX_DEPTH 4
+struct xfrm_offload;
+
 /** 
  *	struct sk_buff - socket buffer
  *	@next: Next buffer in list
@@ -187,6 +195,8 @@
  *	@nf_bridge: Saved data about a bridged frame - see br_netfilter.c
  *      @private: Data which is private to the HIPPI implementation
  *	@tc_index: Traffic control index
+ *	@xfrm_offload: Tx offload info, Rx offload results
+ *	@xfrm_offload_idx: The number of cookies/results stored currently
  */
 
 struct sk_buff {
@@ -272,6 +282,8 @@
 
 #endif
 
+	int			xfrm_offload_idx;
+	struct xfrm_offload *	xfrm_offload[SKB_XFRM_MAX_DEPTH];
 
 	/* These elements must be at the end, see alloc_skb() for details.  */
 	unsigned int		truesize;
@@ -1178,6 +1190,49 @@
 #else /* CONFIG_NETFILTER */
 static inline void nf_reset(struct sk_buff *skb) {}
 #endif /* CONFIG_NETFILTER */
+
+static inline int skb_push_xfrm_offload(struct sk_buff *skb,
+					struct xfrm_offload *xol)
+{
+	if (likely(skb->xfrm_offload_idx < SKB_XFRM_MAX_DEPTH)) {
+		skb->xfrm_offload[skb->xfrm_offload_idx++] = xol;
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
+static inline struct xfrm_offload *
+skb_get_xfrm_offload(const struct sk_buff *skb, int idx)
+{
+	if (likely(idx < skb->xfrm_offload_idx))
+		return skb->xfrm_offload[idx];
+	else
+		return NULL;
+}
+
+static inline int skb_has_xfrm_offload(const struct sk_buff *skb)
+{
+	return !!skb_get_xfrm_offload(skb, 0);
+}
+
+static inline int skb_put_xfrm_result(struct sk_buff *skb, int result, int idx)
+{
+	if (likely(idx < SKB_XFRM_MAX_DEPTH)) {
+		skb->xfrm_offload[idx] = (struct xfrm_offload *) result;
+		return 0;
+	}
+	return -ENOMEM;
+}
+
+static inline int skb_pop_xfrm_result(struct sk_buff *skb)
+{
+	/* XXX XFRM_OFFLOAD_NONE == 0, but cannot include <net/xfrm.h> */
+	int res = 0;
+	if (likely(skb->xfrm_offload_idx < SKB_XFRM_MAX_DEPTH))
+		res = (int) skb->xfrm_offload[skb->xfrm_offload_idx++];
+	return res;
+}
 
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff -Nru a/include/net/xfrm.h b/include/net/xfrm.h
--- a/include/net/xfrm.h	2004-12-30 01:10:39 -05:00
+++ b/include/net/xfrm.h	2004-12-30 01:10:39 -05:00
@@ -171,6 +171,15 @@
 	XFRM_STATE_DIR_OUT,
 };
 
+enum {
+	XFRM_OFFLOAD_NONE = 0,
+	XFRM_OFFLOAD_CONF = 1,
+	XFRM_OFFLOAD_AUTH = 2,
+	XFRM_OFFLOAD_AUTH_OK = 4,
+	XFRM_OFFLOAD_AUTH_FAIL = 8,
+	XFRM_OFFLOAD_FIELD = 0x0f
+};
+
 struct xfrm_offload
 {
 	struct list_head	bydev;
diff -Nru a/net/core/skbuff.c b/net/core/skbuff.c
--- a/net/core/skbuff.c	2004-12-30 01:10:39 -05:00
+++ b/net/core/skbuff.c	2004-12-30 01:10:39 -05:00
@@ -230,6 +230,14 @@
 
 	dst_release(skb->dst);
 #ifdef CONFIG_XFRM
+	{
+		int i = 0;
+		struct xfrm_offload *xol;
+		while ((xol = skb_get_xfrm_offload(skb, i++)) != NULL) {
+			if ((unsigned long) xol > XFRM_OFFLOAD_FIELD)
+				xfrm_offload_release(xol);
+		}
+	}
 	secpath_put(skb->sp);
 #endif
 	if(skb->destructor) {
@@ -334,6 +342,17 @@
 #endif
 
 #endif
+	C(xfrm_offload_idx);
+	memcpy(n->xfrm_offload, skb->xfrm_offload,
+			sizeof(struct xfrm_offload *) * SKB_XFRM_MAX_DEPTH);
+	{
+		int i = 0;
+		struct xfrm_offload *xol;
+		while ((xol = skb_get_xfrm_offload(skb, i++)) != NULL) {
+			if ((unsigned long) xol > XFRM_OFFLOAD_FIELD)
+				xfrm_offload_hold(xol);
+		}
+	}
 	C(truesize);
 	atomic_set(&n->users, 1);
 	C(head);
@@ -396,6 +415,18 @@
 	atomic_set(&new->users, 1);
 	skb_shinfo(new)->tso_size = skb_shinfo(old)->tso_size;
 	skb_shinfo(new)->tso_segs = skb_shinfo(old)->tso_segs;
+
+	new->xfrm_offload_idx = old->xfrm_offload_idx;
+	memcpy(new->xfrm_offload, old->xfrm_offload,
+			sizeof(struct xfrm_offload *) * SKB_XFRM_MAX_DEPTH);
+	{
+		int i = 0;
+		struct xfrm_offload *xol;
+		while ((xol = skb_get_xfrm_offload(old, i++)) != NULL) {
+			if ((unsigned long) xol > XFRM_OFFLOAD_FIELD)
+				xfrm_offload_hold(xol);
+		}
+	}
 }
 
 /**
