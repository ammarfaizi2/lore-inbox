Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRAZUmV>; Fri, 26 Jan 2001 15:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129763AbRAZUmL>; Fri, 26 Jan 2001 15:42:11 -0500
Received: from lilly.ping.de ([62.72.90.2]:4617 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S129675AbRAZUl4>;
	Fri, 26 Jan 2001 15:41:56 -0500
Date: Fri, 26 Jan 2001 21:40:59 +0100
To: linux-kernel@vger.kernel.org
Subject: Oops accessing file on 2048 bytes/sector vfat MO in 2.4.0
Message-ID: <20010126214058.A400@voyager.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Stefan Meyknecht <sm@voyager.ping.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I receive a Kernel oops while copying a file from MO-drive (vfat) with
2048 bytes sector size. There is no problen with ext2 formatted MOs.

I think it happens because the function pointer cfv_file_read of the
struct cvf_format is initialized with null.

This oops is 100% reproducable with the kernels: 2.4.0, 2.4.1-pre3,
2.4.1-pre7 and 2.4.0-ac11 (probably all >= 2.4.0).

Stefan

==========================================================================
fs/fat/file.c:
ssize_t fat_file_read(
	struct file *filp,
	char *buf,
	size_t count,
	loff_t *ppos)
{
	struct inode *inode = filp->f_dentry->d_inode;
	return MSDOS_SB(inode->i_sb)->cvf_format
			->cvf_file_read(filp,buf,count,ppos);  <-= oops
}
==========================================================================
fs/fat/cvf.c:

struct cvf_format bigblock_cvf = {
	0,	/* version - who cares? */	
	"big_blocks",
	0,	/* flags - who cares? */
	NULL,
	NULL,
	NULL,
	bigblock_fat_bread,
	bigblock_fat_bread,
	bigblock_fat_brelse,
	bigblock_fat_mark_buffer_dirty,
	bigblock_fat_set_uptodate,
	bigblock_fat_is_uptodate,
	bigblock_fat_ll_rw_block,
	default_fat_access,
	NULL,
	default_fat_bmap,
	NULL,                              <=- cvf_file_read!
	default_fat_file_write,
	NULL,
	NULL
};
==========================================================================
ksymoops 2.3.4 on i686 2.4.0-ac11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-ac11 (specified)
     -m /boot/System.map-2.4.0-ac11 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: c66dcaa0   ecx: 00001000   edx: c66dcac0
esi: bfffe77c   edi: 00000000   ebp: 00001000   esp: c6543f80
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 288, stackpage=c6543000)
Stack: c888d47d c66dcaa0 bfffe77c 00001000 c66dcac0 c66dcaa0 ffffffea c012d556 
       c66dcaa0 bfffe77c 00001000 c66dcac0 c6542000 00000002 bfffe77c bffff824 
       c0108d57 00000003 bfffe77c 00001000 00000002 bfffe77c bffff824 00000003 
Call Trace: [<c888d47d>] [<c012d556>] [<c0108d57>] 
Code:  Bad EIP value.

>>EIP; 00000000 Before first symbol
Trace; c888d47d <[fat]fat_file_read+2d/34>
Trace; c012d556 <sys_read+96/cc>
Trace; c0108d57 <system_call+33/38>
==========================================================================
Module                  Size  Used by
nls_iso8859-1           2848   1 (autoclean)
nls_cp437               4352   1 (autoclean)
vfat                   10320   1 (autoclean)
fat                    30272   0 (autoclean) [vfat]
hisax                 130032   3
isdn                   86800   4 [hisax]
slhc                    4496   1 [isdn]
emu10k1                45792   0 (unused)
soundcore               3856   4 [emu10k1]
==========================================================================
Linux version 2.4.0-ac11 (root@voyager) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Fri Jan 26 20:17:44 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000007eec000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000003000 @ 0000000007fec000 (ACPI data)
 BIOS-e820: 0000000000010000 @ 0000000007fef000 (reserved)
 BIOS-e820: 0000000000001000 @ 0000000007fff000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 32748
zone(0): 4096 pages.
zone(1): 28652 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=812 BOOT_FILE=/vmlinuz
Initializing CPU#0
Detected 501.147 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 127000k/130992k available (779k kernel code, 3604k reserved, 291k data, 164k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU: Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf08c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
PCI: Found IRQ 5 for device 00:04.2
PCI: The same IRQ used for device 00:09.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.3 present.
45 structures occupying 1336 bytes.
DMI table at 0x000F1F50.
BIOS Vendor: Award Software, Inc.
BIOS Version: ASUS P3B-F ACPI BIOS Revision 1007 Beta 001
BIOS Release: 07/26/2000
System Vendor: System Manufacturer.
Product Name: System Name.
Version System Version.
Serial Number SYS-1234567890.
Board Vendor: ASUSTeK Computer INC..
Board Name: <P3B-F>.
Board Version: REV 1.xx.
Asset Tag: Asset-1234567890.
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 84357kB/63268kB, 256 slots per queue
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0b.0
(scsi0) <Adaptec AHA-294X Ultra SCSI host adapter> found at PCI 0/11/0
(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AHA-294X Ultra SCSI host adapter>
(scsi0:0:0:0) Synchronous at 20.0 Mbyte/sec, offset 15.
  Vendor: IBM       Model: DCAS-34330        Rev: S61A
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:1:0) Synchronous at 20.0 Mbyte/sec, offset 15.
  Vendor: IBM       Model: DCAS-32160        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:2:0) Synchronous at 20.0 Mbyte/sec, offset 15.
  Vendor: IBM       Model: DCAS-32160        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:3:0) Synchronous at 20.0 Mbyte/sec, offset 15.
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:0:4:0) Synchronous at 10.0 Mbyte/sec, offset 8.
  Vendor: PLEXTOR   Model: CD-R   PX-R412C   Rev: 1.07
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:0:5:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: FUJITSU   Model: M2513E            Rev: 0030
  Type:   Optical Device                     ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi removable disk sdd at scsi0, channel 0, id 5, lun 0
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
Partition check:
 sda: sda1 sda2 sda3 < sda5 sda6 >
