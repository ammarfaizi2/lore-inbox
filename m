Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbTJUMH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 08:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263072AbTJUMH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 08:07:58 -0400
Received: from ozlabs.org ([203.10.76.45]:45021 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263079AbTJUMHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 08:07:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16277.8585.229313.67275@cargo.ozlabs.ibm.com>
Date: Tue, 21 Oct 2003 22:07:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add load_addr arg to ELF_PLAT_INIT
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

The patch below adds an argument to the ELF_PLAT_INIT so that the
binfmt_elf code can pass the load address of the interpreter or binary
to the architecture-specific code.  We need this on PPC64.  This code
is already in 2.6.0-test.

Please apply.

Thanks,
Paul.

diff -urN linux-2.4/arch/ia64/ia32/binfmt_elf32.c ppc64-linux-2.4/arch/ia64/ia32/binfmt_elf32.c
--- linux-2.4/arch/ia64/ia32/binfmt_elf32.c	2003-07-05 10:50:40.000000000 +1000
+++ ppc64-linux-2.4/arch/ia64/ia32/binfmt_elf32.c	2003-08-26 15:12:24.000000000 +1000
@@ -44,7 +44,7 @@
 
 static void elf32_set_personality (void);
 
-#define ELF_PLAT_INIT(_r)		ia64_elf32_init(_r)
+#define ELF_PLAT_INIT(_r, load_addr)	ia64_elf32_init(_r)
 #define setup_arg_pages(bprm)		ia32_setup_arg_pages(bprm)
 #define elf_map				elf32_map
 
diff -urN linux-2.4/arch/s390x/kernel/binfmt_elf32.c ppc64-linux-2.4/arch/s390x/kernel/binfmt_elf32.c
--- linux-2.4/arch/s390x/kernel/binfmt_elf32.c	2003-06-28 22:31:09.000000000 +1000
+++ ppc64-linux-2.4/arch/s390x/kernel/binfmt_elf32.c	2003-08-26 15:12:37.000000000 +1000
@@ -35,7 +35,7 @@
 
 /* For SVR4/S390 the function pointer to be registered with `atexit` is
    passed in R14. */
-#define ELF_PLAT_INIT(_r) \
+#define ELF_PLAT_INIT(_r, load_addr) \
 	do { \
 	_r->gprs[14] = 0; \
 	current->thread.flags |= S390_FLAG_31BIT; \
diff -urN linux-2.4/arch/x86_64/ia32/ia32_binfmt.c ppc64-linux-2.4/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.4/arch/x86_64/ia32/ia32_binfmt.c	2003-10-01 20:57:28.000000000 +1000
+++ ppc64-linux-2.4/arch/x86_64/ia32/ia32_binfmt.c	2003-10-14 22:07:53.000000000 +1000
@@ -162,7 +162,7 @@
 # define CONFIG_BINFMT_ELF_MODULE	CONFIG_BINFMT_ELF32_MODULE
 #endif
 
-#define ELF_PLAT_INIT(r)		elf32_init(r)
+#define ELF_PLAT_INIT(r, load_addr)	elf32_init(r)
 #define setup_arg_pages(bprm)		ia32_setup_arg_pages(bprm)
 
 extern void load_gs_index(unsigned);
diff -urN linux-2.4/fs/binfmt_elf.c ppc64-linux-2.4/fs/binfmt_elf.c
--- linux-2.4/fs/binfmt_elf.c	2003-08-13 08:53:50.000000000 +1000
+++ ppc64-linux-2.4/fs/binfmt_elf.c	2003-08-26 15:12:50.000000000 +1000
@@ -440,6 +440,7 @@
 	unsigned int size;
 	unsigned long elf_entry, interp_load_addr = 0;
 	unsigned long start_code, end_code, start_data, end_data;
+	unsigned long reloc_func_desc = 0;
 	struct elfhdr elf_ex;
 	struct elfhdr interp_elf_ex;
   	struct exec interp_ex;
@@ -686,6 +687,7 @@
 				load_bias += error -
 				             ELF_PAGESTART(load_bias + vaddr);
 				load_addr += load_bias;
+				reloc_func_desc = load_addr;
 			}
 		}
 		k = elf_ppnt->p_vaddr;
@@ -727,6 +729,7 @@
 			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
 			goto out_free_dentry;
 		}
+		reloc_func_desc = interp_load_addr;
 
 		allow_write_access(interpreter);
 		fput(interpreter);
@@ -793,10 +796,14 @@
 	/*
 	 * The ABI may specify that certain registers be set up in special
 	 * ways (on i386 %edx is the address of a DT_FINI function, for
-	 * example.  This macro performs whatever initialization to
-	 * the regs structure is required.
+	 * example.  In addition, it may also specify (eg, PowerPC64 ELF)
+	 * that the e_entry field is the address of the function descriptor
+	 * for the startup routine, rather than the address of the startup
+	 * routine itself.  This macro performs whatever initialization to
+	 * the regs structure is required as well as any relocations to the
+	 * function descriptor entries when executing dynamically linked apps.
 	 */
-	ELF_PLAT_INIT(regs);
+	ELF_PLAT_INIT(regs, reloc_func_desc);
 #endif
 
 	start_thread(regs, elf_entry, bprm->p);
diff -urN linux-2.4/include/asm-alpha/elf.h ppc64-linux-2.4/include/asm-alpha/elf.h
--- linux-2.4/include/asm-alpha/elf.h	2003-06-27 08:08:34.000000000 +1000
+++ ppc64-linux-2.4/include/asm-alpha/elf.h	2003-08-26 15:12:51.000000000 +1000
@@ -50,7 +50,7 @@
    we start programs with a value of 0 to indicate that there is no
    such function.  */
 
-#define ELF_PLAT_INIT(_r)       _r->r0 = 0
+#define ELF_PLAT_INIT(_r, load_addr)	_r->r0 = 0
 
 #ifdef __KERNEL__
 /* The registers are layed out in pt_regs for PAL and syscall
diff -urN linux-2.4/include/asm-arm/elf.h ppc64-linux-2.4/include/asm-arm/elf.h
--- linux-2.4/include/asm-arm/elf.h	2003-07-05 10:50:41.000000000 +1000
+++ ppc64-linux-2.4/include/asm-arm/elf.h	2003-08-26 15:12:51.000000000 +1000
@@ -48,7 +48,7 @@
 /* When the program starts, a1 contains a pointer to a function to be 
    registered with atexit, as per the SVR4 ABI.  A value of 0 means we 
    have no such handler.  */
-#define ELF_PLAT_INIT(_r)	(_r)->ARM_r0 = 0
+#define ELF_PLAT_INIT(_r, load_addr)	(_r)->ARM_r0 = 0
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this cpu supports. */
diff -urN linux-2.4/include/asm-cris/elf.h ppc64-linux-2.4/include/asm-cris/elf.h
--- linux-2.4/include/asm-cris/elf.h	2002-02-06 01:10:20.000000000 +1100
+++ ppc64-linux-2.4/include/asm-cris/elf.h	2003-08-22 12:30:50.000000000 +1000
@@ -39,7 +39,7 @@
 	   A value of 0 tells we have no such handler.  */
 	
 	/* Explicitly set registers to 0 to increase determinism.  */
-#define ELF_PLAT_INIT(_r)	do { \
+#define ELF_PLAT_INIT(_r, load_addr)	do { \
 	(_r)->r13 = 0; (_r)->r12 = 0; (_r)->r11 = 0; (_r)->r10 = 0; \
 	(_r)->r9 = 0;  (_r)->r8 = 0;  (_r)->r7 = 0;  (_r)->r6 = 0;  \
 	(_r)->r5 = 0;  (_r)->r4 = 0;  (_r)->r3 = 0;  (_r)->r2 = 0;  \
diff -urN linux-2.4/include/asm-i386/elf.h ppc64-linux-2.4/include/asm-i386/elf.h
--- linux-2.4/include/asm-i386/elf.h	2002-02-05 18:41:18.000000000 +1100
+++ ppc64-linux-2.4/include/asm-i386/elf.h	2003-08-22 12:30:50.000000000 +1000
@@ -41,7 +41,7 @@
    We might as well make sure everything else is cleared too (except for %esp),
    just to make things more deterministic.
  */
-#define ELF_PLAT_INIT(_r)	do { \
+#define ELF_PLAT_INIT(_r, load_addr)	do { \
 	_r->ebx = 0; _r->ecx = 0; _r->edx = 0; \
 	_r->esi = 0; _r->edi = 0; _r->ebp = 0; \
 	_r->eax = 0; \
diff -urN linux-2.4/include/asm-ia64/elf.h ppc64-linux-2.4/include/asm-ia64/elf.h
--- linux-2.4/include/asm-ia64/elf.h	2003-09-10 11:13:44.000000000 +1000
+++ ppc64-linux-2.4/include/asm-ia64/elf.h	2003-09-22 10:34:04.000000000 +1000
@@ -49,7 +49,7 @@
  * talk to him...
  */
 extern void ia64_init_addr_space (void);
-#define ELF_PLAT_INIT(_r)	ia64_init_addr_space()
+#define ELF_PLAT_INIT(_r, load_addr)	ia64_init_addr_space()
 
 /* ELF register definitions.  This is needed for core dump support.  */
 
