Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbUAHT3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265886AbUAHT3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:29:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50807 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265856AbUAHT2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:28:23 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny1 tree for small systems
References: <20040103030814.GG18208@waste.org>
	<m13cawi2h8.fsf@ebiederm.dsl.xmission.com>
	<20040104084005.GU18208@waste.org>
	<m1ekufgt72.fsf@ebiederm.dsl.xmission.com>
	<20040105170938.GY18208@waste.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Jan 2004 12:22:29 -0700
In-Reply-To: <20040105170938.GY18208@waste.org>
Message-ID: <m1wu82i6tm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Matt Mackall <mpm@selenic.com> writes:

> On Sun, Jan 04, 2004 at 05:00:49PM -0700, Eric W. Biederman wrote:
> > On the side of useless ugly.  But interesting in what I had to touch
> > the following patch is a first crude stab at removing block device
> > support from the kernel.
> 
> This looks good. If you can send me a version with
> /BLOCK_DEVICE/BLOCK/, etc., I'll put it in.

Ok.  I have just had a chance to clean some things up.  Attached
is my latest and hopefully clean set up diffs against 2.6.1-rc1-tiny1

I am bouncing this off of linux-kernel as well since I got such good
feedback last time.

- First the compile fixes, so I can compile test this code.
- Then the CONFIG_BLOCK patch.  
  * I have reviewed the code and it looks correct, beyond just the
    fact that the code compiles. 
  * I have added  a sync.c for the sync functions that used to live in
   buffer.c.
  * I have removed most instances of CONFIG_BLOCK from the mainline
    code to improve maintenance.  Now there are just a few ugly parts
    where the block layer is not cleanly separated from the rest of
    the code.
  * I have updated where I put the depends so fewer things need a CONFIG_BLOCK.
  * I have added  a CONFIG_BLOCK to all of the likely looking
    filesystems.
- Then a new patch that was sort of in my tree to make BINFMT_SCRIPT
  configurable.
- And another new patch to use cond_syscall instead of explicit
  dummies when we don't have the AIO code compiled in.

The last two patches really don't really appear to save anything but
they are clean, and you can't have too many CONFIG_EMBEDDED options :)

Eric


--=-=-=
Content-Disposition: attachment;
  filename=linux-2.6.1-rc1-tiny1.compile-fixes.diff

diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1/arch/i386/kernel/cpu/common.c linux-2.6.1-rc1-tiny1.compile-fixes/arch/i386/kernel/cpu/common.c
--- linux-2.6.1-rc1-tiny1/arch/i386/kernel/cpu/common.c	Sun Jan  4 00:03:51 2004
+++ linux-2.6.1-rc1-tiny1.compile-fixes/arch/i386/kernel/cpu/common.c	Thu Jan  8 11:22:52 2004
@@ -421,7 +421,6 @@
  * They will insert themselves into the cpu_devs structure.
  * Then, when cpu_init() is called, we can just iterate over that array.
  */
-
 extern int intel_cpu_init(void);
 extern int cyrix_init_cpu(void);
 extern int nsc_init_cpu(void);
@@ -431,6 +430,34 @@
 extern int rise_init_cpu(void);
 extern int nexgen_init_cpu(void);
 extern int umc_init_cpu(void);
