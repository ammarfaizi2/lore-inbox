Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSJVCF3>; Mon, 21 Oct 2002 22:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261984AbSJVCF3>; Mon, 21 Oct 2002 22:05:29 -0400
Received: from [203.238.93.2] ([203.238.93.2]:18440 "EHLO kasumi.idis.co.kr")
	by vger.kernel.org with ESMTP id <S261914AbSJVCFS>;
	Mon, 21 Oct 2002 22:05:18 -0400
Message-ID: <02b301c27970$1c3d1b60$135deecb@jhheo>
From: "JunHyeok Heo" <jhheo@idis.co.kr>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>, "Michael Goertz" <goertz@gmx.de>,
       "Michael Kiefer" <Michael-Kiefer@web.de>
References: <Pine.LNX.4.10.10210211645240.2756-100000@master.linux-ide.org>
Subject: Re: Kernel Panic 2.4.19 with Segate 80GB HDD
Date: Tue, 22 Oct 2002 11:09:53 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am sorry that i have little knowledge on the spec. related to IDE.
The statement of "erroneously has 48bit LBA turned on" was made
based on the original code and the following experiment.
When i copied "id->lba_capacity" to "id->lba_capacity_2" with maintaining
48bit LBA
in case that id->lba_capacity_2 (100-103th byte in ID) was zero,
I could not access the HDD correctly and i got always "DriveStatusError".
So i assumed Seagate80GB HDD does not support 48bit LBA properly.
I inserted the following code at the very first part of the
"init_idedisk_capacity()" function at the experiment.

if (id->cfs_enable_2 & 0x0400) {
      if (id->lba_capacity_2 == (long long) 0)

             id->lba_capacity_2 = id->lba_capacity;
      }
}

p.s.
    Anyway it is my pleasure i can talk to you.
    I always thank you for what you have done related to the IDE stuff.

----- Original Message -----
From: "Andre Hedrick" <andre@linux-ide.org>
To: "JunHyeok Heo" <jhheo@idis.co.kr>
Cc: <linux-kernel@vger.kernel.org>; "Michael Goertz" <goertz@gmx.de>;
"Michael Kiefer" <Michael-Kiefer@web.de>
Sent: Tuesday, October 22, 2002 8:52 AM
Subject: Re: Kernel Panic 2.4.19 with Segate 80GB HDD


