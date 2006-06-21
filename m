Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbWFUTdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbWFUTdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbWFUTdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:33:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42914 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932688AbWFUTdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:33:15 -0400
Date: Wed, 21 Jun 2006 20:33:08 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Milan Broz <mbroz@redhat.com>
Subject: [PATCH 02/15] dm linear: support ioctls
Message-ID: <20060621193308.GQ4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Milan Broz <mbroz@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Broz <mbroz@redhat.com>

When an ioctl is performed on a device with a linear target, simply
pass it on to the underlying block device.

Note that the ioctl will pass through the filtering in blkdev_ioctl()
twice.
 
Signed-off-by: Milan Broz <mbroz@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/dm-linear.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-linear.c	2006-06-21 17:45:16.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-linear.c	2006-06-21 18:32:07.000000000 +0100
@@ -96,14 +96,25 @@ static int linear_status(struct dm_targe
 	return 0;
 }
 
+static int linear_ioctl(struct dm_target *ti, struct inode *inode,
+			struct file *filp, unsigned int cmd,
+			unsigned long arg)
+{
+	struct linear_c *lc = (struct linear_c *) ti->private;
+	struct block_device *bdev = lc->dev->bdev;
+
+	return blkdev_ioctl(bdev->bd_inode, filp, cmd, arg);
+}
+
 static struct target_type linear_target = {
 	.name   = "linear",
-	.version= {1, 0, 1},
+	.version= {1, 0, 2},
 	.module = THIS_MODULE,
 	.ctr    = linear_ctr,
 	.dtr    = linear_dtr,
 	.map    = linear_map,
 	.status = linear_status,
+	.ioctl  = linear_ioctl,
 };
 
 int __init dm_linear_init(void)
