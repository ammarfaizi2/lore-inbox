Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVHRW3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVHRW3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVHRW3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:29:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46318 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932502AbVHRW33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:29:29 -0400
Message-ID: <43050BBB.2020609@mvista.com>
Date: Thu, 18 Aug 2005 15:29:15 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Sundar Narayanaswamy <sundar007@yahoo.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Latency with Real-Time Preemption with 2.6.12
References: <20050818023853.48406.qmail@web54406.mail.yahoo.com> <1124334766.5186.35.camel@localhost.localdomain>
In-Reply-To: <1124334766.5186.35.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Wed, 2005-08-17 at 19:38 -0700, Sundar Narayanaswamy wrote:
> 
>>Hi,
>>I am trying to experiment using 2.6.12 kernel with the realtime-preempt 
>>V0.7.51-38 patch to determine the kernel preemption latencies with the 
>>CONFIG_PREEMPT_RT mode. The test program I wrote does the following on
>>a thread with highest priority (99) and SCHED_FIFO policy to simulate
>>a real time thread.
>>
>>t1 = gettimeofday
>>nanosleep(for 3 ms)
>>t2 = gettimeofday
>>
>>I was expecting to see the difference t2-t1 to be close to 3 ms. However, 
>>the smallest difference I see is 4 milliseconds under no system load, 
>>and the difference is as high as 25 milliseconds under moderate to 
>>heavy system load (mostly performing disk I/O).
> 
> 
> That version of Ingo's patch does not implement High-Resolution Timers.
> Thomas worked on merging this into the latest RT patch.  Without
> high-res timers, the best you may ever get is 4ms. This is because
> nanosleep is to guarantee _at_least_ 3 ms.  So you have the following
> situation:
> 
> 0               1               2                3               4 (ms)
> +---------------+---------------+----------------+---------------+--->
>            ^                                        ^
>            |                                        |
>          Start here 0+3 = 3                      here we have the response
> 
> If we look at this in smaller units than ms, we started on 0.8ms and
> responded at 3.2ms where we have 3.2 - 0.8 = 2.4 which is less than 3ms.
> So since Ingo's patch doesn't increase the resolution of the timers from
> a jiffy (which is currently 1ms) Linux is forced to add one more than
> you need.
> 
> 
>>Based on the articles and the mails I read on this list, I understand that 
>>worst case latencies of 1 ms (or less) should be possible using the RT 
>>Preemption patch, but I am unable to get anything less than 4 millseconds 
>>even with sleep times smaller than 3 ms. I am running the tests on a SBC 
>>with a 1.4G Pentium M, 512M RAM, 1GB compact flash (using IDE). 
>>
>>I believe I have the high resolution timer working correctly, because if I 
>>comment out the sleep line above t2-t1 is consistenly 0 or 1 microsecond.
> 
> 
> I don't think you have the high res timer working, since there is no
> high res timer in that kernel.
> 
> 
>>Following earlier discussions (in July) in this list, I tried to set kernel 
>>configuration parameters like CONFIG_LATENCY_TRACE to get tracing/debug 
>>information, but I didn't find these parameters in my .config file.
>>
>>I appreciate your suggestions/insights into the situation and steps that I 
>>should try to get more debug/tracing information that might help to understand 
>>the cause of high latency.
> 
> 
> It's not a high latency.  It's doing exactly as it is suppose to, since
> the nanosleep doesn't have high-res support (in that kernel).  If you
> really want to measure latency, you need to add a device or something
> and see what the response time of an interrupt going off to the time a
> thread is woken to respond to it.  Now with Ingo's that is really fast.

Another way to do it is to set up a repeating timer.  You _must_ read 
back the timer to get the repeat time it is really using, and then 
measure how well it does giving signals at these repeat times.  FAR FAR 
more than three lines of code...
> 
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
