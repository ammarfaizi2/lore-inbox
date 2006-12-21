Return-Path: <linux-kernel-owner+w=401wt.eu-S964776AbWLUOSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWLUOSs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbWLUOSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:18:48 -0500
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:48737 "EHLO
	mail-gw1.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbWLUOSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:18:47 -0500
To: akpm@osdl.org
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] fuse: remove clear_page_dirty() call
Message-Id: <E1GxOkZ-0000YX-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 21 Dec 2006 15:18:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And with that, I then either rip out any old users of 
> "test_clear_page_dirty()" or "clear_page_dirty()", and if appropriate (and 
> it's realy lonly appropriate for "truncate()", I replace them with the new 
> "cancel_dirty_page()". Most of the time, they should just be deleted 
> entirely.
> 
> NOTE NOTE NOTE! I _only_ did enough to make things compile for my 
> particular configuration. That means that right now the following 
> filesystems are broken with this patch (because they use the totally 
> broken old crap):
> 
> 	CIFS, FUSE, JFS, ReiserFS, XFS

The use by FUSE was just a remnant of an optimization from the time
when writable mappings were supported.

Now FUSE never actually allows the creation of dirty pages, so this
invocation of clear_page_dirty() is effectively a no-op.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-12-21 15:06:32.000000000 +0100
+++ linux/fs/fuse/file.c	2006-12-21 15:07:02.000000000 +0100
@@ -483,10 +483,8 @@ static int fuse_commit_write(struct file
 			i_size_write(inode, pos);
 		spin_unlock(&fc->lock);
 
-		if (offset == 0 && to == PAGE_CACHE_SIZE) {
-			clear_page_dirty(page);
+		if (offset == 0 && to == PAGE_CACHE_SIZE)
 			SetPageUptodate(page);
-		}
 	}
 	fuse_invalidate_attr(inode);
 	return err;

