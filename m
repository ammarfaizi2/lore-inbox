Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264764AbUDWItY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264764AbUDWItY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 04:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264766AbUDWItY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 04:49:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:60346 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264764AbUDWIsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 04:48:52 -0400
Date: Fri, 23 Apr 2004 14:22:18 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040423085218.GB27638@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040415220232.GC23039@kroah.com> <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk> <20040416223732.GC21701@kroah.com> <20040416234601.GL24997@parcelfarce.linux.theplanet.co.uk> <40807466.1020701@pobox.com> <20040417090712.B11481@flint.arm.linux.org.uk> <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040420161602.GB9603@kroah.com> <20040421101104.GA7921@in.ibm.com> <20040422213736.GL17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040422213736.GL17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 10:37:37PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
[..]
> 
> I would unhash before doing kobject_put() here.  Otherwise you are risking
> ->follow_link() or ->readlink() coming between kobject_put() and unhashing,
> which will screw you when sysfs_get_kobject() tries to grab a reference to
> (already freed) ->d_fsdata.
> 
> > +			/* release the target kobject in case of 
> > +			 * a symlink
> > +			 */
> > +			if (S_ISLNK(victim->d_inode->i_mode))
> > +				kobject_put(victim->d_fsdata);
> >  			d_delete(victim);
> 
> Ditto.

Right.. I have corrected this.

[..]
> 
> Huh?  Not to mention anything else, dput(d) is guaranteed to screw you if
> IS_ERR(d) is true.

great eyes.. I couldn't spot this even with four eyes 8-).. but for my relief
I was not the culprit for this. I also corrected a couple of more uses
of sysfs_get_dentry().

> > +	down(&target_parent->d_inode->i_sem);
> > +	error = sysfs_get_target_path(kobj, target_kobj, path);
> > +	up(&target_parent->d_inode->i_sem);
> 
> You need to be careful in sysfs_get_target_path() - this ->i_sem doesn't
> prevent renames of ancestors.  rwsem held exclusive by renaming and shared
> by sysfs_get_target_path(), maybe?  FWIW, even rwlock might be sufficient...

I used rwsem, considering the allocations done in kobject_set_name().
Updated patch appended.

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

o Also corrected a couple of sysfs_get_dentry() uses.


 fs/sysfs/dir.c     |   17 +++++-
 fs/sysfs/group.c   |   12 ++--
 fs/sysfs/inode.c   |    5 +
 fs/sysfs/symlink.c |  136 +++++++++++++++++++++++++++++++++++++----------------
 fs/sysfs/sysfs.h   |    3 +
 5 files changed, 124 insertions(+), 49 deletions(-)

diff -puN fs/sysfs/sysfs.h~sysfs-symlinks-fix fs/sysfs/sysfs.h
--- linux-2.6.6-rc2-mm1/fs/sysfs/sysfs.h~sysfs-symlinks-fix	2004-04-23 10:22:41.000000000 +0530
+++ linux-2.6.6-rc2-mm1-maneesh/fs/sysfs/sysfs.h	2004-04-23 12:11:52.000000000 +0530
@@ -12,6 +12,9 @@ extern void sysfs_hash_and_remove(struct
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
 
+extern int sysfs_readlink(struct dentry *, char __user *, int );
+extern int sysfs_follow_link(struct dentry *, struct nameidata *);
+extern struct rw_semaphore sysfs_rename_sem;
 
 static inline struct kobject *sysfs_get_kobject(struct dentry *dentry)
 {
diff -puN fs/sysfs/dir.c~sysfs-symlinks-fix fs/sysfs/dir.c
--- linux-2.6.6-rc2-mm1/fs/sysfs/dir.c~sysfs-symlinks-fix	2004-04-23 10:22:41.000000000 +0530
+++ linux-2.6.6-rc2-mm1-maneesh/fs/sysfs/dir.c	2004-04-23 11:30:17.000000000 +0530
@@ -10,6 +10,8 @@
 #include <linux/kobject.h>
 #include "sysfs.h"
 
+DECLARE_RWSEM(sysfs_rename_sem);
+
 static int init_dir(struct inode * inode)
 {
 	inode->i_op = &simple_dir_inode_operations;
@@ -136,6 +138,12 @@ restart:
 			 */
 			spin_unlock(&dcache_lock);
 			d_delete(d);
+			/* release the target kobject in case of 
+			 * a symlink
+			 */
+			if (S_ISLNK(d->d_inode->i_mode))
+				kobject_put(d->d_fsdata);
+			
 			simple_unlink(dentry->d_inode,d);
 			dput(d);
 			pr_debug(" done\n");
@@ -167,10 +175,13 @@ void sysfs_rename_dir(struct kobject * k
 	parent = kobj->parent->dentry;
 
 	down(&parent->d_inode->i_sem);
-
 	new_dentry = sysfs_get_dentry(parent, new_name);
-	d_move(kobj->dentry, new_dentry);
-	kobject_set_name(kobj,new_name);
+	if (!IS_ERR(new_dentry)) {
+		down_write(&sysfs_rename_sem);
+		d_move(kobj->dentry, new_dentry);
+		kobject_set_name(kobj,new_name);
+		up_write(&sysfs_rename_sem);
+	}
 	up(&parent->d_inode->i_sem);	
 }
 
diff -puN fs/sysfs/inode.c~sysfs-symlinks-fix fs/sysfs/inode.c
--- linux-2.6.6-rc2-mm1/fs/sysfs/inode.c~sysfs-symlinks-fix	2004-04-23 10:22:41.000000000 +0530
+++ linux-2.6.6-rc2-mm1-maneesh/fs/sysfs/inode.c	2004-04-23 11:03:38.000000000 +0530
@@ -97,6 +97,11 @@ void sysfs_hash_and_remove(struct dentry
 				 atomic_read(&victim->d_count));
 
 			d_delete(victim);
+			/* release the target kobject in case of 
+			 * a symlink
+			 */
+			if (S_ISLNK(victim->d_inode->i_mode))
+				kobject_put(victim->d_fsdata);
 			simple_unlink(dir->d_inode,victim);
 		}
 		/*
diff -puN fs/sysfs/symlink.c~sysfs-symlinks-fix fs/sysfs/symlink.c
--- linux-2.6.6-rc2-mm1/fs/sysfs/symlink.c~sysfs-symlinks-fix	2004-04-23 10:22:41.000000000 +0530
+++ linux-2.6.6-rc2-mm1-maneesh/fs/sysfs/symlink.c	2004-04-23 11:40:49.000000000 +0530
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
 
@@ -120,6 +93,87 @@ void sysfs_remove_link(struct kobject * 
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
+	struct dentry * target_parent;
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
diff -puN fs/sysfs/group.c~sysfs-symlinks-fix fs/sysfs/group.c
--- linux-2.6.6-rc2-mm1/fs/sysfs/group.c~sysfs-symlinks-fix	2004-04-23 11:20:40.000000000 +0530
+++ linux-2.6.6-rc2-mm1-maneesh/fs/sysfs/group.c	2004-04-23 11:22:12.000000000 +0530
@@ -70,11 +70,13 @@ void sysfs_remove_group(struct kobject *
 	else
 		dir = dget(kobj->dentry);
 
-	remove_files(dir,grp);
-	if (grp->name)
-		sysfs_remove_subdir(dir);
-	/* release the ref. taken in this routine */
-	dput(dir);
+	if (dir && !IS_ERR(dir)) {
+		remove_files(dir,grp);
+		if (grp->name)
+			sysfs_remove_subdir(dir);
+		/* release the ref. taken in this routine */
+		dput(dir);
+	}
 }
 
 

_

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
