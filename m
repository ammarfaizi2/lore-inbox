Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVBAA62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVBAA62 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVBAA2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:28:01 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:8154 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261497AbVBAAIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 19:08:06 -0500
Date: Mon, 31 Jan 2005 17:08:03 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Add PPC440SP and Luan ref board support
Message-ID: <20050131170803.E25809@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the IBM/AMCC PPC440SP SoC. Also adds support for
the Luan reference board that has a 440SP on it.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff -Nru a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
--- a/arch/ppc/boot/simple/Makefile	2005-01-31 17:03:53 -07:00
+++ b/arch/ppc/boot/simple/Makefile	2005-01-31 17:03:53 -07:00
@@ -66,6 +66,12 @@
          end-$(CONFIG_EBONY)		:= ebony
   entrypoint-$(CONFIG_EBONY)		:= 0x01000000
 
+      zimage-$(CONFIG_LUAN)		:= zImage-TREE
+zimageinitrd-$(CONFIG_LUAN)		:= zImage.initrd-TREE
+         end-$(CONFIG_LUAN)		:= luan
+  entrypoint-$(CONFIG_LUAN)		:= 0x01000000
+     extra.o-$(CONFIG_LUAN)		:= pibs.o
+
       zimage-$(CONFIG_OCOTEA)		:= zImage-TREE
 zimageinitrd-$(CONFIG_OCOTEA)		:= zImage.initrd-TREE
          end-$(CONFIG_OCOTEA)		:= ocotea
diff -Nru a/arch/ppc/boot/simple/pibs.c b/arch/ppc/boot/simple/pibs.c
--- a/arch/ppc/boot/simple/pibs.c	2005-01-31 17:03:54 -07:00
+++ b/arch/ppc/boot/simple/pibs.c	2005-01-31 17:03:54 -07:00
@@ -1,5 +1,5 @@
 /*
- * 2004 (c) MontaVista, Software, Inc.  This file is licensed under
+ * 2004-2005 (c) MontaVista, Software, Inc.  This file is licensed under
  * the terms of the GNU General Public License version 2.  This program
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
@@ -10,7 +10,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <asm/ppcboot.h>
-#include <platforms/4xx/ocotea.h>
+#include <asm/ibm4xx.h>
 
 extern unsigned long decompress_kernel(unsigned long load_addr, int num_words,
 				       unsigned long cksum);
@@ -89,13 +89,15 @@
 
 	decompress_kernel(load_addr, num_words, cksum);
 
-	mac64 = simple_strtoull((char *)OCOTEA_PIBS_MAC_BASE, 0, 16);
+	mac64 = simple_strtoull((char *)PIBS_MAC_BASE, 0, 16);
 	memcpy(hold_residual->bi_enetaddr, (char *)&mac64+2, 6);
-	mac64 = simple_strtoull((char *)(OCOTEA_PIBS_MAC_BASE+OCOTEA_PIBS_MAC_OFFSET), 0, 16);
+#ifdef CONFIG_440GX
+	mac64 = simple_strtoull((char *)(PIBS_MAC_BASE+PIBS_MAC_OFFSET), 0, 16);
 	memcpy(hold_residual->bi_enet1addr, (char *)&mac64+2, 6);
-	mac64 = simple_strtoull((char *)(OCOTEA_PIBS_MAC_BASE+OCOTEA_PIBS_MAC_OFFSET*2), 0, 16);
+	mac64 = simple_strtoull((char *)(PIBS_MAC_BASE+PIBS_MAC_OFFSET*2), 0, 16);
 	memcpy(hold_residual->bi_enet2addr, (char *)&mac64+2, 6);
-	mac64 = simple_strtoull((char *)(OCOTEA_PIBS_MAC_BASE+OCOTEA_PIBS_MAC_OFFSET*3), 0, 16);
+	mac64 = simple_strtoull((char *)(PIBS_MAC_BASE+PIBS_MAC_OFFSET*3), 0, 16);
 	memcpy(hold_residual->bi_enet3addr, (char *)&mac64+2, 6);
+#endif
 	return (void *)hold_residual;
 }
diff -Nru a/arch/ppc/configs/luan_defconfig b/arch/ppc/configs/luan_defconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/configs/luan_defconfig	2005-01-31 17:03:54 -07:00
@@ -0,0 +1,668 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.11-rc2
+# Mon Jan 31 16:26:31 2005
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
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
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
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Processor
+#
+# CONFIG_6xx is not set
+# CONFIG_40x is not set
+CONFIG_44x=y
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+# CONFIG_E500 is not set
+CONFIG_BOOKE=y
+CONFIG_PTE_64BIT=y
+CONFIG_PHYS_64BIT=y
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_4xx=y
+
+#
+# IBM 4xx options
+#
+# CONFIG_EBONY is not set
+CONFIG_LUAN=y
+# CONFIG_OCOTEA is not set
+CONFIG_440SP=y
+CONFIG_440=y
+CONFIG_IBM_OCP=y
+CONFIG_IBM_EMAC4=y
+# CONFIG_PPC4xx_DMA is not set
+CONFIG_PPC_GEN550=y
+# CONFIG_PM is not set
+CONFIG_NOT_COHERENT_CACHE=y
+
+#
+# Platform options
+#
+# CONFIG_PC_KEYBOARD is not set
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="ip=on console=ttyS0,115200"
+
+#
+# Bus options
+#
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_PCI_LEGACY_PROC is not set
+# CONFIG_PCI_NAMES is not set
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
+CONFIG_CONSISTENT_START=0xff100000
+CONFIG_CONSISTENT_SIZE=0x00200000
+CONFIG_BOOT_LOAD=0x01000000
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+# CONFIG_STANDALONE is not set
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
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
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
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
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
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
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
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
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_IP_NF_CONNTRACK is not set
+# CONFIG_IP_NF_CONNTRACK_MARK is not set
+# CONFIG_IP_NF_QUEUE is not set
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
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
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_IBM_EMAC=y
+# CONFIG_IBM_EMAC_ERRMSG is not set
+CONFIG_IBM_EMAC_RXB=128
+CONFIG_IBM_EMAC_TXB=128
+CONFIG_IBM_EMAC_FGAP=8
+CONFIG_IBM_EMAC_SKBRES=0
+# CONFIG_NET_PCI is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
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
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
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
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
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
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PCIPS2 is not set
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
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
+CONFIG_SERIAL_8250_EXTENDED=y
+# CONFIG_SERIAL_8250_MANY_PORTS is not set
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+# CONFIG_SERIAL_8250_DETECT_IRQ is not set
+# CONFIG_SERIAL_8250_MULTIPORT is not set
+# CONFIG_SERIAL_8250_RSA is not set
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
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
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
+# CONFIG_USB is not set
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
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
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
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
+# CONFIG_TMPFS is not set
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
+# CONFIG_EXPORTFS is not set
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
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
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
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_FS is not set
+# CONFIG_KGDB is not set
+# CONFIG_XMON is not set
+CONFIG_BDI_SWITCH=y
+# CONFIG_SERIAL_TEXT_DEBUG is not set
+CONFIG_PPC_OCP=y
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
diff -Nru a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S	2005-01-31 17:03:53 -07:00
+++ b/arch/ppc/kernel/head_44x.S	2005-01-31 17:03:53 -07:00
@@ -21,7 +21,7 @@
  * 	Author: MontaVista Software, Inc.
  *         	frank_rowand@mvista.com or source@mvista.com
  * 	   	debbie_chu@mvista.com
- *    Copyright 2002-2004 MontaVista Software, Inc.
+ *    Copyright 2002-2005 MontaVista Software, Inc.
  *      PowerPC 44x support, Matt Porter <mporter@kernel.crashing.org>
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -185,11 +185,11 @@
 	 * are used for polled operation.
 	 */
  	/* pageid fields */
