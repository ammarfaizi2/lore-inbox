Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTEVIir (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 04:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTEVIir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 04:38:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63892 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262584AbTEVIip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 04:38:45 -0400
Date: Thu, 22 May 2003 10:49:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] signal-latency-2.5.69-A1 
In-Reply-To: <200305212243.h4LMhYB09217@owlet.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0305221042220.4330-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 May 2003, Rick Lindsley wrote:

> This has shown some good results on our testing [...]

(do you have any numeric results?)

> [...] but it yielded a hang under some circumstances. I think I've
> located the problem.
> 
> When you decide to call resched_task(), you're holding a runqueue lock.
> I think this gets us into the same mess the mm stuff did a couple of
> months ago with IPIs.

It's perfectly safe to _generate_ an IPI from under the runqueue lock. We
do it in a number of cases, and did it for years. What precise hardware
did you run this on?

>     proc A				proc B
> 
>     grabs rq lock			tries to grab rq lock
>     rescheds a task on that rq		spins with interrupts disabled
>     sends IPI to all processors		<hangs>
>     <hangs>
>     releases lock

firstly, the IPI is not sent to all processors, it's sent to a single
target CPU. Secondly, where and why would the hang happen?

we do loop in one place in the x86 APIC code, apic_wait_icr_idle(). I
believe this should never loop indefinitely, unless the hw is broken.

> Holding the lock does two things: it allows us to set p's state to
> RUNNING, and insures our task_running() check is valid for more than an
> instant.  In the case of the call to resched_task(), the small window
> between unlocking the runqueue and calling resched_task() should be ok.
> If p is no longer running, there's no real harm done that I can see.

i dont disagree in theory with offloading the SMP-message sending outside
the critical section (it makes things more parallel, and the APIC message
itself goes asynchronously anyway), but i'd like to understand the precise
reason for the hang first. The current code should not hang.

	Ingo

