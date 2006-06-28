Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbWF1FSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWF1FSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423158AbWF1FS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:18:29 -0400
Received: from terminus.zytor.com ([192.83.249.54]:54733 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423156AbWF1FSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:18:21 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 06/31] cris support for klibc
Date: Tue, 27 Jun 2006 22:17:06 -0700
Message-Id: <klibc.200606272217.06@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the cris architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 5736f366a2df293571bcc779415f1d9b3a9aa6c1
tree 705889b0b164ac8b6b6638a1802ab429fb570185
parent 48a54d2c17e1e7e786aa842fecb0bd3046ecd9de
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:31 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:31 -0700

 usr/include/arch/cris/klibc/archconfig.h |   15 +++++
 usr/include/arch/cris/klibc/archsetjmp.h |   24 +++++++
 usr/include/arch/cris/klibc/archsignal.h |   14 ++++
 usr/include/arch/cris/klibc/archstat.h   |   39 ++++++++++++
 usr/klibc/arch/cris/MCONFIG              |   26 ++++++++
 usr/klibc/arch/cris/Makefile.inc         |   34 ++++++++++
 usr/klibc/arch/cris/__negdi2.S           |   25 ++++++++
 usr/klibc/arch/cris/crt0.S               |   27 ++++++++
 usr/klibc/arch/cris/divide.c             |   99 ++++++++++++++++++++++++++++++
 usr/klibc/arch/cris/setjmp.S             |   37 +++++++++++
 usr/klibc/arch/cris/syscall.S            |   30 +++++++++
 usr/klibc/arch/cris/sysstub.ph           |   29 +++++++++
 usr/klibc/arch/cris/vfork.S              |   29 +++++++++
 13 files changed, 428 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/cris/klibc/archconfig.h b/usr/include/arch/cris/klibc/archconfig.h
