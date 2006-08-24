Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWHXNBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWHXNBD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWHXNBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:01:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41380 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751280AbWHXNA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:00:56 -0400
From: David Howells <dhowells@redhat.com>
To: Jens Axboe <axboe@suse.de>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] BLOCK: Make it possible to disable the block layer
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 24 Aug 2006 14:00:42 +0100
Message-ID: <32640.1156424442@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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
     	 block layer to do scheduling.

     (*) Various block-based device drivers, such as IDE, the old CDROM
     	 drivers and USB storage.

     (*) MTD blockdev handling and FTL.

     (*) JFFS - which uses set_bdev_super(), something it could avoid doing by
     	 taking a leaf out of JFFS2's book.

 (*) Made most of the contents of linux/blkdev.h, linux/buffer_head.h and
     linux/elevator.h contingent on CONFIG_BLOCK being set.  sector_div() is,
     however, still used in places.

 (*) The contents of linux/blktrace_api.h are contingent now on CONFIG_BLOCK in
     addition to CONFIG_BLK_DEV_IO_TRACE, possibly unnecessarily.

 (*) Also contingent are the contents of linux/mpage.h, linux/genhd.h and parts
     of linux/fs.h.

 (*) The contents of a number of filesystem- and blockdev-specific header files
     are now contingent on their own configuration options.  This includes:
     Ext3/JBD, RAID, MSDOS and ReiserFS.

 (*) Made a number of files in fs/ contingent on CONFIG_BLOCK.

 (*) Moved some stuff out of fs/buffer.c:

     (*) The file sync and general sync stuff moved to fs/sync.c.

     (*) The superblock sync stuff moved to fs/super.c.

     (*) do_invalidatepage() moved to mm/truncate.c.

     (*) try_to_release_page() moved to mm/filemap.c.

 (*) Moved some stuff between header files:

     (*) declarations for do_invalidatepage() and try_to_release_page() moved
     	 to linux/mm.h.

     (*) __set_page_dirty_buffers() moved to linux/buffer_head.h.

 (*) The duplicate declaration of exit_io_context() has been removed from
     linux/sched.h.

 (*) set_page_dirty() doesn't call __set_page_dirty_buffers() if CONFIG_BLOCK
     is not enabled.

 (*) fallback_migrate_page() uses PagePrivate() instead of page_has_buffers().

 (*) The bounce buffer stuff moved from mm/highmem.c to mm/bounce.c, which is
     contingent on CONFIG_BLOCK.

     !!!NOTE!!! There may be a bug in this code: Should init_emergency_pool()
     		be contingent on CONFIG_HIGHMEM?

 (*) The AFS filesystem specifies block_sync_page() as its sync_page address
     op, which needs to be checked, and so is commented out.

 (*) The bdev_cache_init() extern declaration was moved from fs/dcache.c to
     linux/blkdev.h.

 (*) The blockdev_superblock extern declaration was moved from
     fs/fs-writeback.c to linux/blkdev.h.

 (*) fs/fs-writeback.c no longer depends on blockdev_superblock to be present.

 (*) fs/no-block.c was incorporated to hold a couple of things for when
     CONFIG_BLOCK was not set:

     (*) A version generic_writepages(), which is used by NFS.  This is derived
     	 from mpage_writepages() with all the BIO references removed.

     (*) Default blockdev file operations (to give error ENODEV on opening).

 (*) Some /proc changes:

     (*) /proc/devices does not list any blockdevs.

     (*) /proc/diskstats and /proc/partitions are contingent on CONFIG_BLOCK.

 (*) Some compat ioctl handling is now contingent on CONFIG_BLOCK.

 (*) In init/do_mounts.c, no reference is made to the blockdev routines if
     CONFIG_BLOCK is not defined.  This does not prohibit NFS roots or JFFS2.

 (*) The bdflush, ioprio_set and ioprio_get syscalls can now be absent (return
     error ENOSYS if so).

 (*) The seclvl_bd_claim() and seclvl_bd_release() security calls do nothing if
     CONFIG_BLOCK is not set, since they can't then happen.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 block/Kconfig                       |   14 ++
 block/Kconfig.iosched               |    3 
 block/Makefile                      |    2 
 drivers/block/Kconfig               |    4 
 drivers/cdrom/Kconfig               |    2 
 drivers/char/Kconfig                |    1 
 drivers/char/random.c               |    4 
 drivers/ide/Kconfig                 |    4 
 drivers/ieee1394/Kconfig            |    2 
 drivers/infiniband/ulp/iser/Kconfig |    2 
 drivers/infiniband/ulp/srp/Kconfig  |    2 
 drivers/md/Kconfig                  |    3 
 drivers/message/i2o/Kconfig         |    2 
 drivers/mmc/Kconfig                 |    2 
 drivers/mmc/Makefile                |    3 
 drivers/mtd/Kconfig                 |   12 +
 drivers/mtd/devices/Kconfig         |    2 
 drivers/s390/block/Kconfig          |    2 
 drivers/scsi/Kconfig                |    8 +
 drivers/usb/storage/Kconfig         |    2 
 fs/Kconfig                          |   32 +++-
 fs/Makefile                         |   14 +-
 fs/afs/file.c                       |    2 
 fs/buffer.c                         |  174 --------------------
 fs/compat_ioctl.c                   |   24 +++
 fs/dcache.c                         |    2 
 fs/fs-writeback.c                   |   12 +
 fs/inode.c                          |    6 +
 fs/no-block.c                       |  160 +++++++++++++++++++
 fs/partitions/Makefile              |    2 
 fs/proc/proc_misc.c                 |   11 +
 fs/quota.c                          |    9 +
 fs/super.c                          |   35 ++++
 fs/sync.c                           |  113 +++++++++++++
 fs/xfs/Kconfig                      |    1 
 include/linux/blkdev.h              |   53 +++++-
 include/linux/blktrace_api.h        |    6 +
 include/linux/buffer_head.h         |   19 ++
 include/linux/compat_ioctl.h        |    4 
 include/linux/elevator.h            |    3 
 include/linux/ext3_fs.h             |    3 
 include/linux/ext3_jbd.h            |    3 
 include/linux/fs.h                  |   21 ++
 include/linux/genhd.h               |    4 
 include/linux/jbd.h                 |    3 
 include/linux/loop.h                |    3 
 include/linux/mm.h                  |    4 
 include/linux/mpage.h               |    6 +
 include/linux/msdos_fs.h            |    3 
 include/linux/raid/md.h             |    3 
 include/linux/raid/md_k.h           |    3 
 include/linux/reiserfs_fs.h         |    3 
 include/linux/sched.h               |    1 
 include/scsi/scsi_tcq.h             |    3 
 init/Kconfig                        |    2 
 init/do_mounts.c                    |   13 +-
 kernel/exit.c                       |    1 
 kernel/sys_ni.c                     |    5 +
 mm/Makefile                         |    1 
 mm/bounce.c                         |  302 +++++++++++++++++++++++++++++++++++
 mm/filemap.c                        |   34 ++++
 mm/highmem.c                        |  281 ---------------------------------
 mm/migrate.c                        |    4 
 mm/page-writeback.c                 |    9 +
 mm/truncate.c                       |   26 +++
 security/seclvl.c                   |    4 
 66 files changed, 977 insertions(+), 526 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index b6f5f0a..9cc0d0b 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -1,6 +1,18 @@
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
+	 filesystems (such as ext3) will become unavailable.  Say Y here unless
+	 you know you really don't want to mount disks and suchlike.
+
+if BLOCK
+
 #XXX - it makes sense to enable this only for 32-bit subarch's, not for x86_64
 #for instance.
 config LBD
@@ -33,4 +45,6 @@ config LSF
 
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
index c05de0e..085e967 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -2,7 +2,7 @@ #
 # Makefile for the kernel block layer
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
+obj-$(CONFIG_BLOCK)	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
 
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
diff --git a/drivers/ieee1394/Kconfig b/drivers/ieee1394/Kconfig
index 1867375..c9d84b9 100644
--- a/drivers/ieee1394/Kconfig
+++ b/drivers/ieee1394/Kconfig
@@ -122,7 +122,7 @@ config IEEE1394_VIDEO1394
 
 config IEEE1394_SBP2
 	tristate "SBP-2 support (Harddisks etc.)"
-	depends on IEEE1394 && SCSI && (PCI || BROKEN)
+	depends on IEEE1394 && BLOCK && SCSI && (PCI || BROKEN)
 	help
 	  This option enables you to use SBP-2 devices connected to your IEEE
 	  1394 bus.  SBP-2 devices include harddrives and DVD devices.
diff --git a/drivers/infiniband/ulp/iser/Kconfig b/drivers/infiniband/ulp/iser/Kconfig
index fead87d..f945953 100644
--- a/drivers/infiniband/ulp/iser/Kconfig
+++ b/drivers/infiniband/ulp/iser/Kconfig
@@ -1,6 +1,6 @@
 config INFINIBAND_ISER
 	tristate "ISCSI RDMA Protocol"
-	depends on INFINIBAND && SCSI
+	depends on INFINIBAND && BLOCK && SCSI
 	select SCSI_ISCSI_ATTRS
 	---help---
 	  Support for the ISCSI RDMA Protocol over InfiniBand.  This
diff --git a/drivers/infiniband/ulp/srp/Kconfig b/drivers/infiniband/ulp/srp/Kconfig
index 8fe3be4..63d7d5a 100644
--- a/drivers/infiniband/ulp/srp/Kconfig
+++ b/drivers/infiniband/ulp/srp/Kconfig
@@ -1,6 +1,6 @@
 config INFINIBAND_SRP
 	tristate "InfiniBand SCSI RDMA Protocol"
-	depends on INFINIBAND && SCSI
+	depends on INFINIBAND && BLOCK && SCSI
 	---help---
 	  Support for the SCSI RDMA Protocol over InfiniBand.  This
 	  allows you to access storage devices that speak SRP over
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
index 96a81cd..afcbe19 100644
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
@@ -43,7 +45,7 @@ comment "SCSI support type (disk, tape, 
 
 config BLK_DEV_SD
 	tristate "SCSI disk support"
-	depends on SCSI
+	depends on SCSI && BLOCK
 	---help---
 	  If you want to use SCSI hard disks, Fibre Channel disks,
 	  USB storage or the SCSI or parallel port version of
