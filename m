Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262194AbSIZFwr>; Thu, 26 Sep 2002 01:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262195AbSIZFwr>; Thu, 26 Sep 2002 01:52:47 -0400
Received: from [203.117.131.12] ([203.117.131.12]:9669 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S262194AbSIZFwa>; Thu, 26 Sep 2002 01:52:30 -0400
Message-ID: <3D92A1D0.5000203@metaparadigm.com>
Date: Thu, 26 Sep 2002 13:57:36 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>
Subject: 2.4.19pre10aa4 OOPS in ext3 (get_hash_table, unmap_underlying_metadata)
Content-Type: multipart/mixed;
 boundary="------------080704010901030007070809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080704010901030007070809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hiya,

Been having frequent (every 4-8 days) oopses with 2.4.19pre10aa4 on
a moderately loaded server (100 users - 0.4 load avg).

The server is a Intel STL2 with dual P3, 1GB RAM, Intel Pro1000T
and Qlogic 2300 Fibre channel HBA.

We are running qla2300, e1000 and lvm modules unmodified as present in
2.4.19pre10aa4. We also have quotas enabled on 1 of the ext3 fs.

This is the first captive oops after setting up logging on the console
ports (previously, our cluster software would shoot the machine with
a remote power switch, and we'd loose the oops - oopsing to floppy
or somesuch would be great!).

We have also had similar lock-ups with 2.4.18pre2aa2 although have
not been able to catch the oopses.

I can't say i understand the oopses, but from what I can see it
appears a bufferhead is being accessed that may have been freed.

~mc

ksymoops 2.4.1 on i686 2.4.19-pre10.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.19-pre10/ (default)
      -m /boot/System.map-2.4.19-pre10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol set_cpus_allowed_R__ver_set_cpus_allowed not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol vg  , lvm-mod says c4008720, /lib/modules/2.4.19-pre10/kernel/drivers/md/lvm-mod.o says c40085e0.  Ignoring /lib/modules/2.4.19-pre10/kernel/drivers/md/lvm-mod.o entry
Warning (compare_maps): mismatch on symbol md_size  , md says c30a89e0, /lib/modules/2.4.19-pre10/kernel/drivers/md/md.o says c30a8800.  Ignoring /lib/modules/2.4.19-pre10/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol mddev_map  , md says c30a81e0, /lib/modules/2.4.19-pre10/kernel/drivers/md/md.o says c30a8000.  Ignoring /lib/modules/2.4.19-pre10/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says c2e6e694, /lib/modules/2.4.19-pre10/kernel/drivers/usb/usbcore.o says c2e6e0f4.  Ignoring /lib/modules/2.4.19-pre10/kernel/drivers/usb/usbcore.o entry

Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address 6d727567
c0140ca6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0140ca6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c0284b40   ebx: 00000004   ecx: e1f8d540   edx: 6d727563
esi: 01569a5b   edi: 00003a09   ebp: 00000010   esp: eed6de10
ds: 0018   es: 0018   ss: 0018
Process afpd (pid: 20529, stackpage=eed6d000)
Stack: 0000e384 00000000 00001000 00001000 eed6de68 c0141a2b 00003a09 01569a5b
        00001000 00001000 00001000 c0141d69 ebb2a440 00000000 c0141d8a ee9793e0
        ee9793e0 f181c000 00001000 0000017a 00000000 ee9793e0 00001000 00000000
Call Trace: [<c0141a2b>] [<c0141d69>] [<c0141d8a>] [<c0142705>] [<c016bab0>]
    [<c0173577>] [<c016c018>] [<c016bab0>] [<c01364b5>] [<c0131992>] [<c01f5788>]
    [<c0169822>] [<c013f206>] [<c0108aeb>]
Code: 39 72 04 89 d1 75 f3 0f b7 42 08 3b 44 24 20 75 e9 66 39 7a


 >>EIP; c0140ca6 <get_hash_table+76/a0>   <=====

Trace; c0141a2b <unmap_underlying_metadata+1b/60>
Trace; c0141d69 <__block_prepare_write+f9/320>
Trace; c0141d8a <__block_prepare_write+11a/320>
Trace; c0142705 <block_prepare_write+25/80>
Trace; c016bab0 <ext3_get_block+0/70>
Trace; c0173577 <journal_start+b7/e0>
Trace; c016c018 <ext3_prepare_write+c8/200>
Trace; c016bab0 <ext3_get_block+0/70>
Trace; c01364b5 <lru_cache_add+65/70>
Trace; c0131992 <generic_file_write+4e2/7e0>
Trace; c01f5788 <sock_read+88/a0>
Trace; c0169822 <ext3_file_write+22/b0>
Trace; c013f206 <sys_write+96/110>
Trace; c0108aeb <system_call+33/38>
Code;  c0140ca6 <get_hash_table+76/a0>
00000000 <_EIP>:
Code;  c0140ca6 <get_hash_table+76/a0>   <=====
    0:   39 72 04                  cmp    %esi,0x4(%edx)   <=====
Code;  c0140ca9 <get_hash_table+79/a0>
    3:   89 d1                     mov    %edx,%ecx
Code;  c0140cab <get_hash_table+7b/a0>
    5:   75 f3                     jne    fffffffa <_EIP+0xfffffffa> c0140ca0 <get_hash_table+70/a0>
Code;  c0140cad <get_hash_table+7d/a0>
    7:   0f b7 42 08               movzwl 0x8(%edx),%eax
Code;  c0140cb1 <get_hash_table+81/a0>
    b:   3b 44 24 20               cmp    0x20(%esp,1),%eax
Code;  c0140cb5 <get_hash_table+85/a0>
    f:   75 e9                     jne    fffffffa <_EIP+0xfffffffa> c0140ca0 <get_hash_table+70/a0>
Code;  c0140cb7 <get_hash_table+87/a0>
   11:   66 39 7a 00               cmp    %di,0x0(%edx)

kernel BUG at transaction.c:227!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0173518>]    Not tainted
EFLAGS: 00010282
eax: 0000006c   ebx: c27af7e0   ecx: c2710000   edx: c2711f64
esi: eed6c000   edi: e11c1d80   ebp: c1e26600   esp: eed6db5c
ds: 0018   es: 0018   ss: 0018
Process afpd (pid: 20529, stackpage=eed6d000)
Stack: c024f3e0 c024c10a c024c839 000000e3 c0251320 c27af7e0 c27af7e0 ffffffe2
        e11c1d80 ed4ab220 c016e38e c1e26600 00000001 00000000 00000000 33323130
        c1e0f400 e11c1d80 c1e0f400 00000001 c0153f8e e11c1d80 000001ff e11c1d80
