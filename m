Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVAVKMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVAVKMD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 05:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbVAVKMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 05:12:03 -0500
Received: from ozlabs.org ([203.10.76.45]:27269 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262689AbVAVKLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 05:11:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16882.9724.584721.106431@cargo.ozlabs.ibm.com>
Date: Sat, 22 Jan 2005 21:07:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: anton@samba.org, nathanl@austin.ibm.com
Subject: [PATCH] PPC64 use kref for device_node refcounting
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Nathan Lynch <nathanl@austin.ibm.com>.

This changes struct device_node and associated code to use the kref
api for object refcounting and freeing.  I've given it some testing on
pSeries with cpu add/remove and verified that the release function
works.  The change is somewhat cosmetic but it does make the code
easier to understand... at least I think so =)

The only real change is that the refcount on all device_nodes is
initialized at 1, and the device node is freed when the refcount
reaches 0 (of_remove_node has the extra "put" to ensure that this
happens).  This lets us get rid of the OF_STALE flag and macros in
prom.h.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/prom.c test/arch/ppc64/kernel/prom.c
--- linux-2.5/arch/ppc64/kernel/prom.c	2005-01-22 09:25:41.000000000 +1100
+++ test/arch/ppc64/kernel/prom.c	2005-01-22 20:52:35.000000000 +1100
@@ -717,6 +717,7 @@
 				dad->next->sibling = np;
 			dad->next = np;
 		}
+		kref_init(&np->kref);
 	}
 	while(1) {
 		u32 sz, noff;
@@ -1475,24 +1476,31 @@
  *	@node:	Node to inc refcount, NULL is supported to
  *		simplify writing of callers
  *
- *	Returns the node itself or NULL if gone.
+ *	Returns node.
  */
 struct device_node *of_node_get(struct device_node *node)
 {
-	if (node && !OF_IS_STALE(node)) {
-		atomic_inc(&node->_users);
-		return node;
-	}
-	return NULL;
+	if (node)
+		kref_get(&node->kref);
+	return node;
 }
 EXPORT_SYMBOL(of_node_get);
 
+static inline struct device_node * kref_to_device_node(struct kref *kref)
+{
+	return container_of(kref, struct device_node, kref);
+}
+
 /**
- *	of_node_cleanup - release a dynamically allocated node
- *	@arg:  Node to be released
+ *	of_node_release - release a dynamically allocated node
+ *	@kref:  kref element of the node to be released
+ *
+ *	In of_node_put() this function is passed to kref_put()
+ *	as the destructor.
  */
-static void of_node_cleanup(struct device_node *node)
+static void of_node_release(struct kref *kref)
 {
+	struct device_node *node = kref_to_device_node(kref);
 	struct property *prop = node->properties;
 
 	if (!OF_IS_DYNAMIC(node))
@@ -1518,19 +1526,8 @@
  */
 void of_node_put(struct device_node *node)
 {
-	if (!node)
-		return;
-
-	WARN_ON(0 == atomic_read(&node->_users));
-
-	if (OF_IS_STALE(node)) {
-		if (atomic_dec_and_test(&node->_users)) {
-			of_node_cleanup(node);
-			return;
-		}
-	}
-	else
-		atomic_dec(&node->_users);
+	if (node)
+		kref_put(&node->kref, of_node_release);
 }
 EXPORT_SYMBOL(of_node_put);
 
@@ -1773,7 +1770,7 @@
 
 	np->properties = proplist;
 	OF_MARK_DYNAMIC(np);
-	of_node_get(np);
+	kref_init(&np->kref);
 	np->parent = derive_parent(path);
 	if (!np->parent) {
 		kfree(np);
@@ -1809,8 +1806,9 @@
 }
 
 /*
- * Remove an OF device node from the system.
- * Caller should have already "gotten" np.
+ * "Unplug" a node from the device tree.  The caller must hold
+ * a reference to the node.  The memory associated with the node
+ * is not freed until its refcount goes to zero.
  */
 int of_remove_node(struct device_node *np)
 {
@@ -1828,7 +1826,6 @@
 	of_cleanup_node(np);
 
 	write_lock(&devtree_lock);
-	OF_MARK_STALE(np);
 	remove_node_proc_entries(np);
 	if (allnodes == np)
 		allnodes = np->allnext;
@@ -1853,6 +1850,7 @@
 	}
 	write_unlock(&devtree_lock);
 	of_node_put(parent);
+	of_node_put(np); /* Must decrement the refcount */
 	return 0;
 }
 
diff -urN linux-2.5/include/asm-ppc64/prom.h test/include/asm-ppc64/prom.h
--- linux-2.5/include/asm-ppc64/prom.h	2005-01-06 13:13:10.000000000 +1100
+++ test/include/asm-ppc64/prom.h	2005-01-22 20:52:35.000000000 +1100
@@ -149,18 +149,15 @@
 	struct  proc_dir_entry *pde;       /* this node's proc directory */
 	struct  proc_dir_entry *name_link; /* name symlink */
 	struct  proc_dir_entry *addr_link; /* addr symlink */
-	atomic_t _users;                 /* reference count */
+	struct  kref kref;
 	unsigned long _flags;
 };
 
 extern struct device_node *of_chosen;
 
 /* flag descriptions */
-#define OF_STALE   0 /* node is slated for deletion */
 #define OF_DYNAMIC 1 /* node and properties were allocated via kmalloc */
 
-#define OF_IS_STALE(x) test_bit(OF_STALE, &x->_flags)
-#define OF_MARK_STALE(x) set_bit(OF_STALE, &x->_flags)
 #define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
 #define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
 
