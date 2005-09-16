Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161183AbVIPQhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161183AbVIPQhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 12:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbVIPQhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 12:37:21 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:17634 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S1161181AbVIPQhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 12:37:19 -0400
Date: Fri, 16 Sep 2005 13:49:00 -0300
From: Glauber de Oliveira Costa <gocosta@br.ibm.com>
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, adilger@clusterfs.com, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] Cleanup while EXT3FS_DEBUG on
Message-ID: <20050916164900.GU23782@br.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zS7rBR6csb6tI2e1"
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi people,

When trying to gather some debugging information from ext3 runtime, (by
defining EXT3FS_DEBUG in ext3_fs.h), the ext3 code failed to compile with one
error, besides raising some warnings. 

This simple cleanup patch fix this. The code now compiles with no
warnings at all 

-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
gocosta@br.ibm.com
=====================================

--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_debug_cleanup

diff -u linux-2.6.13-orig/fs/ext3/balloc.c linux/fs/ext3/balloc.c
--- linux-2.6.13-orig/fs/ext3/balloc.c	2005-09-16 11:30:45.000000000 -0300
+++ linux/fs/ext3/balloc.c	2005-09-16 10:57:27.000000000 -0300
@@ -1410,7 +1410,7 @@
 	unsigned long desc_count;
 	struct ext3_group_desc *gdp;
 	int i;
-	unsigned long ngroups;
+	unsigned long ngroups = EXT3_SB(sb)->s_groups_count; 
 #ifdef EXT3FS_DEBUG
 	struct ext3_super_block *es;
 	unsigned long bitmap_count, x;
@@ -1421,7 +1421,8 @@
 	desc_count = 0;
 	bitmap_count = 0;
 	gdp = NULL;
-	for (i = 0; i < EXT3_SB(sb)->s_groups_count; i++) {
+
+	for (i = 0; i < ngroups; i++) {
 		gdp = ext3_get_group_desc(sb, i, NULL);
 		if (!gdp)
 			continue;
@@ -1443,7 +1444,6 @@
 	return bitmap_count;
 #else
 	desc_count = 0;
-	ngroups = EXT3_SB(sb)->s_groups_count;
 	smp_rmb();
 	for (i = 0; i < ngroups; i++) {
 		gdp = ext3_get_group_desc(sb, i, NULL);
diff -u linux-2.6.13-orig/fs/ext3/resize.c linux/fs/ext3/resize.c
--- linux-2.6.13-orig/fs/ext3/resize.c	2005-09-16 11:30:45.000000000 -0300
+++ linux/fs/ext3/resize.c	2005-09-16 13:03:30.000000000 -0300
@@ -242,7 +242,7 @@
 	     i < sbi->s_itb_per_group; i++, bit++, block++) {
 		struct buffer_head *it;
 
-		ext3_debug("clear inode block %#04x (+%ld)\n", block, bit);
+		ext3_debug("clear inode block %#04lx (+%d)\n", block, bit);
 		if (IS_ERR(it = bclean(handle, sb, block))) {
 			err = PTR_ERR(it);
 			goto exit_bh;
@@ -643,8 +643,8 @@
 			break;
 
 		bh = sb_getblk(sb, group * bpg + blk_off);
-		ext3_debug(sb, __FUNCTION__, "update metadata backup %#04lx\n",
-			   bh->b_blocknr);
+		ext3_debug("update metadata backup %#04lx\n",
+			  (unsigned long)bh->b_blocknr);
 		if ((err = ext3_journal_get_write_access(handle, bh)))
 			break;
 		lock_buffer(bh);

--zS7rBR6csb6tI2e1--
