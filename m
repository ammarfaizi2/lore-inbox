Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269710AbUICSRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269710AbUICSRZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269722AbUICSOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:14:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39675 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269701AbUICSL4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:11:56 -0400
Message-ID: <4138B343.4000201@mvista.com>
Date: Fri, 03 Sep 2004 11:09:07 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
CC: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       albert@users.sourceforge.net, clameter@sgi.com,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday i386 hooks (v.A0)
References: <1094159492.14662.325.camel@cog.beaverton.ibm.com> <41384277.1310.82E30C@rkdvmks1.ngate.uni-regensburg.de>
In-Reply-To: <41384277.1310.82E30C@rkdvmks1.ngate.uni-regensburg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Windl wrote:
> On 2 Sep 2004 at 18:44, George Anzinger wrote:
> 
> 
~

>>>+#endif
>>> 
>>>+void sync_persistant_clock(struct timespec ts)
>>>+{
>>>+	/*
>>>+	 * If we have an externally synchronized Linux clock, then update
>>>+	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
>>>+	 * called as close as possible to 500 ms before the new second starts.
>>>+	 */
>>>+	if (ts.tv_sec > last_rtc_update + 660 &&
>>>+	    (ts.tv_nsec / 1000)
>>>+			>= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
>>>+	    (ts.tv_nsec / 1000)
>>>+			<= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
>>>+		/* horrible...FIXME */
>>>+		if (efi_enabled) {
>>>+	 		if (efi_set_rtc_mmss(ts.tv_sec) == 0)
>>>+				last_rtc_update = ts.tv_sec;
>>>+			else
>>>+				last_rtc_update = ts.tv_sec - 600;
>>>+		} else if (set_rtc_mmss(ts.tv_sec) == 0)
>>>+			last_rtc_update = ts.tv_sec;
>>>+		else
>>>+			last_rtc_update = ts.tv_sec - 600; /* do it again in 60 s */
>>>+	}
>>>+
>>
>>I have wondered, and continue to do so, why this is not a timer driven function. 
> 
> 
> I think it depends on how reliable timers are regarding in-time triggering. This 
> code has to be executed on-time to make sense. Really.

Granted, but if we are late we can easily skip to the next second.  The 60s 
thing is rather arbitrary.  If we are always late, well, there are lots of user 
aps that rely on timers being on time most of the time. So we need to get that 
right.

-g
> 
> 
>>  It just seems silly to check this every interrupt when we have low overhead 
>>timers for just this sort of thing.
>>
>>I wonder about the load calc in the same way...
> 
> 
> That's completely different.
> 
> ...
> 
> Regards,
> Ulrich
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

