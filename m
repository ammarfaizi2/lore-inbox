Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUDUKJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUDUKJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 06:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUDUKJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 06:09:52 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34017 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264501AbUDUKJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 06:09:28 -0400
Date: Wed, 21 Apr 2004 15:41:04 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040421101104.GA7921@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040415220232.GC23039@kroah.com> <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk> <20040416223732.GC21701@kroah.com> <20040416234601.GL24997@parcelfarce.linux.theplanet.co.uk> <40807466.1020701@pobox.com> <20040417090712.B11481@flint.arm.linux.org.uk> <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040420161602.GB9603@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420161602.GB9603@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 09:16:02AM -0700, Greg KH wrote:
> On Sat, Apr 17, 2004 at 09:22:06AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Sat, Apr 17, 2004 at 09:07:12AM +0100, Russell King wrote:
> > > What about other bus types?  Do I really need to teach userspace about
> > > the relationships between all the various bus types we have on ARM and
> > > how to work out what these relationships are by guessing?
> > > 
> > > Please.  The symlinks are necessary and they are the sole source of
> > > the relationship information.
> > 
> > In which case you want them to be associated with target, not the current
> > pathname of target.  And no, I don't buy the "so far all renames happen *here*
> > and all symlinks are pointing *there*, so we don't care" - that won't last.
> > 
> > When do we have a legitimate reason for dangling symlinks in sysfs, anyway?
> 
> Ok, in thinking about it some more, we don't.  And I don't have a
> problem with grabbing the reference to the target anymore either (after
> looking over the code).  So no more objections from me about this :)
> 

Please see the patch below against 2.6.6-rc2-mm1. In the last version I missed
releasing the target kobject whenever link is deleted. I have corrected this
now. Sorry for the missing code and please review again.


Regards
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


 fs/sysfs/dir.c     |    6 ++
 fs/sysfs/inode.c   |    5 +
 fs/sysfs/symlink.c |  135 +++++++++++++++++++++++++++++++++++++----------------
 fs/sysfs/sysfs.h   |    2 
 4 files changed, 108 insertions(+), 40 deletions(-)

diff -puN fs/sysfs/sysfs.h~sysfs-symlinks-fix fs/sysfs/sysfs.h
--- linux-2.6.6-rc2-mm1/fs/sysfs/sysfs.h~sysfs-symlinks-fix	2004-04-21 14:59:13.000000000 +0530
+++ linux-2.6.6-rc2-mm1-maneesh/fs/sysfs/sysfs.h	2004-04-21 15:00:08.000000000 +0530
@@ -12,6 +12,8 @@ extern void sysfs_hash_and_remove(struct
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
 
+extern int sysfs_readlink(struct dentry *, char __user *, int );
+extern int sysfs_follow_link(struct dentry *, struct nameidata *);
 
 static inline struct kobject *sysfs_get_kobject(struct dentry *dentry)
 {
diff -puN fs/sysfs/dir.c~sysfs-symlinks-fix fs/sysfs/dir.c
--- linux-2.6.6-rc2-mm1/fs/sysfs/dir.c~sysfs-symlinks-fix	2004-04-21 14:59:22.000000000 +0530
+++ linux-2.6.6-rc2-mm1-maneesh/fs/sysfs/dir.c	2004-04-21 15:39:30.000000000 +0530
@@ -135,6 +135,12 @@ restart:
 			 * Unlink and unhash.
 			 */
 			spin_unlock(&dcache_lock);
+			/* release the target kobject in case of 
+			 * a symlink
+			 */
+			if (S_ISLNK(d->d_inode->i_mode))
+				kobject_put(d->d_fsdata);
+			
 			d_delete(d);
 			simple_unlink(dentry->d_inode,d);
 			dput(d);
diff -puN fs/sysfs/inode.c~sysfs-symlinks-fix fs/sysfs/inode.c
--- linux-2.6.6-rc2-mm1/fs/sysfs/inode.c~sysfs-symlinks-fix	2004-04-21 14:59:25.000000000 +0530
+++ linux-2.6.6-rc2-mm1-maneesh/fs/sysfs/inode.c	2004-04-21 15:39:20.000000000 +0530
@@ -96,6 +96,11 @@ void sysfs_hash_and_remove(struct dentry
 			pr_debug("sysfs: Removing %s (%d)\n", victim->d_name.name,
 				 atomic_read(&victim->d_count));
 
+			/* release the target kobject in case of 
+			 * a symlink
+			 */
+			if (S_ISLNK(victim->d_inode->i_mode))
+				kobject_put(victim->d_fsdata);
 			d_delete(victim);
 			simple_unlink(dir->d_inode,victim);
 		}
diff -puN fs/sysfs/symlink.c~sysfs-symlinks-fix fs/sysfs/symlink.c
--- linux-2.6.6-rc2-mm1/fs/sysfs/symlink.c~sysfs-symlinks-fix	2004-04-21 14:59:28.000000000 +0530
+++ linux-2.6.6-rc2-mm1-maneesh/fs/sysfs/symlink.c	2004-04-21 15:39:51.000000000 +0530
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
+	} else 
 		error = PTR_ERR(d);
 	dput(d);
 	up(&dentry->d_inode->i_sem);
-	kfree(path);
 	return error;
 }
 
@@ -120,6 +93,88 @@ void sysfs_remove_link(struct kobject * 
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
+	target_parent = target_kobj->dentry->d_parent;
+
+	down(&target_parent->d_inode->i_sem);
+	error = sysfs_get_target_path(kobj, target_kobj, path);
+	up(&target_parent->d_inode->i_sem);
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
