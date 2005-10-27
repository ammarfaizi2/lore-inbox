Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVJ0Unq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVJ0Unq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVJ0Unq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:43:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:16054 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932227AbVJ0Unp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:43:45 -0400
Subject: Re: Notifier chains are unsafe
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Keith Owens <kaos@ocs.com.au>, Andi Kleen <ak@suse.de>,
       dipankar@in.ibm.com,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0510271018300.4891-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0510271018300.4891-100000@iolanthe.rowland.org>
Content-Type: text/plain
Organization: IBM
Date: Thu, 27 Oct 2005 13:43:40 -0700
Message-Id: <1130445820.3586.263.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 11:28 -0400, Alan Stern wrote:
> On Wed, 26 Oct 2005, Chandra Seetharaman wrote:
> 
> > > It seems pretty clear that a separate notifier_head would be a good thing 
> > > to have, no matter what other changes are made.
> > 
> > Totally agree.
> 
> > > It sounds like there really are two different types of notifier chains:
> > > 
> > >     (1) Chains that always run in process context, where the routines
> > > 	are allowed to sleep.
> > > 
> > >     (2) Chains that run in an atomic context, where the routines are
> > > 	not allowed to sleep.
> > 
> > IMO having two notifiers which differs only in the way mentioned above
> > would be confusing. Also, going through all the existing usages and
> > changing it to proper one could be little painful. 
>    
> It would be less confusing than the state we're in now!  The difference
> between the two types of notifiers would be very analogous to the
> difference between semaphores and spinlocks, which IMO isn't confusing at 
> all.
> 
> I agree that updating all the existing definitions would be a little
> painful.  However, adding a new notifier_head will require doing those 
> updates anyway.

That change would be minimal, one have only change the place from which
the notify_register is called.

Whereas if we change it to become two types one has to go through the
corresponding callouts (and the functions they call and so on) to see
which (BLOCKING or ATOMIC) notifier mechanism to use.

> 
> > > Presumably only type 2 chains must not take any locks (although perhaps 
> > > you wouldn't object to them using a readlock?).  Evidently there's nothing
> > > wrong with a type 1 chain taking a lock.
> > 
> > Not true, the registered function could block. So, we cannot protect the
> > list in notifier_call_chain() using a lock that surrounds notifier_call.
> 
> Sorry, I meant to say there's nothing wrong with a type 1 chain taking a 
> semaphore.
> 
> 
> What do you think of the untested patch below?

Functionally looks good. But there are two problems w.r.t interface
changes:
    1. above mentioned problem of making sure of all the places to use
       the proper one.
    2. Requiring register and unregister to be able to sleep. (there are
       few usages that are called with a lock held)

How does the following code look (only change w.r.t the existing usage
model is that unregister can now return -EAGAIN, if the list is busy).

One assumption the following code makes is that the store of a pointer
(next in the list) is atomic. If that assumption is unacceptable, we can
do one of two things:
    1. change notify_register to return -EAGAIN if list is busy.
    2. move the chain list in call_chain under lock and use that
       list instead of using the chain in the head, and restore it back
       before returning.
 
==================================================
struct notifier_head {
	spinlock_t lock; /* protects both chain and readers below */
	struct list_head chain; /* chain of notifier blocks */
	int readers; /* current no. of readers of the chain */
};

struct notifier_block {
	int (*notifier_call)(struct notifier_block *self, unsigned long,
		void *);
	struct list_head node;
	int priority;
};

int notifier_chain_register(struct notifier_head *nh,
				struct notifier_block *n)
{
	spin_lock(nh->lock);
	list_for_each_rcu(pos, &nh->chain) {
		b = list_entry(pos, struct notifier_block, node);
		if (n->priority > b->priority)
			break;
	}
	list_add_tail(&n->node, pos);
	spin_unlock(nh->lock);
	return 0;
}

int notifier_chain_unregister(struct notifier_head *nh,
	struct notifier_block *n)
{
	int rc = 0;
	spin_lock(nh->lock);
	if (nh->readers == 0)
		list_del(&n->node);
	else
		rc = -EAGAIN;
	spin_unlock(nh->lock);
	return rc;
}
	
int notifier_call_chain(struct notifier_head *nh, unsigned long val,
void *v)
{
	int ret = 0;
	list_head *cur ;
	notifier_block *b, *tmp;

	spin_lock(nh->lock);
	nh->readers++;
	spin_unlock(nh->lock);
	
	if (list_empty(&nh->chain))	/* Optimize for common case */
		return ret;

	list_for_each_entry_safe(b, tmp, &nh->chain, node) {
		ret = b->notifier_call(b, val, v);
		if (ret & NOTIFY_STOP_MASK)
			goto done;
	} while (cur != &nh->chain);

done:
	spin_lock(nh->lock);
	nh->readers--; /* is locking really needed ? */
	spin_unlock(nh->lock);
	return ret;
}
=================================================================

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


