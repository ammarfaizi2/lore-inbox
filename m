Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263521AbRFANev>; Fri, 1 Jun 2001 09:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263507AbRFANel>; Fri, 1 Jun 2001 09:34:41 -0400
Received: from [216.124.224.105] ([216.124.224.105]:27917 "HELO lugop.org")
	by vger.kernel.org with SMTP id <S261535AbRFANe2>;
	Fri, 1 Jun 2001 09:34:28 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Promise Ultra100 TX2 Issue
Message-ID: <991402496.3b179a005f922@www.lugop.org>
Date: Fri, 01 Jun 2001 08:34:56 -0500 (CDT)
From: ryan@webmail.lugop.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.4
X-Originating-IP: 12.2.142.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a system running that uses two Promise Ultra66 cards (PDC20262).  
However, the hard disks are capible of Ultra100 transfer rates.  I needed an 
Ultra66 card for another machine, so I decided to upgrade this one's cards to 
Ultra100.  I purchased a pair of Promise Ultra100 TX2's so that the hard disks 
could run at their full speed.  However, these new cards do not seem to work 
properly.

I upgraded the kernel to 2.2.19 (from 2.2.18) while still using the old cards, 
just to verify everything worked.  After verifing everything came back up 
alright, I swaped the cards.  After the swap, it seemed that everthing would be 
fine, except that whenever I try to write more than a few bytes to the disk, the 
system locks hard, no oops or anything else.

I did notice that when booting up with the new card, these lines

PDC20268: IDE controller on PCI bus 00 dev 78
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
PDC20268: IDE controller on PCI bus 00 dev 88
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide4: BM-DMA at 0xc400-0xc407, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xc408-0xc40f, BIOS settings: hdk:pio, hdl:pio

tell me that the disks are using pio, instead of DMA like they were with the old 
card.  To get more information, I started to look in /proc:

With the old, Ultra66 cards in, this is the report from /proc/ide/pdc202xx

                                PDC20262 Chipset.
------------------------------- General Status ---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 6 mA
Status Polling Period                : 15
Interrupt Check Status Polling Delay : 15
--------------- Primary Channel ---------------- Secondary Channel -------------
                enabled                          enabled 
66 Clocking     enabled                          enabled 
           Mode PCI                         Mode PCI   
                FIFO Empty                       FIFO Empty  
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              yes             yes               yes
DMA Mode:       UDMA 4           UDMA 4          UDMA 4            UDMA 4
PIO Mode:       PIO 4            PIO 4           PIO 4            PIO 4

However, with the new card in (no kernel changes), the report appears to be 
confused

                                PDC20268 TX2 Chipset.
------------------------------- General Status ---------------------------------
Burst Mode                           : enabled
Host Mode                            : Tri-Stated
Bus Clocking                         : 100 External
IO pad select                        : 10 mA
Status Polling Period                : 15
Interrupt Check Status Polling Delay : 15
--------------- Primary Channel ---------------- Secondary Channel -------------
                enabled                          enabled 
66 Clocking     enabled                          enabled 
           Mode MASTER                      Mode MASTER
                Error                            Error       
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              yes             yes               yes
DMA Mode:       PIO---           PIO---          PIO---            PIO---
PIO Mode:       PIO ?            PIO ?           PIO ?            PIO ?

(btw, how do I generate a report for the 2nd Promise card in the system?)

I've tried many different combinations of the settings in the "Block Devices" 
portion of the kernel, but nothing seems to help the situation.

Thanks for the help!
Ryan Allgaier


I'm using Linux-2.2.19 with the following patches
 - ide.2.2.19.05042001.patch
 - linux-2.2.19-reiserfs-3.5.32-patch
 - raid-2.2.19-A1
 - linux-2.2.19-ow1

The system is a Athlon 800, running on an Abit KA7 with the latest BIOS, 512mb 
RAM.  This motherboard does not have 66Mhz PCI slots, AFAIK.  Both Promise 
Ultra100 TX2 cards were put into the exact same PCI slots that the Ultra66's 
were removed from.

Here's an lspci -vv
00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort+ <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [PCI-PCI Bridge] (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) 
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at 9000
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 
00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at 9400
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 
00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at 9800
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 
30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at 9c00
        Region 1: Memory at d5218000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0b.0 VGA compatible controller: Trident Microsystems TGUI 9440 (rev e3) 
(prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d5000000 (32-bit, non-prefetchable)
        Region 1: Memory at d5200000 (32-bit, non-prefetchable)

00:0f.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown 
device 4d68 (rev 01) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort+ <TAbort- 
<MAbort- >SERR- <PERR+
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at a000
        Region 1: I/O ports at a400
        Region 2: I/O ports at a800
        Region 3: I/O ports at ac00
        Region 4: I/O ports at b000
        Region 5: Memory at d5210000 (32-bit, non-prefetchable)
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown 
device 4d68 (rev 01) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort+ <TAbort- 
<MAbort- >SERR- <PERR+
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at b400
        Region 1: I/O ports at b800
        Region 2: I/O ports at bc00
        Region 3: I/O ports at c000
        Region 4: I/O ports at c400
        Region 5: Memory at d5214000 (32-bit, non-prefetchable)
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
