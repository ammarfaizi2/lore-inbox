Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315822AbSEMFCd>; Mon, 13 May 2002 01:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315831AbSEMFCc>; Mon, 13 May 2002 01:02:32 -0400
Received: from [202.135.142.194] ([202.135.142.194]:49163 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315822AbSEMFCY>; Mon, 13 May 2002 01:02:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hotplug CPU prep II: CLONE_IDLETASK 
In-Reply-To: Your message of "Thu, 09 May 2002 09:02:45 MST."
             <Pine.LNX.4.44.0205090900270.2630-100000@home.transmeta.com> 
Date: Mon, 13 May 2002 15:05:19 +1000
Message-Id: <E17781P-0007GT-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0205090900270.2630-100000@home.transmeta.com> you wri
te:
> On Thu, 9 May 2002, Rusty Russell wrote:
> >
> > This changes CLONE_PID ("if my pid is 0, copy it") to CLONE_IDLETASK
> > ("if I have CAP_SYS_MODULE, set child's pid to zero").
> 
> The "CAP_SYS_MODULE" thing needs to change, I think.
> 
> We simply cannot allow user-space to do this AT ALL, even root by mistake.

Was being lazy: some archs implement sys_clone() is asm.

I've merged this with the "make do_fork return a struct task_struct *"
patch, and done all archs.  I've deliberately broken the asm bits.

Please apply,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/include/linux/sched.h working-2.5.15-clonepid/include/linux/sched.h
--- linux-2.5.15/include/linux/sched.h	Mon May  6 16:00:11 2002
+++ working-2.5.15-clonepid/include/linux/sched.h	Mon May 13 14:11:34 2002
@@ -39,7 +39,7 @@
 #define CLONE_FS	0x00000200	/* set if fs info shared between processes */
 #define CLONE_FILES	0x00000400	/* set if open files shared between processes */
 #define CLONE_SIGHAND	0x00000800	/* set if signal handlers and blocked signals shared */
-#define CLONE_PID	0x00001000	/* set if pid shared */
+#define CLONE_IDLETASK	0x00001000	/* set if new pid should be 0 (kernel only)*/
 #define CLONE_PTRACE	0x00002000	/* set if we want to let tracing continue on the child too */
 #define CLONE_VFORK	0x00004000	/* set if the parent wants the child to wake it up on mm_release */
 #define CLONE_PARENT	0x00008000	/* set if we want to have the same parent as the cloner */
@@ -658,7 +658,7 @@
 extern task_t *child_reaper;
 
 extern int do_execve(char *, char **, char **, struct pt_regs *);
-extern int do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long);
+extern struct task_struct *do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long);
 
 extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/kernel/fork.c working-2.5.15-clonepid/kernel/fork.c
--- linux-2.5.15/kernel/fork.c	Mon May 13 12:00:40 2002
+++ working-2.5.15-clonepid/kernel/fork.c	Mon May 13 14:12:04 2002
@@ -136,8 +136,8 @@
 	struct task_struct *p;
 	int pid;
 
