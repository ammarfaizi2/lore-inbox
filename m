Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284927AbRLFBkf>; Wed, 5 Dec 2001 20:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284928AbRLFBk0>; Wed, 5 Dec 2001 20:40:26 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:10370 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284927AbRLFBkS>; Wed, 5 Dec 2001 20:40:18 -0500
Message-ID: <3C0ECB4F.1075340A@us.ibm.com>
Date: Wed, 05 Dec 2001 17:35:11 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux maillist account <l-k@mindspring.com>
CC: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: a nohup-like interface to cpu affinity
In-Reply-To: <5.0.2.1.2.20011126231737.009f0ec0@pop.mindspring.com>
	 <E16744i-0004zQ-00@localhost>
	 <Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain>
	 <1006472754.1336.0.camel@icbm>
	 <E16744i-0004zQ-00@localhost>
	 <5.0.2.1.2.20011126231737.009f0ec0@pop.mindspring.com> <5.0.2.1.2.20011127011901.009ebd30@pop.mindspring.com>
Content-Type: multipart/mixed;
 boundary="------------4BDFD612D7DB15AA0D5BF73A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4BDFD612D7DB15AA0D5BF73A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

In response (albeit a week plus late) to the recent hubbub about the cpu
affinity patches, I'd like to throw a third contender in the ring.

Attatched is a patch (against 2.4.16) which implements a /proc and a prctl()
interface to the cpus_allowed flag.  The truly exciting (at least for me) part
of this patch is the launch_policy flag that it also introduces.  The
launch_policy flag is used similarly to the cpus_allowed flag, but it controls
the cpus_allowed flags of any subsequent children of the process, instead of
the cpus_allowed of the process itself.  Via this flag, there are no worries
about processes being able to fork children before a 'chaff' or 'echo' or
anything else for that matter can be executed.  The child process is assigned
the desired cpus_allowed at fork/exec time.  All this without having to bounce
the current process to different cpus to (hopefully) acheive the same results.

The launch_policy flag can acually be quite powerful.  It allows for children
to be instantiated on the correct cpu/node with a minimum of memory footprint
on the wrong cpu/node.  This can be taken advantage of via the /proc interface
(for smp/numa unaware programs) or through prctl() for more clueful programs.

You must have CAP_SYS_NICE or be the owner of the process to change *either*
cpus_allowed or launch_policy.

I will momentarily be posting this patch in its own thread for greater
exposure.

Feedback of any kind will be greatly appreciated!

Enjoy!

-matt

Linux maillist account wrote:
> 
> At 11:49 PM 11/26/01 -0500, Robert Love wrote:
> >I can see the use for this, but you can also just do `echo whatever >
> >/proc/123/affinity' once it is running ... not a big deal.
> 
> It's isn't quite the same..the biggest difference is races.  The cpuselect(1)
> tool would change the affinity mask before the fork & exec of the first
> child.  To
> do this by hand via an `echo whatever >/proc/123/affinity' would miss all the
> children spun off by 123 before the echo could be executed.  One could write
> cpuselect as a shell script I suppose, using within it an echo on
> /proc/self/affinity,
> though even as a shell script it would be better to have this tool be part
> of the standard
> Linux repetoire that everyone could depend upon as being there in all Linux
> distributions
> and having a well known and unchanging syntax and semantics,  rather than
> have it
> remain something that each user creates ad-hoc as the need for the tool arises.
> 
> Joe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------4BDFD612D7DB15AA0D5BF73A
Content-Type: text/plain; charset=us-ascii;
 name="launch_policy-2.4.16.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="launch_policy-2.4.16.patch"

diff -Nur linux-2.4.10/fs/proc/array.c linux-2.4.10-launch_policy/fs/proc/array.c
--- linux-2.4.10/fs/proc/array.c	Fri Oct 26 15:07:16 2001
+++ linux-2.4.10-launch_policy/fs/proc/array.c	Wed Nov 28 13:59:58 2001
@@ -50,6 +50,10 @@
  * Al Viro & Jeff Garzik :  moved most of the thing into base.c and
  *			 :  proc_misc.c. The rest may eventually go into
  *			 :  base.c too.
+ *
+ * Andrew Morton     : cpus_allowed
+ *
+ * Matthew Dobson    : launch_policy (Thanks to Andrew Morton for inspiraton)
  */
 
 #include <linux/config.h>
@@ -344,7 +348,7 @@
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		task->pid,
 		task->comm,
 		state,
@@ -387,7 +391,9 @@
 		task->nswap,
 		task->cnswap,
 		task->exit_signal,
