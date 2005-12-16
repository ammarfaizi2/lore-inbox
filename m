Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVLPDKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVLPDKP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbVLPDKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:10:15 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:41453 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751290AbVLPDKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:10:13 -0500
Subject: Re: severe jitter experienced with "select()" in linux 2.6.14-rt22
From: Steven Rostedt <rostedt@goodmis.org>
To: Gautam Thaker <gthaker@comcast.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <43A21324.2050905@comcast.net>
References: <43A21324.2050905@comcast.net>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 22:09:58 -0500
Message-Id: <1134702598.13138.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please always CC Ingo Molnar on all -rt related issues.  And Thomas
Gleixner and John Stultz on timer issues with -rt. (CC John on timer
issues in mainline too).


On Thu, 2005-12-15 at 20:06 -0500, Gautam Thaker wrote:
> I have been conduting some jitter tests on 2.6.14-rt22.  (Many thanks
> to Ingo Molnar who has helped in various ways.) I wanted to share the
> results with others and seek comments as to the problems I see and
> whether it is  possible to overcome them and how might I go about it.

Hmm, it seems you know you should have CC'd Ingo ;)

> 
> My tests are rather simple. I take 1 million samples of the actual
> durations of nanosleep() versus the requested 1000 usec duration.
> 
> a = gettimeofday();    		/* measure delta time since last sleep */
> for (i = 0; i < NUM_SAMPLES; i++) {	/* one million iterations,
> typically */
>    nanosleep(1000000);   	/* sleep for 1 msec; = 1000 HZ  */
>    b = gettimeofday();    	/* measure delta time since last sleep */
>    record (b - a);        	/* record the measurement in a histogram */
>    a = b;
> }
> 
> The histogram of the "nanosleep()" tests can be viewed at:
> 
> http://www.atl.external.lmco.com/projects/QoS/compare/j_data/linux/2.6.14-rt22/2.6.14-rt22-UNIPROC-tracing-kernel-no-tracing-done.nano.hist.png
> 
> The results are excellent with actual sleep durations for
> nanosleep(1000 usec) being:
> 
> minimum: 1020  (usec)
> maximum: 1052
> mean: 1030
> variance: 3.876
> num_points: 1000000
> 
> I then repeated this test by replacing nanosleep(1000 usec) with
> 
> select(0, 0, 0, 0, 1000usec)

Well, I hope you passed in a variable here.  I'm sure you did.

> 
> And again measure the observed jitter. The test application is run in
> SCHED_FIFO class at priority 60; the softirq-* processes are run at
> SCHED_FIFO priority 90. In no case does select() return anything other
> than value of zero.
> 
> The select() test exepriences severe jitter. Histogram can be viewed
> at:

Is there any requirement that select must sleep the full time? At least
have you checked the value of the timeout to see if there was reported
time left?  The return value wont be zero.  I believe that the select my
return early with reported time left.
 
> 
> http://www.atl.external.lmco.com/projects/QoS/compare/j_data/linux/2.6.14-rt22/2.6.14-rt22-UNIPROC-tracing-kernel-no-tracing-done.select.out_with_chrt_on_softirq_procs.hist.png
> 
> and the summary of observed select() sleep duration samples is:

The simple answer is that the select system call uses the non high
resolution timers.  There's really no reason to use select for timing.
That's really just a side effect of the system call.  If you need
accurate timing, that's what nanosleep is for.  IIRC, others on LKML
have stated that it is considered bad programming to use select as a
timer when nanosleep is available.

So, what you show is what I would expect.

-- Steve


