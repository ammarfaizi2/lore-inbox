Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUCDGJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 01:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbUCDGJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 01:09:56 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:39133 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261464AbUCDGJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 01:09:54 -0500
Date: Thu, 4 Mar 2004 00:09:48 -0600 (CST)
From: Eric Sandeen <sandeen@sgi.com>
X-X-Sender: sandeen@stout.americas.sgi.com
To: linux-kernel@vger.kernel.org, <lbd@gelato.unsw.edu.au>
cc: neilb@cse.unsw.edu.au
Subject: [PATCH] LBD fix for 2.6.3
Message-ID: <Pine.LNX.4.44.0403040001460.24142-100000@stout.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple xfs users stumbled upon this problem while trying to
use 2.6 + CONFIG_LBD on ia32 boxes - mkfs.xfs followed by
xfs_repair was failing.  At first we thought it was
a raid/md problem, but it's more generic than that.  There's
a problem in __block_write_full_page():

--- linux-2.6.3/fs/buffer.c.orig	2004-03-04 00:01:42.000000000 -0600
+++ linux-2.6.3/fs/buffer.c		2004-03-03 23:46:56.000000000 -0600
@@ -1738,8 +1738,8 @@
 			get_block_t *get_block, struct writeback_control *wbc)
 {
 	int err;
-	unsigned long block;
-	unsigned long last_block;
+	sector_t block;
+	sector_t last_block;
 	struct buffer_head *bh, *head;
 	int nr_underway = 0;
 
later in the function we do:
	last_block = (i_size_read(inode) - 1) >> inode->i_blkbits;
and
	block = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);

... these overflow 32 bits for large devices.

The sophisticated mkfs/repair test works with that patch in place.  ;)

-Eric

