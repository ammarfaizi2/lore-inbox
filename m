Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSLUVlh>; Sat, 21 Dec 2002 16:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSLUVlh>; Sat, 21 Dec 2002 16:41:37 -0500
Received: from verein.lst.de ([212.34.181.86]:32009 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S265097AbSLUVlf>;
	Sat, 21 Dec 2002 16:41:35 -0500
Date: Sat, 21 Dec 2002 22:49:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mmuless ports can't support /proc/<pid>/maps
Message-ID: <20021221224926.A17029@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the same approach as /proc/<pid>/wchan vs CONFIG_KALLSYSM.


--- 1.35/fs/proc/array.c	Mon Nov 25 17:42:29 2002
+++ edited/fs/proc/array.c	Tue Dec 17 23:07:37 2002
@@ -513,8 +513,9 @@
 	return len;
 }
 
-ssize_t proc_pid_read_maps (struct task_struct *task, struct file * file, char * buf,
-			  size_t count, loff_t *ppos)
+#ifdef CONFIG_MMU
+ssize_t proc_pid_read_maps(struct task_struct *task, struct file *file,
+			   char *buf, size_t count, loff_t *ppos)
 {
 	struct mm_struct *mm;
 	struct vm_area_struct * map;
@@ -597,3 +598,4 @@
 out:
 	return retval;
 }
+#endif /* CONFIG_MMU */
===== fs/proc/base.c 1.35 vs edited =====
--- 1.35/fs/proc/base.c	Tue Nov 26 14:29:39 2002
+++ edited/fs/proc/base.c	Tue Dec 17 23:09:41 2002
@@ -75,7 +75,9 @@
   E(PROC_PID_CMDLINE,	"cmdline",	S_IFREG|S_IRUGO),
   E(PROC_PID_STAT,	"stat",		S_IFREG|S_IRUGO),
   E(PROC_PID_STATM,	"statm",	S_IFREG|S_IRUGO),
+#ifdef CONFIG_MMU
   E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUGO),
+#endif
   E(PROC_PID_MEM,	"mem",		S_IFREG|S_IRUSR|S_IWUSR),
   E(PROC_PID_CWD,	"cwd",		S_IFLNK|S_IRWXUGO),
   E(PROC_PID_ROOT,	"root",		S_IFLNK|S_IRWXUGO),
@@ -98,7 +100,6 @@
 	return PROC_I(inode)->type;
 }
 
-ssize_t proc_pid_read_maps(struct task_struct*,struct file*,char*,size_t,loff_t*);
 int proc_pid_stat(struct task_struct*,char*);
 int proc_pid_status(struct task_struct*,char*);
 int proc_pid_statm(struct task_struct*,char*);
@@ -321,6 +322,9 @@
 	return proc_check_root(inode);
 }
 
+#ifdef CONFIG_MMU
+extern ssize_t proc_pid_read_maps(struct task_struct *, struct file *,
+				  char *, size_t, loff_t *);
 static ssize_t pid_maps_read(struct file * file, char * buf,
 			      size_t count, loff_t *ppos)
 {
@@ -335,6 +339,7 @@
 static struct file_operations proc_maps_operations = {
 	.read		= pid_maps_read,
 };
+#endif /* CONFIG_MMU */
 
 extern struct seq_operations mounts_op;
 static int mounts_open(struct inode *inode, struct file *file)
@@ -1023,10 +1028,11 @@
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_statm;
 			break;
+#ifdef CONFIG_MMU
 		case PROC_PID_MAPS:
 			inode->i_fop = &proc_maps_operations;
 			break;
-
+#endif
 		case PROC_PID_MEM:
 			inode->i_op = &proc_mem_inode_operations;
 			inode->i_fop = &proc_mem_operations;
