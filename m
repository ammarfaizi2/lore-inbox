Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265803AbUAEAGr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 19:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUAEAGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 19:06:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7266 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265803AbUAEAGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 19:06:20 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny1 tree for small systems
References: <20040103030814.GG18208@waste.org>
	<m13cawi2h8.fsf@ebiederm.dsl.xmission.com>
	<20040104084005.GU18208@waste.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jan 2004 17:00:49 -0700
In-Reply-To: <20040104084005.GU18208@waste.org>
Message-ID: <m1ekufgt72.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> On Sun, Jan 04, 2004 at 12:42:43AM -0700, Eric W. Biederman wrote:
> > Matt Mackall <mpm@selenic.com> writes:
> > 220K compressed and 371K uncompressed.  This is a serious reduction from
> > previous versions.  There is still a huge amount of code I can't compile
> > out but this is certainly progress.  Thank you.
> 
> Suggestions? I'm rapidly exhausting a lot of the obvious candidates.
> My target build at the moment is ide + ext2 + proc + ipv4 + console, and
> that's currently at around 800K uncompressed, booting in a little less
> than 2.5MB. Hoping to get that under 2.

On the side of useless ugly.  But interesting in what I had to touch
the following patch is a first crude stab at removing block device
support from the kernel.

With nothing selected this gets me down to a 191K bzImage and a 323K
text segment.  So for those who are not using it this is a significant
drop.

I have a fairly static target of kernel and user space in 384K so I
can fit it in a standard BIOS ROM chip.  192K would be even better,
but I have other solutions I can use in that case if I need to.

Eric

$ ls -l arch/i386/boot/bzImage 
-rw-r--r--    2 eric     eric       191316 Jan  4 15:38 arch/i386/boot/bzImage

$ size vmlinux
   text	   data	    bss	    dec	    hex	filename
 323359	  28652	  24252	 376263	  5bdc7	vmlinux

diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/arch/i386/mm/init.c linux-2.6.1-rc1-tiny1.eb2/arch/i386/mm/init.c
--- linux-2.6.1-rc1-tiny1.eb1/arch/i386/mm/init.c	Sun Jan  4 00:22:36 2004
+++ linux-2.6.1-rc1-tiny1.eb2/arch/i386/mm/init.c	Sun Jan  4 13:35:36 2004
@@ -444,7 +444,7 @@
 static struct kcore_list kcore_mem, kcore_vmalloc; 
 #endif
 
-#ifdef CNFIG_CPU_SUP_INTEL
+#ifdef CONFIG_CPU_SUP_INTEL
 extern int ppro_with_ram_bug(void);
 #else
 static inline int ppro_with_ram_bug(void) { return 0; }
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/drivers/block/Kconfig linux-2.6.1-rc1-tiny1.eb2/drivers/block/Kconfig
--- linux-2.6.1-rc1-tiny1.eb1/drivers/block/Kconfig	Wed Dec 17 19:58:28 2003
+++ linux-2.6.1-rc1-tiny1.eb2/drivers/block/Kconfig	Sun Jan  4 03:09:30 2004
@@ -6,7 +6,7 @@
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
-	depends on !X86_PC9800 && !ARCH_S390
+	depends on BLOCK_DEVICES && !X86_PC9800 && !ARCH_S390
 	---help---
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM
@@ -20,29 +20,29 @@
 
 config AMIGA_FLOPPY
 	tristate "Amiga floppy support"
-	depends on AMIGA
+	depends on BLOCK_DEVICES && AMIGA
 
 config ATARI_FLOPPY
 	tristate "Atari floppy support"
-	depends on ATARI
+	depends on BLOCK_DEVICES && ATARI
 
 config BLK_DEV_FD98
 	tristate "NEC PC-9800 floppy disk support"
-	depends on X86_PC9800
+	depends on BLOCK_DEVICES && X86_PC9800
 	---help---
 	  If you want to use the floppy disk drive(s) of NEC PC-9801/PC-9821,
 	  say Y.
 
 config BLK_DEV_SWIM_IOP
 	bool "Macintosh IIfx/Quadra 900/Quadra 950 floppy support (EXPERIMENTAL)"
-	depends on MAC && EXPERIMENTAL && BROKEN
+	depends on BLOCK_DEVICES && MAC && EXPERIMENTAL && BROKEN
 	help
 	  Say Y here to support the SWIM (Super Woz Integrated Machine) IOP
 	  floppy controller on the Macintosh IIfx and Quadra 900/950.
 
 config BLK_DEV_PS2
 	tristate "PS/2 ESDI hard disk support"
-	depends on MCA && MCA_LEGACY
+	depends on BLOCK_DEVICES && MCA && MCA_LEGACY
 	help
 	  Say Y here if you have a PS/2 machine with a MCA bus and an ESDI
 	  hard disk.
@@ -52,7 +52,7 @@
 
 config AMIGA_Z2RAM
 	tristate "Amiga Zorro II ramdisk support"
-	depends on ZORRO
+	depends on BLOCK_DEVICES && ZORRO
 	help
 	  This enables support for using Chip RAM and Zorro II RAM as a
 	  ramdisk or as a swap partition. Say Y if you want to include this
