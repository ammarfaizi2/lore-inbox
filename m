Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270521AbRHHQmR>; Wed, 8 Aug 2001 12:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270522AbRHHQmH>; Wed, 8 Aug 2001 12:42:07 -0400
Received: from [63.209.4.196] ([63.209.4.196]:41988 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270521AbRHHQl5>; Wed, 8 Aug 2001 12:41:57 -0400
Date: Wed, 8 Aug 2001 09:40:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Kravetz <mkravetz@sequent.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Scalable Scheduling
In-Reply-To: <20010808091652.B1088@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0108080929170.1530-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Aug 2001, Mike Kravetz wrote:
>
> I have been working on scheduler scalability.  Specifically,
> the concern is running Linux on bigger machines (higher CPU
> count, SMP only for now).

Note that there is no way I will ever apply this particular patch for a
very simple reason: #ifdef's in code.

Why do you have things like

	#ifdef CONFIG_SMP
		.. use nr_running() ..
	#else
		.. use nr_running ..
	#endif

and

	#ifdef CONFIG_SMP
	       list_add(&p->run_list, &runqueue(task_to_runqueue(p)));
	#else
	       list_add(&p->run_list, &runqueue_head);
	#endif

when it just shows that you did NOT properly abstract your thinking to
realize that the non-SMP case should be the same as the SMP case with 1
CPU (+ optimization).

I find code like the above physically disgusting.

What's wrong with using

	nr_running()

unconditionally, and make sure that it degrades gracefully to just the
single-CPU case?

What's wrong whit just using

	runqueue(task_to_runqueue(p))

and having the UP case realize that the "runqueue()" macro is a fixed
entry?

Same thing applies to that runqueue_lock stuff. That is some of the
ugliest code I've seen in a long time. Please use inline functions, sane
defines that work both ways, and take advantage of the fact that gcc will
optimize constant loops and numbers (it's ok to reference arrays in UP
with "array[smp_processor_id()]", and it's ok to have loops that look like
"for (i = 0; i < NR_CPUS; i++)" that will do the right thing on UP _and_
SMP.

And make your #ifdef's be _outside_ the code.

I hate code that has #ifdef's. It's a magjor design mistake, and shows
that the person who coded it didn't think of it as _one_ problem, but as
two.

So please spend some time cleaning it up, I can't look at it like this.

		Linus

