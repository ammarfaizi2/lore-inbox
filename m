Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317723AbSFSBZ7>; Tue, 18 Jun 2002 21:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317724AbSFSBZ6>; Tue, 18 Jun 2002 21:25:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51629 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317723AbSFSBZ5>;
	Tue, 18 Jun 2002 21:25:57 -0400
Message-ID: <3D0FD8D2.2000602@us.ibm.com>
Date: Tue, 18 Jun 2002 18:05:22 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Ingo Molnar <mingo@elte.hu>, Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
       Robert Love <rml@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       Martin.Bligh@us.ibm.com, hbaum@us.ibm.com, cleverdj@us.ibm.com
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
References: <Pine.LNX.4.44.0206171012270.1263-100000@netfinity.realnet.co.sz> <Pine.LNX.4.44.0206171050050.9574-100000@e2> <20020618071626.GO22961@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at this right now, as it is definitely broken on our NUMA-Q 
hardware when running in multiquad mode.  It needs to respect clustered APIC 
mode, so I'm working on it.

Cheers!

-Matt

William Lee Irwin III wrote:
> On Mon, Jun 17, 2002 at 11:00:26AM +0200, Ingo Molnar wrote:
> 
>>irqbalance uses the set_ioapic_affinity() method to set affinity. The
>>clustered APIC code is broken if it doesnt handle this properly. (i dont
>>have such hardware so i cant tell, but it indeed doesnt appear to handle
>>this case properly.) By wrapping around at node boundary the irqbalance
>>code will work just fine.
> 
> 
> Perhaps a brief look at the code will help. Please forgive my
> non-preservation of whitespace as I cut and pasted it.
> 
> 
> static inline void balance_irq(int irq)
> {
> #if CONFIG_SMP
>     irq_balance_t *entry = irq_balance + irq;
>     unsigned long now = jiffies;
> 
>     if (unlikely(entry->timestamp != now)) {
>         unsigned long allowed_mask;
>         int random_number;
> 
>         rdtscl(random_number);
>         random_number &= 1;
> 
>         allowed_mask = cpu_online_map & irq_affinity[irq];
>         entry->timestamp = now;
>         entry->cpu = move(entry->cpu, allowed_mask, now, random_number);
>         set_ioapic_affinity(irq, 1 << entry->cpu);
>     }
> #endif
> }
> 
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	1 << entry->cpu
> 
> 
> 
> This could be problematic ...
> 
> 
> static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
> {
>     unsigned long flags;
> 
>     /*
>      * Only the first 8 bits are valid.
>      */
>     mask = mask << 24;
>     spin_lock_irqsave(&ioapic_lock, flags);
>     __DO_ACTION(1, = mask, )
>     spin_unlock_irqrestore(&ioapic_lock, flags);
> }
> 
> 
> According to this, nothing over 8 cpu's can work as the cpu id is used
> as a shift into an 8-bit bitfield. Also,
> 
> 
> #define __DO_ACTION(R, ACTION, FINAL)                                   \
>                                                                         \
> {                                                                       \
>         int pin;                                                        \
>         struct irq_pin_list *entry = irq_2_pin + irq;                   \
>                                                                         \
>         for (;;) {                                                      \
>                 unsigned int reg;                                       \
>                 pin = entry->pin;                                       \
>                 if (pin == -1)                                          \
>                         break;                                          \
>                 reg = io_apic_read(entry->apic, 0x10 + R + pin*2);      \
>                 reg ACTION;                                             \
>                 io_apic_modify(entry->apic, reg);                       \
>                 if (!entry->next)                                       \
>                         break;                                          \
>                 entry = irq_2_pin + entry->next;                        \
>         }                                                               \
>         FINAL;                                                          \
> }
> 
> ACTION is supposed to be an assignment to reg; in clustered hierarchical
> destination format this is not a bitmask as assumed by 1 << entry->cpu.
> 
> 
> Matt, Mike, please comment.
> 
> 
> Cheers,
> Bill
> 


