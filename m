Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWJSIhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWJSIhg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 04:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWJSIhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 04:37:35 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40101
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030319AbWJSIhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 04:37:34 -0400
Date: Thu, 19 Oct 2006 01:37:32 -0700 (PDT)
Message-Id: <20061019.013732.30184567.davem@davemloft.net>
To: eiichiro.oiwa.nm@hitachi.com
Cc: alan@redhat.com, jesse.barnes@intel.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: pci_fixup_video change blows up on sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9002705U45372f1d@hitachi.com>
References: <20061018.233102.74754142.davem@davemloft.net>
	<XNM1$9$0$4$$3$3$7$A$9002705U45372f1d@hitachi.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: <eiichiro.oiwa.nm@hitachi.com>
Date: Thu, 19 Oct 2006 16:54:19 +0900

> Does ATI Radeon card have an expansion ROM (video ROM)?

The video card has a PCI expansion ROM.

> Could you show me "lspci -vv" on sparc64?

Attached below.

> If an expansion ROM exists on ATI Radeon or ATY128 card, pci_map_rom returns
> the expansion ROM base address instead of 0xC0000 because fixup_video checks
> the VGA Enable bit in the Bridge Control register.

It is not valid to expect the bridge control register to return
anything meaningful on PCI "host bridge".  The Radeon card here sits
on the root, just under the PCI Host Controller.  The code in
fixup_video appears to assume that every bus up to the root from
the VGA device is a PCI-PCI bridge, which is not a valid assumption.
There can be a PCI host bridge at the root.

Also, and more importantly, you cannot use the 0xc0000 address in a
raw way like this.  There are multiple PCI domains possible in a
given system, and the 0xc0000 address you wish to use must be relative
to that PCI domain.

Therefore, in the presence of multiple PCI domains:

	x = ioremap(0xc0000, ...);

doesn't make any sense, is extremely non-portable, and will crash
on many non-x86 systems.

ioremap()'s first argument is an IO address "cookie" and therefore
using fixed constants for it can never work properly.  It must be
created by the platform specific code, and usually this occurs via PCI
resource computation at PCI probe time.  There are portable ways
defined to do this kind of thing, for example with the
pcibios_bus_to_resource() interface, used by routines such as
drivers/pci/quirks.c:quirk_io_region().

All of this pci_fixup_video code was perfectly fine when it was only
used on x86, where assumptions like this happened to work, but it is
not possible to continue making these assumptions if this code will
now run on every single architecture.

Here is the lspci output:

0000:00:00.0 Host bridge: Sun Microsystems Computer Corp. Tomatillo PCI Bus Module
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Interrupt: pin ? routed to IRQ 1

0000:00:02.0 PCI bridge: Texas Instruments PCI2250 PCI-to-PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: 03000000-030fffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X Gigabit Ethernet (rev 02)
	Subsystem: Broadcom Corporation NetXtreme BCM5703 1000Base-T
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at 000007ff00110000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at 0000000000120000 [disabled] [size=64K]
	Capabilities: [40] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=255 Dev=31 Func=1 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=1, RSCEM-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 6ffffffffffffffc  Data: fffd

0000:00:05.0 Ethernet controller: Intel Corporation 82544EI Gigabit Ethernet Controller (Copper) (rev 02)
	Subsystem: Intel Corporation PRO/1000 XT Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at 000007ff00140000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at 000007ff00160000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 1000a40 [size=32]
	Expansion ROM at 0000000000180000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=1, RSCEM-
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

0000:00:06.0 Non-VGA unclassified device: ALi Corporation M7101 Power Management Controller [PMU]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: ALi Corporation HP Compaq nc4010 (DY885AA#ABN)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at 1000900 [size=256]
	Region 1: Memory at 000007ff00100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 13
	Region 0: Memory at 000007ff01000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 14
	Region 0: Memory at 000007ff02000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0d.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if ff)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 1000a00 [size=8]
	Region 1: I/O ports at 1000a18 [size=4]
	Region 2: I/O ports at 1000a10 [size=8]
	Region 3: I/O ports at 1000a08 [size=4]
	Region 4: I/O ports at 1000a20 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:08.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: Risq Modular Systems, Inc.: Unknown device 0035
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at 000007ff03000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:08.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: Risq Modular Systems, Inc.: Unknown device 0035
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at 000007ff03002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:08.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Risq Modular Systems, Inc.: Unknown device 00e0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at 000007ff03004000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Risq Modular Systems, Inc.: Unknown device 8024
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at 000007ff03006000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at 000007ff03008000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0001:00:00.0 Host bridge: Sun Microsystems Computer Corp. Tomatillo PCI Bus Module
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Interrupt: pin ? routed to IRQ 22

0001:00:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703 Gigabit Ethernet
	Subsystem: Broadcom Corporation NetXtreme BCM5703 Gigabit Ethernet
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at 000007f700200000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=255 Dev=31 Func=1 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=1, RSCEM-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: dfdfefefdfbffffc  Data: fffe

0001:00:03.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0908
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at 000007f708000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 1000300 [size=256]
	Region 2: Memory at 000007f700100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at 0000000000120000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


