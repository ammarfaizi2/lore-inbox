Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbUKCXbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbUKCXbn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbUKCX2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:28:34 -0500
Received: from hera.cwi.nl ([192.16.191.8]:55463 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261999AbUKCX16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:27:58 -0500
Date: Thu, 4 Nov 2004 00:27:45 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] avoid semi-infinite loop when mounting bad ext2
Message-ID: <20041103232744.GA10325@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The routine ext2_readdir() will, when reading a directory page
returns an error, try the next page, without reporting the
error to user space. That is bad, and the patch below changes that.

In my case the filesystem was damaged, and ext2_readdir wanted
to read 60000+ pages and wrote as many error messages to syslog
("attempt to access beyond end"), not what one wants.

Andries

[no doubt a similar patch is appropriate for ext3]


diff -uprN -X /linux/dontdiff a/fs/ext2/dir.c b/fs/ext2/dir.c
--- a/fs/ext2/dir.c	2004-10-30 21:44:02.000000000 +0200
+++ b/fs/ext2/dir.c	2004-11-04 00:14:14.000000000 +0100
@@ -275,7 +275,8 @@ ext2_readdir (struct file * filp, void *
 				   "bad page in #%lu",
 				   inode->i_ino);
 			filp->f_pos += PAGE_CACHE_SIZE - offset;
-			continue;
+			ret = -EIO;
+			goto done;
 		}
 		kaddr = page_address(page);
 		if (need_revalidate) {
