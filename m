Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWDJF7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWDJF7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWDJF7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:59:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:12176 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751026AbWDJF7f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:59:35 -0400
Date: Mon, 10 Apr 2006 11:29:38 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, systemtap@sources.redhat.com
Subject: Re: [PATCH] [3/5] Switch Kprobes inline functions to __kprobes for ppc64
Message-ID: <20060410055938.GB23879@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060410055712.GA24711@in.ibm.com> <20060410055813.GA23879@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410055813.GA23879@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton pointed out that compiler might not inline the functions
marked for inline in kprobes. There by allowing the insertion of probes
on these kprobes routines, which might cause recursion. This patch
removes all such inline and adds them to kprobes section there by
disallowing probes on all such routines. Some of the routines can
even still be inlined, since these routines gets executed after
the kprobes had done necessay setup for reentrancy.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


 arch/powerpc/kernel/kprobes.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff -puN arch/powerpc/kernel/kprobes.c~kprobes-remove-inline-kprobe-functions-ppc64 arch/powerpc/kernel/kprobes.c
--- linux-2.6.17-rc1-mm2/arch/powerpc/kernel/kprobes.c~kprobes-remove-inline-kprobe-functions-ppc64	2006-04-10 11:00:06.000000000 +0530
+++ linux-2.6.17-rc1-mm2-prasanna/arch/powerpc/kernel/kprobes.c	2006-04-10 11:00:06.000000000 +0530
@@ -88,7 +88,7 @@ void __kprobes arch_remove_kprobe(struct
 	mutex_unlock(&kprobe_mutex);
 }
 
-static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
 	kprobe_opcode_t insn = *p->ainsn.insn;
 
@@ -101,21 +101,21 @@ static inline void prepare_singlestep(st
 		regs->nip = (unsigned long)p->ainsn.insn;
 }
 
-static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
+static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	kcb->prev_kprobe.kp = kprobe_running();
 	kcb->prev_kprobe.status = kcb->kprobe_status;
 	kcb->prev_kprobe.saved_msr = kcb->kprobe_saved_msr;
 }
 
-static inline void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
+static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	__get_cpu_var(current_kprobe) = kcb->prev_kprobe.kp;
 	kcb->kprobe_status = kcb->prev_kprobe.status;
 	kcb->kprobe_saved_msr = kcb->prev_kprobe.saved_msr;
 }
 
-static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
+static void __kprobes set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 				struct kprobe_ctlblk *kcb)
 {
 	__get_cpu_var(current_kprobe) = p;
@@ -141,7 +141,7 @@ void __kprobes arch_prepare_kretprobe(st
 	}
 }
 
-static inline int kprobe_handler(struct pt_regs *regs)
+static int __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p;
 	int ret = 0;
@@ -334,7 +334,7 @@ static void __kprobes resume_execution(s
 		regs->nip = (unsigned long)p->addr + 4;
 }
 
-static inline int post_kprobe_handler(struct pt_regs *regs)
+static int __kprobes post_kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
@@ -370,7 +370,7 @@ out:
 	return 1;
 }
 
-static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+static int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
