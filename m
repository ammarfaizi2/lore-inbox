Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWD3QdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWD3QdO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 12:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWD3QdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 12:33:14 -0400
Received: from masoud.ir ([69.12.142.110]:51467 "EHLO deimos.masoud.ir")
	by vger.kernel.org with ESMTP id S1751165AbWD3QdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 12:33:13 -0400
Date: Sun, 30 Apr 2006 09:28:20 -0700
From: masouds@masoud.ir
To: cw@f00f.org
Cc: jeff@garzik.org, gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: [BUG] VIA quirk fixup failure after 2.6.17-rc3
Message-ID: <20060430162820.GA18666@masoud.ir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chris, 
My machine's tulip card stopped working after I updated to 2.6.17-rc3.git3 which included 75cf7456dd87335f574dcd53c4ae616a2ad71a11 patch of yours. Revesing it made the problem go away; Is there a chance that a VIA pci_id was missed from the list of quirks in your patch? 
The problem was that bringing up this interface always failed with 'IRQ #177: nobody cared!':
---
Apr 30 08:44:54 localhost kernel: irq 177: nobody cared (try booting with the "irqpoll" option)
Apr 30 08:44:54 localhost kernel:  <c10500f4> __report_bad_irq+0x24/0x90   <c10501df> note_interrupt+0x7f/0x240
Apr 30 08:44:54 localhost kernel:  <c1022add> rebalance_tick+0x10d/0x2d0   <c104f9f3> handle_IRQ_event+0x33/0x70
Apr 30 08:44:54 localhost kernel:  <c104fb22> __do_IRQ+0xf2/0x100   <c1007553> do_IRQ+0x23/0x40
Apr 30 08:44:54 localhost kernel:  <c1003d10> default_idle+0x0/0x60   <c1005bf6> common_interrupt+0x1a/0x20
Apr 30 08:44:54 localhost kernel:  <c1003d10> default_idle+0x0/0x60   <c1003d3c> default_idle+0x2c/0x60
Apr 30 08:44:54 localhost kernel:  <c1003dcf> cpu_idle+0x5f/0xf0
Apr 30 08:44:54 localhost kernel: handlers:
Apr 30 08:44:54 localhost kernel: [pg0+392112128/1051796480] (tulip_interrupt+0x0/0xee0 [tulip])
Apr 30 08:44:54 localhost kernel: Disabling IRQ #177
Apr 30 08:45:04 localhost kernel: eth0: no IPv6 routers present
Apr 30 08:48:21 localhost kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr 30 08:48:21 localhost kernel: eth0: Transmit timed out, status e4670045, CSR12 45e1d0cc, resetting...
----

Manually removing that patch made things work again.
The machine is a MSI-694D2-Pro2 dual CPU P3/866Mhz machine with 384 megs of ram.
For more info, here is my 'lspci -vv' output:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d0000000-d1ffffff
	Prefetchable memory behind bridge: d2000000-d2ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at 9000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at 9400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at 9800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 11
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0c.0 RAID bus controller: Promise Technology, Inc. PDC20265 (FastTrak100 Lite/Ultra100) (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 169
	Region 0: I/O ports at ac00 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at b400 [size=8]
	Region 3: I/O ports at b800 [size=4]
	Region 4: I/O ports at bc00 [size=64]
	Region 5: Memory at d4000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at 20040000 [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.0 Ethernet controller: Macronix, Inc. [MXIC] MX987x5 (rev 25)
	Subsystem: National Datacomm Corp: Unknown device 8110
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 177
	Region 0: I/O ports at c000 [size=256]
	Region 1: Memory at d4020000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at 20000000 [disabled] [size=256K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 43)
	Subsystem: D-Link System Inc DFE-530TX rev A
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 169
	Region 0: I/O ports at c400 [size=256]
	Region 1: Memory at d4021000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at 20050000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: Intel Corp. 82740 (i740) AGP Graphics Accelerator (rev 21) (prog-if 00 [VGA])
	Subsystem: Diamond Multimedia Systems Stealth II G460
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d2000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at d1000000 (32-bit, non-prefetchable) [size=512K]
	Expansion ROM at d0000000 [disabled] [size=256K]
	Capabilities: [d0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

-------------
cheers, 
Masoud Sharbiani
