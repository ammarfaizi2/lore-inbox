Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVFJRBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVFJRBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 13:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVFJRBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 13:01:51 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:61577 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S262309AbVFJRBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 13:01:01 -0400
Message-ID: <42A9C948.7010801@ru.mvista.com>
Date: Fri, 10 Jun 2005 21:09:28 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org, linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] ppc32: add Freescale MPC885ADS board support
Content-Type: multipart/mixed;
 boundary="------------010502080002020102080402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010502080002020102080402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds the Freescale MPC885ADS board to 2.6.12-rc6.
The supported devices are two SMC UARTs and 10Mbit ethernet on SCC3.

FEC is not supported as the "combined FCC/FEC ethernet driver" driver
by Pantelis Antoniou (first posted to this list on May 9; I'll
call it "fs_enet" for short) should replace the current FEC driver.

On MPC885ADS SCC ethernet PHY defaults to the full duplex mode
upon reset. SCC is set to half duplex by default. This inconsistency
is not handled by this patch for the following reasons:
- ethernet works anyway (the statistics should look terrible though)
- we are working on a patch to add SCC ehternet support to the fs_enet
   driver, and will revisit this full/half duplex issue when moving
   the board to the new ethernet driver and platform devices.

Signed-off-by: Yuri Shpilevsky <yshpilevsky@ru.mvista.com>
Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>


--------------010502080002020102080402
Content-Type: text/plain;
 name="mpc885ads.20050610.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpc885ads.20050610.diff"

diff -Nupr -x .git linux-2.5.base/arch/ppc/8xx_io/enet.c linux-2.5.cur/arch/ppc/8xx_io/enet.c
--- linux-2.5.base/arch/ppc/8xx_io/enet.c	2005-05-24 20:11:17.000000000 +0400
+++ linux-2.5.cur/arch/ppc/8xx_io/enet.c	2005-06-10 16:41:24.000000000 +0400
@@ -714,16 +714,24 @@ static int __init scc_enet_init(void)
 	immap->im_ioport.iop_pcdat &= ~PC_ENET_LBK;	/* Disable Loopback */
 #endif	/* PC_ENET_LBK */
 
-	/* Configure port C pins to enable CLSN and RENA.
+#ifdef PE_ENET_TCLK
+	/* Configure port E for TCLK and RCLK.
 	*/
-	immap->im_ioport.iop_pcpar &= ~(PC_ENET_CLSN | PC_ENET_RENA);
-	immap->im_ioport.iop_pcdir &= ~(PC_ENET_CLSN | PC_ENET_RENA);
-	immap->im_ioport.iop_pcso  |=  (PC_ENET_CLSN | PC_ENET_RENA);
-
+	cp->cp_pepar |=  (PE_ENET_TCLK | PE_ENET_RCLK);
+	cp->cp_pedir &= ~(PE_ENET_TCLK | PE_ENET_RCLK);
+	cp->cp_peso  &= ~(PE_ENET_TCLK | PE_ENET_RCLK);
+#else
 	/* Configure port A for TCLK and RCLK.
 	*/
 	immap->im_ioport.iop_papar |=  (PA_ENET_TCLK | PA_ENET_RCLK);
 	immap->im_ioport.iop_padir &= ~(PA_ENET_TCLK | PA_ENET_RCLK);
+#endif
+
+	/* Configure port C pins to enable CLSN and RENA.
+	*/
+	immap->im_ioport.iop_pcpar &= ~(PC_ENET_CLSN | PC_ENET_RENA);
+	immap->im_ioport.iop_pcdir &= ~(PC_ENET_CLSN | PC_ENET_RENA);
+	immap->im_ioport.iop_pcso  |=  (PC_ENET_CLSN | PC_ENET_RENA);
 
 	/* Configure Serial Interface clock routing.
 	 * First, clear all SCC bits to zero, then set the ones we want.
@@ -896,14 +904,18 @@ static int __init scc_enet_init(void)
 	/* It is now OK to enable the Ethernet transmitter.
 	 * Unfortunately, there are board implementation differences here.
 	 */
