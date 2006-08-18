Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWHRSeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWHRSeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbWHRSeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:34:50 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:14860 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030397AbWHRSet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:34:49 -0400
Date: Fri, 18 Aug 2006 19:34:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Giampaolo Tomassoni <g.tomassoni@libero.it>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Paul Fulghum <paulkf@microgate.com>
Subject: Re: R: How to avoid serial port buffer overruns?
Message-ID: <20060818183430.GD21101@flint.arm.linux.org.uk>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Giampaolo Tomassoni <g.tomassoni@libero.it>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Paul Fulghum <paulkf@microgate.com>
References: <NBBBIHMOBLOHKCGIMJMDGEIMFNAA.g.tomassoni@libero.it> <1155920400.24907.63.camel@mindpipe> <20060818170450.GC21101@flint.arm.linux.org.uk> <1155922240.2924.5.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155922240.2924.5.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 01:30:40PM -0400, Lee Revell wrote:
> On Fri, 2006-08-18 at 18:04 +0100, Russell King wrote:
> > On Fri, Aug 18, 2006 at 01:00:00PM -0400, Lee Revell wrote:
> > > On Fri, 2006-08-18 at 10:48 +0200, Giampaolo Tomassoni wrote:
> > > > > On Thu, 2006-08-17 at 00:19 +0100, Russell King wrote:
> > > > > 
> > > > > 
> > > > > OK, thanks.  FWIW here is the serial board we are using:
> > > > > 
> > > > > http://www.moschip.com/html/MCS9845.html
> > > > > 
> > > > > The hardware guy says "The mn9845cv, have in default 2 serial ports and
> > > > > one ISA bus, where we have connected the tl16c554, quad serial port."
> > > > > 
> > > > > Hopefully Ingo's latency tracer can tell me what is holding off
> > > > > interrupts.
> > > > 
> > > > I beg your pardon: I'm not used that much to interrupts handling in Linux, but this piece of code from sound/drivers/serial-u16550.c in a linux-2.6.16:
> > > 
> > > OK, they are not using serial-u16550 but 8250_fourport for some reason:
> > 
> > Doesn't look like it.  fourport cards have their ports at 0x1a0..0x1bf
> > and 0x2a0..0x2bf, and have some special and non-standard features.
> > 
> 
> Which driver is being used then?
> 
> # lsmod | egrep serial\|8250
> 8250_fourport           2048  0 [permanent]
> 8250_pnp                8704  0 
> parport_serial          7680  0 
> parport_pc             31984  1 parport_serial
> 8250_pci               19968  1 parport_serial
> 8250                   22704  12 8250_pnp,8250_pci
> serial_core            19200  1 8250
> 
> Serial: 8250/16550 driver $Revision: 1.90 $ 10 ports, IRQ sharing
> enabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> Linux agpgart interface v0.101 (c) Dave Jones
> agpgart: Detected AGP bridge 0
> agpgart: AGP aperture is 128M @ 0xe8000000
> parport: PnPBIOS parport detected.
> parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
> Real Time Clock Driver v1.12ac
> input: PC Speaker as /class/input/input1
> ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 185
> 0000:00:0b.0: ttyS4 at I/O 0xdd00 (irq = 185) is a 16550A
> 0000:00:0b.0: ttyS5 at I/O 0xe300 (irq = 185) is a 16550A
> 0000:00:0b.0: ttyS6 at I/O 0xe400 (irq = 185) is a 16550A
> 0000:00:0b.0: ttyS7 at I/O 0xd000 (irq = 185) is a 16550A
> 0000:00:0b.0: ttyS8 at I/O 0xd100 (irq = 185) is a 16550A
> 0000:00:0b.0: ttyS9 at I/O 0xd200 (irq = 185) is a 16550A

That "0000:00:0b.0" looks like a PCI device ID.  If it were a fourport
board, it would be "serial8250.3" according to the current enumeration
in linux/serial_8250.h.

Also, another give away is that IRQ185 is being setup as a PCI interrupt
immediately prior to the devices being registered.

And I doubt that an ISA board (which is what fourport is) would ever get
such a high IRQ number.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