+
+#ifndef CONFIG_CPU_SUP_INTEL
+#define intel_cpu_init() 
+#endif
+#ifndef CONFIG_CPU_SUP_CYRIX
+#define cyrix_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_NSC
+#define nsc_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_AMD
+#define amd_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_CENTAUR
+#define centaur_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_TRANSMETA
+#define transmeta_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_RISE
+#define rise_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_NEXGEN
+#define nexgen_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_UMC
+#define umc_init_cpu() 
+#endif
 
 void __init early_cpu_init(void)
 {
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1/arch/i386/mm/init.c linux-2.6.1-rc1-tiny1.compile-fixes/arch/i386/mm/init.c
--- linux-2.6.1-rc1-tiny1/arch/i386/mm/init.c	Sun Jan  4 00:03:51 2004
+++ linux-2.6.1-rc1-tiny1.compile-fixes/arch/i386/mm/init.c	Thu Jan  8 11:23:49 2004
@@ -444,9 +444,14 @@
 static struct kcore_list kcore_mem, kcore_vmalloc; 
 #endif
 
+#ifdef CONFIG_CPU_SUP_INTEL
+extern int ppro_with_ram_bug(void);
+#else
+static inline int ppro_with_ram_bug(void) { return 0; }
+#endif
+
 void __init mem_init(void)
 {
-	extern int ppro_with_ram_bug(void);
 	int codesize, reservedpages, datasize, initsize;
 	int tmp;
 	int bad_ppro;
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1/kernel/Makefile linux-2.6.1-rc1-tiny1.compile-fixes/kernel/Makefile
--- linux-2.6.1-rc1-tiny1/kernel/Makefile	Wed Dec 17 19:58:18 2003
+++ linux-2.6.1-rc1-tiny1.compile-fixes/kernel/Makefile	Thu Jan  8 11:22:52 2004
@@ -4,10 +4,11 @@
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    exit.o itimer.o time.o softirq.o resource.o \
-	    sysctl.o capability.o ptrace.o timer.o user.o \
+	    sysctl.o capability.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
 
+obj-$(CONFIG_PTRACE) += ptrace.o
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1/kernel/printk.c linux-2.6.1-rc1-tiny1.compile-fixes/kernel/printk.c
--- linux-2.6.1-rc1-tiny1/kernel/printk.c	Sun Jan  4 00:03:57 2004
+++ linux-2.6.1-rc1-tiny1.compile-fixes/kernel/printk.c	Thu Jan  8 11:22:52 2004
@@ -101,10 +101,10 @@
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 static int preferred_console = -1;
 
-#ifdef CONFIG_PRINTK
-
 /* Flag: console code may call schedule() */
 static int console_may_schedule;
+
+#ifdef CONFIG_PRINTK
 
 /*
  *	Setup a list of consoles. Called from init/main.c

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment;
  filename=linux-2.6.1-rc1-tiny1.config-block.diff
Content-Transfer-Encoding: quoted-printable

diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/drivers=
/block/Kconfig linux-2.6.1-rc1-tiny1.config-block/drivers/block/Kconfig
--- linux-2.6.1-rc1-tiny1.compile-fixes/drivers/block/Kconfig	Wed Dec 17 19=
:58:28 2003
+++ linux-2.6.1-rc1-tiny1.config-block/drivers/block/Kconfig	Thu Jan  8 11:=
29:14 2004
@@ -3,6 +3,7 @@
 #
=20
 menu "Block devices"
+	depends BLOCK
=20
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/drivers=
/block/Kconfig.embedded linux-2.6.1-rc1-tiny1.config-block/drivers/block/Kc=
onfig.embedded
--- linux-2.6.1-rc1-tiny1.compile-fixes/drivers/block/Kconfig.embedded	Wed =
Dec 31 17:00:00 1969
+++ linux-2.6.1-rc1-tiny1.config-block/drivers/block/Kconfig.embedded	Thu J=
an  8 11:29:14 2004
@@ -0,0 +1,5 @@
+config BLOCK
+	bool "Block device support" if EMBEDDED
+	default y
+	help
+	  Allow the complete removal of block device code
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/drivers=
/block/Kconfig.iosched linux-2.6.1-rc1-tiny1.config-block/drivers/block/Kco=
nfig.iosched
--- linux-2.6.1-rc1-tiny1.compile-fixes/drivers/block/Kconfig.iosched	Wed D=
ec 17 19:58:07 2003
+++ linux-2.6.1-rc1-tiny1.config-block/drivers/block/Kconfig.iosched	Thu Ja=
n  8 11:29:14 2004
@@ -1,3 +1,5 @@
+if BLOCK
+
 config IOSCHED_NOOP
 	bool "No-op I/O scheduler" if EMBEDDED
 	default y
@@ -26,4 +28,6 @@
 	  workloads, better. In the case of a single process performing I/O to
 	  a disk at any one time, its behaviour is almost identical to the
 	  anticipatory I/O scheduler and so is a good choice.
+
+endif
=20
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/drivers=
/block/Makefile linux-2.6.1-rc1-tiny1.config-block/drivers/block/Makefile
--- linux-2.6.1-rc1-tiny1.compile-fixes/drivers/block/Makefile	Wed Dec 17 1=
9:59:19 2003
+++ linux-2.6.1-rc1-tiny1.config-block/drivers/block/Makefile	Thu Jan  8 11=
:29:14 2004
@@ -13,7 +13,7 @@
 # kblockd threads
 #
=20
-obj-y	:=3D elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
+obj-$(CONFIG_BLOCK)	:=3D elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl=
.o
=20
 obj-$(CONFIG_IOSCHED_NOOP)	+=3D noop-iosched.o
 obj-$(CONFIG_IOSCHED_AS)	+=3D as-iosched.o
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/drivers=
/md/Kconfig linux-2.6.1-rc1-tiny1.config-block/drivers/md/Kconfig
--- linux-2.6.1-rc1-tiny1.compile-fixes/drivers/md/Kconfig	Sat Jan  3 22:09=
:07 2004
+++ linux-2.6.1-rc1-tiny1.config-block/drivers/md/Kconfig	Thu Jan  8 11:29:=
14 2004
@@ -3,6 +3,7 @@
 #
=20
 menu "Multi-device support (RAID and LVM)"
+	depends on BLOCK
=20
 config MD
 	bool "Multiple devices driver support (RAID and LVM)"
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/fs/Kcon=
fig linux-2.6.1-rc1-tiny1.config-block/fs/Kconfig
--- linux-2.6.1-rc1-tiny1.compile-fixes/fs/Kconfig	Sun Jan  4 00:03:56 2004
+++ linux-2.6.1-rc1-tiny1.config-block/fs/Kconfig	Thu Jan  8 11:29:14 2004
@@ -6,6 +6,7 @@
=20
 config EXT2_FS
 	tristate "Second extended fs support"
+	depends on BLOCK
 	help
 	  This is the de facto standard Linux file system (method to organize
 	  files on a storage device) for hard disks.
@@ -85,6 +86,7 @@
=20
 config EXT3_FS
 	tristate "Ext3 journalling file system support"
+	depends on BLOCK
 	help
 	  This is the journaling version of the Second extended file system
 	  (often called ext3), the de facto standard Linux file system
@@ -157,6 +159,7 @@
 # dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD =
$CONFIG_EXT3_FS
 	tristate
 	default EXT3_FS
+	depends on BLOCK
 	help
 	  This is a generic journaling layer for block devices.  It is
 	  currently used by the ext3 file system, but it could also be used to
@@ -195,6 +198,7 @@
=20
 config REISERFS_FS
 	tristate "Reiserfs support"
+	depends on BLOCK
 	help
 	  Stores not just filenames but the files themselves in a balanced
 	  tree.  Uses journaling.
@@ -246,6 +250,7 @@
=20
 config JFS_FS
 	tristate "JFS filesystem support"
+	depends on BLOCK
 	select NLS
 	help
 	  This is a port of IBM's Journaled Filesystem .  More information is
@@ -293,6 +298,7 @@
=20
 config XFS_FS
 	tristate "XFS filesystem support"
+	depends on BLOCK
 	help
 	  XFS is a high performance journaling filesystem which originated
 	  on the SGI IRIX platform.  It is completely multi-threaded, can
@@ -358,6 +364,7 @@
=20
 config MINIX_FS
 	tristate "Minix fs support"
+	depends on BLOCK
 	help
 	  Minix is a simple operating system used in many classes about OS's.
 	  The minix file system (method to organize files on a hard disk
@@ -375,6 +382,7 @@
=20
 config ROMFS_FS
 	tristate "ROM file system support"
+	depends on BLOCK
 	---help---
 	  This is a very small read-only file system mainly intended for
 	  initial ram disks of installation disks, but it could be used for
@@ -466,6 +474,8 @@
 	  N here.
=20
 menu "CD-ROM/DVD Filesystems"
+	depends on BLOCK
+
=20
 config ISO9660_FS
 	tristate "ISO 9660 CDROM file system support"
@@ -529,6 +539,7 @@
 endmenu
=20
 menu "DOS/FAT/NT Filesystems"
+	depends on BLOCK
=20
 config FAT_FS
 	tristate "DOS FAT fs support"
@@ -900,6 +911,7 @@
 config ADFS_FS
 	tristate "ADFS file system support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	depends on BLOCK
 	help
 	  The Acorn Disc Filing System is the standard file system of the
 	  RiscOS operating system which runs on Acorn's ARM-based Risc PC
@@ -928,6 +940,7 @@
 config AFFS_FS
 	tristate "Amiga FFS file system support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	depends on BLOCK
 	help
 	  The Fast File System (FFS) is the common file system used on hard
 	  disks by Amiga(tm) systems since AmigaOS Version 1.3 (34.20).  Say Y
@@ -950,6 +963,7 @@
 config HFS_FS
 	tristate "Apple Macintosh file system support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	depends on BLOCK
 	help
 	  If you say Y here, you will be able to mount Macintosh-formatted
 	  floppy disks and hard drive partitions with full read-write access.
@@ -962,6 +976,7 @@
 config BEFS_FS
 	tristate "BeOS file systemv(BeFS) support (read only) (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	depends on BLOCK
 	select NLS
 	help
 	  The BeOS File System (BeFS) is the native file system of Be, Inc's
@@ -989,6 +1004,7 @@
 config BFS_FS
 	tristate "BFS file system support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	depends on BLOCK
 	help
 	  Boot File System (BFS) is a file system used under SCO UnixWare to
 	  allow the bootloader access to the kernel image and other important
@@ -1011,6 +1027,7 @@
 config EFS_FS
 	tristate "EFS file system support (read only) (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	depends on BLOCK
 	help
 	  EFS is an older file system used for non-ISO9660 CD-ROMs and hard
 	  disk partitions by SGI's IRIX operating system (IRIX 6.0 and newer
@@ -1097,6 +1114,7 @@
=20
 config CRAMFS
 	tristate "Compressed ROM file system support"
+	depends on BLOCK
 	select ZLIB_INFLATE
 	help
 	  Saying Y here includes support for CramFs (Compressed ROM File
@@ -1116,6 +1134,7 @@
=20
 config VXFS_FS
 	tristate "FreeVxFS file system support (VERITAS VxFS(TM) compatible)"
+	depends on BLOCK
 	help
 	  FreeVxFS is a file system driver that support the VERITAS VxFS(TM)
 	  file system format.  VERITAS VxFS(TM) is the standard file system
@@ -1133,6 +1152,7 @@
=20
 config HPFS_FS
 	tristate "OS/2 HPFS file system support"
+	depends on BLOCK
 	help
 	  OS/2 is IBM's operating system for PC's, the same as Warp, and HPFS
 	  is the file system used for organizing files on OS/2 hard disk
@@ -1149,6 +1169,7 @@
=20
 config QNX4FS_FS
 	tristate "QNX4 file system support (read only)"
+	depends on BLOCK
 	help
 	  This is the file system used by the real-time operating systems
 	  QNX 4 and QNX 6 (the latter is also called QNX RTP).
@@ -1176,6 +1197,7 @@
=20
 config SYSV_FS
 	tristate "System V/Xenix/V7/Coherent file system support"
+	depends on BLOCK
 	help
 	  SCO, Xenix and Coherent are commercial Unix systems for Intel
 	  machines, and Version 7 was used on the DEC PDP-11. Saying Y
@@ -1214,6 +1236,7 @@
=20
 config UFS_FS
 	tristate "UFS file system support (read only)"
+	depends on BLOCK
 	help
 	  BSD and derivate versions of Unix (such as SunOS, FreeBSD, NetBSD,
 	  OpenBSD and NeXTstep) use a file system called UFS. Some System V
@@ -1608,6 +1631,7 @@
 endmenu
=20
 menu "Partition Types"
+	depends on BLOCK
=20
 source "fs/partitions/Kconfig"
=20
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/fs/Make=
file linux-2.6.1-rc1-tiny1.config-block/fs/Makefile
--- linux-2.6.1-rc1-tiny1.compile-fixes/fs/Makefile	Sun Jan  4 00:03:56 2004
+++ linux-2.6.1-rc1-tiny1.config-block/fs/Makefile	Thu Jan  8 11:29:14 2004
@@ -5,13 +5,14 @@
 # Rewritten to use lists instead of if-statements.
 #=20
=20
-obj-y :=3D	open.o read_write.o file_table.o buffer.o \
-		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
+obj-y :=3D	open.o read_write.o file_table.o \
+		super.o char_dev.o stat.o exec.o pipe.o \
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o
+		fs-writeback.o mpage.o aio.o sync.o
=20
+obj-$(CONFIG_BLOCK)		+=3D buffer.o bio.o block_dev.o direct-io.o
 obj-$(CONFIG_DNOTIFY)		+=3D dnotify.o
 obj-$(CONFIG_EPOLL)		+=3D eventpoll.o
 obj-$(CONFIG_COMPAT)		+=3D compat.o
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/fs/bloc=
k_dev.c linux-2.6.1-rc1-tiny1.config-block/fs/block_dev.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/fs/block_dev.c	Wed Dec 17 20:00:01 =
2003
+++ linux-2.6.1-rc1-tiny1.config-block/fs/block_dev.c	Thu Jan  8 11:29:14 2=
004
@@ -899,3 +899,104 @@
 }
=20
 EXPORT_SYMBOL(close_bdev_excl);
+
+static void do_emergency_remount(unsigned long foo)
+{
+	struct super_block *sb;
+
+	spin_lock(&sb_lock);
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+		down_read(&sb->s_umount);
+		if (sb->s_root && sb->s_bdev && !(sb->s_flags & MS_RDONLY)) {
+			/*
+			 * ->remount_fs needs lock_kernel().
+			 *
+			 * What lock protects sb->s_flags??
+			 */
+			lock_kernel();
+			do_remount_sb(sb, MS_RDONLY, NULL, 1);
+			unlock_kernel();
+		}
+		drop_super(sb);
+		spin_lock(&sb_lock);
+	}
+	spin_unlock(&sb_lock);
+	printk("Emergency Remount complete\n");
+}
+
+void emergency_remount(void)
+{
+	pdflush_operation(do_emergency_remount, 0);
+}
+
+static int set_bdev_super(struct super_block *s, void *data)
+{
+	s->s_bdev =3D data;
+	s->s_dev =3D s->s_bdev->bd_dev;
+	return 0;
+}
+
+static int test_bdev_super(struct super_block *s, void *data)
+{
+	return (void *)s->s_bdev =3D=3D data;
+}
+
+struct super_block *get_sb_bdev(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data,
+	int (*fill_super)(struct super_block *, void *, int))
+{
+	struct block_device *bdev;
+	struct super_block *s;
+	int error =3D 0;
+
+	bdev =3D open_bdev_excl(dev_name, flags, BDEV_FS, fs_type);
+	if (IS_ERR(bdev))
+		return (struct super_block *)bdev;
+
+	s =3D sget(fs_type, test_bdev_super, set_bdev_super, bdev);
+	if (IS_ERR(s))
+		goto out;
+
+	if (s->s_root) {
+		if ((flags ^ s->s_flags) & MS_RDONLY) {
+			up_write(&s->s_umount);
+			deactivate_super(s);
+			s =3D ERR_PTR(-EBUSY);
+		}
+		goto out;
+	} else {
+		char b[BDEVNAME_SIZE];
+
+		s->s_flags =3D flags;
+		strncpy(s->s_id, bdevname(bdev, b), sizeof(s->s_id));
+		s->s_old_blocksize =3D block_size(bdev);
+		sb_set_blocksize(s, s->s_old_blocksize);
+		error =3D fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+		if (error) {
+			up_write(&s->s_umount);
+			deactivate_super(s);
+			s =3D ERR_PTR(error);
+		} else
+			s->s_flags |=3D MS_ACTIVE;
+	}
+
+	return s;
+
+out:
+	close_bdev_excl(bdev, BDEV_FS);
+	return s;
+}
+
+EXPORT_SYMBOL(get_sb_bdev);
+
+void kill_block_super(struct super_block *sb)
+{
+	struct block_device *bdev =3D sb->s_bdev;
+	generic_shutdown_super(sb);
+	set_blocksize(bdev, sb->s_old_blocksize);
+	close_bdev_excl(bdev, BDEV_FS);
+}
+
+EXPORT_SYMBOL(kill_block_super);
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/fs/buff=
er.c linux-2.6.1-rc1-tiny1.config-block/fs/buffer.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/fs/buffer.c	Sun Jan  4 00:03:56 2004
+++ linux-2.6.1-rc1-tiny1.config-block/fs/buffer.c	Thu Jan  8 11:29:14 2004
@@ -16,6 +16,10 @@
  * Added 32k buffer block sizes - these are required older ARM systems. - =
