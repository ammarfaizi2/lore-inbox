Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbVLFXjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbVLFXjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 18:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbVLFXjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 18:39:07 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:17093 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1030302AbVLFXjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 18:39:05 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, paulmck@us.ibm.com,
       greg@kroah.com, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Douglas_Warzecha@dell.com,
       Abhay_Salunke@dell.com, achim_leubner@adaptec.com,
       dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain 
In-reply-to: Your message of "Sun, 04 Dec 2005 16:19:57 -0000."
             <1133713198.3168.0.camel@localhost> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Dec 2005 10:38:44 +1100
Message-ID: <20749.1133912324@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Dec 2005 16:19:57 +0000, 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>On Llu, 2005-11-28 at 19:31 +1100, Keith Owens wrote:
>> >Or just don't unregister. That is what I did for the debug notifiers.
>> 
>> Unregister is not the only problem.  Chain traversal races with
>> register as well.
>
>There are some NMI handler registration functions and attempts at safe
>code for it in the unmerged experimental part of the bluesmoke
>(bluesmoke.sf.net) project that may be useful perhaps ?

Thanks Alan, the bluesmoke NMI handlers look very similar to the code
that I have just written.  However bluesmoke only handles a single
notifier chain, it has only one walking_handler_list array.  The kernel
is getting to the stage where it needs multiple notifier chains that
can be traversed without locks.  The patch below against 2.6.15-rc5
gives us lockfree traversal of notifier chains and supports multiple
chains.

The thing that I like about this approach is that the rest of the
kernel is barely affected.  We only have to change the function calls
(adding suffix '_lockfree' and removing any locks in the callers) for
code that needs lockfree traversal.  Other notifier chains are left
alone and there is no need to embed the type of chain in struct
notifier_block.  Even the change to add '_lockfree' can be incremental,
converting chains as required.

Note: This patch has been compiled but not tested yet.  Included for
review and discussion while I debug it.

 include/linux/notifier.h |    3 
 kernel/sys.c             |  166 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)

Index: linux/include/linux/notifier.h
===================================================================
--- linux.orig/include/linux/notifier.h	2005-10-28 10:02:08.000000000 +1000
+++ linux/include/linux/notifier.h	2005-12-06 14:28:29.413350932 +1100
@@ -24,6 +24,9 @@ struct notifier_block
 extern int notifier_chain_register(struct notifier_block **list, struct notifier_block *n);
 extern int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n);
 extern int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v);
