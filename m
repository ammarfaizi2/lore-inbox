Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269679AbUISHvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269679AbUISHvG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 03:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269713AbUISHvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 03:51:06 -0400
Received: from cobain.capfed1.sinectis.com.ar ([216.244.192.67]:18084 "EHLO
	cobain.capfed1.sinectis.com.ar") by vger.kernel.org with ESMTP
	id S269679AbUISHvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 03:51:00 -0400
Date: Sun, 19 Sep 2004 04:50:57 -0300
From: Leandro Santi <lesanti@sinectis.com.ar>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] fix dcache nr_dentry race
Message-ID: <20040919075057.GA2445@lesanti.hq.sinectis.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo,

The dentry_stat.nr_dentry counter isn't being properly protected against
concurrent access. We've been observing a drift of about 8000 units per
day on some large MP Maildir++ mailstore nodes.

The following (trivial) patch is pretty much a backport from 2.6.

diff -ru linux-2.4.27.orig/fs/dcache.c linux-2.4.27.patched/fs/dcache.c
--- linux-2.4.27.orig/fs/dcache.c	Fri Jun 13 11:51:37 2003
+++ linux-2.4.27.patched/fs/dcache.c	Thu Sep  9 17:37:56 2004
@@ -55,7 +55,10 @@
 /* Statistics gathering. */
 struct dentry_stat_t dentry_stat = {0, 0, 45, 0,};
 
-/* no dcache_lock, please */
+/*
+ * no dcache_lock, please.  The caller must decrement dentry_stat.nr_dentry
+ * inside dcache_lock.
+ */
 static inline void d_free(struct dentry *dentry)
 {
 	if (dentry->d_op && dentry->d_op->d_release)
@@ -63,7 +66,6 @@
 	if (dname_external(dentry)) 
 		kfree(dentry->d_name.name);
 	kmem_cache_free(dentry_cache, dentry); 
-	dentry_stat.nr_dentry--;
 }
 
 /*
@@ -148,6 +150,7 @@
 kill_it: {
 		struct dentry *parent;
 		list_del(&dentry->d_child);
+		dentry_stat.nr_dentry--;	/* For d_free, below */
 		/* drops the lock, at that point nobody can reach this dentry */
 		dentry_iput(dentry);
 		parent = dentry->d_parent;
@@ -297,6 +300,7 @@
 
 	list_del_init(&dentry->d_hash);
 	list_del(&dentry->d_child);
+	dentry_stat.nr_dentry--;	/* For d_free, below */
 	dentry_iput(dentry);
 	parent = dentry->d_parent;
 	d_free(dentry);
@@ -623,13 +627,15 @@
 	if (parent) {
 		dentry->d_parent = dget(parent);
 		dentry->d_sb = parent->d_sb;
-		spin_lock(&dcache_lock);
-		list_add(&dentry->d_child, &parent->d_subdirs);
-		spin_unlock(&dcache_lock);
 	} else
 		INIT_LIST_HEAD(&dentry->d_child);
 
+	spin_lock(&dcache_lock);
+	if (parent)
+		list_add(&dentry->d_child, &parent->d_subdirs);
 	dentry_stat.nr_dentry++;
+	spin_unlock(&dcache_lock);
+
 	return dentry;
 }
 
Bye,
Leandro.
