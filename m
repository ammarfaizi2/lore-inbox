Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268634AbUIGVqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268634AbUIGVqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268662AbUIGVk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:40:58 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:15763 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S268261AbUIGVfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:35:19 -0400
Message-ID: <413E2990.8020108@dgreaves.com>
Date: Tue, 07 Sep 2004 22:35:12 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: Sebastian Utz <su@rotamente.com>, linux-raid@vger.kernel.org
Subject: Re: Software RAID-5 attempt to access beyond end of device...
References: <1093621033.13979.49.camel@slurp> <16690.51386.426771.284290@cse.unsw.edu.au>
In-Reply-To: <16690.51386.426771.284290@cse.unsw.edu.au>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had this problem too so cc'ing lkml as Neil suggests.

my oops and dmesg at the end.

The reiserfs is on top of an lvm2 on top of a raid5
I tried booting with 2.6.6 and then 2.6.7

David

Neil Brown wrote:

>On Friday August 27, su@rotamente.com wrote:
>  
>
>>Hello,
>>
>>I have a problem with an Software RAID-5 at the top of 4 IDE-Drives
>>connected via 2 Promise UltraTX2 (20268) IDE controller.
>>    
>>
>
>This is not a raid problem.  It is a problem with your filesystem or
>your hardware.
>I think you have reported this for both reiserfs and ext3, in which
>can it is unlikely to be the filesystem.  I guess it could be in the
>generic block layer...
>
>  
>
>>FS is EXT3.
>>Kernel 2.6.8.1	(problem occured with 2.6.7, update didn't helped)
>>CPU: Pentium II 400
>>Mainboard: Asus P2B-S
>>
>>After 29% usage, I've got an Kernel oops and system stalls:
>>-------- snip start -------------
>>Aug 27 16:30:18 gharb kernel: attempt to access beyond end of device
>>Aug 27 16:30:18 gharb kernel: md0: rw=1, want=6917529027856096120,
>>limit=241215360
>>    
>>
>
>6917529027856096120 is 600000000CD0DB78 in hex.
>0xCD0DB78 is 215014264 which is not beyond the end of the device.
>It looks like  2 extra bits have been set at the top of the address.
>This could be due to bad memory (though that is more commonly a
>single-bit error, not a double bit error), or it could be the
>filesystem send a bad request, possibly due to bad indexing
>information that has previously been stored on disk.
>
>I recommend running memtest for a while and confirming that it isn't a
>hardware error, and then possibly following up on
>linux-kernel@vger.kernel.org.
>
>
>NeilBrown
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-raid" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>
Hi I first got this oops 'out of the blue'

Memtest seems to run fine

When rebooting and remounting, it now oopses every time I remount the fs
(I'm running reiserfsck --fix-fixable now.)

################################
First Oops:
Sep  7 20:32:04 cu kernel: attempt to access beyond end of device
Sep  7 20:32:04 cu kernel: dm-0: rw=0, want=1423563552, limit=1153433600
Sep  7 20:32:04 cu kernel: Buffer I/O error on device dm-0, logical 
block 2862300003
Sep  7 20:45:02 cu kernel: nfs warning: mount version older than kernel
Sep  7 20:45:02 cu last message repeated 4 times
Sep  7 20:56:33 cu kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 000006d8
Sep  7 20:56:33 cu kernel:  printing eip:
Sep  7 20:56:33 cu kernel: c01955fd
Sep  7 20:56:33 cu kernel: *pde = 00000000
Sep  7 20:56:33 cu kernel: Oops: 0002 [#1]
Sep  7 20:56:33 cu kernel: CPU:    0
Sep  7 20:56:33 cu kernel: EIP:    
0060:[set_bit_in_list_bitmap+61/112]    Not tainted
Sep  7 20:56:33 cu kernel: EFLAGS: 00010286   (2.6.6)
Sep  7 20:56:33 cu kernel: EIP is at set_bit_in_list_bitmap+0x3d/0x70
Sep  7 20:56:33 cu kernel: eax: 00000000   ebx: 0001ca42   ecx: 
cec11200   edx: d1201918
Sep  7 20:56:33 cu kernel: esi: 000036d4   edi: d112d104   ebp: 
00000000   esp: cfe11a5c
Sep  7 20:56:33 cu kernel: ds: 007b   es: 007b   ss: 0068
Sep  7 20:56:33 cu kernel: Process kswapd0 (pid: 8, threadinfo=cfe10000 
task=cfe16b70)
Sep  7 20:56:33 cu kernel: Stack: d112d10c d112d10c e52136d4 cec11200 
c019a43b cec11200 e52136d4 d112d104
Sep  7 20:56:33 cu kernel:        c0174b2a cfe11de4 e52136d4 c573165c 
cfe10000 c0174b65 cfe11de4 cec11200
Sep  7 20:56:33 cu kernel:        e52136d4 e52136d4 00000268 c0191e74 
cfe11de4 e52136d4 cf17e330 c04be980
Sep  7 20:56:33 cu kernel: Call Trace:
Sep  7 20:56:33 cu kernel:  [journal_mark_freed+155/512] 
journal_mark_freed+0x9b/0x200
Sep  7 20:56:33 cu kernel:  [_reiserfs_free_block+314/336] 
_reiserfs_free_block+0x13a/0x150
Sep  7 20:56:33 cu kernel:  [reiserfs_free_block+37/64] 
reiserfs_free_block+0x25/0x40
Sep  7 20:56:33 cu kernel:  [prepare_for_delete_or_cut+1380/1920] 
prepare_for_delete_or_cut+0x564/0x780
Sep  7 20:56:33 cu kernel:  [ata_scsi_translate+173/240] 
ata_scsi_translate+0xad/0xf0
Sep  7 20:56:33 cu kernel:  [reiserfs_cut_from_item+191/1248] 
reiserfs_cut_from_item+0xbf/0x4e0
Sep  7 20:56:33 cu kernel:  [reiserfs_do_truncate+606/1328] 
reiserfs_do_truncate+0x25e/0x530
Sep  7 20:56:33 cu kernel:  [reiserfs_delete_object+61/112] 
reiserfs_delete_object+0x3d/0x70
Sep  7 20:56:33 cu kernel:  [reiserfs_delete_inode+130/192] 
reiserfs_delete_inode+0x82/0xc0
Sep  7 20:56:33 cu kernel:  [reiserfs_delete_inode+0/192] 
reiserfs_delete_inode+0x0/0xc0
Sep  7 20:56:33 cu kernel:  [generic_delete_inode+81/208] 
generic_delete_inode+0x51/0xd0
Sep  7 20:56:33 cu kernel:  [iput+85/128] iput+0x55/0x80
Sep  7 20:56:33 cu kernel:  [prune_dcache+249/304] prune_dcache+0xf9/0x130
Sep  7 20:56:33 cu kernel:  [shrink_dcache_memory+35/48] 
shrink_dcache_memory+0x23/0x30
Sep  7 20:56:33 cu kernel:  [shrink_slab+288/368] shrink_slab+0x120/0x170
Sep  7 20:56:33 cu kernel:  [balance_pgdat+513/624] 
balance_pgdat+0x201/0x270
Sep  7 20:56:33 cu kernel:  [kswapd+279/304] kswapd+0x117/0x130
Sep  7 20:56:33 cu kernel:  [autoremove_wake_function+0/80] 
autoremove_wake_function+0x0/0x50
Sep  7 20:56:33 cu kernel:  [autoremove_wake_function+0/80] 
autoremove_wake_function+0x0/0x50
Sep  7 20:56:33 cu kernel:  [kswapd+0/304] kswapd+0x0/0x130
Sep  7 20:56:33 cu kernel:  [kernel_thread_helper+5/20] 
kernel_thread_helper+0x5/0x14
Sep  7 20:56:33 cu kernel:
Sep  7 20:56:33 cu kernel: Code: 0f ab 30 8b 7c 24 0c 8b 5c 24 04 8b 74 
24 08 31 c0 83 c4 10
################################


reboot, mount filesystem, oops:
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
ReiserFS: dm-0: Removing [243 454 0x0 SD]..<4>ReiserFS: dm-0: warning: 
vs-4075: reiserfs_free_block: block 3844159188 is out of range on dm-0
Unable to handle kernel paging request at virtual address 379df56e
printing eip:
c019907a
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: ipv6 e1000 usblp uhci_hcd usbcore ext3 jbd mbcache 
nfsd exportfs lockd sunrpc unix
CPU:    0
EIP:    0060:[<c019907a>]    Not tainted
EFLAGS: 00010206   (2.6.7)
EIP is at set_bit_in_list_bitmap+0x3a/0x70
eax: 379df56a   ebx: 000134e8   ecx: cffc3e00   edx: 379df56a
esi: 000044a7   edi: d115e0e4   ebp: 00000000   esp: cda71968
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 1143, threadinfo=cda70000 task=cf867130)
Stack: c03367e1 d115e10c 9a7444a7 cffc3e00 c019df2b cffc3e00 9a7444a7 
d115e0e4
      c042b1a0 cda71d08 9a7444a7 00000001 cd0e0c8c c0177035 cda71d08 
cffc3e00
      9a7444a7 00000000 cda71d08 00000269 cd049658 cda70000 c01953ce 
cda71d08
Call Trace:
[<c019df2b>] journal_mark_freed+0x9b/0x200
[<c0177035>] reiserfs_free_block+0x35/0x60
[<c01953ce>] prepare_for_delete_or_cut+0x58e/0x7a0
[<c0279e40>] scsi_done+0x0/0x70
[<c01963bf>] reiserfs_cut_from_item+0xbf/0x560
[<c0196b50>] reiserfs_do_truncate+0x260/0x570
[<c0195ecd>] reiserfs_delete_object+0x3d/0x70
[<c017e542>] reiserfs_delete_inode+0x82/0xc0
[<c01176e0>] printk+0x100/0x140
[<c017e4c0>] reiserfs_delete_inode+0x0/0xc0
[<c015e971>] generic_delete_inode+0x51/0xd0
[<c015eb75>] iput+0x55/0x80
[<c018a947>] finish_unfinished+0x1e7/0x350
[<c018cb22>] reiserfs_fill_super+0x532/0x6e0
[<c0181020>] reiserfs_init_locked_inode+0x0/0x20
[<c0173969>] disk_name+0xa9/0xb0
[<c014e715>] sb_set_blocksize+0x25/0x60
[<c014e13d>] get_sb_bdev+0x11d/0x150
[<c018cd3f>] get_super_block+0x2f/0x70
[<c018c5f0>] reiserfs_fill_super+0x0/0x6e0
[<c014e38f>] do_kern_mount+0x5f/0xe0
[<c01610f8>] do_add_mount+0x78/0x170
[<c01613f4>] do_mount+0x144/0x190
[<c0161253>] copy_mount_options+0x63/0xc0
[<c0161780>] sys_mount+0xa0/0xf0
[<c0103efb>] syscall_call+0x7/0xb

Code: 8b 40 04 0f ab 30 8b 7c 24 0c 8b 5c 24 04 8b 74 24 08 31 c0
################################


dmesg:
Linux version 2.6.7 (root@cu.dgreaves.com) (gcc version 3.3.3 (Debian 
20040422)) #1 Wed Jun 16 12:39:51 BST 2004
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
BIOS-e820: 000000000ffec000 - 000000000ffef000 (ACPI data)
BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
On node 0 totalpages: 65516
 DMA zone: 4096 pages, LIFO batch:1
 Normal zone: 61420 pages, LIFO batch:14
 HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6900
ACPI: RSDT (v001 ASUS   A7V-133  0x30303031 MSFT 0x31313031) @ 0x0ffec000
ACPI: FADT (v001 ASUS   A7V-133  0x30303031 MSFT 0x31313031) @ 0x0ffec080
ACPI: BOOT (v001 ASUS   A7V-133  0x30303031 MSFT 0x31313031) @ 0x0ffec040
ACPI: DSDT (v001   ASUS A7V-133  0x00001000 MSFT 0x0100000b) @ 0x00000000
Built 1 zonelists
Kernel command line: root=/dev/hda2 ro single
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1276.141 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 255892k/262064k available (2095k kernel code, 5440k reserved, 
889k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... 
Ok.
Calibrating delay loop... 2506.75 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1275.0740 MHz.
..... host bus clock speed is 268.0576 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
SCSI subsystem initialized
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
spurious 8259A interrupt: IRQ7.
atyfb: 3D RAGE II+ (GTB) [0x4755 rev 0x9a] 4M EDO, 14.31818 MHz XTAL, 
200 MHz PLL, 63 Mhz MCLK
fb0: ATY Mach64 frame buffer device on PCI
Simple Boot Flag at 0x3a set to 0x1
SGI XFS with ACLs, no debug enabled
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
Console: switching to colour frame buffer device 80x25
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
   ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
   ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST320420A, ATA DISK drive
hdb: Maxtor 5A300J0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Memorex 482E CD-ROM, ATAPI CD/DVD-ROM drive
hdd: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=39535/16/63, UDMA(66)
hda: hda1 hda2 hda3
hdb: max request size: 1024KiB
hdb: 585940320 sectors (300001 MB) w/2048KiB Cache, CHS=36473/255/63, 
UDMA(100)
hdb: hdb1 hdb2
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
libata version 1.02 loaded.
sata_promise version 1.00
ata1: SATA max UDMA/133 cmd 0xD100D200 ctl 0xD100D238 bmdma 0x0 irq 11
ata2: SATA max UDMA/133 cmd 0xD100D280 ctl 0xD100D2B8 bmdma 0x0 irq 11
ata3: SATA max UDMA/133 cmd 0xD100D300 ctl 0xD100D338 bmdma 0x0 irq 11
ata4: SATA max UDMA/133 cmd 0xD100D380 ctl 0xD100D3B8 bmdma 0x0 irq 11
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
ata1: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
ata2: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_promise
ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
ata3: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_promise
ata4: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
ata4: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_promise
 Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
 Type:   Direct-Access                      ANSI SCSI revision: 05
 Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
 Type:   Direct-Access                      ANSI SCSI revision: 05
 Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
 Type:   Direct-Access                      ANSI SCSI revision: 05
 Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
 Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdb: drive cache: write back
sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sdc: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdc: drive cache: write back
sdc: sdc1
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
SCSI device sdd: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdd: drive cache: write back
sdd: sdd1
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
  8regs     :  1700.000 MB/sec
  8regs_prefetch:  1608.000 MB/sec
  32regs    :  1300.000 MB/sec
  32regs_prefetch:  1296.000 MB/sec
  pII_mmx   :  3408.000 MB/sec
  p5_mmx    :  4572.000 MB/sec
raid5: using function: p5_mmx (4572.000 MB/sec)
raid6: int32x1    503 MB/s
raid6: int32x2    671 MB/s
raid6: int32x4    441 MB/s
raid6: int32x8    402 MB/s
raid6: mmxx1     1070 MB/s
raid6: mmxx2     1824 MB/s
raid6: sse1x1     980 MB/s
raid6: sse1x2    1667 MB/s
raid6: using algorithm sse1x2 (1667 MB/s)
md: raid6 personality registered as nr 8
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ACPI: (supports S0 S1 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md:  adding hdb1 ...
md: created md0
md: bind<hdb1>
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1><sdb1><sda1><hdb1>
raid5: device sdd1 operational as raid disk 3
raid5: device sdc1 operational as raid disk 1
raid5: device sdb1 operational as raid disk 2
raid5: device sda1 operational as raid disk 0
raid5: device hdb1 operational as raid disk 4
raid5: allocated 5222kB for md0
raid5: raid level 5 set md0 active with 5 out of 5 devices, algorithm 2
RAID5 conf printout:
--- rd:5 wd:5 fd:0
disk 0, o:1, dev:sda1
disk 1, o:1, dev:sdc1
disk 2, o:1, dev:sdb1
disk 3, o:1, dev:sdd1
disk 4, o:1, dev:hdb1
md: ... autorun DONE.
XFS mounting filesystem hda2
Starting XFS recovery on filesystem: hda2 (dev: hda2)
Ending XFS recovery on filesystem: hda2 (dev: hda2)
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 160k freed
NET: Registered protocol family 1
Adding 522100k swap on /dev/hda3.  Priority:-1 extents:1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:04.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller
uhci_hcd 0000:00:04.2: irq 4, io base 0000d400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:04.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#2)
uhci_hcd 0000:00:04.3: irq 4, io base 0000d000
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 
alt 0 proto 2 vid 0x04B8 pid 0x0005
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver


