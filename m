Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUENXIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUENXIT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUENXIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:08:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:50396 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262905AbUENXH7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:07:59 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <10845760433419@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:23 -0700
Message-Id: <1084576043923@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.27, 2004/05/11 16:43:50-07:00, maneesh@in.ibm.com

[PATCH] kobject/sysfs race fix

The following patch fixes the race involved between unregistering a kobject
and simultaneously opeing a corresponding attribute file in sysfs.

Ideally sysfs should take a ref.  to the kobject as long as it has dentries
referring to the kobjects, but because of current limitations in
module/kobject ref counting, sysfs's pinning of kobject leads to
hang/delays in rmmod of certain modules.  The patch checks for unhashed
dentries in check_perm() while opening a sysfs file.  If the dentry is
still hashed then it goes ahead and takes the ref to kobject.  This done
under the per dentry lock.  It does this in the inline routine
sysfs_get_kobject(dentry).


 fs/sysfs/bin.c   |    2 +-
 fs/sysfs/file.c  |    2 +-
 fs/sysfs/sysfs.h |   13 +++++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)


diff -Nru a/fs/sysfs/bin.c b/fs/sysfs/bin.c
--- a/fs/sysfs/bin.c	Fri May 14 15:56:11 2004
+++ b/fs/sysfs/bin.c	Fri May 14 15:56:11 2004
@@ -94,7 +94,7 @@
 
 static int open(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
+	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
 	struct bin_attribute * attr = file->f_dentry->d_fsdata;
 	int error = -EINVAL;
 
diff -Nru a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c	Fri May 14 15:56:11 2004
+++ b/fs/sysfs/file.c	Fri May 14 15:56:11 2004
@@ -238,7 +238,7 @@
 
 static int check_perm(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
+	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
 	struct attribute * attr = file->f_dentry->d_fsdata;
 	struct sysfs_buffer * buffer;
 	struct sysfs_ops * ops = NULL;
diff -Nru a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
--- a/fs/sysfs/sysfs.h	Fri May 14 15:56:11 2004
+++ b/fs/sysfs/sysfs.h	Fri May 14 15:56:11 2004
@@ -11,3 +11,16 @@
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
+
+
+static inline struct kobject *sysfs_get_kobject(struct dentry *dentry)
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

