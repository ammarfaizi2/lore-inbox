Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUI0XqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUI0XqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 19:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUI0XqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 19:46:19 -0400
Received: from head.linpro.no ([80.232.36.1]:707 "EHLO head.linpro.no")
	by vger.kernel.org with ESMTP id S267466AbUI0Xoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 19:44:38 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.27: md RAID1 oops on alpha revisited
Organization: Linpro AS
From: Ingvar Hagelund <ingvar@linpro.no>
Date: 28 Sep 2004 01:44:24 +0200
Message-ID: <ujcr7onnup3.fsf@nfsd.linpro.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: -4.9 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CC5AO-0005TC-Jj*N6ZfrUHauW6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.27: md RAID1 oops on alpha revisited

We have a Compaq Alphaserver DS10 466 MHz running Debian Woody with a
self compiled 2.4.27 from kernel.org. We have not been able to make it
run stable on md RAID1. It always crashes in less than an hour
uptime, presumely while stressing the RAID code. Running on single
disks, it's rock stable.

While debugging the problem and googling for answers, we came across
very similar problems, posted to lkml by Norbert Preining 2004-03-27
(http://www.uwsg.iu.edu/hypermail/linux/kernel/0403.3/0837.html)

According to that thread, things should work ok with a newer gcc. It
also seems like some version of the patch mentioned has gone into the
kernel. We rebuilt the kernel using gcc-3.3.4. The result: The machine
crashes maybe a little later, but always within an hour or so.

As the bootlog shows, we booted with degraded mirrors, and added the
other parts of the mirrors after booting. (This to make sure the box
doesn't oops till it's done booting.)

The machine locks up after the oops, so we had to run ksymoops after a
reboot without raid, but with the same kernel and same modules loaded.

Below is ver_linux, cpuinfo, meminfo, some info from gcc, output from
lsmod, the oops run though ksymoops, and the bootlog from dmesg. The
oops was captured using a serial console.

Is it possible to make this thing run stable on md RAID1?

Ingvar


# sh /usr/src/linux-2.4.27/scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux nope 2.4.27-gcc334 #1 Fri Aug 27 12:14:37 CEST 2004 alpha unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.26
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ipt_LOG ipt_state ipt_TCPMSS iptable_mangle iptable_nat ip_conntrack iptable_filter ip_tables 8021q tulip crc32 rtc

# cat /proc/cpuinfo 
cpu                     : Alpha
cpu model               : EV6
cpu variation           : 7
cpu revision            : 0
cpu serial number       : 
system type             : Tsunami
system variation        : Webbrick
system revision         : 0
system serial number    : 
cycle frequency [Hz]    : 462962962 
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 921.84
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : COMPAQ AlphaServer DS10 466 MHz
cpus detected           : 1

# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  523632640 46292992 477339648        0  4931584 22994944
Swap: 1077395456        0 1077395456
MemTotal:       511360 kB
MemFree:        466152 kB
MemShared:           0 kB
Buffers:          4816 kB
Cached:          22456 kB
SwapCached:          0 kB
Active:          15720 kB
Inactive:        16824 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       511360 kB
LowFree:        466152 kB
SwapTotal:     1052144 kB
SwapFree:      1052144 kB


# /usr/local/toolchain/bin/gcc-3.3 -dumpmachine
alphaev6-unknown-linux-gnu
# /usr/local/toolchain/bin/gcc-3.3 -dumpversion
3.3.4

# lsmod
Module                  Size  Used by    Not tainted
ipt_LOG                 4697   1  (autoclean)
ipt_state                880   2  (autoclean)
ipt_TCPMSS              3032   1  (autoclean)
iptable_mangle          2872   1  (autoclean)
iptable_nat            23178   1  (autoclean)
ip_conntrack           26297   0  (autoclean) [ipt_state iptable_nat]
iptable_filter          2308   1  (autoclean)
ip_tables              17408   8  [ipt_LOG ipt_state ipt_TCPMSS iptable_mangle iptable_nat iptable_filter]
8021q                  19408   1  (autoclean)
tulip                  51048   2 
crc32                   3376   0  [tulip]
rtc                     6592   0  (autoclean)


ksymoops 2.4.5 on alpha 2.4.27-gcc334.  Options used
     -V (specified)
     -k /var/log/ksymoops/20040928000118.ksyms (specified)
     -l /var/log/ksymoops/20040928000118.modules (specified)
     -o /lib/modules/2.4.27-gcc334/ (default)
     -m /boot/System.map-2.4.27-gcc334 (default)

Warning (compare_maps): mismatch on symbol ip_conntrack_destroyed  , ip_conntrack says fffffffc00358680, /lib/modules/2.4.27-gcc334/kernel/net/ipv4/netfilter/ip_conntrack.o says fffffffc00352010.  Ignoring /lib/modules/2.4.27-gcc334/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol ip_conntrack_hash  , ip_conntrack says fffffffc003586a0, /lib/modules/2.4.27-gcc334/kernel/net/ipv4/netfilter/ip_conntrack.o says fffffffc00352030.  Ignoring /lib/modules/2.4.27-gcc334/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol ip_conntrack_htable_size  , ip_conntrack says fffffffc00358688, /lib/modules/2.4.27-gcc334/kernel/net/ipv4/netfilter/ip_conntrack.o says fffffffc00352018.  Ignoring /lib/modules/2.4.27-gcc334/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol ip_conntrack_lock  , ip_conntrack says fffffffc00358678, /lib/modules/2.4.27-gcc334/kernel/net/ipv4/netfilter/ip_conntrack.o says fffffffc00352008.  Ignoring /lib/modules/2.4.27-gcc334/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol vlan_default_dev_flags  , 8021q says fffffffc0033aaaa, /lib/modules/2.4.27-gcc334/kernel/net/8021q/8021q.o says fffffffc0033600a.  Ignoring /lib/modules/2.4.27-gcc334/kernel/net/8021q/8021q.o entry
Warning (compare_maps): mismatch on symbol vlan_group_lock  , 8021q says fffffffc0033aab8, /lib/modules/2.4.27-gcc334/kernel/net/8021q/8021q.o says fffffffc00336000.  Ignoring /lib/modules/2.4.27-gcc334/kernel/net/8021q/8021q.o entry
Warning (compare_maps): mismatch on symbol vlan_name_type  , 8021q says fffffffc0033aaa8, /lib/modules/2.4.27-gcc334/kernel/net/8021q/8021q.o says fffffffc00336008.  Ignoring /lib/modules/2.4.27-gcc334/kernel/net/8021q/8021q.o entry
Warning (compare_maps): mismatch on symbol tulip_debug  , tulip says fffffffc003326bc, /lib/modules/2.4.27-gcc334/kernel/drivers/net/tulip/tulip.o says fffffffc0032600c.  Ignoring /lib/modules/2.4.27-gcc334/kernel/drivers/net/tulip/tulip.o entry
Warning (compare_maps): mismatch on symbol tulip_max_interrupt_work  , tulip says fffffffc003326f8, /lib/modules/2.4.27-gcc334/kernel/drivers/net/tulip/tulip.o says fffffffc00326018.  Ignoring /lib/modules/2.4.27-gcc334/kernel/drivers/net/tulip/tulip.o entry
Warning (compare_maps): mismatch on symbol tulip_rx_copybreak  , tulip says fffffffc003326fc, /lib/modules/2.4.27-gcc334/kernel/drivers/net/tulip/tulip.o says fffffffc0032601c.  Ignoring /lib/modules/2.4.27-gcc334/kernel/drivers/net/tulip/tulip.o entry
Unable to handle kernel paging request at virtual address 0000000000000240
swapper(0): Oops 1
pc = [<fffffc000050da04>]  ra = [<fffffc000050da04>]  ps = 0007    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000000  t0 = 0000000000000000  t1 = fffffc000050dc10
t2 = 0000000000000000  t3 = fffffc001fdd6000  t4 = fffffc000064cdf8
t5 = fffffffffffffc18  t6 = ffffffffffffffff  t7 = fffffc0000600000
s0 = 0000000000000000  s1 = 0000000000000004  s2 = fffffc001ff86800
s3 = fffffc001ff868b8  s4 = 0000000000000004  s5 = fffffc00006eef40
s6 = 0000000000000000
a0 = fffffc001fdd60c0  a1 = 0000000000000000  a2 = fffffc0000603ec8
a3 = fffffc0000b70158  a4 = 000000011ffffa20  a5 = 0000000000000000
t8 = 000000012000e8ad  t9 = 00000200000ccf84  t10= 000000000000000b
t11= 0000000000000400  pv = fffffc000050d6b0  at = fffffc0000605000
gp = fffffc00006e1a00  sp = fffffc0000603df8
Trace:fffffc000050d6dc fffffc0000317ca4 fffffc0000318640 fffffc000031ff70 fffffc0000318c84 fffffc0000313308 fffffc00003148c0 fffffc0000320200 fffffc00003148a0 fffffc00003100a0 fffffc000031001c 
Code: 23bd4018  c3ffffc8  2ffe0000  47ff041f  2ffe0000  d3400049 <b0090240> c3ffffbd 


>>RA;  fffffc000050da04 <isp1020_intr_handler+304/420>

>>PC;  fffffc000050da04 <isp1020_intr_handler+304/420>   <=====

Trace; fffffc000050d6dc <do_isp1020_intr_handler+2c/50>
Trace; fffffc0000317ca4 <handle_IRQ_event+a4/120>
Trace; fffffc0000318640 <handle_irq+d0/190>
Trace; fffffc000031ff70 <dp264_srm_device_interrupt+30/50>
Trace; fffffc0000318c84 <do_entInt+f4/150>
Trace; fffffc0000313308 <ret_from_sys_call+0/10>
Trace; fffffc00003148c0 <cpu_idle+70/80>
Trace; fffffc0000320200 <do_check_pgt_cache+0/140>
Trace; fffffc00003148a0 <cpu_idle+50/80>
Trace; fffffc00003100a0 <rest_init+40/60>
Trace; fffffc000031001c <_stext+1c/20>

Code;  fffffc000050d9ec <isp1020_intr_handler+2ec/420>
0000000000000000 <_PC>:
Code;  fffffc000050d9ec <isp1020_intr_handler+2ec/420>
   0:   18 40 bd 23       lda  gp,16408(gp)
Code;  fffffc000050d9f0 <isp1020_intr_handler+2f0/420>
   4:   c8 ff ff c3       br   ffffffffffffff28 <_PC+0xffffffffffffff28> fffffc000050d914 <isp1020_intr_handler+214/420>
Code;  fffffc000050d9f4 <isp1020_intr_handler+2f4/420>
   8:   00 00 fe 2f       unop 
Code;  fffffc000050d9f8 <isp1020_intr_handler+2f8/420>
   c:   1f 04 ff 47       nop  
Code;  fffffc000050d9fc <isp1020_intr_handler+2fc/420>
  10:   00 00 fe 2f       unop 
Code;  fffffc000050da00 <isp1020_intr_handler+300/420>
  14:   49 00 40 d3       bsr  ra,13c <_PC+0x13c> fffffc000050db28 <isp1020_return_status+8/100>
Code;  fffffc000050da04 <isp1020_intr_handler+304/420>   <=====
  18:   40 02 09 b0       stl  v0,576(s0)   <=====
Code;  fffffc000050da08 <isp1020_intr_handler+308/420>
  1c:   bd ff ff c3       br   ffffffffffffff14 <_PC+0xffffffffffffff14> fffffc000050d900 <isp1020_intr_handler+200/420>

Kernel panic: Aiee, killing interrupt handler!

10 warnings issued.  Results may not be reliable.


# dmesg
Linux version 2.4.27-gcc334 (foo@nope) (gcc version 3.3.4) #1 Fri Aug 27 12:14:37 CEST 2004
Booting on Tsunami variation Webbrick using machine vector Webbrick from SRM
Major Options: LEGACY_START MAGIC_SYSRQ 
Command line: ro root=/dev/md1 md=1,/dev/sda1,missing md=2,/dev/sda2,missing md=3,/dev/sda3,missing md=4,/dev/sda4,missing console=ttyS0,57600
memcluster 0, usage 1, start        0, end      256
memcluster 1, usage 0, start      256, end    65479
memcluster 2, usage 1, start    65479, end    65536
freeing pages 256:384
freeing pages 932:65479
reserving pages 932:933
On node 0 totalpages: 65479
zone(0): 65479 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/md1 md=1,/dev/sda1,missing md=2,/dev/sda2,missing md=3,/dev/sda3,missing md=4,/dev/sda4,missing console=ttyS0,57600
md: Will configure md1 (super-block) from /dev/sda1,missing, below.
md: Will configure md2 (super-block) from /dev/sda2,missing, below.
md: Will configure md3 (super-block) from /dev/sda3,missing, below.
md: Will configure md4 (super-block) from /dev/sda4,missing, below.
Using epoch = 2000
Console: colour VGA+ 80x25
Calibrating delay loop... 921.84 BogoMIPS
Memory: 511208k/523832k available (2803k kernel code, 10576k reserved, 889k data, 152k init)
Dentry cache hash table entries: 65536 (order: 7, 1048576 bytes)
Inode cache hash table entries: 32768 (order: 6, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 8192 bytes)
Buffer cache hash table entries: 32768 (order: 5, 262144 bytes)
Page-cache hash table entries: 65536 (order: 6, 524288 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
SGI XFS with no debug enabled
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 00:0d.0
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8800-0x8807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x8808-0x880f, BIOS settings: hdc:pio, hdd:pio
hdc: COMPAQ CDR-8435, ATAPI CD/DVD-ROM drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide1 at 0x170-0x177,0x376 on irq 15
SCSI subsystem driver Revision: 1.00
qlogicisp : new isp1020 revision ID (5)
scsi0 : QLogic ISP1020 SCSI on PCI bus 00 device 88 irq 47 MEM base 0xfffffd000a0c1000
  Vendor: SEAGATE   Model: ST373307LW        Rev: 0007
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: SEAGATE   Model: ST373307LW        Rev: 0007
  Type:   Direct-Access                      ANSI SCSI revision: 03
DC390: 0 adapters found
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sda: 143374744 512-byte hdwr sectors (73408 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
SCSI device sdb: 143374744 512-byte hdwr sectors (73408 MB)
 sdb: sdb1 sdb2 sdb3 sdb4
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1843.200 MB/sec
   32regs    :  2121.728 MB/sec
   alpha     :  2039.808 MB/sec
   alpha prefetch:  1925.120 MB/sec
raid5: using function: alpha prefetch (1925.120 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Unknown device name: missing
md: Loading md1: /dev/sda1
 [events: 00000054]
md: bind<sda1,1>
md: sda1's event counter: 00000054
md: RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 248k
md1: 1 data-disks, max readahead per data-disk: 248k
raid1: device sda1 operational as mirror 0
raid1: md1, not all disks are operational -- trying to recover array
raid1: raid set md1 active with 1 out of 2 mirrors
md: updating md1 RAID superblock on device
md: sda1 [events: 00000055]<6>(write) sda1's sb offset: 2104448
md: recovery thread got woken up ...
md1: no spare disk to reconstruct array! -- continuing in degraded mode
md: recovery thread finished ...
md: Unknown device name: missing
md: Loading md2: /dev/sda2
 [events: 0000003b]
md: bind<sda2,1>
md: sda2's event counter: 0000003b
md: RAID level 1 does not need chunksize! Continuing anyway.
md2: max total readahead window set to 248k
md2: 1 data-disks, max readahead per data-disk: 248k
raid1: device sda2 operational as mirror 0
raid1: md2, not all disks are operational -- trying to recover array
raid1: raid set md2 active with 1 out of 2 mirrors
md: updating md2 RAID superblock on device
md: sda2 [events: 0000003c]<6>(write) sda2's sb offset: 4200896
md: recovery thread got woken up ...
md2: no spare disk to reconstruct array! -- continuing in degraded mode
md1: no spare disk to reconstruct array! -- continuing in degraded mode
md: recovery thread finished ...
md: Unknown device name: missing
md: Loading md3: /dev/sda3
 [events: 00000039]
md: bind<sda3,1>
md: sda3's event counter: 00000039
md: RAID level 1 does not need chunksize! Continuing anyway.
md3: max total readahead window set to 248k
md3: 1 data-disks, max readahead per data-disk: 248k
raid1: device sda3 operational as mirror 1
raid1: md3, not all disks are operational -- trying to recover array
raid1: raid set md3 active with 1 out of 2 mirrors
md: updating md3 RAID superblock on device
md: sda3 [events: 0000003a]<6>(write) sda3's sb offset: 4200896
md: recovery thread got woken up ...
md3: no spare disk to reconstruct array! -- continuing in degraded mode
md2: no spare disk to reconstruct array! -- continuing in degraded mode
md1: no spare disk to reconstruct array! -- continuing in degraded mode
md: recovery thread finished ...
md: Unknown device name: missing
md: Loading md4: /dev/sda4
 [events: 0000003a]
md: bind<sda4,1>
md: sda4's event counter: 0000003a
md: RAID level 1 does not need chunksize! Continuing anyway.
md4: max total readahead window set to 248k
md4: 1 data-disks, max readahead per data-disk: 248k
raid1: device sda4 operational as mirror 1
raid1: md4, not all disks are operational -- trying to recover array
raid1: raid set md4 active with 1 out of 2 mirrors
md: updating md4 RAID superblock on device
md: sda4 [events: 0000003b]<6>(write) sda4's sb offset: 1052160
md: recovery thread got woken up ...
md4: no spare disk to reconstruct array! -- continuing in degraded mode
md3: no spare disk to reconstruct array! -- continuing in degraded mode
md2: no spare disk to reconstruct array! -- continuing in degraded mode
md1: no spare disk to reconstruct array! -- continuing in degraded mode
md: recovery thread finished ...
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 65536 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
Adding Swap: 1052144k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,1), internal journal
rtc: SRM (post-2000) epoch (2000) detected
Real Time Clock Driver v1.10f
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
tulip0:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY (2) block.
tulip0:  Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) block.
tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21143 SYM PHY (4) block.
eth0: Digital DS21143 Tulip rev 65 at 0x8400, 08:00:2B:86:1C:54, IRQ 29.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
tulip1:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY (2) block.
tulip1:  Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) block.
tulip1:  Index #3 - Media 100baseTx-FDX (#5) described by a 21143 SYM PHY (4) block.
eth1: Digital DS21143 Tulip rev 65 at 0x8480, 08:00:2B:86:1C:55, IRQ 30.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
eth0.205: add 01:00:5e:00:00:01 mcast address to master interface
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2046 buckets, 16368 max) - 416 bytes per conntrack




-- 
Many that live deserve death. And some that die deserve life. Can you
give it to them? Then do not be too eager to deal out death in
judgement. For even the very wise cannot see all ends.
								Gandalf
