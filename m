Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424446AbWKJWSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424446AbWKJWSZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 17:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424452AbWKJWSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 17:18:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23486 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424446AbWKJWSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 17:18:24 -0500
Message-ID: <4554FAAB.1070409@redhat.com>
Date: Fri, 10 Nov 2006 16:18:19 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19] Fix oops on ext3 directory corruption (resend from
 -mm)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend for 2.6.19 consideration, it's in -mm today)

These were found using the infamous fsfuzzer tool.

There may be security implications of this as well, and although I wouldn't
probably judge it as high risk, there is some potential for mischief.

First, we had a corrupted directory that was never checked
for consistency... it was corrupt, and pointed to another bad "entry"
of length 0.  The for() loop looped forever, since the length
of ext3_next_entry(de) was 0, and we kept looking at the same
pointer over and over and over and over... I modeled this check
and subsequent action on what is done for other directory types
in ext3_readdir...

Next we had a root directory inode which had a corrupted size, claimed
to be > 200M on a 4M filesystem.  There was only really 1 block in the 
directory, but because the size was so large, readdir kept coming back 
for more, spewing thousands of printk's along the way.

Per Andreas' suggestion, if we're in this read error condition and we're
trying to read an offset which is greater than i_blocks worth of bytes,
stop trying, and break out of the loop.

With these two changes fsfuzz test survives quite well on ext3.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.18/fs/ext3/namei.c
===================================================================
--- linux-2.6.18.orig/fs/ext3/namei.c
+++ linux-2.6.18/fs/ext3/namei.c
@@ -551,6 +551,15 @@ static int htree_dirblock_to_tree(struct
 					   dir->i_sb->s_blocksize -
 					   EXT3_DIR_REC_LEN(0));
 	for (; de < top; de = ext3_next_entry(de)) {
+		if (!ext3_check_dir_entry("htree_dirblock_to_tree", dir, de, bh,
+					(block<<EXT3_BLOCK_SIZE_BITS(dir->i_sb))
+						+((char *)de - bh->b_data))) {
+			/* On error, skip the f_pos to the next block. */
+			dir_file->f_pos = (dir_file->f_pos |
+					(dir->i_sb->s_blocksize - 1)) + 1;
+			brelse (bh);
+			return count;
+		}
 		ext3fs_dirhash(de->name, de->name_len, hinfo);
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
Index: linux-2.6.18/fs/ext3/dir.c
===================================================================
--- linux-2.6.18.orig/fs/ext3/dir.c
+++ linux-2.6.18/fs/ext3/dir.c
@@ -151,6 +151,9 @@ static int ext3_readdir(struct file * fi
 			ext3_error (sb, "ext3_readdir",
 				"directory #%lu contains a hole at offset %lu",
 				inode->i_ino, (unsigned long)filp->f_pos);
+			/* corrupt size?  Maybe no more blocks to read */
+			if (filp->f_pos > inode->i_blocks << 9)
+				break;
 			filp->f_pos += sb->s_blocksize - offset;
 			continue;
 		}




