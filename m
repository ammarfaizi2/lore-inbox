Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbTJOE2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 00:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTJOE2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 00:28:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:38600 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262359AbTJOE2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 00:28:12 -0400
Date: Tue, 14 Oct 2003 21:31:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-Id: <20031014213150.26cee98a.akpm@osdl.org>
In-Reply-To: <20031014105514.GH765@holomorphy.com>
References: <20031014105514.GH765@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> (e) About 4.8MB are consumed by slab allocations at runtime.
>  	The top 10 slab abusers are:
> 
>  inode_cache               840K           840K     100.00%   
>  dentry_cache              746K           753K      99.07%   
>  ext3_inode_cache          591K           592K      99.84%   
>  size-4096                 504K           504K     100.00%   
>  size-512                  203K           204K      99.75%   
>  size-2048                 182K           204K      89.22%   
>  pgd                       188K           188K     100.00%   
>  task_struct               100K           108K      92.86%   
>  vm_area_struct             93K           101K      92.28%   
>  blkdev_requests           101K           101K     100.00%   
> 
>  The inode_cache culprit is the obvious butt of many complaints:
>  # find /sys | wc -l
>  2656
> 

hmm, you have a lot more sysfs entries than I do:

vmm:/home/akpm> find /sys|wc -l
    849

The below patch nukes them all; saves around half meg here.  You need to
add "nosysfs" and "root=NN:MM" to the kernel boot commandline.  Please let
me know how much space you save.



 fs/sysfs/bin.c        |    6 ++++++
 fs/sysfs/dir.c        |   16 +++++++++++++++-
 fs/sysfs/file.c       |    9 +++++++++
 fs/sysfs/group.c      |    6 ++++++
 fs/sysfs/inode.c      |   18 ++++++++++++++++--
 fs/sysfs/symlink.c    |    3 +++
 fs/sysfs/sysfs.h      |    3 +++
 include/linux/sysfs.h |    0 
 8 files changed, 58 insertions(+), 3 deletions(-)

diff -puN fs/sysfs/inode.c~nosysfs fs/sysfs/inode.c
--- 25/fs/sysfs/inode.c~nosysfs	2003-10-14 18:24:42.000000000 -0700
+++ 25-akpm/fs/sysfs/inode.c	2003-10-14 18:40:16.000000000 -0700
@@ -11,7 +11,8 @@
 #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
-extern struct super_block * sysfs_sb;
+#include <linux/init.h>
+#include "sysfs.h"
 
 static struct address_space_operations sysfs_aops = {
 	.readpage	= simple_readpage,
@@ -24,6 +25,8 @@ static struct backing_dev_info sysfs_bac
 	.memory_backed	= 1,	/* Does not contribute to dirty memory */
 };
 
