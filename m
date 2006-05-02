Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWEBIdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWEBIdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 04:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWEBIdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 04:33:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53195 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932508AbWEBIdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 04:33:44 -0400
To: "Brown, Len" <len.brown@intel.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
References: <CFF307C98FEABE47A452B27C06B85BB652DF16@hdsmsx411.amr.corp.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 02 May 2006 02:33:00 -0600
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB652DF16@hdsmsx411.amr.corp.intel.com> (Len
 Brown's message of "Tue, 2 May 2006 03:41:50 -0400")
Message-ID: <m1d5ew9683.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brown, Len" <len.brown@intel.com> writes:

>>IRQ is an interrupt request, from a device.
>>Currently they can come in over a pin, or over a packet.
>>IRQs at the source can be shared.
>
> Well stated.
>
>>For an IRQ number it is just an enumeration of interrupt sources.
>>Ideally in a stable manner so that the assigned number does not
>>depend on compile options, or which version of the kernel you
>>are running.
>
> While desirable, the "stable" part is not guaranteed.
> On an ACPI system with PCI Interrupt Link devices,
> request_irq() goes into the pci-enable-device path,
> which ends up asking ACPI what interrupt pin this device uses.
> But the pin is programmable, so we pick one from the list
> of possible, program the router accordingly, and this is what
> gets returned to request_irq().  ACPI PCI Interrupt Link Devices,
> of course, are just a wrapper for what x86 legacy calls PIRQ routers.
>
> In practice, if you boot the same or similar kernel on the
> same configuration, you get 'stable', but if something changes
> such as enabling/disabling a device or loading an additional device
> driver
> or otherwise tinkering with probe order, then all bets are off,
> since the sequence of selecting and
> balancing possible device interrupt lines between available IRQs has
> changed.

Agreed in the general case there is nothing we can do.  But
with a reasonable degree of stability things will stay put
long enough for people to reason about them.

Although I would actually expect us to use the normal twiddle of
irq lines on a bus.  But if we can have less contention that is certainly
better.

>>The global irq_desc array is the core of any definition.
>>That is how linux knows about irqs.  Beyond that we ideally
>>have stable numbers across reboots, and recompiles, and hardware
>>addition and removal.  Stable numbers are not really possible
>>but we can come quite close.
>
> Okay, I'm good with irq_desc, Linux's generic IRQ definition,
> being the center of the universe.  I'm also good with the index
> into irq_desc[] being the "IRQ number" show in /proc/interrupts.
> I guess I was thinking from a HW-specific point of view this
> afternoon...

I had to stare at the code for a while to see this as well.

> I don't like vector numbers being exposed in /proc/interrupts
> on x86.  On an ACPI-enabled system, I think that they should be
> the GSI.  This is consistent with the 0-15 legacy definitions
> being pin numbers (which I think we must keep), and consistent
> with the 16-n numbers being IOAPIC pin numbers (+offset),
> (which I think we should have kept).

Agreed.

> Of course, to do this simply, we'd have to select the irq_desc[i]
> with i = gsi, and not i = vector.

Exactly.

>>> We should never have had a problem with un-connected interrupt lines
>>> consuming vectors, as the vectors are handed out at run-time
>>> only when interrupts are requested by drivers.
>>
>>Incorrect.  By being requested by drivers I assume you mean by
>>request_irq.  assign_irq_vector is called long before request_irq
>>and in fact there is currently not a call from request_irq to
>>assign_irq_vector.  Look where assign_irq_vector is called in io_apic.c
>
> You are right.  This code is wrong.
> It makes absolutely no sense to reserve vectors in advance
> for every RTE in the IOAPIC when we don't even know if they
> are going to be used.
>
> This is clearly a holdover from the early IOAPIC/MPS days
> when we were talking about 4 to 8 non-legacy RTEs.
>
> This is where the big system vector shortage problem
> should be addressed.

Yes.  Natalie mentioned that there are some IBM systems
that still run out of processor vectors with our current
irq collapsing.

>>I think there is a legitimate case for legacy edge triggered
>>interrupts to request a vector sooner, as there are so many races in
>>the enable/disable paths. 
>
> I don't follow you on this part.

For edge triggered legacy irqs coming off the i8259 it probably makes
sense to assign them vectors early like we do currently.

I believe although I am not certain that with edge triggered irqs
actually disabling them makes it easy to miss edges.

>>
>>> The problem with this workaround is going to be choose a policy
>>> of where to direct what, and how to move things if interrupts
>>> become un-balanced.
>>
>>The directing problem already exists.  In general an I/O apic can
>>only direct an irq at a specific cpu, and linux already supports
>>cpusets on which an irq may be delivered.
>>
>>But yes on systems with 8 or fewer cpus the I/O apics can do the
>>directing themselves and it is likely we still want to handle that
>>case.
>
> I don't think it is important to optimize for <= 8 CPUs
> having hundreds of unique interrupts.  Systems with huge
> numbers of interrutps will have more than 8 CPUs.  If they
> don't, then the should function, but being optimal isn't
> what the administrator had in mind.  With multiple cores
> being added to systems, this becomes even more true
> over time.

Sorry. To be clear for systems with <= 8 CPUs we need to allocate
a common vector for all 8 cpus at once if we want to use
flat mode and this makes a version of assign_irq_vector that can work
assign per cpu vectors more complicated, since it has to handle both
cases.  Hmm, should assign_irq_vector become a ioapic method?

I don't think we want to loose the optimization of letting the
hardware select select the cpu on small systems.

>>It is reassuring to see that the way I want to make the code work tends
>>to be they way you already think the code works.  I can't be too far
>>off in reducing the complexity.
>
> Yeah, thanks for pointing out that the vectors are assigned at
> IOAPIC init-time.  I hadn't noticed that, and it needs to be addressed.

Exactly.  Once that is fixed setting gsi == irq should be trivial.
Then we only have to worry about big systems that actually use
more than 244 IRQs.  Which is where the per cpu vector assignment
comes in.

Eric


