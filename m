Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVEHEOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVEHEOd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 00:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVEHEOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 00:14:33 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:62360 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262806AbVEHEO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 00:14:28 -0400
Message-ID: <427D921F.8070602@yahoo.com.au>
Date: Sun, 08 May 2005 14:14:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: vatsa@in.ibm.com, schwidefsky@de.ibm.com, jdike@addtoit.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] (How to) Let idle CPUs sleep
References: <20050507182728.GA29592@in.ibm.com> <1115524211.17482.23.camel@localhost.localdomain>
In-Reply-To: <1115524211.17482.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Sat, 2005-05-07 at 23:57 +0530, Srivatsa Vaddagiri wrote:
> 
>>Two solutions have been proposed so far:
>>
>>	A. As per Nick's suggestion, impose a max limit (say some 100 ms or
>>	   say a second, Nick?) on how long a idle CPU can avoid taking

Yeah probably something around that order of magnitude. I suspect
there will fast be a point where either you'll get other timers
going off more frequently, and / or you simply get very quickly
diminishing returns on the amount of power saving gained from
increasing the period.

>>	   local-timer ticks. As a result, the load imbalance could exist only
>>	   for this max duration, after which the sleeping CPU will wake up
>>	   and balance itself. If there is no imbalance, it can go and sleep
>>	   again for the max duration.
>>
>> 	   For ex, lets say a idle CPU found that it doesn't have any near timer
>>	   for the next 1 minute. Instead of letting it sleep for 1 minute in
>>	   a single stretch, we let it sleep in bursts of 100 msec (or whatever
>>	   is the max. duration chosen). This still is better than having
>>	   the idle CPU take HZ ticks a second.
>>
>>	   As a special case, when all the CPUs of an image go idle, we
>>	   could consider completely shutting off local timer ticks
>>	   across all CPUs (till the next non-timer interrupt).
>>
>>
>>	B. Don't impose any max limit on how long a idle CPU can sleep.
>>	   Here we let the idle CPU sleep as long as it wants. It is
>>	   woken up by a "busy" CPU when it detects an imbalance. The
>>	   busy CPU acts as a watchdog here. If there are no such
>>	   busy CPUs, then it means that nobody will acts as watchdogs
>>	   and idle CPUs sleep as long as they want. A possible watchdog
>>	   implementation has been discussed at:
>>
>>	http://marc.theaimsgroup.com/?l=linux-kernel&m=111287808905764&w=2
> 
> 
> My preference would be the second: fix the scheduler so it doesn't rely
> on regular polling.

It is not so much a matter of "fixing" the scheduler as just adding
more heuristics. When are we too busy? When should we wake another
CPU? What if that CPU is an SMT sibling? What if it is across the
other side of the topology, and other CPUs closer to it are busy
as well? What if they're busy but not as busy as we are? etc.

We've already got that covered in the existing periodic pull balancing,
so instead of duplicating this logic and moving this extra work to busy
CPUs, we can just use the existing framework.

At least we should try method A first, and if that isn't good enough
(though I suspect it will be), then think about adding more complexity
to the scheduler.

>  However, as long as the UP case runs with no timer
> interrupts when idle, many people will be happy (eg. most embedded).
> 

Well in the UP case, both A and B should basically degenerate to the
same thing.

Probably the more important case for the scheduler is to be able to
turn off idle SMP hypervisor clients, Srivatsa?

-- 
SUSE Labs, Novell Inc.

