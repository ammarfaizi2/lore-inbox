Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265136AbUD3KDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUD3KDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 06:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUD3KDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 06:03:23 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:43912 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265136AbUD3KDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 06:03:01 -0400
Date: Fri, 30 Apr 2004 15:35:43 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk, Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040430100543.GA25296@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <40807466.1020701@pobox.com> <20040417090712.B11481@flint.arm.linux.org.uk> <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040420161602.GB9603@kroah.com> <20040421101104.GA7921@in.ibm.com> <20040422213736.GL17014@parcelfarce.linux.theplanet.co.uk> <20040423085218.GB27638@in.ibm.com> <20040423092641.GM17014@parcelfarce.linux.theplanet.co.uk> <20040429130353.GC11624@in.ibm.com> <20040429154104.GI17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429154104.GI17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 04:41:04PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Apr 29, 2004 at 06:33:53PM +0530, Maneesh Soni wrote:
> 
> [snip]
> 
> > @@ -167,10 +175,14 @@ void sysfs_rename_dir(struct kobject * k
> >  	parent = kobj->parent->dentry;
> >  
> >  	down(&parent->d_inode->i_sem);
> > -
> >  	new_dentry = sysfs_get_dentry(parent, new_name);
> > -	d_move(kobj->dentry, new_dentry);
> > -	kobject_set_name(kobj,new_name);
> > +	if (!IS_ERR(new_dentry)) {
> > +		down_write(&sysfs_rename_sem);
> > +		d_move(kobj->dentry, new_dentry);
> > +		kobject_set_name(kobj,new_name);
> > +		up_write(&sysfs_rename_sem);
> > +		dput(new_dentry);
> > +	}
> >  	up(&parent->d_inode->i_sem);	
> >  }
> 
> I would probably lift that rwsem all way up - in front of any other locks
> in sysfs_rename_dir().  Note that kobject_set_name() can very well lead to
> allocations, so just to make the lock hierarchy cleaner...  Another thing:
> please, check that new_dentry is negative here.  Other than that, I've
> got no problems with the patch.

Ok... the corrected patch is appended. But I see more work to be done here
which if required can be done as a patch over this one which is not related
to sysfs symlinks. Please see the next mail.

Thanks
Maneesh



o The symlinks code in sysfs doesnot point to the correct target kobject
  whenever target kobject is renamed and suffers from dangling symlinks
  if target kobject is removed.

o The following patch implements ->readlink and ->follow_link operations 
  for sysfs instead of using the page_symlink_inode_operations. 
  The pointer to target kobject is saved in the link dentry's d_fsdata field. 
  The target path is generated everytime we do ->readlink and ->follow_link. 
  This results in generating the correct target path during readlink and 
  follow_link operations inspite of renamed target kobject. 

o This also pins the target kobject during link creation and the ref. is
  released when the link is removed. 

o Apart from being correct this patch also saves some memory by not pinning
  a whole page for saving the target information.

o Used a rw_semaphor sysfs_rename_sem to avoid clashing with renaming of 
  ancestors while the target path is generated. 

o Used dcache_lock in fs/sysfs/sysfs.h:sysfs_get_kobject() because of using
  d_drop() while removing dentries.


 fs/sysfs/dir.c     |   22 +++++++-
 fs/sysfs/inode.c   |    7 ++
 fs/sysfs/symlink.c |  135 ++++++++++++++++++++++++++++++++++++-----------------
 fs/sysfs/sysfs.h   |    7 +-
 4 files changed, 123 insertions(+), 48 deletions(-)

