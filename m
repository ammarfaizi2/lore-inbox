Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVCDIN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVCDIN0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 03:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVCDIN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 03:13:26 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:28865 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262622AbVCDIGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 03:06:00 -0500
Date: Fri, 4 Mar 2005 02:05:43 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: akpm@osdl.org
cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: PowerQUICC II Pro subarch support
Message-ID: <Pine.LNX.4.61.0503040158290.16127@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Patch adds support for the initial PowerQUICC II Pro processors 
(MPC8343/E, MPC8347/E, and MPC8349/E) and the first reference platform 
(MPC834x SYS) from Freescale.

The initial support is limited to existing drivers that overlap with the 
MPC85xx subarch (ethernet, I2C, uart).

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	2005-03-02 14:20:27 -06:00
+++ b/CREDITS	2005-03-02 14:20:27 -06:00
@@ -1095,7 +1095,7 @@
 
 N: Kumar Gala
 E: kumar.gala@freescale.com
-D: Embedded PowerPC 6xx/7xx/74xx/82xx/85xx support
+D: Embedded PowerPC 6xx/7xx/74xx/82xx/83xx/85xx support
 S: Austin, Texas 78729
 S: USA
 
diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2005-03-02 14:20:27 -06:00
+++ b/MAINTAINERS	2005-03-02 14:20:27 -06:00
@@ -1372,7 +1372,7 @@
 L:	linuxppc-embedded@ozlabs.org
 S:	Maintained
 
-LINUX FOR POWERPC EMBEDDED PPC85XX
+LINUX FOR POWERPC EMBEDDED PPC83XX AND PPC85XX
 P:     Kumar Gala
 M:     kumar.gala@freescale.com
 W:     http://www.penguinppc.org/
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2005-03-02 14:20:27 -06:00
+++ b/arch/ppc/Kconfig	2005-03-02 14:20:27 -06:00
@@ -52,17 +52,17 @@
 	default 6xx
 
 config 6xx
-	bool "6xx/7xx/74xx/52xx/8260"
+	bool "6xx/7xx/74xx/52xx/82xx/83xx"
 	help
 	  There are four types of PowerPC chips supported.  The more common
 	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
-	  versions (821, 823, 850, 855, 860, 52xx, 8260), the IBM embedded
+	  versions (821, 823, 850, 855, 860, 52xx, 82xx, 83xx), the IBM embedded
 	  versions (403 and 405) and the high end 64 bit Power processors
 	  (POWER 3, POWER4, and IBM 970 also known as G5)
 	  Unless you are building a kernel for one of the embedded processor
 	  systems, 64 bit IBM RS/6000 or an Apple G5, choose 6xx.
 	  Note that the kernel runs in 32-bit mode even on 64-bit chips.
-	  Also note that because the 52xx & 82xx family has a 603e core,
+	  Also note that because the 52xx, 82xx, & 83xx family has a 603e core,
 	  specific support for that chipset is asked later on.
 
 config 40x
@@ -109,7 +109,7 @@
 config ALTIVEC
 	bool "AltiVec Support"
 	depends on 6xx || POWER4
-	depends on !8260
+	depends on !8260 && !83xx
 	---help---
 	  This option enables kernel support for the Altivec extensions to the
 	  PowerPC processor. The kernel currently supports saving and restoring
@@ -140,7 +140,7 @@
 
 config TAU
 	bool "Thermal Management Support"
-	depends on 6xx && !8260
+	depends on 6xx && !8260 && !83xx
 	help
 	  G3 and G4 processors have an on-chip temperature sensor called the
 	  'Thermal Assist Unit (TAU)', which, in theory, can measure the on-die
@@ -228,6 +228,7 @@
 	  If in doubt, say Y here.
 
 source arch/ppc/platforms/4xx/Kconfig
+source arch/ppc/platforms/83xx/Kconfig
 source arch/ppc/platforms/85xx/Kconfig
 
 config PPC64BRIDGE
@@ -475,7 +476,7 @@
 
 choice
 	prompt "Machine Type"
-	depends on 6xx || POWER3 || POWER4
+	depends on (6xx && !83xx) || POWER3 || POWER4
 	default PPC_MULTIPLATFORM
 	---help---
 	  Linux currently supports several different kinds of PowerPC-based
@@ -660,7 +661,7 @@
 
 config 8260
 	bool "CPM2 Support" if WILLOW
-	depends on 6xx
+	depends on 6xx && !83xx
 	default y if TQM8260 || RPX8260 || EST8260 || SBS8260 || SBC82xx || PQ2FADS
 	help
 	  The MPC8260 is a typical embedded CPU made by Motorola.  Selecting
@@ -1079,8 +1080,8 @@
 	bool
 
 config PCI
-	bool "PCI support" if 40x || CPM2 || 85xx
-	default y if !40x && !CPM2 && !8xx && !APUS && !85xx
+	bool "PCI support" if 40x || CPM2 || 83xx || 85xx
+	default y if !40x && !CPM2 && !8xx && !APUS && !83xx && !85xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
 	help
diff -Nru a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile	2005-03-02 14:20:27 -06:00
+++ b/arch/ppc/Makefile	2005-03-02 14:20:27 -06:00
@@ -57,6 +57,7 @@
 core-y				+= arch/ppc/kernel/ arch/ppc/platforms/ \
 				   arch/ppc/mm/ arch/ppc/lib/ arch/ppc/syslib/
 core-$(CONFIG_4xx)		+= arch/ppc/platforms/4xx/
+core-$(CONFIG_83xx)		+= arch/ppc/platforms/83xx/
 core-$(CONFIG_85xx)		+= arch/ppc/platforms/85xx/
 core-$(CONFIG_MATH_EMULATION)	+= arch/ppc/math-emu/
 core-$(CONFIG_XMON)		+= arch/ppc/xmon/
diff -Nru a/arch/ppc/configs/mpc834x_sys_defconfig b/arch/ppc/configs/mpc834x_sys_defconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/configs/mpc834x_sys_defconfig	2005-03-02 14:20:27 -06:00
@@ -0,0 +1,644 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.11-rc4
+# Thu Feb 17 16:12:23 2005
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_FUTEX=y
+# CONFIG_EPOLL is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+
+#
+# Loadable module support
+#
+# CONFIG_MODULES is not set
+
+#
+# Processor
+#
+CONFIG_6xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+# CONFIG_E500 is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_PPC_GEN550=y
+CONFIG_83xx=y
+
+#
+# Freescale 83xx options
+#
+CONFIG_MPC834x_SYS=y
+CONFIG_MPC834x=y
+CONFIG_PPC_STD_MMU=y
+
+#
+# Platform options
+#
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_CMDLINE_BOOL is not set
+
+#
+# Bus options
+#
+CONFIG_GENERIC_ISA_DMA=y
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PC-card bridges
+#
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
+CONFIG_BOOT_LOAD=0x00800000
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
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=32768
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
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
+# CONFIG_NETLINK_DEV is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
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
+
+#
+# Ethernet (1000 Mbit)
+#
+CONFIG_GIANFAR=y
+# CONFIG_GFAR_NAPI is not set
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
+# CONFIG_PPP is not set
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
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_SERIO is not set
+# CONFIG_SERIO_I8042 is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
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
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
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
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
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
+# I2C support
+#
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ISA is not set
+CONFIG_I2C_MPC=y
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PCA_ISA is not set
+
+#
+# Hardware Sensors Chip support
+#
+# CONFIG_I2C_SENSOR is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83627HF is not set
+
+#
+# Other I2C Chip support
+#
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
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
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
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
+# CONFIG_EXT2_FS_XATTR is not set
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
+CONFIG_DNOTIFY=y
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
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+# CONFIG_DEVFS_FS is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
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
+# CONFIG_MSDOS_PARTITION is not set
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
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SERIAL_TEXT_DEBUG is not set
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
diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	2005-03-02 14:20:27 -06:00
+++ b/arch/ppc/kernel/cputable.c	2005-03-02 14:20:27 -06:00
@@ -560,6 +560,18 @@
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603
 	},
