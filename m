Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTEBAVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 20:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbTEBAVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 20:21:37 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39355 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262811AbTEBAVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 20:21:13 -0400
Date: Thu, 1 May 2003 17:33:30 -0700
Message-Id: <200305020033.h420XUi12295@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386 vsyscall DSO implementation, take 2
X-Fcc: ~/Mail/linus
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a small bug in the core dump changes in the patch I posted.  
I have fixed that.  The rest of the patch is unchanged.  AFAICT, people
like the idea, and this patch works well for me.  Can it go in?


Thanks,
Roland


--- stock-2.5.68/arch/i386/kernel/Makefile	Sat Apr 19 19:48:53 2003
+++ linux-2.5.68/arch/i386/kernel/Makefile	Wed Apr 23 21:03:25 2003
@@ -27,9 +27,29 @@ obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspen
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_MODULES)		+= module.o
-obj-y				+= sysenter.o
+obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 
 EXTRA_AFLAGS   := -traditional
 
 obj-$(CONFIG_SCx200)		+= scx200.o
+
+# vsyscall.o contains the vsyscall DSO images as __initdata.
+# We must build both images before we can assemble it.
+$(obj)/vsyscall.o: $(obj)/vsyscall-int80.so $(obj)/vsyscall-sysenter.so
+extra-y += $(foreach F,int80 sysenter,vsyscall-$F.o vsyscall-$F.so)
+
+# The DSO images are built using a special linker script.
+$(obj)/vsyscall-int80.so $(obj)/vsyscall-sysenter.so: \
+$(obj)/vsyscall-%.so: $(src)/vsyscall.lds $(obj)/vsyscall-%.o
+	$(CC) -nostdlib -shared -s -Wl,-soname=linux-vsyscall.so.1 \
+	      -o $@ -Wl,-T,$^
+
+# We also create a special relocatable object that should mirror the symbol
+# table and layout of the linked DSO.  With ld -R we can then refer to
+# these symbols in the kernel code rather than hand-coded addresses.
+extra-y += vsyscall-syms.o
+$(obj)/built-in.o: $(obj)/vsyscall-syms.o
+$(obj)/built-in.o: ld_flags += -R $(obj)/vsyscall-syms.o
+$(obj)/vsyscall-syms.o: $(src)/vsyscall.lds $(obj)/vsyscall-sysenter.o
+	$(CC) -nostdlib -r -o $@ -Wl,-T,$^
--- stock-2.5.68/arch/i386/kernel/entry.S	Sat Apr 19 19:48:56 2003
+++ linux-2.5.68/arch/i386/kernel/entry.S	Wed Apr 23 20:37:55 2003
@@ -230,8 +230,8 @@ need_resched:
 	jmp need_resched
 #endif
 
-/* Points to after the "sysenter" instruction in the vsyscall page */
-#define SYSENTER_RETURN 0xffffe010
+/* SYSENTER_RETURN points to after the "sysenter" instruction in
+   the vsyscall page.  See vsyscall-sysentry.S, which defines the symbol.  */
 
 	# sysenter call handler stub
 ENTRY(sysenter_entry)
--- stock-2.5.68/arch/i386/kernel/signal.c	Sat Apr 19 19:49:25 2003
+++ linux-2.5.68/arch/i386/kernel/signal.c	Wed Apr 23 20:35:43 2003
@@ -19,6 +19,7 @@
 #include <linux/stddef.h>
 #include <linux/personality.h>
 #include <linux/suspend.h>
+#include <linux/elf.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -347,6 +348,10 @@ get_sigframe(struct k_sigaction *ka, str
 	return (void __user *)((esp - frame_size) & -8ul);
 }
 