RMK
  *
  * async buffer flushing, 1999 Andrea Arcangeli <andrea@suse.de>
+ *
+ * moved bdflush and generic sync functions to sync.c
+ * moved try_to_release_page to mm/page-writeback.c=20
+ *     Eric Biederman <ebiederm@xmission.com> 8 Jan 2004=20
  */
=20
 #include <linux/config.h>
@@ -225,27 +229,6 @@
=20
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
@@ -260,137 +243,7 @@
 	return sync_blockdev(bdev);
 }
=20
-/*
- * sync everything.  Start out by waking pdflush, because that writes back
- * all queues in parallel.
- */
-static void do_sync(unsigned long wait)
-{
-	wakeup_bdflush(0);
-	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
-	DQUOT_SYNC(NULL);
-	sync_supers();		/* Write the superblocks */
-	sync_filesystems(0);	/* Start syncing the filesystems */
-	sync_filesystems(wait);	/* Waitingly sync the filesystems */
-	sync_inodes(wait);	/* Mappings, inodes and blockdevs, again. */
-	if (!wait)
-		printk("Emergency Sync complete\n");
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
-=20
-int file_fsync(struct file *filp, struct dentry *dentry, int datasync)
-{
-	struct inode * inode =3D dentry->d_inode;
-	struct super_block * sb;
-	int ret;
-
-	/* sync the inode to buffers */
-	write_inode_now(inode, 0);
-
-	/* sync the superblock to buffers */
-	sb =3D inode->i_sb;
-	lock_super(sb);
-	if (sb->s_op->write_super)
-		sb->s_op->write_super(sb);
-	unlock_super(sb);
-
-	/* .. finally sync the buffers to disk */
-	ret =3D sync_blockdev(sb->s_bdev);
-	return ret;
-}
-
-asmlinkage long sys_fsync(unsigned int fd)
-{
-	struct file * file;
-	struct dentry * dentry;
-	struct inode * inode;
-	int ret, err;
-
-	ret =3D -EBADF;
-	file =3D fget(fd);
-	if (!file)
-		goto out;
-
-	dentry =3D file->f_dentry;
-	inode =3D dentry->d_inode;
-
-	ret =3D -EINVAL;
-	if (!file->f_op || !file->f_op->fsync) {
-		/* Why?  We can still call filemap_fdatawrite */
-		goto out_putf;
-	}
-
-	/* We need to protect against concurrent writers.. */
-	down(&inode->i_sem);
-	current->flags |=3D PF_SYNCWRITE;
-	ret =3D filemap_fdatawrite(inode->i_mapping);
-	err =3D file->f_op->fsync(file, dentry, 0);
-	if (!ret)
-		ret =3D err;
-	err =3D filemap_fdatawait(inode->i_mapping);
-	if (!ret)
-		ret =3D err;
-	current->flags &=3D ~PF_SYNCWRITE;
-	up(&inode->i_sem);
-
-out_putf:
-	fput(file);
-out:
-	return ret;
-}
-
-asmlinkage long sys_fdatasync(unsigned int fd)
-{
-	struct file * file;
-	struct dentry * dentry;
-	struct inode * inode;
-	int ret, err;
-
-	ret =3D -EBADF;
-	file =3D fget(fd);
-	if (!file)
-		goto out;
-
-	dentry =3D file->f_dentry;
-	inode =3D dentry->d_inode;
-
-	ret =3D -EINVAL;
-	if (!file->f_op || !file->f_op->fsync)
-		goto out_putf;
-
-	down(&inode->i_sem);
-	current->flags |=3D PF_SYNCWRITE;
-	ret =3D filemap_fdatawrite(inode->i_mapping);
-	err =3D file->f_op->fsync(file, dentry, 1);
-	if (!ret)
-		ret =3D err;
-	err =3D filemap_fdatawait(inode->i_mapping);
-	if (!ret)
-		ret =3D err;
-	current->flags &=3D ~PF_SYNCWRITE;
-	up(&inode->i_sem);
=20
-out_putf:
-	fput(file);
-out:
-	return ret;
-}
=20
 /*
  * Various filesystems appear to want __find_get_block to be non-blocking.
@@ -1562,35 +1415,6 @@
 }
=20
 /**
- * try_to_release_page() - release old fs-specific metadata on a page
- *
- * @page: the page which the kernel is trying to free
- * @gfp_mask: memory allocation flags (and I/O mode)
- *
- * The address_space is to try to release any data against the page
- * (presumably at page->private).  If the release was successful, return `=
1'.
- * Otherwise return zero.
- *
- * The @gfp_mask argument specifies whether I/O may be performed to release
- * this page (__GFP_IO), and whether the call may block (__GFP_WAIT).
- *
- * NOTE: @gfp_mask may go away, and this function may become non-blocking.
- */
-int try_to_release_page(struct page *page, int gfp_mask)
-{
-	struct address_space * const mapping =3D page->mapping;
-
-	if (!PageLocked(page))
-		BUG();
-	if (PageWriteback(page))
-		return 0;
-=09
-	if (mapping && mapping->a_ops->releasepage)
-		return mapping->a_ops->releasepage(page, gfp_mask);
-	return try_to_free_buffers(page);
-}
-
-/**
  * block_invalidatepage - invalidate part of all of a buffer-backed page
  *
  * @page: the page which is affected
@@ -2894,33 +2718,6 @@
 }
=20
 /*
- * There are no bdflush tunables left.  But distributions are
- * still running obsolete flush daemons, so we terminate them here.
- *
- * Use of bdflush() is deprecated and will be removed in a future kernel.
- * The `pdflush' kernel threads fully replace bdflush daemons and this cal=
l.
- */
-asmlinkage long sys_bdflush(int func, long data)
-{
-	static int msg_count;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	if (msg_count < 5) {
-		msg_count++;
-		printk(KERN_INFO
-			"warning: process `%s' used the obsolete bdflush"
-			" system call\n", current->comm);
-		printk(KERN_INFO "Fix your initscripts?\n");
-	}
-
-	if (func =3D=3D 1)
-		do_exit(0);
-	return 0;
-}
-
-/*
  * Buffer-head allocation
  */
 static kmem_cache_t *bh_cachep;
@@ -3054,7 +2851,6 @@
 EXPORT_SYMBOL(end_buffer_async_write);
 EXPORT_SYMBOL(end_buffer_read_sync);
 EXPORT_SYMBOL(end_buffer_write_sync);
-EXPORT_SYMBOL(file_fsync);
 EXPORT_SYMBOL(fsync_bdev);
 EXPORT_SYMBOL(fsync_buffers_list);
 EXPORT_SYMBOL(generic_block_bmap);
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/fs/dcac=
he.c linux-2.6.1-rc1-tiny1.config-block/fs/dcache.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/fs/dcache.c	Sat Jan  3 22:09:11 2004
+++ linux-2.6.1-rc1-tiny1.config-block/fs/dcache.c	Thu Jan  8 11:29:14 2004
@@ -1598,7 +1598,12 @@
=20
 EXPORT_SYMBOL(d_genocide);
=20
+#ifdef CONFIG_BLOCK
 extern void bdev_cache_init(void);
+#else
+static inline void bdev_cache_init(void) {}
+#endif
+
 extern void chrdev_init(void);
=20
 void __init vfs_caches_init(unsigned long mempages)
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/fs/fs-w=
riteback.c linux-2.6.1-rc1-tiny1.config-block/fs/fs-writeback.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/fs/fs-writeback.c	Wed Dec 17 20:00:=
00 2003
+++ linux-2.6.1-rc1-tiny1.config-block/fs/fs-writeback.c	Thu Jan  8 11:29:1=
4 2004
@@ -23,7 +23,9 @@
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
=20
+#ifdef CONFIG_BLOCK
 extern struct super_block *blockdev_superblock;
+#endif
=20
 /**
  *	__mark_inode_dirty -	internal function
@@ -263,6 +265,7 @@
 		struct backing_dev_info *bdi =3D mapping->backing_dev_info;
=20
 		if (bdi->memory_backed) {
+#ifdef CONFIG_BLOCK
 			if (sb =3D=3D blockdev_superblock) {
 				/*
 				 * Dirty memory-backed blockdev: the ramdisk
@@ -271,6 +274,7 @@
 				list_move(&inode->i_list, &sb->s_dirty);
 				continue;
 			}
+#endif
 			/*
 			 * Assume that all inodes on this superblock are memory
 			 * backed.  Skip the superblock.
@@ -280,15 +284,19 @@
=20
 		if (wbc->nonblocking && bdi_write_congested(bdi)) {
 			wbc->encountered_congestion =3D 1;
+#ifdef CONFIG_BLOCK
 			if (sb !=3D blockdev_superblock)
 				break;		/* Skip a congested fs */
+#endif
 			list_move(&inode->i_list, &sb->s_dirty);
 			continue;		/* Skip a congested blockdev */
 		}
