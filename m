Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbVKYTd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbVKYTd1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbVKYTd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:33:27 -0500
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:21381 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751462AbVKYTd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:33:26 -0500
Date: Fri, 25 Nov 2005 17:36:31 -0200
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, adilger@clusterfs.com, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] ext3: use sbi instead of EXT3_SB() in resize code.
Message-ID: <20051125193631.GD19410@br.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: glommer@br.ibm.com (Glauber de Oliveira Costa)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There are places in the resize code in which EXT3_SB() macro is used
after an statement like sbi = EXT3_SB(sb) is done. Inside the same 
function, both sbi and EXT3_SB() are used to reference the super block
Altough it is not wrong, keeping it coherent increases legibility, IMHO.

Signed-off-by: Glauber de Oliveira Costa <glommer@br.ibm.com>
---
  


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ext3-sbi

--- linux-2.6.14.2-orig/fs/ext3/resize.c	2005-11-25 16:09:17.000000000 +0000
+++ linux-2.6.14.2-orig/fs/ext3/resize-sbi.c	2005-11-25 16:28:57.000000000 +0000
@@ -31,7 +31,7 @@ static int verify_group_input(struct sup
 	unsigned start = le32_to_cpu(es->s_blocks_count);
 	unsigned end = start + input->blocks_count;
 	unsigned group = input->group;
-	unsigned itend = input->inode_table + EXT3_SB(sb)->s_itb_per_group;
+	unsigned itend = input->inode_table + sbi->s_itb_per_group;
 	unsigned overhead = ext3_bg_has_super(sb, group) ?
 		(1 + ext3_bg_num_gdb(sb, group) +
 		 le16_to_cpu(es->s_reserved_gdt_blocks)) : 0;
@@ -754,7 +754,7 @@ int ext3_group_add(struct super_block *s
 	}
 
 	lock_super(sb);
-	if (input->group != EXT3_SB(sb)->s_groups_count) {
+	if (input->group != sbi->s_groups_count) {
 		ext3_warning(sb, __FUNCTION__,
 			     "multiple resizers run on filesystem!\n");
 		goto exit_journal;
@@ -788,7 +788,7 @@ int ext3_group_add(struct super_block *s
 	 * data.  So we need to be careful to set all of the relevant
 	 * group descriptor data etc. *before* we enable the group.
 	 *
-	 * The key field here is EXT3_SB(sb)->s_groups_count: as long as
+	 * The key field here is sbi->s_groups_count: as long as
 	 * that retains its old value, nobody is going to access the new
 	 * group.
 	 *
@@ -848,7 +848,7 @@ int ext3_group_add(struct super_block *s
 	smp_wmb();
 
 	/* Update the global fs size fields */
-	EXT3_SB(sb)->s_groups_count++;
+	sbi->s_groups_count++;
 
 	ext3_journal_dirty_metadata(handle, primary);
 
@@ -863,7 +863,7 @@ int ext3_group_add(struct super_block *s
 	percpu_counter_mod(&sbi->s_freeinodes_counter,
 			   EXT3_INODES_PER_GROUP(sb));
 
-	ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
+	ext3_journal_dirty_metadata(handle, sbi->s_sbh);
 	sb->s_dirt = 1;
 
 exit_journal:

--OBd5C1Lgu00Gd/Tn--
