Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSEOWtS>; Wed, 15 May 2002 18:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316514AbSEOWtR>; Wed, 15 May 2002 18:49:17 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:22262 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316512AbSEOWtP>; Wed, 15 May 2002 18:49:15 -0400
Subject: [PATCH] 2.4-ac: task CPU affinity syscalls
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-5815zFN6sY9V71eSAYZa"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 May 2002 15:49:15 -0700
Message-Id: <1021502955.825.23.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5815zFN6sY9V71eSAYZa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch, against 2.4.19-pre8-ac4, implements the task CPU
affinity syscalls found in 2.5.  This is not suggested for inclusion in
2.4 until the 2.5 interface is assuredly what we want.  I post it now
for discussion and those who are interested.

The syscalls are:

        sched_getaffinity(pid_t pid, unsigned long len, unsigned long *mask)
        sched_setaffinity(pid_t pid, unsigned long len, unsigned long *mask)

which get and set the affinity of any given task (provided proper
permission) to the given CPU bitmask.

I believe we solved the locking issue I presented before: handle it as
in 2.5.  Acquire tasklist_lock, translate the pid into a valid
task_struct, call get_task_struct to bump the task_struct's page
reference count, drop tasklist_lock, call set_cpus_allowed, then call
free_task_struct which does free_pages.  Since the pages usage count was
bumped, it will not be freed unless the task prematurely deallocated in
the middle.

Comments?  Hopefully this works and - assuming the 2.5 interface stays
as is - I can put this aside until it is time to merge it.

	Robert Love



--=-5815zFN6sY9V71eSAYZa
Content-Disposition: attachment; filename=cpu-affinity-syscall-rml-2.4.19-pre8-ac4-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=cpu-affinity-syscall-rml-2.4.19-pre8-ac4-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre8-ac4/arch/i386/kernel/entry.S linux/arch/i386/ke=
rnel/entry.S
--- linux-2.4.19-pre8-ac4/arch/i386/kernel/entry.S	Wed May 15 12:53:43 2002
+++ linux/arch/i386/kernel/entry.S	Wed May 15 14:51:39 2002
@@ -639,8 +639,8 @@
  	.long SYMBOL_NAME(sys_tkill)
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sendfile64 */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* 240 reserved for futex */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sched_setaffinity */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for sched_getaffinity */
+	.long SYMBOL_NAME(sys_sched_setaffinity)
+	.long SYMBOL_NAME(sys_sched_getaffinity)
=20
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -urN linux-2.4.19-pre8-ac4/arch/ppc/kernel/misc.S linux/arch/ppc/kerne=
l/misc.S
--- linux-2.4.19-pre8-ac4/arch/ppc/kernel/misc.S	Wed May 15 12:53:46 2002
+++ linux/arch/ppc/kernel/misc.S	Wed May 15 14:53:17 2002
@@ -1162,6 +1162,22 @@
 	.long sys_mincore
 	.long sys_gettid
 	.long sys_tkill
+	.long sys_ni_syscall
+	.long sys_ni_syscall	/* 210 */
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall	/* 215 */
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall	/* 220 */
+	.long sys_ni_syscall
+	.long sys_sched_setaffinity
+	.long sys_sched_getaffinity
+
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
 	.endr
diff -urN linux-2.4.19-pre8-ac4/include/asm-ppc/unistd.h linux/include/asm-=
ppc/unistd.h
--- linux-2.4.19-pre8-ac4/include/asm-ppc/unistd.h	Wed May 15 12:53:42 2002
+++ linux/include/asm-ppc/unistd.h	Wed May 15 14:53:00 2002
@@ -216,6 +216,8 @@
 #define __NR_mincore		206
 #define __NR_gettid		207
 #define __NR_tkill		208
+#define __NR_sched_setaffinity	222
+#define __NR_sched_getaffinity	223
=20
 #define __NR(n)	#n
=20
diff -urN linux-2.4.19-pre8-ac4/include/linux/capability.h linux/include/li=
nux/capability.h
--- linux-2.4.19-pre8-ac4/include/linux/capability.h	Wed May 15 12:53:42 20=
02
+++ linux/include/linux/capability.h	Wed May 15 14:51:39 2002
@@ -243,6 +243,7 @@
 /* Allow use of FIFO and round-robin (realtime) scheduling on own
    processes and setting the scheduling algorithm used by another
    process. */
+/* Allow setting cpu affinity on other processes */
=20
 #define CAP_SYS_NICE         23
=20
diff -urN linux-2.4.19-pre8-ac4/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre8-ac4/kernel/sched.c	Wed May 15 12:53:42 2002
+++ linux/kernel/sched.c	Wed May 15 14:56:04 2002
@@ -1187,6 +1187,98 @@
 	return retval;
 }
=20
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
+	new_mask &=3D cpu_online_map;
+	if (!new_mask)
+		return -EINVAL;
+
+	/*
+	 * We cannot hold a lock across a call to set_cpus_allowed, however
+	 * we need to assure our task does not slip out from under us.  Since
+	 * we are only concerned that its task_struct remains, we can pin it
+	 * here and decrement the usage count when we are done.
+	 */
+	read_lock(&tasklist_lock);
+
+	retval =3D -ESRCH;
+	p =3D find_process_by_pid(pid);
+	if (!p) {
+		read_unlock(&tasklist_lock);
+		goto out_unlock;
+	}
+
+	get_task_struct(p);
+	read_unlock(&tasklist_lock);
+
+	retval =3D -EPERM;
+	if ((current->euid !=3D p->euid) && (current->euid !=3D p->uid) &&
+			!capable(CAP_SYS_NICE))
+		goto out_unlock;
+
+	retval =3D 0;
+	set_cpus_allowed(p, new_mask);
+
+out_unlock:
+	free_task_struct(p);
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
+	real_len =3D sizeof(mask);
+
+	if (len < real_len)
+		return -EINVAL;
+
+	read_lock(&tasklist_lock);
+
+	retval =3D -ESRCH;
+	p =3D find_process_by_pid(pid);
+	if (!p)
+		goto out_unlock;
+
+	retval =3D 0;
+	mask =3D p->cpus_allowed & cpu_online_map;
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

--=-5815zFN6sY9V71eSAYZa--

