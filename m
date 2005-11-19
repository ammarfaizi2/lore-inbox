Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161215AbVKSCTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161215AbVKSCTr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161211AbVKSCTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:19:47 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:43490 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161215AbVKSCTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:19:45 -0500
Subject: [RFC][PATCH 1/7]: Interface change to the notifier chain mechanism
	- basic fix
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, Alan Stern <stern@rowland.harvard.edu>,
       paulmck@us.ibm.com, kaos@sgi.com
Content-Type: text/plain
Organization: IBM
Date: Fri, 18 Nov 2005 18:19:43 -0800
Message-Id: <1132366783.9617.13.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has the core interface change and the fix for the original problem.
It is same as what I posted last Friday, plus the changes suggested by
Paul McKenney.

Signed-off-by:  Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by:  Alan Stern <stern@rowland.harvard.edu>
-----

 include/linux/notifier.h |   69 ++++++++++++++++++++++++++++++++--
 kernel/sys.c             |   93 ++++++++++++++++++++++++++++-------------------
 2 files changed, 121 insertions(+), 41 deletions(-)

Index: l2615-rc1-notifiers/include/linux/notifier.h
===================================================================
--- l2615-rc1-notifiers.orig/include/linux/notifier.h
+++ l2615-rc1-notifiers/include/linux/notifier.h
@@ -10,25 +10,84 @@
 #ifndef _LINUX_NOTIFIER_H
 #define _LINUX_NOTIFIER_H
 #include <linux/errno.h>
+#include <linux/rwsem.h>
+
+/*
+ * Notifier chains are of two types:
+ *	Atomic notifier chains: Chain callbacks run in interrupt/atomic
+ *		context. Callouts are not allowed to block.
+ *	Blocking notifier chains: Chain callback run in process context.
+ *		Callouts are allowed to block.
+ *
+ * Type of a chain is defined in its head.
+ *
+ * notifier_chain_register() and notifier_chain_unregister() should be
+ * called only from process context.
+ *
+ * notifier_chain_unregister() _should not_ be called from the
+ * corresponding call chain.
+ *
+ */
+enum notifier_type {
+	ATOMIC_NOTIFIER,
+	BLOCKING_NOTIFIER,
+};
 
 struct notifier_block
 {
-	int (*notifier_call)(struct notifier_block *self, unsigned long, void *);
+	int (*notifier_call)(struct notifier_block *, unsigned long, void *);
 	struct notifier_block *next;
 	int priority;
 };
 
+struct notifier_head {
+	enum notifier_type type;
+	struct rw_semaphore rwsem;
+	struct notifier_block *head;
+};
+
+#define NOTIFIER_HEAD_INIT(name, head_type) {		\
+	.type = head_type,				\
+	.rwsem = __RWSEM_INITIALIZER((name).rwsem),	\
+	.head = NULL }
+
+#define NOTIFIER_HEAD(name, head_type) \
+	struct notifier_head name = NOTIFIER_HEAD_INIT(name, head_type)
+
+#define INIT_NOTIFIER_HEAD(name, head_type) do {		\
+	(name)->type = head_type;			\
+	init_rwsem(&(name)->rwsem);			\
+	(name)->head = NULL;				\
+} while (0)
+
+#define ATOMIC_NOTIFIER_HEAD_INIT(name) \
+		NOTIFIER_HEAD_INIT(name, ATOMIC_NOTIFIER)
+#define ATOMIC_NOTIFIER_HEAD(name) \
+		NOTIFIER_HEAD(name, ATOMIC_NOTIFIER)
+#define ATOMIC_INIT_NOTIFIER_HEAD(name) \
+		INIT_NOTIFIER_HEAD(name, ATOMIC_NOTIFIER)
+
+#define BLOCKING_NOTIFIER_HEAD_INIT(name) \
+		NOTIFIER_HEAD_INIT(name, BLOCKING_NOTIFIER)
+#define BLOCKING_NOTIFIER_HEAD(name) \
+		NOTIFIER_HEAD(name, BLOCKING_NOTIFIER)
+#define BLOCKING_INIT_NOTIFIER_HEAD(name) \
+		INIT_NOTIFIER_HEAD(name, BLOCKING_NOTIFIER)
 
 #ifdef __KERNEL__
 
-extern int notifier_chain_register(struct notifier_block **list, struct notifier_block *n);
-extern int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n);
-extern int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v);
+extern int notifier_chain_register(struct notifier_head *,
+					struct notifier_block *);
+extern int notifier_chain_unregister(struct notifier_head *,
+					struct notifier_block *);
+extern int notifier_call_chain(struct notifier_head *,
+					unsigned long val, void *v);
 
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
 #define NOTIFY_STOP_MASK	0x8000		/* Don't call further */
-#define NOTIFY_BAD		(NOTIFY_STOP_MASK|0x0002)	/* Bad/Veto action	*/
+#define NOTIFY_BAD		(NOTIFY_STOP_MASK|0x0002)
+						/* Bad/Veto action */
 /*
  * Clean way to return from the notifier and stop further calls.
  */
