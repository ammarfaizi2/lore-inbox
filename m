Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbVLMU4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVLMU4M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVLMU4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:56:11 -0500
Received: from fmr21.intel.com ([143.183.121.13]:8373 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030214AbVLMU4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:56:09 -0500
Message-Id: <20051213203901.264302465@csdlinux-2.jf.intel.com>
References: <20051213203547.649087523@csdlinux-2.jf.intel.com>
Date: Tue, 13 Dec 2005 12:35:50 -0800
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: ananth@in.ibm.com, akpm@osdl.org, paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, prasanna@in.ibm.com,
       systemtap@sources.redhat.com,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [patch 3/4] Kprobes - Changed from using spinlock to mutext
Content-Disposition: inline; filename=rcu_unregister_race_fix_v2.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Kprobes - Changed from using spinlock to mutext

	Since Kprobes runtime exception handlers is now
lock free as this code path is now using RCU to walk 
through the list, there is no need for the 
register/unregister{_kprobe} to use 
spin_{lock/unlock}_isr{save/restore}. The serialization
during registration/unregistration is now possible using
just a mutex.

In the above process, this patch also fixes a minor memory
leak for x86_64 and powerpc.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
===================================================================

 arch/i386/kernel/kprobes.c    |    6 --
 arch/powerpc/kernel/kprobes.c |   14 ++----
 arch/sparc64/kernel/kprobes.c |    6 --
 arch/x86_64/kernel/kprobes.c  |    7 ---
 include/asm-ia64/kprobes.h    |    5 --
 include/linux/kprobes.h       |    1 
 kernel/kprobes.c              |   91 +++++++++++++++++++-----------------------
 7 files changed, 53 insertions(+), 77 deletions(-)

Index: linux-2.6.15-rc5-mm2/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/i386/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm2/arch/i386/kernel/kprobes.c
@@ -58,13 +58,9 @@ static inline int is_IF_modifier(kprobe_
 
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
-	return 0;
-}
-
-void __kprobes arch_copy_kprobe(struct kprobe *p)
-{
 	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 	p->opcode = *p->addr;
+	return 0;
 }
 
 void __kprobes arch_arm_kprobe(struct kprobe *p)
Index: linux-2.6.15-rc5-mm2/arch/powerpc/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/powerpc/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm2/arch/powerpc/kernel/kprobes.c
@@ -60,13 +60,13 @@ int __kprobes arch_prepare_kprobe(struct
 		if (!p->ainsn.insn)
 			ret = -ENOMEM;
 	}
-	return ret;
-}
 
-void __kprobes arch_copy_kprobe(struct kprobe *p)
-{
-	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
-	p->opcode = *p->addr;
+	if (!ret) {
+		memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+		p->opcode = *p->addr;
+	}
+
+	return ret;
 }
 
 void __kprobes arch_arm_kprobe(struct kprobe *p)
@@ -85,9 +85,7 @@ void __kprobes arch_disarm_kprobe(struct
 
 void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
-	down(&kprobe_mutex);
 	free_insn_slot(p->ainsn.insn);
-	up(&kprobe_mutex);
 }
 
 static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
Index: linux-2.6.15-rc5-mm2/arch/sparc64/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/sparc64/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm2/arch/sparc64/kernel/kprobes.c
@@ -43,14 +43,10 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kpr
 
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
-	return 0;
-}
-
-void __kprobes arch_copy_kprobe(struct kprobe *p)
-{
 	p->ainsn.insn[0] = *p->addr;
 	p->ainsn.insn[1] = BREAKPOINT_INSTRUCTION_2;
 	p->opcode = *p->addr;
+	return 0;
 }
 
 void __kprobes arch_arm_kprobe(struct kprobe *p)
Index: linux-2.6.15-rc5-mm2/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/x86_64/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm2/arch/x86_64/kernel/kprobes.c
@@ -42,8 +42,8 @@
 #include <asm/pgtable.h>
 #include <asm/kdebug.h>
 
