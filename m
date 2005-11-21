Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVKUPKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVKUPKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVKUPKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:10:39 -0500
Received: from main.gmane.org ([80.91.229.2]:27099 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932258AbVKUPKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:10:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jani Monoses <jani.monoses@gmail.com>
Subject: softlockup on boot with kernel >2.6.12
Date: Mon, 21 Nov 2005 16:58:33 +0200
Message-ID: <dlsnaq$o5v$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050502000001020500040604"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: home03207.cluj.astral.ro
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050502000001020500040604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On an HP Nx8220 laptop current kernels fail to boot. It prints

PCI: Cannot allocate resource region 7 of  bridge
and two similar lines for region 8 and 9. This fails in pci/i386.c
because r->start == 0.

These are the last messages before the softlockup timeout kicks in and
shows that the IP is in strstr() inside acpi_match_ids().

I attach a lspci -vvv, the troubled bridge is 0:1c.1 the one with memory
starting at 0.

The same behaviour is in 2.6.14, while 2.6.13 fails there but with a
different and more verbose PCI IRQ collision message layout.

With git bisect I got to commit 3fb02738b0fd36f47710a2bf207129efd2f5daa2
as the one between 2.6.12 and 2.6.13 as the first non-booting kernel.

thanks
Jani

--------------050502000001020500040604
Content-Type: text/plain;
 name=",l"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=",l"

0000:00:00.0 Host bridge: Intel Corp. Mobile Memory Controller Hub (rev 03)
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corp. Mobile Memory Controller Hub PCI Express Port (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: c8800000-c8bfffff
	Prefetchable memory behind bridge: c0000000-c7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=10, subordinate=10, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: c8000000-c83fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:1c.1 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=20, subordinate=20, sec-latency=0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00000000-000fffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at 3000 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 3020 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at 3040 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at c8c00000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: c8400000-c87fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:1e.2 Multimedia audio controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at 3100 [size=256]
	Region 1: I/O ports at 3200 [size=64]
	Region 2: Memory at c8c01000 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at c8c02000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:1e.3 Modem: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 22
	Region 0: I/O ports at 3400 [size=256]
	Region 1: I/O ports at 3500 [size=128]
	Capabilities: <available only to root>

0000:00:1f.0 ISA bridge: Intel Corp. 82801FBM (ICH6M) LPC Interface Bridge (rev 03)
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 3580 [size=16]

0000:01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 3150 (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at c8800000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

0000:02:04.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
	Subsystem: Hewlett-Packard Company: Unknown device 12f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 6000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at c8400000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:02:06.0 CardBus bridge: Texas Instruments: Unknown device 8031
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x20 (128 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at c8401000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 20000000-203ff000 (prefetchable)
	Memory window 1: 20400000-207ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:02:06.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8032 (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at c8402000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at c8404000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>

0000:02:06.3 Unknown mass storage controller: Texas Instruments: Unknown device 8033
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1750ns min, 1000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at c8408000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: <available only to root>

0000:02:06.4 0805: Texas Instruments: Unknown device 8034
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1750ns min, 1000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at c840a000 (32-bit, non-prefetchable) [size=256]
	Region 1: Memory at c840b000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at c840c000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:02:06.5 Communication controller: Texas Instruments: Unknown device 8035
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c840d000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at c840e000 (32-bit, non-prefetchable) [size=4K]
	Region 2: Memory at c840f000 (32-bit, non-prefetchable) [size=4K]
	Region 3: Memory at c8410000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:10:00.0 Ethernet controller: Broadcom Corporation: Unknown device 167d (rev 11)
	Subsystem: Hewlett-Packard Company: Unknown device 0934
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at c8000000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>


--------------050502000001020500040604--

