Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSHMPFI>; Tue, 13 Aug 2002 11:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSHMPFI>; Tue, 13 Aug 2002 11:05:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57992 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315536AbSHMPFE>;
	Tue, 13 Aug 2002 11:05:04 -0400
Date: Tue, 13 Aug 2002 17:09:03 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] clone_startup(), 2.5.31-A0
Message-ID: <Pine.LNX.4.44.0208131650230.30647-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch implements a new syscall on x86, clone_startup().
The parameters are:

	clone_startup(fn, child_stack, flags, tls_desc, pid_addr)

with the help of this syscall glibc's next-generation pthreads code is
able to perform single-syscall thread creation: clone_startup() sets up
the child TLS and writes the child PID back into userspace. (which address
points to the thread control block.).

the child PID has to be written back because otherwise the parent and the
child would have to do expensive and unrobust synchronization. The first
instruction the child executes might as well be a signal handler, and
glibc code needs the TLS and the PID of the thread. There are a number of
workarounds in userspace that can solve this problem without
clone_startup(), but each of them has disadvantages:

 - the parent might disable all signals across clone() calls. This adds 3
   extra syscalls: 2 in the parent, 1 in the child. The old LinuxThreads
   code did something like this.

 - glibc could check whether the PID is available and call getpid() if
   not, but this introduces runtime overhead.

 - glibc might define a wrapper function around signal handlers - this is
   both unrobust and might cause compatibility problems.

 - glibc could use a mutex with the parent to let the parent fill in the
   PID. This causes two extra context-switches if the child is executed
   first after clone().

and the kernel can indeed provide a pretty good solution - why not do it
this way.

the TLS setup avoids an extra set_thread_area() syscalls. [Standalone
glibc applications still use set_thread_area(), so this syscall does not
obsolete set_thread_area().]

Implementational issues: i've introduced a new kernel-internal clone flag,
CLONE_STARTUP. In theory we could use the existing clone() syscall and let
applications fill in CLONE_STARTUP - i felt uneasy about this solution
because it introduces a versioned sys_clone() parametering, makings things
messy. But it would undoubtedly work safely and reliably, and it's even a
bit slower than the separated syscalls solution this patch adds.

for performance reasons the kernel does not recognize the -1 TLS
descriptor number, but this is a non-issue, child threads inherit the TLS
index of the parent anyway. Also, the kernel does not allow an 'empty' TLS
to be defined.

Comments?

	Ingo

--- linux/arch/i386/kernel/process.c.orig	Tue Aug 13 16:24:59 2002
+++ linux/arch/i386/kernel/process.c	Tue Aug 13 16:51:51 2002
@@ -559,6 +559,7 @@
 	unsigned long unused,
 	struct task_struct * p, struct pt_regs * regs)
 {
+	struct thread_struct *t = &p->thread;
 	struct pt_regs * childregs;
 	struct task_struct *tsk;
 
@@ -567,17 +568,42 @@
 	childregs->eax = 0;
 	childregs->esp = esp;
 
-	p->thread.esp = (unsigned long) childregs;
-	p->thread.esp0 = (unsigned long) (childregs+1);
+	t->esp = (unsigned long) childregs;
+	t->esp0 = (unsigned long) (childregs+1);
+	t->eip = (unsigned long) ret_from_fork;
 
-	p->thread.eip = (unsigned long) ret_from_fork;
-
-	savesegment(fs,p->thread.fs);
-	savesegment(gs,p->thread.gs);
+	savesegment(fs, t->fs);
+	savesegment(gs, t->gs);
 
 	tsk = current;
 	unlazy_fpu(tsk);
-	struct_cpy(&p->thread.i387, &tsk->thread.i387);
+	struct_cpy(&t->i387, &tsk->thread.i387);
+
+	/*
+	 * In the clone_startup() case we set up the child's
+	 * TLS, and we also put its TID into userspace.
+	 */
+	if (clone_flags & CLONE_STARTUP) {
+		struct desc_struct *desc;
+		struct user_desc info;
+		int idx;
+
+		if (copy_from_user(&info, (void *)childregs->esi, sizeof(info)))
+			return -EFAULT;
+		if (LDT_empty(&info))
+			return -EINVAL;
+
+		idx = info.entry_number;
+		if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
+			return -EINVAL;
+
+		desc = t->tls_array + idx - GDT_ENTRY_TLS_MIN;
+		desc->a = LDT_entry_a(&info);
+		desc->b = LDT_entry_b(&info);
+
+		if (put_user(p->pid, (pid_t *)childregs->edx))
+			return -EFAULT;
+	}
 
 	if (unlikely(NULL != tsk->thread.ts_io_bitmap)) {
 		p->thread.ts_io_bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
@@ -744,18 +770,27 @@
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
-asmlinkage int sys_clone(struct pt_regs regs)
+static inline int __clone(struct pt_regs *regs, unsigned long clone_flags)
 {
 	struct task_struct *p;
-	unsigned long clone_flags;
 	unsigned long newsp;
 
-	clone_flags = regs.ebx;
-	newsp = regs.ecx;
+	clone_flags = regs->ebx;
+	newsp = regs->ecx;
 	if (!newsp)
-		newsp = regs.esp;
-	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0);
+		newsp = regs->esp;
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, regs, 0);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+}
+
+asmlinkage int sys_clone(struct pt_regs regs)
+{
+	return __clone(&regs, regs.ebx & ~CLONE_STARTUP);
+}
+
+asmlinkage int sys_clone_startup(struct pt_regs regs)
+{
+	return __clone(&regs, regs.ebx | CLONE_STARTUP);
 }
 
 /*
--- linux/arch/i386/kernel/entry.S.orig	Tue Aug 13 16:50:01 2002
+++ linux/arch/i386/kernel/entry.S	Tue Aug 13 16:49:48 2002
@@ -754,6 +754,7 @@
 	.long sys_sched_getaffinity
 	.long sys_set_thread_area
 	.long sys_get_thread_area
+	.long sys_clone_startup	/* 245 */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
--- linux/include/linux/sched.h.orig	Tue Aug 13 16:48:27 2002
+++ linux/include/linux/sched.h	Tue Aug 13 16:49:09 2002
@@ -45,6 +45,7 @@
 #define CLONE_THREAD	0x00010000	/* Same thread group? */
 #define CLONE_NEWNS	0x00020000	/* New namespace group? */
 #define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
+#define CLONE_STARTUP	0x00080000	/* create child state */
 
 #define CLONE_SIGNAL	(CLONE_SIGHAND | CLONE_THREAD)
 
--- linux/include/asm-i386/unistd.h.orig	Tue Aug 13 16:50:11 2002
+++ linux/include/asm-i386/unistd.h	Tue Aug 13 16:50:28 2002
@@ -249,6 +249,7 @@
 #define __NR_sched_getaffinity	242
 #define __NR_set_thread_area	243
 #define __NR_get_thread_area	244
+#define __NR_clone_startup	245
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 

