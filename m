Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbTFJPOJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTFJPOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:14:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:20674 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S262976AbTFJPOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:14:03 -0400
Date: Tue, 10 Jun 2003 16:30:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] loop 1/9 file use highmem
Message-ID: <Pine.LNX.4.44.0306101606080.2285-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the first of nine small patches to the loop driver,
mostly to reduce its pressure on zone normal when there's highmem.

I don't pretend these fix every loop hang I see and you not,
nor have I completed reinvestigating those against latest kernel.
These patches just remove what I hope we'll agree is silliness,
setting a base for further work.

(Some could conceivably make some loads worse: making better use of
highmem for data could in theory expose kmap deadlocks, I've never seen,
or permit so much more data in transit that mempool exhaustion wins:
if so, we fix those issues, rather than depending on mistakes.)

Based on 2.5.70-mm7.  Aggregate diffstat is:

 drivers/block/loop.c |   71 +++++++++++++++++++++++++++------------------
 fs/bio.c             |   79 ---------------------------------------------------
 include/linux/bio.h  |    1 
 include/linux/loop.h |    1 
 4 files changed, 43 insertions(+), 109 deletions(-)

loop 1/9 file use highmem

When loop restricts underlying file's allocation mask to avoid
deadlock, it unintentionally masks out its highmem capability,
making failures at the underlying level much more likely.

--- 2.5.70-mm7/drivers/block/loop.c	Mon Jun  9 10:14:55 2003
+++ loop1/drivers/block/loop.c	Mon Jun  9 10:29:01 2003
@@ -714,7 +714,7 @@
 		goto out_putf;
 	}
 	lo->old_gfp_mask = inode->i_mapping->gfp_mask;
-	inode->i_mapping->gfp_mask = GFP_NOIO;
+	inode->i_mapping->gfp_mask &= ~(__GFP_IO|__GFP_FS);
 
 	set_blocksize(bdev, lo_blocksize);
 