-	if (flags & CLONE_PID)
-		return current->pid;
+	if (flags & CLONE_IDLETASK)
+		return 0;
 
 	spin_lock(&lastpid_lock);
 	if((++last_pid) & 0xffff8000) {
@@ -608,27 +608,18 @@
  * For an example that's using stack_top, see
  * arch/ia64/kernel/process.c.
  */
-int do_fork(unsigned long clone_flags, unsigned long stack_start,
-	    struct pt_regs *regs, unsigned long stack_size)
+struct task_struct *do_fork(unsigned long clone_flags,
+			    unsigned long stack_start,
+			    struct pt_regs *regs,
+			    unsigned long stack_size)
 {
 	int retval;
 	unsigned long flags;
-	struct task_struct *p;
+	struct task_struct *p = NULL;
 	struct completion vfork;
 
 	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
-		return -EINVAL;
-
-	retval = -EPERM;
-
-	/* 
-	 * CLONE_PID is only allowed for the initial SMP swapper
-	 * calls
-	 */
-	if (clone_flags & CLONE_PID) {
-		if (current->pid)
-			goto fork_out;
-	}
+		return ERR_PTR(-EINVAL);
 
 	retval = -ENOMEM;
 	p = dup_task_struct(current);
@@ -768,8 +759,7 @@
 	 *
 	 * Let it rip!
 	 */
-	retval = p->pid;
-	p->tgid = retval;
+	p->tgid = p->pid;
 	INIT_LIST_HEAD(&p->thread_group);
 
 	/* Need tasklist lock for parent etc handling! */
@@ -807,9 +797,12 @@
 		 * COW overhead when the child exec()s afterwards.
 		 */
 		set_need_resched();
+	retval = 0;
 
 fork_out:
-	return retval;
+	if (retval)
+		return ERR_PTR(retval);
+	return p;
 
 bad_fork_cleanup_namespace:
 	exit_namespace(p);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/alpha/kernel/process.c working-2.5.15-clonepid/arch/alpha/kernel/process.c
--- linux-2.5.15/arch/alpha/kernel/process.c	Tue Apr 23 11:39:31 2002
+++ working-2.5.15-clonepid/arch/alpha/kernel/process.c	Mon May 13 14:41:05 2002
@@ -260,16 +260,22 @@
 alpha_clone(unsigned long clone_flags, unsigned long usp,
 	    struct switch_stack * swstack)
 {
+	struct task_struct *p;
 	if (!usp)
 		usp = rdusp();
-	return do_fork(clone_flags, usp, (struct pt_regs *) (swstack+1), 0);
+
+	p = do_fork(clone_flags & ~CLONE_IDLETASK,
+		    usp, (struct pt_regs *) (swstack+1), 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 int
 alpha_vfork(struct switch_stack * swstack)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(),
-			(struct pt_regs *) (swstack+1), 0);
+	struct task_struct *p;
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(),
+		    (struct pt_regs *) (swstack+1), 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/alpha/kernel/smp.c working-2.5.15-clonepid/arch/alpha/kernel/smp.c
--- linux-2.5.15/arch/alpha/kernel/smp.c	Thu Mar 21 14:14:37 2002
+++ working-2.5.15-clonepid/arch/alpha/kernel/smp.c	Mon May 13 14:41:37 2002
@@ -433,13 +433,13 @@
 	return 0;
 }
 
-static int __init
+static struct task_struct * __init
 fork_by_hand(void)
 {
 	/* Don't care about the contents of regs since we'll never
 	   reschedule the forked task. */
 	struct pt_regs regs;
-	return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 }
 
 /*
@@ -457,12 +457,9 @@
 	   the other task-y sort of data structures set up like we
 	   wish.  We can't use kernel_thread since we must avoid
 	   rescheduling the child.  */
-	if (fork_by_hand() < 0)
+	idle = fork_by_hand();
+	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpuid);
-
-	idle = prev_task(&init_task);
-	if (!idle)
-		panic("No idle process for CPU %d", cpuid);
 
 	init_idle(idle, cpuid);
 	unhash_process(idle);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/arm/kernel/sys_arm.c working-2.5.15-clonepid/arch/arm/kernel/sys_arm.c
--- linux-2.5.15/arch/arm/kernel/sys_arm.c	Thu Jul  5 07:56:44 2001
+++ working-2.5.15-clonepid/arch/arm/kernel/sys_arm.c	Mon May 13 14:47:08 2002
@@ -238,7 +238,9 @@
  */
 asmlinkage int sys_fork(struct pt_regs *regs)
 {
-	return do_fork(SIGCHLD, regs->ARM_sp, regs, 0);
+	struct task_struct *p;
+	p = do_fork(SIGCHLD, regs->ARM_sp, regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /* Clone a task - this clones the calling program thread.
@@ -246,14 +248,18 @@
  */
 asmlinkage int sys_clone(unsigned long clone_flags, unsigned long newsp, struct pt_regs *regs)
 {
+	struct task_struct *p;
 	if (!newsp)
 		newsp = regs->ARM_sp;
-	return do_fork(clone_flags, newsp, regs, 0);
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 asmlinkage int sys_vfork(struct pt_regs *regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->ARM_sp, regs, 0);
+	struct task_struct *p;
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->ARM_sp, regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /* sys_execve() executes a new program.
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/cris/kernel/process.c working-2.5.15-clonepid/arch/cris/kernel/process.c
--- linux-2.5.15/arch/cris/kernel/process.c	Wed Feb 20 17:55:58 2002
+++ working-2.5.15-clonepid/arch/cris/kernel/process.c	Mon May 13 14:54:00 2002
@@ -299,7 +299,9 @@
 asmlinkage int sys_fork(long r10, long r11, long r12, long r13, long mof, long srp,
 			struct pt_regs *regs)
 {
-	return do_fork(SIGCHLD, rdusp(), regs, 0);
+	struct task_struct *p;
+	p = do_fork(SIGCHLD, rdusp(), regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /* if newusp is 0, we just grab the old usp */
@@ -308,9 +310,11 @@
 			 long r12, long r13, long mof, long srp,
 			 struct pt_regs *regs)
 {
+	struct task_struct *p;
 	if (!newusp)
 		newusp = rdusp();
-	return do_fork(flags, newusp, regs, 0);
+	p = do_fork(flags & ~CLONE_IDLETASK, newusp, regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /* vfork is a system call in i386 because of register-pressure - maybe
@@ -320,7 +324,9 @@
 asmlinkage int sys_vfork(long r10, long r11, long r12, long r13, long mof, long srp,
 			 struct pt_regs *regs)
 {
-        return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(), regs, 0);
+	struct task_struct *p;
+        p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(), regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/process.c working-2.5.15-clonepid/arch/i386/kernel/process.c
--- linux-2.5.15/arch/i386/kernel/process.c	Mon Apr 29 16:00:17 2002
+++ working-2.5.15-clonepid/arch/i386/kernel/process.c	Mon May 13 14:22:57 2002
@@ -711,11 +711,15 @@
 
 asmlinkage int sys_fork(struct pt_regs regs)
 {
-	return do_fork(SIGCHLD, regs.esp, &regs, 0);
+	struct task_struct *p;
+
+	p = do_fork(SIGCHLD, regs.esp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 asmlinkage int sys_clone(struct pt_regs regs)
 {
+	struct task_struct *p;
 	unsigned long clone_flags;
 	unsigned long newsp;
 
@@ -723,7 +727,8 @@
 	newsp = regs.ecx;
 	if (!newsp)
 		newsp = regs.esp;
-	return do_fork(clone_flags, newsp, &regs, 0);
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
@@ -738,7 +743,10 @@
  */
 asmlinkage int sys_vfork(struct pt_regs regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.esp, &regs, 0);
+	struct task_struct *p;
+
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.esp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/smpboot.c working-2.5.15-clonepid/arch/i386/kernel/smpboot.c
--- linux-2.5.15/arch/i386/kernel/smpboot.c	Mon Apr 15 11:47:10 2002
+++ working-2.5.15-clonepid/arch/i386/kernel/smpboot.c	Mon May 13 14:11:34 2002
@@ -529,14 +529,14 @@
 	unsigned short ss;
 } stack_start;
 
-static int __init fork_by_hand(void)
+static struct task_struct * __init fork_by_hand(void)
 {
 	struct pt_regs regs;
 	/*
 	 * don't care about the eip and regs settings since
 	 * we'll never reschedule the forked task.
 	 */
-	return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 }
 
 /* which physical APIC ID maps to which logical CPU number */
@@ -822,17 +822,14 @@
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
 	 */
-	if (fork_by_hand() < 0)
+	idle = fork_by_hand();
+	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
 
 	/*
 	 * We remove it from the pidhash and the runqueue
 	 * once we got the process:
 	 */
-	idle = prev_task(&init_task);
-	if (!idle)
-		panic("No idle process for CPU %d", cpu);
-
 	init_idle(idle, cpu);
 
 	map_cpu_to_boot_apicid(cpu, apicid);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/ia64/ia32/ia32_entry.S working-2.5.15-clonepid/arch/ia64/ia32/ia32_entry.S
--- linux-2.5.15/arch/ia64/ia32/ia32_entry.S	Thu Mar 21 14:14:38 2002
+++ working-2.5.15-clonepid/arch/ia64/ia32/ia32_entry.S	Mon May 13 14:48:49 2002
@@ -41,7 +41,7 @@
 	mov out3=16				// stacksize (compensates for 16-byte scratch area)
 	adds out2=IA64_SWITCH_STACK_SIZE+16,sp	// out2 = &regs
 	zxt4 out0=in0				// out0 = clone_flags
-	br.call.sptk.many rp=do_fork
+	br.call.sptk.many rp=do_fork_WITHOUT_CLONE_IDLETASK		// FIXME: mask out CLONE_IDLETASK from flags, and return value now task_struct *.
 .ret0:	.restore sp
 	adds sp=IA64_SWITCH_STACK_SIZE,sp	// pop the switch stack
 	mov ar.pfs=loc1
@@ -167,7 +167,7 @@
 	mov out1=0
 	mov out3=0
 	adds out2=IA64_SWITCH_STACK_SIZE+16,sp	// out2 = &regs
-	br.call.sptk.few rp=do_fork
+	br.call.sptk.few rp=do_fork_FIXME_RETURNS_TASK_STRUCT
 .ret5:	mov ar.pfs=loc1
 	.restore sp
 	adds sp=IA64_SWITCH_STACK_SIZE,sp	// pop the switch stack
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/ia64/kernel/entry.S working-2.5.15-clonepid/arch/ia64/kernel/entry.S
--- linux-2.5.15/arch/ia64/kernel/entry.S	Tue Apr 23 11:39:32 2002
+++ working-2.5.15-clonepid/arch/ia64/kernel/entry.S	Mon May 13 15:03:23 2002
@@ -101,7 +101,7 @@
 	mov out3=in2
 	adds out2=IA64_SWITCH_STACK_SIZE+16,sp	// out2 = &regs
 	mov out0=in0				// out0 = clone_flags
-	br.call.sptk.many rp=do_fork
+	br.call.sptk.many rp=do_fork_WITHOUT_CLONE_IDLETASK // FIXME: mask out CLONE_IDLETASK from flags, and now returns task_struct *.
 .ret1:	.restore sp
 	adds sp=IA64_SWITCH_STACK_SIZE,sp	// pop the switch stack
 	mov ar.pfs=loc1
@@ -120,7 +120,7 @@
 	mov out3=16				// stacksize (compensates for 16-byte scratch area)
 	adds out2=IA64_SWITCH_STACK_SIZE+16,sp	// out2 = &regs
 	mov out0=in0				// out0 = clone_flags
-	br.call.sptk.many rp=do_fork
+	br.call.sptk.many rp=do_fork_WITHOUT_CLONE_IDLETASK // FIXME: mask out CLONE_IDLETASK from flags, and now return task_struct *.
 .ret2:	.restore sp
 	adds sp=IA64_SWITCH_STACK_SIZE,sp	// pop the switch stack
 	mov ar.pfs=loc1
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/ia64/kernel/smpboot.c working-2.5.15-clonepid/arch/ia64/kernel/smpboot.c
--- linux-2.5.15/arch/ia64/kernel/smpboot.c	Tue Apr 23 11:39:33 2002
+++ working-2.5.15-clonepid/arch/ia64/kernel/smpboot.c	Mon May 13 14:49:53 2002
@@ -391,14 +391,14 @@
 	return cpu_idle();
 }
 
-static int __init
+static struct task_struct * __init
 fork_by_hand (void)
 {
 	/*
 	 * don't care about the eip and regs settings since
 	 * we'll never reschedule the forked task.
 	 */
-	return do_fork(CLONE_VM|CLONE_PID, 0, 0, 0);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, 0, 0);
 }
 
 static void __init
@@ -412,17 +412,14 @@
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
 	 */
-	if (fork_by_hand() < 0)
+	idle = fork_by_hand();
+	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
 
 	/*
 	 * We remove it from the pidhash and the runqueue
 	 * once we got the process:
 	 */
-	idle = prev_task(&init_task);
-	if (!idle)
-		panic("No idle process for CPU %d", cpu);
-
 	init_idle(idle, cpu);
 
 	ia64_cpu_to_sapicid[cpu] = sapicid;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/m68k/kernel/process.c working-2.5.15-clonepid/arch/m68k/kernel/process.c
--- linux-2.5.15/arch/m68k/kernel/process.c	Mon May 13 12:00:30 2002
+++ working-2.5.15-clonepid/arch/m68k/kernel/process.c	Mon May 13 14:46:05 2002
@@ -177,25 +177,31 @@
 
 asmlinkage int m68k_fork(struct pt_regs *regs)
 {
-	return do_fork(SIGCHLD, rdusp(), regs, 0);
+	struct task_struct *p;
+	p = do_fork(SIGCHLD, rdusp(), regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 asmlinkage int m68k_vfork(struct pt_regs *regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(), regs, 0);
+	struct task_struct *p;
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(), regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 asmlinkage int m68k_clone(struct pt_regs *regs)
 {
 	unsigned long clone_flags;
 	unsigned long newsp;
+	struct task_struct *p;
 
 	/* syscall2 puts clone_flags in d1 and usp in d2 */
 	clone_flags = regs->d1;
 	newsp = regs->d2;
 	if (!newsp)
 		newsp = rdusp();
-	return do_fork(clone_flags, newsp, regs, 0);
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/mips/kernel/smp.c working-2.5.15-clonepid/arch/mips/kernel/smp.c
--- linux-2.5.15/arch/mips/kernel/smp.c	Mon Apr 15 11:47:11 2002
+++ working-2.5.15-clonepid/arch/mips/kernel/smp.c	Mon May 13 14:45:03 2002
@@ -122,8 +122,7 @@
 
 		/* Spawn a new process normally.  Grab a pointer to
 		   its task struct so we can mess with it */
-		do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
-		p = prev_task(&init_task);
+		p = do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 
 		/* Schedule the first task manually */
 		p->processor = i;
@@ -151,7 +150,7 @@
 		 * The following code is purely to make sure
 		 * Linux can schedule processes on this slave.
 		 */
-		kernel_thread(0, NULL, CLONE_PID);
+		kernel_thread(0, NULL, CLONE_IDLETASK);
 		p = prev_task(&init_task);
 		sprintf(p->comm, "%s%d", "Idle", i);
 		init_tasks[i] = p;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/mips/kernel/syscall.c working-2.5.15-clonepid/arch/mips/kernel/syscall.c
--- linux-2.5.15/arch/mips/kernel/syscall.c	Tue Jul  3 06:56:40 2001
+++ working-2.5.15-clonepid/arch/mips/kernel/syscall.c	Mon May 13 14:43:41 2002
@@ -95,10 +95,10 @@
 save_static_function(sys_fork);
 static_unused int _sys_fork(struct pt_regs regs)
 {
-	int res;
+	struct task_struct *p;
 
-	res = do_fork(SIGCHLD, regs.regs[29], &regs, 0);
-	return res;
+	p = do_fork(SIGCHLD, regs.regs[29], &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 
@@ -107,14 +107,14 @@
 {
 	unsigned long clone_flags;
 	unsigned long newsp;
-	int res;
+	struct task_struct *p;
 
 	clone_flags = regs.regs[4];
 	newsp = regs.regs[5];
 	if (!newsp)
 		newsp = regs.regs[29];
-	res = do_fork(clone_flags, newsp, &regs, 0);
-	return res;
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/mips64/kernel/syscall.c working-2.5.15-clonepid/arch/mips64/kernel/syscall.c
--- linux-2.5.15/arch/mips64/kernel/syscall.c	Mon Sep 10 03:43:01 2001
+++ working-2.5.15-clonepid/arch/mips64/kernel/syscall.c	Mon May 13 14:50:50 2002
@@ -77,26 +77,26 @@
 
 asmlinkage int sys_fork(abi64_no_regargs, struct pt_regs regs)
 {
-	int res;
+	struct task_struct *p;
 
 	save_static(&regs);
-	res = do_fork(SIGCHLD, regs.regs[29], &regs, 0);
-	return res;
+	p = do_fork(SIGCHLD, regs.regs[29], &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 asmlinkage int sys_clone(abi64_no_regargs, struct pt_regs regs)
 {
 	unsigned long clone_flags;
 	unsigned long newsp;
-	int res;
+	struct task_struct *p;
 
 	save_static(&regs);
 	clone_flags = regs.regs[4];
 	newsp = regs.regs[5];
 	if (!newsp)
 		newsp = regs.regs[29];
-	res = do_fork(clone_flags, newsp, &regs, 0);
-	return res;
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/mips64/sgi-ip27/ip27-init.c working-2.5.15-clonepid/arch/mips64/sgi-ip27/ip27-init.c
--- linux-2.5.15/arch/mips64/sgi-ip27/ip27-init.c	Thu Mar 21 14:14:41 2002
+++ working-2.5.15-clonepid/arch/mips64/sgi-ip27/ip27-init.c	Mon May 13 14:11:34 2002
@@ -490,7 +490,7 @@
 			 * The following code is purely to make sure
 			 * Linux can schedule processes on this slave.
 			 */
-			kernel_thread(0, NULL, CLONE_PID);
+			kernel_thread(0, NULL, CLONE_IDLETASK);
 			p = prev_task(&init_task);
 			sprintf(p->comm, "%s%d", "Idle", num_cpus);
 			init_tasks[num_cpus] = p;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/parisc/kernel/entry.S working-2.5.15-clonepid/arch/parisc/kernel/entry.S
--- linux-2.5.15/arch/parisc/kernel/entry.S	Wed Feb 20 17:55:59 2002
+++ working-2.5.15-clonepid/arch/parisc/kernel/entry.S	Mon May 13 14:52:32 2002
@@ -500,7 +500,7 @@
 	ldo	CLONE_VM(%r0), %r26   /* Force CLONE_VM since only init_mm */
 	or	%r26, %r24, %r26      /* will have kernel mappings.	 */
 	copy	%r0, %r25
-	bl	do_fork, %r2
+	bl	do_fork_FIXME_NOW_RETURNS_TASK_STRUCT, %r2
 	copy	%r1, %r24
 
 	/* Parent Returns here */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/parisc/kernel/process.c working-2.5.15-clonepid/arch/parisc/kernel/process.c
--- linux-2.5.15/arch/parisc/kernel/process.c	Wed Feb 20 17:55:59 2002
+++ working-2.5.15-clonepid/arch/parisc/kernel/process.c	Mon May 13 14:53:08 2002
@@ -159,14 +159,17 @@
 sys_clone(unsigned long clone_flags, unsigned long usp,
 	  struct pt_regs *regs)
 {
-	return do_fork(clone_flags, usp, regs, 0);
+	struct task_struct *p;
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, usp, regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 int
 sys_vfork(struct pt_regs *regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
-		       regs->gr[30], regs, 0);
+	struct task_struct *p;
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->gr[30], regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 int
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/ppc/kernel/process.c working-2.5.15-clonepid/arch/ppc/kernel/process.c
--- linux-2.5.15/arch/ppc/kernel/process.c	Mon May 13 12:00:32 2002
+++ working-2.5.15-clonepid/arch/ppc/kernel/process.c	Mon May 13 14:25:53 2002
@@ -437,22 +437,28 @@
 int sys_clone(int p1, int p2, int p3, int p4, int p5, int p6,
 	      struct pt_regs *regs)
 {
+ 	struct task_struct *p;
 	CHECK_FULL_REGS(regs);
-	return do_fork(p1, regs->gpr[1], regs, 0);
+ 	p = do_fork(p1 & ~CLONE_IDLETASK, regs->gpr[1], regs, 0);
+ 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 int sys_fork(int p1, int p2, int p3, int p4, int p5, int p6,
 	     struct pt_regs *regs)
 {
+	struct task_struct *p;
 	CHECK_FULL_REGS(regs);
-	return do_fork(SIGCHLD, regs->gpr[1], regs, 0);
+	p = do_fork(SIGCHLD, regs->gpr[1], regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 int sys_vfork(int p1, int p2, int p3, int p4, int p5, int p6,
 	      struct pt_regs *regs)
 {
+	struct task_struct *p;
 	CHECK_FULL_REGS(regs);
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->gpr[1], regs, 0);
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->gpr[1], regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 int sys_execve(unsigned long a0, unsigned long a1, unsigned long a2,
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/ppc/kernel/smp.c working-2.5.15-clonepid/arch/ppc/kernel/smp.c
--- linux-2.5.15/arch/ppc/kernel/smp.c	Mon Apr 15 11:47:12 2002
+++ working-2.5.15-clonepid/arch/ppc/kernel/smp.c	Mon May 13 14:11:34 2002
@@ -343,11 +343,9 @@
 		/* create a process for the processor */
 		/* only regs.msr is actually used, and 0 is OK for it */
 		memset(&regs, 0, sizeof(struct pt_regs));
-		if (do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0) < 0)
+		p = do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
+		if (IS_ERR(p))
 			panic("failed fork for CPU %d", i);
-		p = prev_task(&init_task);
-		if (!p)
-			panic("No idle task for CPU %d", i);
 		init_idle(p, i);
 		unhash_process(p);
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/ppc64/kernel/process.c working-2.5.15-clonepid/arch/ppc64/kernel/process.c
--- linux-2.5.15/arch/ppc64/kernel/process.c	Mon May  6 11:11:52 2002
+++ working-2.5.15-clonepid/arch/ppc64/kernel/process.c	Mon May 13 14:56:00 2002
@@ -256,19 +256,25 @@
 int sys_clone(int p1, int p2, int p3, int p4, int p5, int p6,
 	      struct pt_regs *regs)
 {
-	return do_fork(p1, regs->gpr[1], regs, 0);
+	struct task_struct *p;
+	p = do_fork(p1 & ~CLONE_IDLETASK, regs->gpr[1], regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 int sys_fork(int p1, int p2, int p3, int p4, int p5, int p6,
 	     struct pt_regs *regs)
 {
-	return do_fork(SIGCHLD, regs->gpr[1], regs, 0);
+	struct task_struct *p;
+	p = do_fork(SIGCHLD, regs->gpr[1], regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 int sys_vfork(int p1, int p2, int p3, int p4, int p5, int p6,
 			 struct pt_regs *regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->gpr[1], regs, 0);
+	struct task_struct *p;
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->gpr[1], regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 int sys_execve(unsigned long a0, unsigned long a1, unsigned long a2,
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/ppc64/kernel/smp.c working-2.5.15-clonepid/arch/ppc64/kernel/smp.c
--- linux-2.5.15/arch/ppc64/kernel/smp.c	Mon May  6 11:11:52 2002
+++ working-2.5.15-clonepid/arch/ppc64/kernel/smp.c	Mon May 13 14:56:18 2002
@@ -640,11 +640,9 @@
 
 		memset(&regs, 0, sizeof(struct pt_regs));
 
-		if (do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0) < 0)
+		p = do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
+		if (IS_ERR(p))
 			panic("failed fork for CPU %d", i);
-		p = prev_task(&init_task);
-		if (!p)
-			panic("No idle task for CPU %d", i);
 
 		init_idle(p, i);
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/s390/kernel/process.c working-2.5.15-clonepid/arch/s390/kernel/process.c
--- linux-2.5.15/arch/s390/kernel/process.c	Wed Feb 20 17:56:00 2002
+++ working-2.5.15-clonepid/arch/s390/kernel/process.c	Mon May 13 14:51:29 2002
@@ -332,19 +332,23 @@
 
 asmlinkage int sys_fork(struct pt_regs regs)
 {
-        return do_fork(SIGCHLD, regs.gprs[15], &regs, 0);
+	struct task_struct *p;
+        p = do_fork(SIGCHLD, regs.gprs[15], &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 asmlinkage int sys_clone(struct pt_regs regs)
 {
         unsigned long clone_flags;
         unsigned long newsp;
+	struct task_struct *p;
 
         clone_flags = regs.gprs[3];
         newsp = regs.orig_gpr2;
         if (!newsp)
                 newsp = regs.gprs[15];
-        return do_fork(clone_flags, newsp, &regs, 0);
+        p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
@@ -359,8 +363,9 @@
  */
 asmlinkage int sys_vfork(struct pt_regs regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
-                       regs.gprs[15], &regs, 0);
+	struct task_struct *p;
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.gprs[15], &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/s390/kernel/smp.c working-2.5.15-clonepid/arch/s390/kernel/smp.c
--- linux-2.5.15/arch/s390/kernel/smp.c	Thu Mar 21 14:14:41 2002
+++ working-2.5.15-clonepid/arch/s390/kernel/smp.c	Mon May 13 14:52:17 2002
@@ -505,13 +505,13 @@
 {
 }
 
-static int __init fork_by_hand(void)
+static struct task_struct *__init fork_by_hand(void)
 {
        struct pt_regs regs;
        /* don't care about the psw and regs settings since we'll never
           reschedule the forked task. */
        memset(&regs,0,sizeof(struct pt_regs));
-       return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
+       return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 }
 
 static void __init do_boot_cpu(int cpu)
@@ -521,16 +521,14 @@
 
         /* We can't use kernel_thread since we must _avoid_ to reschedule
            the child. */
-        if (fork_by_hand() < 0)
+        idle = fork_by_hand();
+	if (IS_ERR(idle))
                 panic("failed fork for CPU %d", cpu);
 
         /*
          * We remove it from the pidhash and the runqueue
          * once we got the process:
          */
-        idle = prev_task(&init_task);
-        if (!idle)
-                panic("No idle process for CPU %d",cpu);
         idle->processor = cpu;
 	idle->cpus_runnable = 1 << cpu; /* we schedule the first task manually */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/s390x/kernel/process.c working-2.5.15-clonepid/arch/s390x/kernel/process.c
--- linux-2.5.15/arch/s390x/kernel/process.c	Wed Feb 20 17:56:00 2002
+++ working-2.5.15-clonepid/arch/s390x/kernel/process.c	Mon May 13 14:54:47 2002
@@ -331,19 +331,23 @@
 
 asmlinkage int sys_fork(struct pt_regs regs)
 {
-        return do_fork(SIGCHLD, regs.gprs[15], &regs, 0);
+	struct task_struct *p;
+        p = do_fork(SIGCHLD, regs.gprs[15], &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 asmlinkage int sys_clone(struct pt_regs regs)
 {
         unsigned long clone_flags;
         unsigned long newsp;
+	struct task_struct *p;
 
         clone_flags = regs.gprs[3];
         newsp = regs.orig_gpr2;
         if (!newsp)
                 newsp = regs.gprs[15];
-        return do_fork(clone_flags, newsp, &regs, 0);
+        p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
@@ -358,8 +362,9 @@
  */
 asmlinkage int sys_vfork(struct pt_regs regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
-                       regs.gprs[15], &regs, 0);
+	struct task_struct *p;
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.gprs[15], &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/s390x/kernel/smp.c working-2.5.15-clonepid/arch/s390x/kernel/smp.c
--- linux-2.5.15/arch/s390x/kernel/smp.c	Thu Mar 21 14:14:41 2002
+++ working-2.5.15-clonepid/arch/s390x/kernel/smp.c	Mon May 13 14:55:17 2002
@@ -484,13 +484,13 @@
 {
 }
 
-static int __init fork_by_hand(void)
+static struct task_struct * __init fork_by_hand(void)
 {
        struct pt_regs regs;
        /* don't care about the psw and regs settings since we'll never
           reschedule the forked task. */
        memset(&regs,0,sizeof(struct pt_regs));
-       return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
+       return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 }
 
 static void __init do_boot_cpu(int cpu)
@@ -500,16 +500,14 @@
 
         /* We can't use kernel_thread since we must _avoid_ to reschedule
            the child. */
-        if (fork_by_hand() < 0)
+        idle = fork_by_hand();
+	if (IS_ERR(idle))
                 panic("failed fork for CPU %d", cpu);
 
         /*
          * We remove it from the pidhash and the runqueue
          * once we got the process:
          */
-        idle = prev_task(&init_task);
-        if (!idle)
-                panic("No idle process for CPU %d",cpu);
         idle->processor = cpu;
 	idle->cpus_runnable = 1 << cpu; /* we schedule the first task manually */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/sh/kernel/process.c working-2.5.15-clonepid/arch/sh/kernel/process.c
--- linux-2.5.15/arch/sh/kernel/process.c	Wed Feb 20 17:56:00 2002
+++ working-2.5.15-clonepid/arch/sh/kernel/process.c	Mon May 13 14:48:00 2002
@@ -276,16 +276,20 @@
 			unsigned long r6, unsigned long r7,
 			struct pt_regs regs)
 {
-	return do_fork(SIGCHLD, regs.regs[15], &regs, 0);
+	struct task_struct *p;
+	p = do_fork(SIGCHLD, regs.regs[15], &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 asmlinkage int sys_clone(unsigned long clone_flags, unsigned long newsp,
 			 unsigned long r6, unsigned long r7,
 			 struct pt_regs regs)
 {
+	struct task_struct *p;
 	if (!newsp)
 		newsp = regs.regs[15];
-	return do_fork(clone_flags, newsp, &regs, 0);
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
@@ -302,7 +306,9 @@
 			 unsigned long r6, unsigned long r7,
 			 struct pt_regs regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.regs[15], &regs, 0);
+	struct task_struct *p;
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.regs[15], &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/sparc/kernel/entry.S working-2.5.15-clonepid/arch/sparc/kernel/entry.S
--- linux-2.5.15/arch/sparc/kernel/entry.S	Wed Nov 14 04:16:05 2001
+++ working-2.5.15-clonepid/arch/sparc/kernel/entry.S	Mon May 13 15:03:23 2002
@@ -1393,7 +1393,7 @@
 	std	%g4, [%curptr + AOFF_task_thread + AOFF_thread_fork_kpsr]
 	add	%sp, REGWIN_SZ, %o2		! arg2:	pt_regs ptr
 	mov	0, %o3
-	call	C_LABEL(do_fork)
+	call	C_LABEL(do_fork_FIXME_NOW_RETURNS_TASK_STRUCT)
 	 mov	%l5, %o7
 	
 	/* Whee, kernel threads! */
@@ -1416,7 +1416,8 @@
 	std	%g4, [%curptr + AOFF_task_thread + AOFF_thread_fork_kpsr]
 	add	%sp, REGWIN_SZ, %o2		! arg2:	pt_regs ptr
 	mov	0, %o3
-	call	C_LABEL(do_fork)
+	/* FIXME:	remove CLONE_IDLETASK from flags first */
+	call	C_LABEL(do_fork_WITHOUT_CLONE_IDLETASK)
 	 mov	%l5, %o7
 
 	/* Whee, real vfork! */
@@ -1432,9 +1433,9 @@
 	sethi	%hi(0x4000 | 0x0100 | SIGCHLD), %o0
 	mov	%fp, %o1
 	or	%o0, %lo(0x4000 | 0x0100 | SIGCHLD), %o0
-	sethi	%hi(C_LABEL(do_fork)), %l1
+	sethi	%hi(C_LABEL(do_fork_FIXME_NOW_RETURNS_TASK_STRUCT)), %l1
 	mov	0, %o3
-	jmpl	%l1 + %lo(C_LABEL(do_fork)), %g0
+	jmpl	%l1 + %lo(C_LABEL(do_fork_FIXME_NOW_RETURNS_TASK_STRUCT)), %g0
 	 add	%sp, REGWIN_SZ, %o2
 
         .align  4
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/sparc/kernel/sun4d_smp.c working-2.5.15-clonepid/arch/sparc/kernel/sun4d_smp.c
--- linux-2.5.15/arch/sparc/kernel/sun4d_smp.c	Mon May  6 16:00:09 2002
+++ working-2.5.15-clonepid/arch/sparc/kernel/sun4d_smp.c	Mon May 13 14:11:34 2002
@@ -214,7 +214,7 @@
 			int no;
 
 			/* Cook up an idler for this guy. */
-			kernel_thread(start_secondary, NULL, CLONE_PID);
+			kernel_thread(start_secondary, NULL, CLONE_IDLETASK);
 
 			cpucount++;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/sparc/kernel/sun4m_smp.c working-2.5.15-clonepid/arch/sparc/kernel/sun4m_smp.c
--- linux-2.5.15/arch/sparc/kernel/sun4m_smp.c	Mon May  6 16:00:09 2002
+++ working-2.5.15-clonepid/arch/sparc/kernel/sun4m_smp.c	Mon May 13 14:11:34 2002
@@ -187,7 +187,7 @@
 			int timeout;
 
 			/* Cook up an idler for this guy. */
-			kernel_thread(start_secondary, NULL, CLONE_PID);
+			kernel_thread(start_secondary, NULL, CLONE_IDLETASK);
 
 			cpucount++;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/sparc64/kernel/entry.S working-2.5.15-clonepid/arch/sparc64/kernel/entry.S
--- linux-2.5.15/arch/sparc64/kernel/entry.S	Mon May  6 11:11:52 2002
+++ working-2.5.15-clonepid/arch/sparc64/kernel/entry.S	Mon May 13 14:46:22 2002
@@ -1429,7 +1429,7 @@
 sys_clone:	flushw
 		movrz		%o1, %fp, %o1
 		mov		0, %o3
-		ba,pt		%xcc, do_fork
+		ba,pt		%xcc, do_fork_FIXME_NOW_RETURNS_TASK_STRUCT
 		 add		%sp, STACK_BIAS + REGWIN_SZ, %o2
 ret_from_syscall:
 		/* Clear SPARC_FLAG_NEWCHILD, switch_to leaves thread.flags in
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/sparc64/kernel/smp.c working-2.5.15-clonepid/arch/sparc64/kernel/smp.c
--- linux-2.5.15/arch/sparc64/kernel/smp.c	Mon May  6 11:11:52 2002
+++ working-2.5.15-clonepid/arch/sparc64/kernel/smp.c	Mon May 13 14:11:34 2002
@@ -268,7 +268,7 @@
 			int no;
 
 			prom_printf("Starting CPU %d... ", i);
-			kernel_thread(NULL, NULL, CLONE_PID);
+			kernel_thread(NULL, NULL, CLONE_IDLETASK);
 			cpucount++;
 
 			p = prev_task(&init_task);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/x86_64/ia32/sys_ia32.c working-2.5.15-clonepid/arch/x86_64/ia32/sys_ia32.c
--- linux-2.5.15/arch/x86_64/ia32/sys_ia32.c	Tue Apr 23 11:39:33 2002
+++ working-2.5.15-clonepid/arch/x86_64/ia32/sys_ia32.c	Mon May 13 14:56:53 2002
@@ -2683,14 +2683,18 @@
 
 asmlinkage int sys32_fork(struct pt_regs regs)
 {
-	return do_fork(SIGCHLD, regs.rsp, &regs, 0);
+	struct task_struct *p;
+	p = do_fork(SIGCHLD, regs.rsp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 asmlinkage int sys32_clone(unsigned int clone_flags, unsigned int newsp, struct pt_regs regs)
 {
+	struct task_struct *p;
 	if (!newsp)
 		newsp = regs.rsp;
-	return do_fork(clone_flags, newsp, &regs, 0);
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
@@ -2705,7 +2709,9 @@
  */
 asmlinkage int sys32_vfork(struct pt_regs regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.rsp, &regs, 0);
+	struct task_struct *p;
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.rsp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/x86_64/kernel/entry.S working-2.5.15-clonepid/arch/x86_64/kernel/entry.S
--- linux-2.5.15/arch/x86_64/kernel/entry.S	Tue Apr 23 11:39:33 2002
+++ working-2.5.15-clonepid/arch/x86_64/kernel/entry.S	Mon May 13 14:57:08 2002
@@ -570,7 +570,7 @@
 	movq %rsp, %rdx
 
 	# clone now
-	call do_fork
+	call do_fork_FIXME_NOW_RETURNS_TASK_STRUCT
 	# save retval on the stack so it's popped before `ret`
 	movq %rax, RAX(%rsp)
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/x86_64/kernel/process.c working-2.5.15-clonepid/arch/x86_64/kernel/process.c
--- linux-2.5.15/arch/x86_64/kernel/process.c	Tue Apr 23 11:39:33 2002
+++ working-2.5.15-clonepid/arch/x86_64/kernel/process.c	Mon May 13 14:58:02 2002
@@ -608,14 +608,18 @@
 
 asmlinkage long sys_fork(struct pt_regs regs)
 {
-	return do_fork(SIGCHLD, regs.rsp, &regs, 0);
+	struct task_struct *p;
+	p = do_fork(SIGCHLD, regs.rsp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 asmlinkage long sys_clone(unsigned long clone_flags, unsigned long newsp, struct pt_regs regs)
 {
+	struct task_struct *p;
 	if (!newsp)
 		newsp = regs.rsp;
-	return do_fork(clone_flags, newsp, &regs, 0);
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
@@ -630,7 +634,9 @@
  */
 asmlinkage long sys_vfork(struct pt_regs regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.rsp, &regs, 0);
+	struct task_struct *p;
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.rsp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/x86_64/kernel/smpboot.c working-2.5.15-clonepid/arch/x86_64/kernel/smpboot.c
--- linux-2.5.15/arch/x86_64/kernel/smpboot.c	Tue Apr 23 11:39:33 2002
+++ working-2.5.15-clonepid/arch/x86_64/kernel/smpboot.c	Mon May 13 14:58:29 2002
@@ -476,14 +476,14 @@
 extern volatile unsigned long init_rsp; 
 extern void (*initial_code)(void);
 
-static int __init fork_by_hand(void)
+static struct task_struct * __init fork_by_hand(void)
 {
 	struct pt_regs regs;
 	/*
 	 * don't care about the rip and regs settings since
 	 * we'll never reschedule the forked task.
 	 */
-	return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 }
 
 #if APIC_DEBUG
@@ -538,17 +538,14 @@
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
 	 */
-	if (fork_by_hand() < 0)
+	idle = fork_by_hand();
+	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
 
 	/*
 	 * We remove it from the pidhash and the runqueue
 	 * once we got the process:
 	 */
-	idle = prev_task(&init_task);
-	if (!idle)
-		panic("No idle process for CPU %d", cpu);
-
 	init_idle(idle,cpu);
 
 	x86_cpu_to_apicid[cpu] = apicid;
