Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbUL3Iu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbUL3Iu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 03:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbUL3IuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 03:50:08 -0500
Received: from smtp.knology.net ([24.214.63.101]:35037 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261573AbUL3Ish (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:37 -0500
Date: Thu, 30 Dec 2004 03:48:35 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 7/22] xfrm: Allow device drivers to force recalculation of offloads
Message-Id: <20041230035000.16@ori.thedillows.org>
References: <20041230035000.15@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 00:37:44-05:00 dave@thedillows.org 
#   Give device drivers a method to allow the use of crypto
#   offload features for existing xfrm_states and bundles, as
#   well as dynamically remove crypto offload capabilities.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# net/xfrm/xfrm_state.c
#   2004/12/30 00:37:26-05:00 dave@thedillows.org +39 -0
#   When we've been informed of a new device that can offload
#   xfrm crypto operations, go ahead and offload existing inbound
#   xfrm_states to it.
#   
#   When we're removing crypto offload capabilities, remove every
#   offload instance for that device.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# net/xfrm/xfrm_policy.c
#   2004/12/30 00:37:26-05:00 dave@thedillows.org +17 -0
#   When adding/removing xfrm offload capable device, give the xfrm_state
#   engine a chance to make the changes it needs, then flush any existing
#   bundles that use the device so that future flows get a chance to use
#   the offload features (for add), or resume using the software crypto
#   routines (for remove).
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# net/xfrm/xfrm_export.c
#   2004/12/30 00:37:26-05:00 dave@thedillows.org +2 -0
#   Export the driver-visible API.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# include/net/xfrm.h
#   2004/12/30 00:37:26-05:00 dave@thedillows.org +4 -0
#   Prototypes for the new routines.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/include/net/xfrm.h b/include/net/xfrm.h
--- a/include/net/xfrm.h	2004-12-30 01:10:52 -05:00
+++ b/include/net/xfrm.h	2004-12-30 01:10:52 -05:00
@@ -833,6 +833,8 @@
 extern struct xfrm_state *xfrm_find_acq_byseq(u32 seq);
 extern void xfrm_state_delete(struct xfrm_state *x);
 extern void xfrm_state_flush(u8 proto);
+extern void xfrm_state_accel_add(struct net_device *dev);
+extern void xfrm_state_accel_flush(struct net_device *dev);
 extern int xfrm_replay_check(struct xfrm_state *x, u32 seq);
 extern void xfrm_replay_advance(struct xfrm_state *x, u32 seq);
 extern int xfrm_state_check(struct xfrm_state *x, struct sk_buff *skb);
@@ -888,6 +890,8 @@
 extern int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol);
 extern struct xfrm_policy *xfrm_sk_policy_lookup(struct sock *sk, int dir, struct flowi *fl);
 extern int xfrm_flush_bundles(void);
+extern void xfrm_accel_add(struct net_device *dev);
+extern void xfrm_accel_flush(struct net_device *dev);
 
 extern wait_queue_head_t km_waitq;
 extern void km_state_expired(struct xfrm_state *x, int hard);
diff -Nru a/net/xfrm/xfrm_export.c b/net/xfrm/xfrm_export.c
--- a/net/xfrm/xfrm_export.c	2004-12-30 01:10:52 -05:00
+++ b/net/xfrm/xfrm_export.c	2004-12-30 01:10:52 -05:00
@@ -63,3 +63,5 @@
 EXPORT_SYMBOL_GPL(skb_icv_walk);
 
 EXPORT_SYMBOL_GPL(xfrm_state_offload_add);
+EXPORT_SYMBOL_GPL(xfrm_accel_add);
+EXPORT_SYMBOL_GPL(xfrm_accel_flush);
diff -Nru a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
--- a/net/xfrm/xfrm_policy.c	2004-12-30 01:10:52 -05:00
+++ b/net/xfrm/xfrm_policy.c	2004-12-30 01:10:52 -05:00
@@ -1121,6 +1121,23 @@
 	return 0;
 }
 
+static int bundle_uses_dev(struct dst_entry *dst, void *dev)
+{
+	return (dst->dev == dev);
+}
+
+void xfrm_accel_add(struct net_device *dev)
+{
+	xfrm_state_accel_add(dev);
+	xfrm_prune_bundles(bundle_uses_dev, dev);
+}
+
+void xfrm_accel_flush(struct net_device *dev)
+{
+	xfrm_state_accel_flush(dev);
+	xfrm_prune_bundles(bundle_uses_dev, dev);
+}
+
 /* Well... that's _TASK_. We need to scan through transformation
  * list and figure out what mss tcp should generate in order to
  * final datagram fit to mtu. Mama mia... :-)
diff -Nru a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
--- a/net/xfrm/xfrm_state.c	2004-12-30 01:10:52 -05:00
+++ b/net/xfrm/xfrm_state.c	2004-12-30 01:10:52 -05:00
@@ -998,6 +998,45 @@
 		xfrm_offload_release(old);
 }
 
+static int try_new_accel(struct xfrm_state *x, int unused, void *data)
+{
+	struct net_device *dev = data;
+
+	if (x->dir == XFRM_STATE_DIR_IN)
+		dev->xfrm_state_add(dev, x);
+	return 0;
+}
+
+static int remove_stale_accel(struct xfrm_state *x, int unused, void *dev)
+{
+	struct xfrm_offload *xol, *entry = NULL;
+
+	spin_lock(&x->lock);
+	list_for_each_entry(xol, &x->offloads, bydev) {
+		if (xol->dev == dev) {
+			list_del(&xol->bydev);
+			entry = xol;
+			break;
+		}
+	}
+	spin_unlock(&x->lock);
+
+	if (entry)
+		xfrm_offload_release(entry);
+
+	return 0;
+}
+
+void xfrm_state_accel_add(struct net_device *dev)
+{
+	xfrm_state_walk(IPSEC_PROTO_ANY, try_new_accel, dev);
+}
+
+void xfrm_state_accel_flush(struct net_device *dev)
+{
+	xfrm_state_walk(IPSEC_PROTO_ANY, remove_stale_accel, dev);
+}
+
 void __init xfrm_state_init(void)
 {
 	int i;