+int nosysfs;
+
 struct inode * sysfs_new_inode(mode_t mode)
 {
 	struct inode * inode = new_inode(sysfs_sb);
@@ -44,6 +47,10 @@ int sysfs_create(struct dentry * dentry,
 {
 	int error = 0;
 	struct inode * inode = NULL;
+
+	if (nosysfs)
+		return 0;
+
 	if (dentry) {
 		if (!dentry->d_inode) {
 			if ((inode = sysfs_new_inode(mode)))
@@ -87,6 +94,8 @@ void sysfs_hash_and_remove(struct dentry
 {
 	struct dentry * victim;
 
+	if (nosysfs)
+		return;
 	down(&dir->d_inode->i_sem);
 	victim = sysfs_get_dentry(dir,name);
 	if (!IS_ERR(victim)) {
@@ -107,4 +116,9 @@ void sysfs_hash_and_remove(struct dentry
 	up(&dir->d_inode->i_sem);
 }
 
-
+static int __init nosysfs_setup(char *str)
+{
+	nosysfs = 1;
+	return 1;
+}
+__setup("nosysfs", nosysfs_setup);
diff -puN fs/sysfs/dir.c~nosysfs fs/sysfs/dir.c
--- 25/fs/sysfs/dir.c~nosysfs	2003-10-14 18:25:40.000000000 -0700
+++ 25-akpm/fs/sysfs/dir.c	2003-10-14 18:29:50.000000000 -0700
@@ -46,6 +46,8 @@ static int create_dir(struct kobject * k
 
 int sysfs_create_subdir(struct kobject * k, const char * n, struct dentry ** d)
 {
+	if (nosysfs)
+		return 0;
 	return create_dir(k,k->dentry,n,d);
 }
 
@@ -61,6 +63,9 @@ int sysfs_create_dir(struct kobject * ko
 	struct dentry * parent;
 	int error = 0;
 
+	if (nosysfs)
+		return 0;
+
 	if (!kobj)
 		return -EINVAL;
 
@@ -102,6 +107,8 @@ static void remove_dir(struct dentry * d
 
 void sysfs_remove_subdir(struct dentry * d)
 {
+	if (nosysfs)
+		return;
 	remove_dir(d);
 }
 
@@ -118,8 +125,12 @@ void sysfs_remove_subdir(struct dentry *
 void sysfs_remove_dir(struct kobject * kobj)
 {
 	struct list_head * node;
-	struct dentry * dentry = dget(kobj->dentry);
+	struct dentry *dentry;
+
+	if (nosysfs)
+		return;
 
+	dentry = dget(kobj->dentry);
 	if (!dentry)
 		return;
 
@@ -164,6 +175,9 @@ void sysfs_rename_dir(struct kobject * k
 {
 	struct dentry * new_dentry, * parent;
 
+	if (nosysfs)
+		return;
+
 	if (!strcmp(kobject_name(kobj), new_name))
 		return;
 
diff -puN include/linux/sysfs.h~nosysfs include/linux/sysfs.h
diff -puN fs/sysfs/sysfs.h~nosysfs fs/sysfs/sysfs.h
--- 25/fs/sysfs/sysfs.h~nosysfs	2003-10-14 18:27:36.000000000 -0700
+++ 25-akpm/fs/sysfs/sysfs.h	2003-10-14 18:28:22.000000000 -0700
@@ -1,4 +1,7 @@
+struct super_block;
 
+extern struct super_block *sysfs_sb;
+extern int nosysfs;
 extern struct vfsmount * sysfs_mount;
 
 extern struct inode * sysfs_new_inode(mode_t mode);
diff -puN fs/sysfs/file.c~nosysfs fs/sysfs/file.c
--- 25/fs/sysfs/file.c~nosysfs	2003-10-14 18:38:15.000000000 -0700
+++ 25-akpm/fs/sysfs/file.c	2003-10-14 18:40:06.000000000 -0700
@@ -350,6 +350,9 @@ int sysfs_add_file(struct dentry * dir, 
 	struct dentry * dentry;
 	int error;
 
+	if (nosysfs)
+		return 0;
+
 	down(&dir->d_inode->i_sem);
 	dentry = sysfs_get_dentry(dir,attr->name);
 	if (!IS_ERR(dentry)) {
@@ -374,6 +377,9 @@ int sysfs_add_file(struct dentry * dir, 
 
 int sysfs_create_file(struct kobject * kobj, const struct attribute * attr)
 {
+	if (nosysfs)
+		return 0;
+
 	if (kobj && attr)
 		return sysfs_add_file(kobj->dentry,attr);
 	return -EINVAL;
@@ -394,6 +400,9 @@ int sysfs_update_file(struct kobject * k
 	struct dentry * victim;
 	int res = -ENOENT;
 
+	if (nosysfs)
+		return 0;
+
 	down(&dir->d_inode->i_sem);
 	victim = sysfs_get_dentry(dir, attr->name);
 	if (!IS_ERR(victim)) {
diff -puN fs/sysfs/symlink.c~nosysfs fs/sysfs/symlink.c
--- 25/fs/sysfs/symlink.c~nosysfs	2003-10-14 18:40:32.000000000 -0700
+++ 25-akpm/fs/sysfs/symlink.c	2003-10-14 18:40:57.000000000 -0700
@@ -79,6 +79,9 @@ int sysfs_create_link(struct kobject * k
 	char * path;
 	char * s;
 
+	if (nosysfs)
+		return 0;
+
 	depth = object_depth(kobj);
 	size = object_path_length(target) + depth * 3 - 1;
 	if (size > PATH_MAX)
diff -puN fs/sysfs/bin.c~nosysfs fs/sysfs/bin.c
--- 25/fs/sysfs/bin.c~nosysfs	2003-10-14 18:51:48.000000000 -0700
+++ 25-akpm/fs/sysfs/bin.c	2003-10-14 18:52:20.000000000 -0700
@@ -152,6 +152,9 @@ int sysfs_create_bin_file(struct kobject
 	struct dentry * parent;
 	int error = 0;
 
+	if (nosysfs)
+		return 0;
+
 	if (!kobj || !attr)
 		return -EINVAL;
 
@@ -185,6 +188,9 @@ int sysfs_create_bin_file(struct kobject
 
 int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr)
 {
+	if (nosysfs)
+		return 0;
+
 	sysfs_hash_and_remove(kobj->dentry,attr->attr.name);
 	return 0;
 }
diff -puN fs/sysfs/group.c~nosysfs fs/sysfs/group.c
--- 25/fs/sysfs/group.c~nosysfs	2003-10-14 19:32:58.000000000 -0700
+++ 25-akpm/fs/sysfs/group.c	2003-10-14 19:33:16.000000000 -0700
@@ -45,6 +45,9 @@ int sysfs_create_group(struct kobject * 
 	struct dentry * dir;
 	int error;
 
+	if (nosysfs)
+		return 0;
+
 	if (grp->name) {
 		error = sysfs_create_subdir(kobj,grp->name,&dir);
 		if (error)
@@ -65,6 +68,9 @@ void sysfs_remove_group(struct kobject *
 {
 	struct dentry * dir;
 
+	if (nosysfs)
+		return;
+
 	if (grp->name)
 		dir = sysfs_get_dentry(kobj->dentry,grp->name);
 	else

_

