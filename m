Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbTDKVK2 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 17:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbTDKVK2 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 17:10:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34542 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261759AbTDKVK1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 17:10:27 -0400
Message-ID: <3E9731E2.9090606@mvista.com>
Date: Fri, 11 Apr 2003 14:21:38 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 kernel/timer.c may incorrectly reenable interrupts
References: <24294.1050043625@kao2.melbourne.sgi.com> <3E966BAA.804@mvista.com> <20030411112728.M626@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20030411112728.M626@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> On Fri, Apr 11, 2003 at 12:15:54AM -0700, george anzinger wrote:
> 
>>As machines get faster and faster, it will be come more and more of a 
>>burden to "stop the world" and sync with the interrupt system, which 
>>is running at a much slower speed.  This is what the cli / sti/ 
>>restore flags causes.  I saw one test where the time to do the cli was 
>>as long as the run_timer_list code, for example.
> 
> 
> Maybe we could replace some cli/sti pairs with spinlocks? If it
> takes more time to cli/sti than to run the whole code section
> that will be protected by the spinlock, then it might be better
> to use that instead and block in the IRQ dispatch code.

Not so fast there :)  The cli/sti is there to protect from "same cpu" 
contention, i.e. this machine can come here on interrupt so don't 
allow interrupts.  The spin lock is only good for the "other" cpus.

On the other hand, a cli/sti will NOT protect from other machine 
interrupts (baring the global cli which is not even in 2.5).

The better thing to do, IMHO, is to move the work off the interrupt 
path where only spin locks (and preemption locks) are required.

Another possibility is to make more use of the new read/write stuff 
that is now being used for the xtime lock.  The idea here is that we 
don't care if an interrupt (or the other machine) visits this data 
while we are here as long as we know about it and can then redo what 
we are doing.  This works very well for fetching a few words that need 
to be fetch atomically WRT the lock.  If the fetch is not atomic (i.e. 
was interrupted), just try again.  I haven't measured or heard of 
measurements on this change, but I suspect that there is a significant 
reduction in the time to do gettimeofday() because the cli/sti is not 
on the read path any more.
> 
> But I have no measures, how fast the spinlocks are in the
> non-/contention case
> 
> Problems: 
>    - The total amount of CLI/STI doesn't matter, for spinlocks it
>      does (they are not recursive)
> 
>    - spinlocks are usally not compiled in
> 
>    - Older CPUs may still benefit from cli/sti.
> 
> What do you think?
> 
> Regards
> 
> Ingo Oeser

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

