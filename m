Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWFZA76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWFZA76 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 20:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWFZA7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:59:48 -0400
Received: from terminus.zytor.com ([192.83.249.54]:24975 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965103AbWFZA7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:59:30 -0400
Date: Sun, 25 Jun 2006 17:58:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 36/43] sparc64 support for klibc
Message-Id: <klibc.200606251757.36@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the sparc64 architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit f30fa3db62972125afa68d3b53d03cdb843d3bbd
tree f2d942e281dce8bb98d4fa84b7e431c7beaddfc4
parent 1b5c93603ed3460ed1fba9e5d453a6fa54d0ccce
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:50 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:50 -0700

 usr/include/arch/sparc64/klibc/archconfig.h |   15 +++++++
 usr/include/arch/sparc64/klibc/archsetjmp.h |   16 ++++++++
 usr/include/arch/sparc64/klibc/archsignal.h |   17 ++++++++
 usr/include/arch/sparc64/klibc/archstat.h   |   30 +++++++++++++++
 usr/include/arch/sparc64/klibc/archsys.h    |   10 +++++
 usr/klibc/arch/sparc64/MCONFIG              |   21 ++++++++++
 usr/klibc/arch/sparc64/Makefile.inc         |   16 ++++++++
 usr/klibc/arch/sparc64/crt0.S               |    2 +
 usr/klibc/arch/sparc64/pipe.S               |   30 +++++++++++++++
 usr/klibc/arch/sparc64/setjmp.S             |   55 +++++++++++++++++++++++++++
 usr/klibc/arch/sparc64/syscall.S            |   18 +++++++++
 usr/klibc/arch/sparc64/sysfork.S            |   26 +++++++++++++
 usr/klibc/arch/sparc64/sysstub.ph           |   25 ++++++++++++
 13 files changed, 281 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/sparc64/klibc/archconfig.h b/usr/include/arch/sparc64/klibc/archconfig.h
