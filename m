Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267779AbUJRW5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267779AbUJRW5o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUJRW5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:57:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:1435 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267739AbUJRWzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:55:35 -0400
Subject: [PATCH 3/3] ext3 reservation skip allocation in a "full" group
From: Mingming Cao <cmm@us.ibm.com>
To: akpm@osdl.org, "Stephen C. Tweedie" <sct@redhat.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2004 15:57:19 -0700
Message-Id: <1098140241.9692.1070.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we could not allocate a block in the "goal" group, we continue the search in the rest groups:find a new reservation window, allocate a block from there.  Since we could not allocate a block from the goal group anyway, skip the group where the number of free blocks is less than half of window size, there could be a better place to make a reservation.


---

 linux-2.6.9-rc4-mm1-ming/fs/ext3/balloc.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff -puN fs/ext3/balloc.c~ext3_skip_reservation_in_full_group fs/ext3/balloc.c
--- linux-2.6.9-rc4-mm1/fs/ext3/balloc.c~ext3_skip_reservation_in_full_group	2004-10-18 22:28:11.723757688 -0700
+++ linux-2.6.9-rc4-mm1-ming/fs/ext3/balloc.c	2004-10-18 22:28:11.732756320 -0700
@@ -1154,6 +1154,7 @@ int ext3_new_block(handle_t *handle, str
 	struct ext3_sb_info *sbi;
 	struct reserve_window_node *my_rsv = NULL;
 	struct reserve_window_node *rsv = &EXT3_I(inode)->i_rsv_window;
+	unsigned short windowsz = 0;
 #ifdef EXT3FS_DEBUG
 	static int goal_hits, goal_attempts;
 #endif
@@ -1185,9 +1186,9 @@ int ext3_new_block(handle_t *handle, str
 	 * command EXT3_IOC_SETRSVSZ to set the window size to 0 to turn off
 	 * reservation on that particular file)
 	 */
+	windowsz = atomic_read(&rsv->rsv_goal_size);
 	if (test_opt(sb, RESERVATION) &&
-		S_ISREG(inode->i_mode) &&
-		(atomic_read(&rsv->rsv_goal_size) > 0))
+		S_ISREG(inode->i_mode) && (windowsz > 0))
 		my_rsv = rsv;
 	if (!ext3_has_free_blocks(sbi)) {
 		*errp = -ENOSPC;
@@ -1240,7 +1241,12 @@ retry:
 			goto out;
 		}
 		free_blocks = le16_to_cpu(gdp->bg_free_blocks_count);
-		if (free_blocks <= 0)
+		/*
+		 * skip this group if the number of
+		 * free blocks is less than half of the reservation
+		 * window size.
+		 */
+		if (free_blocks <= (windowsz/2))
 			continue;
 
 		brelse(bitmap_bh);

_

