Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265599AbTFNBd7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 21:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbTFNBd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 21:33:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56259
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265599AbTFNBdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 21:33:52 -0400
Date: Sat, 14 Jun 2003 03:48:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@tech9.net>
Cc: =?iso-8859-1?Q?Ram=F3n?= Rey Vicente????ey Vicente 
	<retes_simbad@yahoo.es>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: lowlatency fixes needed in 2.4 and 2.5
Message-ID: <20030614014820.GZ1571@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bcc: 
Subject: Re: linux-2.4.21 released
Reply-To: 
In-Reply-To: <1055534626.1123.4.camel@localhost>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5

On Fri, Jun 13, 2003 at 08:03:46PM +0000, Robert Love wrote:
> On Fri, 2003-06-13 at 18:56, Ramón Rey Vicente????ey Vicente wrote:
> 
> > And, what's about the low_latency/preemptible patches? 
> 
> We did all that and more for 2.5.

the lowlatency patches are a must for 2.4, let's put them under the
security bugfix headline and maybe they will get merged eventually ;).

It's not at all about lowlatency, it's about DoSing a box given enough
pagecache and ram, tested it years ago the first time on some alpha.

All the needed fixes for 2.4 are here and those bugs are fixed since
ages in my tree.

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1/9981_elevator-lowlatency-5

And IMHO any benchmark of -preempt against a kernel w/o these
_bugfixes_ is cheating. You want to benchmark -preempt against a non
buggy kernel, only then comparisons are interesting.

I'm not very exited about the -preempt stuff going on in 2.5 (this is
code that is there since many months I know), just to make an example
this code is micro-inefficient w/o -preempt configured:

static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
{
	struct runqueue *rq;

repeat_lock_task:
	local_irq_save(*flags);
	rq = task_rq(p);
	

when -preempt isn't configured you definitely want to do the
local_irq_save _after_ the task_rq like we do in 2.4. It's absolutely
wasteful to do the local_irq_save before the rq = task_rq.

Sure this is very much nitpicking (don't need to flame me I already know
you'll never measure any performance overhead in any macrobenchmark, and
it only affects irq latency anyways), but still I'm concerned on how
-preempt is impacting some piece of code like this in a not very visible
way and because it micro-peanlizes kernel compiles with -preempt
disabled. I really would prefer an #ifdef CONFIG_PREEMPT there (or a
cleaner abstraction, possibly not specific to the scheduler), as a
documentation factor.

Of course the above alone really doesn't matter, maybe this is _the_
special case, but I want to stress careful coding with non-preempt in
mind too, because I don't think I'm going to use -preempt for my self
built kernels. -preempt also renders impossible to guarantee CPU unplug
in a definite amount of time, as it may be impossible to reach a
quiescent point with RCU (this is now a problem for dcache/ipc/routing
cache etc..).  To gauarantee that, you'd need explicit schedule points
in any indefinite kernel loop outside spinlock (the thing that -preempt
avoids explicitly).

I still think an explicit preempt-enable around the cpu intensive
per-page copy users or checksums may be overall more worthwhile to
provide lower mean latency than preempt as a whole.

I had a short look and 2.5 w/o -preempt enabled is still buggy and needs
the above fixes too. Andrew, is that right or am I overlooking
something?

In short I'd like to see those needed fixes included in 2.4 and
_especially_ 2.5 ASAP.

Andrea
