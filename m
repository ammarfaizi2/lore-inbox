Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423160AbWF1FTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423160AbWF1FTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423162AbWF1FSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:18:49 -0400
Received: from terminus.zytor.com ([192.83.249.54]:64461 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423159AbWF1FSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:18:35 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 08/31] ia64 support for klibc
Date: Tue, 27 Jun 2006 22:17:08 -0700
Message-Id: <klibc.200606272217.08@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the ia64 architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 2ddc0b5cb0056f213e6e279030e50c1bd223cef6
tree 7bbf2602b638130dc949cd1d23981da665f3bddd
parent 0b76ae4ad7c15cddd0d1202234f5dbc75e8dde56
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:36 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:36 -0700

 usr/include/arch/ia64/klibc/archconfig.h |   17 +
 usr/include/arch/ia64/klibc/archsetjmp.h |   17 +
 usr/include/arch/ia64/klibc/archsignal.h |   32 +++
 usr/include/arch/ia64/klibc/archstat.h   |   26 ++
 usr/include/arch/ia64/klibc/archsys.h    |  217 +++++++++++++++++++
 usr/klibc/arch/ia64/MCONFIG              |   11 +
 usr/klibc/arch/ia64/Makefile.inc         |   26 ++
 usr/klibc/arch/ia64/crt0.S               |   27 ++
 usr/klibc/arch/ia64/pipe.c               |   41 ++++
 usr/klibc/arch/ia64/setjmp.S             |  343 ++++++++++++++++++++++++++++++
 usr/klibc/arch/ia64/syscall.S            |   20 ++
 usr/klibc/arch/ia64/sysstub.ph           |   29 +++
 usr/klibc/arch/ia64/vfork.S              |   42 ++++
 13 files changed, 848 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/ia64/klibc/archconfig.h b/usr/include/arch/ia64/klibc/archconfig.h
