Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752081AbWIHEL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbWIHEL5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 00:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbWIHEL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 00:11:57 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:33971 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1752084AbWIHELy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 00:11:54 -0400
To: cmm@us.ibm.com, adilger@clusterfs.com, johann.lombardi@bull.net
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][1/4] ext2/3/4: enlarge blocksize
Message-Id: <20060908131144sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Fri, 8 Sep 2006 13:11:44 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On July 7, 2006, sho wrote:
> On Jun 29, 2006, Andreas wrote:
> > On Jun 28, 2006  17:50 +0200, Johann Lombardi wrote:
> > ext2/ext3_dir_entry_2 has a 16-bit entry(rec_len) and it 
> > would overflow
> > with 64KB blocksize.  This patch prevent from overflow by limiting
> > rec_len to 65532.
> > Having a max rec_len of 65532 is rather unfortunate, since the dir
> > blocks always need to filled with dir entries.  65536 - 65532 = 4,
> > and the minimum ext3_dir_entry size is 8 bytes.  I would instead
> > make this maybe 64 bytes less so that there is room for a filename
> > in the "tail" dir_entry.
>
> The fix, adding dummy entry at the tail of a directory block, needs
> to regenerate dummy entry when all of the entries are removed in
> kernel.
> While in e2fsprogs, e2fsck needs to do the same when destroyed by
> some reason.  Thus procedures get more complicated.
> Then I updated the patch to limit rec_len to 65532(64K - 4).  The
> difference from the previous patch is that the end of a directory
> block is changed to 65532(64K - 4) with 64K blocksize.
> This is more simple and less tweaky.  This necessarily makes 4-bytes
> from the end of a directory block useless, but 4-bytes is negligible
> compared to 64KB, who cares?

In response to Mingming's ext4 patches, I updated my patches.
These patches support large blocksize up to PAGESIZE (max 64KB).
NOTE:
They limit the end of a directory block to 65532(64K - 4)
to avoid overflow only when using 64KB block.

The difference from the previous patches is as follows.
- add ext4 support

This patch applies on top of Mingming's patches(against ext3dev-2.6.18-
rc4.patch) which were posted at:
	http://ext2.sourceforge.net/48bitext3/patches/latest/

Through mke2fs, ".." entry of root directory is supposed to have rec_len
which is equal to blocksize.  So just to fix kernel ends up occurring
the error in ext2_check_page() etc, if 64KB blocksize.  Thus I tested
with the provisional fix against e2fsprogs.  This patch doesn't include
that fix.

I tested I/O performance with 4K-64K blocksize on ext3.

my box:
  models       :NX-7700i
  CPU type     :Itanium2
  number of CPU:1
  architecture :ia64
  memory size  :8309152KB
  disk size    :70007.196(MB)

Results:
          blocksize    Read(MB/sec)    Write(MB/sec)
              4K          58.2            59.7
              8K          64.3            60.7
             16K          66.8            62.2
             32K          65.3            60.2
             64K          65.4            60.4

I don't know why 16K-blocksize marks the highest numbers.  But
without this patch, >4KB blocksize can't be used at least :)

