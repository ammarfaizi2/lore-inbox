Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUBRNGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUBRNE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:04:26 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:60812 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265933AbUBRNCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:02:16 -0500
Date: Wed, 18 Feb 2004 18:36:47 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mjbligh@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Matt Mackall <mpm@selenic.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Subject: [RFC][5/6] Sysfs backing store release 0.1
Message-ID: <20040218130647.GG1255@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040218130211.GB1255@in.ibm.com> <20040218130306.GC1255@in.ibm.com> <20040218130411.GD1255@in.ibm.com> <20040218130501.GE1255@in.ibm.com> <20040218130542.GF1255@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218130542.GF1255@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o sysfs_create_link() now does not create a dentry but allocates a
  sysfs_dirent and links it to the parent kobject.

o sysfs_dirent corresponding to symlink has an array of two string. One of
  them is the name of the symlink and the second one is the target path of the
  symlink


 fs/sysfs/symlink.c |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff -puN fs/sysfs/symlink.c~sysfs-leaves-symlink fs/sysfs/symlink.c
--- linux-2.6.3-mm1/fs/sysfs/symlink.c~sysfs-leaves-symlink	2004-02-18 15:23:41.000000000 +0530
+++ linux-2.6.3-mm1-maneesh/fs/sysfs/symlink.c	2004-02-18 15:23:49.000000000 +0530
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
@@ -72,7 +93,6 @@ static void fill_object_path(struct kobj
 int sysfs_create_link(struct kobject * kobj, struct kobject * target, char * name)
 {
 	struct dentry * dentry = kobj->dentry;
-	struct dentry * d;
 	int error = 0;
 	int size;
 	int depth;
@@ -97,14 +117,10 @@ int sysfs_create_link(struct kobject * k
 	pr_debug("%s: path = '%s'\n",__FUNCTION__,path);
 
 	down(&dentry->d_inode->i_sem);
-	d = sysfs_get_dentry(dentry,name);
-	if (!IS_ERR(d))
-		error = sysfs_symlink(dentry->d_inode,d,path);
-	else
-		error = PTR_ERR(d);
-	dput(d);
+	error = sysfs_add_link(dentry->d_fsdata, name, path);
 	up(&dentry->d_inode->i_sem);
-	kfree(path);
+	if (error)
+		kfree(path);
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
