Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbTL3EB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbTL3EB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:01:58 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:64644 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S264366AbTL3EBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:01:45 -0500
Date: Mon, 29 Dec 2003 22:50:37 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Amit Gurdasani <amitg@alumni.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EISA ID for PnP modem and resource allocation
Message-ID: <20031229225037.GB3198@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Amit Gurdasani <amitg@alumni.cmu.edu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0312261610200.1798@athena> <20031229143711.GA3176@neo.rr.com> <Pine.LNX.4.56.0312300338360.1163@athena>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0312300338360.1163@athena>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 03:59:16AM +0400, Amit Gurdasani wrote:
> :Without special hardware modifications, it is usually unsafe to share irqs
> :between isa devices.
>
> Ah. So 2.4's behavior was broken then?

Perhaps in this case.

>
> :> The reason I ask is that I also have a jumpered SB16 on IRQ 5, and loading
> :> the 8250 driver before the snd_sb16 driver results in the SB16's IRQ being
> :> allocated for the modem, which prevents the SB16 driver from loading.
> :> Loading the SB16 driver first results in resource starvation for the modem,
> :> and the 8250 driver is only able to set up the onboard serial ports ttyS0
> :> and ttyS1.
> :
> :You may want to try changing the jumper on your SB16 to allow for PnP
> :autoconfiguration.
>
> It's a pre-PnP SB16 from 1994, as far as I can tell -- IRQ, I/O port and DMA
> channels can be set only by setting jumpers. I suppose I could pull the card
> out and set its IRQ setting to something the modem won't claim.

Because of detection limitations in legacy hardware, you may have to notify the
Plug and Play Layer that your device is using irq 5.  Booting with the parameter
pnp_reserve_irq=5 will prevent resource conflicts with the legacy SB16 device.

>
> :> In the meantime, I'm using the isapnptools to set up the modem with IRQ 4
> :> before loading either driver. The result is that the SB16 driver gets IRQ 5
> :> as needed, and ttyS0 is set up with IRQ 0 (is this OK?), but I'd really like
> :> to use the kernel ISA PnP support.
> :
> :Could I please see a copy of your /proc/interrupts.
>
>            CPU0
>   0:     314288          XT-PIC  timer
>   1:       1024          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:       7444          XT-PIC  SoundBlaster
>   8:          1          XT-PIC  rtc
>   9:       4675          XT-PIC  ide2
>  10:         41          XT-PIC  eth0
>  11:      89930          XT-PIC  i91u
>  12:      10092          XT-PIC  i8042
>  15:         57          XT-PIC  ide1
> NMI:          0
> LOC:          0
> ERR:          0
> MIS:          0
>
> Apart from these, dmesg output shows these IRQs allocated:
>
> ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
> parport0: irq 7 detected

Hmm, it shouldn't be reporting irq 0.  The probbing code may be confused.
I would guess it is on irq 4.

>
> Additionally, pnpdump says the modem can only claim an IRQ line from among
> 3, 4, 5, 7, 9, 10, 11, 12 or 15 in various configurations.

It appears that you have an unresolvable resource conflict.  I'm working on
a more flexable resource manager for the 2.7 kernel.  For now, I recommend that
you disable one of your serial ports in your BIOS configuration interface and
try booting with pnp_reserve_irq=5.

Alternatively you could try enabling PnPBIOS support.  There's a slight chance
that the pci code will reroute ide2 to 14 (assuming ide2 is pci), leaving room
for your modem on 9.  You'll still need to reserve irq 5 as stated above.

Thanks,
Adam
