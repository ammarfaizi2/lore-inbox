Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262970AbUJ1Ld7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbUJ1Ld7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbUJ1Ld7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:33:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:8884 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262970AbUJ1LdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:33:25 -0400
Date: Thu, 28 Oct 2004 17:04:45 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>, ak@muc.de,
       suparna@in.ibm.com, dprobes@www-124.southbury.usf.ibm.com
Subject: Re: [1/3] PATCH Kprobes for x86_64- 2.6.9-final
Message-ID: <20041028113444.GA5812@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20041028113208.GA11182@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028113208.GA11182@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1/3] kprobes-arch-i386-changes.patch
Couple of routine's are modified to support kprobes porting to other
architectures.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
---


---

 linux-2.6.9-final-prasanna/arch/i386/kernel/kprobes.c |   23 ++++++++++--------
 linux-2.6.9-final-prasanna/include/asm-i386/kprobes.h |    7 +++++
 linux-2.6.9-final-prasanna/include/linux/kprobes.h    |    5 ++-
 linux-2.6.9-final-prasanna/kernel/kprobes.c           |    6 +++-
 4 files changed, 29 insertions(+), 12 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-arch-i386-changes arch/i386/kernel/kprobes.c
--- linux-2.6.9-final/arch/i386/kernel/kprobes.c~kprobes-arch-i386-changes	2004-10-28 16:44:50.000000000 +0530
+++ linux-2.6.9-final-prasanna/arch/i386/kernel/kprobes.c	2004-10-28 16:44:50.000000000 +0530
@@ -58,9 +58,14 @@ static inline int is_IF_modifier(kprobe_
 	return 0;
 }
 
-void arch_prepare_kprobe(struct kprobe *p)
+int arch_prepare_kprobe(struct kprobe *p)
+{
+	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+	return 0;
+}
+
+void arch_remove_kprobe(struct kprobe *p)
 {
-	memcpy(p->insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 }
 
 static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
@@ -73,7 +78,7 @@ static inline void prepare_singlestep(st
 {
 	regs->eflags |= TF_MASK;
 	regs->eflags &= ~IF_MASK;
-	regs->eip = (unsigned long)&p->insn;
+	regs->eip = (unsigned long)&p->ainsn.insn;
 }
 
 /*
@@ -153,7 +158,7 @@ static inline int kprobe_handler(struct 
  * instruction.  To avoid the SMP problems that can occur when we
  * temporarily put back the original opcode to single-step, we
  * single-stepped a copy of the instruction.  The address of this
- * copy is p->insn.
+ * copy is p->ainsn.insn.
  *
  * This function prepares to return from the post-single-step
  * interrupt.  We have to fix up the stack as follows:
@@ -173,10 +178,10 @@ static void resume_execution(struct kpro
 {
 	unsigned long *tos = (unsigned long *)&regs->esp;
 	unsigned long next_eip = 0;
-	unsigned long copy_eip = (unsigned long)&p->insn;
+	unsigned long copy_eip = (unsigned long)&p->ainsn.insn;
 	unsigned long orig_eip = (unsigned long)p->addr;
 
-	switch (p->insn[0]) {
+	switch (p->ainsn.insn[0]) {
 	case 0x9c:		/* pushfl */
 		*tos &= ~(TF_MASK | IF_MASK);
 		*tos |= kprobe_old_eflags;
@@ -185,13 +190,13 @@ static void resume_execution(struct kpro
 		*tos = orig_eip + (*tos - copy_eip);
 		break;
 	case 0xff:
-		if ((p->insn[1] & 0x30) == 0x10) {
+		if ((p->ainsn.insn[1] & 0x30) == 0x10) {
 			/* call absolute, indirect */
 			/* Fix return addr; eip is correct. */
 			next_eip = regs->eip;
 			*tos = orig_eip + (*tos - copy_eip);
-		} else if (((p->insn[1] & 0x31) == 0x20) ||	/* jmp near, absolute indirect */
-			   ((p->insn[1] & 0x31) == 0x21)) {	/* jmp far, absolute indirect */
+		} else if (((p->ainsn.insn[1] & 0x31) == 0x20) ||	/* jmp near, absolute indirect */
+			   ((p->ainsn.insn[1] & 0x31) == 0x21)) {	/* jmp far, absolute indirect */
 			/* eip is correct. */
 			next_eip = regs->eip;
 		}
diff -puN include/asm-i386/kprobes.h~kprobes-arch-i386-changes include/asm-i386/kprobes.h
--- linux-2.6.9-final/include/asm-i386/kprobes.h~kprobes-arch-i386-changes	2004-10-28 16:44:50.000000000 +0530
+++ linux-2.6.9-final-prasanna/include/asm-i386/kprobes.h	2004-10-28 16:44:50.000000000 +0530
@@ -38,6 +38,13 @@ typedef u8 kprobe_opcode_t;
 	? (MAX_STACK_SIZE) \
 	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
 
+/* Architecture specific copy of original instruction*/
+struct arch_specific_insn {
+	/* copy of the original instruction */
+	kprobe_opcode_t insn[MAX_INSN_SIZE];
+};
+
+
 /* trap3/1 are intr gates for kprobes.  So, restore the status of IF,
  * if necessary, before executing the original int3/1 (trap) handler.
  */
diff -puN include/linux/kprobes.h~kprobes-arch-i386-changes include/linux/kprobes.h
--- linux-2.6.9-final/include/linux/kprobes.h~kprobes-arch-i386-changes	2004-10-28 16:44:50.000000000 +0530
+++ linux-2.6.9-final-prasanna/include/linux/kprobes.h	2004-10-28 16:44:50.000000000 +0530
@@ -64,7 +64,7 @@ struct kprobe {
 	kprobe_opcode_t opcode;
 
 	/* copy of the original instruction */
-	kprobe_opcode_t insn[MAX_INSN_SIZE];
+	struct arch_specific_insn ainsn;
 };
 
 /*
@@ -94,7 +94,8 @@ static inline int kprobe_running(void)
 	return kprobe_cpu == smp_processor_id();
 }
 
-extern void arch_prepare_kprobe(struct kprobe *p);
+extern int arch_prepare_kprobe(struct kprobe *p);
+extern void arch_remove_kprobe(struct kprobe *p);
 extern void show_registers(struct pt_regs *regs);
 
 /* Get the kprobe at this addr (if any).  Must have called lock_kprobes */
diff -puN kernel/kprobes.c~kprobes-arch-i386-changes kernel/kprobes.c
--- linux-2.6.9-final/kernel/kprobes.c~kprobes-arch-i386-changes	2004-10-28 16:44:50.000000000 +0530
+++ linux-2.6.9-final-prasanna/kernel/kprobes.c	2004-10-28 16:44:50.000000000 +0530
@@ -84,10 +84,13 @@ int register_kprobe(struct kprobe *p)
 		ret = -EEXIST;
 		goto out;
 	}
+
+	if ((ret = arch_prepare_kprobe(p)) != 0) {
+		goto out;
+	}
 	hlist_add_head(&p->hlist,
 		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
 
-	arch_prepare_kprobe(p);
 	p->opcode = *p->addr;
 	*p->addr = BREAKPOINT_INSTRUCTION;
 	flush_icache_range((unsigned long) p->addr,
@@ -101,6 +104,7 @@ void unregister_kprobe(struct kprobe *p)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&kprobe_lock, flags);
+	arch_remove_kprobe(p);
 	*p->addr = p->opcode;
 	hlist_del(&p->hlist);
 	flush_icache_range((unsigned long) p->addr,

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
