Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVLIVD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVLIVD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVLIVD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:03:57 -0500
Received: from fmr22.intel.com ([143.183.121.14]:26011 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932068AbVLIVD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:03:57 -0500
Date: Fri, 9 Dec 2005 13:03:45 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       anil.s.keshavamurthy@intel.com,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>
Subject: [BUG][PATCH] Kprobes - Increment kprobe missed count for multiprobes
Message-ID: <20051209130345.A8254@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[BUG][PATCH] Kprobes - Increment kprobe missed count for multiprobes

When multiple probes are registered at the same address and if due
to some recursion (probe getting triggered within a probe handler),
we skip calling pre_handlers and just increment nmissed field.

The below patch make sure it walks the list for multiple probes
case. Without the below patch we get incorrect results of nmissed
count for multiple probe case.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
-----------------------------------------------------
 arch/i386/kernel/kprobes.c    |    2 +-
 arch/ia64/kernel/kprobes.c    |    2 +-
 arch/powerpc/kernel/kprobes.c |    2 +-
 arch/sparc64/kernel/kprobes.c |    2 +-
 arch/x86_64/kernel/kprobes.c  |    2 +-
 include/linux/kprobes.h       |    1 +
 kernel/kprobes.c              |   13 +++++++++++++
 7 files changed, 19 insertions(+), 5 deletions(-)

Index: linux-2.6.15-rc5-mm1/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/i386/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm1/arch/i386/kernel/kprobes.c
@@ -191,7 +191,7 @@ static int __kprobes kprobe_handler(stru
 			 */
 			save_previous_kprobe(kcb);
 			set_current_kprobe(p, regs, kcb);
-			p->nmissed++;
+			inc_nmissed_count(p);
 			prepare_singlestep(p, regs);
 			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
Index: linux-2.6.15-rc5-mm1/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm1/arch/ia64/kernel/kprobes.c
@@ -630,7 +630,7 @@ static int __kprobes pre_kprobes_handler
 			 */
 			save_previous_kprobe(kcb);
 			set_current_kprobe(p, kcb);
-			p->nmissed++;
+			inc_nmissed_count(p);
 			prepare_ss(p, regs);
 			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
Index: linux-2.6.15-rc5-mm1/arch/powerpc/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/powerpc/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm1/arch/powerpc/kernel/kprobes.c
@@ -174,7 +174,7 @@ static inline int kprobe_handler(struct 
 			save_previous_kprobe(kcb);
 			set_current_kprobe(p, regs, kcb);
 			kcb->kprobe_saved_msr = regs->msr;
-			p->nmissed++;
+			inc_nmissed_count(p);
 			prepare_singlestep(p, regs);
 			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
Index: linux-2.6.15-rc5-mm1/arch/sparc64/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/sparc64/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm1/arch/sparc64/kernel/kprobes.c
@@ -138,7 +138,7 @@ static int __kprobes kprobe_handler(stru
 			 */
 			save_previous_kprobe(kcb);
 			set_current_kprobe(p, regs, kcb);
-			p->nmissed++;
+			inc_nmissed_count(p);
 			kcb->kprobe_status = KPROBE_REENTER;
 			prepare_singlestep(p, regs, kcb);
 			return 1;
Index: linux-2.6.15-rc5-mm1/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/x86_64/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm1/arch/x86_64/kernel/kprobes.c
@@ -329,7 +329,7 @@ int __kprobes kprobe_handler(struct pt_r
 				 */
 				save_previous_kprobe(kcb);
 				set_current_kprobe(p, regs, kcb);
-				p->nmissed++;
+				inc_nmissed_count(p);
 				prepare_singlestep(p, regs);
 				kcb->kprobe_status = KPROBE_REENTER;
 				return 1;
Index: linux-2.6.15-rc5-mm1/include/linux/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/include/linux/kprobes.h
+++ linux-2.6.15-rc5-mm1/include/linux/kprobes.h
@@ -158,6 +158,7 @@ extern int arch_init_kprobes(void);
 extern void show_registers(struct pt_regs *regs);
 extern kprobe_opcode_t *get_insn_slot(void);
 extern void free_insn_slot(kprobe_opcode_t *slot);
+extern void inc_nmissed_count(struct kprobe *p);
 
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
 struct kprobe *get_kprobe(void *addr);
Index: linux-2.6.15-rc5-mm1/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm1/kernel/kprobes.c
@@ -246,6 +246,19 @@ static int __kprobes aggr_break_handler(
 	return ret;
 }
 
+/* Walks the list and increments nmissed count for multiprobe case */
+void __kprobes inc_nmissed_count(struct kprobe *p)
+{
+	struct kprobe *kp;
+	if (p->pre_handler != aggr_pre_handler) {
+		p->nmissed++;
+	} else {
+		list_for_each_entry_rcu(kp, &p->list, list)
+			kp->nmissed++;
+	}
+	return;
+}
+
 /* Called with kretprobe_lock held */
 struct kretprobe_instance __kprobes *get_free_rp_inst(struct kretprobe *rp)
 {
