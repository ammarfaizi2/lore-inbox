Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTIRS0L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 14:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTIRS0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 14:26:11 -0400
Received: from mta04bw.bigpond.com ([144.135.24.150]:40425 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP id S262037AbTIRSYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 14:24:33 -0400
Date: Sun, 21 Sep 2003 06:23:17 +1000
From: Ben Peddell <killer.lightspeed@bigpond.com>
Subject: Problem with PIO with ide-scsi in Kernel 2.4.22
To: lkml <linux-kernel@vger.kernel.org>
Reply-to: killer.lightspeed@bigpond.com
Message-id: <3F6CB735.9000307@bigpond.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had a problem with the ide-scsi (ATAPI SCSI emulation) module with 
Linux 2.4.22.

When I disable DMA and read the CD-ROM, it reads a random amount up to 
about 1MB, and then has a timeout.
This never happened with linux-2.4.19-16mdk. I have even tried feeding 
the old settings into the configurator, but without success.
Here, I've set the log level to 9:

    # hdparm -d1 /dev/hdc

    /dev/hdc:
     setting using_dma to 1 (on)
     using_dma    =  1 (on)
    # dd if=/dev/cdrom of=/dev/null
    403932+0 records in
    403932+0 records out
    # hdparm -d0 /dev/hdc

    /dev/hdc:
     setting using_dma to 0 (off)
    hdc: DMA disabled
     using_dma    =  0 (off)
    # dd if=/dev/cdrom of=/dev/null
    scsi : aborting command due to timeout : pid 13970, scsi0, channel 
0, id 0, lun 0 Read (10) 00 00 00 12 a4 00 00 3f 00
    hdc: irq timeout: status=0xd0 { Busy }
    scsi : aborting command due to timeout : pid 13971, scsi0, channel 
0, id 0, lun 0 Read (10) 00 00 00 12 e3 00 00 01 00
    hdc: ATAPI reset complete
    hdc: irq timeout: status=0xd0 { Busy }
    hdc: ATAPI reset complete
     I/O error: dev 0b:00, sector 19088
     I/O error: dev 0b:00, sector 19088
    dd: reading `/dev/cdrom': Input/output error
    19088+0 records in
    19088+0 records out
    # hdparm -d1 /dev/hdc

    /dev/hdc:
     setting using_dma to 1 (on)
     using_dma    =  1 (on)
    # dd if=/dev/cdrom of=/dev/null
    403932+0 records in
    403932+0 records out
    # dd if=/dev/vcs of=~/showprob.vcs

/dev/cdrom is a symbolic link to /dev/scd0, which is itself a symbolic 
link to /dev/scsi/host0/bus0/target0/lun0/cd
    ] ls -l /dev/cdrom /dev/scd0 /dev/sg0 /dev/sr0
    lr-xr-xr-x    1 root     root            4 Sep 21  2003 /dev/cdrom 
-> scd0
    lr-xr-xr-x    1 root     root           31 Sep 21  2003 /dev/scd0 -> 
scsi/host0/bus0/target0/lun0/cd
    lr-xr-xr-x    1 root     root           36 Sep 21  2003 /dev/sg0 -> 
scsi/host0/bus0/target0/lun0/generic
    lr-xr-xr-x    1 root     root            4 Sep 21  2003 /dev/sr0 -> scd0

Here's some info:
My motherboard is an ECS K7S5A-Pro.
I have added lm_sensors-2.6.2 and supermount-1.2.9-2.4.22 to the kernel.
The kernel was downloaded from 
ftp://ftp.kernel.org/pub/linux/kernel/v2.4/linux-2.4.22.tar.bz2
The rest of this message contains the output of lspci and dmesg, and the 
configuration.

    # uname -a
    Linux localhost.localdomain 2.4.22 #2 Sun Sep 21 00:30:00 EST 2003 
i686 unknown unknown GNU/Linux
    # lspci -vv
    00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
            Latency: 32
            Region 0: Memory at d0000000 (32-bit, non-prefetchable) 
[size=64M]
            Capabilities: [c0] AGP version 2.0
                    Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                    Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x4

    00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP 
(prog-if 00 [Normal decode])
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64
            Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
            Memory behind bridge: cde00000-cfefffff
            Prefetchable memory behind bridge: bdc00000-cdcfffff
            BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

    00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
            Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 0

    00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 
07) (prog-if 10 [OHCI])
            Subsystem: Silicon Integrated Systems [SiS] 7001
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64 (20000ns max), cache line size 08
            Interrupt: pin D routed to IRQ 10
            Region 0: Memory at cfffe000 (32-bit, non-prefetchable) 
[size=4K]

    00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 
07) (prog-if 10 [OHCI])
            Subsystem: Silicon Integrated Systems [SiS] 7001
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64 (20000ns max), cache line size 08
            Interrupt: pin A routed to IRQ 5
            Region 0: Memory at cffff000 (32-bit, non-prefetchable) 
[size=4K]

    00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] 
(rev d0) (prog-if 80 [Master])
            Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE 
Controller (A,B step)
            Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 128
            Region 4: I/O ports at ff00 [size=16]

    00:02.7 Multimedia audio controller: Silicon Integrated Systems 
[SiS] SiS7012 PCI Audio Accelerator (rev a0)
            Subsystem: C-Media Electronics Inc: Unknown device 0300
            Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64 (13000ns min, 2750ns max)
            Interrupt: pin C routed to IRQ 10
            Region 0: I/O ports at dc00 [size=256]
            Region 1: I/O ports at d800 [size=64]
            Capabilities: [48] Power Management version 2
                    Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-

    00:0f.0 Communication controller: Lucent Microelectronics LT 
WinModem (rev 02)
            Subsystem: Lucent Microelectronics LT WinModem
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64 (63000ns min, 3500ns max)
            Interrupt: pin A routed to IRQ 10
            Region 0: Memory at cfffdf00 (32-bit, non-prefetchable) 
[size=256]
            Region 1: I/O ports at d400 [size=8]
            Region 2: I/O ports at d000 [size=256]
            Capabilities: [f8] Power Management version 2
                    Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold-)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
   
    00:13.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 
00 [UHCI])
            Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64, cache line size 08
            Interrupt: pin A routed to IRQ 11
            Region 4: I/O ports at c800 [size=32]
            Capabilities: [80] Power Management version 2
                    Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
   
    00:13.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 
00 [UHCI])
            Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64, cache line size 08
            Interrupt: pin B routed to IRQ 11
            Region 4: I/O ports at cc00 [size=32]
            Capabilities: [80] Power Management version 2
                    Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
   
    00:13.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) 
(prog-if 20 [EHCI])
            Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device 
1234
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64, cache line size 10
            Interrupt: pin C routed to IRQ 10
            Region 0: Memory at cfffde00 (32-bit, non-prefetchable) 
[size=256]
            Capabilities: [80] Power Management version 2
                    Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-

    01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 
MX] (rev b2) (prog-if 00 [VGA])
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 248 (1250ns min, 250ns max)
            Interrupt: pin A routed to IRQ 11
            Region 0: Memory at ce000000 (32-bit, non-prefetchable) 
[size=16M]
            Region 1: Memory at c0000000 (32-bit, prefetchable) [size=128M]
            Expansion ROM at cfef0000 [disabled] [size=64K]
            Capabilities: [60] Power Management version 2
                    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
            Capabilities: [44] AGP version 2.0
                    Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2,x4
                    Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x4
   
    # dmesg
    Linux version 2.4.22 (root@localhost.localdomain) (gcc version 3.2 
(Mandrake Linux 9.0 3.2-1mdk)) #2 Sun Sep 21 00:30:00 EST 2003
    BIOS-provided physical RAM map:
     BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
     BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
     BIOS-e820: 00000000000ec000 - 0000000000100000 (reserved)
     BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
     BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
     BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
     BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
     BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
     BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
     BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
    255MB LOWMEM available.
    ACPI: have wakeup address 0xc0001000
    On node 0 totalpages: 65520
    zone(0): 4096 pages.
    zone(1): 61424 pages.
    zone(2): 0 pages.
    ACPI: RSDP (v000 AMI                                       ) @ 
0x000fa340
    ACPI: RSDT (v001 AMIINT SiS735XX 0x00001000 MSFT 0x0100000b) @ 
0x0fff0000
    ACPI: FADT (v001 AMIINT SiS735XX 0x00001000 MSFT 0x0100000b) @ 
0x0fff0030
    ACPI: DSDT (v001    SiS      735 0x00000100 MSFT 0x0100000d) @ 
0x00000000
    ACPI: MADT not present
    Kernel command line: BOOT_IMAGE=linux ro root=306 devfs=mount 
hdc=ide-scsi
    ide_setup: hdc=ide-scsi
    Local APIC disabled by BIOS -- reenabling.
    Found and enabled local APIC!
    Initializing CPU#0
    Detected 1294.501 MHz processor.
    Console: colour dummy device 80x25
    Calibrating delay loop... 2582.11 BogoMIPS
    Memory: 254916k/262080k available (2535k kernel code, 6776k 
reserved, 818k data, 176k init, 0k highmem)
    Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
    Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
    Mount cache hash table entries: 512 (order: 0, 4096 bytes)
    Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
    Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
    CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
    CPU: L2 Cache: 64K (64 bytes/line)
    Intel machine check architecture supported.
    Intel machine check reporting enabled on CPU#0.
    CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
    CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
    CPU: AMD Duron(tm) Processor stepping 01
    Enabling fast FPU save and restore... done.
    Enabling unmasked SIMD FPU exception support... done.
    Checking 'hlt' instruction... OK.
    POSIX conformance testing by UNIFIX
    enabled ExtINT on CPU#0
    ESR value before enabling vector: 00000000
    ESR value after enabling vector: 00000000
    Using local APIC timer interrupts.
    calibrating APIC timer ...
    ..... CPU clock speed is 1294.5269 MHz.
    ..... host bus clock speed is 199.1580 MHz.
    cpu: 0, clocks: 1991580, slice: 995790
    CPU0<T0:1991568,T1:995776,D:2,S:995790,C:1991580>
    mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
    mtrr: detected mtrr type: Intel
    ACPI: Subsystem revision 20030813
    PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
    PCI: Using configuration type 1
    ACPI: Interpreter enabled
    ACPI: Using PIC for interrupt routing
    ACPI: System [ACPI] (supports S0 S1 S4 S5)
    ACPI: PCI Root Bridge [PCI0] (00:00)
    PCI: Probing PCI hardware (bus 00)
    ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
    ACPI: Power Resource [URP1] (off)
    ACPI: Power Resource [URP2] (off)
    ACPI: Power Resource [FDDP] (off)
    ACPI: Power Resource [LPTP] (off)
    ACPI: PCI Interrupt Link [LNKA] (IRQs *11)
    ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
    ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 12 14 15)
    ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 *12 14 15)
    ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 12 14 15, disabled)
    ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 12 14 15, disabled)
    ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 12 14 15, disabled)
    ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 7 10 12 14 15)
    PCI: Probing PCI hardware
    ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
    ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
    ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
    ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
    ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
    PCI: Using ACPI for IRQ routing
    PCI: if you experience problems, try using option 'pci=noacpi' or 
even 'acpi=off'
    isapnp: Scanning for PnP cards...
    isapnp: No Plug & Play device found
    Linux NET4.0 for Linux 2.4
    Based upon Swansea University Computer Society NET3.039
    Initializing RT netlink socket
    Starting kswapd
    VFS: Disk quotas vdquot_6.5.1
    Journalled Block Device driver loaded
    devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
    devfs: boot_options: 0x1
    Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
    udf: registering filesystem
    ACPI: Power Button (FF) [PWRF]
    ACPI: Sleep Button (CM) [SLPB]
    ACPI: Processor [CPU1] (supports C1)
    parport0: PC-style at 0x378 [PCSPP,TRISTATE]
    i2c-core.o: i2c core module
    i2c-dev.o: i2c /dev entries driver module
    i2c-core.o: driver i2c-dev dummy driver registered.
    i2c-algo-bit.o: i2c bit algorithm module
    i2c-proc.o version 2.6.1 (20010825)
    i2c-isa.o version 2.6.2 (20011118)
    i2c-dev.o: Registered 'ISA main adapter' as minor 0
    i2c-core.o: adapter ISA main adapter registered as adapter 0.
    i2c-isa.o: ISA bus access for i2c modules initialized.
    vesafb: framebuffer at 0xc0000000, mapped to 0xd0814000, size 3072k
    vesafb: mode is 1024x768x16, linelength=2048, pages=0
    vesafb: protected mode interface info at c000:c480
    vesafb: scrolling: redraw
    vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
    Console: switching to colour frame buffer device 128x48
    fb0: VESA VGA frame buffer device
    pty: 256 Unix98 ptys configured
    ddcmon.o version 2.6.2 (20011118)
    i2c-core.o: driver DDCMON READER registered.
    eeprom.o version 2.6.2 (20011118)
    i2c-core.o: driver EEPROM READER registered.
    it87.o version 2.6.2 (20011118)
    i2c-core.o: driver IT87xx sensor driver registered.
    i2c-core.o: client [IT87 chip] registered to adapter [ISA main 
adapter](pos. 0).
    Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
    Software Watchdog Timer: 0.05, timer margin: 60 sec
    Floppy drive(s): fd0 is 1.44M
    FDC 0 is a post-1991 82077
    RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
    loop: loaded (max 255 devices)
    PPP generic driver version 2.4.2
    PPP Deflate Compression module registered
    PPP BSD Compression module registered
    Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
    Linux agpgart interface v0.99 (c) Jeff Hartmann
    agpgart: Maximum main memory to use for agp memory: 203M
    agpgart: Detected SiS 735 chipset
    agpgart: AGP aperture is 64M @ 0xd0000000
    [drm] Initialized tdfx 1.0.0 20010216 on minor 0
    [drm] AGP 0.99 on SiS @ 0xd0000000 64MB
    [drm] Initialized radeon 1.1.1 20010405 on minor 1
    [drm] AGP 0.99 on SiS @ 0xd0000000 64MB
    [drm] Initialized i810 1.2.0 20010920 on minor 2
    Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
    ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
    SIS5513: IDE controller at PCI slot 00:02.5
    SIS5513: chipset revision 208
    SIS5513: not 100% native mode: will probe irqs later
    SIS5513: SiS735 ATA 100 (2nd gen) controller
        ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
        ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
    hda: ST340810A, ATA DISK drive
    blk: queue c04a6500, I/O limit 4095Mb (mask 0xffffffff)
    hdc: LITE-ON COMBO LTC-48161H, ATAPI CD/DVD-ROM drive
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    ide1 at 0x170-0x177,0x376 on irq 15
    hda: attached ide-disk driver.
    hda: host protected area => 1
    hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, 
UDMA(100)
    hdc: attached ide-scsi driver.
    Partition check:
     /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 > p4
    ide: late registration of driver.
    SCSI subsystem driver Revision: 1.00
    scsi0 : SCSI host adapter emulation for IDE ATAPI devices
      Vendor: LITE-ON   Model: COMBO LTC-48161H  Rev: KH0G
      Type:   CD-ROM                             ANSI SCSI revision: 02
    Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
    sr0: scsi3-mmc drive: 24x/48x writer cd/rw xa/form2 cdda tray
    Uniform CD-ROM driver Revision: 3.12
    usb.c: registered new driver usbdevfs
    usb.c: registered new driver hub
    ehci_hcd 00:13.2: VIA Technologies, Inc. USB 2.0
    ehci_hcd 00:13.2: irq 10, pci mem d0b2fe00
    usb.c: new USB bus registered, assigned bus number 1
    PCI: 00:13.2 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.
    PCI: 00:13.2 PCI cache line size corrected to 64.
    ehci_hcd 00:13.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jun-19/2.4
    hub.c: USB hub found
    hub.c: 4 ports detected
    host/usb-uhci.c: $Revision: 1.275 $ time 00:30:15 Sep 21 2003
    host/usb-uhci.c: High bandwidth mode enabled
    host/usb-uhci.c: USB UHCI at I/O 0xcc00, IRQ 11
    host/usb-uhci.c: Detected 2 ports
    usb.c: new USB bus registered, assigned bus number 2
    hub.c: USB hub found
    hub.c: 2 ports detected
    host/usb-uhci.c: USB UHCI at I/O 0xc800, IRQ 11
    host/usb-uhci.c: Detected 2 ports
    usb.c: new USB bus registered, assigned bus number 3
    hub.c: USB hub found
    hub.c: 2 ports detected
    host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
    host/usb-ohci.c: USB OHCI at membase 0xd0b31000, IRQ 5
    host/usb-ohci.c: usb-00:02.3, Silicon Integrated Systems [SiS] USB 
1.0 Controller (#2)
    usb.c: new USB bus registered, assigned bus number 4
    hub.c: USB hub found
    hub.c: 3 ports detected
    host/usb-ohci.c: USB OHCI at membase 0xd0b33000, IRQ 10
    host/usb-ohci.c: usb-00:02.2, Silicon Integrated Systems [SiS] USB 
1.0 Controller
    usb.c: new USB bus registered, assigned bus number 5
    hub.c: USB hub found
    hub.c: 3 ports detected
    usb.c: registered new driver hiddev
    usb.c: registered new driver hid
    hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
    hid-core.c: USB HID support drivers
    usb.c: registered new driver usblp
    printer.c: v0.11: USB Printer Device Class driver
    Initializing USB Mass Storage driver...
    usb.c: registered new driver usb-storage
    USB Mass Storage support registered.
    mice: PS/2 mouse device common for all mice
    md: linear personality registered as nr 1
    md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
    md: Autodetecting RAID arrays.
    md: autorun ...
    md: ... autorun DONE.
    LVM version 1.0.5+(22/07/2002)
    Initializing Cryptographic API
    NET4: Linux TCP/IP 1.0 for NET4.0
    IP Protocols: ICMP, UDP, TCP, IGMP
    IP: routing cache hash table of 2048 buckets, 16Kbytes
    TCP: Hash tables configured (established 16384 bind 32768)
    NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
    RAMDISK: Compressed image found at block 0
    Freeing initrd memory: 58k freed
    VFS: Mounted root (ext2 filesystem).
    Mounted devfs on /dev
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    Mounted devfs on /dev
    Freeing unused kernel memory: 176k freed
    hub.c: new USB device 00:13.0-2, assigned address 2
    input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb3:2.0
    EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
    # grep 'CONFIG_' /boot/config-2.4.22 | grep '='
    CONFIG_X86=y
    CONFIG_UID16=y
    CONFIG_EXPERIMENTAL=y
    CONFIG_MODULES=y
    CONFIG_MODVERSIONS=y
    CONFIG_KMOD=y
    CONFIG_MK7=y
    CONFIG_X86_WP_WORKS_OK=y
    CONFIG_X86_INVLPG=y
    CONFIG_X86_CMPXCHG=y
    CONFIG_X86_XADD=y
    CONFIG_X86_BSWAP=y
    CONFIG_X86_POPAD_OK=y
    CONFIG_RWSEM_XCHGADD_ALGORITHM=y
    CONFIG_X86_L1_CACHE_SHIFT=6
    CONFIG_X86_HAS_TSC=y
    CONFIG_X86_GOOD_APIC=y
    CONFIG_X86_USE_3DNOW=y
    CONFIG_X86_PGE=y
    CONFIG_X86_USE_PPRO_CHECKSUM=y
    CONFIG_X86_F00F_WORKS_OK=y
    CONFIG_X86_MCE=y
    CONFIG_X86_MSR=y
    CONFIG_X86_CPUID=y
    CONFIG_NOHIGHMEM=y
    CONFIG_MTRR=y
    CONFIG_X86_UP_APIC=y
    CONFIG_X86_UP_IOAPIC=y
    CONFIG_X86_LOCAL_APIC=y
    CONFIG_X86_IO_APIC=y
    CONFIG_X86_TSC=y
    CONFIG_NET=y
    CONFIG_PCI=y
    CONFIG_PCI_GOANY=y
    CONFIG_PCI_BIOS=y
    CONFIG_PCI_DIRECT=y
    CONFIG_ISA=y
    CONFIG_PCI_NAMES=y
    CONFIG_HOTPLUG=y
    CONFIG_SYSVIPC=y
    CONFIG_BSD_PROCESS_ACCT=y
    CONFIG_SYSCTL=y
    CONFIG_KCORE_ELF=y
    CONFIG_BINFMT_AOUT=y
    CONFIG_BINFMT_ELF=y
    CONFIG_BINFMT_MISC=y
    CONFIG_PM=y
    CONFIG_APM=m
    CONFIG_APM_DO_ENABLE=y
    CONFIG_APM_CPU_IDLE=y
    CONFIG_APM_DISPLAY_BLANK=y
    CONFIG_ACPI=y
    CONFIG_ACPI_BOOT=y
    CONFIG_ACPI_BUS=y
    CONFIG_ACPI_INTERPRETER=y
    CONFIG_ACPI_EC=y
    CONFIG_ACPI_POWER=y
    CONFIG_ACPI_PCI=y
    CONFIG_ACPI_SLEEP=y
    CONFIG_ACPI_SYSTEM=y
    CONFIG_ACPI_BUTTON=y
    CONFIG_ACPI_FAN=y
    CONFIG_ACPI_PROCESSOR=y
    CONFIG_ACPI_THERMAL=y
    CONFIG_MTD=y
    CONFIG_PARPORT=y
    CONFIG_PARPORT_PC=y
    CONFIG_PARPORT_PC_CML1=y
    CONFIG_PARPORT_SERIAL=y
    CONFIG_PARPORT_PC_FIFO=y
    CONFIG_PARPORT_PC_SUPERIO=y
    CONFIG_PARPORT_1284=y
    CONFIG_PNP=y
    CONFIG_ISAPNP=y
    CONFIG_BLK_DEV_FD=y
    CONFIG_BLK_DEV_LOOP=y
    CONFIG_BLK_DEV_NBD=y
    CONFIG_BLK_DEV_RAM=y
    CONFIG_BLK_DEV_RAM_SIZE=32768
    CONFIG_BLK_DEV_INITRD=y
    CONFIG_BLK_STATS=y
    CONFIG_MD=y
    CONFIG_BLK_DEV_MD=y
    CONFIG_MD_LINEAR=y
    CONFIG_MD_RAID0=m
    CONFIG_MD_RAID1=m
    CONFIG_MD_RAID5=m
    CONFIG_MD_MULTIPATH=m
    CONFIG_BLK_DEV_LVM=y
    CONFIG_PACKET=y
    CONFIG_PACKET_MMAP=y
    CONFIG_NETFILTER=y
    CONFIG_FILTER=y
    CONFIG_UNIX=y
    CONFIG_INET=y
    CONFIG_IP_MULTICAST=y
    CONFIG_SYN_COOKIES=y
    CONFIG_IP_NF_CONNTRACK=m
    CONFIG_IP_NF_FTP=m
    CONFIG_IP_NF_AMANDA=m
    CONFIG_IP_NF_TFTP=m
    CONFIG_IP_NF_IRC=m
    CONFIG_IP_NF_QUEUE=m
    CONFIG_IP_NF_IPTABLES=m
    CONFIG_IP_NF_MATCH_LIMIT=m
    CONFIG_IP_NF_MATCH_MAC=m
    CONFIG_IP_NF_MATCH_PKTTYPE=m
    CONFIG_IP_NF_MATCH_MARK=m
    CONFIG_IP_NF_MATCH_MULTIPORT=m
    CONFIG_IP_NF_MATCH_TOS=m
    CONFIG_IP_NF_MATCH_RECENT=m
    CONFIG_IP_NF_MATCH_ECN=m
    CONFIG_IP_NF_MATCH_DSCP=m
    CONFIG_IP_NF_MATCH_AH_ESP=m
    CONFIG_IP_NF_MATCH_LENGTH=m
    CONFIG_IP_NF_MATCH_TTL=m
    CONFIG_IP_NF_MATCH_TCPMSS=m
    CONFIG_IP_NF_MATCH_HELPER=m
    CONFIG_IP_NF_MATCH_STATE=m
    CONFIG_IP_NF_MATCH_CONNTRACK=m
    CONFIG_IP_NF_MATCH_UNCLEAN=m
    CONFIG_IP_NF_MATCH_OWNER=m
    CONFIG_IP_NF_FILTER=m
    CONFIG_IP_NF_TARGET_REJECT=m
    CONFIG_IP_NF_TARGET_MIRROR=m
    CONFIG_IP_NF_NAT=m
    CONFIG_IP_NF_NAT_NEEDED=y
    CONFIG_IP_NF_TARGET_MASQUERADE=m
    CONFIG_IP_NF_TARGET_REDIRECT=m
    CONFIG_IP_NF_NAT_AMANDA=m
    CONFIG_IP_NF_NAT_LOCAL=y
    CONFIG_IP_NF_NAT_SNMP_BASIC=m
    CONFIG_IP_NF_NAT_IRC=m
    CONFIG_IP_NF_NAT_FTP=m
    CONFIG_IP_NF_NAT_TFTP=m
    CONFIG_IP_NF_MANGLE=m
    CONFIG_IP_NF_TARGET_TOS=m
    CONFIG_IP_NF_TARGET_ECN=m
    CONFIG_IP_NF_TARGET_DSCP=m
    CONFIG_IP_NF_TARGET_MARK=m
    CONFIG_IP_NF_TARGET_LOG=m
    CONFIG_IP_NF_TARGET_ULOG=m
    CONFIG_IP_NF_TARGET_TCPMSS=m
    CONFIG_IP_NF_ARPTABLES=m
    CONFIG_IP_NF_ARPFILTER=m
    CONFIG_IP_NF_ARP_MANGLE=m
    CONFIG_IP_NF_COMPAT_IPCHAINS=m
    CONFIG_IP_NF_NAT_NEEDED=y
    CONFIG_IP_NF_COMPAT_IPFWADM=m
    CONFIG_IP_NF_NAT_NEEDED=y
    CONFIG_IPX=m
    CONFIG_NET_SCHED=y
    CONFIG_NET_SCH_CBQ=m
    CONFIG_NET_SCH_HTB=m
    CONFIG_NET_SCH_CSZ=m
    CONFIG_NET_SCH_PRIO=m
    CONFIG_NET_SCH_RED=m
    CONFIG_NET_SCH_SFQ=m
    CONFIG_NET_SCH_TEQL=m
    CONFIG_NET_SCH_TBF=m
    CONFIG_NET_SCH_GRED=m
    CONFIG_NET_SCH_DSMARK=m
    CONFIG_NET_SCH_INGRESS=m
    CONFIG_NET_QOS=y
    CONFIG_NET_ESTIMATOR=y
    CONFIG_NET_CLS=y
    CONFIG_NET_CLS_TCINDEX=m
    CONFIG_NET_CLS_ROUTE4=m
    CONFIG_NET_CLS_ROUTE=y
    CONFIG_NET_CLS_FW=m
    CONFIG_NET_CLS_U32=m
    CONFIG_NET_CLS_RSVP=m
    CONFIG_NET_CLS_RSVP6=m
    CONFIG_NET_CLS_POLICE=y
    CONFIG_NET_PKTGEN=m
    CONFIG_IDE=y
    CONFIG_BLK_DEV_IDE=y
    CONFIG_BLK_DEV_IDEDISK=y
    CONFIG_IDEDISK_MULTI_MODE=y
    CONFIG_BLK_DEV_IDECD=y
    CONFIG_BLK_DEV_IDESCSI=y
    CONFIG_IDE_TASK_IOCTL=y
    CONFIG_BLK_DEV_CMD640=y
    CONFIG_BLK_DEV_ISAPNP=y
    CONFIG_BLK_DEV_IDEPCI=y
    CONFIG_BLK_DEV_GENERIC=y
    CONFIG_IDEPCI_SHARE_IRQ=y
    CONFIG_BLK_DEV_IDEDMA_PCI=y
    CONFIG_IDEDMA_PCI_AUTO=y
    CONFIG_BLK_DEV_IDEDMA=y
    CONFIG_IDEDMA_PCI_WIP=y
    CONFIG_BLK_DEV_SIS5513=y
    CONFIG_BLK_DEV_VIA82CXXX=y
    CONFIG_IDEDMA_AUTO=y
    CONFIG_IDEDMA_IVB=y
    CONFIG_BLK_DEV_IDE_MODES=y
    CONFIG_SCSI=y
    CONFIG_BLK_DEV_SD=m
    CONFIG_SD_EXTRA_DEVS=40
    CONFIG_BLK_DEV_SR=y
    CONFIG_BLK_DEV_SR_VENDOR=y
    CONFIG_SR_EXTRA_DEVS=2
    CONFIG_CHR_DEV_SG=y
    CONFIG_SCSI_DEBUG_QUEUES=y
    CONFIG_SCSI_MULTI_LUN=y
    CONFIG_SCSI_CONSTANTS=y
    CONFIG_SCSI_LOGGING=y
    CONFIG_SCSI_SYM53C8XX=y
    CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
    CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
    CONFIG_SCSI_NCR53C8XX_SYNC=20
    CONFIG_NETDEVICES=y
    CONFIG_DUMMY=y
    CONFIG_TUN=y
    CONFIG_NET_ETHERNET=y
    CONFIG_NET_PCI=y
    CONFIG_EEPRO100=y
    CONFIG_PPP=y
    CONFIG_PPP_FILTER=y
    CONFIG_PPP_ASYNC=y
    CONFIG_PPP_SYNC_TTY=y
    CONFIG_PPP_DEFLATE=y
    CONFIG_PPP_BSDCOMP=y
    CONFIG_INPUT=y
    CONFIG_INPUT_KEYBDEV=y
    CONFIG_INPUT_MOUSEDEV=y
    CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
    CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
    CONFIG_INPUT_JOYDEV=y
    CONFIG_INPUT_EVDEV=y
    CONFIG_VT=y
    CONFIG_VT_CONSOLE=y
    CONFIG_SERIAL=y
    CONFIG_SERIAL_CONSOLE=y
    CONFIG_UNIX98_PTYS=y
    CONFIG_UNIX98_PTY_COUNT=256
    CONFIG_I2C=y
    CONFIG_I2C_ALGOBIT=y
    CONFIG_I2C_MAINBOARD=y
    CONFIG_I2C_SIS5595=m
    CONFIG_I2C_ISA=y
    CONFIG_I2C_CHARDEV=y
    CONFIG_I2C_PROC=y
    CONFIG_SENSORS=y
    CONFIG_SENSORS_IT87=y
    CONFIG_SENSORS_OTHER=y
    CONFIG_SENSORS_DDCMON=y
    CONFIG_SENSORS_EEPROM=y
    CONFIG_MOUSE=y
    CONFIG_PSMOUSE=y
    CONFIG_INPUT_GAMECON=m
    CONFIG_WATCHDOG=y
    CONFIG_SOFT_WATCHDOG=y
    CONFIG_AGP=y
    CONFIG_AGP_INTEL=y
    CONFIG_AGP_I810=y
    CONFIG_AGP_VIA=y
    CONFIG_AGP_AMD=y
    CONFIG_AGP_SIS=y
    CONFIG_AGP_ALI=y
    CONFIG_DRM=y
    CONFIG_DRM_NEW=y
    CONFIG_DRM_TDFX=y
    CONFIG_DRM_RADEON=y
    CONFIG_DRM_I810=y
    CONFIG_DRM_I810_XFREE_41=y
    CONFIG_QUOTA=y
    CONFIG_SUPERMOUNT=y
    CONFIG_EXT3_FS=y
    CONFIG_JBD=y
    CONFIG_JBD_DEBUG=y
    CONFIG_FAT_FS=y
    CONFIG_MSDOS_FS=m
    CONFIG_UMSDOS_FS=m
    CONFIG_VFAT_FS=y
    CONFIG_TMPFS=y
    CONFIG_RAMFS=y
    CONFIG_ISO9660_FS=y
    CONFIG_JOLIET=y
    CONFIG_ZISOFS=y
    CONFIG_PROC_FS=y
    CONFIG_DEVFS_FS=y
    CONFIG_DEVPTS_FS=y
    CONFIG_EXT2_FS=y
    CONFIG_UDF_FS=y
    CONFIG_NFS_FS=y
    CONFIG_NFSD=y
    CONFIG_SUNRPC=y
    CONFIG_LOCKD=y
    CONFIG_SMB_FS=y
    CONFIG_ZISOFS_FS=y
    CONFIG_MSDOS_PARTITION=y
    CONFIG_SMB_NLS=y
    CONFIG_NLS=y
    CONFIG_NLS_DEFAULT="iso8859-1"
    CONFIG_NLS_CODEPAGE_437=y
    CONFIG_NLS_CODEPAGE_737=m
    CONFIG_NLS_CODEPAGE_775=m
    CONFIG_NLS_CODEPAGE_850=y
    CONFIG_NLS_CODEPAGE_852=m
    CONFIG_NLS_CODEPAGE_855=m
    CONFIG_NLS_CODEPAGE_857=m
    CONFIG_NLS_CODEPAGE_860=m
    CONFIG_NLS_CODEPAGE_861=m
    CONFIG_NLS_CODEPAGE_862=m
    CONFIG_NLS_CODEPAGE_863=m
    CONFIG_NLS_CODEPAGE_864=m
    CONFIG_NLS_CODEPAGE_865=m
    CONFIG_NLS_CODEPAGE_866=m
    CONFIG_NLS_CODEPAGE_869=m
    CONFIG_NLS_CODEPAGE_936=m
    CONFIG_NLS_CODEPAGE_950=m
    CONFIG_NLS_CODEPAGE_932=m
    CONFIG_NLS_CODEPAGE_949=m
    CONFIG_NLS_CODEPAGE_874=m
    CONFIG_NLS_ISO8859_8=m
    CONFIG_NLS_CODEPAGE_1250=m
    CONFIG_NLS_CODEPAGE_1251=m
    CONFIG_NLS_ISO8859_1=y
    CONFIG_NLS_ISO8859_2=m
    CONFIG_NLS_ISO8859_3=m
    CONFIG_NLS_ISO8859_4=m
    CONFIG_NLS_ISO8859_5=m
    CONFIG_NLS_ISO8859_6=m
    CONFIG_NLS_ISO8859_7=m
    CONFIG_NLS_ISO8859_9=m
    CONFIG_NLS_ISO8859_13=m
    CONFIG_NLS_ISO8859_14=m
    CONFIG_NLS_ISO8859_15=m
    CONFIG_NLS_KOI8_R=m
    CONFIG_NLS_KOI8_U=m
    CONFIG_NLS_UTF8=y
    CONFIG_VGA_CONSOLE=y
    CONFIG_VIDEO_SELECT=y
    CONFIG_FB=y
    CONFIG_DUMMY_CONSOLE=y
    CONFIG_FB_RIVA=m
    CONFIG_FB_VESA=y
    CONFIG_FB_VGA16=m
    CONFIG_VIDEO_SELECT=y
    CONFIG_FBCON_ADVANCED=y
    CONFIG_FBCON_MFB=y
    CONFIG_FBCON_CFB8=y
    CONFIG_FBCON_CFB16=y
    CONFIG_FBCON_CFB24=y
    CONFIG_FBCON_CFB32=y
    CONFIG_FBCON_VGA_PLANES=y
    CONFIG_FBCON_VGA=y
    CONFIG_FONT_8x8=y
    CONFIG_FONT_8x16=y
    CONFIG_SOUND=y
    CONFIG_SOUND_ES1370=m
    CONFIG_SOUND_ICH=m
    CONFIG_SOUND_OSS=y
    CONFIG_SOUND_VMIDI=m
    CONFIG_USB=y
    CONFIG_USB_DEVICEFS=y
    CONFIG_USB_EHCI_HCD=y
    CONFIG_USB_UHCI=y
    CONFIG_USB_OHCI=y
    CONFIG_USB_STORAGE=y
    CONFIG_USB_PRINTER=y
    CONFIG_USB_HID=y
    CONFIG_USB_HIDINPUT=y
    CONFIG_USB_HIDDEV=y
    CONFIG_DEBUG_KERNEL=y
    CONFIG_DEBUG_STACKOVERFLOW=y
    CONFIG_DEBUG_SLAB=y
    CONFIG_MAGIC_SYSRQ=y
    CONFIG_CRYPTO=y
    CONFIG_CRYPTO_HMAC=y
    CONFIG_CRYPTO_NULL=y
    CONFIG_CRYPTO_MD4=y
    CONFIG_CRYPTO_MD5=y
    CONFIG_CRYPTO_SHA1=y
    CONFIG_CRYPTO_SHA256=y
    CONFIG_CRYPTO_SHA512=y
    CONFIG_CRYPTO_DES=y
    CONFIG_CRYPTO_BLOWFISH=y
    CONFIG_CRYPTO_TWOFISH=y
    CONFIG_CRYPTO_SERPENT=y
    CONFIG_CRYPTO_AES=y
    CONFIG_CRYPTO_DEFLATE=y
    CONFIG_CRYPTO_TEST=m
    CONFIG_CRC32=y
    CONFIG_ZLIB_INFLATE=y
    CONFIG_ZLIB_DEFLATE=y


