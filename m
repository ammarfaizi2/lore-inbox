Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264096AbUDGExp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 00:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbUDGExp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 00:53:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:62938 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263140AbUDGEx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 00:53:29 -0400
Date: Tue, 6 Apr 2004 22:46:57 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: bgerst@didntduck.org
Subject: Re: [PATCH] use EFLAGS #defines instead of inline constants
Message-Id: <20040406224657.45b7c83f.rddunlap@osdl.org>
In-Reply-To: <20040405170419.1f2fc143.rddunlap@osdl.org>
References: <20040405170419.1f2fc143.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| From: Brian Gerst
| 
| Randy.Dunlap wrote:
| > // linux-2.6.5
| > // use x86 EFLAGS defines in place of inline constants;
| > 
| > diffstat:=
| >  arch/i386/kernel/doublefault.c |    3 ++-
| >  arch/i386/kernel/process.c     |    2 +-
| >  arch/i386/kernel/signal.c      |    7 ++++++-
| >  3 files changed, 9 insertions(+), 3 deletions(-)
|
...
| 
| kernel_thread() doesn't really needs PF and SF.  They are just result 
| flags that nothing should depend on.  Some additional suggestions are 
| cleanup the vm86 code to use the defines from processor.h instead of its 
| own, and moving FIX_EFLAGS to processor.h (rename it X86_EFLAGS_USER or 
| something).

Hi,

Thanks for the comments.  Here's an updated patch.
More comments?

--
~Randy


// linux-2.6.5
// use x86 EFLAGS register defines instead of inline constants;

diffstat:=
 arch/i386/kernel/doublefault.c |    3 +-
 arch/i386/kernel/ioport.c      |    6 +++--
 arch/i386/kernel/process.c     |    2 -
 arch/i386/kernel/signal.c      |   10 +++++----
 arch/i386/kernel/traps.c       |   12 +++++------
 arch/i386/kernel/vm86.c        |   43 +++++++++++++++++++++++------------------
 arch/i386/mm/fault.c           |    7 +++---
 include/asm-i386/processor.h   |    4 +++
 include/asm-i386/ptrace.h      |    2 -
 include/asm-i386/vm86.h        |   12 -----------
 10 files changed, 54 insertions(+), 47 deletions(-)


diff -Naurp ./arch/i386/kernel/doublefault.c~use_eflags ./arch/i386/kernel/doublefault.c
--- ./arch/i386/kernel/doublefault.c~use_eflags	2004-03-10 18:55:22.000000000 -0800
+++ ./arch/i386/kernel/doublefault.c	2004-04-01 21:10:04.000000000 -0800
@@ -6,6 +6,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
+#include <asm/processor.h>
 #include <asm/desc.h>
 
 #define DOUBLEFAULT_STACKSIZE (1024)
@@ -53,7 +54,7 @@ struct tss_struct doublefault_tss __cach
 	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,
 
 	.eip		= (unsigned long) doublefault_fn,
-	.eflags		= 0x00000082,
+	.eflags		= X86_EFLAGS_SF | 0x2,	/* 0x2 bit is always set */
 	.esp		= STACK_START,
 	.es		= __USER_DS,
 	.cs		= __KERNEL_CS,
