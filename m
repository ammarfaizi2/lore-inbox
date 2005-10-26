Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVJZSqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVJZSqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 14:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVJZSqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 14:46:13 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:56257 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964857AbVJZSqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 14:46:13 -0400
Date: Wed, 26 Oct 2005 14:46:11 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Chandra Seetharaman <sekharan@us.ibm.com>, Keith Owens <kaos@ocs.com.au>,
       Andi Kleen <ak@suse.de>, <dipankar@in.ibm.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Notifier chains are unsafe
In-Reply-To: <1130283036.3586.148.camel@linuxchandra>
Message-ID: <Pine.LNX.4.44L0.0510261037280.4957-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2005, Chandra Seetharaman wrote:

> Hi Alan,
> 
> I agree with your approach of having a notifier_head to have both the
> head of the notifier_list and the corresponding lock (instead of having
> a single global rwlock to protect all notifier lists).

It seems pretty clear that a separate notifier_head would be a good thing 
to have, no matter what other changes are made.

> But, I am confused about the need for three data structures and two next
> pointers. I think we can achieve the same by 2 data structures:
> 
> 	notifier_head {
> 		spinlock_t lock;
> 		list_head  head;
> 	};
> 	notifier_block {
> 		int (*notifier_call)(struct notifier_block *self,
> 			unsigned long, void *);
> 		list_head lists;
> 		int priority;
> 	};
> 
> I think that having multiple data structures make the code hard to
> follow.
> 
> No. of register/unregister would be a lot lesser than a
> notifier_call_chain() calls, so IMHO, rwlock would be a better option.	

But if you simply use an rwlock, and acquire the readlock during 
notifier_call_chain, then you will hang when a notifier routine tries to 
unregister itself while it is running.

See below for more options...

> <snip>

> Since the lock is being dropped while calling notifier_call, how are we
> guaranteed caller.next is valid ? It might have been unregistered.

You are right.  I should have realized that; it's an embarassing mistake.


On Wed, 26 Oct 2005, Keith Owens wrote:

> Register and unregister should only be called from contexts that can
> sleep, although that may not be documented.

I'm willing to take your word for it.  However, if it isn't documented 
then how can you be sure that all callers are doing it correctly?  Note 
that the code doesn't even contain a might_sleep()!

>  notifier_call_chain() can
> be called in any context, it must not take any locks.

It sounds like there really are two different types of notifier chains:

    (1) Chains that always run in process context, where the routines
	are allowed to sleep.

    (2) Chains that run in an atomic context, where the routines are
	not allowed to sleep.

Presumably only type 2 chains must not take any locks (although perhaps 
you wouldn't object to them using a readlock?).  Evidently there's nothing
wrong with a type 1 chain taking a lock.

It's a pity that there's no easy way to distinguish the two types of
chains.  Solving these problems correctly will require using different
code for the two types.


On 26 Oct 2005, Andi Kleen wrote:

> If you add locks to the reader make sure it is only taken
> if the list is non empty. Otherwise you will add unacceptable
> overhead to some fast paths.

I don't understand this comment.  What point is there in avoiding a lock
when the list is empty?  Did you mean that a lock should be taken only if
the list _is_ empty?

> Better would be likely to use RCU.

Note that the RCU documentation says RCU critical sections are not allowed
to sleep.


The whole situation is a ridiculous mess.  Here are my current thoughts:

	For sleepable chaine (type 1 above), the chain can be
	protected either by an rwsem or a mutex.  An rwsem is more
	friendly when several threads may want to use the chain
	simultaneously; a mutex allows (in principle) a routine
	to unregister itself as it runs.

	For non-sleepable chains (type 2 above), it may be acceptable
	to protect the chain by an rwlock.  If performance is so
	important that no locks can be tolerated in notifier_call_chain
	then RCU could be used instead.

On the whole, it's probably best to disallow routines unregistering
themselves as they run.  If a routine does want to do this, it can simply
use a local "enabled" flag.  Instead of unregistering itself, it should
just clear the flag -- and whenever it runs, it should simply return if
the flag isn't set.  (Of course, the routine would then have to be 
unregistered from somewhere else.)

I've listed four possible implementations.  The rwsem and RCU approaches
seem to be the most widely applicable.  Even so, it will be necessary to
go through and indicate, for each existing chain, which type it is.

Alan Stern