=20
 		if (wbc->bdi && bdi !=3D wbc->bdi) {
+#ifdef CONFIG_BLOCK
 			if (sb !=3D blockdev_superblock)
 				break;		/* fs has the wrong queue */
+#endif
 			list_move(&inode->i_list, &sb->s_dirty);
 			continue;		/* blockdev has wrong queue */
 		}
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/fs/inod=
e.c linux-2.6.1-rc1-tiny1.config-block/fs/inode.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/fs/inode.c	Wed Dec 17 19:59:55 2003
+++ linux-2.6.1-rc1-tiny1.config-block/fs/inode.c	Thu Jan  8 11:29:14 2004
@@ -245,8 +245,10 @@
 	DQUOT_DROP(inode);
 	if (inode->i_sb && inode->i_sb->s_op->clear_inode)
 		inode->i_sb->s_op->clear_inode(inode);
+#ifdef CONFIG_BLOCK
 	if (inode->i_bdev)
 		bd_forget(inode);
+#endif
 	if (inode->i_cdev)
 		cd_forget(inode);
 	inode->i_state =3D I_CLEAR;
@@ -354,6 +356,7 @@
=20
 EXPORT_SYMBOL(invalidate_inodes);
=20=20
+#ifdef CONFIG_BLOCK
 int __invalidate_device(struct block_device *bdev, int do_sync)
 {
 	struct super_block *sb;
@@ -380,6 +383,7 @@
 }
=20
 EXPORT_SYMBOL(__invalidate_device);
+#endif
=20
 static int can_unuse(struct inode *inode)
 {
@@ -1384,6 +1388,17 @@
=20
 	set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
 }
