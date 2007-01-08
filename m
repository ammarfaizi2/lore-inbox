Return-Path: <linux-kernel-owner+w=401wt.eu-S1030445AbXAHWuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbXAHWuS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbXAHWuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:50:17 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:55063 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030438AbXAHWuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:50:16 -0500
Date: Tue, 9 Jan 2007 09:49:32 +1100
From: David Chinner <dgc@sgi.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Make BH_Unwritten a first class bufferhead flag
Message-ID: <20070108224932.GZ33919298@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, XFS uses BH_PrivateStart for flagging unwritten
extent state in a bufferhead. Recently, i found the long standing
mmap/unwritten extent conversion bug, and it was to do with
partial page invalidation not clearing the unwritten flag from
bufferheads attached to the page but beyond EOF. See here
for a full explaination:

http://oss.sgi.com/archives/xfs/2006-12/msg00196.html

The solution I have checked into the XFS dev tree involves
duplicating code from block_invalidatepage to clear the
unwritten flag from the bufferhead(s), and then calling
block_invalidatepage() to do the rest.

Christoph suggested that this would be better solved by
pushing the unwritten flag into the common buffer head flags
and just adding the call to discard_buffer():

http://oss.sgi.com/archives/xfs/2006-12/msg00239.html

The following patch makes BH_Unwritten a first class citizen.
Patch against 2.6.20-rc3.

Signed-Off-By: Dave Chinner <dgc@sgi.com>

---
 fs/buffer.c                  |    1 +
 fs/xfs/linux-2.6/xfs_linux.h |   10 ----------
 include/linux/buffer_head.h  |    2 ++
 3 files changed, 3 insertions(+), 10 deletions(-)

Index: linux/fs/buffer.c
===================================================================
--- linux.orig/fs/buffer.c	2007-01-08 17:19:49.039465038 +1100
+++ linux/fs/buffer.c	2007-01-08 17:20:43.547898480 +1100
@@ -1439,6 +1439,7 @@ static void discard_buffer(struct buffer
 	clear_buffer_req(bh);
 	clear_buffer_new(bh);
 	clear_buffer_delay(bh);
+	clear_buffer_unwritten(bh);
 	unlock_buffer(bh);
 }
 
Index: linux/fs/xfs/linux-2.6/xfs_linux.h
===================================================================
--- linux.orig/fs/xfs/linux-2.6/xfs_linux.h	2007-01-08 17:19:32.703335135 +1100
+++ linux/fs/xfs/linux-2.6/xfs_linux.h	2007-01-08 17:19:36.271363508 +1100
@@ -109,16 +109,6 @@
 #undef  HAVE_PERCPU_SB	/* per cpu superblock counters are a 2.6 feature */
 #endif
 
-/*
- * State flag for unwritten extent buffers.
- *
- * We need to be able to distinguish between these and delayed
- * allocate buffers within XFS.  The generic IO path code does
- * not need to distinguish - we use the BH_Delay flag for both
- * delalloc and these ondisk-uninitialised buffers.
- */
-BUFFER_FNS(PrivateStart, unwritten);
-
 #define restricted_chown	xfs_params.restrict_chown.val
 #define irix_sgid_inherit	xfs_params.sgid_inherit.val
 #define irix_symlink_mode	xfs_params.symlink_mode.val
Index: linux/include/linux/buffer_head.h
===================================================================
--- linux.orig/include/linux/buffer_head.h	2007-01-08 17:17:15.118241081 +1100
+++ linux/include/linux/buffer_head.h	2007-01-08 17:18:25.714802453 +1100
@@ -34,6 +34,7 @@ enum bh_state_bits {
 	BH_Write_EIO,	/* I/O error on write */
 	BH_Ordered,	/* ordered write */
 	BH_Eopnotsupp,	/* operation not supported (barrier) */
+	BH_Unwritten,	/* Buffer is allocated on disk but not written */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
@@ -126,6 +127,7 @@ BUFFER_FNS(Boundary, boundary)
 BUFFER_FNS(Write_EIO, write_io_error)
 BUFFER_FNS(Ordered, ordered)
 BUFFER_FNS(Eopnotsupp, eopnotsupp)
+BUFFER_FNS(Unwritten, unwritten)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 #define touch_buffer(bh)	mark_page_accessed(bh->b_page)
