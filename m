Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273476AbRIQTQI>; Mon, 17 Sep 2001 15:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273567AbRIQTQB>; Mon, 17 Sep 2001 15:16:01 -0400
Received: from ns.caldera.de ([212.34.180.1]:26543 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S273476AbRIQTPq>;
	Mon, 17 Sep 2001 15:15:46 -0400
Date: Mon, 17 Sep 2001 21:16:04 +0200
From: Christoph Hellwig <hch@caldera.de>
To: linux-kernel@vger.kernel.org, jj@redhat.com
Subject: [PATCH][RFC] setting personality in binfmt_elf
Message-ID: <20010917211603.A21048@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	linux-kernel@vger.kernel.org, jj@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the appended patch changes the way the personality is set in binfmt_elf
using the ELF header.

Currently we check for one of the obviously SysVish interpreter names and
then set a variable ibcs_interpreter (which btw is completly misnamed as
iBCS2 mandates COFF) that can be used by the arch code to set the personality.

Addiditonally binfmt_elf set's the personality even before changing to
find the interpreter in the emulation prefix if and only IF we are on sparc.
Then it sets it back for some setup work and again to the non-native
personality (if needed).

The attached patch changes this in two ways:

 1) the arch code gets the ELF header and the intepreter name to do
    the check itself
 2) we always set the personality early to use the emulation prefix

The patch works fine in Linux-ABI CVS for over half an year, and unless
someone disagrees with that changes NOW I will send it to Linus this
week.

Jakub, I assume you wrote the inital sparc hack, that's why I'd like to
hear feedback especially from you.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

diff -uNr -Xdontdiff linux-2.4.10-pre8/fs/binfmt_elf.c linux/fs/binfmt_elf.c
--- linux-2.4.10-pre8/fs/binfmt_elf.c	Thu Sep 13 20:57:32 2001
+++ linux/fs/binfmt_elf.c	Thu Sep 13 22:04:52 2001
@@ -400,7 +400,6 @@
 	int load_addr_set = 0;
 	char * elf_interpreter = NULL;
 	unsigned int interpreter_type = INTERPRETER_NONE;
-	unsigned char ibcs2_interpreter = 0;
 	mm_segment_t old_fs;
 	unsigned long error;
 	struct elf_phdr * elf_ppnt, *elf_phdata;
@@ -480,40 +479,18 @@
 					   elf_ppnt->p_filesz);
 			if (retval < 0)
 				goto out_free_interp;
-			/* If the program interpreter is one of these two,
-			 * then assume an iBCS2 image. Otherwise assume
-			 * a native linux image.
+
+			/*
+			 * Change our personality, if needed.
 			 */
-			if (strcmp(elf_interpreter,"/usr/lib/libc.so.1") == 0 ||
-			    strcmp(elf_interpreter,"/usr/lib/ld.so.1") == 0)
-				ibcs2_interpreter = 1;
+			SET_ELF_PERSONALITY(elf_ex, elf_interpreter);
+
 #if 0
 			printk("Using ELF interpreter %s\n", elf_interpreter);
 #endif
-#ifdef __sparc__
-			if (ibcs2_interpreter) {
-				unsigned long old_pers = current->personality;
-				struct exec_domain *old_domain = current->exec_domain;
-				struct exec_domain *new_domain;
-				struct fs_struct *old_fs = current->fs, *new_fs;
-				get_exec_domain(old_domain);
-				atomic_inc(&old_fs->count);
-
-				set_personality(PER_SVR4);
-				interpreter = open_exec(elf_interpreter);
-
-				new_domain = current->exec_domain;
-				new_fs = current->fs;
-				current->personality = old_pers;
-				current->exec_domain = old_domain;
-				current->fs = old_fs;
-				put_exec_domain(new_domain);
-				put_fs_struct(new_fs);
-			} else
-#endif
-			{
-				interpreter = open_exec(elf_interpreter);
-			}
+		
+			interpreter = open_exec(elf_interpreter);
+
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter))
 				goto out_free_interp;