@@ -98,7 +100,7 @@ config CHR_DEV_OSST
 
 config BLK_DEV_SR
 	tristate "SCSI CDROM support"
-	depends on SCSI
+	depends on SCSI && BLOCK
 	---help---
 	  If you want to use a SCSI or FireWire CD-ROM under Linux,
 	  say Y and read the SCSI-HOWTO and the CDROM-HOWTO at
@@ -473,7 +475,7 @@ source "drivers/scsi/megaraid/Kconfig.me
 
 config SCSI_SATA
 	tristate "Serial ATA (SATA) support"
-	depends on SCSI
+	depends on SCSI && BLOCK
 	help
 	  This driver family supports Serial ATA host controllers
 	  and devices.
diff --git a/drivers/usb/storage/Kconfig b/drivers/usb/storage/Kconfig
index be9eec2..578aa13 100644
--- a/drivers/usb/storage/Kconfig
+++ b/drivers/usb/storage/Kconfig
@@ -8,7 +8,7 @@ comment "may also be needed; see USB_STO
 
 config USB_STORAGE
 	tristate "USB Mass Storage support"
-	depends on USB
+	depends on USB && BLOCK
 	select SCSI
 	---help---
 	  Say Y here if you want to connect USB mass storage devices to your
diff --git a/fs/Kconfig b/fs/Kconfig
index 3f00a9f..dc5e69b 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -4,6 +4,8 @@ #
 
 menu "File systems"
 
+if BLOCK
+
 config EXT2_FS
 	tristate "Second extended fs support"
 	help
@@ -383,8 +385,11 @@ config MINIX_FS
 	  partition (the one containing the directory /) cannot be compiled as
 	  a module.
 
+endif
+
 config ROMFS_FS
 	tristate "ROM file system support"
+	depends on BLOCK
 	---help---
 	  This is a very small read-only file system mainly intended for
 	  initial ram disks of installation disks, but it could be used for
@@ -530,6 +535,7 @@ config FUSE_FS
 	  If you want to develop a userspace FS, or if you want to use
 	  a filesystem based on FUSE, answer Y or M.
 
+if BLOCK
 menu "CD-ROM/DVD Filesystems"
 
 config ISO9660_FS
@@ -597,7 +603,9 @@ config UDF_NLS
 	depends on (UDF_FS=m && NLS) || (UDF_FS=y && NLS=y)
 
 endmenu
+endif
 
+if BLOCK
 menu "DOS/FAT/NT Filesystems"
 
 config FAT_FS
@@ -782,6 +790,7 @@ config NTFS_RW
 	  It is perfectly safe to say N here.
 
 endmenu
+endif
 
 menu "Pseudo filesystems"
 
@@ -907,7 +916,7 @@ menu "Miscellaneous filesystems"
 
 config ADFS_FS
 	tristate "ADFS file system support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on BLOCK && EXPERIMENTAL
 	help
 	  The Acorn Disc Filing System is the standard file system of the
 	  RiscOS operating system which runs on Acorn's ARM-based Risc PC
@@ -935,7 +944,7 @@ config ADFS_FS_RW
 
 config AFFS_FS
 	tristate "Amiga FFS file system support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on BLOCK && EXPERIMENTAL
 	help
 	  The Fast File System (FFS) is the common file system used on hard
 	  disks by Amiga(tm) systems since AmigaOS Version 1.3 (34.20).  Say Y
@@ -957,7 +966,7 @@ config AFFS_FS
 
 config HFS_FS
 	tristate "Apple Macintosh file system support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on BLOCK && EXPERIMENTAL
 	select NLS
 	help
 	  If you say Y here, you will be able to mount Macintosh-formatted
@@ -970,6 +979,7 @@ config HFS_FS
 
 config HFSPLUS_FS
 	tristate "Apple Extended HFS file system support"
+	depends on BLOCK
 	select NLS
 	select NLS_UTF8
 	help
@@ -983,7 +993,7 @@ config HFSPLUS_FS
 
 config BEFS_FS
 	tristate "BeOS file system (BeFS) support (read only) (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on BLOCK && EXPERIMENTAL
 	select NLS
 	help
 	  The BeOS File System (BeFS) is the native file system of Be, Inc's
@@ -1010,7 +1020,7 @@ config BEFS_DEBUG
 
 config BFS_FS
 	tristate "BFS file system support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on BLOCK && EXPERIMENTAL
 	help
 	  Boot File System (BFS) is a file system used under SCO UnixWare to
 	  allow the bootloader access to the kernel image and other important
@@ -1032,7 +1042,7 @@ config BFS_FS
 
 config EFS_FS
 	tristate "EFS file system support (read only) (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on BLOCK && EXPERIMENTAL
 	help
 	  EFS is an older file system used for non-ISO9660 CD-ROMs and hard
 	  disk partitions by SGI's IRIX operating system (IRIX 6.0 and newer
@@ -1047,7 +1057,7 @@ config EFS_FS
 
 config JFFS_FS
 	tristate "Journalling Flash File System (JFFS) support"
-	depends on MTD
+	depends on MTD && BLOCK
 	help
 	  JFFS is the Journaling Flash File System developed by Axis
 	  Communications in Sweden, aimed at providing a crash/powerdown-safe
@@ -1232,6 +1242,7 @@ endchoice
 
 config CRAMFS
 	tristate "Compressed ROM file system support (cramfs)"
