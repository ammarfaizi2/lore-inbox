Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbSLITlm>; Mon, 9 Dec 2002 14:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSLITll>; Mon, 9 Dec 2002 14:41:41 -0500
Received: from itsc042.itsnpt.com ([208.48.57.42]:42147 "HELO dan.drown.org")
	by vger.kernel.org with SMTP id <S266100AbSLITlk>;
	Mon, 9 Dec 2002 14:41:40 -0500
Date: Mon, 9 Dec 2002 14:29:44 -0500
From: Daniel Drown <dan-lk@drown.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: page_remove_rmap
Message-ID: <20021209142944.A22671@dan.drown.org>
References: <20021208130908.GE19698@krispykreme> <Pine.LNX.4.50L.0212081246570.21756-100000@imladris.surriel.com> <Pine.LNX.4.50L.0212081444350.21756-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.50L.0212081444350.21756-100000@imladris.surriel.com>; from riel@conectiva.com.br on Sun, Dec 08, 2002 at 02:45:38PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Dec 2002, Rik van Riel wrote:
> Looks like the bitflag locking in rmap is hurting you.
> How does it work with a real spinlock in the struct page
> instead of using a bit in page->flags ?

On Sun, 08 Dec 2002, Rik van Riel wrote:
> In particular, something like the (completely untested) patch
> below.  Yes, this patch is on the wrong side of the space/time
> tradeoff for machines with highmem, but it might be worth it
> for 64 bit machines, especially those with slow bitops.
[removed patch]

I also have a workload that page_remove_rmap appears at the top of the profile
output.  So I took your suggestion but I made the changes to 2.4.20-ac1 (which
looks like rmap-14b).

Machine is 2x 2.2ghz Xeon P4 (HT enabled), 2gb ram.

Nagios is configured with 8,000 services on 4,000 hosts with each service
being checked every 2 minutes.  The service checks just execute /bin/true.  No
"real" status checks are used for the purposes of this benchmark.

When nagios wants to execute a service check, it forks off a process to
monitor the service check and report its status back to the master process.
That process forks of another process to actually call exec.  (I have changed
the default nagios behaviour from calling fork three times to execute a
service check)

The default behavour of nagios is to call free() on most of the allocated
memory in the monitoring child, but this just lead to higher mem usage (glibc
not able to free memory it allocated with brk because it's fragmented, copy
from a freelist update?).  I changed this to just leave the allocated memory
alone, so this leads to high amounts of shared memory (~20mb shared between
the processes).

cpu time - cpu time spent in nagios and child processes
# checks - number of checks executed by nagios (rounded to the nearest 100)
nagios latency - difference between when nagios wanted to schedule a check and
			when it ran
check exec time - how long it took for the check to finish

kernel		cpu time	# checks	nagios latency	check exec time
		(user/sys/real)	(rounded)	(max/avg)	(max/avg)
2.4.19-O1	36s/61s/141s	8500		1s/0.130s	1s/0.031s
2.4.20		40s/73s/141s	8500		1s/0.151s	1s/0.009s
2.4.20-ac1	21s/1029s/308s	4000		79s/3.456s	1s/0.011s
2.4.20-ac1+spin	21s/899s/276s	4000		72s/5.428s	1s/0.013s
2.4.18-18.8.0	23s/600s/187s	3800		84s/9.494s	2s/0.019s

The run queue on the -rmap based kernels (2.4.20-ac1*, rh 8.0's 2.4.18-18.8.0)
gets up to 1500 at points.  Machine is still pretty responsive at this
point, but when I kill all the nagios processes, the box stops cold for a
minute or two.  (kernel still responsive ala ICMP, userland not.)

2.4.19-O1 (sched-2.4.19-rc2-A4 + 2G/2G split) and 2.4.20 (vanilla) run queues
are mostly 0 with some jumps to 200.

These boxes arn't in production yet, so I can do testing on them.

Full kernel profiling output for everything but the rh kernel is available at:
http://dan.drown.org/nagios/profiling.html

-- 
It's looking like if MySQL AB doesn't make a movie based on the manual,
nobody's ever gonna learn how to use a database.
        - r.
