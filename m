Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbUL3Iu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbUL3Iu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 03:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUL3Itg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 03:49:36 -0500
Received: from smtp.knology.net ([24.214.63.101]:25013 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261572AbUL3Isg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:36 -0500
Date: Thu, 30 Dec 2004 03:48:35 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 6/22] xfrm: add a parameter to xfrm_prune_bundles()
Message-Id: <20041230035000.15@ori.thedillows.org>
References: <20041230035000.14@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 00:35:34-05:00 dave@thedillows.org 
#   Add a parameter to the decision function(s) used by
#   xfrm_prune_bundles(). This will allow us to have more
#   fine grained selection of bundles pruned (like, say,
#   per device.)
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# net/xfrm/xfrm_policy.c
#   2004/12/30 00:35:16-05:00 dave@thedillows.org +10 -9
#   Add a parameter to the decision function(s) used by
#   xfrm_prune_bundles(). This will allow us to have more
#   fine grained selection of bundles pruned (like, say,
#   per device.)
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
--- a/net/xfrm/xfrm_policy.c	2004-12-30 01:11:05 -05:00
+++ b/net/xfrm/xfrm_policy.c	2004-12-30 01:11:05 -05:00
@@ -730,7 +730,7 @@
 		kfree(xbl);
 }
 
-static int stale_bundle(struct dst_entry *dst);
+static int stale_bundle(struct dst_entry *dst, void *unused);
 
 /* Main function: finds/creates a bundle for given flow.
  *
@@ -841,7 +841,7 @@
 		}
 
 		write_lock_bh(&policy->lock);
-		if (unlikely(policy->dead || stale_bundle(dst))) {
+		if (unlikely(policy->dead || stale_bundle(dst, NULL))) {
 			/* Wow! While we worked on resolving, this
 			 * policy has gone. Retry. It is not paranoia,
 			 * we just cannot enlist new bundle to dead object.
@@ -1022,14 +1022,14 @@
 
 static struct dst_entry *xfrm_dst_check(struct dst_entry *dst, u32 cookie)
 {
-	if (!stale_bundle(dst))
+	if (!stale_bundle(dst, NULL))
 		return dst;
 
 	dst_release(dst);
 	return NULL;
 }
 
-static int stale_bundle(struct dst_entry *dst)
+static int stale_bundle(struct dst_entry *dst, void *unused)
 {
 	struct dst_entry *child = dst;
 
@@ -1072,7 +1072,8 @@
 	return dst;
 }
 
-static void xfrm_prune_bundles(int (*func)(struct dst_entry *))
+static void xfrm_prune_bundles(int (*func)(struct dst_entry *, void *),
+					void *data)
 {
 	int i;
 	struct xfrm_policy *pol;
@@ -1084,7 +1085,7 @@
 			write_lock(&pol->lock);
 			dstp = &pol->bundles;
 			while ((dst=*dstp) != NULL) {
-				if (func(dst)) {
+				if (func(dst, data)) {
 					*dstp = dst->next;
 					dst->next = gc_list;
 					gc_list = dst;
@@ -1104,19 +1105,19 @@
 	}
 }
 
-static int unused_bundle(struct dst_entry *dst)
+static int unused_bundle(struct dst_entry *dst, void *unused)
 {
 	return !atomic_read(&dst->__refcnt);
 }
 
 static void __xfrm_garbage_collect(void)
 {
-	xfrm_prune_bundles(unused_bundle);
+	xfrm_prune_bundles(unused_bundle, NULL);
 }
 
 int xfrm_flush_bundles(void)
 {
-	xfrm_prune_bundles(stale_bundle);
+	xfrm_prune_bundles(stale_bundle, NULL);
 	return 0;
 }
 
