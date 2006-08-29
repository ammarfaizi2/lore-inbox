Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbWH2SJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbWH2SJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbWH2SJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:09:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59620 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965224AbWH2SGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:06:38 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 19/19] BLOCK: Make it possible to disable the block layer [try #6]
Date: Tue, 29 Aug 2006 19:06:34 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829180634.32596.4507.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
References: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Make it possible to disable the block layer.  Not all embedded devices require
it, some can make do with just JFFS2, NFS, ramfs, etc - none of which require
the block layer to be present.

This patch does the following:

 (*) Introduces CONFIG_BLOCK to disable the block layer, buffering and blockdev
     support.

 (*) Adds dependencies on CONFIG_BLOCK to any configuration item that controls
     an item that uses the block layer.  This includes:

     (*) Block I/O tracing.

     (*) Disk partition code.

     (*) All filesystems that are block based, eg: Ext3, ReiserFS, ISOFS.

     (*) The SCSI layer.  As far as I can tell, even SCSI chardevs use the
     	 block layer to do scheduling.  Some drivers that use SCSI facilities -
     	 such as USB storage - end up disabled indirectly from this.

     (*) Various block-based device drivers, such as IDE and the old CDROM
     	 drivers.

     (*) MTD blockdev handling and FTL.

     (*) JFFS - which uses set_bdev_super(), something it could avoid doing by
     	 taking a leaf out of JFFS2's book.

 (*) Makes most of the contents of linux/blkdev.h, linux/buffer_head.h and
     linux/elevator.h contingent on CONFIG_BLOCK being set.  sector_div() is,
     however, still used in places, and so is still available.

 (*) Also made contingent are the contents of linux/mpage.h, linux/genhd.h and
     parts of linux/fs.h.

 (*) Makes a number of files in fs/ contingent on CONFIG_BLOCK.

 (*) Makes mm/bounce.c (bounce buffering) contingent on CONFIG_BLOCK.

 (*) set_page_dirty() doesn't call __set_page_dirty_buffers() if CONFIG_BLOCK
     is not enabled.

 (*) fs/no-block.c is created to hold out-of-line stubs and things that are
     required when CONFIG_BLOCK is not set:

     (*) Default blockdev file operations (to give error ENODEV on opening).

 (*) Makes some /proc changes:

     (*) /proc/devices does not list any blockdevs.

     (*) /proc/diskstats and /proc/partitions are contingent on CONFIG_BLOCK.

 (*) Makes some compat ioctl handling contingent on CONFIG_BLOCK.

 (*) If CONFIG_BLOCK is not defined, makes sys_quotactl() return -ENODEV if
     given command other than Q_SYNC or if a special device is specified.

 (*) In init/do_mounts.c, no reference is made to the blockdev routines if
     CONFIG_BLOCK is not defined.  This does not prohibit NFS roots or JFFS2.

 (*) The bdflush, ioprio_set and ioprio_get syscalls can now be absent (return
     error ENOSYS by way of cond_syscall if so).

 (*) The seclvl_bd_claim() and seclvl_bd_release() security calls do nothing if
     CONFIG_BLOCK is not set, since they can't then happen.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 block/Kconfig                |   20 +++++++++++++++++
 block/Kconfig.iosched        |    3 +++
 block/Makefile               |    2 +-
 drivers/block/Kconfig        |    4 +++
 drivers/cdrom/Kconfig        |    2 +-
 drivers/char/Kconfig         |    1 +
 drivers/char/random.c        |    4 +++
 drivers/ide/Kconfig          |    4 +++
 drivers/md/Kconfig           |    3 +++
 drivers/message/i2o/Kconfig  |    2 +-
 drivers/mmc/Kconfig          |    2 +-
 drivers/mmc/Makefile         |    3 ++-
 drivers/mtd/Kconfig          |   12 +++++-----
 drivers/mtd/devices/Kconfig  |    2 +-
 drivers/s390/block/Kconfig   |    2 +-
 drivers/scsi/Kconfig         |    2 ++
 fs/Kconfig                   |   31 ++++++++++++++++++++------
 fs/Makefile                  |   14 ++++++++----
 fs/compat_ioctl.c            |   18 +++++++++++++++
 fs/internal.h                |    6 +++++
 fs/no-block.c                |   22 ++++++++++++++++++
 fs/partitions/Makefile       |    2 +-
 fs/proc/proc_misc.c          |   11 ++++++++-
 fs/quota.c                   |   44 ++++++++++++++++++++++++++-----------
 fs/super.c                   |    4 +++
 fs/xfs/Kconfig               |    1 +
 include/linux/blkdev.h       |   50 ++++++++++++++++++++++++++++++------------
 include/linux/buffer_head.h  |   16 +++++++++++++
 include/linux/compat_ioctl.h |    2 ++
 include/linux/elevator.h     |    3 +++
 include/linux/fs.h           |   25 ++++++++++++++++++---
 include/linux/genhd.h        |    4 +++
 include/linux/mpage.h        |    3 +++
 include/linux/raid/md.h      |    3 +++
 include/linux/raid/md_k.h    |    3 +++
 include/scsi/scsi_tcq.h      |    3 ++-
 init/Kconfig                 |    2 +-
 init/do_mounts.c             |   13 ++++++++++-
 kernel/sys_ni.c              |    5 ++++
 mm/Makefile                  |    2 +-
 mm/filemap.c                 |    4 +++
 mm/migrate.c                 |    2 ++
 mm/page-writeback.c          |    8 ++++---
 mm/truncate.c                |    2 ++
 security/seclvl.c            |    4 +++
 45 files changed, 312 insertions(+), 63 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index b6f5f0a..9af6c61 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -1,6 +1,24 @@
 #
 # Block layer core configuration
 #
+config BLOCK
+       bool "Enable the block layer"
+       default y
+       help
+	 This permits the block layer to be removed from the kernel if it's not
+	 needed (on some embedded devices for example).  If this option is
+	 disabled, then blockdev files will become unusable and some
+	 filesystems (such as ext3) will become unavailable.
+
+	 This option will also disable SCSI character devices and USB storage
+	 since they make use of various block layer definitions and
+	 facilities.
+
+	 Say Y here unless you know you really don't want to mount disks and
+	 suchlike.
+
+if BLOCK
+
 #XXX - it makes sense to enable this only for 32-bit subarch's, not for x86_64
 #for instance.
 config LBD
@@ -33,4 +51,6 @@ config LSF
 
 	  If unsure, say Y.
 
+endif
+
 source block/Kconfig.iosched
diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 48d090e..903f0d3 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -1,3 +1,4 @@
+if BLOCK
 
 menu "IO Schedulers"
 
@@ -67,3 +68,5 @@ config DEFAULT_IOSCHED
 	default "noop" if DEFAULT_NOOP
 
 endmenu
+
+endif
diff --git a/block/Makefile b/block/Makefile
index c05de0e..4b84d0d 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -2,7 +2,7 @@ #
 # Makefile for the kernel block layer
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
+obj-$(CONFIG_BLOCK) := elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
 
 obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index b5382ce..422e31d 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -2,6 +2,8 @@ #
 # Block device driver configuration
 #
 
+if BLOCK
+
 menu "Block devices"
 
 config BLK_DEV_FD
@@ -468,3 +470,5 @@ config ATA_OVER_ETH
 	devices like the Coraid EtherDrive (R) Storage Blade.
 
 endmenu
+
+endif
diff --git a/drivers/cdrom/Kconfig b/drivers/cdrom/Kconfig
index ff5652d..4b12e90 100644
--- a/drivers/cdrom/Kconfig
+++ b/drivers/cdrom/Kconfig
@@ -3,7 +3,7 @@ # CDROM driver configuration
 #
 
 menu "Old CD-ROM drivers (not SCSI, not IDE)"
-	depends on ISA
+	depends on ISA && BLOCK
 
 config CD_NO_IDESCSI
 	bool "Support non-SCSI/IDE/ATAPI CDROM drives"
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index c40e487..b9c6777 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -984,6 +984,7 @@ config GPIO_VR41XX
 
 config RAW_DRIVER
 	tristate "RAW driver (/dev/raw/rawN) (OBSOLETE)"
+	depends on BLOCK
 	help
 	  The raw driver permits block devices to be bound to /dev/raw/rawN. 
 	  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O. 
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4c3a5ca..b430a12 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -655,6 +655,7 @@ void add_interrupt_randomness(int irq)
 	add_timer_randomness(irq_timer_state[irq], 0x100 + irq);
 }
 
