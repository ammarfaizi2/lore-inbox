Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293701AbSB1TlW>; Thu, 28 Feb 2002 14:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293695AbSB1Tju>; Thu, 28 Feb 2002 14:39:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45740 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293692AbSB1TiA>;
	Thu, 28 Feb 2002 14:38:00 -0500
Date: Thu, 28 Feb 2002 13:37:51 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.19-pre1] Signal changes for thread groups
Message-ID: <66720000.1014925071@baldur>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1871009384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1871009384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Here's a 2.4 version of the signal changes that were accepted into the 2.5
tree for thread groups.  It redirects signals to any task in a thread group
to the thread group leader.  It then introduces a tkill() system call for
signals directed at a specific task.

This patch does not introduce any behavior changes outside thread groups,
and as far as I know no one is using thread groups in 2.4.  It has been in
2.5 for awhile with no problems surfacing.

I'm sending it as a plain text attachment rather than try to fight with my
mailer again.  I hope that's acceptable.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========1871009384==========
Content-Type: text/plain; charset=iso-8859-1; name="ngpt-2.4.19-pre1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ngpt-2.4.19-pre1.diff"; size=32752

--- linux-2.4.19-pre1/./kernel/fork.c	Mon Feb 25 13:38:13 2002
+++ linux-2.4.19-pre1-ngpt/./kernel/fork.c	Thu Feb 28 13:25:25 2002
@@ -710,10 +710,10 @@
 	/* Need tasklist lock for parent etc handling! */
 	write_lock_irq(&tasklist_lock);
=20
-	/* CLONE_PARENT and CLONE_THREAD re-use the old parent */
+	/* CLONE_PARENT re-uses the old parent */
 	p->p_opptr =3D current->p_opptr;
 	p->p_pptr =3D current->p_pptr;
-	if (!(clone_flags & (CLONE_PARENT | CLONE_THREAD))) {
+	if (!(clone_flags & CLONE_PARENT)) {
 		p->p_opptr =3D current;
 		if (!(p->ptrace & PT_PTRACED))
 			p->p_pptr =3D current;
--- linux-2.4.19-pre1/./kernel/signal.c	Wed Nov 21 18:26:27 2001
+++ linux-2.4.19-pre1-ngpt/./kernel/signal.c	Thu Feb 28 13:25:25 2002
@@ -142,6 +142,35 @@
 	}
 }
=20
+/*
+ * sig_exit - cause the current task to exit due to a signal.
+ */
+
+void
+sig_exit(int sig, int exit_code, struct siginfo *info)
+{
+	struct task_struct *t;
+
+	sigaddset(&current->pending.signal, sig);
+	recalc_sigpending(current);
+	current->flags |=3D PF_SIGNALED;
+
+	/* Propagate the signal to all the tasks in
+	 *  our thread group
+	 */
+	if (info && (unsigned long)info !=3D 1
+	    && info->si_code !=3D SI_TKILL) {
+		read_lock(&tasklist_lock);
+		for_each_thread(t) {
+			force_sig_info(sig, info, t);
+		}
+		read_unlock(&tasklist_lock);
+	}
+
+	do_exit(exit_code);
+	/* NOTREACHED */
+}
+
 /* Notify the system that a driver wants to block all signals for this
  * process, and wants to be notified if any signals at all were to be
  * sent/acted upon.  If the notifier routine returns non-zero, then the
@@ -592,7 +621,7 @@
 		retval =3D -ESRCH;
 		read_lock(&tasklist_lock);
 		for_each_task(p) {
-			if (p->pgrp =3D=3D pgrp) {
+			if (p->pgrp =3D=3D pgrp && thread_group_leader(p)) {
 				int err =3D send_sig_info(sig, info, p);
 				if (retval)
 					retval =3D err;
@@ -639,8 +668,15 @@
 	read_lock(&tasklist_lock);
 	p =3D find_task_by_pid(pid);
 	error =3D -ESRCH;
-	if (p)
+	if (p) {
+		if (!thread_group_leader(p)) {
+                       struct task_struct *tg;
+                       tg =3D find_task_by_pid(p->tgid);
+                       if (tg)
+                               p =3D tg;
+                }
 		error =3D send_sig_info(sig, info, p);
+	}
 	read_unlock(&tasklist_lock);
 	return error;
 }
@@ -663,7 +699,7 @@
=20
 		read_lock(&tasklist_lock);
 		for_each_task(p) {
-			if (p->pid > 1 && p !=3D current) {
+			if (p->pid > 1 && p !=3D current && thread_group_leader(p)) {
 				int err =3D send_sig_info(sig, info, p);
 				++count;
 				if (err !=3D -EPERM)
@@ -986,6 +1022,36 @@
 	info.si_uid =3D current->uid;
=20
 	return kill_something_info(sig, &info, pid);
+}
+
+/*
+ *  Kill only one task, even if it's a CLONE_THREAD task.
+ */
+asmlinkage long
+sys_tkill(int pid, int sig)
+{
+       struct siginfo info;
+       int error;
+       struct task_struct *p;
+
+       /* This is only valid for single tasks */
+       if (pid <=3D 0)
+           return -EINVAL;
+
+       info.si_signo =3D sig;
+       info.si_errno =3D 0;
+       info.si_code =3D SI_TKILL;
+       info.si_pid =3D current->pid;
+       info.si_uid =3D current->uid;
+
+       read_lock(&tasklist_lock);
+       p =3D find_task_by_pid(pid);
+       error =3D -ESRCH;
+       if (p) {
+               error =3D send_sig_info(sig, &info, p);
+       }
+       read_unlock(&tasklist_lock);
+       return error;
 }
