Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261802AbTCQRqs>; Mon, 17 Mar 2003 12:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261814AbTCQRqs>; Mon, 17 Mar 2003 12:46:48 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:11763 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S261802AbTCQRqe>; Mon, 17 Mar 2003 12:46:34 -0500
Subject: Re: Ptrace hole / Linux 2.2.25
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200303171604.h2HG4Zc30291@devserv.devel.redhat.com>
References: <200303171604.h2HG4Zc30291@devserv.devel.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IjLAUIpJ7VjG6fAE2Sbh"
Organization: Red Hat, Inc.
Message-Id: <1047923841.1600.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 17 Mar 2003 18:57:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IjLAUIpJ7VjG6fAE2Sbh
Content-Type: multipart/mixed; boundary="=-1qViFfTHS++2uBB5HLbh"


--=-1qViFfTHS++2uBB5HLbh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-03-17 at 17:04, Alan Cox wrote:
> Vulnerability: CAN-2003-0127
>=20
> The Linux 2.2 and Linux 2.4 kernels have a flaw in ptrace. This hole allo=
ws
> local users to obtain full privileges. Remote exploitation of this hole i=
s
> not possible. Linux 2.5 is not believed to be vulnerable.
>=20
> Linux 2.2.25 has been released to correct Linux 2.2. It contains no other
> changes. The bug fixes that would have been in 2.2.5pre1 will now appear =
in
> 2.2.26pre1. The patch will apply directly to most older 2.2 releases.
>=20
> A patch for Linux 2.4.20/Linux 2.4.21pre is attached. The patch also
> subtly changes the PR_SET_DUMPABLE prctl. We believe this is neccessary a=
nd=20
> that it will not affect any software. The functionality change is specifi=
c=20
> to unusual debugging situations.

I've attached a patch against 2.4.21pre5=20

--=-1qViFfTHS++2uBB5HLbh
Content-Disposition: attachment; filename=ptrace.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=ptrace.patch; charset=UTF-8

diff -urN linux-2.4.21-pre5/arch/alpha/kernel/entry.S linux-2.4.21-pre5.ptr=
ace/arch/alpha/kernel/entry.S
--- linux-2.4.21-pre5/arch/alpha/kernel/entry.S	2002-08-03 02:39:42.0000000=
00 +0200
+++ linux-2.4.21-pre5.ptrace/arch/alpha/kernel/entry.S	2003-03-17 18:52:52.=
000000000 +0100
@@ -231,12 +231,12 @@
 .end	kernel_clone
=20
 /*
- * kernel_thread(fn, arg, clone_flags)
+ * arch_kernel_thread(fn, arg, clone_flags)
  */
 .align 3
 .globl	kernel_thread
 .ent	kernel_thread
-kernel_thread:
+arch_kernel_thread:
 	ldgp	$29,0($27)	/* we can be called from a module */
 	.frame $30, 4*8, $26
 	subq	$30,4*8,$30
diff -urN linux-2.4.21-pre5/arch/arm/kernel/process.c linux-2.4.21-pre5.ptr=
ace/arch/arm/kernel/process.c
--- linux-2.4.21-pre5/arch/arm/kernel/process.c	2002-08-03 02:39:42.0000000=
00 +0200
+++ linux-2.4.21-pre5.ptrace/arch/arm/kernel/process.c	2003-03-17 18:52:52.=
000000000 +0100
@@ -366,7 +366,7 @@
  * a system call from a "real" process, but the process memory space will
  * not be free'd until both the parent and the child have exited.
  */
-pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
+pid_t arch_kernel_thread(int (*fn)(void *), void *arg, unsigned long flags=
)
 {
 	pid_t __ret;
=20
diff -urN linux-2.4.21-pre5/arch/cris/kernel/entry.S linux-2.4.21-pre5.ptra=
ce/arch/cris/kernel/entry.S
--- linux-2.4.21-pre5/arch/cris/kernel/entry.S	2003-03-17 18:51:45.00000000=
0 +0100
+++ linux-2.4.21-pre5.ptrace/arch/cris/kernel/entry.S	2003-03-17 18:52:52.0=
00000000 +0100
@@ -739,12 +739,12 @@
  * the grosser the code, at least with the gcc version in cris-dist-1.13.
  */
=20
-/* int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags) *=
/
+/* int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long fla=
gs) */
 /*                   r10                r11         r12  */
=20
 	.text
-	.global kernel_thread
-kernel_thread:
+	.global arch_kernel_thread
+arch_kernel_thread:
=20
 	/* Save ARG for later.  */
 	move.d $r11, $r13
diff -urN linux-2.4.21-pre5/arch/i386/kernel/process.c linux-2.4.21-pre5.pt=
race/arch/i386/kernel/process.c
--- linux-2.4.21-pre5/arch/i386/kernel/process.c	2002-08-03 02:39:42.000000=
000 +0200
+++ linux-2.4.21-pre5.ptrace/arch/i386/kernel/process.c	2003-03-17 18:52:52=
.000000000 +0100
@@ -485,7 +485,7 @@
 /*
  * Create a kernel thread
  */
-int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
 	long retval, d0;
=20
diff -urN linux-2.4.21-pre5/arch/ia64/kernel/process.c linux-2.4.21-pre5.pt=
race/arch/ia64/kernel/process.c
--- linux-2.4.21-pre5/arch/ia64/kernel/process.c	2003-03-17 18:51:45.000000=
000 +0100
+++ linux-2.4.21-pre5.ptrace/arch/ia64/kernel/process.c	2003-03-17 18:52:52=
.000000000 +0100
@@ -230,7 +230,7 @@
  *	|                     | <-- sp (lowest addr)
  *	+---------------------+
  *
- * Note: if we get called through kernel_thread() then the memory
+ * Note: if we get called through arch_kernel_thread() then the memory
  * above "(highest addr)" is valid kernel stack memory that needs to
  * be copied as well.
  *
@@ -485,7 +485,7 @@
 }
=20
 pid_t