-static DECLARE_MUTEX(kprobe_mutex);
 void jprobe_return_end(void);
+void __kprobes arch_copy_kprobe(struct kprobe *p);
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
@@ -69,12 +69,11 @@ static inline int is_IF_modifier(kprobe_
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	/* insn: must be on special executable page on x86_64. */
-	down(&kprobe_mutex);
 	p->ainsn.insn = get_insn_slot();
-	up(&kprobe_mutex);
 	if (!p->ainsn.insn) {
 		return -ENOMEM;
 	}
+	arch_copy_kprobe(p);
 	return 0;
 }
 
@@ -223,9 +222,7 @@ void __kprobes arch_disarm_kprobe(struct
 
 void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
-	down(&kprobe_mutex);
 	free_insn_slot(p->ainsn.insn);
-	up(&kprobe_mutex);
 }
 
 static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
Index: linux-2.6.15-rc5-mm2/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/asm-ia64/kprobes.h
@@ -110,11 +110,6 @@ struct arch_specific_insn {
  	unsigned short target_br_reg;
 };
 
-/* ia64 does not need this */
-static inline void arch_copy_kprobe(struct kprobe *p)
-{
-}
-
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
 
Index: linux-2.6.15-rc5-mm2/include/linux/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/linux/kprobes.h
@@ -150,7 +150,6 @@ struct kretprobe_instance {
 
 extern spinlock_t kretprobe_lock;
 extern int arch_prepare_kprobe(struct kprobe *p);
-extern void arch_copy_kprobe(struct kprobe *p);
 extern void arch_arm_kprobe(struct kprobe *p);
 extern void arch_disarm_kprobe(struct kprobe *p);
 extern void arch_remove_kprobe(struct kprobe *p);
Index: linux-2.6.15-rc5-mm2/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm2/kernel/kprobes.c
@@ -48,7 +48,7 @@
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
 
-static DEFINE_SPINLOCK(kprobe_lock);	/* Protects kprobe_table */
+static DECLARE_MUTEX(kprobe_mutex);	/* Protects kprobe_table */
 DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
 static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
 
@@ -167,7 +167,7 @@ static inline void reset_kprobe_instance
 
 /*
  * This routine is called either:
- * 	- under the kprobe_lock spinlock - during kprobe_[un]register()
+ * 	- under the kprobe_mutex - during kprobe_[un]register()
  * 				OR
  * 	- with preemption disabled - from arch/xxx/kernel/kprobes.c
  */
@@ -420,7 +420,6 @@ static inline void add_aggr_kprobe(struc
 /*
  * This is the second or subsequent kprobe at the address - handle
  * the intricacies
- * TODO: Move kcalloc outside the spin_lock
  */
 static int __kprobes register_aggr_kprobe(struct kprobe *old_p,
 					  struct kprobe *p)
@@ -442,25 +441,6 @@ static int __kprobes register_aggr_kprob
 	return ret;
 }
 
-/* kprobe removal house-keeping routines */
-static inline void cleanup_kprobe(struct kprobe *p, unsigned long flags)
-{
-	arch_disarm_kprobe(p);
-	hlist_del_rcu(&p->hlist);
-	spin_unlock_irqrestore(&kprobe_lock, flags);
-	arch_remove_kprobe(p);
-}
-
-static inline void cleanup_aggr_kprobe(struct kprobe *old_p,
-		struct kprobe *p, unsigned long flags)
-{
-	list_del_rcu(&p->list);
-	if (list_empty(&old_p->list))
-		cleanup_kprobe(old_p, flags);
-	else
-		spin_unlock_irqrestore(&kprobe_lock, flags);
-}
-
 static int __kprobes in_kprobes_functions(unsigned long addr)
 {
 	if (addr >= (unsigned long)__kprobes_text_start
@@ -472,7 +452,6 @@ static int __kprobes in_kprobes_function
 int __kprobes register_kprobe(struct kprobe *p)
 {
 	int ret = 0;
-	unsigned long flags = 0;
 	struct kprobe *old_p;
 	struct module *mod;
 
@@ -484,18 +463,17 @@ int __kprobes register_kprobe(struct kpr
 			(unlikely(!try_module_get(mod))))
 		return -EINVAL;
 
-	if ((ret = arch_prepare_kprobe(p)) != 0)
-		goto rm_kprobe;
-
 	p->nmissed = 0;
-	spin_lock_irqsave(&kprobe_lock, flags);
+	down(&kprobe_mutex);
 	old_p = get_kprobe(p->addr);
 	if (old_p) {
 		ret = register_aggr_kprobe(old_p, p);
 		goto out;
 	}
 
-	arch_copy_kprobe(p);
+	if ((ret = arch_prepare_kprobe(p)) != 0)
+		goto out;
+
 	INIT_HLIST_NODE(&p->hlist);
 	hlist_add_head_rcu(&p->hlist,
 		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
@@ -503,10 +481,8 @@ int __kprobes register_kprobe(struct kpr
   	arch_arm_kprobe(p);
 
 out:
-	spin_unlock_irqrestore(&kprobe_lock, flags);
-rm_kprobe:
-	if (ret == -EEXIST)
-		arch_remove_kprobe(p);
+	up(&kprobe_mutex);
+
 	if (ret && mod)
 		module_put(mod);
 	return ret;
@@ -514,29 +490,48 @@ rm_kprobe:
 
 void __kprobes unregister_kprobe(struct kprobe *p)
 {
-	unsigned long flags;
-	struct kprobe *old_p;
 	struct module *mod;
+	struct kprobe *old_p, *cleanup_p;
 
-	spin_lock_irqsave(&kprobe_lock, flags);
+	down(&kprobe_mutex);
 	old_p = get_kprobe(p->addr);
-	if (old_p) {
-		/* cleanup_*_kprobe() does the spin_unlock_irqrestore */
-		if (old_p->pre_handler == aggr_pre_handler)
-			cleanup_aggr_kprobe(old_p, p, flags);
-		else
-			cleanup_kprobe(p, flags);
+	if (unlikely(!old_p)) {
+		up(&kprobe_mutex);
+		return;
+	}
+
+	if ((old_p->pre_handler == aggr_pre_handler) &&
+		(p->list.next == &old_p->list) &&
+		(p->list.prev == &old_p->list)) {
+		/* Only one element in the aggregate list */
+		arch_disarm_kprobe(p);
+		hlist_del_rcu(&old_p->hlist);
+		cleanup_p = old_p;
+	} else if (old_p == p) {
+		/* Only one kprobe element in the hash list */
+		arch_disarm_kprobe(p);
+		hlist_del_rcu(&p->hlist);
+		cleanup_p = p;
+	} else {
+		list_del_rcu(&p->list);
+		cleanup_p = NULL;
+	}
 
-		synchronize_sched();
+	up(&kprobe_mutex);
 
-		if ((mod = module_text_address((unsigned long)p->addr)))
-			module_put(mod);
+	synchronize_sched();
+	if ((mod = module_text_address((unsigned long)p->addr)))
+		module_put(mod);
 
-		if (old_p->pre_handler == aggr_pre_handler &&
-				list_empty(&old_p->list))
+	if (cleanup_p) {
+		if (cleanup_p->pre_handler == aggr_pre_handler) {
+			list_del_rcu(&p->list);
 			kfree(old_p);
-	} else
-		spin_unlock_irqrestore(&kprobe_lock, flags);
+		}
+		down(&kprobe_mutex);
+		arch_remove_kprobe(p);
+		up(&kprobe_mutex);
+	}
 }
 
 static struct notifier_block kprobe_exceptions_nb = {

--

