Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUL3Izc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUL3Izc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 03:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbUL3IzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 03:55:08 -0500
Received: from smtp.knology.net ([24.214.63.101]:30858 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261580AbUL3Ish (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:37 -0500
Date: Thu, 30 Dec 2004 03:48:35 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 5/22] xfrm: Attempt to offload bundled xfrm_states for outbound xfrms
Message-Id: <20041230035000.14@ori.thedillows.org>
References: <20041230035000.13@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 00:34:46-05:00 dave@thedillows.org 
#   Plumb in offloading new bundles for outgoing packets.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# net/xfrm/xfrm_policy.c
#   2004/12/30 00:34:28-05:00 dave@thedillows.org +28 -0
#   When we create a new bundle for an outbound flow, try to
#   offload as much as the destination driver will allow.
#   
#   Don't forget to clean up....
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# include/net/xfrm.h
#   2004/12/30 00:34:28-05:00 dave@thedillows.org +6 -0
#   A convenience structure for offloading bundles.
#   
#   The dst->child field gives us a singly linked list
#   from upper protocols to outer transforms. Drivers, however,
#   will likely have a limited number of offloads they can
#   perform on a particular packet, so they need to offload
#   the bundle from the outside in. This list makes it easier
#   for them.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# include/net/dst.h
#   2004/12/30 00:34:28-05:00 dave@thedillows.org +1 -0
#   Add a field to store the offload information for this part
#   of the outgoing bundle (non-NULL if this dst is offloaded.)
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/include/net/dst.h b/include/net/dst.h
--- a/include/net/dst.h	2004-12-30 01:11:18 -05:00
+++ b/include/net/dst.h	2004-12-30 01:11:18 -05:00
@@ -65,6 +65,7 @@
 	struct neighbour	*neighbour;
 	struct hh_cache		*hh;
 	struct xfrm_state	*xfrm;
+	struct xfrm_offload	*xfrm_offload;
 
 	int			(*input)(struct sk_buff*);
 	int			(*output)(struct sk_buff*);
diff -Nru a/include/net/xfrm.h b/include/net/xfrm.h
--- a/include/net/xfrm.h	2004-12-30 01:11:18 -05:00
+++ b/include/net/xfrm.h	2004-12-30 01:11:18 -05:00
@@ -178,6 +178,12 @@
 	atomic_t		refcnt;
 };
 
+struct xfrm_bundle_list
+{
+	struct list_head	node;
+	struct dst_entry *	dst;
+};
+
 struct xfrm_type;
 struct xfrm_dst;
 struct xfrm_policy_afinfo {
diff -Nru a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
--- a/net/xfrm/xfrm_policy.c	2004-12-30 01:11:18 -05:00
+++ b/net/xfrm/xfrm_policy.c	2004-12-30 01:11:18 -05:00
@@ -705,6 +705,31 @@
 	};
 }
 
+static void xfrm_accel_bundle(struct dst_entry *dst)
+{
+	struct xfrm_bundle_list bundle, *xbl, *tmp;
+	struct net_device *dev = dst->dev;
+	INIT_LIST_HEAD(&bundle.node);
+
+	if (dev && netif_running(dev) && (dev->features & NETIF_F_IPSEC)) {
+		while (dst) {
+			xbl = kmalloc(sizeof(*xbl), GFP_ATOMIC);
+			if (!xbl)
+				goto out;
+
+			xbl->dst = dst;
+			list_add_tail(&xbl->node, &bundle.node);
+			dst = dst->child;
+		}
+
+		dev->xfrm_bundle_add(dev, &bundle);
+	}
+
+out:
+	list_for_each_entry_safe(xbl, tmp, &bundle.node, node)
+		kfree(xbl);
+}
+
 static int stale_bundle(struct dst_entry *dst);
 
 /* Main function: finds/creates a bundle for given flow.
@@ -833,6 +858,7 @@
 		policy->bundles = dst;
 		dst_hold(dst);
 		write_unlock_bh(&policy->lock);
+		xfrm_accel_bundle(dst);
 	}
 	*dst_p = dst;
 	dst_release(dst_orig);
@@ -1023,8 +1049,10 @@
 {
 	if (!dst->xfrm)
 		return;
+	xfrm_offload_release(dst->xfrm_offload);
 	xfrm_state_put(dst->xfrm);
 	dst->xfrm = NULL;
+	dst->xfrm_offload = NULL;
 }
 
 static void xfrm_link_failure(struct sk_buff *skb)
