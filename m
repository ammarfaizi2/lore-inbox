Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVLVEZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVLVEZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVLVEZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:25:00 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:48885 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932132AbVLVEY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:24:59 -0500
Date: Thu, 22 Dec 2005 13:24:54 +0900 (JST)
Message-Id: <20051222.132454.1025208517.masano@tnes.nec.co.jp>
To: trond.myklebust@fys.uio.no, matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fix posix lock on NFS
From: ASANO Masahiro <masano@tnes.nec.co.jp>
X-Mailer: Mew version 3.3 on XEmacs 21.4.11 (Native Windows TTY Support)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a problem on NFS client code.  It enables a local user to
crash the system.

NFS client prevents mandatory lock, but there is a flaw on it; Locks
are possibly left if the mode is changed while locking.  And a recent
changes on VFS makes it calls BUG().

For example:
   fd = open("file_on_nfs", O_RDWR | O_CREAT, 0644);
   memset(&lck, 0, sizeof(lck));
   lck.l_type = F_WRLCK;
   fcntl(fd, F_SETLK, &lck);    // get locked
   fchmod(fd, 02644);           // change i_mode to -rw-r-Sr--
   close(fd);                   // "kernel BUG at fs/locks.c:1932!"

The cause is:
   o The situation that locking succeeds but unlocking fails is
     possible, because of i_mode.
   o locks_remove_flock() calls BUG() if posix locks remain on an
     inode when closing.  It was changed at 2.6.13-rc4.

Here is a patch against 2.6.15-rc6.  This permits unlocking even if
the mandatory lock bits are set.

Signed-off-by: ASANO Masahiro <masano@tnes.nec.co.jp>
---

--- linux-2.6.15-rc6/fs/nfs/file.c.orig	2005-12-21 21:30:14.000000000 +0900
+++ linux-2.6.15-rc6/fs/nfs/file.c	2005-12-21 21:42:16.000000000 +0900
@@ -524,7 +524,8 @@ static int nfs_lock(struct file *filp, i
 		return -EINVAL;
 
 	/* No mandatory locks over NFS */
-	if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
+	if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID &&
+	    fl->fl_type != F_UNLCK)
 		return -ENOLCK;
 
 	if (IS_GETLK(cmd))
