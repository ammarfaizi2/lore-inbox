Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbRC3ABR>; Thu, 29 Mar 2001 19:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129478AbRC3AA6>; Thu, 29 Mar 2001 19:00:58 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:44263 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S129466AbRC3AAx>; Thu, 29 Mar 2001 19:00:53 -0500
Date: Fri, 30 Mar 2001 01:59:46 +0200
To: linux-kernel@vger.kernel.org
Subject: IRQ routing conflict & ressource assignment on Thinkpad
Message-ID: <20010330015945.A4206@storm.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something that was itching me for a while (and I had a bad conscience
for not reporting a bug for so long):

I have an IBM Thinkpad i1200 (1161-267, Celeron 550, see lspci below).

The PCI code in 2.4 always complains about an IRQ routing conflict wrt
the CardBus controller.  That used to make it crash when hotplug is
configured, since loading the i810 sound module would change the
controller's IRQ, then a inserting a card blows it up.  Doesn't seem to
happen anymore, but the warnings are still there.

Another (possibly related) problem is that the controller does not get
IO resources assigned, so the Tulip driver won't work.  This
specifically happens only with kernel hotplug code, pcmcia-cs modules
3.1.22 work for me.  The IRQ crashes also happened only with kernel
hotplug, the conflict report is always on.

Oh, and sometimes the i810 audio driver can hang the system, games seem
to trigger that, sound output from e.g. mp3 player don't hurt.  But I
don't have much data on that yet.

Following data is collected from the kernel with PCI hotplug configured
in.  If someone needs the .config, please ask.

This is what dump_pirq says:

Interrupt routing table found at address 0xfbdb0:
  Version 1.0, size 0x0070
  Interrupt router is device 00:07.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x8086 device 0x7198

Device 00:02.0 (slot 0): VGA compatible controller
  INTA: link 0x60, irq mask 0x0400 [10]

Device 00:07.0 (slot 0): ISA bridge
  INTD: link 0x63, irq mask 0x0400 [10]

Device 00:06.0 (slot 0): 
  INTA: link 0x62, irq mask 0x8000 [15]

Device 00:03.0 (slot 0): CardBus bridge
  INTA: link 0x61, irq mask 0x0400 [10]
  INTB: link 0x62, irq mask 0x0400 [10]

Device 00:00.0 (slot 0): Host bridge
  INTB: link 0x61, irq mask 0x0800 [11]

Interrupt router at 00:07.0: Intel 82443MX PCI-to-ISA bridge
  PIRQ1 (link 0x60): irq 10
  PIRQ2 (link 0x61): irq 11
  PIRQ3 (link 0x62): unrouted
  PIRQ4 (link 0x63): irq 10
  Serial IRQ: [enabled] [continuous] [frame=21] [pulse=12]
  Level mask: 0x0c00 [10,11]



The relevant lines from dmesg for both problems:

Linux version 2.4.2 (root@merv) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Die Feb 27 21:45:50 CET 2001
[...]
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7198] at 00:07.0
  got res[10000000:10000fff] for resource 0 of O2 Micro, Inc. OZ6812 Cardbus Controller
[...]
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:03.0
PCI: The same IRQ used for device 00:00.1
PCI: The same IRQ used for device 00:00.2
IRQ routing conflict in pirq table for device 00:03.0
Intel PCIC probe: not found.
[...]
Yenta IRQ list 02b8, PCI irq10
Socket status: 30000821
[...]
PCI: Found IRQ 10 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0x8000, IRQ 10
usb-uhci.c: Detected 2 ports
[...]

Removed and reinserted ethernet pccard here:

cs: cb_alloc(bus 1): vendor 0x1011, device 0x0019
PCI: Failed to allocate resource 0 for PCI device 1011:0019
  got res[10800000:108003ff] for resource 1 of PCI device 1011:0019
  got res[10400000:1043ffff] for resource 6 of PCI device 1011:0019
PCI: Enabling device 01:00.0 (0000 -> 0003)
Linux Tulip driver version 0.9.13a (January 20, 2001)
tulip: eth0: I/O region (0x0@0x1000) too small, aborting


And that's lspci -vvv with the ethernet card inserted:

00:00.0 Host bridge: Intel Corporation 82440MX I/O Controller (rev 01)
	Subsystem: IBM: Unknown device 01ab
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 32

00:00.1 Multimedia audio controller: Intel Corporation 82440MX AC'97 Audio Controller
	Subsystem: IBM: Unknown device 01a1
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at 7000 [size=256]
	Region 1: I/O ports at 7400 [size=64]

00:00.2 Modem: Intel Corporation: Unknown device 7196 (prog-if 00 [Generic])
	Subsystem: IBM: Unknown device 01a2
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at 7800 [size=256]
	Region 1: I/O ports at 7c00 [size=128]

00:02.0 VGA compatible controller: Silicon Motion, Inc. SM712 LynxEM+ (rev a0) (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 01a4
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 06000000 (32-bit, non-prefetchable) [size=16M]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 CardBus bridge: O2 Micro, Inc. OZ6812 Cardbus Controller (rev 05)
	Subsystem: IBM: Unknown device 01a3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:07.0 ISA bridge: Intel Corporation 82440MX PCI to ISA Bridge (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82440MX EIDE Controller (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at 8040 [size=16]

00:07.2 USB Controller: Intel Corporation 82440MX USB Universal Host Controller (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at 8000 [size=32]

00:07.3 Bridge: Intel Corporation 82440MX Power Management Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:00.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Abocom Systems Inc: Unknown device ab01
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1000
	Region 1: Memory at 10800000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 10400000 [size=256K]


-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
