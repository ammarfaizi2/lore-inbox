Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314281AbSD2Sj2>; Mon, 29 Apr 2002 14:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSD2Sj1>; Mon, 29 Apr 2002 14:39:27 -0400
Received: from zero.tech9.net ([209.61.188.187]:25361 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314281AbSD2Sj0>;
	Mon, 29 Apr 2002 14:39:26 -0400
Subject: [PATCH][RFC] 2.4-ac affinity syscalls and how to pin a task?
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 29 Apr 2002 14:39:30 -0400
Message-Id: <1020105570.904.13.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch implements the task cpu affinity interface on top of
the O(1) scheduler in 2.4.19-pre7-ac3.  The migration_thread is now in
-ac3 so we can implement such an interface.

This is the same interface as in 2.5 and posted previously for 2.4 (sans
O(1)):

	sched_getaffinity(pid_t pid, unsigned long len, unsigned long *mask)
	sched_setaffinity(pid_t pid, unsigned long len, unsigned long *mask)

Problem:

We need to assure the task stays valid and does not exit, but due to the
semantics of set_cpus_allowed and migration_thread we can not hold a
lock across a call.  In 2.5 we can pin a task via get_task_struct.  This
assures us, at least, that the task struct is not deallocated until a
final call to put_task_struct.

What equivalent mechanism do we have in 2.4?  How can we assure a task
stays put without grabbing a spinlock?

This patch grabs the tasklist_lock before calling set_cpus_allowed. 
While this is working fine here and is safe enough to play with now, it
is not safe.

Comments?

	Robert Love

diff -urN linux-2.4.19-pre7-ac3/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.4.19-pre7-ac3/arch/i386/kernel/entry.S	Mon Apr 29 12:34:58 2002
+++ linux/arch/i386/kernel/entry.S	Mon Apr 29 14:29:32 2002
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
diff -urN linux-2.4.19-pre7-ac3/include/linux/capability.h linux/include/linux/capability.h
--- linux-2.4.19-pre7-ac3/include/linux/capability.h	Mon Apr 29 12:33:28 2002
+++ linux/include/linux/capability.h	Mon Apr 29 14:29:32 2002
@@ -243,6 +243,7 @@
 /* Allow use of FIFO and round-robin (realtime) scheduling on own
    processes and setting the scheduling algorithm used by another
    process. */
+/* Allow setting cpu affinity on other processes */
 
 #define CAP_SYS_NICE         23
 
diff -urN linux-2.4.19-pre7-ac3/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre7-ac3/kernel/sched.c	Mon Apr 29 12:33:23 2002
+++ linux/kernel/sched.c	Mon Apr 29 14:33:49 2002
@@ -1183,6 +1183,93 @@
 	return retval;
 }
 
+/**
+ * sys_sched_setaffinity - set the cpu affinity of a process
+ * @pid: pid of the process
+ * @len: length in bytes of the bitmask pointed to by user_mask_ptr
+ * @user_mask_ptr: user-space pointer to the new cpu mask
+ */
+asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
+				     unsigned long *user_mask_ptr)
+{
+	unsigned long new_mask;
+	task_t *p;
+	int retval;
+
+	if (len < sizeof(new_mask))
+		return -EINVAL;
+
+	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
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
+ * @len: length in bytes of the bitmask pointed to by user_mask_ptr
+ * @user_mask_ptr: user-space pointer to hold the current cpu mask
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



