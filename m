Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423182AbWF1FTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423182AbWF1FTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423165AbWF1FTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:19:42 -0400
Received: from terminus.zytor.com ([192.83.249.54]:3022 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423164AbWF1FS6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:18:58 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 17/31] sh support for klibc
Date: Tue, 27 Jun 2006 22:17:17 -0700
Message-Id: <klibc.200606272217.17@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the sh architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit f3d2864f8dd665446cb0a96b9811e77138ba8f6b
tree e991a52f0572bbeaf97ee2f909f5b294d24e36e3
parent 271a450164027af5f0924e2e1d75ddec961a5c6d
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:56 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:56 -0700

 usr/include/arch/sh/klibc/archconfig.h |   14 +++++++
 usr/include/arch/sh/klibc/archsetjmp.h |   22 +++++++++++
 usr/include/arch/sh/klibc/archsignal.h |   14 +++++++
 usr/include/arch/sh/klibc/archstat.h   |   38 +++++++++++++++++++
 usr/klibc/arch/sh/MCONFIG              |   18 +++++++++
 usr/klibc/arch/sh/Makefile.inc         |   15 ++++++++
 usr/klibc/arch/sh/crt0.S               |   27 ++++++++++++++
 usr/klibc/arch/sh/setjmp.S             |   64 ++++++++++++++++++++++++++++++++
 usr/klibc/arch/sh/syscall.S            |   35 ++++++++++++++++++
 usr/klibc/arch/sh/sysstub.ph           |   34 +++++++++++++++++
 10 files changed, 281 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/sh/klibc/archconfig.h b/usr/include/arch/sh/klibc/archconfig.h