-	lis	r3,0xe000	
+	lis	r3,UART0_IO_BASE@h	
 	ori	r3,r3,PPC44x_TLB_VALID | PPC44x_TLB_256M
 
 	/* xlat fields */
-	lis	r4,0x4000		/* RPN is 0x40000000 */
+	lis	r4,UART0_PHYS_IO_BASE@h		/* RPN depends on SoC */
 	ori	r4,r4,0x0001		/* ERPN is 1 for second 4GB page */
 
 	/* attrib fields */
diff -Nru a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
--- a/arch/ppc/platforms/4xx/Kconfig	2005-01-31 17:03:53 -07:00
+++ b/arch/ppc/platforms/4xx/Kconfig	2005-01-31 17:03:53 -07:00
@@ -73,6 +73,11 @@
 	help
 	  This option enables support for the IBM PPC440GP evaluation board.
 
+config LUAN
+	bool "Luan"
+	help
+	  This option enables support for the IBM PPC440SP evaluation board.
+
 config OCOTEA
 	bool "Ocotea"
 	help
@@ -103,9 +108,14 @@
 	depends on OCOTEA
 	default y
 
+config 440SP
+	bool
+	depends on LUAN
+	default y
+
 config 440
 	bool
-	depends on 440GP
+	depends on 440GP || 440SP
 	default y
 
 config 440A
@@ -132,7 +142,7 @@
 
 config IBM_OCP
 	bool
-	depends on ASH || BUBINGA || CPCI405 || EBONY || EP405 || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
+	depends on ASH || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
 	default y
 
 config XILINX_OCP
@@ -142,7 +152,7 @@
 
 config IBM_EMAC4
 	bool
-	depends on 440GX
+	depends on 440GX || 440SP
 	default y
 
 config BIOS_FIXUP
diff -Nru a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
--- a/arch/ppc/platforms/4xx/Makefile	2005-01-31 17:03:54 -07:00
+++ b/arch/ppc/platforms/4xx/Makefile	2005-01-31 17:03:54 -07:00
@@ -6,6 +6,7 @@
 obj-$(CONFIG_EBONY)		+= ebony.o
 obj-$(CONFIG_EP405)		+= ep405.o
 obj-$(CONFIG_BUBINGA)		+= bubinga.o
+obj-$(CONFIG_LUAN)		+= luan.o
 obj-$(CONFIG_OAK)		+= oak.o
 obj-$(CONFIG_OCOTEA)		+= ocotea.o
 obj-$(CONFIG_REDWOOD_5)		+= redwood5.o
@@ -20,6 +21,7 @@
 obj-$(CONFIG_REDWOOD_6)		+= ibmstbx25.o
 obj-$(CONFIG_440GP)		+= ibm440gp.o
 obj-$(CONFIG_440GX)		+= ibm440gx.o
+obj-$(CONFIG_440SP)		+= ibm440sp.o
 obj-$(CONFIG_405EP)		+= ibm405ep.o
 obj-$(CONFIG_405GPR)		+= ibm405gpr.o
 obj-$(CONFIG_VIRTEX_II_PRO)	+= virtex-ii_pro.o
diff -Nru a/arch/ppc/platforms/4xx/ebony.c b/arch/ppc/platforms/4xx/ebony.c
--- a/arch/ppc/platforms/4xx/ebony.c	2005-01-31 17:03:54 -07:00
+++ b/arch/ppc/platforms/4xx/ebony.c	2005-01-31 17:03:54 -07:00
@@ -4,7 +4,7 @@
  * Ebony board specific routines
  *
  * Matt Porter <mporter@kernel.crashing.org>
