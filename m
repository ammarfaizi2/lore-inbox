Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136663AbREAQ45>; Tue, 1 May 2001 12:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136662AbREAQ4r>; Tue, 1 May 2001 12:56:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:32048 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136657AbREAQ4l>; Tue, 1 May 2001 12:56:41 -0400
Date: Tue, 1 May 2001 18:55:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.4 sluggish under fork load
Message-ID: <20010501185517.A31373@athlon.random>
In-Reply-To: <20010430195149.F19620@athlon.random> <Pine.LNX.4.21.0104302335490.19012-100000@imladris.rielhome.conectiva> <20010501071849.A16474@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010501071849.A16474@athlon.random>; from andrea@suse.de on Tue, May 01, 2001 at 07:18:49AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 07:18:49AM +0200, Andrea Arcangeli wrote:
> I'm running with this below patch applied since a some time (I didn't
> submitted it because for some reason unless I do p->policy &=
> ~SCHED_YIELD ksoftirqd deadlocks at boot and I didn't yet investigated
> why, and I'd like to have the whole picture on it first):

OK I found the explanation now. The reason ksoftirqd was deadlocking on
me without the explicit clear of SCHED_YIELD in p->policy is because a
softirq event was pending at the time of the first kernel_thread() and
then while returning from the syscall it was so taking the ret_from_irq
path that skips the reschedule [which was supposed to clear the
sched_yield and to reschedule the child] because CS was pointing to the
kernel descriptor. So init then runs with SCHED_YIELD set and when it
executes kernel_thread(ksoftirqd) also ksoftirqd inherit SCHED_YIELD set
too (copied at top of do_fork) and it never gets scheduled -> deadlock.

Basically there's no guarantee that any kernel_thread will return with
SCHED_YIELD cleared.

And if you fork off a child with its p->policy SCHED_YIELD set it will
never get scheduled in.

Only "just" running tasks can have SCHED_YIELD set.

So the below lines are the *right* and most robust approch as far I can
tell. (plus counter needs to be volatile, as every variable that can
change under the C code, even while it's probably not required by the
code involved with current->counter)

> +	{
> +		int counter = current->counter >> 1;
> +		current->counter = p->counter = counter;
> +		p->policy &= ~SCHED_YIELD;
> +		current->policy |= SCHED_YIELD;
> +		current->need_resched = 1;
> +	}

Alan, the patch you merged in 2.4.4ac2 can fail like mine, but it may fail in
a much more subtle way, while I notice if ksoftirqd never get scheduled
because I synchronize on it and I deadlock, your kupdate/bdflush/kswapd
may be forked off correctly but they can all have SCHED_YIELD set and
they will *never* get scheduled. You know what can happen if kupdate
never gets scheduled... I recommend to be careful with 2.4.4ac2.

My patch (part of it quoted above) is the right replacement for the code
in 2.4.4ac2 (you may want to do `counter = current->counter + 1 >> 1'
tricks additionally to that, I will change it a bit too for that minor
part.

Andrea
