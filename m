Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261769AbSJIOb4>; Wed, 9 Oct 2002 10:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261781AbSJIOb4>; Wed, 9 Oct 2002 10:31:56 -0400
Received: from mailout.zma.compaq.com ([161.114.64.105]:29710 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S261769AbSJIObz>; Wed, 9 Oct 2002 10:31:55 -0400
Date: Wed, 9 Oct 2002 08:33:49 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.41, cciss, fix cciss_open (2 of 5)
Message-ID: <20021009083349.B6746@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch fixes a problem with detecting partitions on any but 
the first disk.  Detecting the partitions requires opening the device,
but the i_size test prevented this, except for the special case of c0d0.
The new test corrects this, allow partition tables to be read for all the
disks.  Applies to 2.5.40.

diff -urN linux-2.5.40-0/drivers/block/cciss.c linux-2.5.40-cciss-fix-vol/drivers/block/cciss.c
--- linux-2.5.40-0/drivers/block/cciss.c	Thu Oct  3 14:25:16 2002
+++ linux-2.5.40-cciss-fix-vol/drivers/block/cciss.c	Mon Oct  7 09:09:50 2002
@@ -352,7 +352,7 @@
 	 * but I'm already using way to many device nodes to claim another one
 	 * for "raw controller".
 	 */
-	if (inode->i_bdev->bd_inode->i_size == 0) {
+	if (hba[ctlr]->drv[dsk].nr_blocks == 0) {
 		if (minor(inode->i_rdev) != 0)
 			return -ENXIO;
 		if (!capable(CAP_SYS_ADMIN))