Index: l2615-rc1-notifiers/kernel/sys.c
===================================================================
--- l2615-rc1-notifiers.orig/kernel/sys.c
+++ l2615-rc1-notifiers/kernel/sys.c
@@ -94,30 +94,32 @@ int cad_pid = 1;
  */
 
 static struct notifier_block *reboot_notifier_list;
-static DEFINE_RWLOCK(notifier_lock);
 
 /**
  *	notifier_chain_register	- Add notifier to a notifier chain
- *	@list: Pointer to root list pointer
+ *	@nh: Pointer to head of the notifier chain
  *	@n: New entry in notifier chain
  *
  *	Adds a notifier to a notifier chain.
+ *	Must be called from process context.
  *
  *	Currently always returns zero.
  */
  
-int notifier_chain_register(struct notifier_block **list, struct notifier_block *n)
+int notifier_chain_register(struct notifier_head *nh, struct notifier_block *n)
 {
-	write_lock(&notifier_lock);
-	while(*list)
-	{
-		if(n->priority > (*list)->priority)
+	struct notifier_block **nl;
+
+	down_write(&nh->rwsem);
+	nl = &nh->head;
+	while ((*nl) != NULL) {
+		if (n->priority > (*nl)->priority)
 			break;
-		list= &((*list)->next);
+		nl = &((*nl)->next);
 	}
-	n->next = *list;
-	*list=n;
-	write_unlock(&notifier_lock);
+	n->next = *nl;
+	rcu_assign_pointer(*nl, n);
+	up_write(&nh->rwsem);
 	return 0;
 }
 
@@ -125,28 +127,32 @@ EXPORT_SYMBOL(notifier_chain_register);
 
 /**
  *	notifier_chain_unregister - Remove notifier from a notifier chain
- *	@nl: Pointer to root list pointer
+ *	@nh: Pointer to head of the notifier chain
  *	@n: New entry in notifier chain
  *
  *	Removes a notifier from a notifier chain.
+ *	Must be called from process context.
  *
  *	Returns zero on success, or %-ENOENT on failure.
  */
- 
-int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n)
+int notifier_chain_unregister(struct notifier_head *nh,
+					struct notifier_block *n)
 {
-	write_lock(&notifier_lock);
-	while((*nl)!=NULL)
-	{
-		if((*nl)==n)
-		{
-			*nl=n->next;
-			write_unlock(&notifier_lock);
+	struct notifier_block **nl;
+
+	down_write(&nh->rwsem);
+	nl = &nh->head;
+	while ((*nl) != NULL) {
+		if ((*nl) == n) {
+			rcu_assign_pointer(*nl, n->next);
+			up_write(&nh->rwsem);
+			if (nh->type == ATOMIC_NOTIFIER)
+				synchronize_rcu();
 			return 0;
 		}
-		nl=&((*nl)->next);
+		nl = &((*nl)->next);
 	}
-	write_unlock(&notifier_lock);
+	up_write(&nh->rwsem);
 	return -ENOENT;
 }
 
@@ -154,12 +160,18 @@ EXPORT_SYMBOL(notifier_chain_unregister)
 
 /**
  *	notifier_call_chain - Call functions in a notifier chain
- *	@n: Pointer to root pointer of notifier chain
+ *	@nh: Pointer to the head of notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
  *
  *	Calls each function in a notifier chain in turn.
  *
+ *	If @nh points to an %ATOMIC_NOTIFIER_HEAD then this routine may
+ *	be called in any context, as it will not sleep.
+ *
+ *	If @nh points to a %BLOCKING_NOTIFIER_HEAD then this routine may
+ *	be called only in process context.
+ *
  *	If the return value of the notifier can be and'd
  *	with %NOTIFY_STOP_MASK, then notifier_call_chain
  *	will return immediately, with the return value of
@@ -168,20 +180,29 @@ EXPORT_SYMBOL(notifier_chain_unregister)
  *	of the last notifier function called.
  */
  
-int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
+int notifier_call_chain(struct notifier_head *nh, unsigned long val, void *v)
 {
-	int ret=NOTIFY_DONE;
-	struct notifier_block *nb = *n;
+	int ret = NOTIFY_DONE;
+	struct notifier_block *nb;
 
-	while(nb)
-	{
-		ret=nb->notifier_call(nb,val,v);
-		if(ret&NOTIFY_STOP_MASK)
-		{
-			return ret;
-		}
-		nb=nb->next;
-	}
+	if (!nh->head)
+		return ret;
+	if (nh->type == ATOMIC_NOTIFIER)
+		rcu_read_lock();
+	else
+		down_read(&nh->rwsem);
+	nb = rcu_dereference(nh->head);
+	while (nb) {
+		ret = nb->notifier_call(nb, val, v);
+		if ((ret & NOTIFY_STOP_MASK) == NOTIFY_STOP_MASK)
+			goto done;
+		nb = rcu_dereference(nb->next);
+	}
+done:
+	if (nh->type == ATOMIC_NOTIFIER)
+		rcu_read_unlock();
+	else
+		up_read(&nh->rwsem);
 	return ret;
 }
 

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


