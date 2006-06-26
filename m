Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWFZBGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWFZBGv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWFZBGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:06:33 -0400
Received: from terminus.zytor.com ([192.83.249.54]:22927 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965007AbWFZA7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:59:21 -0400
Date: Sun, 25 Jun 2006 17:58:05 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 28/43] mips support for klibc
Message-Id: <klibc.200606251757.28@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the mips architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 8dc79563c06020d8844b9e9b821741828039b59e
tree b957c8fb1fddf486f5c26b1880726051d4f6aaad
parent bc9b363b31d301ab94c115cccc2e079c0d318498
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:31 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:31 -0700

 usr/include/arch/mips/klibc/archconfig.h |   15 ++
 usr/include/arch/mips/klibc/archfcntl.h  |   86 ++++++++++++
 usr/include/arch/mips/klibc/archsetjmp.h |   39 +++++
 usr/include/arch/mips/klibc/archsignal.h |   14 ++
 usr/include/arch/mips/klibc/archstat.h   |   40 ++++++
 usr/include/arch/mips/klibc/archsys.h    |   12 ++
 usr/include/arch/mips/machine/asm.h      |   11 ++
 usr/include/arch/mips/sgidefs.h          |   20 +++
 usr/include/arch/mips/spaces.h           |    1 
 usr/klibc/arch/mips/MCONFIG              |   15 ++
 usr/klibc/arch/mips/Makefile.inc         |   30 ++++
 usr/klibc/arch/mips/crt0.S               |   25 ++++
 usr/klibc/arch/mips/klibc.ld             |  214 ++++++++++++++++++++++++++++++
 usr/klibc/arch/mips/pipe.S               |   16 ++
 usr/klibc/arch/mips/setjmp.S             |   80 +++++++++++
 usr/klibc/arch/mips/syscall.S            |   16 ++
 usr/klibc/arch/mips/sysstub.ph           |   30 ++++
 usr/klibc/arch/mips/vfork.S              |   16 ++
 18 files changed, 680 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/mips/klibc/archconfig.h b/usr/include/arch/mips/klibc/archconfig.h
