Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVGKQB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVGKQB1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGKP7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:59:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37316 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262142AbVGKP5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:57:20 -0400
Date: Mon, 11 Jul 2005 17:57:14 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] Change ll_rw_block() calls in UFS
Message-ID: <20050711155714.GU12428@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

  attached patch changes UFS to use SWRITE when sending data to disk in
O_SYNC mode. Please apply.

								Honza


-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ufs-2.6.12-ll_rw_block-fix.diff"

We need to be sure that current data are sent to disk. Hence we call
ll_rw_block() with SWRITE.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-1-forgetfix/fs/ufs/balloc.c linux-2.6.12-2-ll_rw_block-fix/fs/ufs/balloc.c
--- linux-2.6.12-1-forgetfix/fs/ufs/balloc.c	2005-01-05 17:19:34.000000000 +0100
+++ linux-2.6.12-2-ll_rw_block-fix/fs/ufs/balloc.c	2005-07-09 02:00:04.000000000 +0200
@@ -114,8 +114,7 @@ void ufs_free_fragments (struct inode * 
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ubh_wait_on_buffer (UCPI_UBH);
-		ubh_ll_rw_block (WRITE, 1, (struct ufs_buffer_head **)&ucpi);
+		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **)&ucpi);
 		ubh_wait_on_buffer (UCPI_UBH);
 	}
 	sb->s_dirt = 1;
@@ -200,8 +199,7 @@ do_more:
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ubh_wait_on_buffer (UCPI_UBH);
-		ubh_ll_rw_block (WRITE, 1, (struct ufs_buffer_head **)&ucpi);
+		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **)&ucpi);
 		ubh_wait_on_buffer (UCPI_UBH);
 	}
 
@@ -459,8 +457,7 @@ ufs_add_fragments (struct inode * inode,
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ubh_wait_on_buffer (UCPI_UBH);
-		ubh_ll_rw_block (WRITE, 1, (struct ufs_buffer_head **)&ucpi);
+		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **)&ucpi);
 		ubh_wait_on_buffer (UCPI_UBH);
 	}
 	sb->s_dirt = 1;
@@ -585,8 +582,7 @@ succed:
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ubh_wait_on_buffer (UCPI_UBH);
-		ubh_ll_rw_block (WRITE, 1, (struct ufs_buffer_head **)&ucpi);
+		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **)&ucpi);
 		ubh_wait_on_buffer (UCPI_UBH);
 	}
 	sb->s_dirt = 1;
diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-1-forgetfix/fs/ufs/ialloc.c linux-2.6.12-2-ll_rw_block-fix/fs/ufs/ialloc.c
--- linux-2.6.12-1-forgetfix/fs/ufs/ialloc.c	2005-03-03 18:58:30.000000000 +0100
+++ linux-2.6.12-2-ll_rw_block-fix/fs/ufs/ialloc.c	2005-07-09 02:01:06.000000000 +0200
@@ -124,8 +124,7 @@ void ufs_free_inode (struct inode * inod
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ubh_wait_on_buffer (UCPI_UBH);
-		ubh_ll_rw_block (WRITE, 1, (struct ufs_buffer_head **) &ucpi);
+		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **) &ucpi);
 		ubh_wait_on_buffer (UCPI_UBH);
 	}
 	
@@ -249,8 +248,7 @@ cg_found:
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ubh_wait_on_buffer (UCPI_UBH);
-		ubh_ll_rw_block (WRITE, 1, (struct ufs_buffer_head **) &ucpi);
+		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **) &ucpi);
 		ubh_wait_on_buffer (UCPI_UBH);
 	}
 	sb->s_dirt = 1;
diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-1-forgetfix/fs/ufs/truncate.c linux-2.6.12-2-ll_rw_block-fix/fs/ufs/truncate.c
--- linux-2.6.12-1-forgetfix/fs/ufs/truncate.c	2005-03-03 18:58:30.000000000 +0100
+++ linux-2.6.12-2-ll_rw_block-fix/fs/ufs/truncate.c	2005-07-09 02:01:52.000000000 +0200
@@ -285,8 +285,7 @@ next:;
 		}
 	}
 	if (IS_SYNC(inode) && ind_ubh && ubh_buffer_dirty(ind_ubh)) {
-		ubh_wait_on_buffer (ind_ubh);
-		ubh_ll_rw_block (WRITE, 1, &ind_ubh);
+		ubh_ll_rw_block (SWRITE, 1, &ind_ubh);
 		ubh_wait_on_buffer (ind_ubh);
 	}
 	ubh_brelse (ind_ubh);
@@ -353,8 +352,7 @@ static int ufs_trunc_dindirect (struct i
 		}
 	}
 	if (IS_SYNC(inode) && dind_bh && ubh_buffer_dirty(dind_bh)) {
-		ubh_wait_on_buffer (dind_bh);
-		ubh_ll_rw_block (WRITE, 1, &dind_bh);
+		ubh_ll_rw_block (SWRITE, 1, &dind_bh);
 		ubh_wait_on_buffer (dind_bh);
 	}
 	ubh_brelse (dind_bh);
@@ -418,8 +416,7 @@ static int ufs_trunc_tindirect (struct i
 		}
 	}
 	if (IS_SYNC(inode) && tind_bh && ubh_buffer_dirty(tind_bh)) {
-		ubh_wait_on_buffer (tind_bh);
-		ubh_ll_rw_block (WRITE, 1, &tind_bh);
+		ubh_ll_rw_block (SWRITE, 1, &tind_bh);
 		ubh_wait_on_buffer (tind_bh);
 	}
 	ubh_brelse (tind_bh);

--kA1LkgxZ0NN7Mz3A--
