Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVG0SnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVG0SnZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVG0SlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:41:14 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:29028 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261799AbVG0Sil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:38:41 -0400
Date: Wed, 27 Jul 2005 11:38:26 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: define-auxiliary-vector-size-at_vector_size.patch added to -mm tree
Message-ID: <20050727183826.GA23302@lucon.org>
References: <200507262144.j6QLiJVC015284@shell0.pdx.osdl.net> <20050727002608.GA7469@lucon.org> <20050726215323.0070c867.akpm@osdl.org> <20050727045901.GA11392@lucon.org> <20050726220637.215803f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20050726220637.215803f3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 26, 2005 at 10:06:37PM -0700, Andrew Morton wrote:
> "H. J. Lu" <hjl@lucon.org> wrote:
> >
> > On Tue, Jul 26, 2005 at 09:53:23PM -0700, Andrew Morton wrote:
> > > "H. J. Lu" <hjl@lucon.org> wrote:
> > > >
> > > > My patch breaks x86_64 build. This patch will fix x86_64 build. I am
> > > >  also enclosing the updated full patch.
> > > 
> > > It now breaks ppc64
> > > 
> > > include/asm/elf.h: In function `dump_task_regs':
> > > include/asm/elf.h:177: error: dereferencing pointer to incomplete type
> > > 
> > > That's because pt_regs isn't known, because sched.h is including elf.h
> > > before pt_regs gets defined.  This is a pretty fragile area I'm afraid.
> > 
> > Should we creat a new header file like auxvector.h? Auxiliary isn't
> > ELF specific anyway.
> 
> That would work.

How about this patch?


H.J.

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.12-auxv-2.patch"

--- linux/include/asm-alpha/auxvec.h.auxv	2005-07-27 11:34:19.226937310 -0700
+++ linux/include/asm-alpha/auxvec.h	2005-07-27 11:34:19.227937145 -0700
@@ -0,0 +1,24 @@
+#ifndef __ASM_ALPHA_AUXVEC_H
+#define __ASM_ALPHA_AUXVEC_H
+
+/* Reserve these numbers for any future use of a VDSO.  */
+#if 0
+#define AT_SYSINFO		32
+#define AT_SYSINFO_EHDR		33
+#endif
+
+/* More complete cache descriptions than AT_[DIU]CACHEBSIZE.  If the
+   value is -1, then the cache doesn't exist.  Otherwise:
+
+      bit 0-3:	  Cache set-associativity; 0 means fully associative.
+      bit 4-7:	  Log2 of cacheline size.
+      bit 8-31:	  Size of the entire cache >> 8.
+      bit 32-63:  Reserved.
+*/
+
+#define AT_L1I_CACHESHAPE	34
+#define AT_L1D_CACHESHAPE	35
+#define AT_L2_CACHESHAPE	36
+#define AT_L3_CACHESHAPE	37
+
+#endif /* __ASM_ALPHA_AUXVEC_H */
--- linux/include/asm-alpha/elf.h.auxv	2005-03-01 23:38:09.000000000 -0800
+++ linux/include/asm-alpha/elf.h	2005-07-27 11:34:19.227937145 -0700
@@ -1,6 +1,8 @@
 #ifndef __ASM_ALPHA_ELF_H
 #define __ASM_ALPHA_ELF_H
 
+#include <asm/auxvec.h>
+
 /* Special values for the st_other field in the symbol table.  */
 
 #define STO_ALPHA_NOPV		0x80
@@ -142,26 +144,6 @@ extern int dump_elf_task_fp(elf_fpreg_t 
 	: amask (AMASK_CIX) ? "ev6" : "ev67");	\
 })
 
-/* Reserve these numbers for any future use of a VDSO.  */
-#if 0
-#define AT_SYSINFO		32
-#define AT_SYSINFO_EHDR		33
-#endif
-
-/* More complete cache descriptions than AT_[DIU]CACHEBSIZE.  If the
-   value is -1, then the cache doesn't exist.  Otherwise:
-
-      bit 0-3:	  Cache set-associativity; 0 means fully associative.
-      bit 4-7:	  Log2 of cacheline size.
-      bit 8-31:	  Size of the entire cache >> 8.
-      bit 32-63:  Reserved.
-*/
-
-#define AT_L1I_CACHESHAPE	34
-#define AT_L1D_CACHESHAPE	35
-#define AT_L2_CACHESHAPE	36
-#define AT_L3_CACHESHAPE	37
-
 #ifdef __KERNEL__
 
 #define SET_PERSONALITY(EX, IBCS2)				\
--- linux/include/asm-arm/auxvec.h.auxv	2005-07-27 11:34:19.228936980 -0700
+++ linux/include/asm-arm/auxvec.h	2005-07-27 11:34:19.228936980 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMARM_AUXVEC_H
+#define __ASMARM_AUXVEC_H
+
+#endif
--- linux/include/asm-arm26/auxvec.h.auxv	2005-07-27 11:34:19.229936815 -0700
+++ linux/include/asm-arm26/auxvec.h	2005-07-27 11:34:19.229936815 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMARM_AUXVEC_H
+#define __ASMARM_AUXVEC_H
+
+#endif
--- linux/include/asm-cris/auxvec.h.auxv	2005-07-27 11:34:19.229936815 -0700
+++ linux/include/asm-cris/auxvec.h	2005-07-27 11:34:19.229936815 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMCRIS_AUXVEC_H
+#define __ASMCRIS_AUXVEC_H
+
+#endif
--- linux/include/asm-h8300/auxvec.h.auxv	2005-07-27 11:34:19.230936650 -0700
+++ linux/include/asm-h8300/auxvec.h	2005-07-27 11:34:19.230936650 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMH8300_AUXVEC_H
+#define __ASMH8300_AUXVEC_H
+
+#endif
--- linux/include/asm-i386/auxvec.h.auxv	2005-07-27 11:34:19.230936650 -0700
+++ linux/include/asm-i386/auxvec.h	2005-07-27 11:34:19.230936650 -0700
@@ -0,0 +1,11 @@
+#ifndef __ASMi386_AUXVEC_H
+#define __ASMi386_AUXVEC_H
+
+/*
+ * Architecture-neutral AT_ values in 0-17, leave some room
+ * for more of them, start the x86-specific ones at 32.
+ */
+#define AT_SYSINFO		32
+#define AT_SYSINFO_EHDR		33
+
+#endif
--- linux/include/asm-i386/elf.h.auxv	2005-03-01 23:38:13.000000000 -0800
+++ linux/include/asm-i386/elf.h	2005-07-27 11:36:26.558940660 -0700
@@ -9,6 +9,7 @@
 #include <asm/user.h>
 #include <asm/processor.h>
 #include <asm/system.h>		/* for savesegment */
+#include <asm/auxvec.h>
 
 #include <linux/utsname.h>
 
@@ -109,13 +110,6 @@ typedef struct user_fxsr_struct elf_fpxr
 
 #define ELF_PLATFORM  (system_utsname.machine)
 
-/*
- * Architecture-neutral AT_ values in 0-17, leave some room
- * for more of them, start the x86-specific ones at 32.
- */
-#define AT_SYSINFO		32
-#define AT_SYSINFO_EHDR		33
-
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) do { } while (0)
 
--- linux/include/asm-ia64/auxvec.h.auxv	2005-07-27 11:34:19.232936321 -0700
+++ linux/include/asm-ia64/auxvec.h	2005-07-27 11:34:19.232936321 -0700
@@ -0,0 +1,11 @@
+#ifndef _ASM_IA64_AUXVEC_H
+#define _ASM_IA64_AUXVEC_H
+
+/*
+ * Architecture-neutral AT_ values are in the range 0-17.  Leave some room for more of
+ * them, start the architecture-specific ones at 32.
+ */
+#define AT_SYSINFO	32
+#define AT_SYSINFO_EHDR	33
+
+#endif /* _ASM_IA64_AUXVEC_H */
--- linux/include/asm-ia64/elf.h.auxv	2005-03-01 23:38:13.000000000 -0800
+++ linux/include/asm-ia64/elf.h	2005-07-27 11:34:19.253932858 -0700
@@ -12,6 +12,7 @@
 
 #include <asm/fpu.h>
 #include <asm/page.h>
+#include <asm/auxvec.h>
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
@@ -177,13 +178,6 @@ extern void ia64_elf_core_copy_regs (str
    relevant until we have real hardware to play with... */
 #define ELF_PLATFORM	NULL
 
-/*
- * Architecture-neutral AT_ values are in the range 0-17.  Leave some room for more of
- * them, start the architecture-specific ones at 32.
- */
-#define AT_SYSINFO	32
-#define AT_SYSINFO_EHDR	33
-
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2)	set_personality(PER_LINUX)
 #define elf_read_implies_exec(ex, executable_stack)					\
--- linux/include/asm-m32r/auxvec.h.auxv	2005-07-27 11:34:19.253932858 -0700
+++ linux/include/asm-m32r/auxvec.h	2005-07-27 11:34:19.253932858 -0700
@@ -0,0 +1,4 @@
+#ifndef _ASM_M32R__AUXVEC_H
+#define _ASM_M32R__AUXVEC_H
+
+#endif  /* _ASM_M32R__AUXVEC_H */
--- linux/include/asm-m68k/auxvec.h.auxv	2005-07-27 11:34:19.254932694 -0700
+++ linux/include/asm-m68k/auxvec.h	2005-07-27 11:34:19.254932694 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMm68k_AUXVEC_H
+#define __ASMm68k_AUXVEC_H
+
+#endif
--- linux/include/asm-m68knommu/auxvec.h.auxv	2005-07-27 11:34:19.254932694 -0700
+++ linux/include/asm-m68knommu/auxvec.h	2005-07-27 11:34:19.255932529 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMm68k_AUXVEC_H
+#define __ASMm68k_AUXVEC_H
+
+#endif
--- linux/include/asm-mips/auxvec.h.auxv	2005-07-27 11:34:19.255932529 -0700
+++ linux/include/asm-mips/auxvec.h	2005-07-27 11:34:19.255932529 -0700
@@ -0,0 +1,4 @@
+#ifndef _ASM_AUXVEC_H
+#define _ASM_AUXVEC_H
+
+#endif /* _ASM_AUXVEC_H */
--- linux/include/asm-parisc/auxvec.h.auxv	2005-07-27 11:34:19.256932364 -0700
+++ linux/include/asm-parisc/auxvec.h	2005-07-27 11:34:19.256932364 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMPARISC_AUXVEC_H
+#define __ASMPARISC_AUXVEC_H
+
+#endif
--- linux/include/asm-ppc/auxvec.h.auxv	2005-07-27 11:34:19.256932364 -0700
+++ linux/include/asm-ppc/auxvec.h	2005-07-27 11:34:19.256932364 -0700
@@ -0,0 +1,14 @@
+#ifndef __PPC_AUXVEC_H
+#define __PPC_AUXVEC_H
+
+/*
+ * We need to put in some extra aux table entries to tell glibc what
+ * the cache block size is, so it can use the dcbz instruction safely.
+ */
+#define AT_DCACHEBSIZE		19
+#define AT_ICACHEBSIZE		20
+#define AT_UCACHEBSIZE		21
+/* A special ignored type value for PPC, for glibc compatibility.  */
+#define AT_IGNOREPPC		22
+
+#endif
--- linux/include/asm-ppc/elf.h.auxv	2005-03-01 23:37:30.000000000 -0800
+++ linux/include/asm-ppc/elf.h	2005-07-27 11:34:19.257932199 -0700
@@ -7,6 +7,7 @@
 #include <asm/types.h>
 #include <asm/ptrace.h>
 #include <asm/cputable.h>
+#include <asm/auxvec.h>
 
 /* PowerPC relocations defined by the ABIs */
 #define R_PPC_NONE		0
@@ -122,16 +123,6 @@ extern int dump_task_fpu(struct task_str
 
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
 
-/*
- * We need to put in some extra aux table entries to tell glibc what
- * the cache block size is, so it can use the dcbz instruction safely.
- */
-#define AT_DCACHEBSIZE		19
-#define AT_ICACHEBSIZE		20
-#define AT_UCACHEBSIZE		21
-/* A special ignored type value for PPC, for glibc compatibility.  */
-#define AT_IGNOREPPC		22
-
 extern int dcache_bsize;
 extern int icache_bsize;
 extern int ucache_bsize;
--- linux/include/asm-ppc64/auxvec.h.auxv	2005-07-27 11:34:19.258932034 -0700
+++ linux/include/asm-ppc64/auxvec.h	2005-07-27 11:35:54.618207638 -0700
@@ -0,0 +1,19 @@
+#ifndef __PPC64_AUXVEC_H
+#define __PPC64_AUXVEC_H
+
+/*
+ * We need to put in some extra aux table entries to tell glibc what
+ * the cache block size is, so it can use the dcbz instruction safely.
+ */
+#define AT_DCACHEBSIZE		19
+#define AT_ICACHEBSIZE		20
+#define AT_UCACHEBSIZE		21
+/* A special ignored type value for PPC, for glibc compatibility.  */
+#define AT_IGNOREPPC		22
+
+/* The vDSO location. We have to use the same value as x86 for glibc's
+ * sake :-)
+ */
+#define AT_SYSINFO_EHDR		33
+
+#endif /* __PPC64_AUXVEC_H */
--- linux/include/asm-ppc64/elf.h.auxv	2005-07-08 11:50:09.000000000 -0700
+++ linux/include/asm-ppc64/elf.h	2005-07-27 11:35:08.815760333 -0700
@@ -4,6 +4,7 @@
 #include <asm/types.h>
 #include <asm/ptrace.h>
 #include <asm/cputable.h>
+#include <asm/auxvec.h>
 
 /* PowerPC relocations defined by the ABIs */
 #define R_PPC_NONE		0
@@ -237,21 +238,6 @@ do {								\
 
 #endif
 
-/*
- * We need to put in some extra aux table entries to tell glibc what
- * the cache block size is, so it can use the dcbz instruction safely.
- */
-#define AT_DCACHEBSIZE		19
-#define AT_ICACHEBSIZE		20
-#define AT_UCACHEBSIZE		21
-/* A special ignored type value for PPC, for glibc compatibility.  */
-#define AT_IGNOREPPC		22
-
-/* The vDSO location. We have to use the same value as x86 for glibc's
- * sake :-)
- */
-#define AT_SYSINFO_EHDR		33
-
 extern int dcache_bsize;
 extern int icache_bsize;
 extern int ucache_bsize;
--- linux/include/asm-s390/auxvec.h.auxv	2005-07-27 11:34:19.259931869 -0700
+++ linux/include/asm-s390/auxvec.h	2005-07-27 11:34:19.259931869 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMS390_AUXVEC_H
+#define __ASMS390_AUXVEC_H
+
+#endif
--- linux/include/asm-sh/auxvec.h.auxv	2005-07-27 11:34:19.260931704 -0700
+++ linux/include/asm-sh/auxvec.h	2005-07-27 11:34:19.260931704 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASM_SH_AUXVEC_H
+#define __ASM_SH_AUXVEC_H
+
+#endif /* __ASM_SH_AUXVEC_H */
--- linux/include/asm-sh64/auxvec.h.auxv	2005-07-27 11:34:19.260931704 -0700
+++ linux/include/asm-sh64/auxvec.h	2005-07-27 11:34:19.260931704 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASM_SH64_AUXVEC_H
+#define __ASM_SH64_AUXVEC_H
+
+#endif /* __ASM_SH64_AUXVEC_H */
--- linux/include/asm-sparc/auxvec.h.auxv	2005-07-27 11:34:19.261931540 -0700
+++ linux/include/asm-sparc/auxvec.h	2005-07-27 11:34:19.261931540 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMSPARC_AUXVEC_H
+#define __ASMSPARC_AUXVEC_H
+
+#endif /* !(__ASMSPARC_AUXVEC_H) */
--- linux/include/asm-sparc64/auxvec.h.auxv	2005-07-27 11:34:19.262931375 -0700
+++ linux/include/asm-sparc64/auxvec.h	2005-07-27 11:34:19.262931375 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASM_SPARC64_AUXVEC_H
+#define __ASM_SPARC64_AUXVEC_H
+
+#endif /* !(__ASM_SPARC64_AUXVEC_H) */
--- linux/include/asm-um/auxvec.h.auxv	2005-07-27 11:34:19.262931375 -0700
+++ linux/include/asm-um/auxvec.h	2005-07-27 11:34:19.262931375 -0700
@@ -0,0 +1,4 @@
+#ifndef __UM_AUXVEC_H
+#define __UM_AUXVEC_H
+
+#endif
--- linux/include/asm-v850/auxvec.h.auxv	2005-07-27 11:34:19.263931210 -0700
+++ linux/include/asm-v850/auxvec.h	2005-07-27 11:34:19.263931210 -0700
@@ -0,0 +1,4 @@
+#ifndef __V850_AUXVEC_H__
+#define __V850_AUXVEC_H__
+
+#endif /* __V850_AUXVEC_H__ */
--- linux/include/asm-x86_64/auxvec.h.auxv	2005-07-27 11:34:19.263931210 -0700
+++ linux/include/asm-x86_64/auxvec.h	2005-07-27 11:34:19.263931210 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASM_X86_64_AUXVEC_H
+#define __ASM_X86_64_AUXVEC_H
+
+#endif
--- linux/include/linux/auxvec.h.auxv	2005-07-27 11:34:19.265930880 -0700
+++ linux/include/linux/auxvec.h	2005-07-27 11:34:19.265930880 -0700
@@ -0,0 +1,31 @@
+#ifndef _LINUX_AUXVEC_H
+#define _LINUX_AUXVEC_H
+
+#include <asm/auxvec.h>
+
+/* Symbolic values for the entries in the auxiliary table
+   put on the initial stack */
+#define AT_NULL   0	/* end of vector */
+#define AT_IGNORE 1	/* entry should be ignored */
+#define AT_EXECFD 2	/* file descriptor of program */
+#define AT_PHDR   3	/* program headers for program */
+#define AT_PHENT  4	/* size of program header entry */
+#define AT_PHNUM  5	/* number of program headers */
+#define AT_PAGESZ 6	/* system page size */
+#define AT_BASE   7	/* base address of interpreter */
+#define AT_FLAGS  8	/* flags */
+#define AT_ENTRY  9	/* entry point of program */
+#define AT_NOTELF 10	/* program is not ELF */
+#define AT_UID    11	/* real uid */
+#define AT_EUID   12	/* effective uid */
+#define AT_GID    13	/* real gid */
+#define AT_EGID   14	/* effective gid */
+#define AT_PLATFORM 15  /* string identifying CPU for optimizations */
+#define AT_HWCAP  16    /* arch dependent hints at CPU capabilities */
+#define AT_CLKTCK 17	/* frequency at which times() increments */
+
+#define AT_SECURE 23   /* secure mode boolean */
+
+#define AT_VECTOR_SIZE  42 /* Size of auxiliary table.  */
+
+#endif /* _LINUX_AUXVEC_H */
--- linux/include/linux/elf.h.auxv	2005-03-01 23:37:49.000000000 -0800
+++ linux/include/linux/elf.h	2005-07-27 11:34:19.266930715 -0700
@@ -2,6 +2,7 @@
 #define _LINUX_ELF_H
 
 #include <linux/types.h>
+#include <linux/auxvec.h>
 #include <asm/elf.h>
 
 #ifndef elf_read_implies_exec
@@ -158,29 +159,6 @@ typedef __s64	Elf64_Sxword;
 #define ELF64_ST_BIND(x)	ELF_ST_BIND(x)
 #define ELF64_ST_TYPE(x)	ELF_ST_TYPE(x)
 
-/* Symbolic values for the entries in the auxiliary table
-   put on the initial stack */
-#define AT_NULL   0	/* end of vector */
-#define AT_IGNORE 1	/* entry should be ignored */
-#define AT_EXECFD 2	/* file descriptor of program */
-#define AT_PHDR   3	/* program headers for program */
-#define AT_PHENT  4	/* size of program header entry */
-#define AT_PHNUM  5	/* number of program headers */
-#define AT_PAGESZ 6	/* system page size */
-#define AT_BASE   7	/* base address of interpreter */
-#define AT_FLAGS  8	/* flags */
-#define AT_ENTRY  9	/* entry point of program */
-#define AT_NOTELF 10	/* program is not ELF */
-#define AT_UID    11	/* real uid */
-#define AT_EUID   12	/* effective uid */
-#define AT_GID    13	/* real gid */
-#define AT_EGID   14	/* effective gid */
-#define AT_PLATFORM 15  /* string identifying CPU for optimizations */
-#define AT_HWCAP  16    /* arch dependent hints at CPU capabilities */
-#define AT_CLKTCK 17	/* frequency at which times() increments */
-
-#define AT_SECURE 23   /* secure mode boolean */
-
 typedef struct dynamic{
   Elf32_Sword d_tag;
   union{
--- linux/include/linux/sched.h.auxv	2005-07-08 11:50:09.000000000 -0700
+++ linux/include/linux/sched.h	2005-07-27 11:34:19.269930221 -0700
@@ -35,6 +35,8 @@
 #include <linux/topology.h>
 #include <linux/seccomp.h>
 
+#include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
+
 struct exec_domain;
 
 /*
@@ -243,7 +245,7 @@ struct mm_struct {
 	mm_counter_t _rss;
 	mm_counter_t _anon_rss;
 
-	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
+	unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
 	unsigned dumpable:1;
 	cpumask_t cpu_vm_mask;

--lrZ03NoBR/3+SXJZ--