-kernel_thread (int (*fn)(void *), void *arg, unsigned long flags)
+arch_kernel_thread (int (*fn)(void *), void *arg, unsigned long flags)
 {
 	struct task_struct *parent =3D current;
 	int result, tid;
diff -urN linux-2.4.21-pre5/arch/m68k/kernel/process.c linux-2.4.21-pre5.pt=
race/arch/m68k/kernel/process.c
--- linux-2.4.21-pre5/arch/m68k/kernel/process.c	2002-08-03 02:39:43.000000=
000 +0200
+++ linux-2.4.21-pre5.ptrace/arch/m68k/kernel/process.c	2003-03-17 18:52:52=
.000000000 +0100
@@ -124,7 +124,7 @@
 /*
  * Create a kernel thread
  */
-int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
 	int pid;
 	mm_segment_t fs;
diff -urN linux-2.4.21-pre5/arch/mips/kernel/process.c linux-2.4.21-pre5.pt=
race/arch/mips/kernel/process.c
--- linux-2.4.21-pre5/arch/mips/kernel/process.c	2002-11-29 00:53:10.000000=
000 +0100
+++ linux-2.4.21-pre5.ptrace/arch/mips/kernel/process.c	2003-03-17 18:52:52=
.000000000 +0100
@@ -152,7 +152,7 @@
 /*
  * Create a kernel thread
  */
-int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
 	long retval;
=20
diff -urN linux-2.4.21-pre5/arch/mips64/kernel/process.c linux-2.4.21-pre5.=
ptrace/arch/mips64/kernel/process.c
--- linux-2.4.21-pre5/arch/mips64/kernel/process.c	2002-11-29 00:53:10.0000=
00000 +0100
+++ linux-2.4.21-pre5.ptrace/arch/mips64/kernel/process.c	2003-03-17 18:52:=
52.000000000 +0100
@@ -151,7 +151,7 @@
 /*
  * Create a kernel thread
  */
-int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
+int arch_kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
 {
 	int retval;
=20
diff -urN linux-2.4.21-pre5/arch/parisc/kernel/process.c linux-2.4.21-pre5.=
ptrace/arch/parisc/kernel/process.c
--- linux-2.4.21-pre5/arch/parisc/kernel/process.c	2003-03-17 18:51:45.0000=
00000 +0100
+++ linux-2.4.21-pre5.ptrace/arch/parisc/kernel/process.c	2003-03-17 18:52:=
52.000000000 +0100
@@ -169,7 +169,7 @@
  */
=20
 extern pid_t __kernel_thread(int (*fn)(void *), void *arg, unsigned long f=
lags);
-pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
+pid_t arch_kernel_thread(int (*fn)(void *), void *arg, unsigned long flags=
)
 {
=20
 	/*
diff -urN linux-2.4.21-pre5/arch/ppc/kernel/misc.S linux-2.4.21-pre5.ptrace=
/arch/ppc/kernel/misc.S
--- linux-2.4.21-pre5/arch/ppc/kernel/misc.S	2003-03-17 18:51:45.000000000 =
+0100
+++ linux-2.4.21-pre5.ptrace/arch/ppc/kernel/misc.S	2003-03-17 18:52:52.000=
000000 +0100
@@ -899,9 +899,9 @@
=20
 /*
  * Create a kernel thread
- *   kernel_thread(fn, arg, flags)
+ *   arch_kernel_thread(fn, arg, flags)
  */
-_GLOBAL(kernel_thread)
+_GLOBAL(arch_kernel_thread)
 	mr	r6,r3		/* function */
 	ori	r3,r5,CLONE_VM	/* flags */
 	li	r0,__NR_clone
diff -urN linux-2.4.21-pre5/arch/ppc64/kernel/misc.S linux-2.4.21-pre5.ptra=
ce/arch/ppc64/kernel/misc.S
--- linux-2.4.21-pre5/arch/ppc64/kernel/misc.S	2003-03-17 18:51:45.00000000=
0 +0100
+++ linux-2.4.21-pre5.ptrace/arch/ppc64/kernel/misc.S	2003-03-17 18:52:52.0=
00000000 +0100
@@ -481,9 +481,9 @@
=20
 /*
  * Create a kernel thread
- *   kernel_thread(fn, arg, flags)
+ *   arch_kernel_thread(fn, arg, flags)
  */
-_GLOBAL(kernel_thread)
+_GLOBAL(arch_kernel_thread)
 	mr	r6,r3		/* function */
 	ori	r3,r5,CLONE_VM	/* flags */
 	li	r0,__NR_clone
diff -urN linux-2.4.21-pre5/arch/s390/kernel/process.c linux-2.4.21-pre5.pt=
race/arch/s390/kernel/process.c
--- linux-2.4.21-pre5/arch/s390/kernel/process.c	2003-03-17 18:51:45.000000=
000 +0100
+++ linux-2.4.21-pre5.ptrace/arch/s390/kernel/process.c	2003-03-17 18:52:52=
.000000000 +0100
@@ -105,7 +105,7 @@
 		show_trace((unsigned long *) regs->gprs[15]);
 }
=20
-int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
         int clone_arg =3D flags | CLONE_VM;
         int retval;
diff -urN linux-2.4.21-pre5/arch/s390x/kernel/process.c linux-2.4.21-pre5.p=
trace/arch/s390x/kernel/process.c
--- linux-2.4.21-pre5/arch/s390x/kernel/process.c	2003-03-17 18:51:45.00000=
0000 +0100
+++ linux-2.4.21-pre5.ptrace/arch/s390x/kernel/process.c	2003-03-17 18:52:5=
2.000000000 +0100
@@ -102,7 +102,7 @@
 		show_trace((unsigned long *) regs->gprs[15]);
 }
=20
-int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
         int clone_arg =3D flags | CLONE_VM;
         int retval;
diff -urN linux-2.4.21-pre5/arch/sh/kernel/process.c linux-2.4.21-pre5.ptra=
ce/arch/sh/kernel/process.c
--- linux-2.4.21-pre5/arch/sh/kernel/process.c	2001-10-15 22:36:48.00000000=
0 +0200
+++ linux-2.4.21-pre5.ptrace/arch/sh/kernel/process.c	2003-03-17 18:52:52.0=
00000000 +0100
@@ -118,7 +118,7 @@
  * This is the mechanism for creating a new kernel thread.
  *
  */
-int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {	/* Don't use this in BL=3D1(cli).  Or else, CPU resets! */
 	register unsigned long __sc0 __asm__ ("r0");
 	register unsigned long __sc3 __asm__ ("r3") =3D __NR_clone;
diff -urN linux-2.4.21-pre5/arch/sparc/kernel/process.c linux-2.4.21-pre5.p=
trace/arch/sparc/kernel/process.c
--- linux-2.4.21-pre5/arch/sparc/kernel/process.c	2002-08-03 02:39:43.00000=
0000 +0200
+++ linux-2.4.21-pre5.ptrace/arch/sparc/kernel/process.c	2003-03-17 18:52:5=
2.000000000 +0100
@@ -676,7 +676,7 @@
  * a system call from a "real" process, but the process memory space will
  * not be free'd until both the parent and the child have exited.
  */
-pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+pid_t arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flag=
s)
 {
 	long retval;
=20
diff -urN linux-2.4.21-pre5/arch/sparc64/kernel/process.c linux-2.4.21-pre5=
.ptrace/arch/sparc64/kernel/process.c
--- linux-2.4.21-pre5/arch/sparc64/kernel/process.c	2002-11-29 00:53:12.000=
000000 +0100
+++ linux-2.4.21-pre5.ptrace/arch/sparc64/kernel/process.c	2003-03-17 18:52=
:52.000000000 +0100
@@ -673,7 +673,7 @@
  * a system call from a "real" process, but the process memory space will
  * not be free'd until both the parent and the child have exited.
  */
-pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+pid_t arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flag=
s)
 {
 	long retval;
=20
diff -urN linux-2.4.21-pre5/fs/exec.c linux-2.4.21-pre5.ptrace/fs/exec.c
--- linux-2.4.21-pre5/fs/exec.c	2003-03-17 18:52:03.000000000 +0100
+++ linux-2.4.21-pre5.ptrace/fs/exec.c	2003-03-17 18:52:54.000000000 +0100
@@ -576,8 +576,10 @@
=20
 	current->sas_ss_sp =3D current->sas_ss_size =3D 0;
=20
-	if (current->euid =3D=3D current->uid && current->egid =3D=3D current->gi=
d)
+	if (current->euid =3D=3D current->uid && current->egid =3D=3D current->gi=
d) {
 		current->mm->dumpable =3D 1;
+		current->task_dumpable =3D 1;
+	}
 	name =3D bprm->filename;
 	for (i=3D0; (ch =3D *(name++)) !=3D '\0';) {
 		if (ch =3D=3D '/')
@@ -1085,7 +1087,7 @@
 	binfmt =3D current->binfmt;
 	if (!binfmt || !binfmt->core_dump)
 		goto fail;
-	if (!current->mm->dumpable)
+	if (!is_dumpable(current))
 		goto fail;
 	current->mm->dumpable =3D 0;
 	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
diff -urN linux-2.4.21-pre5/include/asm-alpha/processor.h linux-2.4.21-pre5=
.ptrace/include/asm-alpha/processor.h
--- linux-2.4.21-pre5/include/asm-alpha/processor.h	2001-10-05 21:11:05.000=
000000 +0200
+++ linux-2.4.21-pre5.ptrace/include/asm-alpha/processor.h	2003-03-17 18:52=
:58.000000000 +0100
@@ -119,7 +119,7 @@
 extern void release_thread(struct task_struct *);
=20
 /* Create a kernel thread without removing it from tasklists.  */
-extern long kernel_thread(int (*fn)(void *), void *arg, unsigned long flag=
s);
+extern long arch_kernel_thread(int (*fn)(void *), void *arg, unsigned long=
 flags);
=20
 #define copy_segments(tsk, mm)		do { } while (0)
 #define release_segments(mm)		do { } while (0)
diff -urN linux-2.4.21-pre5/include/asm-arm/processor.h linux-2.4.21-pre5.p=
trace/include/asm-arm/processor.h
--- linux-2.4.21-pre5/include/asm-arm/processor.h	2002-08-03 02:39:45.00000=
0000 +0200
+++ linux-2.4.21-pre5.ptrace/include/asm-arm/processor.h	2003-03-17 18:52:5=
8.000000000 +0100
@@ -117,7 +117,7 @@
 /*
  * Create a new kernel thread
  */
-extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags=
);
+extern int arch_kernel_thread(int (*fn)(void *), void *arg, unsigned long =
flags);
=20
 #endif
=20
diff -urN linux-2.4.21-pre5/include/asm-cris/processor.h linux-2.4.21-pre5.=
ptrace/include/asm-cris/processor.h
--- linux-2.4.21-pre5/include/asm-cris/processor.h	2003-03-17 18:52:04.0000=
00000 +0100
+++ linux-2.4.21-pre5.ptrace/include/asm-cris/processor.h	2003-03-17 18:52:=
58.000000000 +0100
@@ -81,7 +81,7 @@
 #define INIT_THREAD  { \
    0, 0, 0x20 }  /* ccr =3D int enable, nothing else */
=20
-extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flag=
s);
+extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long=
 flags);
