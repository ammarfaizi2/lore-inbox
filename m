Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWGKRic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWGKRic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWGKRic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:38:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:64177 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751139AbWGKRib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:38:31 -0400
Date: Tue, 11 Jul 2006 10:39:06 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matt Helsley <matthltc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com, Ingo Molnar <mingo@elte.hu>, tytso@us.ibm.com,
       Darren Hart <dvhltc@us.ibm.com>, oleg@tv-sign.ru,
       Jes Sorensen <jes@sgi.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: SRCU-based notifier chains
Message-ID: <20060711173906.GC1288@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1152306686.21787.2163.camel@stark> <Pine.LNX.4.44L0.0607101502540.5721-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0607101502540.5721-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 03:11:31PM -0400, Alan Stern wrote:
> On Fri, 7 Jul 2006, Matt Helsley wrote:
> > On Fri, 2006-07-07 at 15:59 -0400, Alan Stern wrote:

[ . . . ]

> > > We might want to leave some chains using the existing rw-semaphore API.  
> > > It's more appropriate when there's a high frequency of write-locking
> > > (i.e., things registering or unregistering on the notifier chain).  The 
> > > SRCU approach is more appropriate when the chain is called a lot and 
> > > needs to have low overhead, but (un)registration is uncommon.  Matt's task 
> > > notifiers are a good example.
> > 
> > Yes, it is an excellent example.
> 
> Okay, here is a patch -- completely untested but it compiles -- that adds 
> a new kind of notifier head, using SRCU to manage the list consistency.
> 
> At the moment I don't have any good candidates for blocking notifier 
> chains that should be converted to SRCU notifier chains, although some of 
> the things in the neworking core probably qualify.
> 
> Anyway, you can try this out with your task notifiers to make sure it 
> works as desired.
> 
> Alan Stern
> 
> P.S.: For this to work, the patch had to add "#ifndef _LINUX_SRCU_H"  
> guards to include/linux/srcu.h.  They undoubtedly belong there regardless.

Looks sane to me.  A couple of minor comments interspersed.

							Thanx, Paul

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>

> Index: usb-2.6/kernel/sys.c
> ===================================================================
> --- usb-2.6.orig/kernel/sys.c
> +++ usb-2.6/kernel/sys.c
> @@ -151,7 +151,7 @@ static int __kprobes notifier_call_chain
>  
>  /*
>   *	Atomic notifier chain routines.  Registration and unregistration
> - *	use a mutex, and call_chain is synchronized by RCU (no locks).
> + *	use a spinlock, and call_chain is synchronized by RCU (no locks).
>   */
>  
>  /**
> @@ -399,6 +399,128 @@ int raw_notifier_call_chain(struct raw_n
>  
>  EXPORT_SYMBOL_GPL(raw_notifier_call_chain);
>  
> +/*
> + *	SRCU notifier chain routines.    Registration and unregistration
> + *	use a mutex, and call_chain is synchronized by SRCU (no locks).
> + */

Hmmm...  Probably my just failing to pay attention, but haven't noticed
the double-header-comment style before.

