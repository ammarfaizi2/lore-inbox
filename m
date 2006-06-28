Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423155AbWF1FSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423155AbWF1FSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423158AbWF1FSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:18:25 -0400
Received: from terminus.zytor.com ([192.83.249.54]:53197 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423155AbWF1FST
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:18:19 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 05/31] arm support for klibc
Date: Tue, 27 Jun 2006 22:17:05 -0700
Message-Id: <klibc.200606272217.05@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the arm architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 48a54d2c17e1e7e786aa842fecb0bd3046ecd9de
tree f7949076afb232f0d1dabff12221d1c724e641b6
parent c3fe3fde33e77fa6c09cb43ca3783e6bf36ef895
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:30 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:30 -0700

 usr/include/arch/arm/klibc/archconfig.h |   14 ++++
 usr/include/arch/arm/klibc/archsetjmp.h |   14 ++++
 usr/include/arch/arm/klibc/archsignal.h |   14 ++++
 usr/include/arch/arm/klibc/archstat.h   |   40 ++++++++++++
 usr/include/arch/arm/klibc/asmmacros.h  |   30 +++++++++
 usr/klibc/arch/arm/MCONFIG              |   36 +++++++++++
 usr/klibc/arch/arm/Makefile.inc         |   23 +++++++
 usr/klibc/arch/arm/__muldi3.c           |   15 +++++
 usr/klibc/arch/arm/aeabi_nonsense.S     |    9 +++
 usr/klibc/arch/arm/crt0.S               |   23 +++++++
 usr/klibc/arch/arm/setjmp.S             |  102 +++++++++++++++++++++++++++++++
 usr/klibc/arch/arm/syscall.S            |   61 +++++++++++++++++++
 usr/klibc/arch/arm/sysstub.ph           |   58 ++++++++++++++++++
 usr/klibc/arch/arm/vfork.S              |   60 ++++++++++++++++++
 14 files changed, 499 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/arm/klibc/archconfig.h b/usr/include/arch/arm/klibc/archconfig.h
