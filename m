Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWBJQD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWBJQD0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWBJQD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:03:26 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:18314 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750768AbWBJQDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:03:25 -0500
Date: Fri, 10 Feb 2006 11:03:24 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] Notifier chain update: API changes
Message-ID: <Pine.LNX.4.44L0.0602101101350.5227-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel's implementation of notifier chains is unsafe.  There is no
protection against entries being added to or removed from a chain
while the chain is in use.  The issues were discussed in this thread:

    http://marc.theaimsgroup.com/?l=linux-kernel&m=113018709002036&w=2

We noticed that notifier chains in the kernel fall into two basic
usage classes:

	"Blocking" chains are always called from a process context
	and the callout routines are allowed to sleep;

	"Atomic" chains can be called from an atomic context and
	the callout routines are not allowed to sleep.

We decided to codify this distinction and make it part of the API.
Therefore this set of patches introduces three new, parallel APIs: one
for blocking notifiers, one for atomic notifiers, and one for "raw"
notifiers (which is really just the old API under a new name).  New
kinds of data structures are used for the heads of the chains, and new
routines are defined for registration, unregistration, and calling a
chain.  The three APIs are explained in include/linux/notifier.h and
their implementation is in kernel/sys.c.

With atomic and blocking chains, the implementation guarantees that
the chain links will not be corrupted and that chain callers will not
get messed up by entries being added or removed.  For raw chains the
implementation provides no guarantees at all; users of this API must
provide their own protections.  (The idea was that situations may come
up where the assumptions of the atomic and blocking APIs are not
appropriate, so it should be possible for users to handle these things
in their own way.)

There are some limitations, which should not be too hard to live with.
For atomic/blocking chains, registration and unregistration must
always be done in a process context since the chain is protected by a
mutex/rwsem.  Also, a callout routine for a non-raw chain must not try
to register or unregister entries on its own chain.  (This did happen
in a couple of places and the code had to be changed to avoid it.)

Since atomic chains may be called from within an NMI handler, they
cannot use spinlocks for synchronization.  Instead we use RCU.  The
overhead falls almost entirely in the unregister routine, which is
okay since unregistration is much less frequent that calling a chain.


Here is the list of chains that we adjusted and their classifications.
None of them use the raw API, so for the moment it is only a
placeholder.

ATOMIC CHAINS
-------------
arch/i386/kernel/traps.c:		i386die_chain
arch/ia64/kernel/traps.c:		ia64die_chain
arch/powerpc/kernel/traps.c:		powerpc_die_chain
arch/sparc64/kernel/traps.c:		sparc64die_chain
arch/x86_64/kernel/traps.c:		die_chain
drivers/char/ipmi/ipmi_si_intf.c:	xaction_notifier_list
kernel/panic.c:				panic_notifier_list
kernel/profile.c:			task_free_notifier
net/bluetooth/hci_core.c:		hci_notifier
net/ipv4/netfilter/ip_conntrack_core.c:	ip_conntrack_chain
net/ipv4/netfilter/ip_conntrack_core.c:	ip_conntrack_expect_chain
net/ipv6/addrconf.c:			inet6addr_chain
net/netfilter/nf_conntrack_core.c:	nf_conntrack_chain
net/netfilter/nf_conntrack_core.c:	nf_conntrack_expect_chain
net/netlink/af_netlink.c:		netlink_chain

BLOCKING CHAINS
---------------
arch/powerpc/platforms/pseries/reconfig.c:	pSeries_reconfig_chain
arch/s390/kernel/process.c:		idle_chain
arch/x86_64/kernel/process.c		idle_notifier
drivers/base/memory.c:			memory_chain
drivers/cpufreq/cpufreq.c		cpufreq_policy_notifier_list
drivers/cpufreq/cpufreq.c		cpufreq_transition_notifier_list
drivers/macintosh/adb.c:		adb_client_list
drivers/macintosh/via-pmu.c		sleep_notifier_list
drivers/macintosh/via-pmu68k.c		sleep_notifier_list
drivers/macintosh/windfarm_core.c	wf_client_list
drivers/usb/core/notify.c		usb_notifier_list
drivers/video/fbmem.c			fb_notifier_list
kernel/cpu.c				cpu_chain
kernel/module.c				module_notify_list
kernel/profile.c			munmap_notifier
kernel/profile.c			task_exit_notifier
kernel/sys.c				reboot_notifier_list
net/core/dev.c				netdev_chain
net/decnet/dn_dev.c:			dnaddr_chain
net/ipv4/devinet.c:			inetaddr_chain

It's possible that some of these classifications are wrong.  If they are,
please let us know or submit a patch to fix them.  Note that any chain
that gets called very frequently should be atomic, because the rwsem
read-locking used for blocking chains is very likely to incur cache
misses on SMP systems.  (However, if the chain's callout routines may
sleep then the chain cannot be atomic.)


