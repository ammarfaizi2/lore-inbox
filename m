Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266405AbUAODgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 22:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266389AbUAODgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 22:36:40 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:32250 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266443AbUAODgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 22:36:38 -0500
Message-ID: <40060ABC.6080208@mvista.com>
Date: Wed, 14 Jan 2004 19:36:28 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Nick Piggin <piggin@cyberone.com.au>, Guillaume Foliard <guifo@wanadoo.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: Scheduler degradation since 2.5.66
References: <200312142048.51579.guifo@wanadoo.fr> <3FDD205A.6040807@cyberone.com.au> <3FDD35F9.7090709@cyberone.com.au> <3FDE5449.60507@mvista.com> <4005E24C.2030807@tmr.com>
In-Reply-To: <4005E24C.2030807@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> George Anzinger wrote:
> 
>> We get the request at some time t between tick tt and tt+1 to sleep 
>> for N ticks.
>> We round this up to the next higher tick count convert to jiffies 
>> dropping any fraction and then add 1.  So that should be 2 right?  
>> This is added to NOW which, in the test code, is pretty well pined to 
>> the last tick plus processing time.  So why do you see 3?
>>
>> What is missing here is that the request was for 1.000000 ms and a 
>> tick is really 0.999849 ms.  So the request is for a bit more than a 
>> tick which we are obligated to round up to 2 ticks.  Then adding the 1 
>> tick guard we get the 3 you are seeing.  Now if you actually look at 
>> that elapsed time you should see it at about 2.999547 ms and ranging 
>> down to 1.999698 ms.
> 
> 
> Clearly the rounding between what you want and the resolution of the 
> hardware tick is never going to be perfect if there is a non-integer 
> ratio between the values. If this is a real concern, you can play with 
> the algorithm and/or go to a faster clock. Or both.
> 
> You might also be much happier simply setting target times 2ms apart, 
> and sleeping for target-NOW ns. That allows for the processing time.
> 
> If the kernel had a better idea of when the next tick would be instead 
> of assuming counting from NOW instead of "last tick" you could probably 
> do better, 

But then you have a better resolution.  For this, see the high-res-timers patch 
in my signature, which will get you much closer, but still plays by the standard 
rules.

but I'm not suggesting that overhead be added to the ticks
> code in case someone needs a better nanosleep. I don't know how well 
> that would work in the SMP case in any event. Sort of
>   wait_ticks = 1 + int((NOW + delay - time_since_last_tick)/ns_per_tick)
> or
>   wait_ticks =
>     int((NOW-delay - time_since_tick + ns_per_tick - 1)/ns_per_tick)
> 
> I think there's too much caution about going over, but without playing 
> with the code I'm just dropping ideas.

The "caution" is around the standard that says "thou shalt never wake early" or 
words to that effect.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

