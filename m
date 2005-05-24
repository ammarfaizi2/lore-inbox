Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVEXKaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVEXKaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVEXKTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:19:20 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:24802 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262075AbVEXKRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 06:17:18 -0400
Date: Tue, 24 May 2005 15:48:40 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, ak@muc.de, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: Re: [PATCH 3/5] Kprobes: Temporary disarming of reentrant probe for x86_64
Message-ID: <20050524101840.GB27186@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050524101532.GA27215@in.ibm.com> <20050524101712.GA27186@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524101712.GA27186@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch includes x86_64 architecture specific changes to support temporary
disarming on reentrancy of probes.

Signed-of-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>

---


---

 linux-2.6.12-rc4-mm2-prasanna/arch/x86_64/kernel/kprobes.c |   73 ++++++++++---
 1 files changed, 60 insertions(+), 13 deletions(-)

diff -puN arch/x86_64/kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-x86_64 arch/x86_64/kernel/kprobes.c
--- linux-2.6.12-rc4-mm2/arch/x86_64/kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-x86_64	2005-05-24 15:29:27.000000000 +0530
+++ linux-2.6.12-rc4-mm2-prasanna/arch/x86_64/kernel/kprobes.c	2005-05-24 15:29:27.000000000 +0530
@@ -43,12 +43,10 @@
 
 static DECLARE_MUTEX(kprobe_mutex);
 
-/* kprobe_status settings */
-#define KPROBE_HIT_ACTIVE	0x00000001
-#define KPROBE_HIT_SS		0x00000002
-
 static struct kprobe *current_kprobe;
 static unsigned long kprobe_status, kprobe_old_rflags, kprobe_saved_rflags;
+static struct kprobe *kprobe_prev;
+static unsigned long kprobe_status_prev, kprobe_old_rflags_prev, kprobe_saved_rflags_prev;
 static struct pt_regs jprobe_saved_regs;
 static long *jprobe_saved_rsp;
 static kprobe_opcode_t *get_insn_slot(void);
@@ -238,6 +236,31 @@ void arch_remove_kprobe(struct kprobe *p
 	down(&kprobe_mutex);
 }
 
+static inline void save_previous_kprobe(void)
+{
+	kprobe_prev = current_kprobe;
+	kprobe_status_prev = kprobe_status;
+	kprobe_old_rflags_prev = kprobe_old_rflags;
+	kprobe_saved_rflags_prev = kprobe_saved_rflags;
+}
+
+static inline void restore_previous_kprobe(void)
+{
+	current_kprobe = kprobe_prev;
+	kprobe_status = kprobe_status_prev;
+	kprobe_old_rflags = kprobe_old_rflags_prev;
+	kprobe_saved_rflags = kprobe_saved_rflags_prev;
+}
+
+static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs)
+{
+	current_kprobe = p;
+	kprobe_saved_rflags = kprobe_old_rflags
+		= (regs->eflags & (TF_MASK | IF_MASK));
+	if (is_IF_modifier(p->ainsn.insn))
+		kprobe_saved_rflags &= ~IF_MASK;
+}
+
 static void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
 	regs->eflags |= TF_MASK;
@@ -273,10 +296,30 @@ int kprobe_handler(struct pt_regs *regs)
 				regs->eflags |= kprobe_saved_rflags;
 				unlock_kprobes();
 				goto no_kprobe;
+			} else if (kprobe_status == KPROBE_HIT_SSDONE) {
+				/* TODO: Provide re-entrancy from
+				 * post_kprobes_handler() and avoid exception
+				 * stack corruption while single-stepping on
+				 * the instruction of the new probe.
+				 */
+				arch_disarm_kprobe(p);
+				regs->rip = (unsigned long)p->addr;
+				ret = 1;
+			} else {
+				/* We have reentered the kprobe_handler(), since
+				 * another probe was hit while within the
+				 * handler. We here save the original kprobe
+				 * variables and just single step on instruction
+				 * of the new probe without calling any user
+				 * handlers.
+				 */
+				save_previous_kprobe();
+				set_current_kprobe(p, regs);
+				p->nmissed++;
+				prepare_singlestep(p, regs);
+				kprobe_status = KPROBE_REENTER;
+				return 1;
 			}
-			arch_disarm_kprobe(p);
-			regs->rip = (unsigned long)p->addr;
-			ret = 1;
 		} else {
 			p = current_kprobe;
 			if (p->break_handler && p->break_handler(p, regs)) {
@@ -306,11 +349,7 @@ int kprobe_handler(struct pt_regs *regs)
 	}
 
 	kprobe_status = KPROBE_HIT_ACTIVE;
-	current_kprobe = p;
-	kprobe_saved_rflags = kprobe_old_rflags
-	    = (regs->eflags & (TF_MASK | IF_MASK));
-	if (is_IF_modifier(p->ainsn.insn))
-		kprobe_saved_rflags &= ~IF_MASK;
+	set_current_kprobe(p, regs);
 
 	if (p->pre_handler && p->pre_handler(p, regs))
 		/* handler has already set things up, so skip ss setup */
@@ -411,13 +450,21 @@ int post_kprobe_handler(struct pt_regs *
 	if (!kprobe_running())
 		return 0;
 
-	if (current_kprobe->post_handler)
+	if ((kprobe_status != KPROBE_REENTER) && current_kprobe->post_handler) {
+		kprobe_status = KPROBE_HIT_SSDONE;
 		current_kprobe->post_handler(current_kprobe, regs, 0);
+	}
 
 	resume_execution(current_kprobe, regs);
 	regs->eflags |= kprobe_saved_rflags;
 
+	/*Restore back the original saved kprobes variables and continue. */
+	if (kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe();
+		goto out;
+	}
 	unlock_kprobes();
+out:
 	preempt_enable_no_resched();
 
 	/*

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
