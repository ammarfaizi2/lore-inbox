Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVHEA4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVHEA4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 20:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVHEA4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 20:56:38 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:7029 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262796AbVHEA4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 20:56:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Message-Id:Content-Type;
  b=3dIydUYkuHPSRmW4lsIgosJ7pThQ0oD0Ry4PlZD3FJyBJ5gImjJfN2Hqbg6P7AbDhTZgGtTmATjVjkf01kdf0E8C97VnXoIhMttGveCyvKaNyKHVDTzI/vSnXSdS9np0JkLTUebeMmvFnz01tmJaezq589sjbO6Dkj78UfS88bQ=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, akpm@osdl.org
Subject: Re: [PATCH] Speedup FAT filesystem directory reads
Date: Fri, 5 Aug 2005 02:54:08 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200508040333.44935.annabellesgarden@yahoo.de> <87wtn1ail7.fsf@devron.myhome.or.jp>
In-Reply-To: <87wtn1ail7.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Message-Id: <200508050254.08418.annabellesgarden@yahoo.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wir8CENjoJmiAJt"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_wir8CENjoJmiAJt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Donnerstag, 4. August 2005 16:21 schrieb OGAWA Hirofumi:
> Karsten Wiese <annabellesgarden@yahoo.de> writes:
> 
> > Please give this a try and commit to -mm or mainline, if approved.
> 
> Looks good. Thanks.  However, I tweaked the patch.
> 
>     - replace __getblk() to sb_getblk()
>     - exclude root-dir of FAT12/FAT16 from readahead
>     - exclude (sec_per_clus == 1) from readahead
>     - move the all readahead stuff to one inline function
> 
> What do you think of the following patch?

Looks better, is smaller and works equally well here, thanks.
I had to hand apply it though as it was slightly scrambled
(by my mail client?) so patch couldn't handle it.
Please send patches as attachment.

Andrew,
please replace the initial version in -mm with this one.

    Thanks,
    Karsten


From: Karsten Wiese <annabellesgarden@yahoo.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

This speeds up directory reads for large FAT partitions, if the buffercache
has to be filled from the drive. Following values were taken from:

        $ time find path_to_freshly_mounted_fat > /dev/null

on an otherwise idle system.

FAT with 16KB Clusters on IDE attached drive:   Factor  2
FAT with 32KB Clusters on USB2 attached drive:  Factor 10 (!)
Its less than 1/10 slower, if the buffercache is uptodate.

The patch introduces the new function fat_dir_readahead().

fat_dir_readahead() calls sb_breadahead() to readahead a whole cluster,
if the requested sector is the first one in a cluster.
It is usefull to do this, because on FAT directories occupy whole
clusters, with the exception of FAT12/FAT16 root dirs.

Readahead is only done, if the cluster's first sector is not uptodate
to avoid overhead, when the buffer cache is already uptodate.
Note that under memory pressure, the maximal byte count wasted
(read: has to be red from disk twice) is 1 cluster's size.  Thats 64KB.

fat_dir_readahead() is called from fat__get_entry().

There is also an unrelated cleanup at one spot:

        if (bh)
                brelse(bh);

is replaced with:

        brelse(bh);

brelse() can handle NULL pointer arguments by itself.

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



--Boundary-00=_wir8CENjoJmiAJt
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="speedup-fat-filesystem-directory-reads_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="speedup-fat-filesystem-directory-reads_2.patch"

diff -ur linux-2.6.13_orig/fs/fat/dir.c linux-2.6.13/fs/fat/dir.c
--- linux-2.6.13_orig/fs/fat/dir.c	2005-07-31 21:14:20.000000000 +0200
+++ linux-2.6.13/fs/fat/dir.c	2005-08-04 19:11:21.000000000 +0200
@@ -30,6 +30,29 @@
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
@@ -58,6 +81,8 @@
 	if (err || !phys)
 		return -1;	/* beyond EOF or error */
 
+	fat_dir_readahead(dir, iblock, phys);
+
 	*bh = sb_bread(sb, phys);
 	if (*bh == NULL) {
 		printk(KERN_ERR "FAT: Directory bread(block %llu) failed\n",
@@ -635,8 +660,7 @@
 EODir:
 	filp->f_pos = cpos;
 FillFailed:
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	if (unicode)
 		free_page((unsigned long)unicode);
 out:

--Boundary-00=_wir8CENjoJmiAJt--

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
