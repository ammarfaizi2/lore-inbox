Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266207AbUGOXAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266207AbUGOXAc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 19:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUGOXAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 19:00:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38394 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266207AbUGOXAV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 19:00:21 -0400
Message-ID: <40F70C6D.5050506@mvista.com>
Date: Thu, 15 Jul 2004 15:59:57 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Christoph Lameter <clameter@sgi.com>, lkml <linux-kernel@vger.kernel.org>,
       ia64 <linux-ia64@vger.kernel.org>
Subject: Re: gettimeofday nanoseconds patch (makes it possible for the	posix-timer
 functions to return higher accuracy)
References: <Pine.LNX.4.58.0407140940260.14704@schroedinger.engr.sgi.com> <1089835776.1388.216.camel@cog.beaverton.ibm.com>
In-Reply-To: <1089835776.1388.216.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Wed, 2004-07-14 at 09:41, Christoph Lameter wrote:
> 
>>I am working on some timer issues for the IA64 in order to make the timers
>>more efficient and return results with a higher accuracy.
>>
>>However, in various locations do_gettimeofday is used and then the
>>resulting usecs are multiplied by 1000 to obtain nanoseconds. This is in
>>particular problematic for the posix timers and especially clock_gettime.
>>
>>The following patch introduces a new gettimeofday function using
>>struct timespec instead of struct timeval. If a platforms supports time
>>interpolation then the new gettimeofday will use that to provide a
>>gettimeofday function with higher accuracy and then also clock_gettime
>>will return with nanosecond accuracy.
> 
> 
> Honestly, I'm not a fan of the patch. It realistically only helps ia64
> and and adds more confusing code to the generic time code. If there
> isn't an real/immediate need for this, I'd wait to 2.7 for a better
> cleanup. 
> 
> None the less, I do understand the desire for the change (and am working
> to address it in 2.7), so could you at least use a better name then
> gettimeofday()? Maybe get_ns_time() or something? Its just too similar
> to do_gettimeofday and the syscall gettimeofday(). 
> 
> Really, I feel the cleaner method is to fix do_gettimeofday() so it
> returns a timespec and then convert it to a timeval in
> sys_gettimeofday(). However this would add overhead to the syscall, so I
> doubt folks would go for it.

Uh, I don't think it adds any overhead.  If the get_offset code returns 
nanoseconds which is added to xtime you get a timespec which you then convert to 
the timeval.  Currently the get_offset code returns usec so the xtime is first 
converted to timeval and then the add is done.  So the timespec to timeval 
conversion is done in both cases.

As to accuracy, the more "accurate" way is to change get_offset to return 
nanoseconds.  This way there is only one round off (by the divide) instead of 
two (the get_offset and the divide).  I ran into this problem in the latest HRT 
patch.  One of my tests is to do a gettimeofday and a clock_gettime and make 
sure there is no "backward" stuff happening.  Test failed by 1 micro second 
"some" of the time because of this double round off.

To fix this the HRT patch changes do_gettimeofday to use the get_offset the 
patch provides to do the full high-res thing.

Oh, and by the way, the divide in the conversion of nsec to usec is not really a 
divide due to the magic of the gcc optimizer.

I actually promised John I would provide a patch to do this, but, well, we have 
customers....

-g
> 
> 
>>I would be interested in feedback on this approach. In this context
>>the time interpolator patches that are being discussed on linux-ia64
>>would also be of interest. Those provide a generic way to utilize
>>any memory mapped or CPU counter to do the time interpolations for any
>>platforms and would allow an easy way to realize a nanosecond resolution
>>for all platforms.
> 
> 
> I think the ia64 time interpolation code is a step in the right
> direction (def better then the i386 bits), but it still isn't the
> cleanest and clearest way. My plan is to select a reliable timesource
> for the system, then use a periodic interrupt to accumulate time from
> the timesource (in order to avoid overflows). This avoids lost tick
> issues and cleanly separates the timer subsystem from the time of day
> subsystem.
> 
> 
>>The patch is against 2.6.8-rc1
>>
>>Index: linux-2.6.7/kernel/time.c
>>===================================================================
>>--- linux-2.6.7.orig/kernel/time.c
>>+++ linux-2.6.7/kernel/time.c
>>@@ -421,6 +421,40 @@
>>
>> EXPORT_SYMBOL(current_kernel_time);
>>
>>+#ifdef TIME_INTERPOLATION
>>+void gettimeofday (struct timespec *tv)
>>+{
>>+        unsigned long seq;
>>+
>>+        do {
>>+                seq = read_seqbegin(&xtime_lock);
>>+                tv->tv_sec = xtime.tv_sec;
>>+                tv->tv_nsec = xtime.tv_nsec+time_interpolator_get_offset();
>>+        } while (unlikely(read_seqretry(&xtime_lock, seq)));
>>+
>>+        while (unlikely(tv->tv_nsec >= NSEC_PER_SEC)) {
>>+                tv->tv_nsec -= NSEC_PER_SEC;
>>+                ++tv->tv_sec;
>>+        }
>>+}
> 
> 
> You'll need to cap time_interpolator_get_offset() at the maximum NTP
> tick size, or else you may have time go backwards right after a timer
> interrupt. 
> 
> thanks
> -john
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

