Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSFTUYa>; Thu, 20 Jun 2002 16:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315461AbSFTUY3>; Thu, 20 Jun 2002 16:24:29 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:62144 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S315449AbSFTUY0> convert rfc822-to-8bit; Thu, 20 Jun 2002 16:24:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: colpatch@us.ibm.com, William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
Date: Thu, 20 Jun 2002 15:22:42 -0500
X-Mailer: KMail [version 1.4]
Cc: Ingo Molnar <mingo@elte.hu>, Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
       Robert Love <rml@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       Martin.Bligh@us.ibm.com, hbaum@us.ibm.com, cleverdj@us.ibm.com,
       anton@samba.org
References: <Pine.LNX.4.44.0206171012270.1263-100000@netfinity.realnet.co.sz> <20020618071626.GO22961@holomorphy.com> <3D0FD8D2.2000602@us.ibm.com>
In-Reply-To: <3D0FD8D2.2000602@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206201522.42503.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Could we also change "now" to a longer interval?  In netbench, 2.4.18, O1, 
irqbalance, I get the following results:

[4-way P4, 4 acenics]
now = jiffies	743 Mbps
now = jiffies*10	784 Mbps
now = jiffies*20	803 Mbps
now = jiffies*30	800 Mbps
now = jiffies*100	770 Mbps

[no irqbalance patch]
all IRQs on one CPU	809 Mbps
1 acenic per CPU	800 Mbps

Either the IRQs don't get to stick around long enough, or there is a high cost 
for the IOAPIC programming?  Anton may have some info on this as well....

-Andrew Theurer

On Tuesday 18 June 2002 20:05, Matthew Dobson wrote:
> I'm looking at this right now, as it is definitely broken on our NUMA-Q
> hardware when running in multiquad mode.  It needs to respect clustered
> APIC mode, so I'm working on it.
>
> Cheers!
>
> -Matt
>
> William Lee Irwin III wrote:
> > On Mon, Jun 17, 2002 at 11:00:26AM +0200, Ingo Molnar wrote:
> >>irqbalance uses the set_ioapic_affinity() method to set affinity. The
> >>clustered APIC code is broken if it doesnt handle this properly. (i dont
> >>have such hardware so i cant tell, but it indeed doesnt appear to handle
> >>this case properly.) By wrapping around at node boundary the irqbalance
> >>code will work just fine.
> >
> > Perhaps a brief look at the code will help. Please forgive my
> > non-preservation of whitespace as I cut and pasted it.
> >
> >
> > static inline void balance_irq(int irq)
> > {
> > #if CONFIG_SMP
> >     irq_balance_t *entry = irq_balance + irq;
> >     unsigned long now = jiffies;
> >
> >     if (unlikely(entry->timestamp != now)) {
> >         unsigned long allowed_mask;
> >         int random_number;
> >
> >         rdtscl(random_number);
> >         random_number &= 1;
> >
> >         allowed_mask = cpu_online_map & irq_affinity[irq];
> >         entry->timestamp = now;
> >         entry->cpu = move(entry->cpu, allowed_mask, now, random_number);
> >         set_ioapic_affinity(irq, 1 << entry->cpu);
> >     }
> > #endif
> > }
> >
> >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 	1 << entry->cpu
> >
> >
> >
> > This could be problematic ...
> >
> >
> > static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
> > {
> >     unsigned long flags;
> >
> >     /*
> >      * Only the first 8 bits are valid.
> >      */
> >     mask = mask << 24;
> >     spin_lock_irqsave(&ioapic_lock, flags);
> >     __DO_ACTION(1, = mask, )
> >     spin_unlock_irqrestore(&ioapic_lock, flags);
> > }
> >
> >
> > According to this, nothing over 8 cpu's can work as the cpu id is used
> > as a shift into an 8-bit bitfield. Also,
> >
> >
> > #define __DO_ACTION(R, ACTION, FINAL)                                   \
> >                                                                         \
> > {                                                                       \
> >         int pin;                                                        \
> >         struct irq_pin_list *entry = irq_2_pin + irq;                   \
> >                                                                         \
> >         for (;;) {                                                      \
> >                 unsigned int reg;                                       \
> >                 pin = entry->pin;                                       \
> >                 if (pin == -1)                                          \
> >                         break;                                          \
> >                 reg = io_apic_read(entry->apic, 0x10 + R + pin*2);      \
> >                 reg ACTION;                                             \
> >                 io_apic_modify(entry->apic, reg);                       \
> >                 if (!entry->next)                                       \
> >                         break;                                          \
> >                 entry = irq_2_pin + entry->next;                        \
> >         }                                                               \
> >         FINAL;                                                          \
> > }
> >
> > ACTION is supposed to be an assignment to reg; in clustered hierarchical
> > destination format this is not a bitmask as assumed by 1 << entry->cpu.
> >
> >
> > Matt, Mike, please comment.
> >
> >
> > Cheers,
> > Bill
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

