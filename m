Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTKLMag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 07:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTKLMag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 07:30:36 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:26079 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262061AbTKLM2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 07:28:07 -0500
Date: Wed, 12 Nov 2003 17:56:47 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 5/5] sysfs-symlink.patch
Message-ID: <20031112122647.GI14580@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031112122344.GD14580@in.ibm.com> <20031112122503.GE14580@in.ibm.com> <20031112122529.GF14580@in.ibm.com> <20031112122549.GG14580@in.ibm.com> <20031112122615.GH14580@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112122615.GH14580@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o This patch creates symlink kobject. We don't create the symlink in sysfs
  when sysfs_create_symlink() is called but just allocates one sysfs_dirent 
  of type SYSFS_KOBJ_LINK. The s_element for symlinks is an array of two
  strings, one prepresenting the name of the link and another patch of 
  the target of the link.


 fs/sysfs/symlink.c |   36 ++++++++++++++++++++----------------
 1 files changed, 20 insertions(+), 16 deletions(-)

diff -puN fs/sysfs/symlink.c~sysfs-symlink fs/sysfs/symlink.c
--- linux-2.6.0-test9/fs/sysfs/symlink.c~sysfs-symlink	2003-11-12 15:26:34.000000000 +0530
+++ linux-2.6.0-test9-maneesh/fs/sysfs/symlink.c	2003-11-12 15:26:53.000000000 +0530
@@ -15,7 +15,7 @@ static int init_symlink(struct inode * i
 	return 0;
 }
 
-static int sysfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
+int sysfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
 {
 	int error;
 
@@ -71,13 +71,12 @@ static void fill_object_path(struct kobj
  */
 int sysfs_create_link(struct kobject * kobj, struct kobject * target, char * name)
 {
-	struct dentry * dentry = kobj->dentry;
-	struct dentry * d;
-	int error = 0;
 	int size;
 	int depth;
 	char * path;
 	char * s;
+        char ** link_names;
+        struct sysfs_dirent * link;
 
 	depth = object_depth(kobj);
 	size = object_path_length(target) + depth * 3 - 1;
@@ -96,18 +95,23 @@ int sysfs_create_link(struct kobject * k
 	fill_object_path(target,path,size);
 	pr_debug("%s: path = '%s'\n",__FUNCTION__,path);
 
-	down(&dentry->d_inode->i_sem);
-	d = sysfs_get_dentry(dentry,name);
-	if (!IS_ERR(d))
-		error = sysfs_symlink(dentry->d_inode,d,path);
-	else
-		error = PTR_ERR(d);
-	dput(d);
-	up(&dentry->d_inode->i_sem);
-	kfree(path);
-	return error;
-}
+        link_names = kmalloc(2 * (sizeof(char *)), GFP_KERNEL);
+        if (!link_names) {
+                kfree(path);
+                return -ENOMEM;
+        }
+        link_names[0] = name;
+        link_names[1] = path;
+                                                                                
+	link = sysfs_alloc_dirent(kobj->s_dirent, link_names, SYSFS_KOBJ_LINK);
+	if (IS_ERR(link)) {
+                kfree(path);
+                kfree(link_names);
+		return PTR_ERR(link);
+	}
 
+	return 0;
+}
 
 /**
  *	sysfs_remove_link - remove symlink in object's directory.
@@ -117,7 +121,7 @@ int sysfs_create_link(struct kobject * k
 
 void sysfs_remove_link(struct kobject * kobj, char * name)
 {
-	sysfs_hash_and_remove(kobj->dentry,name);
+	sysfs_hash_and_remove(kobj->s_dirent, name);
 }
 
 

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
