Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269306AbRGaObD>; Tue, 31 Jul 2001 10:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269308AbRGaOay>; Tue, 31 Jul 2001 10:30:54 -0400
Received: from [64.7.140.42] ([64.7.140.42]:53699 "EHLO inet.connecttech.com")
	by vger.kernel.org with ESMTP id <S269306AbRGaOaf>;
	Tue, 31 Jul 2001 10:30:35 -0400
Message-ID: <000701c119cd$ebf0c720$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Khalid Aziz" <khalid@fc.hp.com>
Cc: "Linux kernel development list" <linux-kernel@vger.kernel.org>
In-Reply-To: <200107302332.f6UNWbxg001791@webber.adilger.int> <3B65F1A2.30708CC1@fc.hp.com>
Subject: Re: Support for serial console on legacy free machines
Date: Tue, 31 Jul 2001 10:34:35 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

From: "Khalid Aziz" <khalid@fc.hp.com>
> AFAIK, you can not have console on a PCI serial port at this time. I
> looked at it few months back and found out that PCI initialization
> happens much too late for a serial console. It would take quite a bit of

That's very odd. That implies that serial consoles don't use the serial
driver at all then, as the pci serial port setup is done at the same
time as the regular serial port setups.

If a serial console is using serial.c, the pci serial ports will also
be available.

Hm, looking through the driver quick, I find some interesting things:

A) Serial console support is mutually exclusive with the serial driver
being a module.
B) The serial console will not share its irq. Other ports with the same
irq are set to polled mode. This may impact performance. It also suggests
that using the console on a pci board isn't a good idea, as pci will
share the irq to other devices.
C) serial.c contains a completely separate serial console driver,
complete with its own init routine. Which meshes with the current
suggestion that the "serial driver" isn't used, and pci init happens
too late.

> work to get serial console working on PCI cards. PA-Linux faced the same
> problem but they were able to get around it by using the firmware calls
> to do console I/O. If serial console were working on PCI serial cards,
> you wouldn't need ACPI to use it.

It seems like pci consoles won't work, now that I think about it. The
console driver gets an index, which I'm going to assume works thusly:
lilo console=ttyS1 ends up passing 1 as the index. That index is used
to pick a serial port out of the array of serial ports that the driver
knows about. If console init happens early, and serial driver init happens
late (it would be dependent on pci init) then only hard coded ports
would work. Those are defined in asm/serial.h, and for i386 include the
standard ports, and a number of isa ports from various board manufacturers.

Using one of our pci ports would require knowledge of its io address,
which wouldn't be available until the pci subsystem had inited. Perhaps
that could be changed to allow pci based consoles?

Elsethread someone mentions a stripped down usb console driver; that's
analogous to the serial console driver contained in serial.c. And if
serial can do it...

..Stu




