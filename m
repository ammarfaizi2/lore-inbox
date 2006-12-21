Return-Path: <linux-kernel-owner+w=401wt.eu-S1423035AbWLUS6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423035AbWLUS6h (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423032AbWLUS6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:58:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58710 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423031AbWLUS6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:58:35 -0500
Message-ID: <458AD954.7020904@redhat.com>
Date: Thu, 21 Dec 2006 12:58:28 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
Subject: [PATCH] ext2: skip pages past number of blocks in ext2_find_entry
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one was pointed out on the MOKB site:
http://kernelfun.blogspot.com/2006/11/mokb-09-11-2006-linux-26x-ext2checkpage.html

If a directory's i_size is corrupted, ext2_find_entry() will keep processing
pages until the i_size is reached, even if there are no more blocks associated
with the directory inode.  This patch puts in some minimal sanity-checking
so that we don't keep checking pages (and issuing errors) if we know there
can be no more data to read, based on the block count of the directory inode.

This is somewhat similar in approach to the ext3 patch I sent earlier this
year.

Thanks,

-Eric

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.19/fs/ext2/dir.c
===================================================================
--- linux-2.6.19.orig/fs/ext2/dir.c
+++ linux-2.6.19/fs/ext2/dir.c
@@ -368,6 +368,14 @@ struct ext2_dir_entry_2 * ext2_find_entr
 		}
 		if (++n >= npages)
 			n = 0;
+		/* next page is past the blocks we've got */
+		if (unlikely(n > (dir->i_blocks >> (PAGE_CACHE_SHIFT - 9)))) {
+			ext2_error(dir->i_sb, __FUNCTION__,
+				"dir %lu size %lld exceeds block count %llu",
+				dir->i_ino, dir->i_size,
+				(unsigned long long)dir->i_blocks);
+				goto out;
+		}
 	} while (n != start);
 out:
 	return NULL;


