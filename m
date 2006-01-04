Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWADNU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWADNU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 08:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWADNUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 08:20:21 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:16778 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751785AbWADNTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 08:19:17 -0500
Message-Id: <20060104131843.317180000@dorka.pomaz.szeredi.hu>
References: <20060104131530.511388000@dorka.pomaz.szeredi.hu>
Date: Wed, 04 Jan 2006 14:15:35 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] fuse: ensure progress in read and write
Content-Disposition: inline; filename=fuse_at_least_one_page.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In direct_io mode, send at least one page per reqest.  Previously it
was possible that reqests with zero data were sent, and hence the
read/write didn't make any progress, resulting in an infinite (though
interruptible) loop.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-01-04 12:37:52.000000000 +0100
+++ linux/fs/fuse/file.c	2006-01-04 12:37:56.000000000 +0100
@@ -475,7 +475,7 @@ static int fuse_get_user_pages(struct fu
 
 	nbytes = min(nbytes, (unsigned) FUSE_MAX_PAGES_PER_REQ << PAGE_SHIFT);
 	npages = (nbytes + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	npages = min(npages, FUSE_MAX_PAGES_PER_REQ);
+	npages = min(max(npages, 1), FUSE_MAX_PAGES_PER_REQ);
 	down_read(&current->mm->mmap_sem);
 	npages = get_user_pages(current, current->mm, user_addr, npages, write,
 				0, req->pages, NULL);
@@ -506,7 +506,6 @@ static ssize_t fuse_direct_io(struct fil
 		return -EINTR;
 
 	while (count) {
-		size_t tmp;
 		size_t nres;
 		size_t nbytes = min(count, nmax);
 		int err = fuse_get_user_pages(req, buf, nbytes, !write);
@@ -514,8 +513,8 @@ static ssize_t fuse_direct_io(struct fil
 			res = err;
 			break;
 		}
-		tmp = (req->num_pages << PAGE_SHIFT) - req->page_offset;
-		nbytes = min(nbytes, tmp);
+		nbytes = (req->num_pages << PAGE_SHIFT) - req->page_offset;
+		nbytes = min(count, nbytes);
 		if (write)
 			nres = fuse_send_write(req, file, inode, pos, nbytes);
 		else

--
