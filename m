Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWEIDKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWEIDKS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 23:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWEIDKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 23:10:18 -0400
Received: from usea-naimss3.unisys.com ([192.61.61.105]:40964 "EHLO
	usea-naimss3.unisys.com") by vger.kernel.org with ESMTP
	id S1751350AbWEIDKQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 23:10:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Mon, 8 May 2006 22:10:00 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0BCF@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-Index: AcZvj+3cUNJ/67FZTaabyEaNx8cUSQAAHvvQAAIXkFAATcJ24AACFL4wAHSAIGAADV8rMAANMJDw
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Brown, Len" <len.brown@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 09 May 2006 03:10:02.0207 (UTC) FILETIME=[1007F6F0:01C67316]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <6>IOAPIC[64]: apic_id 127, version 32, address 0xfec49000, GSI
> 1728-1751
> 
> wow, big box!

Yea, it's decent :) I asked for the big one since this way we can test
IRQs "wrapping  around".

> 
> >I have tested this algorithm and it worked just fine for 
> me... I used 
> >the following compression code in mp_register_gsi():
> >
> >
> >int     irqs_used = 0;
> >int     gsi_to_irq[NR_IRQS] = { [0 ... NR_IRQS-1] = -1 };
> >...
> >
> >        if (triggering == ACPI_LEVEL_SENSITIVE) {
> >                if (gsi > NR_IRQS) {
> >                        int i;
> >                        printk("NBP: looking for unused IRQ\n");
> >                        for (i = nr_ioapic_registers[0]; i < NR_IRQS;
> i++) {
> >                                if (gsi_to_irq[i] == -1) {
> >                                        gsi_to_irq[i] = gsi;
> >                                        gsi = i;
> >                                        break;
> >                                }
> >                        }
> >                        if (i >= NR_IRQS) {
> >                                printk(KERN_ERR "GSI %u is 
> too high\n",
> ...
> >                                return gsi;
> >                        }
> >                } else
> >                        gsi_to_irq[gsi] = gsi;
> >        }
> 
> the problem with this code as it stands is that 
> acpi/mp_register_gsi() can be called with gsi in any order.  
> So it is possible for the compression code above to select 
> gsi_to_irq[n] and later for the non-compression path to 
> over-write gsi_to_irq[n].
> 

It should always find the entry it's done the first one around actually,
the first thing in mp_register_gsi() will check for it I think.

> Also, I would prefer that this code be in 
> ioapic_renumber_irq(), as I think it is unnecessarily complex 
> to re-number, and then re-number again.
> (gsi_irq_sharing() is a separate discussion)

Sure - for i386, but Len, we would have to bring it into x86_64 and make
this thing above (or something like this) to be a default handler, yes. 

> 
> I think this should be model-specific, but if you feel that 
> handling (gsi > NR_IRQS) here is important in the generic 
> case, then I'm fine with this being a default 
> ioapic_renumber_irq() handler that a platform can augment/override.
>

OK.. besides note that only pretty large system will wrap around to get
unused IRQs, the rest of the world is getting pretty much default
behavior, pre-compression time so to speak :)
 
> Re: returning error
> At one point acpi_register_gsi() was able to return an error.
> However, that was broken when acpi_gsi_to_irq() was created, 
> and then broken worse when that routine was modified with 
> gsi_irq_sharing().  if you BUG() on i > NR_IRQS, that would 
> be consistent wth gsi_irq_sharing().

Ok, sounds good. I will put something together according to the above
and hopefully test it soon.

Thanks,
--Natalie
 
