Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267808AbUH1U7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbUH1U7W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUH1U7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:59:22 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:26767 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S267808AbUH1U6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:58:50 -0400
Date: Sat, 28 Aug 2004 22:38:42 +0200 (MEST)
From: Martin Jacobs <100.179370@germanynet.de>
To: linux-kernel@vger.kernel.org
Cc: s.willing@mops.net
Subject: Re: syba tech multi-I/O pci-card
Message-ID: <Pine.LNX.4.44.0408281935090.26507-100000@Schnecke.Windsbach.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello!
> Does anyone know this card? (Output extracted from lspci -vv)
>
> 00:10.0 Class 0786: Syba Tech Ltd Multi-IO Card (rev 92)
> (prog-if 15)
>  Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>  Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>  Interrupt: pin A routed to IRQ 11
>  Region 0: I/O ports at dc00
>
> It is a dual RS232-card with two 16550A - UARTS. I want to use
> it as ttyS2 &
> ttyS3 in my (fax)server, but setserial only knows the ports
> when I boot to DOS,
> manually set the Ports (3E8 & 2E8, IrDA disabled) and then use
> loadlin.
>
> The following lines are from my /sbin/init.d/serial (which
> does the serial
> setup at boot time):
>
>     SETSERIAL="/sbin/setserial -bav"
>     AUTO_IRQ=auto_irq
>      echo " + Setting up ttyS0..."
>      ${SETSERIAL} /dev/ttyS0 ${AUTO_IRQ} autoconfig
>      echo " + Setting up ttyS1..."
>      ${SETSERIAL} /dev/ttyS1 ${AUTO_IRQ} autoconfig
>      echo " + Setting up ttyS2..."
>      ${SETSERIAL} /dev/ttyS2 irq 11 port 0x3E8 uart 16550A
>      echo " + Setting up ttyS3..."
>      ${SETSERIAL} /dev/ttyS3 irq 11 port 0x2E8 uart 16550A
>     echo "done."
>
> The manual claims that the card is from Syba Tech Ltd. and is
> using an "TC32001
> PCI I/O Target Controller chipset", but I'm unable to find any
> website of this
> company.
> I tried all the drivers which come with the 2.3.9 (which is
> the last kernel I
> tested which compiled on by box), but none worked.
>
> Could anyone help me with this card?
> bye,
> Sebastian
> --
> ...

Hi all,

I know, this is a rather later response. Anyway, I have a similar
another card of this family and can help a little bit. Here ist
what I found out:

1. Kernel 2.4 recognizes this kind of IO cards as manufactured
by "Syba Tech".

lspci lists my card (4-port serial) as

	Class 0786: Syba Tech Ltd Multi-IO Card (rev 92)

2. Kernel 2.4 (it's serial driver) does not recognize this
card as multi IO card.

3. Using DOS emulator as root with setting

	$_pci = (on)
	$_ports = "device /dev/null 0xbc00 0xbfff"

allows to start DOS program SYBAMIO.EXE. After setting
everything to auto and saving your settings (press key F3),
SYBAMIO.EXE writes DOS file C:\sybamio.dat.

Program SYBAMIO.EXE is provided with this card as DOS based
configuration software.

4. Now serial port UARTs are mapped inside card's
IO address range as reported by /proc/ioports. My machine
lists this card as:

	bc00-bfff : Syba Tech Ltd Multi-IO Card

Actually configured UART base addresses can be found in file
sybamio.dat. Create a hex dump, e.g. use xxd, and have a look
at offsets 0x0010, 0x0014, 0x0028 and 0x002c. As far as I
could analyze this file, interrupt line is found at offset
0x0c.

In my machine I found the following base adresses:

	ttyS2: 0xbde8
	ttyS3: 0xbce8
	ttyS4: 0xbdf8
	ttyS5: 0xbcf8

5. Use hex words (LSB, MSB) at those addresses and use them as
UART base address. Then use setserial to tell your linux
serial driver to detect and use those ports:

	/sbin/setserial /dev/ttyS<n> port <base> autoconfigure
irq <int> ^fourport

After repeating this four times (I added this to boot.local)
cat /proc/ioports reports:

	...
	bc00-bfff : Syba Tech Ltd Multi-IO Card
	  bce8-bcef : serial(set)
	  bcf8-bcff : serial(set)
	  bde8-bdef : serial(set)
	  bdf8-bdff : serial(set)
	...

6. All four ports work after doing this. So far I could not
verify if all ports work concurrently.

7. I do not have to repeat step 3 after reboot!

Other cards of this family will work similar, I hope.

Regards

Martin Jacobs

-- 
Martin Jacobs, Registered Linux User #87175, http://counter.li.org/




