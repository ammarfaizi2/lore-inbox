Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269281AbUI3NYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269281AbUI3NYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 09:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269277AbUI3NYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 09:24:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15256 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269259AbUI3NX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 09:23:56 -0400
Date: Thu, 30 Sep 2004 14:23:29 +0100
Message-Id: <200409301323.i8UDNT1a004771@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 3/10]: ext3 online resize: fix bh leak
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that verify_group_input() brelse's the buffer we're verifying
in every case.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc2-mm4/fs/ext3/resize.c.=K0002=.orig
+++ linux-2.6.9-rc2-mm4/fs/ext3/resize.c
@@ -36,7 +36,7 @@ static int verify_group_input(struct sup
 		(1 + ext3_bg_num_gdb(sb, group) +
 		 le16_to_cpu(es->s_reserved_gdt_blocks)) : 0;
 	unsigned metaend = start + overhead;
-	struct buffer_head *bh;
+	struct buffer_head *bh = NULL;
 	int free_blocks_count;
 	int err = -EINVAL;
 
@@ -104,10 +104,9 @@ static int verify_group_input(struct sup
 		ext3_warning(sb, __FUNCTION__,
 			     "Inode table (%u-%u) overlaps GDT table (%u-%u)",
 			     input->inode_table, itend - 1, start, metaend - 1);
-	else {
-		brelse(bh);
+	else 
 		err = 0;
-	}
+	brelse(bh);
 
 	return err;
 }
