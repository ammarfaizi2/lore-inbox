Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWCGNVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWCGNVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 08:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWCGNVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 08:21:03 -0500
Received: from relay04.roc.ny.frontiernet.net ([66.133.182.167]:62916 "EHLO
	relay04.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S1751100AbWCGNVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 08:21:00 -0500
Message-ID: <20060307132051.hjv4vs2d8dc0skoo@webmail03.roc.ny.frontiernet.net>
Date: Tue, 07 Mar 2006 13:20:51 +0000
From: Bryan Holty <lgeek@frontiernet.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, "Luck, Tony" <tony.luck@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IRQ: prevent enabling of previously disabled interrupt
References: <aec7e5c30603070434j7f326ad2r5f1b0e8046870941@mail.gmail.com>
	<9a8748490603070507h48e2fe02qbf9da7956e794161@mail.gmail.com>
In-Reply-To: <9a8748490603070507h48e2fe02qbf9da7956e794161@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.5-cvs)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 05:55, Andrew Morton wrote:
> "lgeek@frontiernet.net" <lgeek@frontiernet.net> wrote:
>>
>> Hi,
>>    This fix prevents re-disabling and enabling of a previously disabled
>> interrupt in 2.6.16-rc5.  On an SMP system with irq balancing enabled;
>> If an interrupt is disabled from within its own interrupt context with
>> disable_irq_nosync and is also earmarked for processor migration, 
>> the interrupt is blindly moved to the other processor and enabled 
>> without regard for its current "enabled" state.  If there is an 
>> interrupt
>> pending, it will unexpectedly invoke the irq handler on the new irq
>> owning processor (even though the irq was previously disabled)
>>
>>    The more intuitive fix would be to invoke disable_irq_nosync and
>> enable_irq, but since we already have the desc->lock from __do_IRQ, we
>> cannot call them directly.  Instead we can use the same logic to
>> disable and enable found in disable_irq_nosync and enable_irq, with
>> regards to the desc->depth.
>>
>>    This now prevents a disabled interrupt from being re-disabled, 
>> and more importantly prevents a disabled interrupt from being 
>> incorrectly enabled on a different processor.
>>
>> Signed-off-by: Bryan Holty <lgeek@frontiernet.net>
>>
>> --- 2.6.16-rc5/include/linux/irq.h
>> +++ b/include/linux/irq.h
>> @@ -155,9 +155,13 @@
>> 	 * Being paranoid i guess!
>> 	 */
>> 	if (unlikely(!cpus_empty(tmp))) {
>> -		desc->handler->disable(irq);
>> +		if (likely(!desc->depth++))
>> +			desc->handler->disable(irq);
>> +
>> 		desc->handler->set_affinity(irq,tmp);
>> -		desc->handler->enable(irq);
>> +
>> +		if (likely(!--desc->depth))
>> +			desc->handler->enable(irq);
>> 	}
>> 	cpus_clear(pending_irq_cpumask[irq]);
>> }
>
> But desc->lock isn't held here.  We need that for the update to ->depth (at
> least).
>
> And we can't take it here because one of the two ->end callers in __do_IRQ
> already holds that lock.  Possibly we should require that ->end callers
> hold the lock, but that would incur considerable cost for cpu-local
> interrupts.
>
> So we'd need to require that ->end gets called outside the lock for
> non-CPU-local interrupts.  I'm not sure what the implications of that would
> be - the ->end handlers don't need to be threaded at present and perhaps we
> could put hardware into a bad state?
>
> Or we add a new ->local_end, just for the CPU-local IRQs.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

Another option is to check for the disabled flag explicitly.  The check prior
to the disable could arguably be removed, but the check prior to the
enable is necessary.  If the interrupt has been explicitly disabled, as with
the IRQ_DISABLED flag, then it will take an explicit effort to re-enable it.


--- 2.6.16-rc5/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -155,9 +155,13 @@
	 * Being paranoid i guess!
	 */
	if (unlikely(!cpus_empty(tmp))) {
-		desc->handler->disable(irq);
+		if (likely(!(desc->status & IRQ_DISABLED)))
+			desc->handler->disable(irq);
+
		desc->handler->set_affinity(irq,tmp);
-		desc->handler->enable(irq);
+
+		if (likely(!(desc->status & IRQ_DISABLED)))
+			desc->handler->enable(irq);
	}
	cpus_clear(pending_irq_cpumask[irq]);
}

-- 
Bryan Holty

