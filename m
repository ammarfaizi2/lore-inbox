Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbVJaWXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbVJaWXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVJaWXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:23:04 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:40855 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751326AbVJaWXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:23:03 -0500
Subject: Re: Notifier chains are unsafe
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Keith Owens <kaos@ocs.com.au>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0510291024510.12207-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0510291024510.12207-100000@netrider.rowland.org>
Content-Type: text/plain
Organization: IBM
Date: Mon, 31 Oct 2005 14:22:57 -0800
Message-Id: <1130797377.3586.357.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-29 at 10:51 -0400, Alan Stern wrote:
> On Fri, 28 Oct 2005, Chandra Seetharaman wrote:
> 
> > On Fri, 2005-10-28 at 10:23 -0400, Alan Stern wrote:
> > > On Thu, 27 Oct 2005, Chandra Seetharaman wrote:
> > > 
> > > > So, requirements to fix the bug are:
> > > > 	- no sleeping in register/unregister(if we want to keep the
> > > >           current way of use. We can change it and make the relevant
> > > >           changes in the kernel code, if it is agreeable)
> > > 
> > > I think we will have to make these changes.  In principal it shouldn't be 
> > > hard to add a simple "enabled" flag to each callout which currently is
> > > registered/unregistered atomically or while running.  We could even put 
> > > such a flag into the notifier_block structure and add routines to set or 
> > > clear it, using appropriate barriers.
> > 
> > I do not understand the purpose of enabled flag. Can you clarify
> 
> Something like this:
> 
> struct notifier_block {
>         int (*notifier_call)(struct notifier_block *self, unsigned long,
>                 void *);
>         struct list_head node;
>         int priority;
> 	int enabled;
> };
> 
> int notifier_call_chain(struct notifier_head *nh, unsigned long val,
> void *v)
> {
>         int ret = 0;
>         notifier_block *b;
> 
>         if (list_empty(&nh->chain))     /* Optimize for common case */
>                 return ret;
> 
> 	smp_rmb();
>         list_for_each_entry(b, &nh->chain, node) {
> 		if (b->enabled) {
> 	                ret = b->notifier_call(b, val, v);
> 	                if (ret & NOTIFY_STOP_MASK)
> 	                        break;
> 		}
> 	}
> 
>         return ret;
> }
> 
> #define notifier_block_enable(b)	set_wmb((b)->enabled, 1)
> #define notifier_block_disable(b)	set_wmb((b)->enabled, 0)
> 

I am not getting the complete picture. So, in unregister we would just
disable and never delete the notifier_block ? Or
notifier_block_enable/disable will be used by external entities
directly ?

> 
> It occurred to me that there _is_ a way to do unregister for atomic chains 
> without blocking.  Add to struct notifier_head
> 
> 	atomic_t num_callers;
> 
> Then in notifier_call_chain, do atomic_inc(&nh->num_callers) at the start
> and atomic_dec(&nh->num_callers) at the end.  Finally, make unregister do
> this:
> 
> int notifier_chain_unregister(struct notifier_head *nh,
>         struct notifier_block *n)
> {
> 	if (nh->type == ATOMIC_NOTIFIER) {
> 	        spin_lock(nh->lock);
> 	        list_del(&n->node);
> 		smp_mb();
> 		while (atomic_read(&nh->num_callers) > 0)
> 			cpu_relax();
> 	        spin_unlock(nh->lock);
> 	} else {
> 	...
> 	}
>         return 0;
> }

But, how is the list protected in call_chain (will you be holding the
lock in call_chain() while incrementing the atomic variable).
 
> 
> I don't mean to suggest that this is better than using RCU, and with 
> notifier_block_disable it probably isn't needed.  However it is worth
> thinking about.
> 
> Alan Stern
> 
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


