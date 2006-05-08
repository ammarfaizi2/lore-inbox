Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWEHSh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWEHSh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 14:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWEHSh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 14:37:59 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:46354 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S932484AbWEHSh6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 14:37:58 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Mon, 8 May 2006 13:37:53 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0BCE@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-Index: AcZvj+3cUNJ/67FZTaabyEaNx8cUSQAAHvvQAAIXkFAATcJ24AACFL4wAHSAIGAACREqcA==
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Brown, Len" <len.brown@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 08 May 2006 18:37:54.0628 (UTC) FILETIME=[84F78040:01C672CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Natalie,
> > Regarding the "IRQ compression" in mp_register_gsi()....
> > 
> > Some time ago we invented ioapic_renumber_irq() to handle the case 
> > where the ES7000 BIOS is missing the INTERRUPT_OVERRIDES needed to 
> > tell that legacy IRQs used pins > 15, and PCI interrupts
> used pins <
> > 16.
> > 
> > In that case, the ES7000 uses es7000_rename_gsi() to simply
> re-number
> > the IRQs for the lower pins to some unused numbers above
> the highest
> > GSI in the system -- emulating what the BIOS should have done.
> > 
> > Later, GSI compression was also added to mp_register_gsi():
> > 
> > if (triggering == ACPI_LEVEL_SENSITIVE) {
> > 	gsi = pci_irq++;
> > 	...
> > }
> > 
> > This GSI "compression" was intended to handle systems which have a 
> > large number of sparsely populated IOAPICs.  On these systems, the 
> > maximum GSI is well above NR_IRQS.  While there can be a
> large number
> > of devices on these boxes, the total in use is actually still below 
> > NR_IRQs -- so squeezing the GSIs into the IRQ numbers works.
> > 
> > The problem with doing this is that it also compresses the
> IRQ numbers
> > for the other 99.99% of the systems on earth, causing
> complexity and
> > bugs, such as several mentioned on this thread.
> > 
> > I'm thinking that it would be simpler for the big iron that
> has GSI's
> > > NR_IRQs, to simply use the existing
> > ioapci_renumber_irq() hook to do whatever compression or re-naming 
> > they fancy.
> > This will also allow for simpler systems to remain simple and use 
> > identity irq = gsi numbering.
> > (don't get me started on CONFIG_PCI_MSI, that is an
> independent issue)
> > 
> > Also, as we discussed, it would probably be cleaner even on those 
> > large systems if the compression algorithm did not re-name
> every GSI,
> > but only did re-names when it really has to (GSI > NR_IRQS).  eg.
> > 
> > < gsi = pci_irq++
> > ---
> > > if (GSI < NR_IRQS)
> > >    gsi = irq;
> > > else
> > >    BUG_ON(irq_used >= NR_IRQS)
> > >    gsi = platform specific algorithm to grab the unused IRQs that
> > >    can never have any real devices attached.
> > > irqs_used++;
> > 
> > If we had done this, then we wouldn't have needed kimbal's patch.
> > If we do this, then we can delete that workaround on top of 
> > workaround.
> > 
> > thoughts?
> 
> Sure sounds like a great idea. I just signed up for a large partition 
> (> 1700 GSIs) to try this over the weekend.
> The problem with oapic_renumber_gsi() is that it didn't actually 
> migrate to x86_64 because it doesn't have sub-archs so far. But using 
> actual number of interrupts vs. range is definitely promising idea.

I have tested this algorithm and it worked just fine for me... I used
the following compression code in mp_register_gsi():


int     irqs_used = 0;
int     gsi_to_irq[NR_IRQS] = { [0 ... NR_IRQS-1] = -1 };
...

        if (triggering == ACPI_LEVEL_SENSITIVE) {
                if (gsi > NR_IRQS) {
                        int i;
                        printk("NBP: looking for unused IRQ\n");
                        for (i = nr_ioapic_registers[0]; i < NR_IRQS;
i++) {
                                if (gsi_to_irq[i] == -1) {
                                        gsi_to_irq[i] = gsi;
                                        gsi = i;
                                        break;
                                }
                        }
                        if (i >= NR_IRQS) {
                                printk(KERN_ERR "GSI %u is too high\n",
gsi); <== could ne BUG here, 
 
but Im not sure if you want 
 
to panic the system or just 
 
not register those extra devices
                                return gsi;
                        }
                } else
                        gsi_to_irq[gsi] = gsi;
        }

- only starting looking for unused IRQ after getting large IRQ numbers,
and not looking for free ones on the first io-apic avoiding all dangers
of it :) (and plus some code in io_apic.c to record used entries in
gsi_to_irq[]).
Would that be better interim solution? It so, I would also like Kimball
and someone with VIA chipset handy to test this of course...

Thanks,
--Natalie

> I was also thinking that all the
> complexity is actually located on the first IO-APIC, this may have 
> some potential for compression only coming into play on non-zero 
> IO-APICs. But using the total number of IRQs used is definitely the 
> most logical thing to try...I will test this shortly - Thanks, 
> --Natalie
> 
