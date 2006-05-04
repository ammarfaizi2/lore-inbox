Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWEDQFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWEDQFk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 12:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWEDQFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 12:05:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:59066 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751505AbWEDQFj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 12:05:39 -0400
X-IronPort-AV: i="4.05,89,1146466800"; 
   d="scan'208"; a="31485991:sNHT5987098054"
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Thu, 4 May 2006 12:04:19 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB65ACA39@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-index: AcZvj+3cUNJ/67FZTaabyEaNx8cUSQAAHvvQ
From: "Brown, Len" <len.brown@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 04 May 2006 16:04:25.0732 (UTC) FILETIME=[6A627C40:01C66F94]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>>>>> We should never have had a problem with un-connected 
>interrupt lines
>>>>> consuming vectors, as the vectors are handed out at run-time
>>>>> only when interrupts are requested by drivers.
>>>>
>>>>Incorrect.  By being requested by drivers I assume you mean by
>>>>request_irq.  assign_irq_vector is called long before request_irq
>>>>and in fact there is currently not a call from request_irq to
>>>>assign_irq_vector.  Look where assign_irq_vector is called in 
>>>io_apic.c
>>
>> Hmmm, on Natalie's ping, I looked at this again.
>>
>> setup_IO_APIC_irqs() actually consumes only 16 vectors.
>> This is because it only sets up the IRQs for pins
>> found with find_irq_entry(), which searches mp_irqs[]
>> which at this point contains only the legacy identify mappings.
>
>In the case of ACPI.  I think the mptable case has all of information
>in mp_irqs at that point.

Agreed, I just sent a note on this, but apparently it "crossed
in the mail" with yours.  The key point about MPS is that MPS
should not describe pins that can never be connected -- so that isn't
quite as bad as handing out a vector for every RTE, which is what the
code appears to do on first read...

>> The PNP code then takes a swing at things, and it registers
>> a handful of gsi's, but they are all duplicates of the legacy
>> mappings already set-up, so no additional vectors are consumed.
>>
>> So on a big system, the large quantity of vectors will not 
>be consumed
>> at
>> IOAPIC initialization time, but later at device probe time.
>> Not via request_irq(), but via pci_enable_device():
>>
>> pci_enable_device()
>>  pci_enable_device_bars()
>>   pcibios_enable_device()
>>    pcibios_enable_irq() -> acpi_pci_irq_enable()
>>     acpi_register_gsi()
>>      mp_register_gsi()
>>       io_apic_set_pci_routing()
>>        entry.vector = assign_irq_vector(irq)
>>
>> So except for the legacy IRQs, we are already allocating the vectors
>> on-demand, and that doesn't need to be fixed.
>
>I agree with the fact, we do allocate the vectors on-demand.
>Since the allocation is not allowed to fail, and because
>it seems to be an accident of the implementation rather
>than a deliberate implementation detail I still think it
>needs to be fixed so the code is less brittle.

Yeah, it isn't clear that this has any advantage over assigning
the vector at request_irq() time where one would expect to see it.
Though some might consider "currently working" an advantage:-)

>But if we are not afraid of breaking machines with more
>that 243 interrupt sources (which currently force ioapic/pin
>combinations to share irqs today) it does mean we can move
>the removal of the irq to gsi mapping up, in the patch series.  We
>first need to raise the limit on the number of IRQs on x86.

No, I don't think we have the license to intentionally break big
machines
that are currently working.  In the long run, these two big-machine
hacks should go away:

mp_register_gsi()
	/*
	 * For PCI devices, assign IRQs in order, avoiding gaps
	 * due to unused I/O APIC pins.
	 */
	...

io_apic_set_pci_routing() (x86_64 only upstream, i386 too on SuSE)
	irq = gsi_irq_sharing(irq)


I think what we can do in the short term is to make these workarounds
not have any effect on the systems which don't need them.  This means
searching like gsi_irq_sharing() does, instead of always compressing
like mp_register_gsi() does.  It also means not printing dmesg
about vector sharing when no sharing is actually happening.


>We can't raise the limit on the number of IRQs when msi is
>enabled but enabling CONFIG_PCI_MSI already has problem in this
>area and that is an independent fix.
>
>Since we unnecessarily break big machines I think this needs to sit
>in -mm until the window for 2.6.18 opens up.  By that time we should
>be able to get all of the pieces in to keep the largest of machines
>working well into the future.
>
>That includes fixing msi to allocate irqs, fixing the irq affinity
>calls to be race free, and making the vector allocation to be
>a per cpu allocation.
>
>I still think we need to do everything I outlined previously if
>for no other reason than to leave us with a maintainable code
>base that works for obvious reasons.  But since the dependencies
>are not as bad as they previously appeared, it does mean we can
>take the patches in a different order.

Based on past history of the un-intended impact of interrupt changes,
(eg. what started this thread)
I would suggest that only the simplest things go into 2.6.18
and that the larger changes stay in -mm for all of 2.6.18
and targtet 2.6.19.

-Len
