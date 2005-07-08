Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVGHLNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVGHLNf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVGHLK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:10:59 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:35208 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262505AbVGHLKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:10:31 -0400
Date: Fri, 8 Jul 2005 16:40:45 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>,
       "David S. Miller" <davem@davemloft.net>, systemtap@sources.redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [5/6 PATCH] Kprobes : Prevent possible race conditions ia64 changes
Message-ID: <20050708111045.GA15871@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050707101833.GI12106@in.ibm.com> <20050707190645.A29253@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707190645.A29253@unix-os.sc.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anil,

I have updated the patch as per your comments to move routines
from jprobes.S to .kprobes.text section.

Please let me know if you any issues.

Thanks
Prasanna


This patch contains the ia64 architecture specific changes to
prevent the possible race conditions.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 include/asm-ia64/asmmacro.h                                  |    0 
 linux-2.6.13-rc1-mm1-prasanna/arch/ia64/kernel/jprobes.S     |    1 
 linux-2.6.13-rc1-mm1-prasanna/arch/ia64/kernel/kprobes.c     |   57 ++++++-----
 linux-2.6.13-rc1-mm1-prasanna/arch/ia64/kernel/traps.c       |    5 
 linux-2.6.13-rc1-mm1-prasanna/arch/ia64/kernel/vmlinux.lds.S |    1 
 linux-2.6.13-rc1-mm1-prasanna/arch/ia64/lib/flush.S          |    1 
 linux-2.6.13-rc1-mm1-prasanna/arch/ia64/mm/fault.c           |    3 
 7 files changed, 41 insertions(+), 27 deletions(-)

diff -puN arch/ia64/kernel/kprobes.c~kprobes-exclude-functions-ia64 arch/ia64/kernel/kprobes.c
--- linux-2.6.13-rc1-mm1/arch/ia64/kernel/kprobes.c~kprobes-exclude-functions-ia64	2005-07-08 15:22:52.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/ia64/kernel/kprobes.c	2005-07-08 15:22:52.000000000 +0530
@@ -87,8 +87,10 @@ static enum instruction_type bundle_enco
  * is IP relative instruction and update the kprobe
  * inst flag accordingly
  */
