Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313693AbSDPOg4>; Tue, 16 Apr 2002 10:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313694AbSDPOgz>; Tue, 16 Apr 2002 10:36:55 -0400
Received: from zero.tech9.net ([209.61.188.187]:21766 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313693AbSDPOgy>;
	Tue, 16 Apr 2002 10:36:54 -0400
Subject: [PATCH] task cpu affinity syscalls for 2.4
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 16 Apr 2002 10:36:56 -0400
Message-Id: <1018967816.3399.77.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch implements

        int sched_setaffinity(pid_t pid, unsigned int len,
                              unsigned long *user_mask_ptr)
        int sched_getaffinity(pid_t pid, unsigned int len,
                              unsigned long *user_mask_ptr)

which are the task cpu affinity syscalls I wrote for 2.5 (and merged
as-of 2.5.8-pre3).  While the interfaces are the same, the scheduling
behavior of 2.4 and 2.5 is greatly different due to differing schedules
and such, so the implementation is different.  Thus, this patch borrows
a lot from Ingo Molnar's 2.4 affinity syscalls he posted awhile back. 
The interface, syscall numbers, and behavior are the same as what is in
2.5 however.

This patch is not intended for merging into 2.4 yet, I would like to see
the 2.5 syscalls see more use and make sure we agree on its behavior and
interface before accepting a backport into 2.4.  This is intended for
additional testing.  I am reposting this since the previous patch no
longer applies to pre7.

At
        ftp://ftp.kernel.org/pub/linux/kernel/people/rml/cpu-affinity

I have some documentation and sample programs for those interested.

The following is against 2.4.19-pre7 .... enjoy.

        Robert Love

diff -urN linux-2.4.19-pre7/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.4.19-pre7/arch/i386/kernel/entry.S	Tue Apr 16 01:28:01 2002
+++ linux/arch/i386/kernel/entry.S	Tue Apr 16 01:39:02 2002
@@ -637,8 +637,8 @@
  	.long SYMBOL_NAME(sys_tkill)
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sendfile64 */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* 240 reserved for futex */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sched_setaffinity */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sched_getaffinity */
+	.long SYMBOL_NAME(sys_sched_setaffinity)
+	.long SYMBOL_NAME(sys_sched_getaffinity)
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -urN linux-2.4.19-pre7/include/linux/capability.h linux/include/linux/capability.h
--- linux-2.4.19-pre7/include/linux/capability.h	Tue Apr 16 01:25:12 2002
+++ linux/include/linux/capability.h	Tue Apr 16 01:41:47 2002
@@ -243,6 +243,7 @@
 /* Allow use of FIFO and round-robin (realtime) scheduling on own
    processes and setting the scheduling algorithm used by another
    process. */
+/* Allow setting cpu affinity on other processes */
 
 #define CAP_SYS_NICE         23
 
diff -urN linux-2.4.19-pre7/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre7/kernel/sched.c	Tue Apr 16 01:28:27 2002
+++ linux/kernel/sched.c	Tue Apr 16 01:40:43 2002
@@ -1124,6 +1124,106 @@
 	return retval;
 }
 
+/**
+ * sys_sched_setaffinity - set the cpu affinity of a process
+ * @pid: pid of the process
+ * @len: length of the bitmask pointed to by user_mask_ptr
+ * @user_mask_ptr: userspace pointer to the new cpu mask
+ */
+asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
+				     unsigned long *user_mask_ptr)
+{
+	unsigned long new_mask;
+	struct task_struct *p;
+	int retval, reschedule = 0;
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
+	read_lock_irq(&tasklist_lock);
+	spin_lock(&runqueue_lock);
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
+	p->cpus_allowed = new_mask;
+
+#ifdef CONFIG_SMP
+	if (!(p->cpus_runnable & p->cpus_allowed)) {
+		if (p == current)
+			reschedule = 1;
+		else {
+			p->need_resched = 1;
+			smp_send_reschedule(p->processor);
+		}
+	}
+#endif
+
+	retval = 0;
+out_unlock:
+	spin_unlock(&runqueue_lock);
+	read_unlock_irq(&tasklist_lock);
+
+	if (reschedule)
+		schedule();
+
+	return retval;
+}
+
+/**
+ * sys_sched_getaffinity - get the cpu affinity of a process
+ * @pid: pid of the process
+ * @len: length of the bitmask pointed to by user_mask_ptr
+ * @user_mask_ptr: userspace pointer to hold the current mask
+ */
+asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
+				     unsigned long *user_mask_ptr)
+{
+	unsigned long mask;
+	unsigned int real_len;
+	struct task_struct *p;
+	int retval;
+
+	real_len = sizeof(mask);
+
+	if (len < real_len)
+		return -EINVAL;
+
+	read_lock_irq(&tasklist_lock);
+	spin_lock(&runqueue_lock);
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
+	spin_unlock(&runqueue_lock);
+	read_unlock_irq(&tasklist_lock);
+	if (retval)
+		return retval;
+	if (copy_to_user(user_mask_ptr, &mask, real_len))
+		return -EFAULT;
+	return real_len;
+}
+
 static void show_task(struct task_struct * p)
 {
 	unsigned long free = 0;



