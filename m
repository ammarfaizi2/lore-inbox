Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261713AbSIXSSV>; Tue, 24 Sep 2002 14:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261754AbSIXSSV>; Tue, 24 Sep 2002 14:18:21 -0400
Received: from [198.149.18.6] ([198.149.18.6]:31951 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261713AbSIXSSU>;
	Tue, 24 Sep 2002 14:18:20 -0400
Subject: [PATCH] 2.4.19 place buffer dirtied in truncate() on inode's dirty
	data list
From: Eric Sandeen <sandeen@sgi.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 24 Sep 2002 13:23:29 -0500
Message-Id: <1032891809.4190.108.camel@stout.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is for 2.4.x:

block_truncate_page() does a __mark_buffer_dirty(bh) at the end, but it
does not file the buffer on the inode's dirty data queue, so only
bdflush can ever get to it, and other sync mechanisms which call
fsync_inode_data_buffers() do not see it.

This was causing a particular problem with O_DIRECT on an xfs
filesystem, since O_DIRECT tries to sync before doing the I/O. 
Following a truncate(), O_DIRECT reads of the last block were not
returning the correct data, since the truncate never got synced down to
disk.

ext2 does not seem to be able to do an O_DIRECT read of the last
filesytem block, unless the file size is a multiple of block size, so it
doesn't show up there.

--- linux/fs/buffer.c_1.109     Mon Sep 23 13:10:56 2002
+++ linux/fs/buffer.c   Mon Sep 23 13:04:44 2002
@@ -2028,7 +2028,12 @@
        flush_dcache_page(page);
        kunmap(page);
 
-       __mark_buffer_dirty(bh);
+       if (!atomic_set_buffer_dirty(bh)) {
+               __mark_dirty(bh);
+               buffer_insert_inode_data_queue(bh, inode);
+               balance_dirty();
+       }
+
        err = 0;


The balance_dirty() call is debatable, Andrew Morton pointed out that it
does add a bit more risk.  OTOH, if you go off and truncate a million
files in a row, you'll be in sorry shape without it.

2.5 apparently does not have this problem, it calls mark_buffer_dirty()
which seems to take care of things.

-Eric

-- 
Eric Sandeen      XFS for Linux     http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.         651-683-3102

