Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbUL3Iu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbUL3Iu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 03:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUL3Iu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 03:50:29 -0500
Received: from smtp.knology.net ([24.214.63.101]:60127 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261575AbUL3Ish (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:37 -0500
Date: Thu, 30 Dec 2004 03:48:35 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 4/22] xfrm: Try to offload inbound xfrm_states
Message-Id: <20041230035000.13@ori.thedillows.org>
References: <20041230035000.12@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 00:33:11-05:00 dave@thedillows.org 
#   Plumb in offloading of inbound xfrm_states.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# net/xfrm/xfrm_state.c
#   2004/12/30 00:32:54-05:00 dave@thedillows.org +28 -1
#   Try to offload an inbound xfrm_state when it is added or updated.
#   Since it could potentially come in from any interface, try to
#   offload it on all devices that support it.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
--- a/net/xfrm/xfrm_state.c	2004-12-30 01:11:30 -05:00
+++ b/net/xfrm/xfrm_state.c	2004-12-30 01:11:30 -05:00
@@ -398,6 +398,26 @@
 	spin_unlock_bh(&xfrm_state_lock);
 }
 
+static void xfrm_state_inbound_accel(struct xfrm_state *x)
+{
+	/* Only called for an inbound xfrm_state. Since it could
+	 * possibly arrive on any interface, try to offload it
+	 * on all devices that are capable.
+	 */
+	struct net_device *dev;
+
+	rtnl_lock();
+	read_lock(&dev_base_lock);
+	dev = dev_base;
+	while (dev) {
+		if (netif_running(dev) && (dev->features & NETIF_F_IPSEC))
+			dev->xfrm_state_add(dev, x);
+		dev = dev->next;
+	}
+	read_unlock(&dev_base_lock);
+	rtnl_unlock();
+}
+
 static struct xfrm_state *__xfrm_find_acq_byseq(u32 seq);
 
 int xfrm_state_add(struct xfrm_state *x)
@@ -444,6 +464,9 @@
 	spin_unlock_bh(&xfrm_state_lock);
 	xfrm_state_put_afinfo(afinfo);
 
+	if (!err && x->dir == XFRM_STATE_DIR_IN)
+		xfrm_state_inbound_accel(x);
+
 	if (x1) {
 		xfrm_state_delete(x1);
 		xfrm_state_put(x1);
@@ -455,7 +478,7 @@
 int xfrm_state_update(struct xfrm_state *x)
 {
 	struct xfrm_state_afinfo *afinfo;
-	struct xfrm_state *x1;
+	struct xfrm_state *x1, *accel = NULL;
 	int err;
 
 	afinfo = xfrm_state_get_afinfo(x->props.family);
@@ -479,6 +502,7 @@
 
 	if (x1->km.state == XFRM_STATE_ACQ) {
 		__xfrm_state_insert(x);
+		accel = x;
 		x = NULL;
 	}
 	err = 0;
@@ -489,6 +513,9 @@
 
 	if (err)
 		return err;
+
+	if (accel && accel->dir == XFRM_STATE_DIR_IN)
+		xfrm_state_inbound_accel(accel);
 
 	if (!x) {
 		xfrm_state_delete(x1);
