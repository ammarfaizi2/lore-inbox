Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVIWXE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVIWXE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 19:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVIWXE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 19:04:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:17842 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932095AbVIWXE2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 19:04:28 -0400
Message-ID: <433489F6.9080203@us.ibm.com>
Date: Fri, 23 Sep 2005 16:04:22 -0700
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geoff Levand <geoffrey.levand@am.sony.com>
CC: george@mvista.com, "Theodore Ts'o" <tytso@mit.edu>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       "lkml, " <linux-kernel@vger.kernel.org>, dino@us.ibm.com,
       Thomas Gleixner <tglx@linutronix.de>,
       Paul McKenney <paulmck@us.ibm.com>,
       "Sarma, Dipankar" <dipankar@in.ibm.com>
Subject: Re: HRT on opteron / rt14 on opteron
References: <432F21D1.90209@us.ibm.com> <432F5A44.9010208@am.sony.com>
In-Reply-To: <432F5A44.9010208@am.sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geoff Levand wrote:
 > Darren Hart wrote:
 >
 >>I am trying to get "high resolution timing" (in the generic sense) to
 >>work on a 2 way opteron box.  I am building 32 bit kernels with ARCH=i386 and
 >>the
 >>preocessor set to Pentium-MMX.  When given the option, I use the TSC for
 >>HRT.
 >>
 >>I've tested several revisions and currently Ingo/Thomas's 2.6.13-rt14
 >>builds/boots/runs and passes my simple clock_nanosleep test (the
 >>latency.c test
 >>that I believe was integrated into the HRT support package a while
 >>back):
 >>
 >>#linux-2.6.13-rt14
 >>[root@elm3a210 dvhart]# ./latency 10 1000
 >>Sleeping 1000 times for 10 usecs
 >>min:11 us max:15 us avg: 11 us
 >>
 >>
 >>HRT for 2.6.12 builds/boots but doesn't seem to be using high resolution
 >>timers
 >>at all:
 >>
 >>#linux-2.6.12-hrt
 >>[root@elm3a210 dvhart]# ./latency 10 1000
 >>Sleeping 1000 times for 10 usecs
 >>min:1006 us max:2001 us avg: 1500 us
 >>
 >>
 >>Can anyone offer any thoughts as to why this might be?  Is this a known
 >>problem?
 >>  If so I'm happy to work on it and would appreciate any direction those
 >>in the
 >>know could offer.  Is there even interest in fixing this?  I'd like to
 >>know
 >>George's mind on the HRT patch, does he intend to maintain it separate
 >>from the
 >>rt patches?
 >>
 >>Thanks,
 >>
 >
 >
 > Here are my results from the latest patches in CVS/HRT (non-rt).
 >
 > linux-2.6.12, Pentium 4 Vaio note.
 >
 > CONFIG_HIGH_RES_TIMERS=y
 > CONFIG_HIGH_RES_TIMER_TSC=y
 > CONFIG_HIGH_RES_RESOLUTION=10000
 > CONFIG_PREEMPT=y
 >
 > root@rex:/opt/hrtimers-support/bin# ./latency-test -d 10 -l 1000
 > CLOCK_REALTIME_HR: min:13 max:1014 avg:638 (us)
 > CLOCK_REALTIME: min:585 max:2496 avg:1689 (us)
 >
 > Why don't you try latency-test so we can compare?  I put a dist here:
 >
 >    http://tree.celinuxforum.org/downloads/hrtimers-support-dev-05.05.27.tar.gz
 >

I am trying to run all the tests in the above tarball on a 2.6.13 kernel with 
ktimers+tod+hrt + a hrt compatibility patch which uses the normal clocks when a 
_HR clock is requested since ktimers treats them the same.  I remember there 
used to be a run_tests script or something when this was a kernel patch, but I 
am not seeing that or any kind of documentation on how to interpret the output 
of the tests which output numbers rather than pass/fail.  For instance:

# ./1-4
it value left is 3 999985323

What does that even mean?  Should I only be running executables that end in 
-test perhaps?  Are some of these for use by the other tests?

# ./clock_nanosleep
Clock resolution        1.000 usec
Requested delay    actual delay(sec) error(sec)
  0.000000100      0.000010119     0.000010019
  0.000001000      0.000003834     0.000002834
  0.000010000      0.000012318     0.000002318
  0.000100000      0.000102288     0.000002288
  0.001000000      0.001002339     0.000002339
  0.010000000      0.010002518     0.000002518
  0.100000000      0.100004212     0.000004212
  1.000000100      1.000009595     0.000009495
  1.000001000      1.000009529     0.000008529
  1.000010000      1.000018678     0.000008678
  1.000100000      1.000108919     0.000008919
  1.001000000      1.001007746     0.000007746
  1.010000000      1.010008818     0.000008818
  1.100000000      1.100010579     0.000010579
  2.000000100      2.000015456     0.000015356
  2.000001000      2.000015428     0.000014428
  2.000010000      2.000024492     0.000014492
  2.000100000      2.000114350     0.000014350
  2.001000000      2.001014281     0.000014281
  2.010000000      2.010014583     0.000014583
  2.100000000      2.100004033     0.000004033
  3.000000100      3.000009397     0.000009297
  3.000001000      3.000009292     0.000008292
  3.000010000      3.000018185     0.000008185
  3.000100000      3.000108361     0.000008361
  3.001000000      3.001008024     0.000008024
  3.010000000      3.010008516     0.000008516
  3.100000000      3.100010112     0.000010112
  4.000000100      4.000015062     0.000014962
  4.000001000      4.000015298     0.000014298

Looks like clock_nanosleep has errors < 15 usecs, actually seems like a lot for 
a kernel built with 1us resolution (unloaded) - or does this test include some load?


# ./nanosleep_jitter
Iteration iter time (secs)           min sleep max sleep
   0        0.051953  0.051952 0.000052    0.000052
   1        0.051953  0.051952 0.000052    0.000052
   ...

Is this what is expected?  I believe the test intends to sleep for .05 seconds 
(50 milliseconds), I seem to be sleeping an extra 2 milliseconds.  Seems like a 
lot actually.


# ./performance
I plotted the results, url below for reference.  Is the y-axis the latency 
(above and beyond the requested delay)?
http://www.dvhart.com/tmp/performance_plot.png


# ./rt_sev_none 1
0: value=0.000000000(1.000000000); interval=0.000000000(0.000000000)
... repeated 700 times before I killed it
What should I conclude from this?  Need I let it run to completion?


# ./sigevthread-test
perror: Invalid argument
timer_create failed.

I gather is a conflict with the ktimer implementation?


# ./timerlimit
1: timer id = 0
2: timer id = 1
3: timer id = 2
...
7165: timer id = 7164
7166: timer id = 7165
7167: timer id = 7166
7168: timer id = 7167
timer_create: Resource temporarily unavailable

Is that a reasonable number of successfully created clocks?

# ./timerstress
I plotted the results, url below for reference.  Is the y-axis the latency 
(above and beyond the requested delay)?
http://www.dvhart.com/tmp/timerstress_plot.png


Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Linux Kernel Team
Phone: 503 578 3185
   T/L: 775 3185
