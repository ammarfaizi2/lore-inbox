Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266095AbUFDX7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266095AbUFDX7v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbUFDX7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:59:51 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:41054 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266095AbUFDX7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:59:47 -0400
Date: Fri, 4 Jun 2004 17:05:42 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040604170542.576b4243.pj@sgi.com>
In-Reply-To: <20040604165601.GC21007@holomorphy.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604090314.56d64f4d.pj@sgi.com>
	<20040604165601.GC21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew - I view the following as a discussion of further work
	 that might be done, on top of the cpumask patches I
	 have submitted.  Except for one specific issue that
	 David Mosberger is working off-line with you and me,
	 I have not yet seen any reason to change the cpumask
	 patches as submitted.  I hope that this additional
	 discussion is not discouraging you from considering
	 those cpumask patches for acceptance.

William Lee Irwin III wrote:
> > Yes - doing that 1-bit at a time in a per-cpu loop would be ugly.
> > We should leave cpus_addr() around, at least until such time as the
> > cpumask ADT provided routines to support exactly what you are doing -
> > copying up masks to user space as length specified arrays of uint.
> 
> This is patently ridiculous. Make a compat_sched_getaffinity(), and
> likewise for whatever else is copying unsigned long arrays to userspace.

My mind reading skills are failing me.  At the risk of opening myself to
further ridicule, which part of what I wrote is patently ridiculous,
why, and how does that differ from whatever you had in mind when you
recommended doing "likewise"?

Putting your comments aside for a moment ...

We have here a bit of suckage.  The kernel bitmaps/cpumasks are arrays
of unsigned long, with the low order long in the low order array slot,
and the bytes within the longs in natural byte-order for that arch. The
sched_setaffinity/sched_getaffinity calls in the kernel copy this stuff
directly to/from user space.  This doesn't work so well for 32 bit tasks
on a 64 bit big-endian kernel.  [Begin off-topic alert] The glibc
sched_setaffinity and sched_getaffinity calls forcibly truncate the size
of masks to some constant hardcoded size -- you have to use
__SYSCALL(__NR_set_mempolicy) and such to get the real syscall.  This
doesn't work so well for kernels compiled with NR_CPUS larger than the
hardcoded glibc size.  [End off-topic alert]  This also doesn't provide
any help to other code needing to move binary masks across the
kernel/user boundary, such as the perfctr kernel extension that Mikael
Pettersson <mikpe@csd.uu.se> describes.

I presume that it is too late to change the low level format of masks
that the sched_setaffinity/sched_getaffinity API support.  I'd be
delighted to be wrong on this presumption.  So there is need for a
compat variant of these calls, for use by 32 bit apps on 64 bit kernels.
 My first reaction to Milton Miller's compat_sched_getaffinity patch
that Anton reminded us of is similar to Andrew's.  I haven't had the
intestinal fortitude to study the matter closer yet.   Before actually
reading the code, I would expect that all it had to handle was the
swapping of 32 bit halves of 64 bit longs on 64 bit big endian kernels,
such as I described in my discussion of a mythical BIT32X() macro,
earlier in this thread.  I would not expect it to have to make such a
big deal of the special case of one word masks, as distinct from n word
masks, though I agree that a 32 bit app should be able to use a single
32 bit word mask on a 64 bit kernel compiled with NR_CPUS <= 32.

A key question, since it seems the perfctr stuff Mikael Pettersson
describes is on its way into the main stream kernel, is whether any
other kernel binary bitmap/cpumask API should use the same format as
used by the kernel sched_setaffinity and sched_getaffinity, or use a
more easily portable format - say an array of 32 bit words rather than
an array of unsigned longs.  One could make impassioned pleas either
way.  Having one kernel represent the same type in two different binary
formats is a bit of a botch.  But then again, arrays of 32 bit words are
'nicer'.  And in fact, we already _have_ two formats required, since 32
bit apps on 64 bit end endian kernels necessarily see a different format
than their kernel uses natively -- indeed they use a format that is
essentially the same as perfctr is using now.

My vote, already cast when I slid the 32 bit chunk ascii format past
y'all (it's amazing now, that I managed to do that ...) would be to
export the array of 32 bit words format from the kernel, in all calls
except the set/get affinity calls, where we have already cast the die
otherwise.  I like what I understand Mikael is trying to do here.

In any case, I'd hope that any big/little endian distinctions could be
encapsulated in macros provided by include/linux/byteorder headers. I'd
hope that whichever one or two formats the kernel exported were
supported by conversion routines in bitmap.c and bitmap.h, and if
useful, also made available via the cpumask_t API.  Once cpumask
routines were available to convert the perfctr format, then that would
be one less use of the infamous cpus_addr() macro.  We should minimize
'open coding' of the conversion routines outside of the bitmap routines,
which means look for the opportunity to move codes from both perfctr and
compat_sched_setaffinity into lib/bitmap.c.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
