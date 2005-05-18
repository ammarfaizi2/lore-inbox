Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVERP2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVERP2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVERPXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:23:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19686 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262290AbVERPWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:22:44 -0400
Date: Wed, 18 May 2005 11:22:31 -0400
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Tweedie <sct@redhat.com>
Subject: [PATCH] Fix filp being passed through raw ioctl handler
Message-ID: <20050518152231.GA15602@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="raw-ioctl-filp-001.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't pass meaningless file handles to block device ioctls.

The recent raw IO ioctl-passthrough fix started passing the raw file
handle into the block device ioctl handler.  That's unlikely to be
useful, as the file handle is actually open on a character-mode raw 
device, not a block device, so dereferencing it is not going to yield 
useful results to a block device ioctl handler.

Previously we just passed NULL; also not a value that can usefully
be dereferenced, but at least if it does happen, we'll oops instead of
silently pretending that the file is a block device, so NULL is the more
defensive option here.  This patch reverts to that behaviour.

Noticed by Al Viro.

Signed-off-by: Stephen Tweedie <sct@redhat.com>
Acked-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

---
commit 844f68d0f8b098a80ccd6802c38daa7db05e00bd
tree 821049ac4ae8c959b67fab0ef8589007d6c8d048
parent ca3b9a7031878ad74f53734caba806a2ece34486
author Stephen Tweedie <sct@redhat.com> Tue, 17 May 2005 18:30:49 +0100
committer Stephen Tweedie <sct@redhat.com> Tue, 17 May 2005 18:30:49 +0100

 char/raw.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: drivers/char/raw.c
===================================================================
--- 9cbd94d6df022eeb8f467da9ad5b7ed2c6843a96/drivers/char/raw.c  (mode:100644)
+++ 821049ac4ae8c959b67fab0ef8589007d6c8d048/drivers/char/raw.c  (mode:100644)
@@ -122,7 +122,7 @@
 {
 	struct block_device *bdev = filp->private_data;
 
-	return blkdev_ioctl(bdev->bd_inode, filp, command, arg);
+	return blkdev_ioctl(bdev->bd_inode, NULL, command, arg);
 }
 
 static void bind_device(struct raw_config_request *rq)
