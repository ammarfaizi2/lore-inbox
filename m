Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422733AbWF0Xw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbWF0Xw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbWF0Xw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:52:56 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:65023 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1422733AbWF0Xwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:52:55 -0400
Message-ID: <44A1C4D4.3080805@bigpond.net.au>
Date: Wed, 28 Jun 2006 09:52:52 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Al Boldi <a1426z@gawab.com>,
       Pavel Machek <pavel@ucw.cz>, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Incorrect CPU process accounting using CONFIG_HZ=100
References: <200606211716.01472.a1426z@gawab.com> <20060626160239.GA3257@elf.ucw.cz> <200606271532.33368.a1426z@gawab.com> <200606272302.16950.kernel@kolivas.org>
In-Reply-To: <200606272302.16950.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 27 Jun 2006 23:52:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Tuesday 27 June 2006 22:32, Al Boldi wrote:
>> Pavel Machek wrote:
>>> On Thu 2006-06-22 20:36:39, Al Boldi wrote:
>>>> Jan Engelhardt wrote:
>>>>>> Setting CONFIG_HZ=100 results in incorrect CPU process accounting.
>>>>>>
>>>>>> This can be seen running top d.1, that shows top, itself, consuming
>>>>>> 0ms CPUtime.
>>>>>>
>>>>>> Will this bug have consequences for sched.c?
>>>>> Works for me, somewhat.
>>>>> TIME+ says 0:00.02 after 70 secs. (Ergo: top is not expensive on this
>>>>> CPU.)
>>>> That's what I thought for a long time.  But at closer inspection, top
>>>> d.1 slows down other apps by about the same amount of time at 1000Hz
>>>> and 100Hz, only at 1000Hz it is accounted for whereas at 100Hz it is
>>>> not.
>>> It is not a bug... it is design decision. If you eat "too little" cpu
>>> time, you'll be accouted 0 msec. That's what happens at 100Hz...
>> Bummer!
>>
>> Meanwhile, can't "too little" cpu time be made relative to CONFIG_HZ?
> 
> It is and that's what you're perceiving as the problem. We only charge tasks 
> in ticks and it's the tick size they get charged with. So at 100HZ if a task 
> is running when a tick fires it gets charged 1% cpu. If it runs for 100 ticks 
> it gets charged with 100% cpu. At 1000HZ it gets charged .1% cpu per tick and 
> so on. The actual problem is that tasks only get charged if they happen to be 
> running at the precise moment the tick fires. Now you could increase the 
> accuracy of this timekeeping but it is expensive and this is exactly the sort 
> of thing that we're saving cpu resources on by running at 100HZ (one of 
> many).
> 

It could be (partly) done fairly cheaply in nanoseconds if sched_clock() 
was reliable enough (but comments on this mail list indicate that it 
currently isn't) as it is already called in all the right places for 
getting the total cpu time used (so just a subtraction, addition and 
assignment).  The reason that I say partly is that splitting the time 
into "system" and "user" would be a more complex problem.

Peter
PS It's also called already at appropriate places for measuring total 
sleep and total cpu delay time (i.e. time spent on a run queue waiting 
to get on to a CPU).
PPS The task time stamp is also already updated at all the appropriate 
places for use in this mechanism.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
