Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVGMQXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVGMQXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVGMQXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:23:33 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:55300 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262690AbVGMQX2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:23:28 -0400
Message-ID: <42D540C2.9060201@tmr.com>
Date: Wed, 13 Jul 2005 12:26:42 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org, torvalds@osdl.org,
       christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050712121008.GA7804@ucw.cz> <200507122239.03559.kernel@kolivas.org> <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz>
In-Reply-To: <20050712162740.GA8938@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Jul 12, 2005 at 08:57:06AM -0700, George Anzinger wrote:
> 
> 
>>>>>The PIT crystal runs at 14.3181818 MHz (CGA dotclock, found on ISA, ...)
>>>>>and is divided by 12 to get PIT tick rate
>>>>>
>>>>>	14.3181818 MHz / 12 = 1193182 Hz
>>
>>Yes, but the current code uses 1193180.  Wonder why that is...
> 
> 
> Because it was stated so in some ancient DOS docs? I really don't know.
> x86-64 uses 1193182. This is because when I was doing x86-64 timing
> code, I had observably better results with this number.
> 
> 
>>>>>  HZ   ticks/jiffie  1 second      error (ppm)
>>>>>---------------------------------------------------
>>>>> 100      11932      1.000015238      15.2
>>>>> 200       5966      1.000015238      15.2
>>>>> 250       4773      1.000057143      57.1
>>>>> 300       3977      0.999931429     -68.6
>>>>> 333       3583      0.999964114     -35.9
>>>>> 500       2386      0.999847619    -152.4
>>>>>1000       1193      0.999847619    -152.4
>>
>>If we are following the standard and trying to set up a timer, the 1
>>second time MUST be >= 1 second.  Thus the values for 300 and above in
>>this table don't fly. 
> 
> 
> In that case, the table will look like this (with the CGA clock fixed to
> 14.31818000 MHz):
> 
>    HZ   ticks/jiffie  1 second      error (ppm)
> ---------------------------------------------------
>    100      11932      1.000015365      15.4
>    200       5966      1.000015365      15.4
>    250       4773      1.000057270      57.3
>    300       3978      1.000182984     183.0
>    500       2387      1.000266794     266.8
>   1000       1194      1.000685841     685.8
> ---------------------------------------------------
>     82      14551      1.000000279       0.3
>    216       5524      1.000001956       2.0
>    432       2762      1.000001956       2.0
>    864       1381      1.000001956       2.0
>   1381        864      1.000001956       2.0
> 
> 
> 
>>If we are trying to keep system time, we'll we do just fine at 
>>that by using the actual value of the jiffie (NOT 1/HZ) when we update time 
>>(one of the reasons for going to nanoseconds in xtime).
> 
> 
> Yes, adding (12.0/14318180)*LATCH to xtime in each timer interrupt,
> instead of (1.0/HZ) indeed eliminates the error entirely.
> 
> 
>>The observable thing the user sees is best seen by setting up an
>>itimer to repeat every second.  Then you will see the drift AND it
>>will be against the system clock which itself is quite accurate (the
>>50-100ppm you mention), even without ntp.  And the error really is in
>>the range of 848ppm for HZ=1000 BECAUSE we need to follow the
>>standard.  You can easily see this with the current 2.6 kernel.  We
>>even have a bug report on it:
>>
>>http://bugzilla.kernel.org/show_bug.cgi?id=3289
> 
>  
> Going to HZ=864 would fix this problem. It would likely cause other
> problems in places that expect 1/HZ to be a sane number, though.
> 
But if you are going to an "odd" value, would 1381 would be a better 
choice, given the interest in minimizing latency currently evident? The 
overhead would be a little higher, of course, but the people who want to 
drop to 250 for battery life would probably want 216 anyway.

How serious is the 1/HZ = sane problem, and more to the point how many 
programs get the HZ value with a system call as opposed to including a 
header or building it in? I know some of my older programs use header 
files, that was part of the planning for the future even before 2.5 
started. At the time I didn't expect to have to use the system call.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