- * Copyright 2002-2004 MontaVista Software Inc.
+ * Copyright 2002-2005 MontaVista Software Inc.
  *
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  * Copyright (c) 2003, 2004 Zultys Technologies
@@ -140,7 +140,7 @@
 {
 	void *pcix_reg_base;
 
-	pcix_reg_base = ioremap64(PCIX0_REG_BASE, PCIX0_REG_SIZE);
+	pcix_reg_base = ioremap64(PCIX0_REG_BASE, PCIX_REG_SIZE);
 
 	/* Disable all windows */
 	PCIX_WRITEL(0, PCIX0_POM0SA);
diff -Nru a/arch/ppc/platforms/4xx/ibm440sp.c b/arch/ppc/platforms/4xx/ibm440sp.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/4xx/ibm440sp.c	2005-01-31 17:03:54 -07:00
@@ -0,0 +1,131 @@
+/*
+ * arch/ppc/platforms/4xx/ibm440sp.c
+ *
+ * PPC440SP I/O descriptions
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ * Copyright 2002-2005 MontaVista Software Inc.
+ *
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2003, 2004 Zultys Technologies
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <platforms/4xx/ibm440sp.h>
+#include <asm/ocp.h>
+
+static struct ocp_func_emac_data ibm440sp_emac0_def = {
+	.rgmii_idx	= -1,		/* No RGMII */
+	.rgmii_mux	= -1,		/* No RGMII */
+	.zmii_idx       = -1,           /* No ZMII */
+	.zmii_mux       = -1,           /* No ZMII */
+	.mal_idx        = 0,            /* MAL device index */
+	.mal_rx_chan    = 0,            /* MAL rx channel number */
+	.mal_tx_chan    = 0,            /* MAL tx channel number */
+	.wol_irq        = 61,  		/* WOL interrupt number */
+	.mdio_idx       = -1,           /* No shared MDIO */
+	.tah_idx	= -1,		/* No TAH */
+	.jumbo		= 1,		/* Jumbo frames supported */
+};
+OCP_SYSFS_EMAC_DATA()
+
+static struct ocp_func_mal_data ibm440sp_mal0_def = {
+	.num_tx_chans   = 4,    	/* Number of TX channels */
+	.num_rx_chans   = 4,    	/* Number of RX channels */
+	.txeob_irq	= 38,		/* TX End Of Buffer IRQ  */
+	.rxeob_irq	= 39,		/* RX End Of Buffer IRQ  */
+	.txde_irq	= 34,		/* TX Descriptor Error IRQ */
+	.rxde_irq	= 35,		/* RX Descriptor Error IRQ */
+	.serr_irq	= 33,		/* MAL System Error IRQ    */
+};
+OCP_SYSFS_MAL_DATA()
+
+static struct ocp_func_iic_data ibm440sp_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+
+static struct ocp_func_iic_data ibm440sp_iic1_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+OCP_SYSFS_IIC_DATA()
+
+struct ocp_def core_ocp[] = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_OPB,
+	  .index	= 0,
+	  .paddr	= 0x0000000140000000ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= PPC440SP_UART0_ADDR,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= PPC440SP_UART1_ADDR,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 2,
+	  .paddr	= PPC440SP_UART2_ADDR,
+	  .irq		= UART2_INT,
+	  .pm		= IBM_CPM_UART2,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 0,
+	  .paddr	= 0x00000001f0000400ULL,
+	  .irq		= 2,
+	  .pm		= IBM_CPM_IIC0,
+	  .additions	= &ibm440sp_iic0_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 1,
+	  .paddr	= 0x00000001f0000500ULL,
+	  .irq		= 3,
+	  .pm		= IBM_CPM_IIC1,
+	  .additions	= &ibm440sp_iic1_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .index	= 0,
+	  .paddr	= 0x00000001f0000700ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_MAL,
+	  .paddr	= OCP_PADDR_NA,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440sp_mal0_def,
+	  .show		= &ocp_show_mal_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= 0x00000001f0000800ULL,
+	  .irq		= 60,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440sp_emac0_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
diff -Nru a/arch/ppc/platforms/4xx/ibm440sp.h b/arch/ppc/platforms/4xx/ibm440sp.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/4xx/ibm440sp.h	2005-01-31 17:03:54 -07:00
@@ -0,0 +1,64 @@
+/*
+ * arch/ppc/platforms/4xx/ibm440sp.h
+ *
+ * PPC440SP definitions
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * Copyright 2004-2005 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef __PPC_PLATFORMS_IBM440SP_H
+#define __PPC_PLATFORMS_IBM440SP_H
+
+#include <linux/config.h>
+
+#include <asm/ibm44x.h>
+
+/* UART */
+#define PPC440SP_UART0_ADDR	0x00000001f0000200ULL
+#define PPC440SP_UART1_ADDR	0x00000001f0000300ULL
+#define PPC440SP_UART2_ADDR	0x00000001f0000600ULL
+#define UART0_INT		0
+#define UART1_INT		1
+#define UART2_INT		2
+
+/* Clock and Power Management */
+#define IBM_CPM_IIC0		0x80000000	/* IIC interface */
+#define IBM_CPM_IIC1		0x40000000	/* IIC interface */
+#define IBM_CPM_PCI		0x20000000	/* PCI bridge */
+#define IBM_CPM_CPU		    0x02000000	/* processor core */
+#define IBM_CPM_DMA		    0x01000000	/* DMA controller */
+#define IBM_CPM_BGO		    0x00800000	/* PLB to OPB bus arbiter */
+#define IBM_CPM_BGI		    0x00400000	/* OPB to PLB bridge */
+#define IBM_CPM_EBC		    0x00200000	/* External Bux Controller */
+#define IBM_CPM_EBM		    0x00100000	/* Ext Bus Master Interface */
+#define IBM_CPM_DMC		    0x00080000	/* SDRAM peripheral controller */
+#define IBM_CPM_PLB		    0x00040000	/* PLB bus arbiter */
+#define IBM_CPM_SRAM		0x00020000	/* SRAM memory controller */
+#define IBM_CPM_PPM		    0x00002000	/* PLB Performance Monitor */
+#define IBM_CPM_UIC1		0x00001000	/* Universal Interrupt Controller */
+#define IBM_CPM_GPIO0		0x00000800	/* General Purpose IO (??) */
+#define IBM_CPM_GPT		    0x00000400	/* General Purpose Timers  */
+#define IBM_CPM_UART0		0x00000200	/* serial port 0 */
+#define IBM_CPM_UART1		0x00000100	/* serial port 1 */
+#define IBM_CPM_UART2		0x00000100	/* serial port 1 */
+#define IBM_CPM_UIC0		0x00000080	/* Universal Interrupt Controller */
+#define IBM_CPM_TMRCLK		0x00000040	/* CPU timers */
+#define IBM_CPM_EMAC0  		0x00000020	/* EMAC 0     */
+
+#define DFLT_IBM4xx_PM		~(IBM_CPM_UIC | IBM_CPM_UIC1 | IBM_CPM_CPU \
+				| IBM_CPM_EBC | IBM_CPM_SRAM | IBM_CPM_BGO \
+				| IBM_CPM_EBM | IBM_CPM_PLB | IBM_CPM_OPB \
+				| IBM_CPM_TMRCLK | IBM_CPM_DMA | IBM_CPM_PCI \
+				| IBM_CPM_TAHOE0 | IBM_CPM_TAHOE1 \
+				| IBM_CPM_EMAC0 | IBM_CPM_EMAC1 \
+			  	| IBM_CPM_EMAC2 | IBM_CPM_EMAC3 )
+#endif /* __PPC_PLATFORMS_IBM440SP_H */
+#endif /* __KERNEL__ */
diff -Nru a/arch/ppc/platforms/4xx/luan.c b/arch/ppc/platforms/4xx/luan.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/4xx/luan.c	2005-01-31 17:03:54 -07:00
@@ -0,0 +1,387 @@
+/*
+ * arch/ppc/platforms/4xx/luan.c
+ *
+ * Luan board specific routines
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * Copyright 2004-2005 MontaVista Software Inc.
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
+#include <linux/types.h>
+#include <linux/major.h>
+#include <linux/blkdev.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/ide.h>
+#include <linux/initrd.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/dma.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ocp.h>
+#include <asm/pci-bridge.h>
+#include <asm/time.h>
+#include <asm/todc.h>
+#include <asm/bootinfo.h>
+#include <asm/ppc4xx_pic.h>
+#include <asm/ppcboot.h>
+
+#include <syslib/ibm44x_common.h>
+#include <syslib/ibm440gx_common.h>
+#include <syslib/ibm440sp_common.h>
+
+/*
+ * This is a horrible kludge, we eventually need to abstract this
+ * generic PHY stuff, so the  standard phy mode defines can be
+ * easily used from arch code.
+ */
+#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
+
+bd_t __res;
+
+static struct ibm44x_clocks clocks __initdata;
+
+static void __init
+luan_calibrate_decr(void)
+{
+	unsigned int freq;
+
+	if (mfspr(SPRN_CCR1) & CCR1_TCS)
+		freq = LUAN_TMR_CLK;
+	else
+		freq = clocks.cpu;
+
+	ibm44x_calibrate_decr(freq);
+}
+
+static int
+luan_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: IBM\n");
+	seq_printf(m, "machine\t\t: PPC440SP EVB (Luan)\n");
+
+	return 0;
+}
+
+static inline int
+luan_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
+
+	/* PCIX0 in adapter mode, no host interrupt routing */
+
+	/* PCIX1 */
+	if (hose->index == 0) {
+		static char pci_irq_table[][4] =
+		/*
+		 *	PCI IDSEL/INTPIN->INTLINE
+		 *	  A   B   C   D
+		 */
+		{
+			{ 49, 49, 49, 49 },	/* IDSEL 1 - PCIX1 Slot 0 */
+			{ 49, 49, 49, 49 },	/* IDSEL 2 - PCIX1 Slot 1 */
+			{ 49, 49, 49, 49 },	/* IDSEL 3 - PCIX1 Slot 2 */
+			{ 49, 49, 49, 49 },	/* IDSEL 4 - PCIX1 Slot 3 */
+		};
+		const long min_idsel = 1, max_idsel = 4, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	/* PCIX2 */
+	} else if (hose->index == 1) {
+		static char pci_irq_table[][4] =
+		/*
+		 *	PCI IDSEL/INTPIN->INTLINE
+		 *	  A   B   C   D
+		 */
+		{
+			{ 50, 50, 50, 50 },	/* IDSEL 1 - PCIX2 Slot 0 */
+			{ 50, 50, 50, 50 },	/* IDSEL 2 - PCIX2 Slot 1 */
+			{ 50, 50, 50, 50 },	/* IDSEL 3 - PCIX2 Slot 2 */
+			{ 50, 50, 50, 50 },	/* IDSEL 4 - PCIX2 Slot 3 */
+		};
+		const long min_idsel = 1, max_idsel = 4, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	}
+	return -1;
+}
+
+static void __init luan_set_emacdata(void)
+{
+	struct ocp_def *def;
+	struct ocp_func_emac_data *emacdata;
+
+	/* Set phy_map, phy_mode, and mac_addr for the EMAC */
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
+	emacdata = def->additions;
+	emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
+	emacdata->phy_mode = PHY_MODE_GMII;
+	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+}
+
+#define PCIX_READW(offset) \
+	(readw((void *)((u32)pcix_reg_base+offset)))
+
+#define PCIX_WRITEW(value, offset) \
+	(writew(value, (void *)((u32)pcix_reg_base+offset)))
+
+#define PCIX_WRITEL(value, offset) \
+	(writel(value, (void *)((u32)pcix_reg_base+offset)))
+
+static void __init
+luan_setup_pcix(void)
+{
+	int i;
+	void *pcix_reg_base;
+
+	for (i=0;i<3;i++) {
+		pcix_reg_base = ioremap64(PCIX0_REG_BASE + i*PCIX_REG_OFFSET, PCIX_REG_SIZE);
+
+		/* Enable PCIX0 I/O, Mem, and Busmaster cycles */
+		PCIX_WRITEW(PCIX_READW(PCIX0_COMMAND) | PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER, PCIX0_COMMAND);
+
+		/* Disable all windows */
+		PCIX_WRITEL(0, PCIX0_POM0SA);
+		PCIX_WRITEL(0, PCIX0_POM1SA);
+		PCIX_WRITEL(0, PCIX0_POM2SA);
+		PCIX_WRITEL(0, PCIX0_PIM0SA);
+		PCIX_WRITEL(0, PCIX0_PIM0SAH);
+		PCIX_WRITEL(0, PCIX0_PIM1SA);
+		PCIX_WRITEL(0, PCIX0_PIM2SA);
+		PCIX_WRITEL(0, PCIX0_PIM2SAH);
+
+		/*
+		 * Setup 512MB PLB->PCI outbound mem window
+		 * (a_n000_0000->0_n000_0000)
+		 * */
+		PCIX_WRITEL(0x0000000a, PCIX0_POM0LAH);
+		PCIX_WRITEL(0x80000000 | i*LUAN_PCIX_MEM_SIZE, PCIX0_POM0LAL);
+		PCIX_WRITEL(0x00000000, PCIX0_POM0PCIAH);
+		PCIX_WRITEL(0x80000000 | i*LUAN_PCIX_MEM_SIZE, PCIX0_POM0PCIAL);
+		PCIX_WRITEL(0xe0000001, PCIX0_POM0SA);
+
+		/* Setup 2GB PCI->PLB inbound memory window at 0, enable MSIs */
+		PCIX_WRITEL(0x00000000, PCIX0_PIM0LAH);
+		PCIX_WRITEL(0x00000000, PCIX0_PIM0LAL);
+		PCIX_WRITEL(0xe0000007, PCIX0_PIM0SA);
+		PCIX_WRITEL(0xffffffff, PCIX0_PIM0SAH);
+
+		iounmap(pcix_reg_base);
+	}
+
+	eieio();
+}
+
+static void __init
+luan_setup_hose(struct pci_controller *hose,
+		int lower_mem,
+		int upper_mem,
+		int cfga,
+		int cfgd,
+		u64 pcix_io_base)
+{
+	char name[20];
+
+	sprintf(name, "PCIX%d host bridge", hose->index);
+
+	hose->pci_mem_offset = LUAN_PCIX_MEM_OFFSET;
+
+	pci_init_resource(&hose->io_resource,
+			LUAN_PCIX_LOWER_IO,
+			LUAN_PCIX_UPPER_IO,
+			IORESOURCE_IO,
+			name);
+
+	pci_init_resource(&hose->mem_resources[0],
+			lower_mem,
+			upper_mem,
+			IORESOURCE_MEM,
+			name);
+
+	hose->io_space.start = LUAN_PCIX_LOWER_IO;
+	hose->io_space.end = LUAN_PCIX_UPPER_IO;
+	hose->mem_space.start = lower_mem;
+	hose->mem_space.end = upper_mem;
+	isa_io_base =
+		(unsigned long)ioremap64(pcix_io_base, PCIX_IO_SIZE);
+	hose->io_base_virt = (void *)isa_io_base;
+
+	setup_indirect_pci(hose, cfga, cfgd);
+	hose->set_cfg_type = 1;
+}
+
+static void __init
+luan_setup_hoses(void)
+{
+	struct pci_controller *hose1, *hose2;
+
+	/* Configure windows on the PCI-X host bridge */
+	luan_setup_pcix();
+
+	/* Allocate hoses for PCIX1 and PCIX2 */
+	hose1 = pcibios_alloc_controller();
+	hose2 = pcibios_alloc_controller();
+	if (!hose1 || !hose2)
+		return;
+
+	/* Setup PCIX1 */
+	hose1->first_busno = 0;
+	hose1->last_busno = 0xff;
+
+	luan_setup_hose(hose1,
+			LUAN_PCIX1_LOWER_MEM,
+			LUAN_PCIX1_UPPER_MEM,
+			PCIX1_CFGA,
+			PCIX1_CFGD,
+			PCIX1_IO_BASE);
+
+	hose1->last_busno = pciauto_bus_scan(hose1, hose1->first_busno);
+
+	/* Setup PCIX2 */
+	hose2->first_busno = hose1->last_busno + 1;
+	hose2->last_busno = 0xff;
+
+	luan_setup_hose(hose2,
+			LUAN_PCIX2_LOWER_MEM,
+			LUAN_PCIX2_UPPER_MEM,
+			PCIX2_CFGA,
+			PCIX2_CFGD,
+			PCIX2_IO_BASE);
+
+	hose2->last_busno = pciauto_bus_scan(hose2, hose2->first_busno);
+
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = luan_map_irq;
+}
+
+TODC_ALLOC();
+
+static void __init
+luan_early_serial_map(void)
+{
+	struct uart_port port;
+
+	/* Setup ioremapped serial port access */
+	memset(&port, 0, sizeof(port));
+	port.membase = ioremap64(PPC440SP_UART0_ADDR, 8);
+	port.irq = UART0_INT;
+	port.uartclk = clocks.uart0;
+	port.regshift = 0;
+	port.iotype = SERIAL_IO_MEM;
+	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	port.line = 0;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 0 failed\n");
+	}
+
+	port.membase = ioremap64(PPC440SP_UART1_ADDR, 8);
+	port.irq = UART1_INT;
+	port.uartclk = clocks.uart1;
+	port.line = 1;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 1 failed\n");
+	}
+
+	port.membase = ioremap64(PPC440SP_UART2_ADDR, 8);
+	port.irq = UART2_INT;
+	port.uartclk = BASE_BAUD;
+	port.line = 2;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 2 failed\n");
+	}
+}
+
+static void __init
+luan_setup_arch(void)
+{
+	luan_set_emacdata();
+
+#if !defined(CONFIG_BDI_SWITCH)
+	/*
+	 * The Abatron BDI JTAG debugger does not tolerate others
+	 * mucking with the debug registers.
+	 */
+        mtspr(SPRN_DBCR0, (DBCR0_TDE | DBCR0_IDM));
+#endif
+
+	/*
+	 * Determine various clocks.
+	 * To be completely correct we should get SysClk
+	 * from FPGA, because it can be changed by on-board switches
+	 * --ebs
+	 */
+	/* 440GX and 440SP clocking is the same -mdp */
+	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
+	ocp_sys_info.opb_bus_freq = clocks.opb;
+
+	/* init to some ~sane value until calibrate_delay() runs */
+        loops_per_jiffy = 50000000/HZ;
+
+	/* Setup PCIXn host bridges */
+	luan_setup_hoses();
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+
+	luan_early_serial_map();
+
+	/* Identify the system */
+	printk("Luan port (MontaVista Software, Inc. <source@mvista.com>)\n");
+}
+
+void __init platform_init(unsigned long r3, unsigned long r4,
+		unsigned long r5, unsigned long r6, unsigned long r7)
+{
+	parse_bootinfo(find_bootinfo());
+
+	/*
+	 * If we were passed in a board information, copy it into the
+	 * residual data area.
+	 */
+	if (r3)
+		__res = *(bd_t *)(r3 + KERNELBASE);
+
+	ibm44x_platform_init();
+
+	ppc_md.setup_arch = luan_setup_arch;
+	ppc_md.show_cpuinfo = luan_show_cpuinfo;
+	ppc_md.find_end_of_memory = ibm440sp_find_end_of_memory;
+	ppc_md.get_irq = NULL;		/* Set in ppc4xx_pic_init() */
+
+	ppc_md.calibrate_decr = luan_calibrate_decr;
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = luan_early_serial_map;
+#endif
+}
diff -Nru a/arch/ppc/platforms/4xx/luan.h b/arch/ppc/platforms/4xx/luan.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/4xx/luan.h	2005-01-31 17:03:54 -07:00
@@ -0,0 +1,80 @@
+/*
+ * arch/ppc/platforms/4xx/luan.h
+ *
+ * Luan board definitions
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * Copyright 2004-2005 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_LUAN_H__
+#define __ASM_LUAN_H__
+
+#include <linux/config.h>
+#include <platforms/4xx/ibm440sp.h>
+
+/* F/W TLB mapping used in bootloader glue to reset EMAC */
+#define PPC44x_EMAC0_MR0	0xa0000800
+
+/* Location of MAC addresses in PIBS image */
+#define PIBS_FLASH_BASE		0xffe00000
+#define PIBS_MAC_BASE		(PIBS_FLASH_BASE+0x1b0400)
+
+/* External timer clock frequency */
+#define LUAN_TMR_CLK		25000000
+
+/* Flash */
+#define LUAN_FPGA_REG_0			0x0000000148300000ULL
+#define LUAN_BOOT_LARGE_FLASH(x)	(x & 0x40)
+#define LUAN_SMALL_FLASH_LOW		0x00000001ff900000ULL
+#define LUAN_SMALL_FLASH_HIGH		0x00000001ffe00000ULL
+#define LUAN_SMALL_FLASH_SIZE		0x100000
+#define LUAN_LARGE_FLASH_LOW		0x00000001ff800000ULL
+#define LUAN_LARGE_FLASH_HIGH		0x00000001ffc00000ULL
+#define LUAN_LARGE_FLASH_SIZE		0x400000
+
+/*
+ * Serial port defines
+ */
+#define RS_TABLE_SIZE	3
+
+/* PIBS defined UART mappings, used before early_serial_setup */
+#define UART0_IO_BASE	(u8 *) 0xa0000200
+#define UART1_IO_BASE	(u8 *) 0xa0000300
+#define UART2_IO_BASE	(u8 *) 0xa0000600
+
+#define BASE_BAUD	11059200
+#define STD_UART_OP(num)					\
+	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
+		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
+		iomem_base: UART##num##_IO_BASE,		\
+		io_type: SERIAL_IO_MEM},
+
+#define SERIAL_PORT_DFNS	\
+	STD_UART_OP(0)		\
+	STD_UART_OP(1)		\
+	STD_UART_OP(2)
+
+/* PCI support */
+#define LUAN_PCIX_LOWER_IO	0x00000000
+#define LUAN_PCIX_UPPER_IO	0x0000ffff
+#define LUAN_PCIX0_LOWER_MEM	0x80000000
+#define LUAN_PCIX0_UPPER_MEM	0x9fffffff
+#define LUAN_PCIX1_LOWER_MEM	0xa0000000
+#define LUAN_PCIX1_UPPER_MEM	0xbfffffff
+#define LUAN_PCIX2_LOWER_MEM	0xc0000000
+#define LUAN_PCIX2_UPPER_MEM	0xdfffffff
+
+#define LUAN_PCIX_MEM_SIZE	0x20000000
+#define LUAN_PCIX_MEM_OFFSET	0x00000000
+
+#endif				/* __ASM_LUAN_H__ */
+#endif				/* __KERNEL__ */
diff -Nru a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
--- a/arch/ppc/platforms/4xx/ocotea.c	2005-01-31 17:03:54 -07:00
+++ b/arch/ppc/platforms/4xx/ocotea.c	2005-01-31 17:03:54 -07:00
@@ -5,7 +5,7 @@
  *
  * Matt Porter <mporter@kernel.crashing.org>
  *
