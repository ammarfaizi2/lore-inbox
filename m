Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTLHT3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTLHT3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:29:24 -0500
Received: from fmr04.intel.com ([143.183.121.6]:32710 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261276AbTLHT3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:29:20 -0500
Subject: Re: balance interrupts
From: Len Brown <len.brown@intel.com>
To: Julien Oster <lkml-2315@mc.frodoid.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1070911748.2408.39.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 08 Dec 2003 14:29:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most IO-APIC systems have PCI interrupt lines hard-wired directly to
IO-APIC interrupt pins.  If an interrupt isn't where you want it to be,
you need to physically move a card to another slot so that it gets a
different wire.  A board with decent documentation will tell you what
slots get which interrupt wires.

Today basically all boards have also a PIRQ router that is used to map
these PCI interrupt wires down into PIC interrupt inputs for when the
system is in PIC compatibility mode (eg. when running the booter). 
Sometimes they can also re-map interrupt lines in IO-APIC mode.

Since your system is running in ACPI mode, the output of acpidmp is
needed to figure out exactly that the BIOS is saying the board can do.
The output of lspci -l with this will tell us if we can split apart the
SATA interrupts, or if they're wired together.

Another twist is that sometimes enabling/disabling devices in the BIOS
SETUP will change how the BIOS configures the hardware and make more
interrupts available.  Here, for example, USB seems to be low hanging
fruit on a high-rent >= 16 IRQ.

If you're not using ACPI features, you might also try booting with
"acpi=off" and see if the chip-set PIRQ router does a better job for
you.

cheers,
-Len

On Mon, 2003-12-08 at 12:59, Julien Oster wrote:
> Hello!
> 
> Now that my IO-APIC finally works without lockups (thanks to all!) on
> my nforce2 boards, my interrupts are much less crowded. However,
> there's still one line in /proc/interrupts which I don't really like,
> it's also the only line where more than one piece of hardware shares
> the same interrupt:
> 
>  18:     445160   IO-APIC-level  ide2, ide3, eth0
> 
> ide2 and ide3 are my onboard Silicon Image SATA controller. I guess
> you can't keep them apart on to different interrupts, since it's only
> one chip which is most probably connected to one IRQ line only.
> 
> But I don't think that eth0 has to be on the same interrupt as my SATA
> controller. So, how do I make it go away to another place? I would be
> fine sharing it with e.g. eth1, which is alone on IRQ 19.
> 
> BTW, the whole /proc/interrupts looks like this:
> 
>            CPU0
>   0:   40022145    IO-APIC-edge  timer
>   1:      62950    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   8:     681626    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  12:         55    IO-APIC-edge  i8042
>  14:     968274    IO-APIC-edge  ide0
>  15:    1789182    IO-APIC-edge  ide1
>  16:     404489   IO-APIC-level  EMU10K1
>  18:     445160   IO-APIC-level  ide2, ide3, eth0
>  19:    1596427   IO-APIC-level  eth1
>  20:          0   IO-APIC-level  ohci_hcd
>  21:          0   IO-APIC-level  NVidia nForce2
>  22:      36730   IO-APIC-level  ohci_hcd
> NMI:          0
> LOC:   40021891
> ERR:          0
> MIS:        310
> 
> Regards,
> Julien
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

