Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423169AbWF1FXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423169AbWF1FXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423175AbWF1FXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:23:20 -0400
Received: from terminus.zytor.com ([192.83.249.54]:6094 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423169AbWF1FTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:19:20 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 18/31] sparc support for klibc
Date: Tue, 27 Jun 2006 22:17:18 -0700
Message-Id: <klibc.200606272217.18@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the sparc architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 0b300030e6549258be2bf57cb5ac4d6cedd05786
tree 512a8f450f6df25913512f8c66d54464b4668248
parent f3d2864f8dd665446cb0a96b9811e77138ba8f6b
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:59 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:59 -0700

 usr/include/arch/sparc/klibc/archconfig.h |   14 +
 usr/include/arch/sparc/klibc/archsetjmp.h |   16 ++
 usr/include/arch/sparc/klibc/archsignal.h |   24 +++
 usr/include/arch/sparc/klibc/archstat.h   |   37 ++++
 usr/include/arch/sparc/machine/asm.h      |  191 ++++++++++++++++++++
 usr/include/arch/sparc/machine/frame.h    |  146 +++++++++++++++
 usr/include/arch/sparc/machine/trap.h     |  140 +++++++++++++++
 usr/klibc/arch/sparc/MCONFIG              |   19 ++
 usr/klibc/arch/sparc/Makefile.inc         |   48 +++++
 usr/klibc/arch/sparc/__muldi3.S           |   27 +++
 usr/klibc/arch/sparc/crt0.S               |    2 
 usr/klibc/arch/sparc/crt0i.S              |  100 +++++++++++
 usr/klibc/arch/sparc/divrem.m4            |  276 +++++++++++++++++++++++++++++
 usr/klibc/arch/sparc/pipe.S               |   30 +++
 usr/klibc/arch/sparc/setjmp.S             |   38 ++++
 usr/klibc/arch/sparc/smul.S               |  160 +++++++++++++++++
 usr/klibc/arch/sparc/syscall.S            |   19 ++
 usr/klibc/arch/sparc/sysfork.S            |   25 +++
 usr/klibc/arch/sparc/sysstub.ph           |   25 +++
 usr/klibc/arch/sparc/umul.S               |  193 ++++++++++++++++++++
 20 files changed, 1530 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/sparc/klibc/archconfig.h b/usr/include/arch/sparc/klibc/archconfig.h
