Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVLPBGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVLPBGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVLPBGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:06:46 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:49362 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751250AbVLPBGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:06:46 -0500
Message-ID: <43A21324.2050905@comcast.net>
Date: Thu, 15 Dec 2005 20:06:44 -0500
From: Gautam Thaker <gthaker@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: severe jitter experienced with "select()" in linux 2.6.14-rt22
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been conduting some jitter tests on 2.6.14-rt22.  (Many thanks
to Ingo Molnar who has helped in various ways.) I wanted to share the
results with others and seek comments as to the problems I see and
whether it is  possible to overcome them and how might I go about it.

My tests are rather simple. I take 1 million samples of the actual
durations of nanosleep() versus the requested 1000 usec duration.

a = gettimeofday();    		/* measure delta time since last sleep */
for (i = 0; i < NUM_SAMPLES; i++) {	/* one million iterations,
typically */
   nanosleep(1000000);   	/* sleep for 1 msec; = 1000 HZ  */
   b = gettimeofday();    	/* measure delta time since last sleep */
   record (b - a);        	/* record the measurement in a histogram */
   a = b;
}

The histogram of the "nanosleep()" tests can be viewed at:

http://www.atl.external.lmco.com/projects/QoS/compare/j_data/linux/2.6.14-rt22/2.6.14-rt22-UNIPROC-tracing-kernel-no-tracing-done.nano.hist.png

The results are excellent with actual sleep durations for
nanosleep(1000 usec) being:

minimum: 1020  (usec)
maximum: 1052
mean: 1030
variance: 3.876
num_points: 1000000

I then repeated this test by replacing nanosleep(1000 usec) with

select(0, 0, 0, 0, 1000usec)

And again measure the observed jitter. The test application is run in
SCHED_FIFO class at priority 60; the softirq-* processes are run at
SCHED_FIFO priority 90. In no case does select() return anything other
than value of zero.

The select() test exepriences severe jitter. Histogram can be viewed
at:

http://www.atl.external.lmco.com/projects/QoS/compare/j_data/linux/2.6.14-rt22/2.6.14-rt22-UNIPROC-tracing-kernel-no-tracing-done.select.out_with_chrt_on_softirq_procs.hist.png

and the summary of observed select() sleep duration samples is:

minimum: 35 (usec)
maximum: 239525
mean: 1373.24
variance: 8.99334e+07
num_points: 1000000

The computer is otherwise unloaded and unused and in a small, private
network. The h/w is a 2.8 GHZ dual Xeon IBM Blade, but I have been
testing with 2.6.14-rt22 UniProcessor  kernel configured with full
preemption and 1000 HZ clock. The kernel is compiled with "preemption
latencry tracing" flags but no tracing is enabled during either of
these two tests.

Data summry in a table form can be seen here:

http://www.atl.external.lmco.com/projects/QoS/compare/cgi-bin/tmp/table_7518.html

My queries are this:

1) are these results believable? I like to think that i am careful
tester, but  error in testing is always possible.

2) Can this jitter in  select() be overcome and can select() get as
good as nanosleep() is now under the "rt" kernel patches?

3) I have tried to do some latency tracing, but I can't seem to learn
anything valulabe as to the cause. I have followed the procedure
outlined by Ingo Molnar, but it is  not clear if "dmesg" or
"/proc/latency_trace" reveal anything of value.

/proc/latency trace is full of lines such as these:

   <...>-3     0.... 20317us : __down_mutex (rt_run_flush)
   <...>-3     0.... 20317us : __up_mutex_savestate (rt_run_flush)
   <...>-3     0.... 20317us : __down_mutex (rt_run_flush)
   <...>-3     0.... 20317us : __up_mutex_savestate (rt_run_flush)
   <...>-3     0.... 20317us : __down_mutex (rt_run_flush)
   <...>-3     0.... 20317us : __up_mutex_savestate (rt_run_flush)
   <...>-3     0.... 20318us : __down_mutex (rt_run_flush)
   <...>-3     0.... 20318us : __up_mutex_savestate (rt_run_flush)
   <...>-3     0.... 20318us : __down_mutex (rt_run_flush)
   <...>-3     0.... 20318us : __up_mutex_savestate (rt_run_flush)
   <...>-3     0.... 20318us : __down_mutex (rt_run_flush)
   <...>-3     0.... 20318us : __up_mutex_savestate (rt_run_flush)
   <...>-3     0.... 20319us : __down_mutex (rt_run_flush)

and

"dmesg" says somethign like this:

(        ubersock-4032 |#0): new 131 us user-latency.
(        ubersock-4032 |#0): new 131 us user-latency.
(        ubersock-4032 |#0): new 133 us user-latency.
(        ubersock-4032 |#0): new 221 us user-latency.
(        ubersock-4032 |#0): new 223 us user-latency.
(        ubersock-4032 |#0): new 20629 us user-latency.
root@blade8>

When tracing I exit my test when a large latency is observed (in the
case above a 20,629 usec value was observed by the "select()" test. 

If there is a more specific real-time newsgroup please direct me to it.

G. Thaker

