Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934423AbWK2IiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934423AbWK2IiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 03:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758803AbWK2IiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 03:38:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5640 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758799AbWK2IiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 03:38:13 -0500
Date: Wed, 29 Nov 2006 09:38:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/sysv/: doc cleanup
Message-ID: <20061129083817.GD11084@stusta.de>
References: <20061129082019.GB11084@stusta.de> <20061129082536.GA12734@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129082536.GA12734@infradead.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 08:25:36AM +0000, Christoph Hellwig wrote:
> On Wed, Nov 29, 2006 at 09:20:19AM +0100, Adrian Bunk wrote:
> > This patch removes two different changelog files from fs/sysv/ and moves 
> > the INTRO file to Documentation/filesystems/sysv-fs-intro.txt
> 
> ACK on removing the changlogs.
> NACK on moving the INTO file.  It should be merged into
> Documentation/filesystems/sysv-fs.txt, creating a single document instead.

Updated patch below.

cu
Adrian


<--  snip  -->


This patch removes two different changelog files from fs/sysv/ and 
merges the INTRO file into Documentation/filesystems/sysv-fs.txt

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/filesystems/sysv-fs.txt |  177 ++++++++++++++++++++++++-
 fs/sysv/CHANGES                       |   60 --------
 fs/sysv/ChangeLog                     |  106 ---------------
 fs/sysv/INTRO                         |  182 --------------------------
 4 files changed, 168 insertions(+), 357 deletions(-)

--- linux-2.6.19-rc6-mm2/Documentation/filesystems/sysv-fs.txt.old	2006-11-29 09:34:23.000000000 +0100
+++ linux-2.6.19-rc6-mm2/Documentation/filesystems/sysv-fs.txt	2006-11-29 09:36:00.000000000 +0100
@@ -1,11 +1,8 @@
-This is the implementation of the SystemV/Coherent filesystem for Linux.
 It implements all of
   - Xenix FS,
   - SystemV/386 FS,
   - Coherent FS.
 
-This is version beta 4.
-
 To install:
 * Answer the 'System V and Coherent filesystem support' question with 'y'
   when configuring the kernel.
@@ -28,11 +25,173 @@
   for this FS on hard disk yet.
 
 