@@ -63,7 +63,7 @@
 
 config ATARI_ACSI
 	tristate "Atari ACSI support"
-	depends on ATARI && BROKEN
+	depends on BLOCK_DEVICES && ATARI && BROKEN
 	---help---
 	  This enables support for the Atari ACSI interface. The driver
 	  supports hard disks and CD-ROMs, which have 512-byte sectors, or can
@@ -79,11 +79,11 @@
 	  module will be called acsi.
 
 comment "Some devices (e.g. CD jukebox) support multiple LUNs"
-	depends on ATARI && ATARI_ACSI
+	depends on BLOCK_DEVICES && ATARI && ATARI_ACSI
 
 config ACSI_MULTI_LUN
 	bool "Probe all LUNs on each ACSI device"
-	depends on ATARI_ACSI
+	depends on BLOCK_DEVICES && ATARI_ACSI
 	help
 	  If you have a ACSI device that supports more than one LUN (Logical
 	  Unit Number), e.g. a CD jukebox, you should say Y here so that all
@@ -94,7 +94,7 @@
 
 config ATARI_SLM
 	tristate "Atari SLM laser printer support"
-	depends on ATARI && ATARI_ACSI!=n
+	depends on BLOCK_DEVICES && ATARI && ATARI_ACSI!=n
 	help
 	  If you have an Atari SLM laser printer, say Y to include support for
 	  it in the kernel. Otherwise, say N. This driver is also available as
@@ -105,7 +105,7 @@
 
 config BLK_DEV_XD
 	tristate "XT hard disk support"
-	depends on ISA
+	depends on BLOCK_DEVICES && ISA
 	help
 	  Very old 8 bit hard disk controllers used in the IBM XT computer
 	  will be supported if you say Y here.
@@ -117,7 +117,7 @@
 
 config PARIDE
 	tristate "Parallel port IDE device support"
-	depends on PARPORT
+	depends on BLOCK_DEVIVES && PARPORT
 	---help---
 	  There are many external CD-ROM and disk devices that connect through
 	  your computer's parallel port. Most of them are actually IDE devices
@@ -146,7 +146,7 @@
 
 config BLK_CPQ_DA
 	tristate "Compaq SMART2 support"
-	depends on PCI
+	depends on BLOCK_DEVICES && PCI
 	help
 	  This is the driver for Compaq Smart Array controllers.  Everyone
 	  using these boards should say Y here.  See the file
@@ -156,7 +156,7 @@
 
 config BLK_CPQ_CISS_DA
 	tristate "Compaq Smart Array 5xxx support"
-	depends on PCI
+	depends on BLOCK_DEVICES && PCI
 	help
 	  This is the driver for Compaq Smart Array 5xxx controllers.
 	  Everyone using these boards should say Y here.
@@ -166,7 +166,7 @@
 
 config CISS_SCSI_TAPE
 	bool "SCSI tape drive support for Smart Array 5xxx"
-	depends on BLK_CPQ_CISS_DA && SCSI
+	depends on BLOCK_DEVICES && BLK_CPQ_CISS_DA && SCSI
 	help
 	  When enabled (Y), this option allows SCSI tape drives and SCSI medium
 	  changers (tape robots) to be accessed via a Compaq 5xxx array 
@@ -180,7 +180,7 @@
 
 config BLK_DEV_DAC960
 	tristate "Mylex DAC960/DAC1100 PCI RAID Controller support"
-	depends on PCI
+	depends on BLOCK_DEVICES && PCI
 	help
 	  This driver adds support for the Mylex DAC960, AcceleRAID, and
 	  eXtremeRAID PCI RAID controllers.  See the file
@@ -192,7 +192,7 @@
 
 config BLK_DEV_UMEM
 	tristate "Micro Memory MM5415 Battery Backed RAM support (EXPERIMENTAL)"
-	depends on PCI && EXPERIMENTAL
+	depends on BLOCK_DEVICES && PCI && EXPERIMENTAL
 	---help---
 	  Saying Y here will include support for the MM5415 family of
 	  battery backed (Non-volatile) RAM cards.
@@ -251,7 +251,7 @@
 config BLK_DEV_CRYPTOLOOP
 	tristate "Cryptoloop Support"
 	select CRYPTO
-	depends on BLK_DEV_LOOP
+	depends on BLOCK_DEVICES && BLK_DEV_LOOP
 	---help---
 	  Say Y here if you want to be able to use the ciphers that are 
 	  provided by the CryptoAPI as loop transformation. This might be
@@ -259,7 +259,7 @@
 
 config BLK_DEV_NBD
 	tristate "Network block device support"
-	depends on NET
+	depends on BLOCK_DEVICES && NET
 	---help---
 	  Saying Y here will allow your computer to be a client for network
 	  block devices, i.e. it will be able to use block devices exported by
@@ -305,7 +305,7 @@
 
 config BLK_DEV_RAM_SIZE
 	int "Default RAM disk size"
-	depends on BLK_DEV_RAM
+	depends on BLOCK_DEVICES && BLK_DEV_RAM
 	default "4096"
 	help
 	  The default value is 4096. Only change this if you know what are
@@ -322,7 +322,7 @@
 
 config LBD
 	bool "Support for Large Block Devices"
