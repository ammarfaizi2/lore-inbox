Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313630AbSDHORY>; Mon, 8 Apr 2002 10:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313631AbSDHORX>; Mon, 8 Apr 2002 10:17:23 -0400
Received: from zero.tech9.net ([209.61.188.187]:47629 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313630AbSDHORW>;
	Mon, 8 Apr 2002 10:17:22 -0400
Subject: [PATCH] 2.5: task cpu affinity syscalls
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 08 Apr 2002 10:17:22 -0400
Message-Id: <1018275443.857.159.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached is a resync to 2.5.8-pre2 of my CPU affinity syscalls for 2.5's
scheduler.

This patch implements two new syscalls:

	int sched_setaffinity(pid_t pid, unsigned int len,
				unsigned long *new_mask_ptr)

	int sched_getaffinity(pid_t pid, unsigned int *user_len_ptr,
				unsigned long *user_mask_ptr)

which set and get a task's CPU affinity, respectively.  I think we do
indeed need to export an interface for setting affinity for specific
needs, but a simple exported bitmask representation of cpus_allowed is
more than enough and these calls fit into our existing sched_* family.

These syscalls provide forward-compatibility with cpus_allowed changes,
implement security, and use Ingo's existing set_cpus_allowed method.

These syscalls are based on code of Ingo's for 2.4.

Changes since last post:

- drop tasklist_lock before calling set_cpus_allowed.  Holding it across
  the call may not be safe.  Instead, pin the specific task_struct with
  get_task_struct.
- remove ifdef in code
- minor cleanups, resync, et cetera

Well-tested on both UP and SMP.  A test program and a tool for setting
affinity of processes is available at
	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/cpu-affinity
and your favorite mirror.  Please apply.

	Robert Love

diff -urN linux-2.5.8-pre2/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.8-pre2/arch/i386/kernel/entry.S	Sat Apr  6 14:04:16 2002
+++ linux/arch/i386/kernel/entry.S	Sat Apr  6 19:44:29 2002
@@ -717,6 +717,8 @@
 	.long SYMBOL_NAME(sys_tkill)
 	.long SYMBOL_NAME(sys_sendfile64)
 	.long SYMBOL_NAME(sys_futex)		/* 240 */
+	.long SYMBOL_NAME(sys_sched_setaffinity)
+	.long SYMBOL_NAME(sys_sched_getaffinity)
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -urN linux-2.5.8-pre2/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-2.5.8-pre2/include/asm-i386/unistd.h	Mon Mar 18 15:37:16 2002
+++ linux/include/asm-i386/unistd.h	Sat Apr  6 19:44:29 2002
@@ -245,6 +245,8 @@
 #define __NR_tkill		238
 #define __NR_sendfile64		239
 #define __NR_futex		240
+#define __NR_sched_setaffinity	241
+#define __NR_sched_getaffinity	242
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urN linux-2.5.8-pre2/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.8-pre2/kernel/sched.c	Sat Apr  6 14:04:16 2002
+++ linux/kernel/sched.c	Sat Apr  6 19:44:29 2002
@@ -1234,6 +1234,103 @@
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
+	p = find_process_by_pid(pid);
+	if (!p) {
+		read_unlock(&tasklist_lock);
+		return -ESRCH;
+	}
+
+	/*
+	 * It is not safe to call set_cpus_allowed with the
+	 * tasklist_lock held.  We will bump the task_struct's
+	 * usage count and then drop tasklist_lock.
+	 */
+	get_task_struct(p);
+	read_unlock(&tasklist_lock);
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
+	put_task_struct(p);
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



