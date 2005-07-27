Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVG0Pos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVG0Pos (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVG0PnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:43:24 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:64970 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261304AbVG0Plc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:41:32 -0400
Date: Wed, 27 Jul 2005 10:41:13 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 13/14] ppc32: Remove board support for EP405
Message-ID: <Pine.LNX.4.61.0507271040470.12237@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the EP405 board is no longer maintained and thus being removed

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 715aa4926267a11452ddd3f3abffc19bdefdcb88
tree 6c3d041e5bc4058993dcd2707eb2c5657acfaa41
parent 13046e6e40e2f14b30e9a159791eb330f7204bf4
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 25 Jul 2005 22:19:05 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 25 Jul 2005 22:19:05 -0500

 arch/ppc/boot/simple/embed_config.c |  105 ------
 arch/ppc/configs/ep405_defconfig    |  572 -----------------------------------
 arch/ppc/platforms/4xx/Kconfig      |   17 -
 arch/ppc/platforms/4xx/Makefile     |    1 
 arch/ppc/platforms/4xx/ep405.c      |  197 ------------
 arch/ppc/platforms/4xx/ep405.h      |   54 ---
 include/asm-ppc/ibm4xx.h            |    4 
 7 files changed, 7 insertions(+), 943 deletions(-)

diff --git a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
--- a/arch/ppc/boot/simple/embed_config.c
+++ b/arch/ppc/boot/simple/embed_config.c
@@ -97,7 +97,7 @@ embed_config(bd_t **bdp)
 #endif /* CONFIG_MBX */
 
 #if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC) || \
-	defined(CONFIG_RPX8260) || defined(CONFIG_EP405)
+	defined(CONFIG_RPX8260)
 /* Helper functions for Embedded Planet boards.
 */
 /* Because I didn't find anything that would do this.......
@@ -217,7 +217,7 @@ rpx_cpuspeed(bd_t *bd, u_char *cp)
 }
 #endif
 
-#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC) || defined(CONFIG_EP405)
+#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
 static void
 rpx_memsize(bd_t *bd, u_char *cp)
 {
@@ -233,25 +233,7 @@ rpx_memsize(bd_t *bd, u_char *cp)
 
 	bd->bi_memsize = size * 1024 * 1024;
 }
-#endif /* LITE || CLASSIC || EP405 */
-#if defined(CONFIG_EP405)
-static void
-rpx_nvramsize(bd_t *bd, u_char *cp)
-{
-	uint	size;
-
-	size = 0;
-
-	while (*cp != '\n') {
-		size *= 10;
-		size += (*cp) - '0';
-		cp++;
-	}
-
-	bd->bi_nvramsize = size * 1024;
-}
-#endif /* CONFIG_EP405 */
-
+#endif /* LITE || CLASSIC */
 #endif	/* Embedded Planet boards */
 
 #if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
@@ -845,84 +827,3 @@ embed_config(bd_t **bdp)
 	timebase_period_ns = 1000000000 / bd->bi_tbfreq;
 }
 #endif /* CONFIG_IBM_OPENBIOS */
