Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423186AbWF1FVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423186AbWF1FVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423157AbWF1FT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:19:28 -0400
Received: from terminus.zytor.com ([192.83.249.54]:1998 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423161AbWF1FSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:18:49 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 13/31] parisc support for klibc
Date: Tue, 27 Jun 2006 22:17:13 -0700
Message-Id: <klibc.200606272217.13@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the parisc architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 72d9123910ed26d4d0f97641e0cfde3edcebf767
tree 9e20029aefe03571e8bfbfb414ae5d5c5df2fa9d
parent 364ccece6cff9e5b99b6b5b94d2f781ebf6bdfb8
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:48 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:48 -0700

 usr/include/arch/parisc/klibc/archconfig.h |   14 ++++
 usr/include/arch/parisc/klibc/archsetjmp.h |   14 ++++
 usr/include/arch/parisc/klibc/archsignal.h |   25 ++++++++
 usr/include/arch/parisc/klibc/archstat.h   |   29 +++++++++
 usr/klibc/arch/parisc/MCONFIG              |   12 ++++
 usr/klibc/arch/parisc/Makefile.inc         |   16 +++++
 usr/klibc/arch/parisc/crt0.S               |   37 ++++++++++++
 usr/klibc/arch/parisc/setjmp.S             |   88 ++++++++++++++++++++++++++++
 usr/klibc/arch/parisc/syscall.S            |   36 +++++++++++
 usr/klibc/arch/parisc/sysstub.ph           |   28 +++++++++
 10 files changed, 299 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/parisc/klibc/archconfig.h b/usr/include/arch/parisc/klibc/archconfig.h
