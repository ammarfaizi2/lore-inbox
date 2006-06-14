Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWFNHz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWFNHz6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 03:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWFNHz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 03:55:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59104 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751228AbWFNHz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 03:55:57 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: The i386 and x86_64 genirq patches are wrong!
References: <m1r71t2ew8.fsf@ebiederm.dsl.xmission.com>
	<20060614070353.GA11896@elte.hu>
Date: Wed, 14 Jun 2006 01:55:24 -0600
In-Reply-To: <20060614070353.GA11896@elte.hu> (Ingo Molnar's message of "Wed,
	14 Jun 2006 09:03:53 +0200")
Message-ID: <m1r71s189f.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> A little while ago I worked up some patches to that made x86 vectors 
>> per cpu.  Allowing x86 to handle more than 256 irqs, which 
>> significantly cleaned up the code.
>> 
>> The big stumbling block there was msi and it's totally backwards way 
>> of allocating interrupts.  Getting msi to work with irqs and not 
>> vectors is a lot of work, and very hard to make a clean patchset out 
>> of.
>
> yeah. The whole MSI irq remapping business is a total mess anyway: all 
> that trouble we do to compensate a +32 mapping offset of vectors vs. 
> irqs? Why dont we simply fix up all IRQ entry stubs to have +32, and 
> thus we'd standardize on vector metrics and be done with it. In 
> /proc/interrupts we could subtract 32 perhaps. Then MSI would be always 
> enabled and there would be no MSI #ifdefs anywhere. Am i missing 
> something?

The problem that got me started was that on big boxes
NR_IOAPICS*NR_IOAPiC_PINS on large boxes is frequently in the 1400+
territory.  we have 1400+ irq sources that we can address
individually. The code to map that into 256 interrupt vectors is a
real maintenance pain, and limits what we can do in the future.  

On x86 hardware interrupts are sent from interrupt sources to a cpu
vector pair (at least above 8 cpus).  If you take advantage of that
you can allow your self to have NR_CPUS*255 irqs all working
simultaneously without sharing.  I have tested a basic version of that
and it works.

In acpi the enumeration of the ioapic source pins is called the gsi
number, and it we want irq numbers to be meaningful our irqs in an
ioapic based system really need to be the gsi.  But that requires
we actually use the dynamic mapping of irq# to vector that we
currently have.   All of which is easy to do and simplifies a
lot of code unless you want to enable msi.

As for msi, I want to introduce two arch specific helper functions:

 extern int create_irq(struct irq_chip *chip, void *handler_data);
 extern void destroy_irq(unsigned int irq);

That understand the architectures rules for irq number assignment
and do whatever is appropriate.  The rest of the code can then work.

>> I currently have a pending bug fix that puts move_irq in the correct 
>> place for edge and level triggered interrupts.
>> 
>> For edge triggered interrupts you must move the irq before you 
>> acknowledge the interrupt, or else it can reoccur.
>>
>> For level triggered interrupts you must acknowledge the irq before you 
>> move it, or else the acknowledgement will never find it's way back to 
>> the irq source.
>
> could you please send that fix to me, against whatever base you have it 
> tested on, and i'll merge it to genirq/irqchips [and fix up genirq if 
> needed]. Please also include a description of the problem. How common is 
> that edge retrigger problem, and how come this has never been seen in 
> the past years since we had irqbalance?

Sure.  I'm in the process of breaking it out from my development work
where it was in a big blob with a lot of other changes.  I was going
to make it against -mm but it looks like I need to do that against something
else.

We haven't seen it because the only symptom currently is that an
interrupt is delivered on the wrong cpu.  Since don't change the vector
number we don't notice and life is fine.

As soon as you start caring which cpu an interrupt comes in on it
shows up fast.  Which is why I caught it.


I will send something better in a little while but here are the
relevant irq handling methods, snipped out of my working version
of io_apic.c:

> /*
>  * Once we have recorded IRQ_PENDING already, we can mask the
>  * interrupt for real. This prevents IRQ storms from unhandled
>  * devices.
>  */
> static void ack_edge_ioapic_irq(unsigned int irq)
> {
> 	irq_desc_t *desc = irq_descp(irq);
> 	int do_unmask_irq = 0;
> 	if (((desc->status & (IRQ_PENDING | IRQ_DISABLED))
> 		    == (IRQ_PENDING | IRQ_DISABLED)) || 
> 					    (desc->status & IRQ_MOVE_PENDING)) {
> 		do_unmask_irq = !(desc->status & (IRQ_DISABLED | IRQ_PENDING));
> 		mask_IO_APIC_irq(irq);
> 	}
> 	move_irq(irq);
> 	ack_APIC_irq();
> 	if (unlikely(do_unmask_irq))
> 		unmask_IO_APIC_irq(irq);
> }
...
> static void end_level_ioapic_irq (unsigned int irq)
> {
> 	int do_unmask_irq = 0;
> 	if (unlikely(irq_descp(irq)->status & IRQ_MOVE_PENDING)) {
> 		do_unmask_irq = 1;
> 		mask_IO_APIC_irq(irq);
> 	}
> 	ack_APIC_irq();
> 	move_irq(irq);
> 	if (unlikely(do_unmask_irq))
> 		unmask_IO_APIC_irq(irq);
> }

