Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWEBHl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWEBHl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWEBHl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:41:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:41660 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932487AbWEBHlz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:41:55 -0400
X-IronPort-AV: i="4.05,79,1146466800"; 
   d="scan'208"; a="31126506:sNHT17373209"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Tue, 2 May 2006 03:41:50 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB652DF16@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-Index: AcZtsT6vgePsEi1vT3SuA0EDhIDZnQAAVFaw
From: "Brown, Len" <len.brown@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 02 May 2006 07:41:53.0206 (UTC) FILETIME=[E140A560:01C66DBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>IRQ is an interrupt request, from a device.
>Currently they can come in over a pin, or over a packet.
>IRQs at the source can be shared.

Well stated.

>For an IRQ number it is just an enumeration of interrupt sources.
>Ideally in a stable manner so that the assigned number does not
>depend on compile options, or which version of the kernel you
>are running.

While desirable, the "stable" part is not guaranteed.
On an ACPI system with PCI Interrupt Link devices,
request_irq() goes into the pci-enable-device path,
which ends up asking ACPI what interrupt pin this device uses.
But the pin is programmable, so we pick one from the list
of possible, program the router accordingly, and this is what
gets returned to request_irq().  ACPI PCI Interrupt Link Devices,
of course, are just a wrapper for what x86 legacy calls PIRQ routers.

In practice, if you boot the same or similar kernel on the
same configuration, you get 'stable', but if something changes
such as enabling/disabling a device or loading an additional device
driver
or otherwise tinkering with probe order, then all bets are off,
since the sequence of selecting and
balancing possible device interrupt lines between available IRQs has
changed.

>> Re: irq making sense
>> Depends on the defintion, I suppose.  I'm still looking for one
>> that matches how Linux uses the term.
>
>The global irq_desc array is the core of any definition.
>That is how linux knows about irqs.  Beyond that we ideally
>have stable numbers across reboots, and recompiles, and hardware
>addition and removal.  Stable numbers are not really possible
>but we can come quite close.

Okay, I'm good with irq_desc, Linux's generic IRQ definition,
being the center of the universe.  I'm also good with the index
into irq_desc[] being the "IRQ number" show in /proc/interrupts.
I guess I was thinking from a HW-specific point of view this
afternoon...

I don't like vector numbers being exposed in /proc/interrupts
on x86.  On an ACPI-enabled system, I think that they should be
the GSI.  This is consistent with the 0-15 legacy definitions
being pin numbers (which I think we must keep), and consistent
with the 16-n numbers being IOAPIC pin numbers (+offset),
(which I think we should have kept).

Of course, to do this simply, we'd have to select the irq_desc[i]
with i = gsi, and not i = vector.

>> We should never have had a problem with un-connected interrupt lines
>> consuming vectors, as the vectors are handed out at run-time
>> only when interrupts are requested by drivers.
>
>Incorrect.  By being requested by drivers I assume you mean by
>request_irq.  assign_irq_vector is called long before request_irq
>and in fact there is currently not a call from request_irq to
>assign_irq_vector.  Look where assign_irq_vector is called in io_apic.c

You are right.  This code is wrong.
It makes absolutely no sense to reserve vectors in advance
for every RTE in the IOAPIC when we don't even know if they
are going to be used.

This is clearly a holdover from the early IOAPIC/MPS days
when we were talking about 4 to 8 non-legacy RTEs.

This is where the big system vector shortage problem
should be addressed.

>I think there is a legitimate case for legacy edge triggered
>interrupts to request a vector sooner, as there are so many races in
>the enable/disable paths. 

I don't follow you on this part.

>>>Problem 2.
>>>  Some systems have more than 224 GSIs that are actually 
>>>  connected to devices.
>>>  There are three possible ways to handle this case. 
>>>  - Fail after we run out of vectors.
>>>  - Share a vector.
>>>
>>>  - Allow vectors of different cpus to handle different irqs.
>>>    The is the most elegant and scalable, and Natalie's suggestion.
>>
>> So here we allow the same vector to be used by different IOAPICS,
>> or IOAPIC pins, but have them it directed to different CPUs
>> who have per-cpu tables to vector to different devices?
>>
>> A practical workaround?  Certainly.
>> An elegant solution?  No, that would require better hardware;-)
>
>Agreed. But we lost elegant at the point of on demand assigning of
>vectors to irqs.
>
>> The problem with this workaround is going to be choose a policy
>> of where to direct what, and how to move things if interrupts
>> become un-balanced.
>
>The directing problem already exists.  In general an I/O apic can
>only direct an irq at a specific cpu, and linux already supports
>cpusets on which an irq may be delivered.
>
>But yes on systems with 8 or fewer cpus the I/O apics can do the
>directing themselves and it is likely we still want to handle that
>case.