Call Trace: [<c016e38e>] [<c0153f8e>] [<c01317fa>] [<c013d568>] [<c0169822>]
    [<c01229ca>] [<c0122a3a>] [<c011eaee>] [<c01090dd>] [<c0140ca6>] [<c01166a8>]
    [<c0140ca6>] [<c016b1f5>] [<c016b9e7>] [<c016b8dd>] [<c01162b0>] [<c0108bdc>]
    [<c0140018>] [<c0140ca6>] [<c0141a2b>] [<c0141d69>] [<c0141d8a>] [<c0142705>]
    [<c016bab0>] [<c0173577>] [<c016c018>] [<c016bab0>] [<c01364b5>] [<c0131992>]
    [<c01f5788>] [<c0169822>] [<c013f206>] [<c0108aeb>]
Code: 0f 0b e3 00 39 c8 24 c0 83 c4 14 ff 43 08 eb 6a 6a 01 68 f0


 >>EIP; c0173518 <journal_start+58/e0>   <=====

Trace; c016e38e <ext3_dirty_inode+6e/100>
Trace; c0153f8e <__mark_inode_dirty+2e/a0>
Trace; c01317fa <generic_file_write+34a/7e0>
Trace; c013d568 <vfs_statfs+58/90>
Trace; c0169822 <ext3_file_write+22/b0>
Trace; c01229ca <do_acct_process+25a/270>
Trace; c0122a3a <acct_process+5a/86>
Trace; c011eaee <do_exit+6e/310>
Trace; c01090dd <die+6d/80>
Trace; c0140ca6 <get_hash_table+76/a0>
Trace; c01166a8 <do_page_fault+3f8/614>
Trace; c0140ca6 <get_hash_table+76/a0>
Trace; c016b1f5 <ext3_get_branch+55/d0>
Trace; c016b9e7 <ext3_get_block_handle+247/310>
Trace; c016b8dd <ext3_get_block_handle+13d/310>
Trace; c01162b0 <do_page_fault+0/614>
Trace; c0108bdc <error_code+34/3c>
Trace; c0140018 <fput+18/f0>
Trace; c0140ca6 <get_hash_table+76/a0>
Trace; c0141a2b <unmap_underlying_metadata+1b/60>
Trace; c0141d69 <__block_prepare_write+f9/320>
Trace; c0141d8a <__block_prepare_write+11a/320>
Trace; c0142705 <block_prepare_write+25/80>
Trace; c016bab0 <ext3_get_block+0/70>
Trace; c0173577 <journal_start+b7/e0>
Trace; c016c018 <ext3_prepare_write+c8/200>
Trace; c016bab0 <ext3_get_block+0/70>
Trace; c01364b5 <lru_cache_add+65/70>
Trace; c0131992 <generic_file_write+4e2/7e0>
Trace; c01f5788 <sock_read+88/a0>
Trace; c0169822 <ext3_file_write+22/b0>
Trace; c013f206 <sys_write+96/110>
Trace; c0108aeb <system_call+33/38>
Code;  c0173518 <journal_start+58/e0>
00000000 <_EIP>:
Code;  c0173518 <journal_start+58/e0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c017351a <journal_start+5a/e0>
    2:   e3 00                     jecxz  4 <_EIP+0x4> c017351c <journal_start+5c/e0>
