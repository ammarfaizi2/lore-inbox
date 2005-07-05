Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVGEXJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVGEXJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 19:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVGEXJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 19:09:12 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:65164 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S262002AbVGEXFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 19:05:21 -0400
Date: Wed, 6 Jul 2005 01:05:20 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: AACRAID failure with 2.6.13-rc1
Message-ID: <Pine.LNX.4.60.0507052356230.1410@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem with the AACRAID driver on 2.6.13-rc1-git6 (also tested 
with -git4). I have an Adaptec AAR-2410SA SATA RAID controller card with 2 
RAIDs defined on (sda (Data 2) is a non-actual-RAID disk space where is 
the root (/) system on sda2, and sdb (Data 1) which is a 4 HDD RAID 5). 
When I boot, everything seems to go on just fine for a while (as seen from 
the dmesg below). However after a little while (see the time stamps 
[278.655644] and on) the AACRAID seems to fail totally and after that the 
disks are gone. Since there is a root filesystem on sda2, there is not 
much else that can be done on the system. But the system doesn't hang.

After a little searching I noticed there was some patch on aacraid just 
before 2.6.12 came out. Maybe there's some problem, or maybe somewhere 
later. I didn't actually try any other kernel than those mentioned above. 
But it seems to work with the 2.6.11-6mdk from Mandrake 10.2.

And while on that, I'd like to ask some questions about the performance of 
the AACRAID driver. Does anybody have a clue what should be the 
approximate performance? I have the Adaptec AAR-2410SA (64-bit PCI) in a 
normal 32-bit PCI slot and with 3xWD1200JD and 1xWD1600SD SATA drives.
(Following numbers refer to the at least working aacraid in 2.6.11-6mdk.)
Truth is that hdparm -t /dev/sda gives about 42 MB/s (though, I'm not 
sure what relevance does that have for a SCSI/SATA controller with 2.6.11 
kernel), but the reality is completely different. When copying some large 
files to the AACRAID disk (i.e. writing) it first goes quite fast (while 
it is only caching into memory). But when the memory is full, the transfer 
speed dramatically drops to about 5-7 MB/s. Reading from the AACRAID disk 
gives about 27-28 MB/s at first and after a while (memory cache?) it drops 
to about 20 MB/s. I mean, I've read some recenses about this controller, 
which said that it is slower than most others, but this is IMHO a bit too 
much (and I even have the latest firmware/BIOS V4.2-0 [Build 7348], which 
should have caused some speedup compared to the older one with which the 
recense was done). Especially from the RAID 5 with 4 SATA disks I'd expect 
a far better performance! Now even a classic stand-alone PATA drive is 
performing a lot better than that.

And there's also that thing, that when doing some copying of larger 
files to/from the AACRAID disks. The whole system exercises a sudden 
_very significant_ drop of performance (only during the AACRAID disks 
activity). That's also very odd. It almost seems as if the whole I/O 
was done manually by the CPU without any DMA or something. Is that 
really so? ??? 

Martin

-- dmesg ---------------------

