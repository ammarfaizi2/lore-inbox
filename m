Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277742AbRJLSuA>; Fri, 12 Oct 2001 14:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277750AbRJLStu>; Fri, 12 Oct 2001 14:49:50 -0400
Received: from e23.nc.us.ibm.com ([32.97.136.229]:52893 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277742AbRJLSte>; Fri, 12 Oct 2001 14:49:34 -0400
Date: Sat, 13 Oct 2001 00:23:13 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        paul.mckenney@us.ibm.com
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011013002313.A30411@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20011012132733.75734399.rusty@rustcorp.com.au> <Pine.LNX.4.33.0110120948540.31692-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0110120948540.31692-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Oct 12, 2001 at 09:56:58AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 09:56:58AM -0700, Linus Torvalds wrote:
> 
> Yes. With maybe
> 
> 	non_preempt()
> 	..
> 	preempt()
> 
> around it for the pre-emption patches.

Yes. While in the read side, preemption will have to be disabled
to prevent local pointers being carried across context switches.
It isn't impossible to allow preemption, but that makes the
quiescent point detection logic much more complicated.

> 
> However, you also need to make your free _free_ be aware of the count.
> Which means that the current RCU patch is really unusable for this. You
> need to have the "count" always in a generic place (put it with the hash),
> and your schedule-time free needs to do
> 
> 	if (atomic_read(&count))
> 		skip_this_do_it_next_time
> 
> which starts getting complicated (it means your RCU free now has to have a
> notion of "next time" - just leaving the RCU active will slow down
> scheduling for as long as any reader holds on to an entry). So your
> unread() path probably has to be
> 
> 	if (atomic_dec_and_test(&count))
> 		free_it()
> 
> and the act of hashing should add a count and unhashing should delete a
> count (so that the reader doesn't free it while it is hashed).

Perhaps I am missing something here but shouldn't the refcount based 
schemes anyway have to do this with or without RCU ? If you do

	unhash
	if (atomic_dec_and_test(&count))
		free_it();

the isn't it that if refcount is not 0, sometime later it will have to be 
cleaned up by some garbage collection scheme ? Whatever that scheme is, 
it still needs to be made certain that the element is not back in the 
hash table.  It seems to me that with RCU the same logic can be made use of.
So instead of doing 

	if (atomic_dec_and_test(&count))
		rcu_free_it()

you may do 

	if (atomic_dec_and_test(&count))
		free_it();


where in free_it()

	if (atomic_read(&count))
		return;
	rcu_free_it();

Of course, there may be more complicated freeing schemes for which
we may need additional logic just like you suggested.

> 
> Do that, and the RCU patches may start looking usable for the real world.
> 

One RCU example for refcount + hash table is at
http://lse.sourceforge.net/locking/patches/rt_rcu-2.4.6-02.patch
(ipv4 route cache). 

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
