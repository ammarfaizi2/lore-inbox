Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWEFGSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWEFGSh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 02:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWEFGSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 02:18:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:65362 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750966AbWEFGSf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 02:18:35 -0400
X-IronPort-AV: i="4.05,94,1146466800"; 
   d="scan'208"; a="32289734:sNHT19596941"
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Sat, 6 May 2006 02:18:30 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB65E9F0F@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-index: AcZvj+3cUNJ/67FZTaabyEaNx8cUSQAAHvvQAAIXkFAATcJ24A==
From: "Brown, Len" <len.brown@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 06 May 2006 06:18:32.0956 (UTC) FILETIME=[E6860BC0:01C670D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Natalie,
Regarding the "IRQ compression" in mp_register_gsi()....

Some time ago we invented ioapic_renumber_irq() to handle the case
where the ES7000 BIOS is missing the INTERRUPT_OVERRIDES needed
to tell that legacy IRQs used pins > 15, and PCI interrupts used
pins < 16.

In that case, the ES7000 uses es7000_rename_gsi() to simply re-number
the IRQs for the lower pins to some unused numbers above the highest
GSI in the system -- emulating what the BIOS should have done.

Later, GSI compression was also added to mp_register_gsi():

if (triggering == ACPI_LEVEL_SENSITIVE)
{
	gsi = pci_irq++;
	...
}

This GSI "compression" was intended to handle systems which have a large
number of sparsely populated IOAPICs.  On these systems, the maximum
GSI is well above NR_IRQS.  While there can be a large number of devices
on these boxes, the total in use is actually still below NR_IRQs --
so squeezing the GSIs into the IRQ numbers works.

The problem with doing this is that it also compresses the IRQ numbers
for the other 99.99% of the systems on earth, causing complexity
and bugs, such as several mentioned on this thread.

I'm thinking that it would be simpler for the big iron that has
GSI's > NR_IRQs, to simply use the existing ioapci_renumber_irq() hook
to do whatever compression or re-naming they fancy.
This will also allow for simpler systems to remain simple
and use identity irq = gsi numbering.
(don't get me started on CONFIG_PCI_MSI, that is an independent issue)

Also, as we discussed, it would probably be cleaner even on those large
systems if the compression algorithm did not re-name every GSI, but only
did re-names when it really has to (GSI > NR_IRQS).  eg.

< gsi = pci_irq++
---
> if (GSI < NR_IRQS)
>    gsi = irq;
> else
>    BUG_ON(irq_used >= NR_IRQS)
>    gsi = platform specific algorithm to grab the unused IRQs that
>    can never have any real devices attached.
> irqs_used++;

If we had done this, then we wouldn't have needed kimbal's patch.
If we do this, then we can delete that workaround on top of workaround.

thoughts?
-Len