-	depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH
+	depends on BLOCK_DEVICES && ( X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH )
 	help
 	  Say Y here if you want to attach large (bigger than 2TB) discs to
 	  your machine, or if you want to have a raid or loopback device
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/drivers/block/Kconfig.embedded linux-2.6.1-rc1-tiny1.eb2/drivers/block/Kconfig.embedded
--- linux-2.6.1-rc1-tiny1.eb1/drivers/block/Kconfig.embedded	Wed Dec 31 17:00:00 1969
+++ linux-2.6.1-rc1-tiny1.eb2/drivers/block/Kconfig.embedded	Sun Jan  4 03:09:51 2004
@@ -0,0 +1,5 @@
+config BLOCK_DEVICES
+	bool "Block device support" if EMBEDDED
+	default y
+	help
+	  Allow the complete removal of block device code
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/drivers/block/Kconfig.iosched linux-2.6.1-rc1-tiny1.eb2/drivers/block/Kconfig.iosched
--- linux-2.6.1-rc1-tiny1.eb1/drivers/block/Kconfig.iosched	Wed Dec 17 19:58:07 2003
+++ linux-2.6.1-rc1-tiny1.eb2/drivers/block/Kconfig.iosched	Sun Jan  4 15:34:04 2004
@@ -1,5 +1,6 @@
 config IOSCHED_NOOP
 	bool "No-op I/O scheduler" if EMBEDDED
+	depends on BLOCK_DEVICES
 	default y
 	---help---
 	  The no-op I/O scheduler is a minimal scheduler that does basic merging
@@ -10,6 +11,7 @@
 
 config IOSCHED_AS
 	bool "Anticipatory I/O scheduler" if EMBEDDED
+	depends on BLOCK_DEVICES
 	default y
 	---help---
 	  The anticipatory I/O scheduler is the default disk scheduler. It is
@@ -19,6 +21,7 @@
 
 config IOSCHED_DEADLINE
 	bool "Deadline I/O scheduler" if EMBEDDED
+	depends on BLOCK_DEVICES
 	default y
 	---help---
 	  The deadline I/O scheduler is simple and compact, and is often as
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/drivers/block/Makefile linux-2.6.1-rc1-tiny1.eb2/drivers/block/Makefile
--- linux-2.6.1-rc1-tiny1.eb1/drivers/block/Makefile	Wed Dec 17 19:59:19 2003
+++ linux-2.6.1-rc1-tiny1.eb2/drivers/block/Makefile	Sun Jan  4 03:10:27 2004
@@ -13,7 +13,7 @@
 # kblockd threads
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
+obj-$(CONFIG_BLOCK_DEVICES)	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
 
 obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/drivers/md/Kconfig linux-2.6.1-rc1-tiny1.eb2/drivers/md/Kconfig
--- linux-2.6.1-rc1-tiny1.eb1/drivers/md/Kconfig	Sat Jan  3 22:09:07 2004
+++ linux-2.6.1-rc1-tiny1.eb2/drivers/md/Kconfig	Sun Jan  4 03:13:26 2004
@@ -6,6 +6,7 @@
 
 config MD
 	bool "Multiple devices driver support (RAID and LVM)"
+	depends on BLOCK_DEVICES
 	help
 	  Support multiple physical spindles through a single logical device.
 	  Required for RAID and logical volume management.
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/fs/Kconfig.embedded linux-2.6.1-rc1-tiny1.eb2/fs/Kconfig.embedded
--- linux-2.6.1-rc1-tiny1.eb1/fs/Kconfig.embedded	Wed Dec 31 17:00:00 1969
+++ linux-2.6.1-rc1-tiny1.eb2/fs/Kconfig.embedded	Sun Jan  4 03:44:16 2004
@@ -0,0 +1,11 @@
+config BINFMT_SCRIPT
+	bool "Kernel support for shell scripts" if EMBEDDED
+	default y
+	help
+	  Allow the removal of the code for executing shell scripts
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/fs/Makefile linux-2.6.1-rc1-tiny1.eb2/fs/Makefile
--- linux-2.6.1-rc1-tiny1.eb1/fs/Makefile	Sat Jan  3 22:10:11 2004
+++ linux-2.6.1-rc1-tiny1.eb2/fs/Makefile	Sun Jan  4 03:44:53 2004
@@ -5,12 +5,14 @@
 # Rewritten to use lists instead of if-statements.
 # 
 
-obj-y :=	open.o read_write.o file_table.o buffer.o \
-		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
+obj-y :=	open.o read_write.o file_table.o \
+		super.o char_dev.o stat.o exec.o pipe.o \
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o
+		fs-writeback.o aio.o
+
+obj-$(CONFIG_BLOCK_DEVICES) += buffer.o bio.o block_dev.o mpage.o direct-io.o
 
 obj-$(CONFIG_DNOTIFY)		+= dnotify.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
@@ -24,7 +26,7 @@
 obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc.o
 
 # binfmt_script is always there
