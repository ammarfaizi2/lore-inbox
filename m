Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTI2Gp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 02:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbTI2Gp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 02:45:58 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:26098 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262838AbTI2Gp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 02:45:57 -0400
Date: Sun, 28 Sep 2003 23:42:36 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: effect of nfs blocksize on I/O ?
Message-ID: <20030928234236.A16924@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not talking about rsize/wsize, rather the fs blocksize.

2.4 sets this to MIN(MAX(MAX(4096,rsize),wsize),32768) = 8192 typically.
2.6 sets this to nfs_fsinfo.wtmult?nfs_fsinfo.wtmult:512 = 512 typically.

(My estimation of "typical" may be way off though.)

At a 512 byte blocksize, this overflows struct statfs for fs > 1TB.
Most of my NFS filesystems (on netapp) are larger than that.

But more importantly, what does the VFS *do* with the blocksize?
strace seems to show that glibc/stdio does consider it.  If I fprintf()
two 4096 byte strings, libc does a single write() with 8192 blocksize,
and 3 write()'s for 512 blocksize.  I haven't looked to see what goes
over the wire, but I assume that still follows rsize/wsize.

Does any NFS server report wtmult?

Here's a patch.

/fc

--- a/fs/nfs/inode.c	2003-09-28 23:41:13.000000000 -0700
+++ b/fs/nfs/inode.c	2003-09-28 23:40:18.000000000 -0700
@@ -323,8 +323,8 @@
 		server->wsize = nfs_block_size(fsinfo.wtpref, NULL);
 	if (sb->s_blocksize == 0) {
 		if (fsinfo.wtmult == 0) {
-			sb->s_blocksize = 512;
-			sb->s_blocksize_bits = 9;
+			sb->s_blocksize = nfs_block_bits(server->rsize > server->wsize ? server->rsize : server->wsize,
+							 &sb->s_blocksize_bits);
 		} else
 			sb->s_blocksize = nfs_block_bits(fsinfo.wtmult,
 							 &sb->s_blocksize_bits);
