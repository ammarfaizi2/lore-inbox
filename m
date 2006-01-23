Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWAWTsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWAWTsx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWAWTsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:48:53 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:6375 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S932241AbWAWTsx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:48:53 -0500
Date: Mon, 23 Jan 2006 11:48:52 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] fix fcntl(F_SETFL) on append-only files (repost)
Message-ID: <Pine.LNX.4.63.0601231144290.21186@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

there is code in setfl() which attempts to preserve the O_APPEND flag on 
IS_APPEND files... however IS_APPEND files could also be opened O_RDONLY 
and in that case setfl() should not require O_APPEND...

coreutils 5.93 tail -f attempts to set O_NONBLOCK even on regular files... 
unfortunately if you try this on an append-only log file the result is 
this:

fcntl64(3, F_GETFL)                     = 0x8000 (flags O_RDONLY|O_LARGEFILE)
fcntl64(3, F_SETFL, O_RDONLY|O_NONBLOCK|O_LARGEFILE) = -1 EPERM (Operation not permitted)

i offer up the patch below as one way of fixing the problem... i've tested 
it fixes the problem with tail -f but haven't really tested beyond that.

(i also reported the coreutils bug upstream... it shouldn't fail imho... 
<https://savannah.gnu.org/bugs/index.php?func=detailitem&item_id=15473>)

-dean

Signed-off-by: dean gaudet <dean@arctic.org>

--- linux-2.6.14.4.orig/fs/fcntl.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.4/fs/fcntl.c	2006-01-18 10:33:38.000000000 -0800
@@ -207,8 +207,10 @@
 	struct inode * inode = filp->f_dentry->d_inode;
 	int error = 0;
 
-	/* O_APPEND cannot be cleared if the file is marked as append-only */
-	if (!(arg & O_APPEND) && IS_APPEND(inode))
+	/* O_APPEND cannot be cleared if the file is marked as append-only
+	 * and the file is open for write.
+	 */
+	if (((arg ^ filp->f_flags) & O_APPEND) && IS_APPEND(inode))
 		return -EPERM;
 
 	/* O_NOATIME can only be set by the owner or superuser */