-
-#ifdef CONFIG_EP405
-#include <linux/serial_reg.h>
-
-void
-embed_config(bd_t **bdp)
-{
-	u32 chcr0;
-	u_char *cp;
-	bd_t	*bd;
-
-	/* Different versions of the PlanetCore firmware vary in how
-	   they set up the serial port - in particular whether they
-	   use the internal or external serial clock for UART0.  Make
-	   sure the UART is in a known state. */
-	/* FIXME: We should use the board's 11.0592MHz external serial
-	   clock - it will be more accurate for serial rates.  For
-	   now, however the baud rates in ep405.h are for the internal
-	   clock. */
-	chcr0 = mfdcr(DCRN_CHCR0);
-	if ( (chcr0 & 0x1fff) != 0x103e ) {
-		mtdcr(DCRN_CHCR0, (chcr0 & 0xffffe000) | 0x103e);
-		/* The following tricks serial_init() into resetting the baud rate */
-		writeb(0, UART0_IO_BASE + UART_LCR);
-	}
-
-	/* We haven't seen actual problems with the EP405 leaving the
-	 * EMAC running (as we have on Walnut).  But the registers
-	 * suggest it may not be left completely quiescent.  Reset it
-	 * just to be sure. */
-	mtdcr(DCRN_MALCR(DCRN_MAL_BASE), MALCR_MMSR);     /* 1st reset MAL */
-	while (mfdcr(DCRN_MALCR(DCRN_MAL_BASE)) & MALCR_MMSR) {}; /* wait for the reset */	
-	out_be32((unsigned *)EMAC0_BASE,0x20000000);        /* then reset EMAC */
-
-	bd = &bdinfo;
-	*bdp = bd;
-#if 1
-	        cp = (u_char *)0xF0000EE0;
-	        for (;;) {
-	                if (*cp == 'E') {
-	                        cp++;
-	                        if (*cp == 'A') {
-                                  cp += 2;
-                                  rpx_eth(bd, cp);
-	                        }
-		         }
-
-	         	if (*cp == 'D') {
-	                        	cp++;
-	                        	if (*cp == '1') {
-		                                cp += 2;
-		                                rpx_memsize(bd, cp);
-	        	                }
-                	}
-
-			if (*cp == 'N') {
-				cp++;
-				if (*cp == 'V') {
-					cp += 2;
-					rpx_nvramsize(bd, cp);
-				}
-			}
-			while ((*cp != '\n') && (*cp != 0xff))
-			      cp++;
-
-	                cp++;
-	                if ((*cp == 0) || (*cp == 0xff))
-	                   break;
-	       }
-	bd->bi_intfreq   = 200000000;
-	bd->bi_busfreq   = 100000000;
-	bd->bi_pci_busfreq= 33000000 ;
-#else
-
-	bd->bi_memsize   = 64000000;
-	bd->bi_intfreq   = 200000000;
-	bd->bi_busfreq   = 100000000;
-	bd->bi_pci_busfreq= 33000000 ;
-#endif
-}
-#endif
diff --git a/arch/ppc/configs/ep405_defconfig b/arch/ppc/configs/ep405_defconfig
deleted file mode 100644
--- a/arch/ppc/configs/ep405_defconfig
+++ /dev/null
@@ -1,572 +0,0 @@
-#
-# Automatically generated make config: don't edit
-#
-CONFIG_MMU=y
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
-CONFIG_HAVE_DEC_LOCK=y
-CONFIG_PPC=y
-CONFIG_PPC32=y
-CONFIG_GENERIC_NVRAM=y
-
-#
-# Code maturity level options
-#
-CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
-# CONFIG_STANDALONE is not set
-CONFIG_BROKEN_ON_SMP=y
-
-#
-# General setup
-#
-CONFIG_SWAP=y
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-# CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
-# CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_HOTPLUG is not set
-# CONFIG_IKCONFIG is not set
-CONFIG_EMBEDDED=y
-CONFIG_KALLSYMS=y
-CONFIG_FUTEX=y
-CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-
-#
-# Loadable module support
-#
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
-# CONFIG_MODVERSIONS is not set
-CONFIG_KMOD=y
-
-#
-# Processor
-#
-# CONFIG_6xx is not set
-CONFIG_40x=y
-# CONFIG_44x is not set
-# CONFIG_POWER3 is not set
-# CONFIG_POWER4 is not set
-# CONFIG_8xx is not set
-# CONFIG_MATH_EMULATION is not set
-# CONFIG_CPU_FREQ is not set
-CONFIG_4xx=y
-
-#
-# IBM 4xx options
-#
-# CONFIG_ASH is not set
-# CONFIG_BUBINGA is not set
-# CONFIG_CPCI405 is not set
-CONFIG_EP405=y
-# CONFIG_OAK is not set
-# CONFIG_REDWOOD_5 is not set
-# CONFIG_REDWOOD_6 is not set
-# CONFIG_SYCAMORE is not set
-# CONFIG_WALNUT is not set
-# CONFIG_EP405PC is not set
-CONFIG_IBM405_ERR77=y
-CONFIG_IBM405_ERR51=y
-CONFIG_IBM_OCP=y
-CONFIG_BIOS_FIXUP=y
-CONFIG_405GP=y
-CONFIG_EMBEDDEDBOOT=y
-# CONFIG_PM is not set
-CONFIG_UART0_TTYS0=y
-# CONFIG_UART0_TTYS1 is not set
-CONFIG_NOT_COHERENT_CACHE=y
-
-#
-# Platform options
-#
-# CONFIG_PC_KEYBOARD is not set
-# CONFIG_SMP is not set
-# CONFIG_PREEMPT is not set
-# CONFIG_HIGHMEM is not set
-CONFIG_KERNEL_ELF=y
-CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_MISC is not set
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="ip=on"
-
-#
-# Bus options
-#
-CONFIG_PCI=y
-CONFIG_PCI_DOMAINS=y
-# CONFIG_PCI_LEGACY_PROC is not set
-# CONFIG_PCI_NAMES is not set
-
-#
-# Advanced setup
-#
-# CONFIG_ADVANCED_OPTIONS is not set
-
-#
-# Default settings for advanced configuration options are used
-#
-CONFIG_HIGHMEM_START=0xfe000000
-CONFIG_LOWMEM_SIZE=0x30000000
-CONFIG_KERNEL_START=0xc0000000
-CONFIG_TASK_SIZE=0x80000000
-CONFIG_BOOT_LOAD=0x00400000
-
-#
-# Device Drivers
-#
-
-#
-# Generic Driver Options
-#
-
-#
-# Memory Technology Devices (MTD)
-#
-# CONFIG_MTD is not set
-
-#
-# Parallel port support
-#
-# CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-
-#
-# Block devices
-#
-# CONFIG_BLK_DEV_FD is not set
-# CONFIG_BLK_CPQ_DA is not set
-# CONFIG_BLK_CPQ_CISS_DA is not set
-# CONFIG_BLK_DEV_DAC960 is not set
-# CONFIG_BLK_DEV_UMEM is not set
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_CARMEL is not set
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_INITRD=y
-# CONFIG_LBD is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
-# CONFIG_IDE is not set
-
-#
-# SCSI device support
-#
-# CONFIG_SCSI is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
-# CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
-
-#
-# IEEE 1394 (FireWire) support
-#
-# CONFIG_IEEE1394 is not set
-
-#
-# I2O device support
-#
-# CONFIG_I2O is not set
-
-#
-# Macintosh device drivers
-#
-
-#
-# Networking support
-#
-CONFIG_NET=y
-
-#
-# Networking options
-#
-# CONFIG_PACKET is not set
-# CONFIG_NETLINK_DEV is not set
-CONFIG_UNIX=y
-# CONFIG_NET_KEY is not set
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-# CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IP_PNP_RARP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_IP_MROUTE is not set
-# CONFIG_ARPD is not set
-CONFIG_SYN_COOKIES=y
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-# CONFIG_IPV6 is not set
-# CONFIG_NETFILTER is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
-# CONFIG_IP_SCTP is not set
-# CONFIG_ATM is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_DECNET is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-# CONFIG_X25 is not set
-# CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
-# CONFIG_ECONET is not set
-# CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
-
-#
-# QoS and/or fair queueing
-#
-# CONFIG_NET_SCHED is not set
-
-#
-# Network testing
-#
-# CONFIG_NET_PKTGEN is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-# CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
-# CONFIG_BT is not set
-CONFIG_NETDEVICES=y
-# CONFIG_DUMMY is not set
-# CONFIG_BONDING is not set
-# CONFIG_EQUALIZER is not set
-# CONFIG_TUN is not set
-
-#
-# ARCnet devices
-#
-# CONFIG_ARCNET is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
-CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
-# CONFIG_OAKNET is not set
-# CONFIG_HAPPYMEAL is not set
-# CONFIG_SUNGEM is not set
-# CONFIG_NET_VENDOR_3COM is not set
-
-#
-# Tulip family network device support
-#
-# CONFIG_NET_TULIP is not set
-# CONFIG_HP100 is not set
-# CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-# CONFIG_ACENIC is not set
-# CONFIG_DL2K is not set
-# CONFIG_E1000 is not set
-# CONFIG_NS83820 is not set
-# CONFIG_HAMACHI is not set
-# CONFIG_YELLOWFIN is not set
-# CONFIG_R8169 is not set
-# CONFIG_SK98LIN is not set
-# CONFIG_TIGON3 is not set
-
-#
-# Ethernet (10000 Mbit)
-#
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-
-#
-# Token Ring devices
-#
-# CONFIG_TR is not set
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# Wan interfaces
-#
-# CONFIG_WAN is not set
-# CONFIG_FDDI is not set
-# CONFIG_HIPPI is not set
-# CONFIG_PPP is not set
-# CONFIG_SLIP is not set
-# CONFIG_RCPCI is not set
-# CONFIG_SHAPER is not set
-# CONFIG_NETCONSOLE is not set
-
-#
-# ISDN subsystem
-#
-# CONFIG_ISDN is not set
-
-#
-# Telephony Support
-#
-# CONFIG_PHONE is not set
-
-#
-# Input device support
-#
-CONFIG_INPUT=y
-
-#
-# Userland interfaces
-#
-CONFIG_INPUT_MOUSEDEV=y
-CONFIG_INPUT_MOUSEDEV_PSAUX=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
-# CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
-# CONFIG_INPUT_EVDEV is not set
-# CONFIG_INPUT_EVBUG is not set
-
-#
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_CT82C710 is not set
-# CONFIG_SERIO_PCIPS2 is not set
-
-#
-# Input Device Drivers
-#
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_INPUT_JOYSTICK is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
-# CONFIG_INPUT_MISC is not set
-
-#
-# Character devices
-#
-# CONFIG_VT is not set
-# CONFIG_SERIAL_NONSTANDARD is not set
-
-#
-# Serial drivers
-#
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
-
-#
-# Non-8250 serial port support
-#
-CONFIG_SERIAL_CORE=y
-CONFIG_SERIAL_CORE_CONSOLE=y
-CONFIG_UNIX98_PTYS=y
-CONFIG_LEGACY_PTYS=y
-CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_QIC02_TAPE is not set
-
-#
-# IPMI
-#
-# CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
-# CONFIG_WATCHDOG is not set
-# CONFIG_NVRAM is not set
-CONFIG_GEN_RTC=y
-# CONFIG_GEN_RTC_X is not set
-# CONFIG_DTLK is not set
-# CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
-# CONFIG_FTAPE is not set
-# CONFIG_AGP is not set
-# CONFIG_DRM is not set
-# CONFIG_RAW_DRIVER is not set
-
-#
-# I2C support
-#
-# CONFIG_I2C is not set
-
-#
-# Misc devices
-#
-
-#
-# Multimedia devices
-#
-# CONFIG_VIDEO_DEV is not set
-
-#
-# Digital Video Broadcasting Devices
-#
-# CONFIG_DVB is not set
-
-#
-# Graphics support
-#
-# CONFIG_FB is not set
-
-#
-# Sound
-#
-# CONFIG_SOUND is not set
-
-#
-# USB support
-#
-# CONFIG_USB is not set
-
-#
-# USB Gadget Support
-#
-# CONFIG_USB_GADGET is not set
-
-#
-# File systems
-#
-CONFIG_EXT2_FS=y
-# CONFIG_EXT2_FS_XATTR is not set
-# CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
-# CONFIG_REISERFS_FS is not set
-# CONFIG_JFS_FS is not set
-# CONFIG_XFS_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
-# CONFIG_QUOTA is not set
-# CONFIG_AUTOFS_FS is not set
-# CONFIG_AUTOFS4_FS is not set
-
-#
-# CD-ROM/DVD Filesystems
-#
-# CONFIG_ISO9660_FS is not set
-# CONFIG_UDF_FS is not set
-
-#
-# DOS/FAT/NT Filesystems
-#
-# CONFIG_FAT_FS is not set
-# CONFIG_NTFS_FS is not set
-
-#
-# Pseudo filesystems
-#
-CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_SYSFS=y
-# CONFIG_DEVFS_FS is not set
-# CONFIG_DEVPTS_FS_XATTR is not set
-CONFIG_TMPFS=y
-# CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
-
-#
-# Miscellaneous filesystems
-#
-# CONFIG_ADFS_FS is not set
-# CONFIG_AFFS_FS is not set
-# CONFIG_HFS_FS is not set
-# CONFIG_HFSPLUS_FS is not set
-# CONFIG_BEFS_FS is not set
-# CONFIG_BFS_FS is not set
-# CONFIG_EFS_FS is not set
-# CONFIG_CRAMFS is not set
-# CONFIG_VXFS_FS is not set
-# CONFIG_HPFS_FS is not set
-# CONFIG_QNX4FS_FS is not set
-# CONFIG_SYSV_FS is not set
-# CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
-CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
-# CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
-# CONFIG_NFSD is not set
-CONFIG_ROOT_NFS=y
-CONFIG_LOCKD=y
-# CONFIG_EXPORTFS is not set
-CONFIG_SUNRPC=y
-# CONFIG_RPCSEC_GSS_KRB5 is not set
-# CONFIG_SMB_FS is not set
-# CONFIG_CIFS is not set
-# CONFIG_NCP_FS is not set
-# CONFIG_CODA_FS is not set
-# CONFIG_AFS_FS is not set
-
-#
-# Partition Types
-#
-# CONFIG_PARTITION_ADVANCED is not set
-CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
-# CONFIG_NLS is not set
-
-#
-# IBM 40x options
-#
-
-#
-# Library routines
-#
-CONFIG_CRC32=y
-# CONFIG_LIBCRC32C is not set
-
-#
-# Kernel hacking
-#
-# CONFIG_DEBUG_KERNEL is not set
-# CONFIG_SERIAL_TEXT_DEBUG is not set
-CONFIG_PPC_OCP=y
-
-#
-# Security options
-#
-# CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-# CONFIG_CRYPTO is not set
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -21,11 +21,6 @@ config CPCI405
 	help
 	  This option enables support for the CPCI405 board.
 