-obj-y				+= binfmt_script.o
+obj-$(CONFIG_BINFMT_SCRIPT)	+= binfmt_script.o
 
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
 obj-$(CONFIG_BINFMT_SOM)	+= binfmt_som.o
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/fs/buffer.c linux-2.6.1-rc1-tiny1.eb2/fs/buffer.c
--- linux-2.6.1-rc1-tiny1.eb1/fs/buffer.c	Sat Jan  3 22:10:11 2004
+++ linux-2.6.1-rc1-tiny1.eb2/fs/buffer.c	Sun Jan  4 14:37:38 2004
@@ -225,27 +225,6 @@
 
 /*
  * Write out and wait upon all dirty data associated with this
- * superblock.  Filesystem data as well as the underlying block
- * device.  Takes the superblock lock.
- */
-int fsync_super(struct super_block *sb)
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
-
-	return sync_blockdev(sb->s_bdev);
-}
-
-/*
- * Write out and wait upon all dirty data associated with this
  * device.   Filesystem data as well as the underlying block
  * device.  Takes the superblock lock.
  */
@@ -1559,35 +1538,6 @@
 	clear_buffer_new(bh);
 	clear_buffer_delay(bh);
 	unlock_buffer(bh);
-}
-
-/**
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
-int try_to_release_page(struct page *page, int gfp_mask)
-{
-	struct address_space * const mapping = page->mapping;
-
-	if (!PageLocked(page))
-		BUG();
-	if (PageWriteback(page))
-		return 0;
-	
-	if (mapping && mapping->a_ops->releasepage)
-		return mapping->a_ops->releasepage(page, gfp_mask);
-	return try_to_free_buffers(page);
 }
 
 /**
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/fs/dcache.c linux-2.6.1-rc1-tiny1.eb2/fs/dcache.c
--- linux-2.6.1-rc1-tiny1.eb1/fs/dcache.c	Sat Jan  3 22:09:11 2004
+++ linux-2.6.1-rc1-tiny1.eb2/fs/dcache.c	Sun Jan  4 03:24:20 2004
@@ -1619,7 +1619,9 @@
 	inode_init(mempages);
 	files_init(mempages); 
 	mnt_init(mempages);
+#ifdef CONFIG_BLOCK_DEVICES
 	bdev_cache_init();
+#endif
 	chrdev_init();
 }
 
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/fs/fs-writeback.c linux-2.6.1-rc1-tiny1.eb2/fs/fs-writeback.c
--- linux-2.6.1-rc1-tiny1.eb1/fs/fs-writeback.c	Wed Dec 17 20:00:00 2003
+++ linux-2.6.1-rc1-tiny1.eb2/fs/fs-writeback.c	Sun Jan  4 15:25:49 2004
@@ -22,8 +22,11 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
+#include <linux/quotaops.h>
 
+#ifdef CONFIG_BLOCK_DEVICES
 extern struct super_block *blockdev_superblock;
+#endif
 
 /**
  *	__mark_inode_dirty -	internal function
@@ -263,6 +266,7 @@
 		struct backing_dev_info *bdi = mapping->backing_dev_info;
 
 		if (bdi->memory_backed) {
+#ifdef CONFIG_BLOCK_DEVICES
 			if (sb == blockdev_superblock) {
 				/*
 				 * Dirty memory-backed blockdev: the ramdisk
@@ -271,6 +275,7 @@
 				list_move(&inode->i_list, &sb->s_dirty);
 				continue;
 			}
+#endif
 			/*
 			 * Assume that all inodes on this superblock are memory
 			 * backed.  Skip the superblock.
@@ -280,15 +285,19 @@
 
 		if (wbc->nonblocking && bdi_write_congested(bdi)) {
 			wbc->encountered_congestion = 1;
+#ifdef CONFIG_BLOCK_DEVICES
 			if (sb != blockdev_superblock)
 				break;		/* Skip a congested fs */
+#endif
 			list_move(&inode->i_list, &sb->s_dirty);
 			continue;		/* Skip a congested blockdev */
 		}
 
 		if (wbc->bdi && bdi != wbc->bdi) {
+#ifdef CONFIG_BLOCK_DEVICES
 			if (sb != blockdev_superblock)
 				break;		/* fs has the wrong queue */
+#endif
 			list_move(&inode->i_list, &sb->s_dirty);
 			continue;		/* blockdev has wrong queue */
 		}
@@ -523,11 +532,13 @@
 	current->flags |= PF_SYNCWRITE;
 	if (what & OSYNC_DATA)
 		err = filemap_fdatawrite(inode->i_mapping);
+#ifdef CONFIG_BLOCK_DEVICES
 	if (what & (OSYNC_METADATA|OSYNC_DATA)) {
 		err2 = sync_mapping_buffers(inode->i_mapping);
 		if (!err)
 			err = err2;
 	}
