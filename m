Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUDJPFf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 11:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUDJPFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 11:05:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21515 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262049AbUDJPFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 11:05:13 -0400
Date: Sat, 10 Apr 2004 16:05:09 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] get_files_struct
Message-ID: <20040410160509.D4221@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the 4 duplicate "get_files_struct" implementations into one
get_files_struct() function to compliment put_files_struct().

I'm not particularly bothered about this patch; it builds and works
for me, though I don't have a particular reason to keep it around.

It may be useful for the -tiny tree.

Whatever, if someone thinks its useful...

--- orig/fs/proc/base.c	Thu Mar  4 13:25:39 2004
+++ linux/fs/proc/base.c	Sat Apr 10 15:55:16 2004
@@ -189,11 +189,7 @@ static int proc_fd_link(struct inode *in
 	struct file *file;
 	int fd = proc_type(inode) - PROC_TID_FD_DIR;
 
-	task_lock(task);
-	files = task->files;
-	if (files)
-		atomic_inc(&files->count);
-	task_unlock(task);
+	files = get_files_struct(task);
 	if (files) {
 		spin_lock(&files->file_lock);
 		file = fcheck_files(files, fd);
@@ -806,11 +802,7 @@ static int proc_readfd(struct file * fil
 				goto out;
 			filp->f_pos++;
 		default:
-			task_lock(p);
-			files = p->files;
-			if (files)
-				atomic_inc(&files->count);
-			task_unlock(p);
+			files = get_files_struct(p);
 			if (!files)
 				goto out;
 			spin_lock(&files->file_lock);
@@ -1009,11 +1001,7 @@ static int tid_fd_revalidate(struct dent
 	int fd = proc_type(inode) - PROC_TID_FD_DIR;
 	struct files_struct *files;
 
-	task_lock(task);
-	files = task->files;
-	if (files)
-		atomic_inc(&files->count);
-	task_unlock(task);
+	files = get_files_struct(task);
 	if (files) {
 		spin_lock(&files->file_lock);
 		if (fcheck_files(files, fd)) {
@@ -1117,11 +1105,7 @@ static struct dentry *proc_lookupfd(stru
 	if (!inode)
 		goto out;
 	ei = PROC_I(inode);
-	task_lock(task);
-	files = task->files;
-	if (files)
-		atomic_inc(&files->count);
-	task_unlock(task);
+	files = get_files_struct(task);
 	if (!files)
 		goto out_unlock;
 	inode->i_mode = S_IFLNK;
--- orig/kernel/exit.c	Sat Mar 20 09:22:54 2004
+++ linux/kernel/exit.c	Sat Apr 10 15:54:00 2004
@@ -386,6 +386,19 @@ static inline void close_files(struct fi
 	}
 }
 
+struct files_struct *get_files_struct(struct task_struct *task)
+{
+	struct files_struct *files;
+
+	task_lock(task);
+	files = task->files;
+	if (files)
+		atomic_inc(&files->count);
+	task_unlock(task);
+
+	return files;
+}
+
 void fastcall put_files_struct(struct files_struct *files)
 {
 	if (atomic_dec_and_test(&files->count)) {
--- orig/include/linux/file.h	Tue May 27 10:05:40 2003
+++ linux/include/linux/file.h	Sat Apr 10 15:56:58 2004
@@ -75,6 +75,10 @@ static inline struct file * fcheck_files
 #define fcheck(fd)	fcheck_files(current->files, fd)
 
 extern void FASTCALL(fd_install(unsigned int fd, struct file * file));
+
+struct task_struct;
+
+struct files_struct *get_files_struct(struct task_struct *);
 void FASTCALL(put_files_struct(struct files_struct *fs));
 
 #endif /* __LINUX_FILE_H */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
