Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318878AbSHEU5U>; Mon, 5 Aug 2002 16:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318314AbSHEU5T>; Mon, 5 Aug 2002 16:57:19 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:38405 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S318878AbSHEU5S>; Mon, 5 Aug 2002 16:57:18 -0400
Subject: parport_serial / serial init order wrong?
To: twaugh@redhat.com
Date: Mon, 5 Aug 2002 23:00:52 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17boyC-0004rp-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to make a PCI 2S1P Multi I/O card (NM9835 chip) work with
Linux 2.4.19.  I've applied the 2.5.x linux-netmos.patch (with manual
patching of rejected hunks), and I can see this in the boot messages:

parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport_pc: Via 686A parallel port: io=0x378
PCI parallel port detected: 9710:9835, I/O at 0xb800(0x0)
parport1: PC-style at 0xb800 [PCSPP,TRISTATE,EPP]
ttyS00 at port 0xb000 (irq = 9) is a 16550A
ttyS00 at port 0xb400 (irq = 9) is a 16550A
.....
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
lp0: console ready
lp1: using parport1 (polling).

The two PCI serial ports (incorrectly reported as ttyS00) are really
ttyS4 and ttyS5, but setserial reports unknown UART (with correct I/O
and IRQ), so they don't work until I do this:

setserial /dev/ttyS4 autoconfig
setserial /dev/ttyS5 autoconfig

I suspect that the parport_serial driver should be initialized after
the serial driver, so it can register the detected UARTs properly.
(I have the necessary drivers compiled into the kernel, no modules.)

The serial ports appear to work fine after the setserial autoconfig
commands.  I haven't tested the NM9835 parallel port just yet - what
I really needed is more serial ports, but a PCI card with only two
serial ports (no parallel) was hard to find and twice as expensive ;)

I suspect the NM9835 may be a quite popular chip - any chances of
making support for it available in 2.4.x kernel series?

Thanks,
Marek

