Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVCaIQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVCaIQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 03:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVCaIQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 03:16:27 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:35767 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261171AbVCaIP5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 03:15:57 -0500
Date: Thu, 31 Mar 2005 13:47:14 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: SystemTAP <systemtap@sources.redhat.com>, akpm@osdl.org,
       Andi Kleen <ak@muc.de>, davem@davemloft.net, ananth@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Kprobes: Allow/deny probes on int3/breakpoint instruction?
Message-ID: <20050331081714.GA32299@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050331080714.GB31660@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331080714.GB31660@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kprobes did an improper exit when a probe is inserted on an int3 instruction.
In case of normal execution of int3/breakpoint instruction, it oops!.
Probe on an int3 instruction was not handled properly by the kprobes, it 
generated faults after oops! doing an improper exit with holding the lock. This
fix employes a bit different method to handle probe on an int3/breakpoint 
instruction.

On execution of an int3/breakpoint instruction (placed by kprobe),
kprobes_handler() is called which sets it for single stepping in-line(it does
not matter whether we single step out-of-line/inline since the single stepping
instruction is same). Now it single steps on int3/breakpoint instruction here,
entering kprobes_handler() once again. Kprobes now check's the status that it
is single stepping and avoids the recursion. It runs down through the trap
handler and oops messages is seen on the console since it executed
int3/breakpoint instruction. Here the kprobes single stepping handler never
gets called.

Is this behaviour acceptable ? Or should we avoid putting probes on an int3
/breakpoint instruction ? How should it handle such situations?
Below is the patch to allow probes on an int3/breakpoint instruction.

This patch fixes the above problem by doing a proper exit while avoiding
recursion.
Any pointers/suggestions on the above issues will be helpful.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.12-rc1-prasanna/arch/i386/kernel/kprobes.c    |   12 +++++++++++-
 linux-2.6.12-rc1-prasanna/arch/ppc64/kernel/kprobes.c   |   12 +++++++++++-
 linux-2.6.12-rc1-prasanna/arch/sparc64/kernel/kprobes.c |   16 ++++++++++++++--
 linux-2.6.12-rc1-prasanna/arch/x86_64/kernel/kprobes.c  |   13 +++++++++++--
 4 files changed, 47 insertions(+), 6 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-allow-probes-on-int3 arch/i386/kernel/kprobes.c
