Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVCJIm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVCJIm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 03:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVCJImz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 03:42:55 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:11000 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262428AbVCJImp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 03:42:45 -0500
Message-ID: <4230087E.3080307@mvista.com>
Date: Thu, 10 Mar 2005 00:42:38 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: george@mvista.com, Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean up FIXME in do_timer_interrupt
References: <1109869828.2908.18.camel@mindpipe>	 <20050303164520.0c0900df.akpm@osdl.org> <1109899148.3630.5.camel@mindpipe>	 <42283857.9050007@mvista.com> <1109968985.6710.16.camel@mindpipe>	 <4228CBFB.3000602@mvista.com> <1110313644.4600.13.camel@mindpipe> <422E33F0.6020403@mvista.com>
In-Reply-To: <422E33F0.6020403@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------040700050600040006090102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------040700050600040006090102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ok, here is a patch.  See what you think.  This patch assumes that Lee's patch 
has been merged (although it eliminates all of it).

George

George Anzinger wrote:
> Lee Revell wrote:
> 
>> On Fri, 2005-03-04 at 12:58 -0800, George Anzinger wrote:
>>
>>> Lee Revell wrote:
>>>
>>>> On Fri, 2005-03-04 at 02:28 -0800, George Anzinger wrote:
>>>> The thing that brought this code to my attention is that with 
>>>> PREEMPT_RT
>>>> this happens to be the longest non-preemptible code path in the kernel.
>>>> On my 1.3 Ghz machine set_rtc_mmss takes about 50 usecs, combined with
>>>> the rest of timer irq we end up disabling preemption for about 90 
>>>> usecs.
>>>> Unfortunately I don't have the trace anymore.
>>>>
>>>> Anyway the upshot is if we hung this off a timer it looks like we would
>>>> improve the worst case latency with PREEMPT_RT by almost 50%.  Unless
>>>> there is some reason it has to be done synchronously of course.
>>>
>>>
>>> Well, it does have to be done at the right WRT the second, but I 
>>> suspect we can hit that as well with a timer as it is hit now.  Also, 
>>> if we are _really_ off the mark, this can be defered till the next 
>>> second.
>>>
>>
>>
>> Do you have a patch?
> 
> 
> Not at the moment, but I will work one up.
> 
>>
>> Andrew merged my trivial patch to clean up the logic, but a real fix
>> would be better.
>>
>> Lee
>>
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

--------------040700050600040006090102
Content-Type: text/plain;
 name="cmos-time-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cmos-time-fix.patch"

Source: MontaVista Software, Inc. George Anzinger george@mvista.com
Type:  Enhancement 
Disposition: pending
Description:

This patch changes the update of the cmos clock to be timer driven
rather than poll driven by the timer interrupt function.  If the clock
is not being synced to an outside source the timer is removed and thus
system overhead is nill in that case.  The update frequency is still ~11
minutes and missing the update window still causes a retry in 60
seconds.

signed off by George Anzinger george@mvista.com

 arch/i386/kernel/time.c |   67 +++++++++++++++++++++++++++++++++---------------
 kernel/time.c           |    9 ++++++
 2 files changed, 56 insertions(+), 20 deletions(-)

Index: linux-2.6.12-rc/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.12-rc.orig/arch/i386/kernel/time.c
+++ linux-2.6.12-rc/arch/i386/kernel/time.c
@@ -186,8 +186,6 @@ static int set_rtc_mmss(unsigned long no
 	return retval;
 }
 
-/* last time the cmos clock got updated */
-static long last_rtc_update;
 
 int timer_ack;
 
@@ -239,24 +237,6 @@ static inline void do_timer_interrupt(in
 
 	do_timer_interrupt_hook(regs);
 
-	/*
-	 * If we have an externally synchronized Linux clock, then update
-	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
-	 * called as close as possible to 500 ms before the new second starts.
-	 */
-	if ((time_status & STA_UNSYNC) == 0 &&
-	    xtime.tv_sec > last_rtc_update + 660 &&
-	    (xtime.tv_nsec / 1000)
-			>= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
-	    (xtime.tv_nsec / 1000)
-			<= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
-	        last_rtc_update = xtime.tv_sec;
-		if (efi_enabled) {
-		    if (efi_set_rtc_mmss(xtime.tv_sec))
-			last_rtc_update -= 600;
-		} else if (set_rtc_mmss(xtime.tv_sec))
-			last_rtc_update -= 600;
-	}
 
 	if (MCA_bus) {
 		/* The PS/2 uses level-triggered interrupts.  You can't
@@ -313,7 +293,54 @@ unsigned long get_cmos_time(void)
 
 	return retval;
 }
+static void sync_cmos_clock(unsigned long dummy);
 
+static struct timer_list sync_cmos_timer = 
+                                      TIMER_INITIALIZER(sync_cmos_clock, 0, 0);
+
+static void sync_cmos_clock(unsigned long dummy)
+{
+	struct timeval now, next;
+	int fail = 1;
+	/*
+	 * If we have an externally synchronized Linux clock, then update
+	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
+	 * called as close as possible to 500 ms before the new second starts.
+	 * This code is run on a timer.  If the clock is set, that timer
+	 * may not expire at the correct time.  Thus, we adjust...
+	 */
+	if ((time_status & STA_UNSYNC) != 0)
+		/*
+		 * Not synced, exit, do not restart a timer (if one is 
+		 * running, let it run out).
+		 */
+		return;
+
+	do_gettimeofday(&now);
+	if (now.tv_usec >= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
+	    now.tv_usec <= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
+		fail = set_rtc_mmss(now.tv_sec);
+	}
+	next.tv_usec = USEC_AFTER - now.tv_usec;
+	if (next.tv_usec <= 0)
+		next.tv_usec += USEC_PER_SEC;
+	if (!fail) {
+		next.tv_sec = 659;
+	} else {
+		next.tv_sec = 0;
+	}
+	if (next.tv_usec >= USEC_PER_SEC) {
+		next.tv_sec++;
+		next.tv_usec -= USEC_PER_SEC;
+	}
+	sync_cmos_timer.expires = jiffies + timeval_to_jiffies(&next);
+	add_timer(&sync_cmos_timer);
+		
+}
+void notify_arch_cmos_timer(void)
+{
+	sync_cmos_clock(0);
+}
 static long clock_cmos_diff, sleep_start;
 
 static int timer_suspend(struct sys_device *dev, u32 state)
Index: linux-2.6.12-rc/kernel/time.c
===================================================================
--- linux-2.6.12-rc.orig/kernel/time.c
+++ linux-2.6.12-rc/kernel/time.c
@@ -215,6 +215,14 @@ long pps_stbcnt;		/* stability limit exc
 /* hook for a loadable hardpps kernel module */
 void (*hardpps_ptr)(struct timeval *);
 
+/* we call this to notify the arch when the clock is being
+ * controlled.  If no such arch routine, do nothing.
+ */
+void __attribute__ ((weak)) notify_arch_cmos_timer(void)
+{
+	return;
+}
+
 /* adjtimex mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
@@ -398,6 +406,7 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	txc->stbcnt	   = pps_stbcnt;
 	write_sequnlock_irq(&xtime_lock);
 	do_gettimeofday(&txc->time);
+	notify_arch_cmos_timer();
 	return(result);
 }
 

--------------040700050600040006090102--

