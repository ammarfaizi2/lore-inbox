Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbTLRVfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 16:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265336AbTLRVfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 16:35:06 -0500
Received: from citi.umich.edu ([141.211.133.111]:45703 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S265335AbTLRVfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 16:35:01 -0500
Date: Thu, 18 Dec 2003 16:34:58 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Steve Dickson <SteveD@redhat.com>, <greg.marsden@oracle.com>
Subject: [PATCH] NFS O_DIRECT offset wrap bug
Message-ID: <Pine.BSO.4.33.0312181631330.3379-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi marcelo-

here's an obvious mistake i made in the NFS O_DIRECT implementation.  a
missing type cast causes the offset of direct read and write requests to
wrap at 4GB.  please include this in 2.4.24-pre2.

as far as i can tell, this is not a problem for 2.6 NFS O_DIRECT.


diff -X ../dont-diff -Naurp 00-stock/fs/nfs/direct.c 01-direct-offset/fs/nfs/direct.c
--- 00-stock/fs/nfs/direct.c	2003-08-25 07:44:43.000000000 -0400
+++ 01-direct-offset/fs/nfs/direct.c	2003-12-18 16:28:20.000000000 -0500
@@ -354,7 +354,7 @@ nfs_direct_IO(int rw, struct file *file,
 	size_t count = iobuf->length;
 	struct dentry *dentry = file->f_dentry;
 	struct inode *inode = dentry->d_inode;
-	loff_t offset = blocknr << inode->i_blkbits;
+	loff_t offset = (loff_t) blocknr << inode->i_blkbits;

 	switch (rw) {
 	case READ:

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

