Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVGGKOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVGGKOZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 06:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVGGKOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 06:14:25 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:10406 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261290AbVGGKOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 06:14:08 -0400
Date: Thu, 7 Jul 2005 15:44:47 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>,
       "David S. Miller" <davem@davemloft.net>, systemtap@sources.redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [3/6 PATCH] Kprobes : Prevent possible race conditions x86_64 changes
Message-ID: <20050707101447.GG12106@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050707101015.GE12106@in.ibm.com> <20050707101119.GF12106@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707101119.GF12106@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch contains the x86_64 architecture specific changes to
prevent the possible race conditions.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.13-rc1-mm1-prasanna/arch/x86_64/kernel/kprobes.c     |   35 +++++-----
 linux-2.6.13-rc1-mm1-prasanna/arch/x86_64/kernel/traps.c       |   14 ++--
 linux-2.6.13-rc1-mm1-prasanna/arch/x86_64/kernel/vmlinux.lds.S |    1 
 linux-2.6.13-rc1-mm1-prasanna/arch/x86_64/mm/fault.c           |    3 
 4 files changed, 30 insertions(+), 23 deletions(-)

diff -puN arch/x86_64/kernel/kprobes.c~kprobes-exclude-functions-x86_64 arch/x86_64/kernel/kprobes.c
--- linux-2.6.13-rc1-mm1/arch/x86_64/kernel/kprobes.c~kprobes-exclude-functions-x86_64	2005-07-06 17:45:18.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/x86_64/kernel/kprobes.c	2005-07-06 17:45:43.000000000 +0530
@@ -74,7 +74,7 @@ static inline int is_IF_modifier(kprobe_
 	return 0;
 }
 
-int arch_prepare_kprobe(struct kprobe *p)
+int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	/* insn: must be on special executable page on x86_64. */
 	up(&kprobe_mutex);
@@ -189,7 +189,7 @@ static inline s32 *is_riprel(u8 *insn)
 	return NULL;
 }
 
-void arch_copy_kprobe(struct kprobe *p)
+void __kprobes arch_copy_kprobe(struct kprobe *p)
 {
 	s32 *ripdisp;
 	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE);
@@ -215,21 +215,21 @@ void arch_copy_kprobe(struct kprobe *p)
 	p->opcode = *p->addr;
 }
 
-void arch_arm_kprobe(struct kprobe *p)
+void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
 	*p->addr = BREAKPOINT_INSTRUCTION;
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
 
