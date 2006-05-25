Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbWEYK7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWEYK7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 06:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWEYK7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 06:59:46 -0400
Received: from ppp116-191.lns1.bne3.internode.on.net ([59.167.116.191]:44235
	"EHLO mail.psychogeeks.com") by vger.kernel.org with ESMTP
	id S965093AbWEYK7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 06:59:46 -0400
Date: Thu, 25 May 2006 20:59:42 +1000
From: Chris W <lkml@psychogeeks.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16.18 soft hang, possibly in network or Cardbus related code:
 tulip, via-rhine, yenta
Message-ID: <20060525205942.4a2d0d45@newton.int.psychogeeks.com>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I need a little assistance to isolate the cause of the following problem.  Any assistance offered would be greatly appreciated.  I can rebuild, reconfigure, and jump through hoops as required to get useful debugging information.

Please CC directly as I'm not subscribed to the list.

Regards,
Chris Williams
lkml@psychogeeks.com



[1.] One line summary of the problem:   

2.6.16.18 soft hang, possibly in network or Cardbus related code: tulip, via-rhine, yenta


[2.] Full description of the problem/report:

2.6.16.18 build running on Via EPIA MII 12000 (Nehemiah CPU) as light-duty firewall and wireless AP.  
Via Rhine II interface on motherboard is the internal interface as part of a bridge (br0) that from time-to-time includes a TAP OpenVPN interface as well.  
Netgear FA511 (tulip, eth1) Cardbus card (yenta) is external interface to 1.5Mbps DSL.  
A wireless card (DLink G520) is installed in PCI slot but at no time have drivers (madwifi-ng) been loaded.  
Netfilter rule-set managed by Shoreline firewall scripts.

Machine runs normally from hard reset for a period as short as ~30 minutes and as long as ~3 days then hangs.  Network traffic typically very light, with last incident occurring within an hour under only inbound mail, SSH terminal, and light web browsing loads, and with no internal interface traffic.  Network traffic to/from/through machine is normal until machine stops abruptly.  When machine hangs all function ceases.  Machine is not responsive to keyboard activity or network connection attempts from external interface.  VT switching is not possible.  There is no diagnostic information on the console (i.e. no Oops).

The system stays in the hung state until I power up a machine on the internal network and make a DHCP request.  The affected firewall machine then wakes from its sleep and continues normal operation.  During the hang period the system clock has stopped ticking i.e. system time is now wrong and ntpd shuts down.  The hangcheck_timer (default settings) and "Detect Soft Lockup" do not trigger.  The kernel log sometimes records "tulip_stop_rxtx() failed"  and/or "wifi0: hardware error; reseting" if madwifi is loaded.


[X.] Other notes, patches, fixes, workarounds:

This is a vanilla 2.6.16.18 kernel.org kernel running in a Gentoo machine.  The problem has been present in all the 2.6.16.x builds I've tried.  There are no Gentoo patch sets involved, but the problem also exists in multiple Gentoo kernel releases.

I have looked for common network traffic events, times, or other events that might be a trigger but have found none other than inactivity.  To my recollection it has never died while the internal network was actively in use.

I have eliminated the madwifi driver as a cause by not loading it although the card is still present in the machine. 

I have had issue with the VIA Rhine interface not waking from D3 sleep when this machine was used as a desktop.  The following patch (from an unknown Internet post) remedied that situation, but has made no difference here: 

--- drivers/net/via-rhine.c.orig        2006-05-24 17:57:12.000000000 +1000
+++ drivers/net/via-rhine.c     2006-05-24 17:59:13.000000000 +1000
@@ -1965,7 +1965,9 @@
        }

        /* Hit power state D3 (sleep) */
+       /*
        iowrite8(ioread8(ioaddr + StickyHW) | 0x03, ioaddr + StickyHW);
+       */

        /* TODO: Check use of pci_enable_wake() */

Machine was stable when the wireless card and yenta socket driver were not present.  The external interface was an RTL8139-based card in the PCI slot.  Kernel was a 2.6.15.x derivative IIRC.


[3.] Keywords (i.e., modules, networking, kernel):

tulip, via-rhine, hang


[4.] Kernel version (from /proc/version):

