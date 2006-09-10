Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbWIJEC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbWIJEC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 00:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbWIJECX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 00:02:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64163 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965212AbWIJEBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 00:01:55 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/4] proc: Remove trailing blank entry from pid_entry arrays.
Date: Sat,  9 Sep 2006 22:01:03 -0600
Message-Id: <11578608651017-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1venwfk43.fsf@ebiederm.dsl.xmission.com>
References: <m1venwfk43.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was pointed out that since I am taking ARRAY_SIZE anyway
the trailing empty entry is silly and just wastes space.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c |   39 +++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c4fcd64..725e279 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1377,12 +1377,13 @@ out:
 /* SMP-safe */
 static struct dentry *proc_pident_lookup(struct inode *dir, 
 					 struct dentry *dentry,
-					 struct pid_entry *ents)
+					 struct pid_entry *ents,
+					 unsigned int nents)
 {
 	struct inode *inode;
 	struct dentry *error;
 	struct task_struct *task = get_proc_task(dir);
-	struct pid_entry *p;
+	struct pid_entry *p, *last;
 
 	error = ERR_PTR(-ENOENT);
 	inode = NULL;
@@ -1394,13 +1395,14 @@ static struct dentry *proc_pident_lookup
 	 * Yes, it does not scale. And it should not. Don't add
 	 * new entries into /proc/<tgid>/ without very good reasons.
 	 */
-	for (p = ents; p->name; p++) {
+	last = &ents[nents - 1];
+	for (p = ents; p <= last; p++) {
 		if (p->len != dentry->d_name.len)
 			continue;
 		if (!memcmp(dentry->d_name.name, p->name, p->len))
 			break;
 	}
-	if (!p->name)
+	if (p > last)
 		goto out;
 
 	error = proc_pident_instantiate(dir, dentry, task, p);
@@ -1426,7 +1428,7 @@ static int proc_pident_readdir(struct fi
 	struct dentry *dentry = filp->f_dentry;
 	struct inode *inode = dentry->d_inode;
 	struct task_struct *task = get_proc_task(inode);
-	struct pid_entry *p;
+	struct pid_entry *p, *last;
 	ino_t ino;
 	int ret;
 
@@ -1459,7 +1461,8 @@ static int proc_pident_readdir(struct fi
 			goto out;
 		}
 		p = ents + i;
-		while (p->name) {
+		last = &ents[nents - 1];
+		while (p <= last) {
 			if (proc_pident_fill_cache(filp, dirent, filldir, task, p) < 0)
 				goto out;
 			filp->f_pos++;
@@ -1556,7 +1559,6 @@ static struct pid_entry attr_dir_stuff[]
 	REG("fscreate",   S_IRUGO|S_IWUGO, pid_attr),
 	REG("keycreate",  S_IRUGO|S_IWUGO, pid_attr),
 	REG("sockcreate", S_IRUGO|S_IWUGO, pid_attr),
-	{}
 };
 
 static int proc_attr_dir_readdir(struct file * filp,
@@ -1574,7 +1576,8 @@ static struct file_operations proc_attr_
 static struct dentry *proc_attr_dir_lookup(struct inode *dir,
 				struct dentry *dentry, struct nameidata *nd)
 {
-	return proc_pident_lookup(dir, dentry, attr_dir_stuff);
+	return proc_pident_lookup(dir, dentry,
+				  attr_dir_stuff, ARRAY_SIZE(attr_dir_stuff));
 }
 
 static struct inode_operations proc_attr_dir_inode_operations = {
@@ -1618,7 +1621,6 @@ static struct inode_operations proc_self
 static struct pid_entry proc_base_stuff[] = {
 	NOD("self", S_IFLNK|S_IRWXUGO,
 		&proc_self_inode_operations, NULL, {}),
-	{}
 };
 
 /*
@@ -1695,7 +1697,7 @@ static struct dentry *proc_base_lookup(s
 {
 	struct dentry *error;
 	struct task_struct *task = get_proc_task(dir);
-	struct pid_entry *p;
+	struct pid_entry *p, *last;
 
 	error = ERR_PTR(-ENOENT);
 
@@ -1703,13 +1705,14 @@ static struct dentry *proc_base_lookup(s
 		goto out_no_task;
 
 	/* Lookup the directory entry */
-	for (p = proc_base_stuff; p->name; p++) {
+	last = &proc_base_stuff[ARRAY_SIZE(proc_base_stuff) - 1];
+	for (p = proc_base_stuff; p <= last; p++) {
 		if (p->len != dentry->d_name.len)
 			continue;
 		if (!memcmp(dentry->d_name.name, p->name, p->len))
 			break;
 	}
-	if (!p->name)
+	if (p > last)
 		goto out;
 
 	error = proc_base_instantiate(dir, dentry, task, p);
@@ -1775,7 +1778,6 @@ #endif
 #ifdef CONFIG_AUDITSYSCALL
 	REG("loginuid",   S_IWUSR|S_IRUGO, loginuid),
 #endif
-	{}
 };
 
 static int proc_tgid_base_readdir(struct file * filp,
@@ -1791,7 +1793,8 @@ static struct file_operations proc_tgid_
 };
 
 static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd){
-	return proc_pident_lookup(dir, dentry, tgid_base_stuff);
+	return proc_pident_lookup(dir, dentry,
+				  tgid_base_stuff, ARRAY_SIZE(tgid_base_stuff));
 }
 
 static struct inode_operations proc_tgid_base_inode_operations = {
@@ -1961,7 +1964,7 @@ retry:
 	return task;
 }
 
-#define TGID_OFFSET (FIRST_PROCESS_ENTRY + (ARRAY_SIZE(proc_base_stuff) - 1))
+#define TGID_OFFSET (FIRST_PROCESS_ENTRY + ARRAY_SIZE(proc_base_stuff))
 
 static int proc_pid_fill_cache(struct file *filp, void *dirent, filldir_t filldir,
 	struct task_struct *task, int tgid)
@@ -1983,7 +1986,7 @@ int proc_pid_readdir(struct file * filp,
 	if (!reaper)
 		goto out_no_task;
 
-	for (; nr < (ARRAY_SIZE(proc_base_stuff) - 1); filp->f_pos++, nr++) {
+	for (; nr < ARRAY_SIZE(proc_base_stuff); filp->f_pos++, nr++) {
 		struct pid_entry *p = &proc_base_stuff[nr];
 		if (proc_base_fill_cache(filp, dirent, filldir, reaper, p) < 0)
 			goto out;
@@ -2050,7 +2053,6 @@ #endif
 #ifdef CONFIG_AUDITSYSCALL
 	REG("loginuid",  S_IWUSR|S_IRUGO, loginuid),
 #endif
-	{}
 };
 
 static int proc_tid_base_readdir(struct file * filp,
@@ -2061,7 +2063,8 @@ static int proc_tid_base_readdir(struct 
 }
 
 static struct dentry *proc_tid_base_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd){
-	return proc_pident_lookup(dir, dentry, tid_base_stuff);
+	return proc_pident_lookup(dir, dentry,
+				  tid_base_stuff, ARRAY_SIZE(tid_base_stuff));
 }
 
 static struct file_operations proc_tid_base_operations = {
-- 
1.4.2.rc3.g7e18e-dirty