+#ifdef CONFIG_BLOCK
 void add_disk_randomness(struct gendisk *disk)
 {
 	if (!disk || !disk->random)
@@ -667,6 +668,7 @@ void add_disk_randomness(struct gendisk 
 }
 
 EXPORT_SYMBOL(add_disk_randomness);
+#endif
 
 #define EXTRACT_SIZE 10
 
@@ -918,6 +920,7 @@ void rand_initialize_irq(int irq)
 	}
 }
 
+#ifdef CONFIG_BLOCK
 void rand_initialize_disk(struct gendisk *disk)
 {
 	struct timer_rand_state *state;
@@ -932,6 +935,7 @@ void rand_initialize_disk(struct gendisk
 		disk->random = state;
 	}
 }
+#endif
 
 static ssize_t
 random_read(struct file * file, char __user * buf, size_t nbytes, loff_t *ppos)
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index b6fb167..69d627b 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -4,6 +4,8 @@ #
 # Andre Hedrick <andre@linux-ide.org>
 #
 
+if BLOCK
+
 menu "ATA/ATAPI/MFM/RLL support"
 
 config IDE
@@ -1082,3 +1084,5 @@ config BLK_DEV_HD
 endif
 
 endmenu
+
+endif
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index bf869ed..1e91f90 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -2,6 +2,8 @@ #
 # Block device driver configuration
 #
 
+if CONFIG_BLOCK
+
 menu "Multi-device support (RAID and LVM)"
 
 config MD
@@ -251,3 +253,4 @@ config DM_MULTIPATH_EMC
 
 endmenu
 
+endif
diff --git a/drivers/message/i2o/Kconfig b/drivers/message/i2o/Kconfig
index fef6771..6443392 100644
--- a/drivers/message/i2o/Kconfig
+++ b/drivers/message/i2o/Kconfig
@@ -88,7 +88,7 @@ config I2O_BUS
 
 config I2O_BLOCK
 	tristate "I2O Block OSM"
-	depends on I2O
+	depends on I2O && BLOCK
 	---help---
 	  Include support for the I2O Block OSM. The Block OSM presents disk
 	  and other structured block devices to the operating system. If you
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 45bcf09..f540bd8 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -21,7 +21,7 @@ config MMC_DEBUG
 
 config MMC_BLOCK
 	tristate "MMC block device driver"
-	depends on MMC
+	depends on MMC && BLOCK
 	default y
 	help
 	  Say Y here to enable the MMC block device driver support.
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index d2957e3..b1f6e03 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -24,7 +24,8 @@ obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
 obj-$(CONFIG_MMC_AT91RM9200)	+= at91_mci.o
 