new file mode 100644
index 0000000..adbd1ee
--- /dev/null
+++ b/usr/include/arch/ia64/klibc/archconfig.h
@@ -0,0 +1,17 @@
+/*
+ * include/arch/ia64/klibc/archconfig.h
+ *
+ * See include/klibc/sysconfig.h for the options that can be set in
+ * this file.
+ *
+ */
+
+#ifndef _KLIBC_ARCHCONFIG_H
+#define _KLIBC_ARCHCONFIG_H
+
+/* IA64 doesn't have sys_fork, but it does have an MMU */
+#define _KLIBC_NO_MMU 0
+/* IA64 doesn't have sys_vfork, it has architecture-specific code */
+#define _KLIBC_REAL_VFORK 1
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/ia64/klibc/archsetjmp.h b/usr/include/arch/ia64/klibc/archsetjmp.h
new file mode 100644
index 0000000..43564ee
--- /dev/null
+++ b/usr/include/arch/ia64/klibc/archsetjmp.h
@@ -0,0 +1,17 @@
+/*
+ * arch/ia64/include/klibc/archsetjmp.h
+ *
+ * Code borrowed from the FreeBSD kernel.
+ *
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+/* User code must not depend on the internal representation of jmp_buf. */
+#define _JBLEN 0x200
+
+/* guaranteed 128-bit alignment! */
+typedef char jmp_buf[_JBLEN] __attribute__ ((aligned(16)));
+
+#endif
diff --git a/usr/include/arch/ia64/klibc/archsignal.h b/usr/include/arch/ia64/klibc/archsignal.h
new file mode 100644
index 0000000..fbc961b
--- /dev/null
+++ b/usr/include/arch/ia64/klibc/archsignal.h
@@ -0,0 +1,32 @@
+/*
+ * arch/ia64/include/klibc/archsignal.h
+ *
+ * Architecture-specific signal definitions.
+ *
+ */
+
+#ifndef _KLIBC_ARCHSIGNAL_H
+#define _KLIBC_ARCHSIGNAL_H
+
+#include <asm/signal.h>
+#define _NSIG        64
+#define _NSIG_BPW    64
+#define _NSIG_WORDS (_NSIG / _NSIG_BPW)
+
+typedef struct {
+	unsigned long sig[_NSIG_WORDS];
+} sigset_t;
+
+struct sigaction {
+	union {
+		__sighandler_t _sa_handler;
+		void (*_sa_sigaction) (int, struct siginfo *, void *);
+	} _u;
+	sigset_t sa_mask;
+	int sa_flags;
+};
+
+#define sa_handler      _u._sa_handler
+#define sa_sigaction    _u._sa_sigaction
+
+#endif
diff --git a/usr/include/arch/ia64/klibc/archstat.h b/usr/include/arch/ia64/klibc/archstat.h
new file mode 100644
index 0000000..ff38e41
--- /dev/null
+++ b/usr/include/arch/ia64/klibc/archstat.h
@@ -0,0 +1,26 @@
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
+	unsigned int	st_mode;
+	unsigned int	st_uid;
+	unsigned int	st_gid;
+	unsigned int	__pad0;
+	__stdev64	(st_rdev);
+	unsigned long	st_size;
+	struct timespec st_atim;
+	struct timespec st_mtim;
+	struct timespec st_ctim;
+	unsigned long	st_blksize;
+	long		st_blocks;
+	unsigned long	__unused[3];
+};
+
+#endif
diff --git a/usr/include/arch/ia64/klibc/archsys.h b/usr/include/arch/ia64/klibc/archsys.h
new file mode 100644
index 0000000..6007821
--- /dev/null
+++ b/usr/include/arch/ia64/klibc/archsys.h
@@ -0,0 +1,217 @@
+/*
+ * arch/ia64/include/klibc/archsys.h
+ *
+ * Architecture-specific syscall definitions
+ */
+
+#ifndef _KLIBC_ARCHSYS_H
+#define _KLIBC_ARCHSYS_H
+
+#define __IA64_BREAK "break 0x100000;;\n\t"
+
+#define _syscall0(type,name)                                            \
+type                                                                    \
+name (void)                                                             \
+{                                                                       \
+       register long _r8 asm ("r8");					\
+       register long _r10 asm ("r10");                                  \
+       register long _r15 asm ("r15") = __NR_##name;                    \
+       long _retval;                                                    \
+       __asm __volatile (__IA64_BREAK                                   \
+                         : "=r" (_r8), "=r" (_r10), "=r" (_r15)         \
+                         : "2" (_r15) ASM_ARGS_0                        \
+                         : "memory" ASM_CLOBBERS_0);                    \
+       _retval = _r8;                                                   \
+       if (_r10 == -1) {                                                \
+               errno = (_retval);                                       \
+               _retval = -1;                                            \
+       }                                                                \
+       return (type)_retval;                                                  \
+}
+
+#define _syscall1(type,name,type1,arg1)                                 \
+type                                                                    \
+name (type1 arg1)                                                       \
+{                                                                       \
+       register long _r8 asm ("r8");					\
+       register long _r10 asm ("r10");                                  \
+       register long _r15 asm ("r15") = __NR_##name;                    \
+       long _retval;                                                    \
+       LOAD_ARGS_1(arg1);                                               \
+       __asm __volatile (__IA64_BREAK                                   \
+                         : "=r" (_r8), "=r" (_r10), "=r" (_r15),        \
+                           ASM_OUTARGS_1                                \
+                         : "2" (_r15) ASM_ARGS_1                        \
+                         : "memory" ASM_CLOBBERS_1);                    \
+       _retval = _r8;                                                   \
+       if (_r10 == -1) {                                                \
+               errno = (_retval);                                       \
+               _retval = -1;                                            \
+       }                                                                \
+       return (type)_retval;                                                  \
+}
+
+#define _syscall2(type,name,type1,arg1,type2,arg2)                      \
+type                                                                    \
+name (type1 arg1, type2 arg2)                                           \
+{                                                                       \
+       register long _r8 asm ("r8");					\
+       register long _r10 asm ("r10");                                  \
+       register long _r15 asm ("r15") = __NR_##name;                    \
+       long _retval;                                                    \
+       LOAD_ARGS_2(arg1, arg2);                                         \
+       __asm __volatile (__IA64_BREAK                                   \
+                         : "=r" (_r8), "=r" (_r10), "=r" (_r15),        \
+                           ASM_OUTARGS_2                                \
+                         : "2" (_r15) ASM_ARGS_2                        \
+                         : "memory" ASM_CLOBBERS_2);                    \
+       _retval = _r8;                                                   \
+       if (_r10 == -1) {                                                \
+               errno = (_retval);                                       \
+               _retval = -1;                                            \
+       }                                                                \
+       return (type)_retval;                                                  \
+}
+
+#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3)           \
+type                                                                    \
+name (type1 arg1, type2 arg2, type3 arg3)                               \
+{                                                                       \
+       register long _r8 asm ("r8");					\
+       register long _r10 asm ("r10");                                  \
+       register long _r15 asm ("r15") = __NR_##name;                    \
+       long _retval;                                                    \
+       LOAD_ARGS_3(arg1, arg2, arg3);                                   \
+       __asm __volatile (__IA64_BREAK                                   \
+                         : "=r" (_r8), "=r" (_r10), "=r" (_r15),        \
+                           ASM_OUTARGS_3                                \
+                         : "2" (_r15) ASM_ARGS_3                        \
+                         : "memory" ASM_CLOBBERS_3);                    \
+       _retval = _r8;                                                   \
+       if (_r10 == -1) {                                                \
+               errno = (_retval);                                       \
+               _retval = -1;                                            \
+       }                                                                \
+       return (type)_retval;                                                  \
+}
+
+#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
+type                                                                    \
+name (type1 arg1, type2 arg2, type3 arg3, type4 arg4)                   \
+{                                                                       \
+       register long _r8 asm ("r8");					\
+       register long _r10 asm ("r10");                                  \
+       register long _r15 asm ("r15") = __NR_##name;                    \
+       long _retval;                                                    \
+       LOAD_ARGS_4(arg1, arg2, arg3, arg4);                             \
+       __asm __volatile (__IA64_BREAK                                   \
+                         : "=r" (_r8), "=r" (_r10), "=r" (_r15),        \
+                           ASM_OUTARGS_4                                \
+                         : "2" (_r15) ASM_ARGS_4                        \
+                         : "memory" ASM_CLOBBERS_4);                    \
+       _retval = _r8;                                                   \
+       if (_r10 == -1) {                                                \
+               errno = (_retval);                                       \
+               _retval = -1;                                            \
+       }                                                                \
+       return (type)_retval;                                                  \
+}
+
+#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5) \
+type                                                                    \
+name (type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)       \
+{                                                                       \
+       register long _r8 asm ("r8");					\
+       register long _r10 asm ("r10");                                  \
+       register long _r15 asm ("r15") = __NR_##name;                    \
+       long _retval;                                                    \
+       LOAD_ARGS_5(arg1, arg2, arg3, arg4, arg5);                       \
+       __asm __volatile (__IA64_BREAK                                   \
+                         : "=r" (_r8), "=r" (_r10), "=r" (_r15),        \
+                           ASM_OUTARGS_5                                \
+                         : "2" (_r15) ASM_ARGS_5                        \
+                         : "memory" ASM_CLOBBERS_5);                    \
+       _retval = _r8;                                                   \
+       if (_r10 == -1) {                                                \
+               errno = (_retval);                                       \
+               _retval = -1;                                            \
+       }                                                                \
+       return (type)_retval;                                                  \
+}
+
+#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5,type6,arg6) \
+type                                                                    \
+name (type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5, type6 arg6)       \
+{                                                                       \
+       register long _r8 asm ("r8");					\
+       register long _r10 asm ("r10");                                  \
+       register long _r15 asm ("r15") = __NR_##name;                    \
+       long _retval;                                                    \
+       LOAD_ARGS_6(arg1, arg2, arg3, arg4, arg5, arg6);                 \
+       __asm __volatile (__IA64_BREAK                                   \
+                         : "=r" (_r8), "=r" (_r10), "=r" (_r15),        \
+                           ASM_OUTARGS_6                                \
+                         : "2" (_r15) ASM_ARGS_6                        \
+                         : "memory" ASM_CLOBBERS_6);                    \
+       _retval = _r8;                                                   \
+       if (_r10 == -1) {                                                \
+               errno = (_retval);                                       \
+               _retval = -1;                                            \
+       }                                                                \
+       return (type)_retval;                                                  \
+}
+
+#define LOAD_ARGS_0()   do { } while (0)
+#define LOAD_ARGS_1(out0)				\
+  register long _out0 asm ("out0") = (long) (out0);	\
+  LOAD_ARGS_0 ()
+#define LOAD_ARGS_2(out0, out1)				\
+  register long _out1 asm ("out1") = (long) (out1);	\
+  LOAD_ARGS_1 (out0)
+#define LOAD_ARGS_3(out0, out1, out2)			\
+  register long _out2 asm ("out2") = (long) (out2);	\
+  LOAD_ARGS_2 (out0, out1)
+#define LOAD_ARGS_4(out0, out1, out2, out3)		\
+  register long _out3 asm ("out3") = (long) (out3);	\
+  LOAD_ARGS_3 (out0, out1, out2)
+#define LOAD_ARGS_5(out0, out1, out2, out3, out4)	\
+  register long _out4 asm ("out4") = (long) (out4);	\
+  LOAD_ARGS_4 (out0, out1, out2, out3)
+#define LOAD_ARGS_6(out0, out1, out2, out3, out4, out5)	\
+  register long _out5 asm ("out5") = (long) (out5);	\
+  LOAD_ARGS_5 (out0, out1, out2, out3, out4)
+
+#define ASM_OUTARGS_1	"=r" (_out0)
+#define ASM_OUTARGS_2	ASM_OUTARGS_1, "=r" (_out1)
+#define ASM_OUTARGS_3	ASM_OUTARGS_2, "=r" (_out2)
+#define ASM_OUTARGS_4	ASM_OUTARGS_3, "=r" (_out3)
+#define ASM_OUTARGS_5	ASM_OUTARGS_4, "=r" (_out4)
+#define ASM_OUTARGS_6	ASM_OUTARGS_5, "=r" (_out5)
+
+#define ASM_ARGS_0
+#define ASM_ARGS_1	ASM_ARGS_0, "3" (_out0)
+#define ASM_ARGS_2	ASM_ARGS_1, "4" (_out1)
+#define ASM_ARGS_3	ASM_ARGS_2, "5" (_out2)
+#define ASM_ARGS_4	ASM_ARGS_3, "6" (_out3)
+#define ASM_ARGS_5	ASM_ARGS_4, "7" (_out4)
+#define ASM_ARGS_6	ASM_ARGS_5, "8" (_out5)
+
+#define ASM_CLOBBERS_0	ASM_CLOBBERS_1, "out0"
+#define ASM_CLOBBERS_1	ASM_CLOBBERS_2, "out1"
+#define ASM_CLOBBERS_2	ASM_CLOBBERS_3, "out2"
+#define ASM_CLOBBERS_3	ASM_CLOBBERS_4, "out3"
+#define ASM_CLOBBERS_4	ASM_CLOBBERS_5, "out4"
+#define ASM_CLOBBERS_5	ASM_CLOBBERS_6, "out5"
+#define ASM_CLOBBERS_6	, "out6", "out7",				\
+  /* Non-stacked integer registers, minus r8, r10, r15.  */		\
+  "r2", "r3", "r9", "r11", "r12", "r13", "r14", "r16", "r17", "r18",	\
+  "r19", "r20", "r21", "r22", "r23", "r24", "r25", "r26", "r27",	\
+  "r28", "r29", "r30", "r31",						\
+  /* Predicate registers.  */						\
+  "p6", "p7", "p8", "p9", "p10", "p11", "p12", "p13", "p14", "p15",	\
+  /* Non-rotating fp registers.  */					\
+  "f6", "f7", "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",	\
+  /* Branch registers.  */						\
+  "b6", "b7"
+
+#endif				/* _KLIBC_ARCHSYS_H */
diff --git a/usr/klibc/arch/ia64/MCONFIG b/usr/klibc/arch/ia64/MCONFIG
new file mode 100644
index 0000000..99dd4a5
--- /dev/null
+++ b/usr/klibc/arch/ia64/MCONFIG
@@ -0,0 +1,11 @@
+# -*- makefile -*-
+#
+# arch/ia64/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCOPTFLAGS = -Os
+KLIBCBITSIZE  = 64
diff --git a/usr/klibc/arch/ia64/Makefile.inc b/usr/klibc/arch/ia64/Makefile.inc
new file mode 100644
index 0000000..8bd2910
--- /dev/null
+++ b/usr/klibc/arch/ia64/Makefile.inc
@@ -0,0 +1,26 @@
+# -*- makefile -*-
+#
+# arch/ia64/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHOBJS = \
+	arch/$(KLIBCARCH)/vfork.o \
+	arch/$(KLIBCARCH)/setjmp.o \
+	arch/$(KLIBCARCH)/pipe.o \
+	arch/$(KLIBCARCH)/syscall.o \
+	libgcc/__divdi3.o \
+	libgcc/__divsi3.o \
+	libgcc/__udivdi3.o \
+	libgcc/__udivsi3.o \
+	libgcc/__umodsi3.o \
+	libgcc/__umoddi3.o \
+	libgcc/__udivmodsi4.o \
+	libgcc/__udivmoddi4.o
+
+KLIBCARCHSOOBJS = $(patsubst %o,%.lo,%(KLIBCARCHOBJS))
+
+archclean:
diff --git a/usr/klibc/arch/ia64/crt0.S b/usr/klibc/arch/ia64/crt0.S
new file mode 100644
index 0000000..722276e
--- /dev/null
+++ b/usr/klibc/arch/ia64/crt0.S
@@ -0,0 +1,27 @@
+
+#include <asm/fpu.h>
+
+	.align 32
+	.global _start
+
+	.proc _start
+	.type _start,@function
+_start:
+	.prologue
+	.save rp, r0
+
+	alloc r2 = ar.pfs,0,0,2,0
+	movl r3 = FPSR_DEFAULT
+	;;
+	adds out0= 16,sp    /* argc pointer */
+	movl gp = @gprel(0f)
+0:	mov r9 = ip
+	;;
+	sub gp = r9, gp     /* back-compute gp value */
+
+	.body
+	br.call.sptk.few rp = __libc_init
+	;;
+	break 0             /* break miserably if we ever return */
+
+	.endp _start
diff --git a/usr/klibc/arch/ia64/pipe.c b/usr/klibc/arch/ia64/pipe.c
new file mode 100644
index 0000000..fa3a272
--- /dev/null
+++ b/usr/klibc/arch/ia64/pipe.c
@@ -0,0 +1,41 @@
+/*
+ * pipe.c
+ */
+
+#include <sys/syscall.h>
+#include <klibc/archsys.h>
+
+#define ASM_CLOBBERS ,"out2", "out3", "out4", "out5", "out6", "out7",    \
+   /* Non-stacked integer registers, minus r8, r9, r10, r15.  */	\
+  "r2", "r3", "r11", "r12", "r13", "r14", "r16", "r17", "r18",	        \
+  "r19", "r20", "r21", "r22", "r23", "r24", "r25", "r26", "r27",	\
+  "r28", "r29", "r30", "r31",						\
+  /* Predicate registers.  */						\
+  "p6", "p7", "p8", "p9", "p10", "p11", "p12", "p13", "p14", "p15",	\
+  /* Non-rotating fp registers.  */					\
+  "f6", "f7", "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",	\
+  /* Branch registers.  */						\
+  "b6", "b7"
+
+int pipe(int *filedes)
+{
+	register long _r8 asm("r8");
+	register long _r9 asm("r9");
+	register long _r10 asm("r10");
+	register long _r15 asm("r15") = __NR_pipe;
+	register long _out0 asm("out0") = (long)filedes;
+	long _retval;
+	__asm __volatile(__IA64_BREAK:"=r"(_r8), "=r"(_r10), "=r"(_r15),
+			 "=r"(_out0), "=r"(_r9)
+			 :"2"(_r15), "3"(_out0)
+			 :"memory" ASM_CLOBBERS);
+	if (_r10 == -1) {
+		errno = _r8;
+		_retval = -1;
+	} else {
+		filedes[0] = _r8;
+		filedes[1] = _r9;
+		_retval = 0;
+	}
+	return _retval;
+}
diff --git a/usr/klibc/arch/ia64/setjmp.S b/usr/klibc/arch/ia64/setjmp.S
new file mode 100644
index 0000000..ab1cea2
--- /dev/null
+++ b/usr/klibc/arch/ia64/setjmp.S
@@ -0,0 +1,343 @@
+/*
+ * IA-64 specific setjmp/longjmp routines
+ *
+ * Inspired by setjmp.s from the FreeBSD kernel.
+ */
+
+#define	J_UNAT		0
+#define	J_NATS		0x8
+#define	J_PFS		0x10
+#define	J_BSP		0x18
+#define	J_RNAT		0x20
+#define	J_PREDS		0x28
+#define	J_LC		0x30
+#define	J_R4		0x38
+#define	J_R5		0x40
+#define	J_R6		0x48
+#define	J_R7		0x50
+#define	J_SP		0x58
+#define	J_F2		0x60
+#define	J_F3		0x70
+#define	J_F4		0x80
+#define	J_F5		0x90
+#define	J_F16		0xa0
+#define	J_F17		0xb0
+#define	J_F18		0xc0
+#define	J_F19		0xd0
+#define	J_F20		0xe0
+#define	J_F21		0xf0
+#define	J_F22		0x100
+#define	J_F23		0x110
+#define	J_F24		0x120
+#define	J_F25		0x130
+#define	J_F26		0x140
+#define	J_F27		0x150
+#define	J_F28		0x160
+#define	J_F29		0x170
+#define	J_F30		0x180
+#define	J_F31		0x190
+#define	J_FPSR		0x1a0
+#define	J_B0		0x1a8
+#define	J_B1		0x1b0
+#define	J_B2		0x1b8
+#define	J_B3		0x1c0
+#define	J_B4		0x1c8
+#define	J_B5		0x1d0
+#define	J_SIGMASK	0x1d8
+#define	J_SIGSET	0x1e0
+#define	J_GP		0x1f0
+
+// int setjmp(struct jmp_buffer *)
+//
+//  Setup a non-local goto.
+//
+// Description:
+//
+//  SetJump stores the current register set in the area pointed to
+//  by "save".  It returns zero.  Subsequent calls to "LongJump" will
+//  restore the registers and return non-zero to the same location.
+//
+// On entry, r32 contains the pointer to the jmp_buffer
+//
+	.align 32
+	.global setjmp
+	.proc setjmp
+setjmp:
+    //
+    //  Make sure buffer is aligned at 16byte boundary
+    //
+    add     r10 = -0x10,r0  ;;  // mask the lower 4 bits
+    and     r32 = r32, r10;;
+    add     r32 = 0x10, r32;;   // move to next 16 byte boundary
+
+    add     r10 = J_PREDS, r32  // skip Unats & pfs save area
+    add     r11 = J_BSP, r32
+    //
+    //  save immediate context
+    //
+    mov     r2 = ar.bsp         // save backing store pointer
+    mov     r3 = pr             // save predicates
+    flushrs
+    ;;
+    //
+    // save user Unat register
+    //
+    mov     r16 = ar.lc         // save loop count register
+    mov     r14 = ar.unat       // save user Unat register
+
+    st8     [r10] = r3, J_LC-J_PREDS
+    st8     [r11] = r2, J_R4-J_BSP
+    ;;
+    st8     [r10] = r16, J_R5-J_LC
+    st8     [r32] = r14, J_NATS // Note: Unat at the
+                                // beginning of the save area
+    mov     r15 = ar.pfs
+    ;;
+    //
+    //  save preserved general registers & NaT's
+    //
+    st8.spill   [r11] = r4, J_R6-J_R4
+    ;;
+    st8.spill   [r10] = r5, J_R7-J_R5
+    ;;
+    st8.spill   [r11] = r6, J_SP-J_R6
+    ;;
+    st8.spill   [r10] = r7, J_F3-J_R7
+    ;;
+    st8.spill   [r11] = sp, J_F2-J_SP
+    ;;
+    //
+    // save spilled Unat and pfs registers
+    //
+    mov     r2 = ar.unat        // save Unat register after spill
+    ;;
+    st8     [r32] = r2, J_PFS-J_NATS    // save unat for spilled regs
+    ;;
+    st8     [r32] = r15         // save pfs
+    //
+    //  save floating registers
+    //
+    stf.spill   [r11] = f2, J_F4-J_F2
+    stf.spill   [r10] = f3, J_F5-J_F3
+    ;;
+    stf.spill   [r11] = f4, J_F16-J_F4
+    stf.spill   [r10] = f5, J_F17-J_F5
+    ;;
+    stf.spill   [r11] = f16, J_F18-J_F16
+    stf.spill   [r10] = f17, J_F19-J_F17
+    ;;
+    stf.spill   [r11] = f18, J_F20-J_F18
+    stf.spill   [r10] = f19, J_F21-J_F19
+    ;;
+    stf.spill   [r11] = f20, J_F22-J_F20
+    stf.spill   [r10] = f21, J_F23-J_F21
+    ;;
+    stf.spill   [r11] = f22, J_F24-J_F22
+    stf.spill   [r10] = f23, J_F25-J_F23
+    ;;
+    stf.spill   [r11] = f24, J_F26-J_F24
+    stf.spill   [r10] = f25, J_F27-J_F25
+    ;;
+    stf.spill   [r11] = f26, J_F28-J_F26
+    stf.spill   [r10] = f27, J_F29-J_F27
+    ;;
+    stf.spill   [r11] = f28, J_F30-J_F28
+    stf.spill   [r10] = f29, J_F31-J_F29
+    ;;
+    stf.spill   [r11] = f30, J_FPSR-J_F30
+    stf.spill   [r10] = f31, J_B0-J_F31     // size of f31 + fpsr
+    //
+    // save FPSR register & branch registers
+    //
+    mov     r2 = ar.fpsr    // save fpsr register
+    mov     r3 = b0
+    ;;
+    st8     [r11] = r2, J_B1-J_FPSR
+    st8     [r10] = r3, J_B2-J_B0
+    mov     r2 = b1
+    mov     r3 = b2
+    ;;
+    st8     [r11] = r2, J_B3-J_B1
+    st8     [r10] = r3, J_B4-J_B2
+    mov     r2 = b3
+    mov     r3 = b4
+    ;;
+    st8     [r11] = r2, J_B5-J_B3
+    st8     [r10] = r3
+    mov     r2 = b5
+    ;;
+    st8     [r11] = r2
+    ;;
+    //
+    // return
+    //
+    mov     r8 = r0         // return 0 from setjmp
+    mov     ar.unat = r14   // restore unat
+    br.ret.sptk b0
+    .endp setjmp
+
+//
+// void longjmp(struct jmp_buffer *, int val)
+//
+//  Perform a non-local goto.
+//
+// Description:
+//
+//  LongJump initializes the register set to the values saved by a
+//  previous 'SetJump' and jumps to the return location saved by that
+//  'SetJump'.  This has the effect of unwinding the stack and returning
+//  for a second time to the 'SetJump'.
+//
+
+	.align 32
+	.global longjmp
+	.proc longjmp
+longjmp:
+    //
+    //  Make sure buffer is aligned at 16byte boundary
+    //
+    add     r10 = -0x10,r0  ;;  // mask the lower 4 bits
+    and     r32 = r32, r10;;
+    add     r32 = 0x10, r32;;   // move to next 16 byte boundary
+
+    //
+    // caching the return value as we do invala in the end
+    //
+    mov     r8 = r33            // return value
+
+    //
+    //  get immediate context
+    //
+    mov     r14 = ar.rsc        // get user RSC conf
+    add     r10 = J_PFS, r32    // get address of pfs
+    add     r11 = J_NATS, r32
+    ;;
+    ld8     r15 = [r10], J_BSP-J_PFS    // get pfs
+    ld8     r2 = [r11], J_LC-J_NATS     // get unat for spilled regs
+    ;;
+    mov     ar.unat = r2
+    ;;
+    ld8     r16 = [r10], J_PREDS-J_BSP  // get backing store pointer
+    mov     ar.rsc = r0         // put RSE in enforced lazy
+    mov     ar.pfs = r15
+    ;;
+
+    //
+    // while returning from longjmp the BSPSTORE and BSP needs to be
+    // same and discard all the registers allocated after we did
+    // setjmp. Also, we need to generate the RNAT register since we
+    // did not flushed the RSE on setjmp.
+    //
+    mov     r17 = ar.bspstore   // get current BSPSTORE
+    ;;
+    cmp.ltu p6,p7 = r17, r16    // is it less than BSP of
+(p6)    br.spnt.few .flush_rse
+    mov     r19 = ar.rnat       // get current RNAT
+    ;;
+    loadrs                      // invalidate dirty regs
+    br.sptk.many    .restore_rnat       // restore RNAT
+
+.flush_rse:
+    flushrs
+    ;;
+    mov     r19 = ar.rnat       // get current RNAT
+    mov     r17 = r16           // current BSPSTORE
+    ;;
+.restore_rnat:
+    //
+    // check if RNAT is saved between saved BSP and curr BSPSTORE
+    //
+    mov     r18 = 0x3f
+    ;;
+    dep     r18 = r18,r16,3,6   // get RNAT address
+    ;;
+    cmp.ltu p8,p9 = r18, r17    // RNAT saved on RSE
+    ;;
+(p8)    ld8     r19 = [r18]     // get RNAT from RSE
+    ;;
+    mov     ar.bspstore = r16   // set new BSPSTORE
+    ;;
+    mov     ar.rnat = r19       // restore RNAT
+    mov     ar.rsc = r14        // restore RSC conf
+
+
+    ld8     r3 = [r11], J_R4-J_LC       // get lc register
+    ld8     r2 = [r10], J_R5-J_PREDS    // get predicates
+    ;;
+    mov     pr = r2, -1
+    mov     ar.lc = r3
+    //
+    //  restore preserved general registers & NaT's
+    //
+    ld8.fill    r4 = [r11], J_R6-J_R4
+    ;;
+    ld8.fill    r5 = [r10], J_R7-J_R5
+    ld8.fill    r6 = [r11], J_SP-J_R6
+    ;;
+    ld8.fill    r7 = [r10], J_F2-J_R7
+    ld8.fill    sp = [r11], J_F3-J_SP
+    ;;
+    //
+    //  restore floating registers
+    //
+    ldf.fill    f2 = [r10], J_F4-J_F2
+    ldf.fill    f3 = [r11], J_F5-J_F3
+    ;;
+    ldf.fill    f4 = [r10], J_F16-J_F4
+    ldf.fill    f5 = [r11], J_F17-J_F5
+    ;;
+    ldf.fill    f16 = [r10], J_F18-J_F16
+    ldf.fill    f17 = [r11], J_F19-J_F17
+    ;;
+    ldf.fill    f18 = [r10], J_F20-J_F18
+    ldf.fill    f19 = [r11], J_F21-J_F19
+    ;;
+    ldf.fill    f20 = [r10], J_F22-J_F20
+    ldf.fill    f21 = [r11], J_F23-J_F21
+    ;;
+    ldf.fill    f22 = [r10], J_F24-J_F22
+    ldf.fill    f23 = [r11], J_F25-J_F23
+    ;;
+    ldf.fill    f24 = [r10], J_F26-J_F24
+    ldf.fill    f25 = [r11], J_F27-J_F25
+    ;;
+    ldf.fill    f26 = [r10], J_F28-J_F26
+    ldf.fill    f27 = [r11], J_F29-J_F27
+    ;;
+    ldf.fill    f28 = [r10], J_F30-J_F28
+    ldf.fill    f29 = [r11], J_F31-J_F29
+    ;;
+    ldf.fill    f30 = [r10], J_FPSR-J_F30
+    ldf.fill    f31 = [r11], J_B0-J_F31 ;;
+
+    //
+    // restore branch registers and fpsr
+    //
+    ld8     r16 = [r10], J_B1-J_FPSR    // get fpsr
+    ld8     r17 = [r11], J_B2-J_B0      // get return pointer
+    ;;
+    mov     ar.fpsr = r16
+    mov     b0 = r17
+    ld8     r2 = [r10], J_B3-J_B1
+    ld8     r3 = [r11], J_B4-J_B2
+    ;;
+    mov     b1 = r2
+    mov     b2 = r3
+    ld8     r2 = [r10], J_B5-J_B3
+    ld8     r3 = [r11]
+    ;;
+    mov     b3 = r2
+    mov     b4 = r3
+    ld8     r2 = [r10]
+    ld8     r21 = [r32]         // get user unat
+    ;;
+    mov     b5 = r2
+    mov     ar.unat = r21
+
+    //
+    // invalidate ALAT
+    //
+    invala ;;
+
+    br.ret.sptk b0
+    .endp longjmp
diff --git a/usr/klibc/arch/ia64/syscall.S b/usr/klibc/arch/ia64/syscall.S
new file mode 100644
index 0000000..9929618
--- /dev/null
+++ b/usr/klibc/arch/ia64/syscall.S
@@ -0,0 +1,20 @@
+#
+# arch/ia64/syscall.S
+#
+
+#include <asm/unistd.h>
+
+	.text
+	.align	32
+	.proc	__syscall_error
+	.globl	__syscall_error
+__syscall_error:
+	addl	r2 = @ltoffx(errno),gp
+	;;
+	ld8.mov	r3 = [r2],errno
+	;;
+	st4	[r3] = r8
+	mov	r8 = -1
+	br.ret.sptk.many b0
+	.size	__syscall_error, .-__syscall_error
+	.endp	__syscall_error
diff --git a/usr/klibc/arch/ia64/sysstub.ph b/usr/klibc/arch/ia64/sysstub.ph
new file mode 100644
index 0000000..8e686c6
--- /dev/null
+++ b/usr/klibc/arch/ia64/sysstub.ph
@@ -0,0 +1,29 @@
+# -*- perl -*-
+#
+# arch/ia64/sysstub.ph
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
+    print OUT "\t.text\n";
+    print OUT "\t.align 32\n";
+    print OUT "\t.proc ${fname}\n";
+    print OUT "\t.globl ${fname}\n";
+    print OUT "${fname}:\n";
+    print OUT "\tmov\tr15 = __NR_${sname}\n";
+    print OUT "\tbreak __BREAK_SYSCALL\n";
+    print OUT "\tcmp.eq p6,p0 = -1,r10\n";
+    print OUT "(p6)\tbr.few __syscall_error\n";
+    print OUT "\tbr.ret.sptk.many b0\n";
+    print OUT "\t.size\t${fname},.-${fname}\n";
+    print OUT "\t.endp\t${fname}\n";
+    close(OUT);
+}
+
+1;
diff --git a/usr/klibc/arch/ia64/vfork.S b/usr/klibc/arch/ia64/vfork.S
new file mode 100644
index 0000000..1a84902
--- /dev/null
+++ b/usr/klibc/arch/ia64/vfork.S
@@ -0,0 +1,42 @@
+/*
+ * ia64 specific vfork syscall
+ *
+ * Written By:	 Martin Hicks <mort@wildopensource.com>
+ *
+ */
+
+/* This syscall is a special case of the clone syscall */
+#include <asm/unistd.h>
+#include <asm/signal.h>
+#include <klibc/archsys.h>
+
+/* These are redefined here because linux/sched.h isn't safe for
+ * inclusion in asm.
+ */
+#define CLONE_VM    0x00000100 /* set if VM shared between processes */
+#define CLONE_VFORK 0x00004000 /* set if parent wants the child to wake it up on exit */
+
+/* pid_t vfork(void) */
+/* Implemented as clone(CLONE_VFORK | CLONE_VM | SIGCHLD, 0) */
+
+	.align 32
+	.proc vfork
+	.global vfork
+vfork:
+	alloc r2=ar.pfs,0,0,2,0
+	mov	r15=__NR_clone
+	mov	out0=CLONE_VM|CLONE_VFORK|SIGCHLD
+	mov     out1=0
+	;;
+	break 0x100000      // Do the syscall
+	;;
+	addl	r15=0,r1
+	cmp.eq  p7,p6 = -1,r10
+	;;
+	ld8	r14=[r15]
+	;;
+(p7)	st4	[r14]=r8
+	;;
+(p7)	mov	r8=-1
+	br.ret.sptk.many b0
+	.endp vfork
