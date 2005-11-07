Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVKGCNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVKGCNp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 21:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVKGCNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 21:13:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40381 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932406AbVKGCNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 21:13:44 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Hemminger <shemminger@osdl.org>, Andi Kleen <ak@suse.de>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [Patch 2.6.14-git] Clean up the die notifier registration routines
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Nov 2005 13:13:06 +1100
Message-ID: <5524.1131329586@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Respin for the ppc64->powerpc changes.

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

Compile tested on i386 and x86_64, powerpc and sparc64 have only been
desk checked.  The ia64 patch has some additional changes to arch/ia64
code so the ia64 changes are not here, instead they have gone to the
ia64 maintainer.

Signed-off-by: Keith Owens <kaos@sgi.com>

---

 arch/i386/kernel/traps.c     |   14 +++++++-------
 arch/powerpc/kernel/traps.c  |   14 +++++++-------
 arch/sparc64/kernel/traps.c  |   15 ++++++++-------
 arch/x86_64/kernel/traps.c   |   15 ++++++++-------
 include/asm-i386/kdebug.h    |    6 ++----
 include/asm-powerpc/kdebug.h |    8 ++------
 include/asm-sparc64/kdebug.h |    7 ++-----
 include/asm-x86_64/kdebug.h  |   26 ++++++++++++--------------
 8 files changed, 48 insertions(+), 57 deletions(-)

Index: linux-2.6.14/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/traps.c	2005-11-07 13:09:32.153754302 +1100
+++ linux-2.6.14/arch/i386/kernel/traps.c	2005-11-07 13:10:24.340897394 +1100
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
Index: linux-2.6.14/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6.14.orig/arch/powerpc/kernel/traps.c	2005-11-07 13:09:32.768903895 +1100
+++ linux-2.6.14/arch/powerpc/kernel/traps.c	2005-11-07 13:10:24.342850250 +1100
@@ -76,18 +76,18 @@ EXPORT_SYMBOL(__debugger_fault_handler);
 #endif
 
 struct notifier_block *powerpc_die_chain;
-static DEFINE_SPINLOCK(die_notifier_lock);
 
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
Index: linux-2.6.14/arch/sparc64/kernel/traps.c
===================================================================
--- linux-2.6.14.orig/arch/sparc64/kernel/traps.c	2005-11-07 13:09:33.257117858 +1100
+++ linux-2.6.14/arch/sparc64/kernel/traps.c	2005-11-07 13:10:24.345779534 +1100
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
Index: linux-2.6.14/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.14.orig/arch/x86_64/kernel/traps.c	2005-11-07 13:09:33.412369898 +1100
+++ linux-2.6.14/arch/x86_64/kernel/traps.c	2005-11-07 13:10:24.348708818 +1100
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
Index: linux-2.6.14/include/asm-i386/kdebug.h
===================================================================
--- linux-2.6.14.orig/include/asm-i386/kdebug.h	2005-11-07 13:09:40.367466007 +1100
+++ linux-2.6.14/include/asm-i386/kdebug.h	2005-11-07 13:10:24.350661674 +1100
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
 
 
Index: linux-2.6.14/include/asm-powerpc/kdebug.h
===================================================================
--- linux-2.6.14.orig/include/asm-powerpc/kdebug.h	2005-11-07 13:09:41.206217594 +1100
+++ linux-2.6.14/include/asm-powerpc/kdebug.h	2005-11-07 13:10:24.350661674 +1100
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
 extern struct notifier_block *powerpc_die_chain;
 
 /* Grossly misnamed. */
Index: linux-2.6.14/include/asm-sparc64/kdebug.h
===================================================================
--- linux-2.6.14.orig/include/asm-sparc64/kdebug.h	2005-11-07 13:09:41.659280150 +1100
+++ linux-2.6.14/include/asm-sparc64/kdebug.h	2005-11-07 13:10:24.351638102 +1100
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
Index: linux-2.6.14/include/asm-x86_64/kdebug.h
===================================================================
--- linux-2.6.14.orig/include/asm-x86_64/kdebug.h	2005-11-07 13:09:41.761805082 +1100
+++ linux-2.6.14/include/asm-x86_64/kdebug.h	2005-11-07 13:10:24.352614529 +1100
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

