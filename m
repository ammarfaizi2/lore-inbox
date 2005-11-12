Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVKLFVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVKLFVc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 00:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVKLFVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 00:21:32 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:10730 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932070AbVKLFVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 00:21:32 -0500
Date: Fri, 11 Nov 2005 21:22:13 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Chandra Seetharaman <sekharan@us.ibm.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Subject: [RFC][PATCH] Fix for unsafe notifier chain mechanism
Message-ID: <20051112052213.GB3335@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051112014421.GH1289@us.ibm.com> <Pine.LNX.4.44L0.0511112129090.13667-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0511112129090.13667-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 09:36:40PM -0500, Alan Stern wrote:
> On Fri, 11 Nov 2005, Paul E. McKenney wrote:
> 
> > On Fri, Nov 11, 2005 at 03:43:39PM -0800, Chandra Seetharaman wrote:
> > > Hello,
> > > 
> > > In 2.6.14, the notifier chains are unsafe. notifier_call_chain() walks through
> > > the list of a call chain without any protection.
> 
> > Looks pretty good!  Some RCU-related review comments interspersed below.
> > 
> > > Alan and I did think about changing the data structure to use list_head, but 
> > > deferred it (as a cleanup) as it is not directly tied with what Alan was
> > > trying to fix.
> > 
> > It would simplify the code...
> 
> It would.  It would also mean auditing every place in the kernel where a
> notifier_block structure is defined.  There are a _lot_ of them, and many
> don't use C99 initializers or do initialize the link pointer.  Chandra and
> I decided it was best to leave this as a subsequent cleanup job, maybe
> something suitable for kernel-janitors.

Fair enough by me!

> > > +	down_write(&nh->rwsem);
> > > +	nl = &nh->head;
> > > +	while ((*nl) != NULL) {
> > > +		if (n->priority > (*nl)->priority)
> > > +			break;
> > > +		nl = &((*nl)->next);
> > > +	}
> > > +	rcu_assign_pointer(n->next, *nl);
> > 
> > The above can simply be "n->next = *nl;".  The reason is that this change
> > of state is not visible to RCU readers until after the following statement,
> > and it therefore need not be an RCU-reader-safe assignment.  You only need
> > to use rcu_assign_pointer() when the results of the assignment are
> > immediately visible to RCU readers.
> 
> Correct, the rcu call isn't really needed.  It doesn't hurt perceptibly,
> though, and part of the RCU documentation states:
> 
>  * ...  More importantly, this
>  * call documents which pointers will be dereferenced by RCU read-side
>  * code.
> 
> For that reason, I felt it was worth putting it in.

But the following statement does a much better job of documenting the
pointer that is to be RCU-dereferenced.  Duplicate documentation can
be just as confusing as no documentation.

> > > +	rcu_assign_pointer(*nl, n);
> > > +	up_write(&nh->rwsem);
> > > +	if (nh->type == ATOMIC_NOTIFIER)
> > > +		synchronize_rcu();
> > 
> > This "if" statement and the "synchronize_rcu()" are not needed.  Nothing
> > has been removed from the list, so nothing will be freed, so no need to
> > wait for readers to get done.
> 
> You're right.  In an earlier form of the patch this call was left out, but
> then it crept back in later.  We can remove it.

Sounds good!

> > In contrast, the synchronize_rcu() in notifier_chain_unregister() -is-
> > needed, since we need to free the removed element.
> 
> > > +	if (!nh->head)
> > > +		return ret;
> > > +	if (nh->type == ATOMIC_NOTIFIER)
> > > +		rcu_read_lock();
> > > +	else
> > > +		down_read(&nh->rwsem);
> > 
> > Is it possible for the value of nh->type to change?  If so, there needs
> > to be some additional mechanism to guard against such a change.  However,
> > if this field is constant, this code is just fine as is.
> 
> nh->type is never supposed to change.

OK, then the code is fine as it is.

							Thanx, Paul
