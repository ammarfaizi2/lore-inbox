Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289084AbSBDQdP>; Mon, 4 Feb 2002 11:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289081AbSBDQdE>; Mon, 4 Feb 2002 11:33:04 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:54448 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289074AbSBDQcq>; Mon, 4 Feb 2002 11:32:46 -0500
Date: Mon, 04 Feb 2002 10:32:12 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.3] Changes to signal to better support thread groups
 (resend)
Message-ID: <53100000.1012840332@baldur>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Grrr...  Remind me never to mess with my mailer settings.  Here's my patch 
again, this time not wrapped. - dmc

--------

Given the recent discussion, I'm not sure who I should submit this patch
to.  Alan Cox and Ted T'so have reviewed it, and have suggested it should
be submitted for 2.5, so I'm sending it to Dave and Linus.  If there's
a maintainer more suitable to send it to, please let me know.

During the course of developing our pthread library (the NGPT pthread
library) it became clear we needed some kernel support for handling
signals.  This patch helps the library by redirecting all signals sent to
tasks in a
thread group to the thread group leader.  It also defines the tkill()
system call so the library can signal a specific task if necessary.

Given that as far as I know NGPT is the only user of thread groups, and
that this change would benefit any other user of thread groups, I'm
submitting this for inclusion in the 2.5 kernel.

Note that this patch also adds support for sys_gettid() for the
architectures that don't have it.  While this could have been split into a
spearate patch, it would create conflicts since this patch also adds
sys_tkill(), so I felt it was cleaner to leave them together.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

---------------------

--- linux-2.5.3/./kernel/fork.c	Mon Jan 28 17:11:45 2002
+++ linux-2.5.3-ngpt/./kernel/fork.c	Fri Feb  1 14:08:52 2002
@@ -724,10 +724,10 @@
 	/* Need tasklist lock for parent etc handling! */
 	write_lock_irq(&tasklist_lock);

-	/* CLONE_PARENT and CLONE_THREAD re-use the old parent */
+	/* CLONE_PARENT re-uses the old parent */
 	p->p_opptr = current->p_opptr;
 	p->p_pptr = current->p_pptr;
