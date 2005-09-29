Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVI2QDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVI2QDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVI2QDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:03:23 -0400
Received: from iron.cat.pdx.edu ([131.252.208.92]:44754 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S932213AbVI2QDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:03:22 -0400
Date: Thu, 29 Sep 2005 09:02:29 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200509291602.j8TG2TuI015920@rastaban.cs.pdx.edu>
To: paulmck@us.ibm.com
Cc: Robert.Olsson@data.slu.se, davem@davemloft.net,
       herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, suzannew@cs.pdx.edu, walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The original motivation for this patch was in __in_dev_get 
usage.  I'll try to test a build, but should submittals be 
incremental? first addressing in_dev_get, then 
__in_dev_get?  What seems resolved so far follows.

The exchange below suggests that it is equally important 
to have the rcu_dereference() in __in_dev_get(), so the 
idea of the only difference between in_dev_get and 
__in_dev_get being the refcnt may be accepted.

Correct usage may be a question with the mismatched 
definitions (in terms of refcnt) of __in_dev_get() 
and __in_dev_put() that superficially appear 
paired and this may merit a comment.  If interested, 
examples are mentioned in 
www.uwsg.iu.edu/hypermail/linux/kernel/0509.1/0184.html
and
www.ussg.iu.edu/hypermail/linux/kernel/0509.3/0757.html

But when the refcnt is employed for the DEC Alpha, 
rcu-protection or other locking must be in place for 
multiple CPUs, which apparently affirms the value 
of the marking of an rcu read-side critical section 
done by the calling function which has the vision of the 
extent of use of the protected dereference.

Is this all reasonable to you?
Thank you very much.

----- Original Message ----- 
From: Paul E. McKenney
Sent: Wednesday, September 28, 2005 7:51 AM


> On Wed, Sep 28, 2005 at 12:55:45PM +1000, Herbert Xu wrote:
>> David S. Miller wrote:
>> > 
>> > I agree with the changes to add rcu_dereference() use.
>> > Those were definitely lacking and needed.
>> 
>> Actually I'm not so sure that they are all needed.  I only looked
>> at the > guarantee correct code.  We really need to look at each case
>> individually.
> 
> Yep, these two APIs are only part of the solution.
> 
> The reference-count approach is only guaranteed to work if the kernel
> thread that did the reference-count increment is later referencing that
> same data element.  Otherwise, one has the following possible situation
> on DEC Alpha:
> 
> o CPU 0 initializes and inserts a new element into the data
> structure, using rcu_assign_pointer() to provide any needed
> memory barriers.  (Or, if RCU is not being used, under the
> appropriate update-side lock.)
> 
> o CPU 1 acquires a reference to this new element, presumably
> using either a lock or rcu_read_lock() and rcu_dereference()
> in order to do so safely.  CPU 1 then increments the reference
> count.
> 
> o CPU 2 picks up a pointer to this new element, but in a way
> that relies on the reference count having been incremented,
> without using locking, rcu_read_lock(), rcu_dereference(),
> and so on.
> 
> This CPU can then see the pre-initialized contents of the
> newly inserted data structure (again, but only on DEC Alpha).
> 
> Again, if the same kernel thread that incremented the reference count
> is later accessing it, no problem, even on Alpha.
> 
> Thanx, Paul
>

