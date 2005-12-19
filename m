Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbVLSVHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVLSVHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 16:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVLSVHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 16:07:38 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:18684 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964976AbVLSVHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 16:07:37 -0500
Date: Mon, 19 Dec 2005 14:06:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Jean Delvare <khali@linux-fr.org>, Andrey Volkov <avolkov@varma-el.com>,
       adi@hexapodia.org, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] i2c: Combined ST m41txx i2c rtc chip driver (was: [PATCH 1/1] Added support of ST m41t85 rtc chip)
Message-ID: <20051219210600.GB21696@mag.az.mvista.com>
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org> <20051116025714.GK5546@mag.az.mvista.com> <20051219210325.GA21696@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219210325.GA21696@mag.az.mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 02:03:25PM -0700, Mark A. Greer wrote:
> [I will send a second patch that contains the changes I made to the ppc
> katana platform that has the m41t00 that I tested with.]

FYI, here are the code changes with an updated defconfig for the platform.

Mark
---
 configs/katana_defconfig |   99 +++++++++++++++++++++++++++++++----------------
 platforms/katana.c       |   37 +++++++++++++++--
 2 files changed, 99 insertions(+), 37 deletions(-)
---
diff -Nurp linux-2.6.15-rc5-mm3.orig/arch/ppc/configs/katana_defconfig linux-2.6.15-rc5-mm3-m41txx/arch/ppc/configs/katana_defconfig
--- linux-2.6.15-rc5-mm3.orig/arch/ppc/configs/katana_defconfig	2005-12-03 22:10:42.000000000 -0700
+++ linux-2.6.15-rc5-mm3-m41txx/arch/ppc/configs/katana_defconfig	2005-12-19 13:16:25.000000000 -0700
@@ -1,17 +1,17 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.13-mm1
-# Thu Sep  1 17:16:03 2005
+# Linux kernel version: 2.6.15-rc5-mm1
+# Fri Dec 16 16:12:10 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
-CONFIG_HAVE_DEC_LOCK=y
 CONFIG_PPC=y
 CONFIG_PPC32=y
 CONFIG_GENERIC_NVRAM=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 
 #
 # Code maturity level options
@@ -27,20 +27,21 @@ CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
+CONFIG_SWAP_PREFETCH=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-# CONFIG_HOTPLUG is not set
-CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
+CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -49,8 +50,11 @@ CONFIG_CC_ALIGN_FUNCTIONS=0
 CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
+CONFIG_OBSOLETE_INTERMODULE=y
 
 #
 # Loadable module support
@@ -64,6 +68,25 @@ CONFIG_OBSOLETE_MODPARM=y
 CONFIG_KMOD=y
 
 #
+# Block layer
+#
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+
+#
 # Processor
 #
 CONFIG_6xx=y
@@ -84,11 +107,6 @@ CONFIG_PPC_STD_MMU=y
 CONFIG_NOT_COHERENT_CACHE=y
 
 #
-# Performance-monitoring counters support
-#
-# CONFIG_PERFCTR is not set
-
-#
 # Platform options
 #
 # CONFIG_PPC_MULTIPLATFORM is not set
@@ -144,11 +162,13 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyMM0 ip=on"
 # CONFIG_PM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
 CONFIG_SECCOMP=y
 CONFIG_ISA_DMA_API=y
 
@@ -156,6 +176,8 @@ CONFIG_ISA_DMA_API=y
 # Bus options
 #
 CONFIG_GENERIC_ISA_DMA=y
+# CONFIG_PPC_I8259 is not set
+CONFIG_PPC_INDIRECT_PCI=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCI_LEGACY_PROC=y
@@ -241,14 +263,16 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
 # CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
-# CONFIG_NETFILTER_NETLINK is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
@@ -266,6 +290,11 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 
 #
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
 # Memory Technology Devices (MTD)
 #
 CONFIG_MTD=y
@@ -283,6 +312,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
 # CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -347,6 +377,11 @@ CONFIG_MTD_PHRAM=y
 # CONFIG_MTD_NAND is not set
 
 #
+# OneNAND Flash Device Drivers
+#
+# CONFIG_MTD_ONENAND is not set
+
+#
 # Parallel port support
 #
 # CONFIG_PARPORT is not set
@@ -372,16 +407,7 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_LBD is not set
 # CONFIG_CDROM_PKTCDVD is not set
-
-#
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
@@ -418,6 +444,7 @@ CONFIG_IOSCHED_CFQ=y
 #
 # Macintosh device drivers
 #