[17179569.184000] ACPI: Local APIC address 0xfee00000
[17179569.184000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[17179569.184000] Processor #0 6:10 APIC version 16
[17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[17179569.184000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[17179569.184000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[17179569.184000] ACPI: BIOS IRQ0 pin2 override ignored.
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[17179569.184000] ACPI: IRQ9 used by override.
[17179569.184000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[17179569.184000] Using ACPI (MADT) for SMP configuration information
[17179569.184000] Allocating PCI resources starting at 40000000 (gap: 40000000:bec00000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Kernel command line: root=/dev/sda2 resume=/dev/hde2 splash=silent PROFILE=Home vga=794 init=/bin/bash
[17179569.184000] mapped APIC to ffffd000 (fee00000)
[17179569.184000] mapped IOAPIC to ffffc000 (fec00000)
[17179569.184000] Initializing CPU#0
[17179569.184000] CPU 0 irqstacks, hard=c041d000 soft=c041c000
[17179569.184000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[    0.000000] Detected 2191.552 MHz processor.
[   94.904004] Using tsc for high-res timesource
[   94.904026] Console: colour dummy device 80x25
[   94.904562] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   94.905054] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   94.927216] Memory: 1034364k/1048512k available (1917k kernel code, 13204k reserved, 1040k data, 200k init, 131008k highmem)
[   94.927226] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   95.006270] Calibrating delay using timer specific routine.. 4388.44 BogoMIPS (lpj=8776883)
[   95.006309] Mount-cache hash table entries: 512
[   95.006403] CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
[   95.006409] CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
[   95.006414] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   95.006419] CPU: L2 Cache: 512K (64 bytes/line)
[   95.006422] CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000 00000000 00000000
[   95.006427] Intel machine check architecture supported.
[   95.006430] Intel machine check reporting enabled on CPU#0.
[   95.006443] CPU: AMD Athlon(tm) XP 3200+ stepping 00
[   95.006448] Enabling fast FPU save and restore... done.
[   95.006451] Enabling unmasked SIMD FPU exception support... done.
[   95.006456] Checking 'hlt' instruction... OK.
[   95.028937]  tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
[   95.087359] Parsing all Control Methods:...............................................................................................................................
[   95.184694] Table [DSDT](id F004) - 693 Objects with 76 Devices 262 Methods 23 Regions
[   95.184701] ACPI Namespace successfully loaded at root c0463600
[   95.185561] evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
[   95.185729] ENABLING IO-APIC IRQs
[   95.185907] ..TIMER: vector=0x31 pin1=0 pin2=-1
[   95.330159] checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
[   95.349527] Freeing initrd memory: 603k freed
[   95.349752] NET: Registered protocol family 16
[   95.365684] PCI: PCI BIOS revision 2.10 entry at 0xfaf40, last bus=3
[   95.365693] PCI: Using configuration type 1
[   95.365697] mtrr: v2.0 (20020519)
[   95.365943] ACPI: Subsystem revision 20050309
[   95.373598] evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
[   95.373607] evgpeblk-0987 [06] ev_create_gpe_block   : Found 9 Wake, Enabled 0 Runtime GPEs in this block
[   95.376734] evgpeblk-0979 [06] ev_create_gpe_block   : GPE 20 to 5F [_GPE] 8 regs on int 0x9
[   95.376742] evgpeblk-0987 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 0 Runtime GPEs in this block
[   95.384070] Completing Region/Field/Buffer/Package initialization:....................................................................
[   95.473558] Initialized 23/23 Regions 1/1 Fields 29/29 Buffers 15/23 Packages (702 nodes)
[   95.473565] Executing all Device _STA and_INI methods:...............................................................................
[   95.596172] 79 Devices found containing: 79 _STA, 1 _INI methods
[   95.596177] ACPI: Interpreter enabled
[   95.596181] ACPI: Using IOAPIC for interrupt routing
[   95.603249] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   95.603254] PCI: Probing PCI hardware (bus 00)
[   95.603323] PCI: nForce2 C1 Halt Disconnect fixup
[   95.604477] Boot video device is 0000:03:00.0
[   95.604561] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   95.612988] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[   95.632254] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
[   95.651749] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[   95.657003] ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   95.662270] ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[   95.667532] ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[   95.672731] ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   95.678016] ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
[   95.683288] ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[   95.688556] ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
[   95.693897] ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   95.699092] ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   95.704288] ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   95.709563] ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[   95.714847] ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   95.720050] ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   95.725260] ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   95.730489] ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   95.735457] ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
[   95.740152] ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
[   95.744843] ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
[   95.749539] ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
[   95.754249] ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
[   95.762034] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
[   95.769784] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
[   95.777535] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
[   95.785289] ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
[   95.793045] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
[   95.800811] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
[   95.805491] ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
[   95.813315] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
[   95.821152] ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
[   95.828993] ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
[   95.836825] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
[   95.903016] Linux Plug and Play Support v0.97 (c) Adam Belay
[   95.903033] pnp: PnP ACPI init
[   96.036356] pnp: PnP ACPI: found 13 devices
[   96.036363] PnPBIOS: Disabled by ACPI PNP
[   96.036411] PCI: Using ACPI for IRQ routing
[   96.036417] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   96.122993] pnp: 00:00: ioport range 0x1000-0x107f could not be reserved
[   96.122999] pnp: 00:00: ioport range 0x1080-0x10ff has been reserved
[   96.123003] pnp: 00:00: ioport range 0x1400-0x147f has been reserved
[   96.123007] pnp: 00:00: ioport range 0x1480-0x14ff could not be reserved
[   96.123011] pnp: 00:00: ioport range 0x1800-0x187f has been reserved
[   96.123017] pnp: 00:00: ioport range 0x1880-0x18ff has been reserved
[   96.123023] pnp: 00:01: ioport range 0x1c00-0x1c3f has been reserved
[   96.123027] pnp: 00:01: ioport range 0x2000-0x203f has been reserved
[   96.123235] apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
[   96.123240] apm: overridden by ACPI.
[   96.123464] audit: initializing netlink socket (disabled)
[   96.123476] audit(1120605734.284:1): initialized
[   96.123520] highmem bounce pool size: 64 pages
[   96.123556] VFS: Disk quotas dquot_6.5.1
[   96.123575] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   96.123618] Initializing Cryptographic API
[   96.123736] vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 5120k, total 131072k
[   96.123743] vesafb: mode is 1280x1024x16, linelength=2560, pages=1
[   96.123747] vesafb: protected mode interface info at c000:e910
[   96.123750] vesafb: scrolling: redraw
[   96.123754] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   96.151455] Console: switching to colour frame buffer device 160x64
[   96.151561] fb0: VESA VGA frame buffer device
[   96.151667] isapnp: Scanning for PnP cards...
[   96.462666] isapnp: No Plug & Play device found
[   96.471870] Real Time Clock Driver v1.12
[   96.472050] PNP: PS/2 controller doesn't have AUX irq; using default 0xc
[   96.472163] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 112
[   96.474186] serio: i8042 AUX port at 0x60,0x64 irq 12
[   96.474403] serio: i8042 KBD port at 0x60,0x64 irq 1
[   96.474509] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   96.729246] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   96.985086] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   96.993537] ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
[   97.001627] ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
[   97.001917] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   97.002142] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   97.002299] io scheduler noop registered
[   97.002377] io scheduler anticipatory registered
[   97.002457] io scheduler deadline registered
[   97.002536] io scheduler cfq registered
[   97.002624] RAMDISK driver initialized: 1 RAM disks of 4096K size 1024 blocksize
[   97.002812] mice: PS/2 mouse device common for all mice
[   97.002911] md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
[   97.003010] md: bitmap version 3.38
[   97.003088] NET: Registered protocol family 2
[   97.041038] IP: routing cache hash table of 8192 buckets, 64Kbytes
[   97.041295] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[   97.043234] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[   97.043660] TCP: Hash tables configured (established 262144 bind 65536)
[   97.043769] TCP reno registered
[   97.043883] TCP bic registered
[   97.043936] NET: Registered protocol family 1
[   97.044011] Using IPI Shortcut mode
[   97.044549] ACPI wakeup devices:
[   97.044604] HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1
[   97.047763] ACPI: (supports S0 S1 S4 S5)
[   97.051820] md: Autodetecting RAID arrays.
[   97.054860] md: autorun ...
[   97.057876] md: ... autorun DONE.
[   97.060956] RAMDISK: Compressed image found at block 0
[   97.084628] VFS: Mounted root (ext2 filesystem).
[   97.097114] SCSI subsystem initialized
[   97.104540] Red Hat/Adaptec aacraid driver (1.1.2-lk2 Jul  5 2005)
[   97.111097] ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
[   97.114366] ACPI: PCI Interrupt 0000:01:06.0[A] -> Link [APC3] -> GSI 18 (level, high) -> IRQ 177
[   97.177195] AAC0: kernel 4.2-0[7348]
[   97.180496] AAC0: monitor 4.2-0[7348]
[   97.183775] AAC0: bios 4.2-0[7348]
[   97.187013] AAC0: serial b869e1
[   97.192705] scsi0 : aacraid
[   97.196368]   Vendor: ADAPTEC   Model: Data 2            Rev: V1.0
[   97.199619]   Type:   Direct-Access                      ANSI SCSI revision: 02
[   97.203393]   Vendor: ADAPTEC   Model: Data 1            Rev: V1.0
[   97.206624]   Type:   Direct-Access                      ANSI SCSI revision: 02
[   97.219606] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   97.222833] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   97.230099] IT8212: IDE controller at PCI slot 0000:01:0c.0
[   97.236456] ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
[   97.239786] ACPI: PCI Interrupt 0000:01:0c.0[A] -> Link [APC2] -> GSI 17 (level, high) -> IRQ 185
[   97.243165] IT8212: chipset revision 17
[   97.246494] it821x: controller in pass through mode.
[   97.249816] IT8212: 100% native mode on irq 185
[   97.253187]     ide0: BM-DMA at 0xac00-0xac07, BIOS settings: hda:DMA, hdb:pio
[   97.256592]     ide1: BM-DMA at 0xac08-0xac0f, BIOS settings: hdc:DMA, hdd:pio
[   97.259936] Probing IDE interface ide0...
[   97.314937] input: AT Translated Set 2 keyboard on isa0060/serio0
[   97.548956] hda: Maxtor 6Y120P0, ATA DISK drive
[   98.220424] ide0 at 0x9c10-0x9c17,0xa002 on irq 185
[   98.224072] Probing IDE interface ide1...
[   98.512356] hdc: WDC WD1200JB-00CRA1, ATA DISK drive
[   99.184585] ide1 at 0xa410-0xa417,0xa802 on irq 185
[   99.195323] ieee1394: Initialized config rom entry `ip1394'
[   99.199942] ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
[   99.203579] ACPI: PCI Interrupt 0000:01:08.2[B] -> Link [APC2] -> GSI 17 (level, high) -> IRQ 185
[   99.258522] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[185] MMIO=[e1024000-e10247ff]  Max Packet=[2048]
[   99.269948] sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
[  100.535218] ieee1394: Host added: ID:BUS[0-01:1023] GUID[00023c0020002c8c]
[  104.277282] SCSI device sda: 78192128 512-byte hdwr sectors (40034 MB)
[  104.281116] sda: Write Protect is off
[  104.284895] sda: Mode Sense: 03 00 00 00
[  104.284902] sda: got wrong page
[  104.288607] sda: assuming drive cache: write through
[  104.292515] SCSI device sda: 78192128 512-byte hdwr sectors (40034 MB)
[  104.296246] sda: Write Protect is off
[  104.299937] sda: Mode Sense: 03 00 00 00
[  104.299944] sda: got wrong page
[  104.303628] sda: assuming drive cache: write through
[  104.307342]  sda: sda1 sda2 sda3
[  104.312356] Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
[  104.316162] SCSI device sdb: 702916608 512-byte hdwr sectors (359893 MB)
[  104.319985] sdb: Write Protect is off
[  104.323763] sdb: Mode Sense: 03 00 00 00
[  104.323769] sdb: got wrong page
[  104.327526] sdb: assuming drive cache: write through
[  104.331510] SCSI device sdb: 702916608 512-byte hdwr sectors (359893 MB)
[  104.335395] sdb: Write Protect is off
[  104.339243] sdb: Mode Sense: 03 00 00 00
[  104.339250] sdb: got wrong page
[  104.343064] sdb: assuming drive cache: write through
[  104.346875]  sdb: sdb1
[  104.351586] Attached scsi removable disk sdb at scsi0, channel 0, id 1, lun 0
[  104.439067] kjournald starting.  Commit interval 5 seconds
[  104.442698] EXT3-fs: mounted filesystem with ordered data mode.
[  104.550242] Freeing unused kernel memory: 200k freed
[  159.214212] EXT3 FS on sda2, internal journal
[  278.655644] aacraid: Host adapter reset request. SCSI hang ?
[  278.657556] aacraid: Host adapter appears dead
[  278.659450] scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
[  278.661511] SCSI error: <0 0 0 0> return code = 0x6000000
[  278.663577] end_request: I/O error, dev sda, sector 28632894
[  278.665710] scsi0 (0:0): rejecting I/O to offline device
[  278.667838] scsi0 (0:0): rejecting I/O to offline device
[  278.670085] Buffer I/O error on device sda2, logical block 690
[  278.672273] lost page write due to I/O error on sda2
[  278.674499] Aborting journal on device sda2.
[  278.676768] EXT3-fs error (device sda2) in ext3_reverse_inode_write: Journal has aborted
[  278.679163] scsi0 (0:0): rejecting I/O to offline device
[  278.681573] Buffer I/O error on device sda2, logical block 0
[  278.684026] lost page write due to I/O error on sda2
[  278.686529] EXT3-fs error (device sda2) in ext3_dirty_inode: Journal has aborted
[  278.689109] scsi0 (0:0): rejecting I/O to offline device
[  278.691710] Buffer I/O error on device sda2, logical block 0
[  278.694355] lost page write due to I/O error on sda2
[  278.697020] ext3_abort called.
[  278.699668] EXT3-fs error (device sda2) in ext3_journal_start_sb: Detected aborted journal
[  278.702463] Remounting filesystem read-only
[  278.705813] scsi0 (0:0): rejecting I/O to offline device
[  278.708685] Buffer I/O error on device sda2, logical block 1
[  278.711589] lost page write due to I/O error on sda2
[  278.714516] scsi0 (0:0): rejecting I/O to offline device
[  278.720477] Buffer I/O error on device sda2, logical block 491747
[  278.723509] lost page write due to I/O error on sda2
[  278.726577] scsi0 (0:0): rejecting I/O to offline device
[  278.726577] Buffer I/O error on device sda2, logical block 491834
[  278.729700] lost page write due to I/O error on sda2
[  278.732829] scsi0 (0:0): rejecting I/O to offline device
[  278.735954] Buffer I/O error on device sda2, logical block 491840
[  278.739147] lost page write due to I/O error on sda2
[  278.742389] scsi0 (0:0): rejecting I/O to offline device
[  278.745618] Buffer I/O error on device sda2, logical block 950284
[  278.748911] lost page write due to I/O error on sda2
[  278.752238] Buffer I/O error on device sda2, logical block 950285
[  278.755614] lost page write due to I/O error on sda2
[  278.759009] scsi0 (0:0): rejecting I/O to offline device
[  278.762408] Buffer I/O error on device sda2, logical block 950287
[  278.765855] lost page write due to I/O error on sda2
[  278.769318] scsi0 (0:0): rejecting I/O to offline device
... last message repeats about 45-times ...
[  347.564676] EXT3-fs error (device sda2): ext3_find_entry: reading directory #544057 offset 0
... here the log ends, nothing else happens then, since nothing is working when / is inaccessible ... :(