-static void update_kprobe_inst_flag(uint template, uint  slot, uint major_opcode,
-	unsigned long kprobe_inst, struct kprobe *p)
+static void __kprobes update_kprobe_inst_flag(uint template, uint  slot,
+					      uint major_opcode,
+					      unsigned long kprobe_inst,
+					      struct kprobe *p)
 {
 	p->ainsn.inst_flag = 0;
 	p->ainsn.target_br_reg = 0;
@@ -126,8 +128,10 @@ static void update_kprobe_inst_flag(uint
  * Returns 0 if supported
  * Returns -EINVAL if unsupported
  */
-static int unsupported_inst(uint template, uint  slot, uint major_opcode,
-	unsigned long kprobe_inst, struct kprobe *p)
+static int __kprobes unsupported_inst(uint template, uint  slot,
+				      uint major_opcode,
+				      unsigned long kprobe_inst,
+				      struct kprobe *p)
 {
 	unsigned long addr = (unsigned long)p->addr;
 
@@ -168,8 +172,9 @@ static int unsupported_inst(uint templat
  * on which we are inserting kprobe is cmp instruction
  * with ctype as unc.
  */
-static uint is_cmp_ctype_unc_inst(uint template, uint slot, uint major_opcode,
-unsigned long kprobe_inst)
+static uint __kprobes is_cmp_ctype_unc_inst(uint template, uint slot,
+					    uint major_opcode,
+					    unsigned long kprobe_inst)
 {
 	cmp_inst_t cmp_inst;
 	uint ctype_unc = 0;
@@ -201,8 +206,10 @@ out:
  * In this function we override the bundle with
  * the break instruction at the given slot.
  */
-static void prepare_break_inst(uint template, uint  slot, uint major_opcode,
-	unsigned long kprobe_inst, struct kprobe *p)
+static void __kprobes prepare_break_inst(uint template, uint  slot,
+					 uint major_opcode,
+					 unsigned long kprobe_inst,
+					 struct kprobe *p)
 {
 	unsigned long break_inst = BREAK_INST;
 	bundle_t *bundle = &p->ainsn.insn.bundle;
@@ -271,7 +278,8 @@ static inline int in_ivt_functions(unsig
 		&& addr < (unsigned long)__end_ivt_text);
 }
 
-static int valid_kprobe_addr(int template, int slot, unsigned long addr)
+static int __kprobes valid_kprobe_addr(int template, int slot,
+				       unsigned long addr)
 {
 	if ((slot > 2) || ((bundle_encoding[template][1] == L) && slot > 1)) {
 		printk(KERN_WARNING "Attempting to insert unaligned kprobe "
@@ -323,7 +331,7 @@ static void kretprobe_trampoline(void)
  *    - cleanup by marking the instance as unused
  *    - long jump back to the original return address
  */
-int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head;
@@ -381,7 +389,8 @@ int trampoline_probe_handler(struct kpro
         return 1;
 }
 
-void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs)
+void __kprobes arch_prepare_kretprobe(struct kretprobe *rp,
+				      struct pt_regs *regs)
 {
 	struct kretprobe_instance *ri;
 
@@ -399,7 +408,7 @@ void arch_prepare_kretprobe(struct kretp
 	}
 }
 
-int arch_prepare_kprobe(struct kprobe *p)
+int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	unsigned long addr = (unsigned long) p->addr;
 	unsigned long *kprobe_addr = (unsigned long *)(addr & ~0xFULL);
@@ -430,7 +439,7 @@ int arch_prepare_kprobe(struct kprobe *p
 	return 0;
 }
 
-void arch_arm_kprobe(struct kprobe *p)
+void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
 	unsigned long addr = (unsigned long)p->addr;
 	unsigned long arm_addr = addr & ~0xFULL;
@@ -439,7 +448,7 @@ void arch_arm_kprobe(struct kprobe *p)
 	flush_icache_range(arm_addr, arm_addr + sizeof(bundle_t));
 }
 
-void arch_disarm_kprobe(struct kprobe *p)
+void __kprobes arch_disarm_kprobe(struct kprobe *p)
 {
 	unsigned long addr = (unsigned long)p->addr;
 	unsigned long arm_addr = addr & ~0xFULL;
@@ -449,7 +458,7 @@ void arch_disarm_kprobe(struct kprobe *p
 	flush_icache_range(arm_addr, arm_addr + sizeof(bundle_t));
 }
 
-void arch_remove_kprobe(struct kprobe *p)
+void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
 }
 
@@ -461,7 +470,7 @@ void arch_remove_kprobe(struct kprobe *p
  * to original stack address, handle the case where we need to fixup the
  * relative IP address and/or fixup branch register.
  */
-static void resume_execution(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes resume_execution(struct kprobe *p, struct pt_regs *regs)
 {
   	unsigned long bundle_addr = ((unsigned long) (&p->opcode.bundle)) & ~0xFULL;
   	unsigned long resume_addr = (unsigned long)p->addr & ~0xFULL;
@@ -528,7 +537,7 @@ turn_ss_off:
   	ia64_psr(regs)->ss = 0;
 }
 
-static void prepare_ss(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes prepare_ss(struct kprobe *p, struct pt_regs *regs)
 {
 	unsigned long bundle_addr = (unsigned long) &p->opcode.bundle;
 	unsigned long slot = (unsigned long)p->addr & 0xf;
@@ -545,7 +554,7 @@ static void prepare_ss(struct kprobe *p,
 	ia64_psr(regs)->ss = 1;
 }
 
-static int pre_kprobes_handler(struct die_args *args)
+static int __kprobes pre_kprobes_handler(struct die_args *args)
 {
 	struct kprobe *p;
 	int ret = 0;
@@ -616,7 +625,7 @@ no_kprobe:
 	return ret;
 }
 
-static int post_kprobes_handler(struct pt_regs *regs)
+static int __kprobes post_kprobes_handler(struct pt_regs *regs)
 {
 	if (!kprobe_running())
 		return 0;
@@ -641,7 +650,7 @@ out:
 	return 1;
 }
 
-static int kprobes_fault_handler(struct pt_regs *regs, int trapnr)
+static int __kprobes kprobes_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	if (!kprobe_running())
 		return 0;
@@ -659,8 +668,8 @@ static int kprobes_fault_handler(struct 
 	return 0;
 }
 
-int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val,
-			     void *data)
+int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
+				       unsigned long val, void *data)
 {
 	struct die_args *args = (struct die_args *)data;
 	switch(val) {
@@ -681,7 +690,7 @@ int kprobe_exceptions_notify(struct noti
 	return NOTIFY_DONE;
 }
 
-int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
+int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
 	unsigned long addr = ((struct fnptr *)(jp->entry))->ip;
@@ -703,7 +712,7 @@ int setjmp_pre_handler(struct kprobe *p,
 	return 1;
 }
 
-int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
+int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	*regs = jprobe_saved_regs;
 	return 1;
diff -puN arch/ia64/kernel/traps.c~kprobes-exclude-functions-ia64 arch/ia64/kernel/traps.c
--- linux-2.6.13-rc1-mm1/arch/ia64/kernel/traps.c~kprobes-exclude-functions-ia64	2005-07-08 15:22:52.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/ia64/kernel/traps.c	2005-07-08 15:22:52.000000000 +0530
@@ -15,6 +15,7 @@
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/module.h>       /* for EXPORT_SYMBOL */
 #include <linux/hardirq.h>
+#include <linux/kprobes.h>
 
 #include <asm/fpswa.h>
 #include <asm/ia32.h>
@@ -120,7 +121,7 @@ die_if_kernel (char *str, struct pt_regs
 }
 
 void
-ia64_bad_break (unsigned long break_num, struct pt_regs *regs)
+__kprobes ia64_bad_break (unsigned long break_num, struct pt_regs *regs)
 {
 	siginfo_t siginfo;
 	int sig, code;
@@ -442,7 +443,7 @@ ia64_illegal_op_fault (unsigned long ec,
 	return rv;
 }
 
-void
+void __kprobes
 ia64_fault (unsigned long vector, unsigned long isr, unsigned long ifa,
 	    unsigned long iim, unsigned long itir, long arg5, long arg6,
 	    long arg7, struct pt_regs regs)
diff -puN arch/ia64/kernel/vmlinux.lds.S~kprobes-exclude-functions-ia64 arch/ia64/kernel/vmlinux.lds.S
--- linux-2.6.13-rc1-mm1/arch/ia64/kernel/vmlinux.lds.S~kprobes-exclude-functions-ia64	2005-07-08 15:22:52.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/ia64/kernel/vmlinux.lds.S	2005-07-08 15:22:52.000000000 +0530
@@ -48,6 +48,7 @@ SECTIONS
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT
+	KPROBES_TEXT
 	*(.gnu.linkonce.t*)
     }
   .text2 : AT(ADDR(.text2) - LOAD_OFFSET)
diff -puN arch/ia64/mm/fault.c~kprobes-exclude-functions-ia64 arch/ia64/mm/fault.c
--- linux-2.6.13-rc1-mm1/arch/ia64/mm/fault.c~kprobes-exclude-functions-ia64	2005-07-08 15:22:52.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/ia64/mm/fault.c	2005-07-08 15:22:52.000000000 +0530
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
+#include <linux/kprobes.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -76,7 +77,7 @@ mapped_kernel_page_is_present (unsigned 
 	return pte_present(pte);
 }
 
-void
+void __kprobes
 ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *regs)
 {
 	int signal = SIGSEGV, code = SEGV_MAPERR;
diff -puN arch/ia64/lib/flush.S~kprobes-exclude-functions-ia64 arch/ia64/lib/flush.S
--- linux-2.6.13-rc1-mm1/arch/ia64/lib/flush.S~kprobes-exclude-functions-ia64	2005-07-08 15:22:52.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/ia64/lib/flush.S	2005-07-08 15:22:52.000000000 +0530
@@ -12,6 +12,7 @@
 	 *	Must flush range from start to end-1 but nothing else (need to
 	 *	be careful not to touch addresses that may be unmapped).
 	 */
+	.section .kprobes.text
 GLOBAL_ENTRY(flush_icache_range)
 	.prologue
 	alloc r2=ar.pfs,2,0,0,0
diff -puN include/asm-ia64/asmmacro.h~kprobes-exclude-functions-ia64 include/asm-ia64/asmmacro.h
diff -puN arch/ia64/kernel/jprobes.S~kprobes-exclude-functions-ia64 arch/ia64/kernel/jprobes.S
--- linux-2.6.13-rc1-mm1/arch/ia64/kernel/jprobes.S~kprobes-exclude-functions-ia64	2005-07-08 15:22:52.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/ia64/kernel/jprobes.S	2005-07-08 15:22:52.000000000 +0530
@@ -49,6 +49,7 @@
 	/*
 	 * void jprobe_break(void)
 	 */
+	.section .kprobes.text, "ax"
 ENTRY(jprobe_break)
 	break.m 0x80300
 END(jprobe_break)

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
