Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSIDXOT>; Wed, 4 Sep 2002 19:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSIDXOS>; Wed, 4 Sep 2002 19:14:18 -0400
Received: from verein.lst.de ([212.34.181.86]:28933 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S316089AbSIDXON>;
	Wed, 4 Sep 2002 19:14:13 -0400
Date: Thu, 5 Sep 2002 01:18:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: lord@sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH] XFS filesystem support
Message-ID: <20020905011834.A25366@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	lord@sgi.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oookaaay Linus, I'll patchbomb you daily until it's merged or I'll get
a useful comment..


The following patch adds the config/makefile/documentation infrastructure
for XFS to the current BK tree (or 2.5.33). The actual XFS code is to big
to be posted as patch to lkml so I've uploaded a tarball at kernel.orrg:

	ftp://ftp.kernel.org/pub/linux/kernel/people/hch/xfs/xfs-2.5.33-20020905.tar.gz
	ftp://ftp.kernel.org/pub/linux/kernel/people/hch/xfs/xfs-2.5.33-20020905.tar.bz2

that can be just unpacked in the toplevel kernel source directory.  The
patch and the unpacked tarball give a fully functional XFS filesystem
driver, but no additional features that would require VFS changes.

This XFS code is very different from the latest official release (XFS 1.1).
Namely it uses the generic I/O path, has lots of dead code removed that was
needed in IRIX but superceeded by VFS check in Linux (e.g. the famous rename
checks).

 Documentation/Changes              |   16 +++++
 Documentation/filesystems/00-INDEX |    2
 Documentation/filesystems/xfs.txt  |  118 +++++++++++++++++++++++++++++++++++++
 MAINTAINERS                        |    8 ++
 fs/Config.help                     |   47 ++++++++++++++
 fs/Config.in                       |    7 ++
 fs/Makefile                        |    1
 include/linux/sched.h              |    1
 include/linux/sysctl.h             |    2
 kernel/ksyms.c                     |    1
 10 files changed, 203 insertions

For users of XFS (Linux Distributors, Universities, etc..) take a look
at the XFS users page: http://oss.sgi.com/projects/xfs/xfs_users.html.


diff -uNr -Xdontdiff -p linux-2.5/Documentation/Changes linux-2.5-xfs/Documentation/Changes
--- linux-2.5/Documentation/Changes	Thu Aug 29 22:17:58 2002
+++ linux-2.5-xfs/Documentation/Changes	Fri Jul 19 03:16:00 2002
@@ -56,6 +56,7 @@ o  modutils               2.4.2         
 o  e2fsprogs              1.25                    # tune2fs
 o  jfsutils               1.0.14                  # fsck.jfs -V
 o  reiserfsprogs          3.x.1b                  # reiserfsck 2>&1|grep reiserfsprogs
+o  xfsprogs               2.1.0                   # xfs_db -V
 o  pcmcia-cs              3.1.21                  # cardmgr -V
 o  PPP                    2.4.0                   # pppd --version
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
@@ -182,6 +183,17 @@ The reiserfsprogs package should be used
 versions of mkreiserfs, resize_reiserfs, debugreiserfs and
 reiserfsck. These utils work on both i386 and alpha platforms.
 
+Xfsprogs
+--------
+
+The latest version of xfsprogs contains mkfs.xfs, xfs_db, and the
+xfs_repair utilities, among others, for the XFS filesystem.  It is
+architecture independent and any version from 2.0.0 onward should
+work correctly with this version of the XFS kernel code.  For the new
+(v2) log format that has better support for stripe-size aligning on
+LVM and MD devices at least xfsprogs 2.1.0 is needed.
+
+
 Pcmcia-cs
 ---------
 
@@ -316,6 +328,10 @@ Reiserfsprogs
 -------------
 o  <ftp://ftp.namesys.com/pub/reiserfsprogs/reiserfsprogs-3.x.1b.tar.gz>
 
+Xfsprogs
+--------
+o  <ftp://oss.sgi.com/projects/xfs/download/cmd_tars/xfsprogs-2.1.0.src.tar.gz>
+
 LVM toolset
 -----------
 o  <http://www.sistina.com/lvm/>
diff -uNr -Xdontdiff -p linux-2.5/Documentation/filesystems/00-INDEX linux-2.5-xfs/Documentation/filesystems/00-INDEX
--- linux-2.5/Documentation/filesystems/00-INDEX	Thu Aug 29 22:18:00 2002
+++ linux-2.5-xfs/Documentation/filesystems/00-INDEX	Thu Mar 28 21:13:06 2002
@@ -46,3 +46,5 @@ vfat.txt
 	- info on using the VFAT filesystem used in Windows NT and Windows 95
 vfs.txt
 	- Overview of the Virtual File System
