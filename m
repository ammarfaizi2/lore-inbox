Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319268AbSH2R1H>; Thu, 29 Aug 2002 13:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319272AbSH2R1H>; Thu, 29 Aug 2002 13:27:07 -0400
Received: from brule.borg.umn.edu ([160.94.232.10]:55852 "EHLO
	brule.borg.umn.edu") by vger.kernel.org with ESMTP
	id <S319268AbSH2R1D>; Thu, 29 Aug 2002 13:27:03 -0400
From: Peter Bergner <bergner@brule.borg.umn.edu>
Date: Thu, 29 Aug 2002 12:31:23 -0500
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       linuxPPC64 Dev <linuxppc64-dev@lists.linuxppc.org>
Cc: Dave Engebretsen <engebret@us.ibm.com>,
       Anton Blanchard <anton@au1.ibm.com>
Subject: [RFC][PATCH] Linux-2.5.32 binfmt_elf.c:load_elf_binary() change for PPC64
Message-ID: <20020829123123.A936328@brule.borg.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 64-bit PowerPC ELF ABI specifies that the e_entry field in the ELF header
is the address of a function descriptor for the entry routine (unlike all
other ELF archs where it is the entry point address of the entry routine).
The function descriptor contains the actual entry point address as well
as the address of the Table Of Contents (TOC, similar to a GOT) for the
entry routine.

This causes a problem when we try and execute 64-bit dynamically linked
applications as the e_entry value that is passed to start_thread() is
the e_entry for our interpreter (ld64.so).  The load_elf_binary() routine
takes care of "relocating" the e_entry value for us before passing it to
start_thread().  However, our e_entry function descriptor values also
need relocating before we can use them.  The following patch hooks into
the ELF_PLAT_INIT macro to pass in the load address of the interpreter
so start_thread() can reloc the e_entry function descriptor values.

Does this look reasonable?  I had thought of modifying start_thread()
to take an extra argument, but all uses of start_thread() (other than
ppc64's version) would not use the value and given that the GCC optimizer
can't know this while compiling load_elf_binary(), it would force those
variables to be live all the way to the start_thread() call.
By placing it in the ELF_PLAT_INIT macro, those values become deadcode,
so arches other than PPC64 shouldn't see any code difference.


Peter

--
Peter Bergner
Linux PPC64 Kernel & GLIBC Development
IBM Rochester, MN



diff -urN linux-2.5.32.orig/fs/binfmt_elf.c linux-2.5.32/fs/binfmt_elf.c
--- linux-2.5.32.orig/fs/binfmt_elf.c	Tue Aug 27 14:26:42 2002
+++ linux-2.5.32/fs/binfmt_elf.c	Thu Aug 29 11:03:28 2002
@@ -436,6 +436,7 @@
 	char * elf_interpreter = NULL;
 	unsigned int interpreter_type = INTERPRETER_NONE;
 	unsigned char ibcs2_interpreter = 0;
+	unsigned char load_shared_obj = 0;
 	unsigned long error;
 	struct elf_phdr * elf_ppnt, *elf_phdata;
 	unsigned long elf_bss, k, elf_brk;
@@ -668,6 +669,7 @@
 			load_addr_set = 1;
 			load_addr = (elf_ppnt->p_vaddr - elf_ppnt->p_offset);
 			if (elf_ex.e_type == ET_DYN) {
+				load_shared_obj = 1;
 				load_bias += error -
 				             ELF_PAGESTART(load_bias + vaddr);
 				load_addr += load_bias;
@@ -782,7 +784,7 @@
 	 * example.  This macro performs whatever initialization to
 	 * the regs structure is required.
 	 */
-	ELF_PLAT_INIT(regs);
+	ELF_PLAT_INIT(regs, (load_shared_obj) ? load_addr : interp_load_addr);
 #endif
 
 	start_thread(regs, elf_entry, bprm->p);
diff -urN linux-2.5.32.orig/arch/ppc64/kernel/process.c linux-2.5.32/arch/ppc64/kernel/process.c
--- linux-2.5.32.orig/arch/ppc64/kernel/process.c	Tue Aug 27 14:26:47 2002
+++ linux-2.5.32/arch/ppc64/kernel/process.c	Thu Aug 29 11:37:19 2002
@@ -215,20 +215,29 @@
  */
 void start_thread(struct pt_regs *regs, unsigned long nip, unsigned long sp)
 {
-	/* NIP is *really* a pointer to the function descriptor for
+	unsigned long entry, toc;
+	unsigned long load_addr = regs->gpr[2];
+
+	/* NIP is a relocated pointer to the function descriptor for
          * the elf _start routine.  The first entry in the function
          * descriptor is the entry address of _start and the second
          * entry is the TOC value we need to use.
          */
-	unsigned long *entry = (unsigned long *)nip;
-	unsigned long *toc   = entry + 1;
-
 	set_fs(USER_DS);
-	memset(regs->gpr, 0, sizeof(regs->gpr));
-	memset(&regs->ctr, 0, 4 * sizeof(regs->ctr));
-	__get_user(regs->nip, entry);
+	__get_user(entry, (unsigned long *)nip);
+	__get_user(toc, (unsigned long *)nip+1);
+
+	/* Check whether the e_entry function descriptor entries
+	 * need to be relocated before we can use them.
+	 */
+	if (load_addr != 0) {
+		entry += load_addr;
+		toc += load_addr;
+	}
+
+	regs->nip = entry;
 	regs->gpr[1] = sp;
-	__get_user(regs->gpr[2], toc);
+	regs->gpr[2] = toc;
 	regs->msr = MSR_USER64;
 	if (last_task_used_math == current)
 		last_task_used_math = 0;
diff -urN linux-2.5.32.orig/arch/ia64/ia32/binfmt_elf32.c linux-2.5.32/arch/ia64/ia32/binfmt_elf32.c
--- linux-2.5.32.orig/arch/ia64/ia32/binfmt_elf32.c	Tue Aug 27 14:27:32 2002
+++ linux-2.5.32/arch/ia64/ia32/binfmt_elf32.c	Thu Aug 29 11:06:09 2002
@@ -44,7 +44,7 @@
 
 static void elf32_set_personality (void);
 
-#define ELF_PLAT_INIT(_r)		ia64_elf32_init(_r)
+#define ELF_PLAT_INIT(_r, unused)	ia64_elf32_init(_r)
 #define setup_arg_pages(bprm)		ia32_setup_arg_pages(bprm)
 #define elf_map				elf32_map
 
diff -urN linux-2.5.32.orig/arch/s390x/kernel/binfmt_elf32.c linux-2.5.32/arch/s390x/kernel/binfmt_elf32.c
--- linux-2.5.32.orig/arch/s390x/kernel/binfmt_elf32.c	Tue Aug 27 14:26:42 2002
+++ linux-2.5.32/arch/s390x/kernel/binfmt_elf32.c	Thu Aug 29 11:06:26 2002
@@ -35,7 +35,7 @@
 
 /* For SVR4/S390 the function pointer to be registered with `atexit` is
    passed in R14. */
-#define ELF_PLAT_INIT(_r) \
+#define ELF_PLAT_INIT(_r, unused) \
 	do { \
 	_r->gprs[14] = 0; \
 	current->thread.flags |= S390_FLAG_31BIT; \
diff -urN linux-2.5.32.orig/arch/x86_64/ia32/ia32_binfmt.c linux-2.5.32/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.5.32.orig/arch/x86_64/ia32/ia32_binfmt.c	Tue Aug 27 14:26:32 2002
+++ linux-2.5.32/arch/x86_64/ia32/ia32_binfmt.c	Thu Aug 29 11:06:17 2002
@@ -160,7 +160,7 @@
 # define CONFIG_BINFMT_ELF_MODULE	CONFIG_BINFMT_ELF32_MODULE
 #endif
 
-#define ELF_PLAT_INIT(r)		elf32_init(r)
+#define ELF_PLAT_INIT(r, unused)	elf32_init(r)
 #define setup_arg_pages(bprm)		ia32_setup_arg_pages(bprm)
 
 #undef start_thread
diff -urN linux-2.5.32.orig/include/asm-alpha/elf.h linux-2.5.32/include/asm-alpha/elf.h
--- linux-2.5.32.orig/include/asm-alpha/elf.h	Tue Aug 27 14:26:43 2002
+++ linux-2.5.32/include/asm-alpha/elf.h	Thu Aug 29 11:07:36 2002
@@ -50,7 +50,7 @@
    we start programs with a value of 0 to indicate that there is no
    such function.  */
 
-#define ELF_PLAT_INIT(_r)       _r->r0 = 0
+#define ELF_PLAT_INIT(_r, unused)       _r->r0 = 0
 
 /* Use the same format as the OSF/1 procfs interface.  The register
    layout is sane.  However, since dump_thread() creates the funky
diff -urN linux-2.5.32.orig/include/asm-arm/elf.h linux-2.5.32/include/asm-arm/elf.h
--- linux-2.5.32.orig/include/asm-arm/elf.h	Tue Aug 27 14:26:40 2002
+++ linux-2.5.32/include/asm-arm/elf.h	Thu Aug 29 11:07:09 2002
@@ -48,7 +48,7 @@
 /* When the program starts, a1 contains a pointer to a function to be 
    registered with atexit, as per the SVR4 ABI.  A value of 0 means we 
    have no such handler.  */
-#define ELF_PLAT_INIT(_r)	(_r)->ARM_r0 = 0
+#define ELF_PLAT_INIT(_r, unused)	(_r)->ARM_r0 = 0
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this cpu supports. */
diff -urN linux-2.5.32.orig/include/asm-cris/elf.h linux-2.5.32/include/asm-cris/elf.h
--- linux-2.5.32.orig/include/asm-cris/elf.h	Tue Aug 27 14:26:41 2002
+++ linux-2.5.32/include/asm-cris/elf.h	Thu Aug 29 11:07:42 2002
@@ -39,7 +39,7 @@
 	   A value of 0 tells we have no such handler.  */
 	
 	/* Explicitly set registers to 0 to increase determinism.  */
-#define ELF_PLAT_INIT(_r)	do { \
+#define ELF_PLAT_INIT(_r, unused)	do { \
 	(_r)->r13 = 0; (_r)->r12 = 0; (_r)->r11 = 0; (_r)->r10 = 0; \
 	(_r)->r9 = 0;  (_r)->r8 = 0;  (_r)->r7 = 0;  (_r)->r6 = 0;  \
 	(_r)->r5 = 0;  (_r)->r4 = 0;  (_r)->r3 = 0;  (_r)->r2 = 0;  \
diff -urN linux-2.5.32.orig/include/asm-i386/elf.h linux-2.5.32/include/asm-i386/elf.h
--- linux-2.5.32.orig/include/asm-i386/elf.h	Tue Aug 27 14:26:54 2002
+++ linux-2.5.32/include/asm-i386/elf.h	Thu Aug 29 11:07:27 2002
@@ -41,7 +41,7 @@
    We might as well make sure everything else is cleared too (except for %esp),
    just to make things more deterministic.
  */
-#define ELF_PLAT_INIT(_r)	do { \
+#define ELF_PLAT_INIT(_r, unused)	do { \
 	_r->ebx = 0; _r->ecx = 0; _r->edx = 0; \
 	_r->esi = 0; _r->edi = 0; _r->ebp = 0; \
 	_r->eax = 0; \
diff -urN linux-2.5.32.orig/include/asm-ia64/elf.h linux-2.5.32/include/asm-ia64/elf.h
--- linux-2.5.32.orig/include/asm-ia64/elf.h	Tue Aug 27 14:26:55 2002
+++ linux-2.5.32/include/asm-ia64/elf.h	Thu Aug 29 11:06:46 2002
@@ -48,7 +48,7 @@
  * talk to him...
  */
 extern void ia64_init_addr_space (void);
-#define ELF_PLAT_INIT(_r)	ia64_init_addr_space()
+#define ELF_PLAT_INIT(_r, unused)	ia64_init_addr_space()
 
 /* ELF register definitions.  This is needed for core dump support.  */
 
diff -urN linux-2.5.32.orig/include/asm-ia64/ia32.h linux-2.5.32/include/asm-ia64/ia32.h
--- linux-2.5.32.orig/include/asm-ia64/ia32.h	Tue Aug 27 14:27:33 2002
+++ linux-2.5.32/include/asm-ia64/ia32.h	Thu Aug 29 11:06:52 2002
@@ -331,7 +331,7 @@
 #define ELF_ET_DYN_BASE		(IA32_PAGE_OFFSET/3 + 0x1000000)
 
 void ia64_elf32_init(struct pt_regs *regs);
-#define ELF_PLAT_INIT(_r)	ia64_elf32_init(_r)
+#define ELF_PLAT_INIT(_r, unused)	ia64_elf32_init(_r)
 
 #define elf_addr_t	u32
 #define elf_caddr_t	u32
diff -urN linux-2.5.32.orig/include/asm-m68k/elf.h linux-2.5.32/include/asm-m68k/elf.h
--- linux-2.5.32.orig/include/asm-m68k/elf.h	Tue Aug 27 14:26:37 2002
+++ linux-2.5.32/include/asm-m68k/elf.h	Thu Aug 29 11:06:38 2002
@@ -31,7 +31,7 @@
 /* For SVR4/m68k the function pointer to be registered with `atexit' is
    passed in %a1.  Although my copy of the ABI has no such statement, it
    is actually used on ASV.  */
-#define ELF_PLAT_INIT(_r)	_r->a1 = 0
+#define ELF_PLAT_INIT(_r, unused)	_r->a1 = 0
 
 #define USE_ELF_CORE_DUMP
 #ifndef CONFIG_SUN3
diff -urN linux-2.5.32.orig/include/asm-mips/elf.h linux-2.5.32/include/asm-mips/elf.h
--- linux-2.5.32.orig/include/asm-mips/elf.h	Tue Aug 27 14:26:41 2002
+++ linux-2.5.32/include/asm-mips/elf.h	Thu Aug 29 11:07:16 2002
@@ -73,7 +73,7 @@
  * See comments in asm-alpha/elf.h, this is the same thing
  * on the MIPS.
  */
-#define ELF_PLAT_INIT(_r)	do { \
+#define ELF_PLAT_INIT(_r, unused)	do { \
 	_r->regs[1] = _r->regs[2] = _r->regs[3] = _r->regs[4] = 0;	\
 	_r->regs[5] = _r->regs[6] = _r->regs[7] = _r->regs[8] = 0;	\
 	_r->regs[9] = _r->regs[10] = _r->regs[11] = _r->regs[12] = 0;	\
diff -urN linux-2.5.32.orig/include/asm-mips64/elf.h linux-2.5.32/include/asm-mips64/elf.h
--- linux-2.5.32.orig/include/asm-mips64/elf.h	Tue Aug 27 14:26:32 2002
+++ linux-2.5.32/include/asm-mips64/elf.h	Thu Aug 29 11:07:49 2002
@@ -76,7 +76,7 @@
  * See comments in asm-alpha/elf.h, this is the same thing
  * on the MIPS.
  */
-#define ELF_PLAT_INIT(_r)	do { \
+#define ELF_PLAT_INIT(_r, unused)	do { \
 	_r->regs[1] = _r->regs[2] = _r->regs[3] = _r->regs[4] = 0;	\
 	_r->regs[5] = _r->regs[6] = _r->regs[7] = _r->regs[8] = 0;	\
 	_r->regs[9] = _r->regs[10] = _r->regs[11] = _r->regs[12] = 0;	\
diff -urN linux-2.5.32.orig/include/asm-parisc/elf.h linux-2.5.32/include/asm-parisc/elf.h
--- linux-2.5.32.orig/include/asm-parisc/elf.h	Tue Aug 27 14:27:05 2002
+++ linux-2.5.32/include/asm-parisc/elf.h	Thu Aug 29 11:07:22 2002
@@ -56,7 +56,7 @@
    So that we can use the same startup file with static executables,
    we start programs with a value of 0 to indicate that there is no
    such function.  */
-#define ELF_PLAT_INIT(_r)       _r->gr[23] = 0
+#define ELF_PLAT_INIT(_r, unused)       _r->gr[23] = 0
 
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE	4096
diff -urN linux-2.5.32.orig/include/asm-ppc64/elf.h linux-2.5.32/include/asm-ppc64/elf.h
--- linux-2.5.32.orig/include/asm-ppc64/elf.h	Tue Aug 27 14:27:04 2002
+++ linux-2.5.32/include/asm-ppc64/elf.h	Thu Aug 29 11:19:36 2002
@@ -86,6 +86,13 @@
 
 #define ELF_PLATFORM	(NULL)
 
+# define ELF_PLAT_INIT(_r, interp_load_addr) do { \
+	memset(_r->gpr, 0, sizeof(_r->gpr)); \
+	_r->ctr = _r->link = _r->xer = _r->ccr = 0; \
+	_r->gpr[2] = interp_load_addr; \
+ } while (0)
+
+
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2)				\
 do {	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
diff -urN linux-2.5.32.orig/include/asm-s390/elf.h linux-2.5.32/include/asm-s390/elf.h
--- linux-2.5.32.orig/include/asm-s390/elf.h	Tue Aug 27 14:26:40 2002
+++ linux-2.5.32/include/asm-s390/elf.h	Thu Aug 29 11:07:32 2002
@@ -36,7 +36,7 @@
 
 /* For SVR4/S390 the function pointer to be registered with `atexit` is
    passed in R14. */
-#define ELF_PLAT_INIT(_r) \
+#define ELF_PLAT_INIT(_r, unused) \
 	_r->gprs[14] = 0
 
 #define USE_ELF_CORE_DUMP
diff -urN linux-2.5.32.orig/include/asm-s390x/elf.h linux-2.5.32/include/asm-s390x/elf.h
--- linux-2.5.32.orig/include/asm-s390x/elf.h	Tue Aug 27 14:26:43 2002
+++ linux-2.5.32/include/asm-s390x/elf.h	Thu Aug 29 11:07:04 2002
@@ -36,7 +36,7 @@
 
 /* For SVR4/S390 the function pointer to be registered with `atexit` is
    passed in R14. */
-#define ELF_PLAT_INIT(_r) \
+#define ELF_PLAT_INIT(_r, unused) \
 	do { \
 	_r->gprs[14] = 0; \
 	current->thread.flags = 0; \
diff -urN linux-2.5.32.orig/include/asm-sh/elf.h linux-2.5.32/include/asm-sh/elf.h
--- linux-2.5.32.orig/include/asm-sh/elf.h	Tue Aug 27 14:26:37 2002
+++ linux-2.5.32/include/asm-sh/elf.h	Thu Aug 29 11:08:01 2002
@@ -61,7 +61,7 @@
 
 #define ELF_PLATFORM  (NULL)
 
-#define ELF_PLAT_INIT(_r) \
+#define ELF_PLAT_INIT(_r, unused) \
   do { _r->regs[0]=0; _r->regs[1]=0; _r->regs[2]=0; _r->regs[3]=0; \
        _r->regs[4]=0; _r->regs[5]=0; _r->regs[6]=0; _r->regs[7]=0; \
        _r->regs[8]=0; _r->regs[9]=0; _r->regs[10]=0; _r->regs[11]=0; \
diff -urN linux-2.5.32.orig/include/asm-x86_64/elf.h linux-2.5.32/include/asm-x86_64/elf.h
--- linux-2.5.32.orig/include/asm-x86_64/elf.h	Tue Aug 27 14:27:10 2002
+++ linux-2.5.32/include/asm-x86_64/elf.h	Thu Aug 29 11:06:57 2002
@@ -39,7 +39,7 @@
    We might as well make sure everything else is cleared too (except for %esp),
    just to make things more deterministic.
  */
-#define ELF_PLAT_INIT(_r)	do { \
+#define ELF_PLAT_INIT(_r, unused)	do { \
 	struct task_struct *cur = current; \
 	(_r)->rbx = 0; (_r)->rcx = 0; (_r)->rdx = 0; \
 	(_r)->rsi = 0; (_r)->rdi = 0; (_r)->rbp = 0; \