=20
 /* give the thread a program location
  * set user-mode (The 'U' flag (User mode flag) is CCR/DCCR bit 8)=20
diff -urN linux-2.4.21-pre5/include/asm-i386/processor.h linux-2.4.21-pre5.=
ptrace/include/asm-i386/processor.h
--- linux-2.4.21-pre5/include/asm-i386/processor.h	2002-08-03 02:39:45.0000=
00000 +0200
+++ linux-2.4.21-pre5.ptrace/include/asm-i386/processor.h	2003-03-17 18:52:=
58.000000000 +0100
@@ -433,7 +433,7 @@
 /*
  * create a kernel thread without removing it from tasklists
  */
-extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flag=
s);
+extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long=
 flags);
=20
 /* Copy and release all segment info associated with a VM */
 extern void copy_segments(struct task_struct *p, struct mm_struct * mm);
diff -urN linux-2.4.21-pre5/include/asm-ia64/processor.h linux-2.4.21-pre5.=
ptrace/include/asm-ia64/processor.h
--- linux-2.4.21-pre5/include/asm-ia64/processor.h	2003-03-17 18:52:05.0000=
00000 +0100
+++ linux-2.4.21-pre5.ptrace/include/asm-ia64/processor.h	2003-03-17 18:52:=
58.000000000 +0100
@@ -372,7 +372,7 @@
  * do_basic_setup() and the timing is such that free_initmem() has
  * been called already.
  */
