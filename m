Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269309AbUJWEaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269309AbUJWEaE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUJWE3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:29:05 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:3207
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S267645AbUJWE0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:26:17 -0400
Subject: [patch 1/5] uml: Kconfig and defconfig updates.
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Sat, 23 Oct 2004 05:53:12 +0200
Message-Id: <20041023035314.3C67A509@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Make CONFIG_SMP depend on TT mode. Since SMP does not work in SKAS mode
  (it's still a TODO), add the dependency in the Kconfig. Also mark CONFIG_SMP
  as experimental.
- Workaround kconfig warning: just for now (we wait for a "CONFIG_VIRTUAL_OS"
  to exclude physical hardware) create the CONFIG_INPUT option (fixed to N),
  to avoid complaints from make *config ARCH=um about it being undefined.
- Mark HPPFS as broken and needing updates.
- Update defconfig, both for new kernel options and for changes in the actual
  config. For instance, enable module support by default.
- Update help text for some items and add a help to some other ones.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/Kconfig   |   50 +++++++--
 vanilla-linux-2.6.9-paolo/arch/um/defconfig |  155 ++++++----------------------
 2 files changed, 78 insertions(+), 127 deletions(-)

diff -puN arch/um/Kconfig~uml-smp-depend-on-tt arch/um/Kconfig
--- vanilla-linux-2.6.9/arch/um/Kconfig~uml-smp-depend-on-tt	2004-10-21 01:26:40.107781544 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/Kconfig	2004-10-21 01:26:40.110781088 +0200
@@ -100,7 +100,8 @@ config HOSTFS
         say Y or M here; otherwise say N.
 
 config HPPFS
-	tristate "HoneyPot ProcFS"
+	tristate "HoneyPot ProcFS (EXPERIMENTAL)"
+	depends on BROKEN
 	help
 	hppfs (HoneyPot ProcFS) is a filesystem which allows UML /proc
 	entries to be overridden, removed, or fabricated from the host.
@@ -113,8 +114,12 @@ config HPPFS
 	You only need this if you are setting up a UML honeypot.  Otherwise,
 	it is safe to say 'N' here.
 
+	If you are actively using it, please ask for it to be fixed. In this
+	moment, it does not work on 2.6 (it works somehow on 2.4).
+
 config MCONSOLE
 	bool "Management console"
+	default y
 	help
         The user mode linux management console is a low-level interface to
         the kernel, somewhat like the i386 SysRq interface.  Since there is
@@ -131,19 +136,40 @@ config MCONSOLE
 
 config HOST_2G_2G
 	bool "2G/2G host address space split"
+	default n
+	help
+	This is needed when the host on which you run has a 2G/2G memory
+	split, instead of the customary 3G/1G.
+
+	Note that to enable such a host
+	configuration, which makes sense only in some cases, you need special
+	host patches.
+
+	So, if you do not know what to do here, say 'N'.
 
 config SMP
-	bool "Symmetric multi-processing support"
+	bool "Symmetric multi-processing support (EXPERIMENTAL)"
 	default n
+	depends on MODE_TT && EXPERIMENTAL
 	help
-        This option enables UML SMP support.  UML implements virtual SMP by
-        allowing as many processes to run simultaneously on the host as
-        there are virtual processors configured.  Obviously, if the host is
-        a uniprocessor, those processes will timeshare, but, inside UML,
-        will appear to be running simultaneously.  If the host is a
-        multiprocessor, then UML processes may run simultaneously, depending
-        on the host scheduler.
-        It is safe to leave this unchanged.
+	This option enables UML SMP support.
+	It is NOT related to having a real SMP box. Not directly, at least.
+
+	UML implements virtual SMP by allowing as many processes to run
+	simultaneously on the host as there are virtual processors configured.
+
+	Obviously, if the host is a uniprocessor, those processes will
+	timeshare, but, inside UML, will appear to be running simultaneously.
+	If the host is a multiprocessor, then UML processes may run
+	simultaneously, depending on the host scheduler.
+
+	This, however, is supported only in TT mode. So, if you use the SKAS
+	patch on your host, switching to TT mode and enabling SMP usually gives
+	you worse performances.
+	Also, since the support for SMP has been under-developed, there could
+	be some bugs being exposed by enabling SMP.
+
+	If you don't know what to do, say N.
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
@@ -247,4 +273,8 @@ if BROKEN
 	source "drivers/mtd/Kconfig"
 endif
 
+config INPUT
+	bool
+	default n
+
 source "arch/um/Kconfig.debug"
diff -puN arch/um/defconfig~uml-smp-depend-on-tt arch/um/defconfig
--- vanilla-linux-2.6.9/arch/um/defconfig~uml-smp-depend-on-tt	2004-10-21 01:26:40.108781392 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/defconfig	2004-10-21 01:26:40.110781088 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.9-rc2-mm1
-# Thu Sep 16 23:44:48 2004
+# Linux kernel version: 2.6.9-bk4
+# Thu Oct 21 01:09:54 2004
 #
 CONFIG_USERMODE=y
 CONFIG_MMU=y
@@ -15,15 +15,13 @@ CONFIG_MODE_TT=y
 CONFIG_MODE_SKAS=y
 CONFIG_NET=y
 CONFIG_BINFMT_ELF=y
-CONFIG_BINFMT_MISC=y
+CONFIG_BINFMT_MISC=m
 CONFIG_HOSTFS=y
-CONFIG_HPPFS=y
 CONFIG_MCONSOLE=y
 # CONFIG_HOST_2G_2G is not set
 # CONFIG_SMP is not set
 CONFIG_NEST_LEVEL=0
 CONFIG_KERNEL_HALF_GIGS=1
-# CONFIG_HIGHMEM is not set
 CONFIG_KERNEL_STACK_ORDER=2
 CONFIG_UML_REAL_TIME_CLOCK=y
 
@@ -40,7 +38,7 @@ CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCALVERSION=""
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_POSIX_MQUEUE is not set
+CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
@@ -48,11 +46,12 @@ CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_HOTPLUG is not set
 CONFIG_KOBJECT_UEVENT=y
-# CONFIG_IKCONFIG is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_IOSCHED_NOOP=y
@@ -66,7 +65,12 @@ CONFIG_SHMEM=y
 #
 # Loadable module support
 #
-# CONFIG_MODULES is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+CONFIG_KMOD=y
 
 #
 # Generic Driver Options
@@ -86,6 +90,7 @@ CONFIG_PORT_CHAN=y
 CONFIG_PTY_CHAN=y
 CONFIG_TTY_CHAN=y
 CONFIG_XTERM_CHAN=y
+# CONFIG_NOCONFIG_CHAN is not set
 CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
 CONFIG_CON_CHAN="xterm"
 CONFIG_SSL_CHAN="pty"
@@ -93,22 +98,21 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_WATCHDOG is not set
-CONFIG_UML_SOUND=y
-CONFIG_SOUND=y
-CONFIG_HOSTAUDIO=y
+CONFIG_UML_SOUND=m
+CONFIG_SOUND=m
+CONFIG_HOSTAUDIO=m
 
 #
 # Block Devices
 #
 CONFIG_BLK_DEV_UBD=y
-# CONFIG_BLK_DEV_UBD_SYNC is not set
+CONFIG_BLK_DEV_UBD_SYNC=y
 CONFIG_BLK_DEV_COW_COMMON=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_NBD=y
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_MMAPPER is not set
 CONFIG_NETDEVICES=y
 
 #
@@ -120,7 +124,6 @@ CONFIG_UML_NET_TUNTAP=y
 CONFIG_UML_NET_SLIP=y
 CONFIG_UML_NET_DAEMON=y
 CONFIG_UML_NET_MCAST=y
-# CONFIG_UML_NET_PCAP is not set
 CONFIG_UML_NET_SLIRP=y
 
 #
@@ -178,18 +181,15 @@ CONFIG_INET=y
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
-# CONFIG_KGDBOE is not set
 # CONFIG_NETPOLL is not set
-# CONFIG_NETPOLL_RX is not set
-# CONFIG_NETPOLL_TRAP is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-CONFIG_DUMMY=y
+CONFIG_DUMMY=m
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
-CONFIG_TUN=y
+CONFIG_TUN=m
 
 #
 # Ethernet (10 or 100Mbit)
@@ -217,7 +217,7 @@ CONFIG_TUN=y
 # Wan interfaces
 #
 # CONFIG_WAN is not set
-CONFIG_PPP=y
+CONFIG_PPP=m
 # CONFIG_PPP_MULTILINK is not set
 # CONFIG_PPP_FILTER is not set
 # CONFIG_PPP_ASYNC is not set
@@ -225,7 +225,7 @@ CONFIG_PPP=y
 # CONFIG_PPP_DEFLATE is not set
 # CONFIG_PPP_BSDCOMP is not set
 # CONFIG_PPPOE is not set
-CONFIG_SLIP=y
+CONFIG_SLIP=m
 # CONFIG_SLIP_COMPRESSED is not set
 # CONFIG_SLIP_SMART is not set
 # CONFIG_SLIP_MODE_SLIP6 is not set
@@ -237,47 +237,38 @@ CONFIG_SLIP=y
 #
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
-# CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
-CONFIG_REISER4_FS=y
-CONFIG_REISER4_LARGE_KEY=y
-# CONFIG_REISER4_CHECK is not set
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
 CONFIG_REISERFS_FS=y
 # CONFIG_REISERFS_CHECK is not set
 # CONFIG_REISERFS_PROC_INFO is not set
 # CONFIG_REISERFS_FS_XATTR is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_XFS_FS is not set
-CONFIG_MINIX_FS=y
+# CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_QUOTA=y
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
-CONFIG_AUTOFS_FS=y
-CONFIG_AUTOFS4_FS=y
-
-#
-# Caches
-#
-# CONFIG_CACHEFS is not set
+CONFIG_AUTOFS_FS=m
+CONFIG_AUTOFS4_FS=m
 
 #
 # CD-ROM/DVD Filesystems
 #
-CONFIG_ISO9660_FS=y
-# CONFIG_JOLIET is not set
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
 # CONFIG_ZISOFS is not set
 # CONFIG_UDF_FS is not set
 
 #
 # DOS/FAT/NT Filesystems
 #
-CONFIG_FAT_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
-CONFIG_FAT_DEFAULT_CODEPAGE=437
-CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
 # CONFIG_NTFS_FS is not set
 
 #
@@ -286,11 +277,10 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-CONFIG_DEVFS_FS=y
-CONFIG_DEVFS_MOUNT=y
-# CONFIG_DEVFS_DEBUG is not set
+# CONFIG_DEVFS_FS is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 
@@ -304,10 +294,6 @@ CONFIG_RAMFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-CONFIG_JFFS_FS=y
-CONFIG_JFFS_FS_VERBOSE=0
-# CONFIG_JFFS_PROC_FS is not set
-# CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -396,75 +382,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_LIBCRC32C is not set
 
 #
-# SCSI support
-#
-# CONFIG_SCSI is not set
-
-#
 # Multi-device support (RAID and LVM)
 #
 # CONFIG_MD is not set
-
-#
-# Memory Technology Devices (MTD)
-#
-CONFIG_MTD=y
-# CONFIG_MTD_DEBUG is not set
-# CONFIG_MTD_PARTITIONS is not set
-# CONFIG_MTD_CONCAT is not set
-
-#
-# User Modules And Translation Layers
-#
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=y
-# CONFIG_FTL is not set
-# CONFIG_NFTL is not set
-# CONFIG_INFTL is not set
-
-#
-# RAM/ROM/Flash chip drivers
-#
-# CONFIG_MTD_CFI is not set
-# CONFIG_MTD_JEDECPROBE is not set
-CONFIG_MTD_MAP_BANK_WIDTH_1=y
-CONFIG_MTD_MAP_BANK_WIDTH_2=y
-CONFIG_MTD_MAP_BANK_WIDTH_4=y
-# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
-# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
-# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
-CONFIG_MTD_CFI_I1=y
-CONFIG_MTD_CFI_I2=y
-# CONFIG_MTD_CFI_I4 is not set
-# CONFIG_MTD_CFI_I8 is not set
-# CONFIG_MTD_RAM is not set
-# CONFIG_MTD_ROM is not set
-# CONFIG_MTD_ABSENT is not set
-
-#
-# Mapping drivers for chip access
-#
-# CONFIG_MTD_COMPLEX_MAPPINGS is not set
-
-#
-# Self-contained MTD device drivers
-#
-# CONFIG_MTD_SLRAM is not set
-# CONFIG_MTD_PHRAM is not set
-# CONFIG_MTD_MTDRAM is not set
-CONFIG_MTD_BLKMTD=y
-
-#
-# Disk-On-Chip Device Drivers
-#
-# CONFIG_MTD_DOC2000 is not set
-# CONFIG_MTD_DOC2001 is not set
-# CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
-# CONFIG_MTD_NAND is not set
+# CONFIG_INPUT is not set
 
 #
 # Kernel hacking
_
