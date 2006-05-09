Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWEIFOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWEIFOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 01:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWEIFOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 01:14:41 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:22790 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1751384AbWEIFOk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 01:14:40 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Tue, 9 May 2006 00:14:36 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0BD0@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-Index: AcZvj+3cUNJ/67FZTaabyEaNx8cUSQAAHvvQAAIXkFAATcJ24AACFL4wAHSAIGAADV8rMAANMJDwAADh/DAAA79doA==
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Brown, Len" <len.brown@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 09 May 2006 05:14:36.0876 (UTC) FILETIME=[7747F0C0:01C67327]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >I have tested this algorithm and it worked just fine for me... I 
> >> >used the following compression code in mp_register_gsi():
> >> >
> >> >
> >> >int     irqs_used = 0;
> >> >int     gsi_to_irq[NR_IRQS] = { [0 ... NR_IRQS-1] = -1 };
> >> >...
> >> >
> >> >        if (triggering == ACPI_LEVEL_SENSITIVE) {
> >> >                if (gsi > NR_IRQS) {
> >> >                        int i;
> >> >                        printk("NBP: looking for unused IRQ\n");
> >> >                        for (i = nr_ioapic_registers[0]; i 
> >< NR_IRQS;
> >> i++) {
> >> >                                if (gsi_to_irq[i] == -1) {
> >> >                                        gsi_to_irq[i] = gsi;
> >> >                                        gsi = i;
> >> >                                        break;
> >> >                                }
> >> >                        }
> >> >                        if (i >= NR_IRQS) {
> >> >                                printk(KERN_ERR "GSI %u is 
> >> too high\n",
> >> ...
> >> >                                return gsi;
> >> >                        }
> >> >                } else
> >> >                        gsi_to_irq[gsi] = gsi;
> >> >        }
> >> 
> >> the problem with this code as it stands is that 
> >> acpi/mp_register_gsi() can be called with gsi in any order.  
> >> So it is possible for the compression code above to select 
> >> gsi_to_irq[n] and later for the non-compression path to 
> >> over-write gsi_to_irq[n].
> >> 
> >
> >It should always find the entry it's done the first one around 
> >actually, the first thing in mp_register_gsi() will check for it I
> think.
> 
> No, the top of mp_register_gsi() is based on the real GSI
> (before re-numbering) and the real IOAPIC pin number.
> It prevents re-programming the real IOAPIC pin (a dubious 
> optimization,
> IMHO).
> Yes, if it finds a 2nd call results in the same pin, it returns
> gsi_to_irq[i],
> but that isn't the failure case here.
> 
> a failure case is like so:
> say the 1st IOAPIC has 24 pins, so the 0th RTE of the 2nd APIC is #24,
> and this happens:
> 
> mp_register_gsi(NR_IRQS+1);
> 	gsi_to_irq[24] is free, so it will get claimed
> 	by the IRQ that wants to talk to GSI NR_IRQS+1
> 
> mp_register_gsi(24);
> 	gsi_to_irq[24] was not -1 here, it was NR_IRQS+1,
> 	but that will get over-written to be 24.
> 
> So now you have multiple independent interrupt sources that think
> they own IRQ 24.

But if the first one was say 280, then gsi_to_irq[24]=280. The other one
will be looking for gsi_to_irq[XX]=24. That should make differentiation
I hope. Don't you think? I will go through this some more...

--Natalie
