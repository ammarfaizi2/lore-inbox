Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271922AbTG2Top (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271997AbTG2Top
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:44:45 -0400
Received: from [198.149.18.6] ([198.149.18.6]:35497 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S271922AbTG2Tol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:44:41 -0400
Date: Tue, 29 Jul 2003 14:44:40 -0500
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: KDB in the mainstream 2.4.x kernels?
Message-ID: <20030729194440.GA19938@mandrake.americas.sgi.com>
References: <aJIn.3mj.15@gated-at.bofh.it> <m3smp3y38y.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3smp3y38y.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 10:43:57PM +0200, Andi Kleen wrote:
> 
> One argument i have against it: KDB is incredibly ugly code. 
> Before it could be even considered for merging it would need quite a lot 
> of cleanup.
> ...

I believe there was a consensus reached that the ugliness was out of
necessity.  I hope my understanding is correct.

> 
> As for your home crash debugging I suspect you would be better of with LKCD
> or Mcore (crash dump, saving an crash image on some partition, with examining
> the crash dump after reboot) 

I personally think _BOTH_ belong in a kernel.  KDB for locating problems
in my code during development and a crash dump facility so I can look at
the problems that I don't believe are part of my code at a later time.
Additionally, when I am no longer debugging the code, I would rather
turn KDB off and leave LKCD in there to capture the particular
problem I am chasing.  How many problems have been encountered on
user machines which have resulted in a reboot and ignore method?
This is no way to fix problems!

For me, and I believe I am not alone, the most infuriating problem is the
one line change in your code which "tickles" someone else's bug and I
spend 3 days trying to find what really went wrong.

I am sure that nearly anyone working in the bowels of the kernel has
also had a user land program that terminated with just a bus error.

> 
> KDB is usually not useful for debugging hangs on desktop boxes (and even
> many servers) because you have usually X running. When the machine crashes and
> goes in KDB you cannot see the text output and debug anything. I learned
> to type "go<return>" blind when I had still an KDB aware kernel, but
> it's not very useful overall.

I believe that this could be addressed once KDB gets into the kernel.  If
this were clearly stated as a condition for getting KDB in, then I am
sure someone can figure a method out.

> 
> On a development machine you can avoid that by connecting a serial cable,
> but that's usually not easily possible for a desktop box. Doing a post-mortem
> after reboot is more practical. That is what LKCD/mcore do.
> 
> Disadvantage is that the current crash dump mechanisms (lkcd, mcore
> crash, netdump) are all still not very reliable and have horrible
> error handling. And you can eat a lot of disk space for the dumps and
> they tend to overflow your file systems.  But still it's the only
> realistic option for "desktop bugs"

I am not sure what you mean by LKCD is not reliable.  I use LKCD to
create crash dumps at work all the time.  The only problems I have
are when the NMI doesn't propagate correctly into LKCD and initiate
the dump.  I believe Keith Owens has improved LKCD's understanding
of being called for KDB and now that seems to always work as well.

I think the error handling being referred to is the device driver itself.
That should probably get fixed on a case-by-case basis instead of
putting the blame on LKCD.  I don't see driving force to fixing
drivers for a crash dump facility without a clear direction as to
which facility will be accepted.

As for space, I view that as an admin problem.  If you are selling
a machine with a lot of memory, you need to size for the dump you
will typically get.  I recently initiated an LKCD dump on a machine
with 8GB of memory and had dumping of kernel pages including buffers.
The uncompressed dump output was still only 161MB.  I have also taken
a dump from a machine with over 128GB of memory in 64K pages shortly
after booting with init=/bin/sh.  It took only 108MB.  That doesn't
seem too large in the days of 120GB drives.  This can be reduced even
further by using compression (Already supported by LKCD) and not dumping
kernel buffers.

> 
> BTW debugging on the X server works on linuxppc/mac with xmon because it 
> has a fbcon based console and X server. The debugger can just
> work on the X background while the X server is stopped. Very nifty. 
> But I don't see the x86 XFree86 switching to a similar fbcon model any 
> time soon, so it's unlikely to help.
> 
> -Andi

I believe that crash dumps and in core debugging are useful for a lot of
others as well.  If not, why have Red Hat's netdump and United Linux's
LKCD implementations been done?  It seems the only people saying "no"
to dumps and in core debugging are the people who claim to benefit from
it least.  I view that as equally arrogant to the PPC people being able
to say no to adding machine vectors required by ia64 on a "just because"
basis without justifying based on technical merit.

I agree with _EVERYTHING_ that Linas from IBM pointed out.  What needs to
be done to get this in?

If you want to hear user testimonials, I have used KDB for the last
year.  It has been invaluable in locating race conditions with spin locks
when you have large processor counts and you are stress testing a machine.

I have complained bitterly (ask Keith Owens) that LKCD needs to be
working.  One of my primary uses of LKCD since Keith got it working for
our machine has been: hitting a problem; doing a cursory check to see
if it is something I introduced and debug with KDB.  When I am certain I
am done using KDB, I take the dump and reanalyze using lcrash to ensure
the answer is consistent and do a cursory check for other failures which
may be hiding behind this bug.  It also gives me a method of determining
if my fix introduced a new bug or if a future failure was from a long
running behavior which just now got bad enough.  When I hit something new,
I now have "perfect recall" of the previous failure.

I believe this should be in the 2.6 kernel as well.  I believe it
will save time during the bringup effort for countless people.

Robin Holt
