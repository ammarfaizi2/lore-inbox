Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbVKLBnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVKLBnm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 20:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVKLBnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 20:43:42 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:16525 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750839AbVKLBnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 20:43:41 -0500
Date: Fri, 11 Nov 2005 17:44:21 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Subject: [RFC][PATCH] Fix for unsafe notifier chain mechanism
Message-ID: <20051112014421.GH1289@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1131752619.14041.125.camel@linuxchandra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131752619.14041.125.camel@linuxchandra>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 03:43:39PM -0800, Chandra Seetharaman wrote:
> Hello,
> 
> In 2.6.14, the notifier chains are unsafe. notifier_call_chain() walks through
> the list of a call chain without any protection.
> 
> Alan Stern <stern@rowland.harvard.edu> brought the issue and suggested a fix
> in lkml on Oct 24 2005:
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=113018709002036&w=2
> 
> There was a lot of discussion on that thread regarding the issue, and
> following were the conclusions about the requirements of the notifier
> call mechanism:
> 
> 	- The chain list has to be protected in all the places where the
> 	  list is accessed.
> 	- we need a new notifier_head data structure to encompass the head 
> 	  of the notifier chain and a semaphore that protects the list.
> 	- There should be two types of call chains: one that is called in 
> 	  a process context and another that is called in atomic/interrupt
> 	  context.
> 	- No lock should be acquired in notifier_call_chain() for an
> 	  atomic-type chain.
> 	- notifier_chain_register() and notifier_chain_unregister() should
> 	  be called only from process context.
> 	- notifier_chain_unregister() should _not_ be called from a
> 	  callout routine.
> 
> This patch is a modified version of Alan's original patch and meets these
> requirements.  The patch is not complete, since all the notifier call
> chain definitions have to changed to use the new notifier_head data
> structure.

Looks pretty good!  Some RCU-related review comments interspersed below.

> Alan and I did think about changing the data structure to use list_head, but 
> deferred it (as a cleanup) as it is not directly tied with what Alan was
> trying to fix.

It would simplify the code...