- * Copyright 2003-2004 MontaVista Software Inc.
+ * Copyright 2003-2005 MontaVista Software Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -163,7 +163,7 @@
 {
 	void *pcix_reg_base;
 
-	pcix_reg_base = ioremap64(PCIX0_REG_BASE, PCIX0_REG_SIZE);
+	pcix_reg_base = ioremap64(PCIX0_REG_BASE, PCIX_REG_SIZE);
 
 	/* Enable PCIX0 I/O, Mem, and Busmaster cycles */
 	PCIX_WRITEW(PCIX_READW(PCIX0_COMMAND) | PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER, PCIX0_COMMAND);
diff -Nru a/arch/ppc/platforms/4xx/ocotea.h b/arch/ppc/platforms/4xx/ocotea.h
--- a/arch/ppc/platforms/4xx/ocotea.h	2005-01-31 17:03:54 -07:00
+++ b/arch/ppc/platforms/4xx/ocotea.h	2005-01-31 17:03:54 -07:00
@@ -3,9 +3,9 @@
  *
  * Ocotea board definitions
  *
- * Matt Porter <mporter@mvista.com>
+ * Matt Porter <mporter@kernel.crashing.org>
  *
- * Copyright 2003 MontaVista Software Inc.
+ * Copyright 2003-2005 MontaVista Software Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -22,13 +22,13 @@
 #include <platforms/4xx/ibm440gx.h>
 
 /* F/W TLB mapping used in bootloader glue to reset EMAC */
-#define PPC44x_EMAC0_MR0	0xE0000800
+#define PPC44x_EMAC0_MR0	0xe0000800
 
 /* Location of MAC addresses in PIBS image */
-#define OCOTEA_PIBS_FLASH	0xfff00000
-#define OCOTEA_PIBS_MAC_BASE	(OCOTEA_PIBS_FLASH+0xb0500)
-#define OCOTEA_PIBS_MAC_SIZE	0x200
-#define OCOTEA_PIBS_MAC_OFFSET	0x100
+#define PIBS_FLASH_BASE		0xfff00000
+#define PIBS_MAC_BASE		(PIBS_FLASH_BASE+0xb0500)
+#define PIBS_MAC_SIZE		0x200
+#define PIBS_MAC_OFFSET		0x100
 
 /* External timer clock frequency */
 #define OCOTEA_TMR_CLK	25000000
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2005-01-31 17:03:53 -07:00
+++ b/arch/ppc/syslib/Makefile	2005-01-31 17:03:53 -07:00
@@ -13,6 +13,7 @@
 obj-$(CONFIG_44x)		+= ibm44x_common.o
 obj-$(CONFIG_440GP)		+= ibm440gp_common.o
 obj-$(CONFIG_440GX)		+= ibm440gx_common.o
+obj-$(CONFIG_440SP)		+= ibm440gx_common.o ibm440sp_common.o
 ifeq ($(CONFIG_4xx),y)
 ifeq ($(CONFIG_VIRTEX_II_PRO),y)
 obj-$(CONFIG_40x)		+= xilinx_pic.o
@@ -52,6 +53,7 @@
 obj-$(CONFIG_K2)		+= i8259.o indirect_pci.o todc_time.o \
 					pci_auto.o
 obj-$(CONFIG_LOPEC)		+= i8259.o pci_auto.o todc_time.o
+obj-$(CONFIG_LUAN)		+= indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_KATANA)		+= pci_auto.o
 obj-$(CONFIG_MCPN765)		+= todc_time.o indirect_pci.o pci_auto.o \
 					open_pic.o i8259.o hawk_common.o