+
+#ifndef CONFIG_BLOCK
+static int no_bdev_open(struct inode *inode, struct file *file)
+{
+	return -ENXIO;
+};
+
+struct file_operations def_blk_fops =3D {
+	.open	=3D no_bdev_open,
+};
+#endif
=20
 void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
 {
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/fs/mpag=
e.c linux-2.6.1-rc1-tiny1.config-block/fs/mpage.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/fs/mpage.c	Wed Dec 17 19:58:28 2003
+++ linux-2.6.1-rc1-tiny1.config-block/fs/mpage.c	Thu Jan  8 11:29:14 2004
@@ -27,6 +27,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
=20
+#ifdef CONFIG_BLOCK
 /*
  * I/O completion handler for multipage BIOs.
  *
@@ -576,6 +577,8 @@
 	return bio;
 }
=20
+#endif /* CONFIG_BLOCK */
+
 /**
  * mpage_writepages - walk the list of dirty pages of the given
  * address space and writepage() all of them.
@@ -620,8 +623,10 @@
 		struct writeback_control *wbc, get_block_t get_block)
 {
 	struct backing_dev_info *bdi =3D mapping->backing_dev_info;
+#ifdef CONFIG_BLOCK
 	struct bio *bio =3D NULL;
 	sector_t last_block_in_bio =3D 0;
+#endif
 	int ret =3D 0;
 	int done =3D 0;
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
@@ -631,8 +636,10 @@
 		return 0;
 	}
=20
+#ifdef CONFIG_BLOCK
 	writepage =3D NULL;
 	if (get_block =3D=3D NULL)
+#endif
 		writepage =3D mapping->a_ops->writepage;
=20
 	spin_lock(&mapping->page_lock);
@@ -671,7 +678,9 @@
=20
 		if (page->mapping =3D=3D mapping && !PageWriteback(page) &&
 					test_clear_page_dirty(page)) {
+#ifdef CONFIG_BLOCK
 			if (writepage) {
+#endif
 				ret =3D (*writepage)(page, wbc);
 				if (ret) {
 					if (ret =3D=3D -ENOSPC)
@@ -681,10 +690,13 @@
 						set_bit(AS_EIO,
 							&mapping->flags);
 				}
-			} else {
+#ifdef CONFIG_BLOCK
+			}=20
+			else {
 				bio =3D mpage_writepage(bio, page, get_block,
 					&last_block_in_bio, &ret, wbc);
 			}
+#endif
 			if (ret || (--(wbc->nr_to_write) <=3D 0))
 				done =3D 1;
 			if (wbc->nonblocking && bdi_write_congested(bdi)) {
@@ -701,8 +713,10 @@
 	 * Leave any remaining dirty pages on ->io_pages
 	 */
 	spin_unlock(&mapping->page_lock);
+#ifdef CONFIG_BLOCK
 	if (bio)
 		mpage_bio_submit(WRITE, bio);
+#endif
 	return ret;
 }
 EXPORT_SYMBOL(mpage_writepages);
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/fs/part=
itions/Makefile linux-2.6.1-rc1-tiny1.config-block/fs/partitions/Makefile
--- linux-2.6.1-rc1-tiny1.compile-fixes/fs/partitions/Makefile	Wed Dec 17 1=
9:58:47 2003
+++ linux-2.6.1-rc1-tiny1.config-block/fs/partitions/Makefile	Thu Jan  8 11=
:29:14 2004
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
=20
-obj-y :=3D check.o
+obj-$(CONFIG_BLOCK) :=3D check.o
=20
 obj-$(CONFIG_DEVFS_FS) +=3D devfs.o
 obj-$(CONFIG_ACORN_PARTITION) +=3D acorn.o
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/fs/supe=
r.c linux-2.6.1-rc1-tiny1.config-block/fs/super.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/fs/super.c	Wed Dec 17 19:58:48 2003
+++ linux-2.6.1-rc1-tiny1.config-block/fs/super.c	Thu Jan  8 11:29:14 2004
@@ -18,6 +18,8 @@
  *    Torbj=F6rn Lindh (torbjorn.lindh@gopta.se), April 14, 1996.
  *  Added devfs support: Richard Gooch <rgooch@atnf.csiro.au>, 13-JAN-1998
  *  Heavily rewritten for 'one fs - one tree' dcache architecture. AV, Mar=
 2000
+ *  Moved block device specific functions to block_dev.c=20
+ *     Eric Biederman <ebiederm@xmission.com> 8 Jan 2004
  */
=20
 #include <linux/config.h>
@@ -499,37 +501,6 @@
 	return 0;
 }
