Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269837AbSISDWF>; Wed, 18 Sep 2002 23:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269851AbSISDWF>; Wed, 18 Sep 2002 23:22:05 -0400
Received: from crack.them.org ([65.125.64.184]:26639 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S269837AbSISDV7>;
	Wed, 18 Sep 2002 23:21:59 -0400
Date: Wed, 18 Sep 2002 23:27:01 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       linux-kernel@vger.kernel.org
Subject: ptrace() event tracing [2/3]
Message-ID: <20020919032701.GA1762@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's part 2/3, CLONE_UNTRACED, improved.

diff -Nru a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
--- a/arch/alpha/kernel/entry.S	Tue Sep 17 20:29:37 2002
+++ b/arch/alpha/kernel/entry.S	Tue Sep 17 20:29:37 2002
@@ -213,7 +213,7 @@
 	stq	$2, 152($30)		/* HAE */
 
 	/* Shuffle FLAGS to the front; add CLONE_VM.  */
-	ldi	$1, CLONE_VM
+	ldi	$1, CLONE_VM|CLONE_UNTRACED
 	or	$18, $1, $16
 	bsr	$26, sys_clone
 
diff -Nru a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
--- a/arch/arm/kernel/process.c	Tue Sep 17 20:29:37 2002
+++ b/arch/arm/kernel/process.c	Tue Sep 17 20:29:37 2002
@@ -396,7 +396,7 @@
 	b	sys_exit					\n\
 1:	"
         : "=r" (__ret)
-        : "Ir" (flags), "I" (CLONE_VM), "r" (fn), "r" (arg)
+        : "Ir" (flags), "I" (CLONE_VM | CLONE_UNTRACED), "r" (fn), "r" (arg)
 	: "r0", "r1", "lr");
 	return __ret;
 }
diff -Nru a/arch/cris/kernel/entry.S b/arch/cris/kernel/entry.S
--- a/arch/cris/kernel/entry.S	Tue Sep 17 20:29:37 2002
+++ b/arch/cris/kernel/entry.S	Tue Sep 17 20:29:37 2002
@@ -748,6 +748,7 @@
 	/* r11 is argument 2 to clone, the flags */
 	move.d  $r12, $r11
 	or.w	LCLONE_VM, $r11
+	or.w	LCLONE_UNTRACED, $r11
 
 	/* Save FN for later.  */
 	move.d	$r10, $r12
diff -Nru a/arch/cris/kernel/entryoffsets.c b/arch/cris/kernel/entryoffsets.c
--- a/arch/cris/kernel/entryoffsets.c	Tue Sep 17 20:29:37 2002
+++ b/arch/cris/kernel/entryoffsets.c	Tue Sep 17 20:29:37 2002
@@ -57,5 +57,6 @@
 
 /* linux/sched.h values - doesn't have an #ifdef __ASSEMBLY__ for these.  */
 VAL (LCLONE_VM, CLONE_VM)
+VAL (LCLONE_UNTRACED, CLONE_UNTRACED)
 
 __asm__ (".endif");
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Tue Sep 17 20:29:37 2002
+++ b/arch/i386/kernel/process.c	Tue Sep 17 20:29:37 2002
@@ -504,7 +504,7 @@
 	regs.eflags = 0x286;
 
 	/* Ok, create the new process.. */
-	p = do_fork(flags | CLONE_VM, 0, &regs, 0, NULL);
+	p = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
diff -Nru a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
--- a/arch/ia64/kernel/process.c	Tue Sep 17 20:29:37 2002
+++ b/arch/ia64/kernel/process.c	Tue Sep 17 20:29:37 2002
@@ -509,7 +509,7 @@
 	struct task_struct *parent = current;
 	int result, tid;
 