--- linux-2.6.12-rc1/arch/i386/kernel/kprobes.c~kprobes-allow-probes-on-int3	2005-03-30 16:47:42.000000000 +0530
+++ linux-2.6.12-rc1-prasanna/arch/i386/kernel/kprobes.c	2005-03-30 16:51:43.000000000 +0530
@@ -84,7 +84,11 @@ static inline void prepare_singlestep(st
 {
 	regs->eflags |= TF_MASK;
 	regs->eflags &= ~IF_MASK;
-	regs->eip = (unsigned long)&p->ainsn.insn;
+	/*single step inline if the instruction is an int3*/
+	if (p->opcode == BREAKPOINT_INSTRUCTION)
+		regs->eip = (unsigned long)p->addr;
+	else
+		regs->eip = (unsigned long)&p->ainsn.insn;
 }
 
 /*
@@ -117,6 +121,12 @@ static int kprobe_handler(struct pt_regs
 		   Disarm the probe we just hit, and ignore it. */
 		p = get_kprobe(addr);
 		if (p) {
+			if (kprobe_status == KPROBE_HIT_SS) {
+				regs->eflags &= ~TF_MASK;
+				regs->eflags |= kprobe_saved_eflags;
+				unlock_kprobes();
+				goto no_kprobe;
+			}
 			disarm_kprobe(p, regs);
 			ret = 1;
 		} else {
diff -puN arch/x86_64/kernel/kprobes.c~kprobes-allow-probes-on-int3 arch/x86_64/kernel/kprobes.c
--- linux-2.6.12-rc1/arch/x86_64/kernel/kprobes.c~kprobes-allow-probes-on-int3	2005-03-30 20:55:23.000000000 +0530
+++ linux-2.6.12-rc1-prasanna/arch/x86_64/kernel/kprobes.c	2005-03-31 12:19:53.000000000 +0530
@@ -108,8 +108,11 @@ static void prepare_singlestep(struct kp
 {
 	regs->eflags |= TF_MASK;
 	regs->eflags &= ~IF_MASK;
-
-	regs->rip = (unsigned long)p->ainsn.insn;
+	/*single step inline if the instruction is an int3*/
+	if (p->opcode == BREAKPOINT_INSTRUCTION)
+		regs->rip = (unsigned long)p->addr;
+	else
+		regs->rip = (unsigned long)p->ainsn.insn;
 }
 
 /*
@@ -131,6 +134,12 @@ int kprobe_handler(struct pt_regs *regs)
 		   Disarm the probe we just hit, and ignore it. */
 		p = get_kprobe(addr);
 		if (p) {
+			if (kprobe_status == KPROBE_HIT_SS) {
+				regs->eflags &= ~TF_MASK;
+				regs->eflags |= kprobe_saved_rflags;
+				unlock_kprobes();
+				goto no_kprobe;
+			}
 			disarm_kprobe(p, regs);
 			ret = 1;
 		} else {
diff -puN arch/ppc64/kernel/kprobes.c~kprobes-allow-probes-on-int3 arch/ppc64/kernel/kprobes.c
--- linux-2.6.12-rc1/arch/ppc64/kernel/kprobes.c~kprobes-allow-probes-on-int3	2005-03-30 21:03:14.000000000 +0530
+++ linux-2.6.12-rc1-prasanna/arch/ppc64/kernel/kprobes.c	2005-03-31 10:46:16.000000000 +0530
@@ -71,7 +71,11 @@ static inline void disarm_kprobe(struct 
 static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
 	regs->msr |= MSR_SE;
-	regs->nip = (unsigned long)&p->ainsn.insn;
+	/*single step inline if it a breakpoint instruction*/
+	if (p->opcode == BREAKPOINT_INSTRUCTION)
+		regs->nip = (unsigned long)p->addr;
+	else
+		regs->nip = (unsigned long)&p->ainsn.insn;
 }
 
 static inline int kprobe_handler(struct pt_regs *regs)
@@ -89,6 +93,12 @@ static inline int kprobe_handler(struct 
 		   Disarm the probe we just hit, and ignore it. */
 		p = get_kprobe(addr);
 		if (p) {
+			if (kprobe_status == KPROBE_HIT_SS) {
+				regs->msr &= ~MSR_SE;
+				regs->msr |= kprobe_saved_msr;
+				unlock_kprobes();
+				goto no_kprobe;
+			}
 			disarm_kprobe(p, regs);
 			ret = 1;
 		} else {
diff -puN arch/sparc64/kernel/kprobes.c~kprobes-allow-probes-on-int3 arch/sparc64/kernel/kprobes.c
--- linux-2.6.12-rc1/arch/sparc64/kernel/kprobes.c~kprobes-allow-probes-on-int3	2005-03-31 10:34:50.000000000 +0530
+++ linux-2.6.12-rc1-prasanna/arch/sparc64/kernel/kprobes.c	2005-03-31 10:44:19.000000000 +0530
@@ -68,8 +68,14 @@ static inline void prepare_singlestep(st
 	current_kprobe_orig_tstate_pil = (regs->tstate & TSTATE_PIL);
 	regs->tstate |= TSTATE_PIL;
 
-	regs->tpc = (unsigned long) &p->ainsn.insn[0];
-	regs->tnpc = (unsigned long) &p->ainsn.insn[1];
+	/*single step inline, if it a breakpoint instruction*/
+	if (p->opcode == BREAKPOINT_INSTRUCTION) {
+		regs->tpc = (unsigned long) p->addr;
+		regs->tnpc = current_kprobe_orig_tnpc;
+	} else {
+		regs->tpc = (unsigned long) &p->ainsn.insn[0];
+		regs->tnpc = (unsigned long) &p->ainsn.insn[1];
+	}
 }
 
 static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
@@ -97,6 +103,12 @@ static int kprobe_handler(struct pt_regs
 		 */
 		p = get_kprobe(addr);
 		if (p) {
+			if (kprobe_status == KPROBE_HIT_SS) {
+				regs->tstate = ((regs->tstate & ~TSTATE_PIL) |
+					current_kprobe_orig_tstate_pil);
+				unlock_kprobes();
+				goto no_kprobe;
+			}
 			disarm_kprobe(p, regs);
 			ret = 1;
 		} else {

_

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