@@ -585,10 +562,6 @@
 	current->flags &= ~PF_FORKNOEXEC;
 	elf_entry = (unsigned long) elf_ex.e_entry;
 
-	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
-	   may depend on the personality.  */
-	SET_PERSONALITY(elf_ex, ibcs2_interpreter);
-
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
 	current->mm->rss = 0;
@@ -727,8 +700,7 @@
 	printk("(brk) %lx\n" , (long) current->mm->brk);
 #endif
 
-	if ( current->personality == PER_SVR4 )
-	{
+	if (current->personality & MMAP_PAGE_ZERO) {
 		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
 		   and some applications "depend" upon this behavior.
 		   Since we do not have the power to recompile these, we
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-alpha/elf.h linux/include/asm-alpha/elf.h
--- linux-2.4.10-pre8/include/asm-alpha/elf.h	Sat Jun  2 14:17:46 2001
+++ linux/include/asm-alpha/elf.h	Thu Sep 13 22:04:52 2001
@@ -126,9 +126,22 @@
 })
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(EX, IBCS2)				\
-	set_personality(((EX).e_flags & EF_ALPHA_32BIT)		\
-	   ? PER_LINUX_32BIT : (IBCS2) ? PER_SVR4 : PER_LINUX)
-#endif
 
-#endif
+#define SET_ELF_PERSONALITY(ex,interp)					\
+do {									\
+	unsigned long			personality = PER_LINUX;	\
+									\
+	/* If the header identifies the binary, use that information */	\
+	if ((ex).e_flags & EF_ALPHA_32BIT)				\
+		personality = PER_LINUX_32BIT;				\
+									\
+	/* Else check the interpreter for SVR4isms */			\
+	else if (strcmp((interp), "/usr/lib/libc.so.1") == 0 ||		\
+		 strcmp((interp), "/usr/lib/ld.so.1") == 0)		\
+		personality = PER_SVR4;					\
+									\
+	set_personality(personality);					\
+} while (0)
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_ALPHA_ELF_H */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-arm/proc-armo/elf.h linux/include/asm-arm/proc-armo/elf.h
--- linux-2.4.10-pre8/include/asm-arm/proc-armo/elf.h	Thu Apr 13 17:11:49 2000
+++ linux/include/asm-arm/proc-armo/elf.h	Thu Sep 13 22:04:52 2001
@@ -10,6 +10,6 @@
 #define ELF_PROC_OK(x)		\
 	((x)->e_flags & EF_ARM_APCS26)
 
-#define SET_PERSONALITY(ex,ibcs2) set_personality(PER_LINUX)
+#define SET_ELF_PERSONALITY(ex,interp)	set_personality(PER_LINUX)
 
 #endif
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-arm/proc-armv/elf.h linux/include/asm-arm/proc-armv/elf.h
--- linux-2.4.10-pre8/include/asm-arm/proc-armv/elf.h	Sun Aug 13 18:54:15 2000
+++ linux/include/asm-arm/proc-armv/elf.h	Thu Sep 13 22:04:52 2001
@@ -16,7 +16,14 @@
    enough not to care, don't trust the `ibcs' flag here.  In any case
    there is no other ELF system currently supported by iBCS.
    @@ Could print a warning message to encourage users to upgrade.  */
-#define SET_PERSONALITY(ex,ibcs2) \
-	set_personality(((ex).e_flags&EF_ARM_APCS26 ?PER_LINUX :PER_LINUX_32BIT))
+#define SET_ELF_PERSONALITY(ex,interp)					\
+do {									\
+	unsigned long			personality = PER_LINUX_32BIT;	\
+									\
+	/* If the header identifies the binary, use that information */	\
+	if ((ex).e_flags & EF_ARM_APCS26)				\
+		personality = PER_LINUX;				\
+	set_personality(personality);					\
+} while (0)
 
 #endif
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-cris/elf.h linux/include/asm-cris/elf.h
--- linux-2.4.10-pre8/include/asm-cris/elf.h	Sat Jun  2 14:29:39 2001
+++ linux/include/asm-cris/elf.h	Thu Sep 13 22:04:52 2001
@@ -69,7 +69,6 @@
 #define ELF_PLATFORM  (NULL)
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
-#endif
-
-#endif
+#define SET_ELF_PERSONALITY(ex,interp)	set_personality(PER_LINUX)
+#endif /* __KERNEL__ */
+#endif /* __ASMCRIS_ELF_H */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-i386/elf.h linux/include/asm-i386/elf.h
--- linux-2.4.10-pre8/include/asm-i386/elf.h	Wed Jul  4 18:45:07 2001
+++ linux/include/asm-i386/elf.h	Thu Sep 13 22:16:31 2001
@@ -10,6 +10,12 @@
 
 #include <linux/utsname.h>
 
