Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbSK0CHo>; Tue, 26 Nov 2002 21:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSK0CHo>; Tue, 26 Nov 2002 21:07:44 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:2052 "EHLO
	lap.molina") by vger.kernel.org with ESMTP id <S263977AbSK0CHl>;
	Tue, 26 Nov 2002 21:07:41 -0500
Date: Tue, 26 Nov 2002 20:06:39 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk
Subject: 2.5 problem with SMC2632W adapter
Message-ID: <Pine.LNX.4.44.0211261926230.964-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've previously written about my problems getting the above wireless 
PCMCIA network card working with 2.5.  Since Alan seems to have added some 
network and cardbus changes I tried 2.5.49-ac2.  I'm getting the same 
symptoms.  Thus far, in addition to 2.5.49-ac2 I've tried 2.5.49 (latest 
bk), 2.5.48, 2.5.47, 2.4.18-18.8.0 (RedHat), and 2.4.19.  

Briefly  summarizing my previous message, my system is a Presario 12XL325 
laptop with a PIII-650 cpu.  I'm running RedHat 8.0 on this system with 
addition of mod-init tools v 0.7.  On 2.4.18 and 2.4.19, inserting the 
wireless card generates an event which configures the card and establishes 
a network connection.  None of the 2.5 kernels seems to generates an 
event.  The later ones I understand, but wasn't 47 before the module 
changes?

I've provided what I believe to be relevant information; I'm willing to 
provide additional info and do testing.  I haven't seen anyone else 
complain.  Maybe I'm doing something wrong and someone can give me a clue.

If I manually insert the modules, I get the dmesg output (this is the 
same output for all the versions):

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Assigned IRQ 9 for device 00:0a.0
Yenta IRQ list 0018, PCI irq9
Socket status: 30000010
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x220-0x22f 
0x378-0x37f 0x388-0x38f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
hermes.c: 5 Apr 2002 David Gibson <hermes@gibson.dropbear.id.au>
orinoco.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and 
others)

For the 2.4 kernels I get the following additional output:

divert: allocating divert_blk for eth0
eth0: Station identity 001f:0003:0000:0008
eth0: Looks like an Intersil firmware version 0.08
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:04:E2:2A:29:58
eth0: Station name "Prism  I"
eth0: ready
eth0: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f

and dhclient sets up the routing.  If I build the 2.5 kernels as 
monolithic, I get the additional output in /var/log/messages:

lap kernel: orinoco_cs: RequestIRQ: Resource in use
lap cardmgr[423]: get dev info on socket 0 failed: 
Resource temporarily unavailable

and eth0 is not set up and dhclient obviously won't set up the routing.

lsmod output for an operational set up is:

Module                  Size  Used by    Not tainted
autofs                 11940   0  (autoclean) (unused)
orinoco_cs              5352   1
orinoco                32824   0  [orinoco_cs]
hermes                  7204   0  [orinoco_cs orinoco]
ds                      7944   1  [orinoco_cs]
yenta_socket           11616   1
pcmcia_core            48640   0  [orinoco_cs ds yenta_socket]
iptable_filter          2284   0  (autoclean) (unused)
ip_tables              13592   1  [iptable_filter]
mousedev                5076   0  (unused)
keybdev                 2688   0  (unused)
hid                    20132   0  (unused)
input                   5504   0  [mousedev keybdev hid]
usb-uhci               23564   0  (unused)
usbcore                69664   1  [hid usb-uhci]
ext3                   61440   1
jbd                    46932   1  [ext3]


lspci is:

00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev 05)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: f4100000-f57fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1420 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 1400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 10
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 20)
	Subsystem: Compaq Computer Corporation Soundmax integrated digital audio
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 9
	Region 0: I/O ports at 1000 [size=256]
	Region 1: I/O ports at 1434 [size=4]
	Region 2: I/O ports at 1430 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Communication controller: Conexant HSF 56k Data/Fax Modem (rev 01)
	Subsystem: Compaq Computer Corporation Bear
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=64K]
	Region 1: I/O ports at 1438 [size=8]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME+

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device b103
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 04
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: Trident Microsystems CyberBlade i1 (rev 6a) (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation CyberBlade i1 AGP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=8M]
	Region 1: Memory at f4100000 (32-bit, non-prefetchable) [size=128K]
	Region 2: Memory at f4800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [80] AGP version 1.0
		Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [90] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


