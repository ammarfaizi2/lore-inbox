Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbTBXUCo>; Mon, 24 Feb 2003 15:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267346AbTBXUCo>; Mon, 24 Feb 2003 15:02:44 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:30373 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S267339AbTBXUCi>;
	Mon, 24 Feb 2003 15:02:38 -0500
Date: Mon, 24 Feb 2003 12:03:04 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.62-mm2 slow file system writes across multiple disks
Message-ID: <20030224120304.A29472@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

Running 2.5.62-mm2, I was trying to get multiple commands queued to
different scsi disks via writes to multiple file systems (each fs
on its own disk), but got rather low performance.

Are there any config options or settings I should change to improve the
performance?

Is this expected behaviour for now?

I'm mounting 10 disks using ext2 with noatime, starting 10 dd's in
parallel, with if=/dev/zero bs=128k count=1000, then umount-ing after each
dd completes.

All disks are attached to a single qlogic 2300, running with the feral
driver. Each disk can do about 20 mb/sec, the host adapter is limited to
about 100 mb/sec (fibre 1 gbit/sec).

Kernel is 2.5.62-mm2 with elevator=deadline on a 8 cpu NUMAQ box, all dd's
were run on cpu's 0-3 to try and avoid any cross-node (NUMA) affects.

Following are numbers with a hacked dd to open with O_DIRECT, then dd
without O_DIRECT, and then my config settings.


With O_DIRECT set, 10 dd's (writes) in parallel to ten different file
systems on ten different drives:

[patman@elm3b79 iostuff]$ vmstat 1 1000
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  0  0      0 7035300 229752 500000    0    0     2    15   26     1  0  0  0
 0  0  0      0 7035300 229752 500000    0    0     0     0 1168     6  0  0 100
 3  8  1      0 7029028 231328 500044    0    0  1594  3124 1426  1471  4 22 74
 3  7  0      0 7028644 231440 500044    0    0    44 88324 1911  1632  0  7 93
 4  7  0      0 7028644 231480 500044    0    0     0 89088 1873  1362  0  5 95
 3  7  0      0 7028580 231520 500044    0    0     0 89216 1851  1364  0  5 94
 3  7  0      0 7028580 231564 500044    0    0     0 88784 1889  1374  0  5 94
 0 10  0      0 7028516 231612 500044    0    0     0 88448 1806  1363  0  5 95
 2  8  0      0 7028452 231656 500044    0    0     0 87936 1796  1353  0  5 95
 2  8  0      0 7028452 231696 500044    0    0     0 88960 1814  1343  0  5 94
 2  8  0      0 7028388 231740 500044    0    0     0 89788 1861  1378  0  5 95
 2  8  0      0 7028324 231780 500044    0    0     0 89216 1828  1379  0  5 95
 2  8  0      0 7028324 231824 500044    0    0     0 88192 1834  1370  0  5 95
 0 10  0      0 7028324 231872 500044    0    0     0 88832 1843  1393  0  5 95
 2  8  0      0 7028260 231916 500044    0    0     4 88964 1847  1400  0  6 94
 2  8  0      0 7028132 231968 500044    0    0     8 89088 1865  1398  0  5 95
 3  8  0      0 7028132 232008 500044    0    0     0 89472 1871  1384  0  5 95
 5  2  2      0 7028764 231584 500020    0    0     8 29372 1763   658  1 47 53
 1  3  2      0 7031476 230084 500008    0    0     0  5952 1440   217  0 54 46
 1  0  0      0 7033612 229784 500004    0    0     0   200 1277   101  0  3 96
 0  0  0      0 7034444 229784 500004    0    0     0     0 1059    53  0  0 99

Total time of (for all dd's and umounts to complete, I can post times for
individual dd if wanted):

0.39user 11.82system 0:22.34elapsed 54%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (12790major+5402minor)pagefaults 0swaps



With O_DIRECT NOT set running 10 dd's (writes) in parallel to ten
different file systems on ten different drives on one host gives me:

[patman@elm3b79 iostuff]$ vmstat 1 10000
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  0  0      0 7070668 222200 471956    0    0     2    16   55     1  0  0 28
 0  0  0      0 7070668 222200 471956    0    0     0     0 1202     6  0  0 100
 1  0  0      0 7069948 222204 471948    0    0     0    28 1034    32  1  1 98