Two notes for reading the above code.  In that source tree I
have changed move_irq into a flag IRQ_MOVE_PENDING, and I have
reduce move_irq and move_irq_native to just move_irq.

That at least should clearly show the logic I am working with.

>> Previously in io_apic.c the hacks that the msi code imposed on it were 
>> clear, and many of them were enclosed in #ifdef CONFIG_PCI_MSI. Now 
>> that ifdefs are gone, and the logic in io_apic.h that selected between 
>> the versions of the irq handlers to use (vector or irq) has not been 
>> updated.
>> 
>> I don't know if the latter is actually a bug.  But it definitely makes 
>> it harder to remove the msi hacks, and io_apic.h should definitely 
>> have been updated.
>
> here too it's hard for me to give an answer without seeing your specific 
> changes (against whatever base is most convenient to you). MSI certainly 
> works fine on current -mm. (at least on my box)

So I'm not certain the msi/non-msi case is broken at the moment.  I haven't
looked at it close enough to convince myself either way.  What is clearly
wrong is that the comments now no longer reflect the code, and 
io_apic.h still had defines referring to the previous situation.

>From io_apic.c
> /*
>  * Level and edge triggered IO-APIC interrupts need different handling,
>  * so we use two separate IRQ descriptors. Edge triggered IRQs can be
>  * handled with the level-triggered descriptor, but that one has slightly
>  * more overhead. Level-triggered interrupts cannot be handled with the
>  * edge-triggered handler, without risking IRQ storms and other ugly
>  * races.
>  */
> 

>From io_apic.h
> #ifdef CONFIG_PCI_MSI
> static inline int use_pci_vector(void)	{return 1;}
> static inline void disable_edge_ioapic_vector(unsigned int vector) { }
> static inline void mask_and_ack_level_ioapic_vector(unsigned int vector) { }
> static inline void end_edge_ioapic_vector (unsigned int vector) { }
> #define startup_level_ioapic	startup_level_ioapic_vector
> #define shutdown_level_ioapic	mask_IO_APIC_vector
> #define enable_level_ioapic	unmask_IO_APIC_vector
> #define disable_level_ioapic	mask_IO_APIC_vector
> #define mask_and_ack_level_ioapic mask_and_ack_level_ioapic_vector
> #define end_level_ioapic	end_level_ioapic_vector
> #define set_ioapic_affinity	set_ioapic_affinity_vector
> 
> #define startup_edge_ioapic 	startup_edge_ioapic_vector
> #define shutdown_edge_ioapic 	disable_edge_ioapic_vector
> #define enable_edge_ioapic 	unmask_IO_APIC_vector
> #define disable_edge_ioapic 	disable_edge_ioapic_vector
> #define ack_edge_ioapic 	ack_edge_ioapic_vector
> #define end_edge_ioapic 	end_edge_ioapic_vector
> #else
> static inline int use_pci_vector(void)	{return 0;}
> static inline void disable_edge_ioapic_irq(unsigned int irq) { }
> static inline void mask_and_ack_level_ioapic_irq(unsigned int irq) { }
> static inline void end_edge_ioapic_irq (unsigned int irq) { }
> #define startup_level_ioapic	startup_level_ioapic_irq
> #define shutdown_level_ioapic	mask_IO_APIC_irq
> #define enable_level_ioapic	unmask_IO_APIC_irq
> #define disable_level_ioapic	mask_IO_APIC_irq
> #define mask_and_ack_level_ioapic mask_and_ack_level_ioapic_irq
> #define end_level_ioapic	end_level_ioapic_irq
> #define set_ioapic_affinity	set_ioapic_affinity_irq
> 
> #define startup_edge_ioapic 	startup_edge_ioapic_irq
> #define shutdown_edge_ioapic 	disable_edge_ioapic_irq
> #define enable_edge_ioapic 	unmask_IO_APIC_irq
> #define disable_edge_ioapic 	disable_edge_ioapic_irq
> #define ack_edge_ioapic 	ack_edge_ioapic_irq
> #define end_edge_ioapic 	end_edge_ioapic_irq
> #endif

Eric