new file mode 100644
index 0000000..e34bdb7
--- /dev/null
+++ b/usr/include/arch/arm/klibc/archconfig.h
@@ -0,0 +1,14 @@
+/*
+ * include/arch/arm/klibc/archconfig.h
+ *
+ * See include/klibc/sysconfig.h for the options that can be set in
+ * this file.
+ *
+ */
+
+#ifndef _KLIBC_ARCHCONFIG_H
+#define _KLIBC_ARCHCONFIG_H
+
+/* All defaults */
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/arm/klibc/archsetjmp.h b/usr/include/arch/arm/klibc/archsetjmp.h
new file mode 100644
index 0000000..88db8a1
--- /dev/null
+++ b/usr/include/arch/arm/klibc/archsetjmp.h
@@ -0,0 +1,14 @@
+/*
+ * arch/i386/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	unsigned int regs[10];
+};
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _SETJMP_H */
diff --git a/usr/include/arch/arm/klibc/archsignal.h b/usr/include/arch/arm/klibc/archsignal.h
new file mode 100644
index 0000000..a589527
--- /dev/null
+++ b/usr/include/arch/arm/klibc/archsignal.h
@@ -0,0 +1,14 @@
+/*
+ * arch/arm/include/klibc/archsignal.h
+ *
+ * Architecture-specific signal definitions
+ *
+ */
+
+#ifndef _KLIBC_ARCHSIGNAL_H
+#define _KLIBC_ARCHSIGNAL_H
+
+#include <asm/signal.h>
+/* No special stuff for this architecture */
+
+#endif
diff --git a/usr/include/arch/arm/klibc/archstat.h b/usr/include/arch/arm/klibc/archstat.h
new file mode 100644
index 0000000..95bbc9e
--- /dev/null
+++ b/usr/include/arch/arm/klibc/archstat.h
@@ -0,0 +1,40 @@
+#ifndef _KLIBC_ARCHSTAT_H
+#define _KLIBC_ARCHSTAT_H
+
+#include <klibc/stathelp.h>
+
+#define _STATBUF_ST_NSEC
+
+/* This matches struct stat64 in glibc2.1, hence the absolutely
+ * insane amounts of padding around dev_t's.
+ * Note: The kernel zero's the padded region because glibc might read them
+ * in the hope that the kernel has stretched to using larger sizes.
+ */
+
+struct stat {
+	__stdev64	(st_dev);
+	unsigned char   __pad0[4];
+
+	unsigned long	__st_ino;
+	unsigned int	st_mode;
+	unsigned int	st_nlink;
+
+	unsigned long	st_uid;
+	unsigned long	st_gid;
+
+	__stdev64	(st_rdev);
+	unsigned char   __pad3[4];
+
+	long long	st_size;
+	unsigned long	st_blksize;
+
+	unsigned long long  st_blocks;	/* Number 512-byte blocks allocated. */
+
+	struct timespec st_atim;
+	struct timespec st_mtim;
+	struct timespec st_ctim;
+
+	unsigned long long	st_ino;
+};
+
+#endif
diff --git a/usr/include/arch/arm/klibc/asmmacros.h b/usr/include/arch/arm/klibc/asmmacros.h
new file mode 100644
index 0000000..8a21c94
--- /dev/null
+++ b/usr/include/arch/arm/klibc/asmmacros.h
@@ -0,0 +1,30 @@
+/*
+ * usr/include/arch/arm/klibc/asmmacros.h
+ *
+ * Assembly macros used by ARM system call stubs
+ */
+
+#ifndef _KLIBC_ASMMACROS_H
+#define _KLIBC_ASMMACROS_H
+
+/* An immediate in ARM can be any 8-bit value rotated by an even number of bits */
+
+#define ARM_VALID_IMM(x)	\
+	((((x) & ~0x000000ff) == 0) || \
+	 (((x) & ~0x000003fc) == 0) || \
+	 (((x) & ~0x00000ff0) == 0) || \
+	 (((x) & ~0x00003fc0) == 0) || \
+	 (((x) & ~0x0000ff00) == 0) || \
+	 (((x) & ~0x0003fc00) == 0) || \
+	 (((x) & ~0x000ff000) == 0) || \
+	 (((x) & ~0x003fc000) == 0) || \
+	 (((x) & ~0x00ff0000) == 0) || \
+	 (((x) & ~0x03fc0000) == 0) || \
+	 (((x) & ~0x0ff00000) == 0) || \
+	 (((x) & ~0x3fc00000) == 0) || \
+	 (((x) & ~0xff000000) == 0) || \
+	 (((x) & ~0xfc000003) == 0) || \
+	 (((x) & ~0xf000000f) == 0) || \
+	 (((x) & ~0xc000003f) == 0))
+
+#endif /* _KLIBC_ASMMACROS_H */
diff --git a/usr/klibc/arch/arm/MCONFIG b/usr/klibc/arch/arm/MCONFIG
new file mode 100644
index 0000000..0023eee
--- /dev/null
+++ b/usr/klibc/arch/arm/MCONFIG
@@ -0,0 +1,36 @@
+# -*- makefile -*-
+#
+# arch/arm/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+CPU_ARCH := armv4
+CPU_TUNE := strongarm
+
+KLIBCOPTFLAGS = -Os -march=$(CPU_ARCH) -mtune=$(CPU_TUNE)
+KLIBCBITSIZE  = 32
+KLIBCREQFLAGS = -fno-exceptions
+KLIBCSTRIPFLAGS += -R .ARM.exidx
+
+ifeq ($(CONFIG_KLIBC_THUMB),y)
+CPU_ARCH := $(CPU_ARCH)t
+KLIBCREQFLAGS += -mthumb
+KLIBCLDFLAGS  += --thumb-entry _start
+KLIBCEMAIN     = --thumb-entry _start
+KLIBCREQFLAGS += -mabi=aapcs-linux
+KLIBCSHAREDFLAGS = -Ttext 0x380200
+else
+# Extra linkflags when building the shared version of the library
+# This address needs to be reachable using normal inter-module
+# calls, and work on the memory models for this architecture
+KLIBCSHAREDFLAGS = -Ttext 0x01800200
+ifeq ($(CONFIG_AEABI),y)
+KLIBCREQFLAGS += -mabi=aapcs-linux -mno-thumb-interwork
+else
+KLIBCREQFLAGS += -mabi=apcs-gnu -mno-thumb-interwork
+endif
+endif
+
diff --git a/usr/klibc/arch/arm/Makefile.inc b/usr/klibc/arch/arm/Makefile.inc
new file mode 100644
index 0000000..62065df
--- /dev/null
+++ b/usr/klibc/arch/arm/Makefile.inc
@@ -0,0 +1,23 @@
+# -*- makefile -*-
+#
+# arch/arm/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHOBJS = \
+	arch/arm/setjmp.o \
+	arch/arm/syscall.o \
+	arch/arm/vfork.o \
+	arch/arm/aeabi_nonsense.o \
+	libgcc/__udivmodsi4.o \
+	libgcc/__divdi3.o \
+	libgcc/__moddi3.o \
+	libgcc/__udivdi3.o \
+	libgcc/__umoddi3.o \
+	libgcc/__udivmoddi4.o \
+	libgcc/__clzsi2.o \
+
+
diff --git a/usr/klibc/arch/arm/__muldi3.c b/usr/klibc/arch/arm/__muldi3.c
new file mode 100644
index 0000000..3fdeb2b
--- /dev/null
+++ b/usr/klibc/arch/arm/__muldi3.c
@@ -0,0 +1,15 @@
+#include <stdint.h>
+
+uint64_t __muldi3(uint64_t a, uint64_t b)
+{
+	uint32_t al = (uint32_t)a;
+	uint32_t ah = (uint32_t)(a >> 32);
+	uint32_t bl = (uint32_t)b;
+	uint32_t bh = (uint32_t)(b >> 32);
+	uint64_t v;
+
+	v = (uint64_t)al * bl;
+	v += (uint64_t)(al*bh+ah*bl) << 32;
+
+	return v;
+}
diff --git a/usr/klibc/arch/arm/aeabi_nonsense.S b/usr/klibc/arch/arm/aeabi_nonsense.S
new file mode 100644
index 0000000..c69eb11
--- /dev/null
+++ b/usr/klibc/arch/arm/aeabi_nonsense.S
@@ -0,0 +1,9 @@
+	.text
+	.globl	__aeabi_unwind_cpp_pr0
+__aeabi_unwind_cpp_pr0:
+	.globl	__aeabi_unwind_cpp_pr1
+__aeabi_unwind_cpp_pr1:
+	.globl	__aeabi_unwind_cpp_pr2
+__aeabi_unwind_cpp_pr2:
+	.globl	__aeabi_unwind_cpp_pr3
+__aeabi_unwind_cpp_pr3:
diff --git a/usr/klibc/arch/arm/crt0.S b/usr/klibc/arch/arm/crt0.S
new file mode 100644
index 0000000..1e81f8e
--- /dev/null
+++ b/usr/klibc/arch/arm/crt0.S
@@ -0,0 +1,23 @@
+#
+# arch/arm/crt0.S
+#
+# void _start(void)
+# {
+#    __libc_init(elf_structure, atexit_ptr);
+# }
+#
+
+	.text
+	.balign 4
+	.type _start,#function
+	.globl _start
+
+#ifdef __thumb__
+	.thumb_func
+#endif
+
+_start:	mov	r0, sp
+	mov	r1, #0
+	bl	__libc_init
+
+	.size _start,.-_start
diff --git a/usr/klibc/arch/arm/setjmp.S b/usr/klibc/arch/arm/setjmp.S
new file mode 100644
index 0000000..1841bc7
--- /dev/null
+++ b/usr/klibc/arch/arm/setjmp.S
@@ -0,0 +1,102 @@
+#
+# arch/arm/setjmp.S
+#
+# setjmp/longjmp for the ARM architecture
+#
+
+#ifndef	__thumb__
+
+#
+# "Pure ARM" version		
+#
+# The jmp_buf is assumed to contain the following, in order:
+#		r4
+#		r5
+#		r6
+#		r7
+#		r8
+#		r9
+#		r10
+#		fp
+#		sp
+#		lr
+#
+
+	.text
+	.balign 4
+	.globl setjmp
+	.type setjmp, #function
+setjmp:
+	stmia	r0, {r4, r5, r6, r7, r8, r9, r10, fp, sp, lr}
+	mov	r0, #0
+	mov	pc, lr
+	.size setjmp,.-setjmp
+
+	.text
+	.balign 4
+	.globl longjmp
+	.type longjmp, #function
+longjmp:
+	ldmia	r0, {r4, r5, r6, r7, r8, r9, r10, fp, sp, lr}
+	mov	r0, r1
+	mov	pc, lr
+	.size longjmp,.-longjmp
+
+#else /* __thumb__ */
+
+#
+# Thumb version
+#
+# The jmp_buf is assumed to contain the following, in order:
+#		lr
+#		r4
+#		r5
+#		r6
+#		r7
+#		r8
+#		r9
+#		r10
+#		fp
+#		sp
+#
+
+	.text
+	.balign 4
+	.globl setjmp
+	.type setjmp, #function
+	.thumb_func
+setjmp:
+	mov	r3, lr
+	stmia	r0!, {r3, r4, r5, r6, r7}
+	mov	r3, r8
+	mov	r4, r9
+	mov	r5, r10
+	mov	r6, fp
+	mov	r7, sp
+	stmia	r0!, {r3, r4, r5, r6, r7}
+	mov	r0, #0
+	mov	pc, lr
+	.size setjmp,.-setjmp
+
+	.text
+	.balign 4
+	.globl longjmp
+	.type longjmp, #function
+	.thumb_func
+longjmp:
+	mov	r2, r0
+	add	r0, #5*4
+	ldmia	r0!, {r3, r4, r5, r6, r7}
+	mov	r8, r3
+	mov	r9, r4
+	mov	r10, r5
+	mov	fp, r6
+	mov	sp, r7
+	ldmia	r2!, {r3, r4, r5, r6, r7}
+	mov	r0, r1
+	bne	1f
+	mov	r0, #1
+1:	mov	pc, r3
+	.size longjmp,.-longjmp
+
+#endif /* __thumb__ */
diff --git a/usr/klibc/arch/arm/syscall.S b/usr/klibc/arch/arm/syscall.S
new file mode 100644
index 0000000..5bc291d
--- /dev/null
+++ b/usr/klibc/arch/arm/syscall.S
@@ -0,0 +1,61 @@
+/*
+ * arch/arm/syscall.S
+ *
+ * System call common handling
+ */
+
+	.type	__syscall_common,#function
+	.globl	__syscall_common
+#ifndef __thumb__
+	/* ARM version - this is executed after the swi, unless
+	   we are compiled in EABI mode */
+
+	.balign	4
+__syscall_common:
+#ifdef __ARM_EABI__
+	ldr	r4, [sp,#16]
+	ldr	r5, [sp,#20]
+	ldr	r7, [lr]
+	swi	0
+#endif
+        cmn     r0, #4096
+        rsbcs	r2, r0, #0
+        ldrcs	r3, 1f
+        mvncs	r0, #0
+        strcs	r2, [r3]
+	ldmfd	sp!,{r4,r5,r7,pc}
+
+	.balign 4
+1:
+	.word	errno
+
+#else
+	/* Thumb version - must still load r4 and r5 and run swi */
+
+	.thumb_func
+	.balign	2
+__syscall_common:
+	mov	r7, lr
+	ldr	r4, [sp,#16]
+	sub	r7, #1		/* Remove the Thumb bit */
+	ldr	r5, [sp,#20]
+	ldrh	r7, [r7]
+	swi	0
+	ldr	r1, 2f
+	cmp	r0, r1
+	bcc	1f
+	ldr	r1, 3f
+	neg	r2, r0
+	mov	r0, #1
+	str	r2, [r1]
+	neg	r0, r0
+1:
+	pop	{r4,r5,r7,pc}
+
+	.balign	4
+2:
+	.word	-4095
+3:
+	.word	errno
+
+#endif
diff --git a/usr/klibc/arch/arm/sysstub.ph b/usr/klibc/arch/arm/sysstub.ph
new file mode 100644
index 0000000..d51ace1
--- /dev/null
+++ b/usr/klibc/arch/arm/sysstub.ph
@@ -0,0 +1,58 @@
+# -*- perl -*-
+#
+# arch/arm/sysstub.ph
+#
+# Script to generate system call stubs
+#
+
+
+sub make_sysstub($$$$$@) {
+    my($outputdir, $fname, $type, $sname, $stype, @args) = @_;
+
+    open(OUT, '>', "${outputdir}/${fname}.S");
+    print  OUT "#include <asm/unistd.h>\n";
+    print  OUT "#include <klibc/asmmacros.h>\n";
+
+    print  OUT "	.text\n";
+    print  OUT "	.type	${fname}, #function\n";
+    print  OUT "	.globl	${fname}\n";
+
+    print  OUT "#ifndef __thumb__\n";
+
+    print  OUT "#ifndef __ARM_EABI__\n";
+
+    # ARM version first
+    print  OUT "	.balign	4\n";
+    print  OUT "${fname}:\n";
+    print  OUT "	stmfd	sp!,{r4,r5,lr}\n";
+    print  OUT "	ldr	r4,[sp,#12]\n";
+    print  OUT "	ldr	r5,[sp,#16]\n";
+    print  OUT "	swi	# __NR_${sname}\n";
+    print  OUT "	b	__syscall_common\n";
+
+    print  OUT "#else /* __ARM_EABI__ */\n";
+
+    # ARM EABI version
+    print  out "	.balign	4\n";
+    print  OUT "${fname}:\n";
+    print  OUT "	stmfd	sp!,{r4,r5,r7,lr}\n";
+    print  OUT "	bl	__syscall_common\n";
+    print  OUT "	.word	__NR_${sname}\n";
+
+    print  OUT "#endif /* __ARM_EABI__ */\n";
+    print  OUT "#else /* __thumb__ */\n";
+
+    # Thumb version
+    print  OUT "	.balign	8\n";
+    print  OUT "	.thumb_func\n";
+    print  OUT "${fname}:\n";
+    print  OUT "	push	{r4,r5,r7,lr}\n";
+    print  OUT "	bl	__syscall_common\n";
+    print  OUT "	.short	__NR_${sname}\n";
+
+    print  OUT "#endif /* __thumb__*/\n";
+
+    print  OUT "	.size	__syscall${i},.-__syscall${i}\n";
+}
+
+1;
diff --git a/usr/klibc/arch/arm/vfork.S b/usr/klibc/arch/arm/vfork.S
new file mode 100644
index 0000000..3b2d9f7
--- /dev/null
+++ b/usr/klibc/arch/arm/vfork.S
@@ -0,0 +1,60 @@
+/*
+ * arch/arm/vfork.S
+ *
+ * vfork - nasty system call which must not use the stack.
+ */
+
+#include <asm/unistd.h>
+
+	.type	vfork,#function
+	.globl	vfork
+#ifndef __thumb__
+
+	.balign	4
+vfork:
+#ifdef	__ARM_EABI__
+	mov	r3, r7
+	mov	r7, # __NR_vfork
+	swi	0
+	mov	r7, r3
+#else
+	swi	# __NR_vfork
+#endif
+        cmn     r0, #4096
+        rsbcs	r2, r0, #0
+        ldrcs	r3, 1f
+        mvncs	r0, #0
+        strcs	r2, [r3]
+	mov	pc, lr
+
+	.balign 4
+1:
+	.word	errno
+
+#else
+
+	.thumb_func
+	.balign	2
+vfork:
+	mov	r3, r7
+	mov	r7, # __NR_vfork
+	swi	0
+	mov	r7, r3
+	ldr	r1, 2f
+	cmp	r0, r1
+	bcc	1f
+	ldr	r1, 3f
+	neg	r2, r0
+	mov	r0, #1
+	str	r2, [r1]
+	neg	r0, r0
+1:
+	mov	pc, lr
+
+	.balign	4
+2:
+	.word	-4095
+3:
+	.word	errno
+
+#endif