The patch set is organized as follows:

1 of 8 (this file (as632b)): Introduce the new API and its implementation.
2 of 8: Simple changes that involve only the definition or declaration
	of chain heads.
3 of 8: Changes in which we removed some local protection (it's no
	longer needed since the core now provides the protection).
4 of 8: Changes for diechain in various architectures (it's now safe
	to unregister entries in this chain).
5 of 8: Changes to routines that try to unregister themselves.
6 of 8: Changes to dcdbas.c (it requires special handling).
7 of 8: Changes to make usb_notify use the new API instead of its own.
8 of 8: Changes from the old API names to the new names.


The patch set was written by Alan Stern and Chandra Seetharaman,
incorporating material written by Keith Owens and suggestions from
Paul McKenney and Andrew Morton.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>

Index: l2616/include/linux/notifier.h
===================================================================
--- l2616.orig/include/linux/notifier.h
+++ l2616/include/linux/notifier.h
@@ -10,25 +10,100 @@
 #ifndef _LINUX_NOTIFIER_H
 #define _LINUX_NOTIFIER_H
 #include <linux/errno.h>
+#include <linux/mutex.h>
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
+	struct mutex mutex;
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
+		mutex_init(&(name)->mutex);	\
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
+		.mutex = __MUTEX_INITIALIZER((name).mutex),	\
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
Index: l2616/kernel/sys.c
===================================================================
--- l2616.orig/kernel/sys.c
+++ l2616/kernel/sys.c
@@ -96,98 +96,287 @@ int cad_pid = 1;
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
+static int __kprobes notifier_call_chain(struct notifier_block **nl,
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
+	mutex_lock(&nh->mutex);
+	ret = notifier_chain_register(&nh->head, n);
+	mutex_unlock(&nh->mutex);
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
+ *	Returns zero on success or %-ENOENT on failure.
+ */
+int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
+		struct notifier_block *n)
+{
+	int ret;
+
+	mutex_lock(&nh->mutex);
+	ret = notifier_chain_unregister(&nh->head, n);
+	mutex_unlock(&nh->mutex);
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
+ *	Calls each function in a notifier chain in turn.  The functions
+ *	run in an atomic context, so they must not block.
+ *	This routine uses RCU to synchronize with changes to the chain.
+ *
+ *	If the return value of the notifier can be and'ed
+ *	with %NOTIFY_STOP_MASK then atomic_notifier_call_chain
+ *	will return immediately, with the return value of
+ *	the notifier function which halted execution.
+ *	Otherwise the return value is the return value
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
 }
 
-EXPORT_SYMBOL(notifier_chain_unregister);
+EXPORT_SYMBOL(blocking_notifier_chain_register);
 
 /**
- *	notifier_call_chain - Call functions in a notifier chain
- *	@n: Pointer to root pointer of notifier chain
+ *	blocking_notifier_chain_unregister - Remove notifier from a blocking notifier chain
+ *	@nh: Pointer to head of the blocking notifier chain
+ *	@n: Entry to remove from notifier chain
+ *
+ *	Removes a notifier from a blocking notifier chain.
+ *	Must be called from process context.
+ *
+ *	Returns zero on success or %-ENOENT on failure.
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
+}
+
+EXPORT_SYMBOL(blocking_notifier_chain_unregister);
+
+/**
+ *	blocking_notifier_call_chain - Call functions in a blocking notifier chain
+ *	@nh: Pointer to head of the blocking notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
  *
- *	Calls each function in a notifier chain in turn.
+ *	Calls each function in a notifier chain in turn.  The functions
+ *	run in a process context, so they are allowed to block.
  *
- *	If the return value of the notifier can be and'd
- *	with %NOTIFY_STOP_MASK, then notifier_call_chain
+ *	If the return value of the notifier can be and'ed
+ *	with %NOTIFY_STOP_MASK then blocking_notifier_call_chain
  *	will return immediately, with the return value of
  *	the notifier function which halted execution.
- *	Otherwise, the return value is the return value
+ *	Otherwise the return value is the return value
  *	of the last notifier function called.
  */
  
-int __kprobes notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
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
+	return notifier_chain_register(&nh->head, n);
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
+ *	Returns zero on success or %-ENOENT on failure.
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
+ *	Calls each function in a notifier chain in turn.  The functions
+ *	run in an undefined context.
+ *	All locking must be provided by the caller.
+ *
+ *	If the return value of the notifier can be and'ed
+ *	with %NOTIFY_STOP_MASK then raw_notifier_call_chain
+ *	will return immediately, with the return value of
+ *	the notifier function which halted execution.
+ *	Otherwise the return value is the return value
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