>
> No "erroneously has 48bit LBA turned on" is not what is happening.
> There are general purpose logs which reqire 48-bit operations.
> A device can support 48-bit command and be less than 137GB.
> Also if you disable 48-bit some of the drive features will not work.
>
> Bit on and zero in words 100-103 is a Buggy SPEC!
>
> Currently an beautiful mess has been made by the committe.
>
> If device supports 48-bit is it required to report capacity in all 48-bit
> locations in the IDENTIFY Page?
>
> If the device is destroked to less than 137GB does it report the same in
> both words 60-61 and 100-103?
>
> There are worse yet to come.
>
>
> On Mon, 21 Oct 2002, JunHyeok Heo wrote:
>
> >
> > I investigated this problem.
> > The problem was that Segate 80GB HDD (ST380020ACE) erroneously has 48bit
LBA
> > turned on,
> > but the capacity field for 48Bit LBA has 0.
> > So, i modified the "init_idedisk_capacity()" function to forcily use the
> > 28bit LBA mode
> > in this case. I know that the HDD less than 137GB no need to use 48bit
LBA.
> >
> > If there is someone who suffers from the same symptom,
> > try the following patch at your own risk. ^^;;;
> >
> > --------- From Here -----------------
> > diff -urN linux-2.4.19-ori/drivers/ide/ide-disk.c
> > linux-2.4.19/drivers/ide/ide-disk.c
> > --- linux-2.4.19-ori/drivers/ide/ide-disk.c Sat Aug  3 09:39:44 2002
> > +++ linux-2.4.19/drivers/ide/ide-disk.c Mon Oct 21 17:09:09 2002
> > @@ -928,6 +928,13 @@
> >   drive->select.b.lba = 0;
> >
> >   if (id->cfs_enable_2 & 0x0400) {
> > +  if (id->lba_capacity_2 == (long long) 0) {
> > +   id->cfs_enable_2 &= ~0x0400;
> > +   printk("%s: not suitable for 48bit LBA, forcily 28bit LBA is
> > used\n",drive->name);
> > +  }
> > + }
> > +
> > + if (id->cfs_enable_2 & 0x0400) {
> >    capacity_2 = id->lba_capacity_2;
> >    drive->head  = drive->bios_head = 255;
> >    drive->sect  = drive->bios_sect = 63;
> > ----- Original Message -----
> > From: "JunHyeok Heo" <jhheo@idis.co.kr>
> > To: <linux-kernel@vger.kernel.org>
> > Sent: Friday, October 18, 2002 10:35 AM
> > Subject: Kernel Panic 2.4.19 with Segate 80GB HDD
> >
> >
> > >
> > > I used kernel 2.4.19 with Segate 80GB HDD (ST380020ACE).
> > > The kernel could not recognize the number of sectors correctly, and
then
> > > result in kernel panic.
> > > I tried kernel 2.4.18 with the same HDD, there is no problem.
> > >
> > > Is this a bug in the ide device driver ? or  is there any compatible
HDD
> > > list for 2.4.19 kernel ?
> > >
> > > The cpu is PentiumIII 700Mhz cpu and
> > > The chipset of motherboard is Intel BX.
> > > The IDE controller is INTEL82801BA_9
> > >
> > > In case of 2.4.19 kernel, the booting message as follows...
> > > --
> > > Linux version 2.4.19 (root@i74) (gcc version 2.95.4 (Debian
prerelease))
> > #2
> > > Wed
> > > Oct 16 21:27:55 KST 2002
> > > BIOS-provided physical RAM map:
> > >  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> > >  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> > >  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> > >  BIOS-e820: 0000000000100000 - 000000000bfeb000 (usable)
> > >  BIOS-e820: 000000000bfeb000 - 000000000bfef000 (ACPI data)
> > >  BIOS-e820: 000000000bfef000 - 000000000bfff000 (reserved)
> > >  BIOS-e820: 000000000bfff000 - 000000000c000000 (ACPI NVS)
> > >  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> > > 191MB LOWMEM available.
> > > On node 0 totalpages: 49131
> > > zone(0): 4096 pages.
> > > zone(1): 45035 pages.
> > > zone(2): 0 pages.
> > > Kernel command line: BOOT_IMAGE=host19 ro root=301
> > > BOOT_FILE=/boot/vmlinuz-2.4.1
> > > 9 console=ttyS0,9600 console=ttyS0,9600
> > > Initializing CPU#0
> > > Detected 706.972 MHz processor.
> > > Console: colour VGA+ 80x25
> > > Calibrating delay loop... 1412.30 BogoMIPS
> > > Memory: 192408k/196524k available (1069k kernel code, 3728k reserved,
260k
> > > data,
> > >  60k init, 0k highmem)
> > > Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
> > > Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
> > > Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
> > > Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
> > > Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
> > > CPU: L1 I cache: 16K, L1 D cache: 16K
> > > CPU: L2 cache: 256K
> > > Intel machine check architecture supported.
> > > Intel machine check reporting enabled on CPU#0.
> > > CPU: Intel Pentium III (Coppermine) stepping 03
> > > Enabling fast FPU save and restore... done.
> > > Enabling unmasked SIMD FPU exception support... done.
> > > Checking 'hlt' instruction... OK.
> > > POSIX conformance testing by UNIFIX
> > > PCI: PCI BIOS revision 2.10 entry at 0xf0d90, last bus=2
> > > PCI: Using configuration type 1
> > > PCI: Probing PCI hardware
> > > Unknown bridge resource 0: assuming transparent
> > > PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
> > > Linux NET4.0 for Linux 2.4
> > > Based upon Swansea University Computer Society NET3.039
> > > Initializing RT netlink socket
> > > Starting kswapd
> > > Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> > > pty: 256 Unix98 ptys configured
> > > Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> > > SERIAL_PCI en
> > > abled
> > > ttyS00 at 0x03f8 (irq = 4) is a 16550A
> > > ttyS01 at 0x02f8 (irq = 3) is a 16550A
> > > Real Time Clock Driver v1.10e
> > > Uniform Multi-Platform E-IDE driver Revision: 6.31
> > > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx
> > > ICH2: IDE controller on PCI bus 00 dev f9
> > > ICH2: chipset revision 1
> > > ICH2: not 100% native mode: will probe irqs later
> > >     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
> > >     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
> > > hda: ST380020ACE, ATA DISK drive
> > > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > > hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> > > hda: task_no_data_intr: error=0x04 { DriveStatusError }
> > > hda: setmax_ext LBA 1, native  0
> > > hda: 0 sectors (0 MB) w/2048KiB Cache, CHS=0/255/63, UDMA(33)
> > > PPP generic driver version 2.4.2
> > > NET4: Linux TCP/IP 1.0 for NET4.0
> > > IP Protocols: ICMP, UDP, TCP
> > > IP: routing cache hash table of 1024 buckets, 8Kbytes
> > > TCP: Hash tables configured (established 16384 bind 16384)
> > > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > > hda1: bad access: block=2, count=2
> > > end_request: I/O error, dev 03:01 (hda), sector 2
> > > EXT2-fs: unable to read superblock
> > > hda1: bad access: block=0, count=1
> > > end_request: I/O error, dev 03:01 (hda), sector 0
> > > FAT: unable to read boot sector
> > > hda1: bad access: block=128, count=1
> > > end_request: I/O error, dev 03:01 (hda), sector 128
> > > read_super_block: bread failed (dev 03:01, block 128, size 512)
> > > hda1: bad access: block=16, count=1
> > > end_request: I/O error, dev 03:01 (hda), sector 16
> > > read_super_block: bread failed (dev 03:01, block 16, size 512)
> > > Kernel panic: VFS: Unable to mount root fs on 03:01
> > >
> > > --
> > >
> > > In case of 2.4.18 kernel, the booting message as follows...
> > >
> > > Linux version 2.4.18 (root@i076) (gcc version 2.95.4 (Debian
prerelease))
> > #5
> > > Fri Mar 22 19:21:49 KST 2002
> > > BIOS-provided physical RAM map:
> > >  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> > >  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> > >  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> > >  BIOS-e820: 0000000000100000 - 000000000bfeb000 (usable)
> > >  BIOS-e820: 000000000bfeb000 - 000000000bfef000 (ACPI data)
> > >  BIOS-e820: 000000000bfef000 - 000000000bfff000 (reserved)
> > >  BIOS-e820: 000000000bfff000 - 000000000c000000 (ACPI NVS)
> > >  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> > > On node 0 totalpages: 49131
> > > zone(0): 4096 pages.
> > > zone(1): 45035 pages.
> > > zone(2): 0 pages.
> > > Local APIC disabled by BIOS -- reenabling.
> > > Found and enabled local APIC!
> > > Kernel command line: BOOT_IMAGE=host18 ro root=301
> > > BOOT_FILE=/boot/vmlinuz-2.4.18
> > > Initializing CPU#0
> > > Detected 706.973 MHz processor.
> > > Console: colour VGA+ 80x25
> > > Calibrating delay loop... 1412.30 BogoMIPS
> > > Memory: 191400k/196524k available (1064k kernel code, 4736k reserved,
287k
> > > data, 76k init, 0k highmem)
> > > Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
> > > Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
> > > Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
> > > Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
> > > Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
> > > CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
> > > CPU: L1 I cache: 16K, L1 D cache: 16K
> > > CPU: L2 cache: 256K
> > > CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
> > > Intel machine check architecture supported.
> > > Intel machine check reporting enabled on CPU#0.
> > > CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
> > > CPU:             Common caps: 0383fbff 00000000 00000000 00000000
> > > CPU: Intel Pentium III (Coppermine) stepping 03
> > > Enabling fast FPU save and restore... done.
> > > Enabling unmasked SIMD FPU exception support... done.
> > > Checking 'hlt' instruction... OK.
> > > POSIX conformance testing by UNIFIX
> > > enabled ExtINT on CPU#0
> > > ESR value before enabling vector: 00000000
> > > ESR value after enabling vector: 00000000
> > > Using local APIC timer interrupts.
> > > calibrating APIC timer ...
> > > ..... CPU clock speed is 706.9670 MHz.
> > > ..... host bus clock speed is 100.9952 MHz.
> > > cpu: 0, clocks: 1009952, slice: 504976
> > > CPU0<T0:1009952,T1:504976,D:0,S:504976,C:1009952>
> > > mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> > > mtrr: detected mtrr type: Intel
> > > PCI: PCI BIOS revision 2.10 entry at 0xf0d90, last bus=2
> > > PCI: Using configuration type 1
> > > PCI: Probing PCI hardware
> > > Unknown bridge resource 0: assuming transparent
> > > PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
> > > Linux NET4.0 for Linux 2.4
> > > Based upon Swansea University Computer Society NET3.039
> > > Initializing RT netlink socket
> > > Starting kswapd
> > > pty: 256 Unix98 ptys configured
> > > Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> > > SERIAL_PCI enabled
> > > ttyS00 at 0x03f8 (irq = 4) is a 16550A
> > > ttyS01 at 0x02f8 (irq = 3) is a 16550A
> > > request_module[parport_lowlevel]: Root fs not mounted
> > > lp: driver loaded but no devices found
> > > ppdev: user-space parallel port driver
> > > block: 128 slots per queue, batch=32
> > > Uniform Multi-Platform E-IDE driver Revision: 6.31
> > > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx
> > > PIIX4: IDE controller on PCI bus 00 dev f9
> > > PIIX4: chipset revision 1
> > > PIIX4: not 100% native mode: will probe irqs later
> > >     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
> > >     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
> > > hda: ST380020ACE, ATA DISK drive
> > > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > > hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63,
> > UDMA(33)
> > > Partition check:
> > >  hda: hda1
> > > PPP generic driver version 2.4.1
> > > NET4: Linux TCP/IP 1.0 for NET4.0
> > > IP Protocols: ICMP, UDP, TCP
> > > IP: routing cache hash table of 1024 buckets, 8Kbytes
> > > TCP: Hash tables configured (established 16384 bind 16384)
> > > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > > FAT: bogus logical sector size 0
> > > reiserfs: checking transaction log (device 03:01) ...
> > > Using r5 hash to sort names
> > > ReiserFS version 3.6.25
> > > VFS: Mounted root (reiserfs filesystem) readonly.
> > > Freeing unused kernel memory: 76k freed
> > > 8139too Fast Ethernet driver 0.9.24
> > > PCI: Found IRQ 10 for device 02:0e.0
> > > eth0: RealTek RTL8139 Fast Ethernet at 0xcc8b5000, 00:50:fc:3b:2a:76,
IRQ
> > 10
> > > eth0:  Identified 8139 chip type 'RTL-8139C'
> > > eth0: Setting half-duplex based on auto-negotiated partner ability
0000.
> > >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> Andre Hedrick
> LAD Storage Consulting Group
>
>