+/*
+ * Definitions for detection of foreign ELF binaries.
+ */
+#include <asm/elfmark.h>
+
+
 typedef unsigned long elf_greg_t;
 
 #define ELF_NGREG (sizeof (struct user_regs_struct) / sizeof(elf_greg_t))
@@ -98,7 +104,23 @@
 #define ELF_PLATFORM  (system_utsname.machine)
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
-#endif
+#define SET_ELF_PERSONALITY(ex,interp)					\
+do {									\
+	unsigned long		personality = abi_defhandler_elf;	\
+									\
+	/* If the header identifies the binary, use that information */	\
+	if ((ex).e_flags == EF_386_UW7)					\
+		personality = PER_UW7;					\
+	else if ((ex).e_flags == EF_386_OSR5)				\
+		personality = PER_OSR5;					\
+									\
+	/* Else check the interpreter for SVR4isms */			\
+	else if (strcmp((interp), "/usr/lib/libc.so.1") == 0 ||		\
+		 strcmp((interp), "/usr/lib/ld.so.1") == 0)		\
+		personality = abi_defhandler_libcso;			\
+									\
+	set_personality(personality);					\
+} while (0)
 
-#endif
+#endif /* __KERNEL__ */
+#endif /* __ASMi386_ELF_H */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-i386/elfmark.h linux/include/asm-i386/elfmark.h
--- linux-2.4.10-pre8/include/asm-i386/elfmark.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-i386/elfmark.h	Thu Sep 13 22:04:52 2001
@@ -0,0 +1,38 @@
+/*	$Id: elfmark.h,v 1.1 2001/04/29 10:15:23 hch Exp $	*/
+/*
+ * elfmark - set ELF header e_flags value to an abi-specific value.
+ *
+ * This utility is used for marking ELF binaries (including shared libraries)
+ * for use by the UW Linux kernel module that provides exec domain for PER_UW7 
+ * personality. Run only on IA32 architectures.
+ *
+ * Authors - Tigran Aivazian <tigran@veritas.com>,
+ *		Christoph Hellwig <hch@caldera.de>
+ *
+ * This software is under GPL
+ */
+#ifndef _ELFMARK_H
+#define _ELFMARK_H
+
+/*
+ * The e_flags value for SCO UnixWare 7/UDK binaries
+ */
+#ifndef EF_386_UW7
+#define EF_386_UW7	0x314B4455
+#endif
+
+/*
+ * The e_flags value for SCO OpenServer 5 binaries.
+ */
+#ifndef EF_386_OSR5
+#define EF_386_OSR5	0x3552534f
+#endif
+
+/*
+ * e_flags value with no special meaning.
+ */
+#ifndef EF_386_NONE
+#define EF_386_NONE	0
+#endif
+
+#endif /* _ELFMARK_H */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-ia64/elf.h linux/include/asm-ia64/elf.h
--- linux-2.4.10-pre8/include/asm-ia64/elf.h	Wed Jul 12 00:43:45 2000
+++ linux/include/asm-ia64/elf.h	Thu Sep 13 22:04:52 2001
@@ -82,7 +82,18 @@
 #define ELF_PLATFORM	0
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
-#endif
 
