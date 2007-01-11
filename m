Return-Path: <linux-kernel-owner+w=401wt.eu-S1751259AbXAKBVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbXAKBVD (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 20:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbXAKBVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 20:21:01 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:51053 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965280AbXAKBVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 20:21:01 -0500
Date: Wed, 10 Jan 2007 17:27:21 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: Eric Sandeen <sandeen@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ext2: skip pages past number of blocks in ext2_find_entry (CVE-2006-6054)
Message-ID: <20070111012721.GO10475@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one looks like it fell through the cracks, it's in 2.6.19.2 but not upstream yet.

thanks,
-chris
--
Subject: [PATCH] ext2: skip pages past number of blocks in ext2_find_entry (CVE-2006-6054)
From: Eric Sandeen <sandeen@redhat.com>

This one was pointed out on the MOKB site:
http://kernelfun.blogspot.com/2006/11/mokb-09-11-2006-linux-26x-ext2checkpage.html

If a directory's i_size is corrupted, ext2_find_entry() will keep processing
pages until the i_size is reached, even if there are no more blocks associated
with the directory inode.  This patch puts in some minimal sanity-checking
so that we don't keep checking pages (and issuing errors) if we know there
can be no more data to read, based on the block count of the directory inode.

This is somewhat similar in approach to the ext3 patch I sent earlier this
year.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
Not upstream yet

 fs/ext2/dir.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.19.1.orig/fs/ext2/dir.c
+++ linux-2.6.19.1/fs/ext2/dir.c
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
+			goto out;
+		}
 	} while (n != start);
 out:
 	return NULL;
