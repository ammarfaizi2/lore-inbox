Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbUKROz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUKROz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 09:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUKROyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 09:54:41 -0500
Received: from [151.97.230.22] ([151.97.230.22]:26515 "EHLO zion.localdomain")
	by vger.kernel.org with ESMTP id S262141AbUKROxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 09:53:45 -0500
Subject: [patch 1/1] ext3: use generic_open_file to fix possible preemption bugs
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it,
       viro@parcelfarce.linux.theplanet.co.uk,
       ext2-devel@lists.sourceforge.net, sct@redhat.com
From: blaisorblade_spam@yahoo.it
Date: Thu, 18 Nov 2004 15:42:48 +0100
Message-Id: <20041118144249.A468B787BB@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>, <ext2-devel@lists.sourceforge.net>, Stephen Tweedie <sct@redhat.com>

Ext3 is currently using a duplicate version of generic_open_file, and this
should be fixed, before it gets out of sync.

In fact, it *has* got out of sync.

Apart some cosmethic changes (which are not a problem), note that it directly
reads inode->i_size, while the generic version uses i_size_read().

I'm not sure if this bug can actually be triggered, but here follows a
possible scenario: when

- a file is brought into inode cache
- that file is either truncated or extended (i.e.  inode->i_size is changed)
  and after this it changes it's "more than 2Gb" property,
- and process B opens that file in the meanwhile,

I suppose the size check can be hurted by a race condition, doesn't it?

Similar checks should probably be done for other FS's. Also, ext2 does not
have this problem - someone fixed this problem in ext2 but not ext3? How?

Shouldn't the common code between ext2 and ext3 be shared? I've heard in
answer to this that there are many differences, so it's difficult. In this
case, shouldn't exist a policy to back- and forward- port changes between
these two filesystems?

As a simpler solution, we could make ext3 capable of running without
journaling and use that in place of ext2 (maybe even leaving a dummy "ext2" fs
type to avoid breaking setups).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/fs/ext3/file.c |   16 +---------------
 1 files changed, 1 insertion(+), 15 deletions(-)

diff -puN fs/ext3/file.c~ext3-use-generic_open_file fs/ext3/file.c
--- linux-2.6.10-rc/fs/ext3/file.c~ext3-use-generic_open_file	2004-11-18 15:41:36.060453080 +0100
+++ linux-2.6.10-rc-paolo/fs/ext3/file.c	2004-11-18 15:41:36.096447608 +0100
@@ -43,20 +43,6 @@ static int ext3_release_file (struct ino
 	return 0;
 }
 
-/*
- * Called when an inode is about to be opened.
- * We use this to disallow opening RW large files on 32bit systems if
- * the caller didn't specify O_LARGEFILE.  On 64bit systems we force
- * on this flag in sys_open.
- */
-static int ext3_open_file (struct inode *inode, struct file *filp)
-{
-	if (!(filp->f_flags & O_LARGEFILE) &&
-	    inode->i_size > 0x7FFFFFFFLL)
-		return -EFBIG;
-	return 0;
-}
-
 static ssize_t
 ext3_file_write(struct kiocb *iocb, const char __user *buf, size_t count, loff_t pos)
 {
@@ -125,7 +111,7 @@ struct file_operations ext3_file_operati
 	.writev		= generic_file_writev,
 	.ioctl		= ext3_ioctl,
 	.mmap		= generic_file_mmap,
-	.open		= ext3_open_file,
+	.open		= generic_file_open,
 	.release	= ext3_release_file,
 	.fsync		= ext3_sync_file,
 	.sendfile	= generic_file_sendfile,
_
