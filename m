Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTEDGJI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 02:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTEDGJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 02:09:08 -0400
Received: from are.twiddle.net ([64.81.246.98]:53138 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S263527AbTEDGJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 02:09:01 -0400
Date: Sat, 3 May 2003 23:21:24 -0700
From: Richard Henderson <rth@twiddle.net>
To: Roland McGrath <roland@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix vsyscall unwind information
Message-ID: <20030504062124.GA32457@twiddle.net>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <200305020033.h420XUi12295@magilla.sf.frob.com> <20030503205159.GA29384@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030503205159.GA29384@twiddle.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-adds the %ebp save/restore correction I'd given Uli when the 
unwind information went into sysenter.c, which somehow got lost
with Roland's reorg.

Also adds unwind info for the sigreturn entry points.  This can
be used instead of special-case hacks currently in libgcc and 
gdb, and by extension allows the kernel to change these entry
points without breaking userland.

Tested with Roland's patch to make the VDSO available in glibc,
plus a set of fixes to libgcc, since location expressions hadn't
ever been tested before in this context.

Linus, please pull from 

	bk://are.twiddle.net/unwind-2.5


r~



 arch/i386/Makefile                    |    9 ++
 arch/i386/kernel/asm-offsets.c        |   31 +++++++++
 arch/i386/kernel/sigframe.h           |   21 ++++++
 arch/i386/kernel/signal.c             |   23 -------
 arch/i386/kernel/vsyscall-sigreturn.S |  110 +++++++++++++++++++++++++++++++++-
 arch/i386/kernel/vsyscall-sysenter.S  |    2 
 6 files changed, 171 insertions(+), 25 deletions(-)

through these ChangeSets:

<rth@eeyore.twiddle.net> (03/05/03 1.1209)
   Fix unwind info for sysenter entry point.
   Add unwind info for sigreturn entry points.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1208  -> 1.1209 
#	  arch/i386/Makefile	1.49    -> 1.50   
#	arch/i386/kernel/vsyscall-sysenter.S	1.1     -> 1.2    
#	arch/i386/kernel/signal.c	1.30    -> 1.31   
#	arch/i386/kernel/vsyscall-sigreturn.S	1.1     -> 1.2    
#	               (new)	        -> 1.1     arch/i386/kernel/sigframe.h
#	               (new)	        -> 1.1     arch/i386/kernel/asm-offsets.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/03	rth@eeyore.twiddle.net	1.1209
# Fix unwind info for sysenter entry point.
# Add unwind info for sigreturn entry points.
# --------------------------------------------
#
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Sat May  3 23:03:13 2003
+++ b/arch/i386/Makefile	Sat May  3 23:03:13 2003
@@ -114,6 +114,15 @@
 install fdimage fdimage144 fdimage288: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@
 
+prepare: include/asm-$(ARCH)/asm_offsets.h
+CLEAN_FILES += include/asm-$(ARCH)/asm_offsets.h
+
+arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
+				   include/config/MARKER
+
+include/asm-$(ARCH)/asm_offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
+	$(call filechk,gen-asm-offsets)
+
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/i386/boot
 
diff -Nru a/arch/i386/kernel/asm-offsets.c b/arch/i386/kernel/asm-offsets.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/asm-offsets.c	Sat May  3 23:03:13 2003
@@ -0,0 +1,31 @@
+/*
+ * Generate definitions needed by assembly language modules.
+ * This code generates raw asm output which is post-processed
+ * to extract and format the required data.
+ */
+
+#include <linux/signal.h>
+#include <asm/ucontext.h>
+#include "sigframe.h"
+
+#define DEFINE(sym, val) \
+        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+void foo(void)
+{
+	DEFINE(SIGCONTEXT_eax, offsetof (struct sigcontext, eax));
+	DEFINE(SIGCONTEXT_ebx, offsetof (struct sigcontext, ebx));
+	DEFINE(SIGCONTEXT_ecx, offsetof (struct sigcontext, ecx));
+	DEFINE(SIGCONTEXT_edx, offsetof (struct sigcontext, edx));
+	DEFINE(SIGCONTEXT_esi, offsetof (struct sigcontext, esi));
+	DEFINE(SIGCONTEXT_edi, offsetof (struct sigcontext, edi));
+	DEFINE(SIGCONTEXT_ebp, offsetof (struct sigcontext, ebp));
+	DEFINE(SIGCONTEXT_esp, offsetof (struct sigcontext, esp));
+	DEFINE(SIGCONTEXT_eip, offsetof (struct sigcontext, eip));
+	BLANK();
+
+	DEFINE(RT_SIGFRAME_sigcontext,
+	       offsetof (struct rt_sigframe, uc.uc_mcontext));
+}
diff -Nru a/arch/i386/kernel/sigframe.h b/arch/i386/kernel/sigframe.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/sigframe.h	Sat May  3 23:03:13 2003
@@ -0,0 +1,21 @@
+struct sigframe
+{
+	char *pretcode;
+	int sig;
+	struct sigcontext sc;
+	struct _fpstate fpstate;
+	unsigned long extramask[_NSIG_WORDS-1];
+	char retcode[8];
+};
+
+struct rt_sigframe
+{
+	char *pretcode;
+	int sig;
+	struct siginfo *pinfo;
+	void *puc;
+	struct siginfo info;
+	struct ucontext uc;
+	struct _fpstate fpstate;
+	char retcode[8];
+};
diff -Nru a/arch/i386/kernel/signal.c b/arch/i386/kernel/signal.c
--- a/arch/i386/kernel/signal.c	Sat May  3 23:03:13 2003
+++ b/arch/i386/kernel/signal.c	Sat May  3 23:03:13 2003
@@ -23,6 +23,7 @@
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
+#include "sigframe.h"
 
 #define DEBUG_SIG 0
 
@@ -125,28 +126,6 @@
 /*
  * Do a signal return; undo the signal stack.
  */
-
-struct sigframe
-{
-	char *pretcode;
-	int sig;
-	struct sigcontext sc;
-	struct _fpstate fpstate;
-	unsigned long extramask[_NSIG_WORDS-1];
-	char retcode[8];
-};
-
-struct rt_sigframe
-{
-	char *pretcode;
-	int sig;
-	struct siginfo *pinfo;
-	void *puc;
-	struct siginfo info;
-	struct ucontext uc;
-	struct _fpstate fpstate;
-	char retcode[8];
-};
 
 static int
 restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc, int *peax)
