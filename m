Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423173AbWF1FTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423173AbWF1FTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423160AbWF1FSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:18:46 -0400
Received: from terminus.zytor.com ([192.83.249.54]:64205 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423157AbWF1FSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:18:35 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 07/31] i386 support for klibc
Date: Tue, 27 Jun 2006 22:17:07 -0700
Message-Id: <klibc.200606272217.07@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the i386 architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 0b76ae4ad7c15cddd0d1202234f5dbc75e8dde56
tree 09f9c33da419b48d84b61d20463611179d26fbc1
parent 5736f366a2df293571bcc779415f1d9b3a9aa6c1
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:34 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:34 -0700

 usr/include/arch/i386/klibc/archconfig.h |   19 ++++
 usr/include/arch/i386/klibc/archsetjmp.h |   19 ++++
 usr/include/arch/i386/klibc/archsignal.h |  114 +++++++++++++++++++++++++++
 usr/include/arch/i386/klibc/archstat.h   |   38 +++++++++
 usr/include/arch/i386/klibc/diverr.h     |   15 ++++
 usr/include/arch/i386/sys/io.h           |  127 ++++++++++++++++++++++++++++++
 usr/include/arch/i386/sys/vm86.h         |   40 +++++++++
 usr/klibc/arch/i386/MCONFIG              |   33 ++++++++
 usr/klibc/arch/i386/Makefile.inc         |   30 +++++++
 usr/klibc/arch/i386/crt0.S               |   31 +++++++
 usr/klibc/arch/i386/libgcc/__ashldi3.S   |   29 +++++++
 usr/klibc/arch/i386/libgcc/__ashrdi3.S   |   29 +++++++
 usr/klibc/arch/i386/libgcc/__lshrdi3.S   |   29 +++++++
 usr/klibc/arch/i386/libgcc/__muldi3.S    |   34 ++++++++
 usr/klibc/arch/i386/libgcc/__negdi2.S    |   21 +++++
 usr/klibc/arch/i386/open.S               |   29 +++++++
 usr/klibc/arch/i386/openat.S             |   26 ++++++
 usr/klibc/arch/i386/setjmp.S             |   58 ++++++++++++++
 usr/klibc/arch/i386/sigreturn.S          |   15 ++++
 usr/klibc/arch/i386/socketcall.S         |   55 +++++++++++++
 usr/klibc/arch/i386/syscall.S            |   69 ++++++++++++++++
 usr/klibc/arch/i386/sysstub.ph           |   26 ++++++
 usr/klibc/arch/i386/varsyscall.S         |   36 +++++++++
 usr/klibc/arch/i386/vfork.S              |   26 ++++++
 24 files changed, 948 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/i386/klibc/archconfig.h b/usr/include/arch/i386/klibc/archconfig.h
