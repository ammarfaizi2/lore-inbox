Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbVLHTx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbVLHTx6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbVLHTx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:53:58 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:16877 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932305AbVLHTx5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:53:57 -0500
Date: Thu, 8 Dec 2005 14:53:56 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: sekharan@us.ibm.com, <ak@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/7]: Fix for unsafe notifier chain
In-Reply-To: <20051207153612.0de2ce38.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0512081438050.4934-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Andrew Morton wrote:

> The default version of notifier chains should be the lockless version -
> just like list_head, radix_tree, etc.  (idr tries to provide its own
> locking and has turned out to be a classic case of why we shouldn't do
> that).
> 
> And sure, it makes sense to provide additional, higher-level data
> structures and APIs which layer on top of that, purely as a code
> consolidation exercise.  But they shouldn't be called notifier_chains. 
> Call them notifier_chain_mutex_locked and notifier_chain_rwlocked and
> notifier_chain_spinlocked or whatever.

The code below defines three new data structures: atomic_notifier_head,
blocking_notifier_head, and raw_notifier_head.  The first two correspond
to what we had in the earlier patch, and raw_notifier_head is almost the
same as the current implementation, with no locking or protection at all.  
(None is the default; the type has to be specified when a notifier chain
is defined or used.)

Each of the three has its own API, which is layered on top of a single set 
of core routines.  Is this basically what you had in mind?

> As for the NMIs and RCU: I suspect it was simply a mistake to try to use
> notifier chains for NMI registration in the first place - they are simply
> too complex a data structure for this.  I think I previously suggested
> removing that code and using just a fixed-size array of function pointers. 
> But if the RCUified notifier chain solution is less-than-totally-gross then
> that might be OK as well.

Let me know if the atomic_notifier_head code looks totally gross.  If you
think this scheme is okay, I'll go through and make the corresponding
changes to all the users of the notifier_chain API.

Alan Stern



Index: usb-2.6/include/linux/notifier.h
===================================================================
--- usb-2.6.orig/include/linux/notifier.h
+++ usb-2.6/include/linux/notifier.h
@@ -10,25 +10,100 @@
 #ifndef _LINUX_NOTIFIER_H
 #define _LINUX_NOTIFIER_H
 #include <linux/errno.h>
+#include <asm/semaphore.h>
+#include <linux/rwsem.h>
 
-struct notifier_block
-{
-	int (*notifier_call)(struct notifier_block *self, unsigned long, void *);
+/*
+ * Notifier chains are of three types:
+ *
+ *	Atomic notifier chains: Chain callbacks run in interrupt/atomic
+ *		context. Callouts are not allowed to block.
+ *	Blocking notifier chains: Chain callbacks run in process context.
+ *		Callouts are allowed to block.
+ *	Raw notifier chains: There are no restrictions on callbacks,
+ *		registration, or unregistration.  All locking and protection
+ *		must be provided by the caller.
+ *
+ * atomic_notifier_chain_register() and blocking_notifier_chain_register()
+ * may be called only from process context, and likewise for the
+ * corresponding _unregister() routines.
+ *
+ * atomic_notifier_chain_unregister() and blocking_notifier_chain_unregister()
+ * _must not_ be called from within the call chain.
+ */
+
+struct notifier_block {
+	int (*notifier_call)(struct notifier_block *, unsigned long, void *);
 	struct notifier_block *next;
 	int priority;
 };
 
+struct atomic_notifier_head {
+	struct semaphore sem;
+	struct notifier_block *head;
+};
+
+struct blocking_notifier_head {
+	struct rw_semaphore rwsem;
+	struct notifier_block *head;
+};
+
+struct raw_notifier_head {
+	struct notifier_block *head;
+};
+
+#define ATOMIC_INIT_NOTIFIER_HEAD(name) do {	\
+		init_MUTEX(&(name)->rwsem);	\
+		(name)->head = NULL;		\
+	} while (0)
+#define BLOCKING_INIT_NOTIFIER_HEAD(name) do {	\
+		init_rwsem(&(name)->rwsem);	\
+		(name)->head = NULL;		\
+	} while (0)
+#define RAW_INIT_NOTIFIER_HEAD(name) do {	\
+		(name)->head = NULL;		\
+	} while (0)
+
+#define ATOMIC_NOTIFIER_HEAD(name)				\
+	struct atomic_notifier_head name = {			\
+		.sem = __SEMAPHORE_INITIALIZER((name).sem, 1),	\
+		.head = NULL }
+#define BLOCKING_NOTIFIER_HEAD(name)				\
+	struct blocking_notifier_head name = {			\
+		.rwsem = __RWSEM_INITIALIZER((name).rwsem),	\
+		.head = NULL }
+#define RAW_NOTIFIER_HEAD(name)					\
+	struct raw_notifier_head name = {			\
+	.head = NULL }
 
 #ifdef __KERNEL__
 