+#define SET_ELF_PERSONALITY(ex,interp)					\
+do {									\
+	unsigned long			personality = PER_LINUX;	\
+									\
+	/* Check the interpreter for SVR4isms */			\
+	if (strcmp((interp), "/usr/lib/libc.so.1") == 0 ||		\
+	    strcmp((interp), "/usr/lib/ld.so.1") == 0)		\
+		personality = PER_SVR4;					\
+									\
+	set_personality(personality);					\
+} while (0)
+
+#endif /* __KERNEL__ */
 #endif /* _ASM_IA64_ELF_H */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-m68k/elf.h linux/include/asm-m68k/elf.h
--- linux-2.4.10-pre8/include/asm-m68k/elf.h	Wed Jul 12 00:43:45 2000
+++ linux/include/asm-m68k/elf.h	Thu Sep 13 22:04:52 2001
@@ -89,7 +89,17 @@
 #define ELF_PLATFORM  (NULL)
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
-#endif
+#define SET_ELF_PERSONALITY(ex,interp)					\
+do {									\
+	unsigned long			personality = PER_LINUX;	\
+									\
+	/* Check the interpreter for SVR4isms */			\
+	if (strcmp((interp), "/usr/lib/libc.so.1") == 0 ||		\
+	    strcmp((interp), "/usr/lib/ld.so.1") == 0)		\
+		personality = PER_SVR4;					\
+									\
+	set_personality(personality);					\
+} while (0)
 
-#endif
+#endif /* __KERNEL__ */
+#endif /* __ASMm68k_ELF_H */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-mips/elf.h linux/include/asm-mips/elf.h
--- linux-2.4.10-pre8/include/asm-mips/elf.h	Thu Sep 13 20:57:33 2001
+++ linux/include/asm-mips/elf.h	Thu Sep 13 22:04:52 2001
@@ -92,7 +92,15 @@
 #define ELF_ET_DYN_BASE         (TASK_SIZE / 3 * 2)
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
-#endif
-
+#define SET_ELF_PERSONALITY(ex,interp)					\
+do {									\
+	/* IRIX binaries are handled elsewhere. */			\
+	if (strcmp((interp), "/usr/lib/ld.so.1") == 0)			\
+		retval = -ENOEXEC;					\
+		goto out_free_interp;					\
+									\
+	set_personality(PER_LINUX);					\
+} while (0)
+ 
+#endif /* __KERNEL__ */
 #endif /* __ASM_ELF_H */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-mips64/elf.h linux/include/asm-mips64/elf.h
--- linux-2.4.10-pre8/include/asm-mips64/elf.h	Thu Sep 13 20:57:33 2001
+++ linux/include/asm-mips64/elf.h	Thu Sep 13 22:04:52 2001
@@ -96,17 +96,21 @@
 #define ELF_ET_DYN_BASE         (TASK_SIZE / 3 * 2)
 #endif
 
-#ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2)			\
-do {	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)	\
-		current->thread.mflags |= MF_32BIT;	\
-	else						\
-		current->thread.mflags &= ~MF_32BIT;	\
-	if (ibcs2)					\
-		set_personality(PER_SVR4);		\
-	else if (current->personality != PER_LINUX32)	\
-		set_personality(PER_LINUX);		\
+#define SET_ELF_PERSONALITY(ex,interp)					\
+do {									\
+	/* First do some adjustments for 32bit binary compatiblity */	\
+	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)			\
+		current->thread.mflags |= MF_32BIT;			\
+	else								\
+		current->thread.mflags &= ~MF_32BIT;			\
+									\
+	/* Check the interpreter for SVR4isms */			\
+	if (strcmp((interp), "/usr/lib/libc.so.1") == 0 ||		\
+		 strcmp((interp), "/usr/lib/ld.so.1") == 0)		\
+		set_personality(PER_SVR4);				\
+	else if (current->personality != PER_LINUX32)			\
+		set_personality(PER_LINUX);				\
 } while (0)
-#endif
 
+#endif /* __KERNEL__ */
 #endif /* _ASM_ELF_H */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-parisc/elf.h linux/include/asm-parisc/elf.h
