Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSLPW6l>; Mon, 16 Dec 2002 17:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbSLPW6k>; Mon, 16 Dec 2002 17:58:40 -0500
Received: from office-NAT.rockwellfirstpoint.com ([199.191.58.7]:31957 "EHLO
	ecsmtp01.rockwellfirstpoint.com") by vger.kernel.org with ESMTP
	id <S261973AbSLPW6Y>; Mon, 16 Dec 2002 17:58:24 -0500
Subject: i845PE chipset and 20276 Promise Controller boot failure with 2.4.20-ac2
To: linux-kernel@vger.kernel.org
Cc: edward.kuns@rockwellfirstpoint.com
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF4D4BDDD2.8FD534AB-ON86256C91.007B9286-86256C91.007EE995@rockwellfirstpoint.com>
From: edward.kuns@rockwellfirstpoint.com
Date: Mon, 16 Dec 2002 17:09:49 -0600
X-MIMETrack: Serialize by Router on ECSMTP01/EC/Rockwell(Release 5.0.11  |July 24, 2002) at
 12/16/2002 05:06:37 PM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=09BBE602DFE814168f9e8a93df938690918c09BBE602DFE81416"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=09BBE602DFE814168f9e8a93df938690918c09BBE602DFE81416
Content-type: text/plain; charset=us-ascii

Please CC me at edward.kuns at rockwellfirstpoint.com in your responses.

I have a Gigabyte GA-8PE667 Ultra motherboard (aka P4 Titan 667 Ultra) with
the i845PE chipset plus a Promise RAID controller (PDC20276).  Earlier I
sent a message about the sound problems I've been having.  (Thanks, Alan,
I'll try enabling APIC, etc, tonight.  Since I was working with the Red Hat
kernels, I didn't deeply investigate the default settings there.)  The
other problem I'm having is trying to build my own kernel with 2.4.20-ac2
-- where I have APIC et al enabled.  It builds fine but does not finish
booting.  The failure appears related to the Promise RAID controller.  I
didn't have this problem with earlier 2.4.20-pre*-ac* kernels on an i845G
Intel motherboard which has only the IDE controller of the chipset.

Booting with the new kernel, it gets to the PDC20276 IDE controller, gives
the three lines of 1) controller "not 100% native mode" line and 2,3) two
lines for ide2 and ide3, and that is it.  At that point the machine is hung
solid.  CTL-ALT-DEL does nothing, Magic SysRq does nothing.  I cannot
scroll back.  Only the hardware reset button causes a response.  In case it
matters, the BIOS for the Promise controller is "MBUltra133 (PDC20276) BIOS
2.20.1020.13".  This motherboard allows you to set the Promise controller
in RAID mode or in ATA mode.  I have it set in ATA mode.  I tried putting
it in RAID mode and after setting up a "striped" RAID array of one disk
(grin) grub complained of a disk error and refused to even load.  Feh.
Grub is very, very picky about that sort of thing I guess.  So I set it
back to ATA mode where it at least works with the RH8.0 kernels and grub.

I've tried building with IDE-RAID in or not in.  I've tried building it
with each Promise driver separately (pdc202xx_new.c and pdc202xx_old.c if I
recall correctly) and with both Promise drivers compiled in at the same
time.  With and without IDE-RAID.  They all acted exactly the same.  So
then I added a bunch of printk's to see if I could localize where it was
hanging and it died immediately after displaying info about the PIIX
driver.  Hmm.  I guess there are places one cannot or should not put a
printk?  I modified files like ide-disk.c and both pdc202xx_*.c files.  I
might have added printk's to other files in that same tree.

I searched for other complaints about the Promise controller and someone
said they had success with pure 2.4.20, so I'll try that tonight.  (My
understanding is that 2.4.21-pre1 will have essentially the same IDE code
as earlier *-ac kernels, so it probably wouldn't add much for me to try
that.)  The RedHat 8.0 kernels boot perfectly.  The dmesg related to IDE
drives from the Red Hat kernels is below.  Note that I am missing the
beginning part. The RAID code generates so many messages that I think my
early boot messages have scrolled out of the circular message buffer before
klogd starts.  (Is the size of that buffer adjustable by #define?)

Dec 15 22:35:24 kilroy kernel:     ide0: BM-DMA at 0xcc00-0xcc07, BIOS
settings: hda:DMA, hdb:pio
Dec 15 22:35:24 kilroy kernel:     ide1: BM-DMA at 0xcc08-0xcc0f, BIOS
settings: hdc:pio, hdd:DMA
Dec 15 22:35:24 kilroy kernel: PDC20276: IDE controller on PCI bus 02 dev
60
Dec 15 22:35:24 kilroy kernel: PCI: Found IRQ 11 for device 02:0c.0
Dec 15 22:35:24 kilroy kernel: PCI: Sharing IRQ 11 with 02:00.0
Dec 15 22:35:24 kilroy kernel: PCI: Sharing IRQ 11 with 02:07.1
Dec 15 22:35:24 kilroy kernel: PDC20276: chipset revision 1
Dec 15 22:35:24 kilroy kernel: ide: Found promise 20265 in RAID mode.
Dec 15 22:35:24 kilroy kernel: PDC20276: not 100%% native mode: will probe
irqs later
Dec 15 22:35:24 kilroy kernel:     ide2: BM-DMA at 0xa400-0xa407, BIOS
settings: hde:pio, hdf:pio
Dec 15 22:35:24 kilroy kernel:     ide3: BM-DMA at 0xa408-0xa40f, BIOS
settings: hdg:pio, hdh:pio
Dec 15 22:35:24 kilroy kernel: hda: IC35L060AVER07-0, ATA DISK drive
Dec 15 22:35:24 kilroy kernel: hdd: HL-DT-ST RW/DVD GCC-4320B, ATAPI
CD/DVD-ROM drive
Dec 15 22:35:24 kilroy kernel: hde: IC35L060AVER07-0, ATA DISK drive
Dec 15 22:35:24 kilroy kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 15 22:35:24 kilroy kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec 15 22:35:24 kilroy kernel: ide2 at 0x9400-0x9407,0x9802 on irq 11
Dec 15 22:35:24 kilroy kernel: blk: queue c03afd84, I/O limit 4095Mb (mask
0xffffffff)
Dec 15 22:35:24 kilroy kernel: blk: queue c03afd84, I/O limit 4095Mb (mask
0xffffffff)
Dec 15 22:35:24 kilroy kernel: hda: 120103200 sectors (61493 MB) w/1916KiB
Cache, CHS=7476/255/63, UDMA(33)
Dec 15 22:35:24 kilroy kernel: blk: queue c03b040c, I/O limit 4095Mb (mask
0xffffffff)
Dec 15 22:35:24 kilroy kernel: blk: queue c03b040c, I/O limit 4095Mb (mask
0xffffffff)
Dec 15 22:35:24 kilroy kernel: hde: 120103200 sectors (61493 MB) w/1916KiB
Cache, CHS=119150/16/63, UDMA(100)
Dec 15 22:35:24 kilroy kernel: ide-floppy driver 0.99.newide
Dec 15 22:35:24 kilroy kernel: Partition check:
Dec 15 22:35:24 kilroy kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Dec 15 22:35:24 kilroy kernel:  hde: hde1 hde2 hde3 hde4 < hde5 hde6 >

When I boot with 2.4.20-ac2, it halts after the "ide3: BM-DMA at
0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio" line.  In addition, I do
not see the previous lines about finding or sharing IRQ for that
controller.  Nor do I see "ide: Found promise 20265 in RAID mode."

Another interesting fact is that hda and hde are identical models, but the
i845PE IDE controller only enabled the drive as UDMA33.  Hmm.  Curious. But
I have not investigated this much yet except to see if the PIIX driver has
a "quirk" drive list.  I didn't find one.

My config file for 2.4.20-ac2 is attached to this message.  Given below is
output of "lspci -vv":

00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host
Bridge (rev 02)
      Subsystem: Giga-byte Technology: Unknown device 2560
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
      Latency: 0
      Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
      Capabilities: [e4] #09 [6105]
      Capabilities: [a0] AGP version 2.0
            Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
            Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x4

00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge
(rev 02) (prog-if 00 [Normal decode])
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
      Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 64
      Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
      Memory behind bridge: e8000000-e9ffffff
      Prefetchable memory behind bridge: d8000000-e7ffffff
      BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02) (prog-if
00 [UHCI])
      Subsystem: Giga-byte Technology: Unknown device 24c2
      Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 0
      Interrupt: pin A routed to IRQ 9
      Region 4: I/O ports at b800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02) (prog-if
00 [UHCI])
      Subsystem: Giga-byte Technology: Unknown device 24c2
      Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 0
      Interrupt: pin B routed to IRQ 11
      Region 4: I/O ports at b000 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02) (prog-if
00 [UHCI])
      Subsystem: Giga-byte Technology: Unknown device 24c2
      Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 0
      Interrupt: pin C routed to IRQ 11
      Region 4: I/O ports at b400 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
