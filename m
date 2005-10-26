Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbVJZWkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbVJZWkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 18:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbVJZWkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 18:40:40 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:58086 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751502AbVJZWkk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 18:40:40 -0400
Subject: Re: Notifier chains are unsafe
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Keith Owens <kaos@ocs.com.au>, Andi Kleen <ak@suse.de>,
       dipankar@in.ibm.com,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0510261037280.4957-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0510261037280.4957-100000@iolanthe.rowland.org>
Content-Type: text/plain
Organization: IBM
Date: Wed, 26 Oct 2005 15:40:33 -0700
Message-Id: <1130366433.3586.197.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 14:46 -0400, Alan Stern wrote:
> On Tue, 25 Oct 2005, Chandra Seetharaman wrote:
> 
> > Hi Alan,
> > 
> > I agree with your approach of having a notifier_head to have both the
> > head of the notifier_list and the corresponding lock (instead of having
> > a single global rwlock to protect all notifier lists).
> 
> It seems pretty clear that a separate notifier_head would be a good thing 
> to have, no matter what other changes are made.

Totally agree.

BTW, We have been discussing about "task_notifier" in lse-tech
(http://marc.theaimsgroup.com/?l=lse-tech&m=112908542104457&w=2). If we
have this basic notifier mechanism hardened enough, we could use this
notifier mechanism.

> 
> > But, I am confused about the need for three data structures and two next
> > pointers. I think we can achieve the same by 2 data structures:
> > 
> > 	notifier_head {
> > 		spinlock_t lock;
> > 		list_head  head;
> > 	};
> > 	notifier_block {
> > 		int (*notifier_call)(struct notifier_block *self,
> > 			unsigned long, void *);
> > 		list_head lists;
> > 		int priority;
> > 	};
> > 
> > I think that having multiple data structures make the code hard to
> > follow.
> > 
> > No. of register/unregister would be a lot lesser than a
> > notifier_call_chain() calls, so IMHO, rwlock would be a better option.	
> 
> But if you simply use an rwlock, and acquire the readlock during 
> notifier_call_chain, then you will hang when a notifier routine tries to 
> unregister itself while it is running.

I meant to say that instead of the simple spinlock we should use rwlock.

> >  notifier_call_chain() can
> > be called in any context, it must not take any locks.
> 
> It sounds like there really are two different types of notifier chains:
> 
>     (1) Chains that always run in process context, where the routines
> 	are allowed to sleep.
> 
>     (2) Chains that run in an atomic context, where the routines are
> 	not allowed to sleep.

IMO having two notifiers which differs only in the way mentioned above
would be confusing. Also, going through all the existing usages and
changing it to proper one could be little painful. 
> 
> Presumably only type 2 chains must not take any locks (although perhaps 
> you wouldn't object to them using a readlock?).  Evidently there's nothing
> wrong with a type 1 chain taking a lock.

Not true, the registered function could block. So, we cannot protect the
list in notifier_call_chain() using a lock that surrounds notifier_call.

> 
> It's a pity that there's no easy way to distinguish the two types of
> chains.  Solving these problems correctly will require using different
> code for the two types.
> 
> 
> On 26 Oct 2005, Andi Kleen wrote:
> 
> > If you add locks to the reader make sure it is only taken
> > if the list is non empty. Otherwise you will add unacceptable
> > overhead to some fast paths.
> 
> I don't understand this comment.  What point is there in avoiding a lock
> when the list is empty?  Did you mean that a lock should be taken only if
> the list _is_ empty?
> 
> > Better would be likely to use RCU.
> 
> Note that the RCU documentation says RCU critical sections are not allowed
> to sleep.
> 
> 
> The whole situation is a ridiculous mess.  Here are my current thoughts:
> 
> 	For sleepable chaine (type 1 above), the chain can be
> 	protected either by an rwsem or a mutex.  An rwsem is more
> 	friendly when several threads may want to use the chain
> 	simultaneously; a mutex allows (in principle) a routine
> 	to unregister itself as it runs.
> 
> 	For non-sleepable chains (type 2 above), it may be acceptable
> 	to protect the chain by an rwlock.  If performance is so
> 	important that no locks can be tolerated in notifier_call_chain
> 	then RCU could be used instead.
> 
> On the whole, it's probably best to disallow routines unregistering
> themselves as they run.  If a routine does want to do this, it can simply
> use a local "enabled" flag.  Instead of unregistering itself, it should
> just clear the flag -- and whenever it runs, it should simply return if
> the flag isn't set.  (Of course, the routine would then have to be 
> unregistered from somewhere else.)
> 
> I've listed four possible implementations.  The rwsem and RCU approaches
> seem to be the most widely applicable.  Even so, it will be necessary to
> go through and indicate, for each existing chain, which type it is.
> 
> Alan Stern
> 
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


