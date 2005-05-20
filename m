Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVETTkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVETTkR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 15:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVETTkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 15:40:17 -0400
Received: from ns1.suse.de ([195.135.220.2]:6579 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261552AbVETTkD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 15:40:03 -0400
Date: Fri, 20 May 2005 21:39:57 +0200
From: Andi Kleen <ak@suse.de>
To: Natalie.Protasevich@unisys.com
Cc: akpm@osdl.org, ak@suse.de, zwane@arm.linux.org.uk, len.brown@intel.com,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] Proposed: Let's not waste precious IRQs...
Message-ID: <20050520193957.GH16164@wotan.suse.de>
References: <20050519110613.B817D27266@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20050519110613.B817D27266@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 04:06:13AM -0700, Natalie.Protasevich@unisys.com wrote:
> 
> 
> I suggest to change the way IRQs are handed out to PCI devices. Currently, each I/O APIC pin gets associated with an IRQ, no matter if the pin is used or not. It is expected that each pin can potentually be engaged by a device inserted into the corresponding PCI slot. However, this imposes severe limitation on systems that have designs that employ many  I/O APICs, only utilizing couple lines of each, such as P64H2 chipset. It is used in ES7000, and currently, there is no way to boot the system with more that 9 I/O APICs. The simple change below allows to boot a system with say 64 (or more) I/O APICs, each providing 1 slot, which otherwise impossible because of the IRQ gaps created for unused lines on each I/O APIC. It does not resolve the problem with number of devices that exceeds number of possible IRQs, but eases up a tension for IRQs on any large system with potentually large number of devices. I only implemented this for the ACPI boot, since if the system is this big and
>   using newer chipsets it is probably (better be!) an ACPI based system :). The change is completely "mechanical" and does not alter any internal structures or interrupt model/implementation. The patch works for both i386 and x86_64 archs. It works with MSIs just fine, and should not intervene with implementations like shared vectors, when they get worked out and incorporated.
> 
> 
> To illustrate, below is the interrupt distribution for 2-cell ES7000 with 20 I/O APICs, and an Ethernet card in the last slot, which should be eth1 and which was not configured because its IRQ exceeded allowable number (it actially turned out huge - 480!):
> 
> zorro-tb2:~ # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
>   0:      65716      30012      30007      30002      30009      30010      30010      30010    IO-APIC-edge  timer
>   4:        373          0        725        280          0          0          0          0    IO-APIC-edge  serial
>   8:          0          0          0          0          0          0          0          0    IO-APIC-edge  rtc
>   9:          0          0          0          0          0          0          0          0   IO-APIC-level  acpi
>  14:         39          3          0          0          0          0          0          0    IO-APIC-edge  ide0
>  16:        108         13          0          0          0          0          0          0   IO-APIC-level  uhci_hcd:usb1
>  18:          0          0          0          0          0          0          0          0   IO-APIC-level  uhci_hcd:usb3
>  19:         15          0          0          0          0          0          0          0   IO-APIC-level  uhci_hcd:usb2
>  23:          3          0          0          0          0          0          0          0   IO-APIC-level  ehci_hcd:usb4
>  96:       4240        397         18          0          0          0          0          0   IO-APIC-level  aic7xxx
>  97:         15          0          0          0          0          0          0          0   IO-APIC-level  aic7xxx
> 192:        847          0          0          0          0          0          0          0   IO-APIC-level  eth0
> NMI:          0          0          0          0          0          0          0          0
> LOC:     273423     274528     272829     274228     274092     273761     273827     273694
> ERR:          7
> MIS:          0
> 
> Even thouigh the system doesn't have that many devices, some don't get enabled only because of IRQ numbering model.
> 
> This is the IRQ picture after the patch was applied:
> 
> zorro-tb2:~ # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
>   0:      44169      10004      10004      10001      10004      10003      10004       6135    IO-APIC-edge  timer
>   4:        345          0          0          0          0        244          0          0    IO-APIC-edge  serial
>   8:          0          0          0          0          0          0          0          0    IO-APIC-edge  rtc
>   9:          0          0          0          0          0          0          0          0   IO-APIC-level  acpi
>  14:         39          0          3          0          0          0          0          0    IO-APIC-edge  ide0
>  17:       4425          0          9          0          0          0          0          0   IO-APIC-level  aic7xxx
>  18:         15          0          0          0          0          0          0          0   IO-APIC-level  aic7xxx, uhci_hcd:usb3
>  21:        231          0          0          0          0          0          0          0   IO-APIC-level  uhci_hcd:usb1
>  22:         26          0          0          0          0          0          0          0   IO-APIC-level  uhci_hcd:usb2
>  23:          3          0          0          0          0          0          0          0   IO-APIC-level  ehci_hcd:usb4
>  24:        348          0          0          0          0          0          0          0   IO-APIC-level  eth0
>  25:          6        192          0          0          0          0          0          0   IO-APIC-level  eth1
> NMI:          0          0          0          0          0          0          0          0
> LOC:     107981     107636     108899     108698     108489     108326     108331     108254
> ERR:          7
> MIS:          0
> 
> Not only we see the card in the last I/O APIC, but we are not even close to using up available IRQs, since we didn't waste any.

Thanks. Looks good to me and makes a lot of sense.

Eventually the non ACPI case will need to be fixed too. At least
on some distributions there are "failsafe" boot loader entries
which disable ACPI, and users tend to use them occasionally
and get unhappy when they dont work.

-Andi

P.S.: Could you please line wrap your emails at 80 chars/line. That
would make it easier to quote.

