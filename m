Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVCXUna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVCXUna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVCXUlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:41:55 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:62038 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261211AbVCXUkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:40:13 -0500
Message-ID: <424325A7.2010101@tls.msk.ru>
Date: Thu, 24 Mar 2005 23:40:07 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Netmos parallel/serial/combo support
References: <1111533253.22819.2.camel@eeyore>
In-Reply-To: <1111533253.22819.2.camel@eeyore>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Hmm... Too large Cc list.  Dunno which addresses should be keept...]

Bjorn Helgaas wrote:
> Here's another iteration of my patch for better Netmos support.
> This is against 2.6.12-rc1-mm1.  Kerry and Darac have sucessfully
> tested a similar patch with 9835 cards.  I think we're ready for
> wider testing, such as -mm.
> 
> There's a bugzilla entry for this here:
>     http://bugzilla.kernel.org/show_bug.cgi?id=4334
> 
> I'd like to hear about any problems or issues (or even better,
> about successes, of course :-)).  If you encounter a problem,
> please include the dmesg log and the output of "lspci -vvn".
> 
> This should fix all the problems I know about with Netmos combo cards:
>     - 9735, 9835, and 9855 are not supported
>     - combo cards with parallel are erroneously claimed by serial driver
>     - serial and parport_serial blindly probe for ports

So, do you expect 9[78]35 cards to work? ;)

With this patch applied, my 9835 card now works when loading 8250_pci
module.  But things does not completely work still.

I've a 9835 card with two serial and no parallel ports:

0000:01:00.0 0700: 9710:9835 (rev 01) (prog-if 02)
         Subsystem: 1000:0002
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 193
         Region 0: I/O ports at a400 [size=8]
         Region 1: I/O ports at a000 [size=8]
         Region 2: I/O ports at 9800 [size=8]
         Region 3: I/O ports at 9400 [size=8]
         Region 4: I/O ports at 9000 [size=8]
         Region 5: I/O ports at 8800 [size=16]


When I first load 8250_pci, it correctly detects one onboard
serial port (ttyS0) and two ports on the card (ttyS4 and ttyS5):

Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 193
ttyS4 at I/O 0xa400 (irq = 193) is a 16550A
ttyS5 at I/O 0xa000 (irq = 193) is a 16550A

When I load parport_pc after loading 8250_pci, it correctly detects
onboard parallel port and nothing more:

parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]

But after reloading parport_pc, it does not see the built-in
port anymore; more, after unloading 8250_pci and 8250,
parport_pc finds one parallel port -- on this netmos
card only (there's no parallel port on this card):

PCI parallel port detected: 9710:9835, I/O at 0x9800(0x9400)
parport0: PC-style at 0x9800 (0x9400) [PCSPP,TRISTATE]

When parport_pc loaded, 8250[_pci] can't detect the two
serial ports it detected previously:

Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

So, when loading 8250_pci first, and parport_pc second
(and not unloading anything), things works as expected.
When loading parport_pc first (not parport_serial), and
8250_pci after, there will be 2 parallel and only one
serial ports:

parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 193
PCI parallel port detected: 9710:9835, I/O at 0x9800(0x9400)
parport1: PC-style at 0x9800 (0x9400) [PCSPP,TRISTATE]
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

When loading parport_serial only (which loads all the
rest), things works as expected (well... it's due
to dependencies resolved in a "correct" order -
8250 stuff first and parport_pc second).

The issue with built-in port not being detected after
re-loading parport_pc may be unrelated - looks like
it is this way without the card inserted.

/mjt