10  1  2      0 6893724 224036 640644    0    0  1634   664 1470  1637  4 55 41
10  0  0      0 6542300 224388 986092    0    0    12   164 1312   151  0 52 48
10  0  3      0 6206700 224640 1314784    0    0     0 180412 1314   111  0 56 43
 5  5  1      0 5916124 224884 1599212    0    0     4 306644 1366   208  1 53 46
 0 10  1      0 5805612 224972 1707016    0    0     0 147996 1364    99  1 20 79
 0 10  1      0 5805580 224972 1707016    0    0     0 29216 1348    20  0  1 98
 1  9  1      0 5768996 225008 1743032    0    0     0 30232 1359    28  0  6 94
 0 10  1      0 5759676 225032 1751992    0    0     0 28260 1361    57  0  3 97
 0 10  1      0 5759676 225032 1751992    0    0     0    24 1344     8  0  1 99
 0 10  1      0 5759676 225032 1751992    0    0     0 14352 1357    20  0  1 99
 0 10  1      0 5759676 225032 1751992    0    0     0 11272 1346    14  0  1 99

[ most dd's have completed here, just umount now ]

 0 10  1      0 5889108 225032 1623988    0    0     0 18964 1709    28  0 11 89
 0  9  1      0 6018916 224744 1495984    0    0     0 70668 1408    72  0 14 86
 0  9  1      0 6018788 224744 1495984    0    0     0 83080 1422    52  0  3 97
 0  9  1      0 6018636 224744 1495984    0    0     0 77380 1431    52  0  3 97
 0  9  1      0 6018348 224744 1495984    0    0     0 77904 1431    52  0  3 97
 1  8  1      0 6018260 224756 1495984    0    0     0 52824 1428    60  0  2 98
 0  9  1      0 6018276 224756 1495984    0    0     0 18420 1402    21  0  2 98
 0  9  1      0 6018292 224756 1495984    0    0     0 12276 1424    22  0  1 99
 0  9  1      0 6018308 224756 1495984    0    0     0  7176 1129    14  0  1 99
 0  9  1      0 6018380 224756 1495984    0    0     0  3588 1124    12  0  1 99
 0  8  1      0 6148668 224468 1367980    0    0     0 14356 1568    30  0 16 84
 0  7  1      0 6539564 224176 983968    0    0     0 16908 1372    88  0 32 68
 0  4  1      0 6542172 223440 983968    0    0     0  7176 1256    75  0 10 90
 0  4  1      0 6672124 223440 855964    0    0     0  7688 1169    16  0  7 92
 0  4  1      0 6672540 223440 855964    0    0     0 17940 1255    16  0  1 99
 0  3  1      0 6673452 223164 855964    0    0     0  6720 1086    52  0  3 97
 0  3  1      0 6673580 223164 855964    0    0     0     0 1070     6  0  0 99
 0  3  1      0 6803732 223164 727960    0    0     0 11280 1079    14  0  5 95
 1  2  1      0 6804404 223000 727960    0    0     0  7684 1194    18  0  4 96
 0  2  1      0 6804860 223000 727960    0    0     0 14352 1217    25  0  1 99
 0  2  1      0 6804940 223016 727960    0    0     0  7192 1073    32  0  0 100
 0  2  1      0 6935020 223016 599956    0    0     0    40 1056    16  0  6 94
 0  1  1      0 6936092 222720 599956    0    0     0     0 1053    23  0  2 97
 0  1  1      0 6936092 222720 599956    0    0     0     0 1045     6  0  0 100
 0  1  1      0 6936276 222720 599956    0    0     0     0 1050     6  0  0 99
 0  1  1      0 6936284 222720 599956    0    0     0     0 1048     6  0  0 100
 0  0  3      0 7066996 222428 471952    0    0     0   184 1057    35  0  6 94
 0  0  0      0 7067748 222436 471952    0    0     0     8 1064    41  0  0 100
 0  0  0      0 7067892 222436 471952    0    0     0     0 1026     8  0  0 100


Total time for all 10 dd's and umounts:

0.49user 25.96system 0:45.25elapsed 58%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (12790major+5399minor)pagefaults 0swaps


config options set:

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_SWAP=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_NUMAQ=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PREFETCH=y
CONFIG_SMP=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NR_CPUS=32
CONFIG_NUMA=y
CONFIG_DISCONTIGMEM=y
CONFIG_HAVE_ARCH_BOOTMEM_NODE=y
CONFIG_X86_CPUID=y
CONFIG_HIGHMEM64G=y
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_HIGHPTE=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_HOTPLUG=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_LBD=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_QLOGIC_ISP_NEW=y
CONFIG_SCSI_DEBUG=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_TULIP=y
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_NET_PCI=y
CONFIG_ADAPTEC_STARFIRE=y
CONFIG_INPUT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_RAW_DRIVER=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_FS_MBCACHE=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRC32=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y

-- Patrick Mansfield
