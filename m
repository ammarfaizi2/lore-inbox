Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293060AbSB0XdE>; Wed, 27 Feb 2002 18:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292984AbSB0XcV>; Wed, 27 Feb 2002 18:32:21 -0500
Received: from zero.tech9.net ([209.61.188.187]:39686 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293058AbSB0Xbn>;
	Wed, 27 Feb 2002 18:31:43 -0500
Subject: [PATCH] 2.5: syscalls for setting task affinity
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 27 Feb 2002 18:31:49 -0500
Message-Id: <1014852709.1109.214.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch implements a syscall interface for setting and
retrieving a task's CPU affinity (task->cpus_allowed):

	int sched_set_affinity(pid_t pid, unsigned long *new_mask_ptr);

	int sched_get_affinity(pid_t pid)

sched_set_affinity uses the set_cpus_allowed function in Ingo's new
scheduler to do all the hard work.  Additionally, this patch is based
off Ingo's previous syscall affinity patch and my proc-based affinity
patch.  Much credit to Ingo for this past work and his current
scheduler.

Security is enforced: calling user must match task's uid or euid or
possess CAP_SYS_NICE.

I think exporting cpus_allowed as a bit mask is the proper user
interface for CPU affinity.  Certainly more complicated solutions exist,
but this should get the job done.  I have also updated my proc-based
solution although Ingo and others have flamed^Wconvinced me a
syscall-based interface is ideal.  I agree, mostly on the basis that
/proc may not be mounted but I will post an updated proc-based solution
anyhow for proper discussion.

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
+++ linux/kernel/sched.c	Tue Feb 26 21:10:18 2002
@@ -1215,6 +1215,72 @@
 	return retval;
 }
 
+/**
+ * sys_sched_set_affinity - set the cpu affinity of a process
+ * @pid: pid of the process
+ * @new_mask: user-space pointer to the new cpu mask
+ */
+asmlinkage int sys_sched_set_affinity(pid_t pid, unsigned long *new_mask_ptr)
+{
+	unsigned long new_mask;
+	task_t *p;
+	int retval;
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
+ */
+asmlinkage int sys_sched_get_affinity(pid_t pid)
+{
+	task_t *p;
+	int retval;
+
+	read_lock(&tasklist_lock);
+
+	retval = -ESRCH;
+	p = find_process_by_pid(pid);
+	if (!p)
+		goto out_unlock;
+	retval = p->cpus_allowed & cpu_online_map;
+
+out_unlock:
+	read_unlock(&tasklist_lock);
+	return retval;
+}
+
 asmlinkage long sys_sched_yield(void)
 {
 	runqueue_t *rq;

