Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSFQJCo>; Mon, 17 Jun 2002 05:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316854AbSFQJCn>; Mon, 17 Jun 2002 05:02:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:6376 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316853AbSFQJCn>;
	Mon, 17 Jun 2002 05:02:43 -0400
Date: Mon, 17 Jun 2002 11:00:26 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Robert Love <rml@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
In-Reply-To: <Pine.LNX.4.44.0206171012270.1263-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0206171050050.9574-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Jun 2002, Zwane Mwaikambo wrote:

> > > Can we add a config time option for irqbalance? I consider it extra
> > > overhead for setups which can do the interrupt distribution via hardware
> > > properly, [...]
> > 
> > What x86 hardware do you have in mind?
> 
> ye olde generic x86 SMP box, the interrupt handling imbalance came about
> with the P4 and their newer APIC setup did it not? Although i am aware
> that some x86 SMP boxes don't do the distribution properly too, thats
> why i reckon config option would be best.

even generic x86 SMP boxes benefit from irqbalance due to better irq
affinity. Actually one could hardly find a worse way to distribute
interrupts than the IO-APIC + lowest priority delivery mode does... [in
fact there is one, the P4's do it ;-) ]

> > > [...] also irqbalance breaks NUMAQ horribly seeing as it assumes a
> > > number of things like addressing modes.
> > 
> > exactly what does it assume that breaks NUMAQ?
> 
> <Disclaimer>
> I am not a NUMAQ expert and do not even have access to one for testing
> </Disclaimer>
> 
> The addressing mode, irq_balance assumes that the addressing mode is
> logical mode (when programming the IOREDTBL entries), whilst NUMAQ uses
> a completely different addressing architecture. [...]

irqbalance uses the set_ioapic_affinity() method to set affinity. The
clustered APIC code is broken if it doesnt handle this properly. (i dont
have such hardware so i cant tell, but it indeed doesnt appear to handle
this case properly.) By wrapping around at node boundary the irqbalance
code will work just fine.

> [...] Also another thing is consider this situation;
> 
> irqbalance programs IOAPIC#0 on node0 to deliver to CPU#6 on node1
> 
> Will that interrupt get delivered?

i agree that this could be a problem, but set_ioapic_affinity() can be
made dependent on the actual NUMA setup that is used. This is absolutely
needed anyway for a proper /proc/irq/*/smp_affinity feature.

	Ingo

