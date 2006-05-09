Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWEIEZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWEIEZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 00:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWEIEZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 00:25:19 -0400
Received: from mga03.intel.com ([143.182.124.21]:32780 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751370AbWEIEZR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 00:25:17 -0400
X-IronPort-AV: i="4.05,103,1146466800"; 
   d="scan'208"; a="33507088:sNHT17013605"
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Tue, 9 May 2006 00:25:13 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB65EAD47@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-index: AcZvj+3cUNJ/67FZTaabyEaNx8cUSQAAHvvQAAIXkFAATcJ24AACFL4wAHSAIGAADV8rMAANMJDwAADh/DA=
From: "Brown, Len" <len.brown@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 09 May 2006 04:25:15.0039 (UTC) FILETIME=[91E37AF0:01C67320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >I have tested this algorithm and it worked just fine for 
>> >me... I used 
>> >the following compression code in mp_register_gsi():
>> >
>> >
>> >int     irqs_used = 0;
>> >int     gsi_to_irq[NR_IRQS] = { [0 ... NR_IRQS-1] = -1 };
>> >...
>> >
>> >        if (triggering == ACPI_LEVEL_SENSITIVE) {
>> >                if (gsi > NR_IRQS) {
>> >                        int i;
>> >                        printk("NBP: looking for unused IRQ\n");
>> >                        for (i = nr_ioapic_registers[0]; i 
>< NR_IRQS;
>> i++) {
>> >                                if (gsi_to_irq[i] == -1) {
>> >                                        gsi_to_irq[i] = gsi;
>> >                                        gsi = i;
>> >                                        break;
>> >                                }
>> >                        }
>> >                        if (i >= NR_IRQS) {
>> >                                printk(KERN_ERR "GSI %u is 
>> too high\n",
>> ...
>> >                                return gsi;
>> >                        }
>> >                } else
>> >                        gsi_to_irq[gsi] = gsi;
>> >        }
>> 
>> the problem with this code as it stands is that 
>> acpi/mp_register_gsi() can be called with gsi in any order.  
>> So it is possible for the compression code above to select 
>> gsi_to_irq[n] and later for the non-compression path to 
>> over-write gsi_to_irq[n].
>> 
>
>It should always find the entry it's done the first one around 
>actually, the first thing in mp_register_gsi() will check for it I
think.

No, the top of mp_register_gsi() is based on the real GSI
(before re-numbering) and the real IOAPIC pin number.
It prevents re-programming the real IOAPIC pin (a dubious optimization,
IMHO).
Yes, if it finds a 2nd call results in the same pin, it returns
gsi_to_irq[i],
but that isn't the failure case here.

a failure case is like so:
say the 1st IOAPIC has 24 pins, so the 0th RTE of the 2nd APIC is #24,
and this happens:

mp_register_gsi(NR_IRQS+1);
	gsi_to_irq[24] is free, so it will get claimed
	by the IRQ that wants to talk to GSI NR_IRQS+1

mp_register_gsi(24);
	gsi_to_irq[24] was not -1 here, it was NR_IRQS+1,
	but that will get over-written to be 24.

So now you have multiple independent interrupt sources that think
they own IRQ 24.

-Len
