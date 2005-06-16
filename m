Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVFPWij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVFPWij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVFPWib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:38:31 -0400
Received: from fmr19.intel.com ([134.134.136.18]:7346 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261847AbVFPWdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:33:36 -0400
Message-Id: <20050616223254.746591000@linux.jf.intel.com>
References: <20050616223139.444305000@linux.jf.intel.com>
Date: Thu, 16 Jun 2005 15:31:40 -0700
From: rusty.lynch@intel.com
To: akpm@osdl.org
Cc: systemtap@sources.redhat.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Hien Nguyen <hien@us.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>, Andi Kleen <ak@suse.de>,
       Ananth N Mavinakayanahalli <amavin@redhat.com>,
       linuxppc64-dev@ozlabs.org
Subject: [patch 1/5] [kprobes] Tweak to the function return probe design - take 2
Content-Disposition: inline; filename=kprobes-return-probes-redux-base.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the architecture independant changes for the tweaks 
to the function return probe design.

    --rusty

signed-off-by: Rusty Lynch <Rusty.lynch@intel.com>

 include/linux/kprobes.h |   28 ++-----------------
 kernel/kprobes.c        |   69 +++++++++++++-----------------------------------
 2 files changed, 22 insertions(+), 75 deletions(-)

Index: linux-2.6.12-rc6/include/linux/kprobes.h
===================================================================
--- linux-2.6.12-rc6.orig/include/linux/kprobes.h
+++ linux-2.6.12-rc6/include/linux/kprobes.h
@@ -104,33 +104,12 @@ struct jprobe {
 };
 
 #ifdef ARCH_SUPPORTS_KRETPROBES
-extern int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs);
-extern void trampoline_post_handler(struct kprobe *p, struct pt_regs *regs,
-							unsigned long flags);
-extern struct task_struct *arch_get_kprobe_task(void *ptr);
 extern void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs);
-extern void arch_kprobe_flush_task(struct task_struct *tk);
 #else /* ARCH_SUPPORTS_KRETPROBES */
-static inline void kretprobe_trampoline(void)
-{
-}
-static inline int trampoline_probe_handler(struct kprobe *p,
-						struct pt_regs *regs)
-{
-	return 0;
-}
-static inline void trampoline_post_handler(struct kprobe *p,
-				struct pt_regs *regs, unsigned long flags)
-{
-}
 static inline void arch_prepare_kretprobe(struct kretprobe *rp,
 					struct pt_regs *regs)
 {
 }
-static inline void arch_kprobe_flush_task(struct task_struct *tk)
-{
-}
-#define arch_get_kprobe_task(ptr) ((struct task_struct *)NULL)
 #endif /* ARCH_SUPPORTS_KRETPROBES */
 /*
  * Function-return probe -
@@ -155,8 +134,8 @@ struct kretprobe_instance {
 	struct hlist_node uflist; /* either on free list or used list */
 	struct hlist_node hlist;
 	struct kretprobe *rp;
-	void *ret_addr;
-	void *stack_addr;
+	kprobe_opcode_t *ret_addr;
+	struct task_struct *task;
 };
 
 #ifdef CONFIG_KPROBES