-extern int notifier_chain_register(struct notifier_block **list, struct notifier_block *n);
-extern int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n);
-extern int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v);
+extern int atomic_notifier_chain_register(struct atomic_notifier_head *,
+		struct notifier_block *);
+extern int blocking_notifier_chain_register(struct blocking_notifier_head *,
+		struct notifier_block *);
+extern int raw_notifier_chain_register(struct raw_notifier_head *,
+		struct notifier_block *);
+
+extern int atomic_notifier_chain_unregister(struct atomic_notifier_head *,
+		struct notifier_block *);
+extern int blocking_notifier_chain_unregister(struct blocking_notifier_head *,
+		struct notifier_block *);
+extern int raw_notifier_chain_unregister(struct raw_notifier_head *,
+		struct notifier_block *);
+
+extern int atomic_notifier_call_chain(struct atomic_notifier_head *,
+		unsigned long val, void *v);
+extern int blocking_notifier_call_chain(struct blocking_notifier_head *,
+		unsigned long val, void *v);
+extern int raw_notifier_call_chain(struct raw_notifier_head *,
+		unsigned long val, void *v);
 
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
 #define NOTIFY_STOP_MASK	0x8000		/* Don't call further */
-#define NOTIFY_BAD		(NOTIFY_STOP_MASK|0x0002)	/* Bad/Veto action	*/
+#define NOTIFY_BAD		(NOTIFY_STOP_MASK|0x0002)
+						/* Bad/Veto action */
 /*
  * Clean way to return from the notifier and stop further calls.
  */
Index: usb-2.6/kernel/sys.c
===================================================================
--- usb-2.6.orig/kernel/sys.c
+++ usb-2.6/kernel/sys.c
@@ -94,67 +94,192 @@ int cad_pid = 1;
  */
 
 static struct notifier_block *reboot_notifier_list;
-static DEFINE_RWLOCK(notifier_lock);
+
+/*
+ *	Notifier chain core routines.  The exported routines below
+ *	are layered on top of these, with appropriate locking added.
+ */ 
+
+static int notifier_chain_register(struct notifier_block **nl,
+		struct notifier_block *n)
+{
+	while ((*nl) != NULL) {
+		if (n->priority > (*nl)->priority)
+			break;
+		nl = &((*nl)->next);
+	}
+	n->next = *nl;
+	rcu_assign_pointer(*nl, n);
+	return 0;
+}
+
+static int notifier_chain_unregister(struct notifier_block **nl,
+		struct notifier_block *n)
+{
+	while ((*nl) != NULL) {
+		if ((*nl) == n) {
+			rcu_assign_pointer(*nl, n->next);
+			return 0;
+		}
+		nl = &((*nl)->next);
+	}
+	return -ENOENT;
+}
+ 
+static int notifier_call_chain(struct notifier_block **nl,
+		unsigned long val, void *v)
+{
+	int ret = NOTIFY_DONE;
+	struct notifier_block *nb;
+
+	nb = rcu_dereference(*nl);
+	while (nb) {
+		ret = nb->notifier_call(nb, val, v);
+		if ((ret & NOTIFY_STOP_MASK) == NOTIFY_STOP_MASK)
+			break;
+		nb = rcu_dereference(nb->next);
+	}
+	return ret;
+}
+
+/*
+ *	Atomic notifier chain routines.  Registration and unregistration
+ *	use a mutex, and call_chain is synchronized by RCU (no locks).
+ */ 
 
 /**
- *	notifier_chain_register	- Add notifier to a notifier chain
- *	@list: Pointer to root list pointer
+ *	atomic_notifier_chain_register - Add notifier to an atomic notifier chain
+ *	@nh: Pointer to head of the atomic notifier chain
  *	@n: New entry in notifier chain
  *
- *	Adds a notifier to a notifier chain.
+ *	Adds a notifier to an atomic notifier chain.
+ *	Must be called in process context.
  *
  *	Currently always returns zero.
  */
