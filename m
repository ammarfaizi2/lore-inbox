Return-Path: <linux-kernel-owner+willy=40w.ods.org-S379011AbUKAXEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S379011AbUKAXEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S378950AbUKAXEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:04:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:420 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S323692AbUKAV7Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:59:16 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <10993462761688@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Mon, 1 Nov 2004 13:57:56 -0800
Message-Id: <10993462761946@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2442, 2004/11/01 13:03:33-08:00, akpm@osdl.org

[PATCH] sysfs backing store: use sysfs_dirent based tree in file removal

From: Maneesh Soni <maneesh@in.ibm.com>

o This patch uses the sysfs_dirent based tree while removing sysfs files
  and directories. This avoids holding dcache_lock by not using dentry
  based vfs tree. Thus simplyfying the removal logic in sysfs.

o It uses two helper routines sysfs_get_name(), to get the name for
  sysfs element and sysfs_drop_dentry() to delete the dentry given a
  sysfs_dirent.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/dir.c   |   48 ++++++----------------------
 fs/sysfs/inode.c |   92 +++++++++++++++++++++++++++++++++++++++----------------
 fs/sysfs/sysfs.h |   18 ++++++++++
 3 files changed, 95 insertions(+), 63 deletions(-)


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2004-11-01 13:37:11 -08:00
+++ b/fs/sysfs/dir.c	2004-11-01 13:37:11 -08:00
@@ -19,7 +19,7 @@
 	if (sd) {
 		BUG_ON(sd->s_dentry != dentry);
 		sd->s_dentry = NULL;
-		release_sysfs_dirent(sd);
+		sysfs_put(sd);
 	}
 	iput(inode);
 }
@@ -61,7 +61,7 @@
 	sd->s_mode = mode;
 	sd->s_type = type;
 	sd->s_dentry = dentry;
-	dentry->d_fsdata = sd;
+	dentry->d_fsdata = sysfs_get(sd);
 	dentry->d_op = &sysfs_dentry_ops;
 
 	return 0;
@@ -146,6 +146,7 @@
 	d_delete(d);
 	sd = d->d_fsdata;
  	list_del_init(&sd->s_sibling);
+	sysfs_put(sd);
 	if (d->d_inode)
 		simple_rmdir(parent->d_inode,d);
 
@@ -173,49 +174,22 @@
 
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
diff -Nru a/fs/sysfs/inode.c b/fs/sysfs/inode.c
--- a/fs/sysfs/inode.c	2004-11-01 13:37:11 -08:00
+++ b/fs/sysfs/inode.c	2004-11-01 13:37:11 -08:00
@@ -31,8 +31,8 @@
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
@@ -68,7 +68,8 @@
 		error = init(inode);
 	if (!error) {
 		d_instantiate(dentry, inode);
-		dget(dentry); /* Extra count - pin the dentry in core */
+		if (S_ISDIR(mode))
+			dget(dentry);  /* pin only directory dentry in core */
 	} else
 		iput(inode);
  Done:
@@ -90,35 +91,74 @@
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
diff -Nru a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
--- a/fs/sysfs/sysfs.h	2004-11-01 13:37:11 -08:00
+++ b/fs/sysfs/sysfs.h	2004-11-01 13:37:11 -08:00
@@ -14,6 +14,9 @@
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
 
+extern const unsigned char * sysfs_get_name(struct sysfs_dirent *sd);
+extern void sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent);
+
 extern int sysfs_follow_link(struct dentry *, struct nameidata *);
 extern void sysfs_put_link(struct dentry *, struct nameidata *);
 extern struct rw_semaphore sysfs_rename_sem;
@@ -68,5 +71,20 @@
 		kfree(sl);
 	}
 	kfree(sd);
+}
+
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
 }
 

