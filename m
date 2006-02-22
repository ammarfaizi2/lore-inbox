Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWBVETw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWBVETw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 23:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWBVETw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 23:19:52 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:10903 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751334AbWBVETv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 23:19:51 -0500
Date: Wed, 22 Feb 2006 09:51:21 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com,
       systemtap@sources.redhat.com, linux-kernel@vger.kernel.org
Cc: bibo.mao@intel.com, hiramatu@sdl.hitachi.co.jp
Subject: [PATCH] Kprobes causes NX protection fault on i686 SMP
Message-ID: <20060222042121.GA18108@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the problem seen on i686 machine with NX support,
where the instruction could not be single stepped because of NX
bit set on the memory pages allocated by kprobes module. This patch
provides allocation of instruction solt so that the processor can
execute the instruction from that location similar to x86_64
architecture. Thanks to Bibo and Masami for testing this patch.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


 arch/i386/kernel/kprobes.c |   19 ++++++++++++++++---
 include/asm-i386/kprobes.h |    7 +++++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-i386-fix-nx-protection-fault arch/i386/kernel/kprobes.c
--- linux-2.6.16-rc4-mm1/arch/i386/kernel/kprobes.c~kprobes-i386-fix-nx-protection-fault	2006-02-22 09:45:37.000000000 +0530
+++ linux-2.6.16-rc4-mm1-prasanna/arch/i386/kernel/kprobes.c	2006-02-22 09:45:37.000000000 +0530
@@ -101,6 +101,12 @@ static inline int is_IF_modifier(kprobe_
 
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
+
+	/* insn: must be on special executable page on i386. */
+	p->ainsn.insn = get_insn_slot();
+	if (!p->ainsn.insn)
+		return -ENOMEM;
+
 	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 	p->opcode = *p->addr;
 	if (can_boost(p->opcode)) {
@@ -125,6 +131,13 @@ void __kprobes arch_disarm_kprobe(struct
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
 
+void __kprobes arch_remove_kprobe(struct kprobe *p)
+{
+	mutex_lock(&kprobe_mutex);
+	free_insn_slot(p->ainsn.insn);
+	mutex_unlock(&kprobe_mutex);
+}
+
 static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	kcb->prev_kprobe.kp = kprobe_running();
@@ -159,7 +172,7 @@ static inline void prepare_singlestep(st
 	if (p->opcode == BREAKPOINT_INSTRUCTION)
 		regs->eip = (unsigned long)p->addr;
 	else
-		regs->eip = (unsigned long)&p->ainsn.insn;
+		regs->eip = (unsigned long)p->ainsn.insn;
 }
 
 /* Called with kretprobe_lock held */
@@ -301,7 +314,7 @@ static int __kprobes kprobe_handler(stru
 	    !p->post_handler && !p->break_handler ) {
 		/* Boost up -- we can execute copied instructions directly */
 		reset_current_kprobe();
-		regs->eip = (unsigned long)&p->ainsn.insn;
+		regs->eip = (unsigned long)p->ainsn.insn;
 		preempt_enable_no_resched();
 		return 1;
 	}
@@ -437,7 +450,7 @@ static void __kprobes resume_execution(s
 		struct pt_regs *regs, struct kprobe_ctlblk *kcb)
 {
 	unsigned long *tos = (unsigned long *)&regs->esp;
-	unsigned long copy_eip = (unsigned long)&p->ainsn.insn;
+	unsigned long copy_eip = (unsigned long)p->ainsn.insn;
 	unsigned long orig_eip = (unsigned long)p->addr;
 
 	regs->eflags &= ~TF_MASK;
diff -puN include/asm-i386/kprobes.h~kprobes-i386-fix-nx-protection-fault include/asm-i386/kprobes.h
--- linux-2.6.16-rc4-mm1/include/asm-i386/kprobes.h~kprobes-i386-fix-nx-protection-fault	2006-02-22 09:45:37.000000000 +0530
+++ linux-2.6.16-rc4-mm1-prasanna/include/asm-i386/kprobes.h	2006-02-22 09:45:37.000000000 +0530
@@ -27,6 +27,9 @@
 #include <linux/types.h>
 #include <linux/ptrace.h>
 
+#define  __ARCH_WANT_KPROBES_INSN_SLOT
+
+struct kprobe;
 struct pt_regs;
 
 typedef u8 kprobe_opcode_t;
@@ -41,14 +44,14 @@ typedef u8 kprobe_opcode_t;
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 #define ARCH_SUPPORTS_KRETPROBES
-#define arch_remove_kprobe(p)	do {} while (0)
 
+void arch_remove_kprobe(struct kprobe *p);
 void kretprobe_trampoline(void);
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
 	/* copy of the original instruction */
-	kprobe_opcode_t insn[MAX_INSN_SIZE];
+	kprobe_opcode_t *insn;
 	/*
 	 * If this flag is not 0, this kprobe can be boost when its
 	 * post_handler and break_handler is not set.

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
