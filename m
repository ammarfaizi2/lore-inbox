Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318447AbSHWHHq>; Fri, 23 Aug 2002 03:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318514AbSHWHHq>; Fri, 23 Aug 2002 03:07:46 -0400
Received: from ns.suse.de ([213.95.15.193]:5137 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318447AbSHWHHo>;
	Fri, 23 Aug 2002 03:07:44 -0400
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 Summit NUMA patch with dynamic IRQ balancing
References: <Pine.LNX.4.33.0208131421190.3110-100000@penguin.transmeta.com.suse.lists.linux.kernel> <200208131729.50127.habanero@us.ibm.com.suse.lists.linux.kernel> <20020813233007.GV14394@dualathlon.random.suse.lists.linux.kernel> <200208221931.35052.jamesclv@us.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 23 Aug 2002 09:11:54 +0200
In-Reply-To: James Cleverdon's message of "23 Aug 2002 04:38:09 +0200"
Message-ID: <p73d6saoxqd.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Cleverdon <jamesclv@us.ibm.com> writes:


Some review.

> diff -ruN 2.5.31/arch/i386/kernel/acpi.c s31/arch/i386/kernel/acpi.c
> --- 2.5.31/arch/i386/kernel/acpi.c	Sat Aug 10 18:41:53 2002
> +++ s31/arch/i386/kernel/acpi.c	Wed Aug 14 19:30:13 2002
> @@ -114,6 +114,7 @@
>  	unsigned long		size)
>  {
>  	struct acpi_table_madt	*madt = NULL;
> +	extern void acpi_madt_oem_check(char *oem_id, char *oem_table_id);

This should be moved to acpi.h

>  {
>  	int			result = 0;
> +	extern void		smp_cluster_apic_check(void);

And smp.h

> -		set_ioapic_affinity(irq, 1 << entry->cpu);
> +		set_ioapic_affinity(irq, cpu_present_to_apicid(entry->cpu));

and cpu_present_to_apicid()

> +#define physical_to_logical_apicid(phys_apic) ((1ul << ((phys_apic) & 0x3)) | 
> ((phys_apic) & APIC_DEST_CLUSTER_MASK))

which is not equivalent for more than four CPUs and not using 
clustered mode. Are you sure this is correct? One of these must be wrong 
then, either the old or the new code.


> + * with all interrupts for each quad.  Distribute the interrupts using a
> + * simple round robin scheme.
> + */
> +static int round_robin_cpu_apic_id(void)
> +{
> +	int val;
> +	static unsigned	next_cpu = 0;

This is not protected by any global lock. Are you sure this is ok ?

> @@ -1288,7 +1321,7 @@
>   */
>  static void ack_edge_ioapic_irq(unsigned int irq)
>  {
> -	balance_irq(irq);
> +//	balance_irq(irq);

I would get rid of it completely. 

Doing the TPR change is certainly very involved - testing that on 
a lot of different SMP machines will be definitely needed. I think
it is the right way to go I agree, balance_irq always looked fishy to
me, especially with HyperThreading. How even is the distribution of the 
interrupts under load? Did you test it with Intel chipset P4s ?
Is this mode implemented on all APICs ?
Do you have any thoughts on this scheme on how this interacts with
HyperThreading ?

> @@ -332,6 +332,7 @@
>  
>  	irq_enter();
>  	kstat.irqs[cpu][irq]++;
> +	apic_adj_tpr(TPR_IRQ);
>  	spin_lock(&desc->lock);
>  	desc->handler->ack(irq);
>  	/*
> @@ -389,6 +390,7 @@
>  	 */
>  	desc->handler->end(irq);
>  	spin_unlock(&desc->lock);
> +	apic_adj_tpr(-TPR_IRQ);

It may make sense to it raised over softirqs as well.
This is a bit tricky because they are called from the entry.S 
assembly. It may make sense to raise it again using some asm/ defined
macros in kernel/softirq.c. If not a CPU mostly processing softirqs 
will be marked idle in the idle loop, which is not good.


> translation_table[mpc_record]->trans_local;
> @@ -253,6 +259,15 @@
>  	}
>  	mp_ioapics[nr_ioapics] = *m;
>  	nr_ioapics++;
> +	/******
> +	 * Warning!  We have an APIC version number collision between the APICs
> +	 * on Scorpio-based NUMA-Q boxes and Summit xAPICs.  Intel didn't
> +	 * define the xAPIC ver ID range until late in the development cycle,
> +	 * so there is working silicon out there that doesn't match it.
> +	 * A test in smp_cluster_apic_check() resolves the above conflict.
> +	 ******/
> +	if (m->mpc_apicver >= XAPIC_VER_LOW && m->mpc_apicver <= XAPIC_VER_HIGH)
> +		clustered_hint |= CLUSTERED_APIC_XAPIC;
>  }

This looks risky in the general case. Can't you wrap it with some special
check to make sure it only ever triggers on your hardware?

> +	 * OEM/Product IDs.
> +	 */
> +	if (!strncmp(oem, "IBM ENSW", 8) &&
> +	    (!strncmp(prod, "NF 6000R", 8) || !strncmp(prod, "VIGIL SMP", 9)) )
> +		clustered_hint |= CLUSTERED_APIC_XAPIC;
> +	else if (!strncmp(oem, "IBM NUMA", 8))
> +		clustered_hint |= CLUSTERED_APIC_NUMAQ;

[I'm surprised you are not using ACPI for this on your boxes]


> +	 * A test in smp_cluster_apic_check() resolves the above conflict.
> +	 ******/
> +	if (mp_ioapics[idx].mpc_apicver >= XAPIC_VER_LOW &&
> +	    mp_ioapics[idx].mpc_apicver <= XAPIC_VER_HIGH)
> +		clustered_hint |= CLUSTERED_APIC_XAPIC;

Same as above.

> +#define TRAMPOLINE_LOW phys_to_virt(clustered_apic_numaq?0x8:0x467)
> +#define TRAMPOLINE_HIGH phys_to_virt(clustered_apic_numaq?0xa:0x469)

Ugly. I would use some global for this that is changed by the clustered
apic init code.

Also you could get rid of all the // and #if 1/#if 0


-Andi
