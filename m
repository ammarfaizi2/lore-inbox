Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266374AbUAOAuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266372AbUAOAr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:47:27 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:9223 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S266352AbUAOApA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:45:00 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Scheduler degradation since 2.5.66
Date: Wed, 14 Jan 2004 19:43:56 -0500
Organization: TMR Associates, Inc
Message-ID: <4005E24C.2030807@tmr.com>
References: <200312142048.51579.guifo@wanadoo.fr> <3FDD205A.6040807@cyberone.com.au> <3FDD35F9.7090709@cyberone.com.au> <3FDE5449.60507@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1074126765 2485 192.168.12.10 (15 Jan 2004 00:32:45 GMT)
X-Complaints-To: abuse@tmr.com
Cc: Nick Piggin <piggin@cyberone.com.au>, Guillaume Foliard <guifo@wanadoo.fr>,
       linux-kernel@vger.kernel.org
To: George Anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <3FDE5449.60507@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:

> We get the request at some time t between tick tt and tt+1 to sleep for 
> N ticks.
> We round this up to the next higher tick count convert to jiffies 
> dropping any fraction and then add 1.  So that should be 2 right?  This 
> is added to NOW which, in the test code, is pretty well pined to the 
> last tick plus processing time.  So why do you see 3?
> 
> What is missing here is that the request was for 1.000000 ms and a tick 
> is really 0.999849 ms.  So the request is for a bit more than a tick 
> which we are obligated to round up to 2 ticks.  Then adding the 1 tick 
> guard we get the 3 you are seeing.  Now if you actually look at that 
> elapsed time you should see it at about 2.999547 ms and ranging down to 
> 1.999698 ms.

Clearly the rounding between what you want and the resolution of the 
hardware tick is never going to be perfect if there is a non-integer 
ratio between the values. If this is a real concern, you can play with 
the algorithm and/or go to a faster clock. Or both.

You might also be much happier simply setting target times 2ms apart, 
and sleeping for target-NOW ns. That allows for the processing time.

If the kernel had a better idea of when the next tick would be instead 
of assuming counting from NOW instead of "last tick" you could probably 
do better, but I'm not suggesting that overhead be added to the ticks 
code in case someone needs a better nanosleep. I don't know how well 
that would work in the SMP case in any event. Sort of
   wait_ticks = 1 + int((NOW + delay - time_since_last_tick)/ns_per_tick)
or
   wait_ticks =
     int((NOW-delay - time_since_tick + ns_per_tick - 1)/ns_per_tick)

I think there's too much caution about going over, but without playing 
with the code I'm just dropping ideas.
-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
