Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVJ2EqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVJ2EqU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 00:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVJ2EqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 00:46:20 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:38440 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751140AbVJ2EqT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 00:46:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QDAk80Mc5oWdLRfzRiqIxvgYqqL5tl/AwNtp7WDAmZir9zRqbMzN0233EQVzxb+2mdEKLU/EhbHSUdUxnqhIj9XedTa+/6SzB4VVKa0hOoQh/wAQ/hJPlauZ9xluTY3itNetuox8ecZHpZ8haX3ShNcM9KiUSUZmncQz8s9rRsU=
Message-ID: <cb57165a0510282146h138b870bk438313fa4a62646f@mail.gmail.com>
Date: Fri, 28 Oct 2005 21:46:18 -0700
From: Lee Nicks <allinux@gmail.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.14] ppc32: add watchdog & RTC support for Marvell EV64360BP board
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds watchdog, RTC support for Marvell EV64360BP board.

Signed-off-by: Lee Nicks <allinux@gmail.com>
======================================

diff -ruN a/arch/ppc/configs/ev64360_defconfig
b/arch/ppc/configs/ev64360_defconfig
--- a/arch/ppc/configs/ev64360_defconfig	2005-10-27 17:02:08.000000000 -0700
+++ b/arch/ppc/configs/ev64360_defconfig	2005-10-28 21:22:11.000000000 -0700
@@ -1,17 +1,17 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.13-rc5
-# Fri Aug  5 15:18:23 2005
+# Linux kernel version: 2.6.14
+# Fri Oct 28 19:15:34 2005
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
@@ -26,6 +26,7 @@
 # General setup
 #
 CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -35,6 +36,7 @@
 CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
+CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -74,7 +76,7 @@
 # CONFIG_TAU_AVERAGE is not set
 # CONFIG_KEXEC is not set
 # CONFIG_CPU_FREQ is not set
-# CONFIG_PM is not set
+# CONFIG_WANT_EARLY_SERIAL is not set
 CONFIG_PPC_STD_MMU=y
 CONFIG_NOT_COHERENT_CACHE=y

@@ -86,22 +88,18 @@
 # CONFIG_KATANA is not set
 # CONFIG_WILLOW is not set
 # CONFIG_CPCI690 is not set
-# CONFIG_PCORE is not set
 # CONFIG_POWERPMC250 is not set
 # CONFIG_CHESTNUT is not set
 # CONFIG_SPRUCE is not set
 # CONFIG_HDPU is not set
 # CONFIG_EV64260 is not set
 # CONFIG_LOPEC is not set
-# CONFIG_MCPN765 is not set
 # CONFIG_MVME5100 is not set
 # CONFIG_PPLUS is not set
 # CONFIG_PRPMC750 is not set
 # CONFIG_PRPMC800 is not set
 # CONFIG_SANDPOINT is not set
 # CONFIG_RADSTONE_PPC7D is not set
-# CONFIG_ADIR is not set
-# CONFIG_K2 is not set
 # CONFIG_PAL4 is not set
 # CONFIG_GEMINI is not set
 # CONFIG_EST8260 is not set
@@ -138,10 +136,13 @@
 # CONFIG_SPARSEMEM_MANUAL is not set
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyMM0,115200 root=/dev/mtdblock1 rw rootfstype=jffs2"
+# CONFIG_PM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
 CONFIG_SECCOMP=y
 CONFIG_ISA_DMA_API=y

@@ -152,7 +153,6 @@
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCI_LEGACY_PROC is not set
-# CONFIG_PCI_NAMES is not set

 #
 # PCCARD (PCMCIA/CardBus) support
@@ -206,14 +206,19 @@
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_IP_TCPDIAG=y
-# CONFIG_IP_TCPDIAG_IPV6 is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_BIC=y
 # CONFIG_IPV6 is not set
 # CONFIG_NETFILTER is not set

 #
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
 # SCTP Configuration (EXPERIMENTAL)
 #
 # CONFIG_IP_SCTP is not set
@@ -239,6 +244,7 @@
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set

 #
 # Device Drivers
@@ -252,6 +258,11 @@
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
@@ -358,7 +369,6 @@
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_LBD is not set
 # CONFIG_CDROM_PKTCDVD is not set

@@ -379,6 +389,7 @@
 #
 # SCSI device support
 #
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set

 #
@@ -420,6 +431,10 @@
 # CONFIG_ARCNET is not set

 #
+# PHY device support
+#
+
+#
 # Ethernet (10 or 100Mbit)
 #
 # CONFIG_NET_ETHERNET is not set
