Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTJFJCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbTJFJCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:02:10 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:2448 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263014AbTJFJBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:01:19 -0400
Date: Mon, 6 Oct 2003 14:31:39 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <gregkh@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC 4/6] sysfs-symlink.patch
Message-ID: <20031006090139.GI4220@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031006085915.GE4220@in.ibm.com> <20031006090003.GF4220@in.ibm.com> <20031006090030.GG4220@in.ibm.com> <20031006090107.GH4220@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006090107.GH4220@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o This patch creates symlink kobject. We don't create the symlink in sysfs
  when sysfs_create_symlink() is called but just allocates one kobject to act
  as symlink. Again this code should be part of kobject code. But to keep the
  interfaces same it is in sysfs code.


 fs/sysfs/symlink.c |   41 +++++++++++++++++++++++++++++------------
 1 files changed, 29 insertions(+), 12 deletions(-)

diff -puN fs/sysfs/symlink.c~sysfs-symlink fs/sysfs/symlink.c
--- linux-2.6.0-test6/fs/sysfs/symlink.c~sysfs-symlink	2003-10-06 12:08:04.000000000 +0530
+++ linux-2.6.0-test6-maneesh/fs/sysfs/symlink.c	2003-10-06 12:14:43.000000000 +0530
@@ -15,7 +15,8 @@ static int init_symlink(struct inode * i
 	return 0;
 }
 
-static int sysfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
+int sysfs_symlink(struct inode * dir, struct dentry *dentry, 
+		   const char * symname)
 {
 	int error;
 
@@ -71,13 +72,12 @@ static void fill_object_path(struct kobj
  */
 int sysfs_create_link(struct kobject * kobj, struct kobject * target, char * name)
 {
-	struct dentry * dentry = kobj->dentry;
-	struct dentry * d;
 	int error = 0;
 	int size;
 	int depth;
 	char * path;
 	char * s;
+	struct kobject * link;
 
 	depth = object_depth(kobj);
 	size = object_path_length(target) + depth * 3 - 1;
@@ -96,15 +96,19 @@ int sysfs_create_link(struct kobject * k
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
+	link = kmalloc(sizeof(struct kobject), GFP_KERNEL); 
+	if (!link) {
+		kfree(path);
+		return -ENOMEM;
+	}
+	memset(link, 0, sizeof(struct kobject));
+	kobject_init(link);
+	kobject_set_name(link, name);
+	link->k_symlink = path;
+	down_write(&kobj->k_rwsem);
+	list_add(&link->k_sibling, &kobj->k_children);
+	up_write(&kobj->k_rwsem);
+	link->dentry = NULL;
 	return error;
 }
 
@@ -117,6 +121,19 @@ int sysfs_create_link(struct kobject * k
 
 void sysfs_remove_link(struct kobject * kobj, char * name)
 {
+	struct list_head * tmp;
+
+	down_write(&kobj->k_rwsem);
+	tmp = kobj->k_sibling.next;
+	while (tmp != &kobj->k_sibling) {
+		struct kobject * k = list_entry(tmp, struct kobject, k_sibling);
+		tmp = tmp->next;
+		if (!strcmp(kobject_name(k), name) && (k->k_symlink)) {
+			kfree(k->k_symlink);
+			kobject_cleanup(k);
+		}
+	}
+	up_write(&kobj->k_rwsem);
 	sysfs_hash_and_remove(kobj->dentry,name);
 }
 

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
