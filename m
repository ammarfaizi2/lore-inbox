Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbTAGGvm>; Tue, 7 Jan 2003 01:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267513AbTAGGvm>; Tue, 7 Jan 2003 01:51:42 -0500
Received: from outbound01.telus.net ([199.185.220.220]:46269 "EHLO
	priv-edtnes61.telusplanet.net") by vger.kernel.org with ESMTP
	id <S267512AbTAGGve>; Tue, 7 Jan 2003 01:51:34 -0500
Subject: IDE-DMA 2.4.21-pre3 kernel Oops
From: Bob <gillb4@telusplanet.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Jan 2003 00:00:54 -0700
Message-Id: <1041922855.1658.119.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I have a kernel Oops in the 2.4.21-pre3 kernel. IANALKH, but I
suspect the problem is in ide-dma.c.  I can boot 2.4.21-pre3 if I do the
following in a startup script (effectively not using a DMA channel for
disk access).  I *can* use the DMA controller for stock 2.4.20 kernels.
 #/sbin/hdparm -d1 -c1 -a8 -u1 /dev/dvd
/sbin/hdparm -c1 -a8 -u1 /dev/dvd
#/sbin/hdparm -d1 -c3 -m16 -k1 /dev/hdb
/sbin/hdparm -c3 -m16 -k1 /dev/hdb
#/sbin/hdparm -d1 -c3 -m16 -k1 /dev/hda
/sbin/hdparm -c3 -m16 -k1 /dev/hda

My IDE controller is:
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)
[root@localhost root]# nm `ls /lib/ld*` | grep GLIBC
00000000 A GLIBC_2.0
00000000 A GLIBC_2.1
00000000 A GLIBC_2.3
00000000 A GLIBC_PRIVATE
00000000 A GLIBC_2.0
00000000 A GLIBC_2.1
00000000 A GLIBC_2.3
00000000 A GLIBC_PRIVATE

My system is based on RedHat 7.3.

The callback from the error message I get when trying to use a DMA
controller with the 2.4.20-pre3 kernel (plus a lot of additional
information following):
Script started on Mon Jan  6 21:12:23 2003
[root@localhost root]# uname -r
2.4.21-pre3

[root@localhost root]# gcc -v
Reading specs from /usr/lib/lib/gcc-lib/i686-pc-linux-gnu/3.2.1/specs
Configured with: ../gcc-3.2.1/configure --enable-shared --enable-threads
--enable-checking=gc --prefix=/usr/lib
Thread model: posix
gcc version 3.2.1

[root@localhost root]# ksymoops -v /data/kernel/temp/linux/vmlinux -o
/lib/modules/2.4.21-pre3 -m /boot/System.map-2.4.21-pre3 /root/bug3
ksymoops 2.4.8 on i686 2.4.21-pre3.  Options used
     -v /data/kernel/temp/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3 (specified)
     -m /boot/System.map-2.4.21-pre3 (specified)

kernel BUG in header file at line 155
kernel BUG at panic.c:141!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c011aeb7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000026   ebx: 00000000   ecx: f7be2000   edx: 00000000
esi: c031c760   edi: 00001000   ebp: 00000000   esp: f7be3d3c
ds: 0018   es: 0018   ss: 0018
Process hdparm (pid: 1156, stackpage=f7be3000)
Stack: c0256100 0000009b c01b80d1 0000009b 00000000 00000014 00000050
00000004
       f7eb8000 f7eba000 c031c810 00000000 c031c760 c01b82c4 c031c760
f7eb0200
       00000002 c1c0fe14 00000000 c031c760 c031c760 c031c810 f7eb0200
c031c760
Call Trace:    [<c01b80d1>] [<c01b82c4>] [<c01b87ef>] [<c01af82d>]
[<c01a531e>]
  [<c01ae481>] [<c01ae5fb>] [<c01aeb22>] [<c01b7e90>] [<c01089d5>]
[<c0108b54>]
  [<c010b1f8>] [<c012b6aa>] [<c011748c>] [<c017b70b>] [<c0178e2a>]
[<c01426ae>]
  [<c014a227>] [<c0117410>] [<c0107504>]
Code: 0f 0b 8d 00 1f 6e 25 c0 90 eb fe 8d b4 26 00 00 00 00 8d bc


>>EIP; c011aeb7 <__out_of_line_bug+17/30>   <=====

>>ecx; f7be2000 <_end+378bae8c/3855ae8c>
>>esi; c031c760 <ide_hwifs+0/2af8>
>>esp; f7be3d3c <_end+378bcbc8/3855ae8c>

