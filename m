Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSHWVcV>; Fri, 23 Aug 2002 17:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSHWVcV>; Fri, 23 Aug 2002 17:32:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15805 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S311885AbSHWVcT> convert rfc822-to-8bit;
	Fri, 23 Aug 2002 17:32:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] 2.5.31 Summit NUMA patch with dynamic IRQ balancing
Date: Fri, 23 Aug 2002 14:36:04 -0700
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.33.0208131421190.3110-100000@penguin.transmeta.com.suse.lists.linux.kernel> <200208221931.35052.jamesclv@us.ibm.com.suse.lists.linux.kernel> <p73d6saoxqd.fsf@oldwotan.suse.de>
In-Reply-To: <p73d6saoxqd.fsf@oldwotan.suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208231436.04311.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 August 2002 12:11 am, Andi Kleen wrote:
> James Cleverdon <jamesclv@us.ibm.com> writes:
>
>
> Some review.

Thanks for the review.  Comments below.

> > diff -ruN 2.5.31/arch/i386/kernel/acpi.c s31/arch/i386/kernel/acpi.c
> > --- 2.5.31/arch/i386/kernel/acpi.c	Sat Aug 10 18:41:53 2002
> > +++ s31/arch/i386/kernel/acpi.c	Wed Aug 14 19:30:13 2002
> > @@ -114,6 +114,7 @@
> >  	unsigned long		size)
> >  {
> >  	struct acpi_table_madt	*madt = NULL;
> > +	extern void acpi_madt_oem_check(char *oem_id, char *oem_table_id);
>
> This should be moved to acpi.h

Will be, once I'm sure this is the right way to go.  As mentioned earlier, I'm 
having ACPI problems that seem to imply ACPI isn't building the full IRQ 
table.  In 2.4 we could let MPS do this.  Maybe 2.5 will need to revert to 
that behavior.

> >  {
> >  	int			result = 0;
> > +	extern void		smp_cluster_apic_check(void);
>
> And smp.h

Likewise.

> > -		set_ioapic_affinity(irq, 1 << entry->cpu);
> > +		set_ioapic_affinity(irq, cpu_present_to_apicid(entry->cpu));
>
> and cpu_present_to_apicid()
>
> > +#define physical_to_logical_apicid(phys_apic) ((1ul << ((phys_apic) &
> > 0x3)) | ((phys_apic) & APIC_DEST_CLUSTER_MASK))
>
> which is not equivalent for more than four CPUs and not using
> clustered mode. Are you sure this is correct? One of these must be wrong
> then, either the old or the new code.

There are several APIC numbering schemes here:

1) Classic Flat mode.  Almost anything goes, and we've seen some rather wacky 
assignments by oddball BIOSes.  We assign logical APIC IDs in CPU on-line 
order.

2) NUMA-Q.  We can take some shortcuts because we know _exactly_ how the BIOS 
is going to assign physical and logical APIC IDs.  In fact, the BIOS has 
already set it all up, so just need to let the kernel know.

3) Parallel xAPIC.  (Serial xAPIC can be treated as Flat for <= 8 CPUs).  
Intel has defined a particular physical APIC numbering scheme to include 
hyperthreading, so we can easily generate a unique logical ID from it.  This 
is the value produced by physical_to_logical_apicid().  Maybe I should pick a 
more descriptive name, like xapic_physical_to_logical_apicid.  ;^)