+xfs.txt
+	- info and mount options for the XFS filesystem.
diff -uNr -Xdontdiff -p linux-2.5/Documentation/filesystems/xfs.txt linux-2.5-xfs/Documentation/filesystems/xfs.txt
--- linux-2.5/Documentation/filesystems/xfs.txt	Thu Jan  1 01:00:00 1970
+++ linux-2.5-xfs/Documentation/filesystems/xfs.txt	Wed Jul 31 12:24:31 2002
@@ -0,0 +1,118 @@
+
+The SGI XFS Filesystem
+======================
+
+XFS is a high performance journaling filesystem which originated
+on the SGI IRIX platform.  It is completely multi-threaded, can
+support large files and large filesystems, extended attributes,
+variable block sizes, is extent based, and makes extensive use of
+Btrees (directories, extents, free space) to aid both performance
+and scalability.
+
+Refer to the documentation at http://oss.sgi.com/projects/xfs/
+for further details.  This implementation is on-disk compatible
+with the IRIX version of XFS.
+
+
+Options
+=======
+
+When mounting an XFS filesystem, the following options are accepted.
+
+  biosize=size
+	Sets the preferred buffered I/O size (default size is 64K).
+	"size" must be expressed as the logarithm (base2) of the
+	desired I/O size.
+	Valid values for this option are 14 through 16, inclusive
+	(i.e. 16K, 32K, and 64K bytes).  On machines with a 4K
+	pagesize, 13 (8K bytes) is also a valid size.
+	The preferred buffered I/O size can also be altered on an
+	individual file basis using the ioctl(2) system call.
+
+  dmapi/xdsm
+	Enable the DMAPI (Data Management API) event callouts.
+
+  irixsgid
+	Do not inherit the ISGID bit on subdirectories of ISGID
+	directories, if the process creating the subdirectory
+	is not a member of the parent directory group ID.
+	This matches IRIX behavior.
+
+  logbufs=value
+	Set the number of in-memory log buffers.  Valid numbers range
+	from 2-8 inclusive.
+	The default value is 8 buffers for filesystems with a
+	blocksize of 64K, 4 buffers for filesystems with a blocksize
+	of 32K, 3 buffers for filesystems with a blocksize of 16K
+	and 2 buffers for all other configurations.  Increasing the
+	number of buffers may increase performance on some workloads
+	at the cost of the memory used for the additional log buffers
+	and their associated control structures.
+
+  logbsize=value
+	Set the size of each in-memory log buffer.
+	Size may be specified in bytes, or in kilobytes with a "k" suffix.
+	Valid sizes for version 1 and version 2 logs are 16384 (16k) and 
+	32768 (32k).  Valid sizes for version 2 logs also include 
+	65536 (64k), 131072 (128k) and 262144 (256k).
+	The default value for machines with more than 32MB of memory
+	is 32768, machines with less memory use 16384 by default.
+
+  logdev=device and rtdev=device
+	Use an external log (metadata journal) and/or real-time device.
+	An XFS filesystem has up to three parts: a data section, a log
+	section, and a real-time section.  The real-time section is
+	optional, and the log section can be separate from the data
+	section or contained within it.
+
+  noalign
+	Data allocations will not be aligned at stripe unit boundaries.
+
+  noatime
+	Access timestamps are not updated when a file is read.
+
+  norecovery
+	The filesystem will be mounted without running log recovery.
+	If the filesystem was not cleanly unmounted, it is likely to
+	be inconsistent when mounted in "norecovery" mode.
+	Some files or directories may not be accessible because of this.
+	Filesystems mounted "norecovery" must be mounted read-only or
+	the mount will fail.
+
+  osyncisosync
+	Make O_SYNC writes implement true O_SYNC.  WITHOUT this option,
+	Linux XFS behaves as if an "osyncisdsync" option is used,
+	which will make writes to files opened with the O_SYNC flag set
+	behave as if the O_DSYNC flag had been used instead.
+	This can result in better performance without compromising
+	data safety.
+	However if this option is not in effect, timestamp updates from
+	O_SYNC writes can be lost if the system crashes.
+	If timestamp updates are critical, use the osyncisosync option.
+
+  quota/usrquota/uqnoenforce
+	User disk quota accounting enabled, and limits (optionally)
+	enforced.
+
+  grpquota/gqnoenforce
+	Group disk quota accounting enabled and limits (optionally)
+	enforced.
+
+  sunit=value and swidth=value
+	Used to specify the stripe unit and width for a RAID device or
+	a stripe volume.  "value" must be specified in 512-byte block
+	units.
+	If this option is not specified and the filesystem was made on
+	a stripe volume or the stripe width or unit were specified for
+	the RAID device at mkfs time, then the mount system call will
+	restore the value from the superblock.  For filesystems that
+	are made directly on RAID devices, these options can be used
+	to override the information in the superblock if the underlying
+	disk layout changes after the filesystem has been created.
+	The "swidth" option is required if the "sunit" option has been
+	specified, and must be a multiple of the "sunit" value.
+
+  nouuid
+        Don't check for double mounted file systems using the file system uuid.
+        This is useful to mount LVM snapshot volumes.
+
diff -uNr -Xdontdiff -p linux-2.5/MAINTAINERS linux-2.5-xfs/MAINTAINERS
--- linux-2.5/MAINTAINERS	Thu Aug 29 22:17:47 2002
+++ linux-2.5-xfs/MAINTAINERS	Wed Aug 28 02:04:34 2002
@@ -1915,6 +1915,14 @@ M:	eis@baty.hanse.de
 L:	linux-x25@vger.kernel.org
 S:	Maintained
 
