Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbTCGHwH>; Fri, 7 Mar 2003 02:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbTCGHwH>; Fri, 7 Mar 2003 02:52:07 -0500
Received: from franka.aracnet.com ([216.99.193.44]:57316 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261410AbTCGHwB>; Fri, 7 Mar 2003 02:52:01 -0500
Date: Fri, 07 Mar 2003 00:02:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][RFT] noirqbalance still doesn't do anything
Message-ID: <323650000.1047024141@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.50.0303070224190.18716-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303070224190.18716-100000@montezuma.mastecende.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I didn't get a response to my other patch to do this so i'm guessing that 
> people want a simpler patch(??) This one simply sets TARGET_CPUS to 
> cpu_callout_map instead of cpu_online_map so that when we finally do boot 
> we actually use the other cpus for servicing interrupts.

Actually, I think your first patch is correct. TARGET_CPUS seems like the 
wrong thing to be changing (for example, if we take a CPU offline later)
However, doesn't this:

> +/*
> + * This function currently is only a helper for the i386 smp boot process where 
> + * we need to reprogram the ioredtbls to cater for the cpus which have come online
> + * so mask in all cases should simply be TARGET_CPUS
> + */
> +void __devinit set_ioapic_logical_dest (unsigned long mask)
> +{
> +	struct IO_APIC_route_entry entry;
> +	unsigned long flags;
> +	int apic, pin;
> +
> +	spin_lock_irqsave(&ioapic_lock, flags);
> +	for (apic = 0; apic < nr_ioapics; apic++) {
> +		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
> +			*(((int *)&entry)+0) = io_apic_read(apic, 0x10+pin*2);
> +			*(((int *)&entry)+1) = io_apic_read(apic, 0x11+pin*2);
> +			entry.dest.logical.logical_dest = mask;
> +			io_apic_write(apic, 0x10 + 2 * pin, *(((int *)&entry) + 0));
> +			io_apic_write(apic, 0x11 + 2 * pin, *(((int *)&entry) + 1));
> +		}
> +
> +	}
> +	spin_unlock_irqrestore(&ioapic_lock, flags);
> +}

do more or less the same as set_ioapic_affinity? And even if not, don't
you have to do "mask << 24" instead of "mask" ... or am I just confused?


M.


