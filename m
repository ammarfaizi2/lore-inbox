Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290240AbSAOSiH>; Tue, 15 Jan 2002 13:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290241AbSAOSh6>; Tue, 15 Jan 2002 13:37:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59818 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290235AbSAOShp>;
	Tue, 15 Jan 2002 13:37:45 -0500
Date: Tue, 15 Jan 2002 21:35:10 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [patch] O(1) scheduler, -I1
In-Reply-To: <Pine.LNX.4.40.0201150915590.1460-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201152022590.14517-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Jan 2002, Davide Libenzi wrote:

> >  - RT scheduling is broken.
>
> Why ?

RR tasks were queued to the expired array.

> [...] Ingo, IMHO is not correct to give time slices depending on
> priority and we should return to the old TS(nice) behavior.

i agree - but your new patch is broken still, you have the timeslice range
inverted(!) :-)

but never mind, i've fixed this and added the code to -I1, check it out
at:

    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-final-I1.patch

(for the record, i've tested -I1 on SMP and UP as well.)

-I1 also includes a fix from Dave Jones: mmu_context.h was still included
in arch/i386/kernel/process.c.

> [...] IMVHO is not correct to have new tasks to fully inherit parent
> priority because :

i fully agree - in -I0 i have kept the 'child gets 10% less priority than
parent' rule. This works really well in fork-bomb situations, i've tested
this with -I0. (and -I1 as well.) It also works well with interactive
shells, which want to start processes which will inherit *some* of their
parent's priority, but not all of it.

> 2) if an interactive task is born we do not need an immediate priority
> boost

Think about starting a simple 'ls' under X if under some high load. This
works just fine under 2.5.2-vanilla and 2.5.2-I0 as well. We should give
the task a chance to finish within ... 500 or 1000 msecs (or so), most
shell commands that fork do so.

> 3) if a cpu bound task born from an interactive task ( very very common )
> 	it'll make a long run on the cpu before falling in the hell of cpu
> 	bound tasks
>
> I've also decreased the minimum time slice to 10ms and increased the
> max to 160ms and this should cast back niced tasks to low cpu usages.

(i've done this already in -I0, based on earlier comments of yours.)

> I'm using it in my desk and just to have fun i keep running make -j20
> in background:-)

please re-test this with -I1. (i've tested it and it works just fine, but
more testing cannot hurt.)

are there any other items in your patch that are not yet in -I1?

	Ingo

