Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbUCCMiy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 07:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUCCMif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 07:38:35 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:64705 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261503AbUCCMhG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 07:37:06 -0500
Date: Wed, 3 Mar 2004 18:11:43 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>,
       "Martin J. Bligh" <mjbligh@us.ibm.com>, Matt Mackall <mpm@selenic.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC] 5/6 sysfs backing store version 0.2
Message-ID: <20040303124143.GH2469@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040303123858.GC2469@in.ibm.com> <20040303123942.GD2469@in.ibm.com> <20040303124005.GE2469@in.ibm.com> <20040303124035.GF2469@in.ibm.com> <20040303124109.GG2469@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303124109.GG2469@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



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


 fs/sysfs/symlink.c |   48 ++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 38 insertions(+), 10 deletions(-)

diff -puN fs/sysfs/symlink.c~sysfs-leaves-symlink fs/sysfs/symlink.c
--- linux-2.6.4-rc1/fs/sysfs/symlink.c~sysfs-leaves-symlink	2004-03-03 16:24:11.000000000 +0530
+++ linux-2.6.4-rc1-maneesh/fs/sysfs/symlink.c	2004-03-03 16:24:11.000000000 +0530
@@ -15,7 +15,7 @@ static int init_symlink(struct inode * i
 	return 0;
 }
 
-static int sysfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
+int sysfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
 {
 	int error;
 
@@ -63,6 +63,27 @@ static void fill_object_path(struct kobj
 	}
 }
 
+static int sysfs_add_link(struct sysfs_dirent * parent_sd, char * name, char * target)
+{
+	struct sysfs_dirent * sd;
+	char ** link_names;
+
+	link_names = kmalloc(sizeof(char *) * 2, GFP_KERNEL);
+	if (!link_names)
+		return -ENOMEM;
+
+	link_names[0] = name;
+	link_names[1] = target;
+	
+	sd = sysfs_new_dirent(parent_sd, link_names, SYSFS_KOBJ_LINK);
+	if (!sd) {
+		kfree(link_names);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /**
  *	sysfs_create_link - create symlink between two objects.
  *	@kobj:	object whose directory we're creating the link in.
@@ -72,13 +93,15 @@ static void fill_object_path(struct kobj
 int sysfs_create_link(struct kobject * kobj, struct kobject * target, char * name)
 {
 	struct dentry * dentry = kobj->dentry;
-	struct dentry * d;
 	int error = 0;
 	int size;
 	int depth;
-	char * path;
+	char * link_name, * path;
 	char * s;
 
+	if (!name)
+		return -EINVAL;
+
 	depth = object_depth(kobj);
 	size = object_path_length(target) + depth * 3 - 1;
 	if (size > PATH_MAX)
@@ -96,15 +119,20 @@ int sysfs_create_link(struct kobject * k
 	fill_object_path(target,path,size);
 	pr_debug("%s: path = '%s'\n",__FUNCTION__,path);
 
+	link_name = kmalloc(strlen(name) + 1, GFP_KERNEL);
+	if (!link_name) {
+		kfree(path);
+		return -ENOMEM;
+	}
+	strcpy(link_name, name);
+
 	down(&dentry->d_inode->i_sem);
-	d = sysfs_get_dentry(dentry,name);
-	if (!IS_ERR(d))
-		error = sysfs_symlink(dentry->d_inode,d,path);
-	else
-		error = PTR_ERR(d);
-	dput(d);
+	error = sysfs_add_link(dentry->d_fsdata, link_name, path);
 	up(&dentry->d_inode->i_sem);
-	kfree(path);
+	if (error) {
+		kfree(path);
+		kfree(link_name);
+	}
 	return error;
 }
 

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-5268553
T/L : 9243696
