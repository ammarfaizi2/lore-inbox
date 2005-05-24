Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVEXK3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVEXK3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVEXKUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:20:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46562 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262021AbVEXKPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 06:15:45 -0400
Date: Tue, 24 May 2005 15:47:12 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, ak@muc.de, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: Re: [PATCH 2/5] Kprobes: Temporary disarming of reentrant probe for i386
Message-ID: <20050524101712.GA27186@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050524101532.GA27215@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524101532.GA27215@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch includes i386 architecture specific changes to support temporary
disarming on reentrancy of probes.

Signed-of-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>

---


---

 linux-2.6.12-rc4-mm2-prasanna/arch/i386/kernel/kprobes.c |   62 +++++++++++----
 1 files changed, 49 insertions(+), 13 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-i386 arch/i386/kernel/kprobes.c
--- linux-2.6.12-rc4-mm2/arch/i386/kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-i386	2005-05-24 15:28:48.000000000 +0530
+++ linux-2.6.12-rc4-mm2-prasanna/arch/i386/kernel/kprobes.c	2005-05-24 15:28:48.000000000 +0530
@@ -37,12 +37,10 @@
 #include <asm/kdebug.h>
 #include <asm/desc.h>
 
-/* kprobe_status settings */
-#define KPROBE_HIT_ACTIVE	0x00000001
-#define KPROBE_HIT_SS		0x00000002
-
 static struct kprobe *current_kprobe;
 static unsigned long kprobe_status, kprobe_old_eflags, kprobe_saved_eflags;
+static struct kprobe *kprobe_prev;
+static unsigned long kprobe_status_prev, kprobe_old_eflags_prev, kprobe_saved_eflags_prev;
 static struct pt_regs jprobe_saved_regs;
 static long *jprobe_saved_esp;
 /* copy of the kernel stack at the probe fire time */
@@ -93,6 +91,31 @@ void arch_remove_kprobe(struct kprobe *p
 {
 }
 
+static inline void save_previous_kprobe(void)
+{
+	kprobe_prev = current_kprobe;
+	kprobe_status_prev = kprobe_status;
+	kprobe_old_eflags_prev = kprobe_old_eflags;
+	kprobe_saved_eflags_prev = kprobe_saved_eflags;
+}
+
+static inline void restore_previous_kprobe(void)
+{
+	current_kprobe = kprobe_prev;
+	kprobe_status = kprobe_status_prev;
+	kprobe_old_eflags = kprobe_old_eflags_prev;
+	kprobe_saved_eflags = kprobe_saved_eflags_prev;
+}
+
+static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs)
+{
+	current_kprobe = p;
+	kprobe_saved_eflags = kprobe_old_eflags
+		= (regs->eflags & (TF_MASK | IF_MASK));
+	if (is_IF_modifier(p->opcode))
+		kprobe_saved_eflags &= ~IF_MASK;
+}
+
 static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
 	regs->eflags |= TF_MASK;
@@ -184,9 +207,18 @@ static int kprobe_handler(struct pt_regs
 				unlock_kprobes();
 				goto no_kprobe;
 			}
-			arch_disarm_kprobe(p);
-			regs->eip = (unsigned long)p->addr;
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
+			prepare_singlestep(p, regs);
+			kprobe_status = KPROBE_REENTER;
+			return 1;
 		} else {
 			p = current_kprobe;
 			if (p->break_handler && p->break_handler(p, regs)) {
@@ -221,11 +253,7 @@ static int kprobe_handler(struct pt_regs
 	}
 
 	kprobe_status = KPROBE_HIT_ACTIVE;
-	current_kprobe = p;
-	kprobe_saved_eflags = kprobe_old_eflags
-	    = (regs->eflags & (TF_MASK | IF_MASK));
-	if (is_IF_modifier(p->opcode))
-		kprobe_saved_eflags &= ~IF_MASK;
+	set_current_kprobe(p, regs);
 
 	if (p->pre_handler && p->pre_handler(p, regs))
 		/* handler has already set things up, so skip ss setup */
@@ -370,14 +398,22 @@ static inline int post_kprobe_handler(st
 	if (!kprobe_running())
 		return 0;
 
-	if (current_kprobe->post_handler)
+	if ((kprobe_status != KPROBE_REENTER) && current_kprobe->post_handler) {
+		kprobe_status = KPROBE_HIT_SSDONE;
 		current_kprobe->post_handler(current_kprobe, regs, 0);
+	}
 
 	if (current_kprobe->post_handler != trampoline_post_handler)
 		resume_execution(current_kprobe, regs);
 	regs->eflags |= kprobe_saved_eflags;
 
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
Have a Nice Day!

Thanks & Regards
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
