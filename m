Return-Path: <linux-kernel-owner+w=401wt.eu-S932478AbXAJAi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbXAJAi5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 19:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbXAJAi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 19:38:57 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52511 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932478AbXAJAiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 19:38:55 -0500
Date: Wed, 10 Jan 2007 11:38:19 +1100
From: David Chinner <dgc@sgi.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: [PATCH 2 of 2]: Make XFS use BH_Unwritten and BH_Delay correctly
Message-ID: <20070110003819.GO44411608@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't hide buffer_unwritten behind buffer_delay() and
remove the hack that clears unexpected buffer_unwritten()
states now that it can't happen.

Signed-Off-By: Dave Chinner <dgc@sgi.com>

---
 fs/xfs/linux-2.6/xfs_aops.c |   3 ---
 1 file changed, 29 deletions(-)

Index: 2.6.x-xfs-new/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/xfs/linux-2.6/xfs_aops.c	2007-01-08 12:21:40.000000000 +1100
+++ 2.6.x-xfs-new/fs/xfs/linux-2.6/xfs_aops.c	2007-01-09 11:05:09.763127643 +1100
@@ -58,8 +58,6 @@ xfs_count_page_state(
 	do {
 		if (buffer_uptodate(bh) && !buffer_mapped(bh))
 			(*unmapped) = 1;
-		else if (buffer_unwritten(bh) && !buffer_delay(bh))
-			clear_buffer_unwritten(bh);
 		else if (buffer_unwritten(bh))
 			(*unwritten) = 1;
 		else if (buffer_delay(bh))
@@ -1271,7 +1269,6 @@ __xfs_get_blocks(
 			if (direct)
 				bh_result->b_private = inode;
 			set_buffer_unwritten(bh_result);
-			set_buffer_delay(bh_result);
 		}
 	}
 