Trace; c01b80d1 <ide_build_sglist+181/1a0>
Trace; c01b82c4 <ide_build_dmatable+54/1a0>
Trace; c01b87ef <__ide_dma_read+3f/150>
Trace; c01af82d <do_rw_disk+1ed/740>
Trace; c01a531e <ide_wait_stat+fe/140>
Trace; c01ae481 <start_request+1b1/230>
Trace; c01ae5fb <ide_do_request+ab/1a0>
Trace; c01aeb22 <ide_intr+f2/130>
Trace; c01b7e90 <ide_dma_intr+0/c0>
Trace; c01089d5 <handle_IRQ_event+45/70>
Trace; c0108b54 <do_IRQ+64/a0>
Trace; c010b1f8 <call_do_IRQ+5/d>
Trace; c012b6aa <find_vma+1a/60>
Trace; c011748c <do_page_fault+7c/4fd>
Trace; c017b70b <do_tty_write+db/134>
Trace; c0178e2a <tty_write+fa/130>
Trace; c01426ae <blkdev_ioctl+3e/40>
Trace; c014a227 <sys_ioctl+87/1c0>
Trace; c0117410 <do_page_fault+0/4fd>
Trace; c0107504 <error_code+34/3c>

Code;  c011aeb7 <__out_of_line_bug+17/30>
00000000 <_EIP>:
Code;  c011aeb7 <__out_of_line_bug+17/30>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011aeb9 <__out_of_line_bug+19/30>
   2:   8d 00                     lea    (%eax),%eax
Code;  c011aebb <__out_of_line_bug+1b/30>
   4:   1f                        pop    %ds
Code;  c011aebc <__out_of_line_bug+1c/30>
   5:   6e                        outsb  %ds:(%esi),(%dx)
Code;  c011aebd <__out_of_line_bug+1d/30>
   6:   25 c0 90 eb fe            and    $0xfeeb90c0,%eax
Code;  c011aec2 <__out_of_line_bug+22/30>
   b:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c011aec9 <__out_of_line_bug+29/30>
  12:   8d bc 00 00 00 00 00      lea    0x0(%eax,%eax,1),%edi

 <0>Kernel panic: Aiee, killing interrupt handler!
[root@localhost root]# lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 645 Host (rev 02)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 90)
00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 02)
00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 02)
00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 43)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4
Ti4200] (rev a3)
[root@localhost root]# dmesg
Linux version 2.4.21-pre3 (root@localhost.localdomain) (gcc version
3.2.1) #2 Mon Jan 6 19:21:38 MST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
Kernel command line: ro root=/dev/hda3 hdd=ide-scsi
ide_setup: hdd=ide-scsi
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1890.054 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3774.87 BogoMIPS
Memory: 1033548k/1048512k available (1307k kernel code, 14576k reserved,
513k data, 144k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1039/0645] at 00:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: device reported incorrect length field (61, should be 62)
parport0 (addr 0): SCSI adapter, IMG VP1
parport0: Printer, HEWLETT-PACKARD DESKJET 930C
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
lp0: console ready
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS645    ATA 100 controller
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 92041U4, ATA DISK drive
hdb: Maxtor 98196H8, ATA DISK drive
blk: queue c031c820, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c031c95c, I/O limit 4095Mb (mask 0xffffffff)
hdc: SAMSUNG DVD-ROM SD-608, ATAPI CD/DVD-ROM drive
hdd: CR-4804TE, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 40020624 sectors (20491 MB) w/512KiB Cache, CHS=2646/240/63,
UDMA(66)
hdb: host protected area => 1
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63,
UDMA(100)
hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
 hdb: hdb1
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
EXT2-fs warning (device ide0(3,3)): ext2_read_super: mounting ext3
filesystem as ext2

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 144k freed
Adding Swap: 1050832k swap-space (priority -1)
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:41) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MITSUMI   Model: CR-4804TE         Rev: 2.4C
  Type:   CD-ROM                             ANSI SCSI revision: 02
hdc: DMA disabled
hdd: DMA disabled
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 292 bytes per
conntrack
sis900.c: v1.08.06 9/24/2002
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xe000, IRQ 11, 00:50:2c:02:96:89.
eth0: Media Link On 10mbps half-duplex 
nf_sock overlap: 64-1089/0-0 v 64-66/64-66
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
Linux video capture interface: v1.00
bttv: driver version 0.7.96 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
bttv: Host bridge is Silicon Integrated Systems [SiS] 645 Host
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 2) at 00:0b.0, irq: 5, latency: 32, mmio: 0xe7003000
bttv0: detected: ATI TV Wonder/VE [card=64], PCI subsystem ID is
1002:0003
bttv0: using: BT878(ATI TV-Wonder VE) [card=64,autodetected]
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: using tuner=19
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
i2c-core.o: driver i2c TV tuner driver registered.
tuner: probing bt848 #0 i2c adapter [id=0x10005]
tuner: chip found @ 0xc0
bttv0: i2c attach [client=Temic PAL* auto (4006 FN5),ok]
i2c-core.o: client [Temic PAL* auto (4006 FN5)] registered to adapter
[bt848 #0](pos. 0).
bttv0: registered device video0
bttv0: registered device vbi0
imm: Version 2.05 (for Linux 2.4.0)
imm: Found device at ID 6, Attempting to use EPP 32 bit
imm: Found device at ID 6, Attempting to use PS/2
imm: Communication established at 0x378 with ID 6 using PS/2
scsi1 : Iomega VPI2 (imm) interface
  Vendor: IOMEGA    Model: ZIP 250           Rev: H.41
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi1, channel 0, id 6, lun 0
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sda : block size assumed to be 512 bytes, disk size 1GB.  
 sda: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table
raw1394: /dev/raw1394 device initialized
ohci1394: $Rev: 693 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[e7005000-e70057ff]  Max
Packet=[2048]
ieee1394: SelfID completion called outside of bus reset!
ieee1394: Device added: Node[00:1023]  GUID[0030e000e0000b39] 
[FIREWIRE]
ieee1394: Device added: Node[01:1023]  GUID[0030e000e0000ae3] 
[FIREWIRE]
ieee1394: Host added: Node[02:1023]  GUID[001106001a250051]  [Linux
OHCI-1394]
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[01:1023]: Max speed [S400] - Max payload [2048]
scsi2 : IEEE-1394 SBP-2 protocol driver (host: ohci1394)
$Rev: 707 $ James Goodwin <jamesg@filanet.com>
SBP-2 module load options:
- Max speed supported: S400
- Max sectors per I/O supported: 255
- Max outstanding commands supported: 8
- Max outstanding commands per lun supported: 1
- Serialized I/O (debug): no
- Exclusive login: yes
  Vendor: Maxtor 4  Model: G160J8            Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 06
  Vendor: Maxtor 4  Model: G160J8            Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 06
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
Attached scsi disk sdc at scsi2, channel 0, id 1, lun 0
SCSI device sdb: 268435455 512-byte hdwr sectors (137439 MB)
 sdb: sdb1
SCSI device sdc: 268435455 512-byte hdwr sectors (137439 MB)
 sdc: sdc1
reiserfs: checking transaction log (device 08:11) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:21) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
[root@localhost root]# ls /proc/ide/sis

