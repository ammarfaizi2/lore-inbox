Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUDJDS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 23:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUDJDS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 23:18:29 -0400
Received: from [202.28.93.1] ([202.28.93.1]:22276 "EHLO gear.kku.ac.th")
	by vger.kernel.org with ESMTP id S261885AbUDJDSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 23:18:23 -0400
Date: Sat, 10 Apr 2004 10:18:25 +0700
From: Kitt Tientanopajai <kitt@gear.kku.ac.th>
To: daniel.ritz@gmx.ch
Cc: linux-kernel@vger.kernel.org, dhinds@sonic.net
Subject: Re: 2.6.5 yenta_socket irq 10: nobody cared!
Message-Id: <20040410101825.59158e43.kitt@gear.kku.ac.th>
In-Reply-To: <200404091941.20444.daniel.ritz@gmx.ch>
References: <200404060227.58325.daniel.ritz@gmx.ch>
	<200404081717.15794.daniel.ritz@gmx.ch>
	<20040409093046.51d67994.kitt@gear.kku.ac.th>
	<200404091941.20444.daniel.ritz@gmx.ch>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> > > you're welcome. but i now have the feeling that it's wrong. so another question:
> > > my patch also changes the interrupt assignment for the USB controller at 00:1d.1
> > > so the question is: does this one work ok? or is there an interrupt storm as soon
> > > as you use the device? (like with yenta_socket before)
> > 
> > Ah, right, TM361 has two USB ports, one of them has usb mouse attached and seem to be okay.
> > Another one does not work after applying your patch. This is dmesg when I connect Sony Clie to
> > sync data through the USB port, the pilot-xfer cannot sync any data and then exit without any
> > crash/freeze. 
> 
> with my first patch applied, does the mouse work on the second port?

Yes, usb mouse works. And when I discovered that clie sync did not work on on one port, I just replace mouse with clie sync cable, and sync data through it successfully.

> > Linux Kernel Card Services
> >   options:  [pci] [cardbus] [pm]
> > PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
> > PCI: Found IRQ 10 for device 0000:01:05.0
> > PCI: Sharing IRQ 10 with 0000:01:08.0
> > Yenta: CardBus bridge found at 0000:01:05.0 [12a3:ab01]
> > Yenta: Enabling burst memory read transactions
> > Yenta: Using CSCINT to route CSC interrupts to PCI
> > Yenta: Routing CardBus interrupts to PCI
> > Yenta: ISA IRQ mask 0x0000, PCI irq 10
> > Socket status: 30000011
> > PCI: Found IRQ 11 for device 0000:01:09.0
> > PCI: Sharing IRQ 11 with 0000:00:1d.1
> > PCI: Sharing IRQ 11 with 0000:01:09.1
> > Yenta: CardBus bridge found at 0000:01:09.0 [1025:1022]
> > Yenta O2: socket 0000:01:09.0, Mux Ctrk: 0c00200f, Mode D: 00
> 
> ok, i made a mistake here. in o2micro.h it should have been
> 	mode_d = exca_readb(socket, O2_MODE_D);
> (exca_readb, not config_readb)
> 
> but then the Mux control register already looks ok:
> PCI INTA and INTB are routed to the PCI pins
> 
> so i really don't know why lspci shows pin A routed to irq 11 for both
> functions...the o2micro spec says the interrupt pin register always contains
> pin B for function 1.
> 
> so i CCed dave hinds as he may know the o2micro bridge a bit better.
> 
> could you try to replace the function o2micro_override() in drivers/pcmcia/o2micro.h
> with this one?

replaced, and here is the dmesg.

rgds,
kitt

Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
PCI: Found IRQ 10 for device 0000:01:05.0
PCI: Sharing IRQ 10 with 0000:01:08.0
Yenta: CardBus bridge found at 0000:01:05.0 [12a3:ab01]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0000, PCI irq 10
Socket status: 30000011
PCI: Found IRQ 11 for device 0000:01:09.0
PCI: Sharing IRQ 11 with 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:01:09.1
Yenta: CardBus bridge found at 0000:01:09.0 [1025:1022]
Yenta O2: socket 0000:01:09.0, Mux Ctrl: 0c00200f, Mode A: 00, B: 00, C: 00, D: 42
irq 10: nobody cared!
Call Trace:
 [<c0108eca>] __report_bad_irq+0x2a/0x90
 [<c0108fc0>] note_interrupt+0x70/0xb0
 [<c0109270>] do_IRQ+0x120/0x130
 [<c0107618>] common_interrupt+0x18/0x20
 [<c01217ee>] do_softirq+0x3e/0xa0
 [<c010924a>] do_IRQ+0xfa/0x130
 [<c0107618>] common_interrupt+0x18/0x20
 [<c0113284>] delay_pmtmr+0x14/0x20
 [<c01cf512>] __delay+0x12/0x20
 [<d0dbaace>] yenta_probe_irq+0xfe/0x140 [yenta_socket]
 [<d0dbab4a>] yenta_get_socket_capabilities+0x3a/0x70 [yenta_socket]
 [<d0dbae97>] yenta_probe+0x1a7/0x240 [yenta_socket]
 [<c01d3712>] pci_device_probe_static+0x52/0x70
 [<c01d376c>] __pci_device_probe+0x3c/0x50
 [<c01d37ac>] pci_device_probe+0x2c/0x50
 [<c0232b1f>] bus_match+0x3f/0x70
 [<c0232c4c>] driver_attach+0x5c/0xa0
 [<c0232f78>] bus_add_driver+0xa8/0xc0
 [<c02333cf>] driver_register+0x2f/0x40
 [<c01d399c>] pci_register_driver+0x5c/0x90
 [<d0dbe00f>] yenta_socket_init+0xf/0x11 [yenta_socket]
 [<c0134722>] sys_init_module+0x142/0x280
 [<c0107459>] sysenter_past_esp+0x52/0x71
 
handlers:
[<d0913890>] (snd_intel8x0_interrupt+0x0/0x240 [snd_intel8x0])
[<d090ba10>] (ohci_irq_handler+0x0/0x860 [ohci1394])
[<d0db98a0>] (yenta_interrupt+0x0/0x40 [yenta_socket])
Disabling IRQ #10
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:01:09.1
PCI: Sharing IRQ 11 with 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:01:09.0
Yenta: CardBus bridge found at 0000:01:09.1 [1025:1022]
Yenta O2: socket 0000:01:09.1, Mux Ctrl: 0c00200f, Mode A: 00, B: 00, C: 50, D: 43
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000410


