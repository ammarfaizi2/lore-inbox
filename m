Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289285AbSAIJOV>; Wed, 9 Jan 2002 04:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289286AbSAIJOL>; Wed, 9 Jan 2002 04:14:11 -0500
Received: from dsl-213-023-043-044.arcor-ip.net ([213.23.43.44]:35853 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289285AbSAIJNy>;
	Wed, 9 Jan 2002 04:13:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Wed, 9 Jan 2002 10:17:01 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <E16O3L5-0000B8-00@starship.berlin> <3C3B70D7.43786888@zip.com.au>
In-Reply-To: <3C3B70D7.43786888@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16OEr0-0000DR-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 8, 2002 11:21 pm, Andrew Morton wrote:
> Daniel Phillips wrote:
> > The preemptible kernel can reschedule, on average, sooner than the
> > scheduling-point kernel, which has to wait for a scheduling point to roll
> > around.
> 
> Yes.  It can also fix problematic areas which my testing
> didn't cover.

I bet, with a minor hack, it can help you *find* those problem areas too.  
You compile the two patches together and automatically log any event along 
with the execution address, where your explicit schedule points failed to 
reschedule in time.  Sort of like a profile but suited exactly to your 
problem.

This just detects the problem areas in normal kernel execution, not 
spinlocks, but that is probably where most of the maintainance will be anyway.

By the way, did you check for latency in directory operations?

> Incidentally, there's the SMP problem.  Suppose we
> have the code:
> 
> 	lock_kernel();
> 	for (lots) {
> 		do(something sucky);
> 		if (current->need_resched)
> 			schedule();
> 	}
> 	unlock_kernel();
> 
> This works fine on UP, but not on SMP.  The scenario:
> 
> - CPU A runs this loop.
> 
> - CPU B is spinning on the lock.
> 
> - Interrupt occurs, kernel elects to run RT task on CPU B.
>   CPU A doesn't have need_resched set, and just keeps 
>   on going.  CPU B is stuck spinning on the lock.
> 
> This is only an issue for the low-latency patch - all the
> other approaches still have sufficiently bad worse-case that
> this scenario isn't worth worrying about.
> 
> I toyed with creating spin_lock_while_polling_resched(),
> but ended up changing the scheduler to set need_resched
> against _all_ CPUs if an RT task is being woken (yes, yuk).

Heh, subtle.  Thanks for pointing that out and making my head hurt.

--
Daniel