(prog-if 20 [EHCI])
      Subsystem: Giga-byte Technology: Unknown device 5004
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 0
      Interrupt: pin D routed to IRQ 9
      Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=1K]
      Capabilities: [50] Power Management version 2
            Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
            Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82) (prog-if
00 [Normal decode])
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
      Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
      Latency: 0
      Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
      I/O behind bridge: 00008000-0000afff
      Memory behind bridge: ea000000-ebffffff
      BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
      Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02) (prog-if 8a
[Master SecP PriP])
      Subsystem: Giga-byte Technology: Unknown device 24c2
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 0
      Interrupt: pin A routed to IRQ 9
      Region 0: I/O ports at 01f0
      Region 1: I/O ports at 03f4
      Region 2: I/O ports at 0170
      Region 3: I/O ports at 0374
      Region 4: I/O ports at cc00 [size=16]
      Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 02)
      Subsystem: Giga-byte Technology: Unknown device 24c2
      Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Interrupt: pin B routed to IRQ 5
      Region 4: I/O ports at 5000 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX440]
(rev a3) (prog-if 00 [VGA])
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 248 (1250ns min, 250ns max)
      Interrupt: pin A routed to IRQ 9
      Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
      Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
      Region 2: Memory at e0000000 (32-bit, prefetchable) [size=512K]
      Expansion ROM at <unassigned> [disabled] [size=128K]
      Capabilities: [60] Power Management version 2
            Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
            Status: D0 PME-Enable- DSel=0 DScale=0 PME-
      Capabilities: [44] AGP version 2.0
            Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2,x4
            Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x4

02:00.0 SCSI storage controller: Adaptec AIC-7892B U160/m (rev 02)
      Subsystem: Adaptec 19160 Ultra160 SCSI Controller
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 32 (10000ns min, 6250ns max), cache line size 08
      Interrupt: pin A routed to IRQ 11
      BIST result: 00
      Region 0: I/O ports at 8000 [disabled] [size=256]
      Region 1: Memory at eb008000 (64-bit, non-prefetchable) [size=4K]
      Expansion ROM at <unassigned> [disabled] [size=128K]
      Capabilities: [dc] Power Management version 2
            Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
            Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev
01) (prog-if 02 [16550])
      Subsystem: US Robotics/3Com: Unknown device 00d7
      Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Interrupt: pin A routed to IRQ 11
      Region 0: I/O ports at 8400 [size=8]
      Capabilities: [dc] Power Management version 2
            Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold+)
            Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:03.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
04)
      Subsystem: Creative Labs CT4850 SBLive! Value
      Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 32 (500ns min, 5000ns max)
      Interrupt: pin A routed to IRQ 9
      Region 0: I/O ports at 8800 [size=32]
      Capabilities: [dc] Power Management version 1
            Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
            Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:03.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev
01)
      Subsystem: Creative Labs Gameport Joystick
      Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 32
      Region 0: I/O ports at 8c00 [size=8]
      Capabilities: [dc] Power Management version 1
            Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
            Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:07.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
      Subsystem: NEC Corporation USB
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 32 (250ns min, 10500ns max), cache line size 08
      Interrupt: pin A routed to IRQ 9
      Region 0: Memory at eb004000 (32-bit, non-prefetchable) [size=4K]
      Capabilities: [40] Power Management version 2
            Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
            Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:07.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
      Subsystem: NEC Corporation USB
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 32 (250ns min, 10500ns max), cache line size 08
      Interrupt: pin B routed to IRQ 11
      Region 0: Memory at eb005000 (32-bit, non-prefetchable) [size=4K]
      Capabilities: [40] Power Management version 2
            Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
            Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:07.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20
[EHCI])
      Subsystem: Giga-byte Technology: Unknown device 5004
      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 32 (4000ns min, 8500ns max), cache line size 08
      Interrupt: pin C routed to IRQ 5
      Region 0: Memory at eb006000 (32-bit, non-prefetchable) [size=256]
      Capabilities: [40] Power Management version 2
            Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
            Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (CNR) Ethernet
Controller (rev 82)
      Subsystem: Intel Corp.: Unknown device 3013
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 32 (2000ns min, 14000ns max), cache line size 08
      Interrupt: pin A routed to IRQ 5
      Region 0: Memory at eb007000 (32-bit, non-prefetchable) [size=4K]
      Region 1: I/O ports at 9000 [size=64]
      Capabilities: [dc] Power Management version 2
            Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
            Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:0c.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01)
(prog-if 85)
      Subsystem: Giga-byte Technology: Unknown device b001
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 32 (1000ns min, 4500ns max), cache line size 08
      Interrupt: pin A routed to IRQ 11
      Region 0: I/O ports at 9400 [size=8]
      Region 1: I/O ports at 9800 [size=4]
      Region 2: I/O ports at 9c00 [size=8]
      Region 3: I/O ports at a000 [size=4]
      Region 4: I/O ports at a400 [size=16]
      Region 5: Memory at eb000000 (32-bit, non-prefetchable) [size=16K]
      Capabilities: [60] Power Management version 1
            Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
            Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Does anyone have any ideas where I can go from here?  I'm willing to do
legwork, experiment, recompile, and all that, but I don't know where to
begin.  To start with, where should one *not* put printk's?  (Specifically
in the IDE subsystem, that is.)  Let me know what other information I can
provide that will help.

      Thanks

      Eddie

(See attached file: config-2.4.20-ac2.txt)
--
Edward Kuns
Technical Staff Member
Rockwell FirstPoint Contact
edward.kuns@rockwellfirstpoint.com
www.rockwellfirstpoint.com


--0__=09BBE602DFE814168f9e8a93df938690918c09BBE602DFE81416
Content-type: application/octet-stream; 
	name="config-2.4.20-ac2.txt"
