Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUECQQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUECQQR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 12:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUECQQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 12:16:17 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:8588 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263769AbUECQQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 12:16:08 -0400
Date: Mon, 3 May 2004 10:16:06 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@stanford.edu,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.stanford.edu>, Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [Ext2-devel] [CHECKER] warnings in fs/ext3/namei.c (2.4.19) where disk read errors get ignored, causing non-empty dir to be deleted
Message-ID: <20040503161606.GJ1334@schnapps.adilger.int>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Junfeng Yang <yjf@stanford.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, mc@stanford.edu,
	Madanlal S Musuvathi <madan@stanford.edu>,
	"David L. Dill" <dill@cs.stanford.edu>,
	Andrew Morton <akpm@osdl.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <Pine.GSO.4.44.0404262339360.7250-100000@elaine24.Stanford.EDU> <20040427074455.GD30529@schnapps.adilger.int> <20040503141001.GA23656@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040503141001.GA23656@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 03, 2004  16:10 +0200, Jörn Engel wrote:
> On Tue, 27 April 2004 01:44:55 -0600, Andreas Dilger wrote:
> > Again a conscious decision.  If a name is potentially inaccessible
> > because of an IO error it is better to allow the creation of a
> > potentially duplicate name than refuse creation of any new entries
> > in the directory.  It's a matter of allowing the filesystem to be
> > used as well as possible in the face of failures vs. just giving up
> > and refusing to do anything.
> 
> Do you mind if I doubt the sanity of whoever made that decision?  When
> my hard drive fails, I don't care about writing to the fs too much
> anymore, I want to *notice* the failure early and to *read* as much as
> possible, then put the drive on a pile for test hardware.

If that's what you want, then mount the filesystem with "errors=remount-ro"
and you will get it.  You can even mount it with "errors=panic" so that the
node reboots and does a full fsck immediately.  For users that have a few
bad blocks on their disk and can't afford to throw the whole disk away this
is a reasonable course of action.

Two things that do deserve fixing in these call paths are that
a) we don't call ext3_error() for an IO error in ext3_find_entry(), so we
   won't do the normal ext3 error handling (mark SB in error, remount-ro
   or panic if desired);
b) in empty_dir() we don't continue checking for non-empty blocks after a
   content error (ext3_check_dir_entry() calls ext3_error() already);
c) we had decided not to mark the SB in error for holes in directories to
   allow leway in the indexed-directory implementation, but this change
   incorrectly also disabled marking the SB in error for real IO errors.

Patch applies equally well to 2.4.25 and 2.6-current.

Cheers, Andreas
========================== ext3-direrrors.diff =============================
--- ./fs/ext3/namei.c.orig	2004-03-09 16:46:43.000000000 -0700
+++ ./fs/ext3/namei.c	2004-05-03 10:10:53.000000000 -0600
@@ -825,6 +825,8 @@ restart:
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
 			/* read error, skip block & hope for the best */
+			ext3_error(sb, __FUNCTION__, "reading directory #%lu "
+				   "offset %lu\n", dir->i_ino, block);
 			brelse(bh);
 			goto next;
 		}
@@ -1712,14 +1720,19 @@ static int empty_dir (struct inode * ino
 	struct buffer_head * bh;
 	struct ext3_dir_entry_2 * de, * de1;
 	struct super_block * sb;
-	int err;
+	int err = 0;
 
 	sb = inode->i_sb;
 	if (inode->i_size < EXT3_DIR_REC_LEN(1) + EXT3_DIR_REC_LEN(2) ||
 	    !(bh = ext3_bread (NULL, inode, 0, 0, &err))) {
-	    	ext3_warning (inode->i_sb, "empty_dir",
-			      "bad directory (dir #%lu) - no data block",
-			      inode->i_ino);
+		if (err)
+			ext3_error(inode->i_sb, __FUNCTION__,
+				   "error %d reading directory #%lu offset 0",
+				   err, inode->i_ino);
+		else
+			ext3_warning(inode->i_sb, __FUNCTION__,
+				     "bad directory (dir #%lu) - no data block",
+				     inode->i_ino);
 		return 1;
 	}
 	de = (struct ext3_dir_entry_2 *) bh->b_data;
@@ -1741,24 +1754,26 @@ static int empty_dir (struct inode * ino
 	while (offset < inode->i_size ) {
 		if (!bh ||
 			(void *) de >= (void *) (bh->b_data+sb->s_blocksize)) {
+			err = 0;
 			brelse (bh);
 			bh = ext3_bread (NULL, inode,
 				offset >> EXT3_BLOCK_SIZE_BITS(sb), 0, &err);
 			if (!bh) {
-#if 0
-				ext3_error (sb, "empty_dir",
-				"directory #%lu contains a hole at offset %lu",
-					inode->i_ino, offset);
-#endif
+				if (err)
+					ext3_error(sb, __FUNCTION__,
+						   "error %d reading directory"
+						   " #%lu offset %lu",
+						   err, inode->i_ino, offset);
 				offset += sb->s_blocksize;
 				continue;
 			}
 			de = (struct ext3_dir_entry_2 *) bh->b_data;
 		}
-		if (!ext3_check_dir_entry ("empty_dir", inode, de, bh,
-					   offset)) {
-			brelse (bh);
-			return 1;
+		if (!ext3_check_dir_entry("empty_dir", inode, de, bh, offset)) {
+			de = (struct ext3_dir_entry_2 *)(bh->b_data +
+							 sb->s_blocksize);
+			offset = (offset | (sb->s_blocksize - 1)) + 1;
+			continue;
 		}
 		if (le32_to_cpu(de->inode)) {
 			brelse (bh);
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

