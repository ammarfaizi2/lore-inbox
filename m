Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTASC1h>; Sat, 18 Jan 2003 21:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbTASC1h>; Sat, 18 Jan 2003 21:27:37 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:59208
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265339AbTASC1g>; Sat, 18 Jan 2003 21:27:36 -0500
Date: Sat, 18 Jan 2003 21:32:22 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org, <zwane@linuxpower.ca>, <zab@zabbo.net>,
       <manfred@colorfullife.com>, <macro@ds2.pg.gda.pl>,
       <Martin.Bligh@us.ibm.com>, <jamesclv@us.ibm.com>,
       <andrew.grover@intel.com>
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
In-Reply-To: <20030119015013.GB780@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0301182114400.24250-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2003, William Lee Irwin III wrote:

> +
> +int vector_to_irq[MAX_NUMNODES][FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR + 1];
> +int apic_pin_to_irq[MAX_IO_APICS][24];
> +
> +/*
> + * timer vectors must always go to 0
> + * vectors < FIRST_DEVICE_VECTOR are 1:1
> + * everything else goes through the table
> + */

Careful.

NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61

> +int irq_of_vector(int vector)
> +{
> +	int irq;
> +	if (vector < FIRST_DEVICE_VECTOR)
> +		irq = vector;
> +	else
> +		irq = vector_to_irq[numa_node_id()][vector-FIRST_DEVICE_VECTOR];
> +	return irq;
> +}

Same as above.

> +static int __init assign_irq_vector(int irq)
> +{
> +	static int current_vector = FIRST_DEVICE_VECTOR+1;
> +	if (!irq)
> +		return FIRST_DEVICE_VECTOR;
> +	else if (!irq_vector[irq]) {
> +		irq_vector[irq] = current_vector;
> +		current_vector = next_irq_vector(current_vector);
> +	}
> +	return irq_vector[irq];
> +}

You'll drop irqs when you have collisions with devices 
attached to other busses/ioapics

> +#define init_vector_to_irq()		do {} while (0)
> +#define set_irq_of_vector(a,v,i)	do {} while (0)
> +#define set_irq_of_pin(a,v,i)	do {} while (0)
> +
> +int irq_of_vector(int vector)	{ return vector; }

This would need major warnings not to use on non NUMAQ since that 
information is relevant on Walmart SMP.

> +#ifdef CONFIG_X86_NUMAQ
> +			set_intr_gate(vector, interrupt[vector]);
> +#else
>  			set_intr_gate(vector, interrupt[irq]);
> +#endif

hmm..

> +	if (irq < 0) {
> +		printk("bad vector %ld, irq %d\n", regs.orig_eax & 0xff, irq);
> +		dump_stack();
> +		return 1;
> +	}
> +

Oh my =)

	Zwane
-- 
function.linuxpower.ca



