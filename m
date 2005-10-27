Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVJ0P21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVJ0P21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVJ0P21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:28:27 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:18900 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751084AbVJ0P20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:28:26 -0400
Date: Thu, 27 Oct 2005 11:28:23 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Chandra Seetharaman <sekharan@us.ibm.com>
cc: Keith Owens <kaos@ocs.com.au>, Andi Kleen <ak@suse.de>,
       <dipankar@in.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Notifier chains are unsafe
In-Reply-To: <1130366433.3586.197.camel@linuxchandra>
Message-ID: <Pine.LNX.4.44L0.0510271018300.4891-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005, Chandra Seetharaman wrote:

> > It seems pretty clear that a separate notifier_head would be a good thing 
> > to have, no matter what other changes are made.
> 
> Totally agree.

> > It sounds like there really are two different types of notifier chains:
> > 
> >     (1) Chains that always run in process context, where the routines
> > 	are allowed to sleep.
> > 
> >     (2) Chains that run in an atomic context, where the routines are
> > 	not allowed to sleep.
> 
> IMO having two notifiers which differs only in the way mentioned above
> would be confusing. Also, going through all the existing usages and
> changing it to proper one could be little painful. 
   
It would be less confusing than the state we're in now!  The difference
between the two types of notifiers would be very analogous to the
difference between semaphores and spinlocks, which IMO isn't confusing at 
all.

I agree that updating all the existing definitions would be a little
painful.  However, adding a new notifier_head will require doing those 
updates anyway.