--- linux-2.4.10-pre8/include/asm-parisc/elf.h	Sat Jun  2 14:18:50 2001
+++ linux/include/asm-parisc/elf.h	Thu Sep 13 22:04:52 2001
@@ -90,8 +90,8 @@
 #define ELF_PLATFORM  ("PARISC\0" /*+((boot_cpu_data.x86-3)*5) */)
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) \
-	current->personality = PER_LINUX
-#endif
 
-#endif
+#define SET_ELF_PERSONALITY(ex,interp)	set_personality(PER_LINUX)
+
+#endif /* __KERNEL__ */
+#endif /* __ASMPARISC_ELF_H */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-ppc/elf.h linux/include/asm-ppc/elf.h
--- linux-2.4.10-pre8/include/asm-ppc/elf.h	Thu Sep 13 20:57:34 2001
+++ linux/include/asm-ppc/elf.h	Thu Sep 13 22:04:52 2001
@@ -73,8 +73,6 @@
 
 #define ELF_PLATFORM	(NULL)
 
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
-
 /*
  * We need to put in some extra aux table entries to tell glibc what
  * the cache block size is, so it can use the dcbz instruction safely.
@@ -113,5 +111,7 @@
 	NEW_AUX_ENT(1, AT_IGNOREPPC, AT_IGNOREPPC);			\
  } while (0)
 
+#define SET_ELF_PERSONALITY(ex,interp)	set_personality(PER_LINUX)
+
 #endif /* __KERNEL__ */
-#endif
+#endif /* __PPC_ELF_H */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-s390/elf.h linux/include/asm-s390/elf.h
--- linux-2.4.10-pre8/include/asm-s390/elf.h	Sat Jun  2 14:29:04 2001
+++ linux/include/asm-s390/elf.h	Thu Sep 13 22:04:52 2001
@@ -76,7 +76,8 @@
 #define ELF_PLATFORM (NULL)
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
-#endif
 
-#endif
+#define SET_ELF_PERSONALITY(ex,interp)	set_personality(PER_LINUX)
+
+#endif /* __KERNEL__ */
+#endif /* __ASMS390_ELF_H */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-s390x/elf.h linux/include/asm-s390x/elf.h
--- linux-2.4.10-pre8/include/asm-s390x/elf.h	Sat Jun  2 14:29:04 2001
+++ linux/include/asm-s390x/elf.h	Thu Sep 13 22:04:52 2001
@@ -77,7 +77,8 @@
 #define ELF_PLATFORM (NULL)
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
-#endif
 
-#endif
+#define SET_ELF_PERSONALITY(ex,interp)	set_personality(PER_LINUX)
+
+#endif /* __KERNEL__ */
+#endif /* __ASMS390_ELF_H */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-sh/elf.h linux/include/asm-sh/elf.h
--- linux-2.4.10-pre8/include/asm-sh/elf.h	Thu Sep 13 20:57:34 2001
+++ linux/include/asm-sh/elf.h	Thu Sep 13 22:04:52 2001
@@ -69,7 +69,8 @@
        _r->sr = SR_FD; } while (0)
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality(PER_LINUX_32BIT)
-#endif
 
+#define SET_ELF_PERSONALITY(ex,interp)	set_personality(PER_LINUX_32BIT)
+
+#endif /* __KERNEL__ */
 #endif /* __ASM_SH_ELF_H */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-sparc/elf.h linux/include/asm-sparc/elf.h
--- linux-2.4.10-pre8/include/asm-sparc/elf.h	Wed Jul 12 04:02:37 2000
+++ linux/include/asm-sparc/elf.h	Thu Sep 13 22:04:52 2001
@@ -105,7 +105,18 @@
 #define ELF_PLATFORM	(NULL)
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
-#endif
 
+#define SET_ELF_PERSONALITY(ex,interp)					\
+do {									\
+	unsigned long			personality = PER_LINUX;	\
+									\
+	/* Check the interpreter for SVR4isms */			\
+	if (strcmp((interp), "/usr/lib/libc.so.1") == 0 ||		\
+		 strcmp((interp), "/usr/lib/ld.so.1") == 0)		\
+		personality = PER_SVR4;					\
+									\
+	set_personality(personality);					\
+} while (0)
+
+#endif /* __KERNEL__ */
 #endif /* !(__ASMSPARC_ELF_H) */
