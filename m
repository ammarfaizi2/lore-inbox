Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263249AbSJCMHU>; Thu, 3 Oct 2002 08:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263250AbSJCMHU>; Thu, 3 Oct 2002 08:07:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61956 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263249AbSJCMHS>; Thu, 3 Oct 2002 08:07:18 -0400
Date: Thu, 3 Oct 2002 13:12:41 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: initrd breakage in 2.5.38-2.5.40
Message-ID: <20021003131240.B2304@flint.arm.linux.org.uk>
References: <15772.9013.244887.809979@kim.it.uu.se> <Pine.GSO.4.21.0210030702500.13480-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0210030702500.13480-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Oct 03, 2002 at 07:07:21AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 07:07:21AM -0400, Alexander Viro wrote:
> On Thu, 3 Oct 2002, Mikael Pettersson wrote:
> 
> > First I thought the problem was caused by a apparently missing
> > set_capacity() call in 2.5.38's drivers/block/rd.c:
> 
> I _really_ doubt it - check the loop just above the add_disk() one.
> set_capacity() call is done there, repeating it won't change anything.

My mtdblock problems are probably related to this, so I'll followup here.

mtdblock registers its gendisk structure in its open() method.
Unfortunately, do_open wants to obtain this structure before
the open() method (but doesn't use it.)

This patch trivially re-orders stuff to work, and works for me
(with mtdblock.)

--- orig/fs/block_dev.c	Thu Oct  3 12:46:08 2002
+++ linux/fs/block_dev.c	Thu Oct  3 13:08:10 2002
@@ -631,7 +631,7 @@
 	}
 	if (bdev->bd_contains == bdev) {
 		int part;
-		struct gendisk *g = get_gendisk(bdev->bd_dev, &part);
+		struct gendisk *g;
 
 		if (!bdev->bd_queue) {
 			struct blk_dev_struct *p = blk_dev + major(dev);
@@ -645,6 +645,7 @@
 			if (ret)
 				goto out2;
 		}
+		g = get_gendisk(bdev->bd_dev, &part);
 		if (!bdev->bd_openers) {
 			struct backing_dev_info *bdi;
 			sector_t sect = 0;

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

