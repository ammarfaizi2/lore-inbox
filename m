Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUELVqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUELVqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUELVqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:46:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45506 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261661AbUELVkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:40:21 -0400
Date: Wed, 12 May 2004 17:40:06 -0400
From: Alan Cox <alan@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH: fix block layer ioctl bug
Message-ID: <20040512214006.GA25117@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The block layer checks for -EINVAL from block layer driver ioctls. This
is wrong - ENOTTY is unknown and some drivers correctly use this. I suspect
for an internal ioctl 2.7 should change to -ENOIOCTLCMD and bitch about
old style returns

This is conservative fix for the 2.6 case, it keeps the bogus -EINVAL to
avoid breaking stuff


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/block/ioctl.c linux-2.6.6/drivers/block/ioctl.c
--- linux.vanilla-2.6.6/drivers/block/ioctl.c	2004-05-10 03:31:59.000000000 +0100
+++ linux-2.6.6/drivers/block/ioctl.c	2004-05-11 20:05:09.000000000 +0100
@@ -203,7 +203,8 @@
 	case BLKROSET:
 		if (disk->fops->ioctl) {
 			ret = disk->fops->ioctl(inode, file, cmd, arg);
-			if (ret != -EINVAL)
+			/* -EINVAL to handle old uncorrected drivers */
+			if (ret != -EINVAL && ret != -ENOTTY)
 				return ret;
 		}
 		if (!capable(CAP_SYS_ADMIN))