+	{	/* e300 (a 603e core, plus some) on 83xx */
+		.pvr_mask		= 0x7fff0000,
+		.pvr_value		= 0x00830000,
+		.cpu_name		= "e300",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
+			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_603
+	},
 	{	/* default match, we assume split I/D cache & TB (non-601)... */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
diff -Nru a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c	2005-03-02 14:20:27 -06:00
+++ b/arch/ppc/kernel/ppc_ksyms.c	2005-03-02 14:20:27 -06:00
@@ -319,7 +319,8 @@
 EXPORT_SYMBOL(cpm_install_handler);
 EXPORT_SYMBOL(cpm_free_handler);
 #endif /* CONFIG_8xx */
-#if defined(CONFIG_8xx) || defined(CONFIG_40x) || defined(CONFIG_85xx)
+#if defined(CONFIG_8xx) || defined(CONFIG_40x) || defined(CONFIG_85xx) ||\
+	defined(CONFIG_83xx)
 EXPORT_SYMBOL(__res);
 #endif
 
diff -Nru a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c	2005-03-02 14:20:27 -06:00
+++ b/arch/ppc/kernel/setup.c	2005-03-02 14:20:27 -06:00
@@ -227,6 +227,10 @@
 		maj = ((pvr >> 8) & 0xFF) - 1;
 		min = pvr & 0xFF;
 		break;
+	case 0x8083:	/* e300 */
+		maj = PVR_MAJ(pvr);
+		min = PVR_MIN(pvr);
+		break;
 	case 0x8020:	/* e500 */
 		maj = PVR_MAJ(pvr);
 		min = PVR_MIN(pvr);
diff -Nru a/arch/ppc/platforms/83xx/Kconfig b/arch/ppc/platforms/83xx/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/83xx/Kconfig	2005-03-02 14:20:27 -06:00
@@ -0,0 +1,30 @@
+config 83xx
+	bool "PowerQUICC II Pro (83xx) Support"
+	depends on 6xx
+
+menu "Freescale 83xx options"
+	depends on 83xx
+
+choice
+	prompt "Machine Type"
+	depends on 83xx
+	default MPC834x_SYS
+
+config MPC834x_SYS
+	bool "Freescale MPC834x SYS"
+	help
+	  This option enables support for the MPC 834x SYS evaluation board.
+
+endchoice
+
+config MPC834x
+	bool
+	depends on MPC834x_SYS
+	default y
+
+config PPC_GEN550
+	bool
+	depends on 83xx
+	default y
+
+endmenu
diff -Nru a/arch/ppc/platforms/83xx/Makefile b/arch/ppc/platforms/83xx/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/83xx/Makefile	2005-03-02 14:20:27 -06:00
@@ -0,0 +1,6 @@
+#
+# Makefile for the PowerPC 83xx linux kernel.
+#
+obj-$(CONFIG_83xx)		+= mpc83xx_sys.o mpc83xx_devices.o
+
+obj-$(CONFIG_MPC834x_SYS)	+= mpc834x_sys.o
diff -Nru a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c	2005-03-02 14:20:27 -06:00
@@ -0,0 +1,290 @@
+/*
+ * arch/ppc/platforms/83xx/mpc834x_sys.c
+ *
+ * MPC834x SYS board specific routines
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/serial.h>
+#include <linux/tty.h>	/* for linux/serial_core.h */
+#include <linux/serial_core.h>
+#include <linux/initrd.h>
+#include <linux/module.h>
+#include <linux/fsl_devices.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/atomic.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/ipic.h>
+#include <asm/bootinfo.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpc83xx.h>
+#include <asm/irq.h>
+#include <asm/kgdb.h>
+#include <asm/ppc_sys.h>
+#include <mm/mmu_decl.h>
+
+#include <syslib/ppc83xx_setup.h>
+
+#ifndef CONFIG_PCI
+unsigned long isa_io_base = 0;
+unsigned long isa_mem_base = 0;
+#endif
+
+extern unsigned long total_memory;	/* in mm/init */
+
+unsigned char __res[sizeof (bd_t)];
+
+#ifdef CONFIG_PCI
+#error "PCI is not supported"
+/* NEED mpc83xx_map_irq & mpc83xx_exclude_device
+   see platforms/85xx/mpc85xx_ads_common.c */
+#endif /* CONFIG_PCI */
+
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+static void __init
+mpc834x_sys_setup_arch(void)
+{
+	bd_t *binfo = (bd_t *) __res;
+	unsigned int freq;
+	struct gianfar_platform_data *pdata;
+
+	/* get the core frequency */
+	freq = binfo->bi_intfreq;
+
+	/* Set loops_per_jiffy to a half-way reasonable value,
+	   for use until calibrate_delay gets called. */
+	loops_per_jiffy = freq / HZ;
+
+#ifdef CONFIG_PCI
+	/* setup PCI host bridges */
+	mpc83xx_sys_setup_hose();
+#endif
+	mpc83xx_early_serial_map();
+
+	/* setup the board related information for the enet controllers */
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC83xx_TSEC1);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC83xx_IRQ_EXT1;
+	pdata->phyid = 0;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC83xx_TSEC2);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC83xx_IRQ_EXT2;
+	pdata->phyid = 1;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef  CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+}
+
+static void __init
+mpc834x_sys_map_io(void)
+{
+	/* we steal the lowest ioremap addr for virt space */
+	io_block_mapping(VIRT_IMMRBAR, immrbar, 1024*1024, _PAGE_IO);
+	io_block_mapping(BCSR_VIRT_ADDR, BCSR_PHYS_ADDR, BCSR_SIZE, _PAGE_IO);
+}
+
+int
+mpc834x_sys_show_cpuinfo(struct seq_file *m)
+{
+	uint pvid, svid, phid1;
+	bd_t *binfo = (bd_t *) __res;
+	unsigned int freq;
+
+	/* get the core frequency */
+	freq = binfo->bi_intfreq;
+
+	pvid = mfspr(PVR);
+	svid = mfspr(SVR);
+
+	seq_printf(m, "chip\t\t: MPC%s\n", cur_ppc_sys_spec->ppc_sys_name);
+	seq_printf(m, "Vendor\t\t: Freescale Inc.\n");
+	seq_printf(m, "Machine\t\t: mpc%s sys\n", cur_ppc_sys_spec->ppc_sys_name);
+	seq_printf(m, "core clock\t: %d MHz\n"
+			"bus  clock\t: %d MHz\n",
+			(int)(binfo->bi_intfreq / 1000000),
+			(int)(binfo->bi_busfreq / 1000000));
+	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+
+	/* Display cpu Pll setting */
+	phid1 = mfspr(HID1);
+	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+
+	/* Display the amount of memory */
+	seq_printf(m, "Memory\t\t: %d MB\n", (int)(binfo->bi_memsize / (1024 * 1024)));
+
+	return 0;
+}
+
+
+void __init
+mpc834x_sys_init_IRQ(void)
+{
+	bd_t *binfo = (bd_t *) __res;
+
+	u8 senses[8] = {
+		0,			/* EXT 0 */
+		IRQ_SENSE_LEVEL,	/* EXT 1 */
+		IRQ_SENSE_LEVEL,	/* EXT 2 */
+		0,			/* EXT 3 */
+		0,			/* EXT 4 */
+		0,			/* EXT 5 */
+		0,			/* EXT 6 */
+		0,			/* EXT 7 */
+	};
+
+	ipic_init(binfo->bi_immr_base + 0x00700, 0, MPC83xx_IPIC_IRQ_OFFSET, senses, 8);
+
+	/* Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	ipic_set_default_priority();
+}
+
+static __inline__ void
+mpc834x_sys_set_bat(void)
+{
+	/* we steal the lowest ioremap addr for virt space */
+	mb();
+	mtspr(DBAT1U, VIRT_IMMRBAR | 0x1e);
+	mtspr(DBAT1L, immrbar | 0x2a);
+	mb();
+}
+
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	      unsigned long r6, unsigned long r7)
+{
+	bd_t *binfo = (bd_t *) __res;
+
+	/* parse_bootinfo must always be called first */
+	parse_bootinfo(find_bootinfo());
+
+	/*
+	 * If we were passed in a board information, copy it into the
+	 * residual data area.
+	 */
+	if (r3) {
+		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
+		       sizeof (bd_t));
+	}
+
+#if defined(CONFIG_BLK_DEV_INITRD)
+	/*
+	 * If the init RAM disk has been configured in, and there's a valid
+	 * starting address for it, set it up.
+	 */
+	if (r4) {
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
+	/* Copy the kernel command line arguments to a safe place. */
+	if (r6) {
+		*(char *) (r7 + KERNELBASE) = 0;
+		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
+	}
+
+	immrbar = binfo->bi_immr_base;
+
+	mpc834x_sys_set_bat();
+
+#if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
+	{
+		struct uart_port p;
+
+		memset(&p, 0, sizeof (p));
+		p.iotype = SERIAL_IO_MEM;
+		p.membase = (unsigned char __iomem *)immrbar + 0x4500;
+		p.uartclk = binfo->bi_busfreq;
+
+		gen550_init(0, &p);
+
+		memset(&p, 0, sizeof (p));
+		p.iotype = SERIAL_IO_MEM;
+		p.membase = (unsigned char __iomem *)immrbar + 0x4500;
+		p.uartclk = binfo->bi_busfreq;
+
+		gen550_init(1, &p);
+	}
+#endif
+
+	identify_ppc_sys_by_id(mfspr(SVR));
+
+	/* setup the PowerPC module struct */
+	ppc_md.setup_arch = mpc834x_sys_setup_arch;
+	ppc_md.show_cpuinfo = mpc834x_sys_show_cpuinfo;
+
+	ppc_md.init_IRQ = mpc834x_sys_init_IRQ;
+	ppc_md.get_irq = ipic_get_irq;
+
+	ppc_md.restart = mpc83xx_restart;
+	ppc_md.power_off = mpc83xx_power_off;
+	ppc_md.halt = mpc83xx_halt;
+
+	ppc_md.find_end_of_memory = mpc83xx_find_end_of_memory;
+	ppc_md.setup_io_mappings  = mpc834x_sys_map_io;
+
+	ppc_md.time_init = mpc83xx_time_init;
+	ppc_md.set_rtc_time = NULL;
+	ppc_md.get_rtc_time = NULL;
+	ppc_md.calibrate_decr = mpc83xx_calibrate_decr;
+
+	ppc_md.early_serial_map = mpc83xx_early_serial_map;
+#if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
+	ppc_md.progress = gen550_progress;
+#endif	/* CONFIG_SERIAL_8250 && CONFIG_SERIAL_TEXT_DEBUG */
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc834x_sys_init(): exit", 0);
+
+	return;
+}
diff -Nru a/arch/ppc/platforms/83xx/mpc834x_sys.h b/arch/ppc/platforms/83xx/mpc834x_sys.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.h	2005-03-02 14:20:27 -06:00
@@ -0,0 +1,51 @@
+/*
+ * arch/ppc/platforms/83xx/mpc834x_sys.h
+ *
+ * MPC834X SYS common board definitions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef __MACH_MPC83XX_SYS_H__
+#define __MACH_MPC83XX_SYS_H__
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/seq_file.h>
+#include <syslib/ppc83xx_setup.h>
+#include <asm/ppcboot.h>
+
+#define VIRT_IMMRBAR		((uint)0xfe000000)
+
+#define BCSR_PHYS_ADDR		((uint)0xf8000000)
+#define BCSR_VIRT_ADDR		((uint)0xfe100000)
+#define BCSR_SIZE		((uint)(32 * 1024))
+
+#ifdef CONFIG_PCI
+/* PCI interrupt controller */
+#define PIRQA        MPC83xx_IRQ_IRQ4
+#define PIRQB        MPC83xx_IRQ_IRQ5
+#define PIRQC        MPC83xx_IRQ_IRQ6
+#define PIRQD        MPC83xx_IRQ_IRQ7
+
+#define MPC834x_SYS_PCI1_LOWER_IO        0x00000000
+#define MPC834x_SYS_PCI1_UPPER_IO        0x00ffffff
+
+#define MPC834x_SYS_PCI1_LOWER_MEM       0x80000000
+#define MPC834x_SYS_PCI1_UPPER_MEM       0x9fffffff
+
+#define MPC834x_SYS_PCI1_IO_BASE         0xe2000000
+#define MPC834x_SYS_PCI1_MEM_OFFSET      0x00000000
+
+#define MPC834x_SYS_PCI1_IO_SIZE         0x01000000
+#endif /* CONFIG_PCI */
+
+#endif                /* __MACH_MPC83XX_SYS_H__ */
diff -Nru a/arch/ppc/platforms/83xx/mpc83xx_devices.c b/arch/ppc/platforms/83xx/mpc83xx_devices.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/83xx/mpc83xx_devices.c	2005-03-02 14:20:27 -06:00
@@ -0,0 +1,237 @@
+/*
+ * arch/ppc/platforms/83xx/mpc83xx_devices.c
+ *
+ * MPC83xx Device descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/serial_8250.h>
+#include <linux/fsl_devices.h>
+#include <asm/mpc83xx.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+
+/* We use offsets for IORESOURCE_MEM since we do not know at compile time
+ * what IMMRBAR is, will get fixed up by mach_mpc83xx_fixup
+ */
+
+static struct gianfar_platform_data mpc83xx_tsec1_pdata = {
+	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
+	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
+	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
+	.phy_reg_addr = 0x24000,
+};
+
+static struct gianfar_platform_data mpc83xx_tsec2_pdata = {
+	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
+	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
+	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
+	.phy_reg_addr = 0x24000,
+};
+
+static struct fsl_i2c_platform_data mpc83xx_fsl_i2c1_pdata = {
+	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
+};
+
+static struct fsl_i2c_platform_data mpc83xx_fsl_i2c2_pdata = {
+	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
+};
+
+static struct plat_serial8250_port serial_platform_data[] = {
+	[0] = {
+		.mapbase	= 0x4500,
+		.irq		= MPC83xx_IRQ_UART1,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+	},
+	[1] = {
+		.mapbase	= 0x4600,
+		.irq		= MPC83xx_IRQ_UART2,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+	},
+};
+
+struct platform_device ppc_sys_platform_devices[] = {
+	[MPC83xx_TSEC1] = {
+		.name = "fsl-gianfar",
+		.id	= 1,
+		.dev.platform_data = &mpc83xx_tsec1_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x24000,
+				.end	= 0x24fff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC83xx_IRQ_TSEC1_TX,
+				.end	= MPC83xx_IRQ_TSEC1_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC83xx_IRQ_TSEC1_RX,
+				.end	= MPC83xx_IRQ_TSEC1_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC83xx_IRQ_TSEC1_ERROR,
+				.end	= MPC83xx_IRQ_TSEC1_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC83xx_TSEC2] = {
+		.name = "fsl-gianfar",
+		.id	= 2,
+		.dev.platform_data = &mpc83xx_tsec2_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x25000,
+				.end	= 0x25fff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC83xx_IRQ_TSEC2_TX,
+				.end	= MPC83xx_IRQ_TSEC2_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC83xx_IRQ_TSEC2_RX,
+				.end	= MPC83xx_IRQ_TSEC2_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC83xx_IRQ_TSEC2_ERROR,
+				.end	= MPC83xx_IRQ_TSEC2_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC83xx_IIC1] = {
+		.name = "fsl-i2c",
+		.id	= 1,
+		.dev.platform_data = &mpc83xx_fsl_i2c1_pdata,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x3000,
+				.end	= 0x30ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC83xx_IRQ_IIC1,
+				.end	= MPC83xx_IRQ_IIC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC83xx_IIC2] = {
+		.name = "fsl-i2c",
+		.id	= 2,
+		.dev.platform_data = &mpc83xx_fsl_i2c2_pdata,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x3100,
+				.end	= 0x31ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC83xx_IRQ_IIC2,
+				.end	= MPC83xx_IRQ_IIC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC83xx_DUART] = {
+		.name = "serial8250",
+		.id	= 0,
+		.dev.platform_data = serial_platform_data,
+	},
+	[MPC83xx_SEC2] = {
+		.name = "fsl-sec2",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x30000,
+				.end	= 0x3ffff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC83xx_IRQ_SEC2,
+				.end	= MPC83xx_IRQ_SEC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC83xx_USB2_DR] = {
+		.name = "fsl-usb2-dr",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x22000,
+				.end	= 0x22fff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC83xx_IRQ_USB2_DR,
+				.end	= MPC83xx_IRQ_USB2_DR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC83xx_USB2_MPH] = {
+		.name = "fsl-usb2-mph",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x23000,
+				.end	= 0x23fff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC83xx_IRQ_USB2_MPH,
+				.end	= MPC83xx_IRQ_USB2_MPH,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+};
+
+static int __init mach_mpc83xx_fixup(struct platform_device *pdev)
+{
+	ppc_sys_fixup_mem_resource(pdev, immrbar);
+	return 0;
+}
+
+static int __init mach_mpc83xx_init(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("mach_mpc83xx_init:enter", 0);
+	ppc_sys_device_fixup = mach_mpc83xx_fixup;
+	return 0;
+}
+
+postcore_initcall(mach_mpc83xx_init);
diff -Nru a/arch/ppc/platforms/83xx/mpc83xx_sys.c b/arch/ppc/platforms/83xx/mpc83xx_sys.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/83xx/mpc83xx_sys.c	2005-03-02 14:20:27 -06:00
@@ -0,0 +1,100 @@
+/*
+ * arch/ppc/platforms/83xx/mpc83xx_sys.c
+ *
+ * MPC83xx System descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <asm/ppc_sys.h>
+
+struct ppc_sys_spec *cur_ppc_sys_spec;
+struct ppc_sys_spec ppc_sys_specs[] = {
+	{
+		.ppc_sys_name	= "8349E",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80500000,
+		.num_devices	= 8,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
+		},
+	},
+	{
+		.ppc_sys_name	= "8349",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80510000,
+		.num_devices	= 7,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
+		},
+	},
+	{
+		.ppc_sys_name	= "8347E",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80520000,
+		.num_devices	= 8,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
+		},
+	},
+	{
+		.ppc_sys_name	= "8347",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80530000,
+		.num_devices	= 7,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
+		},
+	},
+	{
+		.ppc_sys_name	= "8343E",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80540000,
+		.num_devices	= 7,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
+			MPC83xx_USB2_DR,
+		},
+	},
+	{
+		.ppc_sys_name	= "8343",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80550000,
+		.num_devices	= 6,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART,
+			MPC83xx_USB2_DR,
+		},
+	},
+	{	/* default match */
+		.ppc_sys_name	= "",
+		.mask 		= 0x00000000,
+		.value 		= 0x00000000,
+	},
+};
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2005-03-02 14:20:27 -06:00
+++ b/arch/ppc/syslib/Makefile	2005-03-02 14:20:27 -06:00
@@ -99,4 +99,8 @@
 ifeq ($(CONFIG_85xx),y)
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
 endif
