Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312680AbSCZUnm>; Tue, 26 Mar 2002 15:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312480AbSCZUn0>; Tue, 26 Mar 2002 15:43:26 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:4868 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S312474AbSCZUnA> convert rfc822-to-8bit; Tue, 26 Mar 2002 15:43:00 -0500
Date: Tue, 26 Mar 2002 21:42:43 +0100 (CET)
From: tomas szepe <kala@pinerecords.com>
To: davem@redhat.com, <linux-kernel@vger.kernel.org>
Subject: 2.4.18 SPARC SMP oops
Message-ID: <Pine.LNX.4.44.0203262128370.417-100000@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David and everybody else on lkml,


The following oops is more-or-less-deterministically reproducible
on my dual-processor SPARCstation 10 with 160MB RAM. It tends to send
the system down under heavy load caused by either sendmail/procmail
or apache. I first came across the bug at around 2.4.17, though it's
probably been lurking in the kernel much longer. I've gone through
quite a bit of trouble attempting to get the oops barf at me in 2.2.x
in case it's my hw config that's behind the whole problem, but I haven't
run into any breakdowns, 2.2.21-rc2 included.

I'm willing to provide as much support as I can to anyone who finds
the issue important enough to try to fix it -- for me, at present,
it efficiently renders the 2.4 branch unusable on my 24-7 server
(which is rather inconvenient as I have trouble finding an alternative
to iptables).

