Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVJXUtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVJXUtE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 16:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVJXUtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 16:49:04 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41676 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751285AbVJXUtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 16:49:01 -0400
Date: Mon, 24 Oct 2005 16:48:58 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Notifier chains are unsafe
Message-ID: <Pine.LNX.4.44L0.0510241634410.4448-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone been bothered by the fact that notifier chains are not safe 
with regard to registration and unregistration while the chain is in use?
The notifier_chain_register and notifier_chain_unregister routines have 
writelock protections, but the corresponding readlock is never taken!

It shouldn't be hard to make this work safely, even allowing such things
as notifier routines unregistering themselves as they run.  The patch
below contains an example implementation, showing one way to do it.

But doing this correctly requires knowing how notifier chains are used.  

	Are they always called in process context, with interrupts enabled?

	Or do some get called in interrupt context?

	Are there any notifier chains invoked on a critical fast path?
	(I hope not...)

	How many different threads are likely to call a particular 
	notifier chain at one time?

Feedback is requested.

Alan Stern



Index: usb-2.6/kernel/sys.c
===================================================================
--- usb-2.6.orig/kernel/sys.c
+++ usb-2.6/kernel/sys.c
@@ -92,31 +92,45 @@ int cad_pid = 1;
  *	and the like. 
  */
 
-static struct notifier_block *reboot_notifier_list;
-static DEFINE_RWLOCK(notifier_lock);
+static DEFINE_NOTIFIER_HEAD(reboot_notifier_list);
+
+struct notifier_caller {
+	struct notifier_block *next;
+	struct list_head node;
+};
 
 /**
  *	notifier_chain_register	- Add notifier to a notifier chain
- *	@list: Pointer to root list pointer
+ *	@nh: Pointer to head of the notifier chain
  *	@n: New entry in notifier chain
  *
  *	Adds a notifier to a notifier chain.
  *
  *	Currently always returns zero.
  */
- 
-int notifier_chain_register(struct notifier_block **list, struct notifier_block *n)
+
+int notifier_chain_register(struct notifier_head *nh,
+		struct notifier_block *n)
 {
-	write_lock(&notifier_lock);
-	while(*list)
-	{
-		if(n->priority > (*list)->priority)
+	struct notifier_block **p, *nnext;
+	struct list_head *pos;
+	struct notifier_caller *caller;
+
+	spin_lock(&nh->lock);
+	for (p = &nh->first; *p; p = &((*p)->next)) {
+		if (n->priority > (*p)->priority)
 			break;
-		list= &((*list)->next);
 	}
-	n->next = *list;
-	*list=n;
-	write_unlock(&notifier_lock);
+	n->next = nnext = *p;
+	*p = n;
+
+	list_for_each(pos, &nh->callers) {
+		caller = list_entry(pos, struct notifier_caller, node);
+		if (caller->next == nnext)
+			caller->next = n;
+	}
+
+	spin_unlock(&nh->lock);
 	return 0;
 }
 
@@ -124,36 +138,49 @@ EXPORT_SYMBOL(notifier_chain_register);
 
 /**
  *	notifier_chain_unregister - Remove notifier from a notifier chain
- *	@nl: Pointer to root list pointer
- *	@n: New entry in notifier chain
+ *	@nh: Pointer to head of the notifier chain
+ *	@n: Entry to remove from the chain
  *
  *	Removes a notifier from a notifier chain.
  *
  *	Returns zero on success, or %-ENOENT on failure.
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
+	int ret = 0;
+	struct notifier_block **p;
+	struct list_head *pos;
+	struct notifier_caller *caller;
+
+	spin_lock(&nh->lock);
+	for (p = &nh->first; *p; p = &((*p)->next)) {
+		if (*p == n)
+			break;
+	}
+	if (!*p) {
+		ret = -ENOENT;
+		goto done;
+	}
+	*p = n->next;
+
+	list_for_each(pos, &nh->callers) {
+		caller = list_entry(pos, struct notifier_caller, node);
+		if (caller->next == n)
+			caller->next = n->next;
 	}
-	write_unlock(&notifier_lock);
-	return -ENOENT;
+
+done:
+	spin_unlock(&nh->lock);
+	return ret;
 }
 
 EXPORT_SYMBOL(notifier_chain_unregister);
 
 /**
  *	notifier_call_chain - Call functions in a notifier chain
- *	@n: Pointer to root pointer of notifier chain
+ *	@nh: Pointer to head of the notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
  *
@@ -167,20 +194,28 @@ EXPORT_SYMBOL(notifier_chain_unregister)
  *	of the last notifier function called.
  */
  
-int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
+int notifier_call_chain(struct notifier_head *nh, unsigned long val, void *v)
 {
-	int ret=NOTIFY_DONE;
-	struct notifier_block *nb = *n;
+	int ret = NOTIFY_DONE;
+	struct notifier_caller caller;
+	struct notifier_block *n;
 
-	while(nb)
-	{
-		ret=nb->notifier_call(nb,val,v);
-		if(ret&NOTIFY_STOP_MASK)
-		{
-			return ret;
-		}
-		nb=nb->next;
+	spin_lock(&nh->lock);
+	caller.next = nh->first;
+	list_add(&caller.node, &nh->callers);
+
+	while (caller.next) {
+		n = caller.next;
+		caller.next = n->next;
+		spin_unlock(&nh->lock);
+		ret = n->notifier_call(n, val, v);
+		spin_lock(&nh->lock);
+		if (ret & NOTIFY_STOP_MASK)
+			break;
 	}
+
+	list_del(&caller.node);
+	spin_unlock(&nh->lock);
 	return ret;
 }
 
Index: usb-2.6/include/linux/notifier.h
===================================================================
--- usb-2.6.orig/include/linux/notifier.h
+++ usb-2.6/include/linux/notifier.h
@@ -6,10 +6,20 @@
  *
  *				Alan Cox <Alan.Cox@linux.org>
  */
- 
+
+/*
+ *	This implementation allows entries to be safely added to or removed
+ *	from a notifier chain at any time (in a context that can sleep),
+ *	including while they are running or another process is calling
+ *	along the chain.  The main assumption is that the number of
+ *	simultaneous calls for a chain will be fairly small.
+ */
+
 #ifndef _LINUX_NOTIFIER_H
 #define _LINUX_NOTIFIER_H
 #include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
 
 struct notifier_block
 {
@@ -18,12 +28,27 @@ struct notifier_block
 	int priority;
 };
 
+struct notifier_head {
+	spinlock_t lock;
+	struct notifier_block *first;
+	struct list_head callers;
+};
+
+#define NOTIFIER_HEAD_INIT(name) { .lock = SPIN_LOCK_UNLOCKED,	\
+		.first = NULL, .callers = LIST_HEAD_INIT((name).callers) }
+
+#define DEFINE_NOTIFIER_HEAD(name) 	\
+		struct notifier_head name = NOTIFIER_HEAD_INIT(name)
+
 
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

