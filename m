Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262819AbRE0RHh>; Sun, 27 May 2001 13:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262822AbRE0RH2>; Sun, 27 May 2001 13:07:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:36382 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262819AbRE0RHP>; Sun, 27 May 2001 13:07:15 -0400
Date: Sun, 27 May 2001 19:07:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] severe softirq handling performance bug, fix, 2.4.5
Message-ID: <20010527190700.H676@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0105261920030.3336-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105261920030.3336-200000@localhost.localdomain>; from mingo@elte.hu on Sat, May 26, 2001 at 07:59:28PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 07:59:28PM +0200, Ingo Molnar wrote:
> the two error cases are:
> 
>  #1 hard-IRQ interrupts user-space code, activates softirq, and returns to
>     user-space code

Before returning to userspace do_IRQ just runs do_softirq by hand from C
code.

>  #2 hard-IRQ interrupts the idle task, activates softirq and returns to
>     the idle task.

The problem only happens when we return to the idle task and a softirq
is been marked active again and we cannot keep running it or we risk to
soft deadlock.

I think the final fix for those issues (plus the case of a softirq
marking itself running all the time) is ksoftirqd, it lets the scheduler
to balance the softirq load, you can as well renice it. please try to
benchmark after applying it, it should solve all your troubles cleanly,
during tux load ksoftirq runs quite a lot btw:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5aa1/00_ksoftirqd-4

don't forget to apply this scheduler fix first, or your risk to run into
troubles:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5aa1/00_cpus_allowed-1

I also suggest to apply the other scheduler fixes like the sched_yield
and parent_timeslice too before running the test.

Andrea
