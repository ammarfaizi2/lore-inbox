Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWBJQFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWBJQFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWBJQFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:05:24 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:21386 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751269AbWBJQFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:05:22 -0500
Date: Fri, 10 Feb 2006 11:05:21 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] Notifier chain update: die_chain changes
Message-ID: <Pine.LNX.4.44L0.0602101104480.5227-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Notifier chain re-implementation (as635b): Update the usages of the
various die_chains.  This includes changes posted by Keith Owens,
including the addition of an unregister routine (which is now safe).

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>
Acked-By: Keith Owens <kaos@sgi.com>

Index: l2616/include/asm-i386/kdebug.h
===================================================================
--- l2616.orig/include/asm-i386/kdebug.h
+++ l2616/include/asm-i386/kdebug.h
@@ -17,11 +17,9 @@ struct die_args {
 	int signr;
 };
 
-/* Note - you should never unregister because that can race with NMIs.
-   If you really want to do it first unregister - then synchronize_sched - then free.
-  */
-int register_die_notifier(struct notifier_block *nb);
-extern struct notifier_block *i386die_chain;
+extern int register_die_notifier(struct notifier_block *);
+extern int unregister_die_notifier(struct notifier_block *);
+extern struct atomic_notifier_head i386die_chain;
 
 
 /* Grossly misnamed. */
@@ -51,7 +49,7 @@ static inline int notify_die(enum die_va
 		.trapnr = trap,
 		.signr = sig
 	};
-	return notifier_call_chain(&i386die_chain, val, &args);
+	return atomic_notifier_call_chain(&i386die_chain, val, &args);
 }
 
 #endif
Index: l2616/arch/i386/kernel/traps.c
===================================================================
--- l2616.orig/arch/i386/kernel/traps.c
+++ l2616/arch/i386/kernel/traps.c
@@ -92,20 +92,20 @@ asmlinkage void spurious_interrupt_bug(v
 asmlinkage void machine_check(void);
 
 static int kstack_depth_to_print = 24;
-struct notifier_block *i386die_chain;
-static DEFINE_SPINLOCK(die_notifier_lock);
+ATOMIC_NOTIFIER_HEAD(i386die_chain);
 
 int register_die_notifier(struct notifier_block *nb)
 {
-	int err = 0;
-	unsigned long flags;
-	spin_lock_irqsave(&die_notifier_lock, flags);
-	err = notifier_chain_register(&i386die_chain, nb);
-	spin_unlock_irqrestore(&die_notifier_lock, flags);
-	return err;
+	return atomic_notifier_chain_register(&i386die_chain, nb);
 }
 EXPORT_SYMBOL(register_die_notifier);
 
+int unregister_die_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&i386die_chain, nb);
+}
+EXPORT_SYMBOL(unregister_die_notifier);
+
 static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
 {
 	return	p > (void *)tinfo &&
Index: l2616/include/asm-ia64/kdebug.h
===================================================================
--- l2616.orig/include/asm-ia64/kdebug.h
+++ l2616/include/asm-ia64/kdebug.h
@@ -40,7 +40,7 @@ struct die_args {
 
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
-extern struct notifier_block *ia64die_chain;
+extern struct atomic_notifier_head ia64die_chain;
 
 enum die_val {
 	DIE_BREAK = 1,
@@ -81,7 +81,7 @@ static inline int notify_die(enum die_va
 		.signr  = sig
 	};
 
-	return notifier_call_chain(&ia64die_chain, val, &args);
+	return atomic_notifier_call_chain(&ia64die_chain, val, &args);
 }
 
 #endif
Index: l2616/arch/ia64/kernel/traps.c
===================================================================
--- l2616.orig/arch/ia64/kernel/traps.c
+++ l2616/arch/ia64/kernel/traps.c
@@ -29,19 +29,19 @@ extern spinlock_t timerlist_lock;
 fpswa_interface_t *fpswa_interface;
 EXPORT_SYMBOL(fpswa_interface);
 
-struct notifier_block *ia64die_chain;
+ATOMIC_NOTIFIER_HEAD(ia64die_chain);
 
 int
 register_die_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_register(&ia64die_chain, nb);
+	return atomic_notifier_chain_register(&ia64die_chain, nb);
 }
 EXPORT_SYMBOL_GPL(register_die_notifier);
 
 int
 unregister_die_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&ia64die_chain, nb);
+	return atomic_notifier_chain_unregister(&ia64die_chain, nb);
 }
 EXPORT_SYMBOL_GPL(unregister_die_notifier);
 
Index: l2616/include/asm-powerpc/kdebug.h
===================================================================
--- l2616.orig/include/asm-powerpc/kdebug.h
+++ l2616/include/asm-powerpc/kdebug.h
@@ -16,13 +16,9 @@ struct die_args {
 	int signr;
 };
 
-/*
-   Note - you should never unregister because that can race with NMIs.
-   If you really want to do it first unregister - then synchronize_sched -
-   then free.
- */
-int register_die_notifier(struct notifier_block *nb);
-extern struct notifier_block *powerpc_die_chain;
+extern int register_die_notifier(struct notifier_block *);
+extern int unregister_die_notifier(struct notifier_block *);
+extern struct atomic_notifier_head powerpc_die_chain;
 
 /* Grossly misnamed. */
 enum die_val {
@@ -37,7 +33,7 @@ enum die_val {
 static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)
 {
 	struct die_args args = { .regs=regs, .str=str, .err=err, .trapnr=trap,.signr=sig };
-	return notifier_call_chain(&powerpc_die_chain, val, &args);
+	return atomic_notifier_call_chain(&powerpc_die_chain, val, &args);
 }
 
 #endif /* __KERNEL__ */
Index: l2616/arch/powerpc/kernel/traps.c
===================================================================
--- l2616.orig/arch/powerpc/kernel/traps.c
+++ l2616/arch/powerpc/kernel/traps.c
@@ -74,19 +74,19 @@ EXPORT_SYMBOL(__debugger_dabr_match);
 EXPORT_SYMBOL(__debugger_fault_handler);
 #endif
 
-struct notifier_block *powerpc_die_chain;
-static DEFINE_SPINLOCK(die_notifier_lock);
+ATOMIC_NOTIFIER_HEAD(powerpc_die_chain);
 
 int register_die_notifier(struct notifier_block *nb)
 {
-	int err = 0;
-	unsigned long flags;
+	return atomic_notifier_chain_register(&powerpc_die_chain, nb);
+}
+EXPORT_SYMBOL(register_die_notifier);
 
-	spin_lock_irqsave(&die_notifier_lock, flags);
-	err = notifier_chain_register(&powerpc_die_chain, nb);
-	spin_unlock_irqrestore(&die_notifier_lock, flags);
-	return err;
+int unregister_die_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&powerpc_die_chain, nb);
 }
+EXPORT_SYMBOL(unregister_die_notifier);
 
 /*
  * Trap & Exception support
Index: l2616/include/asm-sparc64/kdebug.h
===================================================================
--- l2616.orig/include/asm-sparc64/kdebug.h
+++ l2616/include/asm-sparc64/kdebug.h
@@ -15,12 +15,9 @@ struct die_args {
 	int signr;
 };
 
-/* Note - you should never unregister because that can race with NMIs.
- * If you really want to do it first unregister - then synchronize_sched
- * - then free.
- */
-int register_die_notifier(struct notifier_block *nb);
-extern struct notifier_block *sparc64die_chain;
+extern int register_die_notifier(struct notifier_block *);
+extern int unregister_die_notifier(struct notifier_block *);
+extern struct atomic_notifier_head sparc64die_chain;
 
 extern void bad_trap(struct pt_regs *, long);
 
@@ -46,7 +43,7 @@ static inline int notify_die(enum die_va
 				 .trapnr	= trap,
 				 .signr		= sig };
 
-	return notifier_call_chain(&sparc64die_chain, val, &args);
+	return atomic_notifier_call_chain(&sparc64die_chain, val, &args);
 }
 
 #endif
