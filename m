Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbTLPF1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 00:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbTLPF1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 00:27:11 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:11532 "EHLO
	DYN320019.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S265063AbTLPF1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 00:27:04 -0500
Date: Mon, 15 Dec 2003 14:22:14 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Rusty Russell <rusty@au1.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [DOCUMENTATION] Revised Unreliable Kernel Locking Guide
Message-ID: <20031215222213.GA1270@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20031212193559.GA1614@us.ibm.com> <20031215060851.1882C189E1@ozlabs.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215060851.1882C189E1@ozlabs.au.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 04:17:47PM +1100, Rusty Russell wrote:
> In message <20031212193559.GA1614@us.ibm.com> you write:
> 
> > o	Software Interrupt / softirq: formatting botch "of'software".
> > 	This would be "o'software", right?
> 
> Looks ok here:
> 	Tasklets and softirqs both fall into the category of 'software interrupts'.

It was late and my eyes were tired.  Can't even blame it on
my browser!!!

> > o	Preemption: Would it be worth changing the first bit
> > 	of the second sentence to read something like: "In 2.5.4
> > 	and later, when CONFIG_PREEMPT is set, this changes:"?
> 
> I was trying to make it a little future-proof: I think CONFIG_PREEMPT
> should go away some day.

I hear you!  But I suspect that it may take quite some time for that day
to arrive.

> > Overzealous Prevention Of Deadlocks:  Cute!!!
> 
> This is untouched from the old version of the document.  I had a
> troubled youth...

;-)  Well, don't wring -all- of the fun out of the document!

> > Avoiding Locks: Read Copy Update
> > 
> > o	Might be worth noting explicitly early on that updaters are
> > 	running concurrently with readers.  Should be obvious given
> > 	that the readers aren't doing any explicit synchronization,
> > 	but I have run into confusion on this point surprisingly often.
> 
> OK.  Changed the second paragraph from:
> 
> 	How do we get rid of read locks?  That is actually quite simple:
> 
> to:
> 
> 	How do we get rid of read locks?  Getting rid of read locks
> 	means that writers may be changing the list underneath the readers.
> 	That is actually quite simple:

Looks good!  Upon rereading...  Does "wmb()" want to be "smp_wmb()"?

> > o	Please add a note to the list_for_each_entry_rcu() description
> > 	saying that writers (who hold appropriate locks) need not use
> > 	the _rcu() variant.
> 
> OK:
> 
>       Once again, there is a
>       <function>list_for_each_entry_rcu()</function>
>       (<filename>include/linux/list.h</filename>) to help you.  Of
>       course, writers can just use
>       <function>list_for_each_entry()</function>, since there cannot
>       be two simultaneous writers.

Also looks good!

Again, upon rereading, "read Read Copy Update code" probably wants to
be "real Read Copy Update code".   I moused it this time, given
my past record with eyeballing.  ;-)

> > o	If nothing blocks between the call to __cache_find() and the
> > 	eventual object_put(), it is worthwhile to avoid the
> > 	reference-count manipulation.  This would make all of
> > 	cache_find() be almost as fast as UP, rather than just
> > 	__cache_find().
> 
> Good point.  Text added at the bottom of that section:
> 
> <para>
> There is a furthur optimization possible here: remember our original
> cache code, where there were no reference counts and the caller simply
> held the lock whenever using the object?  This is still possible: if
> you hold the lock, noone can delete the object, so you don't need to
> get and put the reference count.
> </para>
> 
> <para>
> Now, because the 'read lock' in RCU is simply disabling preemption, a
> caller which always preemption disabled between calling
                      disables preemption
> <function>cache_find()</function> and
> <function>object_put()</function> does not need to actually get and
> put the reference count: we could expose
> <function>__cache_find()</function> by making it non-static, and
> such callers could simply call that.
> </para>
> <para>
> The benefit here is that the reference count is not written to: the
> object is not altered in any way, which is much faster on SMP
> machines due to caching.
> </para>

Other than the grammar nit above, looks good!

> I've uploaded a new draft with these and other fixes...

Good stuff, thank you!!!

						Thanx, Paul
