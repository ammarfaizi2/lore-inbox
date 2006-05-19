Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWESPrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWESPrJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 11:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWESPrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 11:47:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43960 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932362AbWESPq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 11:46:58 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 04/14] NFS: Add dentry materialisation op [try #10]
Date: Fri, 19 May 2006 16:46:52 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060519154652.11791.32595.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060519154640.11791.2928.stgit@warthog.cambridge.redhat.com>
References: <20060519154640.11791.2928.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds a new directory cache management function that prepares
a disconnected anonymous function to be connected into the dentry tree. The
anonymous dentry is transferred the name and parentage from another dentry.


The following changes were made in [try #2]:

 (*) d_materialise_dentry() now switches the parentage of the two nodes around
     correctly when one or other of them is self-referential.

The following changes were made in [try #7]:

 (*) d_instantiate_unique() has had the interior part split out as function
     __d_instantiate_unique(). Callers of this latter function must be holding
     the appropriate locks.

 (*) _d_rehash() has been added as a wrapper around __d_rehash() to call it
     with the most obvious hash list (the one from the name). d_rehash() now
     calls _d_rehash().

 (*) d_materialise_dentry() is now __d_materialise_dentry() and is static.

 (*) d_materialise_unique() added to perform the combination of d_find_alias(),
     d_materialise_dentry() and d_add_unique() that the NFS client was doing
     twice, all within a single dcache_lock critical section. This reduces the
     number of times two different spinlocks were being accessed.


Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/dcache.c            |  152 ++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/dcache.h |    1 
 2 files changed, 139 insertions(+), 14 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 940d188..c118827 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -815,17 +815,19 @@ void d_instantiate(struct dentry *entry,
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */
-struct dentry *d_instantiate_unique(struct dentry *entry, struct inode *inode)
+static struct dentry *__d_instantiate_unique(struct dentry *entry,
+					     struct inode *inode)
 {
 	struct dentry *alias;
 	int len = entry->d_name.len;
 	const char *name = entry->d_name.name;
 	unsigned int hash = entry->d_name.hash;
 
-	BUG_ON(!list_empty(&entry->d_alias));
-	spin_lock(&dcache_lock);
-	if (!inode)
-		goto do_negative;
+	if (!inode) {
+		entry->d_inode = NULL;
+		return NULL;
+	}
+
 	list_for_each_entry(alias, &inode->i_dentry, d_alias) {
 		struct qstr *qstr = &alias->d_name;
 
@@ -838,19 +840,35 @@ struct dentry *d_instantiate_unique(stru
 		if (memcmp(qstr->name, name, len))
 			continue;
 		dget_locked(alias);
-		spin_unlock(&dcache_lock);
-		BUG_ON(!d_unhashed(alias));
-		iput(inode);
 		return alias;
 	}
+
 	list_add(&entry->d_alias, &inode->i_dentry);
-do_negative:
 	entry->d_inode = inode;
 	fsnotify_d_instantiate(entry, inode);
-	spin_unlock(&dcache_lock);
-	security_d_instantiate(entry, inode);
 	return NULL;
 }
+
+struct dentry *d_instantiate_unique(struct dentry *entry, struct inode *inode)
+{
+	struct dentry *result;
+
+	BUG_ON(!list_empty(&entry->d_alias));
+
+	spin_lock(&dcache_lock);
+	result = __d_instantiate_unique(entry, inode);
+	spin_unlock(&dcache_lock);
+
+	if (!result) {
+		security_d_instantiate(entry, inode);
+		return NULL;
+	}
+
+	BUG_ON(!d_unhashed(result));
+	iput(inode);
+	return result;
+}
+
 EXPORT_SYMBOL(d_instantiate_unique);
 
 /**
@@ -1222,6 +1240,11 @@ static void __d_rehash(struct dentry * e
  	hlist_add_head_rcu(&entry->d_hash, list);
 }
 
+static void _d_rehash(struct dentry * entry)
+{
+	__d_rehash(entry, d_hash(entry->d_parent, entry->d_name.hash));
+}
+
 /**
  * d_rehash	- add an entry back to the hash
  * @entry: dentry to add to the hash
@@ -1231,11 +1254,9 @@ static void __d_rehash(struct dentry * e
  
 void d_rehash(struct dentry * entry)
 {
-	struct hlist_head *list = d_hash(entry->d_parent, entry->d_name.hash);
-
 	spin_lock(&dcache_lock);
 	spin_lock(&entry->d_lock);
-	__d_rehash(entry, list);
+	_d_rehash(entry);
 	spin_unlock(&entry->d_lock);
 	spin_unlock(&dcache_lock);
 }
@@ -1373,6 +1394,108 @@ already_unhashed:
 	spin_unlock(&dcache_lock);
 }
 
+/*
+ * Prepare an anonymous dentry for life in the superblock's dentry tree as a
+ * named dentry in place of the dentry to be replaced.
+ */
+static void __d_materialise_dentry(struct dentry *dentry, struct dentry *anon)
+{
+	struct dentry *dparent, *aparent;
+
+	switch_names(dentry, anon);
+	do_switch(dentry->d_name.len, anon->d_name.len);
+	do_switch(dentry->d_name.hash, anon->d_name.hash);
+
+	dparent = dentry->d_parent;
+	aparent = anon->d_parent;
+	dentry->d_parent = (aparent == anon) ? dentry : aparent;
+	anon->d_parent = (dparent == dentry) ? anon : dparent;
+
+	anon->d_flags &= ~DCACHE_DISCONNECTED;
+}
+
+/**
+ * d_materialise_unique - introduce an inode into the tree
+ * @dentry: candidate dentry
+ * @inode: inode to bind to the dentry, to which aliases may be attached
+ *
+ * Introduces an dentry into the tree, substituting an extant disconnected
+ * root directory alias in its place if there is one
+ */
+struct dentry *d_materialise_unique(struct dentry *dentry, struct inode *inode)
+{
+	struct dentry *alias, *actual;
+
+	BUG_ON(!d_unhashed(dentry));
+
+	spin_lock(&dcache_lock);
+
+	if (!inode) {
+		actual = dentry;
+		dentry->d_inode = NULL;
+		goto found_lock;
+	}
+
+	/* See if a disconnected directory already exists as an anonymous root
+	 * that we should splice into the tree instead */
+	if (S_ISDIR(inode->i_mode) && (alias = __d_find_alias(inode, 1))) {
+		spin_lock(&alias->d_lock);
+
+		/* Is this a mountpoint that we could splice into our tree? */
+		if (IS_ROOT(alias))
+			goto connect_mountpoint;
+
+		if (alias->d_name.len == dentry->d_name.len &&
+		    alias->d_parent == dentry->d_parent &&
+		    memcmp(alias->d_name.name,
+			   dentry->d_name.name,
+			   dentry->d_name.len) == 0)
+			goto replace_with_alias;
+
+		spin_unlock(&alias->d_lock);
+
+		/* Doh! Seem to be aliasing directories for some reason... */
+		dput(alias);
+	}
+
+	/* Add a unique reference */
+	actual = __d_instantiate_unique(dentry, inode);
+	if (!actual)
+		actual = dentry;
+	else if (unlikely(!d_unhashed(actual)))
+		goto shouldnt_be_hashed;
+
+found_lock:
+	spin_lock(&actual->d_lock);
+found:
+	_d_rehash(actual);
+	spin_unlock(&actual->d_lock);
+	spin_unlock(&dcache_lock);
+
+	if (actual == dentry) {
+		security_d_instantiate(dentry, inode);
+		return NULL;
+	}
+
+	iput(inode);
+	return actual;
+
+	/* Convert the anonymous/root alias into an ordinary dentry */
+connect_mountpoint:
+	__d_materialise_dentry(dentry, alias);
+
+	/* Replace the candidate dentry with the alias in the tree */
+replace_with_alias:
+	__d_drop(alias);
+	actual = alias;
+	goto found;
+
+shouldnt_be_hashed:
+	spin_unlock(&dcache_lock);
+	BUG();
+	goto shouldnt_be_hashed;
+}
+
 /**
  * d_path - return the path of a dentry
  * @dentry: dentry to report
@@ -1771,6 +1894,7 @@ EXPORT_SYMBOL(d_instantiate);
 EXPORT_SYMBOL(d_invalidate);
 EXPORT_SYMBOL(d_lookup);
 EXPORT_SYMBOL(d_move);
+EXPORT_SYMBOL_GPL(d_materialise_unique);
 EXPORT_SYMBOL(d_path);
 EXPORT_SYMBOL(d_prune_aliases);
 EXPORT_SYMBOL(d_rehash);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 836325e..1054df6 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -209,6 +209,7 @@ static inline int dname_external(struct 
  */
 extern void d_instantiate(struct dentry *, struct inode *);
 extern struct dentry * d_instantiate_unique(struct dentry *, struct inode *);
+extern struct dentry * d_materialise_unique(struct dentry *, struct inode *);
 extern void d_delete(struct dentry *);
 
 /* allocate/de-allocate */

