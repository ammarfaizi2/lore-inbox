Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVHDBeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVHDBeJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 21:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVHDBeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 21:34:08 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:8323 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261736AbVHDBd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 21:33:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Message-Id:Content-Type;
  b=dp+10Xk8rsvtaxiBHzURDy0vOg9FcTVtx5Kg0Lkr/xK7SQr6DrveV1bzTT72P84QEX9SccEQxAP+8USejoVhAaPJ9tWNSbBbuQkma9AUtfEyqjin7bRROgrreHDe0W82UGLsHRbaR9inBXiuOCGq66Hlil3BKpyL7Q7MWjbdeXA=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp, akpm@osdl.org
Subject: [PATCH] Speedup FAT filesystem directory reads
Date: Thu, 4 Aug 2005 03:33:44 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Message-Id: <200508040333.44935.annabellesgarden@yahoo.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4BX8CKFpQzD4PrX"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_4BX8CKFpQzD4PrX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Please give this a try and commit to -mm or mainline, if approved.

Thanks,
Karsten

Summary:
This speeds up directory reads for large FAT partitions,
if the buffercache has to be filled from the drive.
Following values were taken from:
	$ time find path_to_freshly_mounted_fat > /dev/null
on an otherwise idle system.
FAT with 16KB Clusters on IDE attached drive:	Factor  2
FAT with 32KB Clusters on USB2 attached drive:	Factor 10 (!)
Its less than 1/10 slower, if the buffercache is uptodate.

The patch touches 3 areas:
- fat_bmap() returns the sector's offset in the cluster or a 
  negativ error code instead of 0 or the negativ error code.
  It's callers are changed accordingly.
- fat__get_entry() calls sb_breadahead() to readahead a whole cluster,
  if the requested sector is the first one in a cluster.
  It is usefull to do this, because on FAT directories occupy whole
  clusters.
  Readahead is only done, if the cluster's first sector is not uptodate
  to avoid overhead, when the buffer cache is already uptodate.
  Note that on memory pressure, the maximal byte count wasted
  (read: has to be red from disk twice) is 1 cluster's size. Thats 64KB.
- Unrelated cleanup at one spot:
	if (bh)
		brelse(bh);
  is replaced with:
	brelse(bh);
  brelse() can handle NULL pointer arguments by itself.

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>


--Boundary-00=_4BX8CKFpQzD4PrX
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fat+sb_breadahead.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fat+sb_breadahead.diff"

diff -ur linux-2.6.13_orig/fs/fat/cache.c linux-2.6.13/fs/fat/cache.c
--- linux-2.6.13_orig/fs/fat/cache.c	2005-07-31 21:15:16.000000000 +0200
+++ linux-2.6.13/fs/fat/cache.c	2005-08-02 13:55:50.000000000 +0200
@@ -320,5 +320,5 @@
 		return cluster;
 	else if (cluster)
 		*phys = fat_clus_to_blknr(sbi, cluster) + offset;
-	return 0;
+	return offset;
 }
diff -ur linux-2.6.13_orig/fs/fat/dir.c linux-2.6.13/fs/fat/dir.c
--- linux-2.6.13_orig/fs/fat/dir.c	2005-07-31 21:14:20.000000000 +0200
+++ linux-2.6.13/fs/fat/dir.c	2005-07-31 21:53:28.000000000 +0200
@@ -46,7 +46,7 @@
 	struct super_block *sb = dir->i_sb;
 	sector_t phys, iblock;
 	int offset;
-	int err;
+	int clu_sector;
 
 next:
 	if (*bh)
@@ -54,10 +54,21 @@
 
 	*bh = NULL;
 	iblock = *pos >> sb->s_blocksize_bits;
-	err = fat_bmap(dir, iblock, &phys);
-	if (err || !phys)
+	clu_sector = fat_bmap(dir, iblock, &phys);
+	if (clu_sector < 0 || !phys)
 		return -1;	/* beyond EOF or error */
 
+	if (0 == clu_sector) {
+		struct buffer_head *bh = __getblk(sb->s_bdev, phys, sb->s_blocksize);
+		if (!buffer_uptodate(bh)) {
+			int sec;
+			int sec_per_clus = MSDOS_SB(sb)->sec_per_clus;
+			for (sec = 0; sec < sec_per_clus; sec++)
+				sb_breadahead(sb, phys + sec);
+		}
+		brelse(bh);
+	}
+
 	*bh = sb_bread(sb, phys);
 	if (*bh == NULL) {
 		printk(KERN_ERR "FAT: Directory bread(block %llu) failed\n",
@@ -635,8 +646,7 @@
 EODir:
 	filp->f_pos = cpos;
 FillFailed:
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	if (unicode)
 		free_page((unsigned long)unicode);
 out:
diff -ur linux-2.6.13_orig/fs/fat/inode.c linux-2.6.13/fs/fat/inode.c
--- linux-2.6.13_orig/fs/fat/inode.c	2005-07-31 21:15:16.000000000 +0200
+++ linux-2.6.13/fs/fat/inode.c	2005-08-02 13:55:50.000000000 +0200
@@ -56,7 +56,7 @@
 	int err;
 
 	err = fat_bmap(inode, iblock, &phys);
-	if (err)
+	if (err < 0)
 		return err;
 	if (phys) {
 		map_bh(bh_result, sb, phys);
@@ -76,7 +76,7 @@
 	}
 	MSDOS_I(inode)->mmu_private += sb->s_blocksize;
 	err = fat_bmap(inode, iblock, &phys);
-	if (err)
+	if (err < 0)
 		return err;
 	if (!phys)
 		BUG();

--Boundary-00=_4BX8CKFpQzD4PrX--

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