-		task->processor);
+		task->processor,
+		task->cpus_allowed,
+		task->launch_policy);
 	if(mm)
 		mmput(mm);
 	return res;
@@ -692,5 +698,59 @@
 			task->per_cpu_stime[cpu_logical_map(i)]);
 
 	return len;
+}
+
+static inline int proc_pid_cpu_bitmask_read(char * buffer, unsigned long *bitmask)
+{
+	int len;
+
+	len = sprintf(buffer, "%08lx\n", *bitmask);
+	return len;
+}
+
+static inline int proc_pid_cpu_bitmask_write(char * buffer, unsigned long *bitmask,
+					     size_t nbytes, struct task_struct *task)
+{
+	unsigned long new_mask;
+	char *endp;
+	int ret;
+	unsigned long flags;
+
+	ret = -EPERM;
+	if ((current->euid != task->euid) && (current->euid != task->uid) && 
+	    (!capable(CAP_SYS_NICE)))
+		goto out;
+
+	new_mask = simple_strtoul(buffer, &endp, 16);
+	ret = endp - buffer;
+
+	spin_lock_irqsave(&runqueue_lock, flags);	/* token effort to not be racy */
+	if (!(cpu_online_map & new_mask))
+		ret = -EINVAL;
+	else
+		*bitmask = new_mask;
+	spin_unlock_irqrestore(&runqueue_lock, flags);
+out:
+	return ret;
+}
+
+int proc_pid_cpus_allowed_read(struct task_struct *task, char * buffer)
+{
+	return proc_pid_cpu_bitmask_read(buffer, &task->cpus_allowed);
+}
+
+int proc_pid_cpus_allowed_write(struct task_struct *task, char * buffer, size_t nbytes)
+{
+	return proc_pid_cpu_bitmask_write(buffer, &task->cpus_allowed, nbytes, task);
+}
+
+int proc_pid_launch_policy_read(struct task_struct *task, char * buffer)
+{
+	return proc_pid_cpu_bitmask_read(buffer, &task->launch_policy);
+}
+
+int proc_pid_launch_policy_write(struct task_struct *task, char * buffer, size_t nbytes)
+{
+	return proc_pid_cpu_bitmask_write(buffer, &task->launch_policy, nbytes, task);
 }
 #endif
diff -Nur linux-2.4.10/fs/proc/base.c linux-2.4.10-launch_policy/fs/proc/base.c
--- linux-2.4.10/fs/proc/base.c	Fri Oct 26 15:07:16 2001
+++ linux-2.4.10-launch_policy/fs/proc/base.c	Wed Nov 28 14:00:20 2001
@@ -39,6 +39,10 @@
 int proc_pid_status(struct task_struct*,char*);
 int proc_pid_statm(struct task_struct*,char*);
 int proc_pid_cpu(struct task_struct*,char*);
+int proc_pid_cpus_allowed_read(struct task_struct*, char*);
+int proc_pid_cpus_allowed_write(struct task_struct*, char*, size_t);
+int proc_pid_launch_policy_read(struct task_struct*, char*);
+int proc_pid_launch_policy_write(struct task_struct*, char*, size_t);
 
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
@@ -282,8 +286,44 @@
 	return count;
 }
 
+static ssize_t proc_info_write(struct file * file, const char * buf,
+			  size_t count, loff_t *ppos)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+	unsigned long page;
+	ssize_t ret;
+	struct task_struct *task = inode->u.proc_i.task;
+
+	ret = -EINVAL;
+	if (inode->u.proc_i.op.proc_write == NULL)
+		goto out;
+	if (count > PAGE_SIZE - 1)
+		goto out;
+
+	ret = -ENOMEM;
+	if (!(page = __get_free_page(GFP_KERNEL)))
+		goto out;
+
+	ret = -EFAULT;
+	if (copy_from_user((char *)page, buf, count))
+		goto out_free_page;
+
+	((char *)page)[count] = '\0';
+	ret = inode->u.proc_i.op.proc_write(task, (char*)page, count);
+	if (ret < 0)
+		goto out_free_page;
+
+	*ppos += ret;
+
+out_free_page:
+	free_page(page);
+out:
+	return ret;
+}
+
 static struct file_operations proc_info_file_operations = {
 	read:		proc_info_read,
+	write:		proc_info_write,
 };
 
 #define MAY_PTRACE(p) \
@@ -497,25 +537,29 @@
 	PROC_PID_STATM,
 	PROC_PID_MAPS,
 	PROC_PID_CPU,