-	tid = clone(flags | CLONE_VM, 0);
+	tid = clone(flags | CLONE_VM | CLONE_UNTRACED, 0);
 	if (parent != current) {
 		result = (*fn)(arg);
 		_exit(result);
diff -Nru a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
--- a/arch/m68k/kernel/process.c	Tue Sep 17 20:29:37 2002
+++ b/arch/m68k/kernel/process.c	Tue Sep 17 20:29:37 2002
@@ -152,7 +152,7 @@
 
 	{
 	register long retval __asm__ ("d0");
-	register long clone_arg __asm__ ("d1") = flags | CLONE_VM;
+	register long clone_arg __asm__ ("d1") = flags | CLONE_VM | CLONE_UNTRACED;
 
 	retval = __NR_clone;
 	__asm__ __volatile__
diff -Nru a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
--- a/arch/mips/kernel/process.c	Tue Sep 17 20:29:37 2002
+++ b/arch/mips/kernel/process.c	Tue Sep 17 20:29:37 2002
@@ -176,7 +176,7 @@
 		:"=r" (retval)
 		:"i" (__NR_clone), "i" (__NR_exit),
 		 "r" (arg), "r" (fn),
-		 "r" (flags | CLONE_VM)
+		 "r" (flags | CLONE_VM | CLONE_UNTRACED)
 		 /*
 		  * The called subroutine might have destroyed any of the
 		  * at, result, argument or temporary registers ...
diff -Nru a/arch/mips64/kernel/process.c b/arch/mips64/kernel/process.c
--- a/arch/mips64/kernel/process.c	Tue Sep 17 20:29:37 2002
+++ b/arch/mips64/kernel/process.c	Tue Sep 17 20:29:37 2002
@@ -167,7 +167,7 @@
 		"1:\tmove\t%0, $2"
 		:"=r" (retval)
 		:"i" (__NR_clone), "i" (__NR_exit), "r" (arg), "r" (fn),
-		 "r" (flags | CLONE_VM)
+		 "r" (flags | CLONE_VM | CLONE_UNTRACED)
 
 		 /* The called subroutine might have destroyed any of the
 		  * at, result, argument or temporary registers ...  */
diff -Nru a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
--- a/arch/parisc/kernel/entry.S	Tue Sep 17 20:29:37 2002
+++ b/arch/parisc/kernel/entry.S	Tue Sep 17 20:29:37 2002
@@ -482,6 +482,7 @@
 	 */
 
 #define CLONE_VM 0x100	/* Must agree with <linux/sched.h> */
+#define CLONE_UNTRACED 0x00800000
 
 	.export __kernel_thread, code
 	.import do_fork
@@ -497,7 +498,8 @@
 #endif
 	STREG	%r26, PT_GR26(%r1)  /* Store function & argument for child */
 	STREG	%r25, PT_GR25(%r1)
-	ldo	CLONE_VM(%r0), %r26   /* Force CLONE_VM since only init_mm */
+	ldil	L%CLONE_UNTRACED, %r26
+	ldo	CLONE_VM(%r26), %r26   /* Force CLONE_VM since only init_mm */
 	or	%r26, %r24, %r26      /* will have kernel mappings.	 */
 	copy	%r0, %r25
 	bl	do_fork_FIXME_NOW_RETURNS_TASK_STRUCT, %r2
diff -Nru a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S	Tue Sep 17 20:29:37 2002
+++ b/arch/ppc/kernel/misc.S	Tue Sep 17 20:29:37 2002
@@ -1023,6 +1023,7 @@
 	mr	r30,r3		/* function */
 	mr	r31,r4		/* argument */
 	ori	r3,r5,CLONE_VM	/* flags */
+	oris	r3,r3,CLONE_UNTRACED>>16
 	li	r0,__NR_clone
 	sc
 	cmpi	0,r3,0		/* parent or child? */
diff -Nru a/arch/ppc64/kernel/misc.S b/arch/ppc64/kernel/misc.S
--- a/arch/ppc64/kernel/misc.S	Tue Sep 17 20:29:37 2002
+++ b/arch/ppc64/kernel/misc.S	Tue Sep 17 20:29:37 2002
@@ -485,6 +485,7 @@
 	/* XXX fix this when we optimise syscall entry to not save volatiles */
 	mr	r6,r3		/* function */
 	ori	r3,r5,CLONE_VM	/* flags */
+	oris	r3,r3,(CLONE_UNTRACED>>16)
 	li	r0,__NR_clone
 	sc
 	cmpi	0,r3,0		/* parent or child? */
diff -Nru a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
--- a/arch/s390/kernel/process.c	Tue Sep 17 20:29:37 2002
+++ b/arch/s390/kernel/process.c	Tue Sep 17 20:29:37 2002
@@ -123,7 +123,7 @@
 
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
-        int clone_arg = flags | CLONE_VM;
+        int clone_arg = flags | CLONE_VM | CLONE_UNTRACED;
         int retval;
 
         __asm__ __volatile__(
diff -Nru a/arch/s390x/kernel/process.c b/arch/s390x/kernel/process.c
--- a/arch/s390x/kernel/process.c	Tue Sep 17 20:29:37 2002
+++ b/arch/s390x/kernel/process.c	Tue Sep 17 20:29:37 2002
@@ -120,7 +120,7 @@
 
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
-        int clone_arg = flags | CLONE_VM;
+        int clone_arg = flags | CLONE_VM | CLONE_UNTRACED;
         int retval;
 
         __asm__ __volatile__(
diff -Nru a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
--- a/arch/sh/kernel/process.c	Tue Sep 17 20:29:37 2002
+++ b/arch/sh/kernel/process.c	Tue Sep 17 20:29:37 2002
@@ -120,7 +120,7 @@
 {	/* Don't use this in BL=1(cli).  Or else, CPU resets! */
 	register unsigned long __sc0 __asm__ ("r0");
 	register unsigned long __sc3 __asm__ ("r3") = __NR_clone;
-	register unsigned long __sc4 __asm__ ("r4") = (long) flags | CLONE_VM;
+	register unsigned long __sc4 __asm__ ("r4") = (long) flags | CLONE_VM | CLONE_UNTRACED;
 	register unsigned long __sc5 __asm__ ("r5") = 0;
 	register unsigned long __sc8 __asm__ ("r8") = (long) arg;
 	register unsigned long __sc9 __asm__ ("r9") = (long) fn;
diff -Nru a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
--- a/arch/sparc/kernel/process.c	Tue Sep 17 20:29:37 2002
+++ b/arch/sparc/kernel/process.c	Tue Sep 17 20:29:37 2002
@@ -726,7 +726,7 @@
 			   /* Notreached by child. */
 			   "1: mov %%o0, %0\n\t" :
 			   "=r" (retval) :
-			   "i" (__NR_clone), "r" (flags | CLONE_VM),
+			   "i" (__NR_clone), "r" (flags | CLONE_VM | CLONE_UNTRACED),
 			   "i" (__NR_exit),  "r" (fn), "r" (arg) :
 			   "g1", "g2", "g3", "o0", "o1", "memory", "cc");
 	return retval;
diff -Nru a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
--- a/arch/sparc64/kernel/process.c	Tue Sep 17 20:29:37 2002
+++ b/arch/sparc64/kernel/process.c	Tue Sep 17 20:29:37 2002
@@ -694,7 +694,7 @@
 			   /* Notreached by child. */
 			   "1:" :
 			   "=r" (retval) :
-			   "i" (__NR_clone), "r" (flags | CLONE_VM),
+			   "i" (__NR_clone), "r" (flags | CLONE_VM | CLONE_UNTRACED),
 			   "i" (__NR_exit),  "r" (fn), "r" (arg) :
 			   "g1", "g2", "g3", "o0", "o1", "memory", "cc");
 	return retval;
diff -Nru a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
--- a/arch/x86_64/kernel/process.c	Tue Sep 17 20:29:37 2002
+++ b/arch/x86_64/kernel/process.c	Tue Sep 17 20:29:37 2002
@@ -58,7 +58,7 @@
 
 asmlinkage extern void ret_from_fork(void);
 
-unsigned long kernel_thread_flags = CLONE_VM;
+unsigned long kernel_thread_flags = CLONE_VM | CLONE_UNTRACED;
 
 int hlt_counter;
 
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Tue Sep 17 20:29:37 2002
+++ b/include/linux/sched.h	Tue Sep 17 20:29:37 2002
@@ -50,6 +50,7 @@
 #define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
 #define CLONE_CLEARTID	0x00200000	/* clear the userspace TID */
 #define CLONE_DETACHED	0x00400000	/* parent wants no child-exit signal */
+#define CLONE_UNTRACED  0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
 
 /*
  * List of flags we want to share for kernel threads,
diff -Nru a/arch/alpha/kernel/asm-offsets.c b/arch/alpha/kernel/asm-offsets.c
--- a/arch/alpha/kernel/asm-offsets.c	Wed Sep 18 23:18:07 2002
+++ b/arch/alpha/kernel/asm-offsets.c	Wed Sep 18 23:18:07 2002
@@ -22,6 +22,7 @@
 	BLANK();
 	DEFINE(PT_PTRACED, PT_PTRACED);
 	DEFINE(CLONE_VM, CLONE_VM);
+	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
 	DEFINE(SIGCHLD, SIGCHLD);
 	BLANK();
 	DEFINE(HAE_CACHE, offsetof(struct alpha_machine_vector, hae_cache));
diff -Nru a/arch/ppc/kernel/mk_defs.c b/arch/ppc/kernel/mk_defs.c
--- a/arch/ppc/kernel/mk_defs.c	Wed Sep 18 23:18:07 2002
+++ b/arch/ppc/kernel/mk_defs.c	Wed Sep 18 23:18:07 2002
@@ -116,6 +116,7 @@
 	DEFINE(RESULT, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, result));
 	DEFINE(TRAP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, trap));
 	DEFINE(CLONE_VM, CLONE_VM);
+	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
 	DEFINE(MM_PGD, offsetof(struct mm_struct, pgd));
 
 	/* About the CPU features table */
diff -Nru a/arch/ppc64/kernel/mk_defs.c b/arch/ppc64/kernel/mk_defs.c
--- a/arch/ppc64/kernel/mk_defs.c	Wed Sep 18 23:18:07 2002
+++ b/arch/ppc64/kernel/mk_defs.c	Wed Sep 18 23:18:07 2002
@@ -157,6 +157,7 @@
 	DEFINE(_SRR1, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs)+8);
 
 	DEFINE(CLONE_VM, CLONE_VM);
+	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
 
 	return 0;
 }


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
