Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUBJRGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUBJRED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:04:03 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:6159 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S266024AbUBJRBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:01:13 -0500
Date: Tue, 10 Feb 2004 17:01:10 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [Patch 6/10] dm: block size bug with 64 bit devs
Message-ID: <20040210170110.GL27507@reti>
References: <20040210163548.GC27507@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210163548.GC27507@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 32 bit sector_t the block device size _in bytes_ is also cut to
32 bit in __set_size when the block device is mount (a filesystem
mounted). The argument should be cast to loff_t before expanding the
sector count to a byte count and calling i_size_write.

[Christophe Saout]
--- diff/drivers/md/dm.c	2004-02-10 16:11:43.000000000 +0000
+++ source/drivers/md/dm.c	2004-02-10 16:11:50.000000000 +0000
@@ -639,7 +639,7 @@
 	bdev = bdget_disk(disk, 0);
 	if (bdev) {
 		down(&bdev->bd_inode->i_sem);
-		i_size_write(bdev->bd_inode, size << SECTOR_SHIFT);
+		i_size_write(bdev->bd_inode, (loff_t)size << SECTOR_SHIFT);
 		up(&bdev->bd_inode->i_sem);
 		bdput(bdev);
 	}
