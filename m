Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281450AbRLIB6g>; Sat, 8 Dec 2001 20:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281499AbRLIB61>; Sat, 8 Dec 2001 20:58:27 -0500
Received: from [144.137.80.17] ([144.137.80.17]:4490 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S281450AbRLIB6J>;
	Sat, 8 Dec 2001 20:58:09 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: anton@samba.org, davej@suse.de, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Linux 2.4.17-pre5 
In-Reply-To: Your message of "Sun, 09 Dec 2001 00:31:13 -0000."
             <E16Crs9-0003Gc-00@the-village.bc.nu> 
Date: Sun, 09 Dec 2001 12:58:43 +1100
Message-Id: <E16CtEp-0007Jb-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E16Crs9-0003Gc-00@the-village.bc.nu> you write:
> > The sched.c change is also useless (ie. only harmful).  Anton and I looked 
at
> > adapting the scheduler for hyperthreading, but it looks like the recent 
> > changes have had the side effect of making hyperthreading + the current
> 
> I trust Intels own labs over you on this one.

This is voodoo optimization.  I don't care WHO did it.

Marcelo, drop the patch.  Please delay scheduler hacks until they can
be verified to actually do something.

Given another chip with similar technology (eg. PPC's Hardware Multi
Threading) and the same patch, dbench runs 1 - 10 on 4-way makes NO
POSITIVE DIFFERENCE.

	http://samba.org/~anton/linux/HMT/

> I suspect they know what their chip needs.

I find your faith in J. Random Intel Engineer fascinating.

================

The current scheduler actually works quite well if you number your
CPUs right, and to fix the corner cases takes more than this change.
First some simple terminology: let's assume we have two "sides" to
each CPU (ie. each CPU has two IDs, smp_num_cpus()/2 apart):

	0  1  2  3
	4  5  6  7

The current scheduler code reschedule_idle()s (pushes) from 0 to 3
first anyway, so if we're less than 50% utilized it tends to "just
work".  Note that it doesn't stop the schedule() (pulls) on 4 - 7 from
grabbing a process to run even if there is a fully idle CPU, so it's
far from perfect.

Now let's look at the performance-problematic case: dbench 5.

Without HMT/hyperthread:
	Fifth process not scheduled at all.

	When any of the first four processes schedule(), the fifth
	process is pulled onto that processor.

With HMT/hyperthread:
	Fifth process scheduled on 4 (shared with 0).

	When processes on 1, 2, or 3 schedule(), that processor sits
	idle, while processor 0/4 is doing double work (ie. only 2 in
	5 chance that the right process will schedule() first).

	Finally, 0 or 4 will schedule() then wakeup, and be pulled
	onto another CPU (unless they are all busy again).

The result is that dbench 5 runs significantly SLOWER with
hyperthreading than without.  We really want to pull a process off a
cpu it is running on, if we are completely idle and it is running on a
double-used CPU.  Note that dbench 6 is almost back to normal
performance, since the probability of the right process scheduling
first becomes 4 in 6).

Now, the Intel hack changes reschedule_idle() to push onto the first
completely idle CPU above all others.  Nice idea: the only problem is
finding a load where that actually happens, since we push onto low
numbers first anyway.  If we have an average of <= 4 running
processes, they spread out nicely, and if we have an average of > 4
then there are no fully idle processes and this hack is useless.

Clear?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
