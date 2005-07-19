Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVGSIrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVGSIrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 04:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVGSIrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 04:47:09 -0400
Received: from alpha.tmit.bme.hu ([152.66.246.10]:58381 "EHLO alpha.ttt.bme.hu")
	by vger.kernel.org with ESMTP id S261546AbVGSIrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 04:47:08 -0400
Message-ID: <42DD3CD3.9070508@alpha.tmit.bme.hu>
Date: Tue, 19 Jul 2005 10:48:03 -0700
From: Gyorgy Horvath <horvaath@alpha.tmit.bme.hu>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: Driver for Rocky 4782E WDT and pls help
References: <42DC2871.1030103@alpha.tmit.bme.hu> <1121704467.12438.71.camel@localhost.localdomain>
In-Reply-To: <1121704467.12438.71.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan Cox wrote:

>Did you make sure none of that is ACPI owned in the E820 map and that if
>you set any cache properties they match and are consistent with any
>Linux pagetable uses ?
>  
>
dmesg shows:
----- dmesg portion begin ---------
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
found SMP MP-table at 000f51b0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
----- end of dmesg portion --------

Seems OK since I claimed it from 0x08000000 upto,
and I did not see any overlapping/conflicts.

cat /proc/iomem shows:
----- /proc/iomem portion ---------
08000000-09ffffff : sga155d0
0a000000-0a07ffff : sga155d0
0a080000-0a0fffff : sga155d0
0a100000-0a13ffff : sga155d0
0a140000-0a77ffff : sga155d0
0a780000-0a7bffff : sga155d0
0a7c0000-0adfffff : sga155d0
d0000000-dfffffff : PCI Bus #01
---- end of /proc/iomem portion ---


 > Is this also true with ide=nodma ?

Let us see (lilo,reboot):
---- /proc/ide/ide0/hda/settings --
name                    value           min             max             mode
----                    -----           ---             ---             ----
bios_cyl                2482            0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
.... blah-blah ...
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               0               0               1               rw
-------------------^^^^--------------------------------------------------
DMA is now off...

- Heat up the box

- Issue - let say - lynx - :-O

- Issue fortune - :-O
  It sais:
  "I never failed to convince an audience that the best thing they"
  "could do was to go away."

