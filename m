Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWJTOaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWJTOaf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 10:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWJTOaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 10:30:35 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:35588 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750818AbWJTOae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 10:30:34 -0400
Message-ID: <4538DD82.3010408@openvz.org>
Date: Fri, 20 Oct 2006 18:30:26 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix potential OOPs in blkdev_open()
Content-Type: multipart/mixed;
 boundary="------------020305040602070709060403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020305040602070709060403
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

blkdev_open() calls bc_acquire() to get a struct block_device.
Since bc_acquire() may return NULL when system is out of memory
an appropriate check is required.

Signed-off-by: Pavel Emelianov <xemul@openvz.org>

--------------020305040602070709060403
Content-Type: text/plain;
 name="diff-blkdev-open-oops-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-blkdev-open-oops-fix"

--- ./fs/block_dev.c.bdopen	2006-10-17 14:49:18.000000000 +0400
+++ ./fs/block_dev.c	2006-10-20 17:32:14.000000000 +0400
@@ -1126,6 +1126,8 @@ static int blkdev_open(struct inode * in
 	filp->f_flags |= O_LARGEFILE;
 
 	bdev = bd_acquire(inode);
+	if (bdev == NULL)
+		return -ENOMEM;
 
 	res = do_open(bdev, filp, BD_MUTEX_NORMAL);
 	if (res)

--------------020305040602070709060403--