diff -Nru a/arch/i386/kernel/vsyscall-sigreturn.S b/arch/i386/kernel/vsyscall-sigreturn.S
--- a/arch/i386/kernel/vsyscall-sigreturn.S	Sat May  3 23:03:13 2003
+++ b/arch/i386/kernel/vsyscall-sigreturn.S	Sat May  3 23:03:13 2003
@@ -7,6 +7,7 @@
  */
 
 #include <asm/unistd.h>
+#include <asm/asm_offsets.h>
 
 
 /* XXX
@@ -18,21 +19,124 @@
 	.globl __kernel_sigreturn
 	.type __kernel_sigreturn,@function
 __kernel_sigreturn:
-.LSTART_kernel_sigreturn:
+.LSTART_sigreturn:
 	popl %eax		/* XXX does this mean it needs unwind info? */
 	movl $__NR_sigreturn, %eax
 	int $0x80
 .LEND_sigreturn:
 	.size __kernel_sigreturn,.-.LSTART_sigreturn
 
-	.text
 	.balign 32
 	.globl __kernel_rt_sigreturn
 	.type __kernel_rt_sigreturn,@function
 __kernel_rt_sigreturn:
-.LSTART_kernel_rt_sigreturn:
+.LSTART_rt_sigreturn:
 	movl $__NR_rt_sigreturn, %eax
 	int $0x80
 .LEND_rt_sigreturn:
 	.size __kernel_rt_sigreturn,.-.LSTART_rt_sigreturn
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
+	do_cfa_expr(SIGCONTEXT_esp+4)
+	do_expr(0, SIGCONTEXT_eax+4)
+	do_expr(1, SIGCONTEXT_ecx+4)
+	do_expr(2, SIGCONTEXT_edx+4)
+	do_expr(3, SIGCONTEXT_ebx+4)
+	do_expr(5, SIGCONTEXT_ebp+4)
+	do_expr(6, SIGCONTEXT_esi+4)
+	do_expr(7, SIGCONTEXT_edi+4)
+	do_expr(8, SIGCONTEXT_eip+4)
+
+	.byte 0x42	/* DW_CFA_advance_loc 2 -- nop; popl eax. */
+
+	do_cfa_expr(SIGCONTEXT_esp)
+	do_expr(0, SIGCONTEXT_eax)
+	do_expr(1, SIGCONTEXT_ecx)
+	do_expr(2, SIGCONTEXT_edx)
+	do_expr(3, SIGCONTEXT_ebx)
+	do_expr(5, SIGCONTEXT_ebp)
+	do_expr(6, SIGCONTEXT_esi)
+	do_expr(7, SIGCONTEXT_edi)
+	do_expr(8, SIGCONTEXT_eip)
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
+	do_cfa_expr(RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_esp)
+	do_expr(0, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_eax)
+	do_expr(1, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_ecx)
+	do_expr(2, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_edx)
+	do_expr(3, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_ebx)
+	do_expr(5, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_ebp)
+	do_expr(6, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_esi)
+	do_expr(7, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_edi)
+	do_expr(8, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_eip)
+
+	.align 4
+.LENDFDEDLSI2:
 	.previous
diff -Nru a/arch/i386/kernel/vsyscall-sysenter.S b/arch/i386/kernel/vsyscall-sysenter.S
--- a/arch/i386/kernel/vsyscall-sysenter.S	Sat May  3 23:03:13 2003
+++ b/arch/i386/kernel/vsyscall-sysenter.S	Sat May  3 23:03:13 2003
@@ -74,11 +74,13 @@
 	.long .Lenter_kernel-.Lpush_edx
 	.byte 0x0e		/* DW_CFA_def_cfa_offset */
 	.byte 0x10		/* RA at offset 16 now */
+	.byte 0x85, 0x04	/* DW_CFA_offset %ebp -16 */
 	/* Finally the epilogue.  */
 	.byte 0x04		/* DW_CFA_advance_loc4 */
 	.long .Lpop_ebp-.Lenter_kernel
 	.byte 0x0e		/* DW_CFA_def_cfa_offset */
 	.byte 0x12		/* RA at offset 12 now */
+	.byte 0xc5		/* DW_CFA_restore %ebp */
 	.byte 0x04		/* DW_CFA_advance_loc4 */
 	.long .Lpop_edx-.Lpop_ebp
 	.byte 0x0e		/* DW_CFA_def_cfa_offset */
