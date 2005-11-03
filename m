Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVKCENO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVKCENO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 23:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbVKCENN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 23:13:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58049 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030296AbVKCENM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 23:13:12 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Hemminger <shemminger@osdl.org>, Andi Kleen <ak@suse.de>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [Patch 2.6.14] Clean up the die notifier registration routines
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Nov 2005 15:12:33 +1100
Message-ID: <7924.1130991153@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the extraneous die_notifier_lock, notifier_chain_register()
and notifier_chain_unregister already take a lock.  Also there is some
work being done to make the generic notify code race safe and the
die_notifier_lock would get in that way of that rework.  See
http://marc.theaimsgroup.com/?l=linux-kernel&m=113018709002036&w=2

Add unregister_die_notifier() and export it on all architectures.

Export register_die_notifier() on some architectures, others already
had an export.

Correct include/asm-*/kdebug.h to define the functions as extern.

Remove trailing whitespace in include/asm-x86_64/kdebug.h.

Compile tested on i386 and x86_64, ppc64 and sparc64 have only been
desk checked.  The ia64 patch has some additional changes to arch/ia64
code so the ia64 changes are not here, instead they have gone to the
ia64 maintainer.

Signed-off-by: Keith Owens <kaos@sgi.com>

---

 arch/i386/kernel/traps.c     |   14 +++++++-------
 arch/ppc64/kernel/traps.c    |   14 +++++++-------
 arch/sparc64/kernel/traps.c  |   15 ++++++++-------
 arch/x86_64/kernel/traps.c   |   15 ++++++++-------
 include/asm-i386/kdebug.h    |    6 ++----
 include/asm-ppc64/kdebug.h   |    8 ++------
 include/asm-sparc64/kdebug.h |    7 ++-----
 include/asm-x86_64/kdebug.h  |   26 ++++++++++++--------------
 8 files changed, 48 insertions(+), 57 deletions(-)

Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c	2005-11-02 12:22:42.197126225 +1100
+++ linux/arch/i386/kernel/traps.c	2005-11-03 13:43:06.024887131 +1100
@@ -93,19 +93,19 @@ asmlinkage void machine_check(void);
 
 static int kstack_depth_to_print = 24;
 struct notifier_block *i386die_chain;
-static DEFINE_SPINLOCK(die_notifier_lock);
 
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
Index: linux/arch/ppc64/kernel/traps.c
===================================================================
--- linux.orig/arch/ppc64/kernel/traps.c	2005-10-28 10:02:08.000000000 +1000
+++ linux/arch/ppc64/kernel/traps.c	2005-11-03 13:45:15.066635994 +1100
@@ -63,18 +63,18 @@ EXPORT_SYMBOL(__debugger_fault_handler);
 #endif
 
 struct notifier_block *ppc64_die_chain;
-static DEFINE_SPINLOCK(die_notifier_lock);
 
 int register_die_notifier(struct notifier_block *nb)
 {
-	int err = 0;
-	unsigned long flags;
+	return notifier_chain_register(&ppc64_die_chain, nb);
+}
+EXPORT_SYMBOL(register_die_notifier);
 
-	spin_lock_irqsave(&die_notifier_lock, flags);
-	err = notifier_chain_register(&ppc64_die_chain, nb);
-	spin_unlock_irqrestore(&die_notifier_lock, flags);
-	return err;
+int unregister_die_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_unregister(&ppc64_die_chain, nb);
 }
+EXPORT_SYMBOL(unregister_die_notifier);
 
 /*
  * Trap & Exception support
Index: linux/arch/sparc64/kernel/traps.c
===================================================================
--- linux.orig/arch/sparc64/kernel/traps.c	2005-10-28 10:02:08.000000000 +1000
+++ linux/arch/sparc64/kernel/traps.c	2005-11-03 13:45:55.954543857 +1100
@@ -43,17 +43,18 @@
 #endif
 
 struct notifier_block *sparc64die_chain;
-static DEFINE_SPINLOCK(die_notifier_lock);
 
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
Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c	2005-10-28 10:02:08.000000000 +1000
+++ linux/arch/x86_64/kernel/traps.c	2005-11-03 13:46:37.593324605 +1100
@@ -73,17 +73,18 @@ asmlinkage void spurious_interrupt_bug(v
 asmlinkage void call_debug(void);
 
 struct notifier_block *die_chain;
-static DEFINE_SPINLOCK(die_notifier_lock);
 
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
Index: linux/include/asm-i386/kdebug.h
===================================================================
--- linux.orig/include/asm-i386/kdebug.h	2005-10-28 10:02:08.000000000 +1000
+++ linux/include/asm-i386/kdebug.h	2005-11-03 13:48:07.152245253 +1100
@@ -17,10 +17,8 @@ struct die_args {
 	int signr;
 };
 
-/* Note - you should never unregister because that can race with NMIs.
-   If you really want to do it first unregister - then synchronize_sched - then free.
-  */
-int register_die_notifier(struct notifier_block *nb);
+extern int register_die_notifier(struct notifier_block *);
+extern int unregister_die_notifier(struct notifier_block *);
 extern struct notifier_block *i386die_chain;
 
 
Index: linux/include/asm-ppc64/kdebug.h
===================================================================
--- linux.orig/include/asm-ppc64/kdebug.h	2005-10-28 10:02:08.000000000 +1000
+++ linux/include/asm-ppc64/kdebug.h	2005-11-03 13:51:34.739787840 +1100
@@ -15,12 +15,8 @@ struct die_args {
 	int signr;
 };
 
-/*
-   Note - you should never unregister because that can race with NMIs.
-   If you really want to do it first unregister - then synchronize_sched -
-   then free.
- */
-int register_die_notifier(struct notifier_block *nb);
+extern int register_die_notifier(struct notifier_block *);
+extern int unregister_die_notifier(struct notifier_block *);
 extern struct notifier_block *ppc64_die_chain;
 
 /* Grossly misnamed. */
Index: linux/include/asm-sparc64/kdebug.h
===================================================================
--- linux.orig/include/asm-sparc64/kdebug.h	2005-10-28 10:02:08.000000000 +1000
+++ linux/include/asm-sparc64/kdebug.h	2005-11-03 13:52:18.815730761 +1100
@@ -15,11 +15,8 @@ struct die_args {
 	int signr;
 };
 
-/* Note - you should never unregister because that can race with NMIs.
- * If you really want to do it first unregister - then synchronize_sched
- * - then free.
- */
-int register_die_notifier(struct notifier_block *nb);
+extern int register_die_notifier(struct notifier_block *);
+extern int unregister_die_notifier(struct notifier_block *);
 extern struct notifier_block *sparc64die_chain;
 
 extern void bad_trap(struct pt_regs *, long);
Index: linux/include/asm-x86_64/kdebug.h
===================================================================
--- linux.orig/include/asm-x86_64/kdebug.h	2005-10-28 10:02:08.000000000 +1000
+++ linux/include/asm-x86_64/kdebug.h	2005-11-03 13:52:54.735573771 +1100
@@ -5,21 +5,19 @@
 
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
 
-/* Note - you should never unregister because that can race with NMIs.
-   If you really want to do it first unregister - then synchronize_sched - then free.
-  */
-int register_die_notifier(struct notifier_block *nb);
+extern int register_die_notifier(struct notifier_block *);
+extern int unregister_die_notifier(struct notifier_block *);
 extern struct notifier_block *die_chain;
 /* Grossly misnamed. */
-enum die_val { 
+enum die_val {
 	DIE_OOPS = 1,
 	DIE_INT3,
 	DIE_DEBUG,
@@ -33,13 +31,13 @@ enum die_val { 
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