+#endif
 	if (what & OSYNC_DATA) {
 		err2 = filemap_fdatawait(inode->i_mapping);
 		if (!err)
@@ -586,4 +597,32 @@
 {
 	BUG_ON(!writeback_in_progress(bdi));
 	clear_bit(BDI_pdflush, &bdi->state);
+}
+
+
+/*
+ * Write out and wait upon all dirty data associated with this
+ * superblock.  Filesystem data as well as the underlying block
+ * device.  Takes the superblock lock.
+ */
+int fsync_super(struct super_block *sb)
+{
+	sync_inodes_sb(sb, 0);
+	DQUOT_SYNC(sb);
+	lock_super(sb);
+	if (sb->s_dirt && sb->s_op->write_super)
+		sb->s_op->write_super(sb);
+	unlock_super(sb);
+	if (sb->s_op->sync_fs)
+		sb->s_op->sync_fs(sb, 1);
+#ifdef CONFIG_BLOCK_DEVICES
+	sync_blockdev(sb->s_bdev);
+#endif
+	sync_inodes_sb(sb, 1);
+
+#ifdef CONFIG_BLOCK_DEVICES
+	return sync_blockdev(sb->s_bdev);
+#else
+	return 0;
+#endif
 }
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/fs/inode.c linux-2.6.1-rc1-tiny1.eb2/fs/inode.c
--- linux-2.6.1-rc1-tiny1.eb1/fs/inode.c	Wed Dec 17 19:59:55 2003
+++ linux-2.6.1-rc1-tiny1.eb2/fs/inode.c	Sun Jan  4 15:35:18 2004
@@ -233,7 +233,9 @@
  */
 void clear_inode(struct inode *inode)
 {
+#ifdef CONFIG_BLOCK_DEVICES
 	invalidate_inode_buffers(inode);
+#endif
        
 	if (inode->i_data.nrpages)
 		BUG();
@@ -245,8 +247,10 @@
 	DQUOT_DROP(inode);
 	if (inode->i_sb && inode->i_sb->s_op->clear_inode)
 		inode->i_sb->s_op->clear_inode(inode);
+#if CONFIG_BLOCK_DEVICES
 	if (inode->i_bdev)
 		bd_forget(inode);
+#endif
 	if (inode->i_cdev)
 		cd_forget(inode);
 	inode->i_state = I_CLEAR;
@@ -301,7 +305,9 @@
 		inode = list_entry(tmp, struct inode, i_list);
 		if (inode->i_sb != sb)
 			continue;
+#ifdef CONFIG_BLOCK_DEVICES
 		invalidate_inode_buffers(inode);
+#endif
 		if (!atomic_read(&inode->i_count)) {
 			hlist_del_init(&inode->i_hash);
 			list_del(&inode->i_list);
@@ -353,7 +359,8 @@
 }
 
 EXPORT_SYMBOL(invalidate_inodes);
- 
+
+#ifdef CONFIG_BLOCK_DEVICES 
 int __invalidate_device(struct block_device *bdev, int do_sync)
 {
 	struct super_block *sb;
@@ -380,6 +387,7 @@
 }
 
 EXPORT_SYMBOL(__invalidate_device);
+#endif
 
 static int can_unuse(struct inode *inode)
 {
@@ -431,8 +439,10 @@
 		if (inode_has_buffers(inode) || inode->i_data.nrpages) {
 			__iget(inode);
 			spin_unlock(&inode_lock);
+#ifdef CONFIG_BLOCK_DEVICES
 			if (remove_inode_buffers(inode))
 				reap += invalidate_inode_pages(&inode->i_data);
+#endif
 			iput(inode);
 			spin_lock(&inode_lock);
 
@@ -1391,9 +1401,11 @@
 	if (S_ISCHR(mode)) {
 		inode->i_fop = &def_chr_fops;
 		inode->i_rdev = rdev;
+#ifdef CONFIG_BLOCK_DEVICES
 	} else if (S_ISBLK(mode)) {
 		inode->i_fop = &def_blk_fops;
 		inode->i_rdev = rdev;
+#endif
 	} else if (S_ISFIFO(mode))
 		inode->i_fop = &def_fifo_fops;
 	else if (S_ISSOCK(mode))
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/fs/partitions/Makefile linux-2.6.1-rc1-tiny1.eb2/fs/partitions/Makefile
--- linux-2.6.1-rc1-tiny1.eb1/fs/partitions/Makefile	Wed Dec 17 19:58:47 2003
+++ linux-2.6.1-rc1-tiny1.eb2/fs/partitions/Makefile	Sun Jan  4 03:29:11 2004
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y := check.o
+obj-$(CONFIG_BLOCK_DEVICES) := check.o
 
 obj-$(CONFIG_DEVFS_FS) += devfs.o
 obj-$(CONFIG_ACORN_PARTITION) += acorn.o
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/fs/super.c linux-2.6.1-rc1-tiny1.eb2/fs/super.c
--- linux-2.6.1-rc1-tiny1.eb1/fs/super.c	Wed Dec 17 19:58:48 2003
+++ linux-2.6.1-rc1-tiny1.eb2/fs/super.c	Sun Jan  4 15:18:28 2004
@@ -473,8 +473,10 @@
 {
 	int retval;
 	
+#ifdef CONFIG_BLOCK_DEVICES
 	if (!(flags & MS_RDONLY) && bdev_read_only(sb->s_bdev))
 		return -EACCES;
+#endif
 	if (flags & MS_RDONLY)
 		acct_auto_close(sb);
 	shrink_dcache_sb(sb);
@@ -588,6 +590,7 @@
 	return (void *)s->s_bdev == data;
 }
 
+#ifdef CONFIG_BLOCK_DEVICES
 struct super_block *get_sb_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int))
@@ -645,6 +648,7 @@
 }
 
 EXPORT_SYMBOL(kill_block_super);
+#endif
 
 struct super_block *get_sb_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/include/linux/blkdev.h linux-2.6.1-rc1-tiny1.eb2/include/linux/blkdev.h
--- linux-2.6.1-rc1-tiny1.eb1/include/linux/blkdev.h	Wed Dec 17 19:58:28 2003
+++ linux-2.6.1-rc1-tiny1.eb2/include/linux/blkdev.h	Sun Jan  4 03:32:28 2004
@@ -577,7 +577,11 @@
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
 extern void generic_unplug_device(void *);
+#ifdef CONFIG_BLOCK_DEVICES
 extern long nr_blockdev_pages(void);
+#else
+static inline long nr_blockdev_pages(void) { return 0; }
+#endif
 
 int blk_get_queue(request_queue_t *);
 request_queue_t *blk_alloc_queue(int);
@@ -596,7 +600,12 @@
 extern void blk_queue_free_tags(request_queue_t *);
 extern int blk_queue_resize_tags(request_queue_t *, int);
 extern void blk_queue_invalidate_tags(request_queue_t *);
+
+#if defined(CONFIG_BLOCK_DEVICES)
 extern void blk_congestion_wait(int rw, long timeout);
+#else
+static inline void blk_congestion_wait(int rw, long timeout) {} 
+#endif
 
 extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
 extern void blk_rq_prep_restart(struct request *);
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/include/linux/buffer_head.h linux-2.6.1-rc1-tiny1.eb2/include/linux/buffer_head.h
--- linux-2.6.1-rc1-tiny1.eb1/include/linux/buffer_head.h	Wed Dec 17 19:58:04 2003
+++ linux-2.6.1-rc1-tiny1.eb2/include/linux/buffer_head.h	Sun Jan  4 15:23:47 2004
@@ -150,7 +150,11 @@
 void buffer_insert_list(spinlock_t *lock,
 			struct buffer_head *, struct list_head *);
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode);
+#ifdef CONFIG_BLOCK_DEVICES
 int inode_has_buffers(struct inode *);
