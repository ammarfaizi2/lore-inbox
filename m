Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292843AbSB0XiK>; Wed, 27 Feb 2002 18:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293050AbSB0Xfp>; Wed, 27 Feb 2002 18:35:45 -0500
Received: from zero.tech9.net ([209.61.188.187]:42246 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292464AbSB0Xeg>;
	Wed, 27 Feb 2002 18:34:36 -0500
Subject: [PATCH] 2.5: proc interface for setting task affinity
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 27 Feb 2002 18:34:41 -0500
Message-Id: <1014852882.1109.218.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch implements a proc-based user interface for setting
and retrieving a task's CPU affinity (task->cpus_allowed).

To retrieve <pid>'s affinity:

	cat /proc/<pid>/affinity

and to set it:

	echo n > /proc/<pid>/affinity

Essentially the debate is over, I have been fairly well convinced a
syscall solution is superior.  I do note, however, the beauty in the
above solution.  I have posted a syscall implementation as well, in
another thread, but post this for completeness.

This patch uses set_cpus_allowed in Ingo's new scheduler to do the heavy
work.  It is based off my previous patch which borrowed heavily from
Ingo's previous affinity patch.

Security is enforced: user must possess CAP_SYS_NICE or be the same uid
or euid of the pid in question.  This patch also implements a proc_write
method for the proc_pid code - it adds to the patches size, but the
method is reusable.

Patch is against 2.5.6-pre1.  Enjoy,

	Robert Love

diff -urN linus/Documentation/filesystems/proc.txt linux/Documentation/filesystems/proc.txt
--- linus/Documentation/filesystems/proc.txt	Wed Feb 27 00:33:04 2002
+++ linux/Documentation/filesystems/proc.txt	Tue Feb 26 19:28:00 2002
@@ -118,6 +118,7 @@
 Table 1-1: Process specific entries in /proc 
 ..............................................................................
  File    Content                                        
+ affinity Writable bitmask of allowed CPUs			(2.5)(smp)
  cmdline Command line arguments                         
  cpu	 Current and last cpu in wich it was executed		(2.4)(smp)
  cwd	 Link to the current working directory
@@ -159,12 +160,17 @@
   CapPrm: 0000000000000000 
   CapEff: 0000000000000000 
 
-
 This shows you nearly the same information you would get if you viewed it with
 the ps  command.  In  fact,  ps  uses  the  proc  file  system  to  obtain its
 information. The  statm  file  contains  more  detailed  information about the
 process memory usage. Its seven fields are explained in Table 1-2.
 
+For writable entries, such as affinity:
+
+ >echo 1 > /proc/PID/affinity
+
+To set the affinity of PID to 0x00000001 (=> only CPU0).
+
 
 Table 1-2: Contents of the statm files 
 ..............................................................................
diff -urN linus/fs/proc/array.c linux/fs/proc/array.c
--- linus/fs/proc/array.c	Wed Feb 27 00:33:04 2002
+++ linux/fs/proc/array.c	Wed Feb 27 17:24:53 2002
@@ -47,9 +47,11 @@
  * Gerhard Wichert   :  added BIGMEM support
  * Siemens AG           <Gerhard.Wichert@pdb.siemens.de>
  *
- * Al Viro & Jeff Garzik :  moved most of the thing into base.c and
- *			 :  proc_misc.c. The rest may eventually go into
- *			 :  base.c too.
+ * Al Viro &         :  moved most of the thing into base.c and
+ * Jeff Garzik          proc_misc.c. The rest may eventually go into
+ *                      base.c too.
+ *
+ * Robert Love       :  added affinity (get/set task->cpus_allowed)
  */
 
 #include <linux/config.h>
@@ -695,4 +697,37 @@
 
 	return len;
 }