+
+int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
+		struct notifier_block *n)
+{
+	int ret;
+
+	down(&nh->sem);
+	ret = notifier_chain_register(&nh->head, n);
+	up(&nh->sem);
+	return ret;
+}
+
+EXPORT_SYMBOL(atomic_notifier_chain_register);
+
+/**
+ *	atomic_notifier_chain_unregister - Remove notifier from an atomic notifier chain
+ *	@nh: Pointer to head of the atomic notifier chain
+ *	@n: Entry to remove from notifier chain
+ *
+ *	Removes a notifier from an atomic notifier chain.
+ *	Must be called from process context.
+ *
+ *	Returns zero on success, or %-ENOENT on failure.
+ */
+int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
+		struct notifier_block *n)
+{
+	int ret;
+
+	down(&nh->sem);
+	ret = notifier_chain_unregister(&nh->head, n);
+	up(&nh->sem);
+	synchronize_rcu();
+	return ret;
+}
+
+EXPORT_SYMBOL(atomic_notifier_chain_unregister);
+
+/**
+ *	atomic_notifier_call_chain - Call functions in an atomic notifier chain
+ *	@nh: Pointer to head of the atomic notifier chain
+ *	@val: Value passed unmodified to notifier function
+ *	@v: Pointer passed unmodified to notifier function
+ *
+ *	Calls each function in a notifier chain in turn.
+ *	This routine uses RCU to synchronize with changes in the chain.
+ *
+ *	If the return value of the notifier can be and'd
+ *	with %NOTIFY_STOP_MASK, then notifier_call_chain
+ *	will return immediately, with the return value of
+ *	the notifier function which halted execution.
+ *	Otherwise, the return value is the return value
+ *	of the last notifier function called.
+ */
  
-int notifier_chain_register(struct notifier_block **list, struct notifier_block *n)
+int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
+		unsigned long val, void *v)
 {
-	write_lock(&notifier_lock);
-	while(*list)
-	{
-		if(n->priority > (*list)->priority)
-			break;
-		list= &((*list)->next);
-	}
-	n->next = *list;
-	*list=n;
-	write_unlock(&notifier_lock);
-	return 0;
+	int ret;
+
+	rcu_read_lock();
+	ret = notifier_call_chain(&nh->head, val, v);
+	rcu_read_unlock();
+	return ret;
 }
 
-EXPORT_SYMBOL(notifier_chain_register);
+EXPORT_SYMBOL(atomic_notifier_call_chain);
+
+/*
+ *	Blocking notifier chain routines.  All access to the chain is
+ *	synchronized by an rwsem.
+ */ 
 
 /**
- *	notifier_chain_unregister - Remove notifier from a notifier chain
- *	@nl: Pointer to root list pointer
+ *	blocking_notifier_chain_register - Add notifier to a blocking notifier chain
+ *	@nh: Pointer to head of the blocking notifier chain
  *	@n: New entry in notifier chain
  *
- *	Removes a notifier from a notifier chain.
+ *	Adds a notifier to a blocking notifier chain.
+ *	Must be called in process context.
  *
- *	Returns zero on success, or %-ENOENT on failure.
+ *	Currently always returns zero.
  */
  
-int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n)
+int blocking_notifier_chain_register(struct blocking_notifier_head *nh,
+		struct notifier_block *n)
 {
-	write_lock(&notifier_lock);
-	while((*nl)!=NULL)
-	{
-		if((*nl)==n)
-		{
-			*nl=n->next;
-			write_unlock(&notifier_lock);
-			return 0;
-		}
-		nl=&((*nl)->next);
-	}
-	write_unlock(&notifier_lock);
-	return -ENOENT;
+	int ret;
+
+	down_write(&nh->rwsem);
+	ret = notifier_chain_register(&nh->head, n);
+	up_write(&nh->rwsem);
+	return ret;
+}
+
+EXPORT_SYMBOL(blocking_notifier_chain_register);
+
+/**
+ *	blocking_notifier_chain_unregister - Remove notifier from a blocking notifier chain
+ *	@nh: Pointer to head of the blocking notifier chain
+ *	@n: Entry to remove from notifier chain
+ *
+ *	Removes a notifier from a blocking notifier chain.
+ *	Must be called from process context.
+ *
+ *	Returns zero on success, or %-ENOENT on failure.
+ */
+int blocking_notifier_chain_unregister(struct blocking_notifier_head *nh,
+		struct notifier_block *n)
+{
+	int ret;
+
+	down_write(&nh->rwsem);
+	ret = notifier_chain_unregister(&nh->head, n);
+	up_write(&nh->rwsem);
+	return ret;
 }
 
