Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWJQVVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWJQVVf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWJQVVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:21:35 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:43538 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750941AbWJQVVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:21:34 -0400
Date: Tue, 17 Oct 2006 17:21:33 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20061017201500.GI2062@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610171707170.3627-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006, Paul E. McKenney wrote:

> > Earlier I defined two separate kinds of orderings: "comes before" and
> > "sequentially precedes".  My "comes before" is essentially the same as
> > your "<v", applying only to accesses of the same variable.  You don't have
> > any direct analog to "sequentially precedes", which is perhaps a weakness:  
> > It will be harder for you to denote the effect of a load dependency on a
> > subsequent store.  My "sequentially precedes" does _not_ require the
> > accesses to be to the same variable, but it does require them to take
> > place on the same CPU.
> 
> This is similar to my ">p"/"<p" -- or was your "sequentially precedes"
> somehow taking effects of other CPUs into account.

It was taking the effect of memory barriers into account.  In the program
"load(A); store(B)" the load doesn't sequentially precede the store.  But
in the program "load(A); smp_mb(); store(B)" it does.  Similarly, in the
program "if (A) B = 2;" the load(A) sequentially precedes the store(B) --
thanks to the dependency or (if you prefer) the absence of speculative
stores.

Basically "sequentially precedes" means that any other CPU using the
appropriate memory barriers will observe the accesses apparently occurring
in this order.

> > >      My example formalism for a memory barrier says nothing about the
> > >      actual order in which the assignments to A and B occurred, nor about
> > >      the actual order in which the loads from A and B occurred.  No such
> > >      ordering is required to describe the action of the memory barrier.
> > 
> > Are you sure about that?  I would think it was implicit in your definition
> > of "<v".  Talking about the order of values in a variable during the past
> > isn't very different from talking about the order in which the
> > corresponding stores occurred.
> 
> My "<v" is valid only for a single variable.  A computer that reversed
> the order of execution of CPU 0's two assignments would be permitted,
> as long as the loads on CPU 1 and CPU 2 got the correct values.

Yes, I realize that.  But if several CPUs store values to the same
variable at about the same time, it's not at all clear which stores are
"<v" others.  Deciding this is tantamount to ordering all the stores to
that variable.

> > For that matter, the whole concept of "the value in a variable" is itself
> > rather fuzzy.  Even the sequence of values might not be well defined: If
> > you had some single CPU do nothing but repeatedly load the variable and
> > note its value, you could end up missing some of the values perceived by
> > other CPUs.  That is, it could be possible for CPU 0 to see A take on the
> > values 0,1,2 while CPU 1 sees only the values 0,2.
> 
> Heck, if you have a synchronized clock register with sufficient accuracy,
> you can catch different CPUs thinking that a given variable has different
> values at the same point in time.  ;-)

Exactly.  That's why I'm not too comfortable with your "<v" -- and I'm not 
completely certain of the validity of "comes before" either.  Hardly 
surprising, since they mean pretty much the same thing.

Alan