new file mode 100644
index 0000000..d9528b8
--- /dev/null
+++ b/usr/include/arch/mips/klibc/archconfig.h
@@ -0,0 +1,15 @@
+/*
+ * include/arch/mips/klibc/archconfig.h
+ *
+ * See include/klibc/sysconfig.h for the options that can be set in
+ * this file.
+ *
+ */
+
+#ifndef _KLIBC_ARCHCONFIG_H
+#define _KLIBC_ARCHCONFIG_H
+
+/* MIPS has architecture-specific code for vfork() */
+#define _KLIBC_REAL_VFORK 1
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/mips/klibc/archfcntl.h b/usr/include/arch/mips/klibc/archfcntl.h
new file mode 100644
index 0000000..1f61822
--- /dev/null
+++ b/usr/include/arch/mips/klibc/archfcntl.h
@@ -0,0 +1,86 @@
+/*
+ * arch/mips/include/klibc/archfcntl.h
+ *
+ * On MIPS, <asm/fcntl.h> isn't usable (compiling struct stat with
+ * the correct definitions doesn't "just work"), so we need to provide
+ * our own definitions.
+ */
+
+#ifndef _KLIBC_ARCHFCNTL_H
+#define _KLIBC_ARCHFCNTL_H
+
+#ifdef _ASM_FCNTL_H		/* We were too late! */
+# error "<asm/fcntl.h> included before <klibc/archfcntl.h>"
+#endif
+#define _ASM_FCNTL_H		/* Keep <asm/fcntl.h> from getting included */
+
+#define O_ACCMODE	0x0003
+#define O_RDONLY	0x0000
+#define O_WRONLY	0x0001
+#define O_RDWR		0x0002
+#define O_APPEND	0x0008
+#define O_SYNC		0x0010
+#define O_NONBLOCK	0x0080
+#define O_CREAT         0x0100
+#define O_TRUNC		0x0200
+#define O_EXCL		0x0400
+#define O_NOCTTY	0x0800
+#define FASYNC		0x1000
+#define O_LARGEFILE	0x2000
+#define O_DIRECT	0x8000
+#define O_DIRECTORY	0x10000
+#define O_NOFOLLOW	0x20000
+#define O_NOATIME	0x40000
+
+#define O_NDELAY	O_NONBLOCK
+
+#define F_DUPFD		0
+#define F_GETFD		1
+#define F_SETFD		2
+#define F_GETFL		3
+#define F_SETFL		4
+#define F_GETLK		14
+#define F_SETLK		6
+#define F_SETLKW	7
+
+#define F_SETOWN	24
+#define F_GETOWN	23
+#define F_SETSIG	10
+#define F_GETSIG	11
+
+#define F_GETLK64	33
+#define F_SETLK64	34
+#define F_SETLKW64	35
+
+#define FD_CLOEXEC	1
+
+#define F_RDLCK		0
+#define F_WRLCK		1
+#define F_UNLCK		2
+
+#define F_EXLCK		4
+#define F_SHLCK		8
+
+#define F_INPROGRESS	16
+
+#define LOCK_SH		1
+#define LOCK_EX		2
+#define LOCK_NB		4
+#define LOCK_UN		8
+
+#define LOCK_MAND	32
+#define LOCK_READ	64
+#define LOCK_WRITE	128
+#define LOCK_RW		192
+
+typedef struct flock {
+	short	l_type;
+	short	l_whence;
+	loff_t	l_start;
+	loff_t	l_len;
+	pid_t	l_pid;
+} flock_t;
+
+#define F_LINUX_SPECIFIC_BASE	1024
+
+#endif				/* _KLIBC_ARCHFCNTL_H */
diff --git a/usr/include/arch/mips/klibc/archsetjmp.h b/usr/include/arch/mips/klibc/archsetjmp.h
new file mode 100644
index 0000000..1fbe83e
--- /dev/null
+++ b/usr/include/arch/mips/klibc/archsetjmp.h
@@ -0,0 +1,39 @@
+/*
+ * arch/mips/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	unsigned long __s0;
+	unsigned long __s1;
+	unsigned long __s2;
+	unsigned long __s3;
+	unsigned long __s4;
+	unsigned long __s5;
+	unsigned long __s6;
+	unsigned long __s7;
+	unsigned long __gp;
+	unsigned long __sp;
+	unsigned long __s8;
+	unsigned long __ra;
+	unsigned long __f20;
+	unsigned long __f21;
+	unsigned long __f22;
+	unsigned long __f23;
+	unsigned long __f24;
+	unsigned long __f25;
+	unsigned long __f26;
+	unsigned long __f27;
+	unsigned long __f28;
+	unsigned long __f29;
+	unsigned long __f30;
+	unsigned long __f31;
+	unsigned long __fcr31;
+	unsigned long __unused;
+} __attribute__ ((aligned(8)));
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _KLIBC_ARCHSETJMP_H */
diff --git a/usr/include/arch/mips/klibc/archsignal.h b/usr/include/arch/mips/klibc/archsignal.h
new file mode 100644
index 0000000..b9ca756
--- /dev/null
+++ b/usr/include/arch/mips/klibc/archsignal.h
@@ -0,0 +1,14 @@
+/*
+ * arch/mips/include/klibc/archsignal.h
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
diff --git a/usr/include/arch/mips/klibc/archstat.h b/usr/include/arch/mips/klibc/archstat.h
new file mode 100644
index 0000000..c1d60d9
--- /dev/null
+++ b/usr/include/arch/mips/klibc/archstat.h
@@ -0,0 +1,40 @@
+#ifndef _KLIBC_ARCHSTAT_H
+#define _KLIBC_ARCHSTAT_H
+
+#define _STATBUF_ST_NSEC
+
+/*
+ * This matches struct stat64 in glibc2.1, hence the absolutely insane
+ * amounts of padding around dev_t's.  The memory layout is the same as of
+ * struct stat of the 64-bit kernel, which makes this one of the sanest
+ * 32-bit struct stats.
+ */
+
+struct stat {
+	unsigned int	st_dev;
+	unsigned long	st_pad0[3];	/* Reserved for st_dev expansion  */
+
+	unsigned long long	st_ino;
+
+	mode_t		st_mode;
+	nlink_t		st_nlink;
+
+	uid_t		st_uid;
+	gid_t		st_gid;
+
+	unsigned int	st_rdev;
+	unsigned long	st_pad1[3];	/* Reserved for st_rdev expansion  */
+
+	long long	st_size;
+
+	struct timespec		st_atim;
+	struct timespec		st_mtim;
+	struct timespec		st_ctim;
+
+	unsigned long	st_blksize;
+	unsigned long	st_pad2;
+
+	long long	st_blocks;
+};
+
+#endif
diff --git a/usr/include/arch/mips/klibc/archsys.h b/usr/include/arch/mips/klibc/archsys.h
new file mode 100644
index 0000000..252d80c
--- /dev/null
+++ b/usr/include/arch/mips/klibc/archsys.h
@@ -0,0 +1,12 @@
+/*
+ * arch/mips/include/klibc/archsys.h
+ *
+ * Architecture-specific syscall definitions
+ */
+
+#ifndef _KLIBC_ARCHSYS_H
+#define _KLIBC_ARCHSYS_H
+
+/* No special syscall definitions for this architecture */
+
+#endif				/* _KLIBC_ARCHSYS_H */
diff --git a/usr/include/arch/mips/machine/asm.h b/usr/include/arch/mips/machine/asm.h
new file mode 100644
index 0000000..f524bc6
--- /dev/null
+++ b/usr/include/arch/mips/machine/asm.h
@@ -0,0 +1,11 @@
+/*
+ * arch/mips/include/machine/asm.h
+ */
+
+#ifndef _MACHINE_ASM_H
+#define _MACHINE_ASM_H
+
+#include <asm/regdef.h>
+#include <asm/asm.h>
+
+#endif				/* _MACHINE_ASM_H */
diff --git a/usr/include/arch/mips/sgidefs.h b/usr/include/arch/mips/sgidefs.h
new file mode 100644
index 0000000..fba8ae8
--- /dev/null
+++ b/usr/include/arch/mips/sgidefs.h
@@ -0,0 +1,20 @@
+/*
+ * arch/mips/include/sgidefs.h
+ */
+
+/* Some ABI constants */
+
+#ifndef _SGIDEFS_H
+#define _SGIDEFS_H
+
+#define _MIPS_ISA_MIPS1 1
+#define _MIPS_ISA_MIPS2 2
+#define _MIPS_ISA_MIPS3 3
+#define _MIPS_ISA_MIPS4 4
+#define _MIPS_ISA_MIPS5 5
+
+#define _MIPS_SIM_ABI32         1
+#define _MIPS_SIM_NABI32        2
+#define _MIPS_SIM_ABI64         3
+
+#endif				/* _SGIDEFS_H */
diff --git a/usr/include/arch/mips/spaces.h b/usr/include/arch/mips/spaces.h
new file mode 100644
index 0000000..b5f530b
--- /dev/null
+++ b/usr/include/arch/mips/spaces.h
@@ -0,0 +1 @@
+/* Included by <asm/page.h> but not actually needed */
diff --git a/usr/klibc/arch/mips/MCONFIG b/usr/klibc/arch/mips/MCONFIG
new file mode 100644
index 0000000..fd70500
--- /dev/null
+++ b/usr/klibc/arch/mips/MCONFIG
@@ -0,0 +1,15 @@
+# -*- makefile -*-
+#
+# arch/mips/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHREQFLAGS = -fno-pic -mno-abicalls -G 0
+KLIBCOPTFLAGS     = -Os
+KLIBCBITSIZE      = 32
+
+# Extra linkflags when building the shared version of the library
+KLIBCSHAREDFLAGS	= -T $(src)/arch/$(KLIBCARCH)/klibc.ld
diff --git a/usr/klibc/arch/mips/Makefile.inc b/usr/klibc/arch/mips/Makefile.inc
new file mode 100644
index 0000000..311bdfc
--- /dev/null
+++ b/usr/klibc/arch/mips/Makefile.inc
@@ -0,0 +1,30 @@
+# -*- makefile -*-
+#
+# arch/mips/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCARCHOBJS = \
+	arch/$(KLIBCARCH)/pipe.o \
+	arch/$(KLIBCARCH)/vfork.o \
+	arch/$(KLIBCARCH)/setjmp.o \
+	arch/$(KLIBCARCH)/syscall.o \
+	libgcc/__clzsi2.o \
+	libgcc/__clzdi2.o \
+	libgcc/__ashldi3.o \
+	libgcc/__ashrdi3.o \
+	libgcc/__lshrdi3.o \
+	libgcc/__divdi3.o \
+        libgcc/__moddi3.o \
+        libgcc/__udivdi3.o \
+	libgcc/__umoddi3.o \
+        libgcc/__udivmoddi4.o
+
+
+KLIBCARCHSOOBJS = $(patsubst %.o,%.lo,$(KLIBCARCHOBJS))
+
+
+archclean:
diff --git a/usr/klibc/arch/mips/crt0.S b/usr/klibc/arch/mips/crt0.S
new file mode 100644
index 0000000..142d9f2
--- /dev/null
+++ b/usr/klibc/arch/mips/crt0.S
@@ -0,0 +1,25 @@
+#
+# arch/mips/crt0.S
+#
+# Does arch-specific initialization and invokes __libc_init
+# with the appropriate arguments.
+#
+# See __static_init.c or __shared_init.c for the expected
+# arguments.
+#
+
+#include <machine/asm.h>
+
+NESTED(__start, 32, sp)
+	subu	sp, 32
+	sw	zero, 16(sp)
+
+	lui	gp, %hi(_gp)		# Initialize gp
+	addiu	gp, gp, _gp
+
+	addiu	a0, sp, 32		# Pointer to ELF entry structure
+	move	a1, v0			# Kernel-provided atexit() pointer
+
+	jal	__libc_init
+
+	END(__start)
diff --git a/usr/klibc/arch/mips/klibc.ld b/usr/klibc/arch/mips/klibc.ld
new file mode 100644
index 0000000..5a2a7a6
--- /dev/null
+++ b/usr/klibc/arch/mips/klibc.ld
@@ -0,0 +1,214 @@
+/* Linker script for klibc.so, needed because of the the damned
+   GNU ld script headers problem */
+
+ENTRY(__start)
+SECTIONS
+{
+  /* Read-only sections, merged into text segment: */
+  /* This address needs to be reachable using normal inter-module
+      calls, and work on the memory models for this architecture */
+  /* 2 MB -- the normal starting point for text is 4 MB */
+  . = 0x00200400;
+  .interp         : { *(.interp) }
+  .reginfo        : { *(.reginfo) }
+  .dynamic        : { *(.dynamic) }
+  .hash           : { *(.hash) }
+  .dynsym         : { *(.dynsym) }
+  .dynstr         : { *(.dynstr) }
+  .gnu.version    : { *(.gnu.version) }
+  .gnu.version_d  : { *(.gnu.version_d) }
+  .gnu.version_r  : { *(.gnu.version_r) }
+  .rel.dyn        :
+    {
+      *(.rel.init)
+      *(.rel.text .rel.text.* .rel.gnu.linkonce.t.*)
+      *(.rel.fini)
+      *(.rel.rodata .rel.rodata.* .rel.gnu.linkonce.r.*)
+      *(.rel.data .rel.data.* .rel.gnu.linkonce.d.*)
+      *(.rel.tdata .rel.tdata.* .rel.gnu.linkonce.td.*)
+      *(.rel.tbss .rel.tbss.* .rel.gnu.linkonce.tb.*)
+      *(.rel.ctors)
+      *(.rel.dtors)
+      *(.rel.got)
+      *(.rel.sdata .rel.sdata.* .rel.gnu.linkonce.s.*)
+      *(.rel.sbss .rel.sbss.* .rel.gnu.linkonce.sb.*)
+      *(.rel.sdata2 .rel.sdata2.* .rel.gnu.linkonce.s2.*)
+      *(.rel.sbss2 .rel.sbss2.* .rel.gnu.linkonce.sb2.*)
+      *(.rel.bss .rel.bss.* .rel.gnu.linkonce.b.*)
+    }
+  .rela.dyn       :
+    {
+      *(.rela.init)
+      *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*)
+      *(.rela.fini)
+      *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*)
+      *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*)
+      *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*)
+      *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*)
+      *(.rela.ctors)
+      *(.rela.dtors)
+      *(.rela.got)
+      *(.rela.sdata .rela.sdata.* .rela.gnu.linkonce.s.*)
+      *(.rela.sbss .rela.sbss.* .rela.gnu.linkonce.sb.*)
+      *(.rela.sdata2 .rela.sdata2.* .rela.gnu.linkonce.s2.*)
+      *(.rela.sbss2 .rela.sbss2.* .rela.gnu.linkonce.sb2.*)
+      *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*)
+    }
+  .rel.plt        : { *(.rel.plt) }
+  .rela.plt       : { *(.rela.plt) }
+  .init           :
+  {
+    KEEP (*(.init))
+  } =0
+  .plt            : { *(.plt) }
+  .text           :
+  {
+    _ftext = . ;
+    *(.text .stub .text.* .gnu.linkonce.t.*)
+    /* .gnu.warning sections are handled specially by elf32.em.  */
+    *(.gnu.warning)
+    *(.mips16.fn.*) *(.mips16.call.*)
+  } =0
+  .fini           :
+  {
+    KEEP (*(.fini))
+  } =0
+  PROVIDE (__etext = .);
+  PROVIDE (_etext = .);
+  PROVIDE (etext = .);
+  .rodata         : { *(.rodata .rodata.* .gnu.linkonce.r.*) }
+  .rodata1        : { *(.rodata1) }
+  .sdata2         : { *(.sdata2 .sdata2.* .gnu.linkonce.s2.*) }
+  .sbss2          : { *(.sbss2 .sbss2.* .gnu.linkonce.sb2.*) }
+  .eh_frame_hdr : { *(.eh_frame_hdr) }
+  /* Adjust the address for the data segment.  We want to adjust up to
+     the same address within the page on the next page up.  */
+  . = ALIGN(8192);
+  /* Ensure the __preinit_array_start label is properly aligned.  We
+     could instead move the label definition inside the section, but
+     the linker would then create the section even if it turns out to
+     be empty, which isn't pretty.  */
+  . = ALIGN(32 / 8);
+  PROVIDE (__preinit_array_start = .);
+  .preinit_array     : { *(.preinit_array) }
+  PROVIDE (__preinit_array_end = .);
+  PROVIDE (__init_array_start = .);
+  .init_array     : { *(.init_array) }
+  PROVIDE (__init_array_end = .);
+  PROVIDE (__fini_array_start = .);
+  .fini_array     : { *(.fini_array) }
+  PROVIDE (__fini_array_end = .);
+  .data           :
+  {
+    _fdata = . ;
+    *(.data .data.* .gnu.linkonce.d.*)
+    SORT(CONSTRUCTORS)
+  }
+  .data1          : { *(.data1) }
+  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
+  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
+  .eh_frame       : { KEEP (*(.eh_frame)) }
+  .gcc_except_table   : { *(.gcc_except_table) }
+  .ctors          :
+  {
+    /* gcc uses crtbegin.o to find the start of
+       the constructors, so we make sure it is
+       first.  Because this is a wildcard, it
+       doesn't matter if the user does not
+       actually link against crtbegin.o; the
+       linker won't look for a file to match a
+       wildcard.  The wildcard also means that it
+       doesn't matter which directory crtbegin.o
+       is in.  */
+    KEEP (*crtbegin*.o(.ctors))
+    /* We don't want to include the .ctor section from
+       from the crtend.o file until after the sorted ctors.
+       The .ctor section from the crtend file contains the
+       end of ctors marker and it must be last */
+    KEEP (*(EXCLUDE_FILE (*crtend*.o ) .ctors))
+    KEEP (*(SORT(.ctors.*)))
+    KEEP (*(.ctors))
+  }
+  .dtors          :
+  {
+    KEEP (*crtbegin*.o(.dtors))
+    KEEP (*(EXCLUDE_FILE (*crtend*.o ) .dtors))
+    KEEP (*(SORT(.dtors.*)))
+    KEEP (*(.dtors))
+  }
+  .jcr            : { KEEP (*(.jcr)) }
+  _gp = ALIGN(16) + 0x7ff0;
+  .got            : { *(.got.plt) *(.got) }
+  /* We want the small data sections together, so single-instruction offsets
+     can access them all, and initialized data all before uninitialized, so
+     we can shorten the on-disk segment size.  */
+  .sdata          :
+  {
+    *(.sdata .sdata.* .gnu.linkonce.s.*)
+  }
+  .lit8           : { *(.lit8) }
+  .lit4           : { *(.lit4) }
+  _edata = .;
+  PROVIDE (edata = .);
+  __bss_start = .;
+  _fbss = .;
+  .sbss           :
+  {
+    PROVIDE (__sbss_start = .);
+    PROVIDE (___sbss_start = .);
+    *(.dynsbss)
+    *(.sbss .sbss.* .gnu.linkonce.sb.*)
+    *(.scommon)
+    PROVIDE (__sbss_end = .);
+    PROVIDE (___sbss_end = .);
+  }
+  .bss            :
+  {
+   *(.dynbss)
+   *(.bss .bss.* .gnu.linkonce.b.*)
+   *(COMMON)
+   /* Align here to ensure that the .bss section occupies space up to
+      _end.  Align after .bss to ensure correct alignment even if the
+      .bss section disappears because there are no input sections.  */
+   . = ALIGN(32 / 8);
+  }
+  . = ALIGN(32 / 8);
+  _end = .;
+  PROVIDE (end = .);
+  /* Stabs debugging sections.  */
+  .stab          0 : { *(.stab) }
+  .stabstr       0 : { *(.stabstr) }
+  .stab.excl     0 : { *(.stab.excl) }
+  .stab.exclstr  0 : { *(.stab.exclstr) }
+  .stab.index    0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment       0 : { *(.comment) }
+  /* DWARF debug sections.
+     Symbols in the DWARF debugging sections are relative to the beginning
+     of the section so we begin them at 0.  */
+  /* DWARF 1 */
+  .debug          0 : { *(.debug) }
+  .line           0 : { *(.line) }
+  /* GNU DWARF 1 extensions */
+  .debug_srcinfo  0 : { *(.debug_srcinfo) }
+  .debug_sfnames  0 : { *(.debug_sfnames) }
+  /* DWARF 1.1 and DWARF 2 */
+  .debug_aranges  0 : { *(.debug_aranges) }
+  .debug_pubnames 0 : { *(.debug_pubnames) }
+  /* DWARF 2 */
+  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
+  .debug_abbrev   0 : { *(.debug_abbrev) }
+  .debug_line     0 : { *(.debug_line) }
+  .debug_frame    0 : { *(.debug_frame) }
+  .debug_str      0 : { *(.debug_str) }
+  .debug_loc      0 : { *(.debug_loc) }
+  .debug_macinfo  0 : { *(.debug_macinfo) }
+  /* SGI/MIPS DWARF 2 extensions */
+  .debug_weaknames 0 : { *(.debug_weaknames) }
+  .debug_funcnames 0 : { *(.debug_funcnames) }
+  .debug_typenames 0 : { *(.debug_typenames) }
+  .debug_varnames  0 : { *(.debug_varnames) }
+  .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
+  .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
+  /DISCARD/ : { *(.note.GNU-stack) }
+}
diff --git a/usr/klibc/arch/mips/pipe.S b/usr/klibc/arch/mips/pipe.S
new file mode 100644
index 0000000..02b9405
--- /dev/null
+++ b/usr/klibc/arch/mips/pipe.S
@@ -0,0 +1,16 @@
+#include <asm/asm.h>
+#include <asm/regdef.h>
+#include <asm/unistd.h>
+
+LEAF(pipe)
+	li	v0, __NR_pipe
+	syscall
+	bnez	a3, 1f
+	sw	v0,  (a0)
+	sw	v1, 4(a0)
+	li	v0, 0
+	b	2f
+1:	sw	v0, errno
+	li	v0, -1
+2:	jr	ra
+	END(pipe)
diff --git a/usr/klibc/arch/mips/setjmp.S b/usr/klibc/arch/mips/setjmp.S
new file mode 100644
index 0000000..68eed19
--- /dev/null
+++ b/usr/klibc/arch/mips/setjmp.S
@@ -0,0 +1,80 @@
+#
+# arch/mips/setjmp.S
+#
+# setjmp/longjmp for the MIPS architecture
+#
+# The jmp_buf is assumed to contain the following, in order:
+#	s0..s7
+#	gp
+#	sp
+#	s8
+#	ra
+#	f20..f31
+#	fcr31
+#
+
+#include <machine/asm.h>
+
+LEAF(setjmp)
+	sw	s0,  0(a0)
+	sw	s1,  4(a0)
+	sw	s2,  8(a0)
+	sw	s3, 12(a0)
+	sw	s4, 16(a0)
+	sw	s5, 20(a0)
+	sw	s6, 24(a0)
+	sw	s7, 28(a0)
+	sw	gp, 32(a0)
+	sw	sp, 36(a0)
+	sw	s8, 40(a0)
+	sw	ra, 44(a0)
+	cfc1	t0,$31
+	swc1	$f20,48(a0)
+	swc1	$f21,52(a0)
+	swc1	$f22,56(a0)
+	swc1	$f23,60(a0)
+	swc1	$f24,64(a0)
+	swc1	$f25,68(a0)
+	swc1	$f26,72(a0)
+	swc1	$f27,76(a0)
+	swc1	$f28,80(a0)
+	swc1	$f29,84(a0)
+	swc1	$f30,88(a0)
+	swc1	$f31,92(a0)
+	sw	t0,96(a0)
+	move	v0,zero
+	jr	ra
+
+	END(setjmp)
+
+LEAF(longjmp)
+	lw	s0,  0(a0)
+	lw	s1,  4(a0)
+	lw	s2,  8(a0)
+	lw	s3, 12(a0)
+	lw	s4, 16(a0)
+	lw	s5, 20(a0)
+	lw	s6, 24(a0)
+	lw	s7, 28(a0)
+	lw	gp, 32(a0)
+	lw	sp, 36(a0)
+	lw	s8, 40(a0)
+	lw	ra, 44(a0)
+	lw	t0, 96(a0)
+	lwc1	$f20,48(a0)
+	lwc1	$f21,52(a0)
+	lwc1	$f22,56(a0)
+	lwc1	$f23,60(a0)
+	lwc1	$f24,64(a0)
+	lwc1	$f25,68(a0)
+	lwc1	$f26,72(a0)
+	lwc1	$f27,76(a0)
+	lwc1	$f28,80(a0)
+	lwc1	$f29,84(a0)
+	lwc1	$f30,88(a0)
+	lwc1	$f31,92(a0)
+	ctc1	t0,$31
+	move	v0,a1
+	jr	ra
+
+	END(longjmp)
diff --git a/usr/klibc/arch/mips/syscall.S b/usr/klibc/arch/mips/syscall.S
new file mode 100644
index 0000000..9f308df
--- /dev/null
+++ b/usr/klibc/arch/mips/syscall.S
@@ -0,0 +1,16 @@
+#include <asm/asm.h>
+#include <asm/regdef.h>
+#include <asm/unistd.h>
+
+	.set noreorder
+
+LEAF(__syscall_common)
+	syscall
+        beqz    a3, 1f
+	# sw is actually two instructions; the first one goes
+	# in the branch delay slot
+	# XXX: Break this up manually; as it is now it generates warnings.
+        sw      v0, errno
+        li      v0, -1
+1:      jr      ra
+	END(__syscall_common)
diff --git a/usr/klibc/arch/mips/sysstub.ph b/usr/klibc/arch/mips/sysstub.ph
new file mode 100644
index 0000000..a71d5d0
--- /dev/null
+++ b/usr/klibc/arch/mips/sysstub.ph
@@ -0,0 +1,30 @@
+# -*- perl -*-
+#
+# arch/mips/sysstub.ph
+#
+# Script to generate system call stubs
+#
+
+# On MIPS, most system calls follow the standard convention, with the
+# system call number in r0 (v0), return an error value in r19 (a3) as
+# well as the return value in r0 (v0).
+
+sub make_sysstub($$$$$@) {
+    my($outputdir, $fname, $type, $sname, $stype, @args) = @_;
+
+    $stype = $stype || 'common';
+    open(OUT, '>', "${outputdir}/${fname}.S");
+    print OUT "#include <asm/asm.h>\n";
+    print OUT "#include <asm/regdef.h>\n";
+    print OUT "#include <asm/unistd.h>\n";
+    print OUT "\n";
+    print OUT "\t.set noreorder\n";
+    print OUT "\n";
+    print OUT "LEAF(${fname})\n";
+    print OUT "\tj\t__syscall_${stype}\n";
+    print OUT "\t  li\tv0, __NR_${sname}\n";
+    print OUT "\tEND(${fname})\n";
+    close(OUT);
+}
+
+1;
diff --git a/usr/klibc/arch/mips/vfork.S b/usr/klibc/arch/mips/vfork.S
new file mode 100644
index 0000000..f9f035b
--- /dev/null
+++ b/usr/klibc/arch/mips/vfork.S
@@ -0,0 +1,16 @@
+#include <asm/asm.h>
+#include <asm/regdef.h>
+#include <asm/unistd.h>
+
+#define CLONE_VM	0x00000100
+#define CLONE_VFORK	0x00004000
+#define SIGCHLD		18
+
+	.set noreorder
+
+LEAF(vfork)
+	li	a0, CLONE_VFORK | CLONE_VM | SIGCHLD
+	li	a1, 0
+	j	__syscall_common
+	  li	v0, __NR_clone
+	END(vfork)