-#endif
+
+int proc_pid_affinity_read(struct task_struct *task, char * buffer)
+{
+	return sprintf(buffer, "%08lx\n", task->cpus_allowed & cpu_online_map);
+}
+
+int proc_pid_affinity_write(struct task_struct *task, char *buffer,
+			    size_t bytes)
+{
+	int retval;
+	unsigned long new_mask;
+	char *end;
+
+	new_mask = simple_strtoul(buffer, &end, 16);
+	new_mask &= cpu_online_map;
+	if (!new_mask)
+		return -EINVAL;
+
+	read_lock(&tasklist_lock);
+
+	if ((current->euid != task->euid) && (current->euid != task->uid)
+			&& !capable(CAP_SYS_NICE)) {
+		retval = -EPERM;
+		goto out_unlock;
+	}
+
+	retval = end - buffer;
+	set_cpus_allowed(task, new_mask);
+
+out_unlock:
+	read_unlock(&tasklist_lock);
+	return retval;
+}
+#endif /* CONFIG_SMP */
diff -urN linus/fs/proc/base.c linux/fs/proc/base.c
--- linus/fs/proc/base.c	Wed Feb 27 00:33:04 2002
+++ linux/fs/proc/base.c	Wed Feb 27 17:18:25 2002
@@ -47,6 +47,8 @@
 int proc_pid_status(struct task_struct*,char*);
 int proc_pid_statm(struct task_struct*,char*);
 int proc_pid_cpu(struct task_struct*,char*);
+int proc_pid_affinity_read(struct task_struct*,char*);
+int proc_pid_affinity_write(struct task_struct*,char*,size_t);
 
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
@@ -331,8 +333,44 @@
 	return count;
 }
 
+static ssize_t proc_info_write(struct file * file, const char * buf,
+			       size_t count, loff_t *ppos)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+	unsigned long page;
+	struct task_struct *task = proc_task(inode);
+	struct proc_inode *ei = PROC_I(inode);
+	ssize_t ret;
+	if (ei->op.proc_write == NULL)
+		return -EINVAL;
+
+	if (count > PAGE_SIZE - 1)
+		return -EINVAL;
+
+	if (!(page = __get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+
+	if (copy_from_user((char *) page, buf, count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	((char *) page)[count] = '\0';
+
+	ret = ei->op.proc_write(task, (char*) page, count);
+	if (ret < 0)
+		goto out;
+
+	*ppos += ret;
+
+out:
+	free_page(page);
+	return ret;
+}
+
 static struct file_operations proc_info_file_operations = {
 	read:		proc_info_read,
+	write:		proc_info_write
 };
 
 #define MAY_PTRACE(p) \
@@ -546,6 +584,7 @@
 	PROC_PID_STATM,
 	PROC_PID_MAPS,
 	PROC_PID_CPU,
+	PROC_PID_AFFINITY,
 	PROC_PID_MOUNTS,
 	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
@@ -560,6 +599,7 @@
   E(PROC_PID_STATM,	"statm",	S_IFREG|S_IRUGO),
 #ifdef CONFIG_SMP
   E(PROC_PID_CPU,	"cpu",		S_IFREG|S_IRUGO),
+  E(PROC_PID_AFFINITY,	"affinity",	S_IFREG|S_IRUGO|S_IWUSR),
 #endif
   E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUGO),
   E(PROC_PID_MEM,	"mem",		S_IFREG|S_IRUSR|S_IWUSR),
@@ -936,6 +976,11 @@
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_cpu;
 			break;
+		case PROC_PID_AFFINITY:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_affinity_read;
+			ei->op.proc_write = proc_pid_affinity_write;
+ 			break;
 #endif
 		case PROC_PID_MEM:
 			inode->i_op = &proc_mem_inode_operations;
diff -urN linus/include/linux/capability.h linux/include/linux/capability.h
--- linus/include/linux/capability.h	Wed Feb 27 00:33:04 2002
+++ linux/include/linux/capability.h	Wed Feb 27 16:37:33 2002
@@ -242,6 +242,7 @@
 /* Allow use of FIFO and round-robin (realtime) scheduling on own
    processes and setting the scheduling algorithm used by another
    process. */
+/* Allow setting CPU affinity */
 
 #define CAP_SYS_NICE         23
 
diff -urN linus/include/linux/proc_fs.h linux/include/linux/proc_fs.h
--- linus/include/linux/proc_fs.h	Wed Feb 27 00:33:04 2002
+++ linux/include/linux/proc_fs.h	Wed Feb 27 16:37:41 2002
@@ -208,9 +208,10 @@
 struct proc_inode {
 	struct task_struct *task;
 	int type;
-	union {
+	struct {
 		int (*proc_get_link)(struct inode *, struct dentry **, struct vfsmount **);
 		int (*proc_read)(struct task_struct *task, char *page);
+		int (*proc_write)(struct task_struct *task, char *page, size_t bytes);
 	} op;
 	struct file *file;
 	struct proc_dir_entry *pde;