SiS 5513 Ultra 100 chipset
--------------- Primary Channel ---------------- Secondary Channel
-------------Channel Status: On                               On 
Operation Mode: Compatible                       Compatible 
Cable Type:     80 pins                          80 pins
Prefetch Count: 512                              512
Drive 0:        Postwrite Enabled                Postwrite Disabled
                Prefetch  Enabled                Prefetch  Disabled
                UDMA Enabled                     UDMA Disabled
                UDMA Cycle Time    3 CLK         UDMA Cycle Time   
Reserved
                Data Active Time   3 PCICLK      Data Active Time   3
PCICLK
                Data Recovery Time 1 PCICLK      Data Recovery Time 1
PCICLK
Drive 1:        Postwrite Enabled                Postwrite Disabled
                Prefetch  Enabled                Prefetch  Disabled
                UDMA Enabled                     UDMA Disabled
                UDMA Cycle Time    2 CLK         UDMA Cycle Time   
Reserved
                Data Active Time   3 PCICLK      Data Active Time   3
PCICLK
                Data Recovery Time 1 PCICLK      Data Recovery Time 3
PCICLK
[root@localhost root]# cat /proc/ide/ide0/hda/model
Maxtor 92041U4
[root@localhost root]# cat /proc/ide/ide0/hda/capacity
40020624
[root@localhost root]# cat /proc/ide/ide0/hda/geometry
physical     39703/16/63
logical      2646/240/63
root@localhost root]# cat /proc/ide/ide0/hdb/model
Maxtor 98196H8
[root@localhost root]# cat /proc/ide/ide0/hdb/capacity
160086528
[root@localhost root]# cat /proc/ide/ide0/hdb/geometry
physical     158816/16/63
logical      9964/255/63
[root@localhost hdb]# free
             total       used       free     shared    buffers    
cached
Mem:       1033692      64416     969276          0      13244     
29368
-/+ buffers/cache:      21804    1011888
Swap:      1050832          0    1050832
[root@localhost hdb]# ulimit -a
core file size        (blocks, -c) 0
data seg size         (kbytes, -d) unlimited
file size             (blocks, -f) unlimited
max locked memory     (kbytes, -l) unlimited
max memory size       (kbytes, -m) unlimited
open files                    (-n) 1024
pipe size          (512 bytes, -p) 8
stack size            (kbytes, -s) 8192
cpu time             (seconds, -t) unlimited
max user processes            (-u) 7168
virtual memory        (kbytes, -v) unlimited


Sorry for the bulk.  Again, when I do not use the -d parameter in
hdparm, I can boot 2.4.21-3 successfully (and it crashes when I use
it).  The top of the trace list is ide_build_sglist.  When I run grep -l
ide_build_sglist in  linux/drivers/ide, it comes up with two object
files, and ide-dma.c.  I have found the following information from a
Linux site while looking for a data sheet for the SiS 5513 controller:
"It appears the 5513 has two completely independent IDE channels, each
with its own 64 bytes deep data buffer."  
--my system is configured with the two hard disks connected to HDA, and
DVD and CD drives connected to the HDB.  I appreciate that the ide
section of the kernel has gone from 69 to 57 files, with sis5513.c no
longer in the kernel.  If the IDE backport is ongoing, please e-mail me,
and I won't post again.  If the work is completed (and no solution has
been found for this oops) please e-mail me and I will (attempt) work at
a solution.  Also, if you really want to see lsmod or /etc/ld.so.conf,
e-mail me.  That's about the only things I haven't included here.

Thanks,
Bob