-extern int kernel_thread (int (*fn)(void *), void *arg, unsigned long flag=
s);
+extern int arch_kernel_thread (int (*fn)(void *), void *arg, unsigned long=
 flags);
=20
 /* Copy and release all segment info associated with a VM */
 #define copy_segments(tsk, mm)			do { } while (0)
diff -urN linux-2.4.21-pre5/include/asm-m68k/processor.h linux-2.4.21-pre5.=
ptrace/include/asm-m68k/processor.h
--- linux-2.4.21-pre5/include/asm-m68k/processor.h	2001-10-05 21:11:05.0000=
00000 +0200
+++ linux-2.4.21-pre5.ptrace/include/asm-m68k/processor.h	2003-03-17 18:52:=
58.000000000 +0100
@@ -105,7 +105,7 @@
 {
 }
=20
-extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flag=
s);
+extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long=
 flags);
=20
 #define copy_segments(tsk, mm)		do { } while (0)
 #define release_segments(mm)		do { } while (0)
diff -urN linux-2.4.21-pre5/include/asm-mips/processor.h linux-2.4.21-pre5.=
ptrace/include/asm-mips/processor.h
--- linux-2.4.21-pre5/include/asm-mips/processor.h	2002-11-29 00:53:15.0000=
00000 +0100
+++ linux-2.4.21-pre5.ptrace/include/asm-mips/processor.h	2003-03-17 18:52:=
58.000000000 +0100
@@ -188,7 +188,7 @@
 /* Free all resources held by a thread. */
 #define release_thread(thread) do { } while(0)
=20
-extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flag=
s);
+extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long=
 flags);
=20
 /* Copy and release all segment info associated with a VM */
 #define copy_segments(p, mm) do { } while(0)
