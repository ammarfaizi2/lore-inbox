Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265291AbUG2UmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUG2UmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUG2Uk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:40:28 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:43193 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265255AbUG2Ujq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:39:46 -0400
Date: Thu, 29 Jul 2004 15:40:31 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] Free sysfs_dirent on file removal
Message-ID: <20040729204031.GE4592@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040729203718.GB4592@in.ibm.com> <20040729203821.GC4592@in.ibm.com> <20040729203919.GD4592@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729203919.GD4592@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o The following patch implements the code to free up the sysfs_dirents upon
  directory or file removal. It uses the sysfs_dirent based tree in order
  to remove the directory contents before removing the directory itself.
  It could do this without taking dcache_lock in sysfs_remove_dir() as
  it doesnot use dentry based tree.


 fs/sysfs/dir.c   |   48 ++++++++++++++----------------------------------
 fs/sysfs/inode.c |   51 ++++++++++++++++++++++++++++++---------------------
 2 files changed, 44 insertions(+), 55 deletions(-)

diff -puN fs/sysfs/inode.c~sysfs-backing-store-kill-sysfs_dirent fs/sysfs/inode.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/inode.c~sysfs-backing-store-kill-sysfs_dirent	2004-07-29 15:30:39.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/inode.c	2004-07-29 15:31:07.000000000 -0500
@@ -11,6 +11,8 @@
 #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
+#include "sysfs.h"
+
 extern struct super_block * sysfs_sb;
 
 static struct address_space_operations sysfs_aops = {
@@ -88,33 +90,40 @@ struct dentry * sysfs_get_dentry(struct 
 	return lookup_hash(&qstr,parent);
 }
 
+/* Unhashes the dentry corresponding to given sysfs_dirent
+ * Called with parent inode's i_sem held.
+ */
+void sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
+{
+	struct dentry * dentry = sd->s_dentry;
+
+	if (dentry) {
+		if (!(d_unhashed(dentry) && dentry->d_inode)) {
+			spin_lock(&dcache_lock);
+			dget_locked(dentry);
+			__d_drop(dentry);
+			spin_unlock(&dcache_lock);
+			simple_unlink(parent->d_inode, dentry);
+		} else
+			dput(dentry);
+	}
+}
+
 void sysfs_hash_and_remove(struct dentry * dir, const char * name)
 {
-	struct dentry * victim;
+	struct sysfs_dirent * sd, * parent_sd = dir->d_fsdata;
 
 	down(&dir->d_inode->i_sem);
-	victim = sysfs_get_dentry(dir,name);
-	if (!IS_ERR(victim)) {
-		/* make sure dentry is really there */
-		if (victim->d_inode && 
-		    (victim->d_parent->d_inode == dir->d_inode)) {
-			pr_debug("sysfs: Removing %s (%d)\n", victim->d_name.name,
-				 atomic_read(&victim->d_count));
-
-			d_drop(victim);
-			/* release the target kobject in case of 
-			 * a symlink
-			 */
-			if (S_ISLNK(victim->d_inode->i_mode))
-				kobject_put(victim->d_fsdata);
-			simple_unlink(dir->d_inode,victim);
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (!sd->s_element)
+			continue;
+		if (!strcmp(sysfs_get_name(sd), name)) {
+			list_del_init(&sd->s_sibling);
+			sysfs_drop_dentry(sd, dir);
+			sysfs_put(sd);
+			break;
 		}
-		/*
-		 * Drop reference from sysfs_get_dentry() above.
-		 */
-		dput(victim);
 	}
 	up(&dir->d_inode->i_sem);
 }
 
-
diff -puN fs/sysfs/dir.c~sysfs-backing-store-kill-sysfs_dirent fs/sysfs/dir.c
--- linux-2.6.8-rc2-mm1/fs/sysfs/dir.c~sysfs-backing-store-kill-sysfs_dirent	2004-07-29 15:30:39.000000000 -0500
+++ linux-2.6.8-rc2-mm1-maneesh/fs/sysfs/dir.c	2004-07-29 15:31:07.000000000 -0500
@@ -100,8 +100,13 @@ int sysfs_create_dir(struct kobject * ko
 static void remove_dir(struct dentry * d)
 {
 	struct dentry * parent = dget(d->d_parent);
+	struct sysfs_dirent * sd;
+
 	down(&parent->d_inode->i_sem);
 	d_delete(d);
+	sd = d->d_fsdata;
+ 	list_del_init(&sd->s_sibling);
+ 	sysfs_put(d->d_fsdata);
 	if (d->d_inode)
 		simple_rmdir(parent->d_inode,d);
 
@@ -129,47 +134,22 @@ void sysfs_remove_subdir(struct dentry *
 
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
-				kobject_put(d->d_fsdata);
-			
-			simple_unlink(dentry->d_inode,d);
-			dput(d);
-			pr_debug(" done\n");
-			spin_lock(&dcache_lock);
-			/* re-acquired dcache_lock, need to restart */
-			goto restart;
-		}
-	}
-	spin_unlock(&dcache_lock);
+	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
+		if (!sd->s_element)
+			continue;
+		list_del_init(&sd->s_sibling);
+		sysfs_drop_dentry(sd, dentry);
+		sysfs_put(sd);
+  	}
 	up(&dentry->d_inode->i_sem);
 
 	remove_dir(dentry);

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