new file mode 100644
index 0000000..0206078
--- /dev/null
+++ b/usr/include/arch/cris/klibc/archconfig.h
@@ -0,0 +1,15 @@
+/*
+ * include/arch/cris/klibc/archconfig.h
+ *
+ * See include/klibc/sysconfig.h for the options that can be set in
+ * this file.
+ *
+ */
+
+#ifndef _KLIBC_ARCHCONFIG_H
+#define _KLIBC_ARCHCONFIG_H
+
+/* cris uses 13 as the page shift factor for sys_mmap2 */
+#define _KLIBC_MMAP2_SHIFT	13
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/cris/klibc/archsetjmp.h b/usr/include/arch/cris/klibc/archsetjmp.h
new file mode 100644
index 0000000..d345ccb
--- /dev/null
+++ b/usr/include/arch/cris/klibc/archsetjmp.h
@@ -0,0 +1,24 @@
+/*
+ * arch/cris/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	unsigned long __r0;
+	unsigned long __r1;
+	unsigned long __r2;
+	unsigned long __r3;
+	unsigned long __r4;
+	unsigned long __r5;
+	unsigned long __r6;
+	unsigned long __r7;
+	unsigned long __r8;
+	unsigned long __sp;
+	unsigned long __srp;
+};
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _KLIBC_ARCHSETJMP_H */
diff --git a/usr/include/arch/cris/klibc/archsignal.h b/usr/include/arch/cris/klibc/archsignal.h
new file mode 100644
index 0000000..7fa7454
--- /dev/null
+++ b/usr/include/arch/cris/klibc/archsignal.h
@@ -0,0 +1,14 @@
+/*
+ * arch/cris/include/klibc/archsignal.h
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
diff --git a/usr/include/arch/cris/klibc/archstat.h b/usr/include/arch/cris/klibc/archstat.h
new file mode 100644
index 0000000..09d3ade
--- /dev/null
+++ b/usr/include/arch/cris/klibc/archstat.h
@@ -0,0 +1,39 @@
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
+	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
+	unsigned long	__pad4;		/* future possible st_blocks high bits */
+
+	struct timespec st_atim;
+	struct timespec st_mtim;
+	struct timespec st_ctim;
+
+	unsigned long long	st_ino;
+};
+
+#endif
diff --git a/usr/klibc/arch/cris/MCONFIG b/usr/klibc/arch/cris/MCONFIG
new file mode 100644
index 0000000..659789b
--- /dev/null
+++ b/usr/klibc/arch/cris/MCONFIG
@@ -0,0 +1,26 @@
+# -*- makefile -*-
+#
+# arch/cris/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCOPTFLAGS = -Os -fomit-frame-pointer
+KLIBCBITSIZE  = 32
+
+# Extra linkflags when building the shared version of the library
+# This address needs to be reachable using normal inter-module
+# calls, and work on the memory models for this architecture
+# 224 MB - normal binaries start at 0
+# (lib?)gcc on cris seems to insist on producing .init and .fini sections
+KLIBCSHAREDFLAGS     = --section-start .init=0x0e000100
+
+# The CRIS compiler needs an -iprefix to find libgcc includes when
+# nostdinc is used. It also needs -mlinux to compile linux applications.
+INCLUDE_PREFIX  = $(shell $(CC) -print-libgcc-file-name | sed -e s/libgcc.a//)
+KLIBCARCHREQFLAGS = -iprefix $(INCLUDE_PREFIX) -mlinux
+
+# Special flags needed for linking
+KLIBCLDFLAGS 	+= -mcrislinux
diff --git a/usr/klibc/arch/cris/Makefile.inc b/usr/klibc/arch/cris/Makefile.inc
new file mode 100644
index 0000000..ac93d2d
--- /dev/null
+++ b/usr/klibc/arch/cris/Makefile.inc
@@ -0,0 +1,34 @@
+# -*- makefile -*-
+#
+# arch/cris/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHOBJS = \
+	arch/$(KLIBCARCH)/__Umod.o \
+	arch/$(KLIBCARCH)/__Udiv.o \
+	arch/$(KLIBCARCH)/__Mod.o \
+	arch/$(KLIBCARCH)/__Div.o \
+	arch/$(KLIBCARCH)/__negdi2.o \
+	arch/$(KLIBCARCH)/setjmp.o \
+	arch/$(KLIBCARCH)/syscall.o \
+	arch/$(KLIBCARCH)/vfork.o \
+	libgcc/__divdi3.o \
+	libgcc/__moddi3.o \
+	libgcc/__udivdi3.o \
+	libgcc/__umoddi3.o \
+	libgcc/__udivmoddi4.o
+
+arch/$(KLIBCARCH)/__Umod.o: arch/$(KLIBCARCH)/divide.c
+	$(CC) $(CFLAGS) -DSIGNED=0 -DREM=1 -DBITS=32 -DNAME=__Umod -c -o $@ $<
+arch/$(KLIBCARCH)/__Udiv.o: arch/$(KLIBCARCH)/divide.c
+	$(CC) $(CFLAGS) -DSIGNED=0 -DREM=0 -DBITS=32 -DNAME=__Udiv -c -o $@ $<
+arch/$(KLIBCARCH)/__Mod.o: arch/$(KLIBCARCH)/divide.c
+	$(CC) $(CFLAGS) -DSIGNED=1 -DREM=1 -DBITS=32 -DNAME=__Mod -c -o $@ $<
+arch/$(KLIBCARCH)/__Div.o: arch/$(KLIBCARCH)/divide.c
+	$(CC) $(CFLAGS) -DSIGNED=1 -DREM=0 -DBITS=32 -DNAME=__Div -c -o $@ $<
+
+archclean:
diff --git a/usr/klibc/arch/cris/__negdi2.S b/usr/klibc/arch/cris/__negdi2.S
new file mode 100644
index 0000000..3cca9ed
--- /dev/null
+++ b/usr/klibc/arch/cris/__negdi2.S
@@ -0,0 +1,25 @@
+/*
+ * arch/cris/__negdi2.c
+ */
+
+/*
+ * In 2's complement arithmetric, -x == (~x + 1), so
+ * -{h,l} = (~{h,l} + {0,1)
+ * -{h,l} = {~h,~l} + {0,1}
+ * -{h,l} = {~h + cy, ~l + 1}
+ * ... where cy = (l == 0)
+ * -{h,l} = {~h + cy, -l}
+ */
+
+	.text
+	.balign 4
+	.type	__negdi2,@function
+	.globl	__negdi2
+__negdi2:
+	neg.d	$r10,$r10
+	seq	$r12
+	not	$r11
+	ret
+	  add.d	$r12,$r11
+
+	.size __negdi2, .-__negdi2
diff --git a/usr/klibc/arch/cris/crt0.S b/usr/klibc/arch/cris/crt0.S
new file mode 100644
index 0000000..22cb9b4
--- /dev/null
+++ b/usr/klibc/arch/cris/crt0.S
@@ -0,0 +1,27 @@
+#
+# arch/cris/crt0.S
+#
+# Does arch-specific initialization and invokes __libc_init
+# with the appropriate arguments.
+#
+# See __static_init.c or __shared_init.c for the expected
+# arguments.
+#
+
+	.text
+	.balign 4
+	.type	_start,@function
+	.globl	_start
+_start:
+	/* Save the address of the ELF argument array */
+	move.d	$sp,$r10	/* Address of ELF arguments */
+
+	/* atexit() function (assume null) */
+	moveq	0,$r11
+
+	/* Set up a dummy stack frame to keep gcc from getting confused */
+	push	$r11
+	push	$r11
+	jump	__libc_init
+
+	.size _start, .-_start
diff --git a/usr/klibc/arch/cris/divide.c b/usr/klibc/arch/cris/divide.c
new file mode 100644
index 0000000..1d4ab23
--- /dev/null
+++ b/usr/klibc/arch/cris/divide.c
@@ -0,0 +1,99 @@
+#include <stdint.h>
+#include <signal.h>
+
+#if BITS == 64
+typedef uint64_t unum;
+typedef int64_t snum;
+#else
+typedef uint32_t unum;
+typedef int32_t snum;
+#endif
+
+#ifdef SIGNED
+typedef snum xnum;
+#else
+typedef unum xnum;
+#endif
+
+#ifdef __cris__
+static inline unum __attribute__ ((const))dstep(unum rs, unum rd)
+{
+	asm("dstep %1,%0": "+r"(rd):"r"(rs));
+	return rd;
+}
+
+static inline unum __attribute__ ((const))lz(unum rs)
+{
+	unum rd;
+	asm("lz %1,%0": "=r"(rd):"r"(rs));
+	return rd;
+}
+
+#else
+/* For testing */
+static inline unum __attribute__ ((const))dstep(unum rs, unum rd)
+{
+	rd <<= 1;
+	if (rd >= rs)
+		rd -= rs;
+
+	return rd;
+}
+
+static inline unum __attribute__ ((const))lz(unum rs)
+{
+	unum rd = 0;
+	while (rs >= 0x7fffffff) {
+		rd++;
+		rs <<= 1;
+	}
+	return rd;
+}
+
+#endif
+
+xnum NAME(unum num, unum den)
+{
+	unum quot = 0, qbit = 1;
+	int minus = 0;
+	xnum v;
+
+	if (den == 0) {
+		raise(SIGFPE);
+		return 0;	/* If signal ignored... */
+	}
+
+	if (den == 1)
+		return (xnum) (REM ? 0 : num);
+
+#if SIGNED
+	if ((snum) (num ^ den) < 0)
+		minus = 1;
+	if ((snum) num < 0)
+		num = -num;
+	if ((snum) den < 0)
+		den = -den;
+#endif
+
+	den--;
+
+	/* Left-justify denominator and count shift */
+	while ((snum) den >= 0) {
+		den <<= 1;
+		qbit <<= 1;
+	}
+
+	while (qbit) {
+		if (den <= num) {
+			num -= den;
+			quot += qbit;
+		}
+		den >>= 1;
+		qbit >>= 1;
+	}
+
+	v = (xnum) (REM ? num : quot);
+	if (minus)
+		v = -v;
+	return v;
+}
diff --git a/usr/klibc/arch/cris/setjmp.S b/usr/klibc/arch/cris/setjmp.S
new file mode 100644
index 0000000..2041b82
--- /dev/null
+++ b/usr/klibc/arch/cris/setjmp.S
@@ -0,0 +1,37 @@
+#
+# arch/cris/setjmp.S
+#
+# setjmp/longjmp for the cris architecture
+#
+
+#
+# The jmp_buf is assumed to contain the following, in order:
+#	$r8..$r0	(in that order)
+#	$sp	($r14)
+#	return address
+#
+
+	.text
+	.balign 4
+	.globl	setjmp
+	.type	setjmp, @function
+setjmp:
+	movem	$r8,[$r10+]		/* Save $r8..$r0 at $r10... */
+	move.d	$sp,[$r10+]
+	move	$srp,[$r10]
+	ret
+	  moveq	0,$r10
+
+	.size setjmp,.-setjmp
+
+	.text
+	.balign 4
+	.globl	longjmp
+	.type	longjmp, @function
+longjmp:
+	movem	[$r10+],$r8		/* Load $r8..$r0 from $r10... */
+	move.d	[$r10+],$sp
+	jump	[$r10]
+	move.d $r11,$r10
+
+	.size longjmp,.-longjmp
diff --git a/usr/klibc/arch/cris/syscall.S b/usr/klibc/arch/cris/syscall.S
new file mode 100644
index 0000000..d71495a
--- /dev/null
+++ b/usr/klibc/arch/cris/syscall.S
@@ -0,0 +1,30 @@
+/*
+ * arch/cris/syscall.S
+ *
+ * On cris, r9 contains the syscall number (set by generated stub);
+ * r10..r13 contain arguments 0-3 per the standard calling convention,
+ * and arguments 4-5 are passed in $mof and $srp; however, we have
+ * to save $srp around the system call.
+ */
+
+	.section ".text","ax"
+	.balign	4
+	.globl	__syscall_common
+	.type	__syscall_common,@function
+__syscall_common:
+	push	$srp
+	move	[$sp+4],$mof
+	move	[$sp+8],$srp
+	break	13
+
+	cmps.w	-4096,$r10
+	blo	1f
+	neg.d	$r10,$r11
+	move.d	$r11,[errno]
+	moveq	-1,$r10
+1:
+	pop	$srp
+	ret
+	nop
+
+	.size	__syscall_common,.-__syscall_common
diff --git a/usr/klibc/arch/cris/sysstub.ph b/usr/klibc/arch/cris/sysstub.ph
new file mode 100644
index 0000000..182ad73
--- /dev/null
+++ b/usr/klibc/arch/cris/sysstub.ph
@@ -0,0 +1,29 @@
+# -*- perl -*-
+#
+# arch/cris/sysstub.ph
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
+    print OUT "\t.type\t${fname},\@function\n";
+    print OUT "\t.globl\t${fname}\n";
+    print OUT "\t.balign\t4\n";
+    print OUT "${fname}:\n";
+    print OUT "#if __NR_${sname} <= 31\n";
+    print OUT "\t  moveq\t__NR_${sname}, \$r9\n";
+    print OUT "#else\n";
+    print OUT "\t  move.d\t__NR_${sname}, \$r9\n";
+    print OUT "#endif\n";
+    print OUT "\tjump\t__syscall_common\n";
+    print OUT "\t.size ${fname},.-${fname}\n";
+    close(OUT);
+}
+
+1;
diff --git a/usr/klibc/arch/cris/vfork.S b/usr/klibc/arch/cris/vfork.S
new file mode 100644
index 0000000..ccdb36c
--- /dev/null
+++ b/usr/klibc/arch/cris/vfork.S
@@ -0,0 +1,29 @@
+/*
+ * arch/cris/vfork.S
+ *
+ * On cris, r9 contains the syscall number (set by generated stub);
+ * r10..r13 contain arguments 0-3 per the standard calling convention.
+ * The return address is in $srp; so we just need to avoid the stack
+ * usage of the normal syscall stubs.
+ */
+
+#include <asm/unistd.h>
+
+	.section ".text","ax"
+	.balign	4
+	.globl	vfork
+	.type	vfork,@function
+vfork:
+	move.d	__NR_vfork, $r9
+	break	13
+
+	cmps.w	-4096,$r10
+	blo	1f
+	neg.d	$r10,$r11
+	move.d	$r11,[errno]
+	moveq	-1,$r10
+1:
+	ret
+	nop
+
+	.size	vfork,.-vfork
