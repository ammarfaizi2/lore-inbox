Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUDIRoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 13:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUDIRoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 13:44:44 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:50437 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S261474AbUDIRok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 13:44:40 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Kitt Tientanopajai <kitt@gear.kku.ac.th>
Subject: Re: 2.6.5 yenta_socket irq 10: nobody cared!
Date: Fri, 9 Apr 2004 19:41:20 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, David Hinds <dhinds@sonic.net>
References: <200404060227.58325.daniel.ritz@gmx.ch> <200404081717.15794.daniel.ritz@gmx.ch> <20040409093046.51d67994.kitt@gear.kku.ac.th>
In-Reply-To: <20040409093046.51d67994.kitt@gear.kku.ac.th>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404091941.20444.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 April 2004 04:30, Kitt Tientanopajai wrote:
> Hi,
> 
> > you're welcome. but i now have the feeling that it's wrong. so another question:
> > my patch also changes the interrupt assignment for the USB controller at 00:1d.1
> > so the question is: does this one work ok? or is there an interrupt storm as soon
> > as you use the device? (like with yenta_socket before)
> 
> Ah, right, TM361 has two USB ports, one of them has usb mouse attached and seem to be okay.
> Another one does not work after applying your patch. This is dmesg when I connect Sony Clie to
> sync data through the USB port, the pilot-xfer cannot sync any data and then exit without any
> crash/freeze. 

with my first patch applied, does the mouse work on the second port?

> 
> usb 1-2: new full speed USB device using address 3
> drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
> usbcore: registered new driver usbserial
> drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
> drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring Visor / Palm OS
> drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 3.5
> usb 1-2: palm_os_4_probe - error -32 getting connection info
> visor 1-2:1.0: Handspring Visor / Palm OS converter detected
> usb 1-2: Handspring Visor / Palm OS converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
> usb 1-2: Handspring Visor / Palm OS converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
> usbcore: registered new driver visor
> drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
> usb 1-2: USB disconnect, address 3
> visor 1-2:1.0: device disconnected
> visor ttyUSB0: visor_write - usb_submit_urb(write bulk) failed with status = -19
> visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0
> visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected from ttyUSB1
> 
> > can you please undo my previous patch and apply the attached one instead.
> > the socket may be not working, but it prints the relevant registers from
> > the o2micro chip.
> 
> Sure, this is dmesg after patch. 
> 
> Linux Kernel Card Services
>   options:  [pci] [cardbus] [pm]
> PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
> PCI: Found IRQ 10 for device 0000:01:05.0
> PCI: Sharing IRQ 10 with 0000:01:08.0
> Yenta: CardBus bridge found at 0000:01:05.0 [12a3:ab01]
> Yenta: Enabling burst memory read transactions
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta: ISA IRQ mask 0x0000, PCI irq 10
> Socket status: 30000011
> PCI: Found IRQ 11 for device 0000:01:09.0
> PCI: Sharing IRQ 11 with 0000:00:1d.1
> PCI: Sharing IRQ 11 with 0000:01:09.1
> Yenta: CardBus bridge found at 0000:01:09.0 [1025:1022]
> Yenta O2: socket 0000:01:09.0, Mux Ctrk: 0c00200f, Mode D: 00

ok, i made a mistake here. in o2micro.h it should have been
	mode_d = exca_readb(socket, O2_MODE_D);
(exca_readb, not config_readb)

but then the Mux control register already looks ok:
PCI INTA and INTB are routed to the PCI pins

so i really don't know why lspci shows pin A routed to irq 11 for both
functions...the o2micro spec says the interrupt pin register always contains
pin B for function 1.

so i CCed dave hinds as he may know the o2micro bridge a bit better.

could you try to replace the function o2micro_override() in drivers/pcmcia/o2micro.h
with this one?

static int o2micro_override(struct yenta_socket *socket)
{
        u8 mode_a, mode_b, mode_c, mode_d;
        u32 mux_ctrl;

        mode_a = exca_readb(socket, O2_MODE_A);
        mode_b = exca_readb(socket, O2_MODE_B);
        mode_c = exca_readb(socket, O2_MODE_C);
        mode_d = exca_readb(socket, O2_MODE_D);
        mux_ctrl = config_readl(socket, O2_MUX_CONTROL);

        printk(KERN_INFO "Yenta O2: socket %s, Mux Ctrl: %08x, Mode A: %02x, B: %02x, C: %02x, D: %02x\n",
               pci_name(socket->dev), mux_ctrl, mode_a, mode_b, mode_c, mode_d);

        /* enable O2Micro mode */
        mode_b &= ~O2_MODE_B_IDENT;
        mode_b |= O2_MODE_B_ID_O2;
        exca_writeb(socket, O2_MODE_B, mode_d);

        /* XXX: hack: enable PCI only mode */
        mode_d |= O2_MODE_D_IRQ_PCI;
        exca_writeb(socket, O2_MODE_D, mode_d);

        return 0;
}

so we're in PCI only mode. if it's still not working, then it's the interrupt
routing from the bios i think

-daniel


