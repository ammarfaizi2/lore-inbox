Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVJ2DHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVJ2DHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 23:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVJ2DHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 23:07:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:51881 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751114AbVJ2DHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 23:07:08 -0400
Date: Fri, 28 Oct 2005 20:07:36 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dipankar@in.ibm.com, manfred@colorfullife.com,
       maneesh@in.ibm.com, erikj@sgi.com, ak@suse.de
Subject: [PATCH 2/2] Remove hlist_for_each_rcu() API, convert existing use to hlist_for_each_entry_rcu
Message-ID: <20051029030736.GA26923@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051029025907.GA26879@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051029025907.GA26879@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch removes the hlist_for_each_rcu() API, which is used only
in one place, and is trivially converted to hlist_for_each_entry_rcu(),
making the code shorter and more readable.  Any out-of-tree uses may
be similarly converted.

Signed-off-by: <paulmck@us.ibm.com>

---

 Documentation/RCU/whatisRCU.txt |    2 --
 fs/dcache.c                     |   10 ++++------
 include/linux/list.h            |   13 ++++---------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff -urpNa -X dontdiff linux-2.6.14-RCUdoc/Documentation/RCU/whatisRCU.txt linux-2.6.14-kill-hlist_for_each_rcu/Documentation/RCU/whatisRCU.txt
--- linux-2.6.14-RCUdoc/Documentation/RCU/whatisRCU.txt	2005-10-28 14:40:47.000000000 -0700
+++ linux-2.6.14-kill-hlist_for_each_rcu/Documentation/RCU/whatisRCU.txt	2005-10-28 17:29:10.000000000 -0700
@@ -771,8 +771,6 @@ RCU pointer/list traversal:
 	list_for_each_entry_rcu
 	list_for_each_continue_rcu	(to be deprecated in favor of new
 					 list_for_each_entry_continue_rcu)
-	hlist_for_each_rcu		(to be deprecated in favor of
-					 hlist_for_each_entry_rcu)
 	hlist_for_each_entry_rcu
 
 RCU pointer update:
diff -urpNa -X dontdiff linux-2.6.14-RCUdoc/fs/dcache.c linux-2.6.14-kill-hlist_for_each_rcu/fs/dcache.c
--- linux-2.6.14-RCUdoc/fs/dcache.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-kill-hlist_for_each_rcu/fs/dcache.c	2005-10-28 17:34:01.000000000 -0700
@@ -644,7 +644,7 @@ void shrink_dcache_parent(struct dentry 
  *
  * Prune the dentries that are anonymous
  *
- * parsing d_hash list does not hlist_for_each_rcu() as it
+ * parsing d_hash list does not hlist_for_each_entry_rcu() as it
  * done under dcache_lock.
  *
  */
@@ -1043,15 +1043,13 @@ struct dentry * __d_lookup(struct dentry
 	struct hlist_head *head = d_hash(parent,hash);
 	struct dentry *found = NULL;
 	struct hlist_node *node;
+	struct dentry *dentry; 
 
 	rcu_read_lock();
 	
-	hlist_for_each_rcu(node, head) {
-		struct dentry *dentry; 
+	hlist_for_each_entry_rcu(dentry, node, head, d_hash) {
 		struct qstr *qstr;
 
-		dentry = hlist_entry(node, struct dentry, d_hash);
-
 		if (dentry->d_name.hash != hash)
 			continue;
 		if (dentry->d_parent != parent)
@@ -1123,7 +1121,7 @@ int d_validate(struct dentry *dentry, st
 	spin_lock(&dcache_lock);
 	base = d_hash(dparent, dentry->d_name.hash);
 	hlist_for_each(lhp,base) { 
-		/* hlist_for_each_rcu() not required for d_hash list
+		/* hlist_for_each_entry_rcu() not required for d_hash list
 		 * as it is parsed under dcache_lock
 		 */
 		if (dentry == hlist_entry(lhp, struct dentry, d_hash)) {
diff -urpNa -X dontdiff linux-2.6.14-RCUdoc/include/linux/list.h linux-2.6.14-kill-hlist_for_each_rcu/include/linux/list.h
--- linux-2.6.14-RCUdoc/include/linux/list.h	2005-10-28 14:40:52.000000000 -0700
+++ linux-2.6.14-kill-hlist_for_each_rcu/include/linux/list.h	2005-10-28 17:30:18.000000000 -0700
@@ -585,7 +585,7 @@ static inline void hlist_add_head(struct
  * or hlist_del_rcu(), running on this same list.
  * However, it is perfectly legal to run concurrently with
  * the _rcu list-traversal primitives, such as
- * hlist_for_each_rcu(), used to prevent memory-consistency
+ * hlist_for_each_entry_rcu(), used to prevent memory-consistency
  * problems on Alpha CPUs.  Regardless of the type of CPU, the
  * list-traversal primitive must be guarded by rcu_read_lock().
  */
@@ -634,7 +634,7 @@ static inline void hlist_add_after(struc
  * or hlist_del_rcu(), running on this same list.
  * However, it is perfectly legal to run concurrently with
  * the _rcu list-traversal primitives, such as
- * hlist_for_each_rcu(), used to prevent memory-consistency
+ * hlist_for_each_entry_rcu(), used to prevent memory-consistency
  * problems on Alpha CPUs.
  */
 static inline void hlist_add_before_rcu(struct hlist_node *n,
@@ -659,7 +659,7 @@ static inline void hlist_add_before_rcu(
  * or hlist_del_rcu(), running on this same list.
  * However, it is perfectly legal to run concurrently with
  * the _rcu list-traversal primitives, such as
- * hlist_for_each_rcu(), used to prevent memory-consistency
+ * hlist_for_each_entry_rcu(), used to prevent memory-consistency
  * problems on Alpha CPUs.
  */
 static inline void hlist_add_after_rcu(struct hlist_node *prev,
@@ -683,11 +683,6 @@ static inline void hlist_add_after_rcu(s
 	for (pos = (head)->first; pos && ({ n = pos->next; 1; }); \
 	     pos = n)
 
-#define hlist_for_each_rcu(pos, head) \
-	for ((pos) = (head)->first; \
-		rcu_dereference((pos)) && ({ prefetch((pos)->next); 1; }); \
-		(pos) = (pos)->next)
-
 /**
  * hlist_for_each_entry	- iterate over list of given type
  * @tpos:	the type * to use as a loop counter.
@@ -740,7 +735,7 @@ static inline void hlist_add_after_rcu(s
 
 /**
  * hlist_for_each_entry_rcu - iterate over rcu list of given type
- * @pos:	the type * to use as a loop counter.
+ * @tpos:	the type * to use as a loop counter.
  * @pos:	the &struct hlist_node to use as a loop counter.
  * @head:	the head for your list.
  * @member:	the name of the hlist_node within the struct.