Code;  c017351c <journal_start+5c/e0>
    4:   39 c8                     cmp    %ecx,%eax
Code;  c017351e <journal_start+5e/e0>
    6:   24 c0                     and    $0xc0,%al
Code;  c0173520 <journal_start+60/e0>
    8:   83 c4 14                  add    $0x14,%esp
Code;  c0173523 <journal_start+63/e0>
    b:   ff 43 08                  incl   0x8(%ebx)
Code;  c0173526 <journal_start+66/e0>
    e:   eb 6a                     jmp    7a <_EIP+0x7a> c0173592 <journal_start+d2/e0>
Code;  c0173528 <journal_start+68/e0>
   10:   6a 01                     push   $0x1
Code;  c017352a <journal_start+6a/e0>
   12:   68 f0 00 00 00            push   $0xf0




--------------080704010901030007070809
Content-Type: text/plain;
 name="prodapp3.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prodapp3.dmesg"

0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  1    1    0   1   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  1    1    0   1   0    1    1    91
 01 003 03  1    1    0   1   0    1    1    99
 02 003 03  1    1    0   1   0    1    1    A1
 03 003 03  1    1    0   1   0    1    1    A9
 04 003 03  1    1    0   1   0    1    1    B1
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 003 03  1    1    0   1   0    1    1    B9
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ18 -> 1:2
IRQ19 -> 1:3
IRQ20 -> 1:4
IRQ26 -> 1:10
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 999.5848 MHz.
..... host bus clock speed is 133.2777 MHz.
cpu: 0, clocks: 1332777, slice: 444259
CPU0<T0:1332768,T1:888496,D:13,S:444259,C:1332777>
cpu: 1, clocks: 1332777, slice: 444259
CPU1<T0:1332768,T1:444240,D:10,S:444259,C:1332777>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
PCI: PCI BIOS revision 2.10 entry at 0xfdb57, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered peer bus 01
PCI->APIC IRQ transform: (B0,I2,P0) -> 19
PCI->APIC IRQ transform: (B0,I3,P0) -> 18
PCI->APIC IRQ transform: (B0,I6,P0) -> 26
PCI->APIC IRQ transform: (B1,I4,P0) -> 16
PCI->APIC IRQ transform: (B1,I4,P1) -> 17
PCI->APIC IRQ transform: (B1,I10,P0) -> 20
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.5.0 initialized
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x5460-0x5467, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x5468-0x546f, BIOS settings: hdc:DMA, hdd:DMA
hda: SAMSUNG CD-ROM SN-124, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: SEAGATE   Model: ST318405LC        Rev: 0105
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: ESG-SHV   Model: SCA HSBP M10      Rev: 0.05
  Type:   Processor                          ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sd(8,2): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 211824