diff -Nru a/arch/ppc/syslib/ibm440sp_common.c b/arch/ppc/syslib/ibm440sp_common.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/ibm440sp_common.c	2005-01-31 17:03:54 -07:00
@@ -0,0 +1,71 @@
+/*
+ * arch/ppc/syslib/ibm440sp_common.c
+ *
+ * PPC440SP system library
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ * Copyright 2002-2005 MontaVista Software Inc.
+ *
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2003, 2004 Zultys Technologies
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/serial.h>
+
+#include <asm/param.h>
+#include <asm/ibm44x.h>
+#include <asm/mmu.h>
+#include <asm/machdep.h>
+#include <asm/time.h>
+#include <asm/ppc4xx_pic.h>
+
+/*
+ * Read the 440SP memory controller to get size of system memory.
+ */
+unsigned long __init ibm440sp_find_end_of_memory(void)
+{
+	u32 i;
+	u32 mem_size = 0;
+
+	/* Read two bank sizes and sum */
+	for (i=0; i<2; i++)
+		switch (mfdcr(DCRN_MQ0_BS0BAS + i) & MQ0_CONFIG_SIZE_MASK) {
+			case MQ0_CONFIG_SIZE_8M:
+				mem_size += PPC44x_MEM_SIZE_8M;
+				break;
+			case MQ0_CONFIG_SIZE_16M:
+				mem_size += PPC44x_MEM_SIZE_16M;
+				break;
+			case MQ0_CONFIG_SIZE_32M:
+				mem_size += PPC44x_MEM_SIZE_32M;
+				break;
+			case MQ0_CONFIG_SIZE_64M:
+				mem_size += PPC44x_MEM_SIZE_64M;
+				break;
+			case MQ0_CONFIG_SIZE_128M:
+				mem_size += PPC44x_MEM_SIZE_128M;
+				break;
+			case MQ0_CONFIG_SIZE_256M:
+				mem_size += PPC44x_MEM_SIZE_256M;
+				break;
+			case MQ0_CONFIG_SIZE_512M:
+				mem_size += PPC44x_MEM_SIZE_512M;
+				break;
+			case MQ0_CONFIG_SIZE_1G:
+				mem_size += PPC44x_MEM_SIZE_1G;
+				break;
+			case MQ0_CONFIG_SIZE_2G:
+				mem_size += PPC44x_MEM_SIZE_2G;
+				break;
+			default:
+				break;
+		}
+	return mem_size;
+}
diff -Nru a/arch/ppc/syslib/ibm440sp_common.h b/arch/ppc/syslib/ibm440sp_common.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/ibm440sp_common.h	2005-01-31 17:03:54 -07:00
@@ -0,0 +1,25 @@
+/*
+ * arch/ppc/syslib/ibm440sp_common.h
+ *
+ * PPC440SP system library
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ * Copyright 2004-2005 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#ifdef __KERNEL__
+#ifndef __PPC_SYSLIB_IBM440SP_COMMON_H
+#define __PPC_SYSLIB_IBM440SP_COMMON_H
+
+#ifndef __ASSEMBLY__
+
+extern unsigned long __init ibm440sp_find_end_of_memory(void);
+
+#endif /* __ASSEMBLY__ */
+#endif /* __PPC_SYSLIB_IBM440SP_COMMON_H */
+#endif /* __KERNEL__ */
diff -Nru a/arch/ppc/syslib/ibm44x_common.c b/arch/ppc/syslib/ibm44x_common.c
--- a/arch/ppc/syslib/ibm44x_common.c	2005-01-31 17:03:53 -07:00
+++ b/arch/ppc/syslib/ibm44x_common.c	2005-01-31 17:03:54 -07:00
@@ -4,7 +4,7 @@
  * PPC44x system library
  *
  * Matt Porter <mporter@kernel.crashing.org>
