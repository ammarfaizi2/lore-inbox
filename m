Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274244AbRJJC3w>; Tue, 9 Oct 2001 22:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274288AbRJJC3n>; Tue, 9 Oct 2001 22:29:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24859 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S274244AbRJJC3b>; Tue, 9 Oct 2001 22:29:31 -0400
Date: Wed, 10 Oct 2001 04:30:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: safemode <safemode@speakeasy.net>
Cc: Robert Love <rml@ufl.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011010043003.C726@athlon.random>
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org> <20011010031803.F8384@athlon.random> <20011010020935.50DEF1E756@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011010020935.50DEF1E756@Cantor.suse.de>; from safemode@speakeasy.net on Tue, Oct 09, 2001 at 10:09:33PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 10:09:33PM -0400, safemode wrote:
> On Tuesday 09 October 2001 21:18, Andrea Arcangeli wrote:
> > On Tue, Oct 09, 2001 at 08:36:56PM -0400, safemode wrote:
> > > mp3 player to skip, though.   That probably wont be fixed intil 2.5,
> > > since you need to have preemption in the vm and the rest of the kernel.
> >
> > xmms skips during I/O should have nothing to do with preemption.
> >
> > As Alan noted for the ring of dma fragments to expire you need a
> > scheduler latency of the order of seconds, now (assuming the ll points
> > in read/write paths) when we've bad latencies under writes it's of the
> > order of 10msec and it can be turned down further by putting preemption
> > checks in the buffer lru lists write paths.
> >
> > The reason xmms skips I believe is because the vm is doing write
> > throttling. I've at least one idea on how to fix it but it has nothing
> > to do with preemption in the VM or whatever else scheduler related
> > thing.
> >
> > So I wouldn't expect to fix any playback skips where buffering is
> > possible by using the preemptive patch etc.. It's nearly impossible that
> > it makes any difference.
> >
> > The preemptive patch can matter only if you're doing real time signal
> > processing where any kind of buffering isn't possible.
> >
> > Andrea
> 
> That's what i would think too at first.  What's confusing me is the fact that 
> it is affected by priority.  Which means preemption can solve the problem.  
> If i run the mp3 player at nice -n -20, i get no skips.   Why else would that 

As Dan Mann noted privately there's of course also the possibility that
the scheduler scheduled xmms away for a long time because there's a very
high cpu load, this seems confirmed since the skip goes away with nice
-n -20.

> be if not that preemption is dictating that freeamp's process gets whatever 
> it wants when it wants ?   

If -n -20 fixes the problem that has nothing to do with scheduler
latency or with the write throttling and the preemption patch cannot
help at all.

If -n -20 fixes the problem it simply means your cpu load was too high.
The linux scheduler is fair. So to fix it there are only those possible
ways:

1) buy a faster cpu
2) add additional cpus to your system
3) reduce the cpu load of your system by stopping some of the cpu
   eaters
4) run xmms RT or with higher priority (or reduce the priority of the
   other cpu hogs)

As said it's very very unlikely that preemption points can fix xmms
skips anyways, the worst scheduler latency is always of the order of the
msecs, to generate skips you need a latency of seconds.

I thought your problem weren't just xmms being scheduled away due high
cpu load, because dbench is intended to be an I/O benchmark but maybe
you've lots of cache and you do little I/O?

The problem I was talking about in my earlier email applies to RT tasks
too, so if you were doing lots of I/O and xmms started doing write
throttling just running nice -n -20 wouldn't helped.

> I mean, if renicing the process allows it not to skip, what else is going on 

The reason it allows it not to skip is because the scheduler gives more
cpu to xmms.

There's nothing magic in the software, if you divide the cpu in 10 parts
and you give 1/10 of the cpu to xmms, but xmms needs 1/2 of the cpu to
play your .mp3 then there's nothing you can do to fix it but to tell
the scheduler to give more cpu to xmms (renicing to -20 gives more cpu
to xmms, enough to sustain the .mp3 decoding without dropouts).

> Ok, so maybe i'm wrong and it has nothing to do with preemption, if then what 

Correct, it has nothing to do with preemption.

> not at normal 0.   And why is that the default behavior of the kernel ?  It 
> seems quite unfair in a multiuser-multiprocessing system. 

The opposite, the scheduler is fair, so it divides the cpu to all the
tasks in your system. If xmms wouldn't skip the scheduler isn't fair,
and as you say that would be very bad in a multiuser system.

Andrea
