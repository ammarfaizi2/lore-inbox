Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVK0EIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVK0EIP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 23:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVK0EIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 23:08:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750837AbVK0EIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 23:08:14 -0500
Date: Sat, 26 Nov 2005 20:07:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: sekharan@us.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       paulmck@us.ibm.com, kaos@sgi.com, greg@kroah.com,
       Douglas_Warzecha@dell.com, Abhay_Salunke@dell.com,
       achim_leubner@adaptec.com, dmp@davidmpye.dyndns.org
Subject: Re: [PATCH 0/7]: Fix for unsafe notifier chain
Message-Id: <20051126200741.421a342a.akpm@osdl.org>
In-Reply-To: <1132789071.9460.16.camel@linuxchandra>
References: <1132789071.9460.16.camel@linuxchandra>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman <sekharan@us.ibm.com> wrote:
>
> Andrew,
> 
> I posted this set of patch to lkml last Friday as an RFC. Can you
> consider these for -mm inclusion.

This all looks exotically complex.

> ...
> 
> Here are the details:
> In 2.6.14, notifier chains are unsafe. notifier_call_chain() walks through
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
> 	- We need a new notifier_head data structure to encompass the head 
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
> I posted an RFC that meets the above listed requirements last Friday:
> 	- http://marc.theaimsgroup.com/?l=linux-kernel&m=113175279131346&w=2
> 	
> Paul McKenney provided some suggestions w.r.t RCU usage. This patchset fixes
> the issues he raised.  Keith Owens posted some changes to the diechain for
> various architectures; his changes are included here.

- You don't state _why_ a callback cannot call
  notifier_chain_unregister().  I assume that's because of the use of
  write_lock() locking?

  We could do this with a new callback function return code and do it in
  the core, or just change the code so it is permitted.

- You don't explain why RCU has been introduced into this subsystem. 
  Seems overkillish, or was it done as a way to solve the correctness
  problems?

- Generally, please don't put so much stuff into the [patch 0/N] email. 
  We never put empty patches into git so some sucker has to move all the
  [0/N] content into [1/N].  Better that it's you than me.

- Overall take on the patches: the problem here is that notifier chains
  try to provide their own locking.  Each time we design a container which
  does that, we screw it up and we regret it.

  Please consider removing all locking from the notifer chains and moving
  it into the callers.

  A migration path would be:

  - Introduce a new notifier API which is wholly unlocked

  - Migrate all callers over to that

  - Remove the current implementation

  Note that with this scheme, callbacks which wish to call the unregister
  function can do that, as long as they are not using read_lock() or
  down_read() during the chain traversal.
