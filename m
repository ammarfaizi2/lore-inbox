Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264872AbTFLQE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbTFLQE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:04:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40968 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264872AbTFLQEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:04:52 -0400
Date: Thu, 12 Jun 2003 09:18:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.70-bk16: nfs crash
In-Reply-To: <Pine.LNX.4.44.0306120847540.2742-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0306120915190.2742-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Jun 2003, Linus Torvalds wrote:
> 
> If you depend on not re-initializing the pointers, you should not use the 
> "xxx_del()" function, and you should document it.

Besides, the code doesn't actually depend on not re-initializing the 
pointers, it depends on the _forward_ pointers still being walkable in 
case some other CPU is traversing the list just as we remove the entry.

Which means that I think the proper patch is to (a) document this and also
(b) poison the back pointer.

A patch like the attached, in short.

		Linus

---
===== include/linux/dcache.h 1.32 vs edited =====
--- 1.32/include/linux/dcache.h	Tue Jun 10 14:56:43 2003
+++ edited/include/linux/dcache.h	Thu Jun 12 09:12:27 2003
@@ -174,8 +174,10 @@
 
 static inline void __d_drop(struct dentry *dentry)
 {
-	dentry->d_vfs_flags |= DCACHE_UNHASHED;
-	hlist_del_rcu_init(&dentry->d_hash);
+	if (!(dentry->d_vfs_flags & DCACHE_UNHASHED)) {
+		dentry->d_vfs_flags |= DCACHE_UNHASHED;
+		hlist_del_rcu(&dentry->d_hash);
+	}
 }
 
 static inline void d_drop(struct dentry *dentry)
===== include/linux/list.h 1.32 vs edited =====
--- 1.32/include/linux/list.h	Tue Jun 10 15:46:31 2003
+++ edited/include/linux/list.h	Thu Jun 12 08:59:31 2003
@@ -152,14 +152,17 @@
 /**
  * list_del_rcu - deletes entry from list without re-initialization
  * @entry: the element to delete from the list.
+ *
  * Note: list_empty on entry does not return true after this, 
  * the entry is in an undefined state. It is useful for RCU based
  * lockfree traversal.
+ *
+ * In particular, it means that we can not poison the forward 
+ * pointers that may still be used for path walking.
  */
 static inline void list_del_rcu(struct list_head *entry)
 {
 	__list_del(entry->prev, entry->next);
-	entry->next = LIST_POISON1;
 	entry->prev = LIST_POISON2;
 }
 
@@ -431,7 +434,22 @@
 	n->pprev = LIST_POISON2;
 }
 
-#define hlist_del_rcu hlist_del  /* list_del_rcu is identical too? */
+/**
+ * hlist_del_rcu - deletes entry from hash list without re-initialization
+ * @entry: the element to delete from the list.
+ *
+ * Note: list_empty on entry does not return true after this, 
+ * the entry is in an undefined state. It is useful for RCU based
+ * lockfree traversal.
+ *
+ * In particular, it means that we can not poison the forward
+ * pointers that may still be used for path walking.
+ */
+static inline void hlist_del_rcu(struct hlist_node *n)
+{
+	__hlist_del(n);
+	n->pprev = LIST_POISON2;
+}
 
 static __inline__ void hlist_del_init(struct hlist_node *n) 
 {

