Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVHDOYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVHDOYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVHDOWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:22:21 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:55314 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261849AbVHDOVj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:21:39 -0400
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Speedup FAT filesystem directory reads
References: <200508040333.44935.annabellesgarden@yahoo.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 04 Aug 2005 23:21:24 +0900
In-Reply-To: <200508040333.44935.annabellesgarden@yahoo.de> (Karsten Wiese's message of "Thu, 4 Aug 2005 03:33:44 +0200")
Message-ID: <87wtn1ail7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Wiese <annabellesgarden@yahoo.de> writes:

> Please give this a try and commit to -mm or mainline, if approved.

Looks good. Thanks.  However, I tweaked the patch.

    - replace __getblk() to sb_getblk()
    - exclude root-dir of FAT12/FAT16 from readahead
    - exclude (sec_per_clus == 1) from readahead
    - move the all readahead stuff to one inline function

What do you think of the following patch?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff -puN fs/fat/dir.c~fat-sb_breadahead fs/fat/dir.c
--- linux-2.6.13-rc4/fs/fat/dir.c~fat-sb_breadahead	2005-08-04 21:21:59.000000000 +0900
+++ linux-2.6.13-rc4-hirofumi/fs/fat/dir.c	2005-08-04 23:05:58.000000000 +0900
@@ -30,6 +30,29 @@ static inline loff_t fat_make_i_pos(stru
 		| (de - (struct msdos_dir_entry *)bh->b_data);
 }
 
+static inline void fat_dir_readahead(struct inode *dir, sector_t iblock,
+				     sector_t phys)
+{
+	struct super_block *sb = dir->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct buffer_head *bh;
+	int sec;
+
+	/* This is not a first sector of cluster, or sec_per_clus == 1 */
+	if ((iblock & (sbi->sec_per_clus - 1)) || sbi->sec_per_clus == 1)
+		return;
+	/* root dir of FAT12/FAT16 */
+	if ((sbi->fat_bits != 32) && (dir->i_ino == MSDOS_ROOT_INO))
+		return;
+
+	bh = sb_getblk(sb, phys);
+	if (bh && !buffer_uptodate(bh)) {
+		for (sec = 0; sec < sbi->sec_per_clus; sec++)
+			sb_breadahead(sb, phys + sec);
+	}
+	brelse(bh);
+}
+
 /* Returns the inode number of the directory entry at offset pos. If bh is
    non-NULL, it is brelse'd before. Pos is incremented. The buffer header is
    returned in bh.
@@ -58,6 +81,8 @@ next:
 	if (err || !phys)
 		return -1;	/* beyond EOF or error */
 
+	fat_dir_readahead(dir, iblock, phys);
+
 	*bh = sb_bread(sb, phys);
 	if (*bh == NULL) {
 		printk(KERN_ERR "FAT: Directory bread(block %llu) failed\n",
@@ -635,8 +660,7 @@ RecEnd:
 EODir:
 	filp->f_pos = cpos;
 FillFailed:
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	if (unicode)
 		free_page((unsigned long)unicode);
 out:
_