@@ -176,6 +155,7 @@ extern void arch_copy_kprobe(struct kpro
 extern void arch_arm_kprobe(struct kprobe *p);
 extern void arch_disarm_kprobe(struct kprobe *p);
 extern void arch_remove_kprobe(struct kprobe *p);
+extern int arch_init(void);
 extern void show_registers(struct pt_regs *regs);
 
 /* Get the kprobe at this addr (if any).  Must have called lock_kprobes */
@@ -194,8 +174,6 @@ int register_kretprobe(struct kretprobe 
 void unregister_kretprobe(struct kretprobe *rp);
 
 struct kretprobe_instance *get_free_rp_inst(struct kretprobe *rp);
-struct kretprobe_instance *get_rp_inst(void *sara);
-struct kretprobe_instance *get_rp_inst_tsk(struct task_struct *tk);
 void add_rp_inst(struct kretprobe_instance *ri);
 void kprobe_flush_task(struct task_struct *tk);
 void recycle_rp_inst(struct kretprobe_instance *ri);
Index: linux-2.6.12-rc6/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc6.orig/kernel/kprobes.c
+++ linux-2.6.12-rc6/kernel/kprobes.c
@@ -138,12 +138,6 @@ static int aggr_break_handler(struct kpr
 	return 0;
 }
 
-struct kprobe trampoline_p = {
-		.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
-		.pre_handler = trampoline_probe_handler,
-		.post_handler = trampoline_post_handler
-};
-
 struct kretprobe_instance *get_free_rp_inst(struct kretprobe *rp)
 {
 	struct hlist_node *node;
@@ -162,35 +156,18 @@ struct kretprobe_instance *get_used_rp_i
 	return NULL;
 }
 
-struct kretprobe_instance *get_rp_inst(void *sara)
-{
-	struct hlist_head *head;
-	struct hlist_node *node;
-	struct task_struct *tsk;
-	struct kretprobe_instance *ri;
-
-	tsk = arch_get_kprobe_task(sara);
-	head = &kretprobe_inst_table[hash_ptr(tsk, KPROBE_HASH_BITS)];
-	hlist_for_each_entry(ri, node, head, hlist) {
-		if (ri->stack_addr == sara)
-			return ri;
-	}
-	return NULL;
-}
-
 void add_rp_inst(struct kretprobe_instance *ri)
 {
-	struct task_struct *tsk;
 	/*
 	 * Remove rp inst off the free list -
 	 * Add it back when probed function returns
 	 */
 	hlist_del(&ri->uflist);
-	tsk = arch_get_kprobe_task(ri->stack_addr);
+
 	/* Add rp inst onto table */
 	INIT_HLIST_NODE(&ri->hlist);
 	hlist_add_head(&ri->hlist,
-			&kretprobe_inst_table[hash_ptr(tsk, KPROBE_HASH_BITS)]);
+			&kretprobe_inst_table[hash_ptr(ri->task, KPROBE_HASH_BITS)]);
 
 	/* Also add this rp inst to the used list. */
 	INIT_HLIST_NODE(&ri->uflist);
@@ -217,34 +194,25 @@ struct hlist_head * kretprobe_inst_table
 	return &kretprobe_inst_table[hash_ptr(tsk, KPROBE_HASH_BITS)];
 }
 
-struct kretprobe_instance *get_rp_inst_tsk(struct task_struct *tk)
-{
-	struct task_struct *tsk;
-	struct hlist_head *head;
-	struct hlist_node *node;
-	struct kretprobe_instance *ri;
-
-	head = &kretprobe_inst_table[hash_ptr(tk, KPROBE_HASH_BITS)];
-
-	hlist_for_each_entry(ri, node, head, hlist) {
-		tsk = arch_get_kprobe_task(ri->stack_addr);
-		if (tsk == tk)
-			return ri;
-	}
-	return NULL;
-}
-
 /*
- * This function is called from do_exit or do_execv when task tk's stack is
- * about to be recycled. Recycle any function-return probe instances
- * associated with this task. These represent probed functions that have
- * been called but may never return.
+ * This function is called from exit_thread or flush_thread when task tk's
+ * stack is being recycled so that we can recycle any function-return probe
+ * instances associated with this task. These left over instances represent
+ * probed functions that have been called but will never return.
  */
 void kprobe_flush_task(struct task_struct *tk)
 {
+        struct kretprobe_instance *ri;
+        struct hlist_head *head;
+	struct hlist_node *node, *tmp;
 	unsigned long flags = 0;
+
 	spin_lock_irqsave(&kprobe_lock, flags);
-	arch_kprobe_flush_task(tk);
+        head = kretprobe_inst_table_head(current);
+        hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
+                if (ri->task == tk)
+                        recycle_rp_inst(ri);
+        }
 	spin_unlock_irqrestore(&kprobe_lock, flags);
 }
 
@@ -504,9 +472,10 @@ static int __init init_kprobes(void)
 		INIT_HLIST_HEAD(&kretprobe_inst_table[i]);
 	}
 
-	err = register_die_notifier(&kprobe_exceptions_nb);
-	/* Register the trampoline probe for return probe */
-	register_kprobe(&trampoline_p);
+	err = arch_init();
+	if (!err)
+		err = register_die_notifier(&kprobe_exceptions_nb);
+
 	return err;
 }
 

--