=20
-static void do_emergency_remount(unsigned long foo)
-{
-	struct super_block *sb;
-
-	spin_lock(&sb_lock);
-	list_for_each_entry(sb, &super_blocks, s_list) {
-		sb->s_count++;
-		spin_unlock(&sb_lock);
-		down_read(&sb->s_umount);
-		if (sb->s_root && sb->s_bdev && !(sb->s_flags & MS_RDONLY)) {
-			/*
-			 * ->remount_fs needs lock_kernel().
-			 *
-			 * What lock protects sb->s_flags??
-			 */
-			lock_kernel();
-			do_remount_sb(sb, MS_RDONLY, NULL, 1);
-			unlock_kernel();
-		}
-		drop_super(sb);
-		spin_lock(&sb_lock);
-	}
-	spin_unlock(&sb_lock);
-	printk("Emergency Remount complete\n");
-}
-
-void emergency_remount(void)
-{
-	pdflush_operation(do_emergency_remount, 0);
-}
-
 /*
  * Unnamed block devices are dummy devices used by virtual
  * filesystems which don't use real block-devices.  -- jrs
@@ -575,76 +546,6 @@
 }
=20
 EXPORT_SYMBOL(kill_litter_super);
-
-static int set_bdev_super(struct super_block *s, void *data)
-{
-	s->s_bdev =3D data;
-	s->s_dev =3D s->s_bdev->bd_dev;
-	return 0;
-}
-
-static int test_bdev_super(struct super_block *s, void *data)
-{
-	return (void *)s->s_bdev =3D=3D data;
-}
-
-struct super_block *get_sb_bdev(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
-{
-	struct block_device *bdev;
-	struct super_block *s;
-	int error =3D 0;
-
-	bdev =3D open_bdev_excl(dev_name, flags, BDEV_FS, fs_type);
-	if (IS_ERR(bdev))
-		return (struct super_block *)bdev;
-
-	s =3D sget(fs_type, test_bdev_super, set_bdev_super, bdev);
-	if (IS_ERR(s))
-		goto out;
-
-	if (s->s_root) {
-		if ((flags ^ s->s_flags) & MS_RDONLY) {
-			up_write(&s->s_umount);
-			deactivate_super(s);
-			s =3D ERR_PTR(-EBUSY);
-		}
-		goto out;
-	} else {
-		char b[BDEVNAME_SIZE];
-
-		s->s_flags =3D flags;
-		strncpy(s->s_id, bdevname(bdev, b), sizeof(s->s_id));
-		s->s_old_blocksize =3D block_size(bdev);
-		sb_set_blocksize(s, s->s_old_blocksize);
-		error =3D fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
-		if (error) {
-			up_write(&s->s_umount);
-			deactivate_super(s);
-			s =3D ERR_PTR(error);
-		} else
-			s->s_flags |=3D MS_ACTIVE;
-	}
-
-	return s;
-
-out:
-	close_bdev_excl(bdev, BDEV_FS);
-	return s;
-}
-
-EXPORT_SYMBOL(get_sb_bdev);
-
-void kill_block_super(struct super_block *sb)
-{
-	struct block_device *bdev =3D sb->s_bdev;
-	generic_shutdown_super(sb);
-	set_blocksize(bdev, sb->s_old_blocksize);
-	close_bdev_excl(bdev, BDEV_FS);
-}
-
-EXPORT_SYMBOL(kill_block_super);
=20
 struct super_block *get_sb_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/fs/sync=
.c linux-2.6.1-rc1-tiny1.config-block/fs/sync.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/fs/sync.c	Wed Dec 31 17:00:00 1969
+++ linux-2.6.1-rc1-tiny1.config-block/fs/sync.c	Thu Jan  8 11:29:14 2004
@@ -0,0 +1,201 @@
+/*
+ *  linux/fs/sync.c
+ *
+ *  Copyright (C) 1991, 1992, 2002  Linus Torvalds=20
+ *  And others see buffer.c
+ */
+
+/*
+ * Moved here from buffer.c 8 Jan 2004 Eric Biederman <ebiererman@xmission=
.com>
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/file.h>
+#include <linux/quotaops.h>
+#include <linux/writeback.h>
+#include <linux/buffer_head.h>
+#include <linux/module.h>
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
+	sync_blockdev(sb->s_bdev);
+	sync_inodes_sb(sb, 1);
+
+	return sync_blockdev(sb->s_bdev);
+}
+
+/*
+ * sync everything.  Start out by waking pdflush, because that writes back
+ * all queues in parallel.
+ */
+static void do_sync(unsigned long wait)
+{
+	wakeup_bdflush(0);
+	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
+	DQUOT_SYNC(NULL);
+	sync_supers();		/* Write the superblocks */
+	sync_filesystems(0);	/* Start syncing the filesystems */
+	sync_filesystems(wait);	/* Waitingly sync the filesystems */
+	sync_inodes(wait);	/* Mappings, inodes and blockdevs, again. */
+	if (!wait)
+		printk("Emergency Sync complete\n");
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
+=20
+int file_fsync(struct file *filp, struct dentry *dentry, int datasync)
+{
+	struct inode * inode =3D dentry->d_inode;
+	struct super_block * sb;
+	int ret;
+
+	/* sync the inode to buffers */
+	write_inode_now(inode, 0);
+
+	/* sync the superblock to buffers */
+	sb =3D inode->i_sb;
+	lock_super(sb);
+	if (sb->s_op->write_super)
+		sb->s_op->write_super(sb);
+	unlock_super(sb);
+
+	/* .. finally sync the buffers to disk */
+	ret =3D sync_blockdev(sb->s_bdev);
+	return ret;
+}
+EXPORT_SYMBOL(file_fsync);
+
+asmlinkage long sys_fsync(unsigned int fd)
+{
+	struct file * file;
+	struct dentry * dentry;
+	struct inode * inode;
+	int ret, err;
+
+	ret =3D -EBADF;
+	file =3D fget(fd);
+	if (!file)
+		goto out;
+
+	dentry =3D file->f_dentry;
+	inode =3D dentry->d_inode;
+
+	ret =3D -EINVAL;
+	if (!file->f_op || !file->f_op->fsync) {
+		/* Why?  We can still call filemap_fdatawrite */
+		goto out_putf;
+	}
+
+	/* We need to protect against concurrent writers.. */
+	down(&inode->i_sem);
+	current->flags |=3D PF_SYNCWRITE;
+	ret =3D filemap_fdatawrite(inode->i_mapping);
+	err =3D file->f_op->fsync(file, dentry, 0);
+	if (!ret)
+		ret =3D err;
+	err =3D filemap_fdatawait(inode->i_mapping);
+	if (!ret)
+		ret =3D err;
+	current->flags &=3D ~PF_SYNCWRITE;
+	up(&inode->i_sem);
+
+out_putf:
+	fput(file);
+out:
+	return ret;
+}
+
+asmlinkage long sys_fdatasync(unsigned int fd)
+{
+	struct file * file;
+	struct dentry * dentry;
+	struct inode * inode;
+	int ret, err;
+
+	ret =3D -EBADF;
+	file =3D fget(fd);
+	if (!file)
+		goto out;
+
+	dentry =3D file->f_dentry;
+	inode =3D dentry->d_inode;
+
+	ret =3D -EINVAL;
+	if (!file->f_op || !file->f_op->fsync)
+		goto out_putf;
+
+	down(&inode->i_sem);
+	current->flags |=3D PF_SYNCWRITE;
+	ret =3D filemap_fdatawrite(inode->i_mapping);
+	err =3D file->f_op->fsync(file, dentry, 1);
+	if (!ret)
+		ret =3D err;
+	err =3D filemap_fdatawait(inode->i_mapping);
+	if (!ret)
+		ret =3D err;
+	current->flags &=3D ~PF_SYNCWRITE;
+	up(&inode->i_sem);
+
+out_putf:
+	fput(file);
+out:
+	return ret;
+}
+
+/*
+ * There are no bdflush tunables left.  But distributions are
+ * still running obsolete flush daemons, so we terminate them here.
+ *
+ * Use of bdflush() is deprecated and will be removed in a future kernel.
+ * The `pdflush' kernel threads fully replace bdflush daemons and this cal=
l.
+ */
+asmlinkage long sys_bdflush(int func, long data)
+{
+	static int msg_count;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (msg_count < 5) {
+		msg_count++;
+		printk(KERN_INFO
+			"warning: process `%s' used the obsolete bdflush"
+			" system call\n", current->comm);
+		printk(KERN_INFO "Fix your initscripts?\n");
+	}
+
+	if (func =3D=3D 1)
+		do_exit(0);
+	return 0;
+}
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/include=
/linux/blkdev.h linux-2.6.1-rc1-tiny1.config-block/include/linux/blkdev.h
--- linux-2.6.1-rc1-tiny1.compile-fixes/include/linux/blkdev.h	Wed Dec 17 1=
9:58:28 2003
+++ linux-2.6.1-rc1-tiny1.config-block/include/linux/blkdev.h	Thu Jan  8 11=
:29:14 2004
@@ -577,7 +577,11 @@
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatt=
erlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
 extern void generic_unplug_device(void *);
+#ifdef CONFIG_BLOCK
 extern long nr_blockdev_pages(void);
+#else
+static inline long nr_blockdev_pages(void) { return 0; }
+#endif
=20
 int blk_get_queue(request_queue_t *);
 request_queue_t *blk_alloc_queue(int);
@@ -596,7 +600,12 @@
 extern void blk_queue_free_tags(request_queue_t *);
 extern int blk_queue_resize_tags(request_queue_t *, int);
 extern void blk_queue_invalidate_tags(request_queue_t *);
+
+#ifdef CONFIG_BLOCK
 extern void blk_congestion_wait(int rw, long timeout);
+#else
+static inline void blk_congestion_wait(int rw, long timeout) {}=20
+#endif
=20
 extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bi=
o *);
 extern void blk_rq_prep_restart(struct request *);
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/include=
/linux/buffer_head.h linux-2.6.1-rc1-tiny1.config-block/include/linux/buffe=
r_head.h
--- linux-2.6.1-rc1-tiny1.compile-fixes/include/linux/buffer_head.h	Wed Dec=
 17 19:58:04 2003
+++ linux-2.6.1-rc1-tiny1.config-block/include/linux/buffer_head.h	Thu Jan =
 8 11:29:14 2004
@@ -150,17 +150,26 @@
 void buffer_insert_list(spinlock_t *lock,
 			struct buffer_head *, struct list_head *);
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode);
+#ifdef CONFIG_BLOCK
 int inode_has_buffers(struct inode *);
 void invalidate_inode_buffers(struct inode *);
 int remove_inode_buffers(struct inode *inode);
-int fsync_buffers_list(spinlock_t *lock, struct list_head *);
 int sync_mapping_buffers(struct address_space *mapping);
+int sync_blockdev(struct block_device *bdev);
+#else
+static inline int inode_has_buffers(struct inode *inode) { return 0; }
+static inline void invalidate_inode_buffers(struct inode *inode) { }
+static inline int remove_inode_buffers(struct inode *inode) { return 1; }
+static inline int sync_mapping_buffers(struct address_space *mapping) { re=
turn 0; }
+static inline int sync_blockdev(struct block_device *bdev) { return 0; }
+#endif
+int fsync_buffers_list(spinlock_t *lock, struct list_head *);
+
 void unmap_underlying_metadata(struct block_device *bdev, sector_t block);
=20
 void mark_buffer_async_read(struct buffer_head *bh);
 void mark_buffer_async_write(struct buffer_head *bh);
 void invalidate_bdev(struct block_device *, int);
-int sync_blockdev(struct block_device *bdev);
 void __wait_on_buffer(struct buffer_head *);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 void wake_up_buffer(struct buffer_head *bh);
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/include=
/linux/fs.h linux-2.6.1-rc1-tiny1.config-block/include/linux/fs.h
--- linux-2.6.1-rc1-tiny1.compile-fixes/include/linux/fs.h	Sun Jan  4 00:03=
:57 2004
+++ linux-2.6.1-rc1-tiny1.config-block/include/linux/fs.h	Thu Jan  8 11:29:=
14 2004
@@ -1145,7 +1145,11 @@
 extern int blkdev_put(struct block_device *, int);
 extern int bd_claim(struct block_device *, void *);
 extern void bd_release(struct block_device *);
+#ifdef CONFIG_BLOCK
 extern void blk_run_queues(void);