ext3_orphan_cleanup: deleting unreferenced inode 211823
ext3_orphan_cleanup: deleting unreferenced inode 211458
ext3_orphan_cleanup: deleting unreferenced inode 211792
ext3_orphan_cleanup: deleting unreferenced inode 211334
ext3_orphan_cleanup: deleting unreferenced inode 712642
ext3_orphan_cleanup: deleting unreferenced inode 713744
ext3_orphan_cleanup: deleting unreferenced inode 713746
ext3_orphan_cleanup: deleting unreferenced inode 713748
ext3_orphan_cleanup: deleting unreferenced inode 713750
ext3_orphan_cleanup: deleting unreferenced inode 713752
ext3_orphan_cleanup: deleting unreferenced inode 713765
ext3_orphan_cleanup: deleting unreferenced inode 713768
ext3_orphan_cleanup: deleting unreferenced inode 713780
ext3_orphan_cleanup: deleting unreferenced inode 777241
ext3_orphan_cleanup: deleting unreferenced inode 129929
ext3_orphan_cleanup: deleting unreferenced inode 391040
ext3_orphan_cleanup: deleting unreferenced inode 129570
ext3_orphan_cleanup: deleting unreferenced inode 163423
ext3_orphan_cleanup: deleting unreferenced inode 519158
ext3_orphan_cleanup: deleting unreferenced inode 16231
ext3_orphan_cleanup: deleting unreferenced inode 16226
ext3_orphan_cleanup: deleting unreferenced inode 519157
ext3_orphan_cleanup: deleting unreferenced inode 518190
ext3_orphan_cleanup: deleting unreferenced inode 599367
ext3_orphan_cleanup: deleting unreferenced inode 599162
EXT3-fs: sd(8,2): 26 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 232k freed
Adding Swap: 2040244k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xf88ff000, IRQ 9
usb-ohci.c: usb-00:0f.2, ServerWorks OSB4/CSB5 USB Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,2), internal journal
qla2x00_set_info starts at address = c3180060
qla2x00: Found  VID=1077 DID=2300 SSVID=1077 SSDID=9
scsi2: Found a QLA2300  @ bus 1, device 0xa, irq 20, iobase 0x6400
scsi(2): Allocated 4096 SRB(s)
scsi(2): Configure NVRAM parameters...
qla2x00: 64 Bit PCI Addressing Enabled
scsi(2): Verifying loaded RISC code...
scsi(2): Verifying chip...
scsi(2): Waiting for LIP to complete...
scsi(2): LIP reset occurred
scsi(2): LIP occurred.
scsi(2): LOOP UP detected
scsi2: Topology - (Loop), Host Loop address 0x67
scsi-qla0-adapter-node=200000e08b0419ad;
scsi-qla0-adapter-port=210000e08b0419ad;
scsi-qla0-target-0=2000005013b3385a;
scsi2 : QLogic QLA2300 PCI to Fibre Channel Host Adapter: bus 1 device 10 irq 20
        Firmware version:  3.01.08, Driver version 6.0.1b3
  Vendor: CNSi      Model: G8324             Rev: L411
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: CNSi      Model: G8324             Rev: L411
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: CNSi      Model: G8324             Rev: L411
  Type:   Processor                          ANSI SCSI revision: 03
  Vendor: CNSi      Model: G8324             Rev: L411
  Type:   Processor                          ANSI SCSI revision: 03
  Vendor: CNSi      Model: G8324             Rev: L411
  Type:   Processor                          ANSI SCSI revision: 03
  Vendor: CNSi      Model: G8324             Rev: L411
  Type:   Processor                          ANSI SCSI revision: 03
  Vendor: CNSi      Model: G8324             Rev: L411
  Type:   Processor                          ANSI SCSI revision: 03
