Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbVLGUMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVLGUMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 15:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbVLGUMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 15:12:23 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:16516 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751678AbVLGUMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 15:12:22 -0500
Date: Wed, 7 Dec 2005 15:12:20 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Chandra Seetharaman <sekharan@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/7]: Fix for unsafe notifier chain
Message-ID: <Pine.LNX.4.44L0.0512071441010.22006-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew:

I wasn't on the CC: list for parts of this conversation, so I'm a little 
behind-hand.  But Chandra is off on vacation now, and he asked me to 
continue pursuing this.

On November 27, 2005, Andrew Morton wrote:

> This all looks exotically complex.
> 
> > ...
> > 
> > Here are the details:
> > In 2.6.14, notifier chains are unsafe. notifier_call_chain() walks through
> > the list of a call chain without any protection.

...

> - You don't state _why_ a callback cannot call
>   notifier_chain_unregister().  I assume that's because of the use of
>   write_lock() locking?

Yes, that's part of it.

>   We could do this with a new callback function return code and do it in
>   the core, or just change the code so it is permitted.

I don't think that could be made to work.  The new unregister routine
guarantees that when it returns, the callout is not running on any
processor and will not be invoked.  Clearly this guarantee is necessary
when unregistering a callout that's part of a module about to be unloaded.  
Equally clearly, the guarantee cannot be met when a callout tries to
unregister itself.

On the other hand, this is a very minor issue.  We identified only two
callout routines that want to unregister themselves, both on the reboot
notifier chain.  It's simple to work around the self-unregistration, and
one of the patches in our series (5 of 7) did just that.  That patch alone
is harmless, and in fact it could be accepted independently of the rest of
our changes.

> - You don't explain why RCU has been introduced into this subsystem. 
>   Seems overkillish, or was it done as a way to solve the correctness
>   problems?

[Chandra may have explained this already; if so please forgive the
repetition.]  At least one notifier chain is invoked inside an NMI
handler, so normal locking can't be used with it.  RCU seems like an ideal
way to handle such cases.

The RCU overhead in our patches is really very small.  It amounts to a 
preempt_disable in notifier_call_chain, together with a few memory 
barriers and a call to synchronize_rcu in notifier_unregister.

The memory barriers are necessary even without RCU; they are the same as 
the ones Andi put in his proposed patch.  So the only noticeable overhead 
is in the unregister routine, which runs very infrequently.  (Andi's patch 
explicitly ignores the problems raised by unregistration.)

> - Overall take on the patches: the problem here is that notifier chains
>   try to provide their own locking.  Each time we design a container which
>   does that, we screw it up and we regret it.
> 
>   Please consider removing all locking from the notifer chains and moving
>   it into the callers.

That's a good point.  Would you accept a compromise solution?

A high percentage of the existing notifier chains are of the blocking sort
(the callouts are allowed to sleep).  They are well served by a simple
rw-semaphore, as in our patch.  It seems foolish to force the duplication
of this locking code in all the places that would need it.

Likewise, the atomic-type chains (where the callouts must run in an atomic 
context) are generally well served by the RCU mechanism, especially in 
cases where callouts are never unregistered.

So I propose that, in addition to those two types of chains, we define a
third type: raw notifiers.  These will be implemented with no protection
at all.  No rw-semaphore, no spinlock, no RCU, no need to avoid
self-unregistration, nothing -- all protection will be up to the users.  
In other words, just what you asked for.

This gives us the best of both worlds.  The common cases can benefit from
the centralized locking and protection, while anyone who has special needs
can easily provide for them.

If you think this would be okay, I'll rewrite the notifier patch to 
include the raw type.

Alan Stern