- Issue for files in /usr/bin/*; do eval "$files --help 1> /dev/null 
2>/dev/null&"; done

  Wooow... Still alive! Although... Hehehehehe... Pretty funny... Uuuups...
  No! Not that!

  Phuhhh.... It seemed the firework stopped. But cca. 100 processes 
remained up -
  like notangle,   and markup :-)
  Anyway - the DMA load is still up - 20 Mbytes/sec - and stable.

-- sga155d0 --- POS if0 --- Rx --- Other Tx--
Packets..........   46967648    46943282
Bytes............ 4132286576  4132286576
Errors-Total.....          0           0
-Dropped.........       9907         116
-Frame/Abort.....          0           0
-CRC.............          0           0
-Overrun/Underrun          0           0
-FIFO............          0

-- sga155d0 --- POS if1 --- Rx --- Other Tx--
Packets..........   47020352    46967837
Bytes............ 4134610216  4134610216
Errors-Total.....          0           0
-Dropped.........      36172         127
-Frame/Abort.....          0           0
-CRC.............          0           0
-Overrun/Underrun          0           0
-FIFO............          0

Only thoose dropped packets shows that something
really nasty happened to the system during my stress test.
(Normally it did not drop anything at that rate)
The watchdog slept fine - no hangs.
Time to reboot (who knows).  Succeded too - it survived.

!!!!!!!! Alan - YOU KNOW SOMETHING !!!!!!!!!!!!!!

The system can go without IDE dma for this particular application,
but it would be better to go with it ...

Are there any known issues about the chipsets down here?
Concerning IDE's ultra DMA?

---------------- lspci -vvv begin 
-------------------------------------------
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
Bridge (rev 04)
    Subsystem: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
    Latency: 0
    Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
    Capabilities: [e4] #09 [9104]
    Capabilities: [a0] AGP version 2.0
        Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
        Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
(rev 04) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
    I/O behind bridge: 0000c000-0000cfff
    Memory behind bridge: e5000000-e50fffff
    Prefetchable memory behind bridge: d0000000-dfffffff
    BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 
05) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
    I/O behind bridge: 00008000-0000bfff
    Memory behind bridge: e4000000-e4ffffff
    Prefetchable memory behind bridge: fff00000-000fffff
    BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge 
(ICH2) (rev 05)
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0

00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 
(rev 05) (prog-if 80 [Master])
    Subsystem: Intel Corp.: Unknown device 2442
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Region 4: I/O ports at f000 [size=16]

00:1f.3 SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev 05)
    Subsystem: Intel Corp.: Unknown device 2442
    Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin B routed to IRQ 17
    Region 4: I/O ports at 5000 [size=16]

00:1f.5 Multimedia audio controller: Intel Corp. 82820 820 (Camino 2) 
Chipset AC'97 Audio Controller (rev 05)
    Subsystem: Unknown device 414c:4710
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Interrupt: pin B routed to IRQ 17
    Region 0: I/O ports at dc00 [size=256]
    Region 1: I/O ports at e000 [size=64]

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]: 
Unknown device 0325 (prog-if 00 [VGA])
    Subsystem: Silicon Integrated Systems [SiS]: Unknown device 0325
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 39 (750ns min, 4000ns max)
    BIST result: 00
    Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
    Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=256K]
    Region 2: I/O ports at c000 [size=128]
    Expansion ROM at <unassigned> [disabled] [size=64K]
    Capabilities: [40] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] AGP version 2.0
        Status: RQ=15 SBA- 64bit- FW- Rate=x1,x2
        Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:08.0 Ethernet controller: Intel Corp. 82820 (ICH2) Chipset Ethernet 
Controller (rev 03)
    Subsystem: Intel Corp.: Unknown device 3010
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (2000ns min, 14000ns max), cache line size 08
    Interrupt: pin A routed to IRQ 20
    Region 0: Memory at e4e01000 (32-bit, non-prefetchable) [size=4K]
    Region 1: I/O ports at ac00 [size=64]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:0b.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
    Subsystem: Intel Corp. EtherExpress PRO/100+ Server Adapter (PILA8470B)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (2000ns min, 14000ns max), cache line size 08
    Interrupt: pin A routed to IRQ 17
    Region 0: Memory at e4e02000 (32-bit, non-prefetchable) [size=4K]
    Region 1: I/O ports at a000 [size=64]
    Region 2: Memory at e4d00000 (32-bit, non-prefetchable) [size=1M]
    Expansion ROM at <unassigned> [disabled] [size=1M]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:0c.0 ATM network controller: Technical University of Budapest: 
Unknown device d155 (rev 11) (prog-if ff)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at e4e05000 (32-bit, non-prefetchable) [size=64]
    Region 1: Memory at e4e00000 (32-bit, non-prefetchable) [size=1K]
    Region 2: Memory at e4000000 (32-bit, non-prefetchable) [size=2M]
    Region 3: I/O ports at a400 [size=256]
    Region 4: I/O ports at a800 [size=256]

02:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06) 
(prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32, cache line size 08
    Bus: primary=02, secondary=03, subordinate=03, sec-latency=32
    I/O behind bridge: 00008000-00009fff
    Memory behind bridge: e4200000-e49fffff
    Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
    BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
    Capabilities: [dc] Power Management version 1
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Bridge: PM- B3+

02:0f.0 ATM network controller: Technical University of Budapest: 
Unknown device d155 (rev 11) (prog-if ff)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Interrupt: pin A routed to IRQ 17
    Region 0: Memory at e4e03000 (32-bit, non-prefetchable) [size=64]
    Region 1: Memory at e4e04000 (32-bit, non-prefetchable) [size=1K]
    Region 2: Memory at e4a00000 (32-bit, non-prefetchable) [size=2M]
    Region 3: I/O ports at b000 [size=256]
    Region 4: I/O ports at b400 [size=256]

03:05.0 ATM network controller: Technical University of Budapest: 
Unknown device d155 (rev 11) (prog-if ff)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at e4805000 (32-bit, non-prefetchable) [size=64]
    Region 1: Memory at e4802000 (32-bit, non-prefetchable) [size=1K]
    Region 2: Memory at e4200000 (32-bit, non-prefetchable) [size=2M]
    Region 3: I/O ports at 8000 [size=256]
    Region 4: I/O ports at 8400 [size=256]

03:07.0 ATM network controller: Technical University of Budapest: 
Unknown device d155 (rev 11) (prog-if ff)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Interrupt: pin A routed to IRQ 18
    Region 0: Memory at e4800000 (32-bit, non-prefetchable) [size=64]
    Region 1: Memory at e4801000 (32-bit, non-prefetchable) [size=1K]
    Region 2: Memory at e4400000 (32-bit, non-prefetchable) [size=2M]
    Region 3: I/O ports at 8800 [size=256]
    Region 4: I/O ports at 8c00 [size=256]

03:09.0 ATM network controller: Technical University of Budapest: 
Unknown device d155 (rev 11) (prog-if ff)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at e4803000 (32-bit, non-prefetchable) [size=64]
    Region 1: Memory at e4804000 (32-bit, non-prefetchable) [size=1K]
    Region 2: Memory at e4600000 (32-bit, non-prefetchable) [size=2M]
    Region 3: I/O ports at 9000 [size=256]
    Region 4: I/O ports at 9400 [size=256]

---------------- lspci -vvv end 
---------------------------------------------

Best regards

Gyuri

