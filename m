Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbUCRGdy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 01:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbUCRGck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 01:32:40 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:37585 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262424AbUCRGbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 01:31:08 -0500
Date: Thu, 18 Mar 2004 12:05:48 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Carsten Otte <COTTE@de.ibm.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>,
       "Martin J. Bligh" <mjbligh@us.ibm.com>, Matt Mackall <mpm@selenic.com>
Subject: [RFC 5/6] sysfs backing store v0.3
Message-ID: <20040318063548.GF27107@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040318063306.GA27107@in.ibm.com> <20040318063352.GB27107@in.ibm.com> <20040318063424.GC27107@in.ibm.com> <20040318063455.GD27107@in.ibm.com> <20040318063524.GE27107@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318063524.GE27107@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




= changes in version 0.3
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


 fs/sysfs/symlink.c |   48 ++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 38 insertions(+), 10 deletions(-)

diff -puN fs/sysfs/symlink.c~sysfs-leaves-symlink fs/sysfs/symlink.c
--- linux-2.6.5-rc1/fs/sysfs/symlink.c~sysfs-leaves-symlink	2004-03-18 11:37:04.000000000 +0530
+++ linux-2.6.5-rc1-maneesh/fs/sysfs/symlink.c	2004-03-18 11:37:04.000000000 +0530
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
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