+XFS FILESYSTEM
+P:	Silicon Graphics Inc
+M:	owner-xfs@oss.sgi.com
+M:	lord@sgi.com
+L:	linux-xfs@oss.sgi.com
+W:	http://oss.sgi.com/projects/xfs
+S:	Supported
+
 X86 3-LEVEL PAGING (PAE) SUPPORT
 P:	Ingo Molnar
 M:	mingo@redhat.com
diff -uNr -Xdontdiff -p linux-2.5.32/fs/Config.help linux-2.5-xfs/fs/Config.help
--- linux-2.5/fs/Config.help	Thu Aug 29 22:20:11 2002
+++ linux-2.5-xfs/fs/Config.help	Thu Jul 25 23:18:55 2002
@@ -1036,3 +1036,50 @@ CONFIG_NCPFS_NLS
 
   To select codepages and I/O charsets use ncpfs-2.2.0.13 or newer.
 
+CONFIG_XFS_FS
+  XFS is a high performance journaling filesystem which originated
+  on the SGI IRIX platform.  It is completely multi-threaded, can
+  support large files and large filesystems, extended attributes,
+  variable block sizes, is extent based, and makes extensive use of
+  Btrees (directories, extents, free space) to aid both performance
+  and scalability.
+
+  Refer to the documentation at <http://oss.sgi.com/projects/xfs/>
+  for complete details.  This implementation is on-disk compatible
+  with the IRIX version of XFS.
+
+  If you want to compile this file system as a module ( = code which
+  can be inserted in and removed from the running kernel whenever you
+  want), say M here and read <file:Documentation/modules.txt>. The
+  module will be called xfs.o.  Be aware, however, that if the file
+  system of your root partition is compiled as a module, you'll need
+  to use an initial ramdisk (initrd) to boot.
+
+CONFIG_XFS_QUOTA
+  If you say Y here, you will be able to set limits for disk usage on
+  a per user and/or a per group basis under XFS.  XFS considers quota
+  information as filesystem metadata and uses journaling to provide a
+  higher level guarantee of consistency.  The on-disk data format for
+  quota is also compatible with the IRIX version of XFS, allowing a
+  filesystem to be migrated between Linux and IRIX without any need
+  for conversion.
+
+  If unsure, say N.  More comprehensive documentation can be found in
+  README.quota in the xfsprogs package.  XFS quota can be used either
+  with or without the generic quota support enabled (CONFIG_QUOTA) -
+  they are completely independent subsystems.
+
+CONFIG_XFS_RT
+  If you say Y here you will be able to mount and use XFS filesystems
+  which contain a realtime subvolume. The realtime subvolume is a
+  separate area of disk space where only file data is stored. The
+  realtime subvolume is designed to provide very deterministic
+  data rates suitable for media streaming applications.
+
+  See the xfs man page in section 5 for a bit more information.
+
+  This feature is unsupported at this time, is not yet fully
+  functional, and may cause serious problems.
+
+  If unsure, say N.
+
diff -uNr -Xdontdiff -p linux-2.5/fs/Config.in linux-2.5-xfs/fs/Config.in
--- linux-2.5/fs/Config.in	Thu Aug 29 22:20:11 2002
+++ linux-2.5-xfs/fs/Config.in	Sat Aug  3 00:06:06 2002
@@ -101,6 +101,13 @@ dep_mbool '  UDF write support (DANGEROU
 tristate 'UFS file system support (read only)' CONFIG_UFS_FS
 dep_mbool '  UFS file system write support (DANGEROUS)' CONFIG_UFS_FS_WRITE $CONFIG_UFS_FS $CONFIG_EXPERIMENTAL
 