diff -urN linux-2.4.21-pre5/include/asm-mips64/processor.h linux-2.4.21-pre=
5.ptrace/include/asm-mips64/processor.h
--- linux-2.4.21-pre5/include/asm-mips64/processor.h	2002-11-29 00:53:15.00=
0000000 +0100
+++ linux-2.4.21-pre5.ptrace/include/asm-mips64/processor.h	2003-03-17 18:5=
2:58.000000000 +0100
@@ -231,7 +231,7 @@
 /* Free all resources held by a thread. */
 #define release_thread(thread) do { } while(0)
=20
-extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flag=
s);
+extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long=
 flags);
=20
 /* Copy and release all segment info associated with a VM */
 #define copy_segments(p, mm) do { } while(0)
diff -urN linux-2.4.21-pre5/include/asm-parisc/processor.h linux-2.4.21-pre=
5.ptrace/include/asm-parisc/processor.h
--- linux-2.4.21-pre5/include/asm-parisc/processor.h	2003-03-17 18:52:05.00=
0000000 +0100
+++ linux-2.4.21-pre5.ptrace/include/asm-parisc/processor.h	2003-03-17 18:5=
2:58.000000000 +0100
@@ -292,7 +292,7 @@
=20
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
-extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flag=
s);
+extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long=
 flags);
=20
 extern void map_hpux_gateway_page(struct task_struct *tsk, struct mm_struc=
t *mm);
=20
diff -urN linux-2.4.21-pre5/include/asm-ppc/processor.h linux-2.4.21-pre5.p=
trace/include/asm-ppc/processor.h
--- linux-2.4.21-pre5/include/asm-ppc/processor.h	2003-03-17 18:52:05.00000=
0000 +0100
+++ linux-2.4.21-pre5.ptrace/include/asm-ppc/processor.h	2003-03-17 18:52:5=
8.000000000 +0100
@@ -622,7 +622,7 @@
 /*
  * Create a new kernel thread.
  */
-extern long kernel_thread(int (*fn)(void *), void *arg, unsigned long flag=
s);
+extern long arch_kernel_thread(int (*fn)(void *), void *arg, unsigned long=
 flags);
=20
 /*
  * Bus types
diff -urN linux-2.4.21-pre5/include/asm-ppc64/processor.h linux-2.4.21-pre5=
.ptrace/include/asm-ppc64/processor.h
--- linux-2.4.21-pre5/include/asm-ppc64/processor.h	2003-03-17 18:52:06.000=
000000 +0100
+++ linux-2.4.21-pre5.ptrace/include/asm-ppc64/processor.h	2003-03-17 18:52=
:58.000000000 +0100
@@ -602,7 +602,7 @@
 /*
  * Create a new kernel thread.
  */
-extern long kernel_thread(int (*fn)(void *), void *arg, unsigned long flag=
s);
+extern long arch_kernel_thread(int (*fn)(void *), void *arg, unsigned long=
 flags);
=20
 /*
  * Bus types
diff -urN linux-2.4.21-pre5/include/asm-s390/processor.h linux-2.4.21-pre5.=
ptrace/include/asm-s390/processor.h
--- linux-2.4.21-pre5/include/asm-s390/processor.h	2002-08-03 02:39:45.0000=
00000 +0200
+++ linux-2.4.21-pre5.ptrace/include/asm-s390/processor.h	2003-03-17 18:52:=
58.000000000 +0100
@@ -113,7 +113,7 @@
=20
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
-extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flag=
s);
+extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long=
 flags);
=20
 /* Copy and release all segment info associated with a VM */
 #define copy_segments(nr, mm)           do { } while (0)
diff -urN linux-2.4.21-pre5/include/asm-s390x/processor.h linux-2.4.21-pre5=
.ptrace/include/asm-s390x/processor.h
--- linux-2.4.21-pre5/include/asm-s390x/processor.h	2002-11-29 00:53:15.000=
000000 +0100
+++ linux-2.4.21-pre5.ptrace/include/asm-s390x/processor.h	2003-03-17 18:52=
:58.000000000 +0100
@@ -128,7 +128,7 @@
=20
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
-extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flag=
s);
+extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long=
 flags);
