Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263141AbSIPVf5>; Mon, 16 Sep 2002 17:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSIPVf4>; Mon, 16 Sep 2002 17:35:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12296 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263141AbSIPVfz>; Mon, 16 Sep 2002 17:35:55 -0400
Date: Mon, 16 Sep 2002 14:41:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <1032210898.1010.32.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209161438220.3732-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Sep 2002, Robert Love wrote:
> 
> I liked this idea, and was working on implementing it when I ran into a
> few roadblocks.  Your ideas are welcome.
> 
> First, "preempt_count()" is used as an l-value in a lot of places, i.e.
> look at all the "preempt_count() += foo" in the IRQ code.  We cannot
> mask things out of it.

Ok. Let's just make the masking explicit in in_atomic() then, like you 
suggest:

> Simplest solution is to:
> 
> 	#define in_atomic() \
> 		(preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
> 
> although I still dislike the masking just to make the schedule()
> code-path cleaner.

I don't think this is a scheduler cleanliness issue: it's a consistency
issue. If "in_interrupt()" and friends do not care about PREEMPT_ACTIVE,
then neither should "in_atomic()".  The fact that the scheduler test gets
cleaned up is secondary - although it is obviously a result of being
consistent.

> Oh, and there is another problem: printk() from schedule() implicitly
> calls wake_up().  My machine dies even with just a printk() and not a
> BUG()... I suspect there may be some SMP issue in that whole mess too,
> because setting oops_in_progress prior did not help.

Hmm.. It will call wake_up() because it will try to wake up any klogd. 
What's the problem? Calling wake_up() should be fine from there..

		Linus

