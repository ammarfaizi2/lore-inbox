Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288783AbSAIEkC>; Tue, 8 Jan 2002 23:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288789AbSAIEjx>; Tue, 8 Jan 2002 23:39:53 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58069 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S288783AbSAIEjd>;
	Tue, 8 Jan 2002 23:39:33 -0500
Date: Tue, 8 Jan 2002 19:39:04 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Message-ID: <20020108193904.A1068@w-mikek2.beaverton.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0201072122290.14092-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201072122290.14092-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Jan 07, 2002 at 09:24:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below are some benchmark results when running the D1 version
of the O(1) scheduler on 2.5.2-pre9.  To add another data point,
I hacked together a half-a** multi-queue scheduler based on
the 2.5.2-pre9 scheduler.  haMQ doesn't do load balancing or
anything fancy.  However, it aggressively tries to not let CPUs
go idle (not always a good thing as has been previously discussed).
For reference, patch is at: lse.sourceforge.net/scheduling/2.5.2-pre9-hamq
I can't recommend this code for anything useful.

All benchmarks were run on an 8-way Pentium III 700 MHz 1MB caches.
Number of CPUs was altered via the maxcpus boot flag.

--------------------------------------------------------------------
mkbench - Time how long it takes to compile the kernel.
        We use 'make -j 8' and increase the number of makes run
        in parallel.  Result is average build time in seconds.
        Lower is better.
--------------------------------------------------------------------
# CPUs      # Makes         Vanilla         O(1)	haMQ
--------------------------------------------------------------------
2           1                188             192        184
2           2                366             372        362
2           4                730             742        600
2           6               1096            1112        853
4           1                102             101         95
4           2                196             198        186
4           4                384             386        374
4           6                576             579        487
8           1                 58              57         58
8           2                109             108        105
8           4                209             213        186
8           6                309             312        280

Surprisingly, O(1) seems to do worse than the vanilla scheduler
in almost all cases.

--------------------------------------------------------------------
Chat - VolanoMark simulator.  Result is a measure of throughput.
       Higher is better.
--------------------------------------------------------------------
Configuration Parms     # CPUs   Vanilla    O(1)      haMQ
--------------------------------------------------------------------
10 rooms, 200 messages  2        162644     145915    137097
20 rooms, 200 messages  2        145872     136134    138646
30 rooms, 200 messages  2        124314     183366    144403
10 rooms, 200 messages  4        201745     258444    255415
20 rooms, 200 messages  4        177854     246032    263723
30 rooms, 200 messages  4        153506     302615    257170
10 rooms, 200 messages  8        121792     262804    310603
20 rooms, 200 messages  8         68697     248406    420157
30 rooms, 200 messages  8         42133     302513    283817

O(1) scheduler does better than Vanilla as load and number of
CPUs increase.  Still need to look into why it does worse on
the less loaded 2 CPU runs.

--------------------------------------------------------------------
Reflex - lat_ctx(of LMbench) on steroids.  Does token passing
         to over emphasize scheduler paths.  Allows loading of
         the runqueue unlike lat_ctx.  Result is microseconds
         per round.  Lower is better.  All runs with 0 delay.
         lse.sourceforge.net/scheduling/other/reflex/
         Lower is better.
--------------------------------------------------------------------
#tasks   # CPUs       Vanilla        O(1)         haMQ
--------------------------------------------------------------------
2        2             6.594       14.388       15.996
4        2             6.988        3.787        4.686
8        2             7.322        3.757        5.148
16       2             7.234        3.737        7.244
32       2             7.651        5.135        7.182
64       2             9.462        3.948        7.553
128      2            13.889        4.584        7.918
2        4             6.019       14.646       15.403
4        4            10.997        6.213        6.755
8        4             9.838        2.160        2.838
16       4            10.595        2.154        3.080
32       4            11.870        2.917        3.400
64       4            15.280        2.890        3.131
128      4            19.832        2.685        3.307
2        8             6.338        9.064       15.474
4        8            11.454        7.020        8.281
8        8            13.354        4.390        5.816
16       8            14.976        1.502        2.018
32       8            16.757        1.920        2.240
64       8            19.961        2.264        2.358
128      8            25.010        2.280        2.260

I believe the poor showings for O(1) at the low end are the
result of having the 2 tasks run on 2 different CPUs.  This
is the right thing to do in spite of the numbers.  You
can see lock contention become a factor in the Vanilla scheduler
as load and number of CPUs increase.  Having multiple runqueues
eliminates this problem.

-- 
Mike
