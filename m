Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTEOW1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 18:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTEOW1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 18:27:05 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34021 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S264267AbTEOW0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 18:26:51 -0400
Date: Thu, 15 May 2003 15:39:36 -0700
Message-Id: <200305152239.h4FMdaX12112@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@suse.de>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [x86_64 PATCH] IA32 vsyscall DSO compatibility in IA32_EMULATION
X-Zippy-Says: BRYLCREAM is CREAM O' WHEAT in another DIMENSION..
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, 2.5 ia32 core dumping on x86-64 as is crashes without the patch I just
posted to lkml.

This patch is against 2.5.69 patched up to the 1.1117 cset.

This brings the x86_64 kernel's IA32_EMULATION code up to date with the
vsyscall DSO changes in the native i386 kernel.  The actual code in the
vsyscall entry points is unchanged from what x86_64 has now (i.e. using
"syscall"), and the unwind info for exception handling (and gdb) matches
that code.  As in the original i386 patch, I have cleaned up some
hard-coded address constants to use symbols culled from the vsyscall DSO.

I've tested running 32-bit binaries using the vsyscall entry point on this
kernel, and also produced a core dump from a 32-bit process and verified
that it matches up with what native i386 core dumps now look like.

If you have any issues with this patch, please be sure to keep me addressed
directly in all email, as I am not on the mailing list.


Thanks,
Roland




--- linux-2.5.69-1.1117/arch/x86_64/ia32/Makefile	Sun May  4 16:53:08 2003
+++ linux-2.5.69-1.1083/arch/x86_64/ia32/Makefile	Wed May 14 17:39:17 2003
@@ -4,4 +4,32 @@
 
 obj-$(CONFIG_IA32_EMULATION) := ia32entry.o sys_ia32.o ia32_ioctl.o \
 	ia32_signal.o tls32.o \
-	ia32_binfmt.o fpu32.o ptrace32.o ipc32.o syscall32.o
+	ia32_binfmt.o fpu32.o ptrace32.o ipc32.o syscall32.o \
+	ia32_vsyscall.o
+
+
+# ia32_vsyscall.o contains the vsyscall DSO image as __initdata.
+# We must build the image before we can assemble it.
+$(obj)/ia32_vsyscall.o: $(obj)/vsyscall32.so
+extra-$(CONFIG_IA32_EMULATION) += vsyscall32.o vsyscall32.so
+
+# The DSO images are built using a special linker script.
+$(obj)/vsyscall32.so: $(src)/../../i386/kernel/vsyscall.lds \
+		      $(obj)/vsyscall32.o
+	$(IA32_CC) -nostdlib -shared -s -Wl,-soname=linux-vsyscall.so.1 \
+		   -o $@ -Wl,-T,$^
+
+$(obj)/vsyscall32.o: $(src)/vsyscall32.S
+	$(IA32_AS) -o $@ $<
+
+# We also create a special relocatable object that should mirror the symbol
+# table and layout of the linked DSO.  With ld -R we can then refer to
+# these symbols in the kernel code rather than hand-coded addresses.
+extra-$(CONFIG_IA32_EMULATION) += vsyscall32-syms.o vsyscall32-syms64.o
+$(obj)/built-in.o: $(obj)/vsyscall32-syms64.o
+$(obj)/built-in.o: ld_flags += -R $(obj)/vsyscall32-syms64.o
+$(obj)/vsyscall32-syms.o: $(src)/../../i386/kernel/vsyscall.lds \
+			  $(obj)/vsyscall32.o
+	$(IA32_CC) -nostdlib -r -o $@ -Wl,-T,$^
+$(obj)/vsyscall32-syms64.o: $(obj)/vsyscall32-syms.o
+	$(OBJCOPY) -O elf64-x86-64 $< $@
--- linux-2.5.69-1.1117/arch/x86_64/ia32/ia32_binfmt.c	Sun May  4 16:52:50 2003
+++ linux-2.5.69-1.1083/arch/x86_64/ia32/ia32_binfmt.c	Wed May 14 01:22:45 2003
@@ -25,9 +25,68 @@
 
 #define ELF_NAME "elf/i386"
 
+
+/* This vsyscall magic should match what asm-i386/elf.h does.  */
+
 #define AT_SYSINFO 32
