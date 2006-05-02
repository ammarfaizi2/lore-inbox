Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWEBGZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWEBGZP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWEBGZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:25:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18890 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932400AbWEBGZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:25:12 -0400
To: "Brown, Len" <len.brown@intel.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
References: <CFF307C98FEABE47A452B27C06B85BB652DDDD@hdsmsx411.amr.corp.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 02 May 2006 00:24:25 -0600
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB652DDDD@hdsmsx411.amr.corp.intel.com> (Len
 Brown's message of "Mon, 1 May 2006 19:21:26 -0400")
Message-ID: <m1lktl9c6e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brown, Len" <len.brown@intel.com> writes:

>>The original IRQ (on x86) was simply the enumeration of the input
>>pins on the pair of i8259 interrupt controllers.
>
> The IOAPIC was originally supported by MPS before ACPI.
> MPS used IRQ to describe the ISA inputs to IOAPICs too,
> and PIRQ to describe the PCI inputs.
> Linux (wisely, IMHO) simply used IRQ to refer to an interrupt pin,
> no matter where it is.
>
>>The ACPI global system interrrupts is the enumeration of the input
>>pins on the ioapics in the system.
>>
>>Therefore the GSI number is the IRQ number, by definition.
>
> IRQ, as the term is now used in Linux, means "something to do
> with a specific interrupt".  So yes, a GSI is an IRQ,
> so is an interrupt vector, so is an interrupt handler,
> so is an MSI, an interrupt controller pin,
> and any number of various structures and handlers
> where these items have "something to do with a specific interrupt".
>
> If you have a more precise definition of IRQ in Linux,
> by all means lets hear it; and lets compare the code to the definition
> and see if we can make them match.

IRQ is an interrupt request, from a device.
Currently they can come in over a pin, or over a packet.
IRQs at the source can be shared.

For an IRQ number it is just an enumeration of interrupt sources.
Ideally in a stable manner so that the assigned number does not
depend on compile options, or which version of the kernel you
are running.

>>However GSI is not a complete enumeration because it does not list
>>MSI interrupt sources, and in general can not list MSI interrupt
>>sources.
>
> I agree, the term GSI doesn't comprehend MSIs, nor should it.
>
> The ACPI spec allows the platform to tell the OS that it should
> not enable MSI on a particular box.
>
> The ACPI spec allows the OS to tell the platform that it supports MSI.
>
> But, the specification and operation of MSI is completely outside of
> ACPI,
> as it should be with a standard native hardware interface.
>
>> Further the term GSI is ACPI specific so it really
>> doesn't make sense outside of that context while irq does.
>
> I agree that GSI is a specific term with a single definition,
> and it should have a single use, based on that definition,
> in a context where that definition applies.
>
> Re: irq making sense
> Depends on the defintion, I suppose.  I'm still looking for one
> that matches how Linux uses the term.

The global irq_desc array is the core of any definition.
That is how linux knows about irqs.  Beyond that we ideally
have stable numbers across reboots, and recompiles, and hardware
addition and removal.  Stable numbers are not really possible
but we can come quite close.

>>So the question is how do we solve the big system problem.
>
> Big systems are working today.  The question is how to keep
> them working without overly complicating small systems.

Agreed.  A better way to have put is how do we solve the problems
of big systems in a simple way.

>>Problem 1.
>>  We have more GSIs than interrupt vectors on a cpu, so a simple
>>  1-1 mapping will not work.
>>  However as Natalie's patch showed many of the GSIs are not even
>>  connected so if we only allocate vectors to GSIs that are 
>>  use we should not have a problem.
>
> Which patch does this refer to?

Sorry to be clear the irq compression code, that being fixed yet
again started this thread.

> We should never have had a problem with un-connected interrupt lines
> consuming vectors, as the vectors are handed out at run-time
> only when interrupts are requested by drivers.

Incorrect.  By being requested by drivers I assume you mean by
request_irq.  assign_irq_vector is called long before request_irq
and in fact there is currently not a call from request_irq to
assign_irq_vector.  Look where assign_irq_vector is called in io_apic.c

I think there is a legitimate case for legacy edge triggered
interrupts to request a vector sooner, as there are so many races in
the enable/disable paths. 

>>Problem 2.
>>  Some systems have more than 224 GSIs that are actually 
>>  connected to devices.
>>  There are three possible ways to handle this case. 
>>  - Fail after we run out of vectors.
>>  - Share a vector.
>>
>>  - Allow vectors of different cpus to handle different irqs.
>>    The is the most elegant and scalable, and Natalie's suggestion.
>
> So here we allow the same vector to be used by different IOAPICS,
> or IOAPIC pins, but have them it directed to different CPUs
> who have per-cpu tables to vector to different devices?
>
> A practical workaround?  Certainly.
> An elegant solution?  No, that would require better hardware;-)

