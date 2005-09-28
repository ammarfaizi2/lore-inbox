Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbVI1Ouu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbVI1Ouu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 10:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbVI1Ouu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 10:50:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:5773 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751019AbVI1Out (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 10:50:49 -0400
Date: Wed, 28 Sep 2005 07:51:10 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, suzannew@cs.pdx.edu,
       linux-kernel@vger.kernel.org, Robert.Olsson@data.slu.se,
       walpole@cs.pdx.edu, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20050928145110.GA4925@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050927.135626.88296134.davem@davemloft.net> <E1EKS6j-0006s4-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EKS6j-0006s4-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 12:55:45PM +1000, Herbert Xu wrote:
> David S. Miller <davem@davemloft.net> wrote:
> > 
> > I agree with the changes to add rcu_dereference() use.
> > Those were definitely lacking and needed.
> 
> Actually I'm not so sure that they are all needed.  I only looked
> at the very first one in the patch which is in in_dev_get().  That
> one certainly isn't necessary because the old value of ip_ptr
> is valid as long as the reference count does not hit zero.
> 
> The later is guaranteed by the increment in in_dev_get().
> 
> Because the pervasiveness of reference counting in the network stack,
> I believe that we should scrutinise the other bits in the patch too
> to make sure that they are all needed.
> 
> In general, using rcu_dereference/rcu_assign_pointer does not
> guarantee correct code.  We really need to look at each case
> individually.

Yep, these two APIs are only part of the solution.

The reference-count approach is only guaranteed to work if the kernel
thread that did the reference-count increment is later referencing that
same data element.  Otherwise, one has the following possible situation
on DEC Alpha:

o	CPU 0 initializes and inserts a new element into the data
	structure, using rcu_assign_pointer() to provide any needed
	memory barriers.  (Or, if RCU is not being used, under the
	appropriate update-side lock.)

o	CPU 1 acquires a reference to this new element, presumably
	using either a lock or rcu_read_lock() and rcu_dereference()
	in order to do so safely.  CPU 1 then increments the reference
	count.

o	CPU 2 picks up a pointer to this new element, but in a way
	that relies on the reference count having been incremented,
	without using locking, rcu_read_lock(), rcu_dereference(),
	and so on.

	This CPU can then see the pre-initialized contents of the
	newly inserted data structure (again, but only on DEC Alpha).

Again, if the same kernel thread that incremented the reference count
is later accessing it, no problem, even on Alpha.

							Thanx, Paul
