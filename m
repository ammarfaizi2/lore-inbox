Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314697AbSDTR5P>; Sat, 20 Apr 2002 13:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314698AbSDTR5P>; Sat, 20 Apr 2002 13:57:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49091 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314697AbSDTR5M>;
	Sat, 20 Apr 2002 13:57:12 -0400
Date: Sat, 20 Apr 2002 13:57:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [CFT][PATCH] (2/5) sane procfs/dcache interaction
In-Reply-To: <Pine.GSO.4.21.0204201304150.25383-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0204201356480.25383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -urN C8-unhash_process/fs/proc/base.c C8-name_to_int/fs/proc/base.c
--- C8-unhash_process/fs/proc/base.c	Tue Mar 19 16:05:58 2002
+++ C8-name_to_int/fs/proc/base.c	Fri Apr 19 01:17:11 2002
@@ -778,34 +778,41 @@
 };
 
 /* Lookups */
-#define MAX_MULBY10	((~0U-9)/10)
+
+static unsigned name_to_int(struct dentry *dentry)
+{
+	const char *name = dentry->d_name.name;
+	int len = dentry->d_name.len;
+	unsigned n = 0;
+
+	if (len > 1 && *name == '0')
+		goto out;
+	while (len-- > 0) {
+		unsigned c = *name++ - '0';
+		if (c > 9)
+			goto out;
+		if (n >= (~0U-9)/10)
+			goto out;
+		n *= 10;
+		n += c;
+	}
+	return n;
+out:
+	return ~0U;
+}
 
 /* SMP-safe */
 static struct dentry *proc_lookupfd(struct inode * dir, struct dentry * dentry)
 {
-	unsigned int fd, c;
 	struct task_struct *task = proc_task(dir);
+	unsigned fd = name_to_int(dentry);
 	struct file * file;
 	struct files_struct * files;
 	struct inode *inode;
 	struct proc_inode *ei;
-	const char *name;
-	int len;
 
-	fd = 0;
-	len = dentry->d_name.len;
-	name = dentry->d_name.name;
-	if (len > 1 && *name == '0') goto out;
-	while (len-- > 0) {
-		c = *name - '0';
-		name++;
-		if (c > 9)
-			goto out;
-		if (fd >= MAX_MULBY10)
-			goto out;
-		fd *= 10;
-		fd += c;
-	}
+	if (fd == ~0U)
+		goto out;
 
 	inode = proc_pid_make_inode(dir->i_sb, task, PROC_PID_FD_DIR+fd);
 	if (!inode)
@@ -992,17 +999,12 @@
 /* SMP-safe */
 struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry)
 {
-	unsigned int pid, c;
 	struct task_struct *task;
-	const char *name;
 	struct inode *inode;
 	struct proc_inode *ei;
-	int len;
+	unsigned pid;
 
-	pid = 0;
-	name = dentry->d_name.name;
-	len = dentry->d_name.len;
-	if (len == 4 && !memcmp(name, "self", 4)) {
+	if (dentry->d_name.len == 4 && !memcmp(dentry->d_name.name,"self",4)) {
 		inode = new_inode(dir->i_sb);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
@@ -1017,18 +1019,9 @@
 		d_add(dentry, inode);
 		return NULL;
 	}
-	while (len-- > 0) {
-		c = *name - '0';
-		name++;
-		if (c > 9)
-			goto out;
-		if (pid >= MAX_MULBY10)
-			goto out;
-		pid *= 10;
-		pid += c;
-		if (!pid)
-			goto out;
-	}
+	pid = name_to_int(dentry);
+	if (pid == ~0U)
+		goto out;
 
 	read_lock(&tasklist_lock);
 	task = find_task_by_pid(pid);


