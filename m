Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423165AbWF1FTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423165AbWF1FTw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423163AbWF1FTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:19:40 -0400
Received: from terminus.zytor.com ([192.83.249.54]:2510 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423165AbWF1FSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:18:54 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 16/31] s390 support for klibc
Date: Tue, 27 Jun 2006 22:17:16 -0700
Message-Id: <klibc.200606272217.16@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the s390 architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 271a450164027af5f0924e2e1d75ddec961a5c6d
tree 3b812c9e532f4ceaaf3a9ed64f0041c775ca69df
parent 951675b371b8e1b50a37f0f779e53b73316e9f11
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:54 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:54 -0700

 usr/include/arch/s390/klibc/archconfig.h |   15 ++++++
 usr/include/arch/s390/klibc/archsetjmp.h |   26 ++++++++++
 usr/include/arch/s390/klibc/archsignal.h |   14 ++++++
 usr/include/arch/s390/klibc/archstat.h   |   56 ++++++++++++++++++++++
 usr/klibc/arch/s390/MCONFIG              |   23 +++++++++
 usr/klibc/arch/s390/Makefile.inc         |   38 +++++++++++++++
 usr/klibc/arch/s390/crt0.S               |   35 ++++++++++++++
 usr/klibc/arch/s390/mmap.c               |   75 ++++++++++++++++++++++++++++++
 usr/klibc/arch/s390/setjmp.S             |   66 ++++++++++++++++++++++++++
 usr/klibc/arch/s390/syscall.c            |   16 ++++++
 usr/klibc/arch/s390/sysstub.ph           |   40 ++++++++++++++++
 11 files changed, 404 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/s390/klibc/archconfig.h b/usr/include/arch/s390/klibc/archconfig.h
