Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263543AbTDDSF2 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263808AbTDDSF2 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:05:28 -0500
Received: from [65.198.37.67] ([65.198.37.67]:8367 "EHLO funky.gghcwest.com")
	by vger.kernel.org with ESMTP id S263543AbTDDSFT (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 13:05:19 -0500
Date: Fri, 4 Apr 2003 10:16:48 -0800
From: Jeffrey Baker <jwbaker@acm.org>
To: linux-kernel@vger.kernel.org
Subject: performance degradation from 2.4.17 to 2.4.21-pre5aa2
Message-ID: <20030404181648.GA23281@heat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greets.  Thanks to rwhron, whose benchmarking skills are
unrivalled, and due to profound unhappiness with the
performance of my database server, I decided to move from
kernel 2.4.17 to 2.4.21-pre5aa2.  The aa kernel seems to
have much better block I/O and far superior I/O scheduling
fariness than 2.4.17.  So I decided to change kernels.

The machine in question is a dual pentium III 866 MHz,
serverworks, 4GB main memory, aic7xxx storage on six disks,
using software raid 0+1 with ext2 filesystems.  The workload
is both postgresql and mysql databases, with data of
approximately 80GB and about 60 simultaneous connections.
The performance problems we were having involved simple
queries just going off into space for up to tens of minutes.
I hoped the reduced maximum read latency of the aa kernel
(as seen in tiobench) would improve the situation.

Unfortunately for us, the server's performance is actually
much worse under 2.4.21-pre5aa2 than it was under 2.4.17.
While the block i/o rates seen in vmstat are generally
higher, the CPU load is also much higher, hovering between 7
and 9, normally with more than half the CPU time spent in
the kernel (according to top).  Time to connect to the
database, which involves a TCP connection and a fork and a
lot of file opens, has gone from essentially instantaneous
to varying between zero and thirty seconds.  Queries per
second has gone from about 100 to about 80, and a particular
ad hoc report that previously took fifteen minutes now takes
over twice that time.

I guess the punch line is that the kernel can look good on
paper but be a stinker in reality.  I've since moved the
machine back to 2.4.17.

I'm using highio and config_2gb.  Maybe there are some
config tweaks I can make to improve the situation.  Is there
any known reason why this type of workload would be run
poorly under these newer kernels?

Here's a snippet of vmstat.  The i/o numbers are pathetic
for a storage subsystem capable of over 80MB/s sequential:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 4  0  0 230152  99236   9464 3441048  20   0   172  1772 1708  8790  53  43   4
 7  0  0 230144 108812   9464 3441660   8   0    84  1008 1492  4879  43  57   0
 5  0  0 230136  83584   9464 3442588  12   0   232  1240 1646  7277  54  44   2
 4  0  0 230132  94296   9456 3442120   0   0   100   944 1572  7238  44  53   3
 9  1  0 230116 114716   9436 3439060  12   0   188  1032 1642  7447  46  50   4
 5  1  0 230116 100816   9444 3439520  20   0    76  1856 1394  3809  50  49   0
 7  0  1 230096 105684   9404 3434376  12   0   352   936 1600  6138  49  50   1
 9  1  1 230092  96788   9404 3434960   8   0    76   904 1537  4703  50  50   0
 5  0  0 230092 103884   9404 3435288   0   0    48   464  958  3502  51  45   3
 3  0  0 230092 105348   9404 3435968   0   0    72  1072 1451  6919  49  50   1
 3  0  0 230092 116780   9412 3436452   0   0    20  1760 1520  4578  46  48   7
 6  1  0 230088  95320   9412 3437028  48   0   204   752 1269  5630  50  48   1
 4  1  0 230084  96496   9412 3437732  16   0   132  1064 1499  5966  50  50   1
 7  0  0 230084 106360   9412 3438284   4   0    72   848 1429  7362  48  51   1

-jwb

PS here's everything turned on in my config:

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG8=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_FORCE_MAX_ZONEORDER=11
CONFIG_2GB=y
CONFIG_HIGHIO=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_MAX_USER_RT_PRIO=100
CONFIG_MAX_RT_PRIO=0
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=7777
CONFIG_BLK_DEV_INITRD=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_PACKET=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=256
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_NETDEVICES=y
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_ISA=m
CONFIG_ARCNET_COM20020_PCI=m
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_SERIAL_MULTIPORT=y
CONFIG_HUB6=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=512
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_QUOTA=y
CONFIG_AUTOFS4_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=y
CONFIG_UFS_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_AMIGA_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_SGI_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

