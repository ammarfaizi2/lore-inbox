Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVCNXti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVCNXti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVCNXti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 18:49:38 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:27899 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262133AbVCNXt3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 18:49:29 -0500
Message-ID: <42362301.2080804@mvista.com>
Date: Mon, 14 Mar 2005 15:49:21 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       "J. Bruce Fields" <bfields@fieldses.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spin_lock error in arch/i386/kernel/time.c on APM resume
References: <20050312131143.GA31038@fieldses.org> <4233111A.5070807@mvista.com> <Pine.LNX.4.61.0503120918130.2166@montezuma.fsmlabs.com> <42332F18.5050004@mvista.com> <20050313183549.GC1427@elf.ucw.cz>
In-Reply-To: <20050313183549.GC1427@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>>And more... That this occures implies we are attempting to update the cmos
>>>>clock on resume seems wrong.  One would presume that the time is wrong at 
>>>>this
>>>>time and we are about to save that wrong time.  Possibly the APM code 
>>>>should
>>>>change time_status to STA_UNSYNC on the way into the sleep (or what ever 
>>>>it is
>>>>called).  Who should we ping with this?
>>>
>>>
>>>timer_resume, which appears to be the problem, wants to calculate amount 
>>>of time was spent suspended, also your unconditional irq enable in 
>>>get_cmos_time breaks the atomicity of device_power_up and would deadlock 
>>>in sections of code which call get_time_diff() with xtime_lock held. I 
>>>sent a patch subject "APM: fix interrupts enabled in device_power_up" 
>>>which should address this.
>>
>>I agree.  Still in all that follows, no one has addressed the apparent race 
>>described above.  The reason the system reported the errors that started 
>>this thread is that the APM restore code was trying to read the cmos clock 
>>(I assume to set the xtime clock) WHILE the timer interrupt code what 
>>trying to set the cmos clock from xtime.  In other words, it is destroying 
>>the time it is trying to read.  I repeat "Possibly the APM code should 
>>change time_status to STA_UNSYNC on the way into the sleep."  I am not sure 
>>how ntp is supposed to react to the resume but I suspect that the system 
>>time is rather out of sync...
> 
> 
> It needs to work without NTP, too. You don't get NTP on plane (etc)
> where suspend is most usefull.
> 
> We have CMOS clock, it should be possible to get time from there
> without resorting to NTP..

Eh... sure, but... the bug was reported because the system was attempting to 
update the cmos clock (which it does every ~11 min.) during APM exit.   It does 
this IF AND ONLY IF the system is synced to an external source as indicated by 
the STA_UNSYNC bit being cleared in the time_state.  Now, I don't know what or 
how APM and NTP are supposed to play together, but I suspect that on entry to 
APM time is no longer synced, thus my comment.

As to your comment, the bug would never have shown its ugly face if the system 
wasn't using NTP.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

