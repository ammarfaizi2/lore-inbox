Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWHRMjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWHRMjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWHRMjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:39:31 -0400
Received: from boogie.lpds.sztaki.hu ([193.224.70.237]:54931 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S932086AbWHRMj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:39:29 -0400
Date: Fri, 18 Aug 2006 14:39:27 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: "irq 17: nobody cared" killed my machine (libata, usb, 8139too)
Message-ID: <20060818123927.GA4149@boogie.lpds.sztaki.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A couple of minutes ago I had a crash due to "irq 17: nobody cared".
Stack trace copied using pen+paper method:

	report_bad_irq+0x36/0x7d
	note_interrupt+0x18e/0x16f
	handle_IRQ_event+0x23/0x4c
	__do_IRQ+0xa5/0xd5
	__do_IRQ+0x19/0x24
	common_interrupt+0x1a/0x20
	default_idle+0x0/0x55
	default_idle+0x2c/0x55
	cpu_udle+0x59/0x6e
	start_kernel+0x368/0x370
	unknown_bootparam+0x0/0x204

	handlers:
		ata_interrupt+0x0/0x137
		usb_hcd_interrupt+0x0/0x50 [usbcore]
		rtl_interrupt+0x0/0x3ba [8139too]
	Disabling IRQ #17

Kernel is 2.6.17 with ATA_ENABLE_PATA enabled. It's been running for
nearly two months now without any problems previously; before that I ran
2.6.16 + ATA_ENABLE_PATA also without problems.

Now, that "Disabling IRQ #17" line meant I lost all my disks. AFAIK
there was some talk about not disabling the interrupt in such
situations; will that be part of 2.6.18?

At the time of the crash, there was some disk activity, so libata may be
responsible for the spurious IRQ. The rtl8139 interface is configured
but had no cable connected so it is unlikely to be the cause. The usb4
port bound to irq 17 did not have any devices connected.

Gabor

# cat /proc/interrupts
           CPU0       CPU1
  0:     879295          0    IO-APIC-edge  timer
  1:       4519          0    IO-APIC-edge  i8042
  7:          0          0    IO-APIC-edge  parport0
  8:         58          0    IO-APIC-edge  rtc
 14:      99072          0    IO-APIC-edge  libata
 15:          1          0    IO-APIC-edge  libata
 16:      58971          0   IO-APIC-level  uhci_hcd:usb2, uhci_hcd:usb5, radeon@pci:0000:01:00.0
 17:    5019438          0   IO-APIC-level  libata, uhci_hcd:usb4, rtl
 18:          2          0   IO-APIC-level  ehci_hcd:usb1
 19:       3620          0   IO-APIC-level  uhci_hcd:usb3
 20:      11212          0   IO-APIC-level  acpi, mobo
 21:          0          0   IO-APIC-level  Intel ICH5
NMI:          0          0
LOC:     879215     879175
ERR:          0
MIS:          0

# lspci -vvvx
00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7280
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] Vendor Specific Information
	Capabilities: [a0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
00: 86 80 70 25 06 00 90 20 02 00 00 06 00 00 00 00
10: 08 00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 80 72
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: ffc00000-ffcfffff
	Prefetchable memory behind bridge: d7f00000-f7efffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 71 25 07 01 a0 00 02 00 04 06 00 20 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 a0 a0 a0 02
20: c0 ff c0 ff f0 d7 e0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0d 00

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at cc00 [size=32]
00: 86 80 d2 24 05 00 80 02 02 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 cc 00 00 00 00 00 00 00 00 00 00 62 14 80 72
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at d000 [size=32]
00: 86 80 d4 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 62 14 80 72
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 17
	Region 4: I/O ports at d400 [size=32]
00: 86 80 d7 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 62 14 80 72
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 03 00 00

00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at d800 [size=32]
00: 86 80 de 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d8 00 00 00 00 00 00 00 00 00 00 62 14 80 72
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 18
	Region 0: Memory at ffeff800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port
00: 86 80 dd 24 06 00 90 02 02 20 03 0c 00 00 00 00
10: 00 f8 ef ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 80 72
30: 00 00 00 00 50 00 00 00 00 00 00 00 0c 04 00 00

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: ffd00000-ffdfffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
00: 86 80 4e 24 07 01 80 80 c2 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 20 b0 b0 80 02
20: d0 ff d0 ff f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 00

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 d0 24 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at ec00 [size=8]
	Region 1: I/O ports at e800 [size=4]
	Region 2: I/O ports at e400 [size=8]
	Region 3: I/O ports at e000 [size=4]
	Region 4: I/O ports at dc00 [size=16]
	Region 5: Memory at 50000000 (32-bit, non-prefetchable) [size=1K]
00: 86 80 db 24 07 00 80 02 02 8f 01 01 00 00 00 00
10: 01 ec 00 00 01 e8 00 00 01 e4 00 00 01 e0 00 00
20: 01 dc 00 00 00 00 00 50 00 00 00 00 62 14 80 72
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corporation 82801EB (ICH5) SATA Controller
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=16]
00: 86 80 d1 24 05 00 a0 02 02 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 01 fc 00 00 00 00 00 00 00 00 00 00 86 80 d1 24
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 0c00 [size=32]
00: 86 80 d3 24 01 00 80 02 02 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 0c 00 00 00 00 00 00 00 00 00 00 62 14 80 72
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 0: I/O ports at c800 [size=256]
	Region 1: I/O ports at c400 [size=64]
	Region 2: Memory at ffeff600 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at ffeff500 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 d5 24 07 00 90 02 02 00 01 04 00 00 00 00
