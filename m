Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129595AbQKWSvq>; Thu, 23 Nov 2000 13:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129516AbQKWSvg>; Thu, 23 Nov 2000 13:51:36 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:13829 "EHLO
        tellus.mine.nu") by vger.kernel.org with ESMTP id <S129097AbQKWSvW>;
        Thu, 23 Nov 2000 13:51:22 -0500
Date: Thu, 23 Nov 2000 19:21:04 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, andrewm@uow.edu.au,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 3c59x: Using bad IRQ 0
In-Reply-To: <Pine.LNX.4.10.10011230901580.7992-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011231859140.32678-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000, Linus Torvalds wrote:
> > > Tobias, can you confirm that calling pci_enable_device before reading
> > > dev->irq fixes the 3c59x.c problem for you?
> > 
> > Nope. The interrupts do not seem to get through. Packets are transmitted,
> > but that's it. I've copied the interesting parts from dmesg:
> > 
> > 3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
> > See Documentation/networking/vortex.txt
> > PCI: Enabling device 00:0a.0 (0014 -> 0017)
> > PCI: Assigned IRQ 9 for device 00:0a.0
> > eth0: 3Com PCI 3c905C Tornado at 0xa400,  00:01:02:b4:18:e4, IRQ 9
> 
> Ok, the VIA stuff is happy, and enables the irq routing. The fact that the
> irq's don't actually seem to ever actually appear means that the enable
> sequence is probably slightly buggy.
> 
> Can you do two things?
> 
>  - enable DEBUG in arch/i386/kernel/pci-i386.h. This should make the code
>    print out what the pirq table entries are etc.

Done. When adding the call to eisa_set_level_irq, the line

IRQ for 00:0a.0(0) via 00:0a.0 -> PIRQ 03, mask 1eb8, excl 0000 -> newirq=9 -> assigning IRQ 9 ... OK

was changed into

IRQ for 00:0a.0(0) via 00:0a.0 -> PIRQ 03, mask 1eb8, excl 0000 -> newirq=9 -> assigning IRQ 9 -> edge ... OK

>  - add the line "eisa_set_level_irq(irq);" to pirq_via_set() just before
>    the "return 1;"

You certainly know your kernel very well... :-)

That did the trick, and the 3Com card works just fine.  Now the only
question is why this happened, but I leave that in you capable hands.

/Tobias


Linux version 2.4.0-test11 (root@igor.prodako.se) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #29 Thu Nov 23 18:58:29 CET 2000
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009e800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000001800 @ 000000000009e800 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000000feec000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000003000 @ 000000000ffec000 (ACPI data)
 BIOS-e820: 0000000000010000 @ 000000000ffef000 (reserved)
 BIOS-e820: 0000000000001000 @ 000000000ffff000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 65516
