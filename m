Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTD2T6o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 15:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTD2T6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 15:58:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54519 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261670AbTD2T6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 15:58:38 -0400
Message-ID: <3EAEDC29.3010102@mvista.com>
Date: Tue, 29 Apr 2003 13:10:17 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mbs <mbs@mc.com>
CC: rmoser <mlmoser@comcast.net>, Jae-Young Kim <jaykim@cs.purdue.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel timer accuracy
References: <20030429165427.GA5923@punch.cs.purdue.edu> <200304291511440630.0459FBDF@smtp.comcast.net> <200304291945.PAA27684@mc.com>
In-Reply-To: <200304291945.PAA27684@mc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would help to know what kernel version and machine this is.  The 
slow drift followed by a realignment sounds like a drift between the 
clock tick and the run_timer_list tick.  This, in fact, does happen on 
i386 SMP systems where the run_timer_list tick comes from the APIC and 
the clock tick from the PIT.

-g


mbs wrote:
> the semantic of most "timer" style operations (sleep, nanosleep, timer_xxx 
> etc) are generally "not less than" or "no earlier than", i.e wait no less 
> than 50ms, so anything over 50 is ok (usually within some defined window), 
> but less than 50 is a big no no.
> 
> it seems that the insert mechanism probably sets "5 ticks from now" resulting 
> in 4 complete jiffie intervals plus a partial, rather than "5 complete 
> intervals plus whatever part remains of the interval I'm currently in"
> 
> this may be the correct and intended semantic for the mechanism he is using, 
> but it is clearly not what he expected.
> 
> On Tuesday 29 April 2003 15:11, rmoser wrote:
> 
>>Note:  Not much of this makes sense or is useful.  Read it, maybe
>>I'm wrong.  It's short.
>>
>>*********** REPLY SEPARATOR  ***********
>>
>>On 4/29/2003 at 11:54 AM Jae-Young Kim wrote:
>>
>>>Hi, I'm developing a kernel module that enforces filtered packets to
>>>get delayed for a given short time. I'm using netfilter for packet
>>>filtering and using mod_timer() for packet delay.
>>>
>>>The kernel module holds packet buffer (skb) in a linked list and
>>>waits until the timer expires. If the timer expires, the module
>>>releases the packets.
>>>
>>>What I'm struggling is about the accuracy of timer function. Since
>>>default Linux timer interrupt frequency is set to 100 HZ, I know
>>>the smallest timer interval is 10 msec. and the one jiffy tick is
>>>also 10 msec. However, it looks like that there's a small amount of
>>>error between real-time clock and jiffy tick.
>>>
>>>In my experiment, (I set the 50msec timer for each packet and I sent
>>>one packet in every second), if I set 5 jiffies (= 50 msec) for my
>>>packet delay, the timer correctly executes the callback function
>>>after 5 jiffy ticks, however, the actual real-time measurment shows the
>>>packet delay varies between 40msec and 50msec. Even worse, the actual
>>>delay time variation has a trend. Please see the following data.
>>>
>>>pkt no.       jiffy      actual delay
>>>----------------------------------------
>>>1               5            50.2msec
>>>...            ...             ...
>>>300             5            45.1msec
>>>...            ...             ...
>>>500             5            41.6msec
>>>...            ...             ...
>>>566             5            40.6msec
>>>567             5            40.4msec
>>>568             5            50.3msec
>>>569             5            50.3msec
>>>...            ...             ...
>>
>>Looks normal.  Did someone point this at 50?  Because it looks normal
>>centered at 45.  Maybe you should try centering the delay at 50?  (For a
>>start... 5 mS for 50 mS is too much for me)  At least in large lengths of
>>time, it would then balance out.  Graph this function:
>>
>>f(x) = 1/(sqrt(2*pi)) * pow(e, 0.5 * pow(x,2))
>>
>>That should illustrate normality.  If you make a distribution curve of
>>actual times, does it look like that?  If so, try first to make it center
>>around 50, then try to decrease the standard deviation (which is reflected
>>by having more fluctuations be closer to the mean).
>>
>>
>>>Here, the packet delay starts from around 50msec, but gradually decreased
>>>to 40msec, and then abruptly adjusted to 50msec. The same
>>>decrese-and-abruptly-
>>>adjusted trend was repeated.
>>>
>>>Is there any person have experienced the same problem?
>>>It looks like that the accuray below 10msec is not guaranteed, but I'd
>>>like to
>>>know why this kind of trend happens (I initially thought the error should
>>>be
>>>randomly distributed between 40msec to 60msec) and how the kernel adjust
>>>the timer when the error term becomes over 10msec.
>>
>>That'd be impossible.  The computer is absolutely incapable of producing a
>>random number on its own, much less several [million].  :-p  It may be
>>semi- random or apparently-random though.
>>
>>
>>>- Jay
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