new file mode 100644
index 0000000..bb0c003
--- /dev/null
+++ b/usr/include/arch/sparc64/klibc/archconfig.h
@@ -0,0 +1,15 @@
+/*
+ * include/arch/sparc64/klibc/archconfig.h
+ *
+ * See include/klibc/sysconfig.h for the options that can be set in
+ * this file.
+ *
+ */
+
+#ifndef _KLIBC_ARCHCONFIG_H
+#define _KLIBC_ARCHCONFIG_H
+
+#define _KLIBC_USE_RT_SIG 1	/* Use rt_* signals */
+#define _KLIBC_NEEDS_SA_RESTORER 1 /* Need a restorer function */
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/sparc64/klibc/archsetjmp.h b/usr/include/arch/sparc64/klibc/archsetjmp.h
new file mode 100644
index 0000000..9e825bd
--- /dev/null
+++ b/usr/include/arch/sparc64/klibc/archsetjmp.h
@@ -0,0 +1,16 @@
+/*
+ * arch/sparc64/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	unsigned long __sp;
+	unsigned long __fp;
+	unsigned long __pc;
+};
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _SETJMP_H */
diff --git a/usr/include/arch/sparc64/klibc/archsignal.h b/usr/include/arch/sparc64/klibc/archsignal.h
new file mode 100644
index 0000000..bb0a5ce
--- /dev/null
+++ b/usr/include/arch/sparc64/klibc/archsignal.h
@@ -0,0 +1,17 @@
+/*
+ * arch/sparc64/include/klibc/archsignal.h
+ *
+ * Architecture-specific signal definitions
+ *
+ */
+
+#ifndef _KLIBC_ARCHSIGNAL_H
+#define _KLIBC_ARCHSIGNAL_H
+
+#define __WANT_POSIX1B_SIGNALS__
+#include <asm/signal.h>
+
+/* Not actually used by the kernel... */
+#define SA_RESTORER	0x80000000
+
+#endif
diff --git a/usr/include/arch/sparc64/klibc/archstat.h b/usr/include/arch/sparc64/klibc/archstat.h
new file mode 100644
index 0000000..56fb2a4
--- /dev/null
+++ b/usr/include/arch/sparc64/klibc/archstat.h
@@ -0,0 +1,30 @@
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
+
+	__stdev64 (st_rdev);
+	long		st_size;
+	long		st_blksize;
+	long		st_blocks;
+
+	struct timespec st_atim;
+	struct timespec st_mtim;
+	struct timespec st_ctim;
+
+	unsigned long __unused[3];
+};
+
+#endif
diff --git a/usr/include/arch/sparc64/klibc/archsys.h b/usr/include/arch/sparc64/klibc/archsys.h
new file mode 100644
index 0000000..43151b6
--- /dev/null
+++ b/usr/include/arch/sparc64/klibc/archsys.h
@@ -0,0 +1,10 @@
+/*
+ * arch/sparc64/include/klibc/archsys.h
+ *
+ * Architecture-specific syscall definitions
+ */
+
+#ifndef _KLIBC_ARCHSYS_H
+#define _KLIBC_ARCHSYS_H
+
+#endif				/* _KLIBC_ARCHSYS_H */
diff --git a/usr/klibc/arch/sparc64/MCONFIG b/usr/klibc/arch/sparc64/MCONFIG
new file mode 100644
index 0000000..443250a
--- /dev/null
+++ b/usr/klibc/arch/sparc64/MCONFIG
@@ -0,0 +1,21 @@
+# -*- makefile -*-
+#
+# arch/sparc64/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHREQFLAGS = -m64 -mptr64 -D__sparc64__
+KLIBCOPTFLAGS     = -Os
+KLIBCBITSIZE      = 64
+
+KLIBCLDFLAGS      = -m elf64_sparc
+
+# Extra linkflags when building the shared version of the library
+# This address needs to be reachable using normal inter-module
+# calls, and work on the memory models for this architecture
+# Normal binaries start at 1 MB; the linker wants 1 MB alignment,
+# and call instructions have a 30-bit signed offset, << 2.
+KLIBCSHAREDFLAGS	= -Ttext 0x80000200
diff --git a/usr/klibc/arch/sparc64/Makefile.inc b/usr/klibc/arch/sparc64/Makefile.inc
new file mode 100644
index 0000000..1641f51
--- /dev/null
+++ b/usr/klibc/arch/sparc64/Makefile.inc
@@ -0,0 +1,16 @@
+# -*- makefile -*-
+#
+# arch/sparc64/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHOBJS = \
+	arch/$(KLIBCARCH)/pipe.o \
+	arch/$(KLIBCARCH)/setjmp.o \
+	arch/$(KLIBCARCH)/syscall.o \
+	arch/$(KLIBCARCH)/sysfork.o
+
+archclean:
diff --git a/usr/klibc/arch/sparc64/crt0.S b/usr/klibc/arch/sparc64/crt0.S
new file mode 100644
index 0000000..5faee7c
--- /dev/null
+++ b/usr/klibc/arch/sparc64/crt0.S
@@ -0,0 +1,2 @@
+#define TARGET_PTR_SIZE 64
+#include "../sparc/crt0i.S"
diff --git a/usr/klibc/arch/sparc64/pipe.S b/usr/klibc/arch/sparc64/pipe.S
new file mode 100644
index 0000000..c63b20f
--- /dev/null
+++ b/usr/klibc/arch/sparc64/pipe.S
@@ -0,0 +1,30 @@
+/*
+ * arch/sparc64/pipe.S
+ *
+ * The pipe system call are special on sparc[64]:
+ * they return the two file descriptors in %o0 and %o1.
+ */
+
+#include <asm/unistd.h>
+
+	.globl	pipe
+	.type	pipe,#function
+       	.align	4
+pipe:
+	mov	__NR_pipe, %g1
+	or	%o0, 0, %g4
+	t	0x6d
+	bcc	%xcc, 1f
+	  nop
+	sethi	%hi(errno), %g4
+	or	%g4, %lo(errno), %g4
+	st	%o0,[%g4]
+	retl
+	  mov	-1, %o0
+1:
+	st	%o0,[%g4]
+	st	%o1,[%g4+4]
+	retl
+	  mov	0, %o0
+
+	.size pipe,.-pipe
diff --git a/usr/klibc/arch/sparc64/setjmp.S b/usr/klibc/arch/sparc64/setjmp.S
new file mode 100644
index 0000000..75a6a68
--- /dev/null
+++ b/usr/klibc/arch/sparc64/setjmp.S
@@ -0,0 +1,55 @@
+!
+! setjmp.S
+!
+! Basic setjmp/longjmp
+!
+! This code was based on the equivalent code in NetBSD
+!
+
+!
+! The jmp_buf contains the following entries:
+!   sp
+!   fp
+!   pc
+!
+	.text
+	.align	4
+	.global	setjmp
+	.type	setjmp, @function
+setjmp:
+	stx	%sp,[%o0+0]	! Callers stack pointer
+	stx	%o7,[%o0+8]	! Return pc
+	stx	%fp,[%o0+16]	! Frame pointer
+	retl			! Return
+	 clr	%o0		!  ...0
+
+	.size	setjmp,.-setjmp
+
+
+       	.globl	longjmp
+	.type	longjmp, @function
+longjmp:
+	mov	%o1, %g4	! save return value
+	mov	%o0, %g1	! save target
+	ldx	[%g1+16],%g5	! get callers frame
+1:
+	cmp	%fp, %g5	! compare against desired frame
+	bl,a	1b		! if below...
+	 restore		! pop frame and loop
+	be,a	2f		! if there...
+       	 ldx	[%g1+0],%o2	! fetch return %sp
+
+.Lbotch:
+	unimp	0		! ... error ...
+
+2:
+       	cmp	%o2, %sp	! %sp must not decrease
+	bl	.Lbotch
+	 nop
+	mov	%o2, %sp	! it is OK, put it in place
+
+	ldx	[%g1+8],%o3	! fetch %pc
+	jmp	%o3 + 8		! if sucess...
+	 mov	%g4,%o0		!   return %g4
+
+	.size	longjmp,.-longjmp
diff --git a/usr/klibc/arch/sparc64/syscall.S b/usr/klibc/arch/sparc64/syscall.S
new file mode 100644
index 0000000..7ab9d95
--- /dev/null
+++ b/usr/klibc/arch/sparc64/syscall.S
@@ -0,0 +1,18 @@
+/*
+ * arch/sparc64/syscall.S
+ *
+ * Common system-call stub; %g1 already set to syscall number
+ */
+
+	.globl	__syscall_common
+	.type	__syscall_common,#function
+       	.align	4
+__syscall_common:
+	t	0x6d
+	bcc	%xcc, 1f
+	  sethi	%hi(errno), %g4
+	or	%g4, %lo(errno), %g4
+	st	%o0,[%g4]
+1:
+       	retl
+	  movcs	%xcc, -1, %o0
diff --git a/usr/klibc/arch/sparc64/sysfork.S b/usr/klibc/arch/sparc64/sysfork.S
new file mode 100644
index 0000000..2eed659
--- /dev/null
+++ b/usr/klibc/arch/sparc64/sysfork.S
@@ -0,0 +1,26 @@
+/*
+ * arch/sparc64/sysfork.S
+ *
+ * The fork and vfork system calls are special on sparc[64]:
+ * they return the "other process" pid in %o0 and the
+ * "is child" flag in %o1
+ *
+ * Common system-call stub; %g1 already set to syscall number
+ */
+
+	.globl	__syscall_forkish
+	.type	__syscall_forkish,#function
+       	.align	4
+__syscall_forkish:
+	t	0x6d
+	sub	%o1, 1, %o1
+	bcc,a	%xcc, 1f
+	  and	%o0, %o1, %o0
+	sethi	%hi(errno), %g4
+	or	%g4, %lo(errno), %g4
+	st	%o0, [%g4]
+	retl
+	  mov	-1, %o0
+1:
+       	retl
+	  nop
diff --git a/usr/klibc/arch/sparc64/sysstub.ph b/usr/klibc/arch/sparc64/sysstub.ph
new file mode 100644
index 0000000..deeb88c
--- /dev/null
+++ b/usr/klibc/arch/sparc64/sysstub.ph
@@ -0,0 +1,25 @@
+# -*- perl -*-
+#
+# arch/sparc64/sysstub.ph
+#
+# Script to generate system call stubs
+#
+
+sub make_sysstub($$$$$@) {
+    my($outputdir, $fname, $type, $sname, $stype, @args) = @_;
+
+    $stype = $stype || 'common';
+
+    open(OUT, '>', "${outputdir}/${fname}.S");
+    print OUT "#include <asm/unistd.h>\n";
+    print OUT "\n";
+    print OUT "\t.type ${fname},\@function\n";
+    print OUT "\t.globl ${fname}\n";
+    print OUT "${fname}:\n";
+    print OUT "\tb __syscall_${stype}\n";
+    print OUT "\t  mov\t__NR_${sname}, %g1\n";
+    print OUT "\t.size ${fname},.-${fname}\n";
+    close(OUT);
+}
+
+1;
