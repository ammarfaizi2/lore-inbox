Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUEFEAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUEFEAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 00:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUEFEAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 00:00:41 -0400
Received: from d61.wireless.hilander.com ([216.241.32.61]:25039 "EHLO
	ramirez.hilander.com") by vger.kernel.org with ESMTP
	id S261498AbUEFEAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 00:00:09 -0400
Date: Wed, 05 May 2004 22:00:02 -0600
From: "Alec H. Peterson" <ahp@hilander.com>
To: linux-kernel@vger.kernel.org
Subject: pci_request_regions() failure
Message-ID: <01D138A0E5F192A9DBDB9432@[192.168.0.100]>
X-Mailer: Mulberry/3.1.3 (Mac OS X)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="==========D8C65848C5232FDE4F9B=========="
X-Spam-Score: -4.8 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1BLa3G-0007nj-Ut*keJXQ/M9.n.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========D8C65848C5232FDE4F9B==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I saw that there were some posts recently about Cardbus cards not being 
able reserve memory.  I too am having the same problems (both with Prism 
and Atheros Cardbus cards).  I have some data that I am hopeful will help 
address the issue.

I am currently running on a Shuttle XPC with a 2.4.25 kernel.  I have tried 
this with both a Ricoh RL5C475 single slot and a TI PCI1420 PCMCIA/PCI dual 
slot bridge.  The problem is that whenever I insert the card (a NetGear 
WG511) in the Ricoh controller or in slot 0 of the TI controller I get a 
pci_request_regions() failure.  The interesting thing is the region that it 
fails for.  According to /proc/iomem, slot0 has ec107000-ec108fff as one of 
its memory ranges.  However, the memory region reported in the failure (as 
well as in /proc/iomem after the failure) is ec108000-ec108fff.

However, when I insert the card into slot 1 of the TI controller the driver 
works perfectly, and the region for the slot (ec10c000-ec10dfff) matches 
the region that is mapped to the card (ec10c000-ec10dfff).

I have attached the output of lspci -vv and cat /proc/iomem for both the 
successful and failed situations.

As far as I can tell it appears that for slot 0 (as well as the only slot 
in the single slot controller) the system is being told of a region of 
memory that is only a subset of the actual region that the card should be 
using.  To me, it seems that the device in question needs to be 
re-configured with the proper memory window, but I haven't a clue where to 
begin on such a task, nor do I know if it is even possible.

Any help would be greatly appreciated.

Thanks,

Alec
--==========D8C65848C5232FDE4F9B==========
Content-Type: text/plain; charset=us-ascii; name=Failure; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0651 
(rev 02)
        Subsystem: Silicon Integrated Systems [SiS]: Unknown device 0651
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: ec000000-ec0fffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 14)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 
8a [Master SecP PriP])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller 
(A,B step)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 4000 [size=16]
        Capabilities: [58] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
SiS7012 PCI Audio Accelerator (rev a0)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown 
device c120
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at a000 [size=256]
        Region 1: I/O ports at a400 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f) 
(prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at ec100000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f) 
(prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 5
        Region 0: Memory at ec101000 (32-bit, non-prefetchable) [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f) 
(prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at ec102000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS]: Unknown device 
7002 (prog-if 20 [EHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown 
device f451
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at ec103000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Texas Instruments PCI1420
        Subsystem: CARRY Computer ENG. CO Ltd: Unknown device 0202
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ec104000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: ec105000-ec106000 (prefetchable)
        Memory window 1: ec107000-ec108000
        I/O window 0: 0000a800-0000ac03
        I/O window 1: 0000b000-0000b403
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- 
PostWrite+
        16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1420
        Subsystem: CARRY Computer ENG. CO Ltd: Unknown device 0202
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ec109000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=176
        Memory window 0: ec10a000-ec10b000 (prefetchable)
        Memory window 1: ec10c000-ec10d000
        I/O window 0: 0000b800-0000bc03
        I/O window 1: 0000c000-0000c403
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite+
        16-bit legacy interface ports at 0001

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C 
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at c800 [size=256]
        Region 1: Memory at ec10e000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 46) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at ec10f000 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at cc00 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]: 
Unknown device 6325 (prog-if 00 [VGA])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown 
device f451
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ec000000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at 9000 [size=128]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:00.0 Network controller: Harris Semiconductor: Unknown device 3890 (rev 
01)
        Subsystem: Netgear: Unknown device 4800
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: [virtual] Memory at ec108000 (32-bit, non-prefetchable) 
[size=4K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0dfeffff : System RAM
  00100000-00256b24 : Kernel code
  00256b25-002eaf0b : Kernel data
0dff0000-0dff2fff : ACPI Non-volatile Storage
0dff3000-0dffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : Silicon Integrated Systems [SiS] SiS65x/M650/740 
PCI/AGP VGA Display Adapter
e8000000-ebffffff : Silicon Integrated Systems [SiS] SiS651 Host
ec000000-ec0fffff : PCI Bus #01
  ec000000-ec01ffff : Silicon Integrated Systems [SiS] SiS65x/M650/740 
PCI/AGP VGA Display Adapter
ec100000-ec100fff : Silicon Integrated Systems [SiS] USB 1.0 Controller
ec101000-ec101fff : Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
ec102000-ec102fff : Silicon Integrated Systems [SiS] USB 1.0 Controller (#3)
ec103000-ec103fff : Silicon Integrated Systems [SiS] USB 2.0 Controller
ec104000-ec104fff : Texas Instruments PCI1420
ec105000-ec106fff : PCI CardBus #02
ec107000-ec108fff : PCI CardBus #02
  ec108000-ec108fff :
ec109000-ec109fff : Texas Instruments PCI1420 (#2)
ec10a000-ec10bfff : PCI CardBus #03
ec10c000-ec10dfff : PCI CardBus #03
ec10e000-ec10e0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  ec10e000-ec10e0ff : 8139too
ec10f000-ec10f7ff : VIA Technologies, Inc. IEEE 1394 Host Controller
fec00000-ffffffff : reserved

--==========D8C65848C5232FDE4F9B==========
Content-Type: text/plain; charset=us-ascii; name=Success; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0651 
(rev 02)
        Subsystem: Silicon Integrated Systems [SiS]: Unknown device 0651
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: ec000000-ec0fffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 14)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 
8a [Master SecP PriP])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller 
(A,B step)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 4000 [size=16]
        Capabilities: [58] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
SiS7012 PCI Audio Accelerator (rev a0)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown 
device c120
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at a000 [size=256]
        Region 1: I/O ports at a400 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f) 
(prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at ec100000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f) 
(prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 5
        Region 0: Memory at ec101000 (32-bit, non-prefetchable) [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f) 
(prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] 7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at ec102000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS]: Unknown device 
7002 (prog-if 20 [EHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown 
device f451
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at ec103000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Texas Instruments PCI1420
        Subsystem: CARRY Computer ENG. CO Ltd: Unknown device 0202
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ec104000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: ec105000-ec106000 (prefetchable)
        Memory window 1: ec107000-ec108000
        I/O window 0: 0000a800-0000ac03
        I/O window 1: 0000b000-0000b403
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite+
        16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1420
        Subsystem: CARRY Computer ENG. CO Ltd: Unknown device 0202
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ec109000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=176
        Memory window 0: ec10a000-ec10b000 (prefetchable)
        Memory window 1: ec10c000-ec10d000
        I/O window 0: 0000b800-0000bc03
        I/O window 1: 0000c000-0000c403
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- 
PostWrite+
        16-bit legacy interface ports at 0001

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C 
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at c800 [size=256]
        Region 1: Memory at ec10e000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 46) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at ec10f000 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at cc00 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]: 
Unknown device 6325 (prog-if 00 [VGA])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown 
device f451
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ec000000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at 9000 [size=128]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

03:00.0 Network controller: Harris Semiconductor: Unknown device 3890 (rev 
01)
        Subsystem: Netgear: Unknown device 4800
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (2500ns min, 7000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ec10c000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0dfeffff : System RAM
  00100000-00256b24 : Kernel code
  00256b25-002eaf0b : Kernel data
0dff0000-0dff2fff : ACPI Non-volatile Storage
0dff3000-0dffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : Silicon Integrated Systems [SiS] SiS65x/M650/740 
PCI/AGP VGA Display Adapter
e8000000-ebffffff : Silicon Integrated Systems [SiS] SiS651 Host
ec000000-ec0fffff : PCI Bus #01
  ec000000-ec01ffff : Silicon Integrated Systems [SiS] SiS65x/M650/740 
PCI/AGP VGA Display Adapter
ec100000-ec100fff : Silicon Integrated Systems [SiS] USB 1.0 Controller
ec101000-ec101fff : Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
ec102000-ec102fff : Silicon Integrated Systems [SiS] USB 1.0 Controller (#3)
ec103000-ec103fff : Silicon Integrated Systems [SiS] USB 2.0 Controller
ec104000-ec104fff : Texas Instruments PCI1420
ec105000-ec106fff : PCI CardBus #02
ec107000-ec108fff : PCI CardBus #02
  ec108000-ec108fff :
ec109000-ec109fff : Texas Instruments PCI1420 (#2)
ec10a000-ec10bfff : PCI CardBus #03
ec10c000-ec10dfff : PCI CardBus #03
  ec10c000-ec10dfff : PCI device 1260:3890
    ec10c000-ec10dfff : prism54
ec10e000-ec10e0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  ec10e000-ec10e0ff : 8139too
ec10f000-ec10f7ff : VIA Technologies, Inc. IEEE 1394 Host Controller
fec00000-ffffffff : reserved

--==========D8C65848C5232FDE4F9B==========--