+#define AT_SYSINFO_EHDR 33
+
+extern char *syscall32_page;	/* Defined in syscall32.c.  */
+extern void ia32_vsyscall;	/* Defined in vsyscall32.S.  */
+#define VSYSCALL_BASE	0xffffe000U
+#define VSYSCALL_EHDR	((const struct elfhdr *) syscall32_page)
+
+#define ARCH_DLINFO							\
+do {									\
+	u64 entry;							\
+	asm ("movabsq %1, %0" : "=r" (entry) : "i" (&ia32_vsyscall));	\
+	NEW_AUX_ENT(AT_SYSINFO,	(u32) entry);				\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, (u32) VSYSCALL_BASE);		\
+} while (0)
+
+
+/*
+ * These macros parameterize elf_core_dump in fs/binfmt_elf.c to write out
+ * extra segments containing the vsyscall DSO contents.  Dumping its
+ * contents makes post-mortem fully interpretable later without matching up
+ * the same kernel and hardware config to see what PC values meant.
+ * Dumping its extra ELF program headers includes all the other information
+ * a debugger needs to easily find how the vsyscall DSO was being used.
+ */
+#define ELF_CORE_EXTRA_PHDRS		(VSYSCALL_EHDR->e_phnum)
+#define ELF_CORE_WRITE_EXTRA_PHDRS					      \
+do {									      \
+	const struct elf_phdr *const vsyscall_phdrs =			      \
+		(const struct elf_phdr *) (syscall32_page		      \
+					   + VSYSCALL_EHDR->e_phoff);	      \
+	int i;								      \
+	Elf32_Off ofs = 0;						      \
+	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
+		struct elf_phdr phdr = vsyscall_phdrs[i];		      \
+		if (phdr.p_type == PT_LOAD) {				      \
+			ofs = phdr.p_offset = offset;			      \
+			offset += phdr.p_filesz;			      \
+		}							      \
+		else							      \
+			phdr.p_offset += ofs;				      \
+		phdr.p_paddr = 0; /* match other core phdrs */		      \
+		DUMP_WRITE(&phdr, sizeof(phdr));			      \
+	}								      \
+} while (0)
+#define ELF_CORE_WRITE_EXTRA_DATA					      \
+do {									      \
+	const struct elf_phdr *const vsyscall_phdrs =			      \
+		(const struct elf_phdr *) (syscall32_page		      \
+					   + VSYSCALL_EHDR->e_phoff);	      \
+	int i;								      \
+	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
+		if (vsyscall_phdrs[i].p_type == PT_LOAD)		      \
+			DUMP_WRITE(vsyscall_phdrs[i].p_vaddr - VSYSCALL_BASE  \
+				   + syscall32_page,			      \
+				   vsyscall_phdrs[i].p_filesz);		      \
+	}								      \
+} while (0)
 
-#define ARCH_DLINFO NEW_AUX_ENT(AT_SYSINFO, 0xffffe000)
 
 struct file;
 struct elf_phdr; 
