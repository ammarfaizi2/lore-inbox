Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292466AbSCLWiC>; Tue, 12 Mar 2002 17:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292631AbSCLWhx>; Tue, 12 Mar 2002 17:37:53 -0500
Received: from zero.tech9.net ([209.61.188.187]:53001 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292466AbSCLWhj>;
	Tue, 12 Mar 2002 17:37:39 -0500
Subject: [PATCH] updated 2.5 task affinity syscalls
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 12 Mar 2002 17:38:04 -0500
Message-Id: <1015972684.7465.10.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a resync of the task affinity syscalls against 2.5.7-pre1;
futex() is now using one of the syscall numbers the previous patch used.

This patch implements two new syscalls:

        int sched_setaffinity(pid_t pid, unsigned int len,
                               unsigned long *new_mask_ptr)

        int sched_getaffinity(pid_t pid, unsigned int *user_len_ptr,
                               unsigned long *user_mask_ptr)

which set and get a task's CPU affinity (task->cpus_allowed).

They provide forward-compatibility with cpus_allowed changes, implement
security, and use the existing set_cpus_allowed function in the new
scheduler.

The implementation is based on my proc-based code and Ingo Molnar's
previous syscall affinity patch for 2.4.

Well-tested on both UP and SMP.

	Robert Love

diff -urN linux-2.5.7-pre1/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.7-pre1/arch/i386/kernel/entry.S	Tue Mar 12 17:04:17 2002
+++ linux/arch/i386/kernel/entry.S	Tue Mar 12 17:09:01 2002
@@ -718,6 +718,8 @@
 	.long SYMBOL_NAME(sys_tkill)
 	.long SYMBOL_NAME(sys_sendfile64)
 	.long SYMBOL_NAME(sys_futex)		/* 240 */
+	.long SYMBOL_NAME(sys_sched_setaffinity)
+	.long SYMBOL_NAME(sys_sched_getaffinity)
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -urN linux-2.5.7-pre1/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-2.5.7-pre1/include/asm-i386/unistd.h	Tue Mar 12 17:04:18 2002
+++ linux/include/asm-i386/unistd.h	Tue Mar 12 17:09:11 2002
@@ -245,6 +245,8 @@
 #define __NR_tkill		238
 #define __NR_sendfile64		239
 #define __NR_futex		240
+#define __NR_sched_setaffinity	241
+#define __NR_sched_getaffinity	242
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urN linux-2.5.7-pre1/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.7-pre1/kernel/sched.c	Tue Mar 12 17:04:18 2002
+++ linux/kernel/sched.c	Tue Mar 12 17:11:51 2002
@@ -1224,6 +1224,96 @@
 	return retval;
 }
 
+/**
+ * sys_sched_setaffinity - set the cpu affinity of a process
+ * @pid: pid of the process
+ * @len: length of new_mask
+ * @new_mask: user-space pointer to the new cpu mask
+ */
+asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
+				      unsigned long *new_mask_ptr)
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
+	read_lock(&tasklist_lock);
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
+#ifdef CONFIG_SMP
+	set_cpus_allowed(p, new_mask);
+#endif
+
+out_unlock:
+	read_unlock(&tasklist_lock);
+	return retval;
+}
+
+/**
+ * sys_sched_getaffinity - get the cpu affinity of a process
+ * @pid: pid of the process
+ * @user_len_ptr: userspace pointer to the length of the mask
+ * @user_mask_ptr: userspace pointer to the mask
+ */
+asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int *user_len_ptr,
+				      unsigned long *user_mask_ptr)
+{
+	unsigned long mask;
+	unsigned int len, user_len;
+	task_t *p;
+	int retval;
+
+	len = sizeof(mask);
+
+	if (copy_from_user(&user_len, user_len_ptr, sizeof(user_len)))
+		return -EFAULT;
+
+	/* return to the user the actual size of the bitmask */
+	if (copy_to_user(user_len_ptr, &len, sizeof(len)))
+		return -EFAULT;
+
+	if (user_len < len)
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
+	if (copy_to_user(user_mask_ptr, &mask, sizeof(mask)))
+		return -EFAULT;
+	return 0;
+}
+
 asmlinkage long sys_sched_yield(void)
 {
 	runqueue_t *rq;



