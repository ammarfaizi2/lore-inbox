Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVJJOlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVJJOlf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVJJOlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:41:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:41903 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750818AbVJJOle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:41:34 -0400
Date: Mon, 10 Oct 2005 10:41:07 -0400
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
       prasanna@in.ibm.com
Subject: [PATCH 2/9] Kprobes: Track kprobe on a per_cpu basis - base changes
Message-ID: <20051010144107.GC4389@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20051010143747.GA4389@in.ibm.com> <20051010143928.GB4389@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010143928.GB4389@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Changes to the base kprobe infrastructure to track kprobe execution on a
per-cpu basis.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---

 include/linux/kprobes.h |   31 ++++++++++++++++++++++---------
 kernel/kprobes.c        |   43 ++++++++++++++++++++++++++++---------------
 2 files changed, 50 insertions(+), 24 deletions(-)

Index: linux-2.6.14-rc3/include/linux/kprobes.h
===================================================================
--- linux-2.6.14-rc3.orig/include/linux/kprobes.h	2005-09-30 17:17:35.000000000 -0400
+++ linux-2.6.14-rc3/include/linux/kprobes.h	2005-10-05 15:25:39.000000000 -0400
@@ -33,6 +33,7 @@
 #include <linux/list.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
+#include <linux/percpu.h>
 
 #include <asm/kprobes.h>
 
@@ -106,6 +107,9 @@ struct jprobe {
 	kprobe_opcode_t *entry;	/* probe handling code to jump to */
 };
 
+DECLARE_PER_CPU(struct kprobe *, current_kprobe);
+DECLARE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
+
 #ifdef ARCH_SUPPORTS_KRETPROBES
 extern void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs);
 #else /* ARCH_SUPPORTS_KRETPROBES */
@@ -146,13 +150,6 @@ struct kretprobe_instance {
 void lock_kprobes(void);
 void unlock_kprobes(void);
 
-/* kprobe running now on this CPU? */
-static inline int kprobe_running(void)
-{
-	extern unsigned int kprobe_cpu;
-	return kprobe_cpu == smp_processor_id();
-}
-
 extern int arch_prepare_kprobe(struct kprobe *p);
 extern void arch_copy_kprobe(struct kprobe *p);
 extern void arch_arm_kprobe(struct kprobe *p);
@@ -167,6 +164,22 @@ extern void free_insn_slot(kprobe_opcode
 struct kprobe *get_kprobe(void *addr);
 struct hlist_head * kretprobe_inst_table_head(struct task_struct *tsk);
 
+/* kprobe_running() will just return the current_kprobe on this CPU */
+static inline struct kprobe *kprobe_running(void)
+{
+	return (__get_cpu_var(current_kprobe));
+}
+
+static inline void reset_current_kprobe(void)
+{
+	__get_cpu_var(current_kprobe) = NULL;
+}
+
+static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
+{
+	return (&__get_cpu_var(kprobe_ctlblk));
+}
+
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int setjmp_pre_handler(struct kprobe *, struct pt_regs *);
@@ -183,9 +196,9 @@ void add_rp_inst(struct kretprobe_instan
 void kprobe_flush_task(struct task_struct *tk);
 void recycle_rp_inst(struct kretprobe_instance *ri);
 #else /* CONFIG_KPROBES */
-static inline int kprobe_running(void)
+static inline struct kprobe *kprobe_running(void)
 {
-	return 0;
+	return NULL;
 }
 static inline int register_kprobe(struct kprobe *p)
 {
Index: linux-2.6.14-rc3/kernel/kprobes.c
===================================================================
--- linux-2.6.14-rc3.orig/kernel/kprobes.c	2005-09-30 17:17:35.000000000 -0400
+++ linux-2.6.14-rc3/kernel/kprobes.c	2005-10-05 15:25:39.000000000 -0400
@@ -50,7 +50,7 @@ static struct hlist_head kretprobe_inst_
 
 unsigned int kprobe_cpu = NR_CPUS;
 static DEFINE_SPINLOCK(kprobe_lock);
-static struct kprobe *curr_kprobe;
+static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
 
 /*
  * kprobe->ainsn.insn points to the copy of the instruction to be
@@ -187,6 +187,17 @@ void __kprobes unlock_kprobes(void)
  	local_irq_restore(flags);
 }
 
+/* We have preemption disabled.. so it is safe to use __ versions */
+static inline void set_kprobe_instance(struct kprobe *kp)
+{
+	__get_cpu_var(kprobe_instance) = kp;
+}
+
+static inline void reset_kprobe_instance(void)
+{
+	__get_cpu_var(kprobe_instance) = NULL;
+}
+
 /* You have to be holding the kprobe_lock */
 struct kprobe __kprobes *get_kprobe(void *addr)
 {
@@ -212,11 +223,11 @@ static int __kprobes aggr_pre_handler(st
 
 	list_for_each_entry(kp, &p->list, list) {
 		if (kp->pre_handler) {
-			curr_kprobe = kp;
+			set_kprobe_instance(kp);
 			if (kp->pre_handler(kp, regs))
 				return 1;
 		}
-		curr_kprobe = NULL;
+		reset_kprobe_instance();
 	}
 	return 0;
 }
@@ -228,9 +239,9 @@ static void __kprobes aggr_post_handler(
 
 	list_for_each_entry(kp, &p->list, list) {
 		if (kp->post_handler) {
-			curr_kprobe = kp;
+			set_kprobe_instance(kp);
 			kp->post_handler(kp, regs, flags);
-			curr_kprobe = NULL;
+			reset_kprobe_instance();
 		}
 	}
 	return;
@@ -239,12 +250,14 @@ static void __kprobes aggr_post_handler(
 static int __kprobes aggr_fault_handler(struct kprobe *p, struct pt_regs *regs,
 					int trapnr)
 {
+	struct kprobe *cur = __get_cpu_var(kprobe_instance);
+
 	/*
 	 * if we faulted "during" the execution of a user specified
 	 * probe handler, invoke just that probe's fault handler
 	 */
-	if (curr_kprobe && curr_kprobe->fault_handler) {
-		if (curr_kprobe->fault_handler(curr_kprobe, regs, trapnr))
+	if (cur && cur->fault_handler) {
+		if (cur->fault_handler(cur, regs, trapnr))
 			return 1;
 	}
 	return 0;
@@ -252,15 +265,15 @@ static int __kprobes aggr_fault_handler(
 
 static int __kprobes aggr_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	struct kprobe *kp = curr_kprobe;
-	if (curr_kprobe && kp->break_handler) {
-		if (kp->break_handler(kp, regs)) {
-			curr_kprobe = NULL;
-			return 1;
-		}
+	struct kprobe *cur = __get_cpu_var(kprobe_instance);
+	int ret = 0;
+
+	if (cur && cur->break_handler) {
+		if (cur->break_handler(cur, regs))
+			ret = 1;
 	}
-	curr_kprobe = NULL;
-	return 0;
+	reset_kprobe_instance();
+	return ret;
 }
 
 struct kretprobe_instance __kprobes *get_free_rp_inst(struct kretprobe *rp)