-config EP405
-	bool "EP405/EP405PC"
-	help
-	  This option enables support for the EP405/EP405PC boards.
-
 config REDWOOD_5
 	bool "Redwood-5"
 	help
@@ -75,10 +70,6 @@ config OCOTEA
 
 endchoice
 
-config EP405PC
-	bool "EP405PC Support"
-	depends on EP405
-
 
 # It's often necessary to know the specific 4xx processor type.
 # Fortunately, it is impled (so far) from the board type, so we
@@ -132,7 +123,7 @@ config BOOKE
 
 config IBM_OCP
 	bool
-	depends on ASH || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
+	depends on ASH || BUBINGA || CPCI405 || EBONY || LUAN || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
 	default y
 
 config XILINX_OCP
@@ -147,7 +138,7 @@ config IBM_EMAC4
 
 config BIOS_FIXUP
 	bool
-	depends on BUBINGA || EP405 || SYCAMORE || WALNUT
+	depends on BUBINGA || SYCAMORE || WALNUT
 	default y
 
 # OAK doesn't exist but wanted to keep this around for any future 403GCX boards
@@ -163,7 +154,7 @@ config 405EP
 
 config 405GP
 	bool
-	depends on CPCI405 || EP405 || WALNUT
+	depends on CPCI405 || WALNUT
 	default y
 
 config 405GPR
