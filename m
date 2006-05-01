Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWEAXVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWEAXVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWEAXVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:21:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:30647 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932314AbWEAXVl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:21:41 -0400
X-IronPort-AV: i="4.04,170,1144047600"; 
   d="scan'208"; a="30987290:sNHT54685435"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Mon, 1 May 2006 19:21:26 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB652DDDD@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-Index: AcZsrFkWYuWmjSrjTZ2dfTZKRybUegAqtmzA
From: "Brown, Len" <len.brown@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 01 May 2006 23:21:28.0799 (UTC) FILETIME=[F94FB6F0:01C66D75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The original IRQ (on x86) was simply the enumeration of the input
>pins on the pair of i8259 interrupt controllers.

The IOAPIC was originally supported by MPS before ACPI.
MPS used IRQ to describe the ISA inputs to IOAPICs too,
and PIRQ to describe the PCI inputs.
Linux (wisely, IMHO) simply used IRQ to refer to an interrupt pin,
no matter where it is.

>The ACPI global system interrrupts is the enumeration of the input
>pins on the ioapics in the system.
>
>Therefore the GSI number is the IRQ number, by definition.

IRQ, as the term is now used in Linux, means "something to do
with a specific interrupt".  So yes, a GSI is an IRQ,
so is an interrupt vector, so is an interrupt handler,
so is an MSI, an interrupt controller pin,
and any number of various structures and handlers
where these items have "something to do with a specific interrupt".

If you have a more precise definition of IRQ in Linux,
by all means lets hear it; and lets compare the code to the definition
and see if we can make them match.

>However GSI is not a complete enumeration because it does not list
>MSI interrupt sources, and in general can not list MSI interrupt
>sources.

I agree, the term GSI doesn't comprehend MSIs, nor should it.

The ACPI spec allows the platform to tell the OS that it should
not enable MSI on a particular box.

The ACPI spec allows the OS to tell the platform that it supports MSI.

But, the specification and operation of MSI is completely outside of
ACPI,
as it should be with a standard native hardware interface.

> Further the term GSI is ACPI specific so it really
> doesn't make sense outside of that context while irq does.

I agree that GSI is a specific term with a single definition,
and it should have a single use, based on that definition,
in a context where that definition applies.

Re: irq making sense
Depends on the defintion, I suppose.  I'm still looking for one
that matches how Linux uses the term.

>So the question is how do we solve the big system problem.

Big systems are working today.  The question is how to keep
them working without overly complicating small systems.

>Problem 1.
>  We have more GSIs than interrupt vectors on a cpu, so a simple
>  1-1 mapping will not work.
>  However as Natalie's patch showed many of the GSIs are not even
>  connected so if we only allocate vectors to GSIs that are 
>  use we should not have a problem.

Which patch does this refer to?
We should never have had a problem with un-connected interrupt lines
consuming vectors, as the vectors are handed out at run-time
only when interrupts are requested by drivers.

>Problem 2.
>  Some systems have more than 224 GSIs that are actually 
>  connected to devices.
>  There are three possible ways to handle this case. 
>  - Fail after we run out of vectors.
>  - Share a vector.
>
>  - Allow vectors of different cpus to handle different irqs.
>    The is the most elegant and scalable, and Natalie's suggestion.

So here we allow the same vector to be used by different IOAPICS,
or IOAPIC pins, but have them it directed to different CPUs
who have per-cpu tables to vector to different devices?

A practical workaround?  Certainly.
An elegant solution?  No, that would require better hardware;-)

The problem with this workaround is going to be choose a policy
of where to direct what, and how to move things if interrupts
become un-balanced.

Further, the implementation should cost nothing on systems
that do not need it.

>So what would be a path to get there from here?
>- Fix the irq set_affinity code so that it makes the changes to
>  irqs when the interrupt is actually disabled.
>  Calling desc->handler->disable, desc->handler->enable
>  does not work immediately so the current code is racy.
>  Which shows up very badly if you attempt to change the irq vector,
>  and may cause rare problems today
>
>- Modify the MSI code to allocate irqs and not vectors.
>  So we don't have two paths through the code, for no good reason.

Modify the MSI code to allocate "something to do
with a specific interrupt".  Hmmm, but it does this already:-)

Seriously, aren't the interrupt vectors, or perhaps the
vector/cpu pair, the fundamental resource being allocated here?

>- Modify do_IRQ to get passed an interrupt vector# from the
>  interrupt vector instead of an irq number, and then lookup
>  the irq number in vector_irq.  This means we don't need
>  a code stub per irq, and allows us to handle more irqs
>  by simply increasing NR_IRQS.

isn't the vector number already on the stack from
ENTRY(interrupt)
	pushl $vector-256

what about per/irq kstats?
would you keep stats on a per-vector basis
and translate back to irqs for /proc/interrupts?
what about when the same vector is independently
used by multiple CPUS?

>- Remove the current irq compression.

maybe this can be moved up in the to-do list?

>- Move irq vector allocation/deallocation into request_irq, 
>and free_irq.
>
>- Make vector_irq per_cpu.
>
>- Modify assign_irq to allocate different vectors on different cpus,
>  to fail if we cannot find a free irq vector somewhere in the
>  irqs cpu set, and call assign_irq from set_affinity so when we change
>  cpus we can allocate a different irq.
>
>I have proof of concept level patches for everything thing 
>except making MSI actually allocate irqs, but that should be straight
forward.

except that irqs should be allocating vectors,
the fundamental currency here, and MSI should
be allocating the same, no?

>Does anyone know if we record the maximum GSI number? That looks like
>my sticking point for being able to write a simple irq allocator.

mpparse.c: mp_ioapic_routing[last].gsi_end

cheers,
-Len
