Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUEEM4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUEEM4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264644AbUEEMzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:55:09 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:62904 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264645AbUEEMwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:52:05 -0400
Date: Wed, 5 May 2004 18:29:02 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>
Subject: [RFC 4/6] sysfs backing store ver 0.5
Message-ID: <20040505125902.GE1244@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040505125702.GA1244@in.ibm.com> <20040505125755.GB1244@in.ibm.com> <20040505125815.GC1244@in.ibm.com> <20040505125833.GD1244@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505125833.GD1244@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



=> changes in version 0.5
  o Use a new struct sysfs_symlink to save information
    about the symlink name and the pointer to target kobject.
    This was required to accomodate the latest changes in symlink
    code in sysfs which implements readlink and follow_link
    operations.

=> changes in version 0.4
  o Nil, just re-diffed

=> changes in version 0.3
  o Nil, just re-diffed

=> changes in version 0.2
  o symlink name passed to sysfs_create_link() can be destroyed by the
    caller. So, the symlink name should be allocated and copied to the
    corresponding sysfs dirent instead of directly using the given name
    string. The allocated string is freed when the corresponding sysfs_dirent
    is freed through sysfs_put()

=================
  o sysfs_create_link() now does not create a dentry but allocates a
    sysfs_dirent and links it to the parent kobject.

  o sysfs_dirent corresponding to symlink has an array of two string. One of
    them is the name of the symlink and the second one is the target path of the
    symlink


 fs/sysfs/symlink.c |   42 +++++++++++++++++++++++++++++-------------
 1 files changed, 29 insertions(+), 13 deletions(-)

diff -puN fs/sysfs/symlink.c~sysfs-leaves-symlink fs/sysfs/symlink.c
--- linux-2.6.6-rc3-mm1/fs/sysfs/symlink.c~sysfs-leaves-symlink	2004-05-05 10:55:14.000000000 +0530
+++ linux-2.6.6-rc3-mm1-maneesh/fs/sysfs/symlink.c	2004-05-05 10:55:14.000000000 +0530
@@ -13,7 +13,7 @@ static struct inode_operations sysfs_sym
 	.follow_link = sysfs_follow_link,
 };
 
-static int init_symlink(struct inode * inode)
+int init_symlink(struct inode * inode)
 {
 	inode->i_op = &sysfs_symlink_inode_operations;
 	return 0;
@@ -53,6 +53,30 @@ static void fill_object_path(struct kobj
 	}
 }
 
+static int sysfs_add_link(struct sysfs_dirent * parent_sd, char * name, 
+			    struct kobject * target)
+{
+	struct sysfs_dirent * sd;
+	struct sysfs_symlink * sl;
+
+	sl = kmalloc(sizeof(*sl), GFP_KERNEL);
+	if (!sl)
+		return -ENOMEM;
+
+	sl->link_name = kmalloc(strlen(name) + 1, GFP_KERNEL);
+	strcpy(sl->link_name, name);
+	sl->target_kobj = kobject_get(target);
+
+	sd = sysfs_new_dirent(parent_sd, sl, SYSFS_KOBJ_LINK);
+	if (sd) {
+		sd->s_mode = S_IFLNK|S_IRWXUGO;
+		return 0;
+	}
+
+	kfree(sl);
+	return -ENOMEM;
+}
+
 /**
  *	sysfs_create_link - create symlink between two objects.
  *	@kobj:	object whose directory we're creating the link in.
@@ -62,21 +86,13 @@ static void fill_object_path(struct kobj
 int sysfs_create_link(struct kobject * kobj, struct kobject * target, char * name)
 {
 	struct dentry * dentry = kobj->dentry;
-	struct dentry * d;
 	int error = 0;
 
+	if (!name)
+		return -EINVAL;
+
 	down(&dentry->d_inode->i_sem);
-	d = sysfs_get_dentry(dentry,name);
-	if (!IS_ERR(d)) {
-		error = sysfs_create(d, S_IFLNK|S_IRWXUGO, init_symlink);
-		if (!error)
-			/* 
-			 * associate the link dentry with the target kobject 
-			 */
-			d->d_fsdata = kobject_get(target);
-		dput(d);
-	} else 
-		error = PTR_ERR(d);
+	error = sysfs_add_link(dentry->d_fsdata, name, target);
 	up(&dentry->d_inode->i_sem);
 	return error;
 }

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