@@ -183,7 +174,7 @@ config STB03xxx
 
 config EMBEDDEDBOOT
 	bool
-	depends on EP405 || XILINX_ML300
+	depends on XILINX_ML300
 	default y
 
 config IBM_OPENBIOS
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -3,7 +3,6 @@
 
 obj-$(CONFIG_CPCI405)		+= cpci405.o
 obj-$(CONFIG_EBONY)		+= ebony.o
-obj-$(CONFIG_EP405)		+= ep405.o
 obj-$(CONFIG_BUBINGA)		+= bubinga.o
 obj-$(CONFIG_LUAN)		+= luan.o
 obj-$(CONFIG_OCOTEA)		+= ocotea.o
diff --git a/arch/ppc/platforms/4xx/ep405.c b/arch/ppc/platforms/4xx/ep405.c
deleted file mode 100644
--- a/arch/ppc/platforms/4xx/ep405.c
+++ /dev/null
@@ -1,197 +0,0 @@
-/*
- * arch/ppc/platforms/4xx/ep405.c
- *
- * Embedded Planet 405GP board
- * http://www.embeddedplanet.com
- *
- * Author: Matthew Locke <mlocke@mvista.com>
- *
- * 2001 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#include <linux/config.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <asm/system.h>
-#include <asm/pci-bridge.h>
-#include <asm/machdep.h>
-#include <asm/todc.h>
-#include <asm/ocp.h>
-#include <asm/ibm_ocp_pci.h>
-
-#undef DEBUG
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
-u8 *ep405_bcsr;
-u8 *ep405_nvram;
-
-static struct {
-	u8 cpld_xirq_select;
-	int pci_idsel;
-	int irq;
-} ep405_devtable[] = {
-#ifdef CONFIG_EP405PC
-	{0x07, 0x0E, 25},		/* EP405PC: USB */
-#endif
-};
-
-int __init
-ppc405_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
-{
-	int i;
-
-	/* AFAICT this is only called a few times during PCI setup, so
-	   performance is not critical */
-	for (i = 0; i < ARRAY_SIZE(ep405_devtable); i++) {
-		if (idsel == ep405_devtable[i].pci_idsel)
-			return ep405_devtable[i].irq;
-	}
-	return -1;
-};
-
-void __init
-ep405_setup_arch(void)
-{
-	ppc4xx_setup_arch();
-
-	ibm_ocp_set_emac(0, 0);
-
-	if (__res.bi_nvramsize == 512*1024) {
-		/* FIXME: we should properly handle NVRTCs of different sizes */
-		TODC_INIT(TODC_TYPE_DS1557, ep405_nvram, ep405_nvram, ep405_nvram, 8);
-	}
-}
-
-void __init
-bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
-{
-	unsigned int bar_response, bar;
-	/*
-	 * Expected PCI mapping:
-	 *
-	 *  PLB addr             PCI memory addr
-	 *  ---------------------       ---------------------
-	 *  0000'0000 - 7fff'ffff <---  0000'0000 - 7fff'ffff
-	 *  8000'0000 - Bfff'ffff --->  8000'0000 - Bfff'ffff
-	 *
-	 *  PLB addr             PCI io addr
-	 *  ---------------------       ---------------------
-	 *  e800'0000 - e800'ffff --->  0000'0000 - 0001'0000
-	 *
-	 */
-
-	/* Disable region zero first */
-	out_le32((void *) &(pcip->pmm[0].ma), 0x00000000);
-	/* PLB starting addr, PCI: 0x80000000 */
-	out_le32((void *) &(pcip->pmm[0].la), 0x80000000);
-	/* PCI start addr, 0x80000000 */
-	out_le32((void *) &(pcip->pmm[0].pcila), PPC405_PCI_MEM_BASE);
-	/* 512MB range of PLB to PCI */
-	out_le32((void *) &(pcip->pmm[0].pciha), 0x00000000);
-	/* Enable no pre-fetch, enable region */
-	out_le32((void *) &(pcip->pmm[0].ma), ((0xffffffff -
-						(PPC405_PCI_UPPER_MEM -
-						 PPC405_PCI_MEM_BASE)) | 0x01));
-
-	/* Disable region one */
-	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].la), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].pcila), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].pciha), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
-	out_le32((void *) &(pcip->ptm1ms), 0x00000000);
-
-	/* Disable region two */
-	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].la), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].pcila), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].pciha), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
-	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
-
-	/* Configure PTM (PCI->PLB) region 1 */
-	out_le32((void *) &(pcip->ptm1la), 0x00000000); /* PLB base address */
-	/* Disable PTM region 2 */
-	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
-
-	/* Zero config bars */
-	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
-		early_write_config_dword(hose, hose->first_busno,
-					 PCI_FUNC(hose->first_busno), bar,
-					 0x00000000);
-		early_read_config_dword(hose, hose->first_busno,
-					PCI_FUNC(hose->first_busno), bar,
-					&bar_response);
-		DBG("BUS %d, device %d, Function %d bar 0x%8.8x is 0x%8.8x\n",
-		    hose->first_busno, PCI_SLOT(hose->first_busno),
-		    PCI_FUNC(hose->first_busno), bar, bar_response);
-	}
-	/* end work arround */
-}
-
-void __init
-ep405_map_io(void)
-{
-	bd_t *bip = &__res;
-
-	ppc4xx_map_io();
-
-	ep405_bcsr = ioremap(EP405_BCSR_PADDR, EP405_BCSR_SIZE);
-
-	if (bip->bi_nvramsize > 0) {
-		ep405_nvram = ioremap(EP405_NVRAM_PADDR, bip->bi_nvramsize);
-	}
-}
-
-void __init
-ep405_init_IRQ(void)
-{
-	int i;
-
-	ppc4xx_init_IRQ();
-
-	/* Workaround for a bug in the firmware it incorrectly sets
-	   the IRQ polarities for XIRQ0 and XIRQ1 */
-	mtdcr(DCRN_UIC_PR(DCRN_UIC0_BASE), 0xffffff80); /* set the polarity */
-	mtdcr(DCRN_UIC_SR(DCRN_UIC0_BASE), 0x00000060); /* clear bogus interrupts */
-
-	/* Activate the XIRQs from the CPLD */
-	writeb(0xf0, ep405_bcsr+10);
-
-	/* Set up IRQ routing */
-	for (i = 0; i < ARRAY_SIZE(ep405_devtable); i++) {
-		if ( (ep405_devtable[i].irq >= 25)
-		     && (ep405_devtable[i].irq) <= 31) {
-			writeb(ep405_devtable[i].cpld_xirq_select, ep405_bcsr+5);
-			writeb(ep405_devtable[i].irq - 25, ep405_bcsr+6);
-		}
-	}
-}
-
-void __init
-platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
-	      unsigned long r6, unsigned long r7)
-{
-	ppc4xx_init(r3, r4, r5, r6, r7);
-
-	ppc_md.setup_arch = ep405_setup_arch;
-	ppc_md.setup_io_mappings = ep405_map_io;
-	ppc_md.init_IRQ = ep405_init_IRQ;
-
-	ppc_md.nvram_read_val = todc_direct_read_val;
-	ppc_md.nvram_write_val = todc_direct_write_val;
-
-	if (__res.bi_nvramsize == 512*1024) {
-		ppc_md.time_init = todc_time_init;
-		ppc_md.set_rtc_time = todc_set_rtc_time;
-		ppc_md.get_rtc_time = todc_get_rtc_time;
-	} else {
-		printk("EP405: NVRTC size is not 512k (not a DS1557).  Not sure what to do with it\n");
-	}
-}
diff --git a/arch/ppc/platforms/4xx/ep405.h b/arch/ppc/platforms/4xx/ep405.h
deleted file mode 100644
--- a/arch/ppc/platforms/4xx/ep405.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * arch/ppc/platforms/4xx/ep405.h
- *
- * Embedded Planet 405GP board
- * http://www.embeddedplanet.com
- *
- * Author: Matthew Locke <mlocke@mvista.com>
- *
- * 2000 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#ifdef __KERNEL__
-#ifndef __ASM_EP405_H__
-#define __ASM_EP405_H__
-
-/* We have a 405GP core */
-#include <platforms/4xx/ibm405gp.h>
-
-#ifndef __ASSEMBLY__
-
-#include <linux/types.h>
-
-typedef struct board_info {
-	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
-	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
-	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
-	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
-	unsigned int	 bi_nvramsize;		/* Size of the NVRAM/RTC */
-} bd_t;
-
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
-
-extern u8 *ep405_bcsr;
-extern u8 *ep405_nvram;
-
-/* Map for the BCSR and NVRAM space */
-#define EP405_BCSR_PADDR	((uint)0xf4000000)
-#define EP405_BCSR_SIZE		((uint)16)
-#define EP405_NVRAM_PADDR	((uint)0xf4200000)
-
-/* serial defines */
-#define BASE_BAUD		399193
-
-#define PPC4xx_MACHINE_NAME "Embedded Planet 405GP"
-
-#endif /* !__ASSEMBLY__ */
-#endif /* __ASM_EP405_H__ */
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -27,10 +27,6 @@
 #include <platforms/4xx/cpci405.h>
 #endif
 
-#if defined(CONFIG_EP405)
-#include <platforms/4xx/ep405.h>
-#endif
-
 #if defined(CONFIG_REDWOOD_5)
 #include <platforms/4xx/redwood5.h>
 #endif
