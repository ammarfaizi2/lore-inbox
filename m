Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbSLXKrw>; Tue, 24 Dec 2002 05:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267084AbSLXKrw>; Tue, 24 Dec 2002 05:47:52 -0500
Received: from 0x503e3f58.boanxx7.adsl-dhcp.tele.dk ([80.62.63.88]:13061 "HELO
	mail.hswn.dk") by vger.kernel.org with SMTP id <S267083AbSLXKrs>;
	Tue, 24 Dec 2002 05:47:48 -0500
Date: 24 Dec 2002 10:55:59 -0000
Message-ID: <20021224105559.1876.qmail@osiris.hswn.dk>
To: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Oops, panic: KT400 AGP and IO-APIC problems (Re: Linux v2.5.53)
References: <Pine.LNX.4.44.0212232141010.1079-100000@penguin.transmeta.com>
From: Henrik Storner <henrik@hswn.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Soltek SL75-FRV motherboard with a KT400 chipset.
AMD XP processor, 512 MB DDR RAM (Kingston). This is a new
system I got a few days ago, and it is giving me headaches:

1) AGP is not working (kernel oops with 2.5.53)
2) There is a problem with using IO_APIC (see below)
3) Sound does not work (not essential - 2.4.20-ac2 mostly works)

>Dave Jones <davej@codemonkey.org.uk>:
>  o [AGP] Add AGP 3.0 support and I7505 chipset driver
>  o [AGP] Hopefully get the KT400 working in AGP3.0 mode
>  o [AGP] Use compatability mode of KT400 if detected
>  o [AGP] Clean up capability pointer detection
>  o [AGP] __init audit after Rusty found a bug

Something is broken with AGP. If I configure with

  CONFIG_AGP=y
  # CONFIG_AGP3 is not set
  # CONFIG_AGP_INTEL is not set
  CONFIG_AGP_VIA=y

the kernel oops'es when initialising the AGP driver. Copied by hand:

agpgart: detected VIA Apollo Pro KT400 chipset
Null pointer deref at virtual adddres 00000010
EIP: c03db8fc
*pde: 00000000
Oops: 0000
CPU: 0
EIP: 0060:[<c03db8fc>]
eflags: 00010296
EIP is at 0xc03db8fc
eax: c03db800 ebx: 00000000 ecx: c036cf94 edx: 00000000
esi: c15d0000 edi: 00000000 ebp: dff81e00 esp: dff81ecc
ds: 0068 es: 0068 ss: 0068
Process swapper (pid: 1, threadinfo=dff80000, task=c151e040)
Stack: c15d0000 dff81ef8 00000090 c15d0000 00000000 dff81ef8 c03dba0a c15d0000
       c0352f75 000000a0 c15d0000 dff81f18 c03dba5a c15d0000 00000002 c016ac8c
       dffaf0c0 c15d0000 c0380920 dff81f34 c01fa6f8 c15d0000 c0412860 c15d0046
Call trace:
     sysfs_create_dir+0x7c/0xa0
     pci_device_probe+0x58/0x70
     bus_match+0x43/0x80
     driver_attach+0x61/0x80
     bus_add_driver+0x99/0xc0
     driver_register+0x31/0x40
     pci_register_driver+0x49/0x60
     init+0x20/0x180
     init+0x0/0x180
     kernel_thread_helper+0x5/0x18
Code: 8b 42 10 89 04 24 8b 42 20 c7 44 24 08 fd 00 00 00 89 44 24


Another problem is that I cannot boot with APIC enabled. I have

osiris:~/kernel/linux-2.5 $ grep APIC .config
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

this will not boot, unless add "noapic" as a boot parameter. If 
I omit this, it dies with:

enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
Enabling IO-APIC IRQs
Setting 2 in the phys_id_present_map ...
changing IO_APIC physical apic id to 2 ...
<0>Kernel panic: Could not set ID!


Booting with "noapic" works:

Linux version 2.5.53 (henrik@osiris.hswn.dk) (gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk)) #28 tir dec 24 10:40:12 CET 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fb950
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: VIA      Product ID: VT5440B      APIC at: 0xFEE00000
Processor #0 6:6 APIC version 17
I/O APIC #2 Version 3 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Exp parport=0x378,7 devfs=nomount nodevfsd noapic
Initializing CPU#0
Detected 1599.904 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3153.92 BogoMIPS
Memory: 514848k/524224k available (2132k kernel code, 8628k reserved, 695k data, 308k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU: AMD Athlon(tm) XP 1900+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1599.0696 MHz.
..... host bus clock speed is 266.0616 MHz.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
device class 'cpu': registering
device class cpu: adding driver system:cpu
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=1
PCI: Using configuration type 1
device class cpu: adding device CPU 0
interfaces: adding device CPU 0
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
SCSI subsystem driver Revision: 1.00
device class 'scsi-host': registering
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3177] at 00:11.0
PCI: IRQ 0 for device 00:11.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Hardcoded IRQ 14 for device 00:11.1
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
i2c-core.o: i2c core module version 2.6.4 (20020719)
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
i2c-proc.o version 2.6.4 (20020719)
pty: 256 Unix98 ptys configured
lp0: using parport0 (interrupt-driven).
Real Time Clock Driver v1.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557/8/9 [Ethernet , 00:02:B3:16:0A:CB, IRQ 12.
  Board assembly 721383-016, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: Hardcoded IRQ 14 for device 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DTTA-350640, ATA DISK drive
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-532E-A, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 12692736 sectors (6499 MB) w/468KiB Cache, CHS=13431/15/63, UDMA(33)
 hda: hda1 hda2 < hda5 hda6 >
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
scsi HBA driver sym53c8xx didn't set a release method, please fix the template
sym.0.9.0: setting PCI_COMMAND_PARITY...
sym0: <875> rev 0x3 on pci bus 0 device 9 function 0 irq 10
sym0: Tekram NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.16a
  Vendor: IBM       Model: DDRS-34560        Rev: S92A
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:0:0: tagged command queuing enabled, command queue depth 16.
sym0:0: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 15)
SCSI device sda: cache data unavailable
SCSI device sda: 8925000 512-byte hdwr sectors (4570 MB)
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
device class 'input': registering
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-core.o: i2c core module version 2.6.4 (20020719)
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
i2c-proc.o version 2.6.4 (20020719)
Advanced Linux Sound Architecture Driver Version 0.9.0rc6 (Tue Dec 17 19:01:13 2002 UTC).
ALSA sound/drivers/mpu401/mpu401.c:76: specify port
PCI: Setting latency timer of device 00:11.5 to 64
ALSA device list:
  #0: Virtual MIDI Card 1
  #1: VIA 8233A/C at 0xd800, irq 10
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device sd(8,1), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (sd(8,1)) for (sd(8,1))
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 308k freed
Adding 196684k swap on /dev/sda2.  Priority:-1 extents:1


-- 
Henrik Storner <henrik@hswn.dk> 
