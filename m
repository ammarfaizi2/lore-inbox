Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbVF3Mr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVF3Mr7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 08:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbVF3Mr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 08:47:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:30610 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262728AbVF3MrB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 08:47:01 -0400
Date: Thu, 30 Jun 2005 18:17:11 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050630124711.GC17928@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050507182728.GA29592@in.ibm.com> <1115524211.17482.23.camel@localhost.localdomain> <427D921F.8070602@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427D921F.8070602@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ This is a continuation of the thread at : http://lkml.org/lkml/2005/5/7/98 ]

On Sun, May 08, 2005 at 02:14:23PM +1000, Nick Piggin wrote:
> Rusty Russell wrote:
> >On Sat, 2005-05-07 at 23:57 +0530, Srivatsa Vaddagiri wrote:
> >
> >>Two solutions have been proposed so far:
> >>
> >>	A. As per Nick's suggestion, impose a max limit (say some 100 ms or
> >>	   say a second, Nick?) on how long a idle CPU can avoid taking
> 
> Yeah probably something around that order of magnitude. I suspect
> there will fast be a point where either you'll get other timers
> going off more frequently, and / or you simply get very quickly
> diminishing returns on the amount of power saving gained from
> increasing the period.

I did some measurements on the average interval that a idle CPU is allowed to
sleep before it wakes up. I also have some numbers on Xen comparing performance 
between the two approaches (100ms limit vs no limit on sleep interval). 

First, the avg sleep interval. 

Numbers were obtained on this configuration:

	Machine  : 8-way Intel (P3) box
	Distro   : RHEL3 
	Kernel	 : 2.6.12 

Each time a CPU became idle, next_timer_interrupt was called to find the next 
nearest timer (sleep_time_req) and the CPU slept till either the time elapsed 
or it was interrupted by a interrupt (external/device, reschedule, invalidate 
or call_function). When any of these happen, the actual amount of time slept 
in jiffies (sleep_time_real) was measured. In order to measure what effect 
internal system events (reschedule/invalidate/call-function IPI) alone have on 
avg sleep interval, I redirected all external interrupts to CPU 0.

Also the numbers were obtained at init runlevel 3 with system mostly idle.
I basically logged in and ran the test to get the numbers. Apart from
this test, the only other workloads active were the system daemons that are 
initiated at runlevel 3. The test cleared various per-cpu counters (which were 
used to capture sleep_time_real numbers), slept for 2 minutes and read the 
counters at the end of it.

Below are the numbers I obtained from the test:


CPU#   # of	  Mean		Std Dev	    Max			Min
       samples	

1:     113       1088.690      761.352       2001.000          2.000
2:      76       1633.197      640.230       2002.000         94.000
3:      80       1552.300      682.050       2003.000          1.000
4:      71       1735.606      531.744       2004.000        165.000
5:    2525         48.669        6.391         50.000          2.000
6:      74       1652.905      601.908       2006.000         97.000
7:    1783         68.915       33.495        100.000          0.000

[ CPU0 is excluded because its avg sleep interval is just 1 jiffie - 
  The external jiffie timer keeps waking it every jiffy ]

The mean above represents sleep_time_real, i.e the real time a CPU
was allowed to sleep before something woke it. The best mean
time was for CPU4 (1735.606 jiffies or ~1.7 sec). Also note that
the maximum time it actually could sleep was ~2 sec.

Digging further revealed that this max time was restricted by 
various timers kernel uses. Mostly it was found to be because of
the slab allocator reap timer (it requests a timer every ~2sec on
every CPU) and machine_check timer (MCE_RATE in arch/i386/kernel/cpu/mcheck/
non-fatal.c ).

Just to see the effect of increasing the timeouts of these timers, 
I changed MCE_RATE to 60*HZ (from 15*HZ), REAPTIMEOUT_CPUC to 20*HZ (from 2*HZ),
and REAPTIMEOUT_LIST3 to 40*HZ (from 4*HZ). With this change and reruning
my test under the same conditions, the new numbers that were obtained for 
sleep_time_real are:



