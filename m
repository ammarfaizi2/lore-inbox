Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267934AbUHKE3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267934AbUHKE3U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 00:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267933AbUHKE2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 00:28:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:31452 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267930AbUHKEY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 00:24:59 -0400
Date: Tue, 10 Aug 2004 16:02:03 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] Use sysfs_dirent based tree in file removal
Message-ID: <20040810210203.GD3124@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040810205739.GA3124@in.ibm.com> <20040810210102.GC3124@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810210102.GC3124@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o This patch uses the sysfs_dirent based tree while removing sysfs files
  and directories. This avoids holding dcache_lock by not using dentry 
  based vfs tree. Thus simplyfying the removal logic in sysfs.

o It uses two helper routines sysfs_get_name(), to get the name for
  sysfs element and sysfs_drop_dentry() to delete the dentry given a
  sysfs_dirent.


 fs/sysfs/dir.c   |   48 ++++++----------------------
 fs/sysfs/inode.c |   92 +++++++++++++++++++++++++++++++++++++++----------------
 fs/sysfs/sysfs.h |   17 ++++++++++
 3 files changed, 94 insertions(+), 63 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs-backing-store-use-sysfs_dirent-tree-in-removal fs/sysfs/dir.c
--- linux-2.6.8-rc4/fs/sysfs/dir.c~sysfs-backing-store-use-sysfs_dirent-tree-in-removal	2004-08-10 15:09:15.000000000 -0500
+++ linux-2.6.8-rc4-maneesh/fs/sysfs/dir.c	2004-08-10 15:12:07.000000000 -0500
@@ -19,7 +19,7 @@ static void sysfs_d_iput(struct dentry *
 	if (sd) {
 		BUG_ON(sd->s_dentry != dentry);
 		sd->s_dentry = NULL;
-		release_sysfs_dirent(sd);
+		sysfs_put(sd);
 	}
 	iput(inode);
 }