- * Copyright 2002-2004 MontaVista Software Inc.
+ * Copyright 2002-2005 MontaVista Software Inc.
  *
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  * Copyright (c) 2003, 2004 Zultys Technologies
@@ -39,11 +39,17 @@
 	 * address in the 440's 36-bit address space.  Fix
 	 * them up with the appropriate ERPN
 	 */
-	if ((addr >= PPC44x_IO_LO) && (addr < PPC44x_IO_HI))
+	if ((addr >= PPC44x_IO_LO) && (addr <= PPC44x_IO_HI))
 		page_4gb = PPC44x_IO_PAGE;
-	else if ((addr >= PPC44x_PCICFG_LO) && (addr < PPC44x_PCICFG_HI))
+	else if ((addr >= PPC44x_PCI0CFG_LO) && (addr <= PPC44x_PCI0CFG_HI))
 		page_4gb = PPC44x_PCICFG_PAGE;
-	else if ((addr >= PPC44x_PCIMEM_LO) && (addr < PPC44x_PCIMEM_HI))
+#ifdef CONFIG_440SP
+	else if ((addr >= PPC44x_PCI1CFG_LO) && (addr <= PPC44x_PCI1CFG_HI))
+		page_4gb = PPC44x_PCICFG_PAGE;
+	else if ((addr >= PPC44x_PCI2CFG_LO) && (addr <= PPC44x_PCI2CFG_HI))
+		page_4gb = PPC44x_PCICFG_PAGE;
+#endif
+	else if ((addr >= PPC44x_PCIMEM_LO) && (addr <= PPC44x_PCIMEM_HI))
 		page_4gb = PPC44x_PCIMEM_PAGE;
 
 	return (page_4gb | addr);