> > + * with all interrupts for each quad.  Distribute the interrupts using a
> > + * simple round robin scheme.
> > + */
> > +static int round_robin_cpu_apic_id(void)
> > +{
> > +	int val;
> > +	static unsigned	next_cpu = 0;
>
> This is not protected by any global lock. Are you sure this is ok ?

Yes, it's done by the boot CPU only.  Not that it matters; lacking any 
standard I/O bus to CPU locality table, I can only assign IRQs to APIC 
clusters randomly.

> > @@ -1288,7 +1321,7 @@
> >   */
> >  static void ack_edge_ioapic_irq(unsigned int irq)
> >  {
> > -	balance_irq(irq);
> > +//	balance_irq(irq);
>
> I would get rid of it completely.

Zounds!  You have uncovered my diabolical plot -- to make balance_irq 
unnecessary!  Curses, foiled again!    8^)

> Doing the TPR change is certainly very involved - testing that on
> a lot of different SMP machines will be definitely needed. I think
> it is the right way to go I agree, balance_irq always looked fishy to
> me, especially with HyperThreading. How even is the distribution of the
> interrupts under load? Did you test it with Intel chipset P4s ?
> Is this mode implemented on all APICs ?
> Do you have any thoughts on this scheme on how this interacts with
> HyperThreading ?

Yes, I've given quite a bit of thought to how this code and hyperthreading get 
along.  Since all schedulers since 2.4.14 dispatch tasks to sibling 
processors last, they will take the bulk of the interrupt traffic on a medium 
loaded system.  This shouldn't be a problem, since the siblings have their 
own local APICs.

In my testing, the distribution of interrupts under load begins to approach 
even.  (Not that it matters much so long as we are targeting idle CPUs.)  
But, I've been running the chat benchmark between two x440s almost 
exclusively, to maximize CPU and interrupt load.  Doubtless other job mixes 
will produce different results.  Andrew Theurer has done a bit of basic 
sanity testing too.  If I can get summit and 2.5 working with hyperthreading, 
it is slated for lots more testing.

Yes, we'll have to exercise this code with lots more oddball SMP systems.  My 
site is rather limited on test hardware.  It is almost entirely NUMA-Q, 
Summit, or stock Netfinity.

> > @@ -332,6 +332,7 @@
> >
> >  	irq_enter();
> >  	kstat.irqs[cpu][irq]++;
> > +	apic_adj_tpr(TPR_IRQ);
> >  	spin_lock(&desc->lock);
> >  	desc->handler->ack(irq);
> >  	/*
> > @@ -389,6 +390,7 @@
> >  	 */
> >  	desc->handler->end(irq);
> >  	spin_unlock(&desc->lock);
> > +	apic_adj_tpr(-TPR_IRQ);
>
> It may make sense to it raised over softirqs as well.
> This is a bit tricky because they are called from the entry.S
> assembly. It may make sense to raise it again using some asm/ defined
> macros in kernel/softirq.c. If not a CPU mostly processing softirqs
> will be marked idle in the idle loop, which is not good.

Good idea.  I'll take a look at that.

> > translation_table[mpc_record]->trans_local;
> > @@ -253,6 +259,15 @@
> >  	}
> >  	mp_ioapics[nr_ioapics] = *m;
> >  	nr_ioapics++;
> > +	/******
> > +	 * Warning!  We have an APIC version number collision between the APICs
> > +	 * on Scorpio-based NUMA-Q boxes and Summit xAPICs.  Intel didn't
> > +	 * define the xAPIC ver ID range until late in the development cycle,
> > +	 * so there is working silicon out there that doesn't match it.
> > +	 * A test in smp_cluster_apic_check() resolves the above conflict.
> > +	 ******/
> > +	if (m->mpc_apicver >= XAPIC_VER_LOW && m->mpc_apicver <=
> > XAPIC_VER_HIGH) +		clustered_hint |= CLUSTERED_APIC_XAPIC;
> >  }
>
> This looks risky in the general case. Can't you wrap it with some special
> check to make sure it only ever triggers on your hardware?

That's already done by the code fragment below.  If folks think the xAPIC 
version range test above is too dangerous, it can easily removed.

> > +	 * OEM/Product IDs.
> > +	 */
> > +	if (!strncmp(oem, "IBM ENSW", 8) &&
> > +	    (!strncmp(prod, "NF 6000R", 8) || !strncmp(prod, "VIGIL SMP", 9)) )
> > +		clustered_hint |= CLUSTERED_APIC_XAPIC;
> > +	else if (!strncmp(oem, "IBM NUMA", 8))
> > +		clustered_hint |= CLUSTERED_APIC_NUMAQ;
>
> [I'm surprised you are not using ACPI for this on your boxes]

ACPI was not, is not, and will never be available for NUMA-Q.  NUMA-Q was 
released long before ACPI was hatched.  There is a permanent feature freeze 
on NUMA-Q firmware.  Only bugs are fixed.  (Maybe.  The firmware folks got 
axed by the latest layoff....)

Thus, we have to make this work with MPS.  That's a good idea in any case.

> > +	 * A test in smp_cluster_apic_check() resolves the above conflict.
> > +	 ******/
> > +	if (mp_ioapics[idx].mpc_apicver >= XAPIC_VER_LOW &&
> > +	    mp_ioapics[idx].mpc_apicver <= XAPIC_VER_HIGH)
> > +		clustered_hint |= CLUSTERED_APIC_XAPIC;
>
> Same as above.

Ditto.

> > +#define TRAMPOLINE_LOW phys_to_virt(clustered_apic_numaq?0x8:0x467)
> > +#define TRAMPOLINE_HIGH phys_to_virt(clustered_apic_numaq?0xa:0x469)
>
> Ugly. I would use some global for this that is changed by the clustered
> apic init code.

That's straight from Martin's code, already in the base.  Only the names were 
changed to protect the guilty.   8^)

> Also you could get rid of all the // and #if 1/#if 0

Yup.  Was left in to show my uncertainty about the IRQ weirdness.  Oh, and to 
flag balance_irq.

> -Andi

Thanks again for the review.  I appreciate it.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