> +/**
> + *	srcu_notifier_chain_register - Add notifier to an SRCU notifier chain
> + *	@nh: Pointer to head of the SRCU notifier chain
> + *	@n: New entry in notifier chain
> + *
> + *	Adds a notifier to an SRCU notifier chain.
> + *	Must be called in process context.
> + *
> + *	Currently always returns zero.
> + */
> + 
> +int srcu_notifier_chain_register(struct srcu_notifier_head *nh,
> +		struct notifier_block *n)
> +{
> +	int ret;
> +
> +	/*
> +	 * This code gets used during boot-up, when task switching is
> +	 * not yet working and interrupts must remain disabled.  At
> +	 * such times we must not call mutex_lock().
> +	 */
> +	if (unlikely(system_state == SYSTEM_BOOTING))
> +		return notifier_chain_register(&nh->head, n);
> +
> +	mutex_lock(&nh->mutex);
> +	ret = notifier_chain_register(&nh->head, n);
> +	mutex_unlock(&nh->mutex);
> +	return ret;
> +}
> +
> +EXPORT_SYMBOL_GPL(srcu_notifier_chain_register);
> +
> +/**
> + *	srcu_notifier_chain_unregister - Remove notifier from an SRCU notifier chain
> + *	@nh: Pointer to head of the SRCU notifier chain
> + *	@n: Entry to remove from notifier chain
> + *
> + *	Removes a notifier from an SRCU notifier chain.
> + *	Must be called from process context.
> + *
> + *	Returns zero on success or %-ENOENT on failure.
> + */
> +int srcu_notifier_chain_unregister(struct srcu_notifier_head *nh,
> +		struct notifier_block *n)
> +{
> +	int ret;
> +
> +	/*
> +	 * This code gets used during boot-up, when task switching is
> +	 * not yet working and interrupts must remain disabled.  At
> +	 * such times we must not call mutex_lock().
> +	 */
> +	if (unlikely(system_state == SYSTEM_BOOTING))
> +		return notifier_chain_unregister(&nh->head, n);
> +
> +	mutex_lock(&nh->mutex);
> +	ret = notifier_chain_unregister(&nh->head, n);
> +	mutex_unlock(&nh->mutex);
> +	synchronize_srcu(&nh->srcu);
> +	return ret;
> +}
> +
> +EXPORT_SYMBOL_GPL(srcu_notifier_chain_unregister);
> +
> +/**
> + *	srcu_notifier_call_chain - Call functions in an SRCU notifier chain
> + *	@nh: Pointer to head of the SRCU notifier chain
> + *	@val: Value passed unmodified to notifier function
> + *	@v: Pointer passed unmodified to notifier function
> + *
> + *	Calls each function in a notifier chain in turn.  The functions
> + *	run in a process context, so they are allowed to block.
> + *
> + *	If the return value of the notifier can be and'ed
> + *	with %NOTIFY_STOP_MASK then srcu_notifier_call_chain
> + *	will return immediately, with the return value of
> + *	the notifier function which halted execution.
> + *	Otherwise the return value is the return value
> + *	of the last notifier function called.
> + */
> + 
> +int srcu_notifier_call_chain(struct srcu_notifier_head *nh,
> +		unsigned long val, void *v)
> +{
> +	int ret;
> +	int idx;
> +
> +	idx = srcu_read_lock(&nh->srcu);
> +	ret = notifier_call_chain(&nh->head, val, v);
> +	srcu_read_unlock(&nh->srcu, idx);
> +	return ret;
> +}
> +
> +EXPORT_SYMBOL_GPL(srcu_notifier_call_chain);
> +
> +/**
> + *	srcu_init_notifier_head - Initialize an SRCU notifier head
> + *	@nh: Pointer to head of the srcu notifier chain
> + *
> + *	Unlike other sorts of notifier heads, SRCU notifier heads require
> + *	dynamic initialization.  Be sure to call this routine before
> + *	calling any of the other SRCU notifier routines for this head.
> + *
> + *	If an SRCU notifier head is deallocated, it must first be cleaned
> + *	up by calling srcu_cleanup_notifier_head().  Otherwise the head's
> + *	per-cpu data (used by the SRCU mechanism) will leak.
> + */
> +
> +void srcu_init_notifier_head(struct srcu_notifier_head *nh)
> +{
> +	mutex_init(&nh->mutex);
> +	init_srcu_struct(&nh->srcu);
> +	nh->head = NULL;
> +}
> +
> +EXPORT_SYMBOL_GPL(srcu_init_notifier_head);
> +
>  /**
>   *	register_reboot_notifier - Register function to be called at reboot time
>   *	@nb: Info about notifier function to be called
> Index: usb-2.6/include/linux/notifier.h
> ===================================================================
> --- usb-2.6.orig/include/linux/notifier.h
> +++ usb-2.6/include/linux/notifier.h
> @@ -12,9 +12,10 @@
>  #include <linux/errno.h>
>  #include <linux/mutex.h>
>  #include <linux/rwsem.h>
> +#include <linux/srcu.h>
>  
>  /*
> - * Notifier chains are of three types:
> + * Notifier chains are of four types:

Is it possible to subsume one of the other three types?

Might not be, but have to ask...

>   *
>   *	Atomic notifier chains: Chain callbacks run in interrupt/atomic
>   *		context. Callouts are not allowed to block.
> @@ -23,13 +24,27 @@
>   *	Raw notifier chains: There are no restrictions on callbacks,
>   *		registration, or unregistration.  All locking and protection
>   *		must be provided by the caller.
> + *	SRCU notifier chains: A variant of blocking notifier chains, with
> + *		the same restrictions.
>   *
>   * atomic_notifier_chain_register() may be called from an atomic context,
> - * but blocking_notifier_chain_register() must be called from a process
> - * context.  Ditto for the corresponding _unregister() routines.
> + * but blocking_notifier_chain_register() and srcu_notifier_chain_register()
> + * must be called from a process context.  Ditto for the corresponding
> + * _unregister() routines.
>   *
> - * atomic_notifier_chain_unregister() and blocking_notifier_chain_unregister()
> - * _must not_ be called from within the call chain.
> + * atomic_notifier_chain_unregister(), blocking_notifier_chain_unregister(),
> + * and srcu_notifier_chain_unregister() _must not_ be called from within
> + * the call chain.
> + *
> + * SRCU notifier chains are an alternative form of blocking notifier chains.
> + * They use SRCU (Sleepable Read-Copy Update) instead of rw-semaphores for
> + * protection of the chain links.  This means there is _very_ low overhead
> + * in srcu_notifier_call_chain(): no cache misses and no memory barriers.
> + * As compensation, srcu_notifier_chain_unregister() is rather expensive.
> + * SRCU notifier chains should be used when the chain will be called very
> + * often but notifier_blocks will seldom be removed.  Also, SRCU notifier
> + * chains are slightly more difficult to use because they require dynamic
> + * runtime initialization.
>   */
>  
>  struct notifier_block {
> @@ -52,6 +67,12 @@ struct raw_notifier_head {
>  	struct notifier_block *head;
>  };
>  
> +struct srcu_notifier_head {
> +	struct mutex mutex;
> +	struct srcu_struct srcu;
> +	struct notifier_block *head;
> +};
> +
>  #define ATOMIC_INIT_NOTIFIER_HEAD(name) do {	\
>  		spin_lock_init(&(name)->lock);	\
>  		(name)->head = NULL;		\
> @@ -64,6 +85,11 @@ struct raw_notifier_head {
>  		(name)->head = NULL;		\
>  	} while (0)
>  
> +/* srcu_notifier_heads must be initialized and cleaned up dynamically */
> +extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
> +#define srcu_cleanup_notifier_head(name)	\
> +		cleanup_srcu_struct(&(name)->srcu);
> +
>  #define ATOMIC_NOTIFIER_INIT(name) {				\
>  		.lock = __SPIN_LOCK_UNLOCKED(name.lock),	\
>  		.head = NULL }
> @@ -72,6 +98,7 @@ struct raw_notifier_head {
>  		.head = NULL }
>  #define RAW_NOTIFIER_INIT(name)	{				\
>  		.head = NULL }
> +/* srcu_notifier_heads cannot be initialized statically */
>  
>  #define ATOMIC_NOTIFIER_HEAD(name)				\
>  	struct atomic_notifier_head name =			\
> @@ -91,6 +118,8 @@ extern int blocking_notifier_chain_regis
>  		struct notifier_block *);
>  extern int raw_notifier_chain_register(struct raw_notifier_head *,
>  		struct notifier_block *);
> +extern int srcu_notifier_chain_register(struct srcu_notifier_head *,
> +		struct notifier_block *);
>  
>  extern int atomic_notifier_chain_unregister(struct atomic_notifier_head *,
>  		struct notifier_block *);
> @@ -98,6 +127,8 @@ extern int blocking_notifier_chain_unreg
>  		struct notifier_block *);
>  extern int raw_notifier_chain_unregister(struct raw_notifier_head *,
>  		struct notifier_block *);
> +extern int srcu_notifier_chain_unregister(struct srcu_notifier_head *,
> +		struct notifier_block *);
>  
>  extern int atomic_notifier_call_chain(struct atomic_notifier_head *,
>  		unsigned long val, void *v);
> @@ -105,6 +136,8 @@ extern int blocking_notifier_call_chain(
>  		unsigned long val, void *v);
>  extern int raw_notifier_call_chain(struct raw_notifier_head *,
>  		unsigned long val, void *v);
> +extern int srcu_notifier_call_chain(struct srcu_notifier_head *,
> +		unsigned long val, void *v);
>  
>  #define NOTIFY_DONE		0x0000		/* Don't care */
>  #define NOTIFY_OK		0x0001		/* Suits me */
> Index: usb-2.6/include/linux/srcu.h
> ===================================================================
> --- usb-2.6.orig/include/linux/srcu.h
> +++ usb-2.6/include/linux/srcu.h
> @@ -24,6 +24,9 @@
>   *
>   */
>  
> +#ifndef _LINUX_SRCU_H
> +#define _LINUX_SRCU_H
> +
>  struct srcu_struct_array {
>  	int c[2];
>  };
> @@ -47,3 +50,5 @@ void srcu_read_unlock(struct srcu_struct
>  void synchronize_srcu(struct srcu_struct *sp);
>  long srcu_batches_completed(struct srcu_struct *sp);
>  void cleanup_srcu_struct(struct srcu_struct *sp);
> +
> +#endif
> 
