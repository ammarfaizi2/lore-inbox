Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVIYVkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVIYVkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVIYVkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 17:40:25 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:30623
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932302AbVIYVkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 17:40:25 -0400
Subject: Re: HRT on opteron / rt14 on opteron
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Darren Hart <dvhltc@us.ibm.com>
Cc: Geoff Levand <geoffrey.levand@am.sony.com>, george@mvista.com,
       "Theodore Ts'o" <tytso@mit.edu>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       "lkml," <linux-kernel@vger.kernel.org>, dino@us.ibm.com,
       Paul McKenney <paulmck@us.ibm.com>,
       "Sarma, Dipankar" <dipankar@in.ibm.com>
In-Reply-To: <433489F6.9080203@us.ibm.com>
References: <432F21D1.90209@us.ibm.com> <432F5A44.9010208@am.sony.com>
	 <433489F6.9080203@us.ibm.com>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 25 Sep 2005 23:41:00 +0200
Message-Id: <1127684460.15115.116.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-23 at 16:04 -0700, Darren Hart wrote:
> I am trying to run all the tests in the above tarball on a 2.6.13 kernel with 
> ktimers+tod+hrt + a hrt compatibility patch which uses the normal clocks when a 
> _HR clock is requested since ktimers treats them the same.  I remember there 
> used to be a run_tests script or something when this was a kernel patch, but I 

do_test

> am not seeing that or any kind of documentation on how to interpret the output 
> of the tests which output numbers rather than pass/fail.  For instance:
> 
> # ./1-4
> it value left is 3 999985323
> What does that even mean?  

Cryptic POSIX compliance test output.

The test does the following:

Arm a timer with 2 seconds and a intervall of 5 seconds
(signal to deliver is SIGCONT).

Sleep for 3 seconds

Read the remaining time for the timer

The flow of events is

0	arm timer
 	sleep(3)

0+2sec	timer expires and interupts the sleep. 
	The delivered signal is sigcont, so the sleep is resumed and sleeps the
full 3 seconds. Timer is rearmed with 5 secs.

0+3sec  sleep returns
	  timer_gettime() is called to retrieve the time until the next expiry
of the timer, which should be ~4sec.



> Should I only be running executables that end in 
> -test perhaps?  Are some of these for use by the other tests?

do_test is the script running all the relevant tests AFAICT.


> # ./clock_nanosleep
> Clock resolution        1.000 usec
> Requested delay    actual delay(sec) error(sec)
>   4.000001000      4.000015298     0.000014298
> 
> Looks like clock_nanosleep has errors < 15 usecs, actually seems like a lot for 
> a kernel built with 1us resolution (unloaded) - or does this test include some load?

No. Yoe see the following

t1 = gettime()
nanosleep()
	timer is programmed
timer event interrupt happens
	soft interrupt is invoked
soft interrupt wakes task
return from nanosleep
t2 = gettime()
delta = t2 - t1

So what you see is the overhead of syscalls, the possible interrupt
delay and the overhead of the softirq and the task switch / return to
userspace.

> # ./nanosleep_jitter
> Iteration iter time (secs)           min sleep max sleep
>    0        0.051953  0.051952 0.000052    0.000052
>    1        0.051953  0.051952 0.000052    0.000052
>    ...
> 
> Is this what is expected?  I believe the test intends to sleep for .05 seconds 
> (50 milliseconds), I seem to be sleeping an extra 2 milliseconds.  Seems like a 
> lot actually.

The tests sleeps for 1000 x 50us = 50ms. So having a sleep of ~52usec
each time gives you the 52ms per test

> # ./sigevthread-test
> perror: Invalid argument
> timer_create failed.
> 
> I gather is a conflict with the ktimer implementation?

I think not. It never worked for me. I ignored it as it is not part of
the do_test tests.

> 
> # ./timerlimit
> 7168: timer id = 7167
> timer_create: Resource temporarily unavailable
> 
> Is that a reasonable number of successfully created clocks?

Depends on the number of timers available on your system. But sounds
reasonable.

I have no idea about the plots. George ?

tglx


