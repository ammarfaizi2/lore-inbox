Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVEQXfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVEQXfG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVEQXfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:35:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:28573 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261999AbVEQXdE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:33:04 -0400
Date: Tue, 17 May 2005 16:33:00 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: [RFC][PATCH 0/4] new timeofday-based soft-timer subsystem
Message-ID: <20050517233300.GE2735@us.ibm.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
X-Operating-System: Linux 2.6.12-rc4 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.05.2005 [17:16:35 -0700], john stultz wrote:
> All,
> 	This patch implements the architecture independent portion of the new
> time of day subsystem. For a brief description on the rework, see here:
> http://lwn.net/Articles/120850/ (Many thanks to the LWN team for that
> easy to understand writeup!)
> 
> 	I intend this to be the last RFC release and to submit this patch to
> Andrew for for testing near the end of this month. So please, if you
> have any complaints, suggestions, or blocking issues, let me know.

I have been working closely with John to re-work the soft-timer subsytem
to use the new timeofday() subsystem. The following patches attempts to
begin this process. I would greatly appreciate any comments.

Some design points:

1) The patch is small but does a lot.
a) Renames timer_jiffies to last_timer_time (now that we are not
	jiffies-based).
b) Converts the soft-timer time-vector's/bucket's entries to
	timerinterval (a new unit) width, instead of jiffy width.
c) Defines timerintervals to be the current time as reported by the new
	timeofday-subsystem shifted down by TIMERINTERVAL_BITS bits.
	Thus, various pseudo-'human time' units can be emulated.
d) Uses do_monotonic_clock() (converted to timerintervals) as the basis
	for addition and expiration of timers instead of jiffies.
e) Adds some new helper functions for dealing with nanosecond values.

2) The patch depends on John's timeofday core rework.  For arches that
will not have the new timeofday (or for which the rework is still in
progress), I can emulate the existing system with a separate patch (Such
a possible patch will follow). The goal of this patch, though, is just
to show how easy the new system can be implemented and the benefits. It
has been tested on x86 and x86_64 archs; there may be some issues with
ppc and ppc64 which I am working on resolving.

3) The reason for the re-work? Many people complain about all of the
adding of 1 jiffy here or there to fix bugs. This new systems is
fundamentally human-time oriented and deals with those issues correctly
and, more importantly, sanely :)

The code is reasonably well commented, but does expect readers to
understand the current soft-timer subsystem.

This is still an early working of this patch, so I expect criticism, and
am happy to make changes.

I will try to get some current benchmark differentials posted tomorrow.
The previous patch I released showed little difference between mainline,
John's timeofday rework and my soft-timer rework in kernbench.

Overview:

1/4: A small interdiff between John's current stack and what is
necessary for my patch to work. Moves timeofday.h architecture-specific
code to asm/timeofday.h. This is necessary for my patch.

2/4: Converts the soft-timer subsystem to use timerinterval as the units
of addition and expiration.

3/4: Converts, as an example, sys_nanosleep() to use the new interfaces
provided by patch 2. For instance, you (albeit somewhat rarely -- maybe
once out of every 100,000 requests) may get only 10 usecs of actual
sleep (instead of 2+ msecs no matter what).

4/4: Enables non-NEWTOD archs to use the same interfaces, with some
performance penalty (am working on a better alternative, this is just
a POC).

Thanks,
Nish