diff -Nru a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
--- a/include/asm-ppc/ibm44x.h	2005-01-31 17:03:54 -07:00
+++ b/include/asm-ppc/ibm44x.h	2005-01-31 17:03:54 -07:00
@@ -3,9 +3,9 @@
  *
  * PPC44x definitions
  *
- * Matt Porter <mporter@mvista.com>
+ * Matt Porter <mporter@kernel.crashing.org>
  *
- * Copyright 2002-2003 MontaVista Software Inc.
+ * Copyright 2002-2005 MontaVista Software Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -34,23 +34,55 @@
 /* Lowest TLB slot consumed by the default pinned TLBs */
 #define PPC44x_LOW_SLOT		63
 
+/* LS 32-bits of UART0 physical address location for early serial text debug */
+#ifdef CONFIG_440SP
+#define UART0_PHYS_IO_BASE	0xf0000200
+#else
+#define UART0_PHYS_IO_BASE	0x40000200
+#endif
+
+/*
+ * XXX This 36-bit trap stuff will move somewhere in syslib/
+ * when we rework/abstract the PPC44x PCI-X handling -mdp
+ */
+
 /*
  * Standard 4GB "page" definitions
  */
+#ifdef CONFIG_440SP
+#define	PPC44x_IO_PAGE		0x0000000100000000ULL
+#define	PPC44x_PCICFG_PAGE	0x0000000900000000ULL
+#define	PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
+#define	PPC44x_PCIMEM_PAGE	0x0000000a00000000ULL
+#else
 #define	PPC44x_IO_PAGE		0x0000000100000000ULL
 #define	PPC44x_PCICFG_PAGE	0x0000000200000000ULL
 #define	PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
 #define	PPC44x_PCIMEM_PAGE	0x0000000300000000ULL
+#endif
 
 /*
  * 36-bit trap ranges
  */
-#define PPC44x_IO_LO		0x40000000
-#define PPC44x_IO_HI		0x40001000
-#define PPC44x_PCICFG_LO	0x0ec00000
-#define PPC44x_PCICFG_HI	0x0ec7ffff
-#define PPC44x_PCIMEM_LO	0x80002000
-#define PPC44x_PCIMEM_HI	0xffffffff
+#ifdef CONFIG_440SP
+#define PPC44x_IO_LO		0xf0000000UL
+#define PPC44x_IO_HI		0xf0000fffUL
+#define PPC44x_PCI0CFG_LO	0x0ec00000UL
+#define PPC44x_PCI0CFG_HI	0x0ec00007UL
+#define PPC44x_PCI1CFG_LO	0x1ec00000UL
+#define PPC44x_PCI1CFG_HI	0x1ec00007UL
+#define PPC44x_PCI2CFG_LO	0x2ec00000UL
+#define PPC44x_PCI2CFG_HI	0x2ec00007UL
+#define PPC44x_PCIMEM_LO	0x80000000UL
+#define PPC44x_PCIMEM_HI	0xdfffffffUL
+#else
+#define PPC44x_IO_LO		0x40000000UL
+#define PPC44x_IO_HI		0x40000fffUL
+#define PPC44x_PCI0CFG_LO	0x0ec00000UL
+#define PPC44x_PCI0CFG_HI	0x0ec00007UL
+#define PPC44x_PCIMEM_LO	0x80002000UL
+#define PPC44x_PCIMEM_HI	0xffffffffUL
+#endif
 
 /*
  * The "residual" board information structure the boot loader passes
@@ -62,8 +94,8 @@
  * DCRN definitions
  */
 
-#ifdef CONFIG_440GX
-/* CPRs */
+
+/* CPRs (440GX and 440SP) */
 #define DCRN_CPR_CONFIG_ADDR	0xc
 #define DCRN_CPR_CONFIG_DATA	0xd
 
@@ -84,7 +116,7 @@
 	mtdcr(DCRN_CPR_CONFIG_ADDR, offset); \
 	mtdcr(DCRN_CPR_CONFIG_DATA, data);})
 
-/* SDRs */
+/* SDRs (440GX and 440SP) */
 #define DCRN_SDR_CONFIG_ADDR 	0xe
 #define DCRN_SDR_CONFIG_DATA	0xf
 #define DCRN_SDR_PFC0		0x4100
@@ -127,9 +159,8 @@
 #define SDR_WRITE(offset, data) ({\
 	mtdcr(DCRN_SDR_CONFIG_ADDR, offset); \
 	mtdcr(DCRN_SDR_CONFIG_DATA,data);})
-#endif /* CONFIG_440GX */
 
-/* Base DCRNs */
+/* DMA (excluding 440SP) */
 #define DCRN_DMA0_BASE		0x100
 #define DCRN_DMA1_BASE		0x108
 #define DCRN_DMA2_BASE		0x110
@@ -163,7 +194,7 @@
 #define UICB_UIC1NC		0x10000000
 #define UICB_UIC2NC		0x04000000
 
-/* 440GP MAL DCRs */
+/* 440 MAL DCRs */
 #define DCRN_MALCR(base)		(base + 0x0)	/* Configuration */
 #define DCRN_MALESR(base)		(base + 0x1)	/* Error Status */
 #define DCRN_MALIER(base)		(base + 0x2)	/* Interrupt Enable */
@@ -194,7 +225,6 @@
 #define DCRN_MALRCBS2(base)	((base) + 0x62)	/* Channel Rx 2 Channel Buffer Size */
 #define DCRN_MALRCBS3(base)	((base) + 0x63)	/* Channel Rx 3 Channel Buffer Size */
 