I don't think it is important to optimize for <= 8 CPUs
having hundreds of unique interrupts.  Systems with huge
numbers of interrutps will have more than 8 CPUs.  If they
don't, then the should function, but being optimal isn't
what the administrator had in mind.  With multiple cores
being added to systems, this becomes even more true
over time.

>>>So what would be a path to get there from here?
>>>- Fix the irq set_affinity code so that it makes the changes to
>>>  irqs when the interrupt is actually disabled.
>>>  Calling desc->handler->disable, desc->handler->enable
>>>  does not work immediately so the current code is racy.
>>>  Which shows up very badly if you attempt to change the irq vector,
>>>  and may cause rare problems today
>>>
>>>- Modify the MSI code to allocate irqs and not vectors.
>>>  So we don't have two paths through the code, for no good reason.
>>
>> Modify the MSI code to allocate "something to do
>> with a specific interrupt".  Hmmm, but it does this already:-)
>>
>> Seriously, aren't the interrupt vectors, or perhaps the
>> vector/cpu pair, the fundamental resource being allocated here?
>
>So there are two pieces.  struct irq_desc that describes
>an interrupt source, and the vector that catches the interrupt
>source and tells the cpu about it.  
> 
>To be able to manage an irq source we need to enumerate and give it a
>struct irq_desc entry in the global irq_desc array.  One of the
>operations we perform after that point is to allocate it a vector so
>we can catch that irq source.  But other operations such as reporting,
>and the assignment of cpu affinity also happen based on the entry
>in the irq_desc array.
>
>Except for architecture implementations of irq routing the vectors
>that we catch irqs with should be completely invisible.  The ideal
>architecture would not even have a separate concept and except for
>the msi code linux has not exported the concept of vectors outside
>of the architecture implementations.

Agreed.

>> what about per/irq kstats?
>> would you keep stats on a per-vector basis
>> and translate back to irqs for /proc/interrupts?
>
>No.  What we have on a per irq basis is what makes sense
>and I would leave that untouched.

Agreed.

>> what about when the same vector is independently
>> used by multiple CPUS?
>
>Accounting by irq makes sense.

Agreed.

>>>- Remove the current irq compression.
>>
>> maybe this can be moved up in the to-do list?
>
>Not much.  
>- The current set_affinity code has a real bug.
>- The MSI mismatch is worse and fixing it reduces testing later. 
>- We need to raise the number of irqs we can support.  Either
>  by vastly increasing the number of stubs, whose number looks
>  hard to control at compile time, or by turning this into
>  a data problem.
>
>>>- Move irq vector allocation/deallocation into request_irq, 
>>>and free_irq.
>>>
>>>- Make vector_irq per_cpu.
>>>
>>>- Modify assign_irq to allocate different vectors on different cpus,
>>>  to fail if we cannot find a free irq vector somewhere in the
>>>  irqs cpu set, and call assign_irq from set_affinity so 
>when we change
>>>  cpus we can allocate a different irq.
>>>
>>>I have proof of concept level patches for everything thing 
>>>except making MSI actually allocate irqs, but that should be straight
>> forward.
>>
>> except that irqs should be allocating vectors,
>> the fundamental currency here, and MSI should
>> be allocating the same, no?
>
>Not quite.  The MSI code should first allocate
>an irq_desc entry get an IRQ number.

You're right.  I agree.

>Then when the driver calls request_irq the architecture specific
>code should arrange for __do_IRQ to be called with the appropriate
>irq number when the interrupt happens.  The architecture specific
>code needs to do this by setting the MSI address and the MSI data to
>an architecture specific values, that on x86 will involve the a
>vector.
>

>It is reassuring to see that the way I want to make the code work tends
>to be they way you already think the code works.  I can't be too far
>off in reducing the complexity.

Yeah, thanks for pointing out that the vectors are assigned at
IOAPIC init-time.  I hadn't noticed that, and it needs to be addressed.

-Len
