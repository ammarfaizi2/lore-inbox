Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132636AbRDONIA>; Sun, 15 Apr 2001 09:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132651AbRDONHv>; Sun, 15 Apr 2001 09:07:51 -0400
Received: from colorfullife.com ([216.156.138.34]:30726 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132636AbRDONHe>;
	Sun, 15 Apr 2001 09:07:34 -0400
Message-ID: <3AD99CE4.E1ED7090@colorfullife.com>
Date: Sun, 15 Apr 2001 15:06:44 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Rod Stewart <stewart@dystopia.lab43.org>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>
Subject: [new PATCH] Re: 8139too: defunct threads
In-Reply-To: <Pine.LNX.4.33.0104150100210.13758-100000@dystopia.lab43.org>
Content-Type: multipart/mixed;
 boundary="------------DE1890DE7E5BD7D6D7A75795"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DE1890DE7E5BD7D6D7A75795
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I found the problem:

* init uses waitpid(-1,,), thus the __WALL flag is not set
* without __WALL, only processes with exit_signal == SIGCHLD are reaped
* it's impossible for user space processes to die with another
exit_signal, forget_original_parent changes the exit_signal back to
SIGCHLD ("We dont want people slaying init"), and init itself doesn't
use clone.
* kernel threads can die with an arbitrary exit_signal.

Alan, which fix would you prefer:
* init could use wait3 and set __WALL.
* all kernel thread users could set SIGCHLD. Some already do that
(__call_usermodehelper).
* the kernel_thread implementations could force the exit signal to
SIGCHLD.

I'd prefer the last version. 
The attached patch is tested with i386. The alpha, parisc and ppc
assember changes are guessed.

--
	Manfred
--------------DE1890DE7E5BD7D6D7A75795
Content-Type: text/plain; charset=us-ascii;
 name="patch-child"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-child"

diff -ur 2.4/arch/alpha/kernel/entry.S build-2.4/arch/alpha/kernel/entry.S
--- 2.4/arch/alpha/kernel/entry.S	Sun Sep  3 20:36:45 2000
+++ build-2.4/arch/alpha/kernel/entry.S	Sun Apr 15 14:58:01 2001
@@ -242,12 +242,12 @@
 	subq	$30,4*8,$30
 	stq	$10,16($30)
 	stq	$9,8($30)
-	lda	$0,CLONE_VM
+	lda	$0,CLONE_VM|SIGCHLD
 	stq	$26,0($30)
 	.prologue 1
 	mov	$16,$9		/* save fn */		
 	mov	$17,$10		/* save arg */
-	or	$18,$0,$16	/* shuffle flags to front; add CLONE_VM.  */
+	or	$18,$0,$16	/* shuffle flags to front; add CLONE_VM|SIGCHLD. */
 	bsr	$26,kernel_clone
 	bne	$20,1f		/* $20 is non-zero in child */
 	ldq	$26,0($30)
diff -ur 2.4/arch/arm/kernel/process.c build-2.4/arch/arm/kernel/process.c
--- 2.4/arch/arm/kernel/process.c	Thu Feb 22 22:28:51 2001
+++ build-2.4/arch/arm/kernel/process.c	Sun Apr 15 14:51:08 2001
@@ -368,6 +368,8 @@
 {
 	pid_t __ret;
 
+	flags |= SIGCHLD;
+
 	__asm__ __volatile__(
 	"orr	r0, %1, %2	@ kernel_thread sys_clone
 	mov	r1, #0
diff -ur 2.4/arch/cris/kernel/process.c build-2.4/arch/cris/kernel/process.c
--- 2.4/arch/cris/kernel/process.c	Sat Apr  7 22:01:49 2001
+++ build-2.4/arch/cris/kernel/process.c	Sun Apr 15 14:51:16 2001
@@ -127,6 +127,8 @@
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
 	register long __a __asm__ ("r10");
+
+	flags |= SIGCHLD;
 	
 	__asm__ __volatile__
 		("movu.w %1,r9\n\t"     /* r9 contains syscall number, to sys_clone */
diff -ur 2.4/arch/i386/kernel/process.c build-2.4/arch/i386/kernel/process.c
--- 2.4/arch/i386/kernel/process.c	Thu Feb 22 22:28:52 2001
+++ build-2.4/arch/i386/kernel/process.c	Sun Apr 15 14:40:43 2001
@@ -440,6 +440,8 @@
 {
 	long retval, d0;
 
+	flags |= SIGCHLD;
+
 	__asm__ __volatile__(
 		"movl %%esp,%%esi\n\t"
 		"int $0x80\n\t"		/* Linux/i386 system call */
diff -ur 2.4/arch/ia64/kernel/process.c build-2.4/arch/ia64/kernel/process.c
--- 2.4/arch/ia64/kernel/process.c	Thu Jan  4 21:50:17 2001
+++ build-2.4/arch/ia64/kernel/process.c	Sun Apr 15 14:51:44 2001
@@ -500,7 +500,7 @@
 	struct task_struct *parent = current;
 	int result, tid;
 
-	tid = clone(flags | CLONE_VM, 0);
+	tid = clone(flags | CLONE_VM | SIGCHLD, 0);
 	if (parent != current) {
 		result = (*fn)(arg);
 		_exit(result);
diff -ur 2.4/arch/m68k/kernel/process.c build-2.4/arch/m68k/kernel/process.c
--- 2.4/arch/m68k/kernel/process.c	Thu Feb 22 22:28:54 2001
+++ build-2.4/arch/m68k/kernel/process.c	Sun Apr 15 14:51:58 2001
@@ -135,7 +135,7 @@
 
 	{
 	register long retval __asm__ ("d0");
-	register long clone_arg __asm__ ("d1") = flags | CLONE_VM;
+	register long clone_arg __asm__ ("d1") = flags | CLONE_VM | SIGCHLD;
 
 	__asm__ __volatile__
 	  ("clrl %%d2\n\t"
diff -ur 2.4/arch/mips/kernel/process.c build-2.4/arch/mips/kernel/process.c
--- 2.4/arch/mips/kernel/process.c	Sat Apr  7 22:01:56 2001
+++ build-2.4/arch/mips/kernel/process.c	Sun Apr 15 14:52:12 2001
@@ -161,6 +161,8 @@
 {
 	long retval;
 
+	flags |= SIGCHLD;
+
 	__asm__ __volatile__(
 		".set\tnoreorder\n\t"
 		"move\t$6,$sp\n\t"
diff -ur 2.4/arch/mips64/kernel/process.c build-2.4/arch/mips64/kernel/process.c
--- 2.4/arch/mips64/kernel/process.c	Thu Feb 22 22:28:55 2001
+++ build-2.4/arch/mips64/kernel/process.c	Sun Apr 15 14:52:21 2001
@@ -154,6 +154,8 @@
 {
 	int retval;
 
+	flags |= SIGCHLD;
+
 	__asm__ __volatile__(
 		"move\t$6, $sp\n\t"
 		"move\t$4, %5\n\t"
diff -ur 2.4/arch/parisc/kernel/entry.S build-2.4/arch/parisc/kernel/entry.S
--- 2.4/arch/parisc/kernel/entry.S	Sat Apr  7 22:01:58 2001
+++ build-2.4/arch/parisc/kernel/entry.S	Sun Apr 15 14:56:58 2001
@@ -497,7 +497,7 @@
 #endif
 	STREG	%r26, PT_GR26(%r1)  /* Store function & argument for child */
 	STREG	%r25, PT_GR25(%r1)
-	ldo	CLONE_VM(%r0), %r26   /* Force CLONE_VM since only init_mm */
+	ldo	SIGCHLD|CLONE_VM(%r0), %r26   /* Force CLONE_VM since only init_mm */
 	or	%r26, %r24, %r26      /* will have kernel mappings.	 */
 	copy	%r0, %r25
 	bl	do_fork, %r2
diff -ur 2.4/arch/ppc/kernel/misc.S build-2.4/arch/ppc/kernel/misc.S
--- 2.4/arch/ppc/kernel/misc.S	Sat Apr  7 22:01:59 2001
+++ build-2.4/arch/ppc/kernel/misc.S	Sun Apr 15 14:56:17 2001
@@ -1080,7 +1080,7 @@
  */
 _GLOBAL(kernel_thread)
 	mr	r6,r3		/* function */
-	ori	r3,r5,CLONE_VM	/* flags */
+	ori	r3,r5,CLONE_VM|SIGCHLD	/* flags */
 	li	r0,__NR_clone
 	sc
 	cmpi	0,r3,0		/* parent or child? */
diff -ur 2.4/arch/s390/kernel/process.c build-2.4/arch/s390/kernel/process.c
--- 2.4/arch/s390/kernel/process.c	Thu Feb 22 22:28:57 2001
+++ build-2.4/arch/s390/kernel/process.c	Sun Apr 15 14:52:58 2001
@@ -242,7 +242,7 @@
 
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
-        int clone_arg = flags | CLONE_VM;
+        int clone_arg = flags | CLONE_VM | SIGCHLD;
         int retval;
 
         __asm__ __volatile__(
diff -ur 2.4/arch/s390x/kernel/process.c build-2.4/arch/s390x/kernel/process.c
--- 2.4/arch/s390x/kernel/process.c	Thu Feb 22 22:28:57 2001
+++ build-2.4/arch/s390x/kernel/process.c	Sun Apr 15 14:53:06 2001
@@ -242,7 +242,7 @@
 
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
-        int clone_arg = flags | CLONE_VM;
+        int clone_arg = flags | CLONE_VM | SIGCHLD;
         int retval;
 
         __asm__ __volatile__(
diff -ur 2.4/arch/sh/kernel/process.c build-2.4/arch/sh/kernel/process.c
--- 2.4/arch/sh/kernel/process.c	Thu Feb 22 22:28:57 2001
+++ build-2.4/arch/sh/kernel/process.c	Sun Apr 15 14:53:16 2001
@@ -148,7 +148,7 @@
 {	/* Don't use this in BL=1(cli).  Or else, CPU resets! */
 	register unsigned long __sc0 __asm__ ("r0");
 	register unsigned long __sc3 __asm__ ("r3") = __NR_clone;
-	register unsigned long __sc4 __asm__ ("r4") = (long) flags | CLONE_VM;
+	register unsigned long __sc4 __asm__ ("r4") = (long) flags | CLONE_VM | SIGCHLD;
 	register unsigned long __sc5 __asm__ ("r5") = 0;
 	register unsigned long __sc8 __asm__ ("r8") = (long) arg;
 	register unsigned long __sc9 __asm__ ("r9") = (long) fn;
diff -ur 2.4/arch/sparc/kernel/process.c build-2.4/arch/sparc/kernel/process.c
--- 2.4/arch/sparc/kernel/process.c	Thu Feb 22 22:28:57 2001
+++ build-2.4/arch/sparc/kernel/process.c	Sun Apr 15 14:53:39 2001
@@ -678,6 +678,8 @@
 {
 	long retval;
 
+	flags |= SIGCHLD;
+
 	__asm__ __volatile("mov %4, %%g2\n\t"    /* Set aside fn ptr... */
 			   "mov %5, %%g3\n\t"    /* and arg. */
 			   "mov %1, %%g1\n\t"
diff -ur 2.4/arch/sparc64/kernel/process.c build-2.4/arch/sparc64/kernel/process.c
--- 2.4/arch/sparc64/kernel/process.c	Sat Mar 31 21:47:37 2001
+++ build-2.4/arch/sparc64/kernel/process.c	Sun Apr 15 14:53:49 2001
@@ -647,6 +647,8 @@
 {
 	long retval;
 
+	flags |= SIGCHLD;
+
 	/* If the parent runs before fn(arg) is called by the child,
 	 * the input registers of this function can be clobbered.
 	 * So we stash 'fn' and 'arg' into global registers which

--------------DE1890DE7E5BD7D6D7A75795--


