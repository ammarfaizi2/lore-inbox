Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVHLQcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVHLQcO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVHLQcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:32:14 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:55718 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751222AbVHLQcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:32:13 -0400
Date: Fri, 12 Aug 2005 11:32:04 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       tie-fei.zang@freescale.com
Subject: [PATCH] cpm_uart: Fix 2nd serial port on MPC8560 ADS 
Message-ID: <Pine.LNX.4.61.0508121131320.18385@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2nd serial port on the MPC8560 ADS was not being configured correctly
and thus could not be used as a console.  Updated the defconfig for the
board to configure the proper SCC channel for the 2nd serial port.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 51a75dcea8fe0407f06467de36e258616cda68f9
tree 6adc8ec04a037f64f77e8f17669dec8532557d08
parent 468e916c3b742602a0a10fa12dab015531cd4843
author Kumar K. Gala <kumar.gala@freescale.com> Fri, 12 Aug 2005 11:24:12 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 12 Aug 2005 11:24:12 -0500

 arch/ppc/configs/mpc8560_ads_defconfig  |  273 ++++++++++++++++++-------------
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    9 +
 2 files changed, 171 insertions(+), 111 deletions(-)

diff --git a/arch/ppc/configs/mpc8560_ads_defconfig b/arch/ppc/configs/mpc8560_ads_defconfig
--- a/arch/ppc/configs/mpc8560_ads_defconfig
+++ b/arch/ppc/configs/mpc8560_ads_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc1
-# Thu Jan 20 01:24:56 2005
+# Linux kernel version: 2.6.13-rc6
+# Thu Aug 11 18:14:45 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -11,6 +11,7 @@ CONFIG_HAVE_DEC_LOCK=y
 CONFIG_PPC=y
 CONFIG_PPC32=y
 CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 
 #
 # Code maturity level options
@@ -18,6 +19,7 @@ CONFIG_GENERIC_NVRAM=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -29,12 +31,14 @@ CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_HOTPLUG is not set
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -44,6 +48,7 @@ CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -59,12 +64,16 @@ CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
 # CONFIG_8xx is not set
+# CONFIG_E200 is not set
 CONFIG_E500=y
 CONFIG_BOOKE=y
 CONFIG_FSL_BOOKE=y
+# CONFIG_PHYS_64BIT is not set
 CONFIG_SPE=y
 CONFIG_MATH_EMULATION=y
+# CONFIG_KEXEC is not set
 # CONFIG_CPU_FREQ is not set
+# CONFIG_PM is not set
 CONFIG_85xx=y
 CONFIG_PPC_INDIRECT_PCI_BE=y
 
@@ -72,9 +81,11 @@ CONFIG_PPC_INDIRECT_PCI_BE=y
 # Freescale 85xx options
 #
 # CONFIG_MPC8540_ADS is not set
+# CONFIG_MPC8548_CDS is not set
 # CONFIG_MPC8555_CDS is not set
 CONFIG_MPC8560_ADS=y
 # CONFIG_SBC8560 is not set
+# CONFIG_STX_GP3 is not set
 CONFIG_MPC8560=y
 
 #
@@ -83,11 +94,25 @@ CONFIG_MPC8560=y
 CONFIG_CPM2=y
 # CONFIG_PC_KEYBOARD is not set
 # CONFIG_SMP is not set
-# CONFIG_PREEMPT is not set
 # CONFIG_HIGHMEM is not set
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_CMDLINE_BOOL is not set
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
@@ -103,10 +128,6 @@ CONFIG_PCI_NAMES=y
 # CONFIG_PCCARD is not set
 
 #
-# PC-card bridges
-#
-
-#
 # Advanced setup
 #
 # CONFIG_ADVANCED_OPTIONS is not set
@@ -121,6 +142,69 @@ CONFIG_TASK_SIZE=0x80000000
 CONFIG_BOOT_LOAD=0x00800000
 
 #
+# Networking
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
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
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
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
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
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+
+#
 # Device Drivers
 #
 
@@ -193,6 +277,7 @@ CONFIG_IOSCHED_CFQ=y
 #
 # Fusion MPT device support
 #
+# CONFIG_FUSION is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -209,71 +294,8 @@ CONFIG_IOSCHED_CFQ=y
 #
 
 #
-# Networking support
-#
-CONFIG_NET=y
-
-#
-# Networking options
-#
-CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
-CONFIG_UNIX=y
-# CONFIG_NET_KEY is not set
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-# CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
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
-# CONFIG_INET_TUNNEL is not set
-CONFIG_IP_TCPDIAG=y
-# CONFIG_IP_TCPDIAG_IPV6 is not set
-# CONFIG_IPV6 is not set
-# CONFIG_NETFILTER is not set
-
+# Network device support
 #
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
-
-#
-# QoS and/or fair queueing
-#
-# CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
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
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
@@ -311,8 +333,10 @@ CONFIG_MII=y
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
 # CONFIG_R8169 is not set
+# CONFIG_SKGE is not set
 # CONFIG_SK98LIN is not set
 # CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 CONFIG_GFAR_NAPI=y
 
