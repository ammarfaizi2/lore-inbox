Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292846AbSCJSPS>; Sun, 10 Mar 2002 13:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292937AbSCJSPI>; Sun, 10 Mar 2002 13:15:08 -0500
Received: from zero.tech9.net ([209.61.188.187]:32009 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292846AbSCJSPC>;
	Sun, 10 Mar 2002 13:15:02 -0500
Subject: [PATCH] syscall interface for cpu affinity
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 10 Mar 2002 13:15:03 -0500
Message-Id: <1015784104.1261.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I have updated the patch a bit and resycned to 2.5.6.  Are you
interested?  I believe a user interface for setting task CPU affinity is
useful and completes the rest of our sched_* syscalls.  A syscall
implementation seems to be what everyone wants (I have a proc-interface,
too...)

This patch implements

        int sched_set_affinity(pid_t pid, unsigned int len,
                               unsigned long *new_mask_ptr);

        int sched_get_affinity(pid_t pid, unsigned int *user_len_ptr,
                               unsigned long *user_mask_ptr)

which set and get the cpu affinity (task->cpus_allowed) for a task,
using the set_cpus_allowed function in Ingo's scheduler.  The functions
properly support changes to cpus_allowed, implement security, and are
well-tested.

They are based on Ingo's older affinity syscall patch and my older
affinity proc patch.

Comments?

	Robert Love

diff -urN linux-2.5.6/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.6/arch/i386/kernel/entry.S	Thu Mar  7 21:18:19 2002
+++ linux/arch/i386/kernel/entry.S	Sun Mar 10 13:01:03 2002
@@ -717,6 +717,8 @@
 	.long SYMBOL_NAME(sys_fremovexattr)
 	.long SYMBOL_NAME(sys_tkill)
 	.long SYMBOL_NAME(sys_sendfile64)
+	.long SYMBOL_NAME(sys_sched_set_affinity)	/* 240 */
+	.long SYMBOL_NAME(sys_sched_get_affinity)
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -urN linux-2.5.6/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-2.5.6/include/asm-i386/unistd.h	Thu Mar  7 21:18:55 2002
+++ linux/include/asm-i386/unistd.h	Sun Mar 10 13:03:41 2002
@@ -244,6 +244,8 @@
 #define __NR_fremovexattr	237
 #define __NR_tkill		238
 #define __NR_sendfile64		239
+#define __NR_sched_set_affinity	240
+#define __NR_sched_get_affinity	241
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urN linux-2.5.6/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.6/kernel/sched.c	Thu Mar  7 21:18:19 2002
+++ linux/kernel/sched.c	Sun Mar 10 12:59:26 2002
@@ -1215,6 +1215,95 @@
 	return retval;
 }
 
+/**
+ * sys_sched_set_affinity - set the cpu affinity of a process
+ * @pid: pid of the process
+ * @len: length of new_mask
+ * @new_mask: user-space pointer to the new cpu mask
+ */
+asmlinkage int sys_sched_set_affinity(pid_t pid, unsigned int len,
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
+ * sys_sched_get_affinity - get the cpu affinity of a process
+ * @pid: pid of the process
+ * @user_len_ptr: userspace pointer to the length of the mask
+ * @user_mask_ptr: userspace pointer to the mask
+ */
+asmlinkage int sys_sched_get_affinity(pid_t pid, unsigned int *user_len_ptr,
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

