Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbULLQvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbULLQvt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 11:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbULLQvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 11:51:49 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:30205 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261853AbULLQvq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 11:51:46 -0500
Message-ID: <41BC771D.6020506@mvista.com>
Date: Sun, 12 Dec 2004 08:51:41 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
References: <41BA0ECF.1060203@mvista.com> <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com> <41BA59F6.5010309@mvista.com> <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com> <41BA698E.8000603@mvista.com> <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com> <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com> <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random> <41BC1BF9.70701@colorfullife.com>
In-Reply-To: <41BC1BF9.70701@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Andrea Arcangeli wrote:
> 
>> On Sun, Dec 12, 2004 at 09:59:00AM +0100, Manfred Spraul wrote:
>>  
>>
>>> It means that our NMI irq return path should check if it points to a 
>>> hlt instruction and if yes, then increase the saved EIP by one before 
>>> doing the iretd, right?
>>>   
>>
>>
>> I don't think we'll ever post any event through nmi, so it doesn't
>> matter. We only care to be waken by real irqs, not nmi/smi. Idle loop is
>> fine to ignore the actions of the nmi handlers and to hang into the
>> "hlt".
>>  
>>
> No, You misunderstood the problem:
> 
> sti
> ** NMI handler
> ** normal interrupt arrives, is queued by the cpu
> ** irqd from NMI handler
> ** cpu notices the normal interrupt, handles it.
> ** normal interrupt does a wakeup, schedules a tasklet, whatever

I think you are forgetting that the system does the full context switch from the 
interrupt handler (well, actually from entry.S) and does not do the irqd until 
it is time to go back to the idle thread (i.e. there is nothing left to do), so..
> ** irqd from normal interupt
> hlt << cpu sleeps.

What we loose here is that idle does not go around its little loop again.  If an 
interrupt becomes pending on the way to the hlt, i.e. while entry.S has 
interrupts masked and is doing the irqd, it will be handled prior to the hlt so 
we could loose several of these idle loop spins, until no interrupt is pending 
allowing the hlt to be executed.  On the next interrupt/irqd the hlt will exit. 
  So what is lost is one or more spins round the idle loop.

The "normal" idle loop just looks at the need_resched flag and goes right back 
to the hlt, however, idle, it self, never sets this flag, only interrupt code 
can set it at this point, and the interrupt exit takes action to clear it so I 
don't see it every being found set in the idle loop (I suppose one could do a 
test to see if it is ever found set here), so, in theory, the net effect should 
be nill.

Did I miss something?

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