+extern int notifier_chain_register_lockfree(struct notifier_block **list, struct notifier_block *n);
+extern int notifier_chain_unregister_lockfree(struct notifier_block **nl, struct notifier_block *n);
+extern int notifier_call_chain_lockfree(struct notifier_block **n, unsigned long val, void *v);
 
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
Index: linux/kernel/sys.c
===================================================================
--- linux.orig/kernel/sys.c	2005-12-06 12:23:38.864816047 +1100
+++ linux/kernel/sys.c	2005-12-06 18:29:50.899123936 +1100
@@ -187,6 +187,172 @@ int notifier_call_chain(struct notifier_
 
 EXPORT_SYMBOL(notifier_call_chain);
 
+/* The notifier_chain_*_lockfree functions below are based on the formal
+ * notifier_chain_* functions above, but allow the notifier chain to be
+ * traversed in situations where locks cannot be taken to protect the list,
+ * typically in the various notifier_die() handlers.  The 'lockfree' suffix
+ * only refers to the list traversal; register and unregister still take locks
+ * to protect against concurrent list update.  Register and unregister can only
+ * be called from contexts that can sleep.
+ *
+ * Without a lock on list traversal, list entries cannot be physically deleted,
+ * instead they are logically deleted.  The normal notifier_chain_* functions
+ * above use the supplied struct notifier_block in place.  This introduces
+ * another race because the notifier_block is in caller storage that the caller
+ * can delete (e.g. module unload).  So copy the notifier_block into local
+ * storage which is never deleted, although it can be reused.
+ *
+ * Critical property of these lists - once notifier_block_copy.nb.next is set,
+ * its value never changes.  Not even if the block is unregistered or reused.
+ */
+
+struct notifier_block_copy {
+	struct notifier_block nb;	/* must be at the start of the copy */
+	atomic_t deleted;
+	atomic_t calls;			/* outstanding calls to the function */
+	struct notifier_block *orig;
+};
+
+/**
+ *	notifier_chain_register_lockfree - Add notifier to a lockfree traversal
+ *	notifier chain
+ *	@list: Pointer to root list pointer
+ *	@n: New entry in notifier chain
+ *
+ *	Adds a notifier to a lockfree traversal notifier chain, reusing deleted
+ *	entries where possible.
+ *
+ *	Returns zero on success, or %-ENOMEM on failure.
+ */
+
+int notifier_chain_register_lockfree(struct notifier_block **list,
+				     struct notifier_block *n)
+{
+	struct notifier_block_copy *nbc, *c, *prev = NULL;
+	nbc = kmalloc(sizeof(*nbc), GFP_KERNEL);
+	if (!nbc)
+		return -ENOMEM;
+	nbc->nb = *n;
+	atomic_set(&nbc->deleted, 0);
+	atomic_set(&nbc->calls, 0);
+	nbc->orig = n;
+	write_lock(&notifier_lock);
+	while (*list) {
+		c = (struct notifier_block_copy *)*list;
+		if (nbc->nb.priority > c->nb.priority
+		    && atomic_read(&c->deleted) == 0)
+			break;
+		prev = c;
+		list = &(c->nb.next);
+	}
+	if (prev && atomic_read(&prev->deleted) != 0) {
+		nbc->nb.next = prev->nb.next;
+		prev->nb = nbc->nb;
+		prev->orig = n;
+		smp_wmb();
+		/* clearing the deleted flag must be done last */
+		atomic_set(&prev->deleted, 0);
+		kfree(nbc);
+	} else {
+		nbc->nb.next = *list;
+		smp_wmb();
+		*list = &nbc->nb;
+	}
+	write_unlock(&notifier_lock);
+	return 0;
+}
+
+EXPORT_SYMBOL(notifier_chain_register_lockfree);
+
+/**
+ *	notifier_chain_unregister_lockfree - Remove notifier from a lockfree
+ *	traversal notifier chain
+ *	@list: Pointer to root list pointer
+ *	@n: New entry in notifier chain
+ *
+ *	Removes a notifier from a lockfree traversal notifier chain.
+ *	Unregistered entries are logically deleted, not physically deleted.
+ *
+ *	Returns zero on success, or %-ENOENT on failure.
+ *
+ *	If the notifier exists in the chain and is in use, spin until there are
+ *	no outstanding callbacks on that function.  Only then is it safe to
+ *	return to the caller, the caller may be about to free the storage that
+ *	contains the function.
+ */
+
+int notifier_chain_unregister_lockfree(struct notifier_block **list,
+				       struct notifier_block *n)
+{
+	struct notifier_block_copy *c;
+	write_lock(&notifier_lock);
+	while (*list) {
+		c = (struct notifier_block_copy *)*list;
+		if (c->orig == n && atomic_read(&c->deleted) == 0) {
+			atomic_set(&c->deleted, 1);
+			smp_wmb();
+			while (atomic_read(&c->calls))
+				cpu_relax();
+			write_unlock(&notifier_lock);
+			return 0;
+		}
+		list = &(c->nb.next);
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
+ *
+ *	The callback is passed the address of the original notifier block
+ *	rather than the copy.  Just in case some code decides to embed the
+ *	notifier block in a larger structure then use offsetof() to get at the
+ *	enclosing structure.
+ *
+ *	The list traversal checks calls before deleted, unregister does the
+ *	checks in the reverse order.  That closes the race between traversal
+ *	using an entry and unregister deleting it and ensures that unregister
+ *	will not return as long as the callback is still being used.
+ */
+
+int notifier_call_chain_lockfree(struct notifier_block **list,
+				 unsigned long val, void *v)
+{
+	int ret = NOTIFY_DONE;
+	struct notifier_block_copy *c;
+	c = (struct notifier_block_copy *)*list;
+	while (c) {
+		smp_read_barrier_depends();
+		atomic_inc(&c->calls);
+		smp_mb__after_atomic_inc();
+		if (atomic_read(&c->deleted) == 0)
+			ret = c->nb.notifier_call(c->orig, val, v);
+		atomic_dec(&c->calls);
+		smp_mb__after_atomic_dec();
+		if (ret & NOTIFY_STOP_MASK)
+			break;
+		c = (struct notifier_block_copy *)c->nb.next;
+	}
+	return ret;
+}
+
+EXPORT_SYMBOL(notifier_call_chain_lockfree);
+
 /**
  *	register_reboot_notifier - Register function to be called at reboot time
  *	@nb: Info about notifier function to be called