diff -Naurp ./arch/i386/kernel/process.c~use_eflags ./arch/i386/kernel/process.c
--- ./arch/i386/kernel/process.c~use_eflags	2004-03-30 17:41:30.000000000 -0800
+++ ./arch/i386/kernel/process.c	2004-04-06 21:23:05.000000000 -0700
@@ -278,7 +278,7 @@ int kernel_thread(int (*fn)(void *), voi
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
 	regs.xcs = __KERNEL_CS;
-	regs.eflags = 0x286;
+	regs.eflags = X86_EFLAGS_IF | 0x2;
 
 	/* Ok, create the new process.. */
 	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
diff -Naurp ./arch/i386/kernel/signal.c~use_eflags ./arch/i386/kernel/signal.c
--- ./arch/i386/kernel/signal.c~use_eflags	2004-03-10 18:55:26.000000000 -0800
+++ ./arch/i386/kernel/signal.c	2004-04-06 22:08:36.000000000 -0700
@@ -20,6 +20,7 @@
 #include <linux/personality.h>
 #include <linux/suspend.h>
 #include <linux/elf.h>
+#include <asm/processor.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -170,7 +171,8 @@ restore_sigcontext(struct pt_regs *regs,
 	{
 		unsigned int tmpflags;
 		err |= __get_user(tmpflags, &sc->eflags);
-		regs->eflags = (regs->eflags & ~0x40DD5) | (tmpflags & 0x40DD5);
+		regs->eflags = (regs->eflags & ~X86_EFLAGS_USER) |
+				(tmpflags & X86_EFLAGS_USER);
 		regs->orig_eax = -1;		/* disable syscall checks */
 	}
 
@@ -401,7 +403,7 @@ static void setup_frame(int sig, struct 
 	regs->xes = __USER_DS;
 	regs->xss = __USER_DS;
 	regs->xcs = __USER_CS;
-	regs->eflags &= ~TF_MASK;
+	regs->eflags &= ~X86_EFLAGS_TF;
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
@@ -482,7 +484,7 @@ static void setup_rt_frame(int sig, stru
 	regs->xes = __USER_DS;
 	regs->xss = __USER_DS;
 	regs->xcs = __USER_CS;
-	regs->eflags &= ~TF_MASK;
+	regs->eflags &= ~X86_EFLAGS_TF;
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
@@ -615,7 +617,7 @@ void do_notify_resume(struct pt_regs *re
 {
 	/* Pending single-step? */
 	if (thread_info_flags & _TIF_SINGLESTEP) {
-		regs->eflags |= TF_MASK;
+		regs->eflags |= X86_EFLAGS_TF;
 		clear_thread_flag(TIF_SINGLESTEP);
 	}
 	/* deal with pending signal delivery */
diff -Naurp ./arch/i386/kernel/vm86.c~use_eflags ./arch/i386/kernel/vm86.c
--- ./arch/i386/kernel/vm86.c~use_eflags	2004-03-10 18:55:22.000000000 -0800
+++ ./arch/i386/kernel/vm86.c	2004-04-06 22:16:06.000000000 -0700
@@ -45,6 +45,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
+#include <asm/processor.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 #include <asm/irq.h>
@@ -86,8 +87,12 @@
 #define set_flags(X,new,mask) \
 ((X) = ((X) & ~(mask)) | ((new) & (mask)))
 
-#define SAFE_MASK	(0xDD5)
-#define RETURN_MASK	(0xDFF)
+#define SAFE_MASK      (X86_EFLAGS_OF | X86_EFLAGS_DF | X86_EFLAGS_TF | \
+			X86_EFLAGS_SF | X86_EFLAGS_ZF | X86_EFLAGS_AF | \
+			X86_EFLAGS_PF | X86_EFLAGS_CF)
+#define RETURN_MASK    (X86_EFLAGS_OF | X86_EFLAGS_DF | X86_EFLAGS_TF | \
+			X86_EFLAGS_SF | X86_EFLAGS_ZF | 0x20 | X86_EFLAGS_AF | \
+			0x8 | X86_EFLAGS_PF | 0x2 | X86_EFLAGS_CF)
 
 #define VM86_REGS_PART2 orig_eax
 #define VM86_REGS_SIZE1 \
@@ -112,7 +117,7 @@ struct pt_regs * fastcall save_v86_state
 		printk("no vm86_info: BAD\n");
 		do_exit(SIGSEGV);
 	}
-	set_flags(regs->eflags, VEFLAGS, VIF_MASK | current->thread.v86mask);
+	set_flags(regs->eflags, VEFLAGS, X86_EFLAGS_VIF | current->thread.v86mask);
 	tmp = copy_to_user(&current->thread.vm86_info->regs,regs, VM86_REGS_SIZE1);
 	tmp += copy_to_user(&current->thread.vm86_info->regs.VM86_REGS_PART2,
 		&regs->VM86_REGS_PART2, VM86_REGS_SIZE2);
@@ -276,20 +281,22 @@ static void do_sys_vm86(struct kernel_vm
  	VEFLAGS = info->regs.eflags;
 	info->regs.eflags &= SAFE_MASK;
 	info->regs.eflags |= info->regs32->eflags & ~SAFE_MASK;
-	info->regs.eflags |= VM_MASK;
+	info->regs.eflags |= X86_EFLAGS_VM;
 
 	switch (info->cpu_type) {
 		case CPU_286:
 			tsk->thread.v86mask = 0;
 			break;
 		case CPU_386:
-			tsk->thread.v86mask = NT_MASK | IOPL_MASK;
+			tsk->thread.v86mask = X86_EFLAGS_NT | X86_EFLAGS_IOPL;
 			break;
 		case CPU_486:
-			tsk->thread.v86mask = AC_MASK | NT_MASK | IOPL_MASK;
+			tsk->thread.v86mask = X86_EFLAGS_AC |
+				X86_EFLAGS_NT | X86_EFLAGS_IOPL;
 			break;
 		default:
-			tsk->thread.v86mask = ID_MASK | AC_MASK | NT_MASK | IOPL_MASK;
+			tsk->thread.v86mask = X86_EFLAGS_ID |X86_EFLAGS_AC |
+				X86_EFLAGS_NT | X86_EFLAGS_IOPL;
 			break;
 	}
 
@@ -335,24 +342,24 @@ static inline void return_to_32bit(struc
 
 static inline void set_IF(struct kernel_vm86_regs * regs)
 {
-	VEFLAGS |= VIF_MASK;
-	if (VEFLAGS & VIP_MASK)
+	VEFLAGS |= X86_EFLAGS_VIF;
+	if (VEFLAGS & X86_EFLAGS_VIP)
 		return_to_32bit(regs, VM86_STI);
 }
 
 static inline void clear_IF(struct kernel_vm86_regs * regs)
 {
-	VEFLAGS &= ~VIF_MASK;
+	VEFLAGS &= ~X86_EFLAGS_VIF;
 }
 
 static inline void clear_TF(struct kernel_vm86_regs * regs)
 {
-	regs->eflags &= ~TF_MASK;
+	regs->eflags &= ~X86_EFLAGS_TF;
 }
 
 static inline void clear_AC(struct kernel_vm86_regs * regs)
 {
-	regs->eflags &= ~AC_MASK;
+	regs->eflags &= ~X86_EFLAGS_AC;
 }
 
 /* It is correct to call set_IF(regs) from the set_vflags_*
@@ -370,7 +377,7 @@ static inline void set_vflags_long(unsig
 {
 	set_flags(VEFLAGS, eflags, current->thread.v86mask);
 	set_flags(regs->eflags, eflags, SAFE_MASK);
-	if (eflags & IF_MASK)
+	if (eflags & X86_EFLAGS_IF)
 		set_IF(regs);
 	else
 		clear_IF(regs);
@@ -380,7 +387,7 @@ static inline void set_vflags_short(unsi
 {
 	set_flags(VFLAGS, flags, current->thread.v86mask);
 	set_flags(regs->eflags, flags, SAFE_MASK);
-	if (flags & IF_MASK)
+	if (flags & X86_EFLAGS_IF)
 		set_IF(regs);
 	else
 		clear_IF(regs);
@@ -390,8 +397,8 @@ static inline unsigned long get_vflags(s
 {
 	unsigned long flags = regs->eflags & RETURN_MASK;
 
-	if (VEFLAGS & VIF_MASK)
-		flags |= IF_MASK;
+	if (VEFLAGS & X86_EFLAGS_VIF)
+		flags |= X86_EFLAGS_IF;
 	return flags | (VEFLAGS & current->thread.v86mask);
 }
 
@@ -547,9 +554,9 @@ void handle_vm86_fault(struct kernel_vm8
 
 #define CHECK_IF_IN_TRAP \
 	if (VMPI.vm86dbg_active && VMPI.vm86dbg_TFpendig) \
-		newflags |= TF_MASK
+		newflags |= X86_EFLAGS_TF
 #define VM86_FAULT_RETURN do { \
-	if (VMPI.force_return_for_pic  && (VEFLAGS & (IF_MASK | VIF_MASK))) \
+	if (VMPI.force_return_for_pic && (VEFLAGS & (X86_EFLAGS_IF | X86_EFLAGS_VIF))) \
 		return_to_32bit(regs, VM86_PICRETURN); \
 	return; } while (0)
 
diff -Naurp ./arch/i386/kernel/traps.c~use_eflags ./arch/i386/kernel/traps.c
--- ./arch/i386/kernel/traps.c~use_eflags	2004-03-30 17:41:30.000000000 -0800
+++ ./arch/i386/kernel/traps.c	2004-04-06 21:38:29.000000000 -0700
@@ -295,7 +295,7 @@ void die(const char * str, struct pt_reg
 
 static inline void die_if_kernel(const char * str, struct pt_regs * regs, long err)
 {
-	if (!(regs->eflags & VM_MASK) && !(3 & regs->xcs))
+	if (!(regs->eflags & X86_EFLAGS_VM) && !(3 & regs->xcs))
 		die(str, regs, err);
 }
 
@@ -311,7 +311,7 @@ static inline unsigned long get_cr2(void
 static inline void do_trap(int trapnr, int signr, char *str, int vm86,
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
-	if (regs->eflags & VM_MASK) {
+	if (regs->eflags & X86_EFLAGS_VM) {
 		if (vm86)
 			goto vm86_trap;
 		goto trap_signal;
@@ -394,7 +394,7 @@ asmlinkage void do_general_protection(st
 	if (regs->eflags & X86_EFLAGS_IF)
 		local_irq_enable();
  
-	if (regs->eflags & VM_MASK)
+	if (regs->eflags & X86_EFLAGS_VM)
 		goto gp_in_vm86;
 
 	if (!(regs->xcs & 3))
@@ -557,7 +557,7 @@ asmlinkage void do_debug(struct pt_regs 
 			goto clear_dr7;
 	}
 
-	if (regs->eflags & VM_MASK)
+	if (regs->eflags & X86_EFLAGS_VM)
 		goto debug_vm86;
 
 	/* Save debug status register where ptrace can see it */
@@ -610,7 +610,7 @@ debug_vm86:
 clear_TF_reenable:
 	set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
 clear_TF:
-	regs->eflags &= ~TF_MASK;
+	regs->eflags &= ~X86_EFLAGS_TF;
 	return;
 }
 
@@ -741,7 +741,7 @@ asmlinkage void do_simd_coprocessor_erro
 		 * Handle strange cache flush from user space exception
 		 * in all other cases.  This is undocumented behaviour.
 		 */
-		if (regs->eflags & VM_MASK) {
+		if (regs->eflags & X86_EFLAGS_VM) {
 			handle_vm86_fault((struct kernel_vm86_regs *)regs,
 					  error_code);
 			return;
diff -Naurp ./arch/i386/kernel/ioport.c~use_eflags ./arch/i386/kernel/ioport.c
--- ./arch/i386/kernel/ioport.c~use_eflags	2004-03-10 18:55:27.000000000 -0800
+++ ./arch/i386/kernel/ioport.c	2004-04-06 21:54:52.000000000 -0700
@@ -16,6 +16,8 @@
 #include <linux/slab.h>
 #include <linux/thread_info.h>
 
+#include <asm/processor.h>
+
 /* Set EXTENT bits starting at BASE in BITMAP to value TURN_ON. */
 static void set_bitmap(unsigned long *bitmap, unsigned int base, unsigned int extent, int new_value)
 {
@@ -109,7 +111,7 @@ asmlinkage long sys_iopl(unsigned long u
 {
 	volatile struct pt_regs * regs = (struct pt_regs *) &unused;
 	unsigned int level = regs->ebx;
-	unsigned int old = (regs->eflags >> 12) & 3;
+	unsigned int old = (regs->eflags & X86_EFLAGS_IOPL) >> 12;
 
 	if (level > 3)
 		return -EINVAL;
@@ -118,7 +120,7 @@ asmlinkage long sys_iopl(unsigned long u
 		if (!capable(CAP_SYS_RAWIO))
 			return -EPERM;
 	}
-	regs->eflags = (regs->eflags &~ 0x3000UL) | (level << 12);
+	regs->eflags = (regs->eflags & ~X86_EFLAGS_IOPL) | (level << 12);
 	/* Make sure we return the long way (not sysenter) */
 	set_thread_flag(TIF_IRET);
 	return 0;
diff -Naurp ./arch/i386/mm/fault.c~use_eflags ./arch/i386/mm/fault.c
--- ./arch/i386/mm/fault.c~use_eflags	2004-03-10 18:55:20.000000000 -0800
+++ ./arch/i386/mm/fault.c	2004-04-06 21:58:12.000000000 -0700
@@ -25,6 +25,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
+#include <asm/processor.h>
 #include <asm/hardirq.h>
 #include <asm/desc.h>
 
@@ -81,7 +82,7 @@ static inline unsigned long get_segment_
 	*eip_limit = (seg & 3) ? USER_DS.seg : KERNEL_DS.seg;
 
 	/* Unlikely, but must come before segment checks. */
-	if (unlikely((regs->eflags & VM_MASK) != 0))
+	if (unlikely((regs->eflags & X86_EFLAGS_VM) != 0))
 		return eip + (seg << 4);
 	
 	/* By far the most common cases. */
@@ -223,7 +224,7 @@ asmlinkage void do_page_fault(struct pt_
 	__asm__("movl %%cr2,%0":"=r" (address));
 
 	/* It's safe to allow irq's after cr2 has been saved */
-	if (regs->eflags & (X86_EFLAGS_IF|VM_MASK))
+	if (regs->eflags & (X86_EFLAGS_IF | X86_EFLAGS_VM))
 		local_irq_enable();
 
 	tsk = current;
@@ -333,7 +334,7 @@ good_area:
 	/*
 	 * Did it hit the DOS screen memory VA from vm86 mode?
 	 */
-	if (regs->eflags & VM_MASK) {
+	if (regs->eflags & X86_EFLAGS_VM) {
 		unsigned long bit = (address - 0xA0000) >> PAGE_SHIFT;
 		if (bit < 32)
 			tsk->thread.screen_bitmap |= 1 << bit;
diff -Naurp ./include/asm-i386/ptrace.h~use_eflags ./include/asm-i386/ptrace.h
--- ./include/asm-i386/ptrace.h~use_eflags	2004-03-10 18:55:22.000000000 -0800
+++ ./include/asm-i386/ptrace.h	2004-04-06 22:19:10.000000000 -0700
@@ -55,7 +55,7 @@ struct pt_regs {
 #define PTRACE_SET_THREAD_AREA    26
 
 #ifdef __KERNEL__
-#define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
+#define user_mode(regs) ((X86_EFLAGS_VM & (regs)->eflags) || (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
 #endif
 
diff -Naurp ./include/asm-i386/processor.h~use_eflags ./include/asm-i386/processor.h
--- ./include/asm-i386/processor.h~use_eflags	2004-03-10 18:55:21.000000000 -0800
+++ ./include/asm-i386/processor.h	2004-04-06 21:20:57.000000000 -0700
@@ -121,6 +121,10 @@ extern void dodgy_tsc(void);
 #define X86_EFLAGS_VIP	0x00100000 /* Virtual Interrupt Pending */
 #define X86_EFLAGS_ID	0x00200000 /* CPUID detection flag */
 
+#define	X86_EFLAGS_USER	(X86_EFLAGS_AC | X86_EFLAGS_OF | X86_EFLAGS_DF | \
+			 X86_EFLAGS_TF | X86_EFLAGS_SF | X86_EFLAGS_ZF | \
+			 X86_EFLAGS_AF | X86_EFLAGS_PF | X86_EFLAGS_CF)
+
 /*
  * Generic CPUID function
  */
diff -Naurp ./include/asm-i386/vm86.h~use_eflags ./include/asm-i386/vm86.h
--- ./include/asm-i386/vm86.h~use_eflags	2004-03-10 18:55:35.000000000 -0800
+++ ./include/asm-i386/vm86.h	2004-04-06 21:58:20.000000000 -0700
@@ -4,7 +4,7 @@
 /*
  * I'm guessing at the VIF/VIP flag usage, but hope that this is how
  * the Pentium uses them. Linux will return from vm86 mode when both
- * VIF and VIP is set.
+ * VIF and VIP are set.
  *
  * On a Pentium, we could probably optimize the virtual flags directly
  * in the eflags register instead of doing it "by hand" in vflags...
@@ -12,16 +12,6 @@
  * Linus
  */
 
-#define TF_MASK		0x00000100
-#define IF_MASK		0x00000200
-#define IOPL_MASK	0x00003000
-#define NT_MASK		0x00004000
-#define VM_MASK		0x00020000
-#define AC_MASK		0x00040000
-#define VIF_MASK	0x00080000	/* virtual interrupt flag */
-#define VIP_MASK	0x00100000	/* virtual interrupt pending */
-#define ID_MASK		0x00200000
-
 #define BIOSSEG		0x0f000
 
 #define CPU_086		0
--
~Randy
