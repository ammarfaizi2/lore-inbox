Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUATKAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 05:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbUATKAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 05:00:05 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:49391 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262130AbUATKAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 05:00:00 -0500
Message-ID: <400CFC0D.4020000@mvista.com>
Date: Tue, 20 Jan 2004 01:59:41 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: timing code in 2.6.1
References: <Pine.LNX.4.53.0401161150390.28039@chaos> <20040116153122.2c4adffe.akpm@osdl.org> <Pine.LNX.4.53.0401190849230.6524@chaos>
In-Reply-To: <Pine.LNX.4.53.0401190849230.6524@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Fri, 16 Jan 2004, Andrew Morton wrote:
> 
> 
>>"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>>
>>>
>>>Some drivers are being re-written for 2.6++. The following
>>>construct seems to work for "waiting for an event" in
>>>the kernel modules.
>>>
>>>        // No locks are being held
>>>        tim = jiffies + EVENT_TIMEOUT;
>>>        while(!event() && time_before(jiffies, tim))
>>>            schedule_timeout(0);
>>>
>>>Is there anything wrong?
>>
>>This is not a good thing to be doing.  You should add this task to a
>>waitqueue and then sleep.  Make the code which causes event() to come true
>>deliver a wake_up to that waitqueue.  There are many examples of this in
>>the kernel.
>>
> 
> 
> Huh? The code that causes "event()" needs to get the CPU occasionally
> to check for the event. The hardware doesn't produce an interrupt
> upon that event.

THAT is where the hardware designer went wrong.  An interrupt is really the best 
way for hardware to notify the cpu of an event.  Details may then be read from 
hardware registers, if needed.

The request of a 0 timeout is really asking for a timeout on the last jiffie.  I 
suspect that relying on this to actually not happen until the next jiffie is NOT 
a good thing.  I am not aware of any spec that says that is what it should do 
and I am aware of timer patchs that will run the timer immeadiatly.  A request 
for 1 jiffie will do the same thing in the current kernel AND under that patch. 
  That thing being, by the way, is to wait for the next jiffie which will be any 
time from ~0 to 1 jiffie.
> 
Lots of words, which did not explain why an interrupt was not used to signal the 
event, deleted :)
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

