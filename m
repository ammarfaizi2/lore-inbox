Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWDJGAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWDJGAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 02:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWDJGAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 02:00:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47325 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751026AbWDJGAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 02:00:20 -0400
Date: Mon, 10 Apr 2006 11:30:35 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, systemtap@sources.redhat.com
Subject: Re: [PATCH] [4/5] Switch Kprobes inline functions to __kprobes for ia64
Message-ID: <20060410060035.GC23879@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060410055712.GA24711@in.ibm.com> <20060410055813.GA23879@in.ibm.com> <20060410055938.GB23879@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410055938.GB23879@in.ibm.com>
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


 arch/ia64/kernel/kprobes.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN arch/ia64/kernel/kprobes.c~kprobes-remove-inline-kprobe-functions-ia64 arch/ia64/kernel/kprobes.c
--- linux-2.6.17-rc1-mm2/arch/ia64/kernel/kprobes.c~kprobes-remove-inline-kprobe-functions-ia64	2006-04-10 11:00:37.000000000 +0530
+++ linux-2.6.17-rc1-mm2-prasanna/arch/ia64/kernel/kprobes.c	2006-04-10 11:00:37.000000000 +0530
@@ -251,7 +251,7 @@ static void __kprobes prepare_break_inst
 	update_kprobe_inst_flag(template, slot, major_opcode, kprobe_inst, p);
 }
 
-static inline void get_kprobe_inst(bundle_t *bundle, uint slot,
+static void __kprobes get_kprobe_inst(bundle_t *bundle, uint slot,
 	       	unsigned long *kprobe_inst, uint *major_opcode)
 {
 	unsigned long kprobe_inst_p0, kprobe_inst_p1;
@@ -278,7 +278,7 @@ static inline void get_kprobe_inst(bundl
 }
 
 /* Returns non-zero if the addr is in the Interrupt Vector Table */
-static inline int in_ivt_functions(unsigned long addr)
+static int __kprobes in_ivt_functions(unsigned long addr)
 {
 	return (addr >= (unsigned long)__start_ivt_text
 		&& addr < (unsigned long)__end_ivt_text);
@@ -308,19 +308,19 @@ static int __kprobes valid_kprobe_addr(i
 	return 0;
 }
 
-static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
+static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	kcb->prev_kprobe.kp = kprobe_running();
 	kcb->prev_kprobe.status = kcb->kprobe_status;
 }
 
-static inline void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
+static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	__get_cpu_var(current_kprobe) = kcb->prev_kprobe.kp;
 	kcb->kprobe_status = kcb->prev_kprobe.status;
 }
 
-static inline void set_current_kprobe(struct kprobe *p,
+static void __kprobes set_current_kprobe(struct kprobe *p,
 			struct kprobe_ctlblk *kcb)
 {
 	__get_cpu_var(current_kprobe) = p;

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