--- linux-2.5.69-1.1117/arch/x86_64/ia32/ia32_signal.c	Sun May  4 16:53:42 2003
+++ linux-2.5.69-1.1083/arch/x86_64/ia32/ia32_signal.c	Wed May 14 01:14:24 2003
@@ -141,27 +141,7 @@ sys32_sigaltstack(const stack_ia32_t *us
  * Do a signal return; undo the signal stack.
  */
 
-struct sigframe
-{
-	u32 pretcode;
-	int sig;
-	struct sigcontext_ia32 sc;
-	struct _fpstate_ia32 fpstate;
-	unsigned int extramask[_COMPAT_NSIG_WORDS-1];
-	char retcode[8];
-};
-
-struct rt_sigframe
-{
-	u32 pretcode;
-	int sig;
-	u32 pinfo;
-	u32 puc;
-	struct siginfo32 info;
-	struct ucontext_ia32 uc;
-	struct _fpstate_ia32 fpstate;
-	char retcode[8];
-};
+#include "sigframe.h"
 
 static int
 ia32_restore_sigcontext(struct pt_regs *regs, struct sigcontext_ia32 *sc, unsigned int *peax)
@@ -392,6 +372,10 @@ get_sigframe(struct k_sigaction *ka, str
 	return (void *)((rsp - frame_size) & -8UL);
 }
 
+/* These symbols are defined with the addresses in the vsyscall page.
+   See vsyscall32.S.  */
+extern void ia32_sigreturn, ia32_rt_sigreturn;
+
 void ia32_setup_frame(int sig, struct k_sigaction *ka,
 			compat_sigset_t *set, struct pt_regs * regs)
 {
@@ -426,9 +410,14 @@ void ia32_setup_frame(int sig, struct k_
 	if (err)
 		goto give_sigsegv;
 
-	/* Return stub is in 32bit vsyscall page */
-	{ 
-		void *restorer = syscall32_page + 32; 
+	/* Return stub is in 32bit vsyscall page.  We have its absolute
+	   32-bit address in a symbol.  We can't use a normal C reference
+	   because -mcmodel=kernel limits us to signed 32-bit relocs that
+	   can't handle the values near 2^32.  */
+	{
+		void *restorer;
+		asm ("movabsq %1, %0"
+		     : "=r" (restorer) : "i" (&ia32_sigreturn));
 		if (ka->sa.sa_flags & SA_RESTORER)
 			restorer = ka->sa.sa_restorer;       
 		err |= __put_user(ptr_to_u32(restorer), &frame->pretcode);
@@ -519,9 +508,10 @@ void ia32_setup_rt_frame(int sig, struct
 	if (err)
 		goto give_sigsegv;
 
-	
 	{ 
-		void *restorer = syscall32_page + 32; 
+		void *restorer;
+		asm ("movabsq %1, %0"
+		     : "=r" (restorer) : "i" (&ia32_rt_sigreturn));
 		if (ka->sa.sa_flags & SA_RESTORER)
 			restorer = ka->sa.sa_restorer;       
 		err |= __put_user(ptr_to_u32(restorer), &frame->pretcode);
--- linux-2.5.69-1.1117/arch/x86_64/ia32/ia32_vsyscall.S	Wed Dec 31 16:00:00 1969
+++ linux-2.5.69-1.1083/arch/x86_64/ia32/ia32_vsyscall.S	Tue May 13 23:22:27 2003
@@ -0,0 +1,10 @@
+#include <linux/init.h>
+
+__INITDATA
+
+	.globl ia32_vsyscall_start, ia32_vsyscall_end
+ia32_vsyscall_start:
+	.incbin "arch/x86_64/ia32/vsyscall32.so"
+ia32_vsyscall_end:
+
+__FINIT
--- linux-2.5.69-1.1117/arch/x86_64/ia32/sigframe.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.69-1.1083/arch/x86_64/ia32/sigframe.h	Tue May 13 23:31:02 2003
@@ -0,0 +1,21 @@
+struct sigframe
+{
+	u32 pretcode;
+	int sig;
+	struct sigcontext_ia32 sc;
+	struct _fpstate_ia32 fpstate;
+	unsigned int extramask[_COMPAT_NSIG_WORDS-1];
+	char retcode[8];
+};
+
+struct rt_sigframe
+{
+	u32 pretcode;
+	int sig;
+	u32 pinfo;
+	u32 puc;
+	struct siginfo32 info;
+	struct ucontext_ia32 uc;
+	struct _fpstate_ia32 fpstate;
+	char retcode[8];
+};
--- linux-2.5.69-1.1117/arch/x86_64/ia32/syscall32.c	Sun May  4 16:53:32 2003
+++ linux-2.5.69-1.1083/arch/x86_64/ia32/syscall32.c	Tue May 13 23:59:14 2003
@@ -13,33 +13,11 @@
 #include <asm/tlbflush.h>
 #include <asm/ia32_unistd.h>
 
-/* 32bit SYSCALL stub mapped into user space. */ 
-asm("	.code32\n"
-    "\nsyscall32:\n"
-    "	pushl %ebp\n"
-    "	movl  %ecx,%ebp\n"
-    "	syscall\n"
-    "	popl  %ebp\n"
-    "	ret\n"
-    "syscall32_end:\n"
-
-    /* signal trampolines */
-
-    "sig32_rt_tramp:\n"
-    "	movl $"  __stringify(__NR_ia32_rt_sigreturn) ",%eax\n"
-    "   syscall\n"
-    "sig32_rt_tramp_end:\n"
-
-    "sig32_tramp:\n"
-    "	popl %eax\n"
-    "	movl $"  __stringify(__NR_ia32_sigreturn) ",%eax\n"
-    "	syscall\n"
-    "sig32_tramp_end:\n"
-    "	.code64\n"); 
-
-extern unsigned char syscall32[], syscall32_end[];
-extern unsigned char sig32_rt_tramp[], sig32_rt_tramp_end[];
-extern unsigned char sig32_tramp[], sig32_tramp_end[];
+/*
+ * These symbols are defined by ia32_vsyscall.o to mark the bounds
+ * of the ELF DSO image included therein.
+ */
+extern const char ia32_vsyscall_start, ia32_vsyscall_end;
 
 char *syscall32_page; 
 
@@ -75,11 +53,8 @@ static int __init init_syscall32(void)
 	if (!syscall32_page) 
 		panic("Cannot allocate syscall32 page"); 
 	SetPageReserved(virt_to_page(syscall32_page));
-	memcpy(syscall32_page, syscall32, syscall32_end - syscall32);
-	memcpy(syscall32_page + 32, sig32_rt_tramp, 
-	       sig32_rt_tramp_end - sig32_rt_tramp);
-	memcpy(syscall32_page + 64, sig32_tramp, 
-	       sig32_tramp_end - sig32_tramp);	
+	memcpy(syscall32_page, &ia32_vsyscall_start,
+	       &ia32_vsyscall_end - &ia32_vsyscall_start);
 	return 0;
 } 
 	
--- linux-2.5.69-1.1117/arch/x86_64/ia32/vsyscall32.S	Wed Dec 31 16:00:00 1969
+++ linux-2.5.69-1.1083/arch/x86_64/ia32/vsyscall32.S	Wed May 14 00:20:55 2003
@@ -0,0 +1,205 @@
+/*
+ * Code for the 32-bit vsyscall page.
+ */
+
+#include <asm/ia32_unistd.h>
+#include <asm/offset.h>
+
+
+	.text
+	.globl __kernel_vsyscall
+	.type __kernel_vsyscall,@function
+__kernel_vsyscall:
+.LSTART_vsyscall:
+	pushl %ebp
+.Lpush_ebp:
+	movl %ecx,%ebp
+	syscall
+	popl %ebp
+.Lpop_ebp:
+	ret
+.LEND_vsyscall:
+	.size __kernel_vsyscall,.-.LSTART_vsyscall
+	.previous
+
+	.section .eh_frame,"a",@progbits
+.LSTARTFRAMEDLSI:
+	.long .LENDCIEDLSI-.LSTARTCIEDLSI
+.LSTARTCIEDLSI:
+	.long 0			/* CIE ID */
+	.byte 1			/* Version number */
+	.string "zR"		/* NUL-terminated augmentation string */
+	.uleb128 1		/* Code alignment factor */
+	.sleb128 -4		/* Data alignment factor */
+	.byte 8			/* Return address register column */
+	.uleb128 1		/* Augmentation value length */
+	.byte 0x1b		/* DW_EH_PE_pcrel|DW_EH_PE_sdata4. */
+	.byte 0x0c		/* DW_CFA_def_cfa */
+	.uleb128 4
+	.uleb128 4
+	.byte 0x88		/* DW_CFA_offset, column 0x8 */
+	.uleb128 1
+	.align 4
+.LENDCIEDLSI:
+	.long .LENDFDEDLSI-.LSTARTFDEDLSI /* Length FDE */
+.LSTARTFDEDLSI:
+	.long .LSTARTFDEDLSI-.LSTARTFRAMEDLSI /* CIE pointer */
+	.long .LSTART_vsyscall-.	/* PC-relative start address */
+	.long .LEND_vsyscall-.LSTART_vsyscall
+	.uleb128 0
+	/* What follows are the instructions for the table generation.
+	   We have to record all changes of the stack pointer.  */
+	.byte 0x04		/* DW_CFA_advance_loc4 */
+	.long .Lpush_ebp-.LSTART_vsyscall
+	.byte 0x0e		/* DW_CFA_def_cfa_offset */
+	.byte 0x08		/* RA at offset 8 now */
+	.byte 0x04		/* DW_CFA_advance_loc4 */
+	/* Finally the epilogue.  */
+	.byte 0x04		/* DW_CFA_advance_loc4 */
+	.long .Lpop_ebp-.Lpush_ebp
+	.byte 0x0e		/* DW_CFA_def_cfa_offset */
+	.byte 0x04		/* RA at offset 4 now */
+	.byte 0xc5		/* DW_CFA_restore %ebp */
+	.align 4
+.LENDFDEDLSI:
+	.previous
+
+
+/* XXX
+   Should these be named "_sigtramp" or something?
+*/
+
+	.text
+	.balign 32
+	.globl __kernel_sigreturn
+	.type __kernel_sigreturn,@function
+__kernel_sigreturn:
+.LSTART_sigreturn:
+	popl %eax		/* XXX does this mean it needs unwind info? */
+	movl $__NR_ia32_sigreturn, %eax
+	syscall
+.LEND_sigreturn:
+	.size __kernel_sigreturn,.-.LSTART_sigreturn
+
+	.balign 32
+	.globl __kernel_rt_sigreturn
+	.type __kernel_rt_sigreturn,@function
+__kernel_rt_sigreturn:
+.LSTART_rt_sigreturn:
+	movl $__NR_ia32_rt_sigreturn, %eax
+	syscall
+.LEND_rt_sigreturn:
+	.size __kernel_rt_sigreturn,.-.LSTART_rt_sigreturn
+	.previous
+
+	.section .eh_frame,"a",@progbits
+.LSTARTFRAMEDLSI1:
+	.long .LENDCIEDLSI1-.LSTARTCIEDLSI1
+.LSTARTCIEDLSI1:
+	.long 0			/* CIE ID */
+	.byte 1			/* Version number */
+	.string "zR"		/* NUL-terminated augmentation string */
+	.uleb128 1		/* Code alignment factor */
+	.sleb128 -4		/* Data alignment factor */
+	.byte 8			/* Return address register column */
+	.uleb128 1		/* Augmentation value length */
+	.byte 0x1b		/* DW_EH_PE_pcrel|DW_EH_PE_sdata4. */
+	.byte 0			/* DW_CFA_nop */
+	.align 4
+.LENDCIEDLSI1:
+	.long .LENDFDEDLSI1-.LSTARTFDEDLSI1 /* Length FDE */
+.LSTARTFDEDLSI1:
+	.long .LSTARTFDEDLSI1-.LSTARTFRAMEDLSI1 /* CIE pointer */
+	/* HACK: The dwarf2 unwind routines will subtract 1 from the
+	   return address to get an address in the middle of the
+	   presumed call instruction.  Since we didn't get here via
+	   a call, we need to include the nop before the real start
+	   to make up for it.  */
+	.long .LSTART_sigreturn-1-.	/* PC-relative start address */
+	.long .LEND_sigreturn-.LSTART_sigreturn+1
+	.uleb128 0			/* Augmentation */
+	/* What follows are the instructions for the table generation.
+	   We record the locations of each register saved.  This is
+	   complicated by the fact that the "CFA" is always assumed to
+	   be the value of the stack pointer in the caller.  This means
+	   that we must define the CFA of this body of code to be the
+	   saved value of the stack pointer in the sigcontext.  Which
+	   also means that there is no fixed relation to the other
+	   saved registers, which means that we must use DW_CFA_expression
+	   to compute their addresses.  It also means that when we
+	   adjust the stack with the popl, we have to do it all over again.  */
+
+#define do_cfa_expr(offset)						\
+	.byte 0x0f;			/* DW_CFA_def_cfa_expression */	\
+	.uleb128 1f-0f;			/*   length */			\
+0:	.byte 0x74;			/*     DW_OP_breg4 */		\
+	.sleb128 offset;		/*      offset */		\
+	.byte 0x06;			/*     DW_OP_deref */		\
+1:
+
+#define do_expr(regno, offset)						\
+	.byte 0x10;			/* DW_CFA_expression */		\
+	.uleb128 regno;			/*   regno */			\
+	.uleb128 1f-0f;			/*   length */			\
+0:	.byte 0x74;			/*     DW_OP_breg4 */		\
+	.sleb128 offset;		/*       offset */		\
+1:
+
+	do_cfa_expr(IA32_SIGCONTEXT_esp+4)
+	do_expr(0, IA32_SIGCONTEXT_eax+4)
+	do_expr(1, IA32_SIGCONTEXT_ecx+4)
+	do_expr(2, IA32_SIGCONTEXT_edx+4)
+	do_expr(3, IA32_SIGCONTEXT_ebx+4)
+	do_expr(5, IA32_SIGCONTEXT_ebp+4)
+	do_expr(6, IA32_SIGCONTEXT_esi+4)
+	do_expr(7, IA32_SIGCONTEXT_edi+4)
+	do_expr(8, IA32_SIGCONTEXT_eip+4)
+
+	.byte 0x42	/* DW_CFA_advance_loc 2 -- nop; popl eax. */
+
+	do_cfa_expr(IA32_SIGCONTEXT_esp)
+	do_expr(0, IA32_SIGCONTEXT_eax)
+	do_expr(1, IA32_SIGCONTEXT_ecx)
+	do_expr(2, IA32_SIGCONTEXT_edx)
+	do_expr(3, IA32_SIGCONTEXT_ebx)
+	do_expr(5, IA32_SIGCONTEXT_ebp)
+	do_expr(6, IA32_SIGCONTEXT_esi)
+	do_expr(7, IA32_SIGCONTEXT_edi)
+	do_expr(8, IA32_SIGCONTEXT_eip)
+
+	.align 4
+.LENDFDEDLSI1:
+
+	.long .LENDFDEDLSI2-.LSTARTFDEDLSI2 /* Length FDE */
+.LSTARTFDEDLSI2:
+	.long .LSTARTFDEDLSI2-.LSTARTFRAMEDLSI1 /* CIE pointer */
+	/* HACK: See above wrt unwind library assumptions.  */
+	.long .LSTART_rt_sigreturn-1-.	/* PC-relative start address */
+	.long .LEND_rt_sigreturn-.LSTART_rt_sigreturn+1
+	.uleb128 0			/* Augmentation */
+	/* What follows are the instructions for the table generation.
+	   We record the locations of each register saved.  This is
+	   slightly less complicated than the above, since we don't
+	   modify the stack pointer in the process.  */
+
+	do_cfa_expr(IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_esp)
+	do_expr(0, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_eax)
+	do_expr(1, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_ecx)
+	do_expr(2, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_edx)
+	do_expr(3, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_ebx)
+	do_expr(5, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_ebp)
+	do_expr(6, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_esi)
+	do_expr(7, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_edi)
+	do_expr(8, IA32_RT_SIGFRAME_sigcontext-4 + IA32_SIGCONTEXT_eip)
+
+	.align 4
+.LENDFDEDLSI2:
+	.previous
+
+	/* These names are made available to the kernel.  */
+	.globl ia32_vsyscall
+	ia32_vsyscall = __kernel_vsyscall
+	.globl ia32_sigreturn
+	ia32_sigreturn = __kernel_sigreturn
+	.globl ia32_rt_sigreturn
+	ia32_rt_sigreturn = __kernel_rt_sigreturn
--- linux-2.5.69-1.1117/arch/x86_64/kernel/asm-offsets.c	Sun May  4 16:53:31 2003
+++ linux-2.5.69-1.1083/arch/x86_64/kernel/asm-offsets.c	Tue May 13 23:42:04 2003
@@ -12,6 +12,8 @@
 #include <asm/processor.h>
 #include <asm/segment.h>
 #include <asm/thread_info.h>
+#include <asm/ia32.h>
+#include "../ia32/sigframe.h"
 
 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -43,5 +45,20 @@ int main(void)
 	ENTRY(irqstackptr);
 	BLANK();
 #undef ENTRY
+
+	DEFINE(IA32_SIGCONTEXT_eax, offsetof (struct sigcontext_ia32, eax));
+	DEFINE(IA32_SIGCONTEXT_ebx, offsetof (struct sigcontext_ia32, ebx));
+	DEFINE(IA32_SIGCONTEXT_ecx, offsetof (struct sigcontext_ia32, ecx));
+	DEFINE(IA32_SIGCONTEXT_edx, offsetof (struct sigcontext_ia32, edx));
+	DEFINE(IA32_SIGCONTEXT_esi, offsetof (struct sigcontext_ia32, esi));
+	DEFINE(IA32_SIGCONTEXT_edi, offsetof (struct sigcontext_ia32, edi));
+	DEFINE(IA32_SIGCONTEXT_ebp, offsetof (struct sigcontext_ia32, ebp));
+	DEFINE(IA32_SIGCONTEXT_esp, offsetof (struct sigcontext_ia32, esp));
+	DEFINE(IA32_SIGCONTEXT_eip, offsetof (struct sigcontext_ia32, eip));
+	BLANK();
+
+	DEFINE(IA32_RT_SIGFRAME_sigcontext,
+	       offsetof (struct rt_sigframe, uc.uc_mcontext));
+
 	return 0;
 }
