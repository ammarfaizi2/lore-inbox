Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274669AbRJJEXV>; Wed, 10 Oct 2001 00:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274675AbRJJEXM>; Wed, 10 Oct 2001 00:23:12 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14114 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S274669AbRJJEXH>; Wed, 10 Oct 2001 00:23:07 -0400
Date: Wed, 10 Oct 2001 06:23:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Robert Love <rml@tech9.net>, Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011010062300.H726@athlon.random>
In-Reply-To: <20011010035818.A556B1E760@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011010035818.A556B1E760@Cantor.suse.de>; from Dieter.Nuetzel@hamburg.de on Wed, Oct 10, 2001 at 05:57:46AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 05:57:46AM +0200, Dieter Nützel wrote:
> On Tue, Oct 10, 2001 at 03:06, Andrea Arcangeli wrote:
> > On Tue, Oct 09, 2001 at 10:37:56PM -0400, Robert Love wrote:
> > > On Tue, 2001-10-09 at 22:30, Andrea Arcangeli wrote:
> > > > As said it's very very unlikely that preemption points can fix xmms
> > > > skips anyways, the worst scheduler latency is always of the order of the
> > > > msecs, to generate skips you need a latency of seconds.
> 
> [...]
> > The point is that to avoid dropouts dbench must take say 40% of the cpu
> > and xmms another 40% of the cpu. Then the 10msec doesn't matter. If each
> > one takes 50% of cpu exactly you can run in dropouts anyways because of
> > scheduler imprecisions.
> 
> I get the dropouts (2~3 sec) after dbench 32 is running for 9~10 seconds.
> I've tried with RT artds and nice -20 mpg123.
> 
> Kernel: 2.4.11-pre6 + 00_vm-1 + preempt
> 
> Only solution:
> I have to copy the test MPG3 file into /dev/shm.

If copying the mp3 data into /dev/shm fixes the problem it could be also
an I/O overload. But it could also be still the vm write throttling: to
read the mp3 from disk you need to allocate some cache, while to read
from /dev/shm you don't need to allocate anything because it was just
allocate when you copied the file there. Or it could be both things
together.

Like the cpu is divided by all the CPU hogs, the disk bandwith is also
divided by all the applications doing I/O at the same time (modulo the
fact the gloabl bandwith dramatically decrease when multiple apps do I/O
at the same time due the seeks, the thing that the elevator tries to
avoid by introducing some degree of unfairness in the I/O patterns).

So if this is just an I/O overload (possible too) some possible fixes
could be:

1) buy faster disk
2) try with elvtune -r 1 -w 2 /dev/hd[abcd] /dev/sd[abcd] that will try
   to decrease the global I/O disk bandwith of the system, but it will
   increase fairness

> CPU (1 GHz Athlon II) is ~75% idle during the hiccup.

Of course I can imagine. This is totally unrelated to scheduler
latencies, it's either vm write throttling or I/O congestion so you
don't have enough bandwith to read the file or both.

> The dbench processes are mostly in wait_page/wait_cache if I remember right.
> So I think that you are right it is a file IO wait (latency) problem.

Yes.

> Please hurry up with your read/write copy-user paths lowlatency patches ;-)

In the meantime you can use the preemption points in the copy-user, they
can add a bit more of overhead but nothing interesting, I believe it's
more a cleanup than an improvement to move the reschedule points in
read/write as suggested by Andrew.

BTW, this is the relevant patch:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.11aa1/00_copy-user-lat-5

You're probably more interested in the possible heuristic that I've in
mind to avoid xmms to wait I/O completion for the work submitted by
dbench. Of course assuming the vm write throttling was a relevant cause
of the dropouts, and that the dropouts weren't just due an I/O
congestion (too low disk bendwith).

BTW, to find out if the reason of the dropouts where the vm write
throttling or the too low disk bandwith you can run ps l <pid_of_xmms>,
if it says wait_on_buffer all the time it's the vm write throttling, if
it says always something else it's the too low disk bandwith, I suspect
as said above that you'll see both things because it is probably a mixed
effect. If it's not vm write throttling only a faster disk or elvtune
tweaking can help you, there's no renice-IO -n -20 that allows to
prioritize the I/O bandwith to a certain application.

Andrea