-#if   (!defined (PB_ENET_TENA) &&  defined (PC_ENET_TENA))
+#if   (!defined (PB_ENET_TENA) &&  defined (PC_ENET_TENA) && !defined (PE_ENET_TENA))
 	immap->im_ioport.iop_pcpar |=  PC_ENET_TENA;
 	immap->im_ioport.iop_pcdir &= ~PC_ENET_TENA;
-#elif ( defined (PB_ENET_TENA) && !defined (PC_ENET_TENA))
+#elif ( defined (PB_ENET_TENA) && !defined (PC_ENET_TENA) && !defined (PE_ENET_TENA))
 	cp->cp_pbpar |= PB_ENET_TENA;
 	cp->cp_pbdir |= PB_ENET_TENA;
+#elif ( !defined (PB_ENET_TENA) && !defined (PC_ENET_TENA) && defined (PE_ENET_TENA))
+	cp->cp_pepar |=  PE_ENET_TENA;
+	cp->cp_pedir &= ~PE_ENET_TENA;
+	cp->cp_peso  |=  PE_ENET_TENA;
 #else
-#error Configuration Error: define exactly ONE of PB_ENET_TENA, PC_ENET_TENA
+#error Configuration Error: define exactly ONE of PB_ENET_TENA, PC_ENET_TENA, PE_ENET_TENA
 #endif
 
 #if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
@@ -956,6 +968,19 @@ static int __init scc_enet_init(void)
 		return err;
 	}
 
+#ifdef CONFIG_MPC885ADS
+
+	/* Deassert PHY reset and enable the PHY.
+	 */
+	*((volatile uint *)BCSR4) |= BCSR4_ETH10_RST;
+	*((volatile uint *)BCSR1) |= BCSR1_ETHEN;
+
+	/* On MPC885ADS SCC ethernet PHY defaults to the full duplex mode
+	 * upon reset. SCC is set to half duplex by default. So this
+	 * inconsistency should be better fixed by the software.
+	 */
+#endif
+
 	/* And last, enable the transmit and receive processing.
 	*/
 	sccp->scc_gsmrl |= (SCC_GSMRL_ENR | SCC_GSMRL_ENT);
@@ -969,3 +994,4 @@ static int __init scc_enet_init(void)
 }
 
 module_init(scc_enet_init);
