Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVDXPlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVDXPlq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 11:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVDXPlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 11:41:46 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:45720 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262345AbVDXPlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 11:41:35 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: nfsd with direct_io fix
Message-Id: <E1DPjEP-0000O7-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 24 Apr 2005 17:41:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an Oops which happens when a filesystem mounted with
the "direct_io" mount option is exported through NFS.  The problem is
that nfsd passes a kernel buffer with the "set_fs(KERNEL_DS)" method
to read and write, but get_user_pages() won't work on such a buffer.
The current fix is "don't do that then".  Long term solution will be
to implement nfs serving in userspace.  Bug spotted by David Shaw.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc2-mm3/fs/fuse/file.c linux-fuse/fs/fuse/file.c
--- linux-2.6.12-rc2-mm3/fs/fuse/file.c	2005-04-22 16:00:19.000000000 +0200
+++ linux-fuse/fs/fuse/file.c	2005-04-22 15:50:32.000000000 +0200
@@ -409,6 +409,10 @@ static int fuse_get_user_pages(struct fu
 	unsigned offset = user_addr & ~PAGE_MASK;
 	int npages;
 
+	/* This doesn't work with nfsd */
+	if (!current->mm)
+		return -EPERM;
+
 	nbytes = min(nbytes, (unsigned) FUSE_MAX_PAGES_PER_REQ << PAGE_SHIFT);
 	npages = (nbytes + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	npages = min(npages, FUSE_MAX_PAGES_PER_REQ);