-EXPORT_SYMBOL(notifier_chain_unregister);
+EXPORT_SYMBOL(blocking_notifier_chain_unregister);
 
 /**
- *	notifier_call_chain - Call functions in a notifier chain
- *	@n: Pointer to root pointer of notifier chain
+ *	blocking_notifier_call_chain - Call functions in a blocking notifier chain
+ *	@nh: Pointer to head of the blocking notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
  *
@@ -168,24 +293,85 @@ EXPORT_SYMBOL(notifier_chain_unregister)
  *	of the last notifier function called.
  */
  
-int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
+int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
+		unsigned long val, void *v)
 {
-	int ret=NOTIFY_DONE;
-	struct notifier_block *nb = *n;
+	int ret;
 
-	while(nb)
-	{
-		ret=nb->notifier_call(nb,val,v);
-		if(ret&NOTIFY_STOP_MASK)
-		{
-			return ret;
-		}
-		nb=nb->next;
-	}
+	down_read(&nh->rwsem);
+	ret = notifier_call_chain(&nh->head, val, v);
+	up_read(&nh->rwsem);
 	return ret;
 }
 
-EXPORT_SYMBOL(notifier_call_chain);
+EXPORT_SYMBOL(blocking_notifier_call_chain);
+
+/*
+ *	Raw notifier chain routines.  There is no protection;
+ *	the caller must provide it.  Use at your own risk!
+ */ 
+
+/**
+ *	raw_notifier_chain_register - Add notifier to a raw notifier chain
+ *	@nh: Pointer to head of the raw notifier chain
+ *	@n: New entry in notifier chain
+ *
+ *	Adds a notifier to a raw notifier chain.
+ *	All locking must be provided by the caller.
+ *
+ *	Currently always returns zero.
+ */
+
+int raw_notifier_chain_register(struct raw_notifier_head *nh,
+		struct notifier_block *n)
+{
+	return notifier_chain_register(&nh->head);
+}
+
+EXPORT_SYMBOL(raw_notifier_chain_register);
+
+/**
+ *	raw_notifier_chain_unregister - Remove notifier from a raw notifier chain
+ *	@nh: Pointer to head of the raw notifier chain
+ *	@n: Entry to remove from notifier chain
+ *
+ *	Removes a notifier from a raw notifier chain.
+ *	All locking must be provided by the caller.
+ *
+ *	Returns zero on success, or %-ENOENT on failure.
+ */
+int raw_notifier_chain_unregister(struct raw_notifier_head *nh,
+		struct notifier_block *n)
+{
+	return notifier_chain_unregister(&nh->head, n);
+}
+
+EXPORT_SYMBOL(raw_notifier_chain_unregister);
+
+/**
+ *	raw_notifier_call_chain - Call functions in a raw notifier chain
+ *	@nh: Pointer to head of the raw notifier chain
+ *	@val: Value passed unmodified to notifier function
+ *	@v: Pointer passed unmodified to notifier function
+ *
+ *	Calls each function in a notifier chain in turn.
+ *	All locking must be provided by the caller.
+ *
+ *	If the return value of the notifier can be and'd
+ *	with %NOTIFY_STOP_MASK, then notifier_call_chain
+ *	will return immediately, with the return value of
+ *	the notifier function which halted execution.
+ *	Otherwise, the return value is the return value
+ *	of the last notifier function called.
+ */
+ 
+int raw_notifier_call_chain(struct raw_notifier_head *nh,
+		unsigned long val, void *v)
+{
+	return notifier_call_chain(&nh->head, val, v);
+}
+
+EXPORT_SYMBOL(raw_notifier_call_chain);
 
 /**
  *	register_reboot_notifier - Register function to be called at reboot time

