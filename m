Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274405AbRJJDGW>; Tue, 9 Oct 2001 23:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274424AbRJJDGM>; Tue, 9 Oct 2001 23:06:12 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:55581 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S274405AbRJJDFz>; Tue, 9 Oct 2001 23:05:55 -0400
Date: Wed, 10 Oct 2001 05:06:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@ufl.edu>
Cc: safemode <safemode@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011010050630.E726@athlon.random>
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org> <20011010031803.F8384@athlon.random> <20011010020935.50DEF1E756@Cantor.suse.de> <20011010043003.C726@athlon.random> <1002681480.1044.67.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1002681480.1044.67.camel@phantasy>; from rml@ufl.edu on Tue, Oct 09, 2001 at 10:37:56PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 10:37:56PM -0400, Robert Love wrote:
> On Tue, 2001-10-09 at 22:30, Andrea Arcangeli wrote:
> > As said it's very very unlikely that preemption points can fix xmms
> > skips anyways, the worst scheduler latency is always of the order of the
> > msecs, to generate skips you need a latency of seconds.
> >
> > [...]
> >
> > There's nothing magic in the software, if you divide the cpu in 10 parts
> > and you give 1/10 of the cpu to xmms, but xmms needs 1/2 of the cpu to
> > play your .mp3 then there's nothing you can do to fix it but to tell
> > the scheduler to give more cpu to xmms (renicing to -20 gives more cpu
> 
> What if the CPU does divide its time into two 1/2 parts, and gives one
> each to xmms and dbench.  Everything runs fine, since xmms needs 1/2 cpu
> to play without skips.

Of course. (btw, when running dbench there's usually more than one
thread to generate more I/O, usually 20/40, it depends on the parameter
but let's assume there's only one thread for the sake of this example)

> Now dbench (or any task) is in kernel space for too long.  The CPU time

The time in kernel space decreases the timeslice too, so it doesn't
matter if it runs in kernel space too long, it will still be accounted
as such 1/2 of time.

> xmms needs will of course still be given, but _too late_.  Its just not

I think the issue you raise is that dbench gets a 10msec more of cpu
time and xmms starts running 10msec later than expected (because of the
scheduler latency peak worst case of 10msec).

But that doesn't matter. The scheduler isn't perfect anyways. The
resolution of the scheduler is 10msec too, so you can easily lose 10msec
anywhere else no matter of whatever scheduler latency of 10msec.

The only tasks that can get hurted by the scheduler latency are real
time tasks running with RT prio that expects to get running in less than
10msec after their wakeup, this is obviously not the xmms case that can
live fine even if it becomes running after houndred milliseconds after
its wakeup.

The point is that to avoid dropouts dbench must take say 40% of the cpu
and xmms another 40% of the cpu. Then the 10msec doesn't matter. If each
one takes 50% of cpu exactly you can run in dropouts anyways because of
scheduler imprecisions.

So again: the preemptive patch cannot make any difference, except for
the read/write copy-user paths that originally Ingo fixed ages ago in
2.2, and that I also later fixed in all -aa 2.2 and 2.4 and that are
also fixed in the lowlatency patches from Andrew (but in the
generic_file_read/write rather than in copy-user, to possible avoid some
overhead for short copy users, but the end result for an xmms user is
exactly the same).

So for whatever non real time, but where buffering is possible running
lowlatency patch from Ingo or Andrew, preemptive patch, or -aa isn''t
going to make any difference.

> a cpu resource problem, its a timing problem.  xmms needs x units of CPU
> every y units of time.  Just getting the x whenever is not enough.
> 
> With preempt-kernel patch, the long-lasting kernel space activity dbench
> is engaged in won't hog the CPU until it completes.  When xmms is ready
> (time y arrives), the scheduler will yield the CPU.
> 
> 	Robert Love


Andrea
