Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318726AbSH1Sp5>; Wed, 28 Aug 2002 14:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318813AbSH1Sp5>; Wed, 28 Aug 2002 14:45:57 -0400
Received: from [66.35.146.201] ([66.35.146.201]:6157 "EHLO int1.nea-fast.com")
	by vger.kernel.org with ESMTP id <S318726AbSH1Spy> convert rfc822-to-8bit;
	Wed, 28 Aug 2002 14:45:54 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: walt <walt@nea-fast.com>
To: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: 2.4.19 ext3 oops with file system damage - possible nfs and ext3 not playing nice together
Date: Wed, 28 Aug 2002 14:51:12 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208281451.12117.walt@nea-fast.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kinda long... sorry

I was coping  an ISO image via NFS to a directory on an ext3 partition 
(dev/hdc2)  and the computer locked up as soon as I hit the enter key. I've 
had problems before with ext3 and nfs (see FYI below), but this time it was 
on a different hard drive (first time was /dev/hda) and this time I got an 
oops along with a machine lockup. After hitting the reset button (machine was 
dead) I ended up having to delete a mysql index file because fsck couldn't 
repair it.

>From fstab -
LABEL=/storage          /opt                ext3    defaults        1 2

FYI  - I ran into some reproducible problems before with ext3 and possibly 
NFS. I had a 1365344k oracle database export gzipped down to 263688k and then 
made into an ISO image. I'd  copy the file from the file server 
(2.4.3-SGI_XFS_1.0.1) via NFS , mount the ISO image, and burn it to CD 
without any errors being reported. When I'd try gunzip the file from CD, I'd 
get CRC errors. I then tried mounting the ISO image and running gunzip and 
I'd get the same CRC errors. 
I went back to the file server, mounted the ISO image, and had no problem 
gunzipping it. I then tried coping the same file again via NFS but gave it a 
different name to copy to. Running both diff and cmp told me the files were 
different and both couldn't be gunzipped from mounted ISO images.  
I could also copy this file to a new file name in the same directory  (cp 
db.iso timma.iso) and when I ran both diff and cmp, they reported differences 
between the two files. I then tried using SCP to copy the file over and I had 
no problems. All this was repeatable. I upgraded kernels from RedHat 7.3 
stock  2.4.18-3 to vanilla 2.4.19 and problem seemed to go away. 

I'd be happy to provide anymore information!
- 
Walter Anthony
System Administrator
National Electronic Attachment
Atlanta, Georgia 
 "If it's not broke....tweak it"

>From message log - 
Aug 28 10:16:55 walt kernel: Unable to handle kernel paging request at virtual 
address 01
38835e
Aug 28 10:16:55 walt kernel:  printing eip:
Aug 28 10:16:55 walt kernel: c016bbd7
Aug 28 10:16:55 walt kernel: *pde = 00000000
Aug 28 10:16:55 walt kernel: Oops: 0000
Aug 28 10:16:55 walt kernel: CPU:    0
Aug 28 10:16:55 walt kernel: EIP:    0010:[<c016bbd7>]    Not tainted
Aug 28 10:16:55 walt kernel: EFLAGS: 00013202
Aug 28 10:16:55 walt kernel: eax: cf967eb0   ebx: 01388346   ecx: 00000040   
edx: 0000001
4
Aug 28 10:16:55 walt kernel: esi: cf1c4eb0   edi: 8d505604   ebp: ce5df430   
esp: cf967e8
4
Aug 28 10:16:55 walt kernel: ds: 0018   es: 0018   ss: 0018
Aug 28 10:16:55 walt kernel: Process kjournald (pid: 139, stackpage=cf967000)
Aug 28 10:16:55 walt kernel: Stack: 00000000 00000000 00000000 00000014 
cce1b440 cafe5220
 000017fd 00000096
Aug 28 10:16:55 walt kernel:        c0195a1c c12e00cc c12e5480 c38c9600 
c38c9780 c38c9480
 c38c96c0 c38c9540
