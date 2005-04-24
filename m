Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVDXStr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVDXStr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 14:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVDXStd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 14:49:33 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:9165 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262371AbVDXSol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 14:44:41 -0400
Subject: [patch 5/7] uml - hostfs: avoid buffers
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sun, 24 Apr 2005 20:19:19 +0200
Message-Id: <20050424181919.D305E55D01@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Use this:
	.set_page_dirty = __set_page_dirty_nobuffers,

We already dropped the inclusion of <linux/buffer_head.h>, and we don't have
a backing block device for this FS.

"Without having looked at it, I'm sure that hostfs does not use
buffer_heads.  So setting your ->set_page_dirty a_op to point at
__set_page_dirty_nobuffers() is a reasonable thing to do - it'll provide a
slight speedup."

This speedup is one less spinlock held and one less conditional branch, which
isn't bad.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/fs/hostfs/hostfs_kern.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-avoid-buffers fs/hostfs/hostfs_kern.c
--- linux-2.6.12/fs/hostfs/hostfs_kern.c~uml-hostfs-avoid-buffers	2005-04-24 20:17:05.000000000 +0200
+++ linux-2.6.12-paolo/fs/hostfs/hostfs_kern.c	2005-04-24 20:17:05.000000000 +0200
@@ -521,7 +521,7 @@ int hostfs_commit_write(struct file *fil
 static struct address_space_operations hostfs_aops = {
 	.writepage 	= hostfs_writepage,
 	.readpage	= hostfs_readpage,
-/* 	.set_page_dirty = __set_page_dirty_nobuffers, */
+	.set_page_dirty = __set_page_dirty_nobuffers,
 	.prepare_write	= hostfs_prepare_write,
 	.commit_write	= hostfs_commit_write
 };
_
