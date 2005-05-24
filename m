Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVEXKeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVEXKeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVEXKb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:31:56 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:17582 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262012AbVEXKT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 06:19:26 -0400
Date: Tue, 24 May 2005 15:50:53 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, ak@muc.de, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: Re: [PATCH 5/5] Kprobes: Temporary disarming of reentrant probe for sparc64
Message-ID: <20050524102053.GD27186@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050524101532.GA27215@in.ibm.com> <20050524101712.GA27186@in.ibm.com> <20050524101840.GB27186@in.ibm.com> <20050524101945.GC27186@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524101945.GC27186@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch includes sparc64 architecture specific changes to support temporary
disarming on reentrancy of probes.

Signed-of-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
---


---

 linux-2.6.12-rc4-mm2-prasanna/arch/sparc64/kernel/kprobes.c |   62 +++++++++---
 1 files changed, 49 insertions(+), 13 deletions(-)

diff -puN arch/sparc64/kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-sparc64 arch/sparc64/kernel/kprobes.c
--- linux-2.6.12-rc4-mm2/arch/sparc64/kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-sparc64	2005-05-24 15:30:47.000000000 +0530
+++ linux-2.6.12-rc4-mm2-prasanna/arch/sparc64/kernel/kprobes.c	2005-05-24 15:30:47.000000000 +0530
@@ -65,19 +65,40 @@ void arch_remove_kprobe(struct kprobe *p
 {
 }
 
-/* kprobe_status settings */
-#define KPROBE_HIT_ACTIVE	0x00000001
-#define KPROBE_HIT_SS		0x00000002
-
 static struct kprobe *current_kprobe;
 static unsigned long current_kprobe_orig_tnpc;
 static unsigned long current_kprobe_orig_tstate_pil;
 static unsigned int kprobe_status;
+static struct kprobe *kprobe_prev;
+static unsigned long kprobe_orig_tnpc_prev;
+static unsigned long kprobe_orig_tstate_pil_prev;
+static unsigned int kprobe_status_prev;
 
-static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
+static inline void save_previous_kprobe(void)
+{
+	kprobe_status_prev = kprobe_status;
+	kprobe_orig_tnpc_prev = current_kprobe_orig_tnpc;
+	kprobe_orig_tstate_pil_prev = current_kprobe_orig_tstate_pil;
+	kprobe_prev = current_kprobe;
+}
+
+static inline void restore_previous_kprobe(void)
+{
+	kprobe_status = kprobe_status_prev;
+	current_kprobe_orig_tnpc = kprobe_orig_tnpc_prev;
+	current_kprobe_orig_tstate_pil = kprobe_orig_tstate_pil_prev;
+	current_kprobe = kprobe_prev;
+}
+
+static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	current_kprobe_orig_tnpc = regs->tnpc;
 	current_kprobe_orig_tstate_pil = (regs->tstate & TSTATE_PIL);
+	current_kprobe = p;
+}
+
+static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
+{
 	regs->tstate |= TSTATE_PIL;
 
 	/*single step inline, if it a breakpoint instruction*/
@@ -110,12 +131,18 @@ static int kprobe_handler(struct pt_regs
 				unlock_kprobes();
 				goto no_kprobe;
 			}
-			arch_disarm_kprobe(p);
-			regs->tpc = (unsigned long) p->addr;
-			regs->tnpc = current_kprobe_orig_tnpc;
-			regs->tstate = ((regs->tstate & ~TSTATE_PIL) |
-					current_kprobe_orig_tstate_pil);
-			ret = 1;
+			/* We have reentered the kprobe_handler(), since
+			 * another probe was hit while within the handler.
+			 * We here save the original kprobes variables and
+			 * just single step on the instruction of the new probe
+			 * without calling any user handlers.
+			 */
+			save_previous_kprobe();
+			set_current_kprobe(p, regs);
+			p->nmissed++;
+			kprobe_status = KPROBE_REENTER;
+			prepare_singlestep(p, regs);
+			return 1;
 		} else {
 			p = current_kprobe;
 			if (p->break_handler && p->break_handler(p, regs))
@@ -143,8 +170,8 @@ static int kprobe_handler(struct pt_regs
 		goto no_kprobe;
 	}
 
+	set_current_kprobe(p, regs);
 	kprobe_status = KPROBE_HIT_ACTIVE;
-	current_kprobe = p;
 	if (p->pre_handler && p->pre_handler(p, regs))
 		return 1;
 
@@ -250,12 +277,20 @@ static inline int post_kprobe_handler(st
 	if (!kprobe_running())
 		return 0;
 
-	if (current_kprobe->post_handler)
+	if ((kprobe_status != KPROBE_REENTER) && current_kprobe->post_handler) {
+		kprobe_status = KPROBE_HIT_SSDONE;
 		current_kprobe->post_handler(current_kprobe, regs, 0);
+	}
 
 	resume_execution(current_kprobe, regs);
 
+	/*Restore back the original saved kprobes variables and continue. */
+	if (kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe();
+		goto out;
+	}
 	unlock_kprobes();
+out:
 	preempt_enable_no_resched();
 
 	return 1;
@@ -397,3 +432,4 @@ int longjmp_break_handler(struct kprobe 
 	}
 	return 0;
 }
+

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