scsi(2:0:0:0): Enabled tagged queuing, queue depth 16.
scsi(2:0:0:1): Enabled tagged queuing, queue depth 16.
scsi(2:0:0:50): Enabled tagged queuing, queue depth 16.
scsi(2:0:0:51): Enabled tagged queuing, queue depth 16.
scsi(2:0:0:52): Enabled tagged queuing, queue depth 16.
scsi(2:0:0:53): Enabled tagged queuing, queue depth 16.
scsi(2:0:0:63): Enabled tagged queuing, queue depth 16.
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 1
Attached scsi generic sg4 at scsi2, channel 0, id 0, lun 50,  type 3
Attached scsi generic sg5 at scsi2, channel 0, id 0, lun 51,  type 3
Attached scsi generic sg6 at scsi2, channel 0, id 0, lun 52,  type 3
Attached scsi generic sg7 at scsi2, channel 0, id 0, lun 53,  type 3
Attached scsi generic sg8 at scsi2, channel 0, id 0, lun 63,  type 3
SCSI device sdb: 567762944 512-byte hdwr sectors (290695 MB)
 sdb: sdb1
SCSI device sdc: 35502592 512-byte hdwr sectors (18177 MB)
 sdc: sdc1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Intel(R) PRO/1000 Network Driver - version 4.2.17-k1
Copyright (c) 1999-2002 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth1: OEM i82557/i82558 10/100 Ethernet, 00:D0:B7:B6:36:B5, IRQ 18.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
LVM version 1.0.3(19/02/2002) module loaded
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.18, 14 May 2002 on lvm(58,9), internal journal
ext3_orphan_cleanup: deleting unreferenced inode 508004
ext3_orphan_cleanup: deleting unreferenced inode 3260810
ext3_orphan_cleanup: deleting unreferenced inode 3260809
ext3_orphan_cleanup: deleting unreferenced inode 3260808
ext3_orphan_cleanup: deleting unreferenced inode 3260508
ext3_orphan_cleanup: deleting unreferenced inode 3260434
EXT3-fs: lvm(58,9): 6 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
NET4: AppleTalk 0.18a for Linux NET4.0
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: checktime reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.18, 14 May 2002 on lvm(58,17), internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: checktime reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.18, 14 May 2002 on lvm(58,16), internal journal
ext3_orphan_cleanup: deleting unreferenced inode 477378
ext3_orphan_cleanup: deleting unreferenced inode 1130774
ext3_orphan_cleanup: deleting unreferenced inode 169242
ext3_orphan_cleanup: deleting unreferenced inode 1216257
ext3_orphan_cleanup: deleting unreferenced inode 365755
ext3_orphan_cleanup: deleting unreferenced inode 1278797
ext3_orphan_cleanup: deleting unreferenced inode 1164966
ext3_orphan_cleanup: deleting unreferenced inode 1296488
ext3_orphan_cleanup: deleting unreferenced inode 1263660
ext3_orphan_cleanup: deleting unreferenced inode 787117
ext3_orphan_cleanup: deleting unreferenced inode 20410
ext3_orphan_cleanup: deleting unreferenced inode 1279380
ext3_orphan_cleanup: deleting unreferenced inode 1297521
ext3_orphan_cleanup: deleting unreferenced inode 820547
ext3_orphan_cleanup: deleting unreferenced inode 182863
ext3_orphan_cleanup: deleting unreferenced inode 757280
ext3_orphan_cleanup: deleting unreferenced inode 839553
EXT3-fs: lvm(58,16): 17 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack (8191 buckets, 65528 max)
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: checktime reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.18, 14 May 2002 on lvm(58,12), internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.

--------------080704010901030007070809
Content-Type: text/plain;
 name="prodapp3.lsmod"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prodapp3.lsmod"

