Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbTCGIGu>; Fri, 7 Mar 2003 03:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbTCGIGu>; Fri, 7 Mar 2003 03:06:50 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:142
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261424AbTCGIGG>; Fri, 7 Mar 2003 03:06:06 -0500
Date: Fri, 7 Mar 2003 03:14:17 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][RFT] noirqbalance still doesn't do anything
In-Reply-To: <323650000.1047024141@[10.10.2.4]>
Message-ID: <Pine.LNX.4.50.0303070306270.18716-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303070224190.18716-100000@montezuma.mastecende.com>
 <323650000.1047024141@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, Martin J. Bligh wrote:

> Actually, I think your first patch is correct. TARGET_CPUS seems like the 
> wrong thing to be changing (for example, if we take a CPU offline later)
> However, doesn't this:

Not to mention if we take an interrupt (say pit doing timer ints) and it 
gets sent to one of the still yet to boot cpus? (Although we're so close 
to bringing them up it really doesn't matter).

> > +/*
> > + * This function currently is only a helper for the i386 smp boot process where 
> > + * we need to reprogram the ioredtbls to cater for the cpus which have come online
> > + * so mask in all cases should simply be TARGET_CPUS
> > + */
> > +void __devinit set_ioapic_logical_dest (unsigned long mask)
> > +{
> > +	struct IO_APIC_route_entry entry;
> > +	unsigned long flags;
> > +	int apic, pin;
> > +
> > +	spin_lock_irqsave(&ioapic_lock, flags);
> > +	for (apic = 0; apic < nr_ioapics; apic++) {
> > +		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
> > +			*(((int *)&entry)+0) = io_apic_read(apic, 0x10+pin*2);
> > +			*(((int *)&entry)+1) = io_apic_read(apic, 0x11+pin*2);
> > +			entry.dest.logical.logical_dest = mask;
> > +			io_apic_write(apic, 0x10 + 2 * pin, *(((int *)&entry) + 0));
> > +			io_apic_write(apic, 0x11 + 2 * pin, *(((int *)&entry) + 1));
> > +		}
> > +
> > +	}
> > +	spin_unlock_irqrestore(&ioapic_lock, flags);
> > +}
> 
> do more or less the same as set_ioapic_affinity? And even if not, don't
> you have to do "mask << 24" instead of "mask" ... or am I just confused?

union {	struct { __u32
		__reserved_1	: 24,
		physical_dest	:  4,
		__reserved_2	:  4;
		} physical;
	struct { __u32
		__reserved_1	: 24,
		logical_dest	:  8;
		} logical;
} dest;

Yes. But here we're lucky here because IO_APIC_route_entry is a nicely 
setup struct, all we need to do is put in the mask, for SMP boxes 
with over 8 cpus we'd stuff 0xf with all the magic being in TARGET_CPUS 
for each sub architecture.

Thanks,
	Zwane
-- 
function.linuxpower.ca