-Please report any bugs and suggestions to
-  Bruno Haible <haible@ma2s2.mathematik.uni-karlsruhe.de>
-  Pascal Haible <haible@izfm.uni-stuttgart.de>
-  Krzysztof G. Baranowski <kgb@manjak.knm.org.pl>
+These filesystems are rather similar. Here is a comparison with Minix FS:
+
+* Linux fdisk reports on partitions
+  - Minix FS     0x81 Linux/Minix
+  - Xenix FS     ??
+  - SystemV FS   ??
+  - Coherent FS  0x08 AIX bootable
+
+* Size of a block or zone (data allocation unit on disk)
+  - Minix FS     1024
+  - Xenix FS     1024 (also 512 ??)
+  - SystemV FS   1024 (also 512 and 2048)
+  - Coherent FS   512
+
+* General layout: all have one boot block, one super block and
+  separate areas for inodes and for directories/data.
+  On SystemV Release 2 FS (e.g. Microport) the first track is reserved and
+  all the block numbers (including the super block) are offset by one track.
+
+* Byte ordering of "short" (16 bit entities) on disk:
+  - Minix FS     little endian  0 1
+  - Xenix FS     little endian  0 1
+  - SystemV FS   little endian  0 1
+  - Coherent FS  little endian  0 1
+  Of course, this affects only the file system, not the data of files on it!
+
+* Byte ordering of "long" (32 bit entities) on disk:
+  - Minix FS     little endian  0 1 2 3
+  - Xenix FS     little endian  0 1 2 3
+  - SystemV FS   little endian  0 1 2 3
+  - Coherent FS  PDP-11         2 3 0 1
+  Of course, this affects only the file system, not the data of files on it!
+
+* Inode on disk: "short", 0 means non-existent, the root dir ino is:
+  - Minix FS                            1
+  - Xenix FS, SystemV FS, Coherent FS   2
+
+* Maximum number of hard links to a file:
+  - Minix FS     250
+  - Xenix FS     ??
+  - SystemV FS   ??
+  - Coherent FS  >=10000
+
+* Free inode management:
+  - Minix FS                             a bitmap
+  - Xenix FS, SystemV FS, Coherent FS
+      There is a cache of a certain number of free inodes in the super-block.
+      When it is exhausted, new free inodes are found using a linear search.
+
+* Free block management:
+  - Minix FS                             a bitmap
+  - Xenix FS, SystemV FS, Coherent FS
+      Free blocks are organized in a "free list". Maybe a misleading term,
+      since it is not true that every free block contains a pointer to
+      the next free block. Rather, the free blocks are organized in chunks
+      of limited size, and every now and then a free block contains pointers
+      to the free blocks pertaining to the next chunk; the first of these
+      contains pointers and so on. The list terminates with a "block number"
+      0 on Xenix FS and SystemV FS, with a block zeroed out on Coherent FS.
+
+* Super-block location:
+  - Minix FS     block 1 = bytes 1024..2047
+  - Xenix FS     block 1 = bytes 1024..2047
+  - SystemV FS   bytes 512..1023
+  - Coherent FS  block 1 = bytes 512..1023
+
+* Super-block layout:
+  - Minix FS
+                    unsigned short s_ninodes;
+                    unsigned short s_nzones;
+                    unsigned short s_imap_blocks;
+                    unsigned short s_zmap_blocks;
+                    unsigned short s_firstdatazone;
+                    unsigned short s_log_zone_size;
+                    unsigned long s_max_size;
+                    unsigned short s_magic;
+  - Xenix FS, SystemV FS, Coherent FS
+                    unsigned short s_firstdatazone;
+                    unsigned long  s_nzones;
+                    unsigned short s_fzone_count;
+                    unsigned long  s_fzones[NICFREE];
+                    unsigned short s_finode_count;
+                    unsigned short s_finodes[NICINOD];
+                    char           s_flock;
+                    char           s_ilock;
+                    char           s_modified;
+                    char           s_rdonly;
+                    unsigned long  s_time;
+                    short          s_dinfo[4]; -- SystemV FS only
+                    unsigned long  s_free_zones;
+                    unsigned short s_free_inodes;
+                    short          s_dinfo[4]; -- Xenix FS only
+                    unsigned short s_interleave_m,s_interleave_n; -- Coherent FS only
+                    char           s_fname[6];
+                    char           s_fpack[6];
+    then they differ considerably:
+        Xenix FS
+                    char           s_clean;
+                    char           s_fill[371];
+                    long           s_magic;
+                    long           s_type;
+        SystemV FS
+                    long           s_fill[12 or 14];
+                    long           s_state;
+                    long           s_magic;
+                    long           s_type;
+        Coherent FS
+                    unsigned long  s_unique;
+    Note that Coherent FS has no magic.
+
+* Inode layout:
+  - Minix FS
+                    unsigned short i_mode;
+                    unsigned short i_uid;
+                    unsigned long  i_size;
+                    unsigned long  i_time;
+                    unsigned char  i_gid;
+                    unsigned char  i_nlinks;
+                    unsigned short i_zone[7+1+1];
+  - Xenix FS, SystemV FS, Coherent FS
+                    unsigned short i_mode;
+                    unsigned short i_nlink;
+                    unsigned short i_uid;
+                    unsigned short i_gid;
+                    unsigned long  i_size;
+                    unsigned char  i_zone[3*(10+1+1+1)];
+                    unsigned long  i_atime;
+                    unsigned long  i_mtime;
+                    unsigned long  i_ctime;
+
+* Regular file data blocks are organized as
+  - Minix FS
+               7 direct blocks
+               1 indirect block (pointers to blocks)
+               1 double-indirect block (pointer to pointers to blocks)
+  - Xenix FS, SystemV FS, Coherent FS
+              10 direct blocks
+               1 indirect block (pointers to blocks)
+               1 double-indirect block (pointer to pointers to blocks)
+               1 triple-indirect block (pointer to pointers to pointers to blocks)
+
+* Inode size, inodes per block
+  - Minix FS        32   32
+  - Xenix FS        64   16
+  - SystemV FS      64   16
+  - Coherent FS     64    8
+
+* Directory entry on disk
+  - Minix FS
+                    unsigned short inode;
+                    char name[14/30];
+  - Xenix FS, SystemV FS, Coherent FS
+                    unsigned short inode;
+                    char name[14];
+
+* Dir entry size, dir entries per block
+  - Minix FS     16/32    64/32
+  - Xenix FS     16       64
+  - SystemV FS   16       64
+  - Coherent FS  16       32
+
+* How to implement symbolic links such that the host fsck doesn't scream:
+  - Minix FS     normal
+  - Xenix FS     kludge: as regular files with  chmod 1000
+  - SystemV FS   ??
+  - Coherent FS  kludge: as regular files with  chmod 1000
 
