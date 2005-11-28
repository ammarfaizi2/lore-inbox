Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVK1S6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVK1S6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVK1S6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:58:14 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:54988 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932164AbVK1S6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:58:14 -0500
Subject: Re: [PATCH 0/7]: Fix for unsafe notifier chain
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       paulmck@us.ibm.com, kaos@sgi.com, greg@kroah.com,
       Douglas_Warzecha@dell.com, Abhay_Salunke@dell.com,
       achim_leubner@adaptec.com, dmp@davidmpye.dyndns.org
In-Reply-To: <20051126200741.421a342a.akpm@osdl.org>
References: <1132789071.9460.16.camel@linuxchandra>
	 <20051126200741.421a342a.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Date: Mon, 28 Nov 2005 10:58:10 -0800
Message-Id: <1133204291.9460.55.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-26 at 20:07 -0800, Andrew Morton wrote:
> Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> >
> > Andrew,
> > 
> > I posted this set of patch to lkml last Friday as an RFC. Can you
> > consider these for -mm inclusion.
> 
> This all looks exotically complex.
> 
> > ...
> > 
> > Here are the details:
> > In 2.6.14, notifier chains are unsafe. notifier_call_chain() walks through
> > the list of a call chain without any protection.
> > 
> > Alan Stern <stern@rowland.harvard.edu> brought the issue and suggested a fix
> > in lkml on Oct 24 2005:
> > 	http://marc.theaimsgroup.com/?l=linux-kernel&m=113018709002036&w=2
> > 
> > There was a lot of discussion on that thread regarding the issue, and
> > following were the conclusions about the requirements of the notifier
> > call mechanism:
> > 
> > 	- The chain list has to be protected in all the places where the
> > 	  list is accessed.
> > 	- We need a new notifier_head data structure to encompass the head 
> > 	  of the notifier chain and a semaphore that protects the list.
> > 	- There should be two types of call chains: one that is called in 
> > 	  a process context and another that is called in atomic/interrupt
> > 	  context.
> > 	- No lock should be acquired in notifier_call_chain() for an
> > 	  atomic-type chain.
> > 	- notifier_chain_register() and notifier_chain_unregister() should
> > 	  be called only from process context.
> > 	- notifier_chain_unregister() should _not_ be called from a
> > 	  callout routine.
> > 
> > I posted an RFC that meets the above listed requirements last Friday:
> > 	- http://marc.theaimsgroup.com/?l=linux-kernel&m=113175279131346&w=2
> > 	
> > Paul McKenney provided some suggestions w.r.t RCU usage. This patchset fixes
> > the issues he raised.  Keith Owens posted some changes to the diechain for
> > various architectures; his changes are included here.
> 
> - You don't state _why_ a callback cannot call
>   notifier_chain_unregister().  I assume that's because of the use of
>   write_lock() locking?

Yes. Also, for both type of notifiers we use semaphore to protect the
list, so we cannot call unregister from atomic context.

> 
>   We could do this with a new callback function return code and do it in
>   the core, or just change the code so it is permitted.

That is a good idea, we can do that.
> 
> - You don't explain why RCU has been introduced into this subsystem. 
>   Seems overkillish, or was it done as a way to solve the correctness
>   problems?

After discussions in lkml (and looking at usages of notifier chains in
code), the consensus was that we needed two types of notifier chains,
atomic and blocking.

During the discussions we concluded that blocking notifiers can be
easily protected with a semaphore. Locks is not good enough for atomic
notifiers as they are called from NMI context too. So, we needed a
lockless way to protect the list traversal, hence RCU.

> 
> - Generally, please don't put so much stuff into the [patch 0/N] email. 
>   We never put empty patches into git so some sucker has to move all the
>   [0/N] content into [1/N].  Better that it's you than me.

Will do.
> 
> - Overall take on the patches: the problem here is that notifier chains
>   try to provide their own locking.  Each time we design a container which
>   does that, we screw it up and we regret it.
> 

The problem is that the current notifier chain mechanism gives the
notion of protection (lock acquired in register/unregister), but does
not protect list traversal.
>   Please consider removing all locking from the notifer chains and moving
>   it into the callers.
> 
>   A migration path would be:
> 
>   - Introduce a new notifier API which is wholly unlocked
> 
>   - Migrate all callers over to that
> 
>   - Remove the current implementation

We can just remove the write_lock from register/unregister of current
implementation and it will do what you are suggesting. 

Also, with the current implementation, subsystems can assume that there
is no locks, but none of them do. They work around the locking/race
issues different ways like (1) not unregistering at all (most of them)
or having (2) their own _complete_ notify chain logic (usb).

(1) is a workaround and (2) is redundant code.

> 
>   Note that with this scheme, callbacks which wish to call the unregister
>   function can do that, as long as they are not using read_lock() or
>   down_read() during the chain traversal.
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


