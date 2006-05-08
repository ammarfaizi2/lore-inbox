Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWEHVvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWEHVvn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 17:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWEHVvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 17:51:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:59803 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750858AbWEHVvl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 17:51:41 -0400
X-IronPort-AV: i="4.05,103,1146466800"; 
   d="scan'208"; a="34169235:sNHT147049343"
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Mon, 8 May 2006 17:51:35 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB65EAC04@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-index: AcZvj+3cUNJ/67FZTaabyEaNx8cUSQAAHvvQAAIXkFAATcJ24AACFL4wAHSAIGAADV8rMA==
From: "Brown, Len" <len.brown@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 08 May 2006 21:51:35.0707 (UTC) FILETIME=[93AB6EB0:01C672E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<6>IOAPIC[64]: apic_id 127, version 32, address 0xfec49000, GSI
1728-1751

wow, big box!

>I have tested this algorithm and it worked just fine for me... I used
>the following compression code in mp_register_gsi():
>
>
>int     irqs_used = 0;
>int     gsi_to_irq[NR_IRQS] = { [0 ... NR_IRQS-1] = -1 };
>...
>
>        if (triggering == ACPI_LEVEL_SENSITIVE) {
>                if (gsi > NR_IRQS) {
>                        int i;
>                        printk("NBP: looking for unused IRQ\n");
>                        for (i = nr_ioapic_registers[0]; i < NR_IRQS;
i++) {
>                                if (gsi_to_irq[i] == -1) {
>                                        gsi_to_irq[i] = gsi;
>                                        gsi = i;
>                                        break;
>                                }
>                        }
>                        if (i >= NR_IRQS) {
>                                printk(KERN_ERR "GSI %u is too high\n",
...
>                                return gsi;
>                        }
>                } else
>                        gsi_to_irq[gsi] = gsi;
>        }

the problem with this code as it stands is that acpi/mp_register_gsi()
can be called with gsi in any order.  So it is possible
for the compression code above to select gsi_to_irq[n]
and later for the non-compression path to over-write gsi_to_irq[n].

Also, I would prefer that this code be in ioapic_renumber_irq(), as I
think
it is unnecessarily complex to re-number, and then re-number again.
(gsi_irq_sharing() is a separate discussion)

I think this should be model-specific, but if you feel that handling
(gsi > NR_IRQS) here is important in the generic case, then I'm
fine with this being a default ioapic_renumber_irq() handler
that a platform can augment/override.

Re: returning error
At one point acpi_register_gsi() was able to return an error.
However, that was broken when acpi_gsi_to_irq() was created,
and then broken worse when that routine was modified
with gsi_irq_sharing().  if you BUG() on i > NR_IRQS,
that would be consistent wth gsi_irq_sharing().

thanks,
-Len
