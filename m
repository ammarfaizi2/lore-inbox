Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUITRFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUITRFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 13:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUITRFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 13:05:34 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:47349 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266560AbUITREt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 13:04:49 -0400
Date: Mon, 20 Sep 2004 22:39:30 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] Remove d_bucket
Message-ID: <20040920170930.GB5181@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040920170439.GA5181@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040920170439.GA5181@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested using dcachebench and hevy rename test.
http://lse.sourceforge.net/locking/dcache/rename_test/

Thanks
Dipankar

While going over dcache code, I realized that d_bucket which
was introduced to prevent hash chain traversals from going into
an infinite loop earlier, is no longer necessary. Originally,
when RCU based lock-free lookup was first introduced, dcache
hash chains used list_head. Hash chain traversal was terminated
when dentry->next reaches the list_head in the hash bucket.
However, if renames happen during a lock-free lookup, a dentry
may move to different bucket and subsequent hash chain traversal from
there onwards may not see the list_head in the original bucket
at all. In fact, this would result in the list_head in the bucket
interpreted as a list_head in dentry and bad things will happen
after that. Once hlist based hash chains were introduced in dcache,
the termination condition changed and lock-free traversal would
be safe with NULL pointer based termination of hlists. This means
that d_bucket check is no longer required.

There still exist some theoritical livelocks like a dentry getting
continuously moving and lock-free look-up never terminating.
But that isn't really any worse that what we have. In return
for these changes, we reduce the dentry size by the size of
a pointer. That should make akpm and mpm happy.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 fs/dcache.c            |   39 +++++++++++++++------------------------
 include/linux/dcache.h |    3 +--
 2 files changed, 16 insertions(+), 26 deletions(-)

diff -puN fs/dcache.c~dcache-remove-bucket-test fs/dcache.c
--- linux-2.6.9-rc2-dcache/fs/dcache.c~dcache-remove-bucket-test	2004-09-18 20:22:47.000000000 +0530
+++ linux-2.6.9-rc2-dcache-dipankar/fs/dcache.c	2004-09-20 02:55:12.000000000 +0530
@@ -715,7 +715,6 @@ struct dentry *d_alloc(struct dentry * p
 	dentry->d_fsdata = NULL;
 	dentry->d_mounted = 0;
 	dentry->d_cookie = NULL;
-	dentry->d_bucket = NULL;
 	INIT_HLIST_NODE(&dentry->d_hash);
 	INIT_LIST_HEAD(&dentry->d_lru);
 	INIT_LIST_HEAD(&dentry->d_subdirs);
@@ -850,12 +849,6 @@ struct dentry * d_alloc_anon(struct inod
 			res->d_sb = inode->i_sb;
 			res->d_parent = res;
 			res->d_inode = inode;
-
-			/*
-			 * Set d_bucket to an "impossible" bucket address so
-			 * that d_move() doesn't get a false positive
-			 */
-			res->d_bucket = NULL;
 			res->d_flags |= DCACHE_DISCONNECTED;
 			res->d_flags &= ~DCACHE_UNHASHED;
 			list_add(&res->d_alias, &inode->i_dentry);
@@ -986,13 +979,6 @@ struct dentry * __d_lookup(struct dentry
 		spin_lock(&dentry->d_lock);
 
 		/*
-		 * If lookup ends up in a different bucket due to concurrent
-		 * rename, fail it
-		 */
-		if (unlikely(dentry->d_bucket != head))
-			goto terminate;
-
-		/*
 		 * Recheck the dentry after taking the lock - d_move may have
 		 * changed things.  Don't bother checking the hash because we're
 		 * about to compare the whole name anyway.
@@ -1111,6 +1097,13 @@ void d_delete(struct dentry * dentry)
 	spin_unlock(&dcache_lock);
 }
 
+static void __d_rehash(struct dentry * entry, struct hlist_head *list)
+{
+
+ 	entry->d_flags &= ~DCACHE_UNHASHED;
+ 	hlist_add_head_rcu(&entry->d_hash, list);
+}
+
 /**
  * d_rehash	- add an entry back to the hash
  * @entry: dentry to add to the hash
@@ -1124,10 +1117,8 @@ void d_rehash(struct dentry * entry)
 
 	spin_lock(&dcache_lock);
 	spin_lock(&entry->d_lock);
- 	entry->d_flags &= ~DCACHE_UNHASHED;
+	__d_rehash(entry, list);
 	spin_unlock(&entry->d_lock);
-	entry->d_bucket = list;
- 	hlist_add_head_rcu(&entry->d_hash, list);
 	spin_unlock(&dcache_lock);
 }
 
@@ -1205,6 +1196,8 @@ static void switch_names(struct dentry *
 
 void d_move(struct dentry * dentry, struct dentry * target)
 {
+	struct hlist_head *list;
+
 	if (!dentry->d_inode)
 		printk(KERN_WARNING "VFS: moving negative dcache entry\n");
 
@@ -1224,13 +1217,12 @@ void d_move(struct dentry * dentry, stru
 	/* Move the dentry to the target hash queue, if on different bucket */
 	if (dentry->d_flags & DCACHE_UNHASHED)
 		goto already_unhashed;
-	if (dentry->d_bucket != target->d_bucket) {
-		hlist_del_rcu(&dentry->d_hash);
+
+	hlist_del_rcu(&dentry->d_hash);
+
 already_unhashed:
-		dentry->d_bucket = target->d_bucket;
-		hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
-		dentry->d_flags &= ~DCACHE_UNHASHED;
-	}
+	list = d_hash(target->d_parent, target->d_name.hash);
+	__d_rehash(dentry, list);
 
 	/* Unhash the target: dput() will then get rid of it */
 	__d_drop(target);
@@ -1240,7 +1232,6 @@ already_unhashed:
 
 	/* Switch the names.. */
 	switch_names(dentry, target);
-	smp_wmb();
 	do_switch(dentry->d_name.len, target->d_name.len);
 	do_switch(dentry->d_name.hash, target->d_name.hash);
 
diff -puN include/linux/dcache.h~dcache-remove-bucket-test include/linux/dcache.h
--- linux-2.6.9-rc2-dcache/include/linux/dcache.h~dcache-remove-bucket-test	2004-09-18 21:03:43.000000000 +0530
+++ linux-2.6.9-rc2-dcache-dipankar/include/linux/dcache.h	2004-09-18 21:04:22.000000000 +0530
@@ -28,7 +28,7 @@ struct vfsmount;
  * "quick string" -- eases parameter passing, but more importantly
  * saves "metadata" about the string (ie length and the hash).
  *
- * hash comes first so it snuggles against d_parent and d_bucket in the
+ * hash comes first so it snuggles against d_parent in the
  * dentry.
  */
 struct qstr {
@@ -91,7 +91,6 @@ struct dentry {
 	 * so they all fit in a 16-byte range, with 16-byte alignment.
 	 */
 	struct dentry *d_parent;	/* parent directory */
-	struct hlist_head *d_bucket;	/* lookup hash bucket */
 	struct qstr d_name;
 
 	struct list_head d_lru;		/* LRU list */

_