+	PROC_PID_CPUS_ALLOWED,
+	PROC_PID_LAUNCH_POLICY,
 	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
 
 #define E(type,name,mode) {(type),sizeof(name)-1,(name),(mode)}
 static struct pid_entry base_stuff[] = {
-  E(PROC_PID_FD,	"fd",		S_IFDIR|S_IRUSR|S_IXUSR),
-  E(PROC_PID_ENVIRON,	"environ",	S_IFREG|S_IRUSR),
-  E(PROC_PID_STATUS,	"status",	S_IFREG|S_IRUGO),
-  E(PROC_PID_CMDLINE,	"cmdline",	S_IFREG|S_IRUGO),
-  E(PROC_PID_STAT,	"stat",		S_IFREG|S_IRUGO),
-  E(PROC_PID_STATM,	"statm",	S_IFREG|S_IRUGO),
+  E(PROC_PID_FD,		"fd",		S_IFDIR|S_IRUSR|S_IXUSR),
+  E(PROC_PID_ENVIRON,		"environ",	S_IFREG|S_IRUSR),
+  E(PROC_PID_STATUS,		"status",	S_IFREG|S_IRUGO),
+  E(PROC_PID_CMDLINE,		"cmdline",	S_IFREG|S_IRUGO),
+  E(PROC_PID_STAT,		"stat",		S_IFREG|S_IRUGO),
+  E(PROC_PID_STATM,		"statm",	S_IFREG|S_IRUGO),
 #ifdef CONFIG_SMP
-  E(PROC_PID_CPU,	"cpu",		S_IFREG|S_IRUGO),
+  E(PROC_PID_CPU,		"cpu",		S_IFREG|S_IRUGO),
+  E(PROC_PID_CPUS_ALLOWED,	"cpus_allowed",	S_IFREG|S_IRUGO|S_IWUSR),
+  E(PROC_PID_LAUNCH_POLICY,	"launch_policy",S_IFREG|S_IRUGO|S_IWUSR),
 #endif
-  E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUGO),
-  E(PROC_PID_MEM,	"mem",		S_IFREG|S_IRUSR|S_IWUSR),
-  E(PROC_PID_CWD,	"cwd",		S_IFLNK|S_IRWXUGO),
-  E(PROC_PID_ROOT,	"root",		S_IFLNK|S_IRWXUGO),
-  E(PROC_PID_EXE,	"exe",		S_IFLNK|S_IRWXUGO),
+  E(PROC_PID_MAPS,		"maps",		S_IFREG|S_IRUGO),
+  E(PROC_PID_MEM,		"mem",		S_IFREG|S_IRUSR|S_IWUSR),
+  E(PROC_PID_CWD,		"cwd",		S_IFLNK|S_IRWXUGO),
+  E(PROC_PID_ROOT,		"root",		S_IFLNK|S_IRWXUGO),
+  E(PROC_PID_EXE,		"exe",		S_IFLNK|S_IRWXUGO),
   {0,0,NULL,0}
 };
 #undef E
@@ -869,6 +913,16 @@
 		case PROC_PID_CPU:
 			inode->i_fop = &proc_info_file_operations;
 			inode->u.proc_i.op.proc_read = proc_pid_cpu;
+			break;
+		case PROC_PID_CPUS_ALLOWED:
+			inode->i_fop = &proc_info_file_operations;
+			inode->u.proc_i.op.proc_read = proc_pid_cpus_allowed_read;
+			inode->u.proc_i.op.proc_write = proc_pid_cpus_allowed_write;
+			break;
+		case PROC_PID_LAUNCH_POLICY:
+			inode->i_fop = &proc_info_file_operations;
+			inode->u.proc_i.op.proc_read = proc_pid_launch_policy_read;
+			inode->u.proc_i.op.proc_write = proc_pid_launch_policy_write;
 			break;
 #endif
 		case PROC_PID_MEM:
diff -Nur linux-2.4.10/include/linux/capability.h linux-2.4.10-launch_policy/include/linux/capability.h
--- linux-2.4.10/include/linux/capability.h	Mon Nov 19 22:57:29 2001
+++ linux-2.4.10-launch_policy/include/linux/capability.h	Wed Nov 28 13:49:59 2001
@@ -243,6 +243,8 @@
 /* Allow use of FIFO and round-robin (realtime) scheduling on own
    processes and setting the scheduling algorithm used by another
    process. */
+/* Allow binding of tasks to CPUs */
+/* Allow setting of launch policies */
 
 #define CAP_SYS_NICE         23
 