10: 01 c8 00 00 01 c4 00 00 00 f6 ef ff 00 f5 ef ff
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 80 72
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
	Subsystem: PC Partner Limited Unknown device 7c26
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at a800 [size=256]
	Region 2: Memory at ffcf0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at ffcc0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 64 59 07 00 b0 02 01 00 00 03 08 20 80 00
10: 08 00 00 e8 01 a8 00 00 00 00 cf ff 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 26 7c
30: 00 00 cc ff 58 00 00 00 00 00 00 00 0b 01 08 00

01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)
	Subsystem: PC Partner Limited Unknown device 7c27
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size: 32 bytes
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at ffce0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 44 5d 07 00 b0 02 01 00 80 03 08 20 00 00
10: 08 00 00 e0 00 00 ce ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 27 7c
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 08 00

02:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Compex FN22-3(A) LinxPRO Ethernet Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at bc00 [size=256]
	Region 1: Memory at ffdfff00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 20 00 00
10: 01 bc 00 00 00 ff df ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f6 11 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 20 40

02:08.0 Ethernet controller: Intel Corporation 82562EZ 10/100 Ethernet Controller (rev 02)
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at ffdfe000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at b800 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 50 10 17 00 90 02 02 00 00 02 08 20 00 00
10: 00 e0 df ff 01 b8 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 8c 72
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 08 38

