Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTKRJxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 04:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTKRJxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 04:53:40 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:12265 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262315AbTKRJxh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 04:53:37 -0500
Message-ID: <3FB9EC19.80107@softhome.net>
Date: Tue, 18 Nov 2003 10:53:29 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Q] jiffies overflow & timers.
References: <3FB91527.50007@softhome.net> <Pine.LNX.4.53.0311171347540.24608@chaos> <3FB9373D.6010300@softhome.net> <Pine.LNX.4.53.0311171624100.27657@chaos>
In-Reply-To: <Pine.LNX.4.53.0311171624100.27657@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
>>Richard B. Johnson wrote:
>>
>>>Use jiffies as other modules use it:
>>>
>>>        tim = jiffies + TIMEOUT_IN_HZ;
>>>        while(time_before(jiffies, tim))
>>>        {
>>>            if(what_im_waiting_for())
>>>                break;
>>>            current->policy |= SCHED_YIELD;
>>>            schedule();
>>>        }
>>>//
>>>// Note that somebody could have taken the CPU for many seconds
>>>// causing a 'timeout', therefore, you need to add one more check
>>>// after loop-termination:
>>>//
>>>            if(what_im_waiting_for())
>>>                good();
>>>            else
>>>                timed_out();
>>>
>>>Overflow is handled up to one complete wrap of jiffies + TIMEOUT. It's
>>>only the second wrap that will fail and if you are waiting several
>>>months for something to happen in your code, the code is broken.
>>>


   time_before(a,b) == (((long)a - (long)b) < 0)

   Can you explain me this games with signs there?
   Or this code expected to work reliably for timeouts < (ULONG_MAX/2)?
   time_before/time_after - do implicit conversion to signed types, 
while jiffies/friends are all unsigned. If one day gcc will be fixed - 
and it will truncate data here as I expect it to do - this will not work 
at all. Or this is a feature of 2-complement archs?
   (ldd2 again is silent on this topic - and I'm totally confused...)


> 
> schedule() is the kernel procedure that gives the CPU to somebody
> while your code is waiting for something to happen. You cannot
> call that in an interrupt or when a lock is held.
> 

   It is state machine, it is event driven - there is nothing that can 
yield CPU to someone else, because in first place it does not take CPU ;-)))
   Right now it is run from tasklet - so ksoftirqd context.

   Ok.
   Thinking about this gave me hints to understand userspace 
implementation of timers, which was used with my network layers before I 
have started kernel port.
   Idea is simple: all times absolute (think struct timeval). all given 
timer events are put into let us say binary heap, with timeval used as 
key. Check for expiration == O(1) - and this check is called in 
"while(1) { schedule(); }" loop. If we have NO expired timer - we are 
fast to yield CPU to someone else. Slow case of dequeueing from heap 
(what is O(log(n))) is really slow by definition - we are dequeueing 
event from heap and it needs to be processed.

   Looks Ok to me.
   Clearer/cleaner/safer than games with sign & ./kernel/timer.c 
implementation (internal_add_timer/cascade_timers/run_timer_list - what 
all those mess is about?).

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