Aug 28 10:16:55 walt kernel:        c38c9120 c38c9a20 c38c9d20 c38c9660 
c38c9180 c38c9c60
 c38c9960 c38c9c00
Aug 28 10:16:55 walt kernel: Call Trace:    [<c0195a1c>] [<c016eeb3>] 
[<c016ece0>] [<c010
7166>] [<c016ed00>]
Aug 28 10:16:55 walt kernel:
Aug 28 10:16:55 walt kernel: Code: 8b 43 18 a9 04 00 00 00 75 41 83 e0 02 74 
1a f0 ff 43
10 8b


root@walt scripts]# sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux walt 2.4.19 #2 SMP Fri Aug 9 12:15:24 EDT 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         nfs lockd sunrpc 3c59x md rtc

[root@walt burn]# cat /proc/partitions
major minor  #blocks  name

  22     0    8257032 hdc
  22     1     208813 hdc1
  22     2    8040532 hdc2
   3     0    4224150 hda
   3     1     610438 hda1
   3     2     200812 hda2
   3     3    3405780 hda3


root@walt ide]# cat /proc/ide/piix

                                Intel PIIX4 Ultra 33 Chipset.
--------------- Primary Channel ---------------- Secondary Channel 
-------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 
------
DMA enabled:    yes              no              yes               no
UDMA enabled:   yes              no              yes               no
UDMA enabled:   2                X               2                 X
UDMA
DMA
PIO



[root@walt burn]# dmesg
Linux version 2.4.19 (root@walt) (gcc version 2.96 20000731 (Red Hat Linux 7.3 
2.96-110)) #2 SMP Fri Aug 9 12:15:24 EDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffd000 (usable)
 BIOS-e820: 000000000fffd000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
Advanced speculative caching feature not present
On node 0 totalpages: 65533
zone(0): 4096 pages.
zone(1): 61437 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2.4.19-01 ro root=301 
BOOT_FILE=/boot/vmlinuz-2.4.19
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 267.278 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 532.48 BogoMIPS
Memory: 256704k/262132k available (1172k kernel code, 5040k reserved, 363k 
data, 268k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0080fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0080fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0080fbff 00000000 00000000 00000000
CPU:             Common caps: 0080fbff 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0080fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0080fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0080fbff 00000000 00000000 00000000
CPU:             Common caps: 0080fbff 00000000 00000000 00000000
CPU0: Intel Pentium II (Klamath) stepping 04
per-CPU timeslice cutoff: 1464.30 usecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 267.2755 MHz.
..... host bus clock speed is 66.8185 MHz.
cpu: 0, clocks: 668185, slice: 334092
CPU0<T0:668176,T1:334080,D:4,S:334092,C:668185>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf0750, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
PCI: Found IRQ 10 for device 00:04.2
PCI: Sharing IRQ 10 with 00:09.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MPC3043AT, ATA DISK drive
hdc: WDC WD84AA, ATA DISK drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8448300 sectors (4326 MB), CHS=525/255/63, UDMA(33)
hdc: 16514064 sectors (8455 MB) w/2048KiB Cache, CHS=16383/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3
 hdc: [PTBL] [1027/255/63] hdc1 hdc2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440LX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
[drm] AGP 0.99 on Intel 440LX @ 0xe4000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:09.0
PCI: Sharing IRQ 10 with 00:04.2
scsi0 : AdvanSys SCSI 3.3G: PCI Ultra: IO 0xB000-0xB00F, IRQ 0xA
  Vendor: MATSHITA  Model: CD-R   CW-7502    Rev: 4.10
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TEAC      Model: CD-ROM CD-516S    Rev: 1.0D
  Type:   CD-ROM                             ANSI SCSI revision: 02
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 268k freed
Real Time Clock Driver v1.10e
Adding Swap: 208804k swap-space (priority -1)
Adding Swap: 200804k swap-space (priority -2)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide1(22,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
PCI: Found IRQ 11 for device 00:0b.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0b.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xa800. Vers LK1.1.16