new file mode 100644
index 0000000..9c9e3d8
--- /dev/null
+++ b/usr/include/arch/sh/klibc/archconfig.h
@@ -0,0 +1,14 @@
+/*
+ * include/arch/sh/klibc/archconfig.h
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
diff --git a/usr/include/arch/sh/klibc/archsetjmp.h b/usr/include/arch/sh/klibc/archsetjmp.h
new file mode 100644
index 0000000..bb97167
--- /dev/null
+++ b/usr/include/arch/sh/klibc/archsetjmp.h
@@ -0,0 +1,22 @@
+/*
+ * arch/sh/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	unsigned long __r8;
+	unsigned long __r9;
+	unsigned long __r10;
+	unsigned long __r11;
+	unsigned long __r12;
+	unsigned long __r13;
+	unsigned long __r14;
+	unsigned long __r15;
+	unsigned long __pr;
+};
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _KLIBC_ARCHSETJMP_H */
diff --git a/usr/include/arch/sh/klibc/archsignal.h b/usr/include/arch/sh/klibc/archsignal.h
new file mode 100644
index 0000000..8e48e51
--- /dev/null
+++ b/usr/include/arch/sh/klibc/archsignal.h
@@ -0,0 +1,14 @@
+/*
+ * arch/sh/include/klibc/archsignal.h
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
diff --git a/usr/include/arch/sh/klibc/archstat.h b/usr/include/arch/sh/klibc/archstat.h
new file mode 100644
index 0000000..f4c65ea
--- /dev/null
+++ b/usr/include/arch/sh/klibc/archstat.h
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
+struct stat64 {
+	__stdev64	(st_dev);
+	unsigned char	__pad0[4];
+
+	unsigned long	st_ino;
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
+	unsigned long long st_blocks;
+
+	struct timespec	st_atim;
+	struct timespec st_mtim;
+	struct timespec st_ctim;
+
+	unsigned long	__unused1;
+	unsigned long	__unused2;
+};
+
+#endif
diff --git a/usr/klibc/arch/sh/MCONFIG b/usr/klibc/arch/sh/MCONFIG
new file mode 100644
index 0000000..f0106e1
--- /dev/null
+++ b/usr/klibc/arch/sh/MCONFIG
@@ -0,0 +1,18 @@
+# -*- makefile -*-
+#
+# arch/sh/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+ARCHREGFLAGS = -m4 -mno-implicit-fp
+KLIBCOPTFLAGS     = -Os -fomit-frame-pointer
+KLIBCBITSIZE      = 32
+
+# Extra linkflags when building the shared version of the library
+# This address needs to be reachable using normal inter-module
+# calls, and work on the memory models for this architecture
+# 2 MB -- the normal starting point for text is 4 MB.
+KLIBCSHAREDFLAGS	= -Ttext 0x00200200
diff --git a/usr/klibc/arch/sh/Makefile.inc b/usr/klibc/arch/sh/Makefile.inc
new file mode 100644
index 0000000..ccabfa4
--- /dev/null
+++ b/usr/klibc/arch/sh/Makefile.inc
@@ -0,0 +1,15 @@
+# -*- makefile -*-
+#
+# arch/sh/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+ARCHOBJS = arch/sh/setjmp.o \
+	   arch/sh/syscall.o
+
+ARCHSOOBJS = $(patsubst %.o,%.lo,$(ARCHOBJS))
+
+archclean:
diff --git a/usr/klibc/arch/sh/crt0.S b/usr/klibc/arch/sh/crt0.S
new file mode 100644
index 0000000..7f0a649
--- /dev/null
+++ b/usr/klibc/arch/sh/crt0.S
@@ -0,0 +1,27 @@
+#
+# arch/sh/crt0.S
+#
+# Does arch-specific initialization and invokes __libc_init
+# with the appropriate arguments.
+#
+# See __static_init.c or __shared_init.c for the expected
+# arguments.
+#
+
+	.text
+	.align 2
+	.type _start,#function
+	.globl _start
+
+_start:
+	mov	r15, r4
+	mov	#0, r5
+	mov.l	1f, r0
+
+	jsr	@r0
+	 nop
+
+	.align 2
+1:	.long	__libc_init
+
+	.size _start,.-_start
diff --git a/usr/klibc/arch/sh/setjmp.S b/usr/klibc/arch/sh/setjmp.S
new file mode 100644
index 0000000..2552358
--- /dev/null
+++ b/usr/klibc/arch/sh/setjmp.S
@@ -0,0 +1,64 @@
+#
+# arch/sh/setjmp.S
+#
+# setjmp/longjmp for the SuperH architecture
+#
+
+#
+# The jmp_buf is assumed to contain the following, in order:
+#
+#		r8
+#		r9
+#		r10
+#		r11
+#		r12
+#		r13
+#		r14
+#		r15
+#		pr
+#
+
+	.text
+	.align 2
+
+	.globl setjmp
+	.type setjmp, #function
+
+setjmp:
+	add	#(9*4), r4
+	sts.l	pr, @-r4
+	mov.l	r15, @-r4
+	mov.l	r14, @-r4
+	mov.l	r13, @-r4
+	mov.l	r12, @-r4
+	mov.l	r11, @-r4
+	mov.l	r10, @-r4
+	mov.l	r9, @-r4
+	mov.l	r8, @-r4
+	rts
+	 mov	#0, r0
+
+	.size setjmp,.-setjmp
+
+	.align 2
+	.globl longjmp
+	.type setjmp, #function
+
+longjmp:
+	mov.l	@r4+, r8
+	mov.l	@r4+, r9
+	mov.l	@r4+, r10
+	mov.l	@r4+, r11
+	mov.l	@r4+, r12
+	mov.l	@r4+, r13
+	mov.l	@r4+, r14
+	mov.l	@r4+, r15
+	lds.l	@r4+, pr
+	mov	r5, r0
+	tst	r0, r0
+	bf	1f
+	mov	#1, r0	! in case val==0
+1:	rts
+	 nop
+
+	.size longjmp,.-longjmp
diff --git a/usr/klibc/arch/sh/syscall.S b/usr/klibc/arch/sh/syscall.S
new file mode 100644
index 0000000..41a0486
--- /dev/null
+++ b/usr/klibc/arch/sh/syscall.S
@@ -0,0 +1,35 @@
+/*
+ * arch/sh/syscall.S
+ *
+ * On sh, r3 contains the syscall number (set by generated stub);
+ * r4..r7 contain arguments 0-3 per the standard calling convention,
+ * and arguments 4-5 are passed in r0 and r1.
+ *
+ * The return value is in r3 rather than standard r0.
+ */
+
+	.section ".text.syscall","ax"
+	.align	2
+	.globl	___syscall_common
+	.type	___syscall_common,@function
+___syscall_common:
+	mov.l	@(sp),r0
+	mov.l	@(4,sp),r1
+	trapa	#0x15
+	mov.l	1f,r0
+	cmp/hs	r0,r3
+	bt/s	3f
+	  neg	r3,r4
+	mov.l	2f,r5
+	mov.l	r4,@r5
+	rts
+	  mov	#-1,r0
+3:
+	rts
+	  mov	r3,r0
+
+	.align 2
+1:	.long	-4096		/* Errno limit */
+2:	.long	errno
+
+	.size	___syscall_common,.-___syscall_common
diff --git a/usr/klibc/arch/sh/sysstub.ph b/usr/klibc/arch/sh/sysstub.ph
new file mode 100644
index 0000000..ce04b73
--- /dev/null
+++ b/usr/klibc/arch/sh/sysstub.ph
@@ -0,0 +1,34 @@
+# -*- perl -*-
+#
+# arch/sh/sysstub.ph
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
+    print OUT "\t.section\t\".text.syscall\",\"ax\"\n";
+    print OUT "\t.type\t${fname},\#function\n";
+    print OUT "\t.globl\t${fname}\n";
+    print OUT "\t.align\t2\n";
+    print OUT "${fname}:\n";
+    print OUT "\tbra\t__syscall_common\n";
+    print OUT "#if __NR_${sname} >= 128\n";
+    print OUT "\t  mov.l\t1f, r3\n";
+    print OUT "#else\n";
+    print OUT "\t  mov\t# __NR_${sname}, r3\n";
+    print OUT "#endif\n";
+    print OUT "\t.size ${fname},.-${fname}\n";
+    print OUT "\n";
+    print OUT "#if __NR_${sname} >= 128\n";
+    print OUT "\t.align\t2\n";
+    print OUT "1:\t.long\t__NR_${sname}\n";
+    print OUT "#endif\n";
+    close(OUT);
+}
+
+1;