After the oops occurs, the machine is in a state where:

    o  All memory is exhausted, yet no processes get killed
       (I haven't got a clue as to where all the memory goes).
    o  System load is constantly rising.
    o  Most processes are impossible to run (sh won't fork them),
       but somehow I've always been able to ssh in and issue a reboot
       after a while of trying.
    o  The system can only be rebooted via /sbin/reboot -f -n (god
       bless ext3!), as it appears that sync() won't go through.

Enclosed please find the oops decode from ksymoops 2.4.5 as well
as an inline copy of the corresponding 2.4.18-rc4 '.config'. Should
you need more information, please don't hesitate to ask for it.

bye,
Tomas (I'm not subscribed to the list, make sure to CC me!)

pub 1024d/8e316a84 2002-01-29   tomas szepe <kala@pinerecords.com>
openpgp f/print 2955 2eea c4b8 b09e 7ae1  4d5d 68e3 d606 8e31 6a84


ksymoops 2.4.5 on sparc 2.4.18-rc4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-rc4/ (default)
     -m /boot/System.map (specified)

Mar 26 15:26:48 louise kernel: Run out of nocached RAM!
Mar 26 15:26:48 louise kernel: kernel BUG at srmmu.c:397!
Mar 26 15:26:48 louise kernel: Unable to handle kernel NULL pointer dereference<1>tsk->{mm,active_mm}->context = 000098b9
Mar 26 15:26:48 louise kernel: tsk->{mm,active_mm}->pgd = fc0e9400
Mar 26 15:26:48 louise kernel:               \|/ ____ \|/
Mar 26 15:26:49 louise kernel:               "@'/ ,. \`@"
Mar 26 15:26:49 louise kernel:               /_| \__/ |_\
Mar 26 15:26:50 louise kernel:                  \__U_/
Mar 26 15:26:50 louise kernel: procmail(6642): Oops
Mar 26 15:26:50 louise kernel: PSR: 408000c6 PC: f00241dc NPC: f00241e0 Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
Mar 26 15:26:51 louise kernel: g0: 87f20019 g1: 40800fe4 g2: 00000001 g3: 40400fe5 g4: f002b9b8 g5: 53545556 g6: f8708000 g7: 00000100
Mar 26 15:26:52 louise kernel: o0: 0000001b o1: 404000e6 o2: f018c800 o3: f018c800 o4: f018c930 o5: f01e5c00 sp: f8709d48 o7: f00241d4
Mar 26 15:26:52 louise kernel: l0: 00000000 l1: f01c2e20 l2: f004c54c l3: 00000000 l4: 00000020 l5: 5f646c00 l6: f8708000 l7: 5002a6a8
Mar 26 15:26:52 louise kernel: i0: f87200a0 i1: 501e46c4 i2: 009187ee i3: f041f760 i4: 00000000 i5: 00000008 fp: f8709db0 i7: f003f75c
Mar 26 15:26:52 louise kernel: Caller[f003f75c]
Mar 26 15:26:52 louise kernel: Caller[f003f588]
Mar 26 15:26:53 louise kernel: Caller[f0022428]
Mar 26 15:26:53 louise kernel: Caller[f001505c]
Mar 26 15:26:53 louise kernel: Caller[5011f9b8]
Mar 26 15:26:53 louise kernel: Instruction DUMP: 92126170  40001d46  9410218d <c0202000> 81c7e008  91e82000  9de3bf98  90100018  7fffff53

>>PC;  f00241dc <srmmu_pte_alloc_one+1c/28>   <=====

>>g0; 87f20019 Before first symbol
>>g1; 40800fe4 Before first symbol
>>g3; 40400fe5 Before first symbol
>>g4; f002b9b8 <release_console_sem+44/10c>
>>g5; 53545556 Before first symbol
>>g6; f8708000 <end+84efd60/e0f0d60>
>>o1; 404000e6 Before first symbol
>>o2; f018c800 <abi_table+70/134>
>>o3; f018c800 <abi_table+70/134>
>>o4; f018c930 <console_printk+0/10>
>>o5; f01e5c00 <uidhash_table+16c/400>
>>sp; f8709d48 <end+84f1aa8/e0f0d60>
>>o7; f00241d4 <srmmu_pte_alloc_one+14/28>
>>l1; f01c2e20 <pagemap_lru_lock+0/20>
>>l2; f004c54c <_alloc_pages+4/2c>
>>l5; 5f646c00 Before first symbol
>>l6; f8708000 <end+84efd60/e0f0d60>
>>l7; 5002a6a8 Before first symbol
>>i0; f87200a0 <end+8507e00/e0f0d60>
>>i1; 501e46c4 Before first symbol
>>i2; 009187ee Before first symbol
>>i3; f041f760 <end+2074c0/e0f0d60>
>>fp; f8709db0 <end+84f1b10/e0f0d60>
>>i7; f003f75c <pte_alloc+44/b0>

Trace; f003f75c <pte_alloc+44/b0>
Trace; f003f588 <handle_mm_fault+70/184>
Trace; f0022428 <do_sparc_fault+200/450>
Trace; f001505c <srmmu_fault+58/68>
Trace; 5011f9b8 Before first symbol

Code;  f00241d0 <srmmu_pte_alloc_one+10/28>
00000000 <_PC>:
Code;  f00241d0 <srmmu_pte_alloc_one+10/28>
   0:   92 12 61 70       or  %o1, 0x170, %o1
Code;  f00241d4 <srmmu_pte_alloc_one+14/28>
   4:   40 00 1d 46       call  751c <_PC+0x751c> f002b6ec <printk+0/1e8>
Code;  f00241d8 <srmmu_pte_alloc_one+18/28>
   8:   94 10 21 8d       mov  0x18d, %o2
Code;  f00241dc <srmmu_pte_alloc_one+1c/28>   <=====
   c:   c0 20 20 00       clr  [ %g0 ]   <=====
Code;  f00241e0 <srmmu_pte_alloc_one+20/28>
  10:   81 c7 e0 08       ret
Code;  f00241e4 <srmmu_pte_alloc_one+24/28>
  14:   91 e8 20 00       restore  %g0, 0, %o0
Code;  f00241e8 <srmmu_free_pte_fast+0/18>
  18:   9d e3 bf 98       save  %sp, -104, %sp
Code;  f00241ec <srmmu_free_pte_fast+4/18>
  1c:   90 10 00 18       mov  %i0, %o0
Code;  f00241f0 <srmmu_free_pte_fast+8/18>
  20:   7f ff ff 53       call  fffffd6c <_PC+0xfffffd6c> f0023f3c <srmmu_free_nocache+0/a4>
Code;  f00241f4 <srmmu_free_pte_fast+c/18>
  24:   00 00 00 00       unimp  0


/usr/src/linux/.config:
#
# Automatically generated make config: don't edit
#
CONFIG_UID16=y
CONFIG_HIGHMEM=y

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
# General setup
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SMP=y
CONFIG_SPARC32=y
# CONFIG_ISA is not set
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_PCMCIA is not set
CONFIG_SBUS=y
CONFIG_SBUSCHAR=y
CONFIG_BUSMOUSE=y
CONFIG_SUN_MOUSE=y
CONFIG_SERIAL=y
CONFIG_SUN_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SUN_KEYBOARD=y
CONFIG_SUN_CONSOLE=y
CONFIG_SUN_AUXIO=y
CONFIG_SUN_IO=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
# CONFIG_SUN4 is not set
# CONFIG_PCI is not set
CONFIG_SUN_OPENPROMFS=m
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_SUNOS_EMUL is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_SUNBPP=m
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y
CONFIG_PRINTER=m

#
# Console drivers
#
CONFIG_PROM_CONSOLE=y

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_SBUS=y
CONFIG_FB_CGSIX=y
# CONFIG_FB_BWTWO is not set
# CONFIG_FB_CGTHREE is not set
# CONFIG_FB_TCX is not set
# CONFIG_FB_CGFOURTEEN is not set
# CONFIG_FB_P9100 is not set
# CONFIG_FB_LEO is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FONT_SUN8x16 is not set
CONFIG_FONT_SUN12x22=y
CONFIG_FBCON_FONTS=y
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Misc Linux/SPARC drivers
#
CONFIG_SUN_OPENPROMIO=m
CONFIG_SUN_MOSTEK_RTC=y
# CONFIG_SUN_BPP is not set
# CONFIG_SUN_VIDEOPIX is not set
# CONFIG_SUN_AURORA is not set
# CONFIG_TADPOLE_TS102_UCTRL is not set
# CONFIG_SUN_JSFLASH is not set

#
# Linux/SPARC audio subsystem (EXPERIMENTAL)
#
# CONFIG_SPARCAUDIO is not set
# CONFIG_SPARCAUDIO_AMD7930 is not set
# CONFIG_SPARCAUDIO_DBRI is not set
# CONFIG_SPARCAUDIO_CS4231 is not set
# CONFIG_SPARCAUDIO_DUMMY is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_MATCH_LIMIT is not set
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_MARK is not set
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
# CONFIG_IP_NF_MATCH_STATE is not set
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_TARGET_LOG is not set
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
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
# CONFIG_IDE is not set
# CONFIG_BLK_DEV_IDE_MODES is not set
# CONFIG_BLK_DEV_HD is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CDrom)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
CONFIG_SCSI_SUNESP=y
# CONFIG_SCSI_QLOGICPTI is not set

#
# Fibre Channel support
#
# CONFIG_FC4 is not set
# CONFIG_FC4_SOC is not set
# CONFIG_FC4_SOCAL is not set
# CONFIG_SCSI_PLUTO is not set
# CONFIG_SCSI_FCAL is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
CONFIG_TUN=m
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_BSDCOMP is not set
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_SUNLANCE=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_MYRI_SBUS is not set

#
# Unix98 PTY support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=512

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_REISERFS_FS=m
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
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_MINIX_FS=m
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
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=m
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
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
CONFIG_SUN_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=m
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
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
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
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Watchdog
#
# CONFIG_SOFT_WATCHDOG is not set

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set

