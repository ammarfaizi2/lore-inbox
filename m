Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVGVTVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVGVTVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 15:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVGVTVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 15:21:39 -0400
Received: from [195.23.16.24] ([195.23.16.24]:50573 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262144AbVGVTVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 15:21:37 -0400
Message-ID: <42E14735.1090205@grupopie.com>
Date: Fri, 22 Jul 2005 20:21:25 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Marshall <tmarshall@real.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: itimer oddness in 2.6.12
References: <20050722171657.GG4311@real.com>
In-Reply-To: <20050722171657.GG4311@real.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Marshall wrote:
> The patch to fix "setitimer timer expires too early" is causing issues for
> the Helix server.  We have a timer processs that updates the server's
> timestamp on an itimer and it expects the signal to be delivered at roughly
> the interval retrieved from getitimer.  This is very consistent on every
> platform, including Linux up to 2.6.11, but breaks on 2.6.12.  On 2.6.12,
> setting the itimer to 10ms and retrieving the actual interval from getitimer
> reports 10.998ms, but the timer interrupts are consistently delivered at
> roughly 11.998ms.  

Unfortunately, this is not so clear cut as it seems :(

I tested this on my system again, and if I set the timer to 9900us and 
put the system to some load I get intervals as low as 10022us with a 
vanilla 2.6.12.2 kernel. Removing this patch would cause the system to 
give me 9022us intervals which is just unnacceptable.

The reason this misbehaves in your case is that 10ms is converted into 
11 jiffies. I'm not really an expert in the time subsystem, but I guess 
this happens because 1000HZ aren't _exactly_ 1000HZ, they're probably a 
little more, so to guarantee 10 ms, we need 11 jiffies (or there is a 
bug in the timeval->jiffies conversions).

If HZ is slightly greater than 1000, this means that each tick will come 
in slightly less than 1 ms. Lets assume we want 2 ms intervals:


---|------------|------------|------------|------------|------
     ^          ^                          ^            ^
     0          1                          2            3

If you place your request at instant "1" and the time between ticks is 
slightly less than 1 ms, at instant "2" there is no guarantee that the 
time has ellapsed, only at instant "3" that is 4 ticks away. If you 
place that request at instant "0", you'll get almost 4ms.

So, the fact that 10 ms are converted to 11 jiffies explains why 
getitimer returns 10.998ms.

The fact that you are getting consistently 11.998ms just means that 
either your system is pretty idle, or the process that is requesting 
this timer has a very high priority so that it is able to request the 
timer again right after the timer tick (like in instant "0").

If this process is delayed for some reason and just requests the timer 
in the middle of the tick you would start seing values like 11.5ms.

If 10ms in jiffies would be just 10, then you would see 11ms between 
alarms, and getitimer would report 10ms.

The only way this could be better was if we knew "where" inside the tick 
we were when we set the timer (as discussed in the thread you 
mentioned), but in your case, even this wouldn't help because you're 
requesting a 10ms timer and to absolutely conform to the setitimer 
specification we can't just give you a 9.9ms interval.

Anyway, making the software depend on the time a timer takes to expire 
when the man page states "Timers will never expire before the requested 
time, ... the delivery will be offset by a small time dependent on the 
system loading" doesn't seem like a very robust software design to me...

-- 
Paulo Marques
Software Development Department - Grupo PIE, S.A.
Phone: +351 252 290600, Fax: +351 252 290601
Web: www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