+/* These symbols are defined with the addresses in the vsyscall page.
+   See vsyscall-sigreturn.S.  */
+extern void __kernel_sigreturn, __kernel_rt_sigreturn;
+
 static void setup_frame(int sig, struct k_sigaction *ka,
 			sigset_t *set, struct pt_regs * regs)
 {
@@ -379,7 +384,7 @@ static void setup_frame(int sig, struct 
 	if (err)
 		goto give_sigsegv;
 
-	restorer = (void *) (fix_to_virt(FIX_VSYSCALL) + 32);
+	restorer = &__kernel_sigreturn;
 	if (ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
 
@@ -462,7 +467,7 @@ static void setup_rt_frame(int sig, stru
 		goto give_sigsegv;
 
 	/* Set up to return from userspace.  */
-	restorer = (void *) (fix_to_virt(FIX_VSYSCALL) + 64);
+	restorer = &__kernel_rt_sigreturn;
 	if (ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
 	err |= __put_user(restorer, &frame->pretcode);
--- stock-2.5.68/arch/i386/kernel/sysenter.c	Sat Apr 19 19:51:16 2003
+++ linux-2.5.68/arch/i386/kernel/sysenter.c	Wed Apr 23 02:16:02 2003
@@ -51,151 +51,30 @@ void enable_sep_cpu(void *info)
 	put_cpu();	
 }
 
+/*
+ * These symbols are defined by vsyscall.o to mark the bounds
+ * of the ELF DSO images included therein.
+ */
+extern const char vsyscall_int80_start, vsyscall_int80_end;
+extern const char vsyscall_sysenter_start, vsyscall_sysenter_end;
+
 static int __init sysenter_setup(void)
 {
-	static const char __initdata int80[] = {
-		0xcd, 0x80,		/* int $0x80 */
-		0xc3			/* ret */
-	};
-	/* Unwind information for the int80 code.  Keep track of
-	   where the return address is stored.  */
-	static const char __initdata int80_eh_frame[] = {
-	/* First the Common Information Entry (CIE):  */
-		0x14, 0x00, 0x00, 0x00,	/* Length of the CIE */
-		0x00, 0x00, 0x00, 0x00,	/* CIE Identifier Tag */
-		0x01,			/* CIE Version */
-		'z', 'R', 0x00,		/* CIE Augmentation */
-		0x01,			/* CIE Code Alignment Factor */
-		0x7c,			/* CIE Data Alignment Factor */
-		0x08,			/* CIE RA Column */
-		0x01,			/* Augmentation size */
-		0x1b,			/* FDE Encoding (pcrel sdata4) */
-		0x0c,			/* DW_CFA_def_cfa */
-		0x04,
-		0x04,
-		0x88,			/* DW_CFA_offset, column 0x8 */
-		0x01,
-		0x00,			/* padding */
-		0x00,
-	/* Now the FDE which contains the instructions for the frame.  */
-		0x0a, 0x00, 0x00, 0x00,	/* FDE Length */
-		0x1c, 0x00, 0x00, 0x00,	/* FDE CIE offset */
-	/* The PC-relative offset to the beginning of the code this
-	   FDE covers.  The computation below assumes that the offset
-	   can be represented in one byte.  Change if this is not true
-	   anymore.  The offset from the beginning of the .eh_frame
-	   is represented by EH_FRAME_OFFSET.  The word with the offset
-	   starts at byte 0x20 of the .eh_frame.  */
-		0x100 - (EH_FRAME_OFFSET + 0x20),
-		0xff, 0xff, 0xff,	/* FDE initial location */
-		3,			/* FDE address range */
-		0x00			/* Augmentation size */
-	/* The code does not change the stack pointer.  We need not
-	   record any operations.  */
-	};
-	static const char __initdata sysent[] = {
-		0x51,			/* push %ecx */
-		0x52,			/* push %edx */
-		0x55,			/* push %ebp */
-	/* 3: backjump target */
-		0x89, 0xe5,		/* movl %esp,%ebp */
-		0x0f, 0x34,		/* sysenter */
-
-	/* 7: align return point with nop's to make disassembly easier */
-		0x90, 0x90, 0x90, 0x90,
-		0x90, 0x90, 0x90,
-
-	/* 14: System call restart point is here! (SYSENTER_RETURN - 2) */
-		0xeb, 0xf3,		/* jmp to "movl %esp,%ebp" */
-	/* 16: System call normal return point is here! (SYSENTER_RETURN in entry.S) */
-		0x5d,			/* pop %ebp */
-		0x5a,			/* pop %edx */
-		0x59,			/* pop %ecx */
-		0xc3			/* ret */
-	};
-	/* Unwind information for the sysenter code.  Keep track of
-	   where the return address is stored.  */
-	static const char __initdata sysent_eh_frame[] = {
-	/* First the Common Information Entry (CIE):  */
-		0x14, 0x00, 0x00, 0x00,	/* Length of the CIE */
-		0x00, 0x00, 0x00, 0x00,	/* CIE Identifier Tag */
-		0x01,			/* CIE Version */
-		'z', 'R', 0x00,		/* CIE Augmentation */
-		0x01,			/* CIE Code Alignment Factor */
-		0x7c,			/* CIE Data Alignment Factor */
-		0x08,			/* CIE RA Column */
-		0x01,			/* Augmentation size */
-		0x1b,			/* FDE Encoding (pcrel sdata4) */
-		0x0c,			/* DW_CFA_def_cfa */
-		0x04,
-		0x04,
-		0x88,			/* DW_CFA_offset, column 0x8 */
-		0x01,
-		0x00,			/* padding */
-		0x00,
-	/* Now the FDE which contains the instructions for the frame.  */
-		0x22, 0x00, 0x00, 0x00,	/* FDE Length */
-		0x1c, 0x00, 0x00, 0x00,	/* FDE CIE offset */
-	/* The PC-relative offset to the beginning of the code this
-	   FDE covers.  The computation below assumes that the offset
-	   can be represented in one byte.  Change if this is not true
-	   anymore.  The offset from the beginning of the .eh_frame
-	   is represented by EH_FRAME_OFFSET.  The word with the offset
-	   starts at byte 0x20 of the .eh_frame.  */
-		0x100 - (EH_FRAME_OFFSET + 0x20),
-		0xff, 0xff, 0xff,	/* FDE initial location */
-		0x14, 0x00, 0x00, 0x00,	/* FDE address range */
-		0x00,			/* Augmentation size */
-	/* What follows are the instructions for the table generation.
-	   We have to record all changes of the stack pointer and
-	   callee-saved registers.  */
-		0x41,			/* DW_CFA_advance_loc+1, push %ecx */
-		0x0e,			/* DW_CFA_def_cfa_offset */
-		0x08,			/* RA at offset 8 now */
-		0x41,			/* DW_CFA_advance_loc+1, push %edx */
-		0x0e,			/* DW_CFA_def_cfa_offset */
-		0x0c,			/* RA at offset 12 now */
-		0x41,			/* DW_CFA_advance_loc+1, push %ebp */
-		0x0e,			/* DW_CFA_def_cfa_offset */
-		0x10,			/* RA at offset 16 now */
-		0x85, 0x04,		/* DW_CFA_offset %ebp -16 */
-	/* Finally the epilogue.  */
-		0x4e,			/* DW_CFA_advance_loc+14, pop %ebx */
-		0x0e,			/* DW_CFA_def_cfa_offset */
-		0x12,			/* RA at offset 12 now */
-		0xc5,			/* DW_CFA_restore %ebp */
-		0x41,			/* DW_CFA_advance_loc+1, pop %edx */
-		0x0e,			/* DW_CFA_def_cfa_offset */
-		0x08,			/* RA at offset 8 now */
-		0x41,			/* DW_CFA_advance_loc+1, pop %ecx */
-		0x0e,			/* DW_CFA_def_cfa_offset */
-		0x04			/* RA at offset 4 now */
-	};
-	static const char __initdata sigreturn[] = {
-	/* 32: sigreturn point */
-		0x58,				/* popl %eax */
-		0xb8, __NR_sigreturn, 0, 0, 0,	/* movl $__NR_sigreturn, %eax */
-		0xcd, 0x80,			/* int $0x80 */
-	};
-	static const char __initdata rt_sigreturn[] = {
-	/* 64: rt_sigreturn point */
-		0xb8, __NR_rt_sigreturn, 0, 0, 0,	/* movl $__NR_rt_sigreturn, %eax */
-		0xcd, 0x80,			/* int $0x80 */
-	};
 	unsigned long page = get_zeroed_page(GFP_ATOMIC);
 
 	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_READONLY);
-	memcpy((void *) page, int80, sizeof(int80));
-	memcpy((void *)(page + 32), sigreturn, sizeof(sigreturn));
-	memcpy((void *)(page + 64), rt_sigreturn, sizeof(rt_sigreturn));
-	memcpy((void *)(page + EH_FRAME_OFFSET), int80_eh_frame,
-	       sizeof(int80_eh_frame));
-	if (!boot_cpu_has(X86_FEATURE_SEP))
+
+	if (!boot_cpu_has(X86_FEATURE_SEP)) {
+		memcpy((void *) page,
+		       &vsyscall_int80_start,
+		       &vsyscall_int80_end - &vsyscall_int80_start);
 		return 0;
+	}
+
+	memcpy((void *) page,
+	       &vsyscall_sysenter_start,
+	       &vsyscall_sysenter_end - &vsyscall_sysenter_start);
 
-	memcpy((void *) page, sysent, sizeof(sysent));
-	memcpy((void *)(page + EH_FRAME_OFFSET), sysent_eh_frame,
-	       sizeof(sysent_eh_frame));
 	on_each_cpu(enable_sep_cpu, NULL, 1, 1);
 	return 0;
 }
--- stock-2.5.68/arch/i386/kernel/vsyscall-int80.S	Wed Dec 31 16:00:00 1969
+++ linux-2.5.68/arch/i386/kernel/vsyscall-int80.S	Wed Apr 23 20:41:41 2003
@@ -0,0 +1,48 @@
+/*
+ * Code for the vsyscall page.  This version uses the old int $0x80 method.
+ */
+
+	.text
+	.globl __kernel_vsyscall
+	.type __kernel_vsyscall,@function
+__kernel_vsyscall:
+.LSTART_vsyscall:
+	int $0x80
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
+	.align 4
+.LENDFDEDLSI:
+	.previous
+
+/*
+ * Get the common code for the sigreturn entry points.
+ */
+#include "vsyscall-sigreturn.S"
--- stock-2.5.68/arch/i386/kernel/vsyscall-sysenter.S	Wed Dec 31 16:00:00 1969
+++ linux-2.5.68/arch/i386/kernel/vsyscall-sysenter.S	Wed Apr 23 23:13:14 2003
@@ -0,0 +1,97 @@
+/*
+ * Code for the vsyscall page.  This version uses the sysenter instruction.
+ */
+
+	.text
+	.globl __kernel_vsyscall
+	.type __kernel_vsyscall,@function
+__kernel_vsyscall:
+.LSTART_vsyscall:
+	push %ecx
+.Lpush_ecx:
+	push %edx
+.Lpush_edx:
+	push %ebp
+.Lenter_kernel:
+	movl %esp,%ebp
+	sysenter
+
+	/* 7: align return point with nop's to make disassembly easier */
+	.space 7,0x90
+
+	/* 14: System call restart point is here! (SYSENTER_RETURN - 2) */
+	jmp .Lenter_kernel
+	/* 16: System call normal return point is here! */
+	.globl SYSENTER_RETURN	/* Symbol used by entry.S.  */
+SYSENTER_RETURN:
+	pop %ebp
+.Lpop_ebp:
+	pop %edx
+.Lpop_edx:
+	pop %ecx
+.Lpop_ecx:
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
+	.long .Lpush_ecx-.LSTART_vsyscall
+	.byte 0x0e		/* DW_CFA_def_cfa_offset */
+	.byte 0x08		/* RA at offset 8 now */
+	.byte 0x04		/* DW_CFA_advance_loc4 */
+	.long .Lpush_edx-.Lpush_ecx
+	.byte 0x0e		/* DW_CFA_def_cfa_offset */
+	.byte 0x0c		/* RA at offset 12 now */
+	.byte 0x04		/* DW_CFA_advance_loc4 */
+	.long .Lenter_kernel-.Lpush_edx
+	.byte 0x0e		/* DW_CFA_def_cfa_offset */
+	.byte 0x10		/* RA at offset 16 now */
+	/* Finally the epilogue.  */
+	.byte 0x04		/* DW_CFA_advance_loc4 */
+	.long .Lpop_ebp-.Lenter_kernel
+	.byte 0x0e		/* DW_CFA_def_cfa_offset */
+	.byte 0x12		/* RA at offset 12 now */
+	.byte 0x04		/* DW_CFA_advance_loc4 */
+	.long .Lpop_edx-.Lpop_ebp
+	.byte 0x0e		/* DW_CFA_def_cfa_offset */
+	.byte 0x08		/* RA at offset 8 now */
+	.byte 0x04		/* DW_CFA_advance_loc4 */
+	.long .Lpop_ecx-.Lpop_edx
+	.byte 0x0e		/* DW_CFA_def_cfa_offset */
+	.byte 0x04		/* RA at offset 4 now */
+	.align 4
+.LENDFDEDLSI:
+	.previous
+
+/*
+ * Get the common code for the sigreturn entry points.
+ */
+#include "vsyscall-sigreturn.S"
--- stock-2.5.68/arch/i386/kernel/vsyscall-sigreturn.S	Wed Dec 31 16:00:00 1969
+++ linux-2.5.68/arch/i386/kernel/vsyscall-sigreturn.S	Wed Apr 23 20:43:16 2003
@@ -0,0 +1,38 @@
+/*
+ * Common code for the sigreturn entry points on the vsyscall page.
+ * So far this code is the same for both int80 and sysenter versions.
+ * This file is #include'd by vsyscall-*.S to define them after the
+ * vsyscall entry point.  The addresses we get for these entry points
+ * by doing ".balign 32" must match in both versions of the page.
+ */
+
+#include <asm/unistd.h>
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
+.LSTART_kernel_sigreturn:
+	popl %eax		/* XXX does this mean it needs unwind info? */
+	movl $__NR_sigreturn, %eax
+	int $0x80
+.LEND_sigreturn:
+	.size __kernel_sigreturn,.-.LSTART_sigreturn
+
+	.text
+	.balign 32
+	.globl __kernel_rt_sigreturn
+	.type __kernel_rt_sigreturn,@function
+__kernel_rt_sigreturn:
+.LSTART_kernel_rt_sigreturn:
+	movl $__NR_rt_sigreturn, %eax
+	int $0x80
+.LEND_rt_sigreturn:
+	.size __kernel_rt_sigreturn,.-.LSTART_rt_sigreturn
+	.previous
--- stock-2.5.68/arch/i386/kernel/vsyscall.lds	Wed Dec 31 16:00:00 1969
+++ linux-2.5.68/arch/i386/kernel/vsyscall.lds	Wed Apr 23 20:59:12 2003
@@ -0,0 +1,67 @@
+/*
+ * Linker script for vsyscall DSO.  The vsyscall page is an ELF shared
+ * object prelinked to its virtual address, and with only one read-only
+ * segment (that fits in one page).  This script controls its layout.
+ */
+
+/* This must match <asm/fixmap.h>.  */
+VSYSCALL_BASE = 0xffffe000;
+
+SECTIONS
+{
+  . = VSYSCALL_BASE + SIZEOF_HEADERS;
+
+  .hash           : { *(.hash) }		:text
+  .dynsym         : { *(.dynsym) }
+  .dynstr         : { *(.dynstr) }
+  .gnu.version    : { *(.gnu.version) }
+  .gnu.version_d  : { *(.gnu.version_d) }
+  .gnu.version_r  : { *(.gnu.version_r) }
+
+  /* This linker script is used both with -r and with -shared.
+     For the layouts to match, we need to skip more than enough
+     space for the dynamic symbol table et al.  If this amount
+     is insufficient, ld -shared will barf.  Just increase it here.  */
+  . = VSYSCALL_BASE + 0x400;
+
+  .text           : { *(.text) }		:text =0x90909090
+
+  .eh_frame_hdr   : { *(.eh_frame_hdr) }	:text :eh_frame_hdr
+  .eh_frame       : { KEEP (*(.eh_frame)) }	:text
+  .dynamic        : { *(.dynamic) }		:text :dynamic
+  .useless        : {
+  	*(.got.plt) *(.got)
+	*(.data .data.* .gnu.linkonce.d.*)
+	*(.dynbss)
+	*(.bss .bss.* .gnu.linkonce.b.*)
+  }						:text
+}
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-only.
+ */
+PHDRS
+{
+  text PT_LOAD FILEHDR PHDRS FLAGS(5); /* PF_R|PF_X */
+  dynamic PT_DYNAMIC FLAGS(4); /* PF_R */
+  eh_frame_hdr 0x6474e550; /* PT_GNU_EH_FRAME, but ld doesn't match the name */
+}
+
+/*
+ * This controls what symbols we export from the DSO.
+ */
+VERSION
+{
+  LINUX_2.5 {
+    global:
+    	__kernel_vsyscall;
+    	__kernel_sigreturn;
+    	__kernel_rt_sigreturn;
+
+    local: *;
+  };
+}
+
+/* The ELF entry point can be used to set the AT_SYSINFO value.  */
+ENTRY(__kernel_vsyscall);
--- stock-2.5.68/fs/binfmt_elf.c	Sat Apr 19 19:49:23 2003
+++ linux-2.5.68/fs/binfmt_elf.c	Wed Apr 23 12:54:07 2003
@@ -1260,6 +1260,9 @@ static int elf_core_dump(long signr, str
 	elf_core_copy_regs(&prstatus->pr_reg, regs);
 	
 	segs = current->mm->map_count;
+#ifdef ELF_CORE_EXTRA_PHDRS
+	segs += ELF_CORE_EXTRA_PHDRS;
+#endif
 
 	/* Set up header */
 	fill_elf_header(elf, segs+1);	/* including notes section */
@@ -1340,6 +1343,10 @@ static int elf_core_dump(long signr, str
 		DUMP_WRITE(&phdr, sizeof(phdr));
 	}
 
+#ifdef ELF_CORE_WRITE_EXTRA_PHDRS
+	ELF_CORE_WRITE_EXTRA_PHDRS;
+#endif
+
  	/* write out the notes section */
 	for (i = 0; i < numnote; i++)
 		if (!writenote(notes + i, file))
@@ -1385,6 +1392,10 @@ static int elf_core_dump(long signr, str
 		}
 	}
 
+#ifdef ELF_CORE_WRITE_EXTRA_DATA
+	ELF_CORE_WRITE_EXTRA_DATA;
+#endif
+
 	if ((off_t) file->f_pos != offset) {
 		/* Sanity check */
 		printk("elf_core_dump: file->f_pos (%ld) != offset (%ld)\n",
--- stock-2.5.68/include/linux/elf.h	Sat Apr 19 19:48:52 2003
+++ linux-2.5.68/include/linux/elf.h	Wed Apr 23 02:48:09 2003
@@ -29,8 +29,11 @@ typedef __s64	Elf64_Sxword;
 #define PT_NOTE    4
 #define PT_SHLIB   5
 #define PT_PHDR    6
+#define PT_LOOS	   0x60000000
+#define PT_HIOS	   0x6fffffff
 #define PT_LOPROC  0x70000000
 #define PT_HIPROC  0x7fffffff
+#define PT_GNU_EH_FRAME		0x6474e550
 #define PT_MIPS_REGINFO		0x70000000
 
 /* Flags in the e_flags field of the header */
--- stock-2.5.68/include/asm-i386/elf.h	Sat Apr 19 19:50:08 2003
+++ linux-2.5.68/include/asm-i386/elf.h	Thu Apr 24 23:24:32 2003
@@ -101,7 +101,7 @@ typedef struct user_fxsr_struct elf_fpxr
  * for more of them, start the x86-specific ones at 32.
  */
 #define AT_SYSINFO		32
-#define AT_SYSINFO_EH_FRAME	33
+#define AT_SYSINFO_EHDR		33
 
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
@@ -119,15 +119,56 @@ extern void dump_smp_unlazy_fpu(void);
 #define ELF_CORE_SYNC dump_smp_unlazy_fpu
 #endif
 
-/* Offset from the beginning of the page where the .eh_frame information
-   for the code in the vsyscall page starts.  */
-#define EH_FRAME_OFFSET 96
+#define VSYSCALL_BASE	(__fix_to_virt(FIX_VSYSCALL))
+#define VSYSCALL_EHDR	((const struct elfhdr *) VSYSCALL_BASE)
+#define VSYSCALL_ENTRY	((unsigned long) &__kernel_vsyscall)
+extern void __kernel_vsyscall;
 
 #define ARCH_DLINFO						\
 do {								\
-		NEW_AUX_ENT(AT_SYSINFO, 0xffffe000);		\
-		NEW_AUX_ENT(AT_SYSINFO_EH_FRAME,		\
-			    0xffffe000 + EH_FRAME_OFFSET);	\
+		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);	\
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, VSYSCALL_BASE);	\
+} while (0)
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
+		(const struct elf_phdr *) (VSYSCALL_BASE		      \
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
+		(const struct elf_phdr *) (VSYSCALL_BASE		      \
+					   + VSYSCALL_EHDR->e_phoff);	      \
+	int i;								      \
+	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
+		if (vsyscall_phdrs[i].p_type == PT_LOAD)		      \
+			DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,	      \
+				   vsyscall_phdrs[i].p_filesz);		      \
+	}								      \
 } while (0)
 
 #endif