CPU#   # of	  Mean		Std Dev	    Max			Min
       samples	

1:      24       5229.833     7341.283      20001.000          4.000
2:    2520         49.797        2.745         50.000          3.000
3:       8      15002.250     8575.149      20003.000       1127.000
4:       8      15002.875     8557.532      20004.000       1156.000
5:       8      15003.750     8537.711      20005.000       1189.000
6:     996        125.923     1209.668      30000.000          2.000
7:     134        940.269      176.835       1060.000        310.000


Note that now the best average sleep_time_real is now 15002.875 (~15 sec) 
for CPU4 and max was 20004.000 (~20 sec).

Now I am not saying that we can blindly increase these timeouts
(REAPTIMEOUT_CPUC/REAPTIMEOUT_LIST3/MCE_RATE). But I think that we can
make these timers idle-cpu aware. For example, if the slab timer notices 
that it is running on a idle CPU and the numbers of slabs it is actually 
reaping  have come down very much, then it can request for longer timeouts
instead of every ~2sec the way it does now. 

It is probably good for virtualization/power-management env that we identify
such short timeouts requested in kernel and make them idle-cpu aware to 
the extend possible. In that case, restricting max sleep time to 100ms, IMO,
is not going to be efficient.

In order to see the benefit of sleeping longer (and rather than waking
every 100ms), I ran some benchmarks on Xen. Basically I measured
the throughput of a CPU-intensive benchmark (which finds first 30 random prime
numbers). Time taken to find the 30 prime numbers was used as a benchmark
to compare the two approaches.

Configuration used was:

	Machine 	: 4-way Intel Xeon box (HT disabled in BIOS)
	Distro 		: RHEL4
	Kernel		: Xen-unstable kernel (based on 2.6.11) for both 
			  Domain 0 and guest domains
	
Xen-unstable was used since it provides SMP guest support. Additional 4-way 
domains were started using the ttylinux distro 
(http://easynews.dl.sourceforge.net/sourceforge/xen/ttylinux-xen.bz2).

The prime-number benchmark was run in one of the domains while the other
domains were idle. The throughput of the benchmark was measued once with 
a total of 30 4-way domains started and another time with 100 4-way domains 
started. In each case, to ensure that virtual-cpu/physical-cpu ration remains
same, I pinned each virtual CPU of each domain to corresponding physical CPU.
For ex: virtual CPU 0 of domains 1-30 was pinned physical CPU 0, virtual CPU 1
of domains 1-30 was pinned to physical CPU 1 and so on.

Case A : No-limit-on-sleep-interval

				Avg of 10 runs		Std Dev

30 domains started		28.55 sec		0.009
100 domains started		28.835 sec		0.011

Note that in going from 30->100 domains, the performance has deteriorated by 
only 0.9%.


Case B : 100ms limit on sleep interval. Since by default Xen guest domain kernel
	 follows case A, it was modified to restrict sleep interval to 100ms


     	            	 	Avg of 10 runs		Std Dev

30 domains started		28.867			0.010
100 domains started		29.993        		0.009

Note that in going from 30->100 domains, there is a deterioration of 3.9%

Comparing the two approaches,

			No limit	100 ms limit	Difference

	30 domains	  28.55		28.867		1.1%
	100 domains	  28.835	29.993		4%

The difference is growing with increasing virtualization. I have heard that 
the number of partitions can be much more (>300?) in some high end zSeries 
machines.


So those are the numbers. To conclude:

	- Currently, in 2.6.12 kernel, the avg real sleep time obtained
	  is ~1.7 sec
	- We can (and IMO we must) look at the short timers in use by the 
	  kernel and potentially increase this avg real sleep time 
	  further (atleast for idle CPUs). This mean waking up every 100 ms
	  makes it inefficient.
	- Even if we decide to go for the simple approach, we should increase
	  the sleep-time limit to few seconds. Don't know what that means 
	  for load-balancing.



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
