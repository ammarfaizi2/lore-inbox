Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264328AbUEMRxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbUEMRxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 13:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbUEMRxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 13:53:45 -0400
Received: from [80.72.36.106] ([80.72.36.106]:18346 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264328AbUEMRx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 13:53:26 -0400
Date: Thu, 13 May 2004 19:53:14 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, apkm@osdl.org
Subject: IRQ and PCI and (2.6.6-bk1 + some bk trees from -mm1)
Message-ID: <Pine.LNX.4.58.0405131944110.3395@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First I cannot boot without acpi_irq_balance. Kernel sets some very stupid 
irq for ide channel (0 or 1 or something like that).

With acpi_irq_balance I got:

polb01 root # cat /proc/interrupts
           CPU0
  0:    8986161          XT-PIC  timer
  1:      20979          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
 10:     637961          XT-PIC  uhci_hcd, uhci_hcd, eth0, bttv0, Bt87x 
audio, nvidia
 11:       2189          XT-PIC  acpi, EMU10K1
 12:     226199          XT-PIC  i8042
 14:         88          XT-PIC  ide0
 15:     460387          XT-PIC  ide1
NMI:          0
LOC:    8984546
ERR:      91840

This is different than with 2.6.2. I think that in 2.6.2 it was better: 
adding all devices to irq 10 is bad I think.

And I got the following in my logs:
May 13 18:32:19 polb01 Aieee - PCI error! status 0x008008, PCI status 
0x8290
May 13 18:34:30 polb01 Aieee - PCI error! status 0x008008, PCI status 
0x8290
May 13 18:35:44 polb01 Aieee - PCI error! status 0x008008, PCI status 
0x8290
May 13 18:40:21 polb01 Aieee - PCI error! status 0x008008, PCI status 
0x8290
May 13 19:01:28 polb01 Aieee - PCI error! status 0x008008, PCI status 
0x8290
May 13 19:16:43 polb01 Aieee - PCI error! status 0x008008, PCI status 
0x8290
May 13 19:22:24 polb01 Aieee - PCI error! status 0x008008, PCI status 
0x8290
May 13 19:22:56 polb01 Aieee - PCI error! status 0x008008, PCI status 
0x8290
May 13 19:27:17 polb01 Aieee - PCI error! status 0x008008, PCI status 
0x8290
May 13 19:27:29 polb01 Aieee - PCI error! status 0x008008, PCI status 
0x8290
May 13 19:42:41 polb01 Aieee - PCI error! status 0x008008, PCI status 
0x8290
May 13 19:49:37 polb01 Aieee - PCI error! status 0x008008, PCI status 
0x8290

This looks serious...


My dmesg:

May 13 17:30:10 polb01 syslog-ng[9254]: syslog-ng version 1.6.2 starting
May 13 17:30:10 polb01 syslog-ng[9254]: Changing permissions on special 
file /dev/tty12
May 13 17:30:10 polb01 Linux version 2.6.6-bk1 (root@polb01) (gcc version 
3.3.3 20040412 (Gentoo Linux 3.3.3-r3, ssp-3.3-7, pie-8.5.3)) #1 Wed May 
12 12:42:51 CEST 2004
May 13 17:30:10 polb01 BIOS-provided physical RAM map:
May 13 17:30:10 polb01 BIOS-e820: 0000000000000000 - 000000000009fc00 
(usable)
May 13 17:30:10 polb01 BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
May 13 17:30:10 polb01 BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
May 13 17:30:10 polb01 BIOS-e820: 0000000000100000 - 000000001fff0000 
(usable)
May 13 17:30:10 polb01 BIOS-e820: 000000001fff0000 - 000000001fff3000 
(ACPI NVS)
May 13 17:30:10 polb01 BIOS-e820: 000000001fff3000 - 0000000020000000 
(ACPI data)
May 13 17:30:10 polb01 BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
May 13 17:30:10 polb01 511MB LOWMEM available.
May 13 17:30:10 polb01 On node 0 totalpages: 131056
May 13 17:30:10 polb01 DMA zone: 4096 pages, LIFO batch:1
May 13 17:30:10 polb01 Normal zone: 126960 pages, LIFO batch:16
May 13 17:30:10 polb01 HighMem zone: 0 pages, LIFO batch:1
May 13 17:30:10 polb01 DMI 2.2 present.
May 13 17:30:10 polb01 ACPI: RSDP (v000 761686                                    
) @ 0x000f6810
May 13 17:30:10 polb01 ACPI: RSDT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3000
May 13 17:30:10 polb01 ACPI: FADT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3040
May 13 17:30:10 polb01 ACPI: DSDT (v001 761686 AWRDACPI 0x00001000 MSFT 
0x0100000c) @ 0x00000000
May 13 17:30:10 polb01 ACPI: PM-Timer IO Port: 0x4008
May 13 17:30:10 polb01 Built 1 zonelists
May 13 17:30:10 polb01 Kernel command line: ro root=/dev/hdd4 
acpi_irq_balance
May 13 17:30:10 polb01 Local APIC disabled by BIOS -- reenabling.
May 13 17:30:10 polb01 Found and enabled local APIC!
May 13 17:30:10 polb01 Initializing CPU#0
May 13 17:30:10 polb01 PID hash table entries: 2048 (order 11: 16384 
bytes)
May 13 17:30:10 polb01 Detected 1001.834 MHz processor.
May 13 17:30:10 polb01 Using pmtmr for high-res timesource
May 13 17:30:10 polb01 Console: colour VGA+ 80x25
May 13 17:30:10 polb01 Memory: 514980k/524224k available (2807k kernel 
code, 8492k reserved, 564k data, 132k init, 0k highmem)
May 13 17:30:10 polb01 Checking if this processor honours the WP bit even 
in supervisor mode... Ok.
May 13 17:30:10 polb01 Calibrating delay loop... 1982.46 BogoMIPS
May 13 17:30:10 polb01 Security Scaffold v1.0.0 initialized
May 13 17:30:10 polb01 Dentry cache hash table entries: 65536 (order: 6, 
262144 bytes)
May 13 17:30:10 polb01 Inode-cache hash table entries: 32768 (order: 5, 
131072 bytes)
May 13 17:30:10 polb01 Mount-cache hash table entries: 512 (order: 0, 4096 
bytes)
May 13 17:30:10 polb01 CPU:     After generic identify, caps: 0183fbff 
c1c7fbff 00000000 00000000
May 13 17:30:10 polb01 CPU:     After vendor identify, caps: 0183fbff 
c1c7fbff 00000000 00000000
May 13 17:30:10 polb01 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K 
(64 bytes/line)
May 13 17:30:10 polb01 CPU: L2 Cache: 256K (64 bytes/line)
May 13 17:30:10 polb01 CPU:     After all inits, caps: 0183fbf7 c1c7fbff 
00000000 00000020
May 13 17:30:10 polb01 Intel machine check architecture supported.
May 13 17:30:10 polb01 Intel machine check reporting enabled on CPU#0.
May 13 17:30:10 polb01 CPU: AMD Athlon(tm) processor stepping 02
May 13 17:30:10 polb01 Enabling fast FPU save and restore... done.
May 13 17:30:10 polb01 Checking 'hlt' instruction... OK.
May 13 17:30:10 polb01 POSIX conformance testing by UNIFIX
May 13 17:30:10 polb01 enabled ExtINT on CPU#0
May 13 17:30:10 polb01 ESR value before enabling vector: 00000000
May 13 17:30:10 polb01 ESR value after enabling vector: 00000000
May 13 17:30:10 polb01 Using local APIC timer interrupts.
May 13 17:30:10 polb01 calibrating APIC timer ...
May 13 17:30:10 polb01 ..... CPU clock speed is 1001.0108 MHz.
May 13 17:30:10 polb01 ..... host bus clock speed is 266.0962 MHz.
May 13 17:30:10 polb01 NET: Registered protocol family 16
May 13 17:30:10 polb01 PCI: PCI BIOS revision 2.10 entry at 0xfb5e0, last 
bus=1
May 13 17:30:10 polb01 PCI: Using configuration type 1
May 13 17:30:10 polb01 mtrr: v2.0 (20020519)
May 13 17:30:10 polb01 ACPI: Subsystem revision 20040326
May 13 17:30:10 polb01 ACPI: IRQ11 SCI: Level Trigger.
May 13 17:30:10 polb01 spurious 8259A interrupt: IRQ7.
May 13 17:30:10 polb01 ACPI: Interpreter enabled
May 13 17:30:10 polb01 ACPI: Using PIC for interrupt routing
May 13 17:30:10 polb01 ACPI: PCI Root Bridge [PCI0] (00:00)
May 13 17:30:10 polb01 PCI: Probing PCI hardware (bus 00)
May 13 17:30:10 polb01 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
May 13 17:30:10 polb01 ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 
*10 11 12 14 15)
May 13 17:30:10 polb01 ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 
10 11 12 14 15)
May 13 17:30:10 polb01 ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 
10 11 12 14 15) *9
May 13 17:30:10 polb01 ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 
10 *11 12 14 15)
May 13 17:30:10 polb01 ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
May 13 17:30:10 polb01 ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
May 13 17:30:10 polb01 ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
May 13 17:30:10 polb01 ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
May 13 17:30:10 polb01 PCI: Using ACPI for IRQ routing
May 13 17:30:10 polb01 Total HugeTLB memory allocated, 0
May 13 17:30:10 polb01 VFS: Disk quotas dquot_6.5.1
May 13 17:30:10 polb01 Dquot-cache hash table entries: 1024 (order 0, 4096 
bytes)
May 13 17:30:10 polb01 SGI XFS with ACLs, security attributes, realtime, 
no debug enabled
May 13 17:30:10 polb01 SGI XFS Quota Management subsystem
May 13 17:30:10 polb01 Initializing Cryptographic API
May 13 17:30:10 polb01 PCI: Via IRQ fixup for 0000:00:07.2, from 11 to 10
May 13 17:30:10 polb01 PCI: Via IRQ fixup for 0000:00:07.3, from 11 to 10
May 13 17:30:10 polb01 Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
May 13 17:30:10 polb01 ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
May 13 17:30:10 polb01 VP_IDE: IDE controller at PCI slot 0000:00:07.1
May 13 17:30:10 polb01 VP_IDE: chipset revision 6
May 13 17:30:10 polb01 VP_IDE: not 100% native mode: will probe irqs later
May 13 17:30:10 polb01 VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 
controller on pci0000:00:07.1
May 13 17:30:10 polb01 ide0: BM-DMA at 0xd400-0xd407, BIOS settings: 
hda:DMA, hdb:DMA
May 13 17:30:10 polb01 ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: 
hdc:DMA, hdd:DMA
May 13 17:30:10 polb01 hda: SAMSUNG SV6004H, ATA DISK drive
May 13 17:30:10 polb01 hdb: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM 
drive
May 13 17:30:10 polb01 Using anticipatory io scheduler
May 13 17:30:10 polb01 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 13 17:30:10 polb01 hdc: Pioneer DVD-ROM ATAPIModel DVD-115 0133, ATAPI 
CD/DVD-ROM drive
May 13 17:30:10 polb01 hdd: SAMSUNG SV3063H, ATA DISK drive
May 13 17:30:10 polb01 ide1 at 0x170-0x177,0x376 on irq 15
May 13 17:30:10 polb01 hda: max request size: 128KiB
May 13 17:30:10 polb01 hda: 117306000 sectors (60060 MB) w/468KiB Cache, 
CHS=65535/16/63, UDMA(100)
May 13 17:30:10 polb01 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
May 13 17:30:10 polb01 hdd: max request size: 128KiB
May 13 17:30:10 polb01 hdd: 59797584 sectors (30616 MB) w/426KiB Cache, 
CHS=59323/16/63, UDMA(100)
May 13 17:30:10 polb01 hdd: hdd1 hdd2 hdd3 hdd4
May 13 17:30:10 polb01 mice: PS/2 mouse device common for all mice
May 13 17:30:10 polb01 serio: i8042 AUX port at 0x60,0x64 irq 12
May 13 17:30:10 polb01 serio: i8042 KBD port at 0x60,0x64 irq 1
May 13 17:30:10 polb01 input: AT Translated Set 2 keyboard on 
isa0060/serio0
May 13 17:30:10 polb01 NET: Registered protocol family 2
May 13 17:30:10 polb01 IP: routing cache hash table of 1024 buckets, 
32Kbytes
May 13 17:30:10 polb01 TCP: Hash tables configured (established 32768 bind 
9362)
May 13 17:30:10 polb01 ACPI: (supports S0 S1 S4 S5)
May 13 17:30:10 polb01 kjournald starting.  Commit interval 5 seconds
May 13 17:30:10 polb01 EXT3-fs: mounted filesystem with ordered data mode.
May 13 17:30:10 polb01 VFS: Mounted root (ext3 filesystem) readonly.
May 13 17:30:10 polb01 Freeing unused kernel memory: 132k freed
May 13 17:30:10 polb01 NET: Registered protocol family 1
May 13 17:30:10 polb01 EXT3 FS on hdd4, internal journal
May 13 17:30:10 polb01 Capability LSM initialized
May 13 17:30:10 polb01 CSLIP: code copyright 1989 Regents of the 
University of California
May 13 17:30:10 polb01 PPP generic driver version 2.4.2
May 13 17:30:10 polb01 PPP Deflate Compression module registered
May 13 17:30:10 polb01 NET: Registered protocol family 8
May 13 17:30:10 polb01 NET: Registered protocol family 20
May 13 17:30:10 polb01 input: PS/2 Generic Mouse on isa0060/serio1
May 13 17:30:10 polb01 ACPI: Power Button (FF) [PWRF]
May 13 17:30:10 polb01 ACPI: Sleep Button (CM) [SLPB]
May 13 17:30:10 polb01 ACPI: Processor [CPU0] (supports C1, 2 throttling 
states)
May 13 17:30:10 polb01 input: PC Speaker
May 13 17:30:10 polb01 inserting floppy driver for 2.6.6-bk1
May 13 17:30:10 polb01 Floppy drive(s): fd0 is 1.44M
May 13 17:30:10 polb01 FDC 0 is a post-1991 82077
May 13 17:30:10 polb01 loop: loaded (max 8 devices)
May 13 17:30:10 polb01 Non-volatile memory driver v1.2
May 13 17:30:10 polb01 BIOS EDD facility v0.14 2004-Apr-28, 2 devices 
found
May 13 17:30:10 polb01 device-mapper: 4.1.0-ioctl (2003-12-10) 
initialised: dm@uk.sistina.com
May 13 17:30:10 polb01 kjournald starting.  Commit interval 5 seconds
May 13 17:30:10 polb01 EXT3 FS on hda5, internal journal
May 13 17:30:10 polb01 EXT3-fs: mounted filesystem with ordered data mode.
May 13 17:30:10 polb01 kjournald starting.  Commit interval 5 seconds
May 13 17:30:10 polb01 EXT3 FS on hda6, internal journal
May 13 17:30:10 polb01 EXT3-fs: mounted filesystem with ordered data mode.
May 13 17:30:10 polb01 NTFS driver 2.1.9 [Flags: R/O MODULE].
May 13 17:30:10 polb01 NTFS volume version 3.1.
May 13 17:30:10 polb01 usbcore: registered new driver usbfs
May 13 17:30:10 polb01 usbcore: registered new driver hub
May 13 17:30:10 polb01 Real Time Clock Driver v1.12
May 13 17:30:10 polb01 parport_pc: Strange, can't probe Via 686A parallel 
port: io=0x378, irq=-1, dma=-1
May 13 17:30:10 polb01 USB Universal Host Controller Interface driver v2.2
May 13 17:30:10 polb01 uhci_hcd 0000:00:07.2: UHCI Host Controller
May 13 17:30:10 polb01 uhci_hcd 0000:00:07.2: irq 10, io base 0000d800
May 13 17:30:10 polb01 uhci_hcd 0000:00:07.2: new USB bus registered, 
assigned bus number 1
May 13 17:30:10 polb01 hub 1-0:1.0: USB hub found
May 13 17:30:10 polb01 hub 1-0:1.0: 2 ports detected
May 13 17:30:10 polb01 uhci_hcd 0000:00:07.3: UHCI Host Controller
May 13 17:30:10 polb01 uhci_hcd 0000:00:07.3: irq 10, io base 0000dc00
May 13 17:30:10 polb01 uhci_hcd 0000:00:07.3: new USB bus registered, 
assigned bus number 2
May 13 17:30:10 polb01 hub 2-0:1.0: USB hub found
May 13 17:30:10 polb01 hub 2-0:1.0: 2 ports detected
May 13 17:30:10 polb01 usb 1-1: new full speed USB device using address 2
May 13 17:30:10 polb01 usb 1-2: new full speed USB device using address 3
May 13 17:30:10 polb01 usbcore: registered new driver speedtch
May 13 17:30:10 polb01 8139too Fast Ethernet driver 0.9.27
May 13 17:30:10 polb01 eth0: RealTek RTL8139 at 0xe000, 00:06:4f:00:73:8b, 
IRQ 10
May 13 17:30:10 polb01 eth0:  Identified 8139 chip type 'RTL-8139C'
May 13 17:30:10 polb01 eth0: link down
May 13 17:30:10 polb01 gameport: pci0000:00:09.1 speed 1242 kHz
May 13 17:30:10 polb01 Linux video capture interface: v1.00
May 13 17:30:10 polb01 bttv: driver version 0.9.15 loaded
May 13 17:30:10 polb01 bttv: using 32 buffers with 2080k (520 pages) each 
for capture
May 13 17:30:10 polb01 bttv: Bt8xx card found (0).
May 13 17:30:10 polb01 bttv0: Bt878 (rev 17) at 0000:00:0d.0, irq: 10, 
latency: 32, mmio: 0xde01b000
May 13 17:30:10 polb01 bttv0: using: Prolink Pixelview PV-BT878P+ 
(Rev.4C,8E) [card=70,insmod option]
May 13 17:30:10 polb01 bttv0: gpio: en=00000000, out=00000000 in=00ffc0ff 
[init]
May 13 17:30:10 polb01 bttv0: using tuner=25
May 13 17:30:10 polb01 bttv0: i2c: checking for MSP34xx @ 0x80... not 
found
May 13 17:30:10 polb01 bttv0: i2c: checking for TDA9875 @ 0xb0... not 
found
May 13 17:30:10 polb01 bttv0: i2c: checking for TDA7432 @ 0x8a... not 
found
May 13 17:30:10 polb01 tvaudio: TV audio decoder + audio/video mux driver
May 13 17:30:10 polb01 tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV951),ta8874z
May 13 17:30:10 polb01 tuner: chip found at addr 0xc2 i2c-bus bt878 #0 
[sw]
May 13 17:30:10 polb01 tuner: type set to 25 (LG PAL_I+FM (TAPC-I001D)) by 
bt878 #0 [sw]
May 13 17:30:10 polb01 bttv0: registered device video0
May 13 17:30:10 polb01 bttv0: registered device vbi0
May 13 17:30:10 polb01 bttv0: registered device radio0
May 13 17:30:10 polb01 bttv0: PLL: 28636363 => 35468950 .. ok
May 13 17:30:10 polb01 bttv0: add subdevice "remote0"


