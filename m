Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283782AbRLEF0T>; Wed, 5 Dec 2001 00:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283783AbRLEF0O>; Wed, 5 Dec 2001 00:26:14 -0500
Received: from mtiwmhc22.worldnet.att.net ([204.127.131.47]:17094 "EHLO
	mtiwmhc22.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S283782AbRLEFZz>; Wed, 5 Dec 2001 00:25:55 -0500
Subject: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
From: Cory Bell <cory.bell@usa.net>
To: linux-kernel@vger.kernel.org
Cc: mj@ucw.cz, john@deater.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 04 Dec 2001 21:16:53 -0800
Message-Id: <1007529416.2339.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me with responses, as I am not subscribed to the list. Any
help or pointers are greatly appreciated!

I'm having trouble with the USB function of my laptop (2.4.16 kernel).
The PCI BIOS config space indicates PIN A, IRQ 9, and apparently, so
does the PIRQ table. However, the mask for the device allows only IRQ
11. Using the patch below (shamelessly stolen from John Clemens and
modified slightly -
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0111.2/0005.html), I
was able to get USB working by forcing anything showing up as IRQ 9 to
IRQ 11 (according to the PIRQ, IRQ 9 ian't usable anyway on my machine).
Obviously, this is evil, but at least it works. Also, the IDE IRQ seems
to be unrouted, but it works fine. The USB adapter is PCI device 00:02.0
USB Controller: Acer Laboratories Inc. [ALi] M5237 USB. Interestingly,
the PIRQ "Link" of the USB device is 0x59, all the others are 0x00-0x03.

What I'm wondering is - what's broken?
Is it:
1) Bad BIOS? (changing the date is as configurable as it gets - and I
have updated to the latest available version)
2) Bad Linux interperetation of ALi IRQ router? (comments in
linux/arch/i386/kernel/pci-irq.c seem to suggest it's possible)
3) Bad Hardware?
4) Bad Karma?

Is there a "correct" way to fix this? Info follows. If anyone would like
additional info (full dmesg output, etc) I'd be happy to email it
seperately.

-Cory Bell

the (very ugly, I know) patch:
--- linux/arch/i386/kernel/pci-irq.c.dist	Sun Nov  4 09:31:58 2001
+++ linux/arch/i386/kernel/pci-irq.c	Tue Dec  4 16:31:56 2001
@@ -583,6 +583,9 @@
 	}
 	DBG(" -> newirq=%d", newirq);
 
+	if (r->get(pirq_router_dev, dev, pirq) == 9) {
+		r->set(pirq_router_dev, dev, pirq, newirq);
+	}
 	/* Check if it is hardcoded */
 	if ((pirq & 0xf0) == 0xf0) {
 		irq = pirq & 0xf;
@@ -674,6 +677,10 @@
 			DBG("%s: ignoring bogus IRQ %d\n", dev->slot_name, dev->irq);
 			dev->irq = 0;
 		}
+		if (dev->irq == 9) {
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 0x0b);
+			dev->irq=11;
+		}
 		/* If the IRQ is already assigned to a PCI device, ignore its ISA use penalty */
 		if (pirq_penalty[dev->irq] >= 100 && pirq_penalty[dev->irq] < 100000)
 			pirq_penalty[dev->irq] = 0;

dmesg snippets (after patch applied):
PCI: BIOS32 Service Directory structure at 0xc00f7ea0
PCI: BIOS32 Service Directory entry at 0xfd792
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfd8b0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:0f.0
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdf40
00:0f slot=00 0:00/4000 1:00/8000 2:00/def8 3:00/def8
00:02 slot=00 0:59/0800 1:00/def8 2:00/def8 3:00/def8
00:08 slot=01 0:03/0020 1:00/def8 2:00/def8 3:00/def8
00:04 slot=00 0:01/0800 1:02/0800 2:00/def8 3:00/def8
00:10 slot=00 0:02/0800 1:00/def8 2:00/def8 3:00/def8
00:07 slot=00 0:01/def8 1:02/def8 2:03/def8 3:04/def8
00:01 slot=00 0:01/0800 1:00/def8 2:00/def8 3:00/def8
01:00 slot=00 0:01/0800 1:00/def8 2:00/def8 3:00/def8
PCI: Attempting to find IRQ router for 10b9:1533
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
PCI: IRQ fixup
00:0f.0: ignoring bogus IRQ 255
IRQ for 00:0f.0:0 -> not routed
...
IRQ for 00:02.0:0 -> PIRQ 59, mask 0800, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 00:02.0
usb-ohci.c: USB OHCI at membase 0xd08b6000, IRQ 11
usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] M5237 USB

without the patch, the above chunk looks like:
IRQ for 00:02.0:0 -> PIRQ 59, mask 0800, excl 0000 -> newirq=9 -> got IRQ 9
PCI: Found IRQ 9 for device 00:02.0
usb-ohci.c: USB OHCI at membase 0xd08b6000, IRQ 9
usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] M5237 USB

