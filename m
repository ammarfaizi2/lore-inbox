Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbVLGCqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVLGCqt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 21:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVLGCqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 21:46:49 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:23937 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964854AbVLGCqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 21:46:48 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andi Kleen <ak@suse.de>, Corey Minyard <minyard@acm.org>,
       Andrew Morton <akpm@osdl.org>, paulmck@us.ibm.com, greg@kroah.com,
       sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Douglas_Warzecha@dell.com,
       Abhay_Salunke@dell.com, achim_leubner@adaptec.com,
       dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain 
In-reply-to: Your message of "Wed, 07 Dec 2005 10:38:44 +1100."
             <20749.1133912324@ocs3.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Dec 2005 13:43:51 +1100
Message-ID: <5893.1133923431@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2005 10:38:44 +1100, 
Keith Owens <kaos@sgi.com> wrote:
>On Sun, 04 Dec 2005 16:19:57 +0000, 
>Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>On Llu, 2005-11-28 at 19:31 +1100, Keith Owens wrote:
>>> >Or just don't unregister. That is what I did for the debug notifiers.
>>> 
>>> Unregister is not the only problem.  Chain traversal races with
>>> register as well.
>>
>>There are some NMI handler registration functions and attempts at safe
>>code for it in the unmerged experimental part of the bluesmoke
>>(bluesmoke.sf.net) project that may be useful perhaps ?
>
>Thanks Alan, the bluesmoke NMI handlers look very similar to the code
>that I have just written.  However bluesmoke only handles a single
>notifier chain, it has only one walking_handler_list array.  The kernel
>is getting to the stage where it needs multiple notifier chains that
>can be traversed without locks.  The patch below against 2.6.15-rc5
>gives us lockfree traversal of notifier chains and supports multiple
>chains.

My previous patch was way too complicated, this is much simpler.  Based
on Corey Minyard's patch of http://lkml.org/lkml/2004/8/19/140,
generalized to support multiple lockfree notifier chains, with a few
extra synchronization calls added.

Again, for review only.  Compiled but not tested yet.

 include/linux/notifier.h |    7 +++
 kernel/sys.c             |  105 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

Index: linux/include/linux/notifier.h
===================================================================
--- linux.orig/include/linux/notifier.h	2005-12-07 12:00:57.569908107 +1100
+++ linux/include/linux/notifier.h	2005-12-07 13:07:18.643526153 +1100
@@ -24,6 +24,13 @@ struct notifier_block
 extern int notifier_chain_register(struct notifier_block **list, struct notifier_block *n);
 extern int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n);
 extern int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v);
+static inline int
+notifier_chain_register_lockfree(struct notifier_block **list, struct notifier_block *n)
+{
+	return notifier_chain_register(list, n);
+}
+extern int notifier_chain_unregister_lockfree(struct notifier_block **nl, struct notifier_block *n);
+extern int notifier_call_chain_lockfree(struct notifier_block **n, unsigned long val, void *v);
 
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
Index: linux/kernel/sys.c
===================================================================
--- linux.orig/kernel/sys.c	2005-12-07 12:00:57.570884536 +1100
+++ linux/kernel/sys.c	2005-12-07 13:37:53.773534284 +1100
@@ -116,6 +116,7 @@ int notifier_chain_register(struct notif
 		list= &((*list)->next);
 	}
 	n->next = *list;
+	smp_wmb();
 	*list=n;
 	write_unlock(&notifier_lock);
 	return 0;
@@ -187,6 +188,110 @@ int notifier_call_chain(struct notifier_
 
 EXPORT_SYMBOL(notifier_call_chain);
 
+/* The notifier_chain_*_lockfree functions below are based on the formal
+ * notifier_chain_* functions above, but allow the notifier chain to be
+ * traversed in situations where locks cannot be taken to protect the list,
+ * typically in the various notifier_die() handlers.  The 'lockfree' suffix
+ * only refers to the list traversal; register and unregister still take locks
+ * to protect against concurrent list update.  Register and unregister can only
+ * be called from contexts that can sleep.
+ */
+
+/* Array notifier_chain_lockfree_inuse is shared between all lockfree notifier
+ * chains.   Unregistration of any chain entry must be delayed if any cpu is
+ * executing a lockfree callback, even if that callback is on a different
+ * chain.  No big deal, unregister is a rare event.
+ *
+ * Each element is only updated from one cpu so the elements do not need to be
+ * atomic.  This avoids problems on architectures that use a hash of spinlocks
+ * to implement atomic variables.
+ *
+ * This array could be replaced by a per cpu variable, but cpu hotplug may want
+ * to use these functions.  Before converting to a per cpu variable, review the
+ * cpu hotplug code, paying particular attention to where cpu_online() is set
+ * or cleared and where cpu hotplug runs any notify chains.  For the same
+ * reason, these functions do not check cpu_online() at the moment.
+ */
+
+static int notifier_chain_lockfree_inuse[NR_CPUS];
+
+/**
+ *	notifier_chain_unregister_lockfree - Remove notifier from a lockfree
+ *	traversal notifier chain
+ *	@list: Pointer to root list pointer
+ *	@n: New entry in notifier chain
+ *
+ *	Removes a notifier from a lockfree traversal notifier chain.
+ *
+ *	Returns zero on success, or %-ENOENT on failure.
+ */
+
+int notifier_chain_unregister_lockfree(struct notifier_block **list,
+				       struct notifier_block *n)
+{
+	int i;
+	write_lock(&notifier_lock);
+	while (*list) {
+		if (*list == n) {
+			*list = n->next;
+			smp_wmb();
+			for (i = 0; i < NR_CPUS; ++i) {
+				while (unlikely(notifier_chain_lockfree_inuse[i])) {
+					barrier();
+					cpu_relax();
+				}
+			}
+			n->next = NULL;
+			write_unlock(&notifier_lock);
+			return 0;
+		}
+		list = &((*list)->next);
+	}
+	write_unlock(&notifier_lock);
+	return -ENOENT;
+}
+
+EXPORT_SYMBOL(notifier_chain_unregister_lockfree);
+
+/**
+ *	notifier_call_chain_lockfree - Call functions in a lockfree traversal
+ *	notifier chain
+ *	@list: Pointer to root pointer of notifier chain
+ *	@val: Value passed unmodified to notifier function
+ *	@v: Pointer passed unmodified to notifier function
+ *
+ *	Calls each function in a lockfree traversal notifier chain in turn.
+ *
+ *	If the return value of the notifier can be and'd with
+ *	%NOTIFY_STOP_MASK, then notifier_call_chain will return immediately,
+ *	with the return value of the notifier function which halted execution.
+ *	Otherwise, the return value is the return value of the last notifier
+ *	function called.
+ */
+
+int notifier_call_chain_lockfree(struct notifier_block **list,
+				 unsigned long val, void *v)
+{
+	int ret = NOTIFY_DONE, cpu = smp_processor_id(), nested;
+	struct notifier_block *nb;
+	nested = notifier_chain_lockfree_inuse[cpu];
+	notifier_chain_lockfree_inuse[cpu] = 1;
+	wmb();
+	nb = *list;
+	while (nb) {
+		smp_read_barrier_depends();
+		ret = nb->notifier_call(nb, val, v);
+		if (ret & NOTIFY_STOP_MASK)
+			break;
+		nb = nb->next;
+	}
+	barrier();
+	notifier_chain_lockfree_inuse[cpu] = nested;
+	return ret;
+}
+
+EXPORT_SYMBOL(notifier_call_chain_lockfree);
+
 /**
  *	register_reboot_notifier - Register function to be called at reboot time
  *	@nb: Info about notifier function to be called