+#else
+static inline int inode_has_buffers(struct inode *inode) { return 0; }
+#endif
 void invalidate_inode_buffers(struct inode *);
 int remove_inode_buffers(struct inode *inode);
 int fsync_buffers_list(spinlock_t *lock, struct list_head *);
@@ -160,7 +164,11 @@
 void mark_buffer_async_read(struct buffer_head *bh);
 void mark_buffer_async_write(struct buffer_head *bh);
 void invalidate_bdev(struct block_device *, int);
+#if CONFIG_BLOCK_DEVICES
 int sync_blockdev(struct block_device *bdev);
+#else
+static inline int sync_blockdev(struct block_device *bdev) { return 0; }
+#endif
 void __wait_on_buffer(struct buffer_head *);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 void wake_up_buffer(struct buffer_head *bh);
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/include/linux/fs.h linux-2.6.1-rc1-tiny1.eb2/include/linux/fs.h
--- linux-2.6.1-rc1-tiny1.eb1/include/linux/fs.h	Sat Jan  3 22:10:11 2004
+++ linux-2.6.1-rc1-tiny1.eb2/include/linux/fs.h	Sun Jan  4 03:52:15 2004
@@ -1145,7 +1145,11 @@
 extern int blkdev_put(struct block_device *, int);
 extern int bd_claim(struct block_device *, void *);
 extern void bd_release(struct block_device *);
+#ifdef CONFIG_BLOCK_DEVICE
 extern void blk_run_queues(void);
+#else
+static inline void blk_run_queues(void) {};
+#endif
 
 /* fs/char_dev.c */
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, char *);
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/include/linux/mm.h linux-2.6.1-rc1-tiny1.eb2/include/linux/mm.h
--- linux-2.6.1-rc1-tiny1.eb1/include/linux/mm.h	Sat Jan  3 22:09:12 2004
+++ linux-2.6.1-rc1-tiny1.eb2/include/linux/mm.h	Sun Jan  4 03:57:55 2004
@@ -486,7 +486,11 @@
 		if (spd)
 			return (*spd)(page);
 	}
+#if CONFIG_BLOCK_DEVICES
 	return __set_page_dirty_buffers(page);
+#else
+	return 0;
+#endif
 }
 
 /*
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/include/linux/mpage.h linux-2.6.1-rc1-tiny1.eb2/include/linux/mpage.h
--- linux-2.6.1-rc1-tiny1.eb1/include/linux/mpage.h	Wed Dec 17 19:58:47 2003
+++ linux-2.6.1-rc1-tiny1.eb2/include/linux/mpage.h	Sun Jan  4 03:33:28 2004
@@ -10,6 +10,7 @@
  * nested includes.  Get it right in the .c file).
  */
 