diff -urN linux-2.4/include/asm-ia64/ia32.h ppc64-linux-2.4/include/asm-ia64/ia32.h
--- linux-2.4/include/asm-ia64/ia32.h	2003-07-05 10:50:41.000000000 +1000
+++ ppc64-linux-2.4/include/asm-ia64/ia32.h	2003-08-26 15:12:51.000000000 +1000
@@ -390,7 +390,7 @@
 #define ELF_ET_DYN_BASE		(IA32_PAGE_OFFSET/3 + 0x1000000)
 
 void ia64_elf32_init(struct pt_regs *regs);
-#define ELF_PLAT_INIT(_r)	ia64_elf32_init(_r)
+#define ELF_PLAT_INIT(_r, load_addr)	ia64_elf32_init(_r)
 
 #define elf_addr_t	u32
 #define elf_caddr_t	u32
diff -urN linux-2.4/include/asm-m68k/elf.h ppc64-linux-2.4/include/asm-m68k/elf.h
--- linux-2.4/include/asm-m68k/elf.h	2002-02-06 04:39:46.000000000 +1100
+++ ppc64-linux-2.4/include/asm-m68k/elf.h	2003-08-22 12:30:51.000000000 +1000
@@ -31,7 +31,7 @@
 /* For SVR4/m68k the function pointer to be registered with `atexit' is
    passed in %a1.  Although my copy of the ABI has no such statement, it
    is actually used on ASV.  */
-#define ELF_PLAT_INIT(_r)	_r->a1 = 0
+#define ELF_PLAT_INIT(_r, load_addr)	_r->a1 = 0
 
 #define USE_ELF_CORE_DUMP
 #ifndef CONFIG_SUN3
diff -urN linux-2.4/include/asm-mips/elf.h ppc64-linux-2.4/include/asm-mips/elf.h
--- linux-2.4/include/asm-mips/elf.h	2002-09-12 20:30:31.000000000 +1000
+++ ppc64-linux-2.4/include/asm-mips/elf.h	2003-08-22 12:30:52.000000000 +1000
@@ -89,7 +89,7 @@
  * See comments in asm-alpha/elf.h, this is the same thing
  * on the MIPS.
  */
-#define ELF_PLAT_INIT(_r)	do { \
+#define ELF_PLAT_INIT(_r, load_addr)	do { \
 	_r->regs[1] = _r->regs[2] = _r->regs[3] = _r->regs[4] = 0;	\
 	_r->regs[5] = _r->regs[6] = _r->regs[7] = _r->regs[8] = 0;	\
 	_r->regs[9] = _r->regs[10] = _r->regs[11] = _r->regs[12] = 0;	\
diff -urN linux-2.4/include/asm-mips64/elf.h ppc64-linux-2.4/include/asm-mips64/elf.h
--- linux-2.4/include/asm-mips64/elf.h	2003-08-24 09:04:16.000000000 +1000
+++ ppc64-linux-2.4/include/asm-mips64/elf.h	2003-08-26 15:12:52.000000000 +1000
@@ -87,7 +87,7 @@
  * See comments in asm-alpha/elf.h, this is the same thing
  * on the MIPS.
  */
-#define ELF_PLAT_INIT(_r)	do { \
+#define ELF_PLAT_INIT(_r, load_addr)	do { \
 	_r->regs[1] = _r->regs[2] = _r->regs[3] = _r->regs[4] = 0;	\
 	_r->regs[5] = _r->regs[6] = _r->regs[7] = _r->regs[8] = 0;	\
 	_r->regs[9] = _r->regs[10] = _r->regs[11] = _r->regs[12] = 0;	\
diff -urN linux-2.4/include/asm-parisc/elf.h ppc64-linux-2.4/include/asm-parisc/elf.h
--- linux-2.4/include/asm-parisc/elf.h	2002-07-29 22:58:45.000000000 +1000
+++ ppc64-linux-2.4/include/asm-parisc/elf.h	2003-08-22 12:30:54.000000000 +1000
@@ -118,7 +118,7 @@
    So that we can use the same startup file with static executables,
    we start programs with a value of 0 to indicate that there is no
    such function.  */
-#define ELF_PLAT_INIT(_r)       _r->gr[23] = 0
+#define ELF_PLAT_INIT(_r, load_addr)       _r->gr[23] = 0
 
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE	4096
diff -urN linux-2.4/include/asm-ppc64/elf.h ppc64-linux-2.4/include/asm-ppc64/elf.h
--- linux-2.4/include/asm-ppc64/elf.h	2003-06-21 08:42:27.000000000 +1000
+++ ppc64-linux-2.4/include/asm-ppc64/elf.h	2003-09-03 18:08:26.000000000 +1000
@@ -88,19 +88,12 @@
 
 #define ELF_PLATFORM	(NULL)
 
