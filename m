Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVILKGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVILKGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 06:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVILKGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 06:06:09 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:30696 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S1750704AbVILKGI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 06:06:08 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: 2.6.13-mm2
Date: Mon, 12 Sep 2005 12:06:04 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
References: <20050908053042.6e05882f.akpm@osdl.org> <20050911123627.2551a057.akpm@osdl.org> <200509112208.44422.daniel.ritz@gmx.ch>
In-Reply-To: <200509112208.44422.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121206.05450.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(continuing the unfinished message)

On Sunday, 11 of September 2005 22:08, Daniel Ritz wrote:
> On Sunday 11 September 2005 21.36, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > > 
> > >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
> > >  > 
> > >  > (kernel.org propagation is slow.  There's a temp copy at
> > >  > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm2.bz2)
> > > 
> > >  Could you please reintroduce the yenta-free_irq-on-suspend.patch (attached)
> > >  into -mm?  My box does not resume from disk without it.
> > 
> > No probs.
> > 
> > Daniel, do you remember why we decided to drop it?  What should we do about
> > this?  Thanks.
> > 
> 
> yeah, there was a long discussion about it. see:
> 	http://marc.theaimsgroup.com/?t=112275164900002&r=1&w=4
> the reason being that it breaks APM suspend on Hugh Dickins' (added to cc:) laptop.
> Linus was quite clear about why reverting...
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=112278810115252&w=4
> 
> we should look at both problems in detail:
> - with APM it seems to break because the bridge gives interrupt before the
>   handler is installed.
> - with ACPI i think some _other_ device gives the interrupts too early. but
>   when all devices on the interrupt unregister the irq is disabled and the
>   problem is hidden.
> 
> i don't think we can do mutch about the APM case...
> 
> so Rafael, your /proc/interrupts, lspci -vvv and dmesg, please.

rafael@albercik:~> cat /proc/interrupts
           CPU0       
  0:    2549476          XT-PIC  timer
  1:       3841          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:         10          XT-PIC  ehci_hcd:usb3
  8:          0          XT-PIC  rtc
  9:      13808          XT-PIC  acpi
 10:     120111          XT-PIC  NVidia nForce3, SysKonnect SK-98xx
 11:      74195          XT-PIC  ohci_hcd:usb1, ohci_hcd:usb2, yenta, yenta
 12:       4733          XT-PIC  i8042
 14:      90733          XT-PIC  ide0
 15:     144590          XT-PIC  ide1
NMI:        879 
LOC:    2549489 
ERR:          6
MIS:          0

rafael@albercik:~> /sbin/lspci -vvv 
0000:00:00.0 Host bridge: nVidia Corporation nForce3 Host Bridge (rev a4)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80c5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <available only to root>

0000:00:01.0 ISA bridge: nVidia Corporation nForce3 LPC Bridge (rev f6)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80c5
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:01.1 SMBus: nVidia Corporation nForce3 SMBus (rev a4)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80c5
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 5000 [size=64]
	Region 5: I/O ports at 5040 [size=64]
	Capabilities: <available only to root>

0000:00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1858
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at febfb000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1858
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at febfc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1859
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at febfdc00 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1853
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e800 [size=256]
	Region 1: I/O ports at ec00 [size=128]
	Region 2: Memory at febff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:08.0 IDE interface: nVidia Corporation nForce3 IDE (rev a5) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 185a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at ffa0 [size=16]
	Capabilities: <available only to root>

0000:00:0a.0 PCI bridge: nVidia Corporation nForce3 PCI Bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=0a, sec-latency=128
	I/O behind bridge: 0000b000-0000dfff
	Memory behind bridge: f8a00000-feafffff
	Prefetchable memory behind bridge: 30000000-33ffffff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:0b.0 PCI bridge: nVidia Corporation nForce3 AGP Bridge (rev a4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f6900000-f89fffff
	Prefetchable memory behind bridge: c6800000-e67fffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: <available only to root>

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV31M [GeForce FX Go5650] (rev a1) (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1852
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f7000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Expansion ROM at f89e0000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Ethernet Controller (rev 13)
	Subsystem: ASUSTeK Computer Inc. Marvell 88E8001 Gigabit Ethernet Controller (Asus)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5750ns min, 7750ns max), cache line size 40
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at feaf8000 (32-bit, non-prefetchable) [size=16K]
	Region 1: I/O ports at d800 [size=256]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ab)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1854
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd200000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 30000000-31fff000 (prefetchable)
	Memory window 1: fc600000-fd1ff000
	I/O window 0: 0000b000-0000bfff
	I/O window 1: 0000c000-0000cfff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:02:01.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ab)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1854
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at fa200000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 32000000-33fff000 (prefetchable)
	Memory window 1: f9600000-fa1ff000
	I/O window 0: 0000d000-0000d1ff
	I/O window 1: 0000d400-0000d5ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:02:01.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1857
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at feafd000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: <available only to root>

0000:02:01.3 System peripheral: Ricoh Co Ltd: Unknown device 0576 (rev 01)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 185b
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at feafd800 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:02:01.4 System peripheral: Ricoh Co Ltd: Unknown device 0592
	Subsystem: ASUSTeK Computer Inc.: Unknown device 185c
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at feafdc00 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:02:02.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller (rev 03)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 120f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at feafe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: <available only to root>

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