Index: l2616/arch/sparc64/kernel/traps.c
===================================================================
--- l2616.orig/arch/sparc64/kernel/traps.c
+++ l2616/arch/sparc64/kernel/traps.c
@@ -42,18 +42,19 @@
 #include <linux/kmod.h>
 #endif
 
-struct notifier_block *sparc64die_chain;
-static DEFINE_SPINLOCK(die_notifier_lock);
+ATOMIC_NOTIFIER_HEAD(sparc64die_chain);
 
 int register_die_notifier(struct notifier_block *nb)
 {
-	int err = 0;
-	unsigned long flags;
-	spin_lock_irqsave(&die_notifier_lock, flags);
-	err = notifier_chain_register(&sparc64die_chain, nb);
-	spin_unlock_irqrestore(&die_notifier_lock, flags);
-	return err;
+	return atomic_notifier_chain_register(&sparc64die_chain, nb);
 }
+EXPORT_SYMBOL(register_die_notifier);
+
+int unregister_die_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&sparc64die_chain, nb);
+}
+EXPORT_SYMBOL(unregister_die_notifier);
 
 /* When an irrecoverable trap occurs at tl > 0, the trap entry
  * code logs the trap state registers at every level in the trap
Index: l2616/include/asm-x86_64/kdebug.h
===================================================================
--- l2616.orig/include/asm-x86_64/kdebug.h
+++ l2616/include/asm-x86_64/kdebug.h
@@ -5,21 +5,20 @@
 
 struct pt_regs;
 
-struct die_args { 
+struct die_args {
 	struct pt_regs *regs;
 	const char *str;
-	long err; 
+	long err;
 	int trapnr;
 	int signr;
-}; 
+};
+
+extern int register_die_notifier(struct notifier_block *);
+extern int unregister_die_notifier(struct notifier_block *);
+extern struct atomic_notifier_head die_chain;
 
-/* Note - you should never unregister because that can race with NMIs.
-   If you really want to do it first unregister - then synchronize_sched - then free.
-  */
-int register_die_notifier(struct notifier_block *nb);
-extern struct notifier_block *die_chain;
 /* Grossly misnamed. */
-enum die_val { 
+enum die_val {
 	DIE_OOPS = 1,
 	DIE_INT3,
 	DIE_DEBUG,
@@ -33,8 +32,8 @@ enum die_val { 
 	DIE_CALL,
 	DIE_NMI_IPI,
 	DIE_PAGE_FAULT,
-}; 
-	
+};
+
 static inline int notify_die(enum die_val val, const char *str,
 			struct pt_regs *regs, long err, int trap, int sig)
 {
@@ -45,7 +44,7 @@ static inline int notify_die(enum die_va
 		.trapnr = trap,
 		.signr = sig
 	};
-	return notifier_call_chain(&die_chain, val, &args); 
+	return atomic_notifier_call_chain(&die_chain, val, &args); 
 } 
 
 extern int printk_address(unsigned long address);
Index: l2616/arch/x86_64/kernel/traps.c
===================================================================
--- l2616.orig/arch/x86_64/kernel/traps.c
+++ l2616/arch/x86_64/kernel/traps.c
@@ -71,18 +71,19 @@ asmlinkage void alignment_check(void);
 asmlinkage void machine_check(void);
 asmlinkage void spurious_interrupt_bug(void);
 
-struct notifier_block *die_chain;
-static DEFINE_SPINLOCK(die_notifier_lock);
+ATOMIC_NOTIFIER_HEAD(die_chain);
 
 int register_die_notifier(struct notifier_block *nb)
 {
-	int err = 0;
-	unsigned long flags;
-	spin_lock_irqsave(&die_notifier_lock, flags);
-	err = notifier_chain_register(&die_chain, nb);
-	spin_unlock_irqrestore(&die_notifier_lock, flags);
-	return err;
+	return atomic_notifier_chain_register(&die_chain, nb);
+}
+EXPORT_SYMBOL(register_die_notifier);
+
+int unregister_die_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&die_chain, nb);
 }
+EXPORT_SYMBOL(unregister_die_notifier);
 
 static inline void conditional_sti(struct pt_regs *regs)
 {

