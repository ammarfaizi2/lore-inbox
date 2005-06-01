Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVFATPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVFATPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFASvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:51:35 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:15570 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S261525AbVFAS2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:28:02 -0400
Message-ID: <429DFD90.10802@keyaccess.nl>
Date: Wed, 01 Jun 2005 20:25:20 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl> <20050601081810.GA23114@elf.ucw.cz>
In-Reply-To: <20050601081810.GA23114@elf.ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------090201080708000406070701"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090201080708000406070701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Pavel Machek wrote:

EHCI maintainter (as given by MAINTAINERS) added to CC.

> On Út 31-05-05 01:21:37, Rene Herman wrote:

[ internal IDE HDD slowdown after switching on external USB2 HDD ]

> USB controller generating extra DMA load? Try rmmoding usb to see if
> it goes away.

I was sceptical about this since the drive is idle (or even switched off 
again) but I recompiled EHCI modular and rmmodding ehci_hcd does in fact 
bring back my 50 MB/s:

				: hdparm -t /dev/hda = 50 MB/s
1. modprobe ehci_hcd		: hdparm -t /dev/hda = 50 MB/s
2. switch on USB2 drive		: hdparm -t /dev/hda = 42 MB/s
3. switch off USB drive		: hdparm -t /dev/hda = 42 MB/s
4. modprobe -r ehci_hcd		: hdparm -t /dev/hda = 50 MB/s

There would not seem to be any extra DMA load with a drive that's idle 
or switched off again though? Is the (VIA) USB2 controller playing bus 
monopolizing tricks or something sinister like that? (the speed doesn't 
drop immediately after loading ehci_hcd though, only after switching on 
the USB2 HDD)

More detail --- it's a VIA VT6212L EHCI controller, on unshared IRQ3. 
IDE0 is AMD756 on unshared IRQ14/15. The USB2 HDD does 30 MB/s (after a 
hdparm -a 1024; with the default 256 it's 25MB/s) which I did think was 
a very good speed.

lspci -vv attached, in case it's useful.

Many thanks in advance to anyone for any additional insight...

Rene.


--------------090201080708000406070701
Content-Type: text/plain;
 name="LSPCI"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="LSPCI"

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller (rev 25)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 120
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at efbff000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at d800 [disabled] [size=4]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x2

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: efc00000-efcfffff
	Prefetchable memory behind bridge: dfa00000-e7afffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (rev 07) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:08.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
	Subsystem: TERRATEC Electronic GmbH: Unknown device 112e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at efffd000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at efe00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk+ DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 61) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 4: I/O ports at da00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 61) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 63) (prog-if 20 [EHCI])
	Subsystem: VIA Technologies, Inc. USB 2.0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Interrupt: pin C routed to IRQ 3
	Region 0: Memory at effffe00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.3 FireWire (IEEE 1394): NEC Corporation: Unknown device 00e7 (rev 01) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation: Unknown device 00ce
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at efffe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at de00 [size=128]
	Region 1: Memory at efffff80 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at effc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:05.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG AGP (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0048
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at b800 [size=256]
	Region 2: Memory at efcfc000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at efcc0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=16 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x2
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------090201080708000406070701--
