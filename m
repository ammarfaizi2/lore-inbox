Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbVKAPYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVKAPYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVKAPYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:24:40 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:9415 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750882AbVKAPYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:24:39 -0500
Date: Tue, 1 Nov 2005 10:24:37 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Chandra Seetharaman <sekharan@us.ibm.com>
cc: Keith Owens <kaos@ocs.com.au>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Notifier chains are unsafe
In-Reply-To: <1130797377.3586.357.camel@linuxchandra>
Message-ID: <Pine.LNX.4.44L0.0511011010350.5081-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Chandra Seetharaman wrote:

> > #define notifier_block_enable(b)      set_wmb((b)->enabled, 1)
> > #define notifier_block_disable(b)     set_wmb((b)->enabled, 0)
> 
> I am not getting the complete picture. So, in unregister we would just
> disable and never delete the notifier_block ? Or
> notifier_block_enable/disable will be used by external entities
> directly ?

Register and unregister will continue to work as before, requiring a
process context and the ability to sleep.  notifier_block_enable/disable
should be used when:

	a callout wants to disable itself as it is running, or

	someone running in an atomic context wants to enable or disable
	a callout.

In the first case, unregister can't be used because it would hang.  In the 
second case, register/unregister can't be used because they need to be 
able to sleep.

In both cases the notifier block would have to be registered beforehand 
and unregistered later.


> > It occurred to me that there _is_ a way to do unregister for atomic chains 
> > without blocking.  Add to struct notifier_head
> > 
> > 	atomic_t num_callers;
> > 
> > Then in notifier_call_chain, do atomic_inc(&nh->num_callers) at the start
> > and atomic_dec(&nh->num_callers) at the end.  Finally, make unregister do
> > this:
> > 
> > int notifier_chain_unregister(struct notifier_head *nh,
> >         struct notifier_block *n)
> > {
> > 	if (nh->type == ATOMIC_NOTIFIER) {
> > 	        spin_lock(nh->lock);
> > 	        list_del(&n->node);
> > 		smp_mb();
> > 		while (atomic_read(&nh->num_callers) > 0)
> > 			cpu_relax();
> > 	        spin_unlock(nh->lock);
> > 	} else {
> > 	...
> > 	}
> >         return 0;
> > }
> 
> But, how is the list protected in call_chain (will you be holding the
> lock in call_chain() while incrementing the atomic variable).

No; the list _won't_ be protected in call_chain.  It will be possible to
unregister a callout while the chain is in use.  That's how the RCU
approach works -- it uses no read locks, only write locks.

Deleting an entry while the list is in use is safe, because readers will
encounter either the old or the new value of the .next pointer, and either
one will be valid.  The important thing is to make sure that no one will
ever encounter the old pointer after unregister returns; that's what the
"while" loop is for.

Alan Stern

