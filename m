Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932741AbWBUPyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbWBUPyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932742AbWBUPyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:54:47 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:39648 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932741AbWBUPyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:54:46 -0500
Date: Tue, 21 Feb 2006 10:54:44 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Chandra Seetharaman <sekharan@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Register atomic_notifiers in atomic context
Message-ID: <Pine.LNX.4.44L0.0602211045490.5374-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some atomic notifier chains require registrations to take place in atomic
context.  An example is the die_notifier, which on some architectures may
be accessed very early during the boot-up procedure, before task-switching
is legal.  To accomodate these chains, this patch (as655) replaces the
mutex in the atomic_notifier_head structure with a spinlock.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Andrew:

This ought to fix the problem you were seeing with the new notifier chains 
on your emt64 system.

Alan Stern



Index: usb-2.6/kernel/sys.c
===================================================================
--- usb-2.6.orig/kernel/sys.c
+++ usb-2.6/kernel/sys.c
@@ -155,7 +155,6 @@ static int __kprobes notifier_call_chain
  *	@n: New entry in notifier chain
  *
  *	Adds a notifier to an atomic notifier chain.
- *	Must be called in process context.
  *
  *	Currently always returns zero.
  */
@@ -163,11 +162,12 @@ static int __kprobes notifier_call_chain
 int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
 		struct notifier_block *n)
 {
+	unsigned long flags;
 	int ret;
 
-	mutex_lock(&nh->mutex);
+	spin_lock_irqsave(&nh->lock, flags);
 	ret = notifier_chain_register(&nh->head, n);
-	mutex_unlock(&nh->mutex);
+	spin_unlock_irqrestore(&nh->lock, flags);
 	return ret;
 }
 
@@ -179,18 +179,18 @@ EXPORT_SYMBOL(atomic_notifier_chain_regi
  *	@n: Entry to remove from notifier chain
  *
  *	Removes a notifier from an atomic notifier chain.
- *	Must be called from process context.
  *
  *	Returns zero on success or %-ENOENT on failure.
  */
 int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
 		struct notifier_block *n)
 {
+	unsigned long flags;
 	int ret;
 
-	mutex_lock(&nh->mutex);
+	spin_lock_irqsave(&nh->lock, flags);
 	ret = notifier_chain_unregister(&nh->head, n);
-	mutex_unlock(&nh->mutex);
+	spin_unlock_irqrestore(&nh->lock, flags);
 	synchronize_rcu();
 	return ret;
 }
Index: usb-2.6/include/linux/notifier.h
===================================================================
--- usb-2.6.orig/include/linux/notifier.h
+++ usb-2.6/include/linux/notifier.h
@@ -24,9 +24,9 @@
  *		registration, or unregistration.  All locking and protection
  *		must be provided by the caller.
  *
- * atomic_notifier_chain_register() and blocking_notifier_chain_register()
- * may be called only from process context, and likewise for the
- * corresponding _unregister() routines.
+ * atomic_notifier_chain_register() may be called from an atomic context,
+ * but blocking_notifier_chain_register() must be called from a process
+ * context.  Ditto for the corresponding _unregister() routines.
  *
  * atomic_notifier_chain_unregister() and blocking_notifier_chain_unregister()
  * _must not_ be called from within the call chain.
@@ -39,7 +39,7 @@ struct notifier_block {
 };
 
 struct atomic_notifier_head {
-	struct mutex mutex;
+	spinlock_t lock;
 	struct notifier_block *head;
 };
 
@@ -53,7 +53,7 @@ struct raw_notifier_head {
 };
 
 #define ATOMIC_INIT_NOTIFIER_HEAD(name) do {	\
-		mutex_init(&(name)->mutex);	\
+		spin_lock_init(&(name)->lock);	\
 		(name)->head = NULL;		\
 	} while (0)
 #define BLOCKING_INIT_NOTIFIER_HEAD(name) do {	\
@@ -66,7 +66,7 @@ struct raw_notifier_head {
 
 #define ATOMIC_NOTIFIER_HEAD(name)				\
 	struct atomic_notifier_head name = {			\
-		.mutex = __MUTEX_INITIALIZER((name).mutex),	\
+		.lock = SPIN_LOCK_UNLOCKED,			\
 		.head = NULL }
 #define BLOCKING_NOTIFIER_HEAD(name)				\
 	struct blocking_notifier_head name = {			\

