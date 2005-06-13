Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVFMUxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVFMUxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVFMUxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:53:40 -0400
Received: from fmr20.intel.com ([134.134.136.19]:52653 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261327AbVFMUwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:52:38 -0400
Message-Id: <20050613205234.799275000@linux.jf.intel.com>
References: <20050613205153.349171000@linux.jf.intel.com>
Date: Mon, 13 Jun 2005 13:51:54 -0700
From: rusty.lynch@intel.com
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: [patch 1/5] [kprobes] Tweak to the function return probe design 
Content-Disposition: inline; filename=kprobes-return-probes-redux-base.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(The following is a resend from this morning.  The various kernel mailing list
did not seem to get my email, so I am resending the patch series from another
machine.)

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
