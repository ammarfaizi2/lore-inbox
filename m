Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbWFUTdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWFUTdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWFUTdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:33:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8867 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932689AbWFUTdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:33:39 -0400
Date: Wed, 21 Jun 2006 20:33:33 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Milan Broz <mbroz@redhat.com>
Subject: [PATCH 03/15] dm mpath: support ioctls
Message-ID: <20060621193333.GR4521@agk.surrey.redhat.com>
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

When an ioctl is performed on a multipath device
simply pass it on to the underlying block device
through current_path. If current path is not yet selected,
select it.

Signed-off-by: Milan Broz <mbroz@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/dm-mpath.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-mpath.c	2006-06-21 17:45:15.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-mpath.c	2006-06-21 18:32:08.000000000 +0100
@@ -1266,12 +1266,39 @@ error:
 	return -EINVAL;
 }
 
+static int multipath_ioctl(struct dm_target *ti, struct inode *inode,
+			   struct file *filp, unsigned int cmd,
+			   unsigned long arg)
+{
+	struct multipath *m = (struct multipath *) ti->private;
+	struct block_device *bdev = NULL;
+	unsigned long flags;
+	int r = 0;
+
+	spin_lock_irqsave(&m->lock, flags);
+
+	if (!m->current_pgpath)
+		__choose_pgpath(m);
+
+	if (m->current_pgpath)
+		bdev = m->current_pgpath->path.dev->bdev;
+
+	if (m->queue_io)
+		r = -EAGAIN;
+	else if (!bdev)
+		r = -EIO;
+
+	spin_unlock_irqrestore(&m->lock, flags);
+
+	return r ? : blkdev_ioctl(bdev->bd_inode, filp, cmd, arg);
+}
+
 /*-----------------------------------------------------------------
  * Module setup
  *---------------------------------------------------------------*/
 static struct target_type multipath_target = {
 	.name = "multipath",
-	.version = {1, 0, 4},
+	.version = {1, 0, 5},
 	.module = THIS_MODULE,
 	.ctr = multipath_ctr,
 	.dtr = multipath_dtr,
@@ -1281,6 +1308,7 @@ static struct target_type multipath_targ
 	.resume = multipath_resume,
 	.status = multipath_status,
 	.message = multipath_message,
+	.ioctl  = multipath_ioctl,
 };
 
 static int __init dm_multipath_init(void)
