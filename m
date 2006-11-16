Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424276AbWKPQtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424276AbWKPQtB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 11:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031193AbWKPQtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 11:49:01 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:4460 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1031192AbWKPQtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 11:49:00 -0500
Message-ID: <455C96DC.4060907@jeffreymahoney.com>
Date: Thu, 16 Nov 2006 11:50:36 -0500
From: Jeff Mahoney <jeffm@jeffreymahoney.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: linux-fsdevel@vger.kernel.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ext3: htree entry integrity checking
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch adds integrity checking to two htree paths that are missing it.

 Currently, if a corrupted directory entry with rec_len=0 is encountered,
 we still trust that the data is valid. This can cause an infinite loop
 in htree_dirblock_to_tree() since the iteration loop will never make any
 progress.

 I initially had written a ext3_check_htree_entry(), but saw that
 ext3_dir_entry_2 is used for both htree and regular directory entries. Since
 ext3_check_dir_entry() is used for checking ext3_dir_entry_2, I used that.
 Can someone confirm that this is correct? There are other places where
 de->rec_len == 0 is used by itself and I'd be fine doing that too, but I
 figure more integrity checking isn't a bad thing.

 This fixes the problem described at:
 http://projects.info-pull.com/mokb/MOKB-10-11-2006.html

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX ../dontdiff linux-2.6.18.orig/fs/ext3/namei.c linux-2.6.18.orig.devel/fs/ext3/namei.c
--- linux-2.6.18.orig/fs/ext3/namei.c	2006-11-09 00:06:37.000000000 -0500
+++ linux-2.6.18.orig.devel/fs/ext3/namei.c	2006-11-12 20:15:19.000000000 -0500
@@ -551,6 +551,11 @@ static int htree_dirblock_to_tree(struct
 					   dir->i_sb->s_blocksize -
 					   EXT3_DIR_REC_LEN(0));
 	for (; de < top; de = ext3_next_entry(de)) {
+		if (!ext3_check_dir_entry(__FUNCTION__, dir, de, bh,
+		                            (char *)de - bh->b_data)) {
+			brelse(bh);
+			return ERR_BAD_DX_DIR;
+		}
 		ext3fs_dirhash(de->name, de->name_len, hinfo);
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
@@ -617,6 +622,11 @@ int ext3_htree_fill_tree(struct file *di
 	if (start_hash < 2 || (start_hash ==2 && start_minor_hash==0)) {
 		de = (struct ext3_dir_entry_2 *) frames[0].bh->b_data;
 		de = ext3_next_entry(de);
+		if (!ext3_check_dir_entry(__FUNCTION__, dir, de, frames[0].bh,
+		                          (char *)de - frames[0].bh->b_data)) {
+			err = ERR_BAD_DX_DIR;
+			goto errout;
+		}
 		if ((err = ext3_htree_store_dirent(dir_file, 2, 0, de)) != 0)
 			goto errout;
 		count++;

-- 
Jeff Mahoney
