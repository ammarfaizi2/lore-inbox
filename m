Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTLPAjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 19:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTLPAjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 19:39:44 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:61423 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262566AbTLPAjm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 19:39:42 -0500
Message-ID: <3FDE5449.60507@mvista.com>
Date: Mon, 15 Dec 2003 16:39:37 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Guillaume Foliard <guifo@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: Scheduler degradation since 2.5.66
References: <200312142048.51579.guifo@wanadoo.fr> <3FDD205A.6040807@cyberone.com.au> <3FDD35F9.7090709@cyberone.com.au>
In-Reply-To: <3FDD35F9.7090709@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Nick Piggin wrote:
> 
>>
>>
>> Guillaume Foliard wrote:
>>
>>> Hello,
>>>
>>> I have been playing with kernel 2.5/2.6 for around 6 months now. I 
>>> was quite pleased with 2.5.65 to see that the soft real-time 
>>> behaviour was much better than 2.4.x. Since then I tried most of the 
>>> 2.5/2.6 versions. But recently someone warned me about some 
>>> degradations with 2.6.0-test6. To show the degradation since 2.5.66 I 
>>> have run a simple test program on most of the versions. This simple 
>>> program is measuring the time it takes to a process to be woken up 
>>> after a call to nanosleep.
>>> As the results are plots, please visit this small website for more 
>>> information : http://perso.wanadoo.fr/kayakgabon/linux
>>> I'm ready to perform more tests or provide more information if 
>>> necessary.
>>>
>>
>> This isn't a problem with the scheduler, its a problem with 
>> sys_nanosleep.
>> jiffies_to_timespec( {1000000us} ) returns 2 jiffies, and nanosleep adds
>> an extra one and asks to sleep for that long (ie. 3ms).
> 
> 
> 
> I think you should actually sleep for 2 jiffies here. You have asked
> to sleep for _at least_ 1 real millisecond and you really don't care
> about the number of jiffies that is. Depending on when the last timer
> interrupt had fired, the next jiffy might be in another microsecond.
> 
> So I think you really must sleep for that extra jiffy (but 3 is too
> many I think). Notice your first graphs are actually bad, because
> some sleeps are much less than 1000us.
> 
> I don't know much about the timer code though, perhaps you do need to
> sleep for 3 jiffies...


We get the request at some time t between tick tt and tt+1 to sleep for N ticks.
We round this up to the next higher tick count convert to jiffies dropping any 
fraction and then add 1.  So that should be 2 right?  This is added to NOW 
which, in the test code, is pretty well pined to the last tick plus processing 
time.  So why do you see 3?

What is missing here is that the request was for 1.000000 ms and a tick is 
really 0.999849 ms.  So the request is for a bit more than a tick which we are 
obligated to round up to 2 ticks.  Then adding the 1 tick guard we get the 3 you 
are seeing.  Now if you actually look at that elapsed time you should see it at 
about 2.999547 ms and ranging down to 1.999698 ms.

Try running the test with a requested sleep time of something less than 0.999849 
ms.  All this is for the x86 which is using this time to do the best it can with 
the PIT which can only get this close to 1 ms ticks.  You can even vary this 
number to see exactly where the round up actually happens.  Ah, life in the nano 
world :)


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

