Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262039AbSJDXWM>; Fri, 4 Oct 2002 19:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262068AbSJDXWM>; Fri, 4 Oct 2002 19:22:12 -0400
Received: from ti200710a082-0338.bb.online.no ([148.122.9.82]:4100 "EHLO
	empire.e") by vger.kernel.org with ESMTP id <S262039AbSJDXWC>;
	Fri, 4 Oct 2002 19:22:02 -0400
Message-ID: <3D9E23E2.8000400@freenix.no>
Date: Sat, 05 Oct 2002 01:27:30 +0200
From: "frode@freenix.no" <frode@freenix.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 (several issues): kernel BUG! at slab.c:1292, imm/ppa IOMega
 ZIP drivers modules ".o" not found, XFS won't link, depmod complains on
Content-Type: multipart/mixed;
 boundary="------------070502090506030301070301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070502090506030301070301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I just downloaded the linux-2.5.40 tarball.

The kernel was built and tested on a box running Debian Unstable (refreshed today).
I had four (five if you include ALSA breaking make menuconfig) issues.

     - the kernel wouldn't link with XFS enabled due to some
       unreferenced symbols ("run_task_queue", etc).

     - configuring for the SCSI IOMega Parallel port drivers as modules,
       make modules_install fails as the 'imm.o' and 'ppa.o' files
       are missing. (i just 'touch'ed these files to get
       "make modules_install" to continue)

     - make modules_install runs depmod which fails with
depmod: cannot read ELF header from /lib/modules/2.5.40/kernel/drivers/scsi/imm.o
depmod: cannot read ELF header from /lib/modules/2.5.40/kernel/drivers/scsi/ppa.o
depmod: *** Unresolved symbols in
/lib/modules/2.5.40/kernel/drivers/usb/input/usbkbd.o
depmod: 	usb_kbd_free_buffers
depmod: *** Unresolved symbols in
/lib/modules/2.5.40/kernel/net/ipv4/netfilter/ipt_owner.o
depmod: 	next_thread
depmod: 	find_task_by_pid
depmod: *** Unresolved symbols in
/lib/modules/2.5.40/kernel/net/ipv6/netfilter/ip6t_owner.o
depmod: 	next_thread
depmod: 	find_task_by_pid

       The first two are naturally caused by me just touching up 0 byte
       files as mentioned above.

     - Booting up, i got several "Debug: sleeping function called from illegal
        context at slab.c:1374", and one nasty-looking BUG!:
       "kernel BUG at slab.c:1292!" which apparently killed off klogd.

The slab.c:1292 bug occurs during bootup, just after init goes
to runlevel 2 and starts syslogd and klogd, and is about to enable swap.

I tried booting twice, and got the same bug at the same time during bootup.
I'll attach "dmesg > dmesg.2.5.40.first" and "diff -u dmesg.2.5.40.first 
dmesg.2.5.40.second" to show the few differences between my two bootups...

As you can see the last dmesg line before the BUG! line mounts a 256mb swap-file 
residing on my ext3 "/" filesystem mounted with priority '-2'. I also have a 
160mb swap partition which is mounted with priority '-1'. I don't know if the 
bug is any way related to this, though. I'm also a bit unsure what to make of 
the stack trace, but it might be of interest that this machine is an NFS client 
to another linux NFS server (seeing "vfs" and "dgram_sendmsg" in there :) )


Apart from klogd dying, everything else seems fine (although I haven't tried 
anything fancy apart from running a few ssh sessions and playing some audio).
Restarting klogd via "/etc/init.d/klogd start" when the system is running
seems to bring up klogd just fine.