+obj-$(CONFIG_83xx)		+= ipic.o ppc83xx_setup.o ppc_sys.o
+ifeq ($(CONFIG_83xx),y)
+obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
+endif
 obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_setup.o mpc52xx_pic.o
diff -Nru a/arch/ppc/syslib/ipic.c b/arch/ppc/syslib/ipic.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/ipic.c	2005-03-02 14:20:27 -06:00
@@ -0,0 +1,646 @@
+/*
+ * include/asm-ppc/ipic.c
+ *
+ * IPIC routines implementations.
+ *
+ * Copyright 2005 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/sysdev.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/ipic.h>
+#include <asm/mpc83xx.h>
+
+#include "ipic.h"
+
+static struct ipic p_ipic;
+static struct ipic * primary_ipic;
+
+static struct ipic_info ipic_info[] = {
+	[9] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 24,
+		.prio_mask = 0,
+	},
+	[10] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 25,
+		.prio_mask = 1,
+	},
+	[11] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 26,
+		.prio_mask = 2,
+	},
+	[14] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 29,
+		.prio_mask = 5,
+	},
+	[15] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 30,
+		.prio_mask = 6,
+	},
+	[16] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 31,
+		.prio_mask = 7,
+	},
+	[17] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SEFCR,
+		.bit	= 1,
+		.prio_mask = 5,
+	},
+	[18] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SEFCR,
+		.bit	= 2,
+		.prio_mask = 6,
+	},
+	[19] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SEFCR,
+		.bit	= 3,
+		.prio_mask = 7,
+	},
+	[20] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SEFCR,
+		.bit	= 4,
+		.prio_mask = 4,
+	},
+	[21] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SEFCR,
+		.bit	= 5,
+		.prio_mask = 5,
+	},
+	[22] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SEFCR,
+		.bit	= 6,
+		.prio_mask = 6,
+	},
+	[23] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SEFCR,
+		.bit	= 7,
+		.prio_mask = 7,
+	},
+	[32] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 0,
+		.prio_mask = 0,
+	},
+	[33] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 1,
+		.prio_mask = 1,
+	},
+	[34] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 2,
+		.prio_mask = 2,
+	},
+	[35] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 3,
+		.prio_mask = 3,
+	},
+	[36] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 4,
+		.prio_mask = 4,
+	},
+	[37] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 5,
+		.prio_mask = 5,
+	},
+	[38] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 6,
+		.prio_mask = 6,
+	},
+	[39] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_A,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 7,
+		.prio_mask = 7,
+	},
+	[48] = {
+		.pend	= IPIC_SEPNR,
+		.mask	= IPIC_SEMSR,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SEFCR,
+		.bit	= 0,
+		.prio_mask = 4,
+	},
+	[64] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 0,
+		.prio_mask = 0,
+	},
+	[65] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 1,
+		.prio_mask = 1,
+	},
+	[66] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 2,
+		.prio_mask = 2,
+	},
+	[67] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_A,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 3,
+		.prio_mask = 3,
+	},
+	[68] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 4,
+		.prio_mask = 0,
+	},
+	[69] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 5,
+		.prio_mask = 1,
+	},
+	[70] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 6,
+		.prio_mask = 2,
+	},
+	[71] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= IPIC_SMPRR_B,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 7,
+		.prio_mask = 3,
+	},
+	[72] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 8,
+	},
+	[73] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 9,
+	},
+	[74] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 10,
+	},
+	[75] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 11,
+	},
+	[76] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 12,
+	},
+	[77] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 13,
+	},
+	[78] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 14,
+	},
+	[79] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 15,
+	},
+	[80] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 16,
+	},
+	[84] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 20,
+	},
+	[85] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 21,
+	},
+	[90] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 26,
+	},
+	[91] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 27,
+	},
+};
+
+static inline u32 ipic_read(volatile u32 __iomem *base, unsigned int reg)
+{
+	return in_be32(base + (reg >> 2));
+}
+
+static inline void ipic_write(volatile u32 __iomem *base, unsigned int reg, u32 value)
+{
+	out_be32(base + (reg >> 2), value);
+}
+
+static inline struct ipic * ipic_from_irq(unsigned int irq)
+{
+	return primary_ipic;
+}
+
+static void ipic_enable_irq(unsigned int irq)
+{
+	struct ipic *ipic = ipic_from_irq(irq);
+	unsigned int src = irq - ipic->irq_offset;
+	u32 temp;
+
+	temp = ipic_read(ipic->regs, ipic_info[src].mask);
+	temp |= (1 << (31 - ipic_info[src].bit));
+	ipic_write(ipic->regs, ipic_info[src].mask, temp);
+}
+
+static void ipic_disable_irq(unsigned int irq)
+{
+	struct ipic *ipic = ipic_from_irq(irq);
+	unsigned int src = irq - ipic->irq_offset;
+	u32 temp;
+
+	temp = ipic_read(ipic->regs, ipic_info[src].mask);
+	temp &= ~(1 << (31 - ipic_info[src].bit));
+	ipic_write(ipic->regs, ipic_info[src].mask, temp);
+}
+
+static void ipic_disable_irq_and_ack(unsigned int irq)
+{
+	struct ipic *ipic = ipic_from_irq(irq);
+	unsigned int src = irq - ipic->irq_offset;
+	u32 temp;
+
+	ipic_disable_irq(irq);
+
+	temp = ipic_read(ipic->regs, ipic_info[src].pend);
+	temp |= (1 << (31 - ipic_info[src].bit));
+	ipic_write(ipic->regs, ipic_info[src].pend, temp);
+}
+
+static void ipic_end_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+		ipic_enable_irq(irq);
+}
+
+struct hw_interrupt_type ipic = {
+	.typename = " IPIC  ",
+	.enable = ipic_enable_irq,
+	.disable = ipic_disable_irq,
+	.ack = ipic_disable_irq_and_ack,
+	.end = ipic_end_irq,
+};
+
+void __init ipic_init(phys_addr_t phys_addr,
+		unsigned int flags,
+		unsigned int irq_offset,
+		unsigned char *senses,
+		unsigned int senses_count)
+{
+	u32 i, temp = 0;
+
+	primary_ipic = &p_ipic;
+	primary_ipic->regs = ioremap(phys_addr, MPC83xx_IPIC_SIZE);
+
+	primary_ipic->irq_offset = irq_offset;
+
+	ipic_write(primary_ipic->regs, IPIC_SICNR, 0x0);
+
+	/* default priority scheme is grouped. If spread mode is required
+	 * configure SICFR accordingly */
+	if (flags & IPIC_SPREADMODE_GRP_A)
+		temp |= SICFR_IPSA;
+	if (flags & IPIC_SPREADMODE_GRP_D)
+		temp |= SICFR_IPSD;
+	if (flags & IPIC_SPREADMODE_MIX_A)
+		temp |= SICFR_MPSA;
+	if (flags & IPIC_SPREADMODE_MIX_B)
+		temp |= SICFR_MPSB;
+
+	ipic_write(primary_ipic->regs, IPIC_SICNR, temp);
+
+	/* handle MCP route */
+	temp = 0;
+	if (flags & IPIC_DISABLE_MCP_OUT)
+		temp = SERCR_MCPR;
+	ipic_write(primary_ipic->regs, IPIC_SERCR, temp);
+
+	/* handle routing of IRQ0 to MCP */
+	temp = ipic_read(primary_ipic->regs, IPIC_SEMSR);
+
+	if (flags & IPIC_IRQ0_MCP)
+		temp |= SEMSR_SIRQ0;
+	else
+		temp &= ~SEMSR_SIRQ0;
+
+	ipic_write(primary_ipic->regs, IPIC_SEMSR, temp);
+
+	for (i = 0 ; i < NR_IPIC_INTS ; i++) {
+		irq_desc[i+irq_offset].handler = &ipic;
+		irq_desc[i+irq_offset].status = IRQ_LEVEL;
+	}
+
+	temp = 0;
+	for (i = 0 ; i < senses_count ; i++) {
+		if ((senses[i] & IRQ_SENSE_MASK) == IRQ_SENSE_EDGE) {
+			temp |= 1 << (16 - i);
+			if (i != 0)
+				irq_desc[i + irq_offset + MPC83xx_IRQ_EXT1 - 1].status = 0;
+			else
+				irq_desc[irq_offset + MPC83xx_IRQ_EXT0].status = 0;
+		}
+	}
+	ipic_write(primary_ipic->regs, IPIC_SECNR, temp);
+
+	printk ("IPIC (%d IRQ sources, %d External IRQs) at %p\n", NR_IPIC_INTS,
+			senses_count, primary_ipic->regs);
+}
+
+int ipic_set_priority(unsigned int irq, unsigned int priority)
+{
+	struct ipic *ipic = ipic_from_irq(irq);
+	unsigned int src = irq - ipic->irq_offset;
+	u32 temp;
+
+	if (priority > 7)
+		return -EINVAL;
+	if (src > 127)
+		return -EINVAL;
+	if (ipic_info[src].prio == 0)
+		return -EINVAL;
+
+	temp = ipic_read(ipic->regs, ipic_info[src].prio);
+
+	if (priority < 4) {
+		temp &= ~(0x7 << (20 + (3 - priority) * 3));
+		temp |= ipic_info[src].prio_mask << (20 + (3 - priority) * 3);
+	} else {
+		temp &= ~(0x7 << (4 + (7 - priority) * 3));
+		temp |= ipic_info[src].prio_mask << (4 + (7 - priority) * 3);
+	}
+
+	ipic_write(ipic->regs, ipic_info[src].prio, temp);
+
+	return 0;
+}
+
+void ipic_set_highest_priority(unsigned int irq)
+{
+	struct ipic *ipic = ipic_from_irq(irq);
+	unsigned int src = irq - ipic->irq_offset;
+	u32 temp;
+
+	temp = ipic_read(ipic->regs, IPIC_SICFR);
+
+	/* clear and set HPI */
+	temp &= 0x7f000000;
+	temp |= (src & 0x7f) << 24;
+	
+	ipic_write(ipic->regs, IPIC_SICFR, temp);
+}
+
+void ipic_set_default_priority(void)
+{
+	ipic_set_priority(MPC83xx_IRQ_TSEC1_TX, 0);
+	ipic_set_priority(MPC83xx_IRQ_TSEC1_RX, 1);
+	ipic_set_priority(MPC83xx_IRQ_TSEC1_ERROR, 2);
+	ipic_set_priority(MPC83xx_IRQ_TSEC2_TX, 3);
+	ipic_set_priority(MPC83xx_IRQ_TSEC2_RX, 4);
+	ipic_set_priority(MPC83xx_IRQ_TSEC2_ERROR, 5);
+	ipic_set_priority(MPC83xx_IRQ_USB2_DR, 6);
+	ipic_set_priority(MPC83xx_IRQ_USB2_MPH, 7);
+
+	ipic_set_priority(MPC83xx_IRQ_UART1, 0);
+	ipic_set_priority(MPC83xx_IRQ_UART2, 1);
+	ipic_set_priority(MPC83xx_IRQ_SEC2, 2);
+	ipic_set_priority(MPC83xx_IRQ_IIC1, 5);
+	ipic_set_priority(MPC83xx_IRQ_IIC2, 6);
+	ipic_set_priority(MPC83xx_IRQ_SPI, 7);
+	ipic_set_priority(MPC83xx_IRQ_RTC_SEC, 0);
+	ipic_set_priority(MPC83xx_IRQ_PIT, 1);
+	ipic_set_priority(MPC83xx_IRQ_PCI1, 2);
+	ipic_set_priority(MPC83xx_IRQ_PCI2, 3);
+	ipic_set_priority(MPC83xx_IRQ_EXT0, 4);
+	ipic_set_priority(MPC83xx_IRQ_EXT1, 5);
+	ipic_set_priority(MPC83xx_IRQ_EXT2, 6);
+	ipic_set_priority(MPC83xx_IRQ_EXT3, 7);
+	ipic_set_priority(MPC83xx_IRQ_RTC_ALR, 0);
+	ipic_set_priority(MPC83xx_IRQ_MU, 1);
+	ipic_set_priority(MPC83xx_IRQ_SBA, 2);
+	ipic_set_priority(MPC83xx_IRQ_DMA, 3);
+	ipic_set_priority(MPC83xx_IRQ_EXT4, 4);
+	ipic_set_priority(MPC83xx_IRQ_EXT5, 5);
+	ipic_set_priority(MPC83xx_IRQ_EXT6, 6);
+	ipic_set_priority(MPC83xx_IRQ_EXT7, 7);
+}
+
+void ipic_enable_mcp(enum ipic_mcp_irq mcp_irq)
+{
+	struct ipic *ipic = primary_ipic;
+	u32 temp;
+
+	temp = ipic_read(ipic->regs, IPIC_SERMR);
+	temp |= (1 << (31 - mcp_irq));
+	ipic_write(ipic->regs, IPIC_SERMR, temp);
+}
+
+void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq)
+{
+	struct ipic *ipic = primary_ipic;
+	u32 temp;
+
+	temp = ipic_read(ipic->regs, IPIC_SERMR);
+	temp &= (1 << (31 - mcp_irq));
+	ipic_write(ipic->regs, IPIC_SERMR, temp);
+}
+
+u32 ipic_get_mcp_status(void)
+{
+	return ipic_read(primary_ipic->regs, IPIC_SERMR);
+}
+
+void ipic_clear_mcp_status(u32 mask)
+{
+	ipic_write(primary_ipic->regs, IPIC_SERMR, mask);
+}
+
+/* Return an interrupt vector or -1 if no interrupt is pending. */
+int ipic_get_irq(struct pt_regs *regs)
+{
+	int irq;
+	
+	irq = ipic_read(primary_ipic->regs, IPIC_SIVCR) & 0x7f;
+
+	if (irq == 0)    /* 0 --> no irq is pending */
+		irq = -1;
+
+	return irq;
+}
+
+static struct sysdev_class ipic_sysclass = {
+	set_kset_name("ipic"),
+};
+
+static struct sys_device device_ipic = {
+	.id		= 0,
+	.cls		= &ipic_sysclass,
+};
+
+static int __init init_ipic_sysfs(void)
+{
+	int rc;
+
+	if (!primary_ipic->regs)
+		return -ENODEV;
+	printk(KERN_DEBUG "Registering ipic with sysfs...\n");
+
+	rc = sysdev_class_register(&ipic_sysclass);
+	if (rc) {
+		printk(KERN_ERR "Failed registering ipic sys class\n");
+		return -ENODEV;
+	}
+	rc = sysdev_register(&device_ipic);
+	if (rc) {
+		printk(KERN_ERR "Failed registering ipic sys device\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+subsys_initcall(init_ipic_sysfs);
diff -Nru a/arch/ppc/syslib/ipic.h b/arch/ppc/syslib/ipic.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/ipic.h	2005-03-02 14:20:27 -06:00
@@ -0,0 +1,49 @@
+/*
+ * arch/ppc/kernel/ipic.h
+ *
+ * IPIC private definitions and structure.
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __IPIC_H__
+#define __IPIC_H__
+
+#include <asm/ipic.h>
+
+#define MPC83xx_IPIC_SIZE	(0x00100)
+
+/* System Global Interrupt Configuration Register */
+#define	SICFR_IPSA	0x00010000
+#define	SICFR_IPSD	0x00080000
+#define	SICFR_MPSA	0x00200000
+#define	SICFR_MPSB	0x00400000
+
+/* System External Interrupt Mask Register */
+#define	SEMSR_SIRQ0	0x00008000
+
+/* System Error Control Register */
+#define SERCR_MCPR	0x00000001
+
+struct ipic {
+	volatile u32 __iomem	*regs;
+	unsigned int		irq_offset;
+};
+
+struct ipic_info {
+	u8	pend;		/* pending register offset from base */
+	u8	mask;		/* mask register offset from base */
+	u8	prio;		/* priority register offset from base */
+	u8	force;		/* force register offset from base */
+	u8	bit;		/* register bit position (as per doc)
+				   bit mask = 1 << (31 - bit) */
+	u8	prio_mask;	/* priority mask value */
+};
+
+#endif /* __IPIC_H__ */
diff -Nru a/arch/ppc/syslib/ppc83xx_setup.c b/arch/ppc/syslib/ppc83xx_setup.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/ppc83xx_setup.c	2005-03-02 14:20:27 -06:00
@@ -0,0 +1,138 @@
+/*
+ * arch/ppc/syslib/ppc83xx_setup.c
+ *
+ * MPC83XX common board code
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/serial.h>
+#include <linux/tty.h>	/* for linux/serial_core.h */
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+
+#include <asm/prom.h>
+#include <asm/time.h>
+#include <asm/mpc83xx.h>
+#include <asm/mmu.h>
+#include <asm/ppc_sys.h>
+#include <asm/kgdb.h>
+
+#include <syslib/ppc83xx_setup.h>
+
+phys_addr_t immrbar;
+
+/* Return the amount of memory */
+unsigned long __init
+mpc83xx_find_end_of_memory(void)
+{
+        bd_t *binfo;
+
+        binfo = (bd_t *) __res;
+
+        return binfo->bi_memsize;
+}
+
+long __init 
+mpc83xx_time_init(void)
+{
+#define SPCR_OFFS   0x00000110
+#define SPCR_TBEN   0x00400000
+
+	bd_t *binfo = (bd_t *)__res;
+	u32 *spcr = ioremap(binfo->bi_immr_base + SPCR_OFFS, 4);
+	
+	*spcr |= SPCR_TBEN;
+
+	iounmap(spcr);
+
+	return 0;
+}
+
+/* The decrementer counts at the system (internal) clock freq divided by 4 */
+void __init
+mpc83xx_calibrate_decr(void)
+{
+        bd_t *binfo = (bd_t *) __res;
+        unsigned int freq, divisor;
+
+	freq = binfo->bi_busfreq;
+	divisor = 4;
+	tb_ticks_per_jiffy = freq / HZ / divisor;
+	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
+}
+
+#ifdef CONFIG_SERIAL_8250
+void __init
+mpc83xx_early_serial_map(void)
+{
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	struct uart_port serial_req;
+#endif
+	struct plat_serial8250_port *pdata;
+	bd_t *binfo = (bd_t *) __res;
+	pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(MPC83xx_DUART);
+
+	/* Setup serial port access */
+	pdata[0].uartclk = binfo->bi_busfreq;
+	pdata[0].mapbase += binfo->bi_immr_base;
+	pdata[0].membase = ioremap(pdata[0].mapbase, 0x100);
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	memset(&serial_req, 0, sizeof (serial_req));
+	serial_req.iotype = SERIAL_IO_MEM;
+	serial_req.mapbase = pdata[0].mapbase;
+	serial_req.membase = pdata[0].membase;
+	serial_req.regshift = 0;
+
+	gen550_init(0, &serial_req);
+#endif
+
+	pdata[1].uartclk = binfo->bi_busfreq;
+	pdata[1].mapbase += binfo->bi_immr_base;
+	pdata[1].membase = ioremap(pdata[1].mapbase, 0x100);
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Assume gen550_init() doesn't modify serial_req */
+	serial_req.mapbase = pdata[1].mapbase;
+	serial_req.membase = pdata[1].membase;
+
+	gen550_init(1, &serial_req);
+#endif
+}
+#endif
+
+void
+mpc83xx_restart(char *cmd)
+{
+	local_irq_disable();
+	for(;;);
+}
+
+void
+mpc83xx_power_off(void)
+{
+	local_irq_disable();
+	for(;;);
+}
+
+void
+mpc83xx_halt(void)
+{
+	local_irq_disable();
+	for(;;);
+}
+
+/* PCI SUPPORT DOES NOT EXIT, MODEL after ppc85xx_setup.c */
diff -Nru a/arch/ppc/syslib/ppc83xx_setup.h b/arch/ppc/syslib/ppc83xx_setup.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/ppc83xx_setup.h	2005-03-02 14:20:27 -06:00
@@ -0,0 +1,53 @@
+/*
+ * arch/ppc/syslib/ppc83xx_setup.h
+ *
+ * MPC83XX common board definitions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef __PPC_SYSLIB_PPC83XX_SETUP_H
+#define __PPC_SYSLIB_PPC83XX_SETUP_H
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <asm/ppcboot.h>
+
+extern unsigned long mpc83xx_find_end_of_memory(void) __init;
+extern long mpc83xx_time_init(void) __init;
+extern void mpc83xx_calibrate_decr(void) __init;
+extern void mpc83xx_early_serial_map(void) __init;
+extern void mpc83xx_restart(char *cmd);
+extern void mpc83xx_power_off(void);
+extern void mpc83xx_halt(void);
+extern void mpc83xx_setup_hose(void) __init;
+
+/* PCI config */
+#if 0
+#define PCI1_CFG_ADDR_OFFSET	(FIXME)
+#define PCI1_CFG_DATA_OFFSET	(FIXME)
+
+#define PCI2_CFG_ADDR_OFFSET	(FIXME)
+#define PCI2_CFG_DATA_OFFSET	(FIXME)
+#endif
+
+/* Serial Config */
+#ifdef CONFIG_SERIAL_MANY_PORTS
+#define RS_TABLE_SIZE  64
+#else
+#define RS_TABLE_SIZE  2
+#endif
+
+#ifndef BASE_BAUD
+#define BASE_BAUD 115200
+#endif
+
+#endif /* __PPC_SYSLIB_PPC83XX_SETUP_H */
diff -Nru a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2005-03-02 14:20:27 -06:00
+++ b/drivers/net/Kconfig	2005-03-02 14:20:27 -06:00
@@ -2083,7 +2083,7 @@
 
 config GIANFAR
 	tristate "Gianfar Ethernet"
-	depends on 85xx
+	depends on 85xx || 83xx
 	help
 	  This driver supports the Gigabit TSEC on the MPC85xx 
 	  family of chips, and the FEC on the 8540
diff -Nru a/include/asm-ppc/io.h b/include/asm-ppc/io.h
--- a/include/asm-ppc/io.h	2005-03-02 14:20:27 -06:00
+++ b/include/asm-ppc/io.h	2005-03-02 14:20:27 -06:00
@@ -30,6 +30,8 @@
 #include <asm/mpc8xx.h>
 #elif defined(CONFIG_8260)
 #include <asm/mpc8260.h>
+#elif defined(CONFIG_83xx)
+#include <asm/mpc83xx.h>
 #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
 #elif defined(CONFIG_APUS)
diff -Nru a/include/asm-ppc/ipic.h b/include/asm-ppc/ipic.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-ppc/ipic.h	2005-03-02 14:20:27 -06:00
@@ -0,0 +1,85 @@
+/*
+ * include/asm-ppc/ipic.h
+ *
+ * IPIC external definitions and structure.
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifdef __KERNEL__
+#ifndef __ASM_IPIC_H__
+#define __ASM_IPIC_H__
+
+#include <linux/irq.h>
+
+/* Flags when we init the IPIC */
+#define IPIC_SPREADMODE_GRP_A	0x00000001
+#define IPIC_SPREADMODE_GRP_D	0x00000002
+#define IPIC_SPREADMODE_MIX_A	0x00000004
+#define IPIC_SPREADMODE_MIX_B	0x00000008
+#define IPIC_DISABLE_MCP_OUT	0x00000010
+#define IPIC_IRQ0_MCP		0x00000020
+
+/* IPIC registers offsets */
+#define IPIC_SICFR	0x00	/* System Global Interrupt Configuration Register */
+#define IPIC_SIVCR	0x04	/* System Global Interrupt Vector Register */
+#define IPIC_SIPNR_H	0x08	/* System Internal Interrupt Pending Register (HIGH) */
+#define IPIC_SIPNR_L	0x0C	/* System Internal Interrupt Pending Register (LOW) */
+#define IPIC_SIPRR_A	0x10	/* System Internal Interrupt group A Priority Register */
+#define IPIC_SIPRR_B	0x14	/* System Internal Interrupt group B Priority Register */
+#define IPIC_SIPRR_C	0x18	/* System Internal Interrupt group C Priority Register */
+#define IPIC_SIPRR_D	0x1C	/* System Internal Interrupt group D Priority Register */
+#define IPIC_SIMSR_H	0x20	/* System Internal Interrupt Mask Register (HIGH) */
+#define IPIC_SIMSR_L	0x24	/* System Internal Interrupt Mask Register (LOW) */
+#define IPIC_SICNR	0x28	/* System Internal Interrupt Control Register */
+#define IPIC_SEPNR	0x2C	/* System External Interrupt Pending Register */
+#define IPIC_SMPRR_A	0x30	/* System Mixed Interrupt group A Priority Register */
+#define IPIC_SMPRR_B	0x34	/* System Mixed Interrupt group B Priority Register */
+#define IPIC_SEMSR	0x38	/* System External Interrupt Mask Register */
+#define IPIC_SECNR	0x3C	/* System External Interrupt Control Register */
+#define IPIC_SERSR	0x40	/* System Error Status Register */
+#define IPIC_SERMR	0x44	/* System Error Mask Register */
+#define IPIC_SERCR	0x48	/* System Error Control Register */
+#define IPIC_SIFCR_H	0x50	/* System Internal Interrupt Force Register (HIGH) */
+#define IPIC_SIFCR_L	0x54	/* System Internal Interrupt Force Register (LOW) */
+#define IPIC_SEFCR	0x58	/* System External Interrupt Force Register */
+#define IPIC_SERFR	0x5C	/* System Error Force Register */
+#define IPIC_SCVCR	0x60	/* System Critical Interrupt Vector Register */
+#define IPIC_SMVCR	0x64	/* System Management Interrupt Vector Register */
+
+enum ipic_prio_grp {
+	IPIC_INT_GRP_A = IPIC_SIPRR_A,
+	IPIC_INT_GRP_D = IPIC_SIPRR_D,
+	IPIC_MIX_GRP_A = IPIC_SMPRR_A,
+	IPIC_MIX_GRP_B = IPIC_SMPRR_B,
+};
+
+enum ipic_mcp_irq {
+	IPIC_MCP_IRQ0 = 0,
+	IPIC_MCP_WDT  = 1,
+	IPIC_MCP_SBA  = 2,
+	IPIC_MCP_PCI1 = 5,
+	IPIC_MCP_PCI2 = 6,
+	IPIC_MCP_MU   = 7,
+};
+
+extern void ipic_init(phys_addr_t phys_addr, unsigned int flags,
+		unsigned int irq_offset,
+		unsigned char *senses, unsigned int senses_count);
+extern int ipic_set_priority(unsigned int irq, unsigned int priority);
+extern void ipic_set_highest_priority(unsigned int irq);
+extern void ipic_set_default_priority(void);
+extern void ipic_enable_mcp(enum ipic_mcp_irq mcp_irq);
+extern void ipic_disable_mcp(enum ipic_mcp_irq mcp_irq);
+extern u32 ipic_get_mcp_status(void);
+extern void ipic_clear_mcp_status(u32 mask);
+extern int ipic_get_irq(struct pt_regs *regs);
+
+#endif /* __ASM_IPIC_H__ */
+#endif /* __KERNEL__ */
diff -Nru a/include/asm-ppc/irq.h b/include/asm-ppc/irq.h
--- a/include/asm-ppc/irq.h	2005-03-02 14:20:27 -06:00
+++ b/include/asm-ppc/irq.h	2005-03-02 14:20:27 -06:00
@@ -161,6 +161,16 @@
 	return irq;
 }
 
+#elif defined(CONFIG_83xx)
+#include <asm/mpc83xx.h>
+
+static __inline__ int irq_canonicalize(int irq)
+{
+	return irq;
+}
+
+#define	NR_IRQS	(NR_IPIC_INTS)
+
 #elif defined(CONFIG_CPM2) && defined(CONFIG_85xx)
 /* Now include the board configuration specific associations.
 */
diff -Nru a/include/asm-ppc/mpc83xx.h b/include/asm-ppc/mpc83xx.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-ppc/mpc83xx.h	2005-03-02 14:20:27 -06:00
@@ -0,0 +1,114 @@
+/*
+ * include/asm-ppc/mpc83xx.h
+ *
+ * MPC83xx definitions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_MPC83xx_H__
+#define __ASM_MPC83xx_H__
+
+#include <linux/config.h>
+#include <asm/mmu.h>
+
+#ifdef CONFIG_83xx
+
+#ifdef CONFIG_MPC834x_SYS
+#include <platforms/83xx/mpc834x_sys.h>
+#endif
+
+#define _IO_BASE        isa_io_base
+#define _ISA_MEM_BASE   isa_mem_base
+#ifdef CONFIG_PCI
+#define PCI_DRAM_OFFSET pci_dram_offset
+#else
+#define PCI_DRAM_OFFSET 0
+#endif
+
+/*
+ * The "residual" board information structure the boot loader passes
+ * into the kernel.
+ */
+extern unsigned char __res[];
+
+/* Internal IRQs on MPC83xx OpenPIC */
+/* Not all of these exist on all MPC83xx implementations */
+
+#ifndef MPC83xx_IPIC_IRQ_OFFSET
+#define MPC83xx_IPIC_IRQ_OFFSET	0
+#endif
+
+#define NR_IPIC_INTS 128
+
+#define MPC83xx_IRQ_UART1	( 9 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_UART2	(10 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_SEC2	(11 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_IIC1	(14 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_IIC2	(15 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_SPI		(16 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT1	(17 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT2	(18 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT3	(19 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT4	(20 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT5	(21 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT6	(22 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT7	(23 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_TSEC1_TX	(32 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_TSEC1_RX	(33 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_TSEC1_ERROR	(34 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_TSEC2_TX	(35 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_TSEC2_RX	(36 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_TSEC2_ERROR	(37 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_USB2_DR	(38 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_USB2_MPH	(39 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_EXT0	(48 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_RTC_SEC	(64 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_PIT		(65 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_PCI1	(66 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_PCI2	(67 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_RTC_ALR	(68 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_MU		(69 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_SBA		(70 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_DMA		(71 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM4	(72 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM8	(73 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GPIO1	(74 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GPIO2	(75 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_DDR		(76 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_LBC		(77 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM2	(78 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM6	(79 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_PMC		(80 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM3	(84 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM7	(85 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM1	(90 + MPC83xx_IPIC_IRQ_OFFSET)
+#define MPC83xx_IRQ_GTM5	(91 + MPC83xx_IPIC_IRQ_OFFSET)
+
+#define MPC83xx_CCSRBAR_SIZE	(1024*1024)
+
+/* Let modules/drivers get at immrbar (physical) */
+extern phys_addr_t immrbar;
+
+enum ppc_sys_devices {
+	MPC83xx_TSEC1,
+	MPC83xx_TSEC2,
+	MPC83xx_IIC1,
+	MPC83xx_IIC2,
+	MPC83xx_DUART,
+	MPC83xx_SEC2,
+	MPC83xx_USB2_DR,
+	MPC83xx_USB2_MPH,
+};
+
+#endif /* CONFIG_83xx */
+#endif /* __ASM_MPC83xx_H__ */
+#endif /* __KERNEL__ */
diff -Nru a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
--- a/include/asm-ppc/ppc_sys.h	2005-03-02 14:20:27 -06:00
+++ b/include/asm-ppc/ppc_sys.h	2005-03-02 14:20:27 -06:00
@@ -21,7 +21,9 @@
 #include <linux/device.h>
 #include <linux/types.h>
 
-#if defined(CONFIG_85xx)
+#if defined(CONFIG_83xx)
+#include <asm/mpc83xx.h>
+#elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
 #else
 #error "need definition of ppc_sys_devices"
diff -Nru a/include/asm-ppc/ppcboot.h b/include/asm-ppc/ppcboot.h
--- a/include/asm-ppc/ppcboot.h	2005-03-02 14:20:27 -06:00
+++ b/include/asm-ppc/ppcboot.h	2005-03-02 14:20:27 -06:00
@@ -38,7 +38,8 @@
 	unsigned long	bi_flashoffset; /* reserved area for startup monitor */
 	unsigned long	bi_sramstart;	/* start of SRAM memory */
 	unsigned long	bi_sramsize;	/* size	 of SRAM memory */
-#if defined(CONFIG_8xx) || defined(CONFIG_CPM2) || defined(CONFIG_85xx)
+#if defined(CONFIG_8xx) || defined(CONFIG_CPM2) || defined(CONFIG_85xx) ||\
+	defined(CONFIG_83xx)
 	unsigned long	bi_immr_base;	/* base of IMMR register */
 #endif
 #if defined(CONFIG_PPC_MPC52xx)
@@ -72,7 +73,8 @@
 #if defined(CONFIG_HYMOD)
 	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
 #endif
-#if defined(CONFIG_EVB64260) || defined(CONFIG_44x) || defined(CONFIG_85xx)
+#if defined(CONFIG_EVB64260) || defined(CONFIG_44x) || defined(CONFIG_85xx) ||\
+	defined(CONFIG_83xx)
 	/* second onboard ethernet port */
 	unsigned char	bi_enet1addr[6];
 #endif
diff -Nru a/include/asm-ppc/serial.h b/include/asm-ppc/serial.h
--- a/include/asm-ppc/serial.h	2005-03-02 14:20:27 -06:00
+++ b/include/asm-ppc/serial.h	2005-03-02 14:20:27 -06:00
@@ -32,6 +32,8 @@
 #include <platforms/spruce.h>
 #elif defined(CONFIG_4xx)
 #include <asm/ibm4xx.h>
+#elif defined(CONFIG_83xx)
+#include <asm/mpc83xx.h>
 #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
 #else