SCSI device sdb: 4226725 512-byte hdwr sectors (2164 MB)
 sdb: sdb1 sdb2
SCSI device sdc: 4226725 512-byte hdwr sectors (2164 MB)
 sdc: sdc1 sdc2 < sdc5 >
SCSI device sdd: 310352 2048-byte hdwr sectors (636 MB)
sdd: Write Protect is off
 sdd: sdd1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 164k freed
Adding Swap: 128484k swap-space (priority -1)
Adding Swap: 128484k swap-space (priority -2)
Creative EMU10K1 PCI Audio Driver, version 0.7, 20:23:02 Jan 26 2001
PCI: Found IRQ 5 for device 00:09.0
PCI: The same IRQ used for device 00:04.2
emu10k1: EMU10K1 rev 7 model 0x8040 found, IO at 0xd000-0xd01f, IRQ 5
CSLIP: code copyright 1989 Regents of the University of California
ISDN subsystem Rev: 1.114/1.94/1.140.6.1/1.85/none/1.5 loaded
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 2.41.6.1
HiSax: Layer2 Revision 2.25
HiSax: TeiMgr Revision 2.17
HiSax: Layer3 Revision 2.17
HiSax: LinkLayer Revision 2.51
HiSax: Approval certification failed because of
HiSax: unauthorized source code changes
HiSax: Total 1 card defined
HiSax: Card 1 Protocol EDSS1 Id=Fritz (0)
HiSax: AVM driver Rev. 2.13
AVM A1: Byte at 1b40 is 3
AVM A1: Byte at 1b43 is 3
AVM A1: Byte at 1b42 is 2
AVM A1: Byte at 1b40 is 3
HiSax: AVM A1 config irq:15 cfg:0x1B40
HiSax: isac:0x1740/0x1340
HiSax: hscx A:0x740/0x340  hscx B:0xF40/0xB40
AVM A1: ISAC version (0): 2086/2186 V1.1
AVM A1: HSCX version A: V2.1  B: V2.1
AVM A1: IRQ 15 count 0
AVM A1: IRQ 15 count 3
HiSax: DSS1 Rev. 2.30
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
==========================================================================
#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
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
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_PM=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_LVM_PROC_FS is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
# CONFIG_IDE is not set
# CONFIG_BLK_DEV_IDE_MODES is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
# CONFIG_AIC7XXX_PROC_STATS is not set
CONFIG_AIC7XXX_RESET_DELAY=5
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
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
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
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

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
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
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
CONFIG_ISDN=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
# CONFIG_ISDN_MPP is not set
CONFIG_ISDN_PPP_BSDCOMP=m
# CONFIG_ISDN_AUDIO is not set
# CONFIG_ISDN_X25 is not set

#
# ISDN feature submodules
#
# CONFIG_ISDN_DRV_LOOP is not set
# CONFIG_ISDN_DIVERSION is not set

#
# low-level hardware drivers
#

#
# Passive ISDN cards
#
CONFIG_ISDN_DRV_HISAX=m

#
#   D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
# CONFIG_HISAX_1TR6 is not set
# CONFIG_HISAX_NI1 is not set

#
#   HiSax supported cards
#
# CONFIG_HISAX_16_0 is not set
# CONFIG_HISAX_16_3 is not set
# CONFIG_HISAX_TELESPCI is not set
# CONFIG_HISAX_S0BOX is not set
CONFIG_HISAX_AVM_A1=y
# CONFIG_HISAX_FRITZPCI is not set
# CONFIG_HISAX_AVM_A1_PCMCIA is not set
# CONFIG_HISAX_ELSA is not set
# CONFIG_HISAX_IX1MICROR2 is not set
# CONFIG_HISAX_DIEHLDIVA is not set
# CONFIG_HISAX_ASUSCOM is not set
# CONFIG_HISAX_TELEINT is not set
# CONFIG_HISAX_HFCS is not set
# CONFIG_HISAX_SEDLBAUER is not set
# CONFIG_HISAX_SPORTSTER is not set
# CONFIG_HISAX_MIC is not set
# CONFIG_HISAX_NETJET is not set
# CONFIG_HISAX_NETJET_U is not set
# CONFIG_HISAX_NICCY is not set
# CONFIG_HISAX_ISURF is not set
# CONFIG_HISAX_HSTSAPHIR is not set
# CONFIG_HISAX_BKM_A4T is not set
# CONFIG_HISAX_SCT_QUADRO is not set
# CONFIG_HISAX_GAZEL is not set
# CONFIG_HISAX_HFC_PCI is not set
# CONFIG_HISAX_W6692 is not set

#
# Active ISDN cards
#
# CONFIG_ISDN_DRV_ICN is not set
# CONFIG_ISDN_DRV_PCBIT is not set
# CONFIG_ISDN_DRV_SC is not set
# CONFIG_ISDN_DRV_ACT2000 is not set
# CONFIG_ISDN_DRV_EICON is not set
# CONFIG_ISDN_CAPI is not set
# CONFIG_HYSDN is not set
# CONFIG_HYSDN_CAPI is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

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

#
# Joysticks
#
# CONFIG_JOYSTICK is not set

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SWAPFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
CONFIG_HPFS_FS=m
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
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
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
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y
==========================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
