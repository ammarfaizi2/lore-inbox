Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269331AbRGaQHB>; Tue, 31 Jul 2001 12:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269344AbRGaQGm>; Tue, 31 Jul 2001 12:06:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47934 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S269343AbRGaQGa>; Tue, 31 Jul 2001 12:06:30 -0400
To: "Stuart MacDonald" <stuartm@connecttech.com>
Cc: "Khalid Aziz" <khalid@fc.hp.com>,
        "Linux kernel development list" <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <200107302332.f6UNWbxg001791@webber.adilger.int>
	<3B65F1A2.30708CC1@fc.hp.com>
	<000701c119cd$ebf0c720$294b82ce@connecttech.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 31 Jul 2001 10:00:12 -0600
In-Reply-To: <000701c119cd$ebf0c720$294b82ce@connecttech.com>
Message-ID: <m1hevtytpv.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Stuart MacDonald" <stuartm@connecttech.com> writes:

> From: "Khalid Aziz" <khalid@fc.hp.com>
> > AFAIK, you can not have console on a PCI serial port at this time. I
> > looked at it few months back and found out that PCI initialization
> > happens much too late for a serial console. It would take quite a bit of
> 
> That's very odd. That implies that serial consoles don't use the serial
> driver at all then, as the pci serial port setup is done at the same
> time as the regular serial port setups.
> 
> If a serial console is using serial.c, the pci serial ports will also
> be available.
> 
> Hm, looking through the driver quick, I find some interesting things:
> 
> A) Serial console support is mutually exclusive with the serial driver
> being a module.
> B) The serial console will not share its irq. Other ports with the same
> irq are set to polled mode. This may impact performance. It also suggests
> that using the console on a pci board isn't a good idea, as pci will
> share the irq to other devices.
> C) serial.c contains a completely separate serial console driver,
> complete with its own init routine. Which meshes with the current
> suggestion that the "serial driver" isn't used, and pci init happens
> too late.
> 
> > work to get serial console working on PCI cards. PA-Linux faced the same
> > problem but they were able to get around it by using the firmware calls
> > to do console I/O. If serial console were working on PCI serial cards,
> > you wouldn't need ACPI to use it.
> 
> It seems like pci consoles won't work, now that I think about it.

It depends.  The pci iniitalization is straight forward.  It should
be relatively simple to build a pci serial driver that hard codes the
pci card.  I have done similiar things because for some debugging I
have done the current serial console is initialized too late.  So I
hacked a hardcoded driver into printk.c

> The
> console driver gets an index, which I'm going to assume works thusly:
> lilo console=ttyS1 ends up passing 1 as the index. That index is used
> to pick a serial port out of the array of serial ports that the driver
> knows about. If console init happens early, and serial driver init happens
> late (it would be dependent on pci init) then only hard coded ports
> would work. Those are defined in asm/serial.h, and for i386 include the
> standard ports, and a number of isa ports from various board manufacturers.
> 
> Using one of our pci ports would require knowledge of its io address,
> which wouldn't be available until the pci subsystem had inited. Perhaps
> that could be changed to allow pci based consoles?

I would say the simple solution would be to add a configure option to
do an early PCI init on the card, and to hard code it's ports.
 
> Elsethread someone mentions a stripped down usb console driver; that's
> analogous to the serial console driver contained in serial.c. And if
> serial can do it...

If it isn't too complex.

Eric
