Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVEXKeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVEXKeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVEXKcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:32:33 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:51863 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262073AbVEXKSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 06:18:24 -0400
Date: Tue, 24 May 2005 15:49:45 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, ak@muc.de, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: Re: [PATCH 4/5] Kprobes: Temporary disarming of reentrant probe for ppc64
Message-ID: <20050524101945.GC27186@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050524101532.GA27215@in.ibm.com> <20050524101712.GA27186@in.ibm.com> <20050524101840.GB27186@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524101840.GB27186@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch includes ppc64 architecture specific changes to support temporary
disarming on reentrancy of probes.

Signed-of-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
---


---

 linux-2.6.12-rc4-mm2-prasanna/arch/ppc64/kernel/kprobes.c |   46 +++++++++++---
 1 files changed, 38 insertions(+), 8 deletions(-)

diff -puN arch/ppc64/kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-ppc64 arch/ppc64/kernel/kprobes.c
--- linux-2.6.12-rc4-mm2/arch/ppc64/kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-ppc64	2005-05-24 15:30:04.000000000 +0530
+++ linux-2.6.12-rc4-mm2-prasanna/arch/ppc64/kernel/kprobes.c	2005-05-24 15:30:04.000000000 +0530
@@ -36,12 +36,10 @@
 #include <asm/kdebug.h>
 #include <asm/sstep.h>
 
-/* kprobe_status settings */
-#define KPROBE_HIT_ACTIVE	0x00000001
-#define KPROBE_HIT_SS		0x00000002
-
 static struct kprobe *current_kprobe;
 static unsigned long kprobe_status, kprobe_saved_msr;
+static struct kprobe *kprobe_prev;
+static unsigned long kprobe_status_prev, kprobe_saved_msr_prev;
 static struct pt_regs jprobe_saved_regs;
 
 int arch_prepare_kprobe(struct kprobe *p)
@@ -88,6 +86,20 @@ static inline void prepare_singlestep(st
 		regs->nip = (unsigned long)&p->ainsn.insn;
 }
 
+static inline void save_previous_kprobe(void)
+{
+	kprobe_prev = current_kprobe;
+	kprobe_status_prev = kprobe_status;
+	kprobe_saved_msr_prev = kprobe_saved_msr;
+}
+
+static inline void restore_previous_kprobe(void)
+{
+	current_kprobe = kprobe_prev;
+	kprobe_status = kprobe_status_prev;
+	kprobe_saved_msr = kprobe_saved_msr_prev;
+}
+
 static inline int kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p;
@@ -106,9 +118,19 @@ static inline int kprobe_handler(struct 
 				unlock_kprobes();
 				goto no_kprobe;
 			}
-			arch_disarm_kprobe(p);
-			regs->nip = (unsigned long)p->addr;
-			ret = 1;
+			/* We have reentered the kprobe_handler(), since
+			 * another probe was hit while within the handler.
+			 * We here save the original kprobes variables and
+			 * just single step on the instruction of the new probe
+			 * without calling any user handlers.
+			 */
+			save_previous_kprobe();
+			current_kprobe = p;
+			kprobe_saved_msr = regs->msr;
+			p->nmissed++;
+			prepare_singlestep(p, regs);
+			kprobe_status = KPROBE_REENTER;
+			return 1;
 		} else {
 			p = current_kprobe;
 			if (p->break_handler && p->break_handler(p, regs)) {
@@ -192,13 +214,21 @@ static inline int post_kprobe_handler(st
 	if (!kprobe_running())
 		return 0;
 
-	if (current_kprobe->post_handler)
+	if ((kprobe_status != KPROBE_REENTER) && current_kprobe->post_handler) {
+		kprobe_status = KPROBE_HIT_SSDONE;
 		current_kprobe->post_handler(current_kprobe, regs, 0);
+	}
 
 	resume_execution(current_kprobe, regs);
 	regs->msr |= kprobe_saved_msr;
 
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
