Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbUCFAkY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 19:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUCFAkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 19:40:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:29349 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261502AbUCFAkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 19:40:16 -0500
Subject: [PATCH 2.6.3-mm4] writeback trylock patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Hugh Dickins <hugh@veritas.com>
Content-Type: multipart/mixed; boundary="=-y1g3xlq3x6B3KaftlBYl"
Organization: 
Message-Id: <1078533612.1773.37.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Mar 2004 16:40:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y1g3xlq3x6B3KaftlBYl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

Here is update to the wb_rwsema patch that adds back the trylock.
It avoids the hang hugh was seeing by setting encountered_congestion
if the trylock fails and checking it in sync_sb_inodes().  Hugh
tested this and did not see the hang.

This prevents non-sync writebacks to from blocking behind sync
writebacks.

This patch applies to 2.6.4-rc1-mm2.

Thoguhts?

Daniel

--=-y1g3xlq3x6B3KaftlBYl
Content-Disposition: attachment; filename=263-mm4.writeback.trylock.patch
Content-Type: text/x-patch; name=263-mm4.writeback.trylock.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -rup linux-2.6.3-mm4.orig/fs/fs-writeback.c linux-2.6.3-mm4/fs/fs-writeback.c
--- linux-2.6.3-mm4.orig/fs/fs-writeback.c	2004-02-27 16:45:44.956839646 -0800
+++ linux-2.6.3-mm4/fs/fs-writeback.c	2004-02-27 16:57:38.746524736 -0800
@@ -158,10 +158,14 @@ __sync_single_inode(struct inode *inode,
 		 * for all i/o without worrying about racing WB_SYNC_NONE
 		 * writers.
 		 */
-		if (wait)
+		if (wait) {
 			down_write(&mapping->wb_rwsema);
-		else
-			down_read(&mapping->wb_rwsema);
+		} else {
+			if (!down_read_trylock(&mapping->wb_rwsema)) {
+				wbc->encountered_congestion = 1;
+				goto skip_writeback;
+			}
+		}
 	}
 
 	/*
@@ -184,6 +188,7 @@ __sync_single_inode(struct inode *inode,
 			up_read(&mapping->wb_rwsema);
 	}
 
+skip_writeback:
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
 		write_inode(inode, wait);
@@ -310,7 +315,12 @@ sync_sb_inodes(struct super_block *sb, s
 			break;
 		}
 
-		if (wbc->nonblocking && bdi_write_congested(bdi)) {
+		/*
+		 * wbc->encountered_congestion is set if we cannot get
+		 * the wb_rwsema.
+		 */
+		if (wbc->nonblocking &&
+		    (bdi_write_congested(bdi) || wbc->encountered_congestion)) {
 			wbc->encountered_congestion = 1;
 			if (sb != blockdev_superblock)
 				break;		/* Skip a congested fs */
diff -rup linux-2.6.3-mm4.orig/mm/filemap.c linux-2.6.3-mm4/mm/filemap.c
--- linux-2.6.3-mm4.orig/mm/filemap.c	2004-02-27 16:47:56.351858126 -0800
+++ linux-2.6.3-mm4/mm/filemap.c	2004-02-27 16:49:29.044938317 -0800
@@ -152,9 +152,10 @@ static int __filemap_fdatawrite(struct a
 		return 0;
 
 	if (!blkdev) {
-		if (sync_mode == WB_SYNC_NONE)
-			down_read(&mapping->wb_rwsema);
-		else
+		if (sync_mode == WB_SYNC_NONE) {
+			if (!down_read_trylock(&mapping->wb_rwsema))
+				return 0;
+		} else 
 			down_write(&mapping->wb_rwsema);
 	}
 

--=-y1g3xlq3x6B3KaftlBYl--