-Bruno Haible
-<haible@ma2s2.mathematik.uni-karlsruhe.de>
 
+Notation: We often speak of a "block" but mean a zone (the allocation unit)
+and not the disk driver's notion of "block".
--- linux-2.6.19-rc6-mm2/fs/sysv/CHANGES	2006-09-20 05:42:06.000000000 +0200
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,60 +0,0 @@
-Mon, 15 Dec 1997	  Krzysztof G. Baranowski <kgb@manjak.knm.org.pl>
-	*    namei.c: struct sysv_dir_inode_operations updated to use dentries.
-
-Fri, 23 Jan 1998   Krzysztof G. Baranowski <kgb@manjak.knm.org.pl>
-	*    inode.c: corrected 1 track offset setting (in sb->sv_block_base).
-		      Originally it was overridden (by setting to zero)
-		      in detected_[xenix,sysv4,sysv2,coherent]. Thanks
-		      to Andrzej Krzysztofowicz <ankry@mif.pg.gda.pl>
-		      for identifying the problem.
-
-Tue, 27 Jan 1998   Krzysztof G. Baranowski <kgb@manjak.knm.org.pl>
-        *    inode.c: added 2048-byte block support to SystemV FS.
-		      Merged detected_bs[512,1024,2048]() into one function:
-		      void detected_bs (u_char type, struct super_block *sb).
-		      Thanks to Andrzej Krzysztofowicz <ankry@mif.pg.gda.pl>
-		      for the patch.
-
-Wed, 4 Feb 1998   Krzysztof G. Baranowski <kgb@manjak.knm.org.pl>
-	*    namei.c: removed static subdir(); is_subdir() from dcache.c
-		      is used instead. Cosmetic changes.
-
-Thu, 3 Dec 1998   Al Viro (viro@parcelfarce.linux.theplanet.co.uk)
-	*    namei.c (sysv_rmdir):
-		      Bugectomy: old check for victim being busy
-		      (inode->i_count) wasn't replaced (with checking
-		      dentry->d_count) and escaped Linus in the last round
-		      of changes. Shot and buried.
-
-Wed, 9 Dec 1998   AV
-	*    namei.c (do_sysv_rename):
-		       Fixed incorrect check for other owners + race.
-		       Removed checks that went to VFS.
-	*    namei.c (sysv_unlink):
-		       Removed checks that went to VFS.
-
-Thu, 10 Dec 1998   AV
-	*    namei.c (do_mknod):
-			Removed dead code - mknod is never asked to
-			create a symlink or directory. Incidentially,
-			it wouldn't do it right if it would be called.
-
-Sat, 26 Dec 1998   KGB
-	*    inode.c (detect_sysv4):
-			Added detection of expanded s_type field (0x10,
-			0x20 and 0x30).  Forced read-only access in this case.
-
-Sun, 21 Mar 1999   AV
-	*    namei.c (sysv_link):
-			Fixed i_count usage that resulted in dcache corruption.
-	*    inode.c:
-			Filled ->delete_inode() method with sysv_delete_inode().
-			sysv_put_inode() is gone, as it tried to do ->delete_
-			_inode()'s job.
-	*    ialloc.c: (sysv_free_inode):
-			Fixed race.
-
-Sun, 30 Apr 1999   AV
-	*    namei.c (sysv_mknod):
-			Removed dead code (S_IFREG case is now passed to
-			->create() by VFS).
--- linux-2.6.19-rc6-mm2/fs/sysv/ChangeLog	2006-09-20 05:42:06.000000000 +0200
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,106 +0,0 @@
-Thu Feb 14 2002  Andrew Morton  <akpm@zip.com.au>
-
-	* dir_commit_chunk(): call writeout_one_page() as well as
-	  waitfor_one_page() for IS_SYNC directories, so that we
-	  actually do sync the directory. (forward-port from 2.4).
-
-Thu Feb  7 2002  Alexander Viro  <viro@parcelfarce.linux.theplanet.co.uk>
-
-	* super.c: switched to ->get_sb()
-	* ChangeLog: fixed dates ;-)
-
-2002-01-24  David S. Miller  <davem@redhat.com>
-
-	* inode.c: Include linux/init.h
-
-Mon Jan 21 2002  Alexander Viro  <viro@parcelfarce.linux.theplanet.co.uk>
-	* ialloc.c (sysv_new_inode): zero SYSV_I(inode)->i_data out.
-	* i_vnode renamed to vfs_inode.  Sorry, but let's keep that
-	  consistent.
-
-Sat Jan 19 2002  Christoph Hellwig  <hch@infradead.org>
-
-	* include/linux/sysv_fs.h (SYSV_I): Get fs-private inode data using
-		list_entry() instead of inode->u.
-	* include/linux/sysv_fs_i.h: Add 'struct inode  i_vnode' field to
-		sysv_inode_info structure.
-	* inode.c: Include <linux/slab.h>, implement alloc_inode/destroy_inode
-		sop methods, add infrastructure for per-fs inode slab cache.
-	* super.c (init_sysv_fs): Initialize inode cache, recover properly
-		in the case of failed register_filesystem for V7.
-	(exit_sysv_fs): Destroy inode cache.
-
-Sat Jan 19 2002  Christoph Hellwig  <hch@infradead.org>
-
-	* include/linux/sysv_fs.h: Include <linux/sysv_fs_i.h>, declare SYSV_I().
-	* dir.c (sysv_find_entry): Use SYSV_I() instead of ->u.sysv_i to
-		access fs-private inode data.
-	* ialloc.c (sysv_new_inode): Likewise.
-	* inode.c (sysv_read_inode): Likewise.
-	(sysv_update_inode): Likewise.
-	* itree.c (get_branch): Likewise.
-	(sysv_truncate): Likewise.
-	* symlink.c (sysv_readlink): Likewise.
-	(sysv_follow_link): Likewise.
-
-Fri Jan  4 2002  Alexander Viro  <viro@parcelfarce.linux.theplanet.co.uk>
-
-	* ialloc.c (sysv_free_inode): Use sb->s_id instead of bdevname().
-	* inode.c (sysv_read_inode): Likewise.
-	  (sysv_update_inode): Likewise.
-	  (sysv_sync_inode): Likewise.
-	* super.c (detect_sysv): Likewise.
-	  (complete_read_super): Likewise.
-	  (sysv_read_super): Likewise.
-	  (v7_read_super): Likewise.
-
-Sun Dec 30 2001  Manfred Spraul  <manfred@colorfullife.com>
-
-	* dir.c (dir_commit_chunk): Do not set dir->i_version.
-	(sysv_readdir): Likewise.
-
-Thu Dec 27 2001  Alexander Viro  <viro@parcelfarce.linux.theplanet.co.uk>
-
-	* itree.c (get_block): Use map_bh() to fill out bh_result.
-
-Tue Dec 25 2001  Alexander Viro  <viro@parcelfarce.linux.theplanet.co.uk>
-
-	* super.c (sysv_read_super): Use sb_set_blocksize() to set blocksize.
-	  (v7_read_super): Likewise.
-
-Tue Nov 27 2001  Alexander Viro  <viro@parcelfarce.linux.theplanet.co.uk>
-
-	* itree.c (get_block): Change type for iblock argument to sector_t.
-	* super.c (sysv_read_super): Set s_blocksize early.
-	  (v7_read_super): Likewise.
-	* balloc.c (sysv_new_block): Use sb_bread(). instead of bread().
-	  (sysv_count_free_blocks): Likewise.
-	* ialloc.c (sysv_raw_inode): Likewise.
-	* itree.c (get_branch): Likewise.
-	  (free_branches): Likewise.
-	* super.c (sysv_read_super): Likewise.
-	  (v7_read_super): Likewise.
-
-Sat Dec 15 2001  Christoph Hellwig  <hch@infradead.org>
-
-	* inode.c (sysv_read_inode): Mark inode as bad in case of failure.
-	* super.c (complete_read_super): Check for bad root inode.
-
-Wed Nov 21 2001  Andrew Morton  <andrewm@uow.edu.au>
-
-	* file.c (sysv_sync_file): Call fsync_inode_data_buffers.
-
-Fri Oct 26 2001  Christoph Hellwig  <hch@infradead.org>
-
-	* dir.c, ialloc.c, namei.c, include/linux/sysv_fs_i.h:
-	Implement per-Inode lookup offset cache.
-	Modelled after Ted's ext2 patch.
-
-Fri Oct 26 2001  Christoph Hellwig  <hch@infradead.org>
-
-	* inode.c, super.c, include/linux/sysv_fs.h,
-	  include/linux/sysv_fs_sb.h:
-	Remove symlink faking.	Noone really wants to use these as
-	linux filesystems and native OSes don't support it anyway.
-
-
--- linux-2.6.19-rc6-mm2/fs/sysv/INTRO	2006-09-20 05:42:06.000000000 +0200
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,182 +0,0 @@
-This is the implementation of the SystemV/Coherent filesystem for Linux.
-It grew out of separate filesystem implementations
-
-    Xenix FS      Doug Evans <dje@cygnus.com>  June 1992
-    SystemV FS    Paul B. Monday <pmonday@eecs.wsu.edu> March-June 1993
-    Coherent FS   B. Haible <haible@ma2s2.mathematik.uni-karlsruhe.de> June 1993
-
-and was merged together in July 1993.
-
-These filesystems are rather similar. Here is a comparison with Minix FS:
-
-* Linux fdisk reports on partitions
-  - Minix FS     0x81 Linux/Minix
-  - Xenix FS     ??
-  - SystemV FS   ??
-  - Coherent FS  0x08 AIX bootable
-
-* Size of a block or zone (data allocation unit on disk)
-  - Minix FS     1024
-  - Xenix FS     1024 (also 512 ??)
-  - SystemV FS   1024 (also 512 and 2048)
-  - Coherent FS   512
-
-* General layout: all have one boot block, one super block and
-  separate areas for inodes and for directories/data.
-  On SystemV Release 2 FS (e.g. Microport) the first track is reserved and
-  all the block numbers (including the super block) are offset by one track.
-
-* Byte ordering of "short" (16 bit entities) on disk:
-  - Minix FS     little endian  0 1
-  - Xenix FS     little endian  0 1
-  - SystemV FS   little endian  0 1
-  - Coherent FS  little endian  0 1
-  Of course, this affects only the file system, not the data of files on it!
-
-* Byte ordering of "long" (32 bit entities) on disk:
-  - Minix FS     little endian  0 1 2 3
-  - Xenix FS     little endian  0 1 2 3
-  - SystemV FS   little endian  0 1 2 3
-  - Coherent FS  PDP-11         2 3 0 1
-  Of course, this affects only the file system, not the data of files on it!
-
-* Inode on disk: "short", 0 means non-existent, the root dir ino is:
-  - Minix FS                            1
-  - Xenix FS, SystemV FS, Coherent FS   2
-
-* Maximum number of hard links to a file:
-  - Minix FS     250
-  - Xenix FS     ??
-  - SystemV FS   ??
-  - Coherent FS  >=10000
-
-* Free inode management:
-  - Minix FS                             a bitmap
-  - Xenix FS, SystemV FS, Coherent FS
-      There is a cache of a certain number of free inodes in the super-block.
-      When it is exhausted, new free inodes are found using a linear search.
-
-* Free block management:
-  - Minix FS                             a bitmap
-  - Xenix FS, SystemV FS, Coherent FS
-      Free blocks are organized in a "free list". Maybe a misleading term,
-      since it is not true that every free block contains a pointer to
-      the next free block. Rather, the free blocks are organized in chunks
-      of limited size, and every now and then a free block contains pointers
-      to the free blocks pertaining to the next chunk; the first of these
-      contains pointers and so on. The list terminates with a "block number"
-      0 on Xenix FS and SystemV FS, with a block zeroed out on Coherent FS.
-
-* Super-block location:
-  - Minix FS     block 1 = bytes 1024..2047
-  - Xenix FS     block 1 = bytes 1024..2047
-  - SystemV FS   bytes 512..1023
-  - Coherent FS  block 1 = bytes 512..1023
-
-* Super-block layout:
-  - Minix FS
-                    unsigned short s_ninodes;
-                    unsigned short s_nzones;
-                    unsigned short s_imap_blocks;
-                    unsigned short s_zmap_blocks;
-                    unsigned short s_firstdatazone;
-                    unsigned short s_log_zone_size;
-                    unsigned long s_max_size;
-                    unsigned short s_magic;
-  - Xenix FS, SystemV FS, Coherent FS
-                    unsigned short s_firstdatazone;
-                    unsigned long  s_nzones;
-                    unsigned short s_fzone_count;
-                    unsigned long  s_fzones[NICFREE];
-                    unsigned short s_finode_count;
-                    unsigned short s_finodes[NICINOD];
-                    char           s_flock;
-                    char           s_ilock;
-                    char           s_modified;
-                    char           s_rdonly;
-                    unsigned long  s_time;
-                    short          s_dinfo[4]; -- SystemV FS only
-                    unsigned long  s_free_zones;
-                    unsigned short s_free_inodes;
-                    short          s_dinfo[4]; -- Xenix FS only
-                    unsigned short s_interleave_m,s_interleave_n; -- Coherent FS only
-                    char           s_fname[6];
-                    char           s_fpack[6];
-    then they differ considerably:
-        Xenix FS
-                    char           s_clean;
-                    char           s_fill[371];
-                    long           s_magic;
-                    long           s_type;
-        SystemV FS
-                    long           s_fill[12 or 14];
-                    long           s_state;
-                    long           s_magic;
-                    long           s_type;
-        Coherent FS
-                    unsigned long  s_unique;
-    Note that Coherent FS has no magic.
-
-* Inode layout:
-  - Minix FS
-                    unsigned short i_mode;
-                    unsigned short i_uid;
-                    unsigned long  i_size;
-                    unsigned long  i_time;
-                    unsigned char  i_gid;
-                    unsigned char  i_nlinks;
-                    unsigned short i_zone[7+1+1];
-  - Xenix FS, SystemV FS, Coherent FS
-                    unsigned short i_mode;
-                    unsigned short i_nlink;
-                    unsigned short i_uid;
-                    unsigned short i_gid;
-                    unsigned long  i_size;
-                    unsigned char  i_zone[3*(10+1+1+1)];
-                    unsigned long  i_atime;
-                    unsigned long  i_mtime;
-                    unsigned long  i_ctime;
-
-* Regular file data blocks are organized as
-  - Minix FS
-               7 direct blocks
-               1 indirect block (pointers to blocks)
-               1 double-indirect block (pointer to pointers to blocks)
-  - Xenix FS, SystemV FS, Coherent FS
-              10 direct blocks
-               1 indirect block (pointers to blocks)
-               1 double-indirect block (pointer to pointers to blocks)
-               1 triple-indirect block (pointer to pointers to pointers to blocks)
-
-* Inode size, inodes per block
-  - Minix FS        32   32
-  - Xenix FS        64   16
-  - SystemV FS      64   16
-  - Coherent FS     64    8
-
-* Directory entry on disk
-  - Minix FS
-                    unsigned short inode;
-                    char name[14/30];
-  - Xenix FS, SystemV FS, Coherent FS
-                    unsigned short inode;
-                    char name[14];
-
-* Dir entry size, dir entries per block
-  - Minix FS     16/32    64/32
-  - Xenix FS     16       64
-  - SystemV FS   16       64
-  - Coherent FS  16       32
-
-* How to implement symbolic links such that the host fsck doesn't scream:
-  - Minix FS     normal
-  - Xenix FS     kludge: as regular files with  chmod 1000
-  - SystemV FS   ??
-  - Coherent FS  kludge: as regular files with  chmod 1000
-
-
-Notation: We often speak of a "block" but mean a zone (the allocation unit)
-and not the disk driver's notion of "block".
-
-
-Bruno Haible  <haible@ma2s2.mathematik.uni-karlsruhe.de>