My lspci -vvvv:

polb01 root # lspci -vvvv
0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] 
System Controller (rev 13)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 176
        Region 0: Memory at d8000000 (32-bit, prefetchable)
        Region 1: Memory at de019000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at d000 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ 
Rate=x4
 
0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] 
AGP Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 176
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: d0000000-d7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
 
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
South] (rev 40)
        Subsystem: ABIT Computer Corp. KG7-Lite Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
0000:00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. 
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 176
        Region 4: I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
0000:00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 
00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 176, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
0000:00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 
00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 176, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
0000:00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 11
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
0000:00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 240 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e000
        Region 1: Memory at de01a000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
0000:00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 
(rev 08)
        Subsystem: Creative Labs SB Live! 5.1 Model SB0100
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 240 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e400
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
0000:00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game 
Port (rev 08)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 240
        Region 0: I/O ports at e800
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
0000:00:0b.0 Communication controller: 5610 56K FaxModem USR 56k Internal 
WinModem
        Subsystem: 5610 56K FaxModem: Unknown device 00b2
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at de018000 (32-bit, prefetchable)
        Region 1: Memory at de000000 (32-bit, prefetchable) [size=64K]
        Region 2: Memory at de010000 (32-bit, prefetchable) [size=32K]
        Region 3: I/O ports at ec00 [size=64]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
 
0000:00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 
Video Capture (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 240 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at de01b000 (32-bit, prefetchable)
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
0000:00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio 
Capture (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 240 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at de01c000 (32-bit, prefetchable)
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
0000:01:05.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 
GTS/Pro] (rev a4) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at dc000000 (32-bit, non-prefetchable)
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=16 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ 
Rate=x4


Can you help me?


Thanks,

Grzegorz Kulewski

