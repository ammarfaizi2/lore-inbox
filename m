Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270870AbTHOUtF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 16:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270869AbTHOUtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 16:49:04 -0400
Received: from fmr05.intel.com ([134.134.136.6]:43988 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S270870AbTHOUs5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 16:48:57 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Update MSI Patches
Date: Fri, 15 Aug 2003 13:48:48 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50240154170D@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Update MSI Patches
Thread-Index: AcNjX2LUdXJyzI+OSxWwZqU6Qv0ukAADuT6A
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "Greg Kroah-Hartmann" <greg@kroah.com>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
X-OriginalArrivalTime: 15 Aug 2003 20:48:49.0226 (UTC) FILETIME=[A0D34AA0:01C3636E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sent: Friday, August 15, 2003, Zwane Mwaikambo wrote:
> Ok i tested it on the following configurations;

> UP i8259 w/ CONFIG_PCI_USE_VECTOR is ok
> UP IOAPIC/MP1.4 w/ or w/o CONFIG_PCI_USE_VECTOR is ok
> UP IOAPIC/ACPI w/ or w/o CONFIG_PCI_USE_VECTOR is ok
> 8x SMP/MP1.4 w/ or w/o CONFIG_PCI_USE_VECTOR is ok
> 8x SMP/ACPI w/ or w/o CONFIG_PCI_USE_VECTOR is ok

> I also just looked again and it does look like the additional interrupt 
> controller startup/ack/mask etc member functions are too much duplicated 
> code (even if it wont all be in the final image). Perhaps just keep them 
> like this;

> static unsigned int startup_edge_ioapic(unsigned int index)
> {
>	int irq = vector_to_irq(index);
>	...
>
>	if (platform_legacy_irq(irq)) {
>		...
>	}
>
>	...
>	return
>}
Thank you for testing it through different configurations!
That is what we thought initially by renaming irq to something like offset or
index to avoid some duplicate functions. However, I think if keeping them like
above perhaps may raise a confusion again of why not name vector since the 
function vector_to_irq(...) converts a vector to irq. Please provide us final 
thoughts.


> Also there is a warning whilst compiling which looks like it must be 
> fixed.

> Index: linux-2.6.0-test3-msi/arch/i386/kernel/mpparse.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.6.0-test3/arch/i386/kernel/mpparse.c,v
> retrieving revision 1.2
> diff -u -p -B -r1.2 mpparse.c
> --- linux-2.6.0-test3-msi/arch/i386/kernel/mpparse.c	15 Aug 2003 07:38:39 -0000	1.2
> +++ linux-2.6.0-test3-msi/arch/i386/kernel/mpparse.c	15 Aug 2003 08:02:28 -0000
> @@ -1133,11 +1133,12 @@ void __init mp_parse_prt (void)
> 
> 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
> 
> -		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq))
> +		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq)) {
> 			if (use_pci_vector() && !platform_legacy_irq(irq))
> 				entry->irq = IO_APIC_VECTOR(irq);
> 			else
> 				entry->irq = irq;
> +		}
> 
> 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
>  			entry->id.segment, entry->id.bus, 
> -
Thanks! Will do ...

Thanks,
Long