-
 #define MALCR_MMSR		0x80000000	/* MAL Software reset */
 #define MALCR_PLBP_1		0x00400000	/* MAL reqest priority: */
 #define MALCR_PLBP_2		0x00800000	/* lowsest is 00 */
@@ -309,7 +339,7 @@
 #define DCRN_SLP	(DCRN_DMASR_BASE + 0x5)	/* DMA Sleep Register */
 #define DCRN_POL	(DCRN_DMASR_BASE + 0x6)	/* DMA Polarity Register */
 
-/* 440GP DRAM controller DCRs */
+/* 440GP/440GX SDRAM controller DCRs */
 #define DCRN_SDRAM0_CFGADDR		0x010
 #define DCRN_SDRAM0_CFGDATA		0x011
 
@@ -335,13 +365,35 @@
 #define PPC44x_MEM_SIZE_128M		0x08000000
 #define PPC44x_MEM_SIZE_256M		0x10000000
 #define PPC44x_MEM_SIZE_512M		0x20000000
+#define PPC44x_MEM_SIZE_1G		0x40000000
+#define PPC44x_MEM_SIZE_2G		0x80000000
 
-#ifdef CONFIG_440GX
-/* Internal SRAM Controller */
-#define DCRN_SRAM0_SB0CR	0x020
-#define DCRN_SRAM0_SB1CR	0x021
-#define DCRN_SRAM0_SB2CR	0x022
-#define DCRN_SRAM0_SB3CR	0x023
+/* 440SP memory controller DCRs */
+#define DCRN_MQ0_BS0BAS			0x40
+#define DCRN_MQ0_BS1BAS			0x41
+
+#define MQ0_CONFIG_SIZE_MASK		0x0000fff0
+#define MQ0_CONFIG_SIZE_8M		0x0000ffc0
+#define MQ0_CONFIG_SIZE_16M		0x0000ff80
+#define MQ0_CONFIG_SIZE_32M		0x0000ff00
+#define MQ0_CONFIG_SIZE_64M		0x0000fe00
+#define MQ0_CONFIG_SIZE_128M		0x0000fc00
+#define MQ0_CONFIG_SIZE_256M		0x0000f800
+#define MQ0_CONFIG_SIZE_512M		0x0000f000
+#define MQ0_CONFIG_SIZE_1G		0x0000e000
+#define MQ0_CONFIG_SIZE_2G		0x0000c000
+
+/* Internal SRAM Controller 440GX/440SP */
+#ifdef CONFIG_440SP
+#define DCRN_SRAM0_BASE		0x100
+#else /* 440GX */
+#define DCRN_SRAM0_BASE		0x000
+#endif
+
+#define DCRN_SRAM0_SB0CR	(DCRN_SRAM0_BASE + 0x020)
+#define DCRN_SRAM0_SB1CR	(DCRN_SRAM0_BASE + 0x021)
+#define DCRN_SRAM0_SB2CR	(DCRN_SRAM0_BASE + 0x022)
+#define DCRN_SRAM0_SB3CR	(DCRN_SRAM0_BASE + 0x023)
 #define  SRAM_SBCR_BAS0		0x80000000
 #define  SRAM_SBCR_BAS1		0x80010000
 #define  SRAM_SBCR_BAS2		0x80020000
@@ -350,16 +402,16 @@
 #define  SRAM_SBCR_BS_64KB	0x00000800
 #define  SRAM_SBCR_BU_RO	0x00000080
 #define  SRAM_SBCR_BU_RW	0x00000180
-#define DCRN_SRAM0_BEAR		0x024
-#define DCRN_SRAM0_BESR0	0x025
-#define DCRN_SRAM0_BESR1	0x026
-#define DCRN_SRAM0_PMEG		0x027
-#define DCRN_SRAM0_CID		0x028
-#define DCRN_SRAM0_REVID	0x029
-#define DCRN_SRAM0_DPC		0x02a
+#define DCRN_SRAM0_BEAR		(DCRN_SRAM0_BASE + 0x024)
+#define DCRN_SRAM0_BESR0	(DCRN_SRAM0_BASE + 0x025)
+#define DCRN_SRAM0_BESR1	(DCRN_SRAM0_BASE + 0x026)
+#define DCRN_SRAM0_PMEG		(DCRN_SRAM0_BASE + 0x027)
+#define DCRN_SRAM0_CID		(DCRN_SRAM0_BASE + 0x028)
+#define DCRN_SRAM0_REVID	(DCRN_SRAM0_BASE + 0x029)
+#define DCRN_SRAM0_DPC		(DCRN_SRAM0_BASE + 0x02a)
 #define  SRAM_DPC_ENABLE	0x80000000
 
-/* L2 Cache Controller */
+/* L2 Cache Controller 440GX/440SP */
 #define DCRN_L2C0_CFG		0x030
 #define  L2C_CFG_L2M		0x80000000
 #define  L2C_CFG_ICU		0x40000000
@@ -409,13 +461,29 @@
 #define  L2C_SNP_SSR_MASK	0x0000f000
 #define  L2C_SNP_SSR_32G	0x0000f000
 #define  L2C_SNP_ESR		0x00000800
-#endif /* CONFIG_440GX */
 
 /*
  * PCI-X definitions
  */
-#define PCIX0_REG_BASE		0x20ec80000ULL
-#define PCIX0_REG_SIZE		0x200
+#define PCIX0_CFGA		0x0ec00000UL
+#define PCIX1_CFGA		0x1ec00000UL
+#define PCIX2_CFGA		0x2ec00000UL
+#define PCIX0_CFGD		0x0ec00004UL
+#define PCIX1_CFGD		0x1ec00004UL
+#define PCIX2_CFGD		0x2ec00004UL
+
+#define PCIX0_IO_BASE		0x0000000908000000ULL
+#define PCIX1_IO_BASE		0x0000000908000000ULL
+#define PCIX2_IO_BASE		0x0000000908000000ULL
+#define PCIX_IO_SIZE		0x00010000
+
+#ifdef CONFIG_440SP
+#define PCIX0_REG_BASE		0x000000090ec80000ULL
+#else
+#define PCIX0_REG_BASE		0x000000020ec80000ULL
+#endif
+#define PCIX_REG_OFFSET		0x10000000
+#define PCIX_REG_SIZE		0x200
 
 #define PCIX0_VENDID		0x000
 #define PCIX0_DEVID		0x002
@@ -512,8 +580,6 @@
 #else
 #define NR_UICS 2
 #endif
-
-#define BD_EMAC_ADDR(e,i) bi_enetaddr[e][i]
 
 #include <asm/ibm4xx.h>
 
diff -Nru a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
--- a/include/asm-ppc/ibm4xx.h	2005-01-31 17:03:54 -07:00
+++ b/include/asm-ppc/ibm4xx.h	2005-01-31 17:03:54 -07:00
@@ -101,6 +101,10 @@
 #include <platforms/4xx/ebony.h>
 #endif
 
+#if defined(CONFIG_LUAN)
+#include <platforms/4xx/luan.h>
+#endif
+
 #if defined(CONFIG_OCOTEA)
 #include <platforms/4xx/ocotea.h>
 #endif
