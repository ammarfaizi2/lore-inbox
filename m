Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276675AbRJMH37>; Sat, 13 Oct 2001 03:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276591AbRJMH3t>; Sat, 13 Oct 2001 03:29:49 -0400
Received: from [202.135.142.195] ([202.135.142.195]:46350 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S276675AbRJMH3j>; Sat, 13 Oct 2001 03:29:39 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion 
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
        paul.mckenney@us.ibm.com
In-Reply-To: Your message of "Fri, 12 Oct 2001 09:56:58 PDT."
             <Pine.LNX.4.33.0110120948540.31692-100000@penguin.transmeta.com> 
Date: Sat, 13 Oct 2001 17:25:27 +1000
Message-Id: <E15sJAm-0005JL-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0110120948540.31692-100000@penguin.transmeta.com> you
 write:
> Yes. With maybe
> 
> 	non_preempt()
> 	..
> 	preempt()
> 
> around it for the pre-emption patches.

Sure, if they want pre-emption on SMP.  Of course, then they'll want
priority inheritence.

> However, you also need to make your free _free_ be aware of the count.
> Which means that the current RCU patch is really unusable for this. You
> need to have the "count" always in a generic place (put it with the hash),
> and your schedule-time free needs to do
> 
> 	if (atomic_read(&count))
> 		skip_this_do_it_next_time

WTF?  I'll spell it out for you again:

	static inline void foo_put(struct foo *foo)
	{
		if (atomic_dec_and_test(foo->use))
			kfree(foo);
	}

Write side normal:

	lock
	unhash(foo)
	unlock
	foo_put(foo)

Write side RCU:

	lock
	unhash(foo)
	unlock
	rcu_call(foo_put, foo);
		/* ie. call foo_put(foo) "later". */

That's all.  Really.

> Do that, and the RCU patches may start looking usable for the real world.

I know you're under strain, but think harder please.

Rusty.
--
Premature optmztion is rt of all evl. --DK