-void arch_disarm_kprobe(struct kprobe *p)
+void __kprobes arch_disarm_kprobe(struct kprobe *p)
 {
 	*p->addr = p->opcode;
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
 
-void arch_remove_kprobe(struct kprobe *p)
+void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
 	up(&kprobe_mutex);
 	free_insn_slot(p->ainsn.insn);
@@ -261,7 +261,7 @@ static inline void set_current_kprobe(st
 		kprobe_saved_rflags &= ~IF_MASK;
 }
 
-static void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
 	regs->eflags |= TF_MASK;
 	regs->eflags &= ~IF_MASK;
@@ -272,7 +272,8 @@ static void prepare_singlestep(struct kp
 		regs->rip = (unsigned long)p->ainsn.insn;
 }
 
-void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs)
+void __kprobes arch_prepare_kretprobe(struct kretprobe *rp,
+				      struct pt_regs *regs)
 {
 	unsigned long *sara = (unsigned long *)regs->rsp;
         struct kretprobe_instance *ri;
@@ -295,7 +296,7 @@ void arch_prepare_kretprobe(struct kretp
  * Interrupts are disabled on entry as trap3 is an interrupt gate and they
  * remain disabled thorough out this function.
  */
-int kprobe_handler(struct pt_regs *regs)
+int __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p;
 	int ret = 0;
@@ -399,7 +400,7 @@ no_kprobe:
 /*
  * Called when we hit the probe point at kretprobe_trampoline
  */
-int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
         struct kretprobe_instance *ri = NULL;
         struct hlist_head *head;
@@ -478,7 +479,7 @@ int trampoline_probe_handler(struct kpro
  * that is atop the stack is the address following the copied instruction.
  * We need to make it the address following the original instruction.
  */
-static void resume_execution(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes resume_execution(struct kprobe *p, struct pt_regs *regs)
 {
 	unsigned long *tos = (unsigned long *)regs->rsp;
 	unsigned long next_rip = 0;
@@ -536,7 +537,7 @@ static void resume_execution(struct kpro
  * Interrupts are disabled on entry as trap1 is an interrupt gate and they
  * remain disabled thoroughout this function.  And we hold kprobe lock.
  */
-int post_kprobe_handler(struct pt_regs *regs)
+int __kprobes post_kprobe_handler(struct pt_regs *regs)
 {
 	if (!kprobe_running())
 		return 0;
@@ -571,7 +572,7 @@ out:
 }
 
 /* Interrupts disabled, kprobe_lock held. */
-int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	if (current_kprobe->fault_handler
 	    && current_kprobe->fault_handler(current_kprobe, regs, trapnr))
@@ -590,8 +591,8 @@ int kprobe_fault_handler(struct pt_regs 
 /*
  * Wrapper routine for handling exceptions.
  */
-int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val,
-			     void *data)
+int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
+				       unsigned long val, void *data)
 {
 	struct die_args *args = (struct die_args *)data;
 	switch (val) {
@@ -619,7 +620,7 @@ int kprobe_exceptions_notify(struct noti
 	return NOTIFY_DONE;
 }
 
-int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
+int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
 	unsigned long addr;
@@ -640,7 +641,7 @@ int setjmp_pre_handler(struct kprobe *p,
 	return 1;
 }
 
-void jprobe_return(void)
+void __kprobes jprobe_return(void)
 {
 	preempt_enable_no_resched();
 	asm volatile ("       xchg   %%rbx,%%rsp     \n"
@@ -651,7 +652,7 @@ void jprobe_return(void)
 		      (jprobe_saved_rsp):"memory");
 }
 
-int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
+int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	u8 *addr = (u8 *) (regs->rip - 1);
 	unsigned long stack_addr = (unsigned long)jprobe_saved_rsp;
diff -puN arch/x86_64/kernel/traps.c~kprobes-exclude-functions-x86_64 arch/x86_64/kernel/traps.c
--- linux-2.6.13-rc1-mm1/arch/x86_64/kernel/traps.c~kprobes-exclude-functions-x86_64	2005-07-06 17:45:18.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/x86_64/kernel/traps.c	2005-07-06 17:45:18.000000000 +0530
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/nmi.h>
+#include <linux/kprobes.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -422,8 +423,9 @@ void die_nmi(char *str, struct pt_regs *
 	do_exit(SIGSEGV);
 }
 
-static void do_trap(int trapnr, int signr, char *str, 
-			   struct pt_regs * regs, long error_code, siginfo_t *info)
+static void __kprobes do_trap(int trapnr, int signr, char *str,
+			      struct pt_regs * regs, long error_code,
+			      siginfo_t *info)
 {
 	conditional_sti(regs);
 
@@ -507,7 +509,8 @@ DO_ERROR(18, SIGSEGV, "reserved", reserv
 DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
 DO_ERROR( 8, SIGSEGV, "double fault", double_fault)
 
-asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
+asmlinkage void __kprobes do_general_protection(struct pt_regs * regs,
+						long error_code)
 {
 	conditional_sti(regs);
 
@@ -628,7 +631,7 @@ asmlinkage void default_do_nmi(struct pt
 		io_check_error(reason, regs);
 }
 
-asmlinkage void do_int3(struct pt_regs * regs, long error_code)
+asmlinkage void __kprobes do_int3(struct pt_regs * regs, long error_code)
 {
 	if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP) == NOTIFY_STOP) {
 		return;
@@ -659,7 +662,8 @@ asmlinkage struct pt_regs *sync_regs(str
 }
 
 /* runs on IST stack. */
-asmlinkage void do_debug(struct pt_regs * regs, unsigned long error_code)
+asmlinkage void __kprobes do_debug(struct pt_regs * regs,
+				   unsigned long error_code)
 {
 	unsigned long condition;
 	struct task_struct *tsk = current;
diff -puN arch/x86_64/kernel/vmlinux.lds.S~kprobes-exclude-functions-x86_64 arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6.13-rc1-mm1/arch/x86_64/kernel/vmlinux.lds.S~kprobes-exclude-functions-x86_64	2005-07-06 17:45:18.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/x86_64/kernel/vmlinux.lds.S	2005-07-06 17:45:18.000000000 +0530
@@ -21,6 +21,7 @@ SECTIONS
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT
+	KPROBES_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
diff -puN arch/x86_64/mm/fault.c~kprobes-exclude-functions-x86_64 arch/x86_64/mm/fault.c
--- linux-2.6.13-rc1-mm1/arch/x86_64/mm/fault.c~kprobes-exclude-functions-x86_64	2005-07-06 17:45:18.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/x86_64/mm/fault.c	2005-07-06 17:45:18.000000000 +0530
@@ -297,7 +297,8 @@ int exception_trace = 1;
  *	bit 2 == 0 means kernel, 1 means user-mode
  *      bit 3 == 1 means fault was an instruction fetch
  */
-asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code)
+asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
+					unsigned long error_code)
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
