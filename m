Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVCMSgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVCMSgd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 13:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVCMSgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 13:36:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24983 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261417AbVCMSgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 13:36:25 -0500
Date: Sun, 13 Mar 2005 19:35:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: George Anzinger <george@mvista.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       "J. Bruce Fields" <bfields@fieldses.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spin_lock error in arch/i386/kernel/time.c on APM resume
Message-ID: <20050313183549.GC1427@elf.ucw.cz>
References: <20050312131143.GA31038@fieldses.org> <4233111A.5070807@mvista.com> <Pine.LNX.4.61.0503120918130.2166@montezuma.fsmlabs.com> <42332F18.5050004@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42332F18.5050004@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>And more... That this occures implies we are attempting to update the cmos
> >>clock on resume seems wrong.  One would presume that the time is wrong at 
> >>this
> >>time and we are about to save that wrong time.  Possibly the APM code 
> >>should
> >>change time_status to STA_UNSYNC on the way into the sleep (or what ever 
> >>it is
> >>called).  Who should we ping with this?
> >
> >
> >timer_resume, which appears to be the problem, wants to calculate amount 
> >of time was spent suspended, also your unconditional irq enable in 
> >get_cmos_time breaks the atomicity of device_power_up and would deadlock 
> >in sections of code which call get_time_diff() with xtime_lock held. I 
> >sent a patch subject "APM: fix interrupts enabled in device_power_up" 
> >which should address this.
> 
> I agree.  Still in all that follows, no one has addressed the apparent race 
> described above.  The reason the system reported the errors that started 
> this thread is that the APM restore code was trying to read the cmos clock 
> (I assume to set the xtime clock) WHILE the timer interrupt code what 
> trying to set the cmos clock from xtime.  In other words, it is destroying 
> the time it is trying to read.  I repeat "Possibly the APM code should 
> change time_status to STA_UNSYNC on the way into the sleep."  I am not sure 
> how ntp is supposed to react to the resume but I suspect that the system 
> time is rather out of sync...

It needs to work without NTP, too. You don't get NTP on plane (etc)
where suspend is most usefull.

We have CMOS clock, it should be possible to get time from there
without resorting to NTP..
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
