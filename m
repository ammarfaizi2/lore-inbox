Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270112AbTGMFDb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 01:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270113AbTGMFDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 01:03:31 -0400
Received: from dm2-67.slc.aros.net ([66.219.220.67]:53988 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S270112AbTGMFDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 01:03:30 -0400
Message-ID: <3F10EB94.3060509@aros.net>
Date: Sat, 12 Jul 2003 23:18:12 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: [PATCH] BLKBSZSET ioctl: fixes possibly silent blocksize change failure
Content-Type: multipart/mixed;
 boundary="------------070704000108070903070700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070704000108070903070700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here's a small patch that fixes a failure to return -EINVAL to user when 
calling the BLKBSZSET ioctl and the requested new blocksize passed in is 
smaller than bdev_hardsect_size(bdev). This patch applies against 2.5.75 
through 2.5.75-bk2 (I have not tried applying the patch against any 
other releases). A quick glance at the 2.4.20 code shows the same bug to 
exist their too (as I suspect is in later 2.4 release also). A side 
effect of this patch is that checking is re-ordered between checking if 
busy and whether the new blocksize is valid. Programs expecting this 
ioctl to validate the new size before checking if busy would need to be 
updated to handle the new checking order.

--------------070704000108070903070700
Content-Type: text/plain;
 name="blocksize.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blocksize.diff"

diff -urN linux-2.5.75/drivers/block/ioctl.c linux-2.5.75-patched/drivers/block/ioctl.c
--- linux-2.5.75/drivers/block/ioctl.c	2003-07-10 14:04:46.000000000 -0600
+++ linux-2.5.75-patched/drivers/block/ioctl.c	2003-07-12 16:35:27.421331789 -0600
@@ -166,13 +166,11 @@
 			return -EINVAL;
 		if (get_user(n, (int *) arg))
 			return -EFAULT;
-		if (n > PAGE_SIZE || n < 512 || (n & (n - 1)))
-			return -EINVAL;
 		if (bd_claim(bdev, &holder) < 0)
 			return -EBUSY;
-		set_blocksize(bdev, n);
+		ret = set_blocksize(bdev, n);
 		bd_release(bdev);
-		return 0;
+		return ret;
 	case BLKPG:
 		return blkpg_ioctl(bdev, (struct blkpg_ioctl_arg *) arg);
 	case BLKRRPART:

--------------070704000108070903070700--

