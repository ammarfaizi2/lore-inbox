Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264274AbRFMXUj>; Wed, 13 Jun 2001 19:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264284AbRFMXUa>; Wed, 13 Jun 2001 19:20:30 -0400
Received: from laurin.munich.netsurf.de ([194.64.166.1]:10733 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S264274AbRFMXUR>; Wed, 13 Jun 2001 19:20:17 -0400
Date: Thu, 14 Jun 2001 01:18:54 +0200
To: "Paulo E. Abreu" <qtabreu@ci.uc.pt>
Cc: linux-kernel@vger.kernel.org, Martin Mares <mj@suse.cz>
Subject: O2 Micro CB bridge problems (was: PCMCIA troubles with an Acer TravelMate 513TE)
Message-ID: <20010614011854.A5278@storm.local>
Mail-Followup-To: "Paulo E. Abreu" <qtabreu@ci.uc.pt>,
	linux-kernel@vger.kernel.org, Martin Mares <mj@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B248A97.8000406@ci.uc.pt>
User-Agent: Mutt/1.3.18i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2001 at 10:08:39AM +0100, Paulo E. Abreu wrote:
> Greetings,
> 
> I have this laptop and I am having trouble with pcmcia in every 2.4.x 
> kernel.
> Someone suggested that this could be a BIOS bug ...
> Below there is the information, that I think is relevant to this problem. If
> more is needed just tell me...

You have the exact same problem as I have.  Your Cardbus bridge gets
memory windows allocated during initialization, but no IO port windows.
This seems to be related to the resource allocation code in Linux 2.4.

> Now I cannot use any PCMCIA device with this laptop, this is critical as I
> cannot have any network connection...

Use the drivers from the pcmcia-cs package instead of the kernel code.
They don't bother with the abstract interfaces provided by the kernel
and do direct pcibios_* function calls.  That works where the kernel PCI
hotplug code doesn't work for me.

Actually I *can* make it work for me, see below for the setpci hack
(replace my IO base with a free range on your computer, use the
appropriate slot number in the -s argument (that was 13.0 and 13.1 in
your case, for each of the PCMCIA slots)).


Now back to addressing the hackers who feel addressed (and Martin Mares
who I just cc'ed without remorse):  I have reported my problems already
once some time (a few 2.4 releases at least) back, but it didn't get
fixed and pcmcia-cs worked too good so I wasn't very active in this
regard.  I have a Thinkpad 1200 (more specifically 1161-267), which has
the same cardbus bridge Paulo has except for the revision, but see
below.

The problem is, in short, that the PCI code allocated memory windows for
the bridge but no IO windows.  The tulip chip on an inserted cb card
gets then memory allocated, but the driver complains that it doesn't
have IO access and stops.  Using modularized drivers I can show that
step by step:


No drivers loaded, pristine state, no memory or I/O windows:

Script started on Wed Jun 13 22:03:14 2001
[root@merv root]# lspci -vvv -s3
00:03.0 CardBus bridge: O2 Micro, Inc. OZ6812 Cardbus Controller (rev 05)
	Subsystem: IBM: Unknown device 01a3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=0
	Memory window 0: 00000000-00000000
	Memory window 1: 00000000-00000000
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

[root@merv root]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03bc-03be : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
7000-70ff : Intel Corporation 82440MX AC'97 Audio Controller
7400-743f : Intel Corporation 82440MX AC'97 Audio Controller
7800-78ff : PCI device 8086:7196 (Intel Corporation)
7c00-7c7f : PCI device 8086:7196 (Intel Corporation)
8000-801f : Intel Corporation 82440MX USB Universal Host Controller
  8000-801f : usb-uhci
8040-804f : Intel Corporation 82440MX EIDE Controller
  8040-8047 : ide0

****
Loading the drivers, memory windows get allocated:
****
  
[root@merv root]# modprobe yenta_socket
[root@merv root]# modprobe cb_enabler
[root@merv root]# lspci -vvv -s3
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

[root@merv root]# dmesg | tail -15
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:03.0
PCI: The same IRQ used for device 00:00.1
PCI: The same IRQ used for device 00:00.2
IRQ routing conflict in pirq table for device 00:03.0
Yenta IRQ list 02b8, PCI irq10
Socket status: 30000827
cs: cb_alloc(bus 1): vendor 0x1011, device 0x0019
PCI: Failed to allocate resource 0(1000-fff) for 01:00.0
  got res[10800000:108003ff] for resource 1 of PCI device 1011:0019
  got res[10400000:1043ffff] for resource 6 of PCI device 1011:0019
PCI: Enabling device 01:00.0 (0000 -> 0003)
Linux Tulip driver version 0.9.15-pre2 (May 16, 2001)
tulip: 01:00.0: I/O region (0x0@0x1000) too small, aborting


****
For reference, the cardbus tulip w/o IO ports:
****

[root@merv root]# lspci -vvv -s1:
01:00.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Abocom Systems Inc: Unknown device ab01
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1000
	Region 1: Memory at 10800000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 10400000 [size=256K]


****
Gross hack, remove drivers, setpci IO window base register to free port
range (not sure about the IO limit register, I just set it during my
experiments):
****

[root@merv root]# rmmod -r cb_enabler
[root@merv root]# rmmod -r yenta_socket
[root@merv root]# setpci -v -s3 CB_IO_BASE_0=0x1000
00:03.0:2c 1000
[root@merv root]# setpci -v -s3 CB_IO_LIMIT_0=0x1
00:03.0:30 0001
[root@merv root]# lspci -vvv -s3
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
	I/O window 0: 00001000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

****
Load driver again, which accepts the IO window base and fixes the limit:
****

[root@merv root]# modprobe yenta_socket
[root@merv root]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03bc-03be : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #01
7000-70ff : Intel Corporation 82440MX AC'97 Audio Controller
7400-743f : Intel Corporation 82440MX AC'97 Audio Controller
7800-78ff : PCI device 8086:7196 (Intel Corporation)
7c00-7c7f : PCI device 8086:7196 (Intel Corporation)
8000-801f : Intel Corporation 82440MX USB Universal Host Controller
  8000-801f : usb-uhci
8040-804f : Intel Corporation 82440MX EIDE Controller
  8040-8047 : ide0
[root@merv root]# lspci -vvv -s3
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
	I/O window 0: 00001000-000010ff
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

[root@merv root]# modprobe cb_enabler
[root@merv root]# dmesg | tail -30
Yenta IRQ list 02b8, PCI irq10
Socket status: 30000827
cs: cb_alloc(bus 1): vendor 0x1011, device 0x0019
PCI: Failed to allocate resource 0(1000-fff) for 01:00.0
  got res[10800000:108003ff] for resource 1 of PCI device 1011:0019
  got res[10400000:1043ffff] for resource 6 of PCI device 1011:0019
PCI: Enabling device 01:00.0 (0000 -> 0003)
Linux Tulip driver version 0.9.15-pre2 (May 16, 2001)
tulip: 01:00.0: I/O region (0x0@0x1000) too small, aborting
cs: cb_free(bus 1)
unloading PCMCIA Card Services
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:03.0
PCI: The same IRQ used for device 00:00.1
PCI: The same IRQ used for device 00:00.2
IRQ routing conflict in pirq table for device 00:03.0
Yenta IRQ list 02b8, PCI irq10
Socket status: 30000827
cs: cb_alloc(bus 1): vendor 0x1011, device 0x0019
  got res[1000:107f] for resource 0 of PCI device 1011:0019
  got res[10800000:108003ff] for resource 1 of PCI device 1011:0019
  got res[10400000:1043ffff] for resource 6 of PCI device 1011:0019
PCI: Enabling device 01:00.0 (0000 -> 0003)
Linux Tulip driver version 0.9.15-pre2 (May 16, 2001)
PCI: Setting latency timer of device 01:00.0 to 64
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #0 config 3000 status 7809 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0x1000, 00:E0:98:7D:E9:9B, IRQ 10.

[root@merv root]# lspci -vvv -s1:
01:00.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Abocom Systems Inc: Unknown device ab01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1000 [size=128]
	Region 1: Memory at 10800000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 10400000 [size=256K]

[root@merv root]# exit

Script done on Wed Jun 13 22:13:45 2001


****

And this continues to work fine.  I'd like to get rid of the pcmcia-cs
modules and use the kernel modules, and it doesn't look like a difficult
bug (I didn't quite figure out the PCI bridge/Cardbus code, however).

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
