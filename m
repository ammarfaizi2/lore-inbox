Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946239AbWJSRNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946239AbWJSRNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946255AbWJSRNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:13:17 -0400
Received: from mx2.netapp.com ([216.240.18.37]:17669 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946239AbWJSRNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:13:16 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419609112:sNHT18021376"
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Thu, 19 Oct 2006 13:11:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Message-Id: <20061019171113.8593.8585.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Subject: [PATCH 1/2] VFS: Make d_materialise_unique() enforce directory
	uniqueness
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 17:13:26.0663 (UTC) FILETIME=[E3F86970:01C6F3A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

If the caller tries to instantiate a directory using an inode that already
has a dentry alias, then we attempt to rename the existing dentry instead
of instantiating a new one. Fail with an ELOOP error if the rename would
affect one of our parent directories.

This behaviour is needed in order to avoid issues such as

  http://bugzilla.kernel.org/show_bug.cgi?id=7178

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/dcache.c  |  102 +++++++++++++++++++++++++++++++++++++---------------------
 fs/nfs/dir.c |    7 +++-
 2 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2bac4ba..f700afd 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1469,23 +1469,21 @@ static void switch_names(struct dentry *
  * deleted it.
  */
  
-/**
- * d_move - move a dentry
+/*
+ * d_move_locked - move a dentry
  * @dentry: entry to move
  * @target: new dentry
  *
  * Update the dcache to reflect the move of a file name. Negative
  * dcache entries should not be moved in this way.
  */
-
-void d_move(struct dentry * dentry, struct dentry * target)
+static void d_move_locked(struct dentry * dentry, struct dentry * target)
 {
 	struct hlist_head *list;
 
 	if (!dentry->d_inode)
 		printk(KERN_WARNING "VFS: moving negative dcache entry\n");
 
-	spin_lock(&dcache_lock);
 	write_seqlock(&rename_lock);
 	/*
 	 * XXXX: do we really need to take target->d_lock?
@@ -1536,10 +1534,39 @@ already_unhashed:
 	fsnotify_d_move(dentry);
 	spin_unlock(&dentry->d_lock);
 	write_sequnlock(&rename_lock);
+}
+
+/**
+ * d_move - move a dentry
+ * @dentry: entry to move
+ * @target: new dentry
+ *
+ * Update the dcache to reflect the move of a file name. Negative
+ * dcache entries should not be moved in this way.
+ */
+
+void d_move(struct dentry * dentry, struct dentry * target)
+{
+	spin_lock(&dcache_lock);
+	d_move_locked(dentry, target);
 	spin_unlock(&dcache_lock);
 }
 
 /*
+ * Reject any lookup loops due to malicious remote servers
+ */
+static int d_detect_loops(struct dentry *dentry, struct inode *inode)
+{
+	struct dentry *p;
+
+	for (p = dentry; p->d_parent != p; p = p->d_parent) {
+		if (p->d_parent->d_inode == inode)
+			return -ELOOP;
+	}
+	return 0;
+}
+
+/*
  * Prepare an anonymous dentry for life in the superblock's dentry tree as a
  * named dentry in place of the dentry to be replaced.
  */
@@ -1581,7 +1608,7 @@ static void __d_materialise_dentry(struc
  */
 struct dentry *d_materialise_unique(struct dentry *dentry, struct inode *inode)
 {
-	struct dentry *alias, *actual;
+	struct dentry *actual;
 
 	BUG_ON(!d_unhashed(dentry));
 
@@ -1593,26 +1620,36 @@ struct dentry *d_materialise_unique(stru
 		goto found_lock;
 	}
 
-	/* See if a disconnected directory already exists as an anonymous root
-	 * that we should splice into the tree instead */
-	if (S_ISDIR(inode->i_mode) && (alias = __d_find_alias(inode, 1))) {
-		spin_lock(&alias->d_lock);
-
-		/* Is this a mountpoint that we could splice into our tree? */
-		if (IS_ROOT(alias))
-			goto connect_mountpoint;
-
-		if (alias->d_name.len == dentry->d_name.len &&
-		    alias->d_parent == dentry->d_parent &&
-		    memcmp(alias->d_name.name,
-			   dentry->d_name.name,
-			   dentry->d_name.len) == 0)
-			goto replace_with_alias;
-
-		spin_unlock(&alias->d_lock);
-
-		/* Doh! Seem to be aliasing directories for some reason... */
-		dput(alias);
+	if (S_ISDIR(inode->i_mode)) {
+		struct dentry *alias;
+
+		actual = ERR_PTR(d_detect_loops(dentry, inode));
+		if (IS_ERR(actual))
+			goto out_unlock;
+		/* Does an aliased dentry already exist? */
+		alias = __d_find_alias(inode, 0);
+		if (alias) {
+			actual = alias;
+			/* Is this an anonymous mountpoint that we could splice
+			 * into our tree? */
+			if (IS_ROOT(alias)) {
+				spin_lock(&alias->d_lock);
+				__d_materialise_dentry(dentry, alias);
+				__d_drop(alias);
+				goto found;
+			}
+			/* Nope, but we must(!) avoid directory aliasing */
+			if (mutex_trylock(&inode->i_sb->s_vfs_rename_mutex)) {
+				d_move_locked(alias, dentry);
+				spin_unlock(&dcache_lock);
+				mutex_unlock(&inode->i_sb->s_vfs_rename_mutex);
+				goto out_nolock;
+			}
+			spin_unlock(&dcache_lock);
+			dput(alias);
+			actual = ERR_PTR(-EBUSY);
+			goto out_nolock;
+		}
 	}
 
 	/* Add a unique reference */
@@ -1627,8 +1664,9 @@ found_lock:
 found:
 	_d_rehash(actual);
 	spin_unlock(&actual->d_lock);
+out_unlock:
 	spin_unlock(&dcache_lock);
-
+out_nolock:
 	if (actual == dentry) {
 		security_d_instantiate(dentry, inode);
 		return NULL;
@@ -1637,16 +1675,6 @@ found:
 	iput(inode);
 	return actual;
 
-	/* Convert the anonymous/root alias into an ordinary dentry */
-connect_mountpoint:
-	__d_materialise_dentry(dentry, alias);
-
-	/* Replace the candidate dentry with the alias in the tree */
-replace_with_alias:
-	__d_drop(alias);
-	actual = alias;
-	goto found;
-
 shouldnt_be_hashed:
 	spin_unlock(&dcache_lock);
 	BUG();
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c86a1ea..2cfa414 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -935,8 +935,11 @@ static struct dentry *nfs_lookup(struct 
 
 no_entry:
 	res = d_materialise_unique(dentry, inode);
-	if (res != NULL)
+	if (res != NULL) {
+		if (IS_ERR(res))
+			goto out_unlock;
 		dentry = res;
+	}
 	nfs_renew_times(dentry);
 	nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
 out_unlock:
@@ -1132,6 +1135,8 @@ static struct dentry *nfs_readdir_lookup
 	alias = d_materialise_unique(dentry, inode);
 	if (alias != NULL) {
 		dput(dentry);
+		if (IS_ERR(alias))
+			return NULL;
 		dentry = alias;
 	}
 
