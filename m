Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317345AbSFRHRV>; Tue, 18 Jun 2002 03:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317346AbSFRHRU>; Tue, 18 Jun 2002 03:17:20 -0400
Received: from holomorphy.com ([66.224.33.161]:44979 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317345AbSFRHRT>;
	Tue, 18 Jun 2002 03:17:19 -0400
Date: Tue, 18 Jun 2002 00:16:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, Robert Love <rml@mvista.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       Martin.Bligh@us.ibm.com, colpatch@us.ibm.com, hbaum@us.ibm.com,
       cleverdj@us.ibm.com
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
Message-ID: <20020618071626.GO22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	Robert Love <rml@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	Martin.Bligh@us.ibm.com, colpatch@us.ibm.com, hbaum@us.ibm.com,
	cleverdj@us.ibm.com
References: <Pine.LNX.4.44.0206171012270.1263-100000@netfinity.realnet.co.sz> <Pine.LNX.4.44.0206171050050.9574-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206171050050.9574-100000@e2>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 11:00:26AM +0200, Ingo Molnar wrote:
> irqbalance uses the set_ioapic_affinity() method to set affinity. The
> clustered APIC code is broken if it doesnt handle this properly. (i dont
> have such hardware so i cant tell, but it indeed doesnt appear to handle
> this case properly.) By wrapping around at node boundary the irqbalance
> code will work just fine.

Perhaps a brief look at the code will help. Please forgive my
non-preservation of whitespace as I cut and pasted it.


static inline void balance_irq(int irq)
{
#if CONFIG_SMP
    irq_balance_t *entry = irq_balance + irq;
    unsigned long now = jiffies;

    if (unlikely(entry->timestamp != now)) {
        unsigned long allowed_mask;
        int random_number;

        rdtscl(random_number);
        random_number &= 1;

        allowed_mask = cpu_online_map & irq_affinity[irq];
        entry->timestamp = now;
        entry->cpu = move(entry->cpu, allowed_mask, now, random_number);
        set_ioapic_affinity(irq, 1 << entry->cpu);
    }
#endif
}

        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	1 << entry->cpu



This could be problematic ...


static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
{
    unsigned long flags;

    /*
     * Only the first 8 bits are valid.
     */
    mask = mask << 24;
    spin_lock_irqsave(&ioapic_lock, flags);
    __DO_ACTION(1, = mask, )
    spin_unlock_irqrestore(&ioapic_lock, flags);
}


According to this, nothing over 8 cpu's can work as the cpu id is used
as a shift into an 8-bit bitfield. Also,


#define __DO_ACTION(R, ACTION, FINAL)                                   \
                                                                        \
{                                                                       \
        int pin;                                                        \
        struct irq_pin_list *entry = irq_2_pin + irq;                   \
                                                                        \
        for (;;) {                                                      \
                unsigned int reg;                                       \
                pin = entry->pin;                                       \
                if (pin == -1)                                          \
                        break;                                          \
                reg = io_apic_read(entry->apic, 0x10 + R + pin*2);      \
                reg ACTION;                                             \
                io_apic_modify(entry->apic, reg);                       \
                if (!entry->next)                                       \
                        break;                                          \
                entry = irq_2_pin + entry->next;                        \
        }                                                               \
        FINAL;                                                          \
}

ACTION is supposed to be an assignment to reg; in clustered hierarchical
destination format this is not a bitmask as assumed by 1 << entry->cpu.


Matt, Mike, please comment.


Cheers,
Bill
