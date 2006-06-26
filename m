Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbWFZA75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbWFZA75 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 20:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWFZA7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:59:53 -0400
Received: from terminus.zytor.com ([192.83.249.54]:25231 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965106AbWFZA7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:59:30 -0400
Date: Sun, 25 Jun 2006 17:58:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 37/43] x86_64 support for klibc
Message-Id: <klibc.200606251757.37@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the x86_64 architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit f889dd04bef1aed36ba18161c727af47338e167a
tree c25f184d2e3337b52dfe3abd191ec639d4d9543d
parent f30fa3db62972125afa68d3b53d03cdb843d3bbd
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:53 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:53 -0700

 usr/include/arch/x86_64/klibc/archconfig.h |   15 +++
 usr/include/arch/x86_64/klibc/archsetjmp.h |   21 +++++
 usr/include/arch/x86_64/klibc/archsignal.h |   18 ++++
 usr/include/arch/x86_64/klibc/archstat.h   |   28 ++++++
 usr/include/arch/x86_64/klibc/archsys.h    |  109 ++++++++++++++++++++++++
 usr/include/arch/x86_64/sys/io.h           |  127 ++++++++++++++++++++++++++++
 usr/klibc/arch/x86_64/MCONFIG              |   35 ++++++++
 usr/klibc/arch/x86_64/Makefile.inc         |   18 ++++
 usr/klibc/arch/x86_64/crt0.S               |   22 +++++
 usr/klibc/arch/x86_64/setjmp.S             |   54 ++++++++++++
 usr/klibc/arch/x86_64/sigreturn.S          |   15 +++
 usr/klibc/arch/x86_64/syscall.S            |   28 ++++++
 usr/klibc/arch/x86_64/sysstub.ph           |   23 +++++
 usr/klibc/arch/x86_64/vfork.S              |   26 ++++++
 14 files changed, 539 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/x86_64/klibc/archconfig.h b/usr/include/arch/x86_64/klibc/archconfig.h
new file mode 100644
index 0000000..b8a2a6d
--- /dev/null
+++ b/usr/include/arch/x86_64/klibc/archconfig.h
@@ -0,0 +1,15 @@
+/*
+ * include/arch/x86_64/klibc/archconfig.h
+ *
+ * See include/klibc/sysconfig.h for the options that can be set in
+ * this file.
+ *
+ */
+
+#ifndef _KLIBC_ARCHCONFIG_H
+#define _KLIBC_ARCHCONFIG_H
+
+/* x86-64 doesn't provide a default sigreturn. */
+#define _KLIBC_NEEDS_SA_RESTORER 1
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/x86_64/klibc/archsetjmp.h b/usr/include/arch/x86_64/klibc/archsetjmp.h
new file mode 100644
index 0000000..454fc60
--- /dev/null
+++ b/usr/include/arch/x86_64/klibc/archsetjmp.h
@@ -0,0 +1,21 @@
+/*
+ * arch/x86_64/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	unsigned long __rbx;
+	unsigned long __rsp;
+	unsigned long __rbp;
+	unsigned long __r12;
+	unsigned long __r13;
+	unsigned long __r14;
+	unsigned long __r15;
+	unsigned long __rip;
+};
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _SETJMP_H */
diff --git a/usr/include/arch/x86_64/klibc/archsignal.h b/usr/include/arch/x86_64/klibc/archsignal.h
new file mode 100644
index 0000000..6c8ec77
--- /dev/null
+++ b/usr/include/arch/x86_64/klibc/archsignal.h
@@ -0,0 +1,18 @@
+/*
+ * arch/x86_64/include/klibc/archsignal.h
+ *
+ * Architecture-specific signal definitions
+ *
+ */
+
+#ifndef _KLIBC_ARCHSIGNAL_H
+#define _KLIBC_ARCHSIGNAL_H
+
+#include <asm/signal.h>
+/* The x86-64 headers defines NSIG 32, but it's actually 64 */
+#undef  _NSIG
+#undef  NSIG
+#define _NSIG 64
+#define NSIG  _NSIG
+
+#endif
diff --git a/usr/include/arch/x86_64/klibc/archstat.h b/usr/include/arch/x86_64/klibc/archstat.h
new file mode 100644
index 0000000..de168ac
--- /dev/null
+++ b/usr/include/arch/x86_64/klibc/archstat.h
@@ -0,0 +1,28 @@
+#ifndef _KLIBC_ARCHSTAT_H
+#define _KLIBC_ARCHSTAT_H
+
+#include <klibc/stathelp.h>
+
+#define _STATBUF_ST_NSEC
+
+struct stat {
+	__stdev64	(st_dev);
+	unsigned long	st_ino;
+	unsigned long	st_nlink;
+
+	unsigned int	st_mode;
+	unsigned int	st_uid;
+	unsigned int	st_gid;
+	unsigned int	__pad0;
+	__stdev64	(st_rdev);
+	long		st_size;
+	long		st_blksize;
+	long		st_blocks;	/* Number 512-byte blocks allocated. */
+
+	struct timespec st_atim;
+	struct timespec st_mtim;
+	struct timespec st_ctim;
+  	long		__unused[3];
+};
+
+#endif
diff --git a/usr/include/arch/x86_64/klibc/archsys.h b/usr/include/arch/x86_64/klibc/archsys.h
new file mode 100644
index 0000000..45c71a7
--- /dev/null
+++ b/usr/include/arch/x86_64/klibc/archsys.h
@@ -0,0 +1,109 @@
+/*
+ * arch/x86_64/include/klibc/archsys.h
+ *
+ * Architecture-specific syscall definitions
+ */
+
+#ifndef _KLIBC_ARCHSYS_H
+#define _KLIBC_ARCHSYS_H
+
+/* The x86-64 syscall headers are needlessly inefficient */
+
+#undef _syscall0
+#undef _syscall1
+#undef _syscall2
+#undef _syscall3
+#undef _syscall4
+#undef _syscall5
+#undef _syscall6
+
+#define _syscall0(type,name) \
+type name (void) \
+{ \
+long __res; \
+__asm__ volatile (__syscall \
+        : "=a" (__res) \
+        : "0" (__NR_##name) \
+        : __syscall_clobber); \
+__syscall_return(type,__res); \
+}
+
+#define _syscall1(type,name,type1,arg1) \
+type name (type1 arg1) \
+{ \
+long __res; \
+__asm__ volatile (__syscall \
+        : "=a" (__res) \
+        : "0" (__NR_##name),"D" (arg1) \
+        : __syscall_clobber); \
+__syscall_return(type,__res); \
+}
+
+#define _syscall2(type,name,type1,arg1,type2,arg2) \
+type name (type1 arg1,type2 arg2) \
+{ \
+long __res; \
+__asm__ volatile (__syscall \
+        : "=a" (__res) \
+        : "0" (__NR_##name),"D" (arg1),"S" (arg2) \
+        : __syscall_clobber); \
+__syscall_return(type,__res); \
+}
+
+#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
+type name (type1 arg1,type2 arg2,type3 arg3) \
+{ \
+long __res; \
+__asm__ volatile (__syscall \
+        : "=a" (__res) \
+        : "0" (__NR_##name),"D" (arg1),"S" (arg2), \
+          "d" (arg3) \
+        : __syscall_clobber); \
+__syscall_return(type,__res); \
+}
+
+#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
+type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4) \
+{ \
+long __res; \
+register type4 __r10 asm("%r10") = arg4; \
+__asm__ volatile (__syscall \
+        : "=a" (__res) \
+        : "0" (__NR_##name),"D" (arg1),"S" (arg2), \
+          "d" (arg3),"r" (__r10) \
+        : __syscall_clobber); \
+__syscall_return(type,__res); \
+}
+
+#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
+          type5,arg5) \
+type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5) \
+{ \
+long __res; \
+register type4 __r10 asm("%r10") = arg4; \
+register type5 __r8  asm("%r8")  = arg5; \
+__asm__ volatile (__syscall \
+        : "=a" (__res) \
+        : "0" (__NR_##name),"D" (arg1),"S" (arg2), \
+          "d" (arg3),"r" (__r10),"r" (__r8) \
+        : __syscall_clobber); \
+__syscall_return(type,__res); \
+}
+
+#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
+          type5,arg5,type6,arg6) \
+type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,type6 arg6) \
+{ \
+long __res; \
+register type4 __r10 asm("%r10") = arg4; \
+register type5 __r8  asm("%r8")  = arg5; \
+register type6 __r9  asm("%r9")  = arg6; \
+__asm__ volatile (__syscall \
+        : "=a" (__res) \
+        : "0" (__NR_##name),"D" (arg1),"S" (arg2), \
+          "d" (arg3),"r" (__r10),"r" (__r8), "r" (__r9) \
+        : __syscall_clobber); \
+__syscall_return(type,__res); \
+}
+
+#endif				/* _KLIBC_ARCHSYS_H */
diff --git a/usr/include/arch/x86_64/sys/io.h b/usr/include/arch/x86_64/sys/io.h
new file mode 100644
index 0000000..2a0ca48
--- /dev/null
+++ b/usr/include/arch/x86_64/sys/io.h
@@ -0,0 +1,127 @@
+/* ----------------------------------------------------------------------- *
+ *
+ *   Copyright 2004 H. Peter Anvin - All Rights Reserved
+ *
+ *   Permission is hereby granted, free of charge, to any person
+ *   obtaining a copy of this software and associated documentation
+ *   files (the "Software"), to deal in the Software without
+ *   restriction, including without limitation the rights to use,
+ *   copy, modify, merge, publish, distribute, sublicense, and/or
+ *   sell copies of the Software, and to permit persons to whom
+ *   the Software is furnished to do so, subject to the following
+ *   conditions:
+ *
+ *   The above copyright notice and this permission notice shall
+ *   be included in all copies or substantial portions of the Software.
+ *
+ *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *   OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * ----------------------------------------------------------------------- */
+
+/*
+ * sys/io.h for the i386 architecture
+ *
+ * Basic I/O macros
+ */
+
+#ifndef _SYS_IO_H
+#define _SYS_IO_H 1
+
+/* I/O-related system calls */
+
+int iopl(int);
+int ioperm(unsigned long, unsigned long, int);
+
+/* Basic I/O macros */
+
+static __inline__ void outb(unsigned char __v, unsigned short __p)
+{
+	asm volatile ("outb %0,%1" : : "a" (__v), "dN"(__p));
+}
+
+static __inline__ void outw(unsigned short __v, unsigned short __p)
+{
+	asm volatile ("outw %0,%1" : : "a" (__v), "dN"(__p));
+}
+
+static __inline__ void outl(unsigned int __v, unsigned short __p)
+{
+	asm volatile ("outl %0,%1" : : "a" (__v), "dN"(__p));
+}
+
+static __inline__ unsigned char inb(unsigned short __p)
+{
+	unsigned char __v;
+	asm volatile ("inb %1,%0" : "=a" (__v) : "dN"(__p));
+	return v;
+}
+
+static __inline__ unsigned short inw(unsigned short __p)
+{
+	unsigned short __v;
+	asm volatile ("inw %1,%0" : "=a" (__v) : "dN"(__p));
+	return v;
+}
+
+static __inline__ unsigned int inl(unsigned short __p)
+{
+	unsigned int __v;
+	asm volatile ("inl %1,%0" : "=a" (__v) : "dN"(__p));
+	return v;
+}
+
+/* String I/O macros */
+
+static __inline__ void
+outsb(unsigned short __p, const void *__d, unsigned long __n)
+{
+	asm volatile ("cld; rep; outsb"
+		      : "+S" (__d), "+c"(__n)
+		      : "d"(__p));
+}
+
+static __inline__ void
+outsw(unsigned short __p, const void *__d, unsigned long __n)
+{
+	asm volatile ("cld; rep; outsw"
+		      : "+S" (__d), "+c"(__n)
+		      : "d"(__p));
+}
+
+static __inline__ void
+outsl(unsigned short __p, const void *__d, unsigned long __n)
+{
+	asm volatile ("cld; rep; outsl"
+		      : "+S" (__d), "+c"(__n)
+		      : "d"(__p));
+}
+
+static __inline__ void insb(unsigned short __p, void *__d, unsigned long __n)
+{
+	asm volatile ("cld; rep; insb"
+		      : "+D" (__d), "+c"(__n)
+		      : "d"(__p));
+}
+
+static __inline__ void insw(unsigned short __p, void *__d, unsigned long __n)
+{
+	asm volatile ("cld; rep; insw"
+		      : "+D" (__d), "+c"(__n)
+		      : "d"(__p));
+}
+
+static __inline__ void insl(unsigned short __p, void *__d, unsigned long __n)
+{
+	asm volatile ("cld; rep; insl"
+		      : "+D" (__d), "+c"(__n)
+		      : "d"(__p));
+}
+
+#endif				/* _SYS_IO_H */
diff --git a/usr/klibc/arch/x86_64/MCONFIG b/usr/klibc/arch/x86_64/MCONFIG
new file mode 100644
index 0000000..edcd638
--- /dev/null
+++ b/usr/klibc/arch/x86_64/MCONFIG
@@ -0,0 +1,35 @@
+# -*- makefile -*-
+#
+# arch/x86-64/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+# Blatantly copied and modified from i386 version by Mats Petersson, AMD.
+#
+
+#
+# NOTE: -fno-asynchronous-unwind-tables produce significantly smaller
+# binaries (20% smaller), but makes the code completely useless for
+# debugging using gdb.
+#
+KLIBCARCHREQFLAGS = -m64
+ifeq ($(DEBUG),y)
+KLIBCOPTFLAGS     = -Os -fomit-frame-pointer \
+		-falign-functions=1 -falign-jumps=1 -falign-loops=1
+else
+KLIBCOPTFLAGS     = -Os -fno-asynchronous-unwind-tables -fomit-frame-pointer \
+		-falign-functions=1 -falign-jumps=1 -falign-loops=1
+endif
+KLIBCBITSIZE      = 64
+KLIBCLDFLAGS      = -m elf_x86_64
+
+# Extra linkflags when building the shared version of the library
+# This address needs to be reachable using normal inter-module
+# calls, and work on the memory models for this architecture
+# 2 MB - normal binaries start at 4 MB
+KLIBCSHAREDFLAGS     = -Ttext 0x00200200
+
+# Additional asm- directories needed during installation
+ASMARCH = asm-i386
diff --git a/usr/klibc/arch/x86_64/Makefile.inc b/usr/klibc/arch/x86_64/Makefile.inc
new file mode 100644
index 0000000..4bfe56a
--- /dev/null
+++ b/usr/klibc/arch/x86_64/Makefile.inc
@@ -0,0 +1,18 @@
+# -*- makefile -*-
+#
+# arch/x86_64/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHOBJS = \
+	arch/$(KLIBCARCH)/setjmp.o \
+	arch/$(KLIBCARCH)/syscall.o \
+	arch/$(KLIBCARCH)/sigreturn.o \
+	arch/$(KLIBCARCH)/vfork.o
+
+KLIBCARCHSOOBJS = $(patsubst %.o,%.lo,$(KLIBCARCHOBJS))
+
+archclean:
diff --git a/usr/klibc/arch/x86_64/crt0.S b/usr/klibc/arch/x86_64/crt0.S
new file mode 100644
index 0000000..6a5f335
--- /dev/null
+++ b/usr/klibc/arch/x86_64/crt0.S
@@ -0,0 +1,22 @@
+#
+# arch/x86_64/crt0.S
+#
+# Does arch-specific initialization and invokes __libc_init
+# with the appropriate arguments.
+#
+# See __static_init.c or __shared_init.c for the expected
+# arguments.
+#
+
+	.text
+	.align 4
+	.type _start,@function
+	.globl _start
+_start:
+	movq %rsp,%rdi			# Offset of the ELF data structure
+	movq %rdx,%rsi			# The atexit() pointer (if any)
+	call __libc_init
+	# We should never get here...
+	hlt
+
+	.size _start,.-_start
diff --git a/usr/klibc/arch/x86_64/setjmp.S b/usr/klibc/arch/x86_64/setjmp.S
new file mode 100644
index 0000000..45f547b
--- /dev/null
+++ b/usr/klibc/arch/x86_64/setjmp.S
@@ -0,0 +1,54 @@
+#
+# arch/x86_64/setjmp.S
+#
+# setjmp/longjmp for the x86-64 architecture
+#
+
+#
+# The jmp_buf is assumed to contain the following, in order:
+#	%rbx
+#	%rsp (post-return)
+#	%rbp
+#	%r12
+#	%r13
+#	%r14
+#	%r15
+#	<return address>
+#
+
+	.text
+	.align 4
+	.globl setjmp
+	.type setjmp, @function
+setjmp:
+	pop  %rsi			# Return address, and adjust the stack
+	xorl %eax,%eax			# Return value
+	movq %rbx,(%rdi)
+	movq %rsp,8(%rdi)		# Post-return %rsp!
+	push %rsi			# Make the call/return stack happy
+	movq %rbp,16(%rdi)
+	movq %r12,24(%rdi)
+	movq %r13,32(%rdi)
+	movq %r14,40(%rdi)
+	movq %r15,48(%rdi)
+	movq %rsi,56(%rdi)		# Return address
+	ret
+
+	.size setjmp,.-setjmp
+
+	.text
+	.align 4
+	.globl longjmp
+	.type longjmp, @function
+longjmp:
+	movl %esi,%eax			# Return value (int)
+	movq (%rdi),%rbx
+	movq 8(%rdi),%rsp
+	movq 16(%rdi),%rbp
+	movq 24(%rdi),%r12
+	movq 32(%rdi),%r13
+	movq 40(%rdi),%r14
+	movq 48(%rdi),%r15
+	jmp *56(%rdi)
+
+	.size longjmp,.-longjmp
diff --git a/usr/klibc/arch/x86_64/sigreturn.S b/usr/klibc/arch/x86_64/sigreturn.S
new file mode 100644
index 0000000..46a5a0b
--- /dev/null
+++ b/usr/klibc/arch/x86_64/sigreturn.S
@@ -0,0 +1,15 @@
+/*
+ * arch/x86_64/sigreturn.S
+ */
+
+#include <asm/unistd.h>
+
+	.text
+	.align	4
+	.globl	__sigreturn
+	.type	__sigreturn,@function
+__sigreturn:
+	movl	$__NR_rt_sigreturn,%eax
+	syscall
+
+	.size	__sigreturn,.-__sigreturn
diff --git a/usr/klibc/arch/x86_64/syscall.S b/usr/klibc/arch/x86_64/syscall.S
new file mode 100644
index 0000000..1797797
--- /dev/null
+++ b/usr/klibc/arch/x86_64/syscall.S
@@ -0,0 +1,28 @@
+/*
+ * arch/x86-64/syscall.S
+ *
+ * Common tail-handling code for system calls.
+ *
+ * The arguments are in the standard argument registers; the system
+ * call number in %eax.
+ */
+	.text
+	.align	4
+	.globl	__syscall_common
+	.type	__syscall_common,@function
+__syscall_common:
+	movq	%rcx,%r10		# The kernel uses %r10 istf %rcx
+	syscall
+
+	cmpq	$-4095,%rax
+	jnb	1f
+	ret
+
+	# Error return, must set errno
+1:
+	negl	%eax
+	movl	%eax,errno(%rip)	# errno is type int, so 32 bits
+	orq	$-1,%rax		# orq $-1 smaller than movq $-1
+	ret
+
+	.size	__syscall_common,.-__syscall_common
diff --git a/usr/klibc/arch/x86_64/sysstub.ph b/usr/klibc/arch/x86_64/sysstub.ph
new file mode 100644
index 0000000..e2d797b
--- /dev/null
+++ b/usr/klibc/arch/x86_64/sysstub.ph
@@ -0,0 +1,23 @@
+# -*- perl -*-
+#
+# arch/x86_64/sysstub.ph
+#
+# Script to generate system call stubs
+#
+
+sub make_sysstub($$$$$@) {
+    my($outputdir, $fname, $type, $sname, $stype, @args) = @_;
+
+    open(OUT, '>', "${outputdir}/${fname}.S");
+    print OUT "#include <asm/unistd.h>\n";
+    print OUT "\n";
+    print OUT "\t.type ${fname},\@function\n";
+    print OUT "\t.globl ${fname}\n";
+    print OUT "${fname}:\n";
+    print OUT "\tmovl \$__NR_${sname},%eax\n"; # Zero-extends to 64 bits
+    print OUT "\tjmp __syscall_common\n";
+    print OUT "\t.size ${fname},.-${fname}\n";
+    close(OUT);
+}
+
+1;
diff --git a/usr/klibc/arch/x86_64/vfork.S b/usr/klibc/arch/x86_64/vfork.S
new file mode 100644
index 0000000..e1c8090
--- /dev/null
+++ b/usr/klibc/arch/x86_64/vfork.S
@@ -0,0 +1,26 @@
+#
+# usr/klibc/arch/x86_64/vfork.S
+#
+# vfork is nasty - there must be nothing at all on the stack above
+# the stack frame of the enclosing function.
+#
+
+#include <asm/unistd.h>
+
+	.text
+	.align	4
+	.globl	vfork
+	.type	vfork, @function
+vfork:
+	pop	%rdx			/* Return address */
+	movl	$__NR_vfork, %eax
+	syscall
+	push	%rdx
+	cmpq	$-4095, %rax
+	jae	1f
+	ret
+1:
+	negl	%eax
+	movl	%eax, errno(%rip)
+	orq	$-1, %rax
+	ret