-mmc_core-y := mmc.o mmc_queue.o mmc_sysfs.o
+mmc_core-y := mmc.o mmc_sysfs.o
+mmc_core-$(CONFIG_BLOCK) += mmc_queue.o
 
 ifeq ($(CONFIG_MMC_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 1344ad7..188cd37 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -166,7 +166,7 @@ config MTD_CHAR
 
 config MTD_BLOCK
 	tristate "Caching block device access to MTD devices"
-	depends on MTD
+	depends on MTD && BLOCK
 	---help---
 	  Although most flash chips have an erase size too large to be useful
 	  as block devices, it is possible to use MTD devices which are based
@@ -188,7 +188,7 @@ config MTD_BLOCK
 
 config MTD_BLOCK_RO
 	tristate "Readonly block device access to MTD devices"
-	depends on MTD_BLOCK!=y && MTD
+	depends on MTD_BLOCK!=y && MTD && BLOCK
 	help
 	  This allows you to mount read-only file systems (such as cramfs)
 	  from an MTD device, without the overhead (and danger) of the caching
@@ -199,7 +199,7 @@ config MTD_BLOCK_RO
 
 config FTL
 	tristate "FTL (Flash Translation Layer) support"
-	depends on MTD
+	depends on MTD && BLOCK
 	---help---
 	  This provides support for the original Flash Translation Layer which
 	  is part of the PCMCIA specification. It uses a kind of pseudo-
@@ -215,7 +215,7 @@ config FTL
 
 config NFTL
 	tristate "NFTL (NAND Flash Translation Layer) support"
-	depends on MTD
+	depends on MTD && BLOCK
 	---help---
 	  This provides support for the NAND Flash Translation Layer which is
 	  used on M-Systems' DiskOnChip devices. It uses a kind of pseudo-
@@ -238,7 +238,7 @@ config NFTL_RW
 
 config INFTL
 	tristate "INFTL (Inverse NAND Flash Translation Layer) support"
-	depends on MTD
+	depends on MTD && BLOCK
 	---help---
 	  This provides support for the Inverse NAND Flash Translation
 	  Layer which is used on M-Systems' newer DiskOnChip devices. It
@@ -255,7 +255,7 @@ config INFTL
 
 config RFD_FTL
         tristate "Resident Flash Disk (Flash Translation Layer) support"
-	depends on MTD
+	depends on MTD && BLOCK
 	---help---
 	  This provides support for the flash translation layer known
 	  as the Resident Flash Disk (RFD), as used by the Embedded BIOS
diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 16c02b5..440f685 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -136,7 +136,7 @@ config MTDRAM_ABS_POS
 
 config MTD_BLOCK2MTD
 	tristate "MTD using block device"
-	depends on MTD
+	depends on MTD && BLOCK
 	help
 	  This driver allows a block device to appear as an MTD. It would
 	  generally be used in the following cases:
diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index 929d6ff..b250c53 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -1,4 +1,4 @@
-if S390
+if S390 && BLOCK
 
 comment "S/390 block device drivers"
 	depends on S390
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 96a81cd..0c393f2 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -3,11 +3,13 @@ menu "SCSI device support"
 config RAID_ATTRS
 	tristate "RAID Transport Class"
 	default n
+	depends on BLOCK
 	---help---
 	  Provides RAID
 
 config SCSI
 	tristate "SCSI device support"
+	depends on BLOCK
 	---help---
 	  If you want to use a SCSI hard disk, SCSI tape drive, SCSI CD-ROM or
 	  any other SCSI device under Linux, say Y and make sure that you know
diff --git a/fs/Kconfig b/fs/Kconfig
index 3f00a9f..6d77626 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -4,6 +4,8 @@ #
 
 menu "File systems"
 
+if BLOCK
+
 config EXT2_FS
 	tristate "Second extended fs support"
 	help
@@ -399,6 +401,8 @@ config ROMFS_FS
 	  If you don't know whether you need it, then you don't need it:
 	  answer N.
 
+endif
+
 config INOTIFY
 	bool "Inotify file change notification support"
 	default y
@@ -530,6 +534,7 @@ config FUSE_FS
 	  If you want to develop a userspace FS, or if you want to use
 	  a filesystem based on FUSE, answer Y or M.
 
+if BLOCK
 menu "CD-ROM/DVD Filesystems"
 
 config ISO9660_FS
@@ -597,7 +602,9 @@ config UDF_NLS
 	depends on (UDF_FS=m && NLS) || (UDF_FS=y && NLS=y)
 
 endmenu
+endif
 
+if BLOCK
 menu "DOS/FAT/NT Filesystems"
 
 config FAT_FS
@@ -782,6 +789,7 @@ config NTFS_RW
 	  It is perfectly safe to say N here.
 
 endmenu
+endif
 
 menu "Pseudo filesystems"
 
@@ -907,7 +915,7 @@ menu "Miscellaneous filesystems"
 
 config ADFS_FS
 	tristate "ADFS file system support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on BLOCK && EXPERIMENTAL
 	help
 	  The Acorn Disc Filing System is the standard file system of the
 	  RiscOS operating system which runs on Acorn's ARM-based Risc PC
@@ -935,7 +943,7 @@ config ADFS_FS_RW
 
 config AFFS_FS
 	tristate "Amiga FFS file system support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on BLOCK && EXPERIMENTAL
 	help
 	  The Fast File System (FFS) is the common file system used on hard
 	  disks by Amiga(tm) systems since AmigaOS Version 1.3 (34.20).  Say Y
@@ -957,7 +965,7 @@ config AFFS_FS
 
 config HFS_FS
 	tristate "Apple Macintosh file system support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on BLOCK && EXPERIMENTAL
 	select NLS
 	help
 	  If you say Y here, you will be able to mount Macintosh-formatted
@@ -970,6 +978,7 @@ config HFS_FS
 
 config HFSPLUS_FS
 	tristate "Apple Extended HFS file system support"
+	depends on BLOCK
 	select NLS
 	select NLS_UTF8
 	help
@@ -983,7 +992,7 @@ config HFSPLUS_FS
 
 config BEFS_FS
 	tristate "BeOS file system (BeFS) support (read only) (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on BLOCK && EXPERIMENTAL
 	select NLS
 	help
 	  The BeOS File System (BeFS) is the native file system of Be, Inc's
@@ -1010,7 +1019,7 @@ config BEFS_DEBUG
 
 config BFS_FS
 	tristate "BFS file system support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on BLOCK && EXPERIMENTAL
 	help
 	  Boot File System (BFS) is a file system used under SCO UnixWare to
 	  allow the bootloader access to the kernel image and other important
@@ -1032,7 +1041,7 @@ config BFS_FS
 
 config EFS_FS
 	tristate "EFS file system support (read only) (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on BLOCK && EXPERIMENTAL
 	help
 	  EFS is an older file system used for non-ISO9660 CD-ROMs and hard
 	  disk partitions by SGI's IRIX operating system (IRIX 6.0 and newer
@@ -1047,7 +1056,7 @@ config EFS_FS
 
 config JFFS_FS
 	tristate "Journalling Flash File System (JFFS) support"
-	depends on MTD
+	depends on MTD && BLOCK
 	help
 	  JFFS is the Journaling Flash File System developed by Axis
 	  Communications in Sweden, aimed at providing a crash/powerdown-safe
@@ -1232,6 +1241,7 @@ endchoice
 
 config CRAMFS
 	tristate "Compressed ROM file system support (cramfs)"
+	depends on BLOCK
 	select ZLIB_INFLATE
 	help
 	  Saying Y here includes support for CramFs (Compressed ROM File
@@ -1251,6 +1261,7 @@ config CRAMFS
 
 config VXFS_FS
 	tristate "FreeVxFS file system support (VERITAS VxFS(TM) compatible)"
+	depends on BLOCK
 	help
 	  FreeVxFS is a file system driver that support the VERITAS VxFS(TM)
 	  file system format.  VERITAS VxFS(TM) is the standard file system
@@ -1268,6 +1279,7 @@ config VXFS_FS
 
 config HPFS_FS
 	tristate "OS/2 HPFS file system support"
+	depends on BLOCK
 	help
 	  OS/2 is IBM's operating system for PC's, the same as Warp, and HPFS
 	  is the file system used for organizing files on OS/2 hard disk
@@ -1284,6 +1296,7 @@ config HPFS_FS
 
 config QNX4FS_FS
 	tristate "QNX4 file system support (read only)"
+	depends on BLOCK
 	help
 	  This is the file system used by the real-time operating systems
 	  QNX 4 and QNX 6 (the latter is also called QNX RTP).
@@ -1311,6 +1324,7 @@ config QNX4FS_RW
 
 config SYSV_FS
 	tristate "System V/Xenix/V7/Coherent file system support"
+	depends on BLOCK
 	help
 	  SCO, Xenix and Coherent are commercial Unix systems for Intel
 	  machines, and Version 7 was used on the DEC PDP-11. Saying Y
@@ -1349,6 +1363,7 @@ config SYSV_FS
 
 config UFS_FS
 	tristate "UFS file system support (read only)"
+	depends on BLOCK
 	help
 	  BSD and derivate versions of Unix (such as SunOS, FreeBSD, NetBSD,
 	  OpenBSD and NeXTstep) use a file system called UFS. Some System V
@@ -1923,11 +1938,13 @@ config 9P_FS
 
 endmenu
 
+if BLOCK
 menu "Partition Types"
 
 source "fs/partitions/Kconfig"
 
 endmenu
+endif
 
 source "fs/nls/Kconfig"
 
diff --git a/fs/Makefile b/fs/Makefile
index 8913542..8071c64 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -5,12 +5,18 @@ # 14 Sep 2000, Christoph Hellwig <hch@in
 # Rewritten to use lists instead of if-statements.
 # 
 
-obj-y :=	open.o read_write.o file_table.o buffer.o  bio.o super.o \
-		block_dev.o char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
+obj-y :=	open.o read_write.o file_table.o super.o \
+		char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
-		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
-		ioprio.o pnode.o drop_caches.o splice.o sync.o
+		seq_file.o xattr.o libfs.o fs-writeback.o \
+		pnode.o drop_caches.o splice.o sync.o
+
+ifeq ($(CONFIG_BLOCK),y)
+obj-y +=	buffer.o bio.o block_dev.o direct-io.o mpage.o ioprio.o
+else
+obj-y +=	no-block.o
+endif
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_INOTIFY_USER)	+= inotify_user.o
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index e1a5643..64b3453 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -645,6 +645,7 @@ out:
 }
 #endif
 
+#ifdef CONFIG_BLOCK
 struct hd_geometry32 {
 	unsigned char heads;
 	unsigned char sectors;
@@ -869,6 +870,7 @@ static int sg_grt_trans(unsigned int fd,
 	}
 	return err;
 }
+#endif /* CONFIG_BLOCK */
 
 struct sock_fprog32 {
 	unsigned short	len;
@@ -992,6 +994,7 @@ static int ppp_ioctl_trans(unsigned int 
 }
 
 
+#ifdef CONFIG_BLOCK
 struct mtget32 {
 	compat_long_t	mt_type;
 	compat_long_t	mt_resid;
@@ -1164,6 +1167,7 @@ static int cdrom_ioctl_trans(unsigned in
 
 	return err;
 }
+#endif /* CONFIG_BLOCK */
 
 #ifdef CONFIG_VT
 
@@ -1491,6 +1495,7 @@ ret_einval(unsigned int fd, unsigned int
 	return -EINVAL;
 }
 
+#ifdef CONFIG_BLOCK
 static int broken_blkgetsize(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	/* The mkswap binary hard codes it to Intel value :-((( */
@@ -1525,12 +1530,14 @@ static int blkpg_ioctl_trans(unsigned in
 
 	return sys_ioctl(fd, cmd, (unsigned long)a);
 }
+#endif
 
 static int ioc_settimeout(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	return rw_long(fd, AUTOFS_IOC_SETTIMEOUT, arg);
 }
 
+#ifdef CONFIG_BLOCK
 /* Fix sizeof(sizeof()) breakage */
 #define BLKBSZGET_32   _IOR(0x12,112,int)
 #define BLKBSZSET_32   _IOW(0x12,113,int)
@@ -1551,6 +1558,7 @@ static int do_blkgetsize64(unsigned int 
 {
        return sys_ioctl(fd, BLKGETSIZE64, (unsigned long)compat_ptr(arg));
 }
+#endif
 
 /* Bluetooth ioctls */
 #define HCIUARTSETPROTO	_IOW('U', 200, int)
@@ -1571,6 +1579,7 @@ #define HIDPCONNDEL	_IOW('H', 201, int)
 #define HIDPGETCONNLIST	_IOR('H', 210, int)
 #define HIDPGETCONNINFO	_IOR('H', 211, int)
 
+#ifdef CONFIG_BLOCK
 struct floppy_struct32 {
 	compat_uint_t	size;
 	compat_uint_t	sect;
@@ -1895,6 +1904,7 @@ out:
 	kfree(karg);
 	return err;
 }
+#endif
 
 struct mtd_oob_buf32 {
 	u_int32_t start;
@@ -1936,6 +1946,7 @@ static int mtd_rw_oob(unsigned int fd, u
 	return err;
 }	
 
+#ifdef CONFIG_BLOCK
 struct raw32_config_request
 {
         compat_int_t    raw_minor;
@@ -2000,6 +2011,7 @@ static int raw_ioctl(unsigned fd, unsign
         }
         return ret;
 }
+#endif /* CONFIG_BLOCK */
 
 struct serial_struct32 {
         compat_int_t    type;
@@ -2606,6 +2618,7 @@ HANDLE_IOCTL(SIOCBRDELIF, dev_ifsioc)
 HANDLE_IOCTL(SIOCRTMSG, ret_einval)
 HANDLE_IOCTL(SIOCGSTAMP, do_siocgstamp)
 #endif
+#ifdef CONFIG_BLOCK
 HANDLE_IOCTL(HDIO_GETGEO, hdio_getgeo)
 HANDLE_IOCTL(BLKRAGET, w_long)
 HANDLE_IOCTL(BLKGETSIZE, w_long)
@@ -2631,14 +2644,17 @@ HANDLE_IOCTL(FDGETFDCSTAT32, fd_ioctl_tr
 HANDLE_IOCTL(FDWERRORGET32, fd_ioctl_trans)
 HANDLE_IOCTL(SG_IO,sg_ioctl_trans)
 HANDLE_IOCTL(SG_GET_REQUEST_TABLE, sg_grt_trans)
+#endif
 HANDLE_IOCTL(PPPIOCGIDLE32, ppp_ioctl_trans)
 HANDLE_IOCTL(PPPIOCSCOMPRESS32, ppp_ioctl_trans)
 HANDLE_IOCTL(PPPIOCSPASS32, ppp_sock_fprog_ioctl_trans)
 HANDLE_IOCTL(PPPIOCSACTIVE32, ppp_sock_fprog_ioctl_trans)
+#ifdef CONFIG_BLOCK
 HANDLE_IOCTL(MTIOCGET32, mt_ioctl_trans)
 HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
 HANDLE_IOCTL(CDROMREADAUDIO, cdrom_ioctl_trans)
 HANDLE_IOCTL(CDROM_SEND_PACKET, cdrom_ioctl_trans)
+#endif
 #define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
 HANDLE_IOCTL(AUTOFS_IOC_SETTIMEOUT32, ioc_settimeout)
 #ifdef CONFIG_VT
@@ -2677,12 +2693,14 @@ HANDLE_IOCTL(SONET_SETFRAMING, do_atm_io
 HANDLE_IOCTL(SONET_GETFRAMING, do_atm_ioctl)
 HANDLE_IOCTL(SONET_GETFRSENSE, do_atm_ioctl)
 /* block stuff */
+#ifdef CONFIG_BLOCK
 HANDLE_IOCTL(BLKBSZGET_32, do_blkbszget)
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset)
 HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgetsize64)
 /* Raw devices */
 HANDLE_IOCTL(RAW_SETBIND, raw_ioctl)
 HANDLE_IOCTL(RAW_GETBIND, raw_ioctl)
+#endif
 /* Serial */
 HANDLE_IOCTL(TIOCGSERIAL, serial_struct_ioctl)
 HANDLE_IOCTL(TIOCSSERIAL, serial_struct_ioctl)
diff --git a/fs/internal.h b/fs/internal.h
index f662b70..f07147d 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -14,10 +14,16 @@ #include <linux/ioctl32.h>
 /*
  * block_dev.c
  */
+#ifdef CONFIG_BLOCK
 extern struct super_block *blockdev_superblock;
 extern void __init bdev_cache_init(void);
 
 #define sb_is_blkdev_sb(sb) ((sb) == blockdev_superblock)
+#else
+static inline void bdev_cache_init(void) {}
+
+#define sb_is_blkdev_sb(sb) 0
+#endif
 
 /*
  * char_dev.c
diff --git a/fs/no-block.c b/fs/no-block.c
new file mode 100644
index 0000000..d269a93
--- /dev/null
+++ b/fs/no-block.c
@@ -0,0 +1,22 @@
+/* no-block.c: implementation of routines required for non-BLOCK configuration
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+
+static int no_blkdev_open(struct inode * inode, struct file * filp)
+{
+	return -ENODEV;
+}
+
+const struct file_operations def_blk_fops = {
+	.open		= no_blkdev_open,
+};
diff --git a/fs/partitions/Makefile b/fs/partitions/Makefile
index d713ce6..67e665f 100644
--- a/fs/partitions/Makefile
+++ b/fs/partitions/Makefile
@@ -2,7 +2,7 @@ #
 # Makefile for the linux kernel.
 #
 
-obj-y := check.o
+obj-$(CONFIG_BLOCK) := check.o
 
 obj-$(CONFIG_ACORN_PARTITION) += acorn.o
 obj-$(CONFIG_AMIGA_PARTITION) += amiga.o
diff --git a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
index 9421562..9ac781e 100644
--- a/fs/proc/proc_misc.c
+++ b/fs/proc/proc_misc.c
@@ -268,12 +268,15 @@ static int devinfo_show(struct seq_file 
 		if (i == 0)
 			seq_printf(f, "Character devices:\n");
 		chrdev_show(f, i);
-	} else {
+	}
+#ifdef CONFIG_BLOCK
+	else {
 		i -= CHRDEV_MAJOR_HASH_SIZE;
 		if (i == 0)
 			seq_printf(f, "\nBlock devices:\n");
 		blkdev_show(f, i);
 	}
+#endif
 	return 0;
 }
 
@@ -346,6 +349,7 @@ static int stram_read_proc(char *page, c
 }
 #endif
 
+#ifdef CONFIG_BLOCK
 extern struct seq_operations partitions_op;
 static int partitions_open(struct inode *inode, struct file *file)
 {
@@ -369,6 +373,7 @@ static struct file_operations proc_disks
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
+#endif
 
 #ifdef CONFIG_MODULES
 extern struct seq_operations modules_op;
@@ -686,7 +691,9 @@ #endif
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("devices", 0, &proc_devinfo_operations);
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
+#ifdef CONFIG_BLOCK
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
+#endif
 	create_seq_entry("stat", 0, &proc_stat_operations);
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 #ifdef CONFIG_SLAB
@@ -698,7 +705,9 @@ #endif
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 	create_seq_entry("zoneinfo",S_IRUGO, &proc_zoneinfo_file_operations);
+#ifdef CONFIG_BLOCK
 	create_seq_entry("diskstats", 0, &proc_diskstats_operations);
+#endif
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
 #endif
diff --git a/fs/quota.c b/fs/quota.c
index d6a2be8..b9dae76 100644
--- a/fs/quota.c
+++ b/fs/quota.c
@@ -338,6 +338,34 @@ static int do_quotactl(struct super_bloc
 }
 
 /*
+ * look up a superblock on which quota ops will be performed
+ * - use the name of a block device to find the superblock thereon
+ */
+static inline struct super_block *quotactl_block(const char __user *special)
+{
+#ifdef CONFIG_BLOCK
+	struct block_device *bdev;
+	struct super_block *sb;
+	char *tmp = getname(special);
+
+	if (IS_ERR(tmp))
+		return ERR_PTR(PTR_ERR(tmp));
+	bdev = lookup_bdev(tmp);
+	putname(tmp);
+	if (IS_ERR(bdev))
+		return ERR_PTR(PTR_ERR(bdev));
+	sb = get_super(bdev);
+	bdput(bdev);
+	if (!sb)
+		return ERR_PTR(-ENODEV);
+
+	return sb;
+#else
+	return ERR_PTR(-ENODEV);
+#endif
+}
+
+/*
  * This is the system call interface. This communicates with
  * the user-level programs. Currently this only supports diskquota
  * calls. Maybe we need to add the process quotas etc. in the future,
@@ -347,25 +375,15 @@ asmlinkage long sys_quotactl(unsigned in
 {
 	uint cmds, type;
 	struct super_block *sb = NULL;
-	struct block_device *bdev;
-	char *tmp;
 	int ret;
 
 	cmds = cmd >> SUBCMDSHIFT;
 	type = cmd & SUBCMDMASK;
 
 	if (cmds != Q_SYNC || special) {
-		tmp = getname(special);
-		if (IS_ERR(tmp))
-			return PTR_ERR(tmp);
-		bdev = lookup_bdev(tmp);
-		putname(tmp);
-		if (IS_ERR(bdev))
-			return PTR_ERR(bdev);
-		sb = get_super(bdev);
-		bdput(bdev);
-		if (!sb)
-			return -ENODEV;
+		sb = quotactl_block(special);
+		if (IS_ERR(sb))
+			return PTR_ERR(sb);
 	}
 
 	ret = check_quotactl_valid(sb, type, cmds, id);
diff --git a/fs/super.c b/fs/super.c
index 22c2fd1..33ce475 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -570,8 +570,10 @@ int do_remount_sb(struct super_block *sb
 {
 	int retval;
 	
+#ifdef CONFIG_BLOCK
 	if (!(flags & MS_RDONLY) && bdev_read_only(sb->s_bdev))
 		return -EACCES;
+#endif
 	if (flags & MS_RDONLY)
 		acct_auto_close(sb);
 	shrink_dcache_sb(sb);
@@ -691,6 +693,7 @@ void kill_litter_super(struct super_bloc
 
 EXPORT_SYMBOL(kill_litter_super);
 
+#ifdef CONFIG_BLOCK
 static int set_bdev_super(struct super_block *s, void *data)
 {
 	s->s_bdev = data;
@@ -786,6 +789,7 @@ void kill_block_super(struct super_block
 }
 
 EXPORT_SYMBOL(kill_block_super);
+#endif
 
 int get_sb_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index 26b364c..35115bc 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -1,5 +1,6 @@
 config XFS_FS
 	tristate "XFS filesystem support"
+	depends on BLOCK
 	help
 	  XFS is a high performance journaling filesystem which originated
 	  on the SGI IRIX platform.  It is completely multi-threaded, can
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c0c60d3..32e2c7c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -16,6 +16,22 @@ #include <linux/stringify.h>
 
 #include <asm/scatterlist.h>
 
+#ifdef CONFIG_LBD
+# include <asm/div64.h>
+# define sector_div(a, b) do_div(a, b)
+#else
+# define sector_div(n, b)( \
+{ \
+	int _res; \
+	_res = (n) % (b); \
+	(n) /= (b); \
+	_res; \
+} \
+)
+#endif
+
+#ifdef CONFIG_BLOCK
+
 struct scsi_ioctl_command;
 
 struct request_queue;
@@ -815,24 +831,30 @@ struct work_struct;
 int kblockd_schedule_work(struct work_struct *work);
 void kblockd_flush(void);
 
-#ifdef CONFIG_LBD
-# include <asm/div64.h>
-# define sector_div(a, b) do_div(a, b)
-#else
-# define sector_div(n, b)( \
-{ \
-	int _res; \
-	_res = (n) % (b); \
-	(n) /= (b); \
-	_res; \
-} \
-)
-#endif 
-
 #define MODULE_ALIAS_BLOCKDEV(major,minor) \
 	MODULE_ALIAS("block-major-" __stringify(major) "-" __stringify(minor))
 #define MODULE_ALIAS_BLOCKDEV_MAJOR(major) \
 	MODULE_ALIAS("block-major-" __stringify(major) "-*")
 
 
+#else /* CONFIG_BLOCK */
+/*
+ * stubs for when the block layer is configured out
+ */
+#define buffer_heads_over_limit 0
+
+static inline long blk_congestion_wait(int rw, long timeout)
+{
+	return timeout;
+}
+
+static inline long nr_blockdev_pages(void)
+{
+	return 0;
+}
+
+static inline void exit_io_context(void) {}
+
+#endif /* CONFIG_BLOCK */
+
 #endif
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 64b508e..131ffd3 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -14,6 +14,8 @@ #include <linux/pagemap.h>
 #include <linux/wait.h>
 #include <asm/atomic.h>
 
+#ifdef CONFIG_BLOCK
+
 enum bh_state_bits {
 	BH_Uptodate,	/* Contains valid data */
 	BH_Dirty,	/* Is dirty */
@@ -301,4 +303,18 @@ static inline void lock_buffer(struct bu
 }
 
 extern int __set_page_dirty_buffers(struct page *page);
+
+#else /* CONFIG_BLOCK */
+
+static inline void buffer_init(void) {}
+static inline int try_to_free_buffers(struct page *page) { return 1; }
+static inline int sync_blockdev(struct block_device *bdev) { return 0; }
+static inline int inode_has_buffers(struct inode *inode) { return 0; }
+static inline void invalidate_inode_buffers(struct inode *inode) {}
+static inline int remove_inode_buffers(struct inode *inode) { return 1; }
+static inline int sync_mapping_buffers(struct address_space *mapping) { return 0; }
+static inline void invalidate_bdev(struct block_device *bdev, int destroy_dirty_buffers) {}
+
+
+#endif /* CONFIG_BLOCK */
 #endif /* _LINUX_BUFFER_HEAD_H */
diff --git a/include/linux/compat_ioctl.h b/include/linux/compat_ioctl.h
index 98d40e0..d61ef59 100644
--- a/include/linux/compat_ioctl.h
+++ b/include/linux/compat_ioctl.h
@@ -90,6 +90,7 @@ COMPATIBLE_IOCTL(FDTWADDLE)
 COMPATIBLE_IOCTL(FDFMTTRK)
 COMPATIBLE_IOCTL(FDRAWCMD)
 /* 0x12 */
+#ifdef CONFIG_BLOCK
 COMPATIBLE_IOCTL(BLKRASET)
 COMPATIBLE_IOCTL(BLKROSET)
 COMPATIBLE_IOCTL(BLKROGET)
@@ -103,6 +104,7 @@ COMPATIBLE_IOCTL(BLKTRACESETUP)
 COMPATIBLE_IOCTL(BLKTRACETEARDOWN)
 ULONG_IOCTL(BLKRASET)
 ULONG_IOCTL(BLKFRASET)
+#endif
 /* RAID */
 COMPATIBLE_IOCTL(RAID_VERSION)
 COMPATIBLE_IOCTL(GET_ARRAY_INFO)
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 9c5a04f..b3370ef 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -3,6 +3,8 @@ #define _LINUX_ELEVATOR_H
 
 #include <linux/percpu.h>
 
+#ifdef CONFIG_BLOCK
+
 typedef int (elevator_merge_fn) (request_queue_t *, struct request **,
 				 struct bio *);
 
@@ -203,4 +205,5 @@ ({								\
 	__val;							\
 })
 
+#endif /* CONFIG_BLOCK */
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2d8217a..e915479 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1478,6 +1478,7 @@ #else
 extern void putname(const char *name);
 #endif
 
+#ifdef CONFIG_BLOCK
 extern int register_blkdev(unsigned int, const char *);
 extern int unregister_blkdev(unsigned int, const char *);
 extern struct block_device *bdget(dev_t);
@@ -1486,11 +1487,15 @@ extern void bd_forget(struct inode *inod
 extern void bdput(struct block_device *);
 extern struct block_device *open_by_devnum(dev_t, unsigned);
 extern struct block_device *open_partition_by_devnum(dev_t, unsigned);
-extern const struct file_operations def_blk_fops;
 extern const struct address_space_operations def_blk_aops;
+#else
+static inline void bd_forget(struct inode *inode) {}
+#endif
+extern const struct file_operations def_blk_fops;
 extern const struct file_operations def_chr_fops;
 extern const struct file_operations bad_sock_fops;
 extern const struct file_operations def_fifo_fops;
+#ifdef CONFIG_BLOCK
 extern int ioctl_by_bdev(struct block_device *, unsigned, unsigned long);
 extern int blkdev_ioctl(struct inode *, struct file *, unsigned, unsigned long);
 extern long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
@@ -1506,6 +1511,7 @@ #else
 #define bd_claim_by_disk(bdev, holder, disk)	bd_claim(bdev, holder)
 #define bd_release_from_disk(bdev, disk)	bd_release(bdev)
 #endif
+#endif
 
 /* fs/char_dev.c */
 #define CHRDEV_MAJOR_HASH_SIZE	255
@@ -1519,14 +1525,19 @@ extern int chrdev_open(struct inode *, s
 extern void chrdev_show(struct seq_file *,off_t);
 
 /* fs/block_dev.c */
-#define BLKDEV_MAJOR_HASH_SIZE	255
 #define BDEVNAME_SIZE	32	/* Largest string for a blockdev identifier */
+
+#ifdef CONFIG_BLOCK
+#define BLKDEV_MAJOR_HASH_SIZE	255
 extern const char *__bdevname(dev_t, char *buffer);
 extern const char *bdevname(struct block_device *bdev, char *buffer);
 extern struct block_device *lookup_bdev(const char *);
 extern struct block_device *open_bdev_excl(const char *, int, void *);
 extern void close_bdev_excl(struct block_device *);
 extern void blkdev_show(struct seq_file *,off_t);
+#else
+#define BLKDEV_MAJOR_HASH_SIZE	0
+#endif
 
 extern void init_special_inode(struct inode *, umode_t, dev_t);
 
@@ -1540,6 +1551,7 @@ extern const struct file_operations rdwr
 
 extern int fs_may_remount_ro(struct super_block *);
 
+#ifdef CONFIG_BLOCK
 /*
  * return READ, READA, or WRITE
  */
@@ -1551,9 +1563,10 @@ #define bio_rw(bio)		((bio)->bi_rw & (RW
 #define bio_data_dir(bio)	((bio)->bi_rw & 1)
 
 extern int check_disk_change(struct block_device *);
-extern int invalidate_inodes(struct super_block *);
 extern int __invalidate_device(struct block_device *);
 extern int invalidate_partition(struct gendisk *, int);
+#endif
+extern int invalidate_inodes(struct super_block *);
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					pgoff_t start, pgoff_t end);
 unsigned long invalidate_inode_pages(struct address_space *mapping);
@@ -1586,7 +1599,9 @@ extern void emergency_sync(void);
 extern void emergency_remount(void);
 extern int do_remount_sb(struct super_block *sb, int flags,
 			 void *data, int force);
+#ifdef CONFIG_BLOCK
 extern sector_t bmap(struct inode *, sector_t);
+#endif
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int, struct nameidata *);
 extern int generic_permission(struct inode *, int,
@@ -1669,9 +1684,11 @@ static inline void insert_inode_hash(str
 extern struct file * get_empty_filp(void);
 extern void file_move(struct file *f, struct list_head *list);
 extern void file_kill(struct file *f);
+#ifdef CONFIG_BLOCK
 struct bio;
 extern void submit_bio(int, struct bio *);
 extern int bdev_read_only(struct block_device *);
+#endif
 extern int set_blocksize(struct block_device *, int);
 extern int sb_set_blocksize(struct super_block *, int);
 extern int sb_min_blocksize(struct super_block *, int);
@@ -1752,6 +1769,7 @@ static inline void do_generic_file_read(
 				actor);
 }
 
+#ifdef CONFIG_BLOCK
 ssize_t __blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode,
 	struct block_device *bdev, const struct iovec *iov, loff_t offset,
 	unsigned long nr_segs, get_block_t get_block, dio_iodone_t end_io,
@@ -1789,6 +1807,7 @@ static inline ssize_t blockdev_direct_IO
 	return __blockdev_direct_IO(rw, iocb, inode, bdev, iov, offset,
 				nr_segs, get_block, end_io, DIO_OWN_LOCKING);
 }
+#endif
 
 extern const struct file_operations generic_ro_fops;
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index e4af57e..41f276f 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -11,6 +11,8 @@ #define _LINUX_GENHD_H
 
 #include <linux/types.h>
 
+#ifdef CONFIG_BLOCK
+
 enum {
 /* These three have identical behaviour; use the second one if DOS FDISK gets
    confused about extended/logical partitions starting past cylinder 1023. */
@@ -420,3 +422,5 @@ static inline struct block_device *bdget
 #endif
 
 #endif
+
+#endif
diff --git a/include/linux/mpage.h b/include/linux/mpage.h
index 517c098..cc5fb75 100644
--- a/include/linux/mpage.h
+++ b/include/linux/mpage.h
@@ -9,6 +9,7 @@
  * (And no, it doesn't do the #ifdef __MPAGE_H thing, and it doesn't do
  * nested includes.  Get it right in the .c file).
  */
+#ifdef CONFIG_BLOCK
 
 struct writeback_control;
 typedef int (writepage_t)(struct page *page, struct writeback_control *wbc);
@@ -20,3 +21,5 @@ int mpage_writepages(struct address_spac
 		struct writeback_control *wbc, get_block_t get_block);
 int mpage_writepage(struct page *page, get_block_t *get_block,
 		struct writeback_control *wbc);
+
+#endif
diff --git a/include/linux/raid/md.h b/include/linux/raid/md.h
index eb3e547..c588709 100644
--- a/include/linux/raid/md.h
+++ b/include/linux/raid/md.h
@@ -53,6 +53,8 @@ #include <linux/raid/md_p.h>
 #include <linux/raid/md_u.h>
 #include <linux/raid/md_k.h>
 
+#ifdef CONFIG_MD
+
 /*
  * Different major versions are not compatible.
  * Different minor versions are only downward compatible.
@@ -95,5 +97,6 @@ extern void md_new_event(mddev_t *mddev)
 
 extern void md_update_sb(mddev_t * mddev);
 
+#endif /* CONFIG_MD */
 #endif 
 
diff --git a/include/linux/raid/md_k.h b/include/linux/raid/md_k.h
index d288902..920b94f 100644
--- a/include/linux/raid/md_k.h
+++ b/include/linux/raid/md_k.h
@@ -18,6 +18,8 @@ #define _MD_K_H
 /* and dm-bio-list.h is not under include/linux because.... ??? */
 #include "../../../drivers/md/dm-bio-list.h"
 
+#ifdef CONFIG_BLOCK
+
 #define	LEVEL_MULTIPATH		(-4)
 #define	LEVEL_LINEAR		(-1)
 #define	LEVEL_FAULTY		(-5)
@@ -362,5 +364,6 @@ static inline void safe_put_page(struct 
 	if (p) put_page(p);
 }
 
+#endif /* CONFIG_BLOCK */
 #endif
 
diff --git a/include/scsi/scsi_tcq.h b/include/scsi/scsi_tcq.h
index 1d0b23d..d1d9b10 100644
--- a/include/scsi/scsi_tcq.h
+++ b/include/scsi/scsi_tcq.h
@@ -5,7 +5,6 @@ #include <linux/blkdev.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
 
-
 #define MSG_SIMPLE_TAG	0x20
 #define MSG_HEAD_TAG	0x21
 #define MSG_ORDERED_TAG	0x22
@@ -13,6 +12,7 @@ #define MSG_ORDERED_TAG	0x22
 #define SCSI_NO_TAG	(-1)    /* identify no tag in use */
 
 
+#ifdef CONFIG_BLOCK
 
 /**
  * scsi_get_tag_type - get the type of tag the device supports
@@ -131,4 +131,5 @@ static inline struct scsi_cmnd *scsi_fin
 	return sdev->current_cmnd;
 }
 
+#endif /* CONFIG_BLOCK */
 #endif /* _SCSI_SCSI_TCQ_H */
diff --git a/init/Kconfig b/init/Kconfig
index a099fc6..814bacc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -92,7 +92,7 @@ config LOCALVERSION_AUTO
 
 config SWAP
 	bool "Support for paging of anonymous memory (swap)"
-	depends on MMU
+	depends on MMU && BLOCK
 	default y
 	help
 	  This option allows you to choose whether you want to have support
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 94aeec7..dbb2604 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -284,7 +284,11 @@ void __init mount_block_root(char *name,
 {
 	char *fs_names = __getname();
 	char *p;
+#ifdef CONFIG_BLOCK
 	char b[BDEVNAME_SIZE];
+#else
+	const char *b = name;
+#endif
 
 	get_fs_names(fs_names);
 retry:
@@ -303,7 +307,9 @@ retry:
 		 * Allow the user to distinguish between failed sys_open
 		 * and bad superblock on root device.
 		 */
+#ifdef CONFIG_BLOCK
 		__bdevname(ROOT_DEV, b);
+#endif
 		printk("VFS: Cannot open root device \"%s\" or %s\n",
 				root_device_name, b);
 		printk("Please append a correct \"root=\" boot option\n");
@@ -315,7 +321,10 @@ retry:
 	for (p = fs_names; *p; p += strlen(p)+1)
 		printk(" %s", p);
 	printk("\n");
-	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
+#ifdef CONFIG_BLOCK
+	__bdevname(ROOT_DEV, b);
+#endif
+	panic("VFS: Unable to mount root fs on %s", b);
 out:
 	putname(fs_names);
 }
@@ -386,8 +395,10 @@ #ifdef CONFIG_BLK_DEV_FD
 			change_floppy("root floppy");
 	}
 #endif
+#ifdef CONFIG_BLOCK
 	create_dev("/dev/root", ROOT_DEV);
 	mount_block_root("/dev/root", root_mountflags);
+#endif
 }
 
 /*
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 6991bec..7a3b2e7 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -134,3 +134,8 @@ cond_syscall(sys_madvise);
 cond_syscall(sys_mremap);
 cond_syscall(sys_remap_file_pages);
 cond_syscall(compat_sys_move_pages);
+
+/* block-layer dependent */
+cond_syscall(sys_bdflush);
+cond_syscall(sys_ioprio_set);
+cond_syscall(sys_ioprio_get);
diff --git a/mm/Makefile b/mm/Makefile
index 63637f0..761b08b 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -12,7 +12,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   readahead.o swap.o truncate.o vmscan.o \
 			   prio_tree.o util.o mmzone.o vmstat.o $(mmu-y)
 
-ifeq ($(CONFIG_MMU),y)
+ifeq ($(CONFIG_MMU)$(CONFIG_BLOCK),yy)
 obj-y			+= bounce.o
 endif
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
diff --git a/mm/filemap.c b/mm/filemap.c
index 20a8a9b..6da05fc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2003,6 +2003,7 @@ inline int generic_write_checks(struct f
 		if (unlikely(*pos + *count > inode->i_sb->s_maxbytes))
 			*count = inode->i_sb->s_maxbytes - *pos;
 	} else {
+#ifdef CONFIG_BLOCK
 		loff_t isize;
 		if (bdev_read_only(I_BDEV(inode)))
 			return -EPERM;
@@ -2014,6 +2015,9 @@ inline int generic_write_checks(struct f
 
 		if (*pos + *count > isize)
 			*count = isize - *pos;
+#else
+		return -EPERM;
+#endif
 	}
 	return 0;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 0227163..bedc0ed 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -409,6 +409,7 @@ int migrate_page(struct address_space *m
 }
 EXPORT_SYMBOL(migrate_page);
 
+#ifdef CONFIG_BLOCK
 /*
  * Migration function for pages with buffers. This function can only be used
  * if the underlying filesystem guarantees that no other references to "page"
@@ -466,6 +467,7 @@ int buffer_migrate_page(struct address_s
 	return 0;
 }
 EXPORT_SYMBOL(buffer_migrate_page);
+#endif
 
 /*
  * Writeback a page to clean the dirty state
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eeeaf43..64f4690 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -799,9 +799,11 @@ int fastcall set_page_dirty(struct page 
 
 	if (likely(mapping)) {
 		int (*spd)(struct page *) = mapping->a_ops->set_page_dirty;
-		if (spd)
-			return (*spd)(page);
-		return __set_page_dirty_buffers(page);
+#ifdef CONFIG_BLOCK
+		if (!spd)
+			spd = __set_page_dirty_buffers;
+#endif
+		return (*spd)(page);
 	}
 	if (!PageDirty(page)) {
 		if (!TestSetPageDirty(page))
diff --git a/mm/truncate.c b/mm/truncate.c
index 4b742cf..081437d 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -34,8 +34,10 @@ void do_invalidatepage(struct page *page
 {
 	void (*invalidatepage)(struct page *, unsigned long);
 	invalidatepage = page->mapping->a_ops->invalidatepage;
+#ifdef CONFIG_BLOCK
 	if (!invalidatepage)
 		invalidatepage = block_invalidatepage;
+#endif
 	if (invalidatepage)
 		(*invalidatepage)(page, offset);
 }
diff --git a/security/seclvl.c b/security/seclvl.c
index c26dd7d..fc00df2 100644
--- a/security/seclvl.c
+++ b/security/seclvl.c
@@ -377,6 +377,7 @@ static int seclvl_settime(struct timespe
 /* claim the blockdev to exclude mounters, release on file close */
 static int seclvl_bd_claim(struct inode *inode)
 {
+#ifdef CONFIG_BLOCK
 	int holder;
 	struct block_device *bdev = NULL;
 	dev_t dev = inode->i_rdev;
@@ -389,12 +390,14 @@ static int seclvl_bd_claim(struct inode 
 		/* claimed, mark it to release on close */
 		inode->i_security = current;
 	}
+#endif
 	return 0;
 }
 
 /* release the blockdev if you claimed it */
 static void seclvl_bd_release(struct inode *inode)
 {
+#ifdef CONFIG_BLOCK
 	if (inode && S_ISBLK(inode->i_mode) && inode->i_security == current) {
 		struct block_device *bdev = inode->i_bdev;
 		if (bdev) {
@@ -403,6 +406,7 @@ static void seclvl_bd_release(struct ino
 			inode->i_security = NULL;
 		}
 	}
+#endif
 }
 
 /**