new file mode 100644
index 0000000..d7a71a4
--- /dev/null
+++ b/usr/include/arch/s390/klibc/archconfig.h
@@ -0,0 +1,15 @@
+/*
+ * include/arch/s390/klibc/archconfig.h
+ *
+ * See include/klibc/sysconfig.h for the options that can be set in
+ * this file.
+ *
+ */
+
+#ifndef _KLIBC_ARCHCONFIG_H
+#define _KLIBC_ARCHCONFIG_H
+
+/* Both s390 and s390x use the "32-bit" version of this structure */
+#define _KLIBC_STATFS_F_TYPE_64 0
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/s390/klibc/archsetjmp.h b/usr/include/arch/s390/klibc/archsetjmp.h
new file mode 100644
index 0000000..728780a
--- /dev/null
+++ b/usr/include/arch/s390/klibc/archsetjmp.h
@@ -0,0 +1,26 @@
+/*
+ * arch/s390/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+#ifndef __s390x__
+
+struct __jmp_buf {
+	uint32_t __gregs[10];	/* general registers r6-r15 */
+	uint64_t __fpregs[2];	/* fp registers f4 and f6   */
+};
+
+#else /* __s390x__ */
+
+struct __jmp_buf {
+	uint64_t __gregs[10]; /* general registers r6-r15 */
+	uint64_t __fpregs[4]; /* fp registers f1, f3, f5, f7 */
+};
+
+#endif /* __s390x__ */
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _SETJMP_H */
diff --git a/usr/include/arch/s390/klibc/archsignal.h b/usr/include/arch/s390/klibc/archsignal.h
new file mode 100644
index 0000000..a16b977
--- /dev/null
+++ b/usr/include/arch/s390/klibc/archsignal.h
@@ -0,0 +1,14 @@
+/*
+ * arch/s390/include/klibc/archsignal.h
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
diff --git a/usr/include/arch/s390/klibc/archstat.h b/usr/include/arch/s390/klibc/archstat.h
new file mode 100644
index 0000000..de3a9da
--- /dev/null
+++ b/usr/include/arch/s390/klibc/archstat.h
@@ -0,0 +1,56 @@
+#ifndef _KLIBC_ARCHSTAT_H
+#define _KLIBC_ARCHSTAT_H
+
+#include <klibc/stathelp.h>
+
+#define _STATBUF_ST_NSEC
+
+#ifndef __s390x__
+
+/* This matches struct stat64 in glibc2.1, hence the absolutely
+ * insane amounts of padding around dev_t's.
+ */
+struct stat {
+	__stdev64	(st_dev);
+        unsigned int    __pad1;
+#define STAT64_HAS_BROKEN_ST_INO        1
+        unsigned long   __st_ino;
+        unsigned int    st_mode;
+        unsigned int    st_nlink;
+        unsigned long   st_uid;
+        unsigned long   st_gid;
+	__stdev64	(st_rdev);
+        unsigned int    __pad3;
+        long long	st_size;
+        unsigned long   st_blksize;
+        unsigned char   __pad4[4];
+        unsigned long   __pad5;     /* future possible st_blocks high bits */
+        unsigned long   st_blocks;  /* Number 512-byte blocks allocated. */
+	struct timespec st_atim;
+	struct timespec st_mtim;
+	struct timespec st_ctim;
+        unsigned long long	st_ino;
+};
+
+#else /* __s390x__ */
+
+struct stat {
+	__stdev64	(st_dev);
+	unsigned long	st_ino;
+	unsigned long	st_nlink;
+	unsigned int	st_mode;
+	unsigned int	st_uid;
+	unsigned int	st_gid;
+	unsigned int	__pad1;
+	__stdev64	(st_rdev);
+	unsigned long	st_size;
+	struct timespec	st_atim;
+	struct timespec	st_mtim;
+	struct timespec	st_ctim;
+	unsigned long	st_blksize;
+	long		st_blocks;
+	unsigned long	__unused[3];
+};
+
+#endif /* __s390x__ */
+#endif
diff --git a/usr/klibc/arch/s390/MCONFIG b/usr/klibc/arch/s390/MCONFIG
new file mode 100644
index 0000000..dd4495a
--- /dev/null
+++ b/usr/klibc/arch/s390/MCONFIG
@@ -0,0 +1,23 @@
+# -*- makefile -*-
+#
+# arch/s390/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCOPTFLAGS = -Os
+
+ifneq ("$(KLIBCARCH)", "s390x")
+	KLIBCBITSIZE	= 32
+	KLIBCCFLAGS	+= -m31
+	KLIBCLDFLAGS	+= -m elf_s390
+else
+	KLIBCBITSIZE	= 64
+	KLIBCCFLAGS	+= -m64
+	KLIBCLDFLAGS	+= -m elf64_s390
+endif
+
+KLIBCASMARCH		= s390
+KLIBCSHAREDFLAGS	= -Ttext 0x40000200
diff --git a/usr/klibc/arch/s390/Makefile.inc b/usr/klibc/arch/s390/Makefile.inc
new file mode 100644
index 0000000..8a35d73
--- /dev/null
+++ b/usr/klibc/arch/s390/Makefile.inc
@@ -0,0 +1,38 @@
+# -*- makefile -*-
+#
+# arch/s390/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+ifneq ("$(KLIBCARCH)", "s390x")
+
+KLIBCARCHOBJS = \
+	arch/$(KLIBCARCHDIR)/setjmp.o \
+	arch/$(KLIBCARCHDIR)/mmap.o \
+	arch/$(KLIBCARCHDIR)/syscall.o \
+	libgcc/__clzsi2.o \
+	libgcc/__ashldi3.o \
+	libgcc/__ashrdi3.o \
+	libgcc/__lshrdi3.o \
+	libgcc/__divdi3.o \
+	libgcc/__moddi3.o \
+	libgcc/__udivdi3.o \
+	libgcc/__umoddi3.o \
+	libgcc/__udivmoddi4.o
+
+else
+
+KLIBCARCHOBJS = \
+	arch/$(KLIBCARCHDIR)/setjmp.o \
+	arch/$(KLIBCARCHDIR)/mmap.o \
+	arch/$(KLIBCARCHDIR)/syscall.o
+
+endif
+
+KLIBCARCHSOOBJS = $(patsubst %.o,%.lo,$(KLIBCARCHOBJS))
+
+
+archclean:
diff --git a/usr/klibc/arch/s390/crt0.S b/usr/klibc/arch/s390/crt0.S
new file mode 100644
index 0000000..fd9237e
--- /dev/null
+++ b/usr/klibc/arch/s390/crt0.S
@@ -0,0 +1,35 @@
+#
+# arch/s390/crt0.S
+#
+# Does arch-specific initialization and invokes __libc_init
+# with the appropriate arguments.
+#
+# See __static_init.c or __shared_init.c for the expected
+# arguments.
+#
+	.text
+	.align 4
+	.type _start,@function
+	.globl _start
+
+#ifndef __s390x__
+
+_start:
+	lr	%r2,%r15
+	lhi	%r3,0
+	ahi	%r15,-96
+	bras	%r1,.L0
+.L0:
+	l	%r1,.L1-.L0(%r1)
+	br	%r1
+.L1:
+	.long	__libc_init
+#else
+
+_start:
+	lgr	%r2,%r15
+	lghi	%r3,0
+	aghi	%r15,-160
+	jg	__libc_init
+#endif
+	.size _start,.-_start
diff --git a/usr/klibc/arch/s390/mmap.c b/usr/klibc/arch/s390/mmap.c
new file mode 100644
index 0000000..4c43779
--- /dev/null
+++ b/usr/klibc/arch/s390/mmap.c
@@ -0,0 +1,75 @@
+#include <errno.h>
+#include <sys/types.h>
+#include <linux/unistd.h>
+
+struct mmap_arg_struct {
+	unsigned long addr;
+	unsigned long len;
+	unsigned long prot;
+	unsigned long flags;
+	unsigned long fd;
+	unsigned long offset;
+};
+
+#ifndef __s390x__
+
+void *__mmap2(void *addr, size_t len, int prot, int flags, int fd, long offset)
+{
+	struct mmap_arg_struct args = {
+		(unsigned long)addr,
+		(unsigned long)len,
+		(unsigned long)prot,
+		(unsigned long)flags,
+		(unsigned long)fd,
+		(unsigned long)offset,
+	};
+
+	register struct mmap_arg_struct *__arg1 asm("2") = &args;
+	register long __svcres asm("2");
+	unsigned long __res;
+
+	__asm__ __volatile__("    svc %b1\n"
+			     : "=d"(__svcres)
+			     : "i"(__NR_mmap2), "0"(__arg1)
+			     : "1", "cc", "memory");
+	__res = __svcres;
+	if (__res >= (unsigned long)-4095) {
+		errno = -__res;
+		__res = -1;
+	}
+	return (void *)__res;
+}
+
+#else /* __s390x__ */
+
+void * mmap(void * addr, size_t len, int prot, int flags,
+						 int fd, off_t offset)
+{
+	struct mmap_arg_struct args = {
+		(unsigned long) addr,
+		(unsigned long) len,
+		(unsigned long) prot,
+		(unsigned long) flags,
+		(unsigned long) fd,
+		(unsigned long) offset,
+	};
+
+	register struct mmap_arg_struct *__arg1 asm("2") = &args;
+	register long __svcres asm("2");
+	unsigned long __res;
+
+	__asm__ __volatile__ (
+		"    svc %b1\n"
+		: "=d" (__svcres)
+		: "i" (__NR_mmap),
+		  "0" (__arg1)
+		: "1", "cc", "memory");
+	__res = __svcres;
+	if (__res >= (unsigned long)-4095) {
+		errno = -__res;
+		__res = -1;
+	}
+	return (void *)__res;
+}
+
+#endif /* __s390x__ */
diff --git a/usr/klibc/arch/s390/setjmp.S b/usr/klibc/arch/s390/setjmp.S
new file mode 100644
index 0000000..c36a051
--- /dev/null
+++ b/usr/klibc/arch/s390/setjmp.S
@@ -0,0 +1,66 @@
+#
+# arch/s390/setjmp.S
+#
+# setjmp/longjmp for the s390 architecture
+#
+
+	.text
+	.align 4
+	.globl setjmp
+	.type setjmp, @function
+
+#ifndef __s390x__
+
+setjmp:
+	stm	%r6,%r15,0(%r2)		# save all general registers
+	std	%f4,40(%r2)		# save fp registers f4 and f6
+	std	%f6,48(%r2)
+	lhi	%r2,0			# return 0
+	br	%r14
+
+	.size setjmp,.-setjmp
+
+	.text
+	.align 4
+	.globl longjmp
+	.type longjmp, @function
+longjmp:
+	lr	%r1,%r2			# jmp_buf
+	lr	%r2,%r3			# return value
+	ld	%f6,48(%r1)		# restore all saved registers
+	ld	%f4,40(%r1)
+	lm	%r6,%r15,0(%r1)
+	br	%r14			# return to restored address
+
+	.size longjmp,.-longjmp
+
+#else
+
+setjmp:
+	stmg	%r6,%r15,0(%r2)		# save all general registers
+	std	%f1,80(%r2)		# save fp registers f4 and f6
+	std	%f3,88(%r2)
+	std	%f5,96(%r2)
+	std	%f7,104(%r2)
+	lghi	%r2,0			# return 0
+	br	%r14
+
+	.size setjmp,.-setjmp
+
+	.text
+	.align 4
+	.globl longjmp
+	.type longjmp, @function
+longjmp:
+	lgr	%r1,%r2			# jmp_buf
+	lgr	%r2,%r3			# return value
+	ld	%f7,104(%r1)		# restore all saved registers
+	ld	%f5,96(%r1)
+	ld	%f3,88(%r1)
+	ld	%f1,80(%r1)
+	lmg	%r6,%r15,0(%r1)
+	br	%r14			# return to restored address
+
+	.size longjmp,.-longjmp
+
+#endif
diff --git a/usr/klibc/arch/s390/syscall.c b/usr/klibc/arch/s390/syscall.c
new file mode 100644
index 0000000..e1d201d
--- /dev/null
+++ b/usr/klibc/arch/s390/syscall.c
@@ -0,0 +1,16 @@
+/*
+ * arch/s390/syscall.c
+ *
+ * Common error-handling path for system calls.
+ * The return value from __syscall_common becomes the
+ * return value from the system call.
+ */
+#include <errno.h>
+
+unsigned long __syscall_common(unsigned long err)
+{
+	if (err < -4095UL)
+		return err;
+	errno = -err;
+	return -1;
+}
diff --git a/usr/klibc/arch/s390/sysstub.ph b/usr/klibc/arch/s390/sysstub.ph
new file mode 100644
index 0000000..880a0da
--- /dev/null
+++ b/usr/klibc/arch/s390/sysstub.ph
@@ -0,0 +1,40 @@
+# -*- perl -*-
+#
+# arch/s390/sysstub.ph
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
+    print OUT ".if __NR_${sname} < 256\n";
+    print OUT "\tsvc __NR_${sname}\n";
+    print OUT ".else\n";
+    print OUT "\tla %r1,__NR_${sname}\n";
+    print OUT "\tsvc 0\n";
+    print OUT ".endif\n";
+
+    print OUT "#ifndef __s390x__\n";
+
+    print OUT "\tbras %r3,1f\n";
+    print OUT "\t.long __syscall_common\n";
+    print OUT "1:\tl %r3,0(%r3)\n";
+    print OUT "\tbr %r3\n";
+
+    print OUT "#else\n";
+
+    print OUT "\tbrasl %r3,__syscall_common\n";
+
+    print OUT "#endif\n";
+    print OUT "\t.size ${fname},.-${fname}\n";
+    close(OUT);
+}
+
+1;