dump_pirq:
Interrupt routing table found at address 0xfdf40:
  Version 1.0, size 0x00a0
  Interrupt router is device 00:07.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x10b9 device 0x1533

Device 00:0f.0 (slot 0): IDE interface

Device 00:02.0 (slot 0): USB Controller
  INTA: link 0x59, irq mask 0x0800 [11]

Device 00:08.0 (slot 1): Multimedia audio controller
  INTA: link 0x03, irq mask 0x0020 [5]

Device 00:04.0 (slot 0): CardBus bridge
  INTA: link 0x01, irq mask 0x0800 [11]
  INTB: link 0x02, irq mask 0x0800 [11]

Device 00:10.0 (slot 0): Ethernet controller
  INTA: link 0x02, irq mask 0x0800 [11]

Device 00:07.0 (slot 0): ISA bridge
  INTA: link 0x01, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTB: link 0x02, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTC: link 0x03, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTD: link 0x04, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]

Device 00:01.0 (slot 0): PCI bridge
  INTA: link 0x01, irq mask 0x0800 [11]

Device 01:00.0 (slot 0): VGA compatible controller
  INTA: link 0x01, irq mask 0x0800 [11]

Interrupt router at 00:07.0: AcerLabs Aladdin M1533 PCI-to-ISA bridge
  INT1 (link 1): irq 11
  INT2 (link 2): irq 11
  INT3 (link 3): irq 5
  INT4 (link 4): unrouted
  INT5 (link 5): unrouted
  INT6 (link 6): unrouted
  INT7 (link 7): unrouted
  INT8 (link 8): unrouted
  Serial IRQ: [enabled] [quiet] [frame=21] [pulse=12]

lspci -vvvx (after patch):
00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1647 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [b0] AGP version 2.0
		Status: RQ=27 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [a4] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 47 16 07 00 10 a2 04 00 00 06 00 00 00 00
10: 08 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 b0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e8100000-edffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: b9 10 47 52 1f 00 00 04 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 a2
20: 10 e8 f0 ed f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fff70000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 37 52 17 00 90 02 03 10 03 0c 08 10 00 00
10: 00 00 f7 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 50

00:04.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Hewlett-Packard Company: Unknown device 0018
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 51 ac 07 00 10 02 00 00 07 06 10 a8 82 00
10: 00 00 00 10 a0 00 00 02 00 02 05 b0 00 00 40 10
20: 00 f0 7f 10 00 00 80 10 00 f0 bf 10 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 0b 01 c0 05
40: 3c 10 18 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Hewlett-Packard Company: Unknown device 0018
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 51 ac 07 00 10 02 00 00 07 06 10 a8 82 00
10: 00 10 00 10 a0 00 00 02 00 06 09 b0 00 00 c0 10
20: 00 f0 ff 10 00 00 00 11 00 f0 3f 11 00 48 00 00
30: fc 48 00 00 00 4c 00 00 fc 4c 00 00 0b 01 c0 05
40: 3c 10 18 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 01 71
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 33 15
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
	Subsystem: Hewlett-Packard Company: Unknown device 0018
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 8400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5d 12 88 19 05 00 90 02 12 00 01 04 00 40 80 00
10: 01 84 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 18 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 01 02 18

00:08.1 Communication controller: ESS Technology ESS Modem (rev 12)
	Subsystem: Hewlett-Packard Company: Unknown device 0018
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 8800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=100mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
00: 5d 12 89 19 01 00 90 02 12 00 80 07 00 00 80 00
10: 01 88 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 18 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 01 00 00

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Laboratories Inc. [ALi] M5229 IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 1000 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 29 52 05 00 90 02 c4 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 10 00 00 00 00 00 00 00 00 00 00 b9 10 29 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 ff 01 02 04

00:10.0 Ethernet controller: Accton Technology Corporation: Unknown device 1216 (rev 11)
	Subsystem: Accton Technology Corporation: Unknown device 2242
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 8c00 [size=256]
	Region 1: Memory at e8001000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 13 11 16 12 13 00 90 02 11 00 00 02 08 40 00 00
10: 01 8c 00 00 00 10 00 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 13 11 42 22
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 01 ff ff

01:00.0 VGA compatible controller: Trident Microsystems: Unknown device 9910 (rev 63) (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0018
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at e8400000 (32-bit, non-prefetchable) [size=4M]
	Region 2: Memory at ea000000 (32-bit, non-prefetchable) [size=32M]
	Region 3: Memory at e8100000 (32-bit, non-prefetchable) [size=32K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [80] AGP version 2.0
		Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [90] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 23 10 10 99 07 00 30 02 63 00 00 03 00 40 00 00
10: 00 00 00 ec 00 00 40 e8 00 00 00 ea 00 00 10 e8
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 18 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 01 00 00

lspci -vvvx -s 00:02.0 (before patch):
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at fff70000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 37 52 17 00 90 02 03 10 03 0c 08 10 00 00
10: 00 00 f7 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 09 01 00 50

