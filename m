Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130409AbQKJPkW>; Fri, 10 Nov 2000 10:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131038AbQKJPkC>; Fri, 10 Nov 2000 10:40:02 -0500
Received: from limes.hometree.net ([194.231.17.49]:48902 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S129776AbQKJPkA>; Fri, 10 Nov 2000 10:40:00 -0500
To: linux-kernel@vger.kernel.org
Date: Fri, 10 Nov 2000 15:39:36 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <8uh4ro$1dv$1@forge.tanstaafl.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Reply-To: hps@tanstaafl.de
Subject: [2.2.18pre17 OOPS Report] Linux' musical taste (ide-cdrom / autofs related) (Repost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Ok, so my first mail seems to never have it made to the list. :-( ]

Hi,

the following situation:

Intel Celeron 667, 128 MB RAM, 440BX-based board (ASUS CUBX)
IBM 30 GB Disk and TEAC CDROM on ide0
LS120 Floppy and a Mitsumi CDROM on ide1   (see boot messages below for details)

Once upon a time this was a RedHat 6.2 box.

Running 2.2.18pre17 completely modular built + 20001027 IDE patch from
kernel.org + Andreas' 2.2.18pre17aa1 patch + some more but I think not
related patches. Complete Kernel SRPMS and RPMS on request. :-)


The following modules loaded (only the interesting ones):

Module                  Size  Used by
nfs                    75736   4 (autoclean)
sr_mod                 15844   0 (autoclean) (unused)
ide-cd                 25756   0 (autoclean)
cdrom                  28348   0 (autoclean) [sr_mod ide-cd]
isofs                  18304   0 (autoclean) (unused)
autofs                  9328   2 (autoclean)
lockd                  45200   0 (autoclean) [nfs]
sunrpc                 57988   1 (autoclean) [nfs lockd]
3c59x                  20872   1 (autoclean)
ide-disk                6160   6

The Mitsumi CDROM is used only for listening to music. There is still
an entry in my automount table for /mnt/misc mounting /dev/hdd to
/mnt/misc/cdrom1 if I ever desire to.

% cat /etc/auto.misc
[...]
cdrom1          -fstype=iso9660,ro      :/dev/hdd
[...]

And after a reinstall of this box, I forgot this line in /etc/fstab,
which is bad but should not do any harm with an audio cd in the drive.

/dev/hdd             /mnt/cdrom1             iso9660 noauto,owner,ro 0 0

Nothing really wierd happened until today I had to reboot the box and
a certain [1] music cd was in the Mitsumi drive. I'm pretty sure that
I've booted with lots of other audio cds in this drive before. This
time, however, the box crashed completely with this oops:

CPU:    0
EIP:    0010:[<c89170c6>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010097
eax: 00000000   ebx: c02b5270   ecx: c6e42810   edx: c6e42805
esi: 00000001   edi: c02b5270   ebp: 00000282   esp: c026fe2c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, process nr: 0, stackpage=c026f000)
Stack: c02b5270 00000282 00000000 c8917969 c02b5270 c89183ec 000003e8 c89177d8 
       c02b5270 c6e42800 00000000 c6e42850 00000000 c02b5198 00000258 c891845d 
       c02b5270 00000012 c89183ec 00000000 c891896e c02b5270 c02b5270 c02b5270 
Call Trace: [<c0181723>] [<c010a4d6>] [<c010a28f>] [<c010a5f8>] [<c010a2d0>] [<c0107b15>] [<c0106000>] 
       [<c0107b38>] [<c0109224>] [<c0106000>] [<c010607b>] [<c0106000>] [<c0100175>] 
Code: 83 78 0c 00 0f 85 f2 03 00 00 8b 84 24 88 00 00 00 8a 08 80 

>>EIP; c89170c6 <[ide-cd]cdrom_analyze_sense_data+5a/460>   <=====
Trace; c0181723 <ide_intr+ef/13c>
Trace; c010a4d6 <dump_thread+252e/2564>
Trace; c010a28f <dump_thread+22e7/2564>
Trace; c010a5f8 <enable_irq+80/128>
Trace; c010a2d0 <dump_thread+2328/2564>
Trace; c0107b15 <enable_hlt+65/14c>
Trace; c0106000 <get_options+0/c10>
Trace; c0107b38 <enable_hlt+88/14c>
Trace; c0109224 <dump_thread+127c/2564>
Trace; c0106000 <get_options+0/c10>
Trace; c010607b <get_options+7b/c10>
Trace; c0106000 <get_options+0/c10>
Trace; c0100175 <_stext+175/6000>
Code;  c89170c6 <[ide-cd]cdrom_analyze_sense_data+5a/460>
00000000 <_EIP>:
Code;  c89170c6 <[ide-cd]cdrom_analyze_sense_data+5a/460>   <=====
   0:   83 78 0c 00               cmpl   $0x0,0xc(%eax)   <=====
Code;  c89170ca <[ide-cd]cdrom_analyze_sense_data+5e/460>
   4:   0f 85 f2 03 00 00         jne    3fc <_EIP+0x3fc> c89174c2 <[ide-cd]cdrom_analyze_sense_data+456/460>
Code;  c89170d0 <[ide-cd]cdrom_analyze_sense_data+64/460>
   a:   8b 84 24 88 00 00 00      mov    0x88(%esp,1),%eax
Code;  c89170d7 <[ide-cd]cdrom_analyze_sense_data+6b/460>
  11:   8a 08                     mov    (%eax),%cl
Code;  c89170d9 <[ide-cd]cdrom_analyze_sense_data+6d/460>
  13:   80 00 00                  addb   $0x0,(%eax)

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing

This is the complete serial capture from booting to the crash:


