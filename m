Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161211AbVKSCUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbVKSCUo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161226AbVKSCUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:20:43 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:30445 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161228AbVKSCUh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:20:37 -0500
Subject: [RFC][PATCH 4/7]: changes notifier head of diechains and add
	notify_chain_unregister
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, Alan Stern <stern@rowland.harvard.edu>,
       kaos@sgi.com
Content-Type: text/plain
Organization: IBM
Date: Fri, 18 Nov 2005 18:20:35 -0800
Message-Id: <1132366835.9617.16.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the usages of the various die_chains.  It covers the
changes posted by Keith Owens.  Among them is addition of an unregister
routine; with the new fixes unregister will not race with callouts.

Signed-off-by:  Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by:  Alan Stern <stern@rowland.harvard.edu>
-----

 arch/i386/kernel/traps.c     |   16 ++++++++--------
 arch/ia64/kernel/traps.c     |    2 +-
 arch/powerpc/kernel/traps.c  |   16 ++++++++--------
 arch/sparc64/kernel/traps.c  |   17 +++++++++--------
 arch/x86_64/kernel/traps.c   |   17 +++++++++--------
 include/asm-i386/kdebug.h    |    8 +++-----
 include/asm-ia64/kdebug.h    |    2 +-
 include/asm-powerpc/kdebug.h |   10 +++-------
 include/asm-sparc64/kdebug.h |    9 +++------
 include/asm-x86_64/kdebug.h  |   29 ++++++++++++++---------------
 10 files changed, 59 insertions(+), 67 deletions(-)

Index: l2615-rc1-notifiers/include/asm-i386/kdebug.h
===================================================================
--- l2615-rc1-notifiers.orig/include/asm-i386/kdebug.h
+++ l2615-rc1-notifiers/include/asm-i386/kdebug.h
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
+extern struct notifier_head i386die_chain;
 
 
 /* Grossly misnamed. */
Index: l2615-rc1-notifiers/arch/i386/kernel/traps.c
===================================================================
--- l2615-rc1-notifiers.orig/arch/i386/kernel/traps.c
+++ l2615-rc1-notifiers/arch/i386/kernel/traps.c
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
+	return notifier_chain_register(&i386die_chain, nb);
 }
 EXPORT_SYMBOL(register_die_notifier);
 