Linux version 2.6.16.18 (root@ptolemy) (gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 Thu May 25 08:24:51 EST 2006


[5.] Output of Oops.. message (if applicable) with symbolic information resolved (see Documentation/oops-tracing.txt)

No Oops.


[6.] A small shell script or example program which triggers the problem (if possible)

N/A

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):
[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)
[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem (please look in /proc and include all information that you think to be relevant):


# cat proc_version.txt
Linux version 2.6.16.18 (root@ptolemy) (gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 Thu May 25 08:24:51 EST 2006


# cat ver_linux.txt
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux ptolemy 2.6.16.18 #1 Thu May 25 08:24:51 EST 2006 i686 VIA Nehemiah GNU/Linux
 
Gnu C                  3.4.5
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.1
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.94
udev                   087
Modules Loaded         hangcheck_timer bsd_comp ppp_async ppp_generic slhc tun tulip via_rhine mii


# cat proc_cpuinfo.txt
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 9
model name      : VIA Nehemiah
stepping        : 8
cpu MHz         : 1199.924
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr cx8 sep mtrr pge cmov pat mmx fxsr
sse rng rng_en ace ace_en
bogomips        : 2403.19


# cat proc_interrupts.txt
           CPU0       
  0:    1024680          XT-PIC  timer
  1:          8          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:          0          XT-PIC  ehci_hcd:usb1
  5:      11565          XT-PIC  yenta, uhci_hcd:usb2, eth0, eth1
  7:          0          XT-PIC  uhci_hcd:usb4
  8:          2          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 12:          0          XT-PIC  yenta, uhci_hcd:usb3
 14:       5819          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0


# cat proc_iomem.txt
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000cdfff : Video ROM
000f0000-000fffff : System ROM
00100000-1dfeffff : System RAM
  00100000-0036a8c0 : Kernel code
  0036a8c1-0041ee3b : Kernel data
1dff0000-1dff2fff : ACPI Non-volatile Storage
1dff3000-1dffffff : ACPI Tables
20000000-21ffffff : PCI CardBus #02
  20000000-2001ffff : 0000:02:00.0
22000000-23ffffff : PCI CardBus #02
  22000000-220003ff : 0000:02:00.0
    22000000-220003ff : tulip
24000000-25ffffff : PCI CardBus #06
26000000-27ffffff : PCI CardBus #06
e0000000-e3ffffff : 0000:00:00.0
e4000000-e7ffffff : PCI Bus #01
  e4000000-e7ffffff : 0000:01:00.0
    e4000000-e5ffffff : vesafb
e8000000-e9ffffff : PCI Bus #01
  e8000000-e8ffffff : 0000:01:00.0
  e9000000-e900ffff : 0000:01:00.0
ea000000-ea00ffff : 0000:00:14.0
ea014000-ea014fff : 0000:00:0a.1
  ea014000-ea014fff : yenta_socket
ea019000-ea0190ff : 0000:00:10.3
  ea019000-ea0190ff : ehci_hcd
ea01a000-ea01a0ff : 0000:00:12.0
  ea01a000-ea01a0ff : via-rhine
ea01b000-ea01bfff : 0000:00:0a.0
  ea01b000-ea01bfff : yenta_socket
ffff0000-ffffffff : reserved


# cat proc_ioports.txt
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vesafb
03f6-03f6 : ide0
0400-047f : 0000:00:11.0
  0400-0403 : PM1a_EVT_BLK
  0404-0405 : PM1a_CNT_BLK
  0408-040b : PM_TMR
  0420-0423 : GPE0_BLK
0500-050f : 0000:00:11.0
  0500-050f : pnp 00:02
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #02
  1000-10ff : 0000:02:00.0
    1000-10ff : tulip
1400-14ff : PCI CardBus #02
1800-18ff : PCI CardBus #06
1c00-1cff : PCI CardBus #06
b000-b01f : 0000:00:10.0
  b000-b01f : uhci_hcd
b400-b41f : 0000:00:10.1
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:10.2
  b800-b81f : uhci_hcd
bc00-bc0f : 0000:00:11.1
  bc00-bc07 : ide0
c000-c0ff : 0000:00:11.5
c800-c8ff : 0000:00:12.0
  c800-c8ff : via-rhine


# cat proc_modules.txt
hangcheck_timer 3160 0 - Live 0xdeb0c000
bsd_comp 5312 0 - Live 0xde87c000
ppp_async 8768 1 - Live 0xdeb08000
ppp_generic 20596 6 bsd_comp,ppp_async, Live 0xdeb10000
slhc 5920 1 ppp_generic, Live 0xde874000
tun 8864 0 - Live 0xde878000
tulip 47488 0 - Live 0xdeb18000
via_rhine 20484 0 - Live 0xdeb01000
mii 4896 1 via_rhine, Live 0xde86f000


# cat lspci.txt
00:00.0 Host bridge: VIA Technologies, Inc. VT8623 [Apollo CLE266]
	Subsystem: VIA Technologies, Inc. Unknown device aa01
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: e4000000-e7ffffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR+
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: VIA Technologies, Inc. Unknown device aa01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at ea01b000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20000000-21fff000 (prefetchable)
	Memory window 1: 22000000-23fff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: VIA Technologies, Inc. Unknown device aa01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 12
	Region 0: Memory at ea014000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 24000000-25fff000 (prefetchable)
	Memory window 1: 26000000-27fff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. Unknown device aa01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Interrupt: pin A routed to IRQ 5
	Region 4: I/O ports at b000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. Unknown device aa01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Interrupt: pin B routed to IRQ 12
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. Unknown device aa01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Interrupt: pin C routed to IRQ 7
	Region 4: I/O ports at b800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: VIA Technologies, Inc. USB 2.0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Interrupt: pin D routed to IRQ 4
	Region 0: Memory at ea019000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc. Unknown device aa01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Unknown device aa01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 4: I/O ports at bc00 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
	Subsystem: VIA Technologies, Inc. Unknown device aa01
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 7
	Region 0: I/O ports at c000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
	Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet Controller on VT8235
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at c800 [size=256]
	Region 1: Memory at ea01a000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.0 Ethernet controller: Atheros Communications, Inc. AR5212 802.11abg NIC (rev 01)
	Subsystem: D-Link System Inc D-Link AirPlus DWL-G520 Wireless PCI Adapter(rev.B)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 7000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at ea000000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8623 [Apollo CLE266] integrated CastleRock graphics (rev 03) (prog-if 00 [VGA])
	Subsystem: VIA Technologies, Inc. VT8623 [Apollo CLE266] integrated CastleRock graphics
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at e9000000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [70] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

02:00.0 Ethernet controller: Linksys 21x4x DEC-Tulip compatible 10/100 Ethernet (rev 11)
	Subsystem: Netgear Unknown device 511a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at 22000000 (32-bit, non-prefetchable) [size=1K]
	[virtual] Expansion ROM at 20000000 [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Linux .config is available at:
http://www.users.on.net/~chrisw67/proc_config.txt

Annotated dmesg output at:
http://www.users.on.net/~chrisw67/dmesg.txt


-- 
Chris Williams

