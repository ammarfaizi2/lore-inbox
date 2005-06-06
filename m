Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVFFP4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVFFP4q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 11:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVFFP4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 11:56:46 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:60119 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261508AbVFFP4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 11:56:37 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jim Ramsay <jim.ramsay@gmail.com>
Subject: Re: Bug in 8520.c - port.type not set for serial console
Date: Mon, 6 Jun 2005 09:55:54 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <4789af9e05053015385667923@mail.gmail.com> <200505311625.46084.bjorn.helgaas@hp.com> <4789af9e0506060803161a8382@mail.gmail.com>
In-Reply-To: <4789af9e0506060803161a8382@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506060955.54238.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 June 2005 9:03 am, Jim Ramsay wrote:
> On 5/31/05, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > On Monday 30 May 2005 4:38 pm, Jim Ramsay wrote:
> > > I am attempting to get the 8520.c driver's serial console working with
> > > a 16550A UART implementation, and have run into what I consider to be
> > > a bug:  In short, the proper 'port.type' for this serial port is not
> > > set until the module init (serial8250_init) is called, so the FCR is
> > > set incorrectly during serial8250_console_init for any port type which
> > > is different than UNKNOWN.
> > >
> > > The exact problem is that the FCR is being set to '0x0' for a port
> > > type of 'UNKNOWN', when for my specific 16550A, it should be set to
> > > '0xC1' - and this makes my screen fill with empty characters instead
> > > of the printk output I need.
> > 
> > Shouldn't a 16550A UART work correctly with FCR==0x0, i.e., with FIFOs
> > disabled?  Is your UART broken?
> 
> That's a good question.  I'll me looking into this in the near future.
> 
> > Serial console output is always polled, one character at a time, so
> > you shouldn't need FIFOs until later.
> 
> True, as long as it works that way... so far I haven't seen it
> actually function properly yet with FCR set to 0.

On all the UARTs I've seen, it works with FCR=0.  Hence my suspicion
of your device.

The problem is that most architectures supply SERIAL_PORT_DFNS,
which are compiled-in mappings of /dev/ttyS device names to
specific devices, so 8250.c knows about and uses those devices
before they're properly identified and initialized.

If you can remove your SERIAL_PORT_DFNS (and discover the devices
at boot-time via a mechanism like ACPI or PCI enumeration), then
8250.c won't start using the port until it's correctly initialized.

That means the serial console won't start working until later, of
course.  If you need a serial console early, I think you should use
something like 8250_early.c.  That uses "console=uart,io,0x3f8", so
you don't have to have compiled-in knowledge of the device names.
It currently initializes the UART with FCR=0 also, but it would
be reasonable to add a "no-init" option to just use the device in
the state firmware left it in.
