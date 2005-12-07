Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbVLGXez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbVLGXez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbVLGXez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:34:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32661 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751824AbVLGXey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:34:54 -0500
Date: Wed, 7 Dec 2005 15:36:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: sekharan@us.ibm.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/7]: Fix for unsafe notifier chain
Message-Id: <20051207153612.0de2ce38.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512071441010.22006-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0512071441010.22006-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> A high percentage of the existing notifier chains are of the blocking sort
> (the callouts are allowed to sleep).  They are well served by a simple
> rw-semaphore, as in our patch.  It seems foolish to force the duplication
> of this locking code in all the places that would need it.
> 
> Likewise, the atomic-type chains (where the callouts must run in an atomic 
> context) are generally well served by the RCU mechanism, especially in 
> cases where callouts are never unregistered.
> 
> So I propose that, in addition to those two types of chains, we define a
> third type: raw notifiers.  These will be implemented with no protection
> at all.  No rw-semaphore, no spinlock, no RCU, no need to avoid
> self-unregistration, nothing -- all protection will be up to the users.  
> In other words, just what you asked for.
> 
> This gives us the best of both worlds.  The common cases can benefit from
> the centralized locking and protection, while anyone who has special needs
> can easily provide for them.
> 
> If you think this would be okay, I'll rewrite the notifier patch to 
> include the raw type.

The default version of notifier chains should be the lockless version -
just like list_head, radix_tree, etc.  (idr tries to provide its own
locking and has turned out to be a classic case of why we shouldn't do
that).

And sure, it makes sense to provide additional, higher-level data
structures and APIs which layer on top of that, purely as a code
consolidation exercise.  But they shouldn't be called notifier_chains. 
Call them notifier_chain_mutex_locked and notifier_chain_rwlocked and
notifier_chain_spinlocked or whatever.

As for the NMIs and RCU: I suspect it was simply a mistake to try to use
notifier chains for NMI registration in the first place - they are simply
too complex a data structure for this.  I think I previously suggested
removing that code and using just a fixed-size array of function pointers. 
But if the RCUified notifier chain solution is less-than-totally-gross then
that might be OK as well.
