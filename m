Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263919AbUDNGgB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 02:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbUDNGgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 02:36:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39338 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263919AbUDNGfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 02:35:51 -0400
Date: Wed, 14 Apr 2004 12:10:16 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040414064015.GA4505@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 02:36:15PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Apr 13, 2004 at 06:10:37PM +0530, Maneesh Soni wrote:
> > Hi,
> > 
> > As pointed by Al Viro, the current symlinks support in sysfs is incorrect as
> > it always sees the old target if target is renamed and obviously does not
> > follow the new target. The page symlink operations as used by current sysfs
> > code always see the target information at the time of creation. 
> 
> a) we ought to take a reference to target when creating a symlink (and drop
> it on removal)

I am not sure, if pinning the kobject for the life time of symlink (dentry)
may result in same problems like rmmod hang which we saw in case of pinning
kobject for the life time of its directory (dentry).

As in the following patch, we do take ref on both the parent and target kobject
while _generating_ the target information in sysfs_getlink().

> 
> b) sysfs_get_target_path() should leave allocation to caller.
> 
> c) AFAICS we should simply allocate a page instead of messing with kmalloc().

Yes, both these have made code look much better and we still save some memory
by not pinning a page for life time of the symlink. We allocate and free the
page during ->readlink and ->follow_link.

Thanks
Maneesh




o The following patch implements ->readlink and ->follow_link operations 
  for sysfs. The pointer to target kobject is saved in the link dentry's
  d_fsdata field. The target path is generated everytime we do ->readlink
  and ->follow_link. 

o Apart from being correct this patch also saves some memory by not pinning
  a whole page for saving the target information.


 fs/sysfs/symlink.c |  133 +++++++++++++++++++++++++++++++++++++----------------
 fs/sysfs/sysfs.h   |   16 ++++++
 2 files changed, 109 insertions(+), 40 deletions(-)

diff -puN fs/sysfs/symlink.c~sysfs-symlinks-fix fs/sysfs/symlink.c
--- linux-2.6.5/fs/sysfs/symlink.c~sysfs-symlinks-fix	2004-04-13 22:19:15.000000000 +0530
+++ linux-2.6.5-maneesh/fs/sysfs/symlink.c	2004-04-14 12:08:54.000000000 +0530
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
@@ -74,37 +64,17 @@ int sysfs_create_link(struct kobject * k
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
+			d->d_fsdata = kobject_get(target);
+	} else 
 		error = PTR_ERR(d);
 	dput(d);
 	up(&dentry->d_inode->i_sem);
-	kfree(path);
 	return error;
 }
 
@@ -120,6 +90,89 @@ void sysfs_remove_link(struct kobject * 
 	sysfs_hash_and_remove(kobj->dentry,name);
 }
 
+static int sysfs_get_target_path(struct kobject * kobj, struct kobject * target,
+				   char *path)
+{
+	char * s;
+	int depth, size;
+	int error = 0;
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
+	return error;
+}
+
+static int sysfs_getlink(struct dentry *dentry, char * path)
+{
+	struct kobject *kobj, *target_kobj;
+	struct dentry * target_parent;
+        int error = 0;
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
+        if (!error)
+	        error = vfs_readlink(dentry, buffer, buflen, (char *) page);
+
+	free_page(page);
+
+	return error;
+}
+
+int sysfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+        int error = 0;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+
+	if (!page)
+		return -ENOMEM;
+
+	error = sysfs_getlink(dentry, (char *) page); 
+        if (!error)
+	        error = vfs_follow_link(nd, (char *) page);
+
+	free_page(page);
+
+	return error;
+}
 
 EXPORT_SYMBOL(sysfs_create_link);
 EXPORT_SYMBOL(sysfs_remove_link);
diff -puN fs/sysfs/sysfs.h~sysfs-symlinks-fix fs/sysfs/sysfs.h
--- linux-2.6.5/fs/sysfs/sysfs.h~sysfs-symlinks-fix	2004-04-13 22:19:15.000000000 +0530
+++ linux-2.6.5-maneesh/fs/sysfs/sysfs.h	2004-04-13 22:19:15.000000000 +0530
@@ -11,3 +11,19 @@ extern void sysfs_hash_and_remove(struct
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
+
+extern int sysfs_readlink(struct dentry *dentry, char __user *buffer, int buflen);
+extern int sysfs_follow_link(struct dentry *dentry, struct nameidata *nd);
+
+static inline struct kobject * sysfs_get_kobject(struct dentry * dentry)
+{
+	struct kobject * kobj = NULL;
+
+	spin_lock(&dentry->d_lock);
+	if (!d_unhashed(dentry))
+		kobj = kobject_get(dentry->d_fsdata);
+	spin_unlock(&dentry->d_lock);
+
+	return kobj;
+}
+

_


-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
