Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbUKWDuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbUKWDuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 22:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbUKVS4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:56:19 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:40431 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S262297AbUKVSzt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:55:49 -0500
Message-ID: <41A235E0.8050405@mvista.com>
Date: Mon, 22 Nov 2004 10:54:24 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Li Shaohua <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH]time run too fast after S3
References: <1101114923.14572.8.camel@sli10-desk.sh.intel.com> <1101148405.6735.107.camel@cog.beaverton.ibm.com>
In-Reply-To: <1101148405.6735.107.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Mon, 2004-11-22 at 01:15, Li Shaohua wrote:
> 
>>after resume from S3, 'date' shows time run too fast. Here is a patch.
> 
> [snip]
> 
>>diff -puN arch/i386/kernel/time.c~wall_jiffies arch/i386/kernel/time.c
>>--- 2.6/arch/i386/kernel/time.c~wall_jiffies	2004-11-22 17:04:42.720038352 +0800
>>+++ 2.6-root/arch/i386/kernel/time.c	2004-11-22 17:06:21.373040816 +0800
>>@@ -343,12 +343,13 @@ static int timer_resume(struct sys_devic
>> 		hpet_reenable();
>> #endif
>> 	sec = get_cmos_time() + clock_cmos_diff;
>>-	sleep_length = get_cmos_time() - sleep_start;
>>+	sleep_length = (get_cmos_time() - sleep_start) * HZ;
>> 	write_seqlock_irqsave(&xtime_lock, flags);
>> 	xtime.tv_sec = sec;
>> 	xtime.tv_nsec = 0;
>> 	write_sequnlock_irqrestore(&xtime_lock, flags);
>>-	jiffies += sleep_length * HZ;
>>+	jiffies += sleep_length;
>>+	wall_jiffies += sleep_length;
>> 	return 0;
>> }
> 
> 
> I'm not all that familiar w/ the suspend code, but yea, this looks like
> an improvement.  The previous code was wrong because they are setting
> xtime themselves, and then updating only jiffies. At the next timer
> interrupt, the difference between jiffies and wall_jiffies would then be
> added to xtime again. 
> 
> Why they don't just use do_settimeofday() for all of this is a mystery
> to me. Are we wanting to pretend timer ticks arrived while we were
> suspended?

I think that this way the uptime and start times of init and friends will be 
much more correct.  settimeofday() would move those around.  So, the short 
answer is, yes.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

