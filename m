Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263938AbTDNVi5 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263940AbTDNVi5 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:38:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30716 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263938AbTDNVir (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:38:47 -0400
Message-ID: <3E9B2CF3.70103@mvista.com>
Date: Mon, 14 Apr 2003 14:49:39 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 kernel/timer.c may incorrectly reenable interrupts
References: <24294.1050043625@kao2.melbourne.sgi.com> <3E966BAA.804@mvista.com> <20030411112728.M626@nightmaster.csn.tu-chemnitz.de> <3E9731E2.9090606@mvista.com> <20030412105546.H659@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20030412105546.H659@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> On Fri, Apr 11, 2003 at 02:21:38PM -0700, george anzinger wrote:
> 
>>Ingo Oeser wrote:
>>
>>>Maybe we could replace some cli/sti pairs with spinlocks? If it
>>>takes more time to cli/sti than to run the whole code section
>>>that will be protected by the spinlock, then it might be better
>>>to use that instead and block in the IRQ dispatch code.
>>
>>Not so fast there :)  The cli/sti is there to protect from "same cpu" 
>>contention, i.e. this machine can come here on interrupt so don't 
>>allow interrupts.  The spin lock is only good for the "other" cpus.
>>
>>On the other hand, a cli/sti will NOT protect from other machine 
>>interrupts (baring the global cli which is not even in 2.5).
> 
> 
> Because it isn't implemented this way? ;-)
> 
> If you have a per-CPU lock, which block in the arch-specific
> IRQ-dispatch section, you can simulate cli/sti quite well.

Yes, I believe this is what RTLinux and RTIA do.  The sti macro then 
needs to check for pending interrupt work, much as the bh_unlock does.
> 
> I have more problems with the semantical difference of cli/sti
> vs. spinlocks on nesting. A cli/sti will never block anything but
> interrupts, a spinlock will block the caller on contention.
> 
> This should be measured. Unfortunately I don't have fast enough
> hardware to notice a difference.
> 
> 
>>The better thing to do, IMHO, is to move the work off the interrupt 
>>path where only spin locks (and preemption locks) are required.
> 
>  
> This is done incrementally already, so its only a matter of time.
> 
> 
>>Another possibility is to make more use of the new read/write stuff 
>>that is now being used for the xtime lock.  The idea here is that we 
>>don't care if an interrupt (or the other machine) visits this data 
>>while we are here as long as we know about it and can then redo what 
>>we are doing.  This works very well for fetching a few words that need 
>>to be fetch atomically WRT the lock.  If the fetch is not atomic (i.e. 
>>was interrupted), just try again.
> 
> 
> Not suitable for drivers. They must read the registers, set some
> other registers and ACK the IRQ in the ISR. There is no way
> around that. 

The lock has two sides, the reader and the writer.  The writer still 
takes the irq/ spinlock, only the reader gets the speed up.
> 
> If the maximum latency between ISR and process context work is
> small and definable by the drivers, people would offload more.
> 
> So if there would be a schedule_work_deadline() then this would
> be nice. The routine called later in process context called will
> be noticed, if the deadline is missed or not and can act
> correctly.
> 
> This will simplify IDE (which needs those small timeouts and
> could act like the stuff timed out, if the deadline is missed),
> this will simplify the deadline-scheduler for IO and allow an
> additional scheduling method for user space.
> 
> The scheduler changes would be one additional queue and it could
> also be depth limited, since later deadlines can be added later.
> 
> We currently have timers, but they are not suitable for doing the
> work only for triggering it and that's a source of complexity in
> driver design.

Something of this sort is present in the workqueues design.  There is 
a schedule work for later call.
> 
> 
>>I haven't measured or heard of 
>>measurements on this change, but I suspect that there is a significant 
>>reduction in the time to do gettimeofday() because the cli/sti is not 
>>on the read path any more.
> 
> 
> I agree that these historical kind of code should be changed,
> but modern drivers, which need to protect from IRQs of this
> device happening while changing some registers could not do this.
> 
> They really need the spin_lock_irqsave() (which does the cli
> implicitly).
> 
> Regards
> 
> Ingo Oeser
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

