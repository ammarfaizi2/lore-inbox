Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262945AbVFXALq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbVFXALq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 20:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbVFXAJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 20:09:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50427 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262915AbVFXAJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 20:09:24 -0400
Message-ID: <42BB4EEC.7050007@mvista.com>
Date: Thu, 23 Jun 2005 17:08:12 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: high-res-timers-discourse@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: HRT proposal (on top of timeofday and soft-timer rework)
References: <20050607013403.GA4706@us.ibm.com> <42A77AD1.3030807@mvista.com> <20050616211830.GA2774@us.ibm.com>
In-Reply-To: <20050616211830.GA2774@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan wrote:
> George,
> 
> Thank you for your thoughtful response. Sorry for the long delay in my
> reply! I hope you have seen my new patch, which tries to accommodate your
> suggestions. I also have some more pseudo code for you! (read the new
> code before replying to my old comments, since most of them no longer
> apply).
> 
> On 08.06.2005 [16:10:09 -0700], George Anzinger wrote:
> 
~
>>I am most concerned about MMAX_HRT_REQ.  The HR timer list is an ordered 
>>list and if kept small a simple O(N/2) list structure works fine.  If 
>>MMAX_HRT_REQ get too large, this assumption fails and we will have list 
>>access timing issues. In looking at the structure for this list in the 
>> current patch, I concluded that more complex list structures may have a 
>>lower order but also carry a higher fixed cost.  In other words the access 
>>time is:
>>
>>FIXED_OVERHEAD+O(*)
>>
>>Once you move away from the simple O(N/2) structure into RB trees, for 
>>example, the FIXED_OVERHEAD part of the access time goes up so the pay out 
>>for small N is just not there.  For this reason, we want to keep the HR 
>>timer list small which means, in your case, keeping MMAX_HRT_REQ as small 
>>as possible.
> 
> 
> I think we have found a reasonable way to avoid the risk of this
> complexity (we being myself, Darren Hart and John Stultz, both of whom I
> much of these ideas to).
> 
> OK, here is the new pseudo code, finally! When I refer to
> unchanged/identical code, I mean relative to mainline, not to my
> previous pseudo code.
> 
> -----------------------------------------------
> 
> struct timer_list
> 	/* keep all existing fields and add ... */
> 	nsec_t expires_nsecs;
> 
> #define TIMER_MAGIC		0x4b87ad6e	/* in the existing code */
> #define HRTIMER_MAGIC		0x4b87ad6f	/* added, and now we can mask w/ ...*/
> #define HRTIMER_MAGIC_MASK	0x1		/* added, the only bit
> 						 * different between LR and HR magic
> 						 * fields */
> 
> init_hrtimer(timer)
> 	/* identical to init_timer() except ... */
> 	timer->magic = HRTIMER_MAGIC
> 
> set_timer_nsecs()
> 	/* identical except ... */
> 	if (timer->magic & HRTIMER_MAGIC_MASK)
> 		notify hr-subsytem that a new hrtimer has been added (if
> 		it's expires is before the next interrupt?)
> 
> We will adjust the timer expiration alogrithm as follows (currently this
> is in run_timer_softirq() / __run_timers()). This callback sequence will
> be executed on *both* the low-res and high-res soft-timer interrupt!:
> 
> soft_timer_callback:
>   nsec_t now_nsecs = do_monotonic_clock()
>   unsigned long now_timerintervals =
>   	nsecs_to_timerintervals_floor(now_nsecs)
>   __run_timers(base, now_timerintervals) /* catch up *all* timers previous
> 					    to the current interval */
> 				      	/* unless we've missed ticks,
> 					   this will do nothing if this
> 					   is a high-res interrupt */
> 					/* maybe extend this function to
> 					   return the time of the next
> 					   low-res interrupt (VST) */ <<<<<<<<<<<<<<<<<
>   nsec_t next_hrt_interrupt = __run_hrtimers(now_nsecs)
> 						/* alogrithm below */
> 						/* and this should,
> 						   likewise, do nothing
> 						   in the low-res case
> 						 */
>   schedule_hrt_interrupt(next_hrt_interrupt) /* interact with h/w */
> 
> Depending on how long soft_timer_callback takes to run, we may actually
> need to put it in a loop, to catch any reprogramming the interrupt
> source to go off right now
> 
> __run_hrtimers(nsec_t now_nsecs)
> 	this function *must* be run after __run_timers() with
> 		nsecs_to_timerintervals_floor(now_nsecs), thus
> 		guaranteeing all soft-timers before that converted value
> 		have already been expired
> 	traverse the current bucket of timers, expiring *all* timers
> 		with timer->expires_nsecs < now_nsecs
> 	store the expires_nsecs field of the first high-res timer seen
> 		satisfying timer->expires_nsecs > now_nsecs
> 		if no such timer is found, keep checking up to
> 			HZ_to_timerintervals(2) intervals away from now
> 			(2 ticks is adjustable, I suppose) (anything
> 			further may be too time-consuming / unnecessary)
> 		if a satisfying timer is found, return
> 			timer->expires_nsecs, the next hrt interrupt's
> 			time
> 		if not, return 0 (none found)

This fixes what?  It seems to me that you still have the possibility of time 
inversion between the two.  Also, unless you put the timers in the list in 
sorted order, there may be inversion within the HR group.

Lets step back a few steps...

There are a couple of issues I think need to be explored here.

First is the whole notion of moving away from the jiffie.  For better or worse, 
the jiffie ~= 1/HZ, is visible in user land.  But, and I think, more 
importantly, it is tuned to the hardware in that it is currently defined as the 
best the hardware can do to come up with ticks at a HZ per second rate.  In the 
case where the hardware can not exactly match a 1/HZ rate (as for HZ=1000), the 
jiffie is changed to what the hardware can do.  In your timer list you are 
choosing buckets (apparently) based on the ease of calculation of the interval 
given a nanosecond request.  I have not done the whole conversion overhead 
analisis on this choice (it should be done), but the hard fact is that the timer 
list is processed on interrupt and _should_ be set up to match what the hardware 
can do.

So now the issue of what "low res" resolution is comes up.  Is this resolution 
arbitrary or is it exactly what you are calling a timerinterval?  If I make a 
request for a low res timer that is to repeat at a 1 nanosecond rate, the system 
is to set the repeat rate to the resolution (round up according to the 
standard).  Further, I can read this value either via posix_getres() or by 
timer_gettime() so the resolution is visible from user land.  I don't see any 
thing in your code (as yet) to set this resolution.  In any case, it is a fixed 
number.  It seems to me that you have a choice here of either "timerintervals" 
or "the hardware interrupt rate" or "1/HZ".  If it is any thing other than the 
hardware interrupt rate, the actual expire times will drift around within this 
resolution (what customers call jitter) due to the drifting of the hardware 
interrupt WRT the resolution.

I notice that you are still using the cascade timer list.  This list is ideal 
for then normal timer insert, remove, expire operations.  Even timers that are 
inserted in the cascade area are _usually_ removed prior to being the subject of 
a cascade.  On the other hand, it is a real bear of a list to find the "next" 
timer to expire.  The VST operation, thus, should be reserved for the idle task 
and NOT depend on any thing one does in the normal course of handling timers.

Now, back to your proposal.  What you have is very much like the structure that 
I abandoned early this year, i.e. an integrated HR and LR timer list.  The 
reasons for my moving away from it are that it requires that timers in each 
bucket be ordered, thus what was an O(1) insert becomes O(N/M*2) (where M is the 
number of buckets).  Further, this overhead is done at timer insert time and 
introduces additional overhead even if there are no HR timers in the given 
bucket.  It also adds complexity to both the add_timer and run_timer code.  It 
also does the full run_timer overhead for each HR timer interrupt, said overhead 
possibly being higher than code to _just_ handle a simple HR this period only 
list.  By not ordering the timers until just prior to expire time, most of those 
that will never expire will have been pulled from the list already, thus 
reducing the ordering overhead.  There are also complexity issues around 
requests for a timer that has already expired that I handled better with the 
dual list approach.

I have gotten feedback on both the before and after HRT code with the before 
being negative and the after positive.

Could you remind us of why you are redoing the timers?  What is the objective of 
this?
> ~

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