diff -puN fs/sysfs/sysfs.h~sysfs-symlinks-fix fs/sysfs/sysfs.h
--- linux-2.6.6-rc2-mm2/fs/sysfs/sysfs.h~sysfs-symlinks-fix	2004-04-30 11:10:09.000000000 +0530
+++ linux-2.6.6-rc2-mm2-maneesh/fs/sysfs/sysfs.h	2004-04-30 11:10:09.000000000 +0530
@@ -12,15 +12,18 @@ extern void sysfs_hash_and_remove(struct
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
 
+extern int sysfs_readlink(struct dentry *, char __user *, int );
+extern int sysfs_follow_link(struct dentry *, struct nameidata *);
+extern struct rw_semaphore sysfs_rename_sem;
 
 static inline struct kobject *sysfs_get_kobject(struct dentry *dentry)
 {
 	struct kobject * kobj = NULL;
 
-	spin_lock(&dentry->d_lock);
+	spin_lock(&dcache_lock);
 	if (!d_unhashed(dentry))
 		kobj = kobject_get(dentry->d_fsdata);
-	spin_unlock(&dentry->d_lock);
+	spin_unlock(&dcache_lock);
 
 	return kobj;
 }
diff -puN fs/sysfs/dir.c~sysfs-symlinks-fix fs/sysfs/dir.c
--- linux-2.6.6-rc2-mm2/fs/sysfs/dir.c~sysfs-symlinks-fix	2004-04-30 11:10:09.000000000 +0530
+++ linux-2.6.6-rc2-mm2-maneesh/fs/sysfs/dir.c	2004-04-30 11:39:16.000000000 +0530
@@ -10,6 +10,8 @@
 #include <linux/kobject.h>
 #include "sysfs.h"
 
+DECLARE_RWSEM(sysfs_rename_sem);
+
 static int init_dir(struct inode * inode)
 {
 	inode->i_op = &simple_dir_inode_operations;
@@ -134,8 +136,14 @@ restart:
 			/**
 			 * Unlink and unhash.
 			 */
+			__d_drop(d);
 			spin_unlock(&dcache_lock);
-			d_delete(d);
+			/* release the target kobject in case of 
+			 * a symlink
+			 */
+			if (S_ISLNK(d->d_inode->i_mode))
+				kobject_put(d->d_fsdata);
+			
 			simple_unlink(dentry->d_inode,d);
 			dput(d);
 			pr_debug(" done\n");
@@ -164,14 +172,20 @@ void sysfs_rename_dir(struct kobject * k
 	if (!kobj->parent)
 		return;
 
+	down_write(&sysfs_rename_sem);
 	parent = kobj->parent->dentry;
 
 	down(&parent->d_inode->i_sem);
-
 	new_dentry = sysfs_get_dentry(parent, new_name);
-	d_move(kobj->dentry, new_dentry);
-	kobject_set_name(kobj,new_name);
+	if (!IS_ERR(new_dentry)) {
+		if (!new_dentry->d_inode) {
+			d_move(kobj->dentry, new_dentry);
+			kobject_set_name(kobj,new_name);
+		}
+		dput(new_dentry);
+	}
 	up(&parent->d_inode->i_sem);	
+	up_write(&sysfs_rename_sem);
 }
 
 EXPORT_SYMBOL(sysfs_create_dir);
diff -puN fs/sysfs/inode.c~sysfs-symlinks-fix fs/sysfs/inode.c
--- linux-2.6.6-rc2-mm2/fs/sysfs/inode.c~sysfs-symlinks-fix	2004-04-30 11:10:09.000000000 +0530
+++ linux-2.6.6-rc2-mm2-maneesh/fs/sysfs/inode.c	2004-04-30 11:10:09.000000000 +0530
@@ -96,7 +96,12 @@ void sysfs_hash_and_remove(struct dentry
 			pr_debug("sysfs: Removing %s (%d)\n", victim->d_name.name,
 				 atomic_read(&victim->d_count));
 
-			d_delete(victim);
+			d_drop(victim);
+			/* release the target kobject in case of 
+			 * a symlink
+			 */
+			if (S_ISLNK(victim->d_inode->i_mode))
+				kobject_put(victim->d_fsdata);
 			simple_unlink(dir->d_inode,victim);
 		}
 		/*
diff -puN fs/sysfs/symlink.c~sysfs-symlinks-fix fs/sysfs/symlink.c
--- linux-2.6.6-rc2-mm2/fs/sysfs/symlink.c~sysfs-symlinks-fix	2004-04-30 11:10:09.000000000 +0530
+++ linux-2.6.6-rc2-mm2-maneesh/fs/sysfs/symlink.c	2004-04-30 11:10:09.000000000 +0530
@@ -8,27 +8,17 @@
 
 #include "sysfs.h"
 
+static struct inode_operations sysfs_symlink_inode_operations = {
+	.readlink = sysfs_readlink,
+	.follow_link = sysfs_follow_link,
+};
 
 static int init_symlink(struct inode * inode)
 {
-	inode->i_op = &page_symlink_inode_operations;
+	inode->i_op = &sysfs_symlink_inode_operations;
 	return 0;
 }
 
-static int sysfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
-{
-	int error;
-
-	error = sysfs_create(dentry, S_IFLNK|S_IRWXUGO, init_symlink);
-	if (!error) {
-		int l = strlen(symname)+1;
-		error = page_symlink(dentry->d_inode, symname, l);
-		if (error)
-			iput(dentry->d_inode);
-	}
-	return error;
-}
-
 static int object_depth(struct kobject * kobj)
 {
 	struct kobject * p = kobj;
@@ -74,37 +64,20 @@ int sysfs_create_link(struct kobject * k
 	struct dentry * dentry = kobj->dentry;
 	struct dentry * d;
 	int error = 0;
-	int size;
-	int depth;
-	char * path;
-	char * s;
-
-	depth = object_depth(kobj);
-	size = object_path_length(target) + depth * 3 - 1;
-	if (size > PATH_MAX)
-		return -ENAMETOOLONG;
-	pr_debug("%s: depth = %d, size = %d\n",__FUNCTION__,depth,size);
-
-	path = kmalloc(size,GFP_KERNEL);
-	if (!path)
-		return -ENOMEM;
-	memset(path,0,size);
-
-	for (s = path; depth--; s += 3)
-		strcpy(s,"../");
-
-	fill_object_path(target,path,size);
-	pr_debug("%s: path = '%s'\n",__FUNCTION__,path);
 
 	down(&dentry->d_inode->i_sem);
 	d = sysfs_get_dentry(dentry,name);
-	if (!IS_ERR(d))
-		error = sysfs_symlink(dentry->d_inode,d,path);
-	else
+	if (!IS_ERR(d)) {
+		error = sysfs_create(d, S_IFLNK|S_IRWXUGO, init_symlink);
+		if (!error)
+			/* 
+			 * associate the link dentry with the target kobject 
+			 */
+			d->d_fsdata = kobject_get(target);
+		dput(d);
+	} else 
 		error = PTR_ERR(d);
-	dput(d);
 	up(&dentry->d_inode->i_sem);
-	kfree(path);
 	return error;
 }
 