LILO boot: 
Loading linux......................
Linux version 2.2.18pre17-2t (root@babsi) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Wed Nov 8 01:09:45 MET 2000
Detected 668197 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1333.65 BogoMIPS
Memory: 127024k/130944k available (1100k kernel code, 412k reserved, 1892k data, 84k init, 0k bigmem)
Dentry hash table entries: 16384 (order 5, 128k)
Buffer cache hash table entries: 131072 (order 7, 512k)
Page cache hash table entries: 32768 (order 5, 128k)
Inode hash table entries: 16384 (order 5, 128k)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xf08c0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 131072 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5 
matroxfb: Matrox Millennium G200 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 800x600x16bpp (virtual: 800x5240)
matroxfb: framebuffer at 0xE3000000, mapped to 0xc8005000, size 8388608
Console: switching to colour frame buffer device 100x37
fb0: MATROX VGA frame buffer device
Detected PS/2 Mouse Port.
Serial driver version 4.27 with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
sbc60xxwdt: WDT driver for 60XX single board computer initialising.
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 8192K size
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTLA-307030, ATA DISK drive
hdb: CD-540E, ATAPI CDROM drive
hdc: LS-120 VER5 00 UHD Floppy, ATAPI FLOPPY drive
hdd: FX162T, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
raid5: measuring checksumming speed
   8regs     :  1147.953 MB/sec
   32regs    :   643.128 MB/sec
using fastest function: 8regs (1147.953 MB/sec)
scsi : 0 hosts.
scsi : detected total.
md.c: sizeof(mdp_super_t) = 4096
Partition check:
RAMDISK: Compressed image found at block 0
autodetecting RAID arrays
autorun ...
... autorun DONE.
VFS: Mounted root (ext2 filesystem).
Loading aic7xxx module
(scsi0) <Adaptec AHA-294X Ultra SCSI host adapter> found at PCI 0/11/0
(scsi0) Narrow Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AHA-294X Ultra SCSI host adapter>
scsi : 1 host.
  Vendor: YAMAHA    Model: CDR400t           Rev: 1.0g
  Type:   CD-ROM                             ANSI SCSI revision: 02
Loading ide-disk module
hda: IBM-DTLA-307030, 29314MB w/1916kB Cache, CHS=3737/255/63, UDMA(33)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
autodetecting RAID arrays
autorun ...
... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=1
Trying to unmount old root ... okay
Freeing unused kernel memory: 84k freed
INIT: version 2.78 booting
			Welcome to Red Hat Linux
		Press 'I' to enter interactive startup.
Mounting proc filesystem [  OK  ]
Configuring kernel parameters [  OK  ]
Setting clock  (utc): Thu Nov  9 14:40:46 MET 2000 [  OK  ]
Activating swap partitions [  OK  ]
Setting hostname forge [  OK  ]
Checking root filesystem
/dev/hda5: clean, 6912/131616 files, 22474/263056 blocks
[/sbin/fsck.ext2 -- /] fsck.ext2 -a /dev/hda5 
[  OK  ]
Remounting root filesystem in read-write mode [  OK  ]
Finding module dependencies [  OK  ]
Loading sound module (snd-card-0) [  OK  ]
Loading mixer settings [  OK  ]
Checking filesystems
/dev/hda1: clean, 27/6024 files, 3783/24066 blocks
/dev/hda7: clean, 58347/196992 files, 271874/393216 blocks
/dev/hda8: clean, 849/66400 files, 6792/132528 blocks
/dev/hda9: clean, 30/3227648 files, 163467/6446073 blocks
Checking all file systems.
[/sbin/fsck.ext2 -- /boot] fsck.ext2 -a /dev/hda1 
[/sbin/fsck.ext2 -- /usr] fsck.ext2 -a /dev/hda7 
[/sbin/fsck.ext2 -- /var] fsck.ext2 -a /dev/hda8 
[/sbin/fsck.ext2 -- /mnt/disk0] fsck.ext2 -a /dev/hda9 
[  OK  ]
Mounting local filesystems [  OK  ]
Turning on user and group quotas for local filesystems [  OK  ]
Enabling swap space [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Setting network parameters [  OK  ]
Bringing up interface lo [  OK  ]
Bringing up interface eth0 [  OK  ]
Starting portmapper: [  OK  ]
Starting NFS file locking services: 
Starting NFS lockd: [  OK  ]
Starting NFS statd: [  OK  ]
Starting automounter:[  OK  ]
Initializing random number generator [  OK  ]
Mounting other filesystems 
Oops: 0000
CPU:    0
EIP:    0010:[<c89170c6>]
EFLAGS: 00010097
eax: 00000000   ebx: c02b5270   ecx: c6e42810   edx: c6e42805
esi: 00000001   edi: c02b5270   ebp: 00000282   esp: c026fe2c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, process nr: 0, stackpage=c026f000)
Stack: c02b5270 00000282 00000000 c8917969 c02b5270 c89183ec 000003e8 c89177d8 
       c02b5270 c6e42800 00000000 c6e42850 00000000 c02b5198 00000258 c891845d 
       c02b5270 00000012 c89183ec 00000000 c891896e c02b5270 c02b5270 c02b5270 
Call Trace: [<c0181723>] [<c010a4d6>] [<c010a28f>] [<c010a5f8>] [<c010a2d0>] [<c0107b15>] [<c0106000>] 
       [<c0107b38>] [<c0109224>] [<c0106000>] [<c010607b>] [<c0106000>] [<c0100175>] 
Code: 83 78 0c 00 0f 85 f2 03 00 00 8b 84 24 88 00 00 00 8a 08 80 
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing

Any ideas?

	Regards
		Henning

[1] Rational Youth, Cold war night life :-)


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