new file mode 100644
index 0000000..4463d08
--- /dev/null
+++ b/usr/include/arch/i386/klibc/archconfig.h
@@ -0,0 +1,19 @@
+/*
+ * include/arch/i386/klibc/archconfig.h
+ *
+ * See include/klibc/sysconfig.h for the options that can be set in
+ * this file.
+ *
+ */
+
+#ifndef _KLIBC_ARCHCONFIG_H
+#define _KLIBC_ARCHCONFIG_H
+
+/* On i386, only half the signals are accessible using the legacy calls. */
+#define _KLIBC_USE_RT_SIG 1
+
+/* The stock i386 kernel is fine, but a whole string of Fedora kernels
+   had a broken default restorer.  It's easier to enable this here. */
+#define _KLIBC_NEEDS_SA_RESTORER 1
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/i386/klibc/archsetjmp.h b/usr/include/arch/i386/klibc/archsetjmp.h
new file mode 100644
index 0000000..ea1ba3d
--- /dev/null
+++ b/usr/include/arch/i386/klibc/archsetjmp.h
@@ -0,0 +1,19 @@
+/*
+ * arch/i386/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	unsigned int __ebx;
+	unsigned int __esp;
+	unsigned int __ebp;
+	unsigned int __esi;
+	unsigned int __edi;
+	unsigned int __eip;
+};
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _SETJMP_H */
diff --git a/usr/include/arch/i386/klibc/archsignal.h b/usr/include/arch/i386/klibc/archsignal.h
new file mode 100644
index 0000000..6c942db
--- /dev/null
+++ b/usr/include/arch/i386/klibc/archsignal.h
@@ -0,0 +1,114 @@
+/*
+ * arch/i386/include/klibc/archsignal.h
+ *
+ * Architecture-specific signal definitions
+ *
+ */
+
+#ifndef _KLIBC_ARCHSIGNAL_H
+#define _KLIBC_ARCHSIGNAL_H
+
+/* The in-kernel headers for i386 still have libc5
+   crap in them.  Reconsider using <asm/signal.h>
+   when/if it gets cleaned up; for now, duplicate
+   the definitions here. */
+
+#define _NSIG           64
+#define _NSIG_BPW       32
+#define _NSIG_WORDS     (_NSIG / _NSIG_BPW)
+
+typedef struct {
+	unsigned long sig[_NSIG_WORDS];
+} sigset_t;
+
+#define SIGHUP           1
+#define SIGINT           2
+#define SIGQUIT          3
+#define SIGILL           4
+#define SIGTRAP          5
+#define SIGABRT          6
+#define SIGIOT           6
+#define SIGBUS           7
+#define SIGFPE           8
+#define SIGKILL          9
+#define SIGUSR1         10
+#define SIGSEGV         11
+#define SIGUSR2         12
+#define SIGPIPE         13
+#define SIGALRM         14
+#define SIGTERM         15
+#define SIGSTKFLT       16
+#define SIGCHLD         17
+#define SIGCONT         18
+#define SIGSTOP         19
+#define SIGTSTP         20
+#define SIGTTIN         21
+#define SIGTTOU         22
+#define SIGURG          23
+#define SIGXCPU         24
+#define SIGXFSZ         25
+#define SIGVTALRM       26
+#define SIGPROF         27
+#define SIGWINCH        28
+#define SIGIO           29
+#define SIGPOLL         SIGIO
+#define SIGPWR          30
+#define SIGSYS          31
+#define SIGUNUSED       31
+
+#define SIGRTMIN        32
+#define SIGRTMAX        (_NSIG-1)
+
+/*
+ * SA_FLAGS values:
+ *
+ * SA_ONSTACK indicates that a registered stack_t will be used.
+ * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
+ * SA_RESTART flag to get restarting signals (which were the default long ago)
+ * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
+ * SA_RESETHAND clears the handler when the signal is delivered.
+ * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
+ * SA_NODEFER prevents the current signal from being masked in the handler.
+ *
+ * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
+ * Unix names RESETHAND and NODEFER respectively.
+ */
+#define SA_NOCLDSTOP	0x00000001u
+#define SA_NOCLDWAIT	0x00000002u
+#define SA_SIGINFO	0x00000004u
+#define SA_ONSTACK	0x08000000u
+#define SA_RESTART	0x10000000u
+#define SA_NODEFER	0x40000000u
+#define SA_RESETHAND	0x80000000u
+
+#define SA_NOMASK	SA_NODEFER
+#define SA_ONESHOT	SA_RESETHAND
+#define SA_INTERRUPT	0x20000000	/* dummy -- ignored */
+
+#define SA_RESTORER	0x04000000
+
+/*
+ * sigaltstack controls
+ */
+#define SS_ONSTACK	1
+#define SS_DISABLE	2
+
+#define MINSIGSTKSZ	2048
+#define SIGSTKSZ	8192
+
+#include <asm-generic/signal.h>
+
+/* This uses gcc anonymous union support... */
+struct siginfo;
+
+struct sigaction {
+	union {
+		__sighandler_t sa_handler;
+		void (*sa_sigaction)(int, struct siginfo *, void *);
+	};
+	unsigned long	sa_flags;
+	__sigrestore_t 	sa_restorer;
+	sigset_t	sa_mask;
+};
+
+#endif
diff --git a/usr/include/arch/i386/klibc/archstat.h b/usr/include/arch/i386/klibc/archstat.h
new file mode 100644
index 0000000..c00f955
--- /dev/null
+++ b/usr/include/arch/i386/klibc/archstat.h
@@ -0,0 +1,38 @@
+#ifndef _KLIBC_ARCHSTAT_H
+#define _KLIBC_ARCHSTAT_H
+
+#include <klibc/stathelp.h>
+
+#define _STATBUF_ST_NSEC
+
+/* This matches struct stat64 in glibc2.1, hence the absolutely
+ * insane amounts of padding around dev_t's.
+ */
+struct stat {
+	__stdev64	(st_dev);
+	unsigned char	__pad0[4];
+
+	unsigned long	__st_ino;
+
+	unsigned int	st_mode;
+	unsigned int	st_nlink;
+
+	unsigned long	st_uid;
+	unsigned long	st_gid;
+
+	__stdev64	(st_rdev);
+	unsigned char	__pad3[4];
+
+	long long	st_size;
+	unsigned long	st_blksize;
+
+	unsigned long long st_blocks;	/* Number 512-byte blocks allocated. */
+
+	struct timespec st_atim;
+	struct timespec st_mtim;
+	struct timespec st_ctim;
+
+	unsigned long long	st_ino;
+};
+
+#endif
diff --git a/usr/include/arch/i386/klibc/diverr.h b/usr/include/arch/i386/klibc/diverr.h
new file mode 100644
index 0000000..fa238ac
--- /dev/null
+++ b/usr/include/arch/i386/klibc/diverr.h
@@ -0,0 +1,15 @@
+/*
+ * arch/i386/include/klibc/diverr.h
+ */
+
+#ifndef _KLIBC_DIVERR_H
+#define _KLIBC_DIVERR_H
+
+#include <signal.h>
+
+static __inline__ void __divide_error(void)
+{
+	asm volatile ("int $0");
+}
+
+#endif				/* _KLIBC_DIVERR_H */
diff --git a/usr/include/arch/i386/sys/io.h b/usr/include/arch/i386/sys/io.h
new file mode 100644
index 0000000..cf31b97
--- /dev/null
+++ b/usr/include/arch/i386/sys/io.h
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
+	asm volatile ("outb %0,%1" : : "a" (__v), "dN" (__p));
+}
+
+static __inline__ void outw(unsigned short __v, unsigned short __p)
+{
+	asm volatile ("outw %0,%1" : : "a" (__v), "dN" (__p));
+}
+
+static __inline__ void outl(unsigned int __v, unsigned short __p)
+{
+	asm volatile ("outl %0,%1" : : "a" (__v), "dN" (__p));
+}
+
+static __inline__ unsigned char inb(unsigned short __p)
+{
+	unsigned char __v;
+	asm volatile ("inb %1,%0" : "=a" (__v) : "dN" (__p));
+	return __v;
+}
+
+static __inline__ unsigned short inw(unsigned short __p)
+{
+	unsigned short __v;
+	asm volatile ("inw %1,%0" : "=a" (__v) : "dN" (__p));
+	return __v;
+}
+
+static __inline__ unsigned int inl(unsigned short __p)
+{
+	unsigned int __v;
+	asm volatile ("inl %1,%0" : "=a" (__v) : "dN" (__p));
+	return __v;
+}
+
+/* String I/O macros */
+
+static __inline__ void
+outsb(unsigned short __p, const void *__d, unsigned long __n)
+{
+	asm volatile ("cld; rep; outsb"
+		      : "+S" (__d), "+c" (__n)
+		      : "d" (__p));
+}
+
+static __inline__ void
+outsw(unsigned short __p, const void *__d, unsigned long __n)
+{
+	asm volatile ("cld; rep; outsw"
+		      : "+S" (__d), "+c" (__n)
+		      : "d" (__p));
+}
+
+static __inline__ void
+outsl(unsigned short __p, const void *__d, unsigned long __n)
+{
+	asm volatile ("cld; rep; outsl"
+		      : "+S" (__d), "+c"(__n)
+		      : "d" (__p));
+}
+
+static __inline__ void insb(unsigned short __p, void *__d, unsigned long __n)
+{
+	asm volatile ("cld; rep; insb"
+		      : "+D" (__d), "+c" (__n)
+		      : "d" (__p));
+}
+
+static __inline__ void insw(unsigned short __p, void *__d, unsigned long __n)
+{
+	asm volatile ("cld; rep; insw"
+		      : "+D" (__d), "+c" (__n)
+		      : "d" (__p));
+}
+
+static __inline__ void insl(unsigned short __p, void *__d, unsigned long __n)
+{
+	asm volatile ("cld; rep; insl"
+		      : "+D" (__d), "+c" (__n)
+		      : "d" (__p));
+}
+
+#endif				/* _SYS_IO_H */
diff --git a/usr/include/arch/i386/sys/vm86.h b/usr/include/arch/i386/sys/vm86.h
new file mode 100644
index 0000000..c4651cd
--- /dev/null
+++ b/usr/include/arch/i386/sys/vm86.h
@@ -0,0 +1,40 @@
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
+ * sys/vm86.h for i386
+ */
+
+#ifndef _SYS_VM86_H
+#define _SYS_VM86_H 1
+
+#include <asm/vm86.h>
+
+/* Actual system call */
+int vm86(struct vm86_struct *);
+
+#endif
diff --git a/usr/klibc/arch/i386/MCONFIG b/usr/klibc/arch/i386/MCONFIG
new file mode 100644
index 0000000..e173266
--- /dev/null
+++ b/usr/klibc/arch/i386/MCONFIG
@@ -0,0 +1,33 @@
+# -*- makefile -*-
+#
+# arch/i386/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+# Enable this to compile with register parameters; only safe for
+# gcc >= 3
+
+ifeq ($(CONFIG_REGPARM),y)
+REGPARM_OPT := -mregparm=3 -D_REGPARM=3
+endif
+
+gcc_align_option  := $(call cc-option, \
+		-falign-functions=0 -falign-jumps=0 -falign-loops=0, \
+		-malign-functions=0 -malign-jumps=0 -malign-loops=0)
+gcc_m32_option  := $(call cc-option, -m32, )
+
+KLIBCOPTFLAGS     = -march=i386 -Os -g -fomit-frame-pointer $(gcc_align_option)
+KLIBCLDFLAGS      = -m elf_i386
+KLIBCREQFLAGS	  += $(REGPARM_OPT)
+KLIBCARCHREQFLAGS += $(gcc_m32_option)
+
+KLIBCBITSIZE  = 32
+
+# Extra linkflags when building the shared version of the library
+# This address needs to be reachable using normal inter-module
+# calls, and work on the memory models for this architecture
+# 96 MB - normal binaries start at 128 MB
+KLIBCSHAREDFLAGS	= -Ttext 0x06000200
diff --git a/usr/klibc/arch/i386/Makefile.inc b/usr/klibc/arch/i386/Makefile.inc
new file mode 100644
index 0000000..d13a28f
--- /dev/null
+++ b/usr/klibc/arch/i386/Makefile.inc
@@ -0,0 +1,30 @@
+# -*- makefile -*-
+#
+# arch/i386/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHOBJS = \
+	arch/$(KLIBCARCH)/socketcall.o \
+	arch/$(KLIBCARCH)/setjmp.o \
+	arch/$(KLIBCARCH)/syscall.o \
+	arch/$(KLIBCARCH)/varsyscall.o \
+	arch/$(KLIBCARCH)/open.o \
+	arch/$(KLIBCARCH)/openat.o \
+	arch/$(KLIBCARCH)/sigreturn.o \
+	arch/$(KLIBCARCH)/vfork.o \
+	arch/$(KLIBCARCH)/libgcc/__ashldi3.o \
+	arch/$(KLIBCARCH)/libgcc/__ashrdi3.o \
+	arch/$(KLIBCARCH)/libgcc/__lshrdi3.o \
+	arch/$(KLIBCARCH)/libgcc/__muldi3.o \
+	arch/$(KLIBCARCH)/libgcc/__negdi2.o \
+	libgcc/__divdi3.o \
+	libgcc/__moddi3.o \
+	libgcc/__udivdi3.o \
+	libgcc/__umoddi3.o \
+	libgcc/__udivmoddi4.o
+
+archclean:
diff --git a/usr/klibc/arch/i386/crt0.S b/usr/klibc/arch/i386/crt0.S
new file mode 100644
index 0000000..8c6635e
--- /dev/null
+++ b/usr/klibc/arch/i386/crt0.S
@@ -0,0 +1,31 @@
+#
+# arch/i386/crt0.S
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
+	# Save the address of the ELF argument array
+	movl %esp,%eax		# Address of ELF arguments
+	# Set up a faux stack frame for the benefit of gdb
+	xorl %ebp,%ebp
+	push %ebp		# Keep gdb from getting confused
+	push %ebp		# Keep gdb from getting confused
+	# Push the arguments and called __libc_init()
+#ifndef _REGPARM
+	push %edx		# atexit() function
+	push %eax		# ELF array
+#endif
+	call __libc_init
+	# If __libc_init returns, problem...
+	hlt
+
+	.size _start, .-_start
diff --git a/usr/klibc/arch/i386/libgcc/__ashldi3.S b/usr/klibc/arch/i386/libgcc/__ashldi3.S
new file mode 100644
index 0000000..7344142
--- /dev/null
+++ b/usr/klibc/arch/i386/libgcc/__ashldi3.S
@@ -0,0 +1,29 @@
+/*
+ * arch/i386/libgcc/__ashldi3.S
+ *
+ * 64-bit shl
+ */
+	.text
+	.align 4
+	.globl __ashldi3
+	.type __ashldi3,@function
+__ashldi3:
+#ifndef _REGPARM
+	movl  4(%esp),%eax
+	movl  8(%esp),%edx
+	movb  12(%esp),%cl
+#endif
+	cmpb  $32,%cl
+	jae   1f
+
+	shldl %cl,%eax,%edx
+	shl   %cl,%eax
+	ret
+
+1:
+	xorl  %edx,%edx
+	shl   %cl,%eax
+	xchgl %edx,%eax
+	ret
+
+	.size __ashldi3,.-__ashldi3
diff --git a/usr/klibc/arch/i386/libgcc/__ashrdi3.S b/usr/klibc/arch/i386/libgcc/__ashrdi3.S
new file mode 100644
index 0000000..7666eb2
--- /dev/null
+++ b/usr/klibc/arch/i386/libgcc/__ashrdi3.S
@@ -0,0 +1,29 @@
+/*
+ * arch/i386/libgcc/__ashrdi3.S
+ *
+ * 64-bit sar
+ */
+	.text
+	.align 4
+	.globl __ashrdi3
+	.type __ashrdi3,@function
+__ashrdi3:
+#ifndef _REGPARM
+	movl  4(%esp),%eax
+	movl  8(%esp),%edx
+	movb  12(%esp),%cl
+#endif
+	cmpb  $32,%cl
+	jae   1f
+
+	shrdl %cl,%edx,%eax
+	sarl  %cl,%edx
+	ret
+
+1:
+	sarl  %cl,%edx
+	movl  %edx,%eax
+	cdq
+	ret
+
+	.size __ashrdi3,.-__ashrdi3
diff --git a/usr/klibc/arch/i386/libgcc/__lshrdi3.S b/usr/klibc/arch/i386/libgcc/__lshrdi3.S
new file mode 100644
index 0000000..6a63c52
--- /dev/null
+++ b/usr/klibc/arch/i386/libgcc/__lshrdi3.S
@@ -0,0 +1,29 @@
+/*
+ * arch/i386/libgcc/__lshrdi3.S
+ *
+ * 64-bit shr
+ */
+	.text
+	.align 4
+	.globl __lshrdi3
+	.type __lshrdi3,@function
+__lshrdi3:
+#ifndef _REGPARM
+	movl  4(%esp),%eax
+	movl  8(%esp),%edx
+	movb  12(%esp),%cl
+#endif
+	cmpb  $32,%cl
+	jae   1f
+
+	shrdl %cl,%edx,%eax
+	shrl  %cl,%edx
+	ret
+
+1:
+	shrl  %cl,%edx
+	xorl  %eax,%eax
+	xchgl %edx,%eax
+	ret
+
+	.size __lshrdi3,.-__lshrdi3
diff --git a/usr/klibc/arch/i386/libgcc/__muldi3.S b/usr/klibc/arch/i386/libgcc/__muldi3.S
new file mode 100644
index 0000000..472c7cc
--- /dev/null
+++ b/usr/klibc/arch/i386/libgcc/__muldi3.S
@@ -0,0 +1,34 @@
+/*
+ * arch/i386/libgcc/__muldi3.S
+ *
+ * 64*64 = 64 bit unsigned multiplication
+ */
+
+	.text
+	.align 4
+	.globl __muldi3
+	.type __muldi3,@function
+__muldi3:
+	push  %esi
+#ifndef _REGPARM
+	movl  8(%esp),%eax
+	movl  %eax,%esi
+	movl  16(%esp),%ecx
+	mull  %ecx
+	imull 12(%esp),%ecx
+	imull 20(%esp),%esi
+	addl  %ecx,%edx
+	addl  %esi,%edx
+#else
+	movl  %eax,%esi
+	push  %edx
+	mull  %ecx
+	imull 8(%esp),%esi
+	addl  %esi,%edx
+	pop   %esi
+	imull %esi,%ecx
+	addl  %ecx,%edx
+#endif
+	pop   %esi
+	ret
+	.size __muldi3,.-__muldi3
diff --git a/usr/klibc/arch/i386/libgcc/__negdi2.S b/usr/klibc/arch/i386/libgcc/__negdi2.S
new file mode 100644
index 0000000..147ad94
--- /dev/null
+++ b/usr/klibc/arch/i386/libgcc/__negdi2.S
@@ -0,0 +1,21 @@
+/*
+ * arch/i386/libgcc/__negdi2.S
+ *
+ * 64-bit negation
+ */
+
+	.text
+	.align 4
+	.globl __negdi2
+	.type __negdi2,@function
+__negdi2:
+#ifndef _REGPARM
+	movl 4(%esp),%eax
+	movl 8(%esp),%edx
+#endif
+	negl %edx
+	negl %eax
+	sbbl $0,%edx
+	ret
+
+	.size __negdi2,.-__negdi2
diff --git a/usr/klibc/arch/i386/open.S b/usr/klibc/arch/i386/open.S
new file mode 100644
index 0000000..7cd136c
--- /dev/null
+++ b/usr/klibc/arch/i386/open.S
@@ -0,0 +1,29 @@
+/*
+ * arch/i386/open.S
+ *
+ * Handle the open() system call - oddball due to the varadic
+ * prototype, which forces the use of the cdecl calling convention,
+ * and the need for O_LARGEFILE.
+ */
+
+#include <asm/unistd.h>
+
+/* <asm/fcntl.h>, despite the name, isn't assembly-safe */
+#define O_LARGEFILE     0100000
+
+	.globl	open
+	.type	open,@function
+
+open:
+#ifdef _REGPARM
+	movl	4(%esp),%eax
+	movl	8(%esp),%edx
+	movl	12(%esp),%ecx
+	orl	$O_LARGEFILE,%edx
+#else
+	orl	$O_LARGEFILE,8(%esp)
+#endif
+	pushl	$__NR_open
+	jmp	__syscall_common
+
+	.size	open,.-open
diff --git a/usr/klibc/arch/i386/openat.S b/usr/klibc/arch/i386/openat.S
new file mode 100644
index 0000000..2dfdfe2
--- /dev/null
+++ b/usr/klibc/arch/i386/openat.S
@@ -0,0 +1,26 @@
+/*
+ * arch/i386/openat.S
+ *
+ * Handle the openat() system call - oddball due to the varadic
+ * prototype, which forces the use of the cdecl calling convention,
+ * and the need for O_LARGEFILE.
+ */
+
+#include <asm/unistd.h>
+
+/* <asm/fcntl.h>, despite the name, isn't assembly-safe */
+#define O_LARGEFILE     0100000
+
+#ifdef __NR_openat		/* Don't build if kernel headers too old */
+
+	.globl	openat
+	.type	openat,@function
+
+openat:
+	orl	$O_LARGEFILE,12(%esp)
+	pushl	$__NR_openat
+	jmp	__syscall_varadic
+
+	.size	openat,.-openat
+
+#endif
diff --git a/usr/klibc/arch/i386/setjmp.S b/usr/klibc/arch/i386/setjmp.S
new file mode 100644
index 0000000..b766792
--- /dev/null
+++ b/usr/klibc/arch/i386/setjmp.S
@@ -0,0 +1,58 @@
+#
+# arch/i386/setjmp.S
+#
+# setjmp/longjmp for the i386 architecture
+#
+
+#
+# The jmp_buf is assumed to contain the following, in order:
+#	%ebx
+#	%esp
+#	%ebp
+#	%esi
+#	%edi
+#	<return address>
+#
+
+	.text
+	.align 4
+	.globl setjmp
+	.type setjmp, @function
+setjmp:
+#ifdef _REGPARM
+	movl %eax,%edx
+#else
+	movl 4(%esp),%edx
+#endif
+	popl %ecx			# Return address, and adjust the stack
+	xorl %eax,%eax			# Return value
+	movl %ebx,(%edx)
+	movl %esp,4(%edx)		# Post-return %esp!
+	pushl %ecx			# Make the call/return stack happy
+	movl %ebp,8(%edx)
+	movl %esi,12(%edx)
+	movl %edi,16(%edx)
+	movl %ecx,20(%edx)		# Return address
+	ret
+
+	.size setjmp,.-setjmp
+
+	.text
+	.align 4
+	.globl longjmp
+	.type longjmp, @function
+longjmp:
+#ifdef _REGPARM
+	xchgl %eax,%edx
+#else
+	movl 4(%esp),%edx		# jmp_ptr address
+	movl 8(%esp),%eax		# Return value
+#endif
+	movl (%edx),%ebx
+	movl 4(%edx),%esp
+	movl 8(%edx),%ebp
+	movl 12(%edx),%esi
+	movl 16(%edx),%edi
+	jmp *20(%edx)
+
+	.size longjmp,.-longjmp
diff --git a/usr/klibc/arch/i386/sigreturn.S b/usr/klibc/arch/i386/sigreturn.S
new file mode 100644
index 0000000..f2a3241
--- /dev/null
+++ b/usr/klibc/arch/i386/sigreturn.S
@@ -0,0 +1,15 @@
+#
+# arch/i386/sigreturn.S
+#
+
+#include <asm/unistd.h>
+
+	.text
+	.align 4
+	.globl __sigreturn
+	.type __sigreturn,@function
+__sigreturn:
+	pop	%eax		# Have no idea why this is needed...
+	movl	$__NR_sigreturn,%eax
+	int	$0x80
+	.size __sigreturn,.-__sigreturn
diff --git a/usr/klibc/arch/i386/socketcall.S b/usr/klibc/arch/i386/socketcall.S
new file mode 100644
index 0000000..816db34
--- /dev/null
+++ b/usr/klibc/arch/i386/socketcall.S
@@ -0,0 +1,55 @@
+#
+# socketcall.S
+#
+# Socketcalls use the following convention:
+# %eax = __NR_socketcall
+# %ebx = socketcall number
+# %ecx = pointer to arguments (up to 6)
+#
+	
+#include <asm/unistd.h>
+
+#ifdef __i386__
+
+	.text
+	.align 4
+	.globl __socketcall_common
+	.type __socketcall_common, @function
+
+__socketcall_common:
+	xchgl	%ebx,(%esp)	# The stub passes the socketcall # on stack
+
+#ifdef	_REGPARM
+	pushl	16(%esp)	# Arg 6
+	pushl	16(%esp)	# Arg 5
+	pushl	16(%esp)	# Arg 4
+	pushl	%ecx
+	pushl	%edx
+	pushl	%eax
+	movl	%esp,%ecx
+#else
+	leal	8(%esp),%ecx	# Arguments already contiguous on-stack
+#endif
+
+	movl	$__NR_socketcall,%eax
+	int	$0x80
+
+#ifdef	_REGPARM
+	addl	$6*4, %esp
+#endif
+	
+	cmpl	$-4095,%eax	# Error return?
+
+	popl	%ebx
+
+	jb	1f
+
+	negl	%eax
+	movl	%eax,errno
+	orl	$-1,%eax	# Return -1
+1:
+	ret
+
+	.size __socketcall_common,.-__socketcall_common
+
+#endif
diff --git a/usr/klibc/arch/i386/syscall.S b/usr/klibc/arch/i386/syscall.S
new file mode 100644
index 0000000..d28717b
--- /dev/null
+++ b/usr/klibc/arch/i386/syscall.S
@@ -0,0 +1,69 @@
+/*
+ * arch/i386/syscall.S
+ *
+ * Common tail-handling code for system calls.
+ *
+ * The arguments are on the stack; the system call number in %eax.
+ */
+
+#define ARG(n)	(4*n+20)(%esp)
+
+	.text
+	.align	4
+	.globl	__syscall_common
+	.type	__syscall_common,@function
+__syscall_common:
+#ifdef _REGPARM
+	xchgl	%ebx,(%esp)
+#else
+	popl	%eax
+	pushl	%ebx
+#endif
+	pushl	%esi
+	pushl	%edi
+	pushl	%ebp
+
+#ifdef _REGPARM
+	xchgl	%eax,%ebx
+	xchgl	%ecx,%edx
+	movl	ARG(0),%esi
+	movl	ARG(1),%edi
+	movl	ARG(2),%ebp
+#else
+	movl	ARG(0),%ebx		# Syscall arguments
+	movl	ARG(1),%ecx
+	movl	ARG(2),%edx
+	movl	ARG(3),%esi
+	movl	ARG(4),%edi
+	movl	ARG(5),%ebp
+#endif
+	.globl __syscall_common_tail
+__syscall_common_tail:
+	int	$0x80
+
+	cmpl	$-4095,%eax
+
+	popl	%ebp
+	popl	%edi
+	popl	%esi
+	popl	%ebx
+
+	jb	1f
+
+	# Error return, must set errno
+	negl	%eax
+	movl	%eax,errno
+	orl	$-1,%eax		# Return -1
+
+1:
+	ret
+
+	.size	__syscall_common,.-__syscall_common
+
+#ifndef _REGPARM
+
+	.globl	__syscall_varadic
+	.type	__syscall_varadic,@function
+__syscall_varadic = __syscall_common
+
+#endif
diff --git a/usr/klibc/arch/i386/sysstub.ph b/usr/klibc/arch/i386/sysstub.ph
new file mode 100644
index 0000000..e73a3ff
--- /dev/null
+++ b/usr/klibc/arch/i386/sysstub.ph
@@ -0,0 +1,26 @@
+# -*- perl -*-
+#
+# arch/i386/sysstub.ph
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
+
+    $stype = 'common' if ( $stype eq '' );
+
+    print OUT "\tpushl \$__NR_${sname}\n";
+    print OUT "\tjmp __syscall_$stype\n";
+    print OUT "\t.size ${fname},.-${fname}\n";
+    close(OUT);
+}
+
+1;
diff --git a/usr/klibc/arch/i386/varsyscall.S b/usr/klibc/arch/i386/varsyscall.S
new file mode 100644
index 0000000..24329ea
--- /dev/null
+++ b/usr/klibc/arch/i386/varsyscall.S
@@ -0,0 +1,36 @@
+/*
+ * arch/i386/varsyscall.S
+ *
+ * Common tail-handling code for varadic system calls (which always
+ * use the cdecl convention.)
+ *
+ * The arguments are on the stack; the system call number in %eax.
+ */
+
+#ifdef	_REGPARM
+
+#define ARG(n)	(4*n+20)(%esp)
+
+	.text
+	.align	4
+	.globl	__syscall_varadic
+	.type	__syscall_varadic,@function
+__syscall_varadic:
+	popl	%eax
+	pushl	%ebx
+	pushl	%esi
+	pushl	%edi
+	pushl	%ebp
+
+	movl	ARG(0),%ebx		# Syscall arguments
+	movl	ARG(1),%ecx
+	movl	ARG(2),%edx
+	movl	ARG(3),%esi
+	movl	ARG(4),%edi
+	movl	ARG(5),%ebp
+
+	jmp	__syscall_common_tail
+
+	.size	__syscall_varadic,.-__syscall_varadic
+
+#endif
diff --git a/usr/klibc/arch/i386/vfork.S b/usr/klibc/arch/i386/vfork.S
new file mode 100644
index 0000000..c98ba3a
--- /dev/null
+++ b/usr/klibc/arch/i386/vfork.S
@@ -0,0 +1,26 @@
+#
+# usr/klibc/arch/i386/vfork.S
+#
+# vfork is nasty - there must be nothing at all on the stack above
+# the stack frame of the enclosing function.
+#
+
+#include <asm/unistd.h>
+
+        .text
+        .align  4
+	.globl	vfork
+	.type	vfork, @function
+vfork:
+	popl	%edx			/* Return address */
+	movl	$__NR_vfork, %eax
+	int	$0x80
+	pushl	%edx
+	cmpl	$-4095, %eax
+	jae	1f
+	ret
+1:
+	negl	%eax
+	movl	%eax, errno
+	orl	$-1, %eax
+	ret
