Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWHOSFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWHOSFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWHOSFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:05:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30891 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030423AbWHOSFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:05:48 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 7/7] proc: Merge proc_tid_attr and proc_tgid_attr
Date: Tue, 15 Aug 2006 12:05:30 -0600
Message-Id: <11556651333155-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation is exactly the same and there is currently nothing to
distinguish proc_tid_attr, and proc_tgid_attr.   So it is pointless
to have two separate implementations.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c |   54 +++++++++++-------------------------------------------
 1 files changed, 11 insertions(+), 43 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index f657210..9943527 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1548,16 +1548,7 @@ static struct file_operations proc_pid_a
 	.write		= proc_pid_attr_write,
 };
 
-static struct pid_entry tgid_attr_stuff[] = {
-	REG("current",    S_IRUGO|S_IWUGO, pid_attr),
-	REG("prev",       S_IRUGO,	   pid_attr),
-	REG("exec",       S_IRUGO|S_IWUGO, pid_attr),
-	REG("fscreate",   S_IRUGO|S_IWUGO, pid_attr),
-	REG("keycreate",  S_IRUGO|S_IWUGO, pid_attr),
-	REG("sockcreate", S_IRUGO|S_IWUGO, pid_attr),
-	{}
-};
-static struct pid_entry tid_attr_stuff[] = {
+static struct pid_entry attr_dir_stuff[] = {
 	REG("current",    S_IRUGO|S_IWUGO, pid_attr),
 	REG("prev",       S_IRUGO,	   pid_attr),
 	REG("exec",       S_IRUGO|S_IWUGO, pid_attr),
@@ -1567,53 +1558,30 @@ static struct pid_entry tid_attr_stuff[]
 	{}
 };
 
-static int proc_tgid_attr_readdir(struct file * filp,
+static int proc_attr_dir_readdir(struct file * filp,
 			     void * dirent, filldir_t filldir)
 {
 	return proc_pident_readdir(filp,dirent,filldir,
-				   tgid_attr_stuff,ARRAY_SIZE(tgid_attr_stuff));
+				   attr_dir_stuff,ARRAY_SIZE(attr_dir_stuff));
 }
 
-static int proc_tid_attr_readdir(struct file * filp,
-			     void * dirent, filldir_t filldir)
-{
-	return proc_pident_readdir(filp,dirent,filldir,
-				   tid_attr_stuff,ARRAY_SIZE(tid_attr_stuff));
-}
-
-static struct file_operations proc_tgid_attr_operations = {
-	.read		= generic_read_dir,
-	.readdir	= proc_tgid_attr_readdir,
-};
-
-static struct file_operations proc_tid_attr_operations = {
+static struct file_operations proc_attr_dir_operations = {
 	.read		= generic_read_dir,
-	.readdir	= proc_tid_attr_readdir,
+	.readdir	= proc_attr_dir_readdir,
 };
 
-static struct dentry *proc_tgid_attr_lookup(struct inode *dir,
+static struct dentry *proc_attr_dir_lookup(struct inode *dir,
 				struct dentry *dentry, struct nameidata *nd)
 {
-	return proc_pident_lookup(dir, dentry, tgid_attr_stuff);
+	return proc_pident_lookup(dir, dentry, attr_dir_stuff);
 }
 
-static struct dentry *proc_tid_attr_lookup(struct inode *dir,
-				struct dentry *dentry, struct nameidata *nd)
-{
-	return proc_pident_lookup(dir, dentry, tid_attr_stuff);
-}
-
-static struct inode_operations proc_tgid_attr_inode_operations = {
-	.lookup		= proc_tgid_attr_lookup,
+static struct inode_operations proc_attr_dir_inode_operations = {
+	.lookup		= proc_attr_dir_lookup,
 	.getattr	= pid_getattr,
 	.setattr	= proc_setattr,
 };
 
-static struct inode_operations proc_tid_attr_inode_operations = {
-	.lookup		= proc_tid_attr_lookup,
-	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
-};
 #endif
 
 /*
@@ -1671,7 +1639,7 @@ #ifdef CONFIG_MMU
 	REG("smaps",      S_IRUGO, smaps),
 #endif
 #ifdef CONFIG_SECURITY
-	DIR("attr",       S_IRUGO|S_IXUGO, tgid_attr),
+	DIR("attr",       S_IRUGO|S_IXUGO, attr_dir),
 #endif
 #ifdef CONFIG_KALLSYMS
 	INF("wchan",      S_IRUGO, pid_wchan),
@@ -1988,7 +1956,7 @@ #ifdef CONFIG_MMU
 	REG("smaps",     S_IRUGO, smaps),
 #endif
 #ifdef CONFIG_SECURITY
-	DIR("attr",      S_IRUGO|S_IXUGO, tid_attr),
+	DIR("attr",      S_IRUGO|S_IXUGO, attr_dir),
 #endif
 #ifdef CONFIG_KALLSYMS
 	INF("wchan",     S_IRUGO, pid_wchan),
-- 
1.4.2.rc3.g7e18e-dirty

