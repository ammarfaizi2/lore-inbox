Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131237AbRCKE2H>; Sat, 10 Mar 2001 23:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131258AbRCKE16>; Sat, 10 Mar 2001 23:27:58 -0500
Received: from f27.law3.hotmail.com ([209.185.241.27]:57866 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S131237AbRCKE1t>;
	Sat, 10 Mar 2001 23:27:49 -0500
X-Originating-IP: [65.25.188.54]
From: "John William" <jw2357@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: RE: HP Vectra XU 5/90 interrupt problems
Date: Sun, 11 Mar 2001 04:27:03 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F27mQVuRWCy7rjcxtni00003e70@hotmail.com>
X-OriginalArrivalTime: 11 Mar 2001 04:27:03.0664 (UTC) FILETIME=[85F79700:01C0A9E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: "Dunlap, Randy" <randy.dunlap@intel.com>
>
> > -----Original Message-----
> > From: John William [mailto:jw2357@hotmail.com]
<snip>
> > If PCI interrupts are shared, force them to be level
> > triggered? Can shared
> > PCI interrupts be edge triggered? If not, then wouldn't this
> > be the correct
> > solution? This isn't specific to the Vectra, but could
> > possibly prevent problems on any machine with a broken BIOS?
>
>PCI interrupts are defined as "level sensitive" and must
>be shareable.
>
>~Randy

So PCI interrupts must always be level triggered? If so, then the kernel 
should never program the IO APIC to use an edge triggered interrupt on a PCI 
device. If that's true, then why not force the interrupt type to level 
triggered for all PCI devices (to work around a potentially broken MP 
table)?

What about this solution:

1) In pci-irq.c, in pcibios_fixup_irqs(), if we are using the IO APIC, check 
to see if the IRQ has been set to level triggered.
2a) If YES, then do nothing different.
2b) If NO, then set the IRQ type to level triggered and write the changed 
configuration to the IO APIC for that interrupt.

The other alternative I considered is adding a check for the presence of 
ELCR data to construct_default_ISA_mptable() in mpparse.c, but there doesn't 
seem to be an easy way to verify that there really is (or isn't) valid ELCR 
data.

Apparently, HP chose to use the ELCR to provide IRQ information on their 
early SMP machines, but since the system is defined as type 5 (ISA/PCI), the 
kernel doesn't check for the presence of ELCR data, and the machine's MP 
table does not appear to have any IRQ information.

But if PCI interrupts have to be level triggered, then the first alternative 
would seem to be a more general solution.

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