@@ -342,6 +366,8 @@ CONFIG_GFAR_NAPI=y
 # CONFIG_SLIP is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # ISDN subsystem
@@ -368,14 +394,6 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-# CONFIG_SERIO is not set
-# CONFIG_SERIO_I8042 is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -385,6 +403,12 @@ CONFIG_SOUND_GAMEPORT=y
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
 # Character devices
 #
 # CONFIG_VT is not set
@@ -403,11 +427,12 @@ CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
 CONFIG_SERIAL_CPM_SCC1=y
-# CONFIG_SERIAL_CPM_SCC2 is not set
+CONFIG_SERIAL_CPM_SCC2=y
 # CONFIG_SERIAL_CPM_SCC3 is not set
-CONFIG_SERIAL_CPM_SCC4=y
+# CONFIG_SERIAL_CPM_SCC4 is not set
 # CONFIG_SERIAL_CPM_SMC1 is not set
 # CONFIG_SERIAL_CPM_SMC2 is not set
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -436,6 +461,11 @@ CONFIG_GEN_RTC=y
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
 # I2C support
 #
 CONFIG_I2C=y
@@ -458,11 +488,11 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_AMD8111 is not set
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
+# CONFIG_I2C_PIIX4 is not set
 # CONFIG_I2C_ISA is not set
 CONFIG_I2C_MPC=y
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
-# CONFIG_I2C_PIIX4 is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
 # CONFIG_SCx200_ACB is not set
@@ -473,19 +503,46 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_VIAPRO is not set
 # CONFIG_I2C_VOODOO3 is not set
 # CONFIG_I2C_PCA_ISA is not set
+# CONFIG_I2C_SENSOR is not set
 
 #
-# Hardware Sensors Chip support
+# Miscellaneous I2C Chip support
 #
-# CONFIG_I2C_SENSOR is not set
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+# CONFIG_SENSORS_M41T00 is not set
+# CONFIG_SENSORS_MAX6875 is not set
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
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
 # CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_ATXP1 is not set
 # CONFIG_SENSORS_DS1621 is not set
 # CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_FSCPOS is not set
 # CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM63 is not set
 # CONFIG_SENSORS_LM75 is not set
@@ -496,31 +553,18 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_LM85 is not set
 # CONFIG_SENSORS_LM87 is not set
 # CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
 # CONFIG_SENSORS_MAX1619 is not set
 # CONFIG_SENSORS_PC87360 is not set
-# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_SIS5595 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_VIA686A is not set
 # CONFIG_SENSORS_W83781D is not set
 # CONFIG_SENSORS_W83L785TS is not set
 # CONFIG_SENSORS_W83627HF is not set
-
-#
-# Other I2C Chip support
-#
-# CONFIG_SENSORS_EEPROM is not set
-# CONFIG_SENSORS_PCF8574 is not set
-# CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_RTC8564 is not set
-# CONFIG_I2C_DEBUG_CORE is not set
-# CONFIG_I2C_DEBUG_ALGO is not set
-# CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_I2C_DEBUG_CHIP is not set
-
-#
-# Dallas's 1-wire bus
-#
-# CONFIG_W1 is not set
+# CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
 # Misc devices
@@ -540,7 +584,6 @@ CONFIG_I2C_MPC=y
 # Graphics support
 #
 # CONFIG_FB is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -550,13 +593,9 @@ CONFIG_I2C_MPC=y
 #
 # USB support
 #
-# CONFIG_USB is not set
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
-
-#
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
-#
+# CONFIG_USB is not set
 
 #
 # USB Gadget Support
@@ -574,10 +613,15 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_INFINIBAND is not set
 
 #
+# SN Devices
+#
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
@@ -587,9 +631,15 @@ CONFIG_JBD=y
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
@@ -614,7 +664,6 @@ CONFIG_DNOTIFY=y
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_DEVFS_FS is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_XATTR is not set
@@ -648,7 +697,7 @@ CONFIG_NFS_FS=y
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
-# CONFIG_EXPORTFS is not set
+CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -700,7 +749,9 @@ CONFIG_CRC32=y
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_KGDB_CONSOLE is not set
 
 #
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -142,12 +142,21 @@ void scc2_lineif(struct uart_cpm_port *p
 	 * be supported in a sane fashion.
 	 */
 #ifndef CONFIG_STX_GP3
+#ifdef CONFIG_MPC8560_ADS
+	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
+	io->iop_ppard |= 0x00000018;
+	io->iop_psord &= ~0x00000008;	/* Rx */
+	io->iop_psord &= ~0x00000010;	/* Tx */
+	io->iop_pdird &= ~0x00000008;	/* Rx */
+	io->iop_pdird |= 0x00000010;	/* Tx */
+#else
 	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
 	io->iop_pparb |= 0x008b0000;
 	io->iop_pdirb |= 0x00880000;
 	io->iop_psorb |= 0x00880000;
 	io->iop_pdirb &= ~0x00030000;
 	io->iop_psorb &= ~0x00030000;
+#endif
 #endif
 	cpm2_immr->im_cpmux.cmx_scr &= 0xff00ffff;
 	cpm2_immr->im_cpmux.cmx_scr |= 0x00090000;