new file mode 100644
index 0000000..f8ba9e2
--- /dev/null
+++ b/usr/include/arch/parisc/klibc/archconfig.h
@@ -0,0 +1,14 @@
+/*
+ * include/arch/parisc/klibc/archconfig.h
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
diff --git a/usr/include/arch/parisc/klibc/archsetjmp.h b/usr/include/arch/parisc/klibc/archsetjmp.h
new file mode 100644
index 0000000..05e943e
--- /dev/null
+++ b/usr/include/arch/parisc/klibc/archsetjmp.h
@@ -0,0 +1,14 @@
+/*
+ * arch/parisc/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	double regs[21];
+};
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _SETJMP_H */
diff --git a/usr/include/arch/parisc/klibc/archsignal.h b/usr/include/arch/parisc/klibc/archsignal.h
new file mode 100644
index 0000000..256aeea
--- /dev/null
+++ b/usr/include/arch/parisc/klibc/archsignal.h
@@ -0,0 +1,25 @@
+/*
+ * arch/parisc/include/klibc/archsignal.h
+ *
+ * Architecture-specific signal definitions
+ *
+ */
+
+#ifndef _KLIBC_ARCHSIGNAL_H
+#define _KLIBC_ARCHSIGNAL_H
+
+#include <asm/signal.h>
+#define _NSIG    64
+#define _NSIG_SZ (_NSIG / LONG_BIT)
+
+typedef struct {
+	unsigned long sig[_NSIG_SZ];
+} sigset_t;
+
+struct sigaction {
+	__sighandler_t	sa_handler;
+	unsigned long	sa_flags;
+	sigset_t	sa_mask;
+};
+
+#endif
diff --git a/usr/include/arch/parisc/klibc/archstat.h b/usr/include/arch/parisc/klibc/archstat.h
new file mode 100644
index 0000000..0b8ef8d
--- /dev/null
+++ b/usr/include/arch/parisc/klibc/archstat.h
@@ -0,0 +1,29 @@
+#ifndef _KLIBC_ARCHSTAT_H
+#define _KLIBC_ARCHSTAT_H
+
+#include <klibc/stathelp.h>
+
+#define _STATBUF_ST_NSEC
+
+struct stat {
+	__stdev64		(st_dev);
+	unsigned int		__pad1;
+
+	unsigned int		__st_ino;	/* Not actually filled in */
+	unsigned int		st_mode;
+	unsigned int		st_nlink;
+	unsigned int		st_uid;
+	unsigned int		st_gid;
+	__stdev64		(st_rdev);
+	unsigned int		__pad2;
+	signed long long	st_size;
+	signed int		st_blksize;
+
+	signed long long	st_blocks;
+	struct timespec		st_atim;
+	struct timespec		st_mtim;
+	struct timespec		st_ctim;
+	unsigned long long	st_ino;
+};
+
+#endif
diff --git a/usr/klibc/arch/parisc/MCONFIG b/usr/klibc/arch/parisc/MCONFIG
new file mode 100644
index 0000000..83c2e9e
--- /dev/null
+++ b/usr/klibc/arch/parisc/MCONFIG
@@ -0,0 +1,12 @@
+# -*- makefile -*-
+#
+# arch/parisc/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCOPTFLAGS = -Os -fomit-frame-pointer
+KLIBCBITSIZE  = 32
+KLIBCSHAREDFLAGS	= -Ttext 0x40001000
diff --git a/usr/klibc/arch/parisc/Makefile.inc b/usr/klibc/arch/parisc/Makefile.inc
new file mode 100644
index 0000000..f479a6c
--- /dev/null
+++ b/usr/klibc/arch/parisc/Makefile.inc
@@ -0,0 +1,16 @@
+# -*- makefile -*-
+#
+# arch/parisc/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHOBJS = \
+	arch/$(KLIBCARCH)/setjmp.o \
+	arch/$(KLIBCARCH)/syscall.o
+
+KLIBCARCHOOBJS = $(patsubst %o,%.lo,%(KLIBCARCHOBJS))
+
+archclean:
diff --git a/usr/klibc/arch/parisc/crt0.S b/usr/klibc/arch/parisc/crt0.S
new file mode 100644
index 0000000..0922446
--- /dev/null
+++ b/usr/klibc/arch/parisc/crt0.S
@@ -0,0 +1,37 @@
+	.align 4
+
+	.import $global$, data
+	.import __libc_init, code
+
+	.global _start
+	.export _start, ENTRY
+	.type _start,@function
+
+	.proc
+	.callinfo
+
+_start:
+/* extend the stack by 64-bytes */
+	ldo	64(%sp), %sp
+
+/* %r25 = argc
+ * %r24 = argv
+ * envp = argv + (argc + 1)
+ * elfdata = (argv - 4)
+ */
+	ldo	-4(%r24), %r26
+
+/* load global data */
+	ldil	L%$global$, %dp
+	ldo	R%$global$(%dp), %dp
+
+/* parisc abi puts the atexit pointer in %r23, see ELF_PLAT_INIT() */
+	copy	%r23, %r25
+
+/* branch to __libc_init */
+	bl	__libc_init,%r2
+	nop
+/* break miserably if we ever return */
+	iitlbp	%r0,(%sr0,%r0) /* illegal instruction */
+	nop
+	.procend
diff --git a/usr/klibc/arch/parisc/setjmp.S b/usr/klibc/arch/parisc/setjmp.S
new file mode 100644
index 0000000..c8d766c
--- /dev/null
+++ b/usr/klibc/arch/parisc/setjmp.S
@@ -0,0 +1,88 @@
+/*
+ * parisc specific setjmp/longjmp routines
+ *
+ */
+
+        .text
+        .align 4
+        .global setjmp
+        .export setjmp, code
+        .proc
+        .callinfo
+setjmp:
+        stw     %r3,0(%r26)
+        stw     %r4,8(%r26)
+        stw     %r5,12(%r26)
+        stw     %r6,16(%r26)
+        stw     %r7,20(%r26)
+        stw     %r8,24(%r26)
+        stw     %r9,28(%r26)
+        stw     %r10,32(%r26)
+        stw     %r11,36(%r26)
+        stw     %r12,40(%r26)
+        stw     %r13,44(%r26)
+        stw     %r14,48(%r26)
+        stw     %r15,52(%r26)
+        stw     %r16,56(%r26)
+        stw     %r17,60(%r26)
+        stw     %r18,64(%r26)
+        stw     %r19,68(%r26)
+        stw     %r27,72(%r26)
+        stw     %r30,76(%r26)
+        stw     %rp,80(%r26)
+        ldo     88(%r26),%r19
+        fstd,ma %fr12,8(%r19)
+        fstd,ma %fr13,8(%r19)
+        fstd,ma %fr14,8(%r19)
+        fstd,ma %fr15,8(%r19)
+        fstd,ma %fr16,8(%r19)
+        fstd,ma %fr17,8(%r19)
+        fstd,ma %fr18,8(%r19)
+        fstd,ma %fr19,8(%r19)
+        fstd,ma %fr20,8(%r19)
+        fstd     %fr21,0(%r19)
+        bv       %r0(%rp)
+        copy     %r0,%r28
+	.procend
+
+	.text
+	.align 4
+	.global longjmp
+	.export longjmp, code
+	.proc
+	.callinfo
+longjmp:
+        ldw     0(%r26),%r3
+        ldw     8(%r26),%r4
+        ldw     12(%r26),%r5
+        ldw     16(%r26),%r6
+        ldw     20(%r26),%r7
+        ldw     24(%r26),%r8
+        ldw     28(%r26),%r9
+        ldw     32(%r26),%r10
+        ldw     36(%r26),%r11
+        ldw     40(%r26),%r12
+        ldw     44(%r26),%r13
+        ldw     48(%r26),%r14
+        ldw     52(%r26),%r15
+        ldw     56(%r26),%r16
+        ldw     60(%r26),%r17
+        ldw     64(%r26),%r18
+        ldw     68(%r26),%r19
+        ldw     72(%r26),%r27
+        ldw     76(%r26),%r30
+        ldw     80(%r26),%rp
+        ldo     88(%r26),%r20
+        fldd,ma 8(%r20),%fr12
+        fldd,ma 8(%r20),%fr13
+        fldd,ma 8(%r20),%fr14
+        fldd,ma 8(%r20),%fr15
+        fldd,ma 8(%r20),%fr16
+        fldd,ma 8(%r20),%fr17
+        fldd,ma 8(%r20),%fr18
+        fldd,ma 8(%r20),%fr19
+        fldd,ma 8(%r20),%fr20
+        fldd    0(%r20),%fr21
+        bv      %r0(%rp)
+        copy    %r25,%r28
+        .procend
diff --git a/usr/klibc/arch/parisc/syscall.S b/usr/klibc/arch/parisc/syscall.S
new file mode 100644
index 0000000..0ff2a65
--- /dev/null
+++ b/usr/klibc/arch/parisc/syscall.S
@@ -0,0 +1,36 @@
+/*
+ * arch/parisc/syscall.S
+ *
+ * %r20 contains the system call number, %r2 contains whence we came
+ *
+ */
+
+	.text
+	.align 64				; cache-width aligned
+	.globl	__syscall_common
+	.type	__syscall_common,@function
+__syscall_common:
+	ldo 		0x40(%sp),%sp
+	stw 		%rp,-0x54(%sp)		; save return pointer
+
+	ldw 		-0x74(%sp),%r22		; %arg4
+	ldw 		-0x78(%sp),%r21		; %arg5
+
+	ble		0x100(%sr2, %r0)	; jump to gateway page
+	nop					; can we move a load here?
+
+	ldi		-0x1000,%r19		; %r19 = -4096
+	sub		%r0,%ret0,%r22		; %r22 = -%ret0
+	cmpb,>>=,n	%r19,%ret0,1f		; if %ret0 >= -4096UL
+	ldi		-1,%ret0		; nullified on taken forward
+
+	/* store %r22 to errno... */
+	ldil		L%errno,%r1
+	ldo		R%errno(%r1),%r1
+	stw		%r22,0(%r1)
+1:
+	ldw 		-0x54(%sp),%rp		; restore return pointer
+	bv		%r0(%rp)		; jump back
+	ldo 		-0x40(%sp),%sp
+
+	.size __syscall_common,.-__syscall_common
diff --git a/usr/klibc/arch/parisc/sysstub.ph b/usr/klibc/arch/parisc/sysstub.ph
new file mode 100644
index 0000000..e2196ac
--- /dev/null
+++ b/usr/klibc/arch/parisc/sysstub.ph
@@ -0,0 +1,28 @@
+# -*- perl -*-
+#
+# arch/parisc/sysstub.ph
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
+    print OUT "\t.align 4\n";
+    print OUT "\t.import __syscall_common, code\n";
+    print OUT "\t.global ${fname}\n";
+    print OUT "\t.export ${fname}, code\n";
+    print OUT "\t.proc\n";
+    print OUT "\.callinfo\n";
+    print OUT "${fname}:\n";
+    print OUT "\tb\t__syscall_common\n";
+    print OUT "\t  ldo\t__NR_${sname}(%r0),%r20\n";
+    print OUT "\t.procend\n";
+    close(OUT);
+}
+
+1;