+	depends on BLOCK
 	select ZLIB_INFLATE
 	help
 	  Saying Y here includes support for CramFs (Compressed ROM File
@@ -1251,6 +1262,7 @@ config CRAMFS
 
 config VXFS_FS
 	tristate "FreeVxFS file system support (VERITAS VxFS(TM) compatible)"
+	depends on BLOCK
 	help
 	  FreeVxFS is a file system driver that support the VERITAS VxFS(TM)
 	  file system format.  VERITAS VxFS(TM) is the standard file system
@@ -1268,6 +1280,7 @@ config VXFS_FS
 
 config HPFS_FS
 	tristate "OS/2 HPFS file system support"
+	depends on BLOCK
 	help
 	  OS/2 is IBM's operating system for PC's, the same as Warp, and HPFS
 	  is the file system used for organizing files on OS/2 hard disk
@@ -1284,6 +1297,7 @@ config HPFS_FS
 
 config QNX4FS_FS
 	tristate "QNX4 file system support (read only)"
+	depends on BLOCK
 	help
 	  This is the file system used by the real-time operating systems
 	  QNX 4 and QNX 6 (the latter is also called QNX RTP).
@@ -1311,6 +1325,7 @@ config QNX4FS_RW
 
 config SYSV_FS
 	tristate "System V/Xenix/V7/Coherent file system support"
+	depends on BLOCK
 	help
 	  SCO, Xenix and Coherent are commercial Unix systems for Intel
 	  machines, and Version 7 was used on the DEC PDP-11. Saying Y
@@ -1349,6 +1364,7 @@ config SYSV_FS
 
 config UFS_FS
 	tristate "UFS file system support (read only)"
+	depends on BLOCK
 	help
 	  BSD and derivate versions of Unix (such as SunOS, FreeBSD, NetBSD,
 	  OpenBSD and NeXTstep) use a file system called UFS. Some System V
@@ -1923,11 +1939,13 @@ config 9P_FS
 
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
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 67d6634..e1ba855 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -37,7 +37,7 @@ struct inode_operations afs_file_inode_o
 
 const struct address_space_operations afs_fs_aops = {
 	.readpage	= afs_file_readpage,
-	.sync_page	= block_sync_page,
+//	.sync_page	= block_sync_page,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 	.releasepage	= afs_file_releasepage,
 	.invalidatepage	= afs_file_invalidatepage,
diff --git a/fs/buffer.c b/fs/buffer.c
index 71649ef..314b9c4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -159,31 +159,6 @@ int sync_blockdev(struct block_device *b
 }
 EXPORT_SYMBOL(sync_blockdev);
 
-static void __fsync_super(struct super_block *sb)
-{
-	sync_inodes_sb(sb, 0);
-	DQUOT_SYNC(sb);
-	lock_super(sb);
-	if (sb->s_dirt && sb->s_op->write_super)
-		sb->s_op->write_super(sb);
-	unlock_super(sb);
-	if (sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, 1);
-	sync_blockdev(sb->s_bdev);
-	sync_inodes_sb(sb, 1);
-}
-
-/*
- * Write out and wait upon all dirty data associated with this
- * superblock.  Filesystem data as well as the underlying block
- * device.  Takes the superblock lock.
- */
-int fsync_super(struct super_block *sb)
-{
-	__fsync_super(sb);
-	return sync_blockdev(sb->s_bdev);
-}
-
 /*
  * Write out and wait upon all dirty data associated with this
  * device.   Filesystem data as well as the underlying block
@@ -260,118 +235,6 @@ void thaw_bdev(struct block_device *bdev
 EXPORT_SYMBOL(thaw_bdev);
 
 /*
- * sync everything.  Start out by waking pdflush, because that writes back
- * all queues in parallel.
- */
-static void do_sync(unsigned long wait)
-{
-	wakeup_pdflush(0);
-	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
-	DQUOT_SYNC(NULL);
-	sync_supers();		/* Write the superblocks */
-	sync_filesystems(0);	/* Start syncing the filesystems */
-	sync_filesystems(wait);	/* Waitingly sync the filesystems */
-	sync_inodes(wait);	/* Mappings, inodes and blockdevs, again. */
-	if (!wait)
-		printk("Emergency Sync complete\n");
-	if (unlikely(laptop_mode))
-		laptop_sync_completion();
-}
-
-asmlinkage long sys_sync(void)
-{
-	do_sync(1);
-	return 0;
-}
-
-void emergency_sync(void)
-{
-	pdflush_operation(do_sync, 0);
-}
-
-/*
- * Generic function to fsync a file.
- *
- * filp may be NULL if called via the msync of a vma.
- */
- 
-int file_fsync(struct file *filp, struct dentry *dentry, int datasync)
-{
-	struct inode * inode = dentry->d_inode;
-	struct super_block * sb;
-	int ret, err;
-
-	/* sync the inode to buffers */
-	ret = write_inode_now(inode, 0);
-
-	/* sync the superblock to buffers */
-	sb = inode->i_sb;
-	lock_super(sb);
-	if (sb->s_op->write_super)
-		sb->s_op->write_super(sb);
-	unlock_super(sb);
-
-	/* .. finally sync the buffers to disk */
-	err = sync_blockdev(sb->s_bdev);
-	if (!ret)
-		ret = err;
-	return ret;
-}
-
-long do_fsync(struct file *file, int datasync)
-{
-	int ret;
-	int err;
-	struct address_space *mapping = file->f_mapping;
-
-	if (!file->f_op || !file->f_op->fsync) {
-		/* Why?  We can still call filemap_fdatawrite */
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = filemap_fdatawrite(mapping);
-
-	/*
-	 * We need to protect against concurrent writers, which could cause
-	 * livelocks in fsync_buffers_list().
-	 */
-	mutex_lock(&mapping->host->i_mutex);
-	err = file->f_op->fsync(file, file->f_dentry, datasync);
-	if (!ret)
-		ret = err;
-	mutex_unlock(&mapping->host->i_mutex);
-	err = filemap_fdatawait(mapping);
-	if (!ret)
-		ret = err;
-out:
-	return ret;
-}
-
-static long __do_fsync(unsigned int fd, int datasync)
-{
-	struct file *file;
-	int ret = -EBADF;
-
-	file = fget(fd);
-	if (file) {
-		ret = do_fsync(file, datasync);
-		fput(file);
-	}
-	return ret;
-}
-
-asmlinkage long sys_fsync(unsigned int fd)
-{
-	return __do_fsync(fd, 0);
-}
-
-asmlinkage long sys_fdatasync(unsigned int fd)
-{
-	return __do_fsync(fd, 1);
-}
-
-/*
  * Various filesystems appear to want __find_get_block to be non-blocking.
  * But it's the page lock which protects the buffers.  To get around this,
  * we get exclusion from try_to_free_buffers with the blockdev mapping's
@@ -1551,35 +1414,6 @@ static void discard_buffer(struct buffer
 }
 
 /**
- * try_to_release_page() - release old fs-specific metadata on a page
- *
- * @page: the page which the kernel is trying to free
- * @gfp_mask: memory allocation flags (and I/O mode)
- *
- * The address_space is to try to release any data against the page
- * (presumably at page->private).  If the release was successful, return `1'.
- * Otherwise return zero.
- *
- * The @gfp_mask argument specifies whether I/O may be performed to release
- * this page (__GFP_IO), and whether the call may block (__GFP_WAIT).
- *
- * NOTE: @gfp_mask may go away, and this function may become non-blocking.
- */
-int try_to_release_page(struct page *page, gfp_t gfp_mask)
-{
-	struct address_space * const mapping = page->mapping;
-
-	BUG_ON(!PageLocked(page));
-	if (PageWriteback(page))
-		return 0;
-	
-	if (mapping && mapping->a_ops->releasepage)
-		return mapping->a_ops->releasepage(page, gfp_mask);
-	return try_to_free_buffers(page);
-}
-EXPORT_SYMBOL(try_to_release_page);
-
-/**
  * block_invalidatepage - invalidate part of all of a buffer-backed page
  *
  * @page: the page which is affected
@@ -1630,14 +1464,6 @@ out:
 }
 EXPORT_SYMBOL(block_invalidatepage);
 
-void do_invalidatepage(struct page *page, unsigned long offset)
-{
-	void (*invalidatepage)(struct page *, unsigned long);
-	invalidatepage = page->mapping->a_ops->invalidatepage ? :
-		block_invalidatepage;
-	(*invalidatepage)(page, offset);
-}
-
 /*
  * We attach and possibly dirty the buffers atomically wrt
  * __set_page_dirty_buffers() via private_lock.  try_to_free_buffers
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 4063a93..79c79a2 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -176,6 +176,7 @@ static int rw_long(unsigned int fd, unsi
 	return err;
 }
 
+#ifdef CONFIG_BLOCK
 static int do_ext2_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	/* These are just misnamed, they actually get/put from/to user an int */
@@ -203,6 +204,7 @@ #endif
 	}
 	return sys_ioctl(fd, cmd, (unsigned long)compat_ptr(arg));
 }
+#endif
 
 struct compat_video_event {
 	int32_t		type;
@@ -694,6 +696,7 @@ out:
 }
 #endif
 
+#ifdef CONFIG_BLOCK
 struct hd_geometry32 {
 	unsigned char heads;
 	unsigned char sectors;
@@ -918,6 +921,7 @@ static int sg_grt_trans(unsigned int fd,
 	}
 	return err;
 }
+#endif /* CONFIG_BLOCK */
 
 struct sock_fprog32 {
 	unsigned short	len;
@@ -1041,6 +1045,7 @@ static int ppp_ioctl_trans(unsigned int 
 }
 
 
+#ifdef CONFIG_BLOCK
 struct mtget32 {
 	compat_long_t	mt_type;
 	compat_long_t	mt_resid;
@@ -1228,7 +1233,9 @@ struct loop_info32 {
 	compat_ulong_t	lo_init[2];
 	char		reserved[4];
 };
+#endif
 
+#ifdef CONFIG_BLOCK
 static int loop_status(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	mm_segment_t old_fs = get_fs();
@@ -1278,6 +1285,7 @@ static int loop_status(unsigned int fd, 
 	}
 	return err;
 }
+#endif
 
 extern int tty_ioctl(struct inode * inode, struct file * file, unsigned int cmd, unsigned long arg);
 
@@ -1607,6 +1615,7 @@ ret_einval(unsigned int fd, unsigned int
 	return -EINVAL;
 }
 
+#ifdef CONFIG_BLOCK
 static int broken_blkgetsize(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	/* The mkswap binary hard codes it to Intel value :-((( */
@@ -1641,12 +1650,14 @@ static int blkpg_ioctl_trans(unsigned in
 
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
@@ -1667,6 +1678,7 @@ static int do_blkgetsize64(unsigned int 
 {
        return sys_ioctl(fd, BLKGETSIZE64, (unsigned long)compat_ptr(arg));
 }
+#endif
 
 /* Bluetooth ioctls */
 #define HCIUARTSETPROTO	_IOW('U', 200, int)
@@ -1687,6 +1699,7 @@ #define HIDPCONNDEL	_IOW('H', 201, int)
 #define HIDPGETCONNLIST	_IOR('H', 210, int)
 #define HIDPGETCONNINFO	_IOR('H', 211, int)
 
+#ifdef CONFIG_BLOCK
 struct floppy_struct32 {
 	compat_uint_t	size;
 	compat_uint_t	sect;
@@ -2011,6 +2024,7 @@ out:
 	kfree(karg);
 	return err;
 }
+#endif
 
 struct mtd_oob_buf32 {
 	u_int32_t start;
@@ -2055,6 +2069,7 @@ static int mtd_rw_oob(unsigned int fd, u
 #define	VFAT_IOCTL_READDIR_BOTH32	_IOR('r', 1, struct compat_dirent[2])
 #define	VFAT_IOCTL_READDIR_SHORT32	_IOR('r', 2, struct compat_dirent[2])
 
+#ifdef CONFIG_BLOCK
 static long
 put_dirent32 (struct dirent *d, struct compat_dirent __user *d32)
 {
@@ -2171,6 +2186,7 @@ static int raw_ioctl(unsigned fd, unsign
         }
         return ret;
 }
+#endif
 
 struct serial_struct32 {
         compat_int_t    type;
@@ -2777,6 +2793,7 @@ HANDLE_IOCTL(SIOCBRDELIF, dev_ifsioc)
 HANDLE_IOCTL(SIOCRTMSG, ret_einval)
 HANDLE_IOCTL(SIOCGSTAMP, do_siocgstamp)
 #endif
+#ifdef CONFIG_BLOCK
 HANDLE_IOCTL(HDIO_GETGEO, hdio_getgeo)
 HANDLE_IOCTL(BLKRAGET, w_long)
 HANDLE_IOCTL(BLKGETSIZE, w_long)
@@ -2802,16 +2819,19 @@ HANDLE_IOCTL(FDGETFDCSTAT32, fd_ioctl_tr
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
 HANDLE_IOCTL(LOOP_SET_STATUS, loop_status)
 HANDLE_IOCTL(LOOP_GET_STATUS, loop_status)
+#endif
 #define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
 HANDLE_IOCTL(AUTOFS_IOC_SETTIMEOUT32, ioc_settimeout)
 #ifdef CONFIG_VT
@@ -2821,6 +2841,7 @@ HANDLE_IOCTL(PIO_UNIMAP, do_unimap_ioctl
 HANDLE_IOCTL(GIO_UNIMAP, do_unimap_ioctl)
 HANDLE_IOCTL(KDFONTOP, do_kdfontop_ioctl)
 #endif
+#ifdef CONFIG_BLOCK
 HANDLE_IOCTL(EXT2_IOC32_GETFLAGS, do_ext2_ioctl)
 HANDLE_IOCTL(EXT2_IOC32_SETFLAGS, do_ext2_ioctl)
 HANDLE_IOCTL(EXT2_IOC32_GETVERSION, do_ext2_ioctl)
@@ -2834,6 +2855,7 @@ COMPATIBLE_IOCTL(EXT3_IOC_GROUP_ADD)
 #ifdef CONFIG_JBD_DEBUG
 HANDLE_IOCTL(EXT3_IOC32_WAIT_FOR_READONLY, do_ext3_ioctl)
 #endif
+#endif
 /* One SMB ioctl needs translations. */
 #define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_uid_t)
 HANDLE_IOCTL(SMB_IOC_GETMOUNTUID_32, do_smb_getmountuid)
@@ -2863,6 +2885,7 @@ HANDLE_IOCTL(SONET_SETFRAMING, do_atm_io
 HANDLE_IOCTL(SONET_GETFRAMING, do_atm_ioctl)
 HANDLE_IOCTL(SONET_GETFRSENSE, do_atm_ioctl)
 /* block stuff */
+#ifdef CONFIG_BLOCK
 HANDLE_IOCTL(BLKBSZGET_32, do_blkbszget)
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset)
 HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgetsize64)
@@ -2873,6 +2896,7 @@ HANDLE_IOCTL(REISERFS_IOC_UNPACK32, reis
 /* Raw devices */
 HANDLE_IOCTL(RAW_SETBIND, raw_ioctl)
 HANDLE_IOCTL(RAW_GETBIND, raw_ioctl)
+#endif
 /* Serial */
 HANDLE_IOCTL(TIOCGSERIAL, serial_struct_ioctl)
 HANDLE_IOCTL(TIOCSSERIAL, serial_struct_ioctl)
diff --git a/fs/dcache.c b/fs/dcache.c
index 1b4a3a3..886ca6f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@ #include <linux/security.h>
 #include <linux/seqlock.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
+#include <linux/blkdev.h>
 
 
 int sysctl_vfs_cache_pressure __read_mostly = 100;
@@ -1742,7 +1743,6 @@ kmem_cache_t *filp_cachep __read_mostly;
 
 EXPORT_SYMBOL(d_genocide);
 
-extern void bdev_cache_init(void);
 extern void chrdev_init(void);
 
 void __init vfs_caches_init_early(void)
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 892643d..d0c5ea7 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -23,7 +23,11 @@ #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
 
-extern struct super_block *blockdev_superblock;
+#ifdef CONFIG_BLOCK
+#define sb_is_blkdev_sb(sb) ((sb) == blockdev_superblock)
+#else
+#define sb_is_blkdev_sb(sb) 0
+#endif
 
 /**
  *	__mark_inode_dirty -	internal function
@@ -320,7 +324,7 @@ sync_sb_inodes(struct super_block *sb, s
 
 		if (!bdi_cap_writeback_dirty(bdi)) {
 			list_move(&inode->i_list, &sb->s_dirty);
-			if (sb == blockdev_superblock) {
+			if (sb_is_blkdev_sb(sb)) {
 				/*
 				 * Dirty memory-backed blockdev: the ramdisk
 				 * driver does this.  Skip just this inode
@@ -337,14 +341,14 @@ sync_sb_inodes(struct super_block *sb, s
 
 		if (wbc->nonblocking && bdi_write_congested(bdi)) {
 			wbc->encountered_congestion = 1;
-			if (sb != blockdev_superblock)
+			if (!sb_is_blkdev_sb(sb))
 				break;		/* Skip a congested fs */
 			list_move(&inode->i_list, &sb->s_dirty);
 			continue;		/* Skip a congested blockdev */
 		}
 
 		if (wbc->bdi && bdi != wbc->bdi) {
-			if (sb != blockdev_superblock)
+			if (!sb_is_blkdev_sb(sb))
 				break;		/* fs has the wrong queue */
 			list_move(&inode->i_list, &sb->s_dirty);
 			continue;		/* blockdev has wrong queue */
diff --git a/fs/inode.c b/fs/inode.c
index 0bf9f04..cdfff1f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -254,8 +254,10 @@ void clear_inode(struct inode *inode)
 	DQUOT_DROP(inode);
 	if (inode->i_sb && inode->i_sb->s_op->clear_inode)
 		inode->i_sb->s_op->clear_inode(inode);
+#ifdef CONFIG_BLOCK
 	if (inode->i_bdev)
 		bd_forget(inode);
+#endif
 	if (inode->i_cdev)
 		cd_forget(inode);
 	inode->i_state = I_CLEAR;
@@ -363,7 +365,8 @@ int invalidate_inodes(struct super_block
 }
 
 EXPORT_SYMBOL(invalidate_inodes);
- 
+
+#ifdef CONFIG_BLOCK 
 int __invalidate_device(struct block_device *bdev)
 {
 	struct super_block *sb = get_super(bdev);
@@ -384,6 +387,7 @@ int __invalidate_device(struct block_dev
 	return res;
 }
 EXPORT_SYMBOL(__invalidate_device);
+#endif
 
 static int can_unuse(struct inode *inode)
 {
diff --git a/fs/no-block.c b/fs/no-block.c
new file mode 100644
index 0000000..eccea07
--- /dev/null
+++ b/fs/no-block.c
@@ -0,0 +1,160 @@
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
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/mpage.h>
+#include <linux/writeback.h>
+#include <linux/backing-dev.h>
+#include <linux/pagevec.h>
+#include <linux/pagemap.h>
+
+/**
+ * generic_writepages - walk the list of dirty pages of the given
+ *                      address space and writepage() all of them.
+ * 
+ * @mapping: address space structure to write
+ * @wbc: subtract the number of written pages from *@wbc->nr_to_write
+ *
+ * This is a library function, which implements the writepages()
+ * address_space_operation.
+ *
+ * If a page is already under I/O, generic_writepages() skips it, even
+ * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
+ * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
+ * and msync() need to guarantee that all the data which was dirty at the time
+ * the call was made get new I/O started against them.  If wbc->sync_mode is
+ * WB_SYNC_ALL then we were called for data integrity and we must wait for
+ * existing IO to complete.
+ */
+int generic_writepages(struct address_space *mapping,
+		       struct writeback_control *wbc)
+{
+	struct backing_dev_info *bdi = mapping->backing_dev_info;
+	int ret = 0;
+	int done = 0;
+	int (*writepage)(struct page *page, struct writeback_control *wbc);
+	struct pagevec pvec;
+	int nr_pages;
+	pgoff_t index;
+	pgoff_t end;		/* Inclusive */
+	int scanned = 0;
+	int range_whole = 0;
+
+	if (wbc->nonblocking && bdi_write_congested(bdi)) {
+		wbc->encountered_congestion = 1;
+		return 0;
+	}
+
+	writepage = mapping->a_ops->writepage;
+
+	/* deal with chardevs and other special file */
+	if (!writepage)
+		return 0;
+
+	pagevec_init(&pvec, 0);
+	if (wbc->range_cyclic) {
+		index = mapping->writeback_index; /* Start from prev offset */
+		end = -1;
+	} else {
+		index = wbc->range_start >> PAGE_CACHE_SHIFT;
+		end = wbc->range_end >> PAGE_CACHE_SHIFT;
+		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
+			range_whole = 1;
+		scanned = 1;
+	}
+retry:
+	while (!done && (index <= end) &&
+			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
+			PAGECACHE_TAG_DIRTY,
+			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1))) {
+		unsigned i;
+
+		scanned = 1;
+		for (i = 0; i < nr_pages; i++) {
+			struct page *page = pvec.pages[i];
+
+			/*
+			 * At this point we hold neither mapping->tree_lock nor
+			 * lock on the page itself: the page may be truncated or
+			 * invalidated (changing page->mapping to NULL), or even
+			 * swizzled back from swapper_space to tmpfs file
+			 * mapping
+			 */
+
+			lock_page(page);
+
+			if (unlikely(page->mapping != mapping)) {
+				unlock_page(page);
+				continue;
+			}
+
+			if (!wbc->range_cyclic && page->index > end) {
+				done = 1;
+				unlock_page(page);
+				continue;
+			}
+
+			if (wbc->sync_mode != WB_SYNC_NONE)
+				wait_on_page_writeback(page);
+
+			if (PageWriteback(page) ||
+					!clear_page_dirty_for_io(page)) {
+				unlock_page(page);
+				continue;
+			}
+
+			ret = (*writepage)(page, wbc);
+			if (ret) {
+				if (ret == -ENOSPC)
+					set_bit(AS_ENOSPC, &mapping->flags);
+				else
+					set_bit(AS_EIO, &mapping->flags);
+			}
+
+			if (unlikely(ret == AOP_WRITEPAGE_ACTIVATE))
+				unlock_page(page);
+			if (ret || (--(wbc->nr_to_write) <= 0))
+				done = 1;
+			if (wbc->nonblocking && bdi_write_congested(bdi)) {
+				wbc->encountered_congestion = 1;
+				done = 1;
+			}
+		}
+		pagevec_release(&pvec);
+		cond_resched();
+	}
+	if (!scanned && !done) {
+		/*
+		 * We hit the last page and there is more work to be done: wrap
+		 * back to the start of the file
+		 */
+		scanned = 1;
+		index = 0;
+		goto retry;
+	}
+	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
+		mapping->writeback_index = index;
+	return ret;
+}
+
+EXPORT_SYMBOL(generic_writepages);
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
index 9f2cfc3..ed8646e 100644
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
index d6a2be8..0116fb1 100644
--- a/fs/quota.c
+++ b/fs/quota.c
@@ -347,15 +347,15 @@ asmlinkage long sys_quotactl(unsigned in
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
+#ifdef CONFIG_BLOCK
+		struct block_device *bdev;
+		char *tmp = getname(special);
 		if (IS_ERR(tmp))
 			return PTR_ERR(tmp);
 		bdev = lookup_bdev(tmp);
@@ -366,6 +366,9 @@ asmlinkage long sys_quotactl(unsigned in
 		bdput(bdev);
 		if (!sb)
 			return -ENODEV;
+#else
+		return -ENODEV;
+#endif
 	}
 
 	ret = check_quotactl_valid(sb, type, cmds, id);
diff --git a/fs/super.c b/fs/super.c
index 6d4e817..33ce475 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -219,6 +219,37 @@ static int grab_super(struct super_block
 	return 0;
 }
 
+/*
+ * Write out and wait upon all dirty data associated with this
+ * superblock.  Filesystem data as well as the underlying block
+ * device.  Takes the superblock lock.  Requires a second blkdev
+ * flush by the caller to complete the operation.
+ */
+void __fsync_super(struct super_block *sb)
+{
+	sync_inodes_sb(sb, 0);
+	DQUOT_SYNC(sb);
+	lock_super(sb);
+	if (sb->s_dirt && sb->s_op->write_super)
+		sb->s_op->write_super(sb);
+	unlock_super(sb);
+	if (sb->s_op->sync_fs)
+		sb->s_op->sync_fs(sb, 1);
+	sync_blockdev(sb->s_bdev);
+	sync_inodes_sb(sb, 1);
+}
+
+/*
+ * Write out and wait upon all dirty data associated with this
+ * superblock.  Filesystem data as well as the underlying block
+ * device.  Takes the superblock lock.
+ */
+int fsync_super(struct super_block *sb)
+{
+	__fsync_super(sb);
+	return sync_blockdev(sb->s_bdev);
+}
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
@@ -539,8 +570,10 @@ int do_remount_sb(struct super_block *sb
 {
 	int retval;
 	
+#ifdef CONFIG_BLOCK
 	if (!(flags & MS_RDONLY) && bdev_read_only(sb->s_bdev))
 		return -EACCES;
+#endif
 	if (flags & MS_RDONLY)
 		acct_auto_close(sb);
 	shrink_dcache_sb(sb);
@@ -660,6 +693,7 @@ void kill_litter_super(struct super_bloc
 
 EXPORT_SYMBOL(kill_litter_super);
 
+#ifdef CONFIG_BLOCK
 static int set_bdev_super(struct super_block *s, void *data)
 {
 	s->s_bdev = data;
@@ -755,6 +789,7 @@ void kill_block_super(struct super_block
 }
 
 EXPORT_SYMBOL(kill_block_super);
+#endif
 
 int get_sb_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
diff --git a/fs/sync.c b/fs/sync.c
index 955aef0..1de747b 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -10,11 +10,124 @@ #include <linux/writeback.h>
 #include <linux/syscalls.h>
 #include <linux/linkage.h>
 #include <linux/pagemap.h>
+#include <linux/quotaops.h>
+#include <linux/buffer_head.h>
 
 #define VALID_FLAGS (SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE| \
 			SYNC_FILE_RANGE_WAIT_AFTER)
 
 /*
+ * sync everything.  Start out by waking pdflush, because that writes back
+ * all queues in parallel.
+ */
+static void do_sync(unsigned long wait)
+{
+	wakeup_pdflush(0);
+	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
+	DQUOT_SYNC(NULL);
+	sync_supers();		/* Write the superblocks */
+	sync_filesystems(0);	/* Start syncing the filesystems */
+	sync_filesystems(wait);	/* Waitingly sync the filesystems */
+	sync_inodes(wait);	/* Mappings, inodes and blockdevs, again. */
+	if (!wait)
+		printk("Emergency Sync complete\n");
+	if (unlikely(laptop_mode))
+		laptop_sync_completion();
+}
+
+asmlinkage long sys_sync(void)
+{
+	do_sync(1);
+	return 0;
+}
+
+void emergency_sync(void)
+{
+	pdflush_operation(do_sync, 0);
+}
+
+/*
+ * Generic function to fsync a file.
+ *
+ * filp may be NULL if called via the msync of a vma.
+ */
+int file_fsync(struct file *filp, struct dentry *dentry, int datasync)
+{
+	struct inode * inode = dentry->d_inode;
+	struct super_block * sb;
+	int ret, err;
+
+	/* sync the inode to buffers */
+	ret = write_inode_now(inode, 0);
+
+	/* sync the superblock to buffers */
+	sb = inode->i_sb;
+	lock_super(sb);
+	if (sb->s_op->write_super)
+		sb->s_op->write_super(sb);
+	unlock_super(sb);
+
+	/* .. finally sync the buffers to disk */
+	err = sync_blockdev(sb->s_bdev);
+	if (!ret)
+		ret = err;
+	return ret;
+}
+
+long do_fsync(struct file *file, int datasync)
+{
+	int ret;
+	int err;
+	struct address_space *mapping = file->f_mapping;
+
+	if (!file->f_op || !file->f_op->fsync) {
+		/* Why?  We can still call filemap_fdatawrite */
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = filemap_fdatawrite(mapping);
+
+	/*
+	 * We need to protect against concurrent writers, which could cause
+	 * livelocks in fsync_buffers_list().
+	 */
+	mutex_lock(&mapping->host->i_mutex);
+	err = file->f_op->fsync(file, file->f_dentry, datasync);
+	if (!ret)
+		ret = err;
+	mutex_unlock(&mapping->host->i_mutex);
+	err = filemap_fdatawait(mapping);
+	if (!ret)
+		ret = err;
+out:
+	return ret;
+}
+
+static long __do_fsync(unsigned int fd, int datasync)
+{
+	struct file *file;
+	int ret = -EBADF;
+
+	file = fget(fd);
+	if (file) {
+		ret = do_fsync(file, datasync);
+		fput(file);
+	}
+	return ret;
+}
+
+asmlinkage long sys_fsync(unsigned int fd)
+{
+	return __do_fsync(fd, 0);
+}
+
+asmlinkage long sys_fdatasync(unsigned int fd)
+{
+	return __do_fsync(fd, 1);
+}
+
+/*
  * sys_sync_file_range() permits finely controlled syncing over a segment of
  * a file in the range offset .. (offset+nbytes-1) inclusive.  If nbytes is
  * zero then sys_sync_file_range() will operate from offset out to EOF.
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
index aafe827..afde0ab 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -16,6 +16,23 @@ #include <linux/stringify.h>
 
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
+extern struct super_block *blockdev_superblock;
+
 struct scsi_ioctl_command;
 
 struct request_queue;
@@ -821,24 +838,32 @@ struct work_struct;
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
 
+extern void bdev_cache_init(void);
+
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
+static inline void bdev_cache_init(void) {}
+static inline void exit_io_context(void) {}
+
+#endif /* CONFIG_BLOCK */
 
 #endif
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 7520cc1..d3cc58a 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -4,6 +4,8 @@ #define BLKTRACE_H
 #include <linux/blkdev.h>
 #include <linux/relay.h>
 
+#ifdef CONFIG_BLOCK
+
 /*
  * Trace categories
  */
@@ -129,7 +131,9 @@ struct blk_user_trace_setup {
 	u32 pid;
 };
 
-#if defined(CONFIG_BLK_DEV_IO_TRACE)
+#endif
+
+#if defined(CONFIG_BLK_DEV_IO_TRACE) && defined(CONFIG_BLOCK)
 extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);
 extern void blk_trace_shutdown(request_queue_t *);
 extern void __blk_add_trace(struct blk_trace *, sector_t, int, int, u32, int, int, void *);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 737e407..131ffd3 100644
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
@@ -190,9 +192,7 @@ extern int buffer_heads_over_limit;
  * Generic address_space_operations implementations for buffer_head-backed
  * address_spaces.
  */
-int try_to_release_page(struct page * page, gfp_t gfp_mask);
 void block_invalidatepage(struct page *page, unsigned long offset);
-void do_invalidatepage(struct page *page, unsigned long offset);
 int block_write_full_page(struct page *page, get_block_t *get_block,
 				struct writeback_control *wbc);
 int block_read_full_page(struct page*, get_block_t*);
@@ -302,4 +302,19 @@ static inline void lock_buffer(struct bu
 		__lock_buffer(bh);
 }
 
+extern int __set_page_dirty_buffers(struct page *page);
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
index 269d000..0dd47d8 100644
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
@@ -395,11 +397,13 @@ COMPATIBLE_IOCTL(DVD_AUTH)
 /* pktcdvd */
 COMPATIBLE_IOCTL(PACKET_CTRL_CMD)
 /* Big L */
+#ifdef CONFIG_BLOCK
 ULONG_IOCTL(LOOP_SET_FD)
 ULONG_IOCTL(LOOP_CHANGE_FD)
 COMPATIBLE_IOCTL(LOOP_CLR_FD)
 COMPATIBLE_IOCTL(LOOP_GET_STATUS64)
 COMPATIBLE_IOCTL(LOOP_SET_STATUS64)
+#endif
 /* Big A */
 /* sparc only */
 /* Big Q for sound/OSS */
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 1713ace..d2f4b0a 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_ELEVATOR_H
 #define _LINUX_ELEVATOR_H
 
+#ifdef CONFIG_BLOCK
+
 typedef int (elevator_merge_fn) (request_queue_t *, struct request **,
 				 struct bio *);
 
@@ -150,4 +152,5 @@ enum {
 
 #define rq_end_sector(rq)	((rq)->sector + (rq)->nr_sectors)
 
+#endif /* CONFIG_BLOCK */
 #endif
diff --git a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
index 9f9cce7..75697f7 100644
--- a/include/linux/ext3_fs.h
+++ b/include/linux/ext3_fs.h
@@ -18,6 +18,8 @@ #define _LINUX_EXT3_FS_H
 
 #include <linux/types.h>
 
+#if defined(CONFIG_EXT3_FS) || defined(CONFIG_EXT3_FS_MODULE)
+
 /*
  * The second extended filesystem constants/structures
  */
@@ -868,4 +870,5 @@ extern struct inode_operations ext3_fast
 
 #endif	/* __KERNEL__ */
 
+#endif  /* CONFIG_EXT3_FS */
 #endif	/* _LINUX_EXT3_FS_H */
diff --git a/include/linux/ext3_jbd.h b/include/linux/ext3_jbd.h
index c8307c0..9dc4348 100644
--- a/include/linux/ext3_jbd.h
+++ b/include/linux/ext3_jbd.h
@@ -19,6 +19,8 @@ #include <linux/fs.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
 
+#if defined(CONFIG_EXT3_FS) || defined(CONFIG_EXT3_FS_MODULE)
+
 #define EXT3_JOURNAL(inode)	(EXT3_SB((inode)->i_sb)->s_journal)
 
 /* Define the number of blocks we need to account to a transaction to
@@ -265,4 +267,5 @@ static inline int ext3_should_writeback_
 	return 0;
 }
 
+#endif  /* CONFIG_EXT3_FS */
 #endif	/* _LINUX_EXT3_JBD_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2561020..9536426 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1438,6 +1438,7 @@ #else
 extern void putname(const char *name);
 #endif
 
+#ifdef CONFIG_BLOCK
 extern int register_blkdev(unsigned int, const char *);
 extern int unregister_blkdev(unsigned int, const char *);
 extern struct block_device *bdget(dev_t);
@@ -1446,11 +1447,13 @@ extern void bd_forget(struct inode *inod
 extern void bdput(struct block_device *);
 extern struct block_device *open_by_devnum(dev_t, unsigned);
 extern struct block_device *open_partition_by_devnum(dev_t, unsigned);
-extern const struct file_operations def_blk_fops;
 extern const struct address_space_operations def_blk_aops;
+#endif
+extern const struct file_operations def_blk_fops;
 extern const struct file_operations def_chr_fops;
 extern const struct file_operations bad_sock_fops;
 extern const struct file_operations def_fifo_fops;
+#ifdef CONFIG_BLOCK
 extern int ioctl_by_bdev(struct block_device *, unsigned, unsigned long);
 extern int blkdev_ioctl(struct inode *, struct file *, unsigned, unsigned long);
 extern long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
@@ -1466,6 +1469,7 @@ #else
 #define bd_claim_by_disk(bdev, holder, disk)	bd_claim(bdev, holder)
 #define bd_release_from_disk(bdev, disk)	bd_release(bdev)
 #endif
+#endif
 
 /* fs/char_dev.c */
 #define CHRDEV_MAJOR_HASH_SIZE	255
@@ -1479,6 +1483,7 @@ extern int chrdev_open(struct inode *, s
 extern void chrdev_show(struct seq_file *,off_t);
 
 /* fs/block_dev.c */
+#ifdef CONFIG_BLOCK
 #define BLKDEV_MAJOR_HASH_SIZE	255
 #define BDEVNAME_SIZE	32	/* Largest string for a blockdev identifier */
 extern const char *__bdevname(dev_t, char *buffer);
@@ -1487,6 +1492,9 @@ extern struct block_device *lookup_bdev(
 extern struct block_device *open_bdev_excl(const char *, int, void *);
 extern void close_bdev_excl(struct block_device *);
 extern void blkdev_show(struct seq_file *,off_t);
+#else
+#define BLKDEV_MAJOR_HASH_SIZE	0
+#endif
 
 extern void init_special_inode(struct inode *, umode_t, dev_t);
 
@@ -1500,6 +1508,7 @@ extern const struct file_operations rdwr
 
 extern int fs_may_remount_ro(struct super_block *);
 
+#ifdef CONFIG_BLOCK
 /*
  * return READ, READA, or WRITE
  */
@@ -1511,9 +1520,10 @@ #define bio_rw(bio)		((bio)->bi_rw & (RW
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
@@ -1541,11 +1551,14 @@ extern int __filemap_fdatawrite_range(st
 extern long do_fsync(struct file *file, int datasync);
 extern void sync_supers(void);
 extern void sync_filesystems(int wait);
+extern void __fsync_super(struct super_block *sb);
 extern void emergency_sync(void);
 extern void emergency_remount(void);
 extern int do_remount_sb(struct super_block *sb, int flags,
 			 void *data, int force);
+#ifdef CONFIG_BLOCK
 extern sector_t bmap(struct inode *, sector_t);
+#endif
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int, struct nameidata *);
 extern int generic_permission(struct inode *, int,
@@ -1628,9 +1641,11 @@ static inline void insert_inode_hash(str
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
@@ -1711,6 +1726,7 @@ static inline void do_generic_file_read(
 				actor);
 }
 
+#ifdef CONFIG_BLOCK
 ssize_t __blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode,
 	struct block_device *bdev, const struct iovec *iov, loff_t offset,
 	unsigned long nr_segs, get_block_t get_block, dio_iodone_t end_io,
@@ -1748,6 +1764,7 @@ static inline ssize_t blockdev_direct_IO
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
diff --git a/include/linux/jbd.h b/include/linux/jbd.h
index 20eb344..4e5b1d1 100644
--- a/include/linux/jbd.h
+++ b/include/linux/jbd.h
@@ -34,6 +34,8 @@ #include <linux/timer.h>
 #include <asm/semaphore.h>
 #endif
 
+#if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE)
+
 #define journal_oom_retry 1
 
 /*
@@ -1093,4 +1095,5 @@ #define JBUFFER_TRACE(jh, info)	do {} wh
 
 #endif	/* __KERNEL__ */
 
+#endif  /* CONFIG_JBD */
 #endif	/* _LINUX_JBD_H */
diff --git a/include/linux/loop.h b/include/linux/loop.h
index e76c761..b8b733a 100644
--- a/include/linux/loop.h
+++ b/include/linux/loop.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_LOOP_H
 #define _LINUX_LOOP_H
 
+#if defined(CONFIG_BLK_DEV_LOOP) || defined(CONFIG_BLK_DEV_LOOP_MODULE)
+
 /*
  * include/linux/loop.h
  *
@@ -159,4 +161,5 @@ #define LOOP_SET_STATUS64	0x4C04
 #define LOOP_GET_STATUS64	0x4C05
 #define LOOP_CHANGE_FD		0x4C06
 
+#endif /* CONFIG_BLK_DEV_LOOP */
 #endif
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f0b135c..c3c25ef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -767,7 +767,9 @@ int get_user_pages(struct task_struct *t
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
 void print_bad_pte(struct vm_area_struct *, pte_t, unsigned long);
 
-int __set_page_dirty_buffers(struct page *page);
+extern int try_to_release_page(struct page * page, gfp_t gfp_mask);
+extern void do_invalidatepage(struct page *page, unsigned long offset);
+
 int __set_page_dirty_nobuffers(struct page *page);
 int redirty_page_for_writepage(struct writeback_control *wbc,
 				struct page *page);
diff --git a/include/linux/mpage.h b/include/linux/mpage.h
index 3ca8804..c70448f 100644
--- a/include/linux/mpage.h
+++ b/include/linux/mpage.h
@@ -21,8 +21,14 @@ int mpage_writepages(struct address_spac
 int mpage_writepage(struct page *page, get_block_t *get_block,
 		struct writeback_control *wbc);
 
+#ifdef CONFIG_BLOCK
 static inline int
 generic_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	return mpage_writepages(mapping, wbc, NULL);
 }
+#else
+extern int generic_writepages(struct address_space *mapping,
+			      struct writeback_control *wbc);
+
+#endif
diff --git a/include/linux/msdos_fs.h b/include/linux/msdos_fs.h
index d9035c7..a1e0f8b 100644
--- a/include/linux/msdos_fs.h
+++ b/include/linux/msdos_fs.h
@@ -6,6 +6,8 @@ #define _LINUX_MSDOS_FS_H
  */
 #include <asm/byteorder.h>
 
+#if defined(CONFIG_MSDOS_FS) || defined(CONFIG_MSDOS_FS_MODULE)
+
 #define SECTOR_SIZE	512		/* sector size (bytes) */
 #define SECTOR_BITS	9		/* log2(SECTOR_SIZE) */
 #define MSDOS_DPB	(MSDOS_DPS)	/* dir entries per block */
@@ -425,4 +427,5 @@ void fat_cache_destroy(void);
 
 #endif /* __KERNEL__ */
 
+#endif /* CONFIG_MSDOS_FS */
 #endif
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
 
diff --git a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
index daa2d83..bfa067b 100644
--- a/include/linux/reiserfs_fs.h
+++ b/include/linux/reiserfs_fs.h
@@ -26,6 +26,8 @@ #include <linux/reiserfs_fs_i.h>
 #include <linux/reiserfs_fs_sb.h>
 #endif
 
+#if defined(CONFIG_REISERFS_FS) || defined(CONFIG_REISERFS_FS_MODULE)
+
 /*
  *  include/linux/reiser_fs.h
  *
@@ -2188,4 +2190,5 @@ #define reiserfs_write_unlock( sb ) unlo
 /* xattr stuff */
 #define REISERFS_XATTR_DIR_SEM(s) (REISERFS_SB(s)->xattr_dir_sem)
 
+#endif /* CONFIG_REISERFS_FS */
 #endif				/* _LINUX_REISER_FS_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6674fc1..c12c5f9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -709,7 +709,6 @@ #endif	/* CONFIG_SMP */
 
 
 struct io_context;			/* See blkdev.h */
-void exit_io_context(void);
 struct cpuset;
 
 #define NGROUPS_SMALL		32
diff --git a/include/scsi/scsi_tcq.h b/include/scsi/scsi_tcq.h
index e47e36a..bc34746 100644
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
diff --git a/kernel/exit.c b/kernel/exit.c
index dba194a..e0abd78 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -38,6 +38,7 @@ #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/audit.h> /* for audit_free() */
 #include <linux/resource.h>
+#include <linux/blkdev.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
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
index 9dd824c..3af3154 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -12,6 +12,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   readahead.o swap.o truncate.o vmscan.o \
 			   prio_tree.o util.o mmzone.o vmstat.o $(mmu-y)
 
+obj-$(CONFIG_BLOCK)	+= bounce.o
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
diff --git a/mm/bounce.c b/mm/bounce.c
new file mode 100644
index 0000000..e042f87
--- /dev/null
+++ b/mm/bounce.c
@@ -0,0 +1,302 @@
+/* bounce.c: bounce buffer handling for block devices
+ *
+ * - Split from highmem.c
+ */
+
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/swap.h>
+#include <linux/bio.h>
+#include <linux/pagemap.h>
+#include <linux/mempool.h>
+#include <linux/blkdev.h>
+#include <linux/init.h>
+#include <linux/hash.h>
+#include <linux/highmem.h>
+#include <linux/blktrace_api.h>
+#include <asm/tlbflush.h>
+
+#define POOL_SIZE	64
+#define ISA_POOL_SIZE	16
+
+static mempool_t *page_pool, *isa_page_pool;
+
+#ifdef CONFIG_HIGHMEM
+static __init int init_emergency_pool(void)
+{
+	struct sysinfo i;
+	si_meminfo(&i);
+	si_swapinfo(&i);
+        
+	if (!i.totalhigh)
+		return 0;
+
+	page_pool = mempool_create_page_pool(POOL_SIZE, 0);
+	BUG_ON(!page_pool);
+	printk("highmem bounce pool size: %d pages\n", POOL_SIZE);
+
+	return 0;
+}
+
+__initcall(init_emergency_pool);
+
+/*
+ * highmem version, map in to vec
+ */
+static void bounce_copy_vec(struct bio_vec *to, unsigned char *vfrom)
+{
+	unsigned long flags;
+	unsigned char *vto;
+
+	local_irq_save(flags);
+	vto = kmap_atomic(to->bv_page, KM_BOUNCE_READ);
+	memcpy(vto + to->bv_offset, vfrom, to->bv_len);
+	kunmap_atomic(vto, KM_BOUNCE_READ);
+	local_irq_restore(flags);
+}
+
+#else /* CONFIG_HIGHMEM */
+
+#define bounce_copy_vec(to, vfrom)	\
+	memcpy(page_address((to)->bv_page) + (to)->bv_offset, vfrom, (to)->bv_len)
+
+#endif /* CONFIG_HIGHMEM */
+
+/*
+ * allocate pages in the DMA region for the ISA pool
+ */
+static void *mempool_alloc_pages_isa(gfp_t gfp_mask, void *data)
+{
+	return mempool_alloc_pages(gfp_mask | GFP_DMA, data);
+}
+
+/*
+ * gets called "every" time someone init's a queue with BLK_BOUNCE_ISA
+ * as the max address, so check if the pool has already been created.
+ */
+int init_emergency_isa_pool(void)
+{
+	if (isa_page_pool)
+		return 0;
+
+	isa_page_pool = mempool_create(ISA_POOL_SIZE, mempool_alloc_pages_isa,
+				       mempool_free_pages, (void *) 0);
+	BUG_ON(!isa_page_pool);
+
+	printk("isa bounce pool size: %d pages\n", ISA_POOL_SIZE);
+	return 0;
+}
+
+/*
+ * Simple bounce buffer support for highmem pages. Depending on the
+ * queue gfp mask set, *to may or may not be a highmem page. kmap it
+ * always, it will do the Right Thing
+ */
+static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
+{
+	unsigned char *vfrom;
+	struct bio_vec *tovec, *fromvec;
+	int i;
+
+	__bio_for_each_segment(tovec, to, i, 0) {
+		fromvec = from->bi_io_vec + i;
+
+		/*
+		 * not bounced
+		 */
+		if (tovec->bv_page == fromvec->bv_page)
+			continue;
+
+		/*
+		 * fromvec->bv_offset and fromvec->bv_len might have been
+		 * modified by the block layer, so use the original copy,
+		 * bounce_copy_vec already uses tovec->bv_len
+		 */
+		vfrom = page_address(fromvec->bv_page) + tovec->bv_offset;
+
+		flush_dcache_page(tovec->bv_page);
+		bounce_copy_vec(tovec, vfrom);
+	}
+}
+
+static void bounce_end_io(struct bio *bio, mempool_t *pool, int err)
+{
+	struct bio *bio_orig = bio->bi_private;
+	struct bio_vec *bvec, *org_vec;
+	int i;
+
+	if (test_bit(BIO_EOPNOTSUPP, &bio->bi_flags))
+		set_bit(BIO_EOPNOTSUPP, &bio_orig->bi_flags);
+
+	/*
+	 * free up bounce indirect pages used
+	 */
+	__bio_for_each_segment(bvec, bio, i, 0) {
+		org_vec = bio_orig->bi_io_vec + i;
+		if (bvec->bv_page == org_vec->bv_page)
+			continue;
+
+		dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
+		mempool_free(bvec->bv_page, pool);
+	}
+
+	bio_endio(bio_orig, bio_orig->bi_size, err);
+	bio_put(bio);
+}
+
+static int bounce_end_io_write(struct bio *bio, unsigned int bytes_done, int err)
+{
+	if (bio->bi_size)
+		return 1;
+
+	bounce_end_io(bio, page_pool, err);
+	return 0;
+}
+
+static int bounce_end_io_write_isa(struct bio *bio, unsigned int bytes_done, int err)
+{
+	if (bio->bi_size)
+		return 1;
+
+	bounce_end_io(bio, isa_page_pool, err);
+	return 0;
+}
+
+static void __bounce_end_io_read(struct bio *bio, mempool_t *pool, int err)
+{
+	struct bio *bio_orig = bio->bi_private;
+
+	if (test_bit(BIO_UPTODATE, &bio->bi_flags))
+		copy_to_high_bio_irq(bio_orig, bio);
+
+	bounce_end_io(bio, pool, err);
+}
+
+static int bounce_end_io_read(struct bio *bio, unsigned int bytes_done, int err)
+{
+	if (bio->bi_size)
+		return 1;
+
+	__bounce_end_io_read(bio, page_pool, err);
+	return 0;
+}
+
+static int bounce_end_io_read_isa(struct bio *bio, unsigned int bytes_done, int err)
+{
+	if (bio->bi_size)
+		return 1;
+
+	__bounce_end_io_read(bio, isa_page_pool, err);
+	return 0;
+}
+
+static void __blk_queue_bounce(request_queue_t *q, struct bio **bio_orig,
+			       mempool_t *pool)
+{
+	struct page *page;
+	struct bio *bio = NULL;
+	int i, rw = bio_data_dir(*bio_orig);
+	struct bio_vec *to, *from;
+
+	bio_for_each_segment(from, *bio_orig, i) {
+		page = from->bv_page;
+
+		/*
+		 * is destination page below bounce pfn?
+		 */
+		if (page_to_pfn(page) < q->bounce_pfn)
+			continue;
+
+		/*
+		 * irk, bounce it
+		 */
+		if (!bio)
+			bio = bio_alloc(GFP_NOIO, (*bio_orig)->bi_vcnt);
+
+		to = bio->bi_io_vec + i;
+
+		to->bv_page = mempool_alloc(pool, q->bounce_gfp);
+		to->bv_len = from->bv_len;
+		to->bv_offset = from->bv_offset;
+		inc_zone_page_state(to->bv_page, NR_BOUNCE);
+
+		if (rw == WRITE) {
+			char *vto, *vfrom;
+
+			flush_dcache_page(from->bv_page);
+			vto = page_address(to->bv_page) + to->bv_offset;
+			vfrom = kmap(from->bv_page) + from->bv_offset;
+			memcpy(vto, vfrom, to->bv_len);
+			kunmap(from->bv_page);
+		}
+	}
+
+	/*
+	 * no pages bounced
+	 */
+	if (!bio)
+		return;
+
+	/*
+	 * at least one page was bounced, fill in possible non-highmem
+	 * pages
+	 */
+	__bio_for_each_segment(from, *bio_orig, i, 0) {
+		to = bio_iovec_idx(bio, i);
+		if (!to->bv_page) {
+			to->bv_page = from->bv_page;
+			to->bv_len = from->bv_len;
+			to->bv_offset = from->bv_offset;
+		}
+	}
+
+	bio->bi_bdev = (*bio_orig)->bi_bdev;
+	bio->bi_flags |= (1 << BIO_BOUNCED);
+	bio->bi_sector = (*bio_orig)->bi_sector;
+	bio->bi_rw = (*bio_orig)->bi_rw;
+
+	bio->bi_vcnt = (*bio_orig)->bi_vcnt;
+	bio->bi_idx = (*bio_orig)->bi_idx;
+	bio->bi_size = (*bio_orig)->bi_size;
+
+	if (pool == page_pool) {
+		bio->bi_end_io = bounce_end_io_write;
+		if (rw == READ)
+			bio->bi_end_io = bounce_end_io_read;
+	} else {
+		bio->bi_end_io = bounce_end_io_write_isa;
+		if (rw == READ)
+			bio->bi_end_io = bounce_end_io_read_isa;
+	}
+
+	bio->bi_private = *bio_orig;
+	*bio_orig = bio;
+}
+
+void blk_queue_bounce(request_queue_t *q, struct bio **bio_orig)
+{
+	mempool_t *pool;
+
+	/*
+	 * for non-isa bounce case, just check if the bounce pfn is equal
+	 * to or bigger than the highest pfn in the system -- in that case,
+	 * don't waste time iterating over bio segments
+	 */
+	if (!(q->bounce_gfp & GFP_DMA)) {
+		if (q->bounce_pfn >= blk_max_pfn)
+			return;
+		pool = page_pool;
+	} else {
+		BUG_ON(!isa_page_pool);
+		pool = isa_page_pool;
+	}
+
+	blk_add_trace_bio(q, *bio_orig, BLK_TA_BOUNCE);
+
+	/*
+	 * slow path
+	 */
+	__blk_queue_bounce(q, bio_orig, pool);
+}
+
+EXPORT_SYMBOL(blk_queue_bounce);
diff --git a/mm/filemap.c b/mm/filemap.c
index b9a60c4..88d9cd1 100644
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
@@ -2474,3 +2478,33 @@ generic_file_direct_IO(int rw, struct ki
 	}
 	return retval;
 }
+
+/**
+ * try_to_release_page() - release old fs-specific metadata on a page
+ *
+ * @page: the page which the kernel is trying to free
+ * @gfp_mask: memory allocation flags (and I/O mode)
+ *
+ * The address_space is to try to release any data against the page
+ * (presumably at page->private).  If the release was successful, return `1'.
+ * Otherwise return zero.
+ *
+ * The @gfp_mask argument specifies whether I/O may be performed to release
+ * this page (__GFP_IO), and whether the call may block (__GFP_WAIT).
+ *
+ * NOTE: @gfp_mask may go away, and this function may become non-blocking.
+ */
+int try_to_release_page(struct page *page, gfp_t gfp_mask)
+{
+	struct address_space * const mapping = page->mapping;
+
+	BUG_ON(!PageLocked(page));
+	if (PageWriteback(page))
+		return 0;
+	
+	if (mapping && mapping->a_ops->releasepage)
+		return mapping->a_ops->releasepage(page, gfp_mask);
+	return try_to_free_buffers(page);
+}
+
+EXPORT_SYMBOL(try_to_release_page);
diff --git a/mm/highmem.c b/mm/highmem.c
index 9b2a540..1ac20d6 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -29,13 +29,6 @@ #include <linux/highmem.h>
 #include <linux/blktrace_api.h>
 #include <asm/tlbflush.h>
 
-static mempool_t *page_pool, *isa_page_pool;
-
-static void *mempool_alloc_pages_isa(gfp_t gfp_mask, void *data)
-{
-	return mempool_alloc_pages(gfp_mask | GFP_DMA, data);
-}
-
 /*
  * Virtual_count is not a pure "count".
  *  0 means that it is not mapped, and has not been mapped
@@ -204,282 +197,8 @@ void fastcall kunmap_high(struct page *p
 }
 
 EXPORT_SYMBOL(kunmap_high);
-
-#define POOL_SIZE	64
-
-static __init int init_emergency_pool(void)
-{
-	struct sysinfo i;
-	si_meminfo(&i);
-	si_swapinfo(&i);
-        
-	if (!i.totalhigh)
-		return 0;
-
-	page_pool = mempool_create_page_pool(POOL_SIZE, 0);
-	BUG_ON(!page_pool);
-	printk("highmem bounce pool size: %d pages\n", POOL_SIZE);
-
-	return 0;
-}
-
-__initcall(init_emergency_pool);
-
-/*
- * highmem version, map in to vec
- */
-static void bounce_copy_vec(struct bio_vec *to, unsigned char *vfrom)
-{
-	unsigned long flags;
-	unsigned char *vto;
-
-	local_irq_save(flags);
-	vto = kmap_atomic(to->bv_page, KM_BOUNCE_READ);
-	memcpy(vto + to->bv_offset, vfrom, to->bv_len);
-	kunmap_atomic(vto, KM_BOUNCE_READ);
-	local_irq_restore(flags);
-}
-
-#else /* CONFIG_HIGHMEM */
-
-#define bounce_copy_vec(to, vfrom)	\
-	memcpy(page_address((to)->bv_page) + (to)->bv_offset, vfrom, (to)->bv_len)
-
 #endif
 
-#define ISA_POOL_SIZE	16
-
-/*
- * gets called "every" time someone init's a queue with BLK_BOUNCE_ISA
- * as the max address, so check if the pool has already been created.
- */
-int init_emergency_isa_pool(void)
-{
-	if (isa_page_pool)
-		return 0;
-
-	isa_page_pool = mempool_create(ISA_POOL_SIZE, mempool_alloc_pages_isa,
-				       mempool_free_pages, (void *) 0);
-	BUG_ON(!isa_page_pool);
-
-	printk("isa bounce pool size: %d pages\n", ISA_POOL_SIZE);
-	return 0;
-}
-
-/*
- * Simple bounce buffer support for highmem pages. Depending on the
- * queue gfp mask set, *to may or may not be a highmem page. kmap it
- * always, it will do the Right Thing
- */
-static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
-{
-	unsigned char *vfrom;
-	struct bio_vec *tovec, *fromvec;
-	int i;
-
-	__bio_for_each_segment(tovec, to, i, 0) {
-		fromvec = from->bi_io_vec + i;
-
-		/*
-		 * not bounced
-		 */
-		if (tovec->bv_page == fromvec->bv_page)
-			continue;
-
-		/*
-		 * fromvec->bv_offset and fromvec->bv_len might have been
-		 * modified by the block layer, so use the original copy,
-		 * bounce_copy_vec already uses tovec->bv_len
-		 */
-		vfrom = page_address(fromvec->bv_page) + tovec->bv_offset;
-
-		flush_dcache_page(tovec->bv_page);
-		bounce_copy_vec(tovec, vfrom);
-	}
-}
-
-static void bounce_end_io(struct bio *bio, mempool_t *pool, int err)
-{
-	struct bio *bio_orig = bio->bi_private;
-	struct bio_vec *bvec, *org_vec;
-	int i;
-
-	if (test_bit(BIO_EOPNOTSUPP, &bio->bi_flags))
-		set_bit(BIO_EOPNOTSUPP, &bio_orig->bi_flags);
-
-	/*
-	 * free up bounce indirect pages used
-	 */
-	__bio_for_each_segment(bvec, bio, i, 0) {
-		org_vec = bio_orig->bi_io_vec + i;
-		if (bvec->bv_page == org_vec->bv_page)
-			continue;
-
-		dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
-		mempool_free(bvec->bv_page, pool);
-	}
-
-	bio_endio(bio_orig, bio_orig->bi_size, err);
-	bio_put(bio);
-}
-
-static int bounce_end_io_write(struct bio *bio, unsigned int bytes_done, int err)
-{
-	if (bio->bi_size)
-		return 1;
-
-	bounce_end_io(bio, page_pool, err);
-	return 0;
-}
-
-static int bounce_end_io_write_isa(struct bio *bio, unsigned int bytes_done, int err)
-{
-	if (bio->bi_size)
-		return 1;
-
-	bounce_end_io(bio, isa_page_pool, err);
-	return 0;
-}
-
-static void __bounce_end_io_read(struct bio *bio, mempool_t *pool, int err)
-{
-	struct bio *bio_orig = bio->bi_private;
-
-	if (test_bit(BIO_UPTODATE, &bio->bi_flags))
-		copy_to_high_bio_irq(bio_orig, bio);
-
-	bounce_end_io(bio, pool, err);
-}
-
-static int bounce_end_io_read(struct bio *bio, unsigned int bytes_done, int err)
-{
-	if (bio->bi_size)
-		return 1;
-
-	__bounce_end_io_read(bio, page_pool, err);
-	return 0;
-}
-
-static int bounce_end_io_read_isa(struct bio *bio, unsigned int bytes_done, int err)
-{
-	if (bio->bi_size)
-		return 1;
-
-	__bounce_end_io_read(bio, isa_page_pool, err);
-	return 0;
-}
-
-static void __blk_queue_bounce(request_queue_t *q, struct bio **bio_orig,
-			       mempool_t *pool)
-{
-	struct page *page;
-	struct bio *bio = NULL;
-	int i, rw = bio_data_dir(*bio_orig);
-	struct bio_vec *to, *from;
-
-	bio_for_each_segment(from, *bio_orig, i) {
-		page = from->bv_page;
-
-		/*
-		 * is destination page below bounce pfn?
-		 */
-		if (page_to_pfn(page) < q->bounce_pfn)
-			continue;
-
-		/*
-		 * irk, bounce it
-		 */
-		if (!bio)
-			bio = bio_alloc(GFP_NOIO, (*bio_orig)->bi_vcnt);
-
-		to = bio->bi_io_vec + i;
-
-		to->bv_page = mempool_alloc(pool, q->bounce_gfp);
-		to->bv_len = from->bv_len;
-		to->bv_offset = from->bv_offset;
-		inc_zone_page_state(to->bv_page, NR_BOUNCE);
-
-		if (rw == WRITE) {
-			char *vto, *vfrom;
-
-			flush_dcache_page(from->bv_page);
-			vto = page_address(to->bv_page) + to->bv_offset;
-			vfrom = kmap(from->bv_page) + from->bv_offset;
-			memcpy(vto, vfrom, to->bv_len);
-			kunmap(from->bv_page);
-		}
-	}
-
-	/*
-	 * no pages bounced
-	 */
-	if (!bio)
-		return;
-
-	/*
-	 * at least one page was bounced, fill in possible non-highmem
-	 * pages
-	 */
-	__bio_for_each_segment(from, *bio_orig, i, 0) {
-		to = bio_iovec_idx(bio, i);
-		if (!to->bv_page) {
-			to->bv_page = from->bv_page;
-			to->bv_len = from->bv_len;
-			to->bv_offset = from->bv_offset;
-		}
-	}
-
-	bio->bi_bdev = (*bio_orig)->bi_bdev;
-	bio->bi_flags |= (1 << BIO_BOUNCED);
-	bio->bi_sector = (*bio_orig)->bi_sector;
-	bio->bi_rw = (*bio_orig)->bi_rw;
-
-	bio->bi_vcnt = (*bio_orig)->bi_vcnt;
-	bio->bi_idx = (*bio_orig)->bi_idx;
-	bio->bi_size = (*bio_orig)->bi_size;
-
-	if (pool == page_pool) {
-		bio->bi_end_io = bounce_end_io_write;
-		if (rw == READ)
-			bio->bi_end_io = bounce_end_io_read;
-	} else {
-		bio->bi_end_io = bounce_end_io_write_isa;
-		if (rw == READ)
-			bio->bi_end_io = bounce_end_io_read_isa;
-	}
-
-	bio->bi_private = *bio_orig;
-	*bio_orig = bio;
-}
-
-void blk_queue_bounce(request_queue_t *q, struct bio **bio_orig)
-{
-	mempool_t *pool;
-
-	/*
-	 * for non-isa bounce case, just check if the bounce pfn is equal
-	 * to or bigger than the highest pfn in the system -- in that case,
-	 * don't waste time iterating over bio segments
-	 */
-	if (!(q->bounce_gfp & GFP_DMA)) {
-		if (q->bounce_pfn >= blk_max_pfn)
-			return;
-		pool = page_pool;
-	} else {
-		BUG_ON(!isa_page_pool);
-		pool = isa_page_pool;
-	}
-
-	blk_add_trace_bio(q, *bio_orig, BLK_TA_BOUNCE);
-
-	/*
-	 * slow path
-	 */
-	__blk_queue_bounce(q, bio_orig, pool);
-}
-
-EXPORT_SYMBOL(blk_queue_bounce);
-
 #if defined(HASHED_PAGE_VIRTUAL)
 
 #define PA_HASH_ORDER	7
diff --git a/mm/migrate.c b/mm/migrate.c
index 3f1e0c2..bedc0ed 100644
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
@@ -525,7 +527,7 @@ static int fallback_migrate_page(struct 
 	 * Buffers may be managed in a filesystem specific way.
 	 * We must have no buffers or drop them.
 	 */
-	if (page_has_buffers(page) &&
+	if (PagePrivate(page) &&
 	    !try_to_release_page(page, GFP_KERNEL))
 		return -EAGAIN;
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e630188..e2cc3af 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -29,6 +29,7 @@ #include <linux/smp.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/buffer_head.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -664,9 +665,11 @@ int fastcall set_page_dirty(struct page 
 
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
index cf1b015..081437d 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -16,6 +16,32 @@ #include <linux/buffer_head.h>	/* grr. t
 				   do_invalidatepage */
 
 
+/**
+ * do_invalidatepage - invalidate part of all of a page
+ * @page: the page which is affected
+ * @offset: the index of the truncation point
+ *
+ * do_invalidatepage() is called when all or part of the page has become
+ * invalidated by a truncate operation.
+ *
+ * do_invalidatepage() does not have to release all buffers, but it must
+ * ensure that no dirty buffer is left outside @offset and that no I/O
+ * is underway against any of the blocks which are outside the truncation
+ * point.  Because the caller is about to free (and possibly reuse) those
+ * blocks on-disk.
+ */
+void do_invalidatepage(struct page *page, unsigned long offset)
+{
+	void (*invalidatepage)(struct page *, unsigned long);
+	invalidatepage = page->mapping->a_ops->invalidatepage;
+#ifdef CONFIG_BLOCK
+	if (!invalidatepage)
+		invalidatepage = block_invalidatepage;
+#endif
+	if (invalidatepage)
+		(*invalidatepage)(page, offset);
+}
+
 static inline void truncate_partial_page(struct page *page, unsigned partial)
 {
 	memclear_highpage_flush(page, partial, PAGE_CACHE_SIZE-partial);
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
