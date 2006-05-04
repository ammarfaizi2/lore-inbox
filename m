Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWEDWmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWEDWmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 18:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWEDWmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 18:42:31 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53121 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751384AbWEDWma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 18:42:30 -0400
To: "Brown, Len" <len.brown@intel.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
References: <CFF307C98FEABE47A452B27C06B85BB65ACA39@hdsmsx411.amr.corp.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 04 May 2006 16:41:33 -0600
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB65ACA39@hdsmsx411.amr.corp.intel.com> (Len
 Brown's message of "Thu, 4 May 2006 12:04:19 -0400")
Message-ID: <m1ac9x76qq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brown, Len" <len.brown@intel.com> writes:

>>In the case of ACPI.  I think the mptable case has all of information
>>in mp_irqs at that point.
>
> Agreed, I just sent a note on this, but apparently it "crossed
> in the mail" with yours.  The key point about MPS is that MPS
> should not describe pins that can never be connected -- so that isn't
> quite as bad as handing out a vector for every RTE, which is what the
> code appears to do on first read...

Makes sense.

>>I agree with the fact, we do allocate the vectors on-demand.
>>Since the allocation is not allowed to fail, and because
>>it seems to be an accident of the implementation rather
>>than a deliberate implementation detail I still think it
>>needs to be fixed so the code is less brittle.
>
> Yeah, it isn't clear that this has any advantage over assigning
> the vector at request_irq() time where one would expect to see it.
> Though some might consider "currently working" an advantage:-)

Right.  This will have to wait until I can start sending patches.

>>But if we are not afraid of breaking machines with more
>>that 243 interrupt sources (which currently force ioapic/pin
>>combinations to share irqs today) it does mean we can move
>>the removal of the irq to gsi mapping up, in the patch series.  We
>>first need to raise the limit on the number of IRQs on x86.
>
> No, I don't think we have the license to intentionally break big
> machines
> that are currently working.

No but it may be ok. At an intermediate step in a series of patches.
Although ideally even that would never happen.

> In the long run, these two big-machine
> hacks should go away:
>
> mp_register_gsi()
> 	/*
> 	 * For PCI devices, assign IRQs in order, avoiding gaps
> 	 * due to unused I/O APIC pins.
> 	 */
> 	...
>
> io_apic_set_pci_routing() (x86_64 only upstream, i386 too on SuSE)
> 	irq = gsi_irq_sharing(irq)
>
>
> I think what we can do in the short term is to make these workarounds
> not have any effect on the systems which don't need them.  This means
> searching like gsi_irq_sharing() does, instead of always compressing
> like mp_register_gsi() does.  It also means not printing dmesg
> about vector sharing when no sharing is actually happening.

I'm a long run kind of guy :)
As soon as I clean up my proof of concept code and send it
out I will have both of those killed.

> Based on past history of the un-intended impact of interrupt changes,
> (eg. what started this thread)
> I would suggest that only the simplest things go into 2.6.18
> and that the larger changes stay in -mm for all of 2.6.18
> and targtet 2.6.19.

That makes sense.  I'm in no hurry :)  Mostly my intention was
that this is not 2.6.17 material and whatever short term hacks
are needed to make 2.6.17 work  need to go in now.

Eric