(I'm not subscribed to the list; I would appreciate being CC:ed replies.)


--------------070502090506030301070301
Content-Type: text/plain;
 name="dmesg.2.5.40.first"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.2.5.40.first"

Linux version 2.5.40 (root@kingdom.e) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Sat Oct 5 00:08:38 CEST 2002
Video mode to be used for restore is f01
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017fec000 (usable)
 BIOS-e820: 0000000017fec000 - 0000000017fef000 (ACPI data)
 BIOS-e820: 0000000017fef000 - 0000000017fff000 (reserved)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 98284
  DMA zone: 4096 pages
  Normal zone: 94188 pages
  HighMem zone: 0 pages
ACPI: RSDP (v000 ASUS                       ) @ 0x000f65e0
ACPI: RSDT (v001 ASUS   K7V      12336.12337) @ 0x17fec000
ACPI: FADT (v001 ASUS   K7V      12336.12337) @ 0x17fec080
ACPI: BOOT (v001 ASUS   K7V      12336.12337) @ 0x17fec040
ACPI: DSDT (v001   ASUS K7V      00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=unstable2540 ro root=345 bootfs=ext3
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 750.033 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 1474.56 BogoMIPS
Memory: 384368k/393136k available (2170k kernel code, 8380k reserved, 1045k data, 116k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0183fbff c1c3fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU:     After generic, caps: 0183fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 749.0879 MHz.
..... host bus clock speed is 199.0967 MHz.
cpu: 0, clocks: 199967, slice: 99983
CPU0<T0:199952,T1:99968,D:1,S:99983,C:199967>
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf1010, last bus=1
PCI: Using configuration type 1
adding '' to cpu class interfaces
ACPI: Subsystem revision 20020918
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:...................................................................................................
Table [DSDT] - 326 Objects with 39 Devices 99 Methods 20 Regions
ACPI Namespace successfully loaded at root c048491c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:................................. exfldio-0103 [21] Ex_setup_region       : Field [PS2E] access width (4 bytes) too large for region [PSMG] (length 1)
 exfldio-0114 [21] Ex_setup_region       : Field [PS2E] Base+Offset+Width 0+0+4 is beyond end of region [PSMG] (length 1)
 dswexec-0404 [14] Ds_exec_end_op        : [AE_NOT_CONFIGURED]: Could not resolve operands, AE_AML_REGION_LIMIT
  uteval-0425 [07] Ut_execute_STA        : _STA on PS2M failed AE_AML_REGION_LIMIT
......
39 Devices found containing: 38 _STA, 0 _INI methods
Completing Region/Field/Buffer/Package initialization:................................................
Initialized 12/20 Regions 5/5 Fields 19/19 Buffers 12/12 Packages (326 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 exfldio-0103 [20] Ex_setup_region       : Field [PS2E] access width (4 bytes) too large for region [PSMG] (length 1)
 exfldio-0114 [20] Ex_setup_region       : Field [PS2E] Base+Offset+Width 0+0+4 is beyond end of region [PSMG] (length 1)
 dswexec-0404 [13] Ds_exec_end_op        : [AE_NOT_CONFIGURED]: Could not resolve operands, AE_AML_REGION_LIMIT
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:04.05 not present in PCI namespace
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:04.06 not present in PCI namespace
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc2b0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc2e0, dseg 0xf0000
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
PnPBIOS: PNP0c02: ioport range 0x290-0x297 has been reserved
PnPBIOS: PNP0c02: ioport range 0xe400-0xe47f has been reserved
PnPBIOS: PNP0c02: ioport range 0xe800-0xe83f could not be reserved
usb.c: registered new driver usbfs
usb.c: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: overridden by ACPI.
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Capability LSM initialized
PCI: Disabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(18)
parport0: assign_addrs: aa5500ff(18)
parport0: Printer, EPSON Stylus COLOR 850
parport_pc: Via 686A parallel port: io=0x378
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 21) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DPTA-372050, ATA DISK drive
hdb: QUANTUM FIREBALLP LM20.5, ATA DISK drive
hda: DMA disabled
hdb: DMA disabled
Debug: sleeping function called from illegal context at slab.c:1374
d7fcdea8 c01182d4 c032a9c0 c032fd37 0000055e 00000000 c0133c3a c032fd37 
       0000055e c04ad1f4 c04ad1bc d7efe46c 00000000 0000000e c0445000 c010cd22 
       c02668b0 d7d33970 000001d0 c04ad1bc c04ad1ac d7efe46c 00000000 00000000 
Call Trace:
 [<c01182d4>]__might_sleep+0x54/0x60
 [<c0133c3a>]kmem_cache_alloc+0x26/0x1d0
 [<c010cd22>]startup_8259A_irq+0xa/0x10
 [<c02668b0>]blk_init_free_list+0x4c/0xd0
 [<c0266941>]blk_init_queue+0xd/0xe8
 [<c0274d00>]ide_init_queue+0x28/0x68
 [<c027b0d4>]do_ide_request+0x0/0x18
 [<c0274fd8>]init_irq+0x298/0x354
 [<c0275336>]hwif_init+0x112/0x258
 [<c0274c2c>]probe_hwif_init+0x1c/0x6c
 [<c028113d>]ide_setup_pci_device+0x3d/0x68
 [<c0273cef>]via_init_one+0x33/0x3c
 [<c010508b>]init+0x33/0x188
 [<c0105058>]init+0x0/0x188
 [<c0106f59>]kernel_thread_helper+0x5/0xc

spurious 8259A interrupt: IRQ7.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: _NEC DV-5700A, ATAPI CD/DVD-ROM drive
hdd: CR-4801TE, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
hdd: DMA disabled
Debug: sleeping function called from illegal context at slab.c:1374
d7fcdea8 c01182d4 c032a9c0 c032fd37 0000055e 00000000 c0133c3a c032fd37 
       0000055e c04ad7cc c04ad794 d7efe534 00000000 0000000f c0445080 c010cd22 
       c02668b0 d7d33970 000001d0 c04ad794 c04ad784 d7efe534 00000000 00000000 
Call Trace:
 [<c01182d4>]__might_sleep+0x54/0x60
 [<c0133c3a>]kmem_cache_alloc+0x26/0x1d0
 [<c010cd22>]startup_8259A_irq+0xa/0x10
 [<c02668b0>]blk_init_free_list+0x4c/0xd0
 [<c0266941>]blk_init_queue+0xd/0xe8
 [<c0274d00>]ide_init_queue+0x28/0x68
 [<c027b0d4>]do_ide_request+0x0/0x18
 [<c0274fd8>]init_irq+0x298/0x354
 [<c0275336>]hwif_init+0x112/0x258
 [<c0274c2c>]probe_hwif_init+0x1c/0x6c
 [<c0281161>]ide_setup_pci_device+0x61/0x68
 [<c0273cef>]via_init_one+0x33/0x3c
 [<c010508b>]init+0x33/0x188
 [<c0105058>]init+0x0/0x188
 [<c0106f59>]kernel_thread_helper+0x5/0xc

ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=2495/255/63, UDMA(66)
 hda:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 hda1 hda2 < hda5 >
hdb: host protected area => 1
hdb: 40132503 sectors (20548 MB) w/1900KiB Cache, CHS=2498/255/63, UDMA(66)
 hdb:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 hdb1 < hdb5 hdb6 hdb7 hdb8 > hdb2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: _NEC      Model: DV-5700A          Rev: 1.91
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MITSUMI   Model: CR-4801TE         Rev: 2.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 17x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 8x/8x writer cd/rw xa/form2 cdda tray
Debug: sleeping function called from illegal context at slab.c:1374
d7fcdf14 c01182d4 c032a9c0 c032fd37 0000055e 00001000 c0133e3a c032fd37 
       0000055e d8800000 00000246 00001000 00001000 c024f156 d7c51954 c041da08 
       c0132abd 0000001c 000001d0 d7fcc000 00000246 00001000 000001d2 d7c51954 
Call Trace:
 [<c01182d4>]__might_sleep+0x54/0x60
 [<c0133e3a>]kmalloc+0x56/0x214
 [<c024f156>]attach+0x42/0x48
 [<c0132abd>]get_vm_area+0x29/0x104
 [<c0132d6e>]__vmalloc+0x32/0x10c
 [<c0132e5d>]vmalloc+0x15/0x1c
 [<c02964ac>]sg_init+0x80/0x100
 [<c0285635>]scsi_register_device+0x71/0x114
 [<c010508b>]init+0x33/0x188
 [<c0105058>]init+0x0/0x188
 [<c0106f59>]kernel_thread_helper+0x5/0xc

ehci-hcd.c: 2002-Sep-23 USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-hcd.c: block sizes: qh 96 qtd 96 itd 128 sitd 64
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1000.000 MB/sec
   32regs    :   980.000 MB/sec
   pII_mmx   :  1720.000 MB/sec
   p5_mmx    :  2188.000 MB/sec
raid5: using function: p5_mmx (2188.000 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 116k freed
Adding 160608k swap on /dev/hdb7.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,69), internal journal
Real Time Clock Driver v1.11
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0d.0: 3Com PCI 3c900 Cyclone 10Mbps Combo at 0x9800. Vers LK1.1.18
phy=0, phyx=24, mii_status=0x180d
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,66), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,70), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
FAT: Using codepage cp437
FAT: Using IO charset iso8859-1
FAT: Using codepage cp437
FAT: Using IO charset iso8859-1
FAT: Using codepage cp437
FAT: Using IO charset iso8859-1
Adding 262136k swap on /swapfile.  Priority:-2 extents:519
------------[ cut here ]------------
kernel BUG at slab.c:1292!
invalid operand: 0000
3c59x rtc  
CPU:    0
EIP:    0060:[<c0133f6e>]    Not tainted
EFLAGS: 00010002
EIP is at kmalloc+0x18a/0x214
eax: d756efff   ebx: d7feb6a0   ecx: 00000001   edx: 00000001
esi: d756ee00   edi: 00000000   ebp: 00012800   esp: d7949e54
ds: 0068   es: 0068   ss: 0068
Process klogd (pid: 198, threadinfo=d7948000 task=d78af580)
Stack: d7bd8314 c04b2ac0 000001d0 00000000 00000200 00000000 00000246 c02ccf42 
       00000120 000001d0 ffffffe0 d7948000 00000032 c02cc4b4 00000080 000001d0 
       d792e200 d719a1e4 d792e084 d7949f04 d7949f5c 00000037 00000000 c02cc640 
Call Trace:
 [<c02ccf42>]alloc_skb+0xd2/0x19c
 [<c02cc4b4>]sock_alloc_send_pskb+0x6c/0x1dc
 [<c02cc640>]sock_alloc_send_skb+0x1c/0x24
 [<c030ea98>]unix_dgram_sendmsg+0xf8/0x418
 [<c02ca06e>]sock_sendmsg+0x72/0x94
 [<c02ca280>]sock_write+0xa4/0xb0
 [<c01408bd>]vfs_write+0xb1/0x130
 [<c01409a2>]sys_write+0x2a/0x3c
 [<c0108a4b>]syscall_call+0x7/0xb

Code: 0f 0b 0c 05 37 fd 32 c0 f7 c5 00 04 00 00 74 36 b8 a5 c2 0f 
 

--------------070502090506030301070301
Content-Type: text/plain;
 name="dmesg.2.5.40.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.2.5.40.diff"

--- dmesg.2.5.40.first	2002-10-05 01:15:24.000000000 +0200
+++ dmesg.2.5.40.second	2002-10-05 01:15:32.000000000 +0200
@@ -27,7 +27,7 @@
 Local APIC disabled by BIOS -- reenabling.
 Found and enabled local APIC!
 Initializing CPU#0
-Detected 750.033 MHz processor.
+Detected 750.191 MHz processor.
 Console: colour VGA+ 80x50
 Calibrating delay loop... 1474.56 BogoMIPS
 Memory: 384368k/393136k available (2170k kernel code, 8380k reserved, 1045k data, 116k init, 0k highmem)
@@ -53,10 +53,10 @@
 ESR value after enabling vector: 00000000
 Using local APIC timer interrupts.
 calibrating APIC timer ...
-..... CPU clock speed is 749.0879 MHz.
-..... host bus clock speed is 199.0967 MHz.
-cpu: 0, clocks: 199967, slice: 99983
-CPU0<T0:199952,T1:99968,D:1,S:99983,C:199967>
+..... CPU clock speed is 749.0925 MHz.
+..... host bus clock speed is 199.0980 MHz.
+cpu: 0, clocks: 199980, slice: 99990
+CPU0<T0:199968,T1:99968,D:10,S:99990,C:199980>
 Linux NET4.0 for Linux 2.4
 Based upon Swansea University Computer Society NET3.039
 Initializing RT netlink socket
@@ -308,13 +308,13 @@
 EIP:    0060:[<c0133f6e>]    Not tainted
 EFLAGS: 00010002
 EIP is at kmalloc+0x18a/0x214
-eax: d756efff   ebx: d7feb6a0   ecx: 00000001   edx: 00000001
-esi: d756ee00   edi: 00000000   ebp: 00012800   esp: d7949e54
+eax: d7626fff   ebx: d7feb6a0   ecx: 00000001   edx: 00000001
+esi: d7626e00   edi: 00000000   ebp: 00012800   esp: d705be54
 ds: 0068   es: 0068   ss: 0068
-Process klogd (pid: 198, threadinfo=d7948000 task=d78af580)
+Process klogd (pid: 188, threadinfo=d705a000 task=d78ae880)
 Stack: d7bd8314 c04b2ac0 000001d0 00000000 00000200 00000000 00000246 c02ccf42 
-       00000120 000001d0 ffffffe0 d7948000 00000032 c02cc4b4 00000080 000001d0 
-       d792e200 d719a1e4 d792e084 d7949f04 d7949f5c 00000037 00000000 c02cc640 
+       00000120 000001d0 ffffffe0 d705a000 00000032 c02cc4b4 00000080 000001d0 
+       d792f200 d72001e4 d792f084 d705bf04 d705bf5c 00000037 00000000 c02cc640 
 Call Trace:
  [<c02ccf42>]alloc_skb+0xd2/0x19c
  [<c02cc4b4>]sock_alloc_send_pskb+0x6c/0x1dc

--------------070502090506030301070301--