+int unregister_die_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_unregister(&i386die_chain, nb);
+}
+EXPORT_SYMBOL(unregister_die_notifier);
+
 static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
 {
 	return	p > (void *)tinfo &&
Index: l2615-rc1-notifiers/include/asm-ia64/kdebug.h
===================================================================
--- l2615-rc1-notifiers.orig/include/asm-ia64/kdebug.h
+++ l2615-rc1-notifiers/include/asm-ia64/kdebug.h
@@ -40,7 +40,7 @@ struct die_args {
 
 extern int register_die_notifier(struct notifier_block *);
 extern int unregister_die_notifier(struct notifier_block *);
-extern struct notifier_block *ia64die_chain;
+extern struct notifier_head ia64die_chain;
 
 enum die_val {
 	DIE_BREAK = 1,
Index: l2615-rc1-notifiers/arch/ia64/kernel/traps.c
===================================================================
--- l2615-rc1-notifiers.orig/arch/ia64/kernel/traps.c
+++ l2615-rc1-notifiers/arch/ia64/kernel/traps.c
@@ -29,7 +29,7 @@ extern spinlock_t timerlist_lock;
 fpswa_interface_t *fpswa_interface;
 EXPORT_SYMBOL(fpswa_interface);
 
-struct notifier_block *ia64die_chain;
+ATOMIC_NOTIFIER_HEAD(ia64die_chain);
 
 int
 register_die_notifier(struct notifier_block *nb)
Index: l2615-rc1-notifiers/include/asm-powerpc/kdebug.h
===================================================================
--- l2615-rc1-notifiers.orig/include/asm-powerpc/kdebug.h
+++ l2615-rc1-notifiers/include/asm-powerpc/kdebug.h
@@ -15,13 +15,9 @@ struct die_args {
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
+extern struct notifier_head powerpc_die_chain;
 
 /* Grossly misnamed. */
 enum die_val {
Index: l2615-rc1-notifiers/arch/powerpc/kernel/traps.c
===================================================================
--- l2615-rc1-notifiers.orig/arch/powerpc/kernel/traps.c
+++ l2615-rc1-notifiers/arch/powerpc/kernel/traps.c
@@ -73,19 +73,19 @@ EXPORT_SYMBOL(__debugger_dabr_match);
 EXPORT_SYMBOL(__debugger_fault_handler);
 #endif
 
-struct notifier_block *powerpc_die_chain;
-static DEFINE_SPINLOCK(die_notifier_lock);
+ATOMIC_NOTIFIER_HEAD(powerpc_die_chain);
 
 int register_die_notifier(struct notifier_block *nb)
 {
-	int err = 0;
-	unsigned long flags;
+	return notifier_chain_register(&powerpc_die_chain, nb);
+}
+EXPORT_SYMBOL(register_die_notifier);
 
-	spin_lock_irqsave(&die_notifier_lock, flags);
-	err = notifier_chain_register(&powerpc_die_chain, nb);
-	spin_unlock_irqrestore(&die_notifier_lock, flags);
-	return err;
+int unregister_die_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_unregister(&powerpc_die_chain, nb);
 }
+EXPORT_SYMBOL(unregister_die_notifier);
 
 /*
  * Trap & Exception support
Index: l2615-rc1-notifiers/include/asm-sparc64/kdebug.h
===================================================================
--- l2615-rc1-notifiers.orig/include/asm-sparc64/kdebug.h
+++ l2615-rc1-notifiers/include/asm-sparc64/kdebug.h
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
+extern struct notifier_head sparc64die_chain;
 
 extern void bad_trap(struct pt_regs *, long);
 
Index: l2615-rc1-notifiers/arch/sparc64/kernel/traps.c
===================================================================
--- l2615-rc1-notifiers.orig/arch/sparc64/kernel/traps.c
+++ l2615-rc1-notifiers/arch/sparc64/kernel/traps.c
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
+	return notifier_chain_register(&sparc64die_chain, nb);
 }
+EXPORT_SYMBOL(register_die_notifier);
+
+int unregister_die_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_unregister(&sparc64die_chain, nb);
+}
+EXPORT_SYMBOL(unregister_die_notifier);
 
 /* When an irrecoverable trap occurs at tl > 0, the trap entry
  * code logs the trap state registers at every level in the trap
Index: l2615-rc1-notifiers/include/asm-x86_64/kdebug.h
===================================================================
--- l2615-rc1-notifiers.orig/include/asm-x86_64/kdebug.h
+++ l2615-rc1-notifiers/include/asm-x86_64/kdebug.h
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
+extern struct notifier_head die_chain;
 
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
@@ -33,13 +32,13 @@ enum die_val { 
 	DIE_CALL,
 	DIE_NMI_IPI,
 	DIE_PAGE_FAULT,
-}; 
-	
+};
+
 static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)
-{ 
-	struct die_args args = { .regs=regs, .str=str, .err=err, .trapnr=trap,.signr=sig }; 
-	return notifier_call_chain(&die_chain, val, &args); 
-} 
+{
+	struct die_args args = { .regs=regs, .str=str, .err=err, .trapnr=trap,.signr=sig };
+	return notifier_call_chain(&die_chain, val, &args);
+}
 
 extern int printk_address(unsigned long address);
 extern void die(const char *,struct pt_regs *,long);
Index: l2615-rc1-notifiers/arch/x86_64/kernel/traps.c
===================================================================
--- l2615-rc1-notifiers.orig/arch/x86_64/kernel/traps.c
+++ l2615-rc1-notifiers/arch/x86_64/kernel/traps.c
@@ -72,18 +72,19 @@ asmlinkage void machine_check(void);
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void call_debug(void);
 
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
+	return notifier_chain_register(&die_chain, nb);
+}
+EXPORT_SYMBOL(register_die_notifier);
+
+int unregister_die_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_unregister(&die_chain, nb);
 }
+EXPORT_SYMBOL(unregister_die_notifier);
 
 static inline void conditional_sti(struct pt_regs *regs)
 {

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