+
diff -Nupr -x .git linux-2.5.base/arch/ppc/configs/mpc885ads_defconfig linux-2.5.cur/arch/ppc/configs/mpc885ads_defconfig
--- linux-2.5.base/arch/ppc/configs/mpc885ads_defconfig	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.5.cur/arch/ppc/configs/mpc885ads_defconfig	2005-06-09 21:17:29.000000000 +0400
@@ -0,0 +1,622 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.12-rc6
+# Thu Jun  9 21:17:29 2005
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+# CONFIG_CLEAN_COMPILE is not set
+CONFIG_BROKEN=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+# CONFIG_EPOLL is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+# CONFIG_MODULES is not set
+
+#
+# Processor
+#
+# CONFIG_6xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+CONFIG_8xx=y
+# CONFIG_E500 is not set
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_EMBEDDEDBOOT=y
+# CONFIG_PM is not set
+CONFIG_NOT_COHERENT_CACHE=y
+
+#
+# Platform options
+#
+# CONFIG_RPXLITE is not set
+# CONFIG_RPXCLASSIC is not set
+# CONFIG_BSEIP is not set
+# CONFIG_FADS is not set
+CONFIG_MPC885ADS=y
+# CONFIG_TQM823L is not set
+# CONFIG_TQM850L is not set
+# CONFIG_TQM855L is not set
+# CONFIG_TQM860L is not set
+# CONFIG_FPS850L is not set
+# CONFIG_SPD823TS is not set
+# CONFIG_IVMS8 is not set
+# CONFIG_IVML24 is not set
+# CONFIG_SM850 is not set
+# CONFIG_HERMES_PRO is not set
+# CONFIG_IP860 is not set
+# CONFIG_LWMON is not set
+# CONFIG_PCU_E is not set
+# CONFIG_CCM is not set
+# CONFIG_LANTEC is not set
+# CONFIG_MBX is not set
+# CONFIG_WINCEPT is not set
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_CMDLINE_BOOL is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+# CONFIG_PCI_QSPAN is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_CONSISTENT_START=0xff100000
+CONFIG_CONSISTENT_SIZE=0x00200000
+CONFIG_BOOT_LOAD=0x00400000
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+
+#
+# Macintosh device drivers
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_OAKNET is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
+
+#
+# Token Ring devices
+#
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+CONFIG_PPP=y
+# CONFIG_PPP_MULTILINK is not set
+# CONFIG_PPP_FILTER is not set
+CONFIG_PPP_ASYNC=y
+CONFIG_PPP_SYNC_TTY=y
+CONFIG_PPP_DEFLATE=y
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPPOE is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+# CONFIG_INPUT is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_CPM=y
+CONFIG_SERIAL_CPM_CONSOLE=y
+# CONFIG_SERIAL_CPM_SCC1 is not set
+# CONFIG_SERIAL_CPM_SCC2 is not set
+# CONFIG_SERIAL_CPM_SCC3 is not set
+# CONFIG_SERIAL_CPM_SCC4 is not set
+CONFIG_SERIAL_CPM_SMC1=y
+CONFIG_SERIAL_CPM_SMC2=y
+CONFIG_UNIX98_PTYS=y
+# CONFIG_LEGACY_PTYS is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+# CONFIG_EXT2_FS_POSIX_ACL is not set
+# CONFIG_EXT2_FS_SECURITY is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_PROC_KCORE is not set
+CONFIG_SYSFS=y
+# CONFIG_DEVFS_FS is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
+# CONFIG_TMPFS is not set
+# CONFIG_HUGETLBFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# MPC8xx CPM Options
+#
+CONFIG_SCC_ENET=y
+# CONFIG_SCC1_ENET is not set
+# CONFIG_SCC2_ENET is not set
+CONFIG_SCC3_ENET=y
+# CONFIG_FEC_ENET is not set
+# CONFIG_ENET_BIG_BUFFERS is not set
+
+#
+# Generic MPC8xx Options
+#
+CONFIG_8xx_COPYBACK=y
+CONFIG_8xx_CPU6=y
+CONFIG_NO_UCODE_PATCH=y
+# CONFIG_USB_SOF_UCODE_PATCH is not set
+# CONFIG_I2C_SPI_UCODE_PATCH is not set
+# CONFIG_I2C_SPI_SMC1_UCODE_PATCH is not set
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=y
+# CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
diff -Nupr -x .git linux-2.5.base/arch/ppc/Kconfig linux-2.5.cur/arch/ppc/Kconfig
--- linux-2.5.base/arch/ppc/Kconfig	2005-06-03 14:11:55.000000000 +0400
+++ linux-2.5.cur/arch/ppc/Kconfig	2005-06-09 16:50:09.000000000 +0400
@@ -379,6 +379,14 @@ config BSEIP
 config FADS
 	bool "FADS"
 
+config MPC885ADS
+	bool "MPC885ADS"
+	help
+	  Freescale Semiconductor MPC885 Application Development System (ADS).
+	  Also known as DUET.
+	  The MPC885ADS is meant to serve as a platform for s/w and h/w
+	  development around the MPC885 processor family.
+
 config TQM823L
 	bool "TQM823L"
 	help