new file mode 100644
index 0000000..90a6c49
--- /dev/null
+++ b/usr/include/arch/sparc/klibc/archconfig.h
@@ -0,0 +1,14 @@
+/*
+ * include/arch/sparc/klibc/archconfig.h
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
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/sparc/klibc/archsetjmp.h b/usr/include/arch/sparc/klibc/archsetjmp.h
new file mode 100644
index 0000000..9b4d6a2
--- /dev/null
+++ b/usr/include/arch/sparc/klibc/archsetjmp.h
@@ -0,0 +1,16 @@
+/*
+ * arch/sparc/include/klibc/archsetjmp.h
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
diff --git a/usr/include/arch/sparc/klibc/archsignal.h b/usr/include/arch/sparc/klibc/archsignal.h
new file mode 100644
index 0000000..6e845a8
--- /dev/null
+++ b/usr/include/arch/sparc/klibc/archsignal.h
@@ -0,0 +1,24 @@
+/*
+ * arch/sparc/include/klibc/archsignal.h
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
+struct sigaction {
+	__sighandler_t	sa_handler;
+	unsigned long	sa_flags;
+	void		(*sa_restorer)(void);	/* Not used by Linux/SPARC */
+	sigset_t	sa_mask;
+};
+
+/* Not actually used by the kernel... */
+#define SA_RESTORER	0x80000000
+
+#endif
diff --git a/usr/include/arch/sparc/klibc/archstat.h b/usr/include/arch/sparc/klibc/archstat.h
new file mode 100644
index 0000000..203d40b
--- /dev/null
+++ b/usr/include/arch/sparc/klibc/archstat.h
@@ -0,0 +1,37 @@
+#ifndef _KLIBC_ARCHSTAT_H
+#define _KLIBC_ARCHSTAT_H
+
+#include <klibc/stathelp.h>
+
+#define _STATBUF_ST_NSEC
+
+struct stat {
+	__stdev64	(st_dev);
+
+	unsigned long long st_ino;
+
+	unsigned int	st_mode;
+	unsigned int	st_nlink;
+
+	unsigned int	st_uid;
+	unsigned int	st_gid;
+
+	__stdev64	(st_rdev);
+
+	unsigned char	__pad3[8];
+
+	long long	st_size;
+	unsigned int	st_blksize;
+
+	unsigned char	__pad4[8];
+	unsigned int	st_blocks;
+
+	struct timespec st_atim;
+	struct timespec st_mtim;
+	struct timespec st_ctim;
+
+	unsigned int	__unused4;
+	unsigned int	__unused5;
+};
+
+#endif
diff --git a/usr/include/arch/sparc/machine/asm.h b/usr/include/arch/sparc/machine/asm.h
new file mode 100644
index 0000000..04fe9b1
--- /dev/null
+++ b/usr/include/arch/sparc/machine/asm.h
@@ -0,0 +1,191 @@
+/*	$NetBSD: asm.h,v 1.14 2002/07/20 08:37:30 mrg Exp $ */
+
+/*
+ * Copyright (c) 1994 Allen Briggs
+ * All rights reserved.
+ *
+ * Gleaned from locore.s and sun3 asm.h which had the following copyrights:
+ * locore.s:
+ * Copyright (c) 1988 University of Utah.
+ * Copyright (c) 1982, 1990 The Regents of the University of California.
+ * sun3/include/asm.h:
+ * Copyright (c) 1993 Adam Glass
+ * Copyright (c) 1990 The Regents of the University of California.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. All advertising materials mentioning features or use of this software
+ *    must display the following acknowledgement:
+ *	This product includes software developed by the University of
+ *	California, Berkeley and its contributors.
+ * 4. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#ifndef _ASM_H_
+#define _ASM_H_
+
+/* Pull in CCFSZ, CC64FSZ, and BIAS from frame.h */
+#ifndef _LOCORE
+#define _LOCORE
+#endif
+#include <machine/frame.h>
+
+#ifdef __ELF__
+#define	_C_LABEL(name)		name
+#else
+#ifdef __STDC__
+#define _C_LABEL(name)		_ ## name
+#else
+#define _C_LABEL(name)		_/**/name
+#endif
+#endif
+#define	_ASM_LABEL(name)	name
+
+#ifdef PIC
+/*
+ * PIC_PROLOGUE() is akin to the compiler generated function prologue for
+ * PIC code. It leaves the address of the Global Offset Table in DEST,
+ * clobbering register TMP in the process.
+ *
+ * We can use two code sequences.  We can read the %pc or use the call
+ * instruction that saves the pc in %o7.  Call requires the branch unit and
+ * IEU1, and clobbers %o7 which needs to be restored.  This instruction
+ * sequence takes about 4 cycles due to instruction interdependence.  Reading
+ * the pc takes 4 cycles to dispatch and is always dispatched alone.  That
+ * sequence takes 7 cycles.
+ */
+#ifdef __arch64__
+#define PIC_PROLOGUE(dest,tmp) \
+	mov %o7, tmp; \
+	sethi %hi(_GLOBAL_OFFSET_TABLE_-4),dest; \
+	call 0f; \
+	 or dest,%lo(_GLOBAL_OFFSET_TABLE_+4),dest; \
+0: \
+	add dest,%o7,dest; \
+	mov tmp, %o7
+#else
+#define PIC_PROLOGUE(dest,tmp) \
+	mov %o7,tmp; 3: call 4f; nop; 4: \
+	sethi %hi(_C_LABEL(_GLOBAL_OFFSET_TABLE_)-(3b-.)),dest; \
+	or dest,%lo(_C_LABEL(_GLOBAL_OFFSET_TABLE_)-(3b-.)),dest; \
+	add dest,%o7,dest; mov tmp,%o7
+#endif
+
+/*
+ * PICCY_SET() does the equivalent of a `set var, %dest' instruction in
+ * a PIC-like way, but without involving the Global Offset Table. This
+ * only works for VARs defined in the same file *and* in the text segment.
+ */
+#ifdef __arch64__
+#define PICCY_SET(var,dest,tmp) \
+	3: rd %pc, tmp; add tmp,(var-3b),dest
+#else
+#define PICCY_SET(var,dest,tmp) \
+	mov %o7,tmp; 3: call 4f; nop; 4: \
+	add %o7,(var-3b),dest; mov tmp,%o7
+#endif
+#else
+#define PIC_PROLOGUE(dest,tmp)
+#define PICCY_OFFSET(var,dest,tmp)
+#endif
+
+#define FTYPE(x)		.type x,@function
+#define OTYPE(x)		.type x,@object
+
+#define	_ENTRY(name) \
+	.align 4; .globl name; .proc 1; FTYPE(name); name:
+
+#ifdef GPROF
+/* see _MCOUNT_ENTRY in profile.h */
+#ifdef __ELF__
+#ifdef __arch64__
+#define _PROF_PROLOGUE \
+	.data; .align 8; 1: .uaword 0; .uaword 0; \
+	.text; save %sp,-CC64FSZ,%sp; sethi %hi(1b),%o0; call _mcount; \
+	or %o0,%lo(1b),%o0; restore
+#else
+#define _PROF_PROLOGUE \
+	.data; .align 4; 1: .long 0; \
+	.text; save %sp,-96,%sp; sethi %hi(1b),%o0; call _mcount; \
+	or %o0,%lo(1b),%o0; restore
+#endif
+#else
+#ifdef __arch64__
+#define _PROF_PROLOGUE \
+	.data; .align 8; 1: .uaword 0; .uaword 0; \
+	.text; save %sp,-CC64FSZ,%sp; sethi %hi(1b),%o0; call mcount; \
+	or %o0,%lo(1b),%o0; restore
+#else
+#define	_PROF_PROLOGUE \
+	.data; .align 4; 1: .long 0; \
+	.text; save %sp,-96,%sp; sethi %hi(1b),%o0; call mcount; \
+	or %o0,%lo(1b),%o0; restore
+#endif
+#endif
+#else
+#define _PROF_PROLOGUE
+#endif
+
+#define ENTRY(name)		_ENTRY(_C_LABEL(name)); _PROF_PROLOGUE
+#define ENTRY_NOPROFILE(name)	_ENTRY(_C_LABEL(name))
+#define	ASENTRY(name)		_ENTRY(_ASM_LABEL(name)); _PROF_PROLOGUE
+#define	FUNC(name)		ASENTRY(name)
+#define RODATA(name)		.align 4; .text; .globl _C_LABEL(name); \
+				OTYPE(_C_LABEL(name)); _C_LABEL(name):
+
+#define ASMSTR			.asciz
+
+#define RCSID(name)		.asciz name
+
+#ifdef __ELF__
+#define	WEAK_ALIAS(alias,sym)						\
+	.weak alias;							\
+	alias = sym
+#endif
+
+/*
+ * WARN_REFERENCES: create a warning if the specified symbol is referenced.
+ */
+#ifdef __ELF__
+#ifdef __STDC__
+#define	WARN_REFERENCES(_sym,_msg)				\
+	.section .gnu.warning. ## _sym ; .ascii _msg ; .text
+#else
+#define	WARN_REFERENCES(_sym,_msg)				\
+	.section .gnu.warning./**/_sym ; .ascii _msg ; .text
+#endif				/* __STDC__ */
+#else
+#ifdef __STDC__
+#define	__STRING(x)			#x
+#define	WARN_REFERENCES(sym,msg)					\
+	.stabs msg ## ,30,0,0,0 ;					\
+	.stabs __STRING(_ ## sym) ## ,1,0,0,0
+#else
+#define	__STRING(x)			"x"
+#define	WARN_REFERENCES(sym,msg)					\
+	.stabs msg,30,0,0,0 ;						\
+	.stabs __STRING(_/**/sym),1,0,0,0
+#endif				/* __STDC__ */
+#endif				/* __ELF__ */
+
+#endif				/* _ASM_H_ */
diff --git a/usr/include/arch/sparc/machine/frame.h b/usr/include/arch/sparc/machine/frame.h
new file mode 100644
index 0000000..6fb9c45
--- /dev/null
+++ b/usr/include/arch/sparc/machine/frame.h
@@ -0,0 +1,146 @@
+/*	$NetBSD: frame.h,v 1.4 2001/12/04 00:05:05 darrenr Exp $ */
+
+/*
+ * Copyright (c) 1992, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ *
+ * This software was developed by the Computer Systems Engineering group
+ * at Lawrence Berkeley Laboratory under DARPA contract BG 91-66 and
+ * contributed to Berkeley.
+ *
+ * All advertising materials mentioning features or use of this software
+ * must display the following acknowledgement:
+ *	This product includes software developed by the University of
+ *	California, Lawrence Berkeley Laboratory.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. All advertising materials mentioning features or use of this software
+ *    must display the following acknowledgement:
+ *	This product includes software developed by the University of
+ *	California, Berkeley and its contributors.
+ * 4. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ *	@(#)frame.h	8.1 (Berkeley) 6/11/93
+ */
+
+#ifndef _MACHINE_FRAME_H
+#define _MACHINE_FRAME_H
+
+#ifdef __ASSEMBLY__
+# define _LOCORE
+#endif
+
+#ifndef _LOCORE
+# include <stdint.h>
+#endif
+
+/*
+ * Sparc stack frame format.
+ *
+ * Note that the contents of each stack frame may be held only in
+ * machine register windows.  In order to get an accurate picture
+ * of the frame, you must first force the kernel to write any such
+ * windows to the stack.
+ */
+#ifndef _LOCORE
+#ifndef SUN4U
+struct frame {
+	int32_t fr_local[8];	/* space to save locals (%l0..%l7) */
+	int32_t fr_arg[6];	/* space to save arguments (%i0..%i5) */
+	struct frame *fr_fp;	/* space to save frame pointer (%i6) */
+	int32_t fr_pc;		/* space to save return pc (%i7) */
+	/*
+	 * SunOS reserves another 8 words here; this is pointless
+	 * but we do it for compatibility.
+	 */
+	int32_t fr_xxx;		/* `structure return pointer' (unused) */
+	int32_t fr_argd[6];	/* `arg dump area' (lunacy) */
+	int32_t fr_argx[1];	/* arg extension (args 7..n; variable size) */
+};
+#else
+struct frame32 {
+	int32_t fr_local[8];	/* space to save locals (%l0..%l7) */
+	int32_t fr_arg[6];	/* space to save arguments (%i0..%i5) */
+	uint32_t fr_fp;	/* space to save frame pointer (%i6) */
+	uint32_t fr_pc;	/* space to save return pc (%i7) */
+	/*
+	 * SunOS reserves another 8 words here; this is pointless
+	 * but we do it for compatibility.
+	 */
+	int32_t fr_xxx;		/* `structure return pointer' (unused) */
+	int32_t fr_argd[6];	/* `arg dump area' (lunacy) */
+	int32_t fr_argx[1];	/* arg extension (args 7..n; variable size) */
+};
+#endif
+#endif
+
+/*
+ * CCFSZ (C Compiler Frame SiZe) is the size of a stack frame required if
+ * a function is to call C code.  It should be just 64, but Sun defined
+ * their frame with space to hold arguments 0 through 5 (plus some junk),
+ * and varargs routines (such as kprintf) demand this, and gcc uses this
+ * area at times anyway.
+ */
+#define CCFSZ		96
+
+/*
+ * Sparc v9 stack frame format.
+ *
+ * Note that the contents of each stack frame may be held only in
+ * machine register windows.  In order to get an accurate picture
+ * of the frame, you must first force the kernel to write any such
+ * windows to the stack.
+ *
+ * V9 frames have an odd bias, so you can tall a v9 frame from
+ * a v8 frame by testing the stack pointer's lsb.
+ */
+#if !defined(_LOCORE) && !defined(_LIBC)
+struct frame64 {
+	int64_t fr_local[8];	/* space to save locals (%l0..%l7) */
+	int64_t fr_arg[6];	/* space to save arguments (%i0..%i5) */
+	uint64_t fr_fp;		/* space to save frame pointer (%i6) */
+	uint64_t fr_pc;		/* space to save return pc (%i7) */
+	/*
+	 * SVR4 reserves a bunch of extra stuff.
+	 */
+	int64_t fr_argd[6];	/* `register save area' (lunacy) */
+	int64_t fr_argx[0];	/* arg extension (args 7..n; variable size) */
+};
+
+#define v9next_frame(f)		((struct frame64*)(f->fr_fp+BIAS))
+#endif
+
+/*
+ * CC64FSZ (C Compiler 64-bit Frame SiZe) is the size of a stack frame used
+ * by the compiler in 64-bit mode.  It is (16)*8; space for 8 ins, 8 outs.
+ */
+#define CC64FSZ		176
+
+/*
+ * v9 stacks all have a bias of 2047 added to the %sp and %fp, so you can easily
+ * detect it by testing the register for an odd value.  Why 2K-1 I don't know.
+ */
+#define BIAS	(2048-1)
+
+#endif /* _MACHINE_FRAME_H */
diff --git a/usr/include/arch/sparc/machine/trap.h b/usr/include/arch/sparc/machine/trap.h
new file mode 100644
index 0000000..5c378c5
--- /dev/null
+++ b/usr/include/arch/sparc/machine/trap.h
@@ -0,0 +1,140 @@
+/*	$NetBSD: trap.h,v 1.11 1999/01/20 00:15:08 pk Exp $ */
+
+/*
+ * Copyright (c) 1992, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ *
+ * This software was developed by the Computer Systems Engineering group
+ * at Lawrence Berkeley Laboratory under DARPA contract BG 91-66 and
+ * contributed to Berkeley.
+ *
+ * All advertising materials mentioning features or use of this software
+ * must display the following acknowledgement:
+ *	This product includes software developed by the University of
+ *	California, Lawrence Berkeley Laboratory.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. All advertising materials mentioning features or use of this software
+ *    must display the following acknowledgement:
+ *	This product includes software developed by the University of
+ *	California, Berkeley and its contributors.
+ * 4. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ *	@(#)trap.h	8.1 (Berkeley) 6/11/93
+ */
+/*
+ * Sun4m support by Aaron Brown, Harvard University.
+ * Changes Copyright (c) 1995 The President and Fellows of Harvard College.
+ * All rights reserved.
+ */
+
+#ifndef	_MACHINE_TRAP_H
+#define	_MACHINE_TRAP_H
+
+/*	trap		vec	  (pri) description	*/
+#define	T_RESET		0x00	/* (1) not actually vectored; jumps to 0 */
+#define	T_TEXTFAULT	0x01	/* (2) address fault during instr fetch */
+#define	T_ILLINST	0x02	/* (3) illegal instruction */
+#define	T_PRIVINST	0x03	/* (4) privileged instruction */
+#define	T_FPDISABLED	0x04	/* (5) fp instr while fp disabled */
+#define	T_WINOF		0x05	/* (6) register window overflow */
+#define	T_WINUF		0x06	/* (7) register window underflow */
+#define	T_ALIGN		0x07	/* (8) address not properly aligned */
+#define	T_FPE		0x08	/* (9) floating point exception */
+#define	T_DATAFAULT	0x09	/* (10) address fault during data fetch */
+#define	T_TAGOF		0x0a	/* (11) tag overflow */
+/*			0x0b	   unused */
+/*			0x0c	   unused */
+/*			0x0d	   unused */
+/*			0x0e	   unused */
+/*			0x0f	   unused */
+/*			0x10	   unused */
+#define	T_L1INT		0x11	/* (27) level 1 interrupt */
+#define	T_L2INT		0x12	/* (26) level 2 interrupt */
+#define	T_L3INT		0x13	/* (25) level 3 interrupt */
+#define	T_L4INT		0x14	/* (24) level 4 interrupt */
+#define	T_L5INT		0x15	/* (23) level 5 interrupt */
+#define	T_L6INT		0x16	/* (22) level 6 interrupt */
+#define	T_L7INT		0x17	/* (21) level 7 interrupt */
+#define	T_L8INT		0x18	/* (20) level 8 interrupt */
+#define	T_L9INT		0x19	/* (19) level 9 interrupt */
+#define	T_L10INT	0x1a	/* (18) level 10 interrupt */
+#define	T_L11INT	0x1b	/* (17) level 11 interrupt */
+#define	T_L12INT	0x1c	/* (16) level 12 interrupt */
+#define	T_L13INT	0x1d	/* (15) level 13 interrupt */
+#define	T_L14INT	0x1e	/* (14) level 14 interrupt */
+#define	T_L15INT	0x1f	/* (13) level 15 interrupt */
+/*			0x20	   unused */
+/*	through		0x23	   unused */
+#define	T_CPDISABLED	0x24	/* (5) coprocessor instr while disabled */
+#define	T_UNIMPLFLUSH	0x25	/* Unimplemented FLUSH */
+/*	through		0x27	   unused */
+#define	T_CPEXCEPTION	0x28	/* (9) coprocessor exception */
+/*			0x29	   unused */
+#define T_IDIV0		0x2a	/* divide by zero (from hw [su]div instr) */
+#define T_STOREBUFFAULT	0x2b	/* SuperSPARC: Store buffer copy-back fault */
+/*			0x2c	   unused */
+/*	through		0x7f	   unused */
+
+/* beginning of `user' vectors (from trap instructions) - all priority 12 */
+#define	T_SUN_SYSCALL	0x80	/* system call */
+#define	T_BREAKPOINT	0x81	/* breakpoint `instruction' */
+#define	T_DIV0		0x82	/* division routine was handed 0 */
+#define	T_FLUSHWIN	0x83	/* flush windows */
+#define	T_CLEANWIN	0x84	/* provide clean windows */
+#define	T_RANGECHECK	0x85	/* ? */
+#define	T_FIXALIGN	0x86	/* fix up unaligned accesses */
+#define	T_INTOF		0x87	/* integer overflow ? */
+#define	T_SVR4_SYSCALL	0x88	/* SVR4 system call */
+#define	T_BSD_SYSCALL	0x89	/* BSD system call */
+#define	T_KGDB_EXEC	0x8a	/* for kernel gdb */
+
+/* 0x8b..0xff are currently unallocated, except the following */
+#define T_SVR4_GETCC		0xa0
+#define T_SVR4_SETCC		0xa1
+#define T_SVR4_GETPSR		0xa2
+#define T_SVR4_SETPSR		0xa3
+#define T_SVR4_GETHRTIME	0xa4
+#define T_SVR4_GETHRVTIME	0xa5
+#define T_SVR4_GETHRESTIME	0xa7
+
+#ifdef _KERNEL			/* pseudo traps for locore.s */
+#define	T_RWRET		-1	/* need first user window for trap return */
+#define	T_AST		-2	/* no-op, just needed reschedule or profile */
+#endif
+
+/* flags to system call (flags in %g1 along with syscall number) */
+#define	SYSCALL_G2RFLAG	0x400	/* on success, return to %g2 rather than npc */
+#define	SYSCALL_G7RFLAG	0x800	/* use %g7 as above (deprecated) */
+
+/*
+ * `software trap' macros to keep people happy (sparc v8 manual says not
+ * to set the upper bits).
+ */
+#define	ST_BREAKPOINT	(T_BREAKPOINT & 0x7f)
+#define	ST_DIV0		(T_DIV0 & 0x7f)
+#define	ST_FLUSHWIN	(T_FLUSHWIN & 0x7f)
+#define	ST_SYSCALL	(T_SUN_SYSCALL & 0x7f)
+
+#endif				/* _MACHINE_TRAP_H_ */
diff --git a/usr/klibc/arch/sparc/MCONFIG b/usr/klibc/arch/sparc/MCONFIG
new file mode 100644
index 0000000..9bb7592
--- /dev/null
+++ b/usr/klibc/arch/sparc/MCONFIG
@@ -0,0 +1,19 @@
+# -*- makefile -*-
+#
+# arch/sparc/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCOPTFLAGS		 = -Os -m32 -mptr32
+KLIBCBITSIZE		 = 32
+KLIBCARCHREQFLAGS	+= -D__sparc32__
+
+# Extra linkflags when building the shared version of the library
+# This address needs to be reachable using normal inter-module
+# calls, and work on the memory models for this architecture
+# Normal binaries start at 64K; the linker wants 64K alignment,
+# and call instructions have a 30-bit signed offset, << 2.
+KLIBCSHAREDFLAGS	 = -Ttext 0x40000100
diff --git a/usr/klibc/arch/sparc/Makefile.inc b/usr/klibc/arch/sparc/Makefile.inc
new file mode 100644
index 0000000..6fa9327
--- /dev/null
+++ b/usr/klibc/arch/sparc/Makefile.inc
@@ -0,0 +1,48 @@
+# -*- makefile -*-
+#
+# arch/sparc/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+m4-targets := arch/$(KLIBCARCH)/sdiv.o arch/$(KLIBCARCH)/srem.o \
+              arch/$(KLIBCARCH)/udiv.o arch/$(KLIBCARCH)/urem.o
+
+KLIBCARCHOBJS = $(m4-targets) \
+	arch/$(KLIBCARCH)/smul.o \
+	arch/$(KLIBCARCH)/umul.o \
+	arch/$(KLIBCARCH)/__muldi3.o \
+	arch/$(KLIBCARCH)/setjmp.o \
+	arch/$(KLIBCARCH)/pipe.o \
+	arch/$(KLIBCARCH)/syscall.o \
+	arch/$(KLIBCARCH)/sysfork.o \
+	libgcc/__ashldi3.o \
+	libgcc/__ashrdi3.o \
+	libgcc/__lshrdi3.o \
+	libgcc/__divdi3.o \
+	libgcc/__moddi3.o \
+	libgcc/__udivdi3.o \
+	libgcc/__umoddi3.o \
+	libgcc/__udivmoddi4.o \
+	libgcc/__clzsi2.o \
+
+
+adir := $(obj)/arch/$(KLIBCARCH)
+
+$(adir)/sdiv.S: m4 := define(NAME,\`.div')define(OP,\`div')define(S,\`true')
+$(adir)/srem.S: m4 := define(NAME,\`.rem')define(OP,\`rem')define(S,\`true')
+$(adir)/udiv.S: m4 := define(NAME,\`.udiv')define(OP,\`div')define(S,\`false')
+$(adir)/urem.S: m4 := define(NAME,\`.urem')define(OP,\`rem')define(S,\`false')
+
+targets += $(m4-targets) $(m4-targets:.o=.S)
+
+quiet_cmd_m4 = M4      $@
+      cmd_m4 = (echo "$(m4)"; cat $^) | m4 > $@
+
+# build .o from .S
+$(addprefix $(obj)/,$(m4-targets)): $(adir)/%.o : $(adir)/%.S
+# build .S from .m4
+$(addprefix $(obj)/,$(m4-targets:.o=.S)): $(src)/arch/$(KLIBCARCH)/divrem.m4
+	$(call if_changed,m4)
diff --git a/usr/klibc/arch/sparc/__muldi3.S b/usr/klibc/arch/sparc/__muldi3.S
new file mode 100644
index 0000000..e53848a
--- /dev/null
+++ b/usr/klibc/arch/sparc/__muldi3.S
@@ -0,0 +1,27 @@
+	.global .umul
+	.section	".text"
+	.align 4
+	.global __muldi3
+	.type	__muldi3, #function
+	.proc	017
+__muldi3:
+	save	%sp, -104, %sp
+	mov	%i1, %o0
+	call	.umul, 0
+	 mov	%i3, %o1
+	mov	%o0, %l2
+	mov	%o1, %l3
+	mov	%i1, %o0
+	call	.umul, 0
+	 mov	%i2, %o1
+	mov	%i0, %o1
+	mov	%o0, %l0
+	call	.umul, 0
+	 mov	%i3, %o0
+	mov	0, %l1
+	add	%l0, %o0, %l0
+	addcc	%l3, %l1, %i1
+	addx	%l2, %l0, %i0
+	jmp	%i7+8
+	 restore
+	.size	__muldi3, .-__muldi3
diff --git a/usr/klibc/arch/sparc/crt0.S b/usr/klibc/arch/sparc/crt0.S
new file mode 100644
index 0000000..63db188
--- /dev/null
+++ b/usr/klibc/arch/sparc/crt0.S
@@ -0,0 +1,2 @@
+#define TARGET_PTR_SIZE	32
+#include "crt0i.S"
diff --git a/usr/klibc/arch/sparc/crt0i.S b/usr/klibc/arch/sparc/crt0i.S
new file mode 100644
index 0000000..0220b01
--- /dev/null
+++ b/usr/klibc/arch/sparc/crt0i.S
@@ -0,0 +1,100 @@
+! This file derived from the equivalent in newlib
+!
+! C run time start off
+
+! This file supports:
+!
+! - both 32bit pointer and 64bit pointer environments (at compile time)
+! - an imposed stack bias (of 2047) (at run time)
+! - medium/low and medium/anywhere code models (at run time)
+
+! Initial stack setup:
+!
+!    bottom of stack (higher memory address)
+! 	...
+!	text of environment strings
+!	text of argument strings
+!	envp[envc] = 0 (4/8 bytes)
+!	...
+!	env[0] (4/8 bytes)
+!	argv[argc] = 0 (4/8 bytes)
+!	...
+!	argv[0] (4/8 bytes)
+!	argc (4/8 bytes)
+!	register save area (64 bits by 16 registers = 128 bytes)
+!	top of stack (%sp)
+
+! Stack Bias:
+!
+! It is the responsibility of the o/s to set this up.
+! We handle both a 0 and 2047 value for the stack bias.
+
+! Medium/Anywhere code model support:
+!
+! In this model %g4 points to the start of the data segment.
+! The text segment can go anywhere, but %g4 points to the *data* segment.
+! It is up to the compiler/linker to get this right.
+!
+! Since this model is statically linked the start of the data segment
+! is known at link time.  Eg:
+!
+!	sethi	%hh(data_start), %g1
+!	sethi	%lm(data_start), %g4
+!	or	%g1, %hm(data_start), %g1
+!	or	%g4, %lo(data_start), %g4
+!	sllx	%g1, 32, %g1
+!	or	%g4, %g1, %g4
+!
+! FIXME: For now we just assume 0.
+
+! FIXME: if %g1 contains a non-zero value, atexit() should be invoked
+! with this value.
+
+
+	.text
+	.align 4
+	.globl _start
+	.type _start, @function
+_start:
+	clr	%fp
+
+! We use %g4 even if the code model is Medium/Low (simplifies the code).
+
+	clr	%g4			! Medium/Anywhere base reg
+
+! If there is a stack bias in effect, account for it in %g5.  Then always
+! add %g5 to stack references below.  This way the code can be used with
+! or without an imposed bias.
+
+	andcc	%sp, 1, %g5
+	bz,a .LNoBias
+	 nop
+	mov	2047, %g5
+.LNoBias:
+	add	%sp, %g5, %g5
+
+! On entry, the kernel leaves room for one register frame, but
+! the C API wants more free space.  Thus, we need to drop the stack
+! pointer additionally.
+
+#if TARGET_PTR_SIZE == 32
+	sub	%sp, 32, %sp		! make room for incoming arguments
+#else /* TARGET_PTR_SIZE == 64 */
+	sub	%sp, 64, %sp		! make room for incoming arguments
+#endif
+
+! Set up pointers to the ELF data structure (argc, argv, ...)
+! Pass as the first argument to __libc_init
+#if TARGET_PTR_SIZE == 32
+	add	%g5, 0x40, %o0
+#else /* TARGET_PTR_SIZE == 64 */
+	add	%g5, 0x80, %o0
+#endif
+
+	call	__libc_init
+	 mov	%g1, %o1	! This is the "atexit" pointer;
+				! pass as the second argument to __libc_init
+
+! If __libc_init returns, something is hosed.  Try an illegal insn.
+! If that does not work, the o/s is hosed more than we are.
+	.long 0
diff --git a/usr/klibc/arch/sparc/divrem.m4 b/usr/klibc/arch/sparc/divrem.m4
new file mode 100644
index 0000000..aa4171d
--- /dev/null
+++ b/usr/klibc/arch/sparc/divrem.m4
@@ -0,0 +1,276 @@
+/*
+ * Copyright (c) 1992, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ *
+ * This software was developed by the Computer Systems Engineering group
+ * at Lawrence Berkeley Laboratory under DARPA contract BG 91-66 and
+ * contributed to Berkeley.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. All advertising materials mentioning features or use of this software
+ *    must display the following acknowledgement:
+ *	This product includes software developed by the University of
+ *	California, Berkeley and its contributors.
+ * 4. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ * from: Header: divrem.m4,v 1.4 92/06/25 13:23:57 torek Exp
+ * $NetBSD: divrem.m4,v 1.4 1997/10/09 10:07:54 lukem Exp $
+ */
+
+/*
+ * Division and remainder, from Appendix E of the Sparc Version 8
+ * Architecture Manual, with fixes from Gordon Irlam.
+ */
+
+#if defined(LIBC_SCCS) && !defined(lint)
+	.asciz "@(#)divrem.m4	8.1 (Berkeley) 6/4/93"
+#endif /* LIBC_SCCS and not lint */
+
+/*
+ * Input: dividend and divisor in %o0 and %o1 respectively.
+ *
+ * m4 parameters:
+ *  NAME	name of function to generate
+ *  OP		OP=div => %o0 / %o1; OP=rem => %o0 % %o1
+ *  S		S=true => signed; S=false => unsigned
+ *
+ * Algorithm parameters:
+ *  N		how many bits per iteration we try to get (4)
+ *  WORDSIZE	total number of bits (32)
+ *
+ * Derived constants:
+ *  TWOSUPN	2^N, for label generation (m4 exponentiation currently broken)
+ *  TOPBITS	number of bits in the top `decade' of a number
+ *
+ * Important variables:
+ *  Q		the partial quotient under development (initially 0)
+ *  R		the remainder so far, initially the dividend
+ *  ITER	number of main division loop iterations required;
+ *		equal to ceil(log2(quotient) / N).  Note that this
+ *		is the log base (2^N) of the quotient.
+ *  V		the current comparand, initially divisor*2^(ITER*N-1)
+ *
+ * Cost:
+ *  Current estimate for non-large dividend is
+ *	ceil(log2(quotient) / N) * (10 + 7N/2) + C
+ *  A large dividend is one greater than 2^(31-TOPBITS) and takes a
+ *  different path, as the upper bits of the quotient must be developed
+ *  one bit at a time.
+ */
+
+define(N, `4')
+define(TWOSUPN, `16')
+define(WORDSIZE, `32')
+define(TOPBITS, eval(WORDSIZE - N*((WORDSIZE-1)/N)))
+
+define(dividend, `%o0')
+define(divisor, `%o1')
+define(Q, `%o2')
+define(R, `%o3')
+define(ITER, `%o4')
+define(V, `%o5')
+
+/* m4 reminder: ifelse(a,b,c,d) => if a is b, then c, else d */
+define(T, `%g1')
+define(SC, `%g7')
+ifelse(S, `true', `define(SIGN, `%g6')')
+
+/*
+ * This is the recursive definition for developing quotient digits.
+ *
+ * Parameters:
+ *  $1	the current depth, 1 <= $1 <= N
+ *  $2	the current accumulation of quotient bits
+ *  N	max depth
+ *
+ * We add a new bit to $2 and either recurse or insert the bits in
+ * the quotient.  R, Q, and V are inputs and outputs as defined above;
+ * the condition codes are expected to reflect the input R, and are
+ * modified to reflect the output R.
+ */
+define(DEVELOP_QUOTIENT_BITS,
+`	! depth $1, accumulated bits $2
+	bl	L.$1.eval(TWOSUPN+$2)
+	srl	V,1,V
+	! remainder is positive
+	subcc	R,V,R
+	ifelse($1, N,
+	`	b	9f
+		add	Q, ($2*2+1), Q
+	', `	DEVELOP_QUOTIENT_BITS(incr($1), `eval(2*$2+1)')')
+L.$1.eval(TWOSUPN+$2):
+	! remainder is negative
+	addcc	R,V,R
+	ifelse($1, N,
+	`	b	9f
+		add	Q, ($2*2-1), Q
+	', `	DEVELOP_QUOTIENT_BITS(incr($1), `eval(2*$2-1)')')
+	ifelse($1, 1, `9:')')
+
+#include <machine/asm.h>
+#include <machine/trap.h>
+
+FUNC(NAME)
+ifelse(S, `true',
+`	! compute sign of result; if neither is negative, no problem
+	orcc	divisor, dividend, %g0	! either negative?
+	bge	2f			! no, go do the divide
+	ifelse(OP, `div',
+		`xor	divisor, dividend, SIGN',
+		`mov	dividend, SIGN')	! compute sign in any case
+	tst	divisor
+	bge	1f
+	tst	dividend
+	! divisor is definitely negative; dividend might also be negative
+	bge	2f			! if dividend not negative...
+	neg	divisor			! in any case, make divisor nonneg
+1:	! dividend is negative, divisor is nonnegative
+	neg	dividend		! make dividend nonnegative
+2:
+')
+	! Ready to divide.  Compute size of quotient; scale comparand.
+	orcc	divisor, %g0, V
+	bnz	1f
+	mov	dividend, R
+
+		! Divide by zero trap.  If it returns, return 0 (about as
+		! wrong as possible, but that is what SunOS does...).
+		t	ST_DIV0
+		retl
+		clr	%o0
+
+1:
+	cmp	R, V			! if divisor exceeds dividend, done
+	blu	Lgot_result		! (and algorithm fails otherwise)
+	clr	Q
+	sethi	%hi(1 << (WORDSIZE - TOPBITS - 1)), T
+	cmp	R, T
+	blu	Lnot_really_big
+	clr	ITER
+
+	! `Here the dividend is >= 2^(31-N) or so.  We must be careful here,
+	! as our usual N-at-a-shot divide step will cause overflow and havoc.
+	! The number of bits in the result here is N*ITER+SC, where SC <= N.
+	! Compute ITER in an unorthodox manner: know we need to shift V into
+	! the top decade: so do not even bother to compare to R.'
+	1:
+		cmp	V, T
+		bgeu	3f
+		mov	1, SC
+		sll	V, N, V
+		b	1b
+		inc	ITER
+
+	! Now compute SC.
+	2:	addcc	V, V, V
+		bcc	Lnot_too_big
+		inc	SC
+
+		! We get here if the divisor overflowed while shifting.
+		! This means that R has the high-order bit set.
+		! Restore V and subtract from R.
+		sll	T, TOPBITS, T	! high order bit
+		srl	V, 1, V		! rest of V
+		add	V, T, V
+		b	Ldo_single_div
+		dec	SC
+
+	Lnot_too_big:
+	3:	cmp	V, R
+		blu	2b
+		nop
+		be	Ldo_single_div
+		nop
+	/* NB: these are commented out in the V8-Sparc manual as well */
+	/* (I do not understand this) */
+	! V > R: went too far: back up 1 step
+	!	srl	V, 1, V
+	!	dec	SC
+	! do single-bit divide steps
+	!
+	! We have to be careful here.  We know that R >= V, so we can do the
+	! first divide step without thinking.  BUT, the others are conditional,
+	! and are only done if R >= 0.  Because both R and V may have the high-
+	! order bit set in the first step, just falling into the regular
+	! division loop will mess up the first time around.
+	! So we unroll slightly...
+	Ldo_single_div:
+		deccc	SC
+		bl	Lend_regular_divide
+		nop
+		sub	R, V, R
+		mov	1, Q
+		b	Lend_single_divloop
+		nop
+	Lsingle_divloop:
+		sll	Q, 1, Q
+		bl	1f
+		srl	V, 1, V
+		! R >= 0
+		sub	R, V, R
+		b	2f
+		inc	Q
+	1:	! R < 0
+		add	R, V, R
+		dec	Q
+	2:
+	Lend_single_divloop:
+		deccc	SC
+		bge	Lsingle_divloop
+		tst	R
+		b,a	Lend_regular_divide
+
+Lnot_really_big:
+1:
+	sll	V, N, V
+	cmp	V, R
+	bleu	1b
+	inccc	ITER
+	be	Lgot_result
+	dec	ITER
+
+	tst	R	! set up for initial iteration
+Ldivloop:
+	sll	Q, N, Q
+	DEVELOP_QUOTIENT_BITS(1, 0)
+Lend_regular_divide:
+	deccc	ITER
+	bge	Ldivloop
+	tst	R
+	bl,a	Lgot_result
+	! non-restoring fixup here (one instruction only!)
+ifelse(OP, `div',
+`	dec	Q
+', `	add	R, divisor, R
+')
+
+Lgot_result:
+ifelse(S, `true',
+`	! check to see if answer should be < 0
+	tst	SIGN
+	bl,a	1f
+	ifelse(OP, `div', `neg Q', `neg R')
+1:')
+	retl
+	ifelse(OP, `div', `mov Q, %o0', `mov R, %o0')
diff --git a/usr/klibc/arch/sparc/pipe.S b/usr/klibc/arch/sparc/pipe.S
new file mode 100644
index 0000000..a8abf3c
--- /dev/null
+++ b/usr/klibc/arch/sparc/pipe.S
@@ -0,0 +1,30 @@
+/*
+ * arch/sparc/pipe.S
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
+	t	0x10
+	bcc	1f
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
diff --git a/usr/klibc/arch/sparc/setjmp.S b/usr/klibc/arch/sparc/setjmp.S
new file mode 100644
index 0000000..038ea78
--- /dev/null
+++ b/usr/klibc/arch/sparc/setjmp.S
@@ -0,0 +1,38 @@
+!
+! setjmp.S
+!
+! Basic setjmp/longjmp
+!
+! This code was based on the equivalent code in NetBSD
+!
+
+#include <machine/asm.h>
+#include <machine/trap.h>
+
+!
+! The jmp_buf contains the following entries:
+!   sp
+!   fp
+!   pc
+!
+ENTRY(setjmp)
+	st	%sp,[%o0+0]	! Callers stack pointer
+	st	%o7,[%o0+4]	! Return pc
+	st	%fp,[%o0+8]	! Frame pointer
+	retl			! Return
+	 clr	%o0		!  ...0
+
+ENTRY(longjmp)
+	sub	%sp, 64, %sp	! set up a local stack frame
+0:
+	t	ST_FLUSHWIN	! flush register windows out to memory
+	!
+	! We restore the saved stack pointer to %fp, then issue
+	! a restore instruction which will reload the register
+	! window from the stack.
+	!
+        ld      [%o0+4], %o7    /* restore return pc */
+        ld      [%o0+0], %fp    /* and stack pointer */
+
+        retl                    ! success, return %g6
+         restore        %o1, 0, %o0
diff --git a/usr/klibc/arch/sparc/smul.S b/usr/klibc/arch/sparc/smul.S
new file mode 100644
index 0000000..544ff6e
--- /dev/null
+++ b/usr/klibc/arch/sparc/smul.S
@@ -0,0 +1,160 @@
+/*	$NetBSD: mul.S,v 1.3 1997/07/16 14:37:42 christos Exp $	*/
+
+/*
+ * Copyright (c) 1992, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ *
+ * This software was developed by the Computer Systems Engineering group
+ * at Lawrence Berkeley Laboratory under DARPA contract BG 91-66 and
+ * contributed to Berkeley.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. All advertising materials mentioning features or use of this software
+ *    must display the following acknowledgement:
+ *	This product includes software developed by the University of
+ *	California, Berkeley and its contributors.
+ * 4. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ * from: Header: mul.s,v 1.5 92/06/25 13:24:03 torek Exp
+ */
+
+#include <machine/asm.h>
+#if defined(LIBC_SCCS) && !defined(lint)
+#if 0
+	.asciz "@(#)mul.s	8.1 (Berkeley) 6/4/93"
+#else
+	RCSID("$NetBSD: mul.S,v 1.3 1997/07/16 14:37:42 christos Exp $")
+#endif
+#endif /* LIBC_SCCS and not lint */
+
+/*
+ * Signed multiply, from Appendix E of the Sparc Version 8
+ * Architecture Manual.
+ *
+ * Returns %o0 * %o1 in %o1%o0 (i.e., %o1 holds the upper 32 bits of
+ * the 64-bit product).
+ *
+ * This code optimizes short (less than 13-bit) multiplies.
+ */
+
+FUNC(.mul)
+	mov	%o0, %y		! multiplier -> Y
+	andncc	%o0, 0xfff, %g0	! test bits 12..31
+	be	Lmul_shortway	! if zero, can do it the short way
+	andcc	%g0, %g0, %o4	! zero the partial product and clear N and V
+
+	/*
+	 * Long multiply.  32 steps, followed by a final shift step.
+	 */
+	mulscc	%o4, %o1, %o4	! 1
+	mulscc	%o4, %o1, %o4	! 2
+	mulscc	%o4, %o1, %o4	! 3
+	mulscc	%o4, %o1, %o4	! 4
+	mulscc	%o4, %o1, %o4	! 5
+	mulscc	%o4, %o1, %o4	! 6
+	mulscc	%o4, %o1, %o4	! 7
+	mulscc	%o4, %o1, %o4	! 8
+	mulscc	%o4, %o1, %o4	! 9
+	mulscc	%o4, %o1, %o4	! 10
+	mulscc	%o4, %o1, %o4	! 11
+	mulscc	%o4, %o1, %o4	! 12
+	mulscc	%o4, %o1, %o4	! 13
+	mulscc	%o4, %o1, %o4	! 14
+	mulscc	%o4, %o1, %o4	! 15
+	mulscc	%o4, %o1, %o4	! 16
+	mulscc	%o4, %o1, %o4	! 17
+	mulscc	%o4, %o1, %o4	! 18
+	mulscc	%o4, %o1, %o4	! 19
+	mulscc	%o4, %o1, %o4	! 20
+	mulscc	%o4, %o1, %o4	! 21
+	mulscc	%o4, %o1, %o4	! 22
+	mulscc	%o4, %o1, %o4	! 23
+	mulscc	%o4, %o1, %o4	! 24
+	mulscc	%o4, %o1, %o4	! 25
+	mulscc	%o4, %o1, %o4	! 26
+	mulscc	%o4, %o1, %o4	! 27
+	mulscc	%o4, %o1, %o4	! 28
+	mulscc	%o4, %o1, %o4	! 29
+	mulscc	%o4, %o1, %o4	! 30
+	mulscc	%o4, %o1, %o4	! 31
+	mulscc	%o4, %o1, %o4	! 32
+	mulscc	%o4, %g0, %o4	! final shift
+
+	! If %o0 was negative, the result is
+	!	(%o0 * %o1) + (%o1 << 32))
+	! We fix that here.
+
+	tst	%o0
+	bge	1f
+	rd	%y, %o0
+
+	! %o0 was indeed negative; fix upper 32 bits of result by subtracting
+	! %o1 (i.e., return %o4 - %o1 in %o1).
+	retl
+	sub	%o4, %o1, %o1
+
+1:
+	retl
+	mov	%o4, %o1
+
+Lmul_shortway:
+	/*
+	 * Short multiply.  12 steps, followed by a final shift step.
+	 * The resulting bits are off by 12 and (32-12) = 20 bit positions,
+	 * but there is no problem with %o0 being negative (unlike above).
+	 */
+	mulscc	%o4, %o1, %o4	! 1
+	mulscc	%o4, %o1, %o4	! 2
+	mulscc	%o4, %o1, %o4	! 3
+	mulscc	%o4, %o1, %o4	! 4
+	mulscc	%o4, %o1, %o4	! 5
+	mulscc	%o4, %o1, %o4	! 6
+	mulscc	%o4, %o1, %o4	! 7
+	mulscc	%o4, %o1, %o4	! 8
+	mulscc	%o4, %o1, %o4	! 9
+	mulscc	%o4, %o1, %o4	! 10
+	mulscc	%o4, %o1, %o4	! 11
+	mulscc	%o4, %o1, %o4	! 12
+	mulscc	%o4, %g0, %o4	! final shift
+
+	/*
+	 *  %o4 has 20 of the bits that should be in the low part of the
+	 * result; %y has the bottom 12 (as %y's top 12).  That is:
+	 *
+	 *	  %o4		    %y
+	 * +----------------+----------------+
+	 * | -12- |   -20-  | -12- |   -20-  |
+	 * +------(---------+------)---------+
+	 *  --hi-- ----low-part----
+	 *
+	 * The upper 12 bits of %o4 should be sign-extended to form the
+	 * high part of the product (i.e., highpart = %o4 >> 20).
+	 */
+
+	rd	%y, %o5
+	sll	%o4, 12, %o0	! shift middle bits left 12
+	srl	%o5, 20, %o5	! shift low bits right 20, zero fill at left
+	or	%o5, %o0, %o0	! construct low part of result
+	retl
+	sra	%o4, 20, %o1	! ... and extract high part of result
diff --git a/usr/klibc/arch/sparc/syscall.S b/usr/klibc/arch/sparc/syscall.S
new file mode 100644
index 0000000..c0273f7
--- /dev/null
+++ b/usr/klibc/arch/sparc/syscall.S
@@ -0,0 +1,19 @@
+/*
+ * arch/sparc/syscall.S
+ *
+ * Common system-call stub; %g1 already set to syscall number
+ */
+
+	.globl	__syscall_common
+	.type	__syscall_common,#function
+       	.align	4
+__syscall_common:
+	t	0x10
+	bcc	1f
+	  sethi	%hi(errno), %g4
+	or	%g4, %lo(errno), %g4
+	st	%o0,[%g4]
+	mov	-1, %o0
+1:
+       	retl
+	  nop
diff --git a/usr/klibc/arch/sparc/sysfork.S b/usr/klibc/arch/sparc/sysfork.S
new file mode 100644
index 0000000..a66c76e
--- /dev/null
+++ b/usr/klibc/arch/sparc/sysfork.S
@@ -0,0 +1,25 @@
+/*
+ * arch/sparc/sysfork.S
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
+	t	0x10
+	sub	%o1, 1, %o1
+	bcc,a	1f
+	  and	%o0, %o1, %o0
+	sethi	%hi(errno), %g4
+	or	%g4, %lo(errno), %g4
+	st	%o0,[%g4]
+	mov	-1, %o0
+1:
+       	retl
+	  nop
diff --git a/usr/klibc/arch/sparc/sysstub.ph b/usr/klibc/arch/sparc/sysstub.ph
new file mode 100644
index 0000000..d8cedb5
--- /dev/null
+++ b/usr/klibc/arch/sparc/sysstub.ph
@@ -0,0 +1,25 @@
+# -*- perl -*-
+#
+# arch/sparc32/sysstub.ph
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
diff --git a/usr/klibc/arch/sparc/umul.S b/usr/klibc/arch/sparc/umul.S
new file mode 100644
index 0000000..6a7193d
--- /dev/null
+++ b/usr/klibc/arch/sparc/umul.S
@@ -0,0 +1,193 @@
+/*	$NetBSD: umul.S,v 1.3 1997/07/16 14:37:44 christos Exp $	*/
+
+/*
+ * Copyright (c) 1992, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ *
+ * This software was developed by the Computer Systems Engineering group
+ * at Lawrence Berkeley Laboratory under DARPA contract BG 91-66 and
+ * contributed to Berkeley.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. All advertising materials mentioning features or use of this software
+ *    must display the following acknowledgement:
+ *	This product includes software developed by the University of
+ *	California, Berkeley and its contributors.
+ * 4. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ * from: Header: umul.s,v 1.4 92/06/25 13:24:05 torek Exp
+ */
+
+#include <machine/asm.h>
+#if defined(LIBC_SCCS) && !defined(lint)
+#if 0
+	.asciz "@(#)umul.s	8.1 (Berkeley) 6/4/93"
+#else
+	RCSID("$NetBSD: umul.S,v 1.3 1997/07/16 14:37:44 christos Exp $")
+#endif
+#endif /* LIBC_SCCS and not lint */
+
+/*
+ * Unsigned multiply.  Returns %o0 * %o1 in %o1%o0 (i.e., %o1 holds the
+ * upper 32 bits of the 64-bit product).
+ *
+ * This code optimizes short (less than 13-bit) multiplies.  Short
+ * multiplies require 25 instruction cycles, and long ones require
+ * 45 instruction cycles.
+ *
+ * On return, overflow has occurred (%o1 is not zero) if and only if
+ * the Z condition code is clear, allowing, e.g., the following:
+ *
+ *	call	.umul
+ *	nop
+ *	bnz	overflow	(or tnz)
+ */
+
+FUNC(.umul)
+	or	%o0, %o1, %o4
+	mov	%o0, %y		! multiplier -> Y
+	andncc	%o4, 0xfff, %g0	! test bits 12..31 of *both* args
+	be	Lmul_shortway	! if zero, can do it the short way
+	andcc	%g0, %g0, %o4	! zero the partial product and clear N and V
+
+	/*
+	 * Long multiply.  32 steps, followed by a final shift step.
+	 */
+	mulscc	%o4, %o1, %o4	! 1
+	mulscc	%o4, %o1, %o4	! 2
+	mulscc	%o4, %o1, %o4	! 3
+	mulscc	%o4, %o1, %o4	! 4
+	mulscc	%o4, %o1, %o4	! 5
+	mulscc	%o4, %o1, %o4	! 6
+	mulscc	%o4, %o1, %o4	! 7
+	mulscc	%o4, %o1, %o4	! 8
+	mulscc	%o4, %o1, %o4	! 9
+	mulscc	%o4, %o1, %o4	! 10
+	mulscc	%o4, %o1, %o4	! 11
+	mulscc	%o4, %o1, %o4	! 12
+	mulscc	%o4, %o1, %o4	! 13
+	mulscc	%o4, %o1, %o4	! 14
+	mulscc	%o4, %o1, %o4	! 15
+	mulscc	%o4, %o1, %o4	! 16
+	mulscc	%o4, %o1, %o4	! 17
+	mulscc	%o4, %o1, %o4	! 18
+	mulscc	%o4, %o1, %o4	! 19
+	mulscc	%o4, %o1, %o4	! 20
+	mulscc	%o4, %o1, %o4	! 21
+	mulscc	%o4, %o1, %o4	! 22
+	mulscc	%o4, %o1, %o4	! 23
+	mulscc	%o4, %o1, %o4	! 24
+	mulscc	%o4, %o1, %o4	! 25
+	mulscc	%o4, %o1, %o4	! 26
+	mulscc	%o4, %o1, %o4	! 27
+	mulscc	%o4, %o1, %o4	! 28
+	mulscc	%o4, %o1, %o4	! 29
+	mulscc	%o4, %o1, %o4	! 30
+	mulscc	%o4, %o1, %o4	! 31
+	mulscc	%o4, %o1, %o4	! 32
+	mulscc	%o4, %g0, %o4	! final shift
+
+
+	/*
+	 * Normally, with the shift-and-add approach, if both numbers are
+	 * positive you get the correct result.  WIth 32-bit two's-complement
+	 * numbers, -x is represented as
+	 *
+	 *		  x		    32
+	 *	( 2  -  ------ ) mod 2  *  2
+	 *		   32
+	 *		  2
+	 *
+	 * (the `mod 2' subtracts 1 from 1.bbbb).  To avoid lots of 2^32s,
+	 * we can treat this as if the radix point were just to the left
+	 * of the sign bit (multiply by 2^32), and get
+	 *
+	 *	-x  =  (2 - x) mod 2
+	 *
+	 * Then, ignoring the `mod 2's for convenience:
+	 *
+	 *   x *  y	= xy
+	 *  -x *  y	= 2y - xy
+	 *   x * -y	= 2x - xy
+	 *  -x * -y	= 4 - 2x - 2y + xy
+	 *
+	 * For signed multiplies, we subtract (x << 32) from the partial
+	 * product to fix this problem for negative multipliers (see mul.s).
+	 * Because of the way the shift into the partial product is calculated
+	 * (N xor V), this term is automatically removed for the multiplicand,
+	 * so we don't have to adjust.
+	 *
+	 * But for unsigned multiplies, the high order bit wasn't a sign bit,
+	 * and the correction is wrong.  So for unsigned multiplies where the
+	 * high order bit is one, we end up with xy - (y << 32).  To fix it
+	 * we add y << 32.
+	 */
+	tst	%o1
+	bl,a	1f		! if %o1 < 0 (high order bit = 1),
+	add	%o4, %o0, %o4	! %o4 += %o0 (add y to upper half)
+1:	rd	%y, %o0		! get lower half of product
+	retl
+	addcc	%o4, %g0, %o1	! put upper half in place and set Z for %o1==0
+
+Lmul_shortway:
+	/*
+	 * Short multiply.  12 steps, followed by a final shift step.
+	 * The resulting bits are off by 12 and (32-12) = 20 bit positions,
+	 * but there is no problem with %o0 being negative (unlike above),
+	 * and overflow is impossible (the answer is at most 24 bits long).
+	 */
+	mulscc	%o4, %o1, %o4	! 1
+	mulscc	%o4, %o1, %o4	! 2
+	mulscc	%o4, %o1, %o4	! 3
+	mulscc	%o4, %o1, %o4	! 4
+	mulscc	%o4, %o1, %o4	! 5
+	mulscc	%o4, %o1, %o4	! 6
+	mulscc	%o4, %o1, %o4	! 7
+	mulscc	%o4, %o1, %o4	! 8
+	mulscc	%o4, %o1, %o4	! 9
+	mulscc	%o4, %o1, %o4	! 10
+	mulscc	%o4, %o1, %o4	! 11
+	mulscc	%o4, %o1, %o4	! 12
+	mulscc	%o4, %g0, %o4	! final shift
+
+	/*
+	 * %o4 has 20 of the bits that should be in the result; %y has
+	 * the bottom 12 (as %y's top 12).  That is:
+	 *
+	 *	  %o4		    %y
+	 * +----------------+----------------+
+	 * | -12- |   -20-  | -12- |   -20-  |
+	 * +------(---------+------)---------+
+	 *	   -----result-----
+	 *
+	 * The 12 bits of %o4 left of the `result' area are all zero;
+	 * in fact, all top 20 bits of %o4 are zero.
+	 */
+
+	rd	%y, %o5
+	sll	%o4, 12, %o0	! shift middle bits left 12
+	srl	%o5, 20, %o5	! shift low bits right 20
+	or	%o5, %o0, %o0
+	retl
+	addcc	%g0, %g0, %o1	! %o1 = zero, and set Z
