Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbUL3Izh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbUL3Izh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 03:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbUL3IwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 03:52:19 -0500
Received: from smtp.knology.net ([24.214.63.101]:35293 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261574AbUL3Ish (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:37 -0500
Date: Thu, 30 Dec 2004 03:48:35 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 3/22] xfrm: Add offload management routines
Message-Id: <20041230035000.12@ori.thedillows.org>
References: <20041230035000.11@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 00:31:03-05:00 dave@thedillows.org 
#   Add offload management to xfrm_state.
#   
#   xfrm_offload_alloc() creates a new xfrm_offload, with a private
#   	part to be used by the driver (ala net_device->priv)
#   	The returned offload may be kfree'd if it has not been
#   	added to a xfrm_state using xfrm_state_offload_add().
#   xfrm_offload_priv() returns a pointer to the private area of
#   	the xfrm_offload. This will be 8-byte aligned.
#   xfrm_offload_hold()/xfrm_offload_release() do the reference
#   	counting of the xfrm_offload
#   xfrm_offload_get() looks up the xfrm_offload from a given device
#   	The caller should call xfrm_offload_release() when it is
#   	finished with this offload.
#   xfrm_state_offload_add() adds a new offload to the xfrm_state,
#   	replacing any existing offload for the device that may
#   	exist for this xfrm_state.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# net/xfrm/xfrm_state.c
#   2004/12/30 00:30:46-05:00 dave@thedillows.org +28 -0
#   Clean up any offloads on destruction of an xfrm_state, and
#   allow the addition of new xfrm_offloads to a xfrm_state.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# net/xfrm/xfrm_export.c
#   2004/12/30 00:30:46-05:00 dave@thedillows.org +2 -0
#   Export xfrm_state_offload_add() to drivers.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# include/net/xfrm.h
#   2004/12/30 00:30:46-05:00 dave@thedillows.org +79 -0
#   Add offload management to xfrm_state.
#   
#   Add xfrm_offload_alloc(), xfrm_offload_priv(), xfrm_offload_hold()
#   xfrm_offload_release(), and xfrm_offload_get().
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/include/net/xfrm.h b/include/net/xfrm.h
--- a/include/net/xfrm.h	2004-12-30 01:11:43 -05:00
+++ b/include/net/xfrm.h	2004-12-30 01:11:43 -05:00
@@ -81,6 +81,8 @@
       metrics. Plus, it will be made via sk->sk_dst_cache. Solved.
  */
 
+struct xfrm_offload;
+
 /* Full description of state of transformer. */
 struct xfrm_state
 {
@@ -149,6 +151,9 @@
 
 	/* Intended direction of this state, used for offloading */
 	int			dir;
+
+	/* List of offload cookies, per device */
+	struct list_head	offloads;
 };
 
 enum {
@@ -166,6 +171,13 @@
 	XFRM_STATE_DIR_OUT,
 };
 
+struct xfrm_offload
+{
+	struct list_head	bydev;
+	struct net_device *	dev;
+	atomic_t		refcnt;
+};
+
 struct xfrm_type;
 struct xfrm_dst;
 struct xfrm_policy_afinfo {
@@ -911,5 +923,72 @@
 				     (struct in6_addr *)b);
 	}
 }