diff -Nupr -x .git linux-2.5.base/arch/ppc/platforms/mpc885ads.h linux-2.5.cur/arch/ppc/platforms/mpc885ads.h
--- linux-2.5.base/arch/ppc/platforms/mpc885ads.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.5.cur/arch/ppc/platforms/mpc885ads.h	2005-06-10 16:46:03.000000000 +0400
@@ -0,0 +1,92 @@
+/*
+ * A collection of structures, addresses, and values associated with
+ * the Freescale MPC885ADS board.
+ * Copied from the FADS stuff.
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2005 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+ 
+#ifdef __KERNEL__
+#ifndef __ASM_MPC885ADS_H__
+#define __ASM_MPC885ADS_H__
+
+#include <linux/config.h>
+
+#include <asm/ppcboot.h>
+
+/* U-Boot maps BCSR to 0xff080000 */
+#define BCSR_ADDR		((uint)0xff080000)
+#define BCSR_SIZE		((uint)(64 * 1024))
+#define BCSR0			((uint)(BCSR_ADDR + 0x00))
+#define BCSR1			((uint)(BCSR_ADDR + 0x04))
+#define BCSR2			((uint)(BCSR_ADDR + 0x08))
+#define BCSR3			((uint)(BCSR_ADDR + 0x0c))
+#define BCSR4			((uint)(BCSR_ADDR + 0x10))
+
+#define CFG_PHYDEV_ADDR		((uint)0xff0a0000)
+#define BCSR5			((uint)(CFG_PHYDEV_ADDR + 0x300))
+
+#define IMAP_ADDR		((uint)0xff000000)
+#define IMAP_SIZE		((uint)(64 * 1024))
+
+#define PCMCIA_MEM_ADDR		((uint)0xff020000)
+#define PCMCIA_MEM_SIZE		((uint)(64 * 1024))
+
+/* Bits of interest in the BCSRs.
+ */
+#define BCSR1_ETHEN		((uint)0x20000000)
+#define BCSR1_IRDAEN		((uint)0x10000000)
+#define BCSR1_RS232EN_1		((uint)0x01000000)
+#define BCSR1_PCCEN		((uint)0x00800000)
+#define BCSR1_PCCVCC0		((uint)0x00400000)
+#define BCSR1_PCCVPP0		((uint)0x00200000)
+#define BCSR1_PCCVPP1		((uint)0x00100000)
+#define BCSR1_PCCVPP_MASK	(BCSR1_PCCVPP0 | BCSR1_PCCVPP1)
+#define BCSR1_RS232EN_2		((uint)0x00040000)
+#define BCSR1_PCCVCC1		((uint)0x00010000)
+#define BCSR1_PCCVCC_MASK	(BCSR1_PCCVCC0 | BCSR1_PCCVCC1)
+
+#define BCSR4_ETH10_RST		((uint)0x80000000)	/* 10Base-T PHY reset*/
+#define BCSR4_USB_LO_SPD	((uint)0x04000000)
+#define BCSR4_USB_VCC		((uint)0x02000000)
+#define BCSR4_USB_FULL_SPD	((uint)0x00040000)
+#define BCSR4_USB_EN		((uint)0x00020000)
+
+#define BCSR5_MII2_EN		0x40
+#define BCSR5_MII2_RST		0x20
+#define BCSR5_T1_RST		0x10
+#define BCSR5_ATM155_RST	0x08
+#define BCSR5_ATM25_RST		0x04
+#define BCSR5_MII1_EN		0x02
+#define BCSR5_MII1_RST		0x01
+
+/* Interrupt level assignments */
+#define PHY_INTERRUPT	SIU_IRQ7	/* PHY link change interrupt */
+#define SIU_INT_FEC1	SIU_LEVEL1	/* FEC1 interrupt */
+#define SIU_INT_FEC2	SIU_LEVEL3	/* FEC2 interrupt */
+#define FEC_INTERRUPT	SIU_INT_FEC1	/* FEC interrupt */
+
+/* We don't use the 8259 */
+#define NR_8259_INTS	0
+
+/* CPM Ethernet through SCC3 */
+#define PA_ENET_RXD	((ushort)0x0040)
+#define PA_ENET_TXD	((ushort)0x0080)
+#define PE_ENET_TCLK	((uint)0x00004000)
+#define PE_ENET_RCLK	((uint)0x00008000)
+#define PE_ENET_TENA	((uint)0x00000010)
+#define PC_ENET_CLSN	((ushort)0x0400)
+#define PC_ENET_RENA	((ushort)0x0800)
+                                                                                                                                                             
+/* Control bits in the SICR to route TCLK (CLK5) and RCLK (CLK6) to
+ * SCC3.  Also, make sure GR3 (bit 8) and SC3 (bit 9) are zero */
+#define SICR_ENET_MASK	((uint)0x00ff0000)
+#define SICR_ENET_CLKRT	((uint)0x002c0000)
+
+#endif /* __ASM_MPC885ADS_H__ */
+#endif /* __KERNEL__ */
diff -Nupr -x .git linux-2.5.base/arch/ppc/syslib/m8xx_setup.c linux-2.5.cur/arch/ppc/syslib/m8xx_setup.c
--- linux-2.5.base/arch/ppc/syslib/m8xx_setup.c	2005-05-24 20:11:22.000000000 +0400
+++ linux-2.5.cur/arch/ppc/syslib/m8xx_setup.c	2005-06-09 16:55:33.000000000 +0400
@@ -369,7 +369,7 @@ m8xx_map_io(void)
 #if defined(CONFIG_HTDMSOUND) || defined(CONFIG_RPXTOUCH) || defined(CONFIG_FB_RPX)
 	io_block_mapping(HIOX_CSR_ADDR, HIOX_CSR_ADDR, HIOX_CSR_SIZE, _PAGE_IO);
 #endif