=20
 /* Copy and release all segment info associated with a VM */
 #define copy_segments(nr, mm)           do { } while (0)
diff -urN linux-2.4.21-pre5/include/asm-sh/processor.h linux-2.4.21-pre5.pt=
race/include/asm-sh/processor.h
--- linux-2.4.21-pre5/include/asm-sh/processor.h	2001-10-05 21:11:05.000000=
000 +0200
+++ linux-2.4.21-pre5.ptrace/include/asm-sh/processor.h	2003-03-17 18:52:58=
.000000000 +0100
@@ -137,7 +137,7 @@
 /*
  * create a kernel thread without removing it from tasklists
  */
-extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flag=
s);
+extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long=
 flags);
=20
 /*
  * Bus types
diff -urN linux-2.4.21-pre5/include/asm-sparc/processor.h linux-2.4.21-pre5=
.ptrace/include/asm-sparc/processor.h
--- linux-2.4.21-pre5/include/asm-sparc/processor.h	2001-10-11 08:42:47.000=
000000 +0200
+++ linux-2.4.21-pre5.ptrace/include/asm-sparc/processor.h	2003-03-17 18:52=
:58.000000000 +0100
@@ -146,7 +146,7 @@
=20
 /* Free all resources held by a thread. */
 #define release_thread(tsk)		do { } while(0)
-extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long fl=
ags);
+extern pid_t arch_kernel_thread(int (*fn)(void *), void * arg, unsigned lo=
ng flags);
=20
=20
 #define copy_segments(tsk, mm)		do { } while (0)
diff -urN linux-2.4.21-pre5/include/asm-sparc64/processor.h linux-2.4.21-pr=
e5.ptrace/include/asm-sparc64/processor.h
--- linux-2.4.21-pre5/include/asm-sparc64/processor.h	2002-08-03 02:39:45.0=
00000000 +0200
+++ linux-2.4.21-pre5.ptrace/include/asm-sparc64/processor.h	2003-03-17 18:=
52:58.000000000 +0100
@@ -270,7 +270,7 @@
 /* Free all resources held by a thread. */
 #define release_thread(tsk)		do { } while(0)
=20
-extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long fl=
ags);
+extern pid_t arch_kernel_thread(int (*fn)(void *), void * arg, unsigned lo=
ng flags);
=20
 #define copy_segments(tsk, mm)		do { } while (0)
 #define release_segments(mm)		do { } while (0)
diff -urN linux-2.4.21-pre5/include/linux/sched.h linux-2.4.21-pre5.ptrace/=
include/linux/sched.h
--- linux-2.4.21-pre5/include/linux/sched.h	2003-03-17 18:52:08.000000000 +=
0100
+++ linux-2.4.21-pre5.ptrace/include/linux/sched.h	2003-03-17 18:53:26.0000=
00000 +0100
@@ -162,6 +162,7 @@
 extern void flush_scheduled_tasks(void);
 extern int start_context_thread(void);
 extern int current_is_keventd(void);
+extern long kernel_thread(int (*fn)(void *), void * arg, unsigned long fla=
gs);
=20
 #if CONFIG_SMP
 extern void set_cpus_allowed(struct task_struct *p, unsigned long new_mask=
);
@@ -345,6 +346,7 @@
 	/* ??? */
 	unsigned long personality;
 	int did_exec:1;
+	unsigned task_dumpable:1;
 	pid_t pid;
 	pid_t pgrp;
 	pid_t tty_old_pgrp;
@@ -454,6 +456,8 @@
 #define PT_TRACESYSGOOD	0x00000008
 #define PT_PTRACE_CAP	0x00000010	/* ptracer can follow suid-exec */
=20
+#define is_dumpable(tsk)	((tsk)->task_dumpable && (tsk)->mm->dumpable)
+
 /*
  * Limit the stack by to some sane default: root can always
  * increase this limit if needed..  8MB seems reasonable.
diff -urN linux-2.4.21-pre5/kernel/fork.c linux-2.4.21-pre5.ptrace/kernel/f=
ork.c
--- linux-2.4.21-pre5/kernel/fork.c	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.21-pre5.ptrace/kernel/fork.c	2003-03-17 18:52:58.000000000 +0=
100
@@ -27,6 +27,7 @@
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
+#include <asm/processor.h>
=20
 /* The idle threads do not count.. */
 int nr_threads;
