Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136510AbRD3RyI>; Mon, 30 Apr 2001 13:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136511AbRD3Rx6>; Mon, 30 Apr 2001 13:53:58 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:17476 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136510AbRD3Rxp>; Mon, 30 Apr 2001 13:53:45 -0400
Date: Mon, 30 Apr 2001 19:51:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 sluggish under fork load
Message-ID: <20010430195149.F19620@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0104281928080.10759-100000@penguin.transmeta.com> <Pine.LNX.4.33.0104291017370.2060-100000@ppro.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0104291017370.2060-100000@ppro.localdomain>; from peter.osterlund@mailbox.swipnet.se on Sun, Apr 29, 2001 at 10:26:57AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 10:26:57AM +0200, Peter Osterlund wrote:
> On Sat, 28 Apr 2001, Linus Torvalds wrote:
> 
> > > could we leave it at half, but set the parent to SCHED_YIELD?
> >
> > Sounds like a good idea. Peter, how does that feel to you? I bet that I'v
> > enever seen it simply because all my machines are (a) much too powerful
> > for any reasonable use and (b) SMP.
> 
> That seems to work. The scheduling delays are back to 20ms and the
> sluggishness feeling is gone. I wrote a simple test program to verify that
> the child is still scheduled before the parent, so the performance
> advantage should still be there. The only annoying thing is that it hides
> the bash bug ;)
> 
> Patch below:
> 
> --- linux-2.4.4.orig/kernel/fork.c	Sat Apr 28 10:17:00 2001
> +++ linux-2.4.4/kernel/fork.c	Sun Apr 29 10:06:42 2001
> @@ -666,16 +666,18 @@
>  	p->pdeath_signal = 0;
> 
>  	/*
> -	 * Give the parent's dynamic priority entirely to the child.  The
> -	 * total amount of dynamic priorities in the system doesn't change
> -	 * (more scheduling fairness), but the child will run first, which
> -	 * is especially useful in avoiding a lot of copy-on-write faults
> -	 * if the child for a fork() just wants to do a few simple things
> -	 * and then exec(). This is only important in the first timeslice.
> -	 * In the long run, the scheduling behavior is unchanged.
> +	 * "share" dynamic priority between parent and child, thus the
> +	 * total amount of dynamic priorities in the system doesn't change,
> +	 * more scheduling fairness. The parent yields to let the child run
> +	 * first, which is especially useful in avoiding a lot of
> +	 * copy-on-write faults if the child for a fork() just wants to do a
> +	 * few simple things and then exec(). This is only important in the
> +	 * first timeslice. In the long run, the scheduling behavior is
> +	 * unchanged.
>  	 */
> -	p->counter = current->counter;
> -	current->counter = 0;
> +	p->counter = (current->counter + 1) >> 1;
> +	current->counter >>= 1;
> +	current->policy |= SCHED_YIELD;
>  	current->need_resched = 1;
> 
>  	/*

please try to reproduce the bad behaviour with 2.4.4aa2. There's a bug
in the parent-timeslice patch in 2.4 that I fixed while backporting it
to 2.2aa and that I now forward ported the fix to 2.4aa. The fact 2.4.4
gives the whole timeslice to the child just gives more light to such
bug. Unfortunately the fix doesn't apply cleanly to 2.4.4 (it's
incremental with the numa-scheduler patch) and I need to finish a few
more things before I can backport it myself.

Andrea