-	if (!(clone_flags & (CLONE_PARENT | CLONE_THREAD))) {
+	if (!(clone_flags & CLONE_PARENT)) {
 		p->p_opptr = current;
 		if (!(p->ptrace & PT_PTRACED))
 			p->p_pptr = current;
--- linux-2.5.3/./kernel/signal.c	Mon Jan 28 17:11:45 2002
+++ linux-2.5.3-ngpt/./kernel/signal.c	Fri Feb  1 13:12:29 2002
@@ -589,7 +589,7 @@
 		retval = -ESRCH;
 		read_lock(&tasklist_lock);
 		for_each_task(p) {
-			if (p->pgrp == pgrp) {
+			if (p->pgrp == pgrp && thread_group_leader(p)) {
 				int err = send_sig_info(sig, info, p);
 				if (retval)
 					retval = err;
@@ -636,8 +636,15 @@
 	read_lock(&tasklist_lock);
 	p = find_task_by_pid(pid);
 	error = -ESRCH;
-	if (p)
+	if (p) {
+		if (!thread_group_leader(p)) {
+                       struct task_struct *tg;
+                       tg = find_task_by_pid(p->tgid);
+                       if (tg)
+                               p = tg;
+                }
 		error = send_sig_info(sig, info, p);
+	}
 	read_unlock(&tasklist_lock);
 	return error;
 }
@@ -660,7 +667,7 @@

 		read_lock(&tasklist_lock);
 		for_each_task(p) {
-			if (p->pid > 1 && p != current) {
+			if (p->pid > 1 && p != current && thread_group_leader(p)) {
 				int err = send_sig_info(sig, info, p);
 				++count;
 				if (err != -EPERM)
@@ -983,6 +990,36 @@
 	info.si_uid = current->uid;

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
+       if (pid <= 0)
+           return -EINVAL;
+
+       info.si_signo = sig;
+       info.si_errno = 0;
+       info.si_code = SI_TKILL;
+       info.si_pid = current->pid;
+       info.si_uid = current->uid;
+
+       read_lock(&tasklist_lock);
+       p = find_task_by_pid(pid);
+       error = -ESRCH;
+       if (p) {
+               error = send_sig_info(sig, &info, p);
+       }
+       read_unlock(&tasklist_lock);
+       return error;
 }

 asmlinkage long
--- linux-2.5.3/./include/linux/sched.h	Tue Jan 29 23:41:12 2002
+++ linux-2.5.3-ngpt/./include/linux/sched.h	Fri Feb  1 14:07:08 2002
@@ -839,8 +839,13 @@
 #define for_each_task(p) \
 	for (p = &init_task ; (p = p->next_task) != &init_task ; )

+#define for_each_thread(task) \
+	for (task = next_thread(current) ; task != current ; task = 
next_thread(task))
+
 #define next_thread(p) \
 	list_entry((p)->thread_group.next, struct task_struct, thread_group)
+
+#define thread_group_leader(p)	(p->pid == p->tgid)

 static inline void unhash_process(struct task_struct *p)
 {
--- linux-2.5.3/./include/asm-i386/unistd.h	Tue Jan 29 20:46:00 2002
+++ linux-2.5.3-ngpt/./include/asm-i386/unistd.h	Fri Feb  1 13:15:08 2002
@@ -242,6 +242,7 @@
 #define __NR_removexattr	235
 #define __NR_lremovexattr	236
 #define __NR_fremovexattr	237
+#define __NR_tkill		238

 /* user-visible error numbers are in the range -1 - -124: see 
<asm-i386/errno.h> */

--- linux-2.5.3/./include/asm-i386/siginfo.h	Tue Jan 29 23:41:10 2002
+++ linux-2.5.3-ngpt/./include/asm-i386/siginfo.h	Fri Feb  1 14:07:04 2002
@@ -107,6 +107,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-mips/unistd.h	Mon Jul  2 15:56:40 2001
+++ linux-2.5.3-ngpt/./include/asm-mips/unistd.h	Fri Feb  1 13:12:28 2002
@@ -233,6 +233,8 @@
 #define __NR_madvise			(__NR_Linux + 218)
 #define __NR_getdents64			(__NR_Linux + 219)
 #define __NR_fcntl64			(__NR_Linux + 220)
+#define __NR_gettid			(__NR_Linux + 221)
+#define __NR_tkill			(__NR_Linux + 222)

 /*
  * Offset of the last Linux flavoured syscall
--- linux-2.5.3/./include/asm-mips/siginfo.h	Wed May 24 20:38:26 2000
+++ linux-2.5.3-ngpt/./include/asm-mips/siginfo.h	Fri Feb  1 13:12:28 2002
@@ -127,6 +127,7 @@
 #define SI_TIMER __SI_CODE(__SI_TIMER,-3) /* sent by timer expiration */
 #define SI_MESGQ	-4	/* sent by real time mesq state change */
 #define SI_SIGIO	-5	/* sent by queued SIGIO */
+#define SI_TKILL	-6	/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-alpha/unistd.h	Fri Nov  9 15:45:35 2001
+++ linux-2.5.3-ngpt/./include/asm-alpha/unistd.h	Fri Feb  1 13:12:28 2002
@@ -318,6 +318,7 @@
 #define __NR_gettid			378
 #define __NR_readahead			379
 #define __NR_security			380 /* syscall for security modules */
+#define __NR_tkill			381

 #if defined(__GNUC__)

--- linux-2.5.3/./include/asm-alpha/siginfo.h	Wed May 24 20:38:26 2000
+++ linux-2.5.3-ngpt/./include/asm-alpha/siginfo.h	Fri Feb  1 13:12:28 2002
@@ -107,6 +107,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-m68k/unistd.h	Thu Oct 25 15:53:55 2001
+++ linux-2.5.3-ngpt/./include/asm-m68k/unistd.h	Fri Feb  1 13:12:28 2002
@@ -222,6 +222,8 @@
 #define __NR_setfsuid32		215
 #define __NR_setfsgid32		216
 #define __NR_getdents64		220
+#define __NR_gettid		221
+#define __NR_tkill		222

 /* user-visible error numbers are in the range -1 - -122: see
    <asm-m68k/errno.h> */
--- linux-2.5.3/./include/asm-m68k/siginfo.h	Mon Nov 27 19:11:26 2000
+++ linux-2.5.3-ngpt/./include/asm-m68k/siginfo.h	Fri Feb  1 13:12:28 2002
@@ -117,6 +117,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-sparc/unistd.h	Sun Oct 21 12:36:54 2001
+++ linux-2.5.3-ngpt/./include/asm-sparc/unistd.h	Fri Feb  1 13:12:29 2002
@@ -271,6 +271,7 @@
 #define __NR_fdatasync          253
 #define __NR_nfsservctl         254
 #define __NR_aplib              255
+#define __NR_tkill              257

 #define _syscall0(type,name) \
 type name(void) \
--- linux-2.5.3/./include/asm-sparc/siginfo.h	Mon Jun 19 19:59:39 2000
+++ linux-2.5.3-ngpt/./include/asm-sparc/siginfo.h	Fri Feb  1 13:12:29 2002
@@ -112,6 +112,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-ppc/unistd.h	Fri Nov  2 19:43:54 2001
+++ linux-2.5.3-ngpt/./include/asm-ppc/unistd.h	Fri Feb  1 13:12:29 2002
@@ -215,6 +215,7 @@
 #define __NR_madvise		205
 #define __NR_mincore		206
 #define __NR_gettid		207
+#define __NR_tkill		208

 #define __NR(n)	#n

--- linux-2.5.3/./include/asm-ppc/siginfo.h	Mon May 21 17:02:06 2001
+++ linux-2.5.3-ngpt/./include/asm-ppc/siginfo.h	Fri Feb  1 13:12:29 2002
@@ -108,6 +108,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-sparc64/unistd.h	Sun Oct 21 12:36:54 2001
+++ linux-2.5.3-ngpt/./include/asm-sparc64/unistd.h	Fri Feb  1 13:12:29 2002
@@ -273,6 +273,7 @@
 #define __NR_fdatasync          253
 #define __NR_nfsservctl         254
 #define __NR_aplib              255
+#define __NR_tkill              256

 #define _syscall0(type,name) \
 type name(void) \
--- linux-2.5.3/./include/asm-sparc64/siginfo.h	Wed May 24 20:38:26 2000
+++ linux-2.5.3-ngpt/./include/asm-sparc64/siginfo.h	Fri Feb  1 13:12:29 
2002
@@ -172,6 +172,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-arm/siginfo.h	Sun Aug 12 13:14:00 2001
+++ linux-2.5.3-ngpt/./include/asm-arm/siginfo.h	Fri Feb  1 13:12:28 2002
@@ -107,6 +107,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL        -6              /* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-sh/siginfo.h	Thu Jan  4 15:19:13 2001
+++ linux-2.5.3-ngpt/./include/asm-sh/siginfo.h	Fri Feb  1 13:12:29 2002
@@ -107,6 +107,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-sh/unistd.h	Mon Oct  2 13:57:34 2000
+++ linux-2.5.3-ngpt/./include/asm-sh/unistd.h	Fri Feb  1 13:12:29 2002
@@ -231,6 +231,8 @@
 #define __NR_madvise		219
 #define __NR_getdents64		220
 #define __NR_fcntl64		221
+#define __NR_gettid		222
+#define __NR_tkill		223

 /* user-visible error numbers are in the range -1 - -125: see 
<asm-sh/errno.h> */

--- linux-2.5.3/./include/asm-ia64/siginfo.h	Thu Apr  5 14:51:47 2001
+++ linux-2.5.3-ngpt/./include/asm-ia64/siginfo.h	Fri Feb  1 13:16:25 2002
@@ -124,6 +124,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-ia64/unistd.h	Fri Nov  9 16:26:17 2001
+++ linux-2.5.3-ngpt/./include/asm-ia64/unistd.h	Fri Feb  1 13:12:28 2002
@@ -206,6 +206,7 @@
 #define __NR_getdents64			1214
 #define __NR_getunwind			1215
 #define __NR_readahead			1216
+#define __NR_tkill			1217

 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)

--- linux-2.5.3/./include/asm-mips64/siginfo.h	Wed Jul  4 13:50:39 2001
+++ linux-2.5.3-ngpt/./include/asm-mips64/siginfo.h	Fri Feb  1 13:12:28 2002
@@ -127,6 +127,7 @@
 #define SI_TIMER __SI_CODE(__SI_TIMER,-3) /* sent by timer expiration */
 #define SI_MESGQ	-4	/* sent by real time mesq state change */
 #define SI_SIGIO	-5	/* sent by queued SIGIO */
+#define SI_TKILL	-6	/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-mips64/unistd.h	Tue Nov 28 23:42:04 2000
+++ linux-2.5.3-ngpt/./include/asm-mips64/unistd.h	Fri Feb  1 13:12:28 2002
@@ -461,11 +461,13 @@
 #define __NR_mincore			(__NR_Linux + 211)
 #define __NR_madvise			(__NR_Linux + 212)
 #define __NR_getdents64			(__NR_Linux + 213)
+#define __NR_gettid			(__NR_Linux + 214)
+#define __NR_tkill			(__NR_Linux + 215)

 /*
  * Offset of the last Linux flavoured syscall
  */
-#define __NR_Linux_syscalls		213
+#define __NR_Linux_syscalls		215

 #ifndef _LANGUAGE_ASSEMBLY

--- linux-2.5.3/./include/asm-s390/siginfo.h	Tue Feb 13 16:13:44 2001
+++ linux-2.5.3-ngpt/./include/asm-s390/siginfo.h	Fri Feb  1 13:12:29 2002
@@ -115,6 +115,7 @@
 #define SI_MESGQ	-3	/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4	/* sent by AIO completion */
 #define SI_SIGIO	-5	/* sent by queued SIGIO */
+#define SI_TKILL	-6	/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-s390/unistd.h	Thu Oct 11 11:43:38 2001
+++ linux-2.5.3-ngpt/./include/asm-s390/unistd.h	Fri Feb  1 13:12:29 2002
@@ -211,6 +211,8 @@
 #define __NR_mincore            218
 #define __NR_madvise            219
 #define __NR_getdents64		220
+#define __NR_gettid		226
+#define __NR_tkill		227


 /* user-visible error numbers are in the range -1 - -122: see 
<asm-s390/errno.h> */
--- linux-2.5.3/./include/asm-parisc/siginfo.h	Tue Dec  5 14:29:39 2000
+++ linux-2.5.3-ngpt/./include/asm-parisc/siginfo.h	Fri Feb  1 13:12:29 2002
@@ -107,6 +107,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-parisc/unistd.h	Tue Dec  5 14:29:39 2000
+++ linux-2.5.3-ngpt/./include/asm-parisc/unistd.h	Fri Feb  1 13:12:29 2002
@@ -689,8 +689,10 @@

 #define __NR_getpmsg            (__NR_Linux + 196)      /* some people 
actually want streams */
 #define __NR_putpmsg            (__NR_Linux + 197)      /* some people 
actually want streams */
+#define __NR_gettid             (__NR_Linux + 198)
+#define __NR_tkill              (__NR_Linux + 199)

-#define __NR_Linux_syscalls     197
+#define __NR_Linux_syscalls     199

 #define HPUX_GATEWAY_ADDR       0xC0000004
 #define LINUX_GATEWAY_ADDR      0x100
--- linux-2.5.3/./include/asm-cris/siginfo.h	Thu Feb  8 18:32:44 2001
+++ linux-2.5.3-ngpt/./include/asm-cris/siginfo.h	Fri Feb  1 13:12:28 2002
@@ -107,6 +107,7 @@
 #define SI_MESGQ	-3		/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_TKILL	-6		/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./include/asm-cris/unistd.h	Mon Jan 21 18:00:39 2002
+++ linux-2.5.3-ngpt/./include/asm-cris/unistd.h	Fri Feb  1 13:12:28 2002
@@ -230,6 +230,7 @@
 #define __NR_security           223     /* syscall for security modules */
 #define __NR_gettid             224
 #define __NR_readahead          225
+#define __NR_tkill              226

 /* XXX - _foo needs to be __foo, while __NR_bar could be _NR_bar. */
 #define _syscall0(type,name) \
--- linux-2.5.3/./include/asm-s390x/unistd.h	Thu Oct 11 11:43:38 2001
+++ linux-2.5.3-ngpt/./include/asm-s390x/unistd.h	Fri Feb  1 13:12:29 2002
@@ -181,6 +181,8 @@
 #define __NR_mincore            218
 #define __NR_madvise            219
 #define __NR_getdents64         220
+#define __NR_gettid		226
+#define __NR_tkill 	        227


 /* user-visible error numbers are in the range -1 - -122: see 
<asm-s390/errno.h> */
--- linux-2.5.3/./include/asm-s390x/siginfo.h	Tue Feb 13 16:13:44 2001
+++ linux-2.5.3-ngpt/./include/asm-s390x/siginfo.h	Fri Feb  1 13:12:29 2002
@@ -115,6 +115,7 @@
 #define SI_MESGQ	-3	/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4	/* sent by AIO completion */
 #define SI_SIGIO	-5	/* sent by queued SIGIO */
+#define SI_TKILL	-6	/* sent by tkill system call */

 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- linux-2.5.3/./arch/i386/kernel/entry.S	Tue Jan 29 20:50:30 2002
+++ linux-2.5.3-ngpt/./arch/i386/kernel/entry.S	Fri Feb  1 13:14:11 2002
@@ -667,6 +667,7 @@
 	.long SYMBOL_NAME(sys_removexattr)	/* 235 */
 	.long SYMBOL_NAME(sys_lremovexattr)
 	.long SYMBOL_NAME(sys_fremovexattr)
+ 	.long SYMBOL_NAME(sys_tkill)

 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
--- linux-2.5.3/./arch/i386/kernel/signal.c	Mon Jan 28 17:11:45 2002
+++ linux-2.5.3-ngpt/./arch/i386/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -686,6 +686,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+
+                               /*
+                                *  If this task is in a thread group, make 
sure
+                                *  this signal kills all tasks in the 
group.
+                                */
+                               if (info.si_code != SI_TKILL) {
+					struct task_struct *task;
+
+					for_each_thread(task) {
+						force_sig_info(signr, &info, task);
+					}
+                               }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/alpha/kernel/entry.S	Mon Jan 28 17:14:22 2002
+++ linux-2.5.3-ngpt/./arch/alpha/kernel/entry.S	Fri Feb  1 13:12:28 2002
@@ -1148,3 +1148,4 @@
 	.quad sys_gettid
 	.quad sys_readahead
 	.quad sys_ni_syscall			/* 380, sys_security */
+	.quad sys_tkill
--- linux-2.5.3/./arch/alpha/kernel/signal.c	Fri Nov  9 15:45:35 2001
+++ linux-2.5.3-ngpt/./arch/alpha/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -719,6 +719,19 @@
 				lock_kernel();
 				sigaddset(&current->pending.signal, signr);
 				current->flags |= PF_SIGNALED;
+
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                               force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/sparc/kernel/signal.c	Mon Jan 14 12:10:44 2002
+++ linux-2.5.3-ngpt/./arch/sparc/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -1283,6 +1283,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+			
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOT REACHED */
 			}
--- linux-2.5.3/./arch/sparc/kernel/systbls.S	Sun Oct 21 12:36:54 2001
+++ linux-2.5.3-ngpt/./arch/sparc/kernel/systbls.S	Fri Feb  1 13:12:28 2002
@@ -70,7 +70,7 @@
 /*240*/	.long sys_munlockall, sys_sched_setparam, sys_sched_getparam, 
sys_sched_setscheduler, sys_sched_getscheduler
 /*245*/	.long sys_sched_yield, sys_sched_get_priority_max, 
sys_sched_get_priority_min, sys_sched_rr_get_interval, sys_nanosleep
 /*250*/	.long sparc_mremap, sys_sysctl, sys_getsid, sys_fdatasync, 
sys_nfsservctl
-/*255*/	.long sys_nis_syscall, sys_nis_syscall
+/*255*/	.long sys_nis_syscall, sys_nis_syscall, sys_tkill

 #ifdef CONFIG_SUNOS_EMUL
 	/* Now the SunOS syscall table. */
--- linux-2.5.3/./arch/mips/kernel/signal.c	Sun Sep  9 12:43:01 2001
+++ linux-2.5.3-ngpt/./arch/mips/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -664,6 +664,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/mips/kernel/syscalls.h	Mon Oct  8 12:39:18 2001
+++ linux-2.5.3-ngpt/./arch/mips/kernel/syscalls.h	Fri Feb  1 13:12:28 2002
@@ -235,3 +235,5 @@
 SYS(sys_madvise, 3)
 SYS(sys_getdents64, 3)
 SYS(sys_fcntl64, 3)				/* 4220 */
+SYS(sys_gettid, 0)
+SYS(sys_tkill, 2)
--- linux-2.5.3/./arch/ppc/kernel/misc.S	Fri Nov  2 19:43:54 2001
+++ linux-2.5.3-ngpt/./arch/ppc/kernel/misc.S	Fri Feb  1 13:12:28 2002
@@ -1121,6 +1121,7 @@
 	.long sys_madvise	/* 205 */
 	.long sys_mincore
 	.long sys_gettid
+	.long sys_tkill
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
 	.endr
--- linux-2.5.3/./arch/ppc/kernel/signal.c	Mon May 21 19:04:47 2001
+++ linux-2.5.3-ngpt/./arch/ppc/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -644,6 +644,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/m68k/kernel/entry.S	Mon Oct  8 12:39:18 2001
+++ linux-2.5.3-ngpt/./arch/m68k/kernel/entry.S	Fri Feb  1 13:12:28 2002
@@ -646,6 +646,8 @@
 	.long SYMBOL_NAME(sys_ni_syscall)
 	.long SYMBOL_NAME(sys_ni_syscall)
 	.long SYMBOL_NAME(sys_getdents64)	/* 220 */
+	.long SYMBOL_NAME(sys_gettid)
+	.long SYMBOL_NAME(sys_tkill)

 	.rept NR_syscalls-(.-SYMBOL_NAME(sys_call_table))/4
 		.long SYMBOL_NAME(sys_ni_syscall)
--- linux-2.5.3/./arch/m68k/kernel/signal.c	Wed Jan 24 17:21:28 2001
+++ linux-2.5.3-ngpt/./arch/m68k/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -1138,6 +1138,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/sparc64/kernel/signal32.c	Mon Jan 14 12:10:44 2002
+++ linux-2.5.3-ngpt/./arch/sparc64/kernel/signal32.c	Fri Feb  1 13:12:28 
2002
@@ -1482,6 +1482,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOT REACHED */
 			}
--- linux-2.5.3/./arch/sparc64/kernel/systbls.S	Sun Oct 21 12:36:54 2001
+++ linux-2.5.3-ngpt/./arch/sparc64/kernel/systbls.S	Fri Feb  1 13:12:28 
2002
@@ -70,7 +70,7 @@
 /*240*/	.word sys_munlockall, sys_sched_setparam, sys_sched_getparam, 
sys_sched_setscheduler, sys_sched_getscheduler
 	.word sys_sched_yield, sys_sched_get_priority_max, 
sys_sched_get_priority_min, sys32_sched_rr_get_interval, sys32_nanosleep
 /*250*/	.word sys32_mremap, sys32_sysctl, sys_getsid, sys_fdatasync, 
sys32_nfsservctl
-	.word sys_aplib
+	.word sys_aplib, sys_tkill

 	/* Now the 64-bit native Linux syscall table. */

@@ -129,7 +129,7 @@
 /*240*/	.word sys_munlockall, sys_sched_setparam, sys_sched_getparam, 
sys_sched_setscheduler, sys_sched_getscheduler
 	.word sys_sched_yield, sys_sched_get_priority_max, 
sys_sched_get_priority_min, sys_sched_rr_get_interval, sys_nanosleep
 /*250*/	.word sys64_mremap, sys_sysctl, sys_getsid, sys_fdatasync, 
sys_nfsservctl
-	.word sys_aplib
+	.word sys_aplib, sys_tkill

 #if defined(CONFIG_SUNOS_EMUL) || defined(CONFIG_SOLARIS_EMUL) || \
     defined(CONFIG_SOLARIS_EMUL_MODULE)
--- linux-2.5.3/./arch/sparc64/kernel/signal.c	Mon Jan 14 12:10:44 2002
+++ linux-2.5.3-ngpt/./arch/sparc64/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -810,6 +810,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+			
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOT REACHED */
 			}
--- linux-2.5.3/./arch/arm/kernel/calls.S	Mon Oct  8 12:39:18 2001
+++ linux-2.5.3-ngpt/./arch/arm/kernel/calls.S	Fri Feb  1 13:12:28 2002
@@ -236,6 +236,8 @@
 		.long	SYMBOL_NAME(sys_mincore)
 /* 220 */	.long	SYMBOL_NAME(sys_madvise)
 		.long	SYMBOL_NAME(sys_fcntl64)
+		.long	SYMBOL_NAME(sys_gettid)
+		.long	SYMBOL_NAME(sys_tkill)
 __syscall_end:

 		.rept	NR_syscalls - (__syscall_end - __syscall_start) / 4
--- linux-2.5.3/./arch/arm/kernel/signal.c	Sat Jan  5 15:04:30 2002
+++ linux-2.5.3-ngpt/./arch/arm/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -640,6 +640,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/sh/kernel/entry.S	Mon Jan 28 17:14:23 2002
+++ linux-2.5.3-ngpt/./arch/sh/kernel/entry.S	Fri Feb  1 13:12:28 2002
@@ -1195,6 +1195,8 @@
 	.long SYMBOL_NAME(sys_madvise)
 	.long SYMBOL_NAME(sys_getdents64)	/* 220 */
 	.long SYMBOL_NAME(sys_fcntl64)
+	.long SYMBOL_NAME(sys_gettid)
+	.long SYMBOL_NAME(sys_tkill)

 	/*
 	 * NOTE!! This doesn't have to be exact - we just have
--- linux-2.5.3/./arch/sh/kernel/signal.c	Thu Jan 24 14:08:15 2002
+++ linux-2.5.3-ngpt/./arch/sh/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -676,6 +676,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+			
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/ia64/kernel/entry.S	Mon Jan 28 17:14:22 2002
+++ linux-2.5.3-ngpt/./arch/ia64/kernel/entry.S	Fri Feb  1 13:12:28 2002
@@ -1130,6 +1130,7 @@
 	data8 sys_getdents64
 	data8 sys_getunwind			// 1215
 	data8 sys_readahead
+	data8 sys_tkill
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
--- linux-2.5.3/./arch/ia64/kernel/signal.c	Fri Nov  9 16:26:17 2001
+++ linux-2.5.3-ngpt/./arch/ia64/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -581,6 +581,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/mips64/kernel/scall_64.S	Mon Jan 28 17:14:22 2002
+++ linux-2.5.3-ngpt/./arch/mips64/kernel/scall_64.S	Fri Feb  1 13:12:28 
2002
@@ -347,3 +347,5 @@
 	PTR	sys_mincore
 	PTR	sys_madvise
 	PTR	sys_getdents64
+	PTR	sys_gettid
+	PTR	sys_tkill
--- linux-2.5.3/./arch/mips64/kernel/scall_o32.S	Mon Jan 28 17:14:23 2002
+++ linux-2.5.3-ngpt/./arch/mips64/kernel/scall_o32.S	Fri Feb  1 13:12:28 
2002
@@ -454,6 +454,8 @@
 	sys	sys_madvise	3
 	sys	sys_getdents64	3
 	sys	sys32_fcntl64	3			/* 4220 */
+	sys	sys32_gettid	0
+	sys	sys32_tkill	2
 	.endm

 	.macro	sys function, nargs
--- linux-2.5.3/./arch/mips64/kernel/signal.c	Sun Sep  9 12:43:01 2001
+++ linux-2.5.3-ngpt/./arch/mips64/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -688,6 +688,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/mips64/kernel/signal32.c	Sun Sep  9 12:43:01 2001
+++ linux-2.5.3-ngpt/./arch/mips64/kernel/signal32.c	Fri Feb  1 13:12:28 
2002
@@ -760,6 +760,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/s390/kernel/entry.S	Mon Jan 28 17:14:23 2002
+++ linux-2.5.3-ngpt/./arch/s390/kernel/entry.S	Fri Feb  1 13:12:28 2002
@@ -602,6 +602,8 @@
 	.long  sys_ni_syscall		 /* 224 - reserved for posix_acl */
 	.rept  255-224
 	.long  sys_ni_syscall
+	.long  sys_gettid		/* 226 */
+	.long  sys_tkill		/* 227 */
 	.endr

 /*
--- linux-2.5.3/./arch/s390/kernel/signal.c	Thu Oct 11 11:04:57 2001
+++ linux-2.5.3-ngpt/./arch/s390/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -566,6 +566,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+				
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/parisc/kernel/signal.c	Wed Dec  6 13:46:39 2000
+++ linux-2.5.3-ngpt/./arch/parisc/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -585,6 +585,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/parisc/kernel/syscall.S	Mon Oct  8 12:39:18 2001
+++ linux-2.5.3-ngpt/./arch/parisc/kernel/syscall.S	Fri Feb  1 13:12:28 2002
@@ -552,6 +552,8 @@
 	ENTRY_UHOH(shmctl)		/* 195 */
 	ENTRY_SAME(ni_syscall)		/* streams1 */
 	ENTRY_SAME(ni_syscall)		/* streams2 */
+	ENTRY_SAME(gettid)
+	ENTRY_SAME(tkill)

 .end

--- linux-2.5.3/./arch/cris/kernel/entry.S	Mon Jan 21 18:00:39 2002
+++ linux-2.5.3-ngpt/./arch/cris/kernel/entry.S	Fri Feb  1 13:12:28 2002
@@ -1015,6 +1015,7 @@
         .long SYMBOL_NAME(sys_ni_syscall)       /* Reserved for Security */
         .long SYMBOL_NAME(sys_gettid)
         .long SYMBOL_NAME(sys_readahead)        /* 225 */
+        .long SYMBOL_NAME(sys_tkill)

         /*
          * NOTE!! This doesn't have to be exact - we just have
--- linux-2.5.3/./arch/cris/kernel/signal.c	Mon Oct  8 13:43:54 2001
+++ linux-2.5.3-ngpt/./arch/cris/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -682,6 +682,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/s390x/kernel/entry.S	Mon Jan 28 17:14:23 2002
+++ linux-2.5.3-ngpt/./arch/s390x/kernel/entry.S	Fri Feb  1 13:12:28 2002
@@ -635,6 +635,8 @@
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* 224 - reserved for 
posix_acl */
         .rept  255-224
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
+	.long  SYSCALL(sys_gettid,sys_gettid)
+	.long  SYSCALL(sys_tkill,sys_tkill)
 	.endr

 /*
--- linux-2.5.3/./arch/s390x/kernel/signal.c	Thu Oct 11 11:04:57 2001
+++ linux-2.5.3-ngpt/./arch/s390x/kernel/signal.c	Fri Feb  1 13:12:28 2002
@@ -572,6 +572,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+					for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}
--- linux-2.5.3/./arch/s390x/kernel/signal32.c	Thu Oct 11 11:04:57 2001
+++ linux-2.5.3-ngpt/./arch/s390x/kernel/signal32.c	Fri Feb  1 13:12:28 2002
@@ -702,6 +702,19 @@
 				sigaddset(&current->pending.signal, signr);
 				recalc_sigpending(current);
 				current->flags |= PF_SIGNALED;
+			
+				/*
+                                 *  If this task is in a thread group, 
make sure
+                                 *  this signal kills all tasks in the 
group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+                                        for_each_thread(task) {
+                                                force_sig_info(signr, 
&info, task);
+                                        }
+                                }
+
 				do_exit(exit_code);
 				/* NOTREACHED */
 			}

