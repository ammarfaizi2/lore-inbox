Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUBQHVQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 02:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUBQHVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 02:21:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24489 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261733AbUBQHT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 02:19:57 -0500
Date: Tue, 17 Feb 2004 12:54:36 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] Fix dentry refcounting in sysfs_remove_group()
Message-ID: <20040217072436.GB5459@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please review the following patch fixing the dentry refcounting during
sysfs_remove_group().

Thanks
Maneesh



o The following patch fixes the dentry refcounting, during sysfs_remove_group() 
  and also adds the missing dput() for the "extra" ref taken during 
  sysfs_create() for the sub-directory dentry corresponding to attribute group. 
  


 fs/sysfs/dir.c   |    2 ++
 fs/sysfs/group.c |    5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff -puN fs/sysfs/dir.c~sysfs_remove_subdir-dentry-leak-fix fs/sysfs/dir.c
--- linux-2.6.3-rc4/fs/sysfs/dir.c~sysfs_remove_subdir-dentry-leak-fix	2004-02-17 11:48:24.000000000 +0530
+++ linux-2.6.3-rc4-maneesh/fs/sysfs/dir.c	2004-02-17 11:54:11.000000000 +0530
@@ -96,6 +96,8 @@ static void remove_dir(struct dentry * d
 void sysfs_remove_subdir(struct dentry * d)
 {
 	remove_dir(d);
+	/* release the "extra" ref taken during sysfs_create() */
+	dput(d);
 }
 
 
diff -puN fs/sysfs/group.c~sysfs_remove_subdir-dentry-leak-fix fs/sysfs/group.c
--- linux-2.6.3-rc4/fs/sysfs/group.c~sysfs_remove_subdir-dentry-leak-fix	2004-02-17 11:48:59.000000000 +0530
+++ linux-2.6.3-rc4-maneesh/fs/sysfs/group.c	2004-02-17 11:49:37.000000000 +0530
@@ -68,12 +68,13 @@ void sysfs_remove_group(struct kobject *
 	if (grp->name)
 		dir = sysfs_get_dentry(kobj->dentry,grp->name);
 	else
-		dir = kobj->dentry;
+		dir = dget(kobj->dentry);
 
 	remove_files(dir,grp);
-	dput(dir);
 	if (grp->name)
 		sysfs_remove_subdir(dir);
+	/* release the ref. taken in this routine */
+	dput(dir);
 }
 
 

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-5268553
T/L : 9243696