zone(0): 4096 pages.
zone(1): 61420 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro root=303 BOOT_FILE=/boot/vmlinuz ide=reverse 1
ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
Initializing CPU#0
Detected 1009.006 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2011.96 BogoMIPS
Memory: 255116k/262064k available (1624k kernel code, 6556k reserved, 101k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: BIOS32 Service Directory structure at 0xc00f92a0
PCI: BIOS32 Service Directory entry at 0xf0ef0
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xf10f0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:04.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
Unknown bridge resource 0: assuming transparent
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f16c0
00:0c slot=01 0:01/1eb8 1:02/1eb8 2:03/1eb8 3:05/1eb8
00:0b slot=02 0:02/1eb8 1:03/1eb8 2:05/1eb8 3:01/1eb8
00:0a slot=03 0:03/1eb8 1:05/1eb8 2:01/1eb8 3:02/1eb8
00:09 slot=04 0:05/1eb8 1:01/1eb8 2:02/1eb8 3:03/1eb8
00:0d slot=05 0:05/1eb8 1:01/1eb8 2:02/1eb8 3:03/1eb8
00:04 slot=00 0:01/1eb8 1:02/1eb8 2:03/1eb8 3:05/1eb8
00:01 slot=00 0:01/1eb8 1:02/1eb8 2:03/1eb8 3:05/1eb8
00:11 slot=00 0:02/1eb8 1:03/1eb8 2:05/1eb8 3:01/1eb8
00:12 slot=00 0:01/1eb8 1:02/1eb8 2:03/1eb8 3:05/1eb8
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: IRQ fixup
00:0a.0: ignoring bogus IRQ 255
00:0b.0: ignoring bogus IRQ 255
IRQ for 00:0a.0(0) via 00:0a.0 -> PIRQ 03, mask 1eb8, excl 0000 ... failed
IRQ for 00:0b.0(0) via 00:0b.0 -> PIRQ 02, mask 1eb8, excl 0000 -> got IRQ 10
PCI: Found IRQ 10 for device 00:0b.0
PCI: The same IRQ used for device 00:11.0
PCI: Allocating resources
PCI: Resource e0000000-e7ffffff (f=1208, d=0, p=0)
PCI: Resource 0000d800-0000d80f (f=101, d=0, p=0)
PCI: Resource 0000d400-0000d41f (f=101, d=0, p=0)
PCI: Resource 0000d000-0000d01f (f=101, d=0, p=0)
PCI: Resource 00009400-00009407 (f=101, d=0, p=0)
PCI: Resource 00009000-00009003 (f=101, d=0, p=0)
PCI: Resource 00008800-00008807 (f=101, d=0, p=0)
PCI: Resource 00008400-00008403 (f=101, d=0, p=0)
PCI: Resource 00008000-0000803f (f=101, d=0, p=0)
PCI: Resource d5000000-d501ffff (f=200, d=0, p=0)
PCI: Resource d6000000-d6ffffff (f=200, d=0, p=0)
PCI: Resource d8000000-dfffffff (f=1208, d=0, p=0)
PCI: Resource 0000a400-0000a47f (f=101, d=1, p=1)
PCI: Resource d5800000-d580007f (f=200, d=1, p=1)
PCI: Resource 0000a000-0000a01f (f=101, d=1, p=1)
PCI: Resource 00009800-00009807 (f=101, d=1, p=1)
PCI: Sorting device list...
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13)
Starting kswapd v1.8
parport_pc: Via 686A parallel port disabled in BIOS
pty: 256 Unix98 ptys configured
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller on PCI bus 00 dev 88
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0x8000-0x8007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x8008-0x800f, BIOS settings: hdc:DMA, hdd:DMA
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:4.1
    ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:DMA, hdh:pio
hda: IBM-DTLA-307060, ATA DISK drive
hde: HITACHI DVD-ROM GD-7500, ATAPI CDROM drive
hdg: PLEXTOR CD-R PX-W1210A, ATAPI CDROM drive
ide0 at 0x9400-0x9407,0x9002 on irq 10
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
ide3 at 0x170-0x177,0x376 on irq 15
hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(100)
hde: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.11
hdg: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Partition check:
 hda: [PTBL] [7476/255/63] hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
ppdev: user-space parallel port driver
PPP generic driver version 2.4.1
3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
PCI: Enabling device 00:0a.0 (0014 -> 0017)
IRQ for 00:0a.0(0) via 00:0a.0 -> PIRQ 03, mask 1eb8, excl 0000 -> newirq=9 -> assigning IRQ 9 -> edge ... OK
PCI: Assigned IRQ 9 for device 00:0a.0
eth0: 3Com PCI 3c905C Tornado at 0xa400,  00:01:02:b4:18:e4, IRQ 9
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
PPP Deflate Compression module registered
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Creative EMU10K1 PCI Audio Driver, version 0.7, 19:28:33 Nov 21 2000
PCI: Enabling device 00:0b.0 (0004 -> 0005)
emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xa000-0xa01f, IRQ 10
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kmem_create: Forcing size word alignment - nfs_fh
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 208836k swap-space (priority -1)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