# dmesg
Linux version 2.6.17libata (gombasg@boogie) (gcc version 4.1.2 20060613 (prerelease) (Debian 4.1.1-5)) #3 SMP Wed Jun 21 17:32:54 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fba30
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000f9e70
ACPI: RSDT (v001 AMIINT INTEL865 0x00000010 MSFT 0x00000097) @ 0x3fff0000
ACPI: FADT (v001 AMIINT INTEL865 0x00000011 MSFT 0x00000097) @ 0x3fff0030
ACPI: MADT (v001 AMIINT INTEL865 0x00000009 MSFT 0x00000097) @ 0x3fff00c0
ACPI: DSDT (v001  INTEL    I865G 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 20 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=l2617 ro root=900 video=radeonfb:1024x768-16@60 resume=/dev/hda7
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2434.629 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035760k/1048512k available (1670k kernel code, 12116k reserved, 886k data, 180k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4871.35 BogoMIPS (lpj=2435679)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 16k freed
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4867.57 BogoMIPS (lpj=2433788)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Total of 2 processors activated (9738.93 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=2000
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=2
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0400-043f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.ICHB._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 *12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: a000-afff
  MEM window: ffc00000-ffcfffff
  PREFETCH window: d7f00000-f7efffff
PCI: Bridge: 0000:00:1e.0
  IO window: b000-bfff
  MEM window: ffd00000-ffdfffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1155903030.813:1): initialized
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=200.00 Mhz, System=166.00 MHz
radeonfb: PLL min 20000 max 40000
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 128x48
radeonfb (0000:01:00.0): ATI Radeon Yd 
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Processor [CPU2] (supports 8 throttling states)
Real Time Clock Driver v1.12ac
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
libata version 1.20 loaded.
ata_piix 0000:00:1f.1: version 1.05
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 17
ata2: PATA max UDMA/100 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 17
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4003 85:3469 86:3e01 87:4003 88:203f
ata1: dev 0 ATA-7, max UDMA/100, 312581808 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 1 cfg 49:0f00 82:4218 83:4000 84:4000 85:4218 86:0000 87:4000 88:0407
ata2: dev 1 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
ata2: dev 1 configured for UDMA/33
scsi1 : ata_piix
  Vendor: ATA       Model: SAMSUNG SP1634N   Rev: UZ10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: MATSHITA  Model: DVD-ROM SR-8587   Rev: 5X35
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: SAMSUNG   Model: CD-R/RW SW-252B   Rev: R701
  Type:   CD-ROM                             ANSI SCSI revision: 05
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata3: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
ata3: dev 0 cfg 49:2f00 82:7069 83:7c01 84:4023 85:7069 86:3c01 87:4023 88:203f
ata3: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : ata_piix
  Vendor: ATA       Model: WDC WD800JD-60LS  Rev: 07.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata4: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
ata4: SATA port has no device.
scsi3 : ata_piix
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 sdb9 >
sd 2:0:0:0: Attached scsi disk sdb
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb9 ...
md:  adding sdb9 ...
md: sdb8 has different UUID to sdb9
md: sdb6 has different UUID to sdb9
md: sdb5 has different UUID to sdb9
md: sdb1 has different UUID to sdb9
md:  adding sda9 ...
md: sda8 has different UUID to sdb9
md: sda6 has different UUID to sdb9
md: sda5 has different UUID to sdb9
md: sda1 has different UUID to sdb9
md: created md5
md: bind<sda9>
md: bind<sdb9>
md: running: <sdb9><sda9>
md: md5: raid array is not clean -- starting background reconstruction
raid1: raid set md5 active with 2 out of 2 mirrors
md: considering sdb8 ...
md: syncing RAID array md5
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for reconstruction.
md: using 128k window, over a total of 44708736 blocks.
md: resuming recovery of md5 from checkpoint.
md:  adding sdb8 ...
md: sdb6 has different UUID to sdb8
md: sdb5 has different UUID to sdb8
md: sdb1 has different UUID to sdb8
md:  adding sda8 ...
md: sda6 has different UUID to sdb8
md: sda5 has different UUID to sdb8
md: sda1 has different UUID to sdb8
input: AT Translated Set 2 keyboard as /class/input/input0
md: created md4
md: bind<sda8>
md: bind<sdb8>
md: running: <sdb8><sda8>
md4: setting max_sectors to 256, segment boundary to 65535
raid0: looking at sdb8
raid0:   comparing sdb8(14651136) with sdb8(14651136)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda8
raid0:   comparing sda8(14651136) with sdb8(14651136)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 29302272 blocks.
raid0 : conf->hash_spacing is 29302272 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: considering sdb6 ...
md:  adding sdb6 ...
md: sdb5 has different UUID to sdb6
md: sdb1 has different UUID to sdb6
md:  adding sda6 ...
md: sda5 has different UUID to sdb6
md: sda1 has different UUID to sdb6
md: created md2
md: bind<sda6>
md: bind<sdb6>
md: running: <sdb6><sda6>
md: md2: raid array is not clean -- starting background reconstruction
raid1: raid set md2 active with 2 out of 2 mirrors
md: considering sdb5 ...
md: delaying resync of md2 until md5 has finished resync (they share one or more physical units)
md:  adding sdb5 ...
md: sdb1 has different UUID to sdb5
md:  adding sda5 ...
md: sda1 has different UUID to sdb5
md: created md1
md: bind<sda5>
md: bind<sdb5>
md: running: <sdb5><sda5>
raid1: raid set md1 active with 2 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
md: md0: raid array is not clean -- starting background reconstruction
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
md: delaying resync of md0 until md5 has finished resync (they share one or more physical units)
md: delaying resync of md2 until md5 has finished resync (they share one or more physical units)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 180k freed
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 20
e100: eth0: e100_probe: addr 0xffdfe000, irq 20, MAC addr 00:0C:76:1F:FE:47
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 18 (level, low) -> IRQ 17
eth1: RealTek RTL8139 at 0xf881cf00, 00:c1:28:01:d5:f6, IRQ 17
eth1:  Identified 8139 chip type 'RTL-8139C'
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
FDC 0 is a post-1991 82077
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 18, io mem 0xffeff800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
sr1: scsi3-mmc drive: 52x/52x writer cd/rw xa/form2 cdda tray
sr 1:0:1:0: Attached scsi CD-ROM sr1
hw_random: RNG not detected
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:0:0: Attached scsi generic sg1 type 5
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000cc00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
sr 1:0:1:0: Attached scsi generic sg2 type 5
sd 2:0:0:0: Attached scsi generic sg3 type 0
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000d000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 17, io base 0x0000d400
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000d800
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 3-2: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1f.5 to 64
usb 3-2: configuration #1 chosen from 1 choice
input: Microsoft Microsoft 3-Button Mouse with IntelliEye(TM) as /class/input/input1
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)] on usb-0000:00:1d.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
intel8x0_measure_ac97_clock: measured 51533 usecs
intel8x0: clocking to 48000
Adding 2008084k swap on /dev/sda7.  Priority:-1 extents:1 across:2008084k
Adding 2008084k swap on /dev/sdb7.  Priority:-2 extents:1 across:2008084k
EXT3 FS on md0, internal journal
i2c /dev entries driver
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hw_random: RNG not detected
NET: Registered protocol family 15
ip_tables: (C) 2000-2006 Netfilter Core Team
rtl: link down
e100: mobo: e100_watchdog: link up, 100Mbps, full-duplex

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