> > Presumably only type 2 chains must not take any locks (although perhaps 
> > you wouldn't object to them using a readlock?).  Evidently there's nothing
> > wrong with a type 1 chain taking a lock.
> 
> Not true, the registered function could block. So, we cannot protect the
> list in notifier_call_chain() using a lock that surrounds notifier_call.

Sorry, I meant to say there's nothing wrong with a type 1 chain taking a 
semaphore.


What do you think of the untested patch below?

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Index: usb-2.6/kernel/sys.c
===================================================================
--- usb-2.6.orig/kernel/sys.c
+++ usb-2.6/kernel/sys.c
@@ -92,31 +92,41 @@ int cad_pid = 1;
  *	and the like. 
  */
 
-static struct notifier_block *reboot_notifier_list;
-static DEFINE_RWLOCK(notifier_lock);
+static DEFINE_BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
 
 /**
  *	notifier_chain_register	- Add notifier to a notifier chain
- *	@list: Pointer to root list pointer
- *	@n: New entry in notifier chain
+ *	@nh: Pointer to head of the notifier chain
+ *	@n: New entry to add to notifier chain
  *
  *	Adds a notifier to a notifier chain.
  *
+ *	Context: Must be able to sleep.
+ *
  *	Currently always returns zero.
  */
  
-int notifier_chain_register(struct notifier_block **list, struct notifier_block *n)
+int notifier_chain_register(struct notifier_head *nh,
+		struct notifier_block *n)
 {
-	write_lock(&notifier_lock);
-	while(*list)
-	{
-		if(n->priority > (*list)->priority)
-			break;
-		list= &((*list)->next);
+	struct list_head *pos;
+	struct notifier_block *b;
+
+	down_write(&nh->rwsem);
+	if (nh->type == ATOMIC_NOTIFIER)
+		rcu_read_lock();
+	list_for_each_rcu(pos, &nh->chain) {
+		b = list_entry(pos, struct notifier_block, node);
+		if (n->priority > b->priority)
+			break;
+	}
+	list_add_tail_rcu(&n->node, pos);
+	up_write(&nh->rwsem);
+
+	if (nh->type == ATOMIC_NOTIFIER) {
+		rcu_read_unlock();
+		synchronize_rcu();
 	}
-	n->next = *list;
-	*list=n;
-	write_unlock(&notifier_lock);
 	return 0;
 }
 
@@ -124,36 +134,34 @@ EXPORT_SYMBOL(notifier_chain_register);
 
 /**
  *	notifier_chain_unregister - Remove notifier from a notifier chain
- *	@nl: Pointer to root list pointer
- *	@n: New entry in notifier chain
++ *	@nh: Pointer to head of the notifier chain
++ *	@n: Entry to remove from the chain
  *
- *	Removes a notifier from a notifier chain.
+ *	Removes a notifier from a notifier chain.  The notifier must
+ *	previously have been added to the chain.
  *
- *	Returns zero on success, or %-ENOENT on failure.
+ *	Context: Must be able to sleep.
+ *
+ *	Currently always returns zero.
  */
  
-int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n)
+int notifier_chain_unregister(struct notifier_head *nh,
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
+	down_write(&nh->rwsem);
+	list_del_rcu(&n->node);
+	up_write(&nh->rwsem);
+
+	if (nh->type == ATOMIC_NOTIFIER)
+		synchronize_rcu();
+	return 0;
 }
 
 EXPORT_SYMBOL(notifier_chain_unregister);
 
 /**
  *	notifier_call_chain - Call functions in a notifier chain
- *	@n: Pointer to root pointer of notifier chain
++ *	@nh: Pointer to head of the notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
  *
@@ -167,20 +175,32 @@ EXPORT_SYMBOL(notifier_chain_unregister)
  *	of the last notifier function called.
  */
  
-int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
+int notifier_call_chain(struct notifier_head *nh, unsigned long val, void *v)
 {
-	int ret=NOTIFY_DONE;
-	struct notifier_block *nb = *n;
+	int ret = NOTIFY_DONE;
+	struct list_head *pos;
+	struct notifier_block *b;
 
-	while(nb)
-	{
-		ret=nb->notifier_call(nb,val,v);
-		if(ret&NOTIFY_STOP_MASK)
-		{
-			return ret;
-		}
-		nb=nb->next;
+	if (list_empty(&nh->chain))	/* Optimize for common case */
+		return ret;
+
+	if (nh->type == ATOMIC_NOTIFIER)
+		rcu_read_lock();
+	else		/* BLOCKING_NOTIFIER */
+		down_read(&nh->rwsem);
+
+	list_for_each_rcu(pos, &nh->chain) {
+		b = list_entry(pos, struct notifier_block, node);
+		ret = b->notifier_call(b, val, v);
+		if (ret & NOTIFY_STOP_MASK)
+			break;
 	}
+
+	if (nh->type == ATOMIC_NOTIFIER)
+		rcu_read_unlock();
+	else		/* BLOCKING_NOTIFIER */
+		up_read(&nh->rwsem);
+
 	return ret;
 }
 
Index: usb-2.6/include/linux/notifier.h
===================================================================
--- usb-2.6.orig/include/linux/notifier.h
+++ usb-2.6/include/linux/notifier.h
@@ -10,25 +10,74 @@
 #ifndef _LINUX_NOTIFIER_H
 #define _LINUX_NOTIFIER_H
 #include <linux/errno.h>
+#include <linux/rwsem.h>
+#include <linux/list.h>
+
+/*
+ *	There are two types of notifier chains:
+ *
+ *		Atomic notifier chains, which may run in an atomic context
+ *		and whose entries are not allowed to block, and
+ *
+ *		Blocking notifier chains, which always run in process
+ *		context and whose entries are allowed to block.
+ *
+ *	The type of a chain is determined by the definition of its head.
+ *	Atomic notifier chains use RCU for registration/unregistration,
+ *	so they can run with no locking overhead.
+ */
+
+enum notifier_type {
+	ATOMIC_NOTIFIER,
+	BLOCKING_NOTIFIER,
+};
+
+struct notifier_head {
+	enum notifier_type type;
+	struct rw_semaphore rwsem;
+	struct list_head chain;
+};
+
+#define ATOMIC_NOTIFIER_HEAD_INIT(name) {			\
+		.type = ATOMIC_NOTIFIER,			\
+		.rwsem = __RWSEM_INITIALIZER((name).rwsem),	\
+		.chain = LIST_HEAD_INIT((name).chain) }
+
+#define BLOCKING_NOTIFIER_HEAD_INIT(name) {			\
+		.type = BLOCKING_NOTIFIER,			\
+		.rwsem = __RWSEM_INITIALIZER((name).rwsem),	\
+		.chain = LIST_HEAD_INIT((name).chain) }
+
+#define DEFINE_ATOMIC_NOTIFIER_HEAD(name) 	\
+		struct notifier_head name = ATOMIC_NOTIFIER_HEAD_INIT(name)
+
+#define DEFINE_BLOCKING_NOTIFIER_HEAD(name) 	\
+		struct notifier_head name = BLOCKING_NOTIFIER_HEAD_INIT(name)
+
 
 struct notifier_block
 {
-	int (*notifier_call)(struct notifier_block *self, unsigned long, void *);
-	struct notifier_block *next;
+	int (*notifier_call)(struct notifier_block *self, unsigned long,
+			void *);
+	struct list_head node;
 	int priority;
 };
 
 
 #ifdef __KERNEL__
 
-extern int notifier_chain_register(struct notifier_block **list, struct notifier_block *n);
-extern int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n);
-extern int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v);
+extern int notifier_chain_register(struct notifier_head *nh,
+		struct notifier_block *n);
+extern int notifier_chain_unregister(struct notifier_head *nh,
+		struct notifier_block *n);
+extern int notifier_call_chain(struct notifier_head *nh,
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

