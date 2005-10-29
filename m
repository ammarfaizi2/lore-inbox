Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVJ2Ovo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVJ2Ovo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVJ2Ovo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:51:44 -0400
Received: from mx1.rowland.org ([192.131.102.7]:11525 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751171AbVJ2Ovn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:51:43 -0400
Date: Sat, 29 Oct 2005 10:51:35 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Chandra Seetharaman <sekharan@us.ibm.com>
cc: Keith Owens <kaos@ocs.com.au>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Notifier chains are unsafe
In-Reply-To: <1130537749.3586.336.camel@linuxchandra>
Message-ID: <Pine.LNX.4.44L0.0510291024510.12207-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2005, Chandra Seetharaman wrote:

> On Fri, 2005-10-28 at 10:23 -0400, Alan Stern wrote:
> > On Thu, 27 Oct 2005, Chandra Seetharaman wrote:
> > 
> > > So, requirements to fix the bug are:
> > > 	- no sleeping in register/unregister(if we want to keep the
> > >           current way of use. We can change it and make the relevant
> > >           changes in the kernel code, if it is agreeable)
> > 
> > I think we will have to make these changes.  In principal it shouldn't be 
> > hard to add a simple "enabled" flag to each callout which currently is
> > registered/unregistered atomically or while running.  We could even put 
> > such a flag into the notifier_block structure and add routines to set or 
> > clear it, using appropriate barriers.
> 
> I do not understand the purpose of enabled flag. Can you clarify

Something like this:

struct notifier_block {
        int (*notifier_call)(struct notifier_block *self, unsigned long,
                void *);
        struct list_head node;
        int priority;
	int enabled;
};

int notifier_call_chain(struct notifier_head *nh, unsigned long val,
void *v)
{
        int ret = 0;
        notifier_block *b;

        if (list_empty(&nh->chain))     /* Optimize for common case */
                return ret;

	smp_rmb();
        list_for_each_entry(b, &nh->chain, node) {
		if (b->enabled) {
	                ret = b->notifier_call(b, val, v);
	                if (ret & NOTIFY_STOP_MASK)
	                        break;
		}
	}

        return ret;
}

#define notifier_block_enable(b)	set_wmb((b)->enabled, 1)
#define notifier_block_disable(b)	set_wmb((b)->enabled, 0)


It occurred to me that there _is_ a way to do unregister for atomic chains 
without blocking.  Add to struct notifier_head

	atomic_t num_callers;

Then in notifier_call_chain, do atomic_inc(&nh->num_callers) at the start
and atomic_dec(&nh->num_callers) at the end.  Finally, make unregister do
this:

int notifier_chain_unregister(struct notifier_head *nh,
        struct notifier_block *n)
{
	if (nh->type == ATOMIC_NOTIFIER) {
	        spin_lock(nh->lock);
	        list_del(&n->node);
		smp_mb();
		while (atomic_read(&nh->num_callers) > 0)
			cpu_relax();
	        spin_unlock(nh->lock);
	} else {
	...
	}
        return 0;
}

I don't mean to suggest that this is better than using RCU, and with 
notifier_block_disable it probably isn't needed.  However it is worth
thinking about.

Alan Stern