Agreed. But we lost elegant at the point of on demand assigning of
vectors to irqs.

> The problem with this workaround is going to be choose a policy
> of where to direct what, and how to move things if interrupts
> become un-balanced.

The directing problem already exists.  In general an I/O apic can
only direct an irq at a specific cpu, and linux already supports
cpusets on which an irq may be delivered.

But yes on systems with 8 or fewer cpus the I/O apics can do the
directing themselves and it is likely we still want to handle that
case.

> Further, the implementation should cost nothing on systems
> that do not need it.

I think the entire cost can be left in the vector selection,
but certainly something to scrutinized the patch for.

>>So what would be a path to get there from here?
>>- Fix the irq set_affinity code so that it makes the changes to
>>  irqs when the interrupt is actually disabled.
>>  Calling desc->handler->disable, desc->handler->enable
>>  does not work immediately so the current code is racy.
>>  Which shows up very badly if you attempt to change the irq vector,
>>  and may cause rare problems today
>>
>>- Modify the MSI code to allocate irqs and not vectors.
>>  So we don't have two paths through the code, for no good reason.
>
> Modify the MSI code to allocate "something to do
> with a specific interrupt".  Hmmm, but it does this already:-)
>
> Seriously, aren't the interrupt vectors, or perhaps the
> vector/cpu pair, the fundamental resource being allocated here?

So there are two pieces.  struct irq_desc that describes
an interrupt source, and the vector that catches the interrupt
source and tells the cpu about it.  
 
To be able to manage an irq source we need to enumerate and give it a
struct irq_desc entry in the global irq_desc array.  One of the
operations we perform after that point is to allocate it a vector so
we can catch that irq source.  But other operations such as reporting,
and the assignment of cpu affinity also happen based on the entry
in the irq_desc array.

Except for architecture implementations of irq routing the vectors
that we catch irqs with should be completely invisible.  The ideal
architecture would not even have a separate concept and except for
the msi code linux has not exported the concept of vectors outside
of the architecture implementations.


>>- Modify do_IRQ to get passed an interrupt vector# from the
>>  interrupt vector instead of an irq number, and then lookup
>>  the irq number in vector_irq.  This means we don't need
>>  a code stub per irq, and allows us to handle more irqs
>>  by simply increasing NR_IRQS.
>
> isn't the vector number already on the stack from
> ENTRY(interrupt)
> 	pushl $vector-256

No.  Currently we pass in the irq number.  The vector
number is forgotten.  So this would require a
vector_irq[vector#] lookup in do_IRQ.

Either that or we allocate a lot more stubs.
Basically there is a simple trade off between code size
and data size in how we do this.  I think less code and
more data is the way to go but I could trivially be convinced
otherwise.

> what about per/irq kstats?
> would you keep stats on a per-vector basis
> and translate back to irqs for /proc/interrupts?

No.  What we have on a per irq basis is what makes sense
and I would leave that untouched.

> what about when the same vector is independently
> used by multiple CPUS?

Accounting by irq makes sense.

>>- Remove the current irq compression.
>
> maybe this can be moved up in the to-do list?

Not much.  
- The current set_affinity code has a real bug.
- The MSI mismatch is worse and fixing it reduces testing later. 
- We need to raise the number of irqs we can support.  Either
  by vastly increasing the number of stubs, whose number looks
  hard to control at compile time, or by turning this into
  a data problem.

>>- Move irq vector allocation/deallocation into request_irq, 
>>and free_irq.
>>
>>- Make vector_irq per_cpu.
>>
>>- Modify assign_irq to allocate different vectors on different cpus,
>>  to fail if we cannot find a free irq vector somewhere in the
>>  irqs cpu set, and call assign_irq from set_affinity so when we change
>>  cpus we can allocate a different irq.
>>
>>I have proof of concept level patches for everything thing 
>>except making MSI actually allocate irqs, but that should be straight
> forward.
>
> except that irqs should be allocating vectors,
> the fundamental currency here, and MSI should
> be allocating the same, no?

Not quite.  The MSI code should first allocate
an irq_desc entry get an IRQ number.

Then when the driver calls request_irq the architecture specific
code should arrange for __do_IRQ to be called with the appropriate
irq number when the interrupt happens.  The architecture specific
code needs to do this by setting the MSI address and the MSI data to
an architecture specific values, that on x86 will involve the a
vector.

>>Does anyone know if we record the maximum GSI number? That looks like
>>my sticking point for being able to write a simple irq allocator.
>
> mpparse.c: mp_ioapic_routing[last].gsi_end

Thanks.  I found that a bit before I saw this email.
It looks like I have all of the pieces now to see if I have the time. :)

It is reassuring to see that the way I want to make the code work tends
to be they way you already think the code works.  I can't be too far
off in reducing the complexity.

Eric