+#else
+static inline void blk_run_queues(void) {};
+#endif
=20
 /* fs/char_dev.c */
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, char *);
@@ -1210,7 +1214,11 @@
 extern void sync_supers(void);
 extern void sync_filesystems(int wait);
 extern void emergency_sync(void);
+#ifdef CONFIG_bLOCK
 extern void emergency_remount(void);
+#else
+static inline void emergency_remount(void) {}
+#endif
 extern int do_remount_sb(struct super_block *sb, int flags,
 			 void *data, int force);
 extern sector_t bmap(struct inode *, sector_t);
@@ -1290,7 +1298,11 @@
 extern void file_kill(struct file *f);
 struct bio;
 extern int submit_bio(int, struct bio *);
+#ifdef CONFIG_BLOCK
 extern int bdev_read_only(struct block_device *);
+#else
+static inline int bdev_read_only(struct block_device *bdev) { return 0; }
+#endif
 extern int set_blocksize(struct block_device *, int);
 extern int sb_set_blocksize(struct super_block *, int);
 extern int sb_min_blocksize(struct super_block *, int);
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/include=
/linux/mm.h linux-2.6.1-rc1-tiny1.config-block/include/linux/mm.h
--- linux-2.6.1-rc1-tiny1.compile-fixes/include/linux/mm.h	Sat Jan  3 22:09=
:12 2004
+++ linux-2.6.1-rc1-tiny1.config-block/include/linux/mm.h	Thu Jan  8 11:29:=
14 2004
@@ -486,7 +486,11 @@
 		if (spd)
 			return (*spd)(page);
 	}
+#if CONFIG_BLOCK
 	return __set_page_dirty_buffers(page);
+#else
+	return 0;
+#endif
 }
=20
 /*
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/init/Kc=
onfig linux-2.6.1-rc1-tiny1.config-block/init/Kconfig
--- linux-2.6.1-rc1-tiny1.compile-fixes/init/Kconfig	Sun Jan  4 00:03:57 20=
04
+++ linux-2.6.1-rc1-tiny1.config-block/init/Kconfig	Thu Jan  8 11:29:14 2004
@@ -276,6 +276,7 @@
 	  Disabling this option will cause the kernel to be built without
 	  support for epoll family of system calls.
=20
+source "drivers/block/Kconfig.embedded"
 source "drivers/block/Kconfig.iosched"
=20
 config CC_OPTIMIZE_FOR_SIZE
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/init/do=
_mounts.c linux-2.6.1-rc1-tiny1.config-block/init/do_mounts.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/init/do_mounts.c	Sun Jan  4 00:03:5=
7 2004
+++ linux-2.6.1-rc1-tiny1.config-block/init/do_mounts.c	Thu Jan  8 11:29:14=
 2004
@@ -267,6 +267,7 @@
 	return 0;
 }
=20
+#ifdef CONFIG_BLOCK
 void __init mount_block_root(char *name, int flags)
 {
 	char *fs_names =3D __getname();
@@ -301,6 +302,7 @@
 out:
 	putname(fs_names);
 }
+#endif /* CONFIG_BLOCK */
=20=20
 #ifdef CONFIG_ROOT_NFS
 static int __init mount_nfs_root(void)
@@ -368,8 +370,10 @@
 			change_floppy("root floppy");
 	}
 #endif
+#ifdef CONFIG_BLOCK
 	create_dev("/dev/root", ROOT_DEV, root_device_name);
 	mount_block_root("/dev/root", root_mountflags);
+#endif
 }
=20
 /*
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/init/ma=
in.c linux-2.6.1-rc1-tiny1.config-block/init/main.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/init/main.c	Sun Jan  4 00:03:57 2004
+++ linux-2.6.1-rc1-tiny1.config-block/init/main.c	Thu Jan  8 11:29:14 2004
@@ -78,7 +78,6 @@
 extern void sbus_init(void);
 extern void sysctl_init(void);
 extern void signals_init(void);
-extern void buffer_init(void);
 extern void pidhash_init(void);
 extern void pidmap_init(void);
 extern void pte_chain_init(void);
@@ -89,6 +88,12 @@
=20
 #ifdef CONFIG_TC
 extern void tc_init(void);
+#endif
+
+#ifdef CONFIG_BLOCK
+extern void buffer_init(void);
+#else
+static inline void buffer_init(void) {}
 #endif
=20
 /*
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/kernel/=
exit.c linux-2.6.1-rc1-tiny1.config-block/kernel/exit.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/kernel/exit.c	Sat Jan  3 22:09:12 2=
004
+++ linux-2.6.1-rc1-tiny1.config-block/kernel/exit.c	Thu Jan  8 11:29:14 20=
04
@@ -750,8 +750,10 @@
 		panic("Attempted to kill the idle task!");
 	if (unlikely(tsk->pid =3D=3D 1))
 		panic("Attempted to kill init!");
+#ifdef CONFIG_BLOCK
 	if (tsk->io_context)
 		exit_io_context();
+#endif
 	tsk->flags |=3D PF_EXITING;
 	del_timer_sync(&tsk->real_timer);
=20
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/mm/file=
map.c linux-2.6.1-rc1-tiny1.config-block/mm/filemap.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/mm/filemap.c	Sat Jan  3 22:09:12 20=
04
+++ linux-2.6.1-rc1-tiny1.config-block/mm/filemap.c	Thu Jan  8 11:29:14 2004
@@ -1639,7 +1639,11 @@
                 file->f_error =3D 0;
                 return err;
         }
-
+#ifndef CONFIG_BLOCK
+	if (unlikely(isblk)) {
+		return -EINVAL;
+	}
+#endif
 	if (!isblk) {
 		/* FIXME: this is for backwards compatibility with 2.4 */
 		if (file->f_flags & O_APPEND)
@@ -1688,7 +1692,9 @@
=20
 		if (unlikely(*pos + *count > inode->i_sb->s_maxbytes))
 			*count =3D inode->i_sb->s_maxbytes - *pos;
-	} else {
+	}=20
+#ifdef CONFIG_BLOCK
+	else {
 		loff_t isize;
 		if (bdev_read_only(inode->i_bdev))
 			return -EPERM;
@@ -1701,6 +1707,7 @@
 		if (*pos + *count > isize)
 			*count =3D isize - *pos;
 	}
+#endif
 	return 0;
 }
=20
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/mm/high=
mem.c linux-2.6.1-rc1-tiny1.config-block/mm/highmem.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/mm/highmem.c	Sat Jan  3 22:09:12 20=
04
+++ linux-2.6.1-rc1-tiny1.config-block/mm/highmem.c	Thu Jan  8 11:29:14 2004
@@ -300,6 +300,7 @@
 	}
 }
=20
+#ifdef CONFIG_BLOCK
 static void bounce_end_io(struct bio *bio, mempool_t *pool)
 {
 	struct bio *bio_orig =3D bio->bi_private;
@@ -479,6 +480,7 @@
 }
=20
 EXPORT_SYMBOL(blk_queue_bounce);
+#endif /* CONFIG_BLOCK */
=20
 #if defined(HASHED_PAGE_VIRTUAL)
=20
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/mm/page=
-writeback.c linux-2.6.1-rc1-tiny1.config-block/mm/page-writeback.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/mm/page-writeback.c	Wed Dec 17 19:5=
9:05 2003
+++ linux-2.6.1-rc1-tiny1.config-block/mm/page-writeback.c	Thu Jan  8 11:29=
:14 2004
@@ -567,3 +567,37 @@
 	return 0;
 }
 EXPORT_SYMBOL(test_clear_page_dirty);