=20
 asmlinkage long
--- linux-2.4.19-pre1/./include/linux/sched.h	Fri Dec 21 11:42:03 2001
+++ linux-2.4.19-pre1-ngpt/./include/linux/sched.h	Thu Feb 28 13:25:25 2002
@@ -610,6 +610,7 @@
 extern void proc_caches_init(void);
 extern void flush_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *);
+extern void sig_exit(int, int, struct siginfo *);
 extern int dequeue_signal(sigset_t *, siginfo_t *);
 extern void block_all_signals(int (*notifier)(void *priv), void *priv,
 			      sigset_t *mask);
@@ -870,8 +871,13 @@
 #define for_each_task(p) \
 	for (p =3D &init_task ; (p =3D p->next_task) !=3D &init_task ; )
=20
+#define for_each_thread(task) \
+	for (task =3D next_thread(current) ; task !=3D current ; task =3D =
next_thread(task))
+
 #define next_thread(p) \
 	list_entry((p)->thread_group.next, struct task_struct, thread_group)
+
+#define thread_group_leader(p)	(p->pid =3D=3D p->tgid)
=20
 static inline void del_from_runqueue(struct task_struct * p)
 {
--- linux-2.4.19-pre1/./include/asm-i386/unistd.h	Mon Feb 25 13:38:12 2002
+++ linux-2.4.19-pre1-ngpt/./include/asm-i386/unistd.h	Thu Feb 28 13:25:25 =
2002
@@ -243,6 +243,8 @@
 #define __NR_lremovexattr	236
 #define __NR_fremovexattr	237
=20
+#define __NR_tkill		238
+
 /* user-visible error numbers are in the range -1 - -124: see =
<asm-i386/errno.h> */
=20
 #define __syscall_return(type, res) \
--- linux-2.4.19-pre1/./include/asm-i386/siginfo.h	Thu Nov 22 13:46:19 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-i386/siginfo.h	Thu Feb 28 13:25:25 =
2002
@@ -107,6 +107,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-mips/unistd.h	Mon Jul  2 15:56:40 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-mips/unistd.h	Thu Feb 28 13:25:25 =
2002
@@ -233,6 +233,8 @@
 #define __NR_madvise			(__NR_Linux + 218)
 #define __NR_getdents64			(__NR_Linux + 219)
 #define __NR_fcntl64			(__NR_Linux + 220)
+#define __NR_gettid			(__NR_Linux + 221)
+#define __NR_tkill			(__NR_Linux + 222)
=20
 /*
  * Offset of the last Linux flavoured syscall
--- linux-2.4.19-pre1/./include/asm-mips/siginfo.h	Wed May 24 20:38:26 2000
+++ linux-2.4.19-pre1-ngpt/./include/asm-mips/siginfo.h	Thu Feb 28 13:25:25 =
2002
@@ -127,6 +127,7 @@
 #define SI_TIMER __SI_CODE(__SI_TIMER,-3) /* sent by timer expiration */
 #define SI_MESGQ	-4	/* sent by real time mesq state change */
 #define SI_SIGIO	-5	/* sent by queued SIGIO */
+#define SI_TKILL	-6	/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-alpha/unistd.h	Fri Nov  9 15:45:35 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-alpha/unistd.h	Thu Feb 28 13:25:25 =
2002
@@ -318,6 +318,7 @@
 #define __NR_gettid			378
 #define __NR_readahead			379
 #define __NR_security			380 /* syscall for security modules */
+#define __NR_tkill			381
=20
 #if defined(__GNUC__)
=20
--- linux-2.4.19-pre1/./include/asm-alpha/siginfo.h	Wed May 24 20:38:26 =
2000
+++ linux-2.4.19-pre1-ngpt/./include/asm-alpha/siginfo.h	Thu Feb 28 =
13:25:25 2002
@@ -107,6 +107,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-m68k/unistd.h	Thu Oct 25 15:53:55 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-m68k/unistd.h	Thu Feb 28 13:25:26 =
2002
@@ -222,6 +222,8 @@
 #define __NR_setfsuid32		215
 #define __NR_setfsgid32		216
 #define __NR_getdents64		220
+#define __NR_gettid		221
+#define __NR_tkill		222
=20
 /* user-visible error numbers are in the range -1 - -122: see
    <asm-m68k/errno.h> */
--- linux-2.4.19-pre1/./include/asm-m68k/siginfo.h	Mon Nov 27 19:11:26 2000
+++ linux-2.4.19-pre1-ngpt/./include/asm-m68k/siginfo.h	Thu Feb 28 13:25:26 =
2002
@@ -117,6 +117,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-sparc/unistd.h	Sun Oct 21 12:36:54 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-sparc/unistd.h	Thu Feb 28 13:25:26 =
2002
@@ -271,6 +271,7 @@
 #define __NR_fdatasync          253
 #define __NR_nfsservctl         254
 #define __NR_aplib              255
+#define __NR_tkill              257
=20
 #define _syscall0(type,name) \
 type name(void) \
--- linux-2.4.19-pre1/./include/asm-sparc/siginfo.h	Mon Jun 19 19:59:39 =
2000
+++ linux-2.4.19-pre1-ngpt/./include/asm-sparc/siginfo.h	Thu Feb 28 =
13:25:26 2002
@@ -112,6 +112,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-ppc/unistd.h	Fri Nov  2 19:43:54 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-ppc/unistd.h	Thu Feb 28 13:25:26 =
2002
@@ -215,6 +215,7 @@
 #define __NR_madvise		205
 #define __NR_mincore		206
 #define __NR_gettid		207
+#define __NR_tkill		208
=20
 #define __NR(n)	#n
=20
--- linux-2.4.19-pre1/./include/asm-ppc/siginfo.h	Mon May 21 17:02:06 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-ppc/siginfo.h	Thu Feb 28 13:25:26 =
2002
@@ -108,6 +108,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-sparc64/unistd.h	Sun Oct 21 12:36:54 =
2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-sparc64/unistd.h	Thu Feb 28 =
13:25:26 2002
@@ -273,6 +273,7 @@
 #define __NR_fdatasync          253
 #define __NR_nfsservctl         254
 #define __NR_aplib              255
+#define __NR_tkill              256
=20
 #define _syscall0(type,name) \
 type name(void) \
--- linux-2.4.19-pre1/./include/asm-sparc64/siginfo.h	Wed May 24 20:38:26 =
2000
+++ linux-2.4.19-pre1-ngpt/./include/asm-sparc64/siginfo.h	Thu Feb 28 =
13:25:26 2002
@@ -172,6 +172,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-arm/siginfo.h	Sun Aug 12 13:14:00 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-arm/siginfo.h	Thu Feb 28 13:25:26 =
2002
@@ -107,6 +107,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL        -6              /* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-sh/siginfo.h	Thu Jan  4 15:19:13 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-sh/siginfo.h	Thu Feb 28 13:25:26 =
2002
@@ -107,6 +107,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-sh/unistd.h	Mon Oct  2 13:57:34 2000
+++ linux-2.4.19-pre1-ngpt/./include/asm-sh/unistd.h	Thu Feb 28 13:25:26 =
2002
@@ -231,6 +231,8 @@
 #define __NR_madvise		219
 #define __NR_getdents64		220
 #define __NR_fcntl64		221
+#define __NR_gettid		222
+#define __NR_tkill		223
=20
 /* user-visible error numbers are in the range -1 - -125: see =
<asm-sh/errno.h> */
=20
--- linux-2.4.19-pre1/./include/asm-ia64/siginfo.h	Fri Dec 21 11:42:03 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-ia64/siginfo.h	Thu Feb 28 13:25:26 =
2002
@@ -124,6 +124,7 @@
 #define SI_MESGQ	(-3)		/* sent by real time mesq state change */
 #define SI_ASYNCIO	(-4)		/* sent by AIO completion */
 #define SI_SIGIO	(-5)		/* sent by queued SIGIO */
+#define SI_TKILL	(-6)		/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-ia64/unistd.h	Fri Nov  9 16:26:17 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-ia64/unistd.h	Thu Feb 28 13:25:26 =
2002
@@ -206,6 +206,7 @@
 #define __NR_getdents64			1214
 #define __NR_getunwind			1215
 #define __NR_readahead			1216
+#define __NR_tkill			1229
=20
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
=20
--- linux-2.4.19-pre1/./include/asm-mips64/siginfo.h	Wed Jul  4 13:50:39 =
2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-mips64/siginfo.h	Thu Feb 28 =
13:25:26 2002
@@ -127,6 +127,7 @@
 #define SI_TIMER __SI_CODE(__SI_TIMER,-3) /* sent by timer expiration */
 #define SI_MESGQ	-4	/* sent by real time mesq state change */
 #define SI_SIGIO	-5	/* sent by queued SIGIO */
+#define SI_TKILL	-6	/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-mips64/unistd.h	Tue Nov 28 23:42:04 =
2000
+++ linux-2.4.19-pre1-ngpt/./include/asm-mips64/unistd.h	Thu Feb 28 =
13:25:26 2002
@@ -461,11 +461,13 @@
 #define __NR_mincore			(__NR_Linux + 211)
 #define __NR_madvise			(__NR_Linux + 212)
 #define __NR_getdents64			(__NR_Linux + 213)
+#define __NR_gettid			(__NR_Linux + 214)
+#define __NR_tkill			(__NR_Linux + 215)
=20
 /*
  * Offset of the last Linux flavoured syscall
  */
-#define __NR_Linux_syscalls		213
+#define __NR_Linux_syscalls		215
=20
 #ifndef _LANGUAGE_ASSEMBLY
=20
--- linux-2.4.19-pre1/./include/asm-s390/siginfo.h	Mon Feb 25 13:38:13 2002
+++ linux-2.4.19-pre1-ngpt/./include/asm-s390/siginfo.h	Thu Feb 28 13:25:26 =
2002
@@ -115,6 +115,7 @@
 #define SI_MESGQ	-3	/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4	/* sent by AIO completion */
 #define SI_SIGIO	-5	/* sent by queued SIGIO */
+#define SI_TKILL	-6	/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-s390/unistd.h	Thu Oct 11 11:43:38 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-s390/unistd.h	Thu Feb 28 13:25:26 =
2002
@@ -211,6 +211,8 @@
 #define __NR_mincore            218
 #define __NR_madvise            219
 #define __NR_getdents64		220
+#define __NR_gettid		226
+#define __NR_tkill		227
=20
=20
 /* user-visible error numbers are in the range -1 - -122: see =
<asm-s390/errno.h> */
--- linux-2.4.19-pre1/./include/asm-parisc/siginfo.h	Tue Dec  5 14:29:39 =
2000
+++ linux-2.4.19-pre1-ngpt/./include/asm-parisc/siginfo.h	Thu Feb 28 =
13:25:26 2002
@@ -107,6 +107,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-parisc/unistd.h	Tue Dec  5 14:29:39 =
2000
+++ linux-2.4.19-pre1-ngpt/./include/asm-parisc/unistd.h	Thu Feb 28 =
13:25:26 2002
@@ -689,8 +689,10 @@
=20
 #define __NR_getpmsg            (__NR_Linux + 196)      /* some people =
actually want streams */
 #define __NR_putpmsg            (__NR_Linux + 197)      /* some people =
actually want streams */
+#define __NR_gettid             (__NR_Linux + 198)
+#define __NR_tkill              (__NR_Linux + 199)
=20
-#define __NR_Linux_syscalls     197
+#define __NR_Linux_syscalls     199
=20
 #define HPUX_GATEWAY_ADDR       0xC0000004
 #define LINUX_GATEWAY_ADDR      0x100
--- linux-2.4.19-pre1/./include/asm-cris/siginfo.h	Thu Feb  8 18:32:44 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-cris/siginfo.h	Thu Feb 28 13:25:26 =
2002
@@ -107,6 +107,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-cris/unistd.h	Mon Feb 25 13:38:12 2002
+++ linux-2.4.19-pre1-ngpt/./include/asm-cris/unistd.h	Thu Feb 28 13:25:26 =
2002
@@ -230,6 +230,7 @@
 #define __NR_security           223     /* syscall for security modules */
 #define __NR_gettid             224
 #define __NR_readahead          225
+#define __NR_tkill              226
=20
 /* XXX - _foo needs to be __foo, while __NR_bar could be _NR_bar. */
 #define _syscall0(type,name) \
--- linux-2.4.19-pre1/./include/asm-s390x/siginfo.h	Mon Feb 25 13:38:13 =
2002
+++ linux-2.4.19-pre1-ngpt/./include/asm-s390x/siginfo.h	Thu Feb 28 =
13:25:26 2002
@@ -115,6 +115,7 @@
 #define SI_MESGQ	-3	/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4	/* sent by AIO completion */
 #define SI_SIGIO	-5	/* sent by queued SIGIO */
+#define SI_TKILL	-6	/* sent by tkill system call */
=20
 #define SI_FROMUSER(siptr)	((siptr)->si_code <=3D 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.4.19-pre1/./include/asm-s390x/unistd.h	Thu Oct 11 11:43:38 2001
+++ linux-2.4.19-pre1-ngpt/./include/asm-s390x/unistd.h	Thu Feb 28 13:25:26 =
2002
@@ -181,6 +181,8 @@
 #define __NR_mincore            218
 #define __NR_madvise            219
 #define __NR_getdents64         220
+#define __NR_gettid		226
+#define __NR_tkill 	        227
=20
=20
 /* user-visible error numbers are in the range -1 - -122: see =
<asm-s390/errno.h> */
--- linux-2.4.19-pre1/./arch/i386/kernel/entry.S	Mon Feb 25 13:37:53 2002
+++ linux-2.4.19-pre1-ngpt/./arch/i386/kernel/entry.S	Thu Feb 28 13:25:26 =
2002
@@ -634,6 +634,7 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* 235 reserved for removexattr */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for lremovexattr */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fremovexattr */
+ 	.long SYMBOL_NAME(sys_tkill)
=20
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
--- linux-2.4.19-pre1/./arch/i386/kernel/signal.c	Mon Feb 25 13:37:53 2002
+++ linux-2.4.19-pre1-ngpt/./arch/i386/kernel/signal.c	Thu Feb 28 13:25:26 =
2002
@@ -685,10 +685,7 @@
 				/* FALLTHRU */
=20
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/alpha/kernel/entry.S	Fri Nov  9 15:45:35 2001
+++ linux-2.4.19-pre1-ngpt/./arch/alpha/kernel/entry.S	Thu Feb 28 13:25:26 =
2002
@@ -1148,3 +1148,4 @@
 	.quad sys_gettid
 	.quad sys_readahead
 	.quad sys_ni_syscall			/* 380, sys_security */
+	.quad sys_tkill
--- linux-2.4.19-pre1/./arch/alpha/kernel/signal.c	Fri Nov  9 15:45:35 2001
+++ linux-2.4.19-pre1-ngpt/./arch/alpha/kernel/signal.c	Thu Feb 28 13:25:26 =
2002
@@ -717,9 +717,7 @@
=20
 			default:
 				lock_kernel();
-				sigaddset(&current->pending.signal, signr);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 			continue;
--- linux-2.4.19-pre1/./arch/sparc/kernel/signal.c	Wed Jan 24 17:18:06 2001
+++ linux-2.4.19-pre1-ngpt/./arch/sparc/kernel/signal.c	Thu Feb 28 13:25:26 =
2002
@@ -1279,10 +1279,7 @@
 #endif
 				/* fall through */
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOT REACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/sparc/kernel/systbls.S	Sun Oct 21 12:36:54 =
2001
+++ linux-2.4.19-pre1-ngpt/./arch/sparc/kernel/systbls.S	Thu Feb 28 =
13:25:26 2002
@@ -70,7 +70,7 @@
 /*240*/	.long sys_munlockall, sys_sched_setparam, sys_sched_getparam, =
sys_sched_setscheduler, sys_sched_getscheduler
 /*245*/	.long sys_sched_yield, sys_sched_get_priority_max, =
sys_sched_get_priority_min, sys_sched_rr_get_interval, sys_nanosleep
 /*250*/	.long sparc_mremap, sys_sysctl, sys_getsid, sys_fdatasync, =
sys_nfsservctl
-/*255*/	.long sys_nis_syscall, sys_nis_syscall
+/*255*/	.long sys_nis_syscall, sys_nis_syscall, sys_tkill
=20
 #ifdef CONFIG_SUNOS_EMUL
 	/* Now the SunOS syscall table. */
--- linux-2.4.19-pre1/./arch/mips/kernel/signal.c	Sun Sep  9 12:43:01 2001
+++ linux-2.4.19-pre1-ngpt/./arch/mips/kernel/signal.c	Thu Feb 28 13:25:26 =
2002
@@ -661,10 +661,7 @@
 				/* FALLTHRU */
=20
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/mips/kernel/syscalls.h	Mon Oct  8 12:39:18 =
2001
+++ linux-2.4.19-pre1-ngpt/./arch/mips/kernel/syscalls.h	Thu Feb 28 =
13:25:26 2002
@@ -235,3 +235,5 @@
 SYS(sys_madvise, 3)
 SYS(sys_getdents64, 3)
 SYS(sys_fcntl64, 3)				/* 4220 */
+SYS(sys_gettid, 0)
+SYS(sys_tkill, 2)
--- linux-2.4.19-pre1/./arch/ppc/kernel/misc.S	Mon Feb 25 13:37:55 2002
+++ linux-2.4.19-pre1-ngpt/./arch/ppc/kernel/misc.S	Thu Feb 28 13:25:26 =
2002
@@ -1122,6 +1122,7 @@
 	.long sys_madvise	/* 205 */
 	.long sys_mincore
 	.long sys_gettid
+	.long sys_tkill
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
 	.endr
--- linux-2.4.19-pre1/./arch/ppc/kernel/signal.c	Mon Nov 26 07:29:17 2001
+++ linux-2.4.19-pre1-ngpt/./arch/ppc/kernel/signal.c	Thu Feb 28 13:25:26 =
2002
@@ -645,10 +645,7 @@
 				/* FALLTHRU */
=20
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/m68k/kernel/entry.S	Mon Oct  8 12:39:18 2001
+++ linux-2.4.19-pre1-ngpt/./arch/m68k/kernel/entry.S	Thu Feb 28 13:25:26 =
2002
@@ -646,6 +646,8 @@
 	.long SYMBOL_NAME(sys_ni_syscall)
 	.long SYMBOL_NAME(sys_ni_syscall)
 	.long SYMBOL_NAME(sys_getdents64)	/* 220 */
+	.long SYMBOL_NAME(sys_gettid)
+	.long SYMBOL_NAME(sys_tkill)
=20
 	.rept NR_syscalls-(.-SYMBOL_NAME(sys_call_table))/4
 		.long SYMBOL_NAME(sys_ni_syscall)
--- linux-2.4.19-pre1/./arch/m68k/kernel/signal.c	Wed Jan 24 17:21:28 2001
+++ linux-2.4.19-pre1-ngpt/./arch/m68k/kernel/signal.c	Thu Feb 28 13:25:26 =
2002
@@ -1135,10 +1135,7 @@
 				/* FALLTHRU */
=20
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/sparc64/kernel/signal32.c	Fri Apr 27 00:17:25 =
2001
+++ linux-2.4.19-pre1-ngpt/./arch/sparc64/kernel/signal32.c	Thu Feb 28 =
13:25:26 2002
@@ -1478,10 +1478,7 @@
 #endif
 				/* fall through */
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOT REACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/sparc64/kernel/systbls.S	Sun Oct 21 12:36:54 =
2001
+++ linux-2.4.19-pre1-ngpt/./arch/sparc64/kernel/systbls.S	Thu Feb 28 =
13:25:26 2002
@@ -70,7 +70,7 @@
 /*240*/	.word sys_munlockall, sys_sched_setparam, sys_sched_getparam, =
sys_sched_setscheduler, sys_sched_getscheduler
 	.word sys_sched_yield, sys_sched_get_priority_max, =
sys_sched_get_priority_min, sys32_sched_rr_get_interval, sys32_nanosleep
 /*250*/	.word sys32_mremap, sys32_sysctl, sys_getsid, sys_fdatasync, =
sys32_nfsservctl
-	.word sys_aplib
+	.word sys_aplib, sys_tkill
=20
 	/* Now the 64-bit native Linux syscall table. */
=20
@@ -129,7 +129,7 @@
 /*240*/	.word sys_munlockall, sys_sched_setparam, sys_sched_getparam, =
sys_sched_setscheduler, sys_sched_getscheduler
 	.word sys_sched_yield, sys_sched_get_priority_max, =
sys_sched_get_priority_min, sys_sched_rr_get_interval, sys_nanosleep
 /*250*/	.word sys64_mremap, sys_sysctl, sys_getsid, sys_fdatasync, =
sys_nfsservctl
-	.word sys_aplib
+	.word sys_aplib, sys_tkill
=20
 #if defined(CONFIG_SUNOS_EMUL) || defined(CONFIG_SOLARIS_EMUL) || \
     defined(CONFIG_SOLARIS_EMUL_MODULE)
--- linux-2.4.19-pre1/./arch/sparc64/kernel/signal.c	Sun Mar 25 20:14:21 =
2001
+++ linux-2.4.19-pre1-ngpt/./arch/sparc64/kernel/signal.c	Thu Feb 28 =
13:25:26 2002
@@ -806,10 +806,7 @@
 #endif
 				/* fall through */
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOT REACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/arm/kernel/calls.S	Mon Oct  8 12:39:18 2001
+++ linux-2.4.19-pre1-ngpt/./arch/arm/kernel/calls.S	Thu Feb 28 13:25:26 =
2002
@@ -236,6 +236,8 @@
 		.long	SYMBOL_NAME(sys_mincore)
 /* 220 */	.long	SYMBOL_NAME(sys_madvise)
 		.long	SYMBOL_NAME(sys_fcntl64)
+		.long	SYMBOL_NAME(sys_gettid)
+		.long	SYMBOL_NAME(sys_tkill)
 __syscall_end:
=20
 		.rept	NR_syscalls - (__syscall_end - __syscall_start) / 4
--- linux-2.4.19-pre1/./arch/arm/kernel/signal.c	Thu Oct 11 11:04:57 2001
+++ linux-2.4.19-pre1-ngpt/./arch/arm/kernel/signal.c	Thu Feb 28 13:25:26 =
2002
@@ -637,10 +637,7 @@
 				/* FALLTHRU */
=20
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/sh/kernel/entry.S	Mon Oct  8 12:39:18 2001
+++ linux-2.4.19-pre1-ngpt/./arch/sh/kernel/entry.S	Thu Feb 28 13:25:26 =
2002
@@ -1298,6 +1298,8 @@
 	.long SYMBOL_NAME(sys_madvise)
 	.long SYMBOL_NAME(sys_getdents64)	/* 220 */
 	.long SYMBOL_NAME(sys_fcntl64)
+	.long SYMBOL_NAME(sys_gettid)
+	.long SYMBOL_NAME(sys_tkill)
=20
 	/*
 	 * NOTE!! This doesn't have to be exact - we just have
--- linux-2.4.19-pre1/./arch/sh/kernel/signal.c	Mon Oct 15 15:36:48 2001
+++ linux-2.4.19-pre1-ngpt/./arch/sh/kernel/signal.c	Thu Feb 28 13:25:26 =
2002
@@ -671,10 +671,7 @@
 				/* FALLTHRU */
=20
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/ia64/kernel/entry.S	Fri Nov  9 16:26:17 2001
+++ linux-2.4.19-pre1-ngpt/./arch/ia64/kernel/entry.S	Thu Feb 28 13:25:26 =
2002
@@ -1142,7 +1142,7 @@
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
-	data8 ia64_ni_syscall
+	data8 sys_tkill
 	data8 ia64_ni_syscall			// 1230
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
--- linux-2.4.19-pre1/./arch/ia64/kernel/signal.c	Fri Nov  9 16:26:17 2001
+++ linux-2.4.19-pre1-ngpt/./arch/ia64/kernel/signal.c	Thu Feb 28 13:25:26 =
2002
@@ -578,10 +578,7 @@
 				/* FALLTHRU */
=20
 			      default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/mips64/kernel/scall_64.S	Mon Oct  8 12:39:18 =
2001
+++ linux-2.4.19-pre1-ngpt/./arch/mips64/kernel/scall_64.S	Thu Feb 28 =
13:25:26 2002
@@ -347,3 +347,5 @@
 	PTR	sys_mincore
 	PTR	sys_madvise
 	PTR	sys_getdents64
+	PTR	sys_gettid
+	PTR	sys_tkill
--- linux-2.4.19-pre1/./arch/mips64/kernel/scall_o32.S	Mon Oct  8 12:39:18 =
2001
+++ linux-2.4.19-pre1-ngpt/./arch/mips64/kernel/scall_o32.S	Thu Feb 28 =
13:25:26 2002
@@ -454,6 +454,8 @@
 	sys	sys_madvise	3
 	sys	sys_getdents64	3
 	sys	sys32_fcntl64	3			/* 4220 */
+	sys	sys32_gettid	0
+	sys	sys32_tkill	2
 	.endm
=20
 	.macro	sys function, nargs
--- linux-2.4.19-pre1/./arch/mips64/kernel/signal.c	Sun Sep  9 12:43:01 =
2001
+++ linux-2.4.19-pre1-ngpt/./arch/mips64/kernel/signal.c	Thu Feb 28 =
13:25:26 2002
@@ -685,10 +685,7 @@
 				/* FALLTHRU */
=20
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/mips64/kernel/signal32.c	Sun Sep  9 12:43:01 =
2001
+++ linux-2.4.19-pre1-ngpt/./arch/mips64/kernel/signal32.c	Thu Feb 28 =
13:25:26 2002
@@ -757,10 +757,7 @@
 				/* FALLTHRU */
=20
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/s390/kernel/entry.S	Mon Feb 25 13:37:56 2002
+++ linux-2.4.19-pre1-ngpt/./arch/s390/kernel/entry.S	Thu Feb 28 13:25:26 =
2002
@@ -602,6 +602,8 @@
 	.long  sys_ni_syscall		 /* 224 - reserved for posix_acl */
 	.rept  255-224
 	.long  sys_ni_syscall
+	.long  sys_gettid		/* 226 */
+	.long  sys_tkill		/* 227 */
 	.endr
=20
 /*
--- linux-2.4.19-pre1/./arch/s390/kernel/signal.c	Thu Oct 11 11:04:57 2001
+++ linux-2.4.19-pre1-ngpt/./arch/s390/kernel/signal.c	Thu Feb 28 13:25:26 =
2002
@@ -563,10 +563,7 @@
                                 /* FALLTHRU */
=20
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/parisc/kernel/signal.c	Wed Dec  6 13:46:39 =
2000
+++ linux-2.4.19-pre1-ngpt/./arch/parisc/kernel/signal.c	Thu Feb 28 =
13:25:26 2002
@@ -581,11 +581,7 @@
 				/* FALLTHRU */
=20
 			default:
-				lock_kernel();
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/parisc/kernel/syscall.S	Mon Oct  8 12:39:18 =
2001
+++ linux-2.4.19-pre1-ngpt/./arch/parisc/kernel/syscall.S	Thu Feb 28 =
13:25:26 2002
@@ -552,6 +552,8 @@
 	ENTRY_UHOH(shmctl)		/* 195 */
 	ENTRY_SAME(ni_syscall)		/* streams1 */
 	ENTRY_SAME(ni_syscall)		/* streams2 */
+	ENTRY_SAME(gettid)
+	ENTRY_SAME(tkill)
=20
 .end
=20
--- linux-2.4.19-pre1/./arch/cris/kernel/entry.S	Mon Feb 25 13:37:52 2002
+++ linux-2.4.19-pre1-ngpt/./arch/cris/kernel/entry.S	Thu Feb 28 13:25:26 =
2002
@@ -1013,6 +1013,7 @@
         .long SYMBOL_NAME(sys_ni_syscall)       /* Reserved for Security =
*/
         .long SYMBOL_NAME(sys_gettid)
         .long SYMBOL_NAME(sys_readahead)        /* 225 */
+        .long SYMBOL_NAME(sys_tkill)
=20
         /*
          * NOTE!! This doesn't have to be exact - we just have
--- linux-2.4.19-pre1/./arch/cris/kernel/signal.c	Mon Oct  8 13:43:54 2001
+++ linux-2.4.19-pre1-ngpt/./arch/cris/kernel/signal.c	Thu Feb 28 13:25:26 =
2002
@@ -679,10 +679,7 @@
=20
 			default:
 				lock_kernel();
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/s390x/kernel/entry.S	Mon Feb 25 13:37:56 2002
+++ linux-2.4.19-pre1-ngpt/./arch/s390x/kernel/entry.S	Thu Feb 28 13:25:26 =
2002
@@ -635,6 +635,8 @@
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* 224 - reserved for =
posix_acl */
         .rept  255-224
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
+	.long  SYSCALL(sys_gettid,sys_gettid)
+	.long  SYSCALL(sys_tkill,sys_tkill)
 	.endr
=20
 /*
--- linux-2.4.19-pre1/./arch/s390x/kernel/signal.c	Thu Oct 11 11:04:57 2001
+++ linux-2.4.19-pre1-ngpt/./arch/s390x/kernel/signal.c	Thu Feb 28 13:25:26 =
2002
@@ -569,10 +569,7 @@
                                 /* FALLTHRU */
=20
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}
--- linux-2.4.19-pre1/./arch/s390x/kernel/signal32.c	Thu Oct 11 11:04:57 =
2001
+++ linux-2.4.19-pre1-ngpt/./arch/s390x/kernel/signal32.c	Thu Feb 28 =
13:25:26 2002
@@ -699,10 +699,7 @@
                                 /* FALLTHRU */
=20
 			default:
-				sigaddset(&current->pending.signal, signr);
-				recalc_sigpending(current);
-				current->flags |=3D PF_SIGNALED;
-				do_exit(exit_code);
+				sig_exit(signr, exit_code, &info);
 				/* NOTREACHED */
 			}
 		}

--==========1871009384==========--