diff -uNr -Xdontdiff linux-2.4.10-pre8/include/asm-sparc64/elf.h linux/include/asm-sparc64/elf.h
--- linux-2.4.10-pre8/include/asm-sparc64/elf.h	Thu Sep 13 20:57:34 2001
+++ linux/include/asm-sparc64/elf.h	Thu Sep 13 22:04:52 2001
@@ -68,39 +68,51 @@
 #define ELF_PLATFORM	(NULL)
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2)			\
-do {	unsigned char flags = current->thread.flags;	\
-	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)	\
-		flags |= SPARC_FLAG_32BIT;		\
-	else						\
-		flags &= ~SPARC_FLAG_32BIT;		\
-	if (flags != current->thread.flags) {		\
-		unsigned long pgd_cache = 0UL;		\
-		if (flags & SPARC_FLAG_32BIT) {		\
-		  pgd_t *pgd0 = &current->mm->pgd[0];	\
-		  if (pgd_none (*pgd0)) {		\
-		    pmd_t *page = pmd_alloc_one_fast(NULL, 0);	\
-		    if (!page)				\
-		      page = pmd_alloc_one(NULL, 0);	\
-                    pgd_set(pgd0, page);		\
-		  }					\
-		  pgd_cache = pgd_val(*pgd0) << 11UL;	\
-		}					\
-		__asm__ __volatile__(			\
-			"stxa\t%0, [%1] %2\n\t"		\
-			"membar #Sync"			\
-			: /* no outputs */		\
-			: "r" (pgd_cache),		\
-			  "r" (TSB_REG),		\
-			  "i" (ASI_DMMU));		\
-		current->thread.flags = flags;		\
-	}						\
-							\
-	if (ibcs2)					\
-		set_personality(PER_SVR4);		\
-	else if (current->personality != PER_LINUX32)	\
-		set_personality(PER_LINUX);		\
+
+#define SET_ELF_PERSONALITY(ex,interp)					\
+do {									\
+	unsigned long			personality = PER_LINUX;	\
+	unsigned char			flags = current->thread.flags;	\
+									\
+	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)			\
+		flags |= SPARC_FLAG_32BIT;				\
+	else								\
+		flags &= ~SPARC_FLAG_32BIT;				\
+									\
+	if (flags != current->thread.flags) {				\
+		unsigned long		pgd_cache = 0UL;		\
+									\
+		if (flags & SPARC_FLAG_32BIT) {				\
+			pgd_t		*pgd0 = &current->mm->pgd[0];	\
+									\
+		  	if (pgd_none (*pgd0)) {				\
+				pmd_t	*page = pmd_alloc_one_fast(NULL, 0); \
+									\
+				if (!page)				\
+					page = pmd_alloc_one(NULL, 0);	\
+				pgd_set(pgd0, page);			\
+			}						\
+									\
+			pgd_cache = pgd_val(*pgd0) << 11UL;		\
+		}							\
+		__asm__ __volatile__(					\
+			"stxa\t%0, [%1] %2\n\t"				\
+			"membar #Sync"					\
+			: /* no outputs */				\
+			: "r" (pgd_cache),				\
+			  "r" (TSB_REG),				\
+			  "i" (ASI_DMMU));				\
+									\
+		current->thread.flags = flags;				\
+	}								\
+									\
+	/* Check the interpreter for SVR4isms */			\
+	if (strcmp((interp), "/usr/lib/libc.so.1") == 0 ||		\
+	    strcmp((interp), "/usr/lib/ld.so.1") == 0)			\
+		set_personality(PER_SVR4);				\
+	else if (current->personality != PER_LINUX32)			\
+		set_personality(PER_LINUX);				\
 } while (0)
-#endif
 
+#endif /* __KERNEL__ */
 #endif /* !(__ASM_SPARC64_ELF_H) */