-#if 0
+
 #define ELF_PLAT_INIT(_r, interp_load_addr)	do { \
 	memset(_r->gpr, 0, sizeof(_r->gpr)); \
 	_r->ctr = _r->link = _r->xer = _r->ccr = 0; \
 	_r->gpr[2] = interp_load_addr; \
 } while (0)
-#endif
-
-#define ELF_PLAT_INIT(_r)       do { \
-        memset(_r->gpr, 0, sizeof(_r->gpr)); \
-        _r->ctr = _r->link = _r->xer = _r->ccr = 0; \
-} while (0)
-
 
 
 
diff -urN linux-2.4/include/asm-s390/elf.h ppc64-linux-2.4/include/asm-s390/elf.h
--- linux-2.4/include/asm-s390/elf.h	2002-02-05 18:39:15.000000000 +1100
+++ ppc64-linux-2.4/include/asm-s390/elf.h	2003-08-22 12:30:54.000000000 +1000
@@ -36,7 +36,7 @@
 
 /* For SVR4/S390 the function pointer to be registered with `atexit` is
    passed in R14. */
-#define ELF_PLAT_INIT(_r) \
+#define ELF_PLAT_INIT(_r, load_addr) \
 	_r->gprs[14] = 0
 
 #define USE_ELF_CORE_DUMP
diff -urN linux-2.4/include/asm-s390x/elf.h ppc64-linux-2.4/include/asm-s390x/elf.h
--- linux-2.4/include/asm-s390x/elf.h	2002-07-30 21:27:40.000000000 +1000
+++ ppc64-linux-2.4/include/asm-s390x/elf.h	2003-08-22 12:30:55.000000000 +1000
@@ -36,7 +36,7 @@
 
 /* For SVR4/S390 the function pointer to be registered with `atexit` is
    passed in R14. */
-#define ELF_PLAT_INIT(_r) \
+#define ELF_PLAT_INIT(_r, load_addr) \
 	do { \
 	_r->gprs[14] = 0; \
 	current->thread.flags = 0; \
diff -urN linux-2.4/include/asm-sh/elf.h ppc64-linux-2.4/include/asm-sh/elf.h
--- linux-2.4/include/asm-sh/elf.h	2002-02-05 18:45:03.000000000 +1100
+++ ppc64-linux-2.4/include/asm-sh/elf.h	2003-08-22 12:30:55.000000000 +1000
@@ -61,7 +61,7 @@
 
 #define ELF_PLATFORM  (NULL)
 
-#define ELF_PLAT_INIT(_r) \
+#define ELF_PLAT_INIT(_r, load_addr) \
   do { _r->regs[0]=0; _r->regs[1]=0; _r->regs[2]=0; _r->regs[3]=0; \
        _r->regs[4]=0; _r->regs[5]=0; _r->regs[6]=0; _r->regs[7]=0; \
        _r->regs[8]=0; _r->regs[9]=0; _r->regs[10]=0; _r->regs[11]=0; \
diff -urN linux-2.4/include/asm-sh64/elf.h ppc64-linux-2.4/include/asm-sh64/elf.h
--- linux-2.4/include/asm-sh64/elf.h	2003-06-28 22:31:10.000000000 +1000
+++ ppc64-linux-2.4/include/asm-sh64/elf.h	2003-10-19 22:53:34.902957896 +1000
@@ -73,7 +73,7 @@
 
 #define ELF_PLATFORM  (NULL)
 
-#define ELF_PLAT_INIT(_r) \
+#define ELF_PLAT_INIT(_r, load_addr) \
   do { _r->regs[0]=0; _r->regs[1]=0; _r->regs[2]=0; _r->regs[3]=0; \
        _r->regs[4]=0; _r->regs[5]=0; _r->regs[6]=0; _r->regs[7]=0; \
        _r->regs[8]=0; _r->regs[9]=0; _r->regs[10]=0; _r->regs[11]=0; \
diff -urN linux-2.4/include/asm-x86_64/elf.h ppc64-linux-2.4/include/asm-x86_64/elf.h
--- linux-2.4/include/asm-x86_64/elf.h	2002-07-31 14:51:22.000000000 +1000
+++ ppc64-linux-2.4/include/asm-x86_64/elf.h	2003-08-22 12:30:55.000000000 +1000
@@ -39,7 +39,7 @@
    We might as well make sure everything else is cleared too (except for %esp),
    just to make things more deterministic.
  */
-#define ELF_PLAT_INIT(_r)	do { \
+#define ELF_PLAT_INIT(_r, load_addr)	do { \
 	struct task_struct *cur = current; \
 	(_r)->rbx = 0; (_r)->rcx = 0; (_r)->rdx = 0; \
 	(_r)->rsi = 0; (_r)->rdi = 0; (_r)->rbp = 0; \