@@ -434,6 +449,7 @@
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
 # CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SK98LIN is not set
 # CONFIG_TIGON3 is not set
@@ -446,6 +462,7 @@
 #
 # Ethernet (10000 Mbit)
 #
+# CONFIG_CHELSIO_T1 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set

@@ -547,7 +564,20 @@
 #
 # Watchdog Cards
 #
-# CONFIG_WATCHDOG is not set
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_MV64X60_WDT=y
+
+#
+# PCI-based Watchdog Cards
+#
+# CONFIG_PCIPCWATCHDOG is not set
+# CONFIG_WDTPCI is not set
 # CONFIG_NVRAM is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
@@ -571,7 +601,6 @@
 # I2C support
 #
 # CONFIG_I2C is not set
-# CONFIG_I2C_SENSOR is not set

 #
 # Dallas's 1-wire bus
@@ -582,6 +611,7 @@
 # Hardware Monitoring support
 #
 CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set

 #
@@ -589,6 +619,10 @@
 #

 #
+# Multimedia Capabilities Port drivers
+#
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -651,10 +685,6 @@
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
-
-#
-# XFS support
-#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -663,6 +693,7 @@
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set

 #
 # CD-ROM/DVD Filesystems
@@ -683,11 +714,10 @@
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
-# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set

 #
 # Miscellaneous filesystems
@@ -735,6 +765,7 @@
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set

 #
 # Partition Types
@@ -751,6 +782,7 @@
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
@@ -767,6 +799,7 @@
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_SERIAL_TEXT_DEBUG is not set

 #
 # Security options
diff -ruN a/arch/ppc/platforms/ev64360.c b/arch/ppc/platforms/ev64360.c
--- a/arch/ppc/platforms/ev64360.c	2005-10-27 17:02:08.000000000 -0700
+++ b/arch/ppc/platforms/ev64360.c	2005-10-28 21:22:11.000000000 -0700
@@ -35,6 +35,8 @@
 #include <asm/bootinfo.h>
 #include <asm/ppcboot.h>
 #include <asm/mv64x60.h>
+#include <asm/todc.h>
+#include <asm/time.h>
 #include <platforms/ev64360.h>

 #define BOARD_VENDOR    "Marvell"
@@ -50,6 +52,8 @@

 unsigned char	__res[sizeof(bd_t)];

+TODC_ALLOC();
+
 static int __init
 ev64360_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
 {
@@ -180,6 +184,9 @@
 		 EV64360_RTC_WINDOW_BASE, EV64360_RTC_WINDOW_SIZE, 0);
 	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_1_WIN);

+	TODC_INIT(TODC_TYPE_DS1501, 0, 0,
+		ioremap(EV64360_RTC_WINDOW_BASE, EV64360_RTC_WINDOW_SIZE), 8);
+
 	mv64x60_set_32bit_window(&bh, MV64x60_CPU2SRAM_WIN,
 		 EV64360_INTERNAL_SRAM_BASE, MV64360_SRAM_SIZE, 0);
 	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2SRAM_WIN);
@@ -494,6 +501,13 @@
 	ppc_md.power_off = ev64360_power_off;
 	ppc_md.halt = ev64360_halt;
 	ppc_md.find_end_of_memory = ev64360_find_end_of_memory;
+        ppc_md.init = NULL;
+
+        ppc_md.time_init = todc_time_init;
+        ppc_md.set_rtc_time = todc_set_rtc_time;
+        ppc_md.get_rtc_time = todc_get_rtc_time;
+        ppc_md.nvram_read_val = todc_direct_read_val;
+        ppc_md.nvram_write_val = todc_direct_write_val;
 	ppc_md.calibrate_decr = ev64360_calibrate_decr;

 #if defined(CONFIG_SERIAL_TEXT_DEBUG) && defined(CONFIG_SERIAL_MPSC_CONSOLE)
diff -ruN a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2005-10-27 17:02:08.000000000 -0700
+++ b/arch/ppc/syslib/Makefile	2005-10-28 21:22:12.000000000 -0700
@@ -48,6 +48,7 @@
 obj-$(CONFIG_CPCI690)		+= todc_time.o pci_auto.o
 obj-$(CONFIG_EBONY)		+= indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_EV64260)		+= todc_time.o pci_auto.o
+obj-$(CONFIG_EV64360)		+= todc_time.o
 obj-$(CONFIG_CHESTNUT)		+= mv64360_pic.o pci_auto.o
 obj-$(CONFIG_GEMINI)		+= open_pic.o indirect_pci.o
 obj-$(CONFIG_GT64260)		+= gt64260_pic.o