Module                  Size  Used by    Not tainted
ipt_REDIRECT             768   2  (autoclean)
iptable_nat            15508   1  (autoclean) [ipt_REDIRECT]
ip_conntrack           15916   1  (autoclean) [ipt_REDIRECT iptable_nat]
ip_tables              11488   4  [ipt_REDIRECT iptable_nat]
appletalk              23532  26 
lvm-mod                60384  30  (autoclean)
eepro100               17712   1 
e1000                  46968   1 
md                     63232   0  (unused)
qla2300               197216   2 
usb-ohci               17088   0  (unused)
usbcore                59104   1  [usb-ohci]

--------------080704010901030007070809
Content-Type: text/plain;
 name="prodapp3.lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prodapp3.lspci"

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
	Flags: bus master, medium devsel, latency 64

00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
	Flags: bus master, medium devsel, latency 64

00:02.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC] (rev 7a) (prog-if 00 [VGA])
	Subsystem: Intel Corporation: Unknown device 4756
	Flags: bus master, stepping, medium devsel, latency 66, IRQ 19
	Memory at fc000000 (32-bit, prefetchable) [size=16M]
	I/O ports at 5000 [size=256]
	Memory at fb140000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1

00:03.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation 82557 [Ethernet Pro 100]
	Flags: bus master, medium devsel, latency 66, IRQ 18
	Memory at fb141000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 5400 [size=64]
	Memory at fb000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2

00:06.0 Ethernet controller: Intel Corporation: Unknown device 100c (rev 02)
	Subsystem: Intel Corporation: Unknown device 1112
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 26
	Memory at fb120000 (32-bit, non-prefetchable) [size=128K]
	Memory at fb100000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at 5440 [size=32]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
	Subsystem: ServerWorks OSB4 South Bridge
	Flags: bus master, medium devsel, latency 0

00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8e [Master SecP SecO PriP])
	Flags: bus master, medium devsel, latency 64
	I/O ports at 0170 [size=8]
	I/O ports at 0374
	I/O ports at 5460 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04) (prog-if 10 [OHCI])
	Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at fb142000 (32-bit, non-prefetchable) [size=4K]

01:04.0 SCSI storage controller: Adaptec 7899P
	Subsystem: Intel Corporation: Unknown device 00cf
	Flags: bus master, 66Mhz, medium devsel, latency 72, IRQ 16
	BIST result: 00
	I/O ports at 5800 [disabled] [size=256]
	Memory at fd000000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

01:04.1 SCSI storage controller: Adaptec 7899P
	Subsystem: Intel Corporation: Unknown device 00cf
	Flags: bus master, 66Mhz, medium devsel, latency 72, IRQ 17
	BIST result: 00
	I/O ports at 6000 [disabled] [size=256]
	Memory at fd001000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

01:0a.0 Fiber Channel: Q Logic: Unknown device 2300 (rev 01)
	Subsystem: Q Logic: Unknown device 0009
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 20
	I/O ports at 6400 [size=256]
	Memory at fd002000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [44] Power Management version 2
	Capabilities: [4c] PCI-X non-bridge device.
	Capabilities: [54] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-


--------------080704010901030007070809
Content-Type: text/plain;
 name="prodapp3.config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prodapp3.config"

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_3GB is not set
# CONFIG_05GB is not set
# CONFIG_HIGHIO is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_X86_NUMAQ is not set
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_MAX_USER_RT_PRIO=100
CONFIG_MAX_RT_PRIO=0
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_LVM=m

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_TUX is not set
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
CONFIG_IP_ROUTE_TOS=y
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
# CONFIG_IP_NF_MATCH_AH_ESP is not set
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
CONFIG_ATALK=m

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
CONFIG_BLK_DEV_SVWKS=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLOGIC_QLA2XXX=y
# CONFIG_SCSI_QLOGIC_QLA2XXX_QLA2200 is not set
CONFIG_SCSI_QLOGIC_QLA2XXX_QLA2300=m
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_TC35815 is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=m
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_NEW_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=m
# CONFIG_MYRI_SBUS is not set
CONFIG_NS83820=m
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_XFS_FS is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set
# CONFIG_ZLIB_FS_INFLATE is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
CONFIG_USB_OHCI=m
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_HID is not set
# CONFIG_USB_HIDINPUT is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_BRLVGER is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_HIGHMEM_EMULATION is not set

--------------080704010901030007070809--