@@ -120,6 +93,86 @@ void sysfs_remove_link(struct kobject * 
 	sysfs_hash_and_remove(kobj->dentry,name);
 }
 
+static int sysfs_get_target_path(struct kobject * kobj, struct kobject * target,
+				   char *path)
+{
+	char * s;
+	int depth, size;
+
+	depth = object_depth(kobj);
+	size = object_path_length(target) + depth * 3 - 1;
+	if (size > PATH_MAX)
+		return -ENAMETOOLONG;
+
+	pr_debug("%s: depth = %d, size = %d\n", __FUNCTION__, depth, size);
+
+	for (s = path; depth--; s += 3)
+		strcpy(s,"../");
+
+	fill_object_path(target, path, size);
+	pr_debug("%s: path = '%s'\n", __FUNCTION__, path);
+
+	return 0;
+}
+
+static int sysfs_getlink(struct dentry *dentry, char * path)
+{
+	struct kobject *kobj, *target_kobj;
+	int error = 0;
+
+	kobj = sysfs_get_kobject(dentry->d_parent);
+	if (!kobj)
+		return -EINVAL;
+
+	target_kobj = sysfs_get_kobject(dentry);
+	if (!target_kobj) {
+		kobject_put(kobj);
+		return -EINVAL;
+	}
+
+	down_read(&sysfs_rename_sem);
+	error = sysfs_get_target_path(kobj, target_kobj, path);
+	up_read(&sysfs_rename_sem);
+	
+	kobject_put(kobj);
+	kobject_put(target_kobj);
+	return error;
+
+}
+
+int sysfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
+{
+	int error = 0;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+
+	if (!page)
+		return -ENOMEM;
+
+	error = sysfs_getlink(dentry, (char *) page);
+	if (!error)
+	        error = vfs_readlink(dentry, buffer, buflen, (char *) page);
+
+	free_page(page);
+
+	return error;
+}
+
+int sysfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	int error = 0;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+
+	if (!page)
+		return -ENOMEM;
+
+	error = sysfs_getlink(dentry, (char *) page); 
+	if (!error)
+	        error = vfs_follow_link(nd, (char *) page);
+
+	free_page(page);
+
+	return error;
+}
 
 EXPORT_SYMBOL(sysfs_create_link);
 EXPORT_SYMBOL(sysfs_remove_link);

_


-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
