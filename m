Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750861AbWFEKLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWFEKLZ (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWFEKLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:11:25 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:3537 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750861AbWFEKLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:11:24 -0400
Date: Mon, 5 Jun 2006 12:11:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Brown, Len" <len.brown@intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: parport and irq question
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6993B13@hdsmsx411.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.61.0606051210580.31612@yvahk01.tjqt.qr>
References: <CFF307C98FEABE47A452B27C06B85BB6993B13@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> what irq am I supposed to hand to the irq= parameter 
>
>does "auto" work any better?
>
Unfortunately no.

This is the default output:
    # modprobe parport_pc
    [42949457.300000] pnp: Device 00:0a activated.
    [42949457.300000] parport: PnPBIOS parport detected.
    [42949457.300000] parport0: PC-style at 0x378 (0x778), irq 7, dma 3
    [PCSPP,TRISTATE,COMPAT,ECP,DMA]
    [42949457.390000] ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 16
    (level, low) -> IRQ 217
    [42949457.390000] PCI parallel port detected: 9710:9805, I/O at
    0xc800(0xc400)
    [42949457.390000] parport1: PC-style at 0xc800 (0xc400) [PCSPP,TRISTATE]
    [42949457.470000] PCI parallel port detected: 9710:9805, I/O at
    0xc000(0xbc00)
    [42949457.470000] parport2: PC-style at 0xc000 (0xbc00) [PCSPP,TRISTATE]
Why don't parport1 and p2 get an IRQ and DMA (and therefore ECP/EPP and all the
fun)?

There is one side thing that seems wrong:
    # modprobe parport_pc io=0x378
    [42949610.790000] parport 0x378 (WARNING): CTR: wrote 0x0c, read 0xff
    [42949610.790000] parport 0x378 (WARNING): DATA: wrote 0xaa, read 0xff
    [42949610.790000] parport 0x378: You gave this address, but there is
    probably no parallel port there!
But the parport is there (see above). The kernel does not seem to active the
pnp device.

When specifying irq=auto,auto,auto, I also need to pass in io=. Automatic IRQ
allocation seems to take place (note the delay in the timestamps), but no IRQ
is assigned in the end:
    # modprobe parport_pc irq=auto,auto,auto io=0x378,0xc800,0xc000
    [42949815.890000] parport 0x378 (WARNING): CTR: wrote 0x0c, read 0xff
    [42949815.890000] parport 0x378 (WARNING): DATA: wrote 0xaa, read 0xff
    [42949815.890000] parport 0x378: You gave this address, but there is
    probably no parallel port there!
    [42949815.890000] parport0: PC-style at 0x378 [PCSPP,TRISTATE]
    [42949815.970000] parport1: PC-style at 0xc800 [PCSPP,TRISTATE,EPP]
    [42949816.050000] parport2: PC-style at 0xc000 (0xc400) [PCSPP,TRISTATE]
Plus, the io_hi part has only been detected for parport2. It is wrong too, as
0xc400 belongs to parport1 (see automatic detection above). Strange!

And now for the only command that successfully allocates IRQs (and DMA),
with the exception of 0x378...:
    # modprobe parport_pc irq=3,5,7 io=0x378,0xc800,0xc000
    io_hi=0x778,0xc400,0xbc00
    [42950056.090000] parport 0x378 (WARNING): CTR: wrote 0x0c, read 0xff
    [42950056.090000] parport 0x378 (WARNING): DATA: wrote 0xaa, read 0xff
    [42950056.090000] parport 0x378: You gave this address, but there is
    probably no parallel port there!
    [42950056.090000] parport0: PC-style at 0x378, irq 3 [PCSPP,TRISTATE]
    [42950056.170000] parport1: PC-style at 0xc800 (0xc400), irq 5, dma 5
    [PCSPP,TRISTATE,COMPAT,ECP,DMA]
    [42950056.250000] parport2: PC-style at 0xc000 (0xbc00), irq 7, dma 7
    [PCSPP,TRISTATE,COMPAT,ECP,DMA]

Hopefully, someone can clear this up.


Jan Engelhardt
-- 
