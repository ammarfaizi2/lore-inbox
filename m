Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbTAUUoF>; Tue, 21 Jan 2003 15:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTAUUoF>; Tue, 21 Jan 2003 15:44:05 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:12833 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S267219AbTAUUoE>; Tue, 21 Jan 2003 15:44:04 -0500
Date: Tue, 21 Jan 2003 20:54:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ext2 allocation failures
Message-ID: <Pine.LNX.4.44.0301212043250.2751-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For almost a year (since 2.5.4) ext2_new_block has tended to set err
0 instead of -ENOSPC or -EIO.  This manifested variously (typically
depends on what's stale in ext2_get_block's chain[4] array): sometimes
__brelse free free buffer backtraces, sometimes release_pages oops,
usually generic_make_request beyond end of device messages, followed
by further ext2 errors.

[Insert lecture on dangers of using goto for unwind :-]

Hugh

--- 2.5.59/fs/ext2/balloc.c	Tue Dec 24 06:23:03 2002
+++ linux/fs/ext2/balloc.c	Tue Jan 21 20:14:37 2003
@@ -470,10 +470,10 @@
 
 	ext2_debug ("allocating block %d. ", block);
 
+	*err = 0;
 out_release:
 	group_release_blocks(desc, gdp_bh, group_alloc);
 	release_blocks(sb, es_alloc);
-	*err = 0;
 out_unlock:
 	unlock_super (sb);
 	DQUOT_FREE_BLOCK(inode, dq_alloc);

