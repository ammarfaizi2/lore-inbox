Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUGGMth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUGGMth (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265095AbUGGMth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:49:37 -0400
Received: from linuxhacker.ru ([217.76.32.60]:60886 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265098AbUGGMta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:49:30 -0400
Date: Wed, 7 Jul 2004 15:47:32 +0300
From: Oleg Drokin <green@clusterfs.com>
To: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: [1/9] Lustre VFS patches for 2.6
Message-ID: <20040707124732.GA25891@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce lock-free versions of d_rehash and d_move.

 fs/dcache.c            |   22 ++++++++++++++++++----
 include/linux/dcache.h |    2 ++
 2 files changed, 20 insertions(+), 4 deletions(-)

Index: linus-2.6.7-bk5/fs/dcache.c
===================================================================
--- linus-2.6.7-bk5.orig/fs/dcache.c	2004-06-24 10:39:11.232154728 +0300
+++ linus-2.6.7-bk5/fs/dcache.c	2004-06-24 10:56:01.043640048 +0300
@@ -1115,16 +1115,23 @@
  * Adds a dentry to the hash according to its name.
  */
  
-void d_rehash(struct dentry * entry)
+void __d_rehash(struct dentry * entry)
 {
 	struct hlist_head *list = d_hash(entry->d_parent, entry->d_name.hash);
 
-	spin_lock(&dcache_lock);
 	spin_lock(&entry->d_lock);
  	entry->d_flags &= ~DCACHE_UNHASHED;
 	spin_unlock(&entry->d_lock);
 	entry->d_bucket = list;
  	hlist_add_head_rcu(&entry->d_hash, list);
+}
+
+EXPORT_SYMBOL(__d_rehash);
+ 
+void d_rehash(struct dentry * entry)
+{
+	spin_lock(&dcache_lock);
+	__d_rehash(entry);
 	spin_unlock(&dcache_lock);
 }
 
@@ -1200,12 +1207,11 @@
  * dcache entries should not be moved in this way.
  */
 
-void d_move(struct dentry * dentry, struct dentry * target)
+void __d_move(struct dentry * dentry, struct dentry * target)
 {
 	if (!dentry->d_inode)
 		printk(KERN_WARNING "VFS: moving negative dcache entry\n");
 
-	spin_lock(&dcache_lock);
 	write_seqlock(&rename_lock);
 	/*
 	 * XXXX: do we really need to take target->d_lock?
@@ -1257,6 +1263,14 @@
 	spin_unlock(&target->d_lock);
 	spin_unlock(&dentry->d_lock);
 	write_sequnlock(&rename_lock);
+}
+
+EXPORT_SYMBOL(__d_move);
+
+void d_move(struct dentry *dentry, struct dentry *target)
+{
+	spin_lock(&dcache_lock);
+	__d_move(dentry, target);
 	spin_unlock(&dcache_lock);
 }
 
Index: linus-2.6.7-bk5/include/linux/dcache.h
===================================================================
--- linus-2.6.7-bk5.orig/include/linux/dcache.h	2004-06-24 10:39:29.534372368 +0300
+++ linus-2.6.7-bk5/include/linux/dcache.h	2004-06-24 10:53:10.319594048 +0300
@@ -227,6 +227,7 @@
  * This adds the entry to the hash queues.
  */
 extern void d_rehash(struct dentry *);
+extern void __d_rehash(struct dentry *);
 
 /**
  * d_add - add dentry to hash queues
@@ -245,6 +246,7 @@
 
 /* used for rename() and baskets */
 extern void d_move(struct dentry *, struct dentry *);
+extern void __d_move(struct dentry *, struct dentry *);
 
 /* appendix may either be NULL or be used for transname suffixes */
 extern struct dentry * d_lookup(struct dentry *, struct qstr *);
