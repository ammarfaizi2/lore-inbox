Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283669AbRK3PwZ>; Fri, 30 Nov 2001 10:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283679AbRK3PwP>; Fri, 30 Nov 2001 10:52:15 -0500
Received: from smtp.iol.cz ([194.228.2.35]:12757 "EHLO smtpmail1.iol.cz")
	by vger.kernel.org with ESMTP id <S283669AbRK3PwG>;
	Fri, 30 Nov 2001 10:52:06 -0500
Date: Fri, 30 Nov 2001 16:21:48 +0100 (CET)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: <Diffserv-general@lists.sourceforge.net>, <lartc@mailman.ds9a.nl>,
        <linux-kernel@vger.kernel.org>
Subject: PSCHED_TDIFF_SAFE bug in TC (QoS) subsystem
Message-ID: <Pine.LNX.4.33.0111301558100.1605-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

during developement of HTB I find bug in macro PSCHED_TDIFF_SAFE
in file include/net/pkt_sched.h. The bug causes minor errors in
TBF queuing discipline and possibly in CBQ. Solution is bellow.

Problem:

The psched_time_t is u64 (for PSCHED_CLOCK_SOURCE!=PSCHED_GETTIMEOFDAY).
The PSCHED_TDIFF_SAFE macro is meant as way to compute difference
between two such timestamps and provide upper bound for result.
Here is the declaration:
#define PSCHED_TDIFF_SAFE(tv1, tv2, bound, guard) ({ \
           long __delta = (tv1) - (tv2); \
           if ( __delta > (bound)) {  __delta = (bound); guard; } \
           __delta; \ })

tv1 is assumed to be greater than tv2. This works well is difference
between tv1 and tv1 <= 0xffffffff but ONLY IF "bound" argument is
unsigned. If you use signed bound whole function will start to behave
very wildly (I was ran into it infortunately).

Impact:

Moreover even if "bound" is unsigned then each 84 minutes (when
difference goes over 0xffffffff) the result is smaller than "bound"
for interval controled by "bound"'s value.

TBF uses it exactly in such way and if TBF class is idle for
84 minutes and then packet arrives it will be delayed more than
neccessary (thus introducing delay).

The error is dependent on "burst" parameter and for 1kbps rate
and 400k burst it is 10%.
The more sofisticated qdisc can rely even more on correct
PSCHED_TDIFF_SAFE behaviuor and here the error could be more
dramatic.

Solution:

Change "long" to "long long" or s32 (if does it exists). It will
introduce minor CPU penalty on 32bit systems but the result will
be correct.

Notes:

All macros PSCHED_XXX seems to assume that there can't be difference
larger than u32 range. Unfortunately author (ANK?) itself uses the
macros at places where the difference IS larger.

I hope in author's comments on this problem.

best regards,
Martin Devera aka devik

