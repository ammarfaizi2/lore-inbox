Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424339AbWKJBs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424339AbWKJBs4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 20:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424340AbWKJBs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 20:48:56 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:42580 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1424339AbWKJBsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 20:48:55 -0500
Date: Thu, 9 Nov 2006 20:48:54 -0500
From: Chris Mason <chris.mason@oracle.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: dgc@sgi.com
Subject: [PATCH] avoid too many boundaries in DIO
Message-ID: <20061110014854.GS10889@think.oraclecorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Chinner found a 10% performance regression with ext3 when using DIO
to fill holes instead of buffered IO.  On large IOs, the ext3 get_block
routine will send more than a page worth of blocks back to DIO via a
single buffer_head with a large b_size value.

The DIO code iterates through this massive block and tests for a
boundary buffer over and over again.  For every block size unit spanned
by the big map_bh, the boundary bit is tested and a bio may be forced
down to the block layer.

There are two potential fixes, one is to ignore the boundary bit on
large regions returned by the FS.  DIO can't tell which part of the big
region was a boundary, and so it may not be a good idea to trust the
hint.

This patch just clears the boundary bit after using it once.  It is 10%
faster for a streaming DIO write w/blocksize of 512k on my sata drive.

Signed-off-by: Chris Mason <chris.mason@oracle.com>

diff -r 38d08cbe880b fs/direct-io.c
--- a/fs/direct-io.c	Thu Nov 09 20:02:08 2006 -0500
+++ b/fs/direct-io.c	Thu Nov 09 20:31:12 2006 -0500
@@ -959,6 +959,17 @@ do_holes:
 			BUG_ON(this_chunk_bytes == 0);
 
 			dio->boundary = buffer_boundary(map_bh);
+
+			/*
+			 * get_block may return more than one page worth
+			 * of blocks.  Only make the first one a boundary.
+			 * This is still sub-optimal, it probably only
+			 * makes sense to play with boundaries when
+			 * get_block returns a single FS block sized
+			 * unit.
+			 */
+			clear_buffer_boundary(map_bh);
+
 			ret = submit_page_section(dio, page, offset_in_page,
 				this_chunk_bytes, dio->next_block_for_io);
 			if (ret) {
