Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbSLCQoM>; Tue, 3 Dec 2002 11:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSLCQoM>; Tue, 3 Dec 2002 11:44:12 -0500
Received: from verein.lst.de ([212.34.181.86]:32784 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261829AbSLCQoL>;
	Tue, 3 Dec 2002 11:44:11 -0500
Date: Tue, 3 Dec 2002 17:51:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mmuless targets can't support /proc/<pid>/maps
Message-ID: <20021203175139.A9965@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- 1.35/fs/proc/array.c	Mon Nov 25 23:42:29 2002
+++ edited/fs/proc/array.c	Tue Dec  3 14:55:22 2002
@@ -433,6 +433,7 @@
 		       size, resident, shared, text, lib, data, dirty);
 }
 
+#ifdef CONFIG_MMU
 /*
  * The way we support synthetic files > 4K
  * - without storing their contents in some buffer and
@@ -597,3 +598,4 @@
 out:
 	return retval;
 }
+#endif /* CONFIG_MMU */
--- 1.35/fs/proc/base.c	Tue Nov 26 20:29:39 2002
+++ edited/fs/proc/base.c	Tue Dec  3 14:55:14 2002
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
+		char *, size_t, loff_t *);
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