+#ifdef CONFIG_BLOCK_DEVICES
 struct writeback_control;
 
 int mpage_readpages(struct address_space *mapping, struct list_head *pages,
@@ -23,3 +24,12 @@
 {
 	return mpage_writepages(mapping, wbc, NULL);
 }
+#else
+
+static inline int
+generic_writepages(struct address_space *mapping, struct writeback_control *wbc)
+{
+	return 0;
+}
+
+#endif
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/init/Kconfig linux-2.6.1-rc1-tiny1.eb2/init/Kconfig
--- linux-2.6.1-rc1-tiny1.eb1/init/Kconfig	Sat Jan  3 22:10:11 2004
+++ linux-2.6.1-rc1-tiny1.eb2/init/Kconfig	Sun Jan  4 03:35:04 2004
@@ -277,6 +277,8 @@
 	  support for epoll family of system calls.
 
 source "drivers/block/Kconfig.iosched"
+source "fs/Kconfig.embedded"
+source "drivers/block/Kconfig.embedded"
 
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size" if EMBEDDED
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/init/do_mounts.c linux-2.6.1-rc1-tiny1.eb2/init/do_mounts.c
--- linux-2.6.1-rc1-tiny1.eb1/init/do_mounts.c	Sat Jan  3 22:10:11 2004
+++ linux-2.6.1-rc1-tiny1.eb2/init/do_mounts.c	Sun Jan  4 03:36:41 2004
@@ -267,6 +267,7 @@
 	return 0;
 }
 
+#if CONFIG_BLOCK_DEVICES
 void __init mount_block_root(char *name, int flags)
 {
 	char *fs_names = __getname();
@@ -301,6 +302,7 @@
 out:
 	putname(fs_names);
 }
+#endif
  
 #ifdef CONFIG_ROOT_NFS
 static int __init mount_nfs_root(void)
@@ -368,8 +370,10 @@
 			change_floppy("root floppy");
 	}
 #endif
+#if CONFIG_BLOCK_DEVICES
 	create_dev("/dev/root", ROOT_DEV, root_device_name);
 	mount_block_root("/dev/root", root_mountflags);
+#endif
 }
 
 /*
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/init/main.c linux-2.6.1-rc1-tiny1.eb2/init/main.c
--- linux-2.6.1-rc1-tiny1.eb1/init/main.c	Sat Jan  3 22:10:11 2004
+++ linux-2.6.1-rc1-tiny1.eb2/init/main.c	Sun Jan  4 03:37:07 2004
@@ -447,7 +447,9 @@
 #endif
 	fork_init(num_physpages);
 	proc_caches_init();
+#if CONFIG_BLOCK_DEVICES
 	buffer_init();
+#endif
 	security_scaffolding_startup();
 	vfs_caches_init(max(1000, (int)num_physpages-16000));
 	radix_tree_init();
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/kernel/exit.c linux-2.6.1-rc1-tiny1.eb2/kernel/exit.c
--- linux-2.6.1-rc1-tiny1.eb1/kernel/exit.c	Sat Jan  3 22:09:12 2004
+++ linux-2.6.1-rc1-tiny1.eb2/kernel/exit.c	Sun Jan  4 15:38:02 2004
@@ -750,8 +750,10 @@
 		panic("Attempted to kill the idle task!");
 	if (unlikely(tsk->pid == 1))
 		panic("Attempted to kill init!");
+#ifdef CONFIG_BLOCK_DEVICES
 	if (tsk->io_context)
 		exit_io_context();
+#endif
 	tsk->flags |= PF_EXITING;
 	del_timer_sync(&tsk->real_timer);
 
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/kernel/sys.c linux-2.6.1-rc1-tiny1.eb2/kernel/sys.c
--- linux-2.6.1-rc1-tiny1.eb1/kernel/sys.c	Sat Jan  3 22:10:11 2004
+++ linux-2.6.1-rc1-tiny1.eb2/kernel/sys.c	Sun Jan  4 03:38:29 2004
@@ -251,6 +251,15 @@
 cond_syscall(sys_epoll_wait)
 cond_syscall(sys_pciconfig_read)
 cond_syscall(sys_pciconfig_write)
+cond_syscall(sys_io_setup)
+cond_syscall(sys_io_destroy)
+cond_syscall(sys_io_getevents)
+cond_syscall(sys_io_submit)
+cond_syscall(sys_io_cancel)
+cond_syscall(sys_bdflush)
+cond_syscall(sys_sync)
+cond_syscall(sys_fsync)
+cond_syscall(sys_fdatasync)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/mm/filemap.c linux-2.6.1-rc1-tiny1.eb2/mm/filemap.c
--- linux-2.6.1-rc1-tiny1.eb1/mm/filemap.c	Sat Jan  3 22:09:12 2004
+++ linux-2.6.1-rc1-tiny1.eb2/mm/filemap.c	Sun Jan  4 03:41:15 2004
@@ -1640,6 +1640,11 @@
                 return err;
         }
 
+#if !defined(CONFIG_BLOCK_DEVICES)
+	if (unlikely(isblk)) {
+		return -EINVAL;
+	}
+#endif
 	if (!isblk) {
 		/* FIXME: this is for backwards compatibility with 2.4 */
 		if (file->f_flags & O_APPEND)
@@ -1688,7 +1693,9 @@
 
 		if (unlikely(*pos + *count > inode->i_sb->s_maxbytes))
 			*count = inode->i_sb->s_maxbytes - *pos;
