Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVHRDNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVHRDNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 23:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVHRDNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 23:13:11 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:64189 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932119AbVHRDNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 23:13:10 -0400
Subject: Re: Latency with Real-Time Preemption with 2.6.12
From: Steven Rostedt <rostedt@goodmis.org>
To: Sundar Narayanaswamy <sundar007@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20050818023853.48406.qmail@web54406.mail.yahoo.com>
References: <20050818023853.48406.qmail@web54406.mail.yahoo.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 23:12:46 -0400
Message-Id: <1124334766.5186.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 19:38 -0700, Sundar Narayanaswamy wrote:
> Hi,
> I am trying to experiment using 2.6.12 kernel with the realtime-preempt 
> V0.7.51-38 patch to determine the kernel preemption latencies with the 
> CONFIG_PREEMPT_RT mode. The test program I wrote does the following on
> a thread with highest priority (99) and SCHED_FIFO policy to simulate
> a real time thread.
> 
> t1 = gettimeofday
> nanosleep(for 3 ms)
> t2 = gettimeofday
> 
> I was expecting to see the difference t2-t1 to be close to 3 ms. However, 
> the smallest difference I see is 4 milliseconds under no system load, 
> and the difference is as high as 25 milliseconds under moderate to 
> heavy system load (mostly performing disk I/O).

That version of Ingo's patch does not implement High-Resolution Timers.
Thomas worked on merging this into the latest RT patch.  Without
high-res timers, the best you may ever get is 4ms. This is because
nanosleep is to guarantee _at_least_ 3 ms.  So you have the following
situation:

0               1               2                3               4 (ms)
+---------------+---------------+----------------+---------------+--->
           ^                                        ^
           |                                        |
         Start here 0+3 = 3                      here we have the response

If we look at this in smaller units than ms, we started on 0.8ms and
responded at 3.2ms where we have 3.2 - 0.8 = 2.4 which is less than 3ms.
So since Ingo's patch doesn't increase the resolution of the timers from
a jiffy (which is currently 1ms) Linux is forced to add one more than
you need.

> 
> Based on the articles and the mails I read on this list, I understand that 
> worst case latencies of 1 ms (or less) should be possible using the RT 
> Preemption patch, but I am unable to get anything less than 4 millseconds 
> even with sleep times smaller than 3 ms. I am running the tests on a SBC 
> with a 1.4G Pentium M, 512M RAM, 1GB compact flash (using IDE). 
> 
> I believe I have the high resolution timer working correctly, because if I 
> comment out the sleep line above t2-t1 is consistenly 0 or 1 microsecond.

I don't think you have the high res timer working, since there is no
high res timer in that kernel.

> 
> Following earlier discussions (in July) in this list, I tried to set kernel 
> configuration parameters like CONFIG_LATENCY_TRACE to get tracing/debug 
> information, but I didn't find these parameters in my .config file.
> 
> I appreciate your suggestions/insights into the situation and steps that I 
> should try to get more debug/tracing information that might help to understand 
> the cause of high latency.

It's not a high latency.  It's doing exactly as it is suppose to, since
the nanosleep doesn't have high-res support (in that kernel).  If you
really want to measure latency, you need to add a device or something
and see what the response time of an interrupt going off to the time a
thread is woken to respond to it.  Now with Ingo's that is really fast.

-- Steve


