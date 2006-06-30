Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933171AbWF3ASG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933171AbWF3ASG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933172AbWF3ASB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:18:01 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:52640 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S933168AbWF3ARs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:17:48 -0400
Subject: [RFC][Update][Patch 6/16]handing unitialized extents
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:17:46 -0700
Message-Id: <1151626666.6601.76.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to add file preallocation support in future as an
RO_COMPAT feature by recognizing uninitialized extents as holes and
limiting extent length to keep the top bit of ee_len free for marking
uninitialized extents.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>
Signed-off-by: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.17-ming/fs/ext3/extents.c               |   16 ++++++++++++++++
 linux-2.6.17-ming/include/linux/ext3_fs_extents.h |    2 ++
 2 files changed, 18 insertions(+)

diff -puN fs/ext3/extents.c~ext3-unitialized-extent-handling fs/ext3/extents.c
--- linux-2.6.17/fs/ext3/extents.c~ext3-unitialized-extent-handling	2006-06-28 16:46:49.657758078 -0700
+++ linux-2.6.17-ming/fs/ext3/extents.c	2006-06-28 16:46:49.667756930 -0700
@@ -1082,6 +1082,13 @@ ext3_can_extents_be_merged(struct inode 
 	    != le32_to_cpu(ex2->ee_block))
 		return 0;
 
+	/*
+	 * To allow future support for preallocated extents to be added
+	 * as an RO_COMPAT feature, refuse to merge to extents if
+	 * can result in the top bit of ee_len being set
+	 */
+	if (le16_to_cpu(ex1->ee_len) + le16_to_cpu(ex2->ee_len) > EXT_MAX_LEN)
+		return 0;
 #ifdef AGRESSIVE_TEST
 	if (le16_to_cpu(ex1->ee_len) >= 4)
 		return 0;
@@ -1943,6 +1950,15 @@ int ext3_ext_get_blocks(handle_t *handle
 	        unsigned long ee_block = le32_to_cpu(ex->ee_block);
 		ext3_fsblk_t ee_start = ext_pblock(ex);
 		unsigned short ee_len  = le16_to_cpu(ex->ee_len);
+
+		/*
+		 * Allow future support for preallocated extents to be added
+		 * as an RO_COMPAT feature:
+		 * Uninitialized extents are treated as holes, except that
+		 * we avoid (fail) allocating new blocks during a write.
+		 */
+		if (ee_len > EXT_MAX_LEN)
+			goto out2;
 		/* if found exent covers block, simple return it */
 	        if (iblock >= ee_block && iblock < ee_block + ee_len) {
 			newblock = iblock - ee_block + ee_start;
diff -puN include/linux/ext3_fs_extents.h~ext3-unitialized-extent-handling include/linux/ext3_fs_extents.h
--- linux-2.6.17/include/linux/ext3_fs_extents.h~ext3-unitialized-extent-handling	2006-06-28 16:46:49.661757619 -0700
+++ linux-2.6.17-ming/include/linux/ext3_fs_extents.h	2006-06-28 16:46:49.668756816 -0700
@@ -141,6 +141,8 @@ typedef int (*ext_prepare_callback)(stru
 
 #define EXT_MAX_BLOCK	0xffffffff
 
+#define EXT_MAX_LEN	((1UL << 15) - 1)
+
 
 #define EXT_FIRST_EXTENT(__hdr__) \
 	((struct ext3_extent *) (((char *) (__hdr__)) +		\

_


