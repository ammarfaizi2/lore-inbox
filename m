Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293071AbSB0XqQ>; Wed, 27 Feb 2002 18:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293072AbSB0Xpt>; Wed, 27 Feb 2002 18:45:49 -0500
Received: from zero.tech9.net ([209.61.188.187]:46342 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293071AbSB0XpU>;
	Wed, 27 Feb 2002 18:45:20 -0500
Subject: [PATCH] 2.5: (better) syscalls for setting task affinity
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 27 Feb 2002 18:45:21 -0500
Message-Id: <1014853522.1109.234.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ This post adds length and pointer checks to the syscalls such that we
can portably change the size of cpus_allowed. ]

The attached patch implements a syscall interface for setting and
retrieving a task's CPU affinity (task->cpus_allowed):

	int sched_set_affinity(pid_t pid, unsigned int len,
			       unsigned long *new_mask_ptr);

	int sched_get_affinity(pid_t pid, unsigned int *user_len_ptr,
			       unsigned long *user_mask_ptr)

sched_set_affinity uses the set_cpus_allowed function in Ingo's new
scheduler to do all the hard work.  Additionally, this patch is based
off Ingo's previous syscall affinity patch and my proc-based affinity
patch.  Much credit to Ingo for this past work and his current
scheduler.

Security is enforced: calling user must match task's uid or euid or
possess CAP_SYS_NICE.

We can safely change the size of cpus_allowed.  One can use:

	sched_get_affinity(0, &len, NULL);

to get the size of cpus_allowed.  The use of this interface, thus,
should be portable as we scale cpus_allowed over sizeof(long).

I think exporting cpus_allowed as a bit mask is the proper user
interface for CPU affinity.  Certainly more complicated solutions exist,
but this should get the job done.  I have also updated my proc-based
solution although Ingo and others have flamed^Wconvinced me a
syscall-based interface is ideal.  I agree, mostly on the basis that
/proc may not be mounted but I have posted an updated proc-based
solution anyhow for proper discussion.

Patch is against 2.5.6-pre1.  Enjoy,

	Robert Love

diff -urN linus/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linus/arch/i386/kernel/entry.S	Tue Feb 26 20:17:01 2002
+++ linux/arch/i386/kernel/entry.S	Tue Feb 26 20:44:06 2002
@@ -716,6 +716,8 @@
 	.long SYMBOL_NAME(sys_lremovexattr)
 	.long SYMBOL_NAME(sys_fremovexattr)
 	.long SYMBOL_NAME(sys_tkill)
+	.long SYMBOL_NAME(sys_sched_set_affinity)
+	.long SYMBOL_NAME(sys_sched_get_affinity)	/* 240 */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -urN linus/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linus/include/asm-i386/unistd.h	Tue Feb 26 20:17:14 2002
+++ linux/include/asm-i386/unistd.h	Tue Feb 26 23:54:21 2002
@@ -243,6 +243,8 @@
 #define __NR_lremovexattr	236
 #define __NR_fremovexattr	237
 #define __NR_tkill		238
+#define __NR_sched_set_affinity 239
+#define __NR_sched_get_affinity 240
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urN linus/kernel/sched.c linux/kernel/sched.c
--- linus/kernel/sched.c	Tue Feb 26 20:17:37 2002
+++ linux/kernel/sched.c	Tue Feb 26 23:52:38 2002
@@ -1215,6 +1215,99 @@
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
+	if (!new_mask_ptr)
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
+out:
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

