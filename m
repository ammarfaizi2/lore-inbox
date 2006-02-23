Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWBWQf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWBWQf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWBWQf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:35:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37783 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751292AbWBWQfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:35:25 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 23/23] proc: Merge proc_tid_attr and proc_tgid_attr
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j7mhxs0.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biahxpd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0aqgiyv.fsf_-_@ebiederm.dsl.xmission.com>
	<m1pslegiwg.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkw2giue.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd6qgirv.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5heginy.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xs2gikb.fsf_-_@ebiederm.dsl.xmission.com>
	<m14q2qgigc.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zmkif3t8.fsf_-_@ebiederm.dsl.xmission.com>
	<m1vev6f3q3.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r75uf3mc.fsf_-_@ebiederm.dsl.xmission.com>
	<m1mzgif3ik.fsf_-_@ebiederm.dsl.xmission.com>
	<m1irr6f3h3.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ek1uf3eq.fsf_-_@ebiederm.dsl.xmission.com>
	<m1accif3bx.fsf_-_@ebiederm.dsl.xmission.com>
	<m164n6f39h.fsf_-_@ebiederm.dsl.xmission.com>
	<m11wxuf35z.fsf_-_@ebiederm.dsl.xmission.com>
	<m1wtfmdoib.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:34:15 -0700
In-Reply-To: <m1wtfmdoib.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:32:44 -0700")
Message-ID: <m1slqadofs.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The implementation is exactly the same and there is currently nothing to
distinguish proc_tid_attr, and proc_tgid_attr.   So it is pointless
to have two separate implementations.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |   50 +++++++++++---------------------------------------
 1 files changed, 11 insertions(+), 39 deletions(-)

283d43b12524e2ae07f6a47fa28392ed77bc9e00
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ae63eeb..e4a4f85 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1495,14 +1495,7 @@ static struct file_operations proc_pid_a
 	.write		= proc_pid_attr_write,
 };
 
-static struct pid_entry tgid_attr_stuff[] = {
-	REG("current",  S_IRUGO|S_IWUGO, pid_attr),
-	REG("prev",     S_IRUGO,         pid_attr),
-	REG("exec",     S_IRUGO|S_IWUGO, pid_attr),
-	REG("fscreate", S_IRUGO|S_IWUGO, pid_attr),
-	{}
-};
-static struct pid_entry tid_attr_stuff[] = {
+static struct pid_entry attr_dir_stuff[] = {
 	REG("current",  S_IRUGO|S_IWUGO, pid_attr),
 	REG("prev",     S_IRUGO,         pid_attr),
 	REG("exec",     S_IRUGO|S_IWUGO, pid_attr),
@@ -1510,49 +1503,28 @@ static struct pid_entry tid_attr_stuff[]
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
+static struct file_operations proc_attr_dir_operations = {
 	.read		= generic_read_dir,
-	.readdir	= proc_tgid_attr_readdir,
+	.readdir	= proc_attr_dir_readdir,
 };
 
-static struct file_operations proc_tid_attr_operations = {
-	.read		= generic_read_dir,
-	.readdir	= proc_tid_attr_readdir,
-};
-
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
 };
 
-static struct inode_operations proc_tid_attr_inode_operations = {
-	.lookup		= proc_tid_attr_lookup,
-};
 #endif
 
 /*
@@ -1609,7 +1581,7 @@ static struct pid_entry tgid_base_stuff[
 	REG("smaps",     S_IRUGO, smaps),
 #endif
 #ifdef CONFIG_SECURITY
-	DIR("attr",      S_IRUGO|S_IXUGO, tgid_attr),
+	DIR("attr",      S_IRUGO|S_IXUGO, attr_dir),
 #endif
 #ifdef CONFIG_KALLSYMS
 	INF("wchan",     S_IRUGO, pid_wchan),
@@ -1939,7 +1911,7 @@ static struct pid_entry tid_base_stuff[]
 	REG("smaps",     S_IRUGO, smaps),
 #endif
 #ifdef CONFIG_SECURITY
-	DIR("attr",      S_IRUGO|S_IXUGO, tid_attr),
+	DIR("attr",      S_IRUGO|S_IXUGO, attr_dir),
 #endif
 #ifdef CONFIG_KALLSYMS
 	INF("wchan",     S_IRUGO, pid_wchan),
-- 
1.2.2.g709a

