Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVDUGOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVDUGOS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 02:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVDUGOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 02:14:17 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:57532 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261232AbVDUGLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 02:11:38 -0400
Subject: [patch] fix race in __block_prepare_write
From: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Content-Type: multipart/mixed; boundary="=-fm1ieqRuY4mHNT+xnOPY"
Date: Thu, 21 Apr 2005 16:11:34 +1000
Message-Id: <1114063894.5182.10.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fm1ieqRuY4mHNT+xnOPY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Questions? Comments?

-- 
SUSE Labs, Novell Inc.

--=-fm1ieqRuY4mHNT+xnOPY
Content-Disposition: attachment; filename=__block_prepare_write-bug.patch
Content-Type: text/x-patch; name=__block_prepare_write-bug.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fix a race where __block_prepare_write can leak out an in-flight
read against a bh if get_block returns an error. This can lead to
the page becoming unlocked while the buffer is locked and the read
still in flight. __mpage_writepage BUGs on this condition.

BUG sighted on a 2-way Itanium2 system with 16K PAGE_SIZE running

	fsstress -v -d $DIR/tmp -n 1000 -p 1000 -l 2
	
where $DIR is a new ext2 filesystem with 4K blocks that is quite
small (causing get_block to fail often with -ENOSPC).

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2005-04-21 11:55:17.549614278 +1000
+++ linux-2.6/fs/buffer.c	2005-04-21 15:55:41.483826075 +1000
@@ -1988,6 +1988,7 @@
 			*wait_bh++=bh;
 		}
 	}
+out:
 	/*
 	 * If we issued read requests - let them complete.
 	 */
@@ -1996,8 +1997,9 @@
 		if (!buffer_uptodate(*wait_bh))
 			return -EIO;
 	}
-	return 0;
-out:
+	if (!err)
+		return err;
+
 	/*
 	 * Zero out any newly allocated blocks to avoid exposing stale
 	 * data.  If BH_New is set, we know that the block was newly

--=-fm1ieqRuY4mHNT+xnOPY--