+# CONFIG_WINDFARM is not set
 
 #
 # Network device support
@@ -445,6 +472,7 @@ CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
 # CONFIG_NET_VENDOR_3COM is not set
 
 #
@@ -599,7 +627,6 @@ CONFIG_SERIAL_MPSC=y
 CONFIG_SERIAL_MPSC_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -631,6 +658,7 @@ CONFIG_GEN_RTC=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
+# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -682,14 +710,20 @@ CONFIG_I2C_MV64XXX=y
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_RTC8564 is not set
-CONFIG_SENSORS_M41T00=y
 # CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_RTC_X1205_I2C is not set
+CONFIG_RTC_M41TXX_I2C=y
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
 
 #
+# SPI support
+#
+# CONFIG_SPI_MASTER is not set
+
+#
 # Dallas's 1-wire bus
 #
 # CONFIG_W1 is not set
@@ -728,6 +762,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_SMSC47M1 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_VT8231 is not set
 # CONFIG_SENSORS_W83781D is not set
 # CONFIG_SENSORS_W83792D is not set
 # CONFIG_SENSORS_W83L785TS is not set
@@ -782,6 +817,10 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_USB is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -801,6 +840,10 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 #
 
 #
+# EDAC - error detection and reporting (RAS)
+#
+
+#
 # Distributed Lock Manager
 #
 # CONFIG_DLM is not set
@@ -816,10 +859,6 @@ CONFIG_EXT2_FS=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
-
-#
-# XFS support
-#
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
@@ -853,8 +892,8 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-# CONFIG_CONFIGFS_FS is not set
 # CONFIG_RELAYFS_FS is not set
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -917,10 +956,6 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
-
-#
-# Profiling support
-#
 # CONFIG_PROFILING is not set
 
 #
diff -Nurp linux-2.6.15-rc5-mm3.orig/arch/ppc/platforms/katana.c linux-2.6.15-rc5-mm3-m41txx/arch/ppc/platforms/katana.c
--- linux-2.6.15-rc5-mm3.orig/arch/ppc/platforms/katana.c	2005-12-03 22:10:42.000000000 -0700
+++ linux-2.6.15-rc5-mm3-m41txx/arch/ppc/platforms/katana.c	2005-12-19 13:16:25.000000000 -0700
@@ -30,6 +30,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mv643xx.h>
 #include <linux/platform_device.h>
+#include <linux/m41txx.h>
 #ifdef CONFIG_BOOTIMG
 #include <linux/bootimg.h>
 #endif
@@ -845,17 +846,43 @@ katana_find_end_of_memory(void)
 	return bdp->bi_memsize;
 }
 
-#if defined(CONFIG_I2C_MV64XXX) && defined(CONFIG_SENSORS_M41T00)
-extern ulong	m41t00_get_rtc_time(void);
-extern int	m41t00_set_rtc_time(ulong);
+#if defined(CONFIG_I2C_MV64XXX) && defined(CONFIG_RTC_M41TXX_I2C)
+static struct m41txx_platform_data katana_m41txx_pdata = {
+	.type = M41TXX_TYPE_M41T00,
+	.i2c_addr = M41TXX_I2C_ADDR,
+};
+
+static struct platform_device katana_m41txx_pdev = {
+	.name		= M41TXX_DRV_NAME,
+	.id		= 0,
+	.num_resources	= 0,
+	.dev = {
+		.platform_data = &katana_m41txx_pdata,
+	},
+};
+
+static int __init
+katana_add_pdata(void)
+{
+	int rc;
+
+	if ((rc = platform_device_register(&katana_m41txx_pdev)))
+		platform_device_unregister(&katana_m41txx_pdev);
+
+	return rc;
+}
+arch_initcall(katana_add_pdata);
+
+extern ulong	m41txx_get_rtc_time(void);
+extern int	m41txx_set_rtc_time(ulong);
 
 static int __init
 katana_rtc_hookup(void)
 {
 	struct timespec	tv;
 
-	ppc_md.get_rtc_time = m41t00_get_rtc_time;
-	ppc_md.set_rtc_time = m41t00_set_rtc_time;
+	ppc_md.get_rtc_time = m41txx_get_rtc_time;
+	ppc_md.set_rtc_time = m41txx_set_rtc_time;
 
 	tv.tv_nsec = 0;
 	tv.tv_sec = (ppc_md.get_rtc_time)();
