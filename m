Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131066AbRANTVA>; Sun, 14 Jan 2001 14:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132600AbRANTUu>; Sun, 14 Jan 2001 14:20:50 -0500
Received: from frankffm8-57.bunt.com ([195.178.8.62]:6148 "EHLO
	dragon.flyn.org") by vger.kernel.org with ESMTP id <S131066AbRANTUn>;
	Sun, 14 Jan 2001 14:20:43 -0500
Date: Sun, 14 Jan 2001 20:10:45 +0100
From: "W. Michael Petullo" <mike@flyn.org>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: Lucent Microelectronics Venus Modem, serial 5.05, and Linux 2.4.0
Message-ID: <20010114201045.A1787@dragon.flyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux dragon.flyn.org 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore, et al.,

I have a Lucent Microelectronics Venus Modem (V90, 56KFlex) (rev 0) based
modem which /almost/ works with your serial driver.  Giving the modem
an ATI command returns AEIGPM560LKTF1.  The company that manufactures
the modem calls it a PM560LKC 56K Internal PCI Call Waiting Modem.
At the very end of this message you will find the output `lspci` and
`cat /proc/bus/pci/00/06.0 | od -h` on my computer.

I recently wrote you about some problems I was having with this modem.
I have found some time to play around with version 5.05 of your driver
and the 2.4.0 Linux kernel, and wanted to share what I have found.

First, I added the following to the pci_boards array in serial.c:

...
{       0x11c1, 0x0480,
	0x1668, 0x0500,
	SPCI_FL_BASE1, 1, 115200 },
...

I found this data in the file located in /proc/bus/pci/00/ associated
with my modem.

In order for pci_announce_device to work with my modem, I also had to
change serial_pci_tbl's class_mask field from 0xffff00 to 0xff0000 in
serial.c.  This causes pci_announce_device to announce any communication
device (PCI_BASE_CLASS_COMMUNICATION) instead of just serial ports
(PCI_CLASS_COMMUNICATION_SERIAL).  In order for my modem to be caught,
the mask had to approve PCI_CLASS_COMMUNICATION_OTHER.

Once I made these two changes, I was back to the problems I was having
before, as documented in the message quoted at the bottom of this one.
Once I made the further modifications documented in this quoted email,
version 5.05 of your serial driver worked with my modem.  Of course,
these modifications are far from the ideal; I am still trying to figure
out what is really going on.

I could send a patch with these changes if you would like.  Any comments?

=============== previous message: =========================================

> The modem is auto-detected fine -- sometimes.  The auto-detection process
> does not fail according to any pattern that I can see.

> There are three different results I see after the auto-detection process:

> 1.  The modem is detected correctly.
> 2.  The modem is detected, but as a 8250 type UART.
> 3.  The modem is not detected.

> In serial.c, you seem to perform a check by writing to a possible
> modem's interrupt enable register and reading the result.  This seems to
> be one of the points at which the auto-configuration process occasionally
> fails.  If I make the following change to this code my modem seems to
> be auto-detected correctly all of the time:

>                scratch = serial_inp(info, UART_IER);
>		serial_outp(info, UART_IER, 0);
> #ifdef __i386__
>		outb(0xff, 0x080);
> #endif
>		scratch2 = serial_inp(info, UART_IER);
>		serial_outp(info, UART_IER, 0x0F);
> #ifdef __i386__
>		outb(0, 0x080);
> #endif
> -             scratch3 = serial_inp(info, UART_IER); /* REMOVE */
> +             scratch3 = 0x0f                        /* ADD */
> 		serial_outp(info, UART_IER, scratch);

> If I print the values of scratch, scratch2, and scratch3, they are:

> 00, 00, and 0f for a successfully detected serial port, respectively
> ff, ff, and ff for a serial port which was not detected and does not exist
> and
> 00, 00, and 00 for my modem when detection fails.

> When the modem /is/ detected setserial says ``UART: 16550A, Port: 0xd400,
> IRQ: 5.''

> The reason for my interest in auto-detecting my modem instead of using
> setserial is two-fold.  First, I am using devfs.  This makes running
> setserial awkward because the modem needs to be auto-detected for
> the kernel to make a device entry in my device filesystem for it.
> Second,I use a modular serial driver and a pre-install entry in my
> modules.conf file that runs setserial also seems awkward.

> A related question: why does your serial driver not take parameters
> like parport?  It would be nice to be able to do something like `insmod
> parport_pc.o io=0x3bc,0x378,0x278 irq=none,7,auto` and not need setserial
> at all.

=============== lspci -vvv: ===============================================

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller (rev 23)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 160
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at eddff000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at d800 [disabled] [size=4]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 160
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=160
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: ede00000-efefffff
	Prefetchable memory behind bridge: d9c00000-ddcfffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:03.0 SCSI storage controller: Adaptec AIC-7881U (rev 01)
	Subsystem: Adaptec AHA-2940UW SCSI Host Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 160 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at effff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at effe0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 160 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at eddfd000 (32-bit, prefetchable) [size=4K]

00:04.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 160 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at eddfe000 (32-bit, prefetchable) [size=4K]

00:06.0 Communication controller: Lucent Microelectronics Venus Modem (V90, 56KFlex)
	Subsystem: Action Tec Electronics Inc: Unknown device 0500
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at efffef00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at d400 [size=256]
	Region 2: I/O ports at d000 [size=256]
	Region 3: I/O ports at cc00 [size=8]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 15)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 4: I/O ports at ffa0 [disabled] [size=16]

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
	Subsystem: Unknown device 4942:4c4c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 160 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at c800 [size=64]

00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
	Subsystem: D-Link System Inc DE-530+
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 160
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at c400 [size=128]
	Region 1: Memory at efffee80 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at eff80000 [disabled] [size=256K]

01:05.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 11) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 160 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at da000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at efef0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

=============== cat /proc/bus/pci/00/06.0 | od -h: ========================

0000000 11c1 0480 0107 0290 0000 0780 0000 0000
0000020 ef00 efff d401 0000 d001 0000 cc01 0000
0000040 0000 0000 0000 0000 0040 0000 1668 0500
0000060 0000 0000 00f8 0000 0000 0000 0105 0efc
0000100 0505 0505 0505 0505 0505 0505 0505 0505
*
0000360 0505 0505 0505 0505 0001 e422 0000 0000
0000400

-- 
W. Michael Petullo

:wq
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
