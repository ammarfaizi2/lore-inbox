Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUJRW47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUJRW47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbUJRWyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:54:25 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:5073 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267683AbUJRWyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:54:09 -0400
Subject: [PATCH 2/3] ext3 reservation allow turn off for specifed file
From: Mingming Cao <cmm@us.ibm.com>
To: akpm@osdl.org, "Stephen C. Tweedie" <sct@redhat.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
In-Reply-To: <1097879695.4591.61.camel@localhost.localdomain>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
	<1097856114.4591.28.camel@localhost.localdomain>
	<1097858401.1968.148.camel@sisko.scot.redhat.com>
	<1097872144.4591.54.camel@localhost.localdomain>
	<1097878826.1968.162.camel@sisko.scot.redhat.com> 
	<1097879695.4591.61.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2004 15:55:20 -0700
Message-Id: <1098140129.9754.1064.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow user shut down reservation-based allocation(using ioctl) on a specific file(e.g. for seeky random write).


---

 linux-2.6.9-rc4-mm1-ming/fs/ext3/balloc.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff -puN fs/ext3/balloc.c~ext3_shutdown_reservation_per-file fs/ext3/balloc.c
--- linux-2.6.9-rc4-mm1/fs/ext3/balloc.c~ext3_shutdown_reservation_per-file	2004-10-18 22:27:06.333698488 -0700
+++ linux-2.6.9-rc4-mm1-ming/fs/ext3/balloc.c	2004-10-18 22:34:52.825780912 -0700
@@ -1153,6 +1153,7 @@ int ext3_new_block(handle_t *handle, str
 	struct ext3_super_block *es;
 	struct ext3_sb_info *sbi;
 	struct reserve_window_node *my_rsv = NULL;
+	struct reserve_window_node *rsv = &EXT3_I(inode)->i_rsv_window;
 #ifdef EXT3FS_DEBUG
 	static int goal_hits, goal_attempts;
 #endif
@@ -1176,8 +1177,18 @@ int ext3_new_block(handle_t *handle, str
 	sbi = EXT3_SB(sb);
 	es = EXT3_SB(sb)->s_es;
 	ext3_debug("goal=%lu.\n", goal);
-	if (test_opt(sb, RESERVATION) && S_ISREG(inode->i_mode))
-		my_rsv = &EXT3_I(inode)->i_rsv_window;
+	/*
+	 * Allocate a block from reservation only when
+	 * filesystem is mounted with reservation(default,-o reservation), and
+	 * it's a regular file, and
+	 * the desired window size is greater than 0 (One could use ioctl
+	 * command EXT3_IOC_SETRSVSZ to set the window size to 0 to turn off
+	 * reservation on that particular file)
+	 */
+	if (test_opt(sb, RESERVATION) &&
+		S_ISREG(inode->i_mode) &&
+		(atomic_read(&rsv->rsv_goal_size) > 0))
+		my_rsv = rsv;
 	if (!ext3_has_free_blocks(sbi)) {
 		*errp = -ENOSPC;
 		goto out;

_

