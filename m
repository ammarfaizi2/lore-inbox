Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTKLMaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 07:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTKLM2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 07:28:32 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:62689 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261925AbTKLM1g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 07:27:36 -0500
Date: Wed, 12 Nov 2003 17:56:15 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 4/5] sysfs-attr_group.patch
Message-ID: <20031112122615.GH14580@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031112122344.GD14580@in.ibm.com> <20031112122503.GE14580@in.ibm.com> <20031112122529.GF14580@in.ibm.com> <20031112122549.GG14580@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112122549.GG14580@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o This patch creates attribute group for the given kobject. Again here we don;t
  create the sysfs directory but just allocated sysfs_dirent for the attribute
  group and links it to the kobject's hierarchy.


 fs/sysfs/group.c |   75 +++++++++++++++++++++++++++++++++----------------------
 1 files changed, 45 insertions(+), 30 deletions(-)

diff -puN fs/sysfs/group.c~sysfs-attr_group fs/sysfs/group.c
--- linux-2.6.0-test9/fs/sysfs/group.c~sysfs-attr_group	2003-11-12 16:30:55.000000000 +0530
+++ linux-2.6.0-test9-maneesh/fs/sysfs/group.c	2003-11-12 16:30:55.000000000 +0530
@@ -12,70 +12,85 @@
 #include <linux/module.h>
 #include <linux/dcache.h>
 #include <linux/err.h>
+#include <linux/namei.h>
 #include "sysfs.h"
 
 
-static void remove_files(struct dentry * dir, 
+static void remove_files(struct sysfs_dirent * sd, 
 			 const struct attribute_group * grp)
 {
 	struct attribute *const* attr;
 
 	for (attr = grp->attrs; *attr; attr++)
-		sysfs_hash_and_remove(dir,(*attr)->name);
+		sysfs_hash_and_remove(sd, (*attr)->name);
 }
 
-static int create_files(struct dentry * dir,
+static int create_files(struct sysfs_dirent * parent_sd,
 			const struct attribute_group * grp)
 {
 	struct attribute *const* attr;
 	int error = 0;
 
 	for (attr = grp->attrs; *attr && !error; attr++) {
-		error = sysfs_add_file(dir,*attr);
+		error = sysfs_add_file(parent_sd, *attr);
 	}
 	if (error)
-		remove_files(dir,grp);
+		remove_files(parent_sd, grp);
 	return error;
 }
 
-
 int sysfs_create_group(struct kobject * kobj, 
 		       const struct attribute_group * grp)
 {
-	struct dentry * dir;
-	int error;
+	struct sysfs_dirent * sd;
+	int error = 0;
 
-	if (grp->name) {
-		error = sysfs_create_subdir(kobj,grp->name,&dir);
-		if (error)
-			return error;
-	} else
-		dir = kobj->dentry;
-	dir = dget(dir);
-	if ((error = create_files(dir,grp))) {
-		if (grp->name)
-			sysfs_remove_subdir(dir);
-		dput(dir);
+	if (!kobj || !grp)
+		return -EINVAL;
+
+	sd = sysfs_alloc_dirent(kobj->s_dirent, (void *) grp, SYSFS_KOBJ_ATTR_GROUP);
+	if (IS_ERR(sd))
+		return PTR_ERR(sd);
+
+	if ((error = create_files(sd, grp))) {
+		sysfs_remove_group(kobj, grp);
 	}
+
 	return error;
 }
 
 void sysfs_remove_group(struct kobject * kobj, 
 			const struct attribute_group * grp)
 {
-	struct dentry * dir;
+	struct sysfs_dirent * tmp_sd;
+	struct sysfs_dirent * grp_sd = NULL;
+	struct dentry * grp_dentry;
 
-	if (grp->name)
-		dir = sysfs_get_dentry(kobj->dentry,grp->name);
-	else
-		dir = kobj->dentry;
-
-	remove_files(dir,grp);
-	dput(dir);
-	if (grp->name)
-		sysfs_remove_subdir(dir);
-}
+	if (grp->name) {
+		down_read(&kobj->s_dirent->s_rwsem);
+		list_for_each_entry(tmp_sd, &kobj->s_dirent->s_children, s_sibling) {
+			if (!strcmp(grp->name, sysfs_get_name(tmp_sd))) {
+				grp_sd = tmp_sd;
+				break;
+			}
+		}
+		up_read(&kobj->s_dirent->s_rwsem);
+	} else 
+		grp_sd = kobj->s_dirent;
+
+	if (grp_sd->s_dentry) {
+		spin_lock(&dcache_lock);
+		grp_dentry = dget_locked(grp_sd->s_dentry);
+		spin_unlock(&dcache_lock);
+		remove_files(grp_sd, grp);
+		if (grp->name) 
+			sysfs_remove_subdir(grp_dentry);
+		dput(grp_dentry);
+	} else
+		sysfs_free_children(grp_sd);
 
+	sysfs_free_dirent(kobj->s_dirent, grp->name);
+}
 
 EXPORT_SYMBOL(sysfs_create_group);
 EXPORT_SYMBOL(sysfs_remove_group);

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
