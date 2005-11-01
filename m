Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVKAUUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVKAUUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVKAUUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:20:40 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:2762 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751118AbVKAUUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:20:39 -0500
Subject: Re: Notifier chains are unsafe
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0511011010350.5081-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0511011010350.5081-100000@iolanthe.rowland.org>
Content-Type: text/plain
Organization: IBM
Date: Tue, 01 Nov 2005 12:20:34 -0800
Message-Id: <1130876434.3586.378.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 10:24 -0500, Alan Stern wrote:
> On Mon, 31 Oct 2005, Chandra Seetharaman wrote:
> 
> > > #define notifier_block_enable(b)      set_wmb((b)->enabled, 1)
> > > #define notifier_block_disable(b)     set_wmb((b)->enabled, 0)
> > 
> > I am not getting the complete picture. So, in unregister we would just
> > disable and never delete the notifier_block ? Or
> > notifier_block_enable/disable will be used by external entities
> > directly ?
> 
> Register and unregister will continue to work as before, requiring a
> process context and the ability to sleep.  notifier_block_enable/disable
> should be used when:
> 
> 	a callout wants to disable itself as it is running, or
> 
> 	someone running in an atomic context wants to enable or disable
> 	a callout.
> 
> In the first case, unregister can't be used because it would hang.  In the 
> second case, register/unregister can't be used because they need to be 
> able to sleep.
> 
> In both cases the notifier block would have to be registered beforehand 
> and unregistered later.

I understand. Thanks for the explanation. I like the option below better
(no new interface).
> 
> 
> > > It occurred to me that there _is_ a way to do unregister for atomic chains 
> > > without blocking.  Add to struct notifier_head
> > > 
> > > 	atomic_t num_callers;
> > > 
> > > Then in notifier_call_chain, do atomic_inc(&nh->num_callers) at the start
> > > and atomic_dec(&nh->num_callers) at the end.  Finally, make unregister do
> > > this:
> > > 
> > > int notifier_chain_unregister(struct notifier_head *nh,
> > >         struct notifier_block *n)
> > > {
> > > 	if (nh->type == ATOMIC_NOTIFIER) {
> > > 	        spin_lock(nh->lock);
> > > 	        list_del(&n->node);
> > > 		smp_mb();
> > > 		while (atomic_read(&nh->num_callers) > 0)
> > > 			cpu_relax();
> > > 	        spin_unlock(nh->lock);
> > > 	} else {
> > > 	...
> > > 	}
> > >         return 0;
> > > }
> > 
> > But, how is the list protected in call_chain (will you be holding the
> > lock in call_chain() while incrementing the atomic variable).
> 
> No; the list _won't_ be protected in call_chain.  It will be possible to
> unregister a callout while the chain is in use.  That's how the RCU
> approach works -- it uses no read locks, only write locks.

but, list_del poisons the next pointer which is not good for a reader
that is walking through the list, we have to use list_del_rcu instead.

Also, do you think we have to use _rcu versions of list traversal
functions in call_chain ?
> 
> Deleting an entry while the list is in use is safe, because readers will
> encounter either the old or the new value of the .next pointer, and either
> one will be valid.  The important thing is to make sure that no one will
> ever encounter the old pointer after unregister returns; that's what the
> "while" loop is for.
>
> Alan Stern
> 
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


