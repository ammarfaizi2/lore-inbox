Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVI2Tdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVI2Tdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVI2Td1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:33:27 -0400
Received: from ppp-62-11-74-97.dialup.tiscali.it ([62.11.74.97]:54173 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S964798AbVI2TdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:33:02 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 5/5] uml: remove empty hostfs_truncate method
Date: Thu, 29 Sep 2005 21:31:02 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20050929193101.14528.90627.stgit@zion.home.lan>
In-Reply-To: <200509292102.44942.blaisorblade@yahoo.it>
References: <200509292102.44942.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Calling truncate() on hostfs spits a kernel warning "Something isn't implemented
here", but it still works fine.

Indeed, hostfs i_op->truncate doesn't do anything. But hostfs_setattr() ->
set_attr() correctly detects ATTR_SIZE and calls truncate() on the host. So we
should be safe (using ftruncate() may be better, in case the file is unlinked on
the host, but we aren't sure to have the file open for writing, and reopening it
would cause the same races; plus nobody should expect UML to be so careful).

So, the warning is wrong, because the current implementation is working. Al, am
I correct, and can the warning be therefore dropped?

CC: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hostfs/hostfs_kern.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -793,11 +793,6 @@ int hostfs_rename(struct inode *from_ino
 	return(err);
 }
 
-void hostfs_truncate(struct inode *ino)
-{
-	not_implemented();
-}
-
 int hostfs_permission(struct inode *ino, int desired, struct nameidata *nd)
 {
 	char *name;
@@ -894,7 +889,6 @@ static struct inode_operations hostfs_io
 	.rmdir		= hostfs_rmdir,
 	.mknod		= hostfs_mknod,
 	.rename		= hostfs_rename,
-	.truncate	= hostfs_truncate,
 	.permission	= hostfs_permission,
 	.setattr	= hostfs_setattr,
 	.getattr	= hostfs_getattr,
@@ -910,7 +904,6 @@ static struct inode_operations hostfs_di
 	.rmdir		= hostfs_rmdir,
 	.mknod		= hostfs_mknod,
 	.rename		= hostfs_rename,
-	.truncate	= hostfs_truncate,
 	.permission	= hostfs_permission,
 	.setattr	= hostfs_setattr,
 	.getattr	= hostfs_getattr,