diff -Nur linux-2.4.10/include/linux/prctl.h linux-2.4.10-launch_policy/include/linux/prctl.h
--- linux-2.4.10/include/linux/prctl.h	Thu Jul 19 20:39:57 2001
+++ linux-2.4.10-launch_policy/include/linux/prctl.h	Mon Nov 19 15:24:10 2001
@@ -20,4 +20,12 @@
 #define PR_GET_KEEPCAPS   7
 #define PR_SET_KEEPCAPS   8
 
+/* Get/set cpus allowed */
+#define PR_GET_CPUS_ALLOWED 13
+#define PR_SET_CPUS_ALLOWED 14
+
+/* Get/set launch policies */
+#define PR_GET_LAUNCH_POLICY 15
+#define PR_SET_LAUNCH_POLICY 16
+
 #endif /* _LINUX_PRCTL_H */
diff -Nur linux-2.4.10/include/linux/proc_fs_i.h linux-2.4.10-launch_policy/include/linux/proc_fs_i.h
--- linux-2.4.10/include/linux/proc_fs_i.h	Fri Oct 26 15:07:16 2001
+++ linux-2.4.10-launch_policy/include/linux/proc_fs_i.h	Wed Oct 17 14:18:53 2001
@@ -1,9 +1,10 @@
 struct proc_inode_info {
 	struct task_struct *task;
 	int type;
-	union {
+	struct {
 		int (*proc_get_link)(struct inode *, struct dentry **, struct vfsmount **);
 		int (*proc_read)(struct task_struct *task, char *page);
+		int (*proc_write)(struct task_struct *task, char *page, size_t nbytes);
 	} op;
 	struct file *file;
 };
diff -Nur linux-2.4.10/include/linux/sched.h linux-2.4.10-launch_policy/include/linux/sched.h
--- linux-2.4.10/include/linux/sched.h	Mon Nov 19 22:57:29 2001
+++ linux-2.4.10-launch_policy/include/linux/sched.h	Mon Nov 19 15:27:40 2001
@@ -352,6 +352,7 @@
 	struct task_struct *pidhash_next;
 	struct task_struct **pidhash_pprev;
 
+	unsigned long launch_policy;            /* for *fork*() & exec() */
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
 	unsigned long rt_priority;
@@ -480,6 +481,7 @@
     p_opptr:		&tsk,						\
     p_pptr:		&tsk,						\
     thread_group:	LIST_HEAD_INIT(tsk.thread_group),		\
+    launch_policy:	-1,						\
     wait_chldexit:	__WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
     real_timer:		{						\
 	function:		it_real_fn				\
diff -Nur linux-2.4.10/kernel/fork.c linux-2.4.10-launch_policy/kernel/fork.c
--- linux-2.4.10/kernel/fork.c	Mon Sep 17 21:46:04 2001
+++ linux-2.4.10-launch_policy/kernel/fork.c	Wed Oct 24 15:55:55 2001
@@ -646,6 +646,7 @@
 		spin_lock_init(&p->sigmask_lock);
 	}
 #endif
+	p->cpus_allowed = p->launch_policy; /* launch_policy is inherited from parent */
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = jiffies;
 
diff -Nur linux-2.4.10/kernel/sys.c linux-2.4.10-launch_policy/kernel/sys.c
--- linux-2.4.10/kernel/sys.c	Tue Sep 18 14:10:43 2001
+++ linux-2.4.10-launch_policy/kernel/sys.c	Wed Nov 28 14:13:20 2001
@@ -1256,6 +1256,27 @@
 			}
 			current->keep_capabilities = arg2;
 			break;
+		case PR_GET_CPUS_ALLOWED:
+			error = put_user(current->cpus_allowed, (long *)arg2);
+			break;
+		case PR_SET_CPUS_ALLOWED:
+			if (!(cpu_online_map & arg2))
+				error = -EINVAL;
+			else {
+				current->cpus_allowed = arg2;
+				if (!((1 << smp_processor_id()) & arg2))
+					current->need_resched = 1;
+			}
+			break;
+		case PR_GET_LAUNCH_POLICY:
+			error = put_user(current->launch_policy, (long *)arg2);
+			break;
+		case PR_SET_LAUNCH_POLICY:
+			if (!(cpu_online_map & arg2))
+				error = -EINVAL;
+			else
+				current->launch_policy = arg2;
+			break;
 		default:
 			error = -EINVAL;
 			break;

--------------4BDFD612D7DB15AA0D5BF73A--

