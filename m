Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266236AbSKLG0Z>; Tue, 12 Nov 2002 01:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266237AbSKLG0Z>; Tue, 12 Nov 2002 01:26:25 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:11410 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S266236AbSKLG0X>;
	Tue, 12 Nov 2002 01:26:23 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [1/4]: Ext2/3 updates: Fix/simplify alternate superblock logic
From: tytso@mit.edu
Message-Id: <E18BUbn-0005ix-00@snap.thunk.org>
Date: Tue, 12 Nov 2002 01:33:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix/simplify alternate superblock logic

Fix bugs when specifying an alternate superblock as a mount option; not 
all of the cases where a alternate sb was specified and a block device
whose hardware blocksize was not 1024 worked correctly (and the failure
mode was different for ext2 and ext3).  The code has been tightened up
and simplified, so that it is right in all of the permutations of these 
cases.


ext2/super.c |   12 +++++-------
ext3/super.c |   10 ++++------
2 files changed, 9 insertions(+), 13 deletions(-)

diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Tue Nov 12 01:12:15 2002
+++ b/fs/ext2/super.c	Tue Nov 12 01:12:15 2002
@@ -548,9 +548,9 @@
 	struct buffer_head * bh;
 	struct ext2_sb_info * sbi;
 	struct ext2_super_block * es;
-	unsigned long block, sb_block = 1;
-	unsigned long logic_sb_block = get_sb_block(&data);
-	unsigned long offset = 0;
+	unsigned long block, sb_block = get_sb_block(&data);
+	unsigned long logic_sb_block;
+	unsigned long offset;
 	unsigned long def_mount_opts;
 	int blocksize = BLOCK_SIZE;
 	int db_count;
@@ -579,10 +579,8 @@
 	 * If the superblock doesn't start on a hardware sector boundary,
 	 * calculate the offset.  
 	 */
-	if (blocksize != BLOCK_SIZE) {
-		logic_sb_block = (sb_block*BLOCK_SIZE) / blocksize;
-		offset = (sb_block*BLOCK_SIZE) % blocksize;
-	}
+	logic_sb_block = (sb_block*BLOCK_SIZE) / blocksize;
+	offset = (sb_block*BLOCK_SIZE) % blocksize;
 
 	if (!(bh = sb_bread(sb, logic_sb_block))) {
 		printk ("EXT2-fs: unable to read superblock\n");
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Tue Nov 12 01:12:15 2002
+++ b/fs/ext3/super.c	Tue Nov 12 01:12:15 2002
@@ -1000,8 +1000,8 @@
 	struct ext3_super_block *es = 0;
 	struct ext3_sb_info *sbi;
 	unsigned long sb_block = get_sb_block(&data);
-	unsigned long block, logic_sb_block = 1;
-	unsigned long offset = 0;
+	unsigned long block, logic_sb_block;
+	unsigned long offset;
 	unsigned long journal_inum = 0;
 	unsigned long def_mount_opts;
 	int blocksize;
@@ -1033,10 +1033,8 @@
 	 * The ext3 superblock will not be buffer aligned for other than 1kB
 	 * block sizes.  We need to calculate the offset from buffer start.
 	 */
-	if (blocksize != EXT3_MIN_BLOCK_SIZE) {
-		logic_sb_block = (sb_block * EXT3_MIN_BLOCK_SIZE) / blocksize;
-		offset = (sb_block * EXT3_MIN_BLOCK_SIZE) % blocksize;
-	}
+	logic_sb_block = (sb_block * EXT3_MIN_BLOCK_SIZE) / blocksize;
+	offset = (sb_block * EXT3_MIN_BLOCK_SIZE) % blocksize;
 
 	if (!(bh = sb_bread(sb, logic_sb_block))) {
 		printk (KERN_ERR "EXT3-fs: unable to read superblock\n");
