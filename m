Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUFSWjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUFSWjq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 18:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbUFSWjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 18:39:46 -0400
Received: from outmx012.isp.belgacom.be ([195.238.3.70]:26529 "EHLO
	outmx012.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S263784AbUFSWjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 18:39:42 -0400
Subject: [PATCH 2.6.7] ext3 fill_super reporting
From: FabF <fabian.frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-56PorrD2j391Tg49wzWV"
Message-Id: <1087684902.2224.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 20 Jun 2004 00:41:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-56PorrD2j391Tg49wzWV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

This patch does the following :
	-Explicit max_per_group authorized for block, fragments, inodes 
	-Remove groupmax recalculations
	-When mounting ext2 or ^has_journal , we know filesystem is extX
relevant.


	btw, I see a FIXME in journal_update for new journal creation.Does it
mean we should patch to have e.g. journalupdate=<filename> or that note
is obsolete ?

Regards,
FabF

--=-56PorrD2j391Tg49wzWV
Content-Disposition: attachment; filename=fillsuper1.diff
Content-Type: text/x-patch; name=fillsuper1.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/ext3/super.c edited/fs/ext3/super.c
--- orig/fs/ext3/super.c	2004-06-16 07:20:03.000000000 +0200
+++ edited/fs/ext3/super.c	2004-06-20 00:29:19.675383104 +0200
@@ -1209,6 +1209,7 @@
 	unsigned long offset = 0;
 	unsigned long journal_inum = 0;
 	unsigned long def_mount_opts;
+	unsigned long max_per_group;
 	struct inode *root;
 	int blocksize;
 	int hblock;
@@ -1397,26 +1398,31 @@
 	sbi->s_mount_state = le16_to_cpu(es->s_state);
 	sbi->s_addr_per_block_bits = log2(EXT3_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits = log2(EXT3_DESC_PER_BLOCK(sb));
-	for (i=0; i < 4; i++)
+
+	for (i = 0; i < 4; i++)
 		sbi->s_hash_seed[i] = le32_to_cpu(es->s_hash_seed[i]);
 	sbi->s_def_hash_version = es->s_def_hash_version;
+	max_per_group = blocksize * 8;
 
-	if (sbi->s_blocks_per_group > blocksize * 8) {
+	if (sbi->s_blocks_per_group > max_per_group) {
 		printk (KERN_ERR
-			"EXT3-fs: #blocks per group too big: %lu\n",
-			sbi->s_blocks_per_group);
+			"EXT3-fs: #blocks per group too big: %lu"
+			" (maximum : %lu)\n",
+			sbi->s_blocks_per_group, max_per_group);
 		goto failed_mount;
 	}
-	if (sbi->s_frags_per_group > blocksize * 8) {
+	if (sbi->s_frags_per_group > max_per_group) {
 		printk (KERN_ERR
-			"EXT3-fs: #fragments per group too big: %lu\n",
-			sbi->s_frags_per_group);
+			"EXT3-fs: #fragments per group too big: %lu"
+			" (maximum : %lu)\n",
+			sbi->s_frags_per_group, max_per_group);
 		goto failed_mount;
 	}
-	if (sbi->s_inodes_per_group > blocksize * 8) {
+	if (sbi->s_inodes_per_group > max_per_group) {
 		printk (KERN_ERR
-			"EXT3-fs: #inodes per group too big: %lu\n",
-			sbi->s_inodes_per_group);
+			"EXT3-fs: #inodes per group too big: %lu"
+			" (maximum : %lu)\n",
+			sbi->s_inodes_per_group, max_per_group);
 		goto failed_mount;
 	}
 
@@ -1491,9 +1497,11 @@
 		if (ext3_create_journal(sb, es, journal_inum))
 			goto failed_mount2;
 	} else {
+		/* ext3 won't run without journal */
 		if (!silent)
 			printk (KERN_ERR
-				"ext3: No journal on filesystem on %s\n",
+				"EXT3-fs: No journal in filesystem on %s"
+				" : a ^has_journal ext3 or ext2 partition\n",
 				sb->s_id);
 		goto failed_mount2;
 	}

--=-56PorrD2j391Tg49wzWV--

