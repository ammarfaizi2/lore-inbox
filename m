Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSDVTeM>; Mon, 22 Apr 2002 15:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314662AbSDVTeL>; Mon, 22 Apr 2002 15:34:11 -0400
Received: from zero.tech9.net ([209.61.188.187]:25098 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314548AbSDVTeJ>;
	Mon, 22 Apr 2002 15:34:09 -0400
Subject: [PATCH][RFC] task cpu affinity syscalls for 2.4-O(1)
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 22 Apr 2002 15:34:13 -0400
Message-Id: <1019504054.939.108.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch implements the 2.5 task affinity syscalls on top of the
2.4 O(1) scheduler patches I recently posted.  We can implement these
now since 2.4's O(1) scheduler now has the migration_thread. 
Previously, the 2.4 patches I did only worked on the "stock" scheduler.

I have a request for comments:

The locking is no good in this patch.  set_cpus_allowed is not atomic
and it is certainly not safe to hold a spinlock across a call to it. 
However, before we call set_cpus_allowed we need a valid reference to
the task and assurance the task won't slip away out from under us.

So you say "ah grab tasklist_lock" but we can't hold it across
set_cpus_allowed.  In 2.5, we solve this by bumping the task_struct's
usage count via get_task_struct - this assures us at least the
task_struct will not go anywhere until we put_task_struct.  We have no
such luxury in 2.4...

In this patch, we grab tasklist_lock.  My testing isn't showing any
deadlocks, so feel free to play, but this approach is not safe.

Any ideas of a how to (a) assure a task is valid and will remain so
through a call to set_cpus_allowed, (b) do (a) without a spinlock?

	Robert Love

diff -urN linux-O1/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-O1/arch/i386/kernel/entry.S	Mon Apr 22 15:22:10 2002
+++ linux/arch/i386/kernel/entry.S	Mon Apr 22 15:23:14 2002
@@ -639,8 +639,8 @@
  	.long SYMBOL_NAME(sys_tkill)
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sendfile64 */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* 240 reserved for futex */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sched_setaffinity */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sched_getaffinity */
+	.long SYMBOL_NAME(sys_sched_setaffinity)
+	.long SYMBOL_NAME(sys_sched_getaffinity)
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -urN linux-O1/include/linux/capability.h linux/include/linux/capability.h
--- linux-O1/include/linux/capability.h	Mon Apr 22 15:21:46 2002
+++ linux/include/linux/capability.h	Mon Apr 22 15:22:31 2002
@@ -243,6 +243,7 @@
 /* Allow use of FIFO and round-robin (realtime) scheduling on own
    processes and setting the scheduling algorithm used by another
    process. */
+/* Allow setting cpu affinity on other processes */
 
 #define CAP_SYS_NICE         23
 
diff -urN linux-O1/kernel/sched.c linux/kernel/sched.c
--- linux-O1/kernel/sched.c	Mon Apr 22 15:21:46 2002
+++ linux/kernel/sched.c	Mon Apr 22 15:22:31 2002
@@ -1184,6 +1184,93 @@
 	return retval;
 }
 
+/**
+ * sys_sched_setaffinity - set the cpu affinity of a process
+ * @pid: pid of the process
+ * @len: length in bytes of the mask pointed to by new_mask_ptr
+ * @new_mask: user-space pointer to the new cpu mask
+ */
+asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
+				     unsigned long *new_mask_ptr)
+{
+	unsigned long new_mask;
+	task_t *p;
+	int retval;
+
+	if (len < sizeof(new_mask))
+		return -EINVAL;
+
+	if (copy_from_user(&new_mask, new_mask_ptr, sizeof(new_mask)))
+		return -EFAULT;
+
+	new_mask &= cpu_online_map;
+	if (!new_mask)
+		return -EINVAL;
+
+	/*
+	 * FIXME: It is unsafe to call set_cpus_allowed while
+	 * holding a lock.  In 2.5, we can bump the task_struct's
+	 * usage count - for 2.4, we have no such luxury.  Holding
+	 * tasklist_lock here is a temporary hack.  You are warned.
+	 */
+	write_lock(&tasklist_lock);
+
+	retval = -ESRCH;
+	p = find_process_by_pid(pid);
+	if (!p)
+		goto out_unlock;
+
+	retval = -EPERM;
+	if ((current->euid != p->euid) && (current->euid != p->uid) &&
+			!capable(CAP_SYS_NICE))
+		goto out_unlock;
+
+	retval = 0;
+	set_cpus_allowed(p, new_mask);
+
+out_unlock:
+	write_unlock(&tasklist_lock);
+	return retval;
+}
+
+/**
+ * sys_sched_getaffinity - get the cpu affinity of a process
+ * @pid: pid of the process
+ * @len: length in bytes of the mask pointed to by user_mask_ptr
+ * @user_mask_ptr: userspace pointer to the mask
+ */
+asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
+				     unsigned long *user_mask_ptr)
+{
+	unsigned long mask;
+	unsigned int real_len;
+	task_t *p;
+	int retval;
+
+	real_len = sizeof(mask);
+
+	if (len < real_len)
+		return -EINVAL;
+
+	read_lock(&tasklist_lock);
+
+	retval = -ESRCH;
+	p = find_process_by_pid(pid);
+	if (!p)
+		goto out_unlock;
+
+	retval = 0;
+	mask = p->cpus_allowed & cpu_online_map;
+
+out_unlock:
+	read_unlock(&tasklist_lock);
+	if (retval)
+		return retval;
+	if (copy_to_user(user_mask_ptr, &mask, real_len))
+		return -EFAULT;
+	return real_len;
+}
+
 asmlinkage long sys_sched_yield(void)
 {
 	runqueue_t *rq;



