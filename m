Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVI1MoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVI1MoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 08:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVI1MoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 08:44:04 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:21897 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751260AbVI1MoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 08:44:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=GiCNwSNBGPhPtLNtc4NpuSpBk5VdkqmLyPVBiRd9SYwC/bsOrHc14XqA3NWDomG/G9Yj5CNM/wtI7hPrcnF7J4jbPNnVjb8k5foa//I7zZ/C9BuCIHa5BKxi0+91FxAjjFUvmgEz9q1cYZQH2/ozOLosnPngNcn+3yNdDjLs4Aw=
From: Tejun Heo <htejun@gmail.com>
To: ak@suse.de, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH linux-2.6 00/03] i386_and_x86_64: implement dma_broken_dac() test
Message-ID: <20050928124148.EBEDFAFE@htj.dyndns.org>
Date: Wed, 28 Sep 2005 21:44:06 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Andi Kleen & Greg Kroah-Hartman.

 I've encountered this problem on my new desktop - an athlon 64
machine with ASUS A8N-E (w/ CK804 a.k.a nforce4 chipset, lspci results
at the end of this mail) and 4 gigs of memory.  I put in an intel
82541 gigabit controller in one of its PCI slot but it malfunctioned.
If I ping from another machine, replies got dropped, delayed in
seconds, dupped and/or corrupted.

  As the last 1gig of memory lived above 4G barrier, I suspected
addressing problem and booted with mem=4G.  Then, it worked fine.  I
verified again with Adaptec 29160 SCSI controller.  Without mem=4G,
data corruption occurred and sometimes probing went wrong with lots of
messages similar to the following.

scsi: host 4 channel 0 id 1 lun 0xffffffffffffffff has a LUN larger than currently supported.

 I believe the problem is with the PCI bridge on the chipset as the
ethernet controller living on the chipset, which doesn't go throught
the PCI bridge, has no problem accessing memories over 4G.

 The following patchset

 a. implements dma_broken_dac() in arch/i386/quirks.c which takes a
    device and returns whether any ancestor of the device is in
    bridges_with_broken_dac pci ID list, which currently contains only
    CK804 PCI bridge.

 b. adds dma_broken_dac() check to dma_supported() functions of i386
    and x86_64 thus failing 64bit pci_set_dma_mask for devices hanging
    off bridges with broken DAC support.

 arch/i386/kernel/quirks.c was chosen as the test is needed by both
i386 and x86_64.  I didn't know where to put the prototype and put it
right above its usage for i386 and in asm-x86_64/proto.h for x86_64.
Please let me know if there are better places.

 With these patches applied, my machine reports like the following on
boot and the e1000 and aic79xx work fine.

PCI 0000:05:06.0: bridge 0000:00:09.0 has broken DAC support, 64bit DMA disabled

 Thanks.

[ Start of patch descriptions ]

01_i386_and_x86_64_implement-dma_broken_dac.patch
	: implement dma_broken_dac() test for i386 and x86_64

	CK804 PCI bridge fails to forward DAC commands from the
	secondary bus to the primary, which is required by PCI
	specification from ver1.1.  This patch implements
	dma_broken_dac() which tests whether there is any such bridge
	among parents of a given device.

02_i386_and_x86_64_add-broken-dac-check-to-i386.patch
	: check broken_dac to i386 dma_supported()

	check for broken_dac in i386 dma_supported() routine.  This
	disables 64-bit DMA for devices hanging off broken bridges.

03_i386_and_x86_64_add-broken-dac-check-to-x86_64.patch
	: check broken_dac to x86_64 dma_supported()

	check for broken_dac in x86-64 dma_supported() routine.  This
	disables 64-bit DMA for devices hanging off broken bridges.

[ End of patch descriptions ]

 Details regarding the machine.

 a. Memory configuration.

 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)


 b. lspci -vt

