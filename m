Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbUL3JTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbUL3JTh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 04:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbUL3JF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 04:05:56 -0500
Received: from smtp.knology.net ([24.214.63.101]:32138 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261592AbUL3Isi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:38 -0500
Date: Thu, 30 Dec 2004 03:48:37 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 20/22] typhoon: add management of outbound bundles
Message-Id: <20041230035000.29@ori.thedillows.org>
References: <20041230035000.28@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 01:04:39-05:00 dave@thedillows.org 
#   Add the offloading of outbound bundles.
#   
#   This is a tricky business, because there are restrictions on
#   the types and order of the xfrms we can offload. Some combinations
#   also yield incorrect results, so we have to reduce the amount of
#   offloading we do in those cases.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# drivers/net/typhoon.c
#   2004/12/30 01:04:20-05:00 dave@thedillows.org +134 -0
#   Add the offloading of outbound bundles.
#   
#   This is a tricky business, because there are restrictions on
#   the types and order of the xfrms we can offload. Some combinations
#   also yield incorrect results, so we have to reduce the amount of
#   offloading we do in those cases.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	2004-12-30 01:08:06 -05:00
+++ b/drivers/net/typhoon.c	2004-12-30 01:08:06 -05:00
@@ -2587,6 +2587,140 @@
 	spin_unlock_bh(&tp->offload_lock);
 }
 
+static inline int
+typhoon_max_offload(struct xfrm_bundle_list *xbl)
+{
+	/* Pre-scan the bundle to avoid offloading problematic sequences.
+	 * Only reduces the offload level to keep as much advantage as
+	 * possible.
+	 *
+	 * For 03.001.002 -- still problematic for 03.001.008, but need
+	 *	re-verify symptoms.
+	 *
+	 * inner AH tunnel, outer AH transport
+	 *	--> 3XP seems to put the inner hash at the wrong location
+	 * inner AH tunnel, outer ESP tunnel
+	 *	--> 3XP corrupts outer hash, maybe wrong place?
+	 * inner AH transport, outer ESP tunnel
+	 *	--> 3XP seems to encrypt the wrong portion of the packet
+	 * inner ESP transport, outer AH tunnel
+	 *	--> 3XP lockup, requires reset
+	 */
+	struct xfrm_bundle_list *bundle;
+	struct dst_entry *dst;
+	struct xfrm_state *x;
+	int last_was_ah = 0, last_was_tunnel = 0;
+	int max_level = 2;
+	int proto;
+
+	list_for_each_entry_reverse(bundle, &xbl->node, node) {
+		dst = bundle->dst;
+		x = dst->xfrm;
+
+		proto = x ? x->type->proto : IPPROTO_IP;
+
+		if(proto == IPPROTO_AH && x->props.mode &&
+					(last_was_ah ^ last_was_tunnel))
+			goto problem_offload;
+
+		if(proto == IPPROTO_AH && !x->props.mode &&
+					(!last_was_ah && last_was_tunnel))
+			goto problem_offload;
+
+		if(proto == IPPROTO_ESP && last_was_ah && last_was_tunnel)
+			goto problem_offload;
+
+		last_was_ah = (proto == IPPROTO_AH) ? 1 : 0;
+		last_was_tunnel = x ? x->props.mode : 0;
+		continue;
+
+problem_offload:
+		max_level--;
+		break;
+	}
+
+	return max_level;
+}
+
+static void
+typhoon_xfrm_bundle_add(struct net_device *dev, struct xfrm_bundle_list *xbl)
+{
+	/* Walk from the outermost dst back up the chain, offloading
+	 * until we hit something we cannot deal with.
+	 */
+	struct typhoon *tp = netdev_priv(dev);
+	struct xfrm_bundle_list *bundle;
+	struct dst_entry *dst;
+	struct xfrm_state *x;
+	struct xfrm_offload *xol;
+	struct typhoon_xfrm_offload *txo;
+	int proto;
+	int level = 0, max_level;
+	int last = -1;
+
+	smp_rmb();
+	if(tp->card_state != Running)
+		return;
+
+	max_level = typhoon_max_offload(xbl);
+
+	list_for_each_entry_reverse(bundle, &xbl->node, node) {
+		dst = bundle->dst;
+		x = dst->xfrm;
+
+		/* Only support IPv4 */
+		if(dst->ops->family != AF_INET)
+			goto cannot_offload;
+
+		proto = x ? x->type->proto : IPPROTO_IP;
+
+		switch(proto) {
+		case IPPROTO_IP:
+		case IPPROTO_IPIP:
+			if(last == IPPROTO_IP || last == IPPROTO_IPIP)
+				goto cannot_offload;
+			if(level)
+				level++;
+			last = proto;
+			continue;
+		case IPPROTO_ESP:
+			if(last != IPPROTO_AH)
+				level++;
+			break;
+		case IPPROTO_AH:
+			level++;
+			break;
+		default:
+			goto cannot_offload;
+		}
+
+		last = proto;
+		if(level > max_level)
+			goto cannot_offload;
+
+		if(dst->xfrm_offload)
+			continue;
+
+		xol = xfrm_offload_get(x, dev);
+		if(!xol) {
+			xol = typhoon_offload_ipsec(tp, x);
+			if(xol)
+				xfrm_offload_hold(xol);
+		}
+
+		if(!xol)
+			goto cannot_offload;
+
+		dst->xfrm_offload = xol;
+		txo = xfrm_offload_priv(xol);
+		if(txo->tunnel)
+			last = IPPROTO_IPIP;
+	}
+
+cannot_offload:
+	return;
+}
+
 static void
 typhoon_tx_timeout(struct net_device *dev)
 {