-#ifdef CONFIG_FADS
+#if defined(CONFIG_FADS) || defined(CONFIG_MPC885ADS)
 	io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);
 #endif
 #ifdef CONFIG_PCI
diff -Nupr -x .git linux-2.5.base/drivers/serial/cpm_uart/cpm_uart_cpm1.c linux-2.5.cur/drivers/serial/cpm_uart/cpm_uart_cpm1.c
--- linux-2.5.base/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2005-05-24 20:12:06.000000000 +0400
+++ linux-2.5.cur/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2005-06-09 16:50:34.000000000 +0400
@@ -94,12 +94,28 @@ void smc1_lineif(struct uart_cpm_port *p
 		((immap_t *)IMAP_ADDR)->im_ioport.iop_paodr &= ~iobits;
 	}
 
+#ifdef CONFIG_MPC885ADS
+	/* Enable SMC1 transceivers */
+	*((volatile uint *)BCSR1) &= ~BCSR1_RS232EN_1;
+#endif
+
 	pinfo->brg = 1;
 }
 
 void smc2_lineif(struct uart_cpm_port *pinfo)
 {
-	/* XXX SMC2: insert port configuration here */
+#ifdef CONFIG_MPC885ADS
+	volatile cpm8xx_t *cp = cpmp;
+
+	cp->cp_pepar |= 0x00000c00;
+	cp->cp_pedir &= 0x00000c00;
+	cp->cp_peso &= ~0x00000400;
+	cp->cp_peso |= 0x00000800;
+
+	/* Enable SMC2 transceivers */
+	*((volatile uint *)BCSR1) &= ~BCSR1_RS232EN_2;
+#endif
+
 	pinfo->brg = 2;
 }
 
diff -Nupr -x .git linux-2.5.base/include/asm-ppc/mpc8xx.h linux-2.5.cur/include/asm-ppc/mpc8xx.h
--- linux-2.5.base/include/asm-ppc/mpc8xx.h	2005-05-24 20:12:29.000000000 +0400
+++ linux-2.5.cur/include/asm-ppc/mpc8xx.h	2005-06-09 16:54:16.000000000 +0400
@@ -68,6 +68,10 @@
 #include <platforms/lantec.h>
 #endif
 
+#if defined(CONFIG_MPC885ADS)
+#include <platforms/mpc885ads.h>
+#endif
+
 /* Currently, all 8xx boards that support a processor to PCI/ISA bridge
  * use the same memory map.
  */

--------------010502080002020102080402--