The Patch-set consists of the following 4 patches.
  [1/4]  ext2/3/4: enlarge blocksize
         - Allow blocksize up to pagesize

  [2/4]  ext2: fix rec_len overflow
         - prevent rec_len from overflow with 64KB blocksize

  [3/4]  ext3: fix rec_len overflow
         - ditto

  [4/4]  ext4: fix rec_len overflow
         - ditto


Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.18-rc4-mingming/Documentation/dontdiff linux-2.6.18-rc4-mingming/fs/ext2/super.c linux-2.6.18-rc4-mingming-tnes/fs/ext2/super.c
--- linux-2.6.18-rc4-mingming/fs/ext2/super.c	2006-08-07 03:20:11.000000000 +0900
+++ linux-2.6.18-rc4-mingming-tnes/fs/ext2/super.c	2006-09-08 09:00:40.000000000 +0900
@@ -725,7 +725,7 @@ static int ext2_fill_super(struct super_
 		brelse(bh);
 
 		if (!sb_set_blocksize(sb, blocksize)) {
-			printk(KERN_ERR "EXT2-fs: blocksize too small for device.\n");
+			printk(KERN_ERR "EXT2-fs: bad blocksize %d.\n", blocksize);
 			goto failed_sbi;
 		}

diff -upNr -X linux-2.6.18-rc4-mingming/Documentation/dontdiff linux-2.6.18-rc4-mingming/fs/ext3/super.c linux-2.6.18-rc4-mingming-tnes/fs/ext3/super.c
--- linux-2.6.18-rc4-mingming/fs/ext3/super.c	2006-08-07 03:20:11.000000000 +0900
+++ linux-2.6.18-rc4-mingming-tnes/fs/ext3/super.c	2006-09-08 09:00:02.000000000 +0900
@@ -1486,7 +1486,10 @@ static int ext3_fill_super (struct super
 		}
 
 		brelse (bh);
-		sb_set_blocksize(sb, blocksize);
+		if (!sb_set_blocksize(sb, blocksize)) {
+			printk(KERN_ERR "EXT3-fs: bad blocksize %d.\n", blocksize);
+			goto out_fail;
+		}
 		logic_sb_block = (sb_block * EXT3_MIN_BLOCK_SIZE) / blocksize;
 		offset = (sb_block * EXT3_MIN_BLOCK_SIZE) % blocksize;
 		bh = sb_bread(sb, logic_sb_block);
diff -upNr -X linux-2.6.18-rc4-mingming/Documentation/dontdiff linux-2.6.18-rc4-mingming/fs/ext4/super.c linux-2.6.18-rc4-mingming-tnes/fs/ext4/super.c
--- linux-2.6.18-rc4-mingming/fs/ext4/super.c	2006-08-29 16:29:05.000000000 +0900
+++ linux-2.6.18-rc4-mingming-tnes/fs/ext4/super.c	2006-09-08 09:00:45.000000000 +0900
@@ -1497,7 +1497,10 @@ static int ext4_fill_super (struct super
 		}
 
 		brelse (bh);
-		sb_set_blocksize(sb, blocksize);
+		if (!sb_set_blocksize(sb, blocksize)) {
+			printk(KERN_ERR "EXT4-fs: bad blocksize %d.\n", blocksize);
+			goto out_fail;
+		}
 		logic_sb_block = sb_block * EXT4_MIN_BLOCK_SIZE;
 		offset = sector_div(logic_sb_block, blocksize);
 		bh = sb_bread(sb, logic_sb_block);
diff -upNr -X linux-2.6.18-rc4-mingming/Documentation/dontdiff linux-2.6.18-rc4-mingming/include/linux/ext2_fs.h linux-2.6.18-rc4-mingming-tnes-no_compile/include/linux/ext2_fs.h
--- linux-2.6.18-rc4-mingming/include/linux/ext2_fs.h	2006-08-07 03:20:11.000000000 +0900
+++ linux-2.6.18-rc4-mingming-tnes-no_compile/include/linux/ext2_fs.h	2006-09-04 11:26:26.000000000 +0900
@@ -90,8 +90,8 @@ static inline struct ext2_sb_info *EXT2_
  * Macro-instructions used to manage several block sizes
  */
 #define EXT2_MIN_BLOCK_SIZE		1024
-#define	EXT2_MAX_BLOCK_SIZE		4096
-#define EXT2_MIN_BLOCK_LOG_SIZE		  10
+#define EXT2_MAX_BLOCK_SIZE		65536
+#define EXT2_MIN_BLOCK_LOG_SIZE		10
 #ifdef __KERNEL__
 # define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
 #else
diff -upNr -X linux-2.6.18-rc4-mingming/Documentation/dontdiff linux-2.6.18-rc4-mingming/include/linux/ext3_fs.h linux-2.6.18-rc4-mingming-tnes-no_compile/include/linux/ext3_fs.h
--- linux-2.6.18-rc4-mingming/include/linux/ext3_fs.h	2006-08-07 03:20:11.000000000 +0900
+++ linux-2.6.18-rc4-mingming-tnes-no_compile/include/linux/ext3_fs.h	2006-09-04 11:26:51.000000000 +0900
@@ -80,8 +80,8 @@
  * Macro-instructions used to manage several block sizes
  */
 #define EXT3_MIN_BLOCK_SIZE		1024
-#define	EXT3_MAX_BLOCK_SIZE		4096
-#define EXT3_MIN_BLOCK_LOG_SIZE		  10
+#define	EXT3_MAX_BLOCK_SIZE		65536
+#define EXT3_MIN_BLOCK_LOG_SIZE		10
 #ifdef __KERNEL__
 # define EXT3_BLOCK_SIZE(s)		((s)->s_blocksize)
 #else
diff -upNr -X linux-2.6.18-rc4-mingming/Documentation/dontdiff linux-2.6.18-rc4-mingming/include/linux/ext4_fs.h linux-2.6.18-rc4-mingming-tnes-no_compile/include/linux/ext4_fs.h
--- linux-2.6.18-rc4-mingming/include/linux/ext4_fs.h	2006-08-29 16:29:05.000000000 +0900
+++ linux-2.6.18-rc4-mingming-tnes-no_compile/include/linux/ext4_fs.h	2006-09-04 11:27:13.000000000 +0900
@@ -81,8 +81,8 @@
  * Macro-instructions used to manage several block sizes
  */
 #define EXT4_MIN_BLOCK_SIZE		1024
-#define	EXT4_MAX_BLOCK_SIZE		4096
-#define EXT4_MIN_BLOCK_LOG_SIZE		  10
+#define	EXT4_MAX_BLOCK_SIZE		65536
+#define EXT4_MIN_BLOCK_LOG_SIZE		10
 #ifdef __KERNEL__
 # define EXT4_BLOCK_SIZE(s)		((s)->s_blocksize)
 #else


Cheers, sho
