Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbTASCqW>; Sat, 18 Jan 2003 21:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbTASCqW>; Sat, 18 Jan 2003 21:46:22 -0500
Received: from holomorphy.com ([66.224.33.161]:45445 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265361AbTASCqT>;
	Sat, 18 Jan 2003 21:46:19 -0500
Date: Sat, 18 Jan 2003 18:55:14 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, zwane@linuxpower.ca, zab@zabbo.net,
       manfred@colorfullife.com, macro@ds2.pg.gda.pl, Martin.Bligh@us.ibm.com,
       jamesclv@us.ibm.com, andrew.grover@intel.com
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
Message-ID: <20030119025514.GD780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	linux-kernel@vger.kernel.org, zwane@linuxpower.ca, zab@zabbo.net,
	manfred@colorfullife.com, macro@ds2.pg.gda.pl,
	Martin.Bligh@us.ibm.com, jamesclv@us.ibm.com,
	andrew.grover@intel.com
References: <20030119015013.GB780@holomorphy.com> <Pine.LNX.4.44.0301182114400.24250-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301182114400.24250-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2003, William Lee Irwin III wrote:
>> +int vector_to_irq[MAX_NUMNODES][FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR + 1];
>> +int apic_pin_to_irq[MAX_IO_APICS][24];
>> +
>> +/*
>> + * timer vectors must always go to 0
>> + * vectors < FIRST_DEVICE_VECTOR are 1:1
>> + * everything else goes through the table
>> + */

On Sat, Jan 18, 2003 at 09:32:22PM -0500, Zwane Mwaikambo wrote:
> Careful.
> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 001 01  0    0    0   0   0    1    1    31
>  01 001 01  0    0    0   0   0    1    1    39
>  02 000 00  1    0    0   0   0    0    0    00
>  03 001 01  0    0    0   0   0    1    1    41
>  04 001 01  0    0    0   0   0    1    1    49
>  05 001 01  0    0    0   0   0    1    1    51
>  06 001 01  0    0    0   0   0    1    1    59
>  07 001 01  0    0    0   0   0    1    1    61

Well, sure, but I can't tell what the software interrupt numbers are
from here. And all of those are above FIRST_DEVICE_VECTOR AFAICT.


On Sat, 18 Jan 2003, William Lee Irwin III wrote:
>> +int irq_of_vector(int vector)
>> +{
>> +	int irq;
>> +	if (vector < FIRST_DEVICE_VECTOR)
>> +		irq = vector;
>> +	else
>> +		irq = vector_to_irq[numa_node_id()][vector-FIRST_DEVICE_VECTOR];
>> +	return irq;
>> +}

On Sat, Jan 18, 2003 at 09:32:22PM -0500, Zwane Mwaikambo wrote:
> Same as above.

This is translation to software interrupt number; I don't see what the
issue is. do_IRQ() calls this on a raw vector which is the index of the
interrupt gate in the IDT, and I guaranteed that it would be the raw IDT
indexthe case elsewhere in the patch (and this is different from the
vanilla Pee Cee case, and even marked with a #ifdef).


On Sat, 18 Jan 2003, William Lee Irwin III wrote:
>> +static int __init assign_irq_vector(int irq)
>> +{
>> +	static int current_vector = FIRST_DEVICE_VECTOR+1;
>> +	if (!irq)
>> +		return FIRST_DEVICE_VECTOR;
>> +	else if (!irq_vector[irq]) {
>> +		irq_vector[irq] = current_vector;
>> +		current_vector = next_irq_vector(current_vector);
>> +	}
>> +	return irq_vector[irq];
>> +}

On Sat, Jan 18, 2003 at 09:32:22PM -0500, Zwane Mwaikambo wrote:
> You'll drop irqs when you have collisions with devices 
> attached to other busses/ioapics

Those aren't reachable anyway. Any given IO-APIC can only reach
devices within its own node. The only possible issue is the priority
class bounded-depth queueing issue (max of 2 or 3 pending) which I've
decided to ignore until something closer to working materializes.


On Sat, 18 Jan 2003, William Lee Irwin III wrote:
>> +#define init_vector_to_irq()		do {} while (0)
>> +#define set_irq_of_vector(a,v,i)	do {} while (0)
>> +#define set_irq_of_pin(a,v,i)	do {} while (0)
>> +
>> +int irq_of_vector(int vector)	{ return vector; }

On Sat, Jan 18, 2003 at 09:32:22PM -0500, Zwane Mwaikambo wrote:
> This would need major warnings not to use on non NUMAQ since that 
> information is relevant on Walmart SMP.

What on earth? The whole patch _should_ be a no-op on vanilla Pee Cees
(modulo breakage; there is of course minimal testing going on, and doing
it in a way with a much better guarantee of not touching Pee Cee code
_at all_ is going to be needed for 2.5 mergeable stuff). The whole
1:1-ness breaking is handled by wrapping things with no-ops like the
above and then introducing the sudden semantics change, which is (as it
should be) #ifdef'd on NUMA-Q, although the #ifdef's etc. etc. probably
belong elsewhere for anything remotely mergeable.


On Sat, 18 Jan 2003, William Lee Irwin III wrote:
>> +#ifdef CONFIG_X86_NUMAQ
>> +			set_intr_gate(vector, interrupt[vector]);
>> +#else
>>  			set_intr_gate(vector, interrupt[irq]);
>> +#endif

On Sat, Jan 18, 2003 at 09:32:22PM -0500, Zwane Mwaikambo wrote:
> hmm..

This is the bit about the interrupt gates pushing the vector instead
of the software interrupt number, and then doing the vector -> software
interrupt number translation in do_IRQ() (which qualifies it with the
essential numa_node_id(), provided in the irq_of_vector() function).


On Sat, 18 Jan 2003, William Lee Irwin III wrote:
>> +	if (irq < 0) {
>> +		printk("bad vector %ld, irq %d\n", regs.orig_eax & 0xff, irq);
>> +		dump_stack();
>> +		return 1;
>> +	}
>> +

On Sat, Jan 18, 2003 at 09:32:22PM -0500, Zwane Mwaikambo wrote:
> Oh my =)

Well, the issue is still being debugged. I'm asking for help, in my own
sick, twisted way. =)


Bill