-[00]-+-00.0  nVidia Corporation CK804 Memory Controller
      +-01.0  nVidia Corporation CK804 ISA Bridge
      +-01.1  nVidia Corporation CK804 SMBus
      +-02.0  nVidia Corporation CK804 USB Controller
      +-02.1  nVidia Corporation CK804 USB Controller
      +-04.0  nVidia Corporation CK804 AC'97 Audio Controller
      +-06.0  nVidia Corporation CK804 IDE
      +-07.0  nVidia Corporation CK804 Serial ATA Controller
      +-08.0  nVidia Corporation CK804 Serial ATA Controller
      +-09.0-[05]--+-06.0  Intel Corporation 82541GI/PI Gigabit Ethernet Controller
      |            +-07.0  VIA Technologies Inc. VT1720/24 [Envy24PT/HT] PCI Multi-Channel Audio Controller
      |            \-08.0  Timedia Technology Co Ltd PCI2S550 (Dual 16550 UART)
      +-0a.0  nVidia Corporation CK804 Ethernet Controller
      +-0b.0-[04]--
      +-0c.0-[03]--
      +-0d.0-[02]--
      +-0e.0-[01]----00.0  nVidia Corporation GeForce 6200 TurboCache(TM)
      +-18.0  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
      +-18.1  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
      +-18.2  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
      \-18.3  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control


 c. lspci -nvvv

0000:00:00.0 0580: 10de:005e (rev a3)
	Subsystem: 1043:815a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [44] #08 [01e0]
	Capabilities: [e0] #08 [a801]

0000:00:01.0 0601: 10de:0050 (rev a3)
	Subsystem: 1043:815a
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:01.1 0c05: 10de:0052 (rev a2)
	Subsystem: 1043:815a
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e400 [size=32]
	Region 4: I/O ports at 4c00 [size=64]
	Region 5: I/O ports at 4c40 [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 0c03: 10de:005a (rev a2) (prog-if 10)
	Subsystem: 1043:815a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at d5004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 0c03: 10de:005b (rev a3) (prog-if 20)
	Subsystem: 1043:815a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 19
	Region 0: Memory at feb00000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2098]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 0401: 10de:0059 (rev a2)
	Subsystem: 1043:812a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at e000 [size=256]
	Region 2: Memory at d5003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.0 0101: 10de:0053 (rev f2) (prog-if 8a [Master SecP PriP])
	Subsystem: 1043:815a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 0101: 10de:0054 (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: 1043:815a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 09f0 [size=8]
	Region 1: I/O ports at 0bf0 [size=4]
	Region 2: I/O ports at 0970 [size=8]
	Region 3: I/O ports at 0b70 [size=4]
	Region 4: I/O ports at d800 [size=16]
	Region 5: Memory at d5002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 0101: 10de:0055 (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: 1043:815a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 09e0 [size=8]
	Region 1: I/O ports at 0be0 [size=4]
	Region 2: I/O ports at 0960 [size=8]
	Region 3: I/O ports at 0b60 [size=4]
	Region 4: I/O ports at c400 [size=16]
	Region 5: Memory at d5001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 0604: 10de:005c (rev a2) (prog-if 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=128
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: d3000000-d4ffffff
	Prefetchable memory behind bridge: d5100000-d51fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:0a.0 0680: 10de:0057 (rev a3)
	Subsystem: 1043:8141
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at d5000000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at b000 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

0000:00:0b.0 0604: 10de:005d (rev a3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]

0000:00:0c.0 0604: 10de:005d (rev a3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]

0000:00:0d.0 0604: 10de:005d (rev a3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]

0000:00:0e.0 0604: 10de:005d (rev a3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d0000000-d2ffffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000cff00000
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]

0000:00:18.0 0600: 1022:1100
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]

0000:00:18.1 0600: 1022:1101
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 0600: 1022:1102
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 0600: 1022:1103
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:01:00.0 0300: 10de:0161 (rev a1)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at d1000000 (64-bit, non-prefetchable) [size=16M]
	Expansion ROM at d2000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] #10 [0001]

0000:05:06.0 0200: 8086:1076
	Subsystem: 8086:1113
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63750ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at d4020000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at d4000000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at a000 [size=64]
	Expansion ROM at d5100000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=0, RSCEM-
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

0000:05:07.0 0401: 1412:1724 (rev 01)
	Subsystem: 1412:1724
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at a400 [size=32]
	Region 1: I/O ports at a800 [size=128]
	Capabilities: [80] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:05:08.0 0700: 1409:7168 (rev 01) (prog-if 02)
	Subsystem: 1409:0002
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at ac00 [size=32]