@@ -61,7 +61,7 @@ int sysfs_make_dirent(struct sysfs_diren
 	sd->s_mode = mode;
 	sd->s_type = type;
 	sd->s_dentry = dentry;
-	dentry->d_fsdata = sd;
+	dentry->d_fsdata = sysfs_get(sd);
 	dentry->d_op = &sysfs_dentry_ops;
 
 	return 0;
@@ -146,6 +146,7 @@ static void remove_dir(struct dentry * d
 	d_delete(d);
 	sd = d->d_fsdata;
  	list_del_init(&sd->s_sibling);
+	sysfs_put(sd);
 	if (d->d_inode)
 		simple_rmdir(parent->d_inode,d);
 
@@ -173,49 +174,22 @@ void sysfs_remove_subdir(struct dentry *
 
 void sysfs_remove_dir(struct kobject * kobj)
 {
-	struct list_head * node;
 	struct dentry * dentry = dget(kobj->dentry);
+	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+	struct sysfs_dirent * sd, * tmp;
 
 	if (!dentry)
 		return;
 
 	pr_debug("sysfs %s: removing dir\n",dentry->d_name.name);
 	down(&dentry->d_inode->i_sem);
-
-	spin_lock(&dcache_lock);
-restart:
-	node = dentry->d_subdirs.next;
-	while (node != &dentry->d_subdirs) {
-		struct dentry * d = list_entry(node,struct dentry,d_child);
-
-		node = node->next;
-		pr_debug(" o %s (%d): ",d->d_name.name,atomic_read(&d->d_count));
-		if (!d_unhashed(d) && (d->d_inode)) {
-			struct sysfs_dirent * sd = d->d_fsdata;
-			d = dget_locked(d);
-			pr_debug("removing");
-
-			/**
-			 * Unlink and unhash.
-			 */
-			__d_drop(d);
-			spin_unlock(&dcache_lock);
-			/* release the target kobject in case of 
-			 * a symlink
-			 */
-			if (S_ISLNK(d->d_inode->i_mode))
-				kobject_put(sd->s_element);
-			
-			list_del_init(&sd->s_sibling);
-			simple_unlink(dentry->d_inode,d);
-			dput(d);
-			pr_debug(" done\n");
-			spin_lock(&dcache_lock);
-			/* re-acquired dcache_lock, need to restart */
-			goto restart;
-		}
+	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
+		if (!sd->s_element)
+			continue;
+		list_del_init(&sd->s_sibling);
+		sysfs_drop_dentry(sd, dentry);
+		sysfs_put(sd);
 	}
-	spin_unlock(&dcache_lock);
 	up(&dentry->d_inode->i_sem);
 
 	remove_dir(dentry);
diff -puN fs/sysfs/inode.c~sysfs-backing-store-use-sysfs_dirent-tree-in-removal fs/sysfs/inode.c
--- linux-2.6.8-rc4/fs/sysfs/inode.c~sysfs-backing-store-use-sysfs_dirent-tree-in-removal	2004-08-10 15:09:15.000000000 -0500
+++ linux-2.6.8-rc4-maneesh/fs/sysfs/inode.c	2004-08-10 15:09:15.000000000 -0500
@@ -31,8 +31,8 @@ struct inode * sysfs_new_inode(mode_t mo
 	struct inode * inode = new_inode(sysfs_sb);
 	if (inode) {
 		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
+		inode->i_uid = 0;
+		inode->i_gid = 0;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
@@ -68,7 +68,8 @@ int sysfs_create(struct dentry * dentry,
 		error = init(inode);
 	if (!error) {
 		d_instantiate(dentry, inode);
-		dget(dentry); /* Extra count - pin the dentry in core */
+		if (S_ISDIR(mode))
+			dget(dentry);  /* pin only directory dentry in core */
 	} else
 		iput(inode);
  Done:
@@ -90,35 +91,74 @@ struct dentry * sysfs_get_dentry(struct 
 	return lookup_hash(&qstr,parent);
 }
 
+/* 
+ * Get the name for corresponding element represented by the given sysfs_dirent
+ */
+const unsigned char * sysfs_get_name(struct sysfs_dirent *sd)
+{
+	struct attribute * attr;
+	struct bin_attribute * bin_attr;
+	struct sysfs_symlink  * sl;
+
+	if (!sd || !sd->s_element)
+		BUG();
+
+	switch (sd->s_type) {
+		case SYSFS_DIR:
+			/* Always have a dentry so use that */
+			return sd->s_dentry->d_name.name;
+
+		case SYSFS_KOBJ_ATTR:
+			attr = sd->s_element;
+			return attr->name;
+
+		case SYSFS_KOBJ_BIN_ATTR:
+			bin_attr = sd->s_element;
+			return bin_attr->attr.name;
+
+		case SYSFS_KOBJ_LINK:
+			sl = sd->s_element;
+			return sl->link_name;
+	}
+	return NULL;
+}
+
+
+/* 
+ * Unhashes the dentry corresponding to given sysfs_dirent
+ * Called with parent inode's i_sem held.
+ */
+void sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
+{
+	struct dentry * dentry = sd->s_dentry;
+
+	if (dentry) {
+		spin_lock(&dcache_lock);
+		if (!(d_unhashed(dentry) && dentry->d_inode)) {
+			dget_locked(dentry);
+			__d_drop(dentry);
+			spin_unlock(&dcache_lock);
+			simple_unlink(parent->d_inode, dentry);
+		} else 
+			spin_unlock(&dcache_lock);
+	}
+}
+
 void sysfs_hash_and_remove(struct dentry * dir, const char * name)
 {
-	struct dentry * victim;
 	struct sysfs_dirent * sd;
+	struct sysfs_dirent * parent_sd = dir->d_fsdata;
 
 	down(&dir->d_inode->i_sem);
-	victim = sysfs_get_dentry(dir,name);
-	if (!IS_ERR(victim)) {
-		/* make sure dentry is really there */
-		if (victim->d_inode && 
-		    (victim->d_parent->d_inode == dir->d_inode)) {
-			pr_debug("sysfs: Removing %s (%d)\n", victim->d_name.name,
-				 atomic_read(&victim->d_count));
-
-			sd = victim->d_fsdata;
-			d_drop(victim);
-			/* release the target kobject in case of 
-			 * a symlink
-			 */
-			if (S_ISLNK(victim->d_inode->i_mode))
-				kobject_put(sd->s_element);
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (!sd->s_element)
+			continue;
+		if (!strcmp(sysfs_get_name(sd), name)) {
 			list_del_init(&sd->s_sibling);
-			simple_unlink(dir->d_inode,victim);
-		} else
-			d_drop(victim);
-		/*
-		 * Drop reference from sysfs_get_dentry() above.
-		 */
-		dput(victim);
+			sysfs_drop_dentry(sd, dir);
+			sysfs_put(sd);
+			break;
+		}
 	}
 	up(&dir->d_inode->i_sem);
 }
diff -puN fs/sysfs/sysfs.h~sysfs-backing-store-use-sysfs_dirent-tree-in-removal fs/sysfs/sysfs.h
--- linux-2.6.8-rc4/fs/sysfs/sysfs.h~sysfs-backing-store-use-sysfs_dirent-tree-in-removal	2004-08-10 15:09:15.000000000 -0500
+++ linux-2.6.8-rc4-maneesh/fs/sysfs/sysfs.h	2004-08-10 15:12:07.000000000 -0500
@@ -14,6 +14,8 @@ extern void sysfs_hash_and_remove(struct
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
 
+extern const unsigned char * sysfs_get_name(struct sysfs_dirent *sd);
+extern void sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent);
 extern int sysfs_readlink(struct dentry *, char __user *, int );
 extern int sysfs_follow_link(struct dentry *, struct nameidata *);
 extern struct rw_semaphore sysfs_rename_sem;
@@ -70,3 +72,18 @@ static inline void release_sysfs_dirent(
 	kfree(sd);
 }
 
+static inline struct sysfs_dirent * sysfs_get(struct sysfs_dirent * sd)
+{
+	if (sd) {
+		WARN_ON(!atomic_read(&sd->s_count));
+		atomic_inc(&sd->s_count);
+	}
+	return sd;
+}
+
+static inline void sysfs_put(struct sysfs_dirent * sd)
+{
+	if (atomic_dec_and_test(&sd->s_count))
+		release_sysfs_dirent(sd);
+}
+

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