-	} else {
+	} 
+#if defined(CONFIG_BLOCK_DEVICES)
+	else {
 		loff_t isize;
 		if (bdev_read_only(inode->i_bdev))
 			return -EPERM;
@@ -1701,6 +1708,7 @@
 		if (*pos + *count > isize)
 			*count = isize - *pos;
 	}
+#endif
 	return 0;
 }
 
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/mm/highmem.c linux-2.6.1-rc1-tiny1.eb2/mm/highmem.c
--- linux-2.6.1-rc1-tiny1.eb1/mm/highmem.c	Sat Jan  3 22:09:12 2004
+++ linux-2.6.1-rc1-tiny1.eb2/mm/highmem.c	Sun Jan  4 03:42:22 2004
@@ -300,6 +300,7 @@
 	}
 }
 
+#ifdef CONFIG_BLOCK_DEVICES
 static void bounce_end_io(struct bio *bio, mempool_t *pool)
 {
 	struct bio *bio_orig = bio->bi_private;
@@ -479,6 +480,7 @@
 }
 
 EXPORT_SYMBOL(blk_queue_bounce);
+#endif /* CONFIG_BLOCK_DEVICES */
 
 #if defined(HASHED_PAGE_VIRTUAL)
 
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/mm/page-writeback.c linux-2.6.1-rc1-tiny1.eb2/mm/page-writeback.c
--- linux-2.6.1-rc1-tiny1.eb1/mm/page-writeback.c	Wed Dec 17 19:59:05 2003
+++ linux-2.6.1-rc1-tiny1.eb2/mm/page-writeback.c	Sun Jan  4 14:15:00 2004
@@ -567,3 +567,38 @@
 	return 0;
 }
 EXPORT_SYMBOL(test_clear_page_dirty);
+
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
+int try_to_release_page(struct page *page, int gfp_mask)
+{
+	struct address_space * const mapping = page->mapping;
+
+	if (!PageLocked(page))
+		BUG();
+	if (PageWriteback(page))
+		return 0;
+	
+	if (mapping && mapping->a_ops->releasepage)
+		return mapping->a_ops->releasepage(page, gfp_mask);
+#if CONFIG_BLOCK_DEVICES
+	return try_to_free_buffers(page);
+#else
+	BUG();
+	return 0;
+#endif
+}
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/mm/swap.c linux-2.6.1-rc1-tiny1.eb2/mm/swap.c
--- linux-2.6.1-rc1-tiny1.eb1/mm/swap.c	Sat Jan  3 22:09:12 2004
+++ linux-2.6.1-rc1-tiny1.eb2/mm/swap.c	Sun Jan  4 14:25:25 2004
@@ -317,6 +317,7 @@
 	pagevec_reinit(pvec);
 }
 
+#if CONFIG_BLOCK_DEVICES
 /*
  * Try to drop buffers from the pages in a pagevec
  */
@@ -333,6 +334,7 @@
 		}
 	}
 }
+#endif
 
 /**
  * pagevec_lookup - gang pagecache lookup
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/mm/truncate.c linux-2.6.1-rc1-tiny1.eb2/mm/truncate.c
--- linux-2.6.1-rc1-tiny1.eb1/mm/truncate.c	Wed Dec 17 19:59:42 2003
+++ linux-2.6.1-rc1-tiny1.eb2/mm/truncate.c	Sun Jan  4 14:27:10 2004
@@ -18,11 +18,18 @@
 
 static int do_invalidatepage(struct page *page, unsigned long offset)
 {
+	int ret;
 	int (*invalidatepage)(struct page *, unsigned long);
 	invalidatepage = page->mapping->a_ops->invalidatepage;
+#if CONFIG_BLOCK_DEVICE
 	if (invalidatepage == NULL)
 		invalidatepage = block_invalidatepage;
-	return (*invalidatepage)(page, offset);
+#endif
+	ret = 1;
+	if (invalidatepage) {
+		ret = (*invalidatepage)(page, offset);
+	}
+	return ret;
 }
 
 static inline void truncate_partial_page(struct page *page, unsigned partial)
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.eb1/mm/vmscan.c linux-2.6.1-rc1-tiny1.eb2/mm/vmscan.c
--- linux-2.6.1-rc1-tiny1.eb1/mm/vmscan.c	Sat Jan  3 22:09:12 2004
+++ linux-2.6.1-rc1-tiny1.eb2/mm/vmscan.c	Sun Jan  4 03:43:24 2004
@@ -704,19 +704,23 @@
 			spin_unlock_irq(&zone->lru_lock);
 			pgdeactivate += pgmoved;
 			pgmoved = 0;
+#ifdef CONFIG_BLOCK_DEVICES
 			if (buffer_heads_over_limit)
 				pagevec_strip(&pvec);
+#endif
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
 	zone->nr_inactive += pgmoved;
 	pgdeactivate += pgmoved;
+#ifdef CONFIG_BLOCK_DEVICES
 	if (buffer_heads_over_limit) {
 		spin_unlock_irq(&zone->lru_lock);
 		pagevec_strip(&pvec);
 		spin_lock_irq(&zone->lru_lock);
 	}
+#endif
 
 	pgmoved = 0;
 	while (!list_empty(&l_active)) {

