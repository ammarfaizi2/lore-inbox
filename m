Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282768AbRK0Dbe>; Mon, 26 Nov 2001 22:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282770AbRK0DbX>; Mon, 26 Nov 2001 22:31:23 -0500
Received: from zero.tech9.net ([209.61.188.187]:32265 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282768AbRK0DbN>;
	Mon, 26 Nov 2001 22:31:13 -0500
Subject: [PATCH] proc-based cpu affinity user interface
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-GdmInKlwJ7bKjTEVrNV7"
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 26 Nov 2001 22:31:41 -0500
Message-Id: <1006831902.842.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GdmInKlwJ7bKjTEVrNV7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is my procfs-based implementation of a user interface for
getting and setting a task's CPU affinity.  Patch is against 2.4.16. 

The kernel already respects affinity, which is stored in
task_struct->cpus_allowed. 

Reading and writing /proc/<pid>/affinity will get and set the affinity.

Security is implemented: the writer must possess CAP_SYS_NICE or be the
same uid as the task in question.  Anyone can read the data.

The read mask will be ANDed with cpu_online_map, so that only valid bits
are returned.  The written data must have _some_ valid bits in it. 
I.e., ffffffff is valid on a 2-way system but 01000000 probably is not. 
Note you don't need to pass the full mask, e.g. "64" is legal.  When a
new mask is set, a reschedule is forced to put the task on a legal CPU. 

Note I had to implement a proc_write function for the procfs (pid)
code.  This is generic and can be used by other, writable, entries. 

This patch comes as an alternative to Ingo Molnar's syscall-implemented
variant.  Ingo's code is good; however I and others expressed discontent
at yet another group of syscalls.  Other benefits include the ease with
which to set the affinity of tasks that are unaware of the new interface
and that with this approach applications don't need to check for the
existence of a syscall. 

Comments? 

	Robert Love

--=-GdmInKlwJ7bKjTEVrNV7
Content-Disposition: attachment; filename=cpu-affinity-rml-2.4.16-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ISO-8859-1

diff -urN linux-2.4.16/fs/proc/array.c linux/fs/proc/array.c
--- linux-2.4.16/fs/proc/array.c	Mon Nov 26 15:56:17 2001
+++ linux/fs/proc/array.c	Mon Nov 26 21:37:02 2001
@@ -50,6 +50,8 @@
  * Al Viro & Jeff Garzik :  moved most of the thing into base.c and
  *			 :  proc_misc.c. The rest may eventually go into
  *			 :  base.c too.
+ *
+ * Robert Love	     :	added affinity (set processes's CPU affinity)
  */
=20
 #include <linux/config.h>
@@ -693,4 +695,64 @@
=20
 	return len;
 }
-#endif
+
+int proc_pid_affinity_read(struct task_struct *task, char * buffer)
+{
+	int len;
+
+	/*
+	 * AND the mask against the current CPU configuration to return
+	 * only valid bits
+	 */
+	len =3D sprintf(buffer, "%08lx\n", task->cpus_allowed & cpu_online_map);
+	return len;
+}
+
+int proc_pid_affinity_write(struct task_struct *task, char * buffer,
+		size_t bytes)
+{
+	unsigned long new_mask;
+	int reschedule =3D 0;
+	char * endp;
+
+	if ((current->euid !=3D task->euid) && (current->euid !=3D task->uid)
+			&& !capable(CAP_SYS_NICE))
+		return -EPERM;
+
+	new_mask =3D simple_strtoul(buffer, &endp, 16);
+
+	new_mask &=3D cpu_online_map;
+	if (!new_mask)
+		return -EINVAL;
+
+	read_lock_irq(&tasklist_lock);
+	spin_lock(&runqueue_lock);
+
+	task->cpus_allowed =3D new_mask;
+
+	/*
+	 * if running on a different CPU, cause a reschedule
+	 * to move the process to an allowed CPU
+	 */
+	if (!(task->cpus_runnable & task->cpus_allowed)) {
+		if (task =3D=3D current)
+			reschedule =3D 1;
+		else {
+			task->need_resched =3D 1;
+			smp_send_reschedule(task->processor);
+		}
+	}
+
+	spin_unlock(&runqueue_lock);
+	read_unlock_irq(&tasklist_lock);
+
+	/*
+	 * if the task is on this CPU, wait to reschedule
+	 * it until we drop the locks
+	 */
+	if (reschedule)
+		schedule();
+
+	return endp - buffer;
+}
+#endif /* CONFIG_SMP */
diff -urN linux-2.4.16/fs/proc/base.c linux/fs/proc/base.c
--- linux-2.4.16/fs/proc/base.c	Mon Nov 26 15:56:17 2001
+++ linux/fs/proc/base.c	Mon Nov 26 21:39:28 2001
@@ -39,6 +39,8 @@
 int proc_pid_status(struct task_struct*,char*);
 int proc_pid_statm(struct task_struct*,char*);
 int proc_pid_cpu(struct task_struct*,char*);
+int proc_pid_affinity_read(struct task_struct*,char*);
+int proc_pid_affinity_write(struct task_struct*,char*,size_t);
=20
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struc=
t vfsmount **mnt)
 {
@@ -282,8 +284,44 @@
 	return count;
 }
