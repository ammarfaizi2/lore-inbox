Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbUC2REx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUC2RD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:03:56 -0500
Received: from ns.suse.de ([195.135.220.2]:6302 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262983AbUC2Qs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 11:48:59 -0500
Subject: [PATCH] loop setup calling bd_set_size too soon
From: Chris Mason <mason@suse.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1080578929.20683.126.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 11:48:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think Andrew and I managed to mismerge the loop setup race fix. 
loop_set_fd is using get_capacity() to read the size of the disk and
sending that to bd_set_size.

But, it is doing this before calling set_capacity, so the size being
used is wrong.  This should clean things up:

Index: linux.t/drivers/block/loop.c
===================================================================
--- linux.t.orig/drivers/block/loop.c	2004-03-29 10:47:07.809522824 -0500
+++ linux.t/drivers/block/loop.c	2004-03-29 10:53:24.376275976 -0500
@@ -687,7 +687,6 @@ static int loop_set_fd(struct loop_devic
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
 	lo->lo_sizelimit = 0;
-	bd_set_size(bdev,(loff_t)get_capacity(disks[lo->lo_number])<<9);
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
@@ -702,6 +701,7 @@ static int loop_set_fd(struct loop_devic
 	lo->lo_queue->unplug_fn = loop_unplug;
 
 	set_capacity(disks[lo->lo_number], size);
+	bd_set_size(bdev, size << 9);
 
 	set_blocksize(bdev, lo_blocksize);
 