> ----
> 
> Signed-off-by:  Chandra Seetharaman <sekharan@us.ibm.com>
> Signed-off-by:  Alan Stern <stern@rowland.harvard.edu>
> -----
> 
>  include/linux/notifier.h |   69 +++++++++++++++++++++++++++++---
>  kernel/sys.c             |  101 ++++++++++++++++++++++++++++-------------------
>  2 files changed, 126 insertions(+), 44 deletions(-)
> 
> Index: l2614-notifiers/include/linux/notifier.h
> ===================================================================
> --- l2614-notifiers.orig/include/linux/notifier.h
> +++ l2614-notifiers/include/linux/notifier.h
> @@ -10,25 +10,84 @@
>  #ifndef _LINUX_NOTIFIER_H
>  #define _LINUX_NOTIFIER_H
>  #include <linux/errno.h>
> +#include <linux/rwsem.h>
> +
> +/*
> + * Notifier chains are of two types:
> + *	Atomic notifier chains: Chain callbacks run in interrupt/atomic
> + *		context. Callouts are not allowed to block.
> + *	Blocking notifier chains: Chain callback run in process context.
> + *		Callouts are allowed to block.
> + *
> + * Type of a chain is defined in its head.
> + *
> + * notifier_chain_register() and notifier_chain_unregister() should be
> + * called only from process context.
> + *
> + * notifier_chain_unregister() _should not_ be called from the
> + * corresponding call chain.
> + *
> + */
> +enum notifier_type {
> +	ATOMIC_NOTIFIER,
> +	BLOCKING_NOTIFIER,
> +};
>  
>  struct notifier_block
>  {
> -	int (*notifier_call)(struct notifier_block *self, unsigned long, void *);
> +	int (*notifier_call)(struct notifier_block *, unsigned long, void *);
>  	struct notifier_block *next;
>  	int priority;
>  };
>  
> +struct notifier_head {
> +	enum notifier_type type;
> +	struct rw_semaphore rwsem;
> +	struct notifier_block *head;
> +};
> +
> +#define NOTIFIER_HEAD_INIT(name, head_type) {		\
> +	.type = head_type,				\
> +	.rwsem = __RWSEM_INITIALIZER((name).rwsem),	\
> +	.head = NULL }
> +
> +#define NOTIFIER_HEAD(name, head_type) \
> +	struct notifier_head name = NOTIFIER_HEAD_INIT(name, head_type)
> +
> +#define INIT_NOTIFIER_HEAD(name, head_type) do {		\
> +	(ptr)->type = head_type;			\
> +	init_rwsem(&(ptr)->rwsem);			\
> +	ptr->head = NULL;				\
> +} while (0)
> +
> +#define ATOMIC_NOTIFIER_HEAD_INIT(name) \
> +		NOTIFIER_HEAD_INIT(name, ATOMIC_NOTIFIER)
> +#define ATOMIC_NOTIFIER_HEAD(name) \
> +		NOTIFIER_HEAD(name, ATOMIC_NOTIFIER)
> +#define ATOMIC_INIT_NOTIFIER_HEAD(name) \
> +		INIT_NOTIFIER_HEAD(name, ATOMIC_NOTIFIER)
> +
> +#define BLOCKING_NOTIFIER_HEAD_INIT(name) \
> +		NOTIFIER_HEAD_INIT(name, BLOCKING_NOTIFIER)
> +#define BLOCKING_NOTIFIER_HEAD(name) \
> +		NOTIFIER_HEAD(name, BLOCKING_NOTIFIER)
> +#define BLOCKING_INIT_NOTIFIER_HEAD(name) \
> +		INIT_NOTIFIER_HEAD(name, BLOCKING_NOTIFIER)
>  
>  #ifdef __KERNEL__
>  
> -extern int notifier_chain_register(struct notifier_block **list, struct notifier_block *n);
> -extern int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n);
> -extern int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v);
> +extern int notifier_chain_register(struct notifier_head *,
> +					struct notifier_block *);
> +extern int notifier_chain_unregister(struct notifier_head *,
> +					struct notifier_block *);
> +extern int notifier_call_chain(struct notifier_head *,
> +					unsigned long val, void *v);
>  
>  #define NOTIFY_DONE		0x0000		/* Don't care */
>  #define NOTIFY_OK		0x0001		/* Suits me */
>  #define NOTIFY_STOP_MASK	0x8000		/* Don't call further */
> -#define NOTIFY_BAD		(NOTIFY_STOP_MASK|0x0002)	/* Bad/Veto action	*/
> +#define NOTIFY_BAD		(NOTIFY_STOP_MASK|0x0002)
> +						/* Bad/Veto action */
>  /*
>   * Clean way to return from the notifier and stop further calls.
>   */
> Index: l2614-notifiers/kernel/sys.c
> ===================================================================
> --- l2614-notifiers.orig/kernel/sys.c
> +++ l2614-notifiers/kernel/sys.c
> @@ -92,31 +92,35 @@ int cad_pid = 1;
>   *	and the like. 
>   */
>  
> -static struct notifier_block *reboot_notifier_list;
> -static DEFINE_RWLOCK(notifier_lock);
> +static BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
>  
>  /**
>   *	notifier_chain_register	- Add notifier to a notifier chain
> - *	@list: Pointer to root list pointer
> + *	@nh: Pointer to head of the notifier chain
>   *	@n: New entry in notifier chain
>   *
>   *	Adds a notifier to a notifier chain.
> + *	Must be called from process context.
>   *
>   *	Currently always returns zero.
>   */
>   
> -int notifier_chain_register(struct notifier_block **list, struct notifier_block *n)
> +int notifier_chain_register(struct notifier_head *nh, struct notifier_block *n)
>  {
> -	write_lock(&notifier_lock);
> -	while(*list)
> -	{
> -		if(n->priority > (*list)->priority)
> -			break;
> -		list= &((*list)->next);
> -	}
> -	n->next = *list;
> -	*list=n;
> -	write_unlock(&notifier_lock);
> +	struct notifier_block **nl;
> +
> +	down_write(&nh->rwsem);
> +	nl = &nh->head;
> +	while ((*nl) != NULL) {
> +		if (n->priority > (*nl)->priority)
> +			break;
> +		nl = &((*nl)->next);
> +	}
> +	rcu_assign_pointer(n->next, *nl);

The above can simply be "n->next = *nl;".  The reason is that this change
of state is not visible to RCU readers until after the following statement,
and it therefore need not be an RCU-reader-safe assignment.  You only need
to use rcu_assign_pointer() when the results of the assignment are
immediately visible to RCU readers.

> +	rcu_assign_pointer(*nl, n);
> +	up_write(&nh->rwsem);
> +	if (nh->type == ATOMIC_NOTIFIER)
> +		synchronize_rcu();

This "if" statement and the "synchronize_rcu()" are not needed.  Nothing
has been removed from the list, so nothing will be freed, so no need to
wait for readers to get done.

In contrast, the synchronize_rcu() in notifier_chain_unregister() -is-
needed, since we need to free the removed element.

>  	return 0;
>  }
>  
> @@ -124,28 +128,32 @@ EXPORT_SYMBOL(notifier_chain_register);
>  
>  /**
>   *	notifier_chain_unregister - Remove notifier from a notifier chain
> - *	@nl: Pointer to root list pointer
> + *	@nh: Pointer to head of the notifier chain
>   *	@n: New entry in notifier chain
>   *
>   *	Removes a notifier from a notifier chain.
> + *	Must be called from process context.
>   *
>   *	Returns zero on success, or %-ENOENT on failure.
>   */
> - 
> -int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n)
> +int notifier_chain_unregister(struct notifier_head *nh,
> +					struct notifier_block *n)
>  {
> -	write_lock(&notifier_lock);
> -	while((*nl)!=NULL)
> -	{
> -		if((*nl)==n)
> -		{
> -			*nl=n->next;
> -			write_unlock(&notifier_lock);
> +	struct notifier_block **nl;
> +
> +	down_write(&nh->rwsem);
> +	nl = &nh->head;
> +	while ((*nl) != NULL) {
> +		if ((*nl) == n) {
> +			rcu_assign_pointer(*nl, n->next);
> +			up_write(&nh->rwsem);
> +			if (nh->type == ATOMIC_NOTIFIER)
> +				synchronize_rcu();
>  			return 0;
>  		}
> -		nl=&((*nl)->next);
> +		nl = &((*nl)->next);
>  	}
> -	write_unlock(&notifier_lock);
> +	up_write(&nh->rwsem);
>  	return -ENOENT;
>  }
>  
> @@ -153,12 +161,18 @@ EXPORT_SYMBOL(notifier_chain_unregister)
>  
>  /**
>   *	notifier_call_chain - Call functions in a notifier chain
> - *	@n: Pointer to root pointer of notifier chain
> + *	@nh: Pointer to the head of notifier chain
>   *	@val: Value passed unmodified to notifier function
>   *	@v: Pointer passed unmodified to notifier function
>   *
>   *	Calls each function in a notifier chain in turn.
>   *
> + *	If @nh points to an %ATOMIC_NOTIFIER_HEAD then this routine may
> + *	be called in any context, as it will not sleep.
> + *
> + *	If @nh points to a %BLOCKING_NOTIFIER_HEAD then this routine may
> + *	be called only in process context.
> + *
>   *	If the return value of the notifier can be and'd
>   *	with %NOTIFY_STOP_MASK, then notifier_call_chain
>   *	will return immediately, with the return value of
> @@ -167,20 +181,29 @@ EXPORT_SYMBOL(notifier_chain_unregister)
>   *	of the last notifier function called.
>   */
>   
> -int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
> +int notifier_call_chain(struct notifier_head *nh, unsigned long val, void *v)
>  {
> -	int ret=NOTIFY_DONE;
> -	struct notifier_block *nb = *n;
> +	int ret = NOTIFY_DONE;
> +	struct notifier_block *nb;
>  
> -	while(nb)
> -	{
> -		ret=nb->notifier_call(nb,val,v);
> -		if(ret&NOTIFY_STOP_MASK)
> -		{
> -			return ret;
> -		}
> -		nb=nb->next;
> -	}
> +	if (!nh->head)
> +		return ret;
> +	if (nh->type == ATOMIC_NOTIFIER)
> +		rcu_read_lock();
> +	else
> +		down_read(&nh->rwsem);

Is it possible for the value of nh->type to change?  If so, there needs
to be some additional mechanism to guard against such a change.  However,
if this field is constant, this code is just fine as is.

> +	nb = rcu_dereference(nh->head);
> +	while (nb) {
> +		ret = nb->notifier_call(nb, val, v);
> +		if ((ret & NOTIFY_STOP_MASK) == NOTIFY_STOP_MASK)
> +			goto done;
> +		nb = rcu_dereference(nb->next);
> +	}
> +done:
> +	if (nh->type == ATOMIC_NOTIFIER)
> +		rcu_read_unlock();
> +	else
> +		up_read(&nh->rwsem);
>  	return ret;
>  }
>  
> 
> -- 
> 
> ----------------------------------------------------------------------
>     Chandra Seetharaman               | Be careful what you choose....
>               - sekharan@us.ibm.com   |      .......you may get it.
> ----------------------------------------------------------------------
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. Download
> it for free - -and be entered to win a 42" plasma tv or your very own
> Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 