=20
+static ssize_t proc_info_write(struct file * file, const char * buf,
+			size_t count, loff_t *ppos)
+{
+	struct inode * inode =3D file->f_dentry->d_inode;
+	unsigned long page;
+	ssize_t ret;
+	struct task_struct *task =3D inode->u.proc_i.task;
+
+	if (inode->u.proc_i.op.proc_write =3D=3D NULL)
+		return -EINVAL;
+
+	if (count > PAGE_SIZE - 1)
+		return -EINVAL;
+
+	if (!(page =3D __get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+
+	if (copy_from_user((char *)page, buf, count)) {
+		free_page(page);
+		return -EFAULT;
+	}
+
+	((char *) page)[count] =3D '\0';
+	ret =3D inode->u.proc_i.op.proc_write(task, (char*) page, count);
+	if (ret < 0) {
+		free_page(page);
+		return -EFAULT;
+	}
+
+	*ppos +=3D ret;
+
+	free_page(page);
+	return ret;
+}
+
 static struct file_operations proc_info_file_operations =3D {
 	read:		proc_info_read,
+	write:		proc_info_write,
 };
=20
 #define MAY_PTRACE(p) \
@@ -497,6 +535,7 @@
 	PROC_PID_STATM,
 	PROC_PID_MAPS,
 	PROC_PID_CPU,
+	PROC_PID_AFFINITY,
 	PROC_PID_FD_DIR =3D 0x8000,	/* 0x8000-0xffff */
 };
=20
@@ -510,6 +549,7 @@
   E(PROC_PID_STATM,	"statm",	S_IFREG|S_IRUGO),
 #ifdef CONFIG_SMP
   E(PROC_PID_CPU,	"cpu",		S_IFREG|S_IRUGO),
+  E(PROC_PID_AFFINITY,	"affinity",	S_IFREG|S_IRUGO|S_IWUSR),
 #endif
   E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUGO),
   E(PROC_PID_MEM,	"mem",		S_IFREG|S_IRUSR|S_IWUSR),
@@ -870,6 +910,11 @@
 			inode->i_fop =3D &proc_info_file_operations;
 			inode->u.proc_i.op.proc_read =3D proc_pid_cpu;
 			break;
+		case PROC_PID_AFFINITY:
+			inode->i_fop =3D &proc_info_file_operations;
+			inode->u.proc_i.op.proc_read =3D proc_pid_affinity_read;
+			inode->u.proc_i.op.proc_write =3D proc_pid_affinity_write;
+ 			break;
 #endif
 		case PROC_PID_MEM:
 			inode->i_op =3D &proc_mem_inode_operations;
diff -urN linux-2.4.16/include/linux/capability.h linux/include/linux/capab=
ility.h
--- linux-2.4.16/include/linux/capability.h	Mon Nov 26 15:56:21 2001
+++ linux/include/linux/capability.h	Mon Nov 26 19:36:51 2001
@@ -243,6 +243,7 @@
 /* Allow use of FIFO and round-robin (realtime) scheduling on own
    processes and setting the scheduling algorithm used by another
    process. */
+/* Allow setting CPU affinity */
=20
 #define CAP_SYS_NICE         23
=20
diff -urN linux-2.4.16/include/linux/proc_fs_i.h linux/include/linux/proc_f=
s_i.h
--- linux-2.4.16/include/linux/proc_fs_i.h	Mon Nov 26 15:56:21 2001
+++ linux/include/linux/proc_fs_i.h	Mon Nov 26 21:41:24 2001
@@ -1,9 +1,11 @@
 struct proc_inode_info {
 	struct task_struct *task;
 	int type;
-	union {
+	struct {
 		int (*proc_get_link)(struct inode *, struct dentry **, struct vfsmount *=
*);
 		int (*proc_read)(struct task_struct *task, char *page);
+		int (*proc_write)(struct task_struct *task, char *page,
+				  size_t bytes);
 	} op;
 	struct file *file;
 };

--=-GdmInKlwJ7bKjTEVrNV7--

