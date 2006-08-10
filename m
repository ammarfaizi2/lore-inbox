Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWHJBVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWHJBVe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWHJBVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:21:33 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:40114 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751438AbWHJBV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:21:26 -0400
Subject: [PATCH 5/9] uninitialized extents handling
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 09 Aug 2006 18:21:28 -0700
Message-Id: <1155172888.3161.84.camel@localhost.localdomain>
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

 linux-2.6.18-rc4-ming/fs/ext4/extents.c               |   16 ++++++++++++++++
 linux-2.6.18-rc4-ming/include/linux/ext4_fs_extents.h |    2 ++
 2 files changed, 18 insertions(+)

diff -puN fs/ext4/extents.c~ext4-unitialized-extent-handling fs/ext4/extents.c
--- linux-2.6.18-rc4/fs/ext4/extents.c~ext4-unitialized-extent-handling	2006-08-09 15:41:57.132331264 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/extents.c	2006-08-09 15:41:57.142331345 -0700
@@ -1082,6 +1082,13 @@ ext4_can_extents_be_merged(struct inode 
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
@@ -1943,6 +1950,15 @@ int ext4_ext_get_blocks(handle_t *handle
 	        unsigned long ee_block = le32_to_cpu(ex->ee_block);
 		ext4_fsblk_t ee_start = ext_pblock(ex);
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
diff -puN include/linux/ext4_fs_extents.h~ext4-unitialized-extent-handling include/linux/ext4_fs_extents.h
--- linux-2.6.18-rc4/include/linux/ext4_fs_extents.h~ext4-unitialized-extent-handling	2006-08-09 15:41:57.135331289 -0700
+++ linux-2.6.18-rc4-ming/include/linux/ext4_fs_extents.h	2006-08-09 15:41:57.143331354 -0700
@@ -141,6 +141,8 @@ typedef int (*ext_prepare_callback)(stru
 
 #define EXT_MAX_BLOCK	0xffffffff
 
+#define EXT_MAX_LEN	((1UL << 15) - 1)
+
 
 #define EXT_FIRST_EXTENT(__hdr__) \
 	((struct ext4_extent *) (((char *) (__hdr__)) +		\

_


