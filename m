Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTJFJCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTJFJCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:02:22 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:44777 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263301AbTJFJBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:01:53 -0400
Date: Mon, 6 Oct 2003 14:32:14 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <gregkh@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC 5/6] sysfs-attr_group.patch
Message-ID: <20031006090214.GJ4220@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031006085915.GE4220@in.ibm.com> <20031006090003.GF4220@in.ibm.com> <20031006090030.GG4220@in.ibm.com> <20031006090107.GH4220@in.ibm.com> <20031006090139.GI4220@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006090139.GI4220@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o This patch creates attribute group for the given kobject. Again here we don;t
  create the sysfs directory but just links the struct attribute_group to the
  kobject.


 fs/sysfs/group.c |   46 ++++++++++++++++------------------------------
 1 files changed, 16 insertions(+), 30 deletions(-)

diff -puN fs/sysfs/group.c~sysfs-attr_group fs/sysfs/group.c
--- linux-2.6.0-test6/fs/sysfs/group.c~sysfs-attr_group	2003-10-06 12:00:23.000000000 +0530
+++ linux-2.6.0-test6-maneesh/fs/sysfs/group.c	2003-10-06 12:00:35.000000000 +0530
@@ -24,40 +24,26 @@ static void remove_files(struct dentry *
 		sysfs_hash_and_remove(dir,(*attr)->name);
 }
 
-static int create_files(struct dentry * dir,
-			const struct attribute_group * grp)
-{
-	struct attribute *const* attr;
-	int error = 0;
-
-	for (attr = grp->attrs; *attr && !error; attr++) {
-		error = sysfs_add_file(dir,*attr);
-	}
-	if (error)
-		remove_files(dir,grp);
-	return error;
-}
-
-
 int sysfs_create_group(struct kobject * kobj, 
 		       const struct attribute_group * grp)
 {
-	struct dentry * dir;
-	int error;
+	struct kobject_attr_group * k_attr_group;
 
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
-	}
-	return error;
+	if (!kobj || !grp)
+		return -EINVAL;
+
+	k_attr_group = kmalloc(sizeof(k_attr_group), GFP_KERNEL);
+	if (!k_attr_group)
+		return -ENOMEM;
+	memset(k_attr_group, 0, sizeof(k_attr_group));
+	INIT_LIST_HEAD(&k_attr_group->list);
+	k_attr_group->attr_group = grp;
+
+	down_write(&kobj->k_rwsem);
+	list_add(&k_attr_group->list, &kobj->attr_group);
+	up_write(&kobj->k_rwsem);
+	
+	return 0;
 }
 
 void sysfs_remove_group(struct kobject * kobj, 

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
