Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVCSJdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVCSJdf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 04:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVCSJde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 04:33:34 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:35574 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262436AbVCSJd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 04:33:29 -0500
Message-ID: <423BF1E6.9030902@mvista.com>
Date: Sat, 19 Mar 2005 01:33:26 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean up FIXME in do_timer_interrupt-lock fix
References: <1109869828.2908.18.camel@mindpipe>	<20050303164520.0c0900df.akpm@osdl.org>	<1109899148.3630.5.camel@mindpipe>	<42283857.9050007@mvista.com>	<1109968985.6710.16.camel@mindpipe>	<4228CBFB.3000602@mvista.com>	<1110313644.4600.13.camel@mindpipe>	<422E33F0.6020403@mvista.com>	<4230087E.3080307@mvista.com>	<1110579830.19661.10.camel@mindpipe> <20050311143459.54c74dd0.akpm@osdl.org>
In-Reply-To: <20050311143459.54c74dd0.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060505050405090402040104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------060505050405090402040104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Did you pick this up?  First sent on 3-11.

Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
>>On Thu, 2005-03-10 at 00:42 -0800, George Anzinger wrote:
>>
>>>This patch changes the update of the cmos clock to be timer driven
>>>rather than poll driven by the timer interrupt function.  If the clock
>>>is not being synced to an outside source the timer is removed and thus
>>>system overhead is nill in that case.  The update frequency is still ~11
>>>minutes and missing the update window still causes a retry in 60
>>>seconds.
>>
>>No replies yet.  Are there any objections to this patch?
> 
> 
> Nope.  I think it's neat.  I queued it up.

I had a nightmare about ntp coming in at the "wrong" time resulting in a
deadlock.  Attached locking changes will make me sleep better :)

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/


--------------060505050405090402040104
Content-Type: text/plain;
 name="cmos_time_lock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cmos_time_lock.patch"

Source: MontaVista Software, Inc.
Type: Defect Fix 
Disposition: Pending
Description:

I was not happy with the locking on this.  Two changes:
1) Turn off irq while setting the clock.
2) Call the timer code only through the timer interface 
   (set a short timer to do it from the ntp call).

Signed-off-by: George Anzinger <george@mvista.com>

 time.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.12-rc/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.12-rc.orig/arch/i386/kernel/time.c
+++ linux-2.6.12-rc/arch/i386/kernel/time.c
@@ -176,12 +176,12 @@ static int set_rtc_mmss(unsigned long no
 	int retval;
 
 	/* gets recalled with irq locally disabled */
-	spin_lock(&rtc_lock);
+	spin_lock_irq(&rtc_lock);
 	if (efi_enabled)
 		retval = efi_set_rtc_mmss(nowtime);
 	else
 		retval = mach_set_rtc_mmss(nowtime);
-	spin_unlock(&rtc_lock);
+	spin_unlock_irq(&rtc_lock);
 
 	return retval;
 }
@@ -338,7 +338,7 @@ static void sync_cmos_clock(unsigned lon
 }
 void notify_arch_cmos_timer(void)
 {
-	sync_cmos_clock(0);
+	mod_timer(&sync_cmos_timer, jiffies + 1);
 }
 static long clock_cmos_diff, sleep_start;
 


--------------060505050405090402040104--