+
+/**
+ * try_to_release_page() - release old fs-specific metadata on a page
+ *
+ * @page: the page which the kernel is trying to free
+ * @gfp_mask: memory allocation flags (and I/O mode)
+ *
+ * The address_space is to try to release any data against the page
+ * (presumably at page->private).  If the release was successful, return `=
1'.
+ * Otherwise return zero.
+ *
+ * The @gfp_mask argument specifies whether I/O may be performed to release
+ * this page (__GFP_IO), and whether the call may block (__GFP_WAIT).
+ *
+ * NOTE: @gfp_mask may go away, and this function may become non-blocking.
+ */
+int try_to_release_page(struct page *page, int gfp_mask)
+{
+	struct address_space * const mapping =3D page->mapping;
+
+	if (!PageLocked(page))
+		BUG();
+	if (PageWriteback(page))
+		return 0;
+=09
+	if (mapping && mapping->a_ops->releasepage)
+		return mapping->a_ops->releasepage(page, gfp_mask);
+#ifdef CONFIG_BLOCK
+	return try_to_free_buffers(page);
+#else
+	BUG();
+	return 0;
+#endif
+}
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/mm/swap=
.c linux-2.6.1-rc1-tiny1.config-block/mm/swap.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/mm/swap.c	Sat Jan  3 22:09:12 2004
+++ linux-2.6.1-rc1-tiny1.config-block/mm/swap.c	Thu Jan  8 11:29:14 2004
@@ -317,6 +317,7 @@
 	pagevec_reinit(pvec);
 }
=20
+#ifdef CONFIG_BLOCK
 /*
  * Try to drop buffers from the pages in a pagevec
  */
@@ -333,6 +334,7 @@
 		}
 	}
 }
+#endif /* CONFIG_BLOCK */
=20
 /**
  * pagevec_lookup - gang pagecache lookup
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/mm/trun=
cate.c linux-2.6.1-rc1-tiny1.config-block/mm/truncate.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/mm/truncate.c	Wed Dec 17 19:59:42 2=
003
+++ linux-2.6.1-rc1-tiny1.config-block/mm/truncate.c	Thu Jan  8 11:29:14 20=
04
@@ -20,9 +20,11 @@
 {
 	int (*invalidatepage)(struct page *, unsigned long);
 	invalidatepage =3D page->mapping->a_ops->invalidatepage;
+#ifdef CONFIG_BLOCK
 	if (invalidatepage =3D=3D NULL)
 		invalidatepage =3D block_invalidatepage;
-	return (*invalidatepage)(page, offset);
+#endif
+	return (invalidatepage) ? (*invalidatepage)(page, offset) : 1;
 }
=20
 static inline void truncate_partial_page(struct page *page, unsigned parti=
al)
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/mm/vmsc=
an.c linux-2.6.1-rc1-tiny1.config-block/mm/vmscan.c
--- linux-2.6.1-rc1-tiny1.compile-fixes/mm/vmscan.c	Sat Jan  3 22:09:12 2004
+++ linux-2.6.1-rc1-tiny1.config-block/mm/vmscan.c	Thu Jan  8 11:29:14 2004
@@ -704,19 +704,23 @@
 			spin_unlock_irq(&zone->lru_lock);
 			pgdeactivate +=3D pgmoved;
 			pgmoved =3D 0;
+#ifdef CONFIG_BLOCK
 			if (buffer_heads_over_limit)
 				pagevec_strip(&pvec);
+#endif
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
 	zone->nr_inactive +=3D pgmoved;
 	pgdeactivate +=3D pgmoved;
+#ifdef CONFIG_BLOCK
 	if (buffer_heads_over_limit) {
 		spin_unlock_irq(&zone->lru_lock);
 		pagevec_strip(&pvec);
 		spin_lock_irq(&zone->lru_lock);
 	}
+#endif
=20
 	pgmoved =3D 0;
 	while (!list_empty(&l_active)) {

--=-=-=
Content-Disposition: attachment;
  filename=linux-2.6.1-rc1-tiny1.config-binfmt-script.diff

diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.config-block/fs/Kconfig.embedded linux-2.6.1-rc1-tiny1.config-binfmt-script/fs/Kconfig.embedded
--- linux-2.6.1-rc1-tiny1.config-block/fs/Kconfig.embedded	Wed Dec 31 17:00:00 1969
+++ linux-2.6.1-rc1-tiny1.config-binfmt-script/fs/Kconfig.embedded	Thu Jan  8 11:41:24 2004
@@ -0,0 +1,6 @@
+config BINFMT_SCRIPT
+	bool "Kernel support for shell scripts" if EMBEDDED
+	default y
+	help
+	  Allow the removal of the code for executing shell scripts
+
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.config-block/fs/Makefile linux-2.6.1-rc1-tiny1.config-binfmt-script/fs/Makefile
--- linux-2.6.1-rc1-tiny1.config-block/fs/Makefile	Thu Jan  8 11:29:14 2004
+++ linux-2.6.1-rc1-tiny1.config-binfmt-script/fs/Makefile	Thu Jan  8 11:40:59 2004
@@ -24,8 +24,7 @@
 obj-$(CONFIG_BINFMT_EM86)	+= binfmt_em86.o
 obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc.o
 
-# binfmt_script is always there
-obj-y				+= binfmt_script.o
+obj-$(CONFIG_BINFMT_SCRIPT)	+= binfmt_script.o
 
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
 obj-$(CONFIG_BINFMT_SOM)	+= binfmt_som.o
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.config-block/init/Kconfig linux-2.6.1-rc1-tiny1.config-binfmt-script/init/Kconfig
--- linux-2.6.1-rc1-tiny1.config-block/init/Kconfig	Thu Jan  8 11:29:14 2004
+++ linux-2.6.1-rc1-tiny1.config-binfmt-script/init/Kconfig	Thu Jan  8 11:42:47 2004
@@ -278,6 +278,7 @@
 
 source "drivers/block/Kconfig.embedded"
 source "drivers/block/Kconfig.iosched"
+source "fs/Kconfig.embedded"
 
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size" if EMBEDDED

--=-=-=
Content-Disposition: attachment;
  filename=linux-2.6.1-rc1-tiny1.reduce-aio.diff

diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.config-binfmt-script/fs/aio.c linux-2.6.1-rc1-tiny1.reduce-aio/fs/aio.c
--- linux-2.6.1-rc1-tiny1.config-binfmt-script/fs/aio.c	Sun Jan  4 00:03:56 2004
+++ linux-2.6.1-rc1-tiny1.reduce-aio/fs/aio.c	Thu Jan  8 12:00:28 2004
@@ -1293,46 +1293,15 @@
 	return 0;
 }
 
-asmlinkage long sys_io_setup(unsigned nr_events, aio_context_t *ctxp)
-{
-	return -ENOSYS;
-}
-
-asmlinkage long sys_io_destroy(aio_context_t ctx)
-{
-	return -ENOSYS;
-}
-
 int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 struct iocb *iocb)
 {
 	return -EINVAL;
 }
 
-asmlinkage long sys_io_submit(aio_context_t ctx_id, long nr,
-			      struct iocb __user **iocbpp)
-{
-	return -ENOSYS;
-}
-
 struct kiocb *lookup_kiocb(struct kioctx *ctx, struct iocb *iocb, u32 key)
 {
 	return 0;
-}
-
-asmlinkage long sys_io_cancel(aio_context_t ctx_id, struct iocb *iocb,
-			      struct io_event *result)
-{
-	return -ENOSYS;
-}
-
-asmlinkage long sys_io_getevents(aio_context_t ctx_id,
-				 long min_nr,
-				 long nr,
-				 struct io_event *events,
-				 struct timespec *timeout)
-{
-	return -ENOSYS;
 }
 
 EXPORT_SYMBOL(aio_complete);
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.config-binfmt-script/kernel/sys.c linux-2.6.1-rc1-tiny1.reduce-aio/kernel/sys.c
--- linux-2.6.1-rc1-tiny1.config-binfmt-script/kernel/sys.c	Thu Jan  8 11:58:47 2004
+++ linux-2.6.1-rc1-tiny1.reduce-aio/kernel/sys.c	Thu Jan  8 12:00:26 2004
@@ -251,6 +251,11 @@
 cond_syscall(sys_epoll_wait)
 cond_syscall(sys_pciconfig_read)
 cond_syscall(sys_pciconfig_write)
+cond_syscall(sys_io_setup)
+cond_syscall(sys_io_destroy)
+cond_syscall(sys_io_submit)
+cond_syscall(sys_io_cancel)
+cond_syscall(sys_io_getevents)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {

--=-=-=--