+
+#define XFRM_OFFLOAD_ALIGN		8
+#define XFRM_OFFLOAD_ALIGN_CONST	(XFRM_OFFLOAD_ALIGN - 1)
+
+static inline struct xfrm_offload *
+xfrm_offload_alloc(int sizeof_priv, struct net_device *dev)
+{
+	struct xfrm_offload *xol;
+	int alloc_size;
+	
+	alloc_size = (sizeof(*xol) + XFRM_OFFLOAD_ALIGN_CONST)
+				& ~XFRM_OFFLOAD_ALIGN_CONST;
+	alloc_size += sizeof_priv;
+	xol = kmalloc(alloc_size, GFP_ATOMIC);
+	if (xol) {
+		memset(xol, 0, alloc_size);
+		INIT_LIST_HEAD(&xol->bydev);
+		atomic_set(&xol->refcnt, 1);
+		xol->dev = dev;
+	}
+
+	return xol;
+}
+
+static inline void *xfrm_offload_priv(struct xfrm_offload *xol)
+{
+	return (char *)xol + ((sizeof(*xol) + XFRM_OFFLOAD_ALIGN_CONST)
+					& ~XFRM_OFFLOAD_ALIGN_CONST);
+}
+
+static inline void xfrm_offload_hold(struct xfrm_offload *xol)
+{
+	atomic_inc(&xol->refcnt);
+}
+
+static inline void xfrm_offload_release(struct xfrm_offload *xol)
+{
+	if (xol) {
+		WARN_ON(atomic_read(&xol->refcnt) < 1);
+		if (atomic_dec_and_test(&xol->refcnt)) {
+			xol->dev->xfrm_state_del(xol->dev, xol);
+			dev_put(xol->dev);
+			kfree(xol);
+		}
+	}
+}
+
+static inline struct xfrm_offload *xfrm_offload_get(struct xfrm_state *x,
+                                               struct net_device *dev)
+{
+	struct xfrm_offload *xol, *ret = NULL;
+
+	spin_lock(&x->lock);
+	list_for_each_entry(xol, &x->offloads, bydev) {
+		if (xol->dev == dev) {
+			xfrm_offload_hold(xol);
+			ret = xol;
+			break;
+		}
+	}
+	spin_unlock(&x->lock);
+
+	return ret;
+}
+
+extern void xfrm_state_offload_add(struct xfrm_state *x,
+					struct xfrm_offload *xol);
 
 #endif	/* _NET_XFRM_H */
diff -Nru a/net/xfrm/xfrm_export.c b/net/xfrm/xfrm_export.c
--- a/net/xfrm/xfrm_export.c	2004-12-30 01:11:43 -05:00
+++ b/net/xfrm/xfrm_export.c	2004-12-30 01:11:43 -05:00
@@ -61,3 +61,5 @@
 EXPORT_SYMBOL_GPL(xfrm_ealg_get_byname);
 EXPORT_SYMBOL_GPL(xfrm_calg_get_byname);
 EXPORT_SYMBOL_GPL(skb_icv_walk);
+
+EXPORT_SYMBOL_GPL(xfrm_state_offload_add);
diff -Nru a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
--- a/net/xfrm/xfrm_state.c	2004-12-30 01:11:43 -05:00
+++ b/net/xfrm/xfrm_state.c	2004-12-30 01:11:43 -05:00
@@ -53,6 +53,12 @@
 
 static void xfrm_state_gc_destroy(struct xfrm_state *x)
 {
+	if (!list_empty(&x->offloads)) {
+		struct xfrm_offload *xol, *next;
+
+		list_for_each_entry_safe(xol, next, &x->offloads, bydev)
+			xfrm_offload_release(xol);
+	}
 	if (del_timer(&x->timer))
 		BUG();
 	if (x->aalg)
@@ -178,6 +184,7 @@
 		atomic_set(&x->tunnel_users, 0);
 		INIT_LIST_HEAD(&x->bydst);
 		INIT_LIST_HEAD(&x->byspi);
+		INIT_LIST_HEAD(&x->offloads);
 		init_timer(&x->timer);
 		x->timer.function = xfrm_timer_handler;
 		x->timer.data	  = (unsigned long)x;
@@ -941,6 +948,27 @@
 		xfrm_state_put(t);
 		x->tunnel = NULL;
 	}
+}
+
+void xfrm_state_offload_add(struct xfrm_state *x, struct xfrm_offload *xol)
+{
+	struct xfrm_offload *entry, *old = NULL;
+
+	spin_lock(&x->lock);
+	list_for_each_entry(entry, &x->offloads, bydev) {
+		if (entry->dev == xol->dev) {
+			list_del(&entry->bydev);
+			old = entry;
+			break;
+		}
+	}
+
+	dev_hold(xol->dev);
+	list_add_tail(&xol->bydev, &x->offloads);
+	spin_unlock(&x->lock);
+
+	if(old)
+		xfrm_offload_release(old);
 }
 
 void __init xfrm_state_init(void)
