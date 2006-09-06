Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWIFQ3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWIFQ3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWIFQ3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:29:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52195 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751561AbWIFQ3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:29:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] proc: Merge proc_tid_attr and proc_tgid_attr
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
	<m1k64hx8rx.fsf@ebiederm.dsl.xmission.com>
	<m1fyf5x8ny.fsf_-_@ebiederm.dsl.xmission.com>
Date: Wed, 06 Sep 2006 10:28:37 -0600
In-Reply-To: <m1fyf5x8ny.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Wed, 06 Sep 2006 10:27:13 -0600")
Message-ID: <m1bqptx8lm.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
index be4d49d..5500ff6 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1549,16 +1549,7 @@ static struct file_operations proc_pid_a
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
@@ -1568,53 +1559,30 @@ static struct pid_entry tid_attr_stuff[]
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
@@ -1791,7 +1759,7 @@ #ifdef CONFIG_MMU
 	REG("smaps",      S_IRUGO, smaps),
 #endif
 #ifdef CONFIG_SECURITY
-	DIR("attr",       S_IRUGO|S_IXUGO, tgid_attr),
+	DIR("attr",       S_IRUGO|S_IXUGO, attr_dir),
 #endif
 #ifdef CONFIG_KALLSYMS
 	INF("wchan",      S_IRUGO, pid_wchan),
@@ -2066,7 +2034,7 @@ #ifdef CONFIG_MMU
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