@@ -565,6 +566,31 @@
 	p->flags =3D new_flags;
 }
=20
+long kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+{
+	struct task_struct *task =3D current;
+	unsigned old_task_dumpable;
+	long ret;
+
+	/* lock out any potential ptracer */
+	task_lock(task);
+	if (task->ptrace) {
+		task_unlock(task);
+		return -EPERM;
+	}
+
+	old_task_dumpable =3D task->task_dumpable;
+	task->task_dumpable =3D 0;
+	task_unlock(task);
+
+	ret =3D arch_kernel_thread(fn, arg, flags);
+
+	/* never reached in child process, only in parent */
+	current->task_dumpable =3D old_task_dumpable;
+
+	return ret;
+}
+
 /*
  *  Ok, this is the main fork-routine. It copies the system process
  * information (task[nr]) and sets up the necessary registers. It also
diff -urN linux-2.4.21-pre5/kernel/ptrace.c linux-2.4.21-pre5.ptrace/kernel=
/ptrace.c
--- linux-2.4.21-pre5/kernel/ptrace.c	2002-08-03 02:39:46.000000000 +0200
+++ linux-2.4.21-pre5.ptrace/kernel/ptrace.c	2003-03-17 18:52:58.000000000 =
+0100
@@ -21,6 +21,10 @@
  */
 int ptrace_check_attach(struct task_struct *child, int kill)
 {
+	mb();
+	if (!is_dumpable(child))
+		return -EPERM;
+
 	if (!(child->ptrace & PT_PTRACED))
 		return -ESRCH;
=20
@@ -70,7 +74,7 @@
  	    (current->gid !=3D task->gid)) && !capable(CAP_SYS_PTRACE))
 		goto bad;
 	rmb();
-	if (!task->mm->dumpable && !capable(CAP_SYS_PTRACE))
+	if (!is_dumpable(task) && !capable(CAP_SYS_PTRACE))
 		goto bad;
 	/* the same process cannot be attached many times */
 	if (task->ptrace & PT_PTRACED)
@@ -136,6 +140,8 @@
 	/* Worry about races with exit() */
 	task_lock(tsk);
 	mm =3D tsk->mm;
+	if (!is_dumpable(tsk) || (&init_mm =3D=3D mm))
+		mm =3D NULL;
 	if (mm)
 		atomic_inc(&mm->mm_users);
 	task_unlock(tsk);
diff -urN linux-2.4.21-pre5/kernel/sys.c linux-2.4.21-pre5.ptrace/kernel/sy=
s.c
--- linux-2.4.21-pre5/kernel/sys.c	2003-03-17 18:52:08.000000000 +0100
+++ linux-2.4.21-pre5.ptrace/kernel/sys.c	2003-03-17 18:52:58.000000000 +01=
00
@@ -1238,7 +1238,7 @@
 			error =3D put_user(current->pdeath_signal, (int *)arg2);
 			break;
 		case PR_GET_DUMPABLE:
-			if (current->mm->dumpable)
+			if (is_dumpable(current))
 				error =3D 1;
 			break;
 		case PR_SET_DUMPABLE:
@@ -1246,7 +1246,8 @@
 				error =3D -EINVAL;
 				break;
 			}
-			current->mm->dumpable =3D arg2;
+			if (is_dumpable(current))
+				current->mm->dumpable =3D arg2;
 			break;
=20
 	        case PR_SET_UNALIGN:

--=-1qViFfTHS++2uBB5HLbh--

--=-IjLAUIpJ7VjG6fAE2Sbh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+dgyBxULwo51rQBIRAmhlAJ9ELfRWIUvJWwft2oer+JJilQlqJwCeLyEt
dHvf7eXpc59ZfEmb8pNTRMk=
=OBv2
-----END PGP SIGNATURE-----

--=-IjLAUIpJ7VjG6fAE2Sbh--
