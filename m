Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270713AbTHOSwD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270726AbTHOSuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:50:04 -0400
Received: from [66.212.224.118] ([66.212.224.118]:14097 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270804AbTHOStY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:49:24 -0400
Date: Fri, 15 Aug 2003 14:37:31 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Greg Kroah-Hartmann <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Update MSI Patches
In-Reply-To: <200308141914.h7EJEMeY006189@snoqualmie.dp.intel.com>
Message-ID: <Pine.LNX.4.53.0308150727320.30634@montezuma.mastecende.com>
References: <200308141914.h7EJEMeY006189@snoqualmie.dp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok i tested it on the following configurations;

UP i8259 w/ CONFIG_PCI_USE_VECTOR is ok
UP IOAPIC/MP1.4 w/ or w/o CONFIG_PCI_USE_VECTOR is ok
UP IOAPIC/ACPI w/ or w/o CONFIG_PCI_USE_VECTOR is ok
8x SMP/MP1.4 w/ or w/o CONFIG_PCI_USE_VECTOR is ok
8x SMP/ACPI w/ or w/o CONFIG_PCI_USE_VECTOR is ok

I also just looked again and it does look like the additional interrupt 
controller startup/ack/mask etc member functions are too much duplicated 
code (even if it wont all be in the final image). Perhaps just keep them 
like this;

static unsigned int startup_edge_ioapic(unsigned int index)
{
	int irq = vector_to_irq(index);
	...

	if (platform_legacy_irq(irq)) {
		...
	}

	...
	return
}

Also there is a warning whilst compiling which looks like it must be 
fixed.

Index: linux-2.6.0-test3-msi/arch/i386/kernel/mpparse.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test3/arch/i386/kernel/mpparse.c,v
retrieving revision 1.2
diff -u -p -B -r1.2 mpparse.c
--- linux-2.6.0-test3-msi/arch/i386/kernel/mpparse.c	15 Aug 2003 07:38:39 -0000	1.2
+++ linux-2.6.0-test3-msi/arch/i386/kernel/mpparse.c	15 Aug 2003 08:02:28 -0000
@@ -1133,11 +1133,12 @@ void __init mp_parse_prt (void)
 
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
-		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq))
+		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq)) {
 			if (use_pci_vector() && !platform_legacy_irq(irq))
 				entry->irq = IO_APIC_VECTOR(irq);
 			else
 				entry->irq = irq;
+		}
 
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
 			entry->id.segment, entry->id.bus, 