+tristate 'XFS filesystem support' CONFIG_XFS_FS
+dep_mbool    '  Realtime support (EXPERIMENTAL)' CONFIG_XFS_RT $CONFIG_XFS_FS $CONFIG_EXPERIMENTAL
+dep_mbool    '  Quota support' CONFIG_XFS_QUOTA $CONFIG_XFS_FS
+if [ "$CONFIG_XFS_QUOTA" = "y" ]; then
+   define_bool CONFIG_QUOTACTL y
+fi
+
 if [ "$CONFIG_NET" = "y" ]; then
 
    mainmenu_option next_comment
diff -uNr -Xdontdiff -p linux-2.5.32/fs/Makefile linux-2.5-xfs/fs/Makefile
--- linux-2.5/fs/Makefile	Thu Aug 29 22:20:11 2002
+++ linux-2.5-xfs/fs/Makefile	Wed Aug 28 02:08:13 2002
@@ -83,5 +83,6 @@ obj-$(CONFIG_ADFS_FS)		+= adfs/
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs/
 obj-$(CONFIG_JFS_FS)		+= jfs/
+obj-$(CONFIG_XFS_FS)		+= xfs/
 
 include $(TOPDIR)/Rules.make
diff -uNr -Xdontdiff -p linux-2.5/include/linux/sched.h linux-2.5-xfs/include/linux/sched.h
--- linux-2.5/include/linux/sched.h	Thu Aug 29 22:21:03 2002
+++ linux-2.5-xfs/include/linux/sched.h	Wed Aug 28 02:08:26 2002
@@ -406,6 +406,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
 #define PF_FROZEN	0x00040000	/* frozen for system suspend */
 #define PF_SYNC		0x00080000	/* performing fsync(), etc */
+#define PF_FSTRANS	0x00100000	/* inside a filesystem transaction */
 
 /*
  * Ptrace flags
diff -uNr -Xdontdiff -p linux-2.5/include/linux/sysctl.h linux-2.5-xfs/include/linux/sysctl.h
--- linux-2.5/include/linux/sysctl.h	Thu Aug 29 22:21:04 2002
+++ linux-2.5-xfs/include/linux/sysctl.h	Thu Aug 29 00:32:22 2002
@@ -150,6 +150,7 @@ enum
 	VM_DIRTY_EXPIRE_CS=15,	/* dirty_expire_centisecs */
 	VM_NR_PDFLUSH_THREADS=16, /* nr_pdflush_threads */
 	VM_OVERCOMMIT_RATIO=17, /* percent of RAM to allow overcommit in */
+	VM_PAGEBUF=18		/* struct: Control pagebuf parameters */
 };
 
 
@@ -553,6 +554,7 @@ enum
 	FS_DIR_NOTIFY=14,	/* int: directory notification enabled */
 	FS_LEASE_TIME=15,	/* int: maximum time to wait for a lease break */
 	FS_DQSTATS=16,	/* disc quota usage statistics */
+	FS_XFS=17,	/* struct: control xfs parameters */
 };
 
 /* /proc/sys/fs/quota/ */
diff -uNr -Xdontdiff -p linux-2.5/kernel/ksyms.c linux-2.5-xfs/kernel/ksyms.c
--- linux-2.5/kernel/ksyms.c	Thu Aug 29 22:21:10 2002
+++ linux-2.5-xfs/kernel/ksyms.c	Wed Aug 28 14:45:24 2002
@@ -278,6 +278,7 @@ EXPORT_SYMBOL(find_lock_page);
 EXPORT_SYMBOL(find_or_create_page);
 EXPORT_SYMBOL(grab_cache_page_nowait);
 EXPORT_SYMBOL(read_cache_page);
+EXPORT_SYMBOL(mark_page_accessed);
 EXPORT_SYMBOL(vfs_readlink);
 EXPORT_SYMBOL(vfs_follow_link);
 EXPORT_SYMBOL(page_readlink);
