Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUG2TVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUG2TVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbUG2TT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:19:58 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:16265 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S264954AbUG2TSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:18:17 -0400
Message-ID: <41094D69.9030008@tu-harburg.de>
Date: Thu, 29 Jul 2004 21:18:01 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [PATCH] ext2_readdir() filp->f_pos fix
Content-Type: multipart/mixed;
 boundary="------------070501090401010202010307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070501090401010202010307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

If the whole inode is read, ext2_readdir() sets the f_pos to a multiple 
of the page size (because of the conditions of the outer for loop). This 
sets the wrong f_pos for directory inodes on ext2 partitions with a 
block size differing from the page size.


--------------070501090401010202010307
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

Signed-off-by: Jan Blunck <j.blunck@tu-harburg.de>

 dir.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: testing-2.5/fs/ext2/dir.c
===================================================================
--- testing-2.5.orig/fs/ext2/dir.c	2004-07-27 19:24:00.000000000 +0200
+++ testing-2.5/fs/ext2/dir.c	2004-07-29 20:32:10.141354816 +0200
@@ -251,7 +251,7 @@
 	loff_t pos = filp->f_pos;
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct super_block *sb = inode->i_sb;
-	unsigned offset = pos & ~PAGE_CACHE_MASK;
+	unsigned int offset = pos & ~PAGE_CACHE_MASK;
 	unsigned long n = pos >> PAGE_CACHE_SHIFT;
 	unsigned long npages = dir_pages(inode);
 	unsigned chunk_mask = ~(ext2_chunk_size(inode)-1);
@@ -303,6 +303,7 @@
 					goto success;
 				}
 			}
+			filp->f_pos += le16_to_cpu(de->rec_len);
 		}
 		ext2_put_page(page);
 	}
@@ -310,7 +311,6 @@
 success:
 	ret = 0;
 done:
-	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
 	filp->f_version = inode->i_version;
 	return ret;
 }

--------------070501090401010202010307--