Content-Disposition: attachment; filename="config-2.4.20-ac2.txt"
Content-transfer-encoding: base64

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMKQ09O
RklHX1g4Nj15CiMgQ09ORklHX1NCVVMgaXMgbm90IHNldApDT05GSUdfVUlEMTY9eQoKIwojIENv
ZGUgbWF0dXJpdHkgbGV2ZWwgb3B0aW9ucwojCkNPTkZJR19FWFBFUklNRU5UQUw9eQoKIwojIExv
YWRhYmxlIG1vZHVsZSBzdXBwb3J0CiMKQ09ORklHX01PRFVMRVM9eQpDT05GSUdfTU9EVkVSU0lP
TlM9eQpDT05GSUdfS01PRD15CgojCiMgUHJvY2Vzc29yIHR5cGUgYW5kIGZlYXR1cmVzCiMKIyBD
T05GSUdfTTM4NiBpcyBub3Qgc2V0CiMgQ09ORklHX000ODYgaXMgbm90IHNldAojIENPTkZJR19N
NTg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTTU4NlRTQyBpcyBub3Qgc2V0CiMgQ09ORklHX001ODZN
TVggaXMgbm90IHNldAojIENPTkZJR19NNjg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTVBFTlRJVU1J
SUkgaXMgbm90IHNldApDT05GSUdfTVBFTlRJVU00PXkKIyBDT05GSUdfTUs2IGlzIG5vdCBzZXQK
IyBDT05GSUdfTUs3IGlzIG5vdCBzZXQKIyBDT05GSUdfTUVMQU4gaXMgbm90IHNldAojIENPTkZJ
R19NQ1JVU09FIGlzIG5vdCBzZXQKIyBDT05GSUdfTVdJTkNISVBDNiBpcyBub3Qgc2V0CiMgQ09O
RklHX01XSU5DSElQMiBpcyBub3Qgc2V0CiMgQ09ORklHX01XSU5DSElQM0QgaXMgbm90IHNldAoj
IENPTkZJR19NQ1lSSVhJSUkgaXMgbm90IHNldApDT05GSUdfWDg2X1dQX1dPUktTX09LPXkKQ09O
RklHX1g4Nl9JTlZMUEc9eQpDT05GSUdfWDg2X0NNUFhDSEc9eQpDT05GSUdfWDg2X1hBREQ9eQpD
T05GSUdfWDg2X0JTV0FQPXkKQ09ORklHX1g4Nl9QT1BBRF9PSz15CiMgQ09ORklHX1JXU0VNX0dF
TkVSSUNfU1BJTkxPQ0sgaXMgbm90IHNldApDT05GSUdfUldTRU1fWENIR0FERF9BTEdPUklUSE09
eQpDT05GSUdfWDg2X0wxX0NBQ0hFX1NISUZUPTcKQ09ORklHX1g4Nl9UU0M9eQpDT05GSUdfWDg2
X0dPT0RfQVBJQz15CkNPTkZJR19YODZfUEdFPXkKQ09ORklHX1g4Nl9VU0VfUFBST19DSEVDS1NV
TT15CkNPTkZJR19YODZfRjAwRl9XT1JLU19PSz15CkNPTkZJR19YODZfTUNFPXkKIyBDT05GSUdf
Q1BVX0ZSRVEgaXMgbm90IHNldAojIENPTkZJR19UT1NISUJBIGlzIG5vdCBzZXQKIyBDT05GSUdf
SThLIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlDUk9DT0RFIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9N
U1I9eQpDT05GSUdfWDg2X0NQVUlEPXkKQ09ORklHX05PSElHSE1FTT15CiMgQ09ORklHX0hJR0hN
RU00RyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJR0hNRU02NEcgaXMgbm90IHNldAojIENPTkZJR19I
SUdITUVNIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFUSF9FTVVMQVRJT04gaXMgbm90IHNldApDT05G
SUdfTVRSUj15CiMgQ09ORklHX1NNUCBpcyBub3Qgc2V0CkNPTkZJR19YODZfVVBfQVBJQz15CkNP
TkZJR19YODZfVVBfSU9BUElDPXkKQ09ORklHX1g4Nl9MT0NBTF9BUElDPXkKQ09ORklHX1g4Nl9J
T19BUElDPXkKCiMKIyBHZW5lcmFsIHNldHVwCiMKQ09ORklHX05FVD15CkNPTkZJR19QQ0k9eQoj
IENPTkZJR19QQ0lfR09CSU9TIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX0dPRElSRUNUIGlzIG5v
dCBzZXQKQ09ORklHX1BDSV9HT0FOWT15CkNPTkZJR19QQ0lfQklPUz15CkNPTkZJR19QQ0lfRElS
RUNUPXkKQ09ORklHX0lTQT15CiMgQ09ORklHX1NDeDIwMCBpcyBub3Qgc2V0CkNPTkZJR19QQ0lf
TkFNRVM9eQojIENPTkZJR19FSVNBIGlzIG5vdCBzZXQKIyBDT05GSUdfTUNBIGlzIG5vdCBzZXQK
Q09ORklHX0hPVFBMVUc9eQoKIwojIFBDTUNJQS9DYXJkQnVzIHN1cHBvcnQKIwojIENPTkZJR19Q
Q01DSUEgaXMgbm90IHNldAoKIwojIFBDSSBIb3RwbHVnIFN1cHBvcnQKIwojIENPTkZJR19IT1RQ
TFVHX1BDSSBpcyBub3Qgc2V0CkNPTkZJR19TWVNWSVBDPXkKQ09ORklHX0JTRF9QUk9DRVNTX0FD
Q1Q9eQpDT05GSUdfU1lTQ1RMPXkKQ09ORklHX0tDT1JFX0VMRj15CiMgQ09ORklHX0tDT1JFX0FP
VVQgaXMgbm90IHNldApDT05GSUdfQklORk1UX0FPVVQ9eQpDT05GSUdfQklORk1UX0VMRj15CkNP
TkZJR19CSU5GTVRfTUlTQz15CkNPTkZJR19JS0NPTkZJRz15CkNPTkZJR19QTT15CkNPTkZJR19B
Q1BJPXkKIyBDT05GSUdfQUNQSV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX0JVU01HUj15
CkNPTkZJR19BQ1BJX1NZUz15CkNPTkZJR19BQ1BJX0NQVT15CkNPTkZJR19BQ1BJX0JVVFRPTj15
CkNPTkZJR19BQ1BJX0FDPXkKIyBDT05GSUdfQUNQSV9FQyBpcyBub3Qgc2V0CiMgQ09ORklHX0FQ
TSBpcyBub3Qgc2V0CgojCiMgTWVtb3J5IFRlY2hub2xvZ3kgRGV2aWNlcyAoTVREKQojCiMgQ09O
RklHX01URCBpcyBub3Qgc2V0CgojCiMgUGFyYWxsZWwgcG9ydCBzdXBwb3J0CiMKQ09ORklHX1BB
UlBPUlQ9bQpDT05GSUdfUEFSUE9SVF9QQz1tCkNPTkZJR19QQVJQT1JUX1BDX0NNTDE9bQojIENP
TkZJR19QQVJQT1JUX1NFUklBTCBpcyBub3Qgc2V0CkNPTkZJR19QQVJQT1JUX1BDX0ZJRk89eQoj
IENPTkZJR19QQVJQT1JUX1BDX1NVUEVSSU8gaXMgbm90IHNldAojIENPTkZJR19QQVJQT1JUX0FN
SUdBIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSUE9SVF9NRkMzIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFSUE9SVF9BVEFSSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUlBPUlRfR1NDIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFSUE9SVF9TVU5CUFAgaXMgbm90IHNldAojIENPTkZJR19QQVJQT1JUX09USEVS
IGlzIG5vdCBzZXQKQ09ORklHX1BBUlBPUlRfMTI4ND15CgojCiMgUGx1ZyBhbmQgUGxheSBjb25m
aWd1cmF0aW9uCiMKQ09ORklHX1BOUD15CkNPTkZJR19JU0FQTlA9eQpDT05GSUdfUE5QQklPUz15
CgojCiMgQmxvY2sgZGV2aWNlcwojCkNPTkZJR19CTEtfREVWX0ZEPXkKIyBDT05GSUdfQkxLX0RF
Vl9YRCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUklERSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19D
UFFfREEgaXMgbm90IHNldAojIENPTkZJR19CTEtfQ1BRX0NJU1NfREEgaXMgbm90IHNldAojIENP
TkZJR19CTEtfREVWX0RBQzk2MCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVU1FTSBpcyBu
b3Qgc2V0CkNPTkZJR19CTEtfREVWX0xPT1A9bQpDT05GSUdfQkxLX0RFVl9OQkQ9bQpDT05GSUdf
QkxLX0RFVl9SQU09eQpDT05GSUdfQkxLX0RFVl9SQU1fU0laRT00MDk2CkNPTkZJR19CTEtfREVW
X0lOSVRSRD15CkNPTkZJR19CTEtfU1RBVFM9eQoKIwojIE11bHRpLWRldmljZSBzdXBwb3J0IChS
QUlEIGFuZCBMVk0pCiMKQ09ORklHX01EPXkKQ09ORklHX0JMS19ERVZfTUQ9bQpDT05GSUdfTURf
TElORUFSPW0KQ09ORklHX01EX1JBSUQwPW0KQ09ORklHX01EX1JBSUQxPW0KQ09ORklHX01EX1JB
SUQ1PW0KIyBDT05GSUdfTURfTVVMVElQQVRIIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfTFZN
PW0KIyBDT05GSUdfQkxLX0RFVl9ETSBpcyBub3Qgc2V0CgojCiMgTmV0d29ya2luZyBvcHRpb25z
CiMKQ09ORklHX1BBQ0tFVD15CiMgQ09ORklHX1BBQ0tFVF9NTUFQIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUTElOS19ERVYgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSPXkKQ09ORklHX05FVEZJ
TFRFUl9ERUJVRz15CkNPTkZJR19GSUxURVI9eQpDT05GSUdfVU5JWD15CkNPTkZJR19JTkVUPXkK
Q09ORklHX0lQX01VTFRJQ0FTVD15CiMgQ09ORklHX0lQX0FEVkFOQ0VEX1JPVVRFUiBpcyBub3Qg
c2V0CiMgQ09ORklHX0lQX1BOUCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfSVBJUD1tCiMgQ09ORklH
X05FVF9JUEdSRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX01ST1VURSBpcyBub3Qgc2V0CiMgQ09O
RklHX0FSUEQgaXMgbm90IHNldAojIENPTkZJR19JTkVUX0VDTiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NZTl9DT09LSUVTIGlzIG5vdCBzZXQKCiMKIyAgIElQOiBOZXRmaWx0ZXIgQ29uZmlndXJhdGlv
bgojCkNPTkZJR19JUF9ORl9DT05OVFJBQ0s9bQpDT05GSUdfSVBfTkZfRlRQPW0KQ09ORklHX0lQ
X05GX0lSQz1tCkNPTkZJR19JUF9ORl9RVUVVRT1tCkNPTkZJR19JUF9ORl9JUFRBQkxFUz1tCkNP
TkZJR19JUF9ORl9NQVRDSF9MSU1JVD1tCkNPTkZJR19JUF9ORl9NQVRDSF9NQUM9bQpDT05GSUdf
SVBfTkZfTUFUQ0hfUEtUVFlQRT1tCkNPTkZJR19JUF9ORl9NQVRDSF9NQVJLPW0KQ09ORklHX0lQ
X05GX01BVENIX01VTFRJUE9SVD1tCkNPTkZJR19JUF9ORl9NQVRDSF9UT1M9bQojIENPTkZJR19J
UF9ORl9NQVRDSF9FQ04gaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9NQVRDSF9EU0NQIGlzIG5v
dCBzZXQKIyBDT05GSUdfSVBfTkZfTUFUQ0hfQUhfRVNQIGlzIG5vdCBzZXQKQ09ORklHX0lQX05G
X01BVENIX0xFTkdUSD1tCkNPTkZJR19JUF9ORl9NQVRDSF9UVEw9bQojIENPTkZJR19JUF9ORl9N
QVRDSF9UQ1BNU1MgaXMgbm90IHNldApDT05GSUdfSVBfTkZfTUFUQ0hfSEVMUEVSPW0KQ09ORklH
X0lQX05GX01BVENIX1NUQVRFPW0KQ09ORklHX0lQX05GX01BVENIX0NPTk5UUkFDSz1tCkNPTkZJ
R19JUF9ORl9NQVRDSF9VTkNMRUFOPW0KQ09ORklHX0lQX05GX01BVENIX09XTkVSPW0KQ09ORklH
X0lQX05GX0ZJTFRFUj1tCkNPTkZJR19JUF9ORl9UQVJHRVRfUkVKRUNUPW0KQ09ORklHX0lQX05G
X1RBUkdFVF9NSVJST1I9bQpDT05GSUdfSVBfTkZfTkFUPW0KQ09ORklHX0lQX05GX05BVF9ORUVE
RUQ9eQpDT05GSUdfSVBfTkZfVEFSR0VUX01BU1FVRVJBREU9bQpDT05GSUdfSVBfTkZfVEFSR0VU
X1JFRElSRUNUPW0KIyBDT05GSUdfSVBfTkZfTkFUX0xPQ0FMIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVBfTkZfTkFUX1NOTVBfQkFTSUMgaXMgbm90IHNldApDT05GSUdfSVBfTkZfTkFUX0lSQz1tCkNP
TkZJR19JUF9ORl9OQVRfRlRQPW0KQ09ORklHX0lQX05GX01BTkdMRT1tCkNPTkZJR19JUF9ORl9U
QVJHRVRfVE9TPW0KIyBDT05GSUdfSVBfTkZfVEFSR0VUX0VDTiBpcyBub3Qgc2V0CiMgQ09ORklH
X0lQX05GX1RBUkdFVF9EU0NQIGlzIG5vdCBzZXQKQ09ORklHX0lQX05GX1RBUkdFVF9NQVJLPW0K
Q09ORklHX0lQX05GX1RBUkdFVF9MT0c9bQojIENPTkZJR19JUF9ORl9UQVJHRVRfVUxPRyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lQX05GX1RBUkdFVF9UQ1BNU1MgaXMgbm90IHNldAojIENPTkZJR19J
UF9ORl9BUlBUQUJMRVMgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9DT01QQVRfSVBDSEFJTlMg
aXMgbm90IHNldAojIENPTkZJR19JUF9ORl9DT01QQVRfSVBGV0FETSBpcyBub3Qgc2V0CiMgQ09O
RklHX0lQVjYgaXMgbm90IHNldAojIENPTkZJR19LSFRUUEQgaXMgbm90IHNldAojIENPTkZJR19B
VE0gaXMgbm90IHNldAojIENPTkZJR19WTEFOXzgwMjFRIGlzIG5vdCBzZXQKCiMKIyAgCiMKIyBD
T05GSUdfSVBYIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBTEsgaXMgbm90IHNldAoKIwojIEFwcGxl
dGFsayBkZXZpY2VzCiMKIyBDT05GSUdfREVDTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfQlJJREdF
IGlzIG5vdCBzZXQKIyBDT05GSUdfWDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTEFQQiBpcyBub3Qg
c2V0CiMgQ09ORklHX0xMQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9ESVZFUlQgaXMgbm90IHNl
dAojIENPTkZJR19FQ09ORVQgaXMgbm90IHNldAojIENPTkZJR19XQU5fUk9VVEVSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX0ZBU1RST1VURSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9IV19GTE9X
Q09OVFJPTCBpcyBub3Qgc2V0CgojCiMgUW9TIGFuZC9vciBmYWlyIHF1ZXVlaW5nCiMKIyBDT05G
SUdfTkVUX1NDSEVEIGlzIG5vdCBzZXQKCiMKIyBOZXR3b3JrIHRlc3RpbmcKIwojIENPTkZJR19O
RVRfUEtUR0VOIGlzIG5vdCBzZXQKCiMKIyBUZWxlcGhvbnkgU3VwcG9ydAojCiMgQ09ORklHX1BI
T05FIGlzIG5vdCBzZXQKCiMKIyBBVEEvSURFL01GTS9STEwgc3VwcG9ydAojCkNPTkZJR19JREU9
eQoKIwojIElERSwgQVRBIGFuZCBBVEFQSSBCbG9jayBkZXZpY2VzCiMKQ09ORklHX0JMS19ERVZf
SURFPXkKCiMKIyBQbGVhc2Ugc2VlIERvY3VtZW50YXRpb24vaWRlLnR4dCBmb3IgaGVscC9pbmZv
IG9uIElERSBkcml2ZXMKIwojIENPTkZJR19CTEtfREVWX0hEX0lERSBpcyBub3Qgc2V0CiMgQ09O
RklHX0JMS19ERVZfSEQgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JREVESVNLPXkKQ09ORklH
X0lERURJU0tfTVVMVElfTU9ERT15CiMgQ09ORklHX0lERURJU0tfU1RST0tFIGlzIG5vdCBzZXQK
Q09ORklHX0JMS19ERVZfSURFQ0Q9eQojIENPTkZJR19CTEtfREVWX0lERVRBUEUgaXMgbm90IHNl
dAojIENPTkZJR19CTEtfREVWX0lERUZMT1BQWSBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lE
RVNDU0k9bQojIENPTkZJR19JREVfVEFTS19JT0NUTCBpcyBub3Qgc2V0CiMgQ09ORklHX0lERV9U
QVNLRklMRV9JTyBpcyBub3Qgc2V0CgojCiMgSURFIGNoaXBzZXQgc3VwcG9ydC9idWdmaXhlcwoj
CiMgQ09ORklHX0JMS19ERVZfQ01ENjQwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JU0FQ
TlAgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JREVQQ0k9eQojIENPTkZJR19CTEtfREVWX0dF
TkVSSUMgaXMgbm90IHNldApDT05GSUdfSURFUENJX1NIQVJFX0lSUT15CkNPTkZJR19CTEtfREVW
X0lERURNQV9QQ0k9eQojIENPTkZJR19CTEtfREVWX09GRkJPQVJEIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkxLX0RFVl9JREVETUFfRk9SQ0VEIGlzIG5vdCBzZXQKQ09ORklHX0lERURNQV9QQ0lfQVVU
Tz15CiMgQ09ORklHX0lERURNQV9PTkxZRElTSyBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lE
RURNQT15CiMgQ09ORklHX0lERURNQV9QQ0lfV0lQIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZf
QURNQT15CiMgQ09ORklHX0JMS19ERVZfQUVDNjJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfQUxJMTVYMyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQU1ENzRYWCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JMS19ERVZfQ01ENjRYIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DWTgy
QzY5MyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQ1M1NTMwIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkxLX0RFVl9IUFQzNFggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0hQVDM2NiBpcyBu
b3Qgc2V0CkNPTkZJR19CTEtfREVWX1BJSVg9eQojIENPTkZJR19CTEtfREVWX05GT1JDRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfTlM4NzQxNSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfT1BUSTYyMSBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX1BEQzIwMlhYX09MRD15CkNPTkZJ
R19QREMyMDJYWF9CVVJTVD15CiMgQ09ORklHX0JMS19ERVZfUERDMjAyWFhfTkVXIGlzIG5vdCBz
ZXQKQ09ORklHX0JMS19ERVZfUloxMDAwPXkKIyBDT05GSUdfQkxLX0RFVl9TQzEyMDAgaXMgbm90
IHNldAojIENPTkZJR19CTEtfREVWX1NWV0tTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9T
SUlNQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TSVM1NTEzIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkxLX0RFVl9TTEM5MEU2NiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVFJNMjkw
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9WSUE4MkNYWFggaXMgbm90IHNldAojIENPTkZJ
R19JREVfQ0hJUFNFVFMgaXMgbm90IHNldApDT05GSUdfSURFRE1BX0FVVE89eQojIENPTkZJR19J
REVETUFfSVZCIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1BX05PTlBDSSBpcyBub3Qgc2V0CkNPTkZJ
R19CTEtfREVWX1BEQzIwMlhYPXkKQ09ORklHX0JMS19ERVZfSURFX01PREVTPXkKQ09ORklHX0JM
S19ERVZfQVRBUkFJRD15CkNPTkZJR19CTEtfREVWX0FUQVJBSURfUERDPW0KIyBDT05GSUdfQkxL
X0RFVl9BVEFSQUlEX0hQVCBpcyBub3Qgc2V0CgojCiMgU0NTSSBzdXBwb3J0CiMKQ09ORklHX1ND
U0k9bQoKIwojIFNDU0kgc3VwcG9ydCB0eXBlIChkaXNrLCB0YXBlLCBDRC1ST00pCiMKQ09ORklH
X0JMS19ERVZfU0Q9bQpDT05GSUdfU0RfRVhUUkFfREVWUz00MApDT05GSUdfQ0hSX0RFVl9TVD1t
CiMgQ09ORklHX0NIUl9ERVZfT1NTVCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX1NSPW0KIyBD
T05GSUdfQkxLX0RFVl9TUl9WRU5ET1IgaXMgbm90IHNldApDT05GSUdfU1JfRVhUUkFfREVWUz0z
CkNPTkZJR19DSFJfREVWX1NHPW0KCiMKIyBTb21lIFNDU0kgZGV2aWNlcyAoZS5nLiBDRCBqdWtl
Ym94KSBzdXBwb3J0IG11bHRpcGxlIExVTnMKIwpDT05GSUdfU0NTSV9ERUJVR19RVUVVRVM9eQpD
T05GSUdfU0NTSV9NVUxUSV9MVU49eQpDT05GSUdfU0NTSV9DT05TVEFOVFM9eQpDT05GSUdfU0NT
SV9MT0dHSU5HPXkKCiMKIyBTQ1NJIGxvdy1sZXZlbCBkcml2ZXJzCiMKIyBDT05GSUdfQkxLX0RF
Vl8zV19YWFhYX1JBSUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJXzcwMDBGQVNTVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDU0lfQUNBUkQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FIQTE1Mlgg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FIQTE1NDIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X0FIQTE3NDAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FBQ1JBSUQgaXMgbm90IHNldApDT05G
SUdfU0NTSV9BSUM3WFhYPW0KQ09ORklHX0FJQzdYWFhfQ01EU19QRVJfREVWSUNFPTI1MwpDT05G
SUdfQUlDN1hYWF9SRVNFVF9ERUxBWV9NUz0xNTAwMAojIENPTkZJR19BSUM3WFhYX1BST0JFX0VJ
U0FfVkwgaXMgbm90IHNldAojIENPTkZJR19BSUM3WFhYX0JVSUxEX0ZJUk1XQVJFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9BSUM3WFhYX09MRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRFBU
X0kyTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQURWQU5TWVMgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX0lOMjAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQU01M0M5NzQgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX01FR0FSQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9CVVNMT0dJ
QyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQ1BRRkNUUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfRE1YMzE5MUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RUQzMyODAgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX0VBVEEgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0VBVEFfRE1BIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9FQVRBX1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRlVU
VVJFX0RPTUFJTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfR0RUSCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfR0VORVJJQ19OQ1I1MzgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JUFMgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0lOSVRJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSU5J
QTEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUFBBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9JTU0gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX05DUjUzQzQwNkEgaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX05DUjUzQzd4eCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1lNNTNDOFhYXzIg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX05DUjUzQzhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfU1lNNTNDOFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9QQVMxNiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfUENJMjAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUENJMjIyMEkgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX1BTSTI0MEkgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FM
T0dJQ19GQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMT0dJQ19JU1AgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX1FMT0dJQ19GQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxPR0lDXzEy
ODAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NFQUdBVEUgaXMgbm90IHNldAojIENPTkZJR19T
Q1NJX1NJTTcxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1lNNTNDNDE2IGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9EQzM5MFQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1QxMjggaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX1UxNF8zNEYgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1VMVFJB
U1RPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTlNQMzIgaXMgbm90IHNldAojIENPTkZJR19T
Q1NJX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBGdXNpb24gTVBUIGRldmljZSBzdXBwb3J0CiMKIyBD
T05GSUdfRlVTSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVTSU9OX0JPT1QgaXMgbm90IHNldAoj
IENPTkZJR19GVVNJT05fSVNFTlNFIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVTSU9OX0NUTCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0ZVU0lPTl9MQU4gaXMgbm90IHNldAoKIwojIElFRUUgMTM5NCAoRmly
ZVdpcmUpIHN1cHBvcnQgKEVYUEVSSU1FTlRBTCkKIwojIENPTkZJR19JRUVFMTM5NCBpcyBub3Qg
c2V0CgojCiMgSTJPIGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdfSTJPIGlzIG5vdCBzZXQKCiMK
IyBOZXR3b3JrIGRldmljZSBzdXBwb3J0CiMKQ09ORklHX05FVERFVklDRVM9eQoKIwojIEFSQ25l
dCBkZXZpY2VzCiMKIyBDT05GSUdfQVJDTkVUIGlzIG5vdCBzZXQKQ09ORklHX0RVTU1ZPW0KIyBD
T05GSUdfQk9ORElORyBpcyBub3Qgc2V0CiMgQ09ORklHX0VRVUFMSVpFUiBpcyBub3Qgc2V0CiMg
Q09ORklHX1RVTiBpcyBub3Qgc2V0CiMgQ09ORklHX0VUSEVSVEFQIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1NCMTAwMCBpcyBub3Qgc2V0CgojCiMgRXRoZXJuZXQgKDEwIG9yIDEwME1iaXQpCiMK
Q09ORklHX05FVF9FVEhFUk5FVD15CiMgQ09ORklHX0hBUFBZTUVBTCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NVTkdFTSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SXzNDT009eQojIENPTkZJR19F
TDEgaXMgbm90IHNldAojIENPTkZJR19FTDIgaXMgbm90IHNldAojIENPTkZJR19FTFBMVVMgaXMg
bm90IHNldAojIENPTkZJR19FTDE2IGlzIG5vdCBzZXQKIyBDT05GSUdfRUwzIGlzIG5vdCBzZXQK
IyBDT05GSUdfM0M1MTUgaXMgbm90IHNldApDT05GSUdfVk9SVEVYPW0KIyBDT05GSUdfTEFOQ0Ug
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1NNQyBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9WRU5ET1JfUkFDQUwgaXMgbm90IHNldAojIENPTkZJR19BVDE3MDAgaXMgbm90IHNldAojIENP
TkZJR19ERVBDQSBpcyBub3Qgc2V0CiMgQ09ORklHX0hQMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX0lTQSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfUENJPXkKIyBDT05GSUdfUENORVQzMiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FEQVBURUNfU1RBUkZJUkUgaXMgbm90IHNldAojIENPTkZJR19BQzMy
MDAgaXMgbm90IHNldAojIENPTkZJR19BUFJJQ09UIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1M4OXgw
IGlzIG5vdCBzZXQKQ09ORklHX1RVTElQPW0KIyBDT05GSUdfVFVMSVBfTVdJIGlzIG5vdCBzZXQK
IyBDT05GSUdfVFVMSVBfTU1JTyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFNFg1IGlzIG5vdCBzZXQK
IyBDT05GSUdfREdSUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RNOTEwMiBpcyBub3Qgc2V0CkNPTkZJ
R19FRVBSTzEwMD1tCkNPTkZJR19FMTAwPW0KIyBDT05GSUdfRkVBTE5YIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkFUU0VNSSBpcyBub3Qgc2V0CiMgQ09ORklHX05FMktfUENJIGlzIG5vdCBzZXQKIyBD
T05GSUdfODEzOUNQIGlzIG5vdCBzZXQKIyBDT05GSUdfODEzOVRPTyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NJUzkwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0VQSUMxMDAgaXMgbm90IHNldAojIENPTkZJ
R19TVU5EQU5DRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RMQU4gaXMgbm90IHNldAojIENPTkZJR19U
QzM1ODE1IGlzIG5vdCBzZXQKIyBDT05GSUdfVklBX1JISU5FIGlzIG5vdCBzZXQKIyBDT05GSUdf
V0lOQk9ORF84NDAgaXMgbm90IHNldAojIENPTkZJR19ORVRfUE9DS0VUIGlzIG5vdCBzZXQKCiMK
IyBFdGhlcm5ldCAoMTAwMCBNYml0KQojCiMgQ09ORklHX0FDRU5JQyBpcyBub3Qgc2V0CiMgQ09O
RklHX0RMMksgaXMgbm90IHNldAojIENPTkZJR19FMTAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX05T
ODM4MjAgaXMgbm90IHNldAojIENPTkZJR19IQU1BQ0hJIGlzIG5vdCBzZXQKIyBDT05GSUdfWUVM
TE9XRklOIGlzIG5vdCBzZXQKIyBDT05GSUdfU0s5OExJTiBpcyBub3Qgc2V0CiMgQ09ORklHX1RJ
R09OMyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZEREkgaXMgbm90IHNldAojIENPTkZJR19ISVBQSSBp
cyBub3Qgc2V0CiMgQ09ORklHX1BMSVAgaXMgbm90IHNldApDT05GSUdfUFBQPW0KIyBDT05GSUdf
UFBQX01VTFRJTElOSyBpcyBub3Qgc2V0CiMgQ09ORklHX1BQUF9GSUxURVIgaXMgbm90IHNldApD
T05GSUdfUFBQX0FTWU5DPW0KIyBDT05GSUdfUFBQX1NZTkNfVFRZIGlzIG5vdCBzZXQKQ09ORklH
X1BQUF9ERUZMQVRFPW0KQ09ORklHX1BQUF9CU0RDT01QPW0KQ09ORklHX1BQUE9FPW0KIyBDT05G
SUdfU0xJUCBpcyBub3Qgc2V0CgojCiMgV2lyZWxlc3MgTEFOIChub24taGFtcmFkaW8pCiMKIyBD
T05GSUdfTkVUX1JBRElPIGlzIG5vdCBzZXQKCiMKIyBUb2tlbiBSaW5nIGRldmljZXMKIwojIENP
TkZJR19UUiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9GQyBpcyBub3Qgc2V0CiMgQ09ORklHX1JD
UENJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0hBUEVSIGlzIG5vdCBzZXQKCiMKIyBXYW4gaW50ZXJm
YWNlcwojCiMgQ09ORklHX1dBTiBpcyBub3Qgc2V0CgojCiMgQW1hdGV1ciBSYWRpbyBzdXBwb3J0
CiMKIyBDT05GSUdfSEFNUkFESU8gaXMgbm90IHNldAoKIwojIElyREEgKGluZnJhcmVkKSBzdXBw
b3J0CiMKIyBDT05GSUdfSVJEQSBpcyBub3Qgc2V0CgojCiMgSVNETiBzdWJzeXN0ZW0KIwojIENP
TkZJR19JU0ROIGlzIG5vdCBzZXQKCiMKIyBPbGQgQ0QtUk9NIGRyaXZlcnMgKG5vdCBTQ1NJLCBu
b3QgSURFKQojCiMgQ09ORklHX0NEX05PX0lERVNDU0kgaXMgbm90IHNldAoKIwojIElucHV0IGNv
cmUgc3VwcG9ydAojCkNPTkZJR19JTlBVVD1tCkNPTkZJR19JTlBVVF9LRVlCREVWPW0KQ09ORklH
X0lOUFVUX01PVVNFREVWPW0KQ09ORklHX0lOUFVUX01PVVNFREVWX1NDUkVFTl9YPTEwMjQKQ09O
RklHX0lOUFVUX01PVVNFREVWX1NDUkVFTl9ZPTc2OAojIENPTkZJR19JTlBVVF9KT1lERVYgaXMg
bm90IHNldApDT05GSUdfSU5QVVRfRVZERVY9bQoKIwojIENoYXJhY3RlciBkZXZpY2VzCiMKQ09O
RklHX1ZUPXkKQ09ORklHX1ZUX0NPTlNPTEU9eQpDT05GSUdfU0VSSUFMPXkKIyBDT05GSUdfU0VS
SUFMX0NPTlNPTEUgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfRVhURU5ERUQgaXMgbm90IHNl
dAojIENPTkZJR19TRVJJQUxfTk9OU1RBTkRBUkQgaXMgbm90IHNldApDT05GSUdfVU5JWDk4X1BU
WVM9eQpDT05GSUdfVU5JWDk4X1BUWV9DT1VOVD0yNTYKQ09ORklHX1BSSU5URVI9bQojIENPTkZJ
R19MUF9DT05TT0xFIGlzIG5vdCBzZXQKQ09ORklHX1BQREVWPW0KIyBDT05GSUdfSFZDX0NPTlNP
TEUgaXMgbm90IHNldAoKIwojIEkyQyBzdXBwb3J0CiMKQ09ORklHX0kyQz1tCkNPTkZJR19JMkNf
QUxHT0JJVD1tCiMgQ09ORklHX0kyQ19QSElMSVBTUEFSIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJD
X0VMViBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19WRUxMRU1BTiBpcyBub3Qgc2V0CkNPTkZJR19T
Q3gyMDBfSTJDX1NDTD0xMgpDT05GSUdfU0N4MjAwX0kyQ19TREE9MTMKIyBDT05GSUdfU0N4MjAw
X0FDQiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEdPUENGIGlzIG5vdCBzZXQKQ09ORklHX0ky
Q19DSEFSREVWPW0KQ09ORklHX0kyQ19QUk9DPW0KCiMKIyBNaWNlCiMKIyBDT05GSUdfQlVTTU9V
U0UgaXMgbm90IHNldApDT05GSUdfTU9VU0U9eQpDT05GSUdfUFNNT1VTRT15CiMgQ09ORklHXzgy
QzcxMF9NT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BDMTEwX1BBRCBpcyBub3Qgc2V0CiMgQ09O
RklHX01LNzEyX01PVVNFIGlzIG5vdCBzZXQKCiMKIyBKb3lzdGlja3MKIwojIENPTkZJR19JTlBV
VF9HQU1FUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1NFUklPIGlzIG5vdCBzZXQKCiMK
IyBKb3lzdGlja3MKIwojIENPTkZJR19JTlBVVF9JRk9SQ0VfVVNCIGlzIG5vdCBzZXQKIyBDT05G
SUdfSU5QVVRfREI5IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfR0FNRUNPTiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lOUFVUX1RVUkJPR1JBRlggaXMgbm90IHNldAojIENPTkZJR19RSUMwMl9UQVBF
IGlzIG5vdCBzZXQKIyBDT05GSUdfSVBNSV9IQU5ETEVSIGlzIG5vdCBzZXQKCiMKIyBXYXRjaGRv
ZyBDYXJkcwojCiMgQ09ORklHX1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1EX1JORyBp
cyBub3Qgc2V0CkNPTkZJR19JTlRFTF9STkc9bQojIENPTkZJR19BTURfUE03NjggaXMgbm90IHNl
dApDT05GSUdfTlZSQU09bQpDT05GSUdfUlRDPW0KIyBDT05GSUdfRFRMSyBpcyBub3Qgc2V0CiMg
Q09ORklHX1IzOTY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQTElDT00gaXMgbm90IHNldAojIENP
TkZJR19TT05ZUEkgaXMgbm90IHNldAoKIwojIEZ0YXBlLCB0aGUgZmxvcHB5IHRhcGUgZGV2aWNl
IGRyaXZlcgojCiMgQ09ORklHX0ZUQVBFIGlzIG5vdCBzZXQKQ09ORklHX0FHUD15CkNPTkZJR19B
R1BfSU5URUw9eQpDT05GSUdfQUdQX0k4MTA9eQojIENPTkZJR19BR1BfVklBIGlzIG5vdCBzZXQK
IyBDT05GSUdfQUdQX0FNRCBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUF9BTURfODE1MSBpcyBub3Qg
c2V0CiMgQ09ORklHX0FHUF9TSVMgaXMgbm90IHNldAojIENPTkZJR19BR1BfQUxJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQUdQX1NXT1JLUyBpcyBub3Qgc2V0CkNPTkZJR19EUk09eQojIENPTkZJR19E
Uk1fT0xEIGlzIG5vdCBzZXQKCiMKIyBEUk0gNC4xIGRyaXZlcnMKIwpDT05GSUdfRFJNX05FVz15
CiMgQ09ORklHX0RSTV9UREZYIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1IxMjggaXMgbm90IHNl
dAojIENPTkZJR19EUk1fUkFERU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0k4MTAgaXMgbm90
IHNldAojIENPTkZJR19EUk1fSTgzMCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9NR0EgaXMgbm90
IHNldAojIENPTkZJR19EUk1fU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfTVdBVkUgaXMgbm90IHNl
dAoKIwojIE11bHRpbWVkaWEgZGV2aWNlcwojCkNPTkZJR19WSURFT19ERVY9bQoKIwojIFZpZGVv
IEZvciBMaW51eAojCkNPTkZJR19WSURFT19QUk9DX0ZTPXkKIyBDT05GSUdfSTJDX1BBUlBPUlQg
aXMgbm90IHNldAoKIwojIFZpZGVvIEFkYXB0ZXJzCiMKQ09ORklHX1ZJREVPX0JUODQ4PW0KIyBD
T05GSUdfVklERU9fUE1TIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fQldRQ0FNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVklERU9fQ1FDQU0gaXMgbm90IHNldAojIENPTkZJR19WSURFT19XOTk2NiBp
cyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX0NQSUEgaXMgbm90IHNldAojIENPTkZJR19WSURFT19T
QUE1MjQ5IGlzIG5vdCBzZXQKIyBDT05GSUdfVFVORVJfMzAzNiBpcyBub3Qgc2V0CiMgQ09ORklH
X1ZJREVPX1NUUkFESVMgaXMgbm90IHNldAojIENPTkZJR19WSURFT19aT1JBTiBpcyBub3Qgc2V0
CiMgQ09ORklHX1ZJREVPX1pSMzYxMjAgaXMgbm90IHNldAoKIwojIFJhZGlvIEFkYXB0ZXJzCiMK
IyBDT05GSUdfUkFESU9fQ0FERVQgaXMgbm90IHNldAojIENPTkZJR19SQURJT19SVFJBQ0sgaXMg
bm90IHNldAojIENPTkZJR19SQURJT19SVFJBQ0syIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFESU9f
QVpURUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFESU9fR0VNVEVLIGlzIG5vdCBzZXQKIyBDT05G
SUdfUkFESU9fR0VNVEVLX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1JBRElPX01BWElSQURJTyBp
cyBub3Qgc2V0CiMgQ09ORklHX1JBRElPX01BRVNUUk8gaXMgbm90IHNldAojIENPTkZJR19SQURJ
T19TRjE2Rk1JIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFESU9fU0YxNkZNUjIgaXMgbm90IHNldAoj
IENPTkZJR19SQURJT19URVJSQVRFQyBpcyBub3Qgc2V0CiMgQ09ORklHX1JBRElPX1RSVVNUIGlz
IG5vdCBzZXQKIyBDT05GSUdfUkFESU9fVFlQSE9PTiBpcyBub3Qgc2V0CiMgQ09ORklHX1JBRElP
X1pPTFRSSVggaXMgbm90IHNldAoKIwojIEZpbGUgc3lzdGVtcwojCiMgQ09ORklHX1FVT1RBIGlz
IG5vdCBzZXQKIyBDT05GSUdfQVVUT0ZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQVVUT0ZTNF9G
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFSVNFUkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQURG
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FGRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19IRlNf
RlMgaXMgbm90IHNldAojIENPTkZJR19CRUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkZTX0ZT
IGlzIG5vdCBzZXQKQ09ORklHX0VYVDNfRlM9bQpDT05GSUdfSkJEPW0KQ09ORklHX0pCRF9ERUJV
Rz15CkNPTkZJR19GQVRfRlM9bQpDT05GSUdfTVNET1NfRlM9bQojIENPTkZJR19VTVNET1NfRlMg
aXMgbm90IHNldApDT05GSUdfVkZBVF9GUz1tCiMgQ09ORklHX0VGU19GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSQU1GUyBpcyBub3Qgc2V0CkNPTkZJR19UTVBGUz15CkNPTkZJR19SQU1GUz15CkNP
TkZJR19JU085NjYwX0ZTPXkKQ09ORklHX0pPTElFVD15CkNPTkZJR19aSVNPRlM9eQojIENPTkZJ
R19KRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19NSU5JWF9GUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1ZYRlNfRlMgaXMgbm90IHNldApDT05GSUdfTlRGU19GUz1tCiMgQ09ORklHX05URlNfUlcgaXMg
bm90IHNldAojIENPTkZJR19IUEZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX1BST0NfRlM9eQojIENP
TkZJR19ERVZGU19GUyBpcyBub3Qgc2V0CkNPTkZJR19ERVZQVFNfRlM9eQojIENPTkZJR19RTlg0
RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19ST01GU19GUyBpcyBub3Qgc2V0CkNPTkZJR19FWFQy
X0ZTPXkKIyBDT05GSUdfU1lTVl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VERl9GUyBpcyBub3Qg
c2V0CkNPTkZJR19VRlNfRlM9bQojIENPTkZJR19VRlNfRlNfV1JJVEUgaXMgbm90IHNldAoKIwoj
IE5ldHdvcmsgRmlsZSBTeXN0ZW1zCiMKIyBDT05GSUdfQ09EQV9GUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0lOVEVSTUVaWk9fRlMgaXMgbm90IHNldApDT05GSUdfTkZTX0ZTPXkKIyBDT05GSUdfTkZT
X1YzIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTX0RJUkVDVElPIGlzIG5vdCBzZXQKQ09ORklHX05G
U0Q9eQojIENPTkZJR19ORlNEX1YzIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTRF9UQ1AgaXMgbm90
IHNldApDT05GSUdfU1VOUlBDPXkKQ09ORklHX0xPQ0tEPXkKQ09ORklHX1NNQl9GUz1tCiMgQ09O
RklHX1NNQl9OTFNfREVGQVVMVCBpcyBub3Qgc2V0CiMgQ09ORklHX05DUF9GUyBpcyBub3Qgc2V0
CkNPTkZJR19aSVNPRlNfRlM9eQoKIwojIFBhcnRpdGlvbiBUeXBlcwojCkNPTkZJR19QQVJUSVRJ
T05fQURWQU5DRUQ9eQojIENPTkZJR19BQ09STl9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJ
R19PU0ZfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1JR0FfUEFSVElUSU9OIGlzIG5v
dCBzZXQKIyBDT05GSUdfQVRBUklfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDX1BB
UlRJVElPTiBpcyBub3Qgc2V0CkNPTkZJR19NU0RPU19QQVJUSVRJT049eQojIENPTkZJR19CU0Rf
RElTS0xBQkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlOSVhfU1VCUEFSVElUSU9OIGlzIG5vdCBz
ZXQKQ09ORklHX1NPTEFSSVNfWDg2X1BBUlRJVElPTj15CiMgQ09ORklHX1VOSVhXQVJFX0RJU0tM
QUJFTCBpcyBub3Qgc2V0CiMgQ09ORklHX0xETV9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJ
R19TR0lfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfVUxUUklYX1BBUlRJVElPTiBpcyBu
b3Qgc2V0CkNPTkZJR19TVU5fUEFSVElUSU9OPXkKIyBDT05GSUdfRUZJX1BBUlRJVElPTiBpcyBu
b3Qgc2V0CkNPTkZJR19TTUJfTkxTPXkKQ09ORklHX05MUz15CgojCiMgTmF0aXZlIExhbmd1YWdl
IFN1cHBvcnQKIwpDT05GSUdfTkxTX0RFRkFVTFQ9Imlzbzg4NTktMSIKQ09ORklHX05MU19DT0RF
UEFHRV80Mzc9bQpDT05GSUdfTkxTX0NPREVQQUdFXzczNz1tCiMgQ09ORklHX05MU19DT0RFUEFH
RV83NzUgaXMgbm90IHNldApDT05GSUdfTkxTX0NPREVQQUdFXzg1MD1tCkNPTkZJR19OTFNfQ09E
RVBBR0VfODUyPW0KIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1NSBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19DT0RFUEFHRV84NTcgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYwIGlz
IG5vdCBzZXQKQ09ORklHX05MU19DT0RFUEFHRV84NjE9bQojIENPTkZJR19OTFNfQ09ERVBBR0Vf
ODYyIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MyBpcyBub3Qgc2V0CkNPTkZJ
R19OTFNfQ09ERVBBR0VfODY0PW0KIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NSBpcyBub3Qgc2V0
CkNPTkZJR19OTFNfQ09ERVBBR0VfODY2PW0KIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2OSBpcyBu
b3Qgc2V0CkNPTkZJR19OTFNfQ09ERVBBR0VfOTM2PW0KQ09ORklHX05MU19DT0RFUEFHRV85NTA9
bQpDT05GSUdfTkxTX0NPREVQQUdFXzkzMj1tCkNPTkZJR19OTFNfQ09ERVBBR0VfOTQ5PW0KQ09O
RklHX05MU19DT0RFUEFHRV84NzQ9bQojIENPTkZJR19OTFNfSVNPODg1OV84IGlzIG5vdCBzZXQK
Q09ORklHX05MU19DT0RFUEFHRV8xMjUwPW0KIyBDT05GSUdfTkxTX0NPREVQQUdFXzEyNTEgaXMg
bm90IHNldApDT05GSUdfTkxTX0lTTzg4NTlfMT1tCkNPTkZJR19OTFNfSVNPODg1OV8yPW0KIyBD
T05GSUdfTkxTX0lTTzg4NTlfMyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzQgaXMg
bm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV81IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lT
Tzg4NTlfNiBpcyBub3Qgc2V0CkNPTkZJR19OTFNfSVNPODg1OV83PW0KIyBDT05GSUdfTkxTX0lT
Tzg4NTlfOSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzEzIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0lTTzg4NTlfMTQgaXMgbm90IHNldApDT05GSUdfTkxTX0lTTzg4NTlfMTU9bQoj
IENPTkZJR19OTFNfS09JOF9SIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tPSThfVSBpcyBub3Qg
c2V0CkNPTkZJR19OTFNfVVRGOD1tCgojCiMgQ29uc29sZSBkcml2ZXJzCiMKQ09ORklHX1ZHQV9D
T05TT0xFPXkKQ09ORklHX1ZJREVPX1NFTEVDVD15CiMgQ09ORklHX01EQV9DT05TT0xFIGlzIG5v
dCBzZXQKCiMKIyBGcmFtZS1idWZmZXIgc3VwcG9ydAojCiMgQ09ORklHX0ZCIGlzIG5vdCBzZXQK
CiMKIyBTb3VuZAojCkNPTkZJR19TT1VORD1tCiMgQ09ORklHX1NPVU5EX0FMSTU0NTUgaXMgbm90
IHNldAojIENPTkZJR19TT1VORF9CVDg3OCBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX0NNUENJ
IGlzIG5vdCBzZXQKQ09ORklHX1NPVU5EX0VNVTEwSzE9bQojIENPTkZJR19NSURJX0VNVTEwSzEg
aXMgbm90IHNldAojIENPTkZJR19TT1VORF9GVVNJT04gaXMgbm90IHNldAojIENPTkZJR19TT1VO
RF9DUzQyODEgaXMgbm90IHNldAojIENPTkZJR19TT1VORF9FUzEzNzAgaXMgbm90IHNldApDT05G
SUdfU09VTkRfRVMxMzcxPW0KIyBDT05GSUdfU09VTkRfRVNTU09MTzEgaXMgbm90IHNldAojIENP
TkZJR19TT1VORF9NQUVTVFJPIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfTUFFU1RSTzMgaXMg
bm90IHNldAojIENPTkZJR19TT1VORF9GT1JURSBpcyBub3Qgc2V0CkNPTkZJR19TT1VORF9JQ0g9
bQojIENPTkZJR19TT1VORF9STUU5NlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfU09OSUNW
SUJFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX1RSSURFTlQgaXMgbm90IHNldAojIENPTkZJ
R19TT1VORF9NU05EQ0xBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX01TTkRQSU4gaXMgbm90
IHNldAojIENPTkZJR19TT1VORF9WSUE4MkNYWFggaXMgbm90IHNldAojIENPTkZJR19TT1VORF9P
U1MgaXMgbm90IHNldApDT05GSUdfU09VTkRfVFZNSVhFUj1tCgojCiMgVVNCIHN1cHBvcnQKIwpD
T05GSUdfVVNCPW0KIyBDT05GSUdfVVNCX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBNaXNjZWxsYW5l
b3VzIFVTQiBvcHRpb25zCiMKQ09ORklHX1VTQl9ERVZJQ0VGUz15CiMgQ09ORklHX1VTQl9CQU5E
V0lEVEggaXMgbm90IHNldAojIENPTkZJR19VU0JfTE9OR19USU1FT1VUIGlzIG5vdCBzZXQKCiMK
IyBVU0IgSG9zdCBDb250cm9sbGVyIERyaXZlcnMKIwpDT05GSUdfVVNCX0VIQ0lfSENEPW0KQ09O
RklHX1VTQl9VSENJPW0KIyBDT05GSUdfVVNCX1VIQ0lfQUxUIGlzIG5vdCBzZXQKQ09ORklHX1VT
Ql9PSENJPW0KCiMKIyBVU0IgRGV2aWNlIENsYXNzIGRyaXZlcnMKIwojIENPTkZJR19VU0JfQVVE
SU8gaXMgbm90IHNldAojIENPTkZJR19VU0JfQkxVRVRPT1RIIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX01JREkgaXMgbm90IHNldApDT05GSUdfVVNCX1NUT1JBR0U9bQojIENPTkZJR19VU0JfU1RP
UkFHRV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0RBVEFGQUIgaXMgbm90
IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9GUkVFQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NUT1JBR0VfSVNEMjAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfRFBDTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0hQODIwMGUgaXMgbm90IHNldApDT05GSUdfVVNC
X1NUT1JBR0VfU0REUjA5PXkKIyBDT05GSUdfVVNCX1NUT1JBR0VfU0REUjU1IGlzIG5vdCBzZXQK
Q09ORklHX1VTQl9TVE9SQUdFX0pVTVBTSE9UPXkKQ09ORklHX1VTQl9BQ009bQpDT05GSUdfVVNC
X1BSSU5URVI9bQoKIwojIFVTQiBIdW1hbiBJbnRlcmZhY2UgRGV2aWNlcyAoSElEKQojCkNPTkZJ
R19VU0JfSElEPW0KQ09ORklHX1VTQl9ISURJTlBVVD15CkNPTkZJR19VU0JfSElEREVWPXkKIyBD
T05GSUdfVVNCX0tCRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NT1VTRSBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9BSVBURUsgaXMgbm90IHNldAojIENPTkZJR19VU0JfV0FDT00gaXMgbm90IHNl
dAoKIwojIFVTQiBJbWFnaW5nIGRldmljZXMKIwojIENPTkZJR19VU0JfREMyWFggaXMgbm90IHNl
dAojIENPTkZJR19VU0JfTURDODAwIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9TQ0FOTkVSPW0KIyBD
T05GSUdfVVNCX01JQ1JPVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hQVVNCU0NTSSBpcyBu
b3Qgc2V0CgojCiMgVVNCIE11bHRpbWVkaWEgZGV2aWNlcwojCiMgQ09ORklHX1VTQl9JQk1DQU0g
aXMgbm90IHNldAojIENPTkZJR19VU0JfT1Y1MTEgaXMgbm90IHNldAojIENPTkZJR19VU0JfUFdD
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFNDAxIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NU
VjY4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9WSUNBTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9EU0JSIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0RBQlVTQiBpcyBub3Qgc2V0CgojCiMgVVNC
IE5ldHdvcmsgYWRhcHRvcnMKIwpDT05GSUdfVVNCX1BFR0FTVVM9bQojIENPTkZJR19VU0JfUlRM
ODE1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9LQVdFVEggaXMgbm90IHNldAojIENPTkZJR19V
U0JfQ0FUQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DRENFVEhFUiBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9VU0JORVQgaXMgbm90IHNldAoKIwojIFVTQiBwb3J0IGRyaXZlcnMKIwpDT05GSUdf
VVNCX1VTUzcyMD1tCgojCiMgVVNCIFNlcmlhbCBDb252ZXJ0ZXIgc3VwcG9ydAojCkNPTkZJR19V
U0JfU0VSSUFMPW0KQ09ORklHX1VTQl9TRVJJQUxfR0VORVJJQz15CkNPTkZJR19VU0JfU0VSSUFM
X0JFTEtJTj1tCiMgQ09ORklHX1VTQl9TRVJJQUxfV0hJVEVIRUFUIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NFUklBTF9ESUdJX0FDQ0VMRVBPUlQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VS
SUFMX0VNUEVHIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9GVERJX1NJTyBpcyBub3Qg
c2V0CkNPTkZJR19VU0JfU0VSSUFMX1ZJU09SPW0KIyBDT05GSUdfVVNCX1NFUklBTF9JUEFRIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9JUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9T
RVJJQUxfRURHRVBPUlQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0VER0VQT1JUX1RJ
IGlzIG5vdCBzZXQKQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTl9QREE9bQpDT05GSUdfVVNCX1NF
UklBTF9LRVlTUEFOPW0KIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTI4IGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTI4WCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9TRVJJQUxfS0VZU1BBTl9VU0EyOFhBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9LRVlTUEFOX1VTQTI4WEIgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5f
VVNBMTkgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fVVNBMThYIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTE5VyBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TRVJJQUxfS0VZU1BBTl9VU0ExOVFXIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NF
UklBTF9LRVlTUEFOX1VTQTE5UUkgaXMgbm90IHNldApDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFO
X1VTQTQ5Vz15CiMgQ09ORklHX1VTQl9TRVJJQUxfTUNUX1UyMzIgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfU0VSSUFMX0tMU0kgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1BMMjMwMyBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfQ1lCRVJKQUNLIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NFUklBTF9YSVJDT00gaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX09NTklO
RVQgaXMgbm90IHNldAoKIwojIFVTQiBNaXNjZWxsYW5lb3VzIGRyaXZlcnMKIwojIENPTkZJR19V
U0JfUklPNTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0FVRVJTV0FMRCBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9USUdMIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0JSTFZHRVIgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfTENEIGlzIG5vdCBzZXQKCiMKIyBCbHVldG9vdGggc3VwcG9ydAojCiMg
Q09ORklHX0JMVUVaIGlzIG5vdCBzZXQKCiMKIyBLZXJuZWwgaGFja2luZwojCkNPTkZJR19ERUJV
R19LRVJORUw9eQpDT05GSUdfREVCVUdfU1RBQ0tPVkVSRkxPVz15CkNPTkZJR19GUkFNRV9QT0lO
VEVSPXkKIyBDT05GSUdfREVCVUdfSElHSE1FTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NM
QUIgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19JT1ZJUlQgaXMgbm90IHNldApDT05GSUdfTUFH
SUNfU1lTUlE9eQpDT05GSUdfUEFOSUNfTU9SU0U9eQojIENPTkZJR19ERUJVR19TUElOTE9DSyBp
cyBub3Qgc2V0CgojCiMgTGlicmFyeSByb3V0aW5lcwojCkNPTkZJR19aTElCX0lORkxBVEU9eQpD
T05GSUdfWkxJQl9ERUZMQVRFPW0K

--0__=09BBE602DFE814168f9e8a93df938690918c09BBE602DFE81416--

