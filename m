Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263414AbTDGM2p (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263416AbTDGM2p (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:28:45 -0400
Received: from ns.suse.de ([213.95.15.193]:25100 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263414AbTDGM2l (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 08:28:41 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Andrew Morton <akpm@zip.com.au>
Subject: [PATCH] Missing brelse() in ext2/ext3 extended attribute code (2.5.66)
Date: Mon, 7 Apr 2003 14:41:34 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+HXk+roTGds4FKS"
Message-Id: <200304071441.34047.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_+HXk+roTGds4FKS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Andrew,

here is a fix for a bug that became visible by the recent fix to 
fs/mbcache.c:mb_cache_entry_insert(). An explanation is in the attachment.

Could you please include that in your next update to Linus?


Thanks,
Andreas.

--Boundary-00=_+HXk+roTGds4FKS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ext23-xattr-reuse-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ext23-xattr-reuse-fix.diff"

Missing brelse() in ext2/ext3 extended attribute code

The ext2 and ext3 EA implementations fail to release a buffer_head if
the inode that is being accessed is sharing EAs with another inode, and
an attribute is set to the same value that it has already, like so:

        $ touch f g
	$ setfattr -n user.test -v test f g
	# (Now, both f and g refer to the same EA block.)
	$ setfattr -n user.test -v test f

With the bug, an "invalidate: busy buffer" or "invalidate: dirty
buffer" message will be logged when the file system is unmounted. This
patch fixes the problem.

At the implementation level:

The code was assuming that ext3_xattr_cache_find cannot return the same
block the inode already is associated with, so testing for (old_bh !=
new_bh) would determine whether the old block is resued or an additional
bh is held. This is wrong if the EA block is used by multiple inodes (in
which case it stays in the cache), and the block isn't actually
modified.  Instead of testing for (old_bh != new_bh), the code now does
a get_bh() in the branch that keeps the old block, which assures that
new_bh now is either NULL or a handle that must be released at the end
of ext3_xattr_set_handle2().

Andreas Gruenbacher <agruen@suse.de>


Index: linux-2.5.66/fs/ext2/xattr.c
===================================================================
--- linux-2.5.66.orig/fs/ext2/xattr.c	2003-03-24 23:00:50.000000000 +0100
+++ linux-2.5.66/fs/ext2/xattr.c	2003-04-06 04:16:59.000000000 +0200
@@ -732,7 +732,8 @@
 			 * The old block will be released after updating
 			 * the inode.
 			 */
-			ea_bdebug(new_bh, "reusing block %ld",
+			ea_bdebug(new_bh, "%s block %ld",
+				(old_bh == new_bh) ? "keeping" : "reusing",
 				new_bh->b_blocknr);
 			
 			error = -EDQUOT;
@@ -746,6 +747,7 @@
 		} else if (old_bh && header == HDR(old_bh)) {
 			/* Keep this block. */
 			new_bh = old_bh;
+			get_bh(new_bh);
 			ext2_xattr_cache_insert(new_bh);
 		} else {
 			/* We need to allocate a new block */
@@ -816,8 +818,7 @@
 	}
 
 cleanup:
-	if (old_bh != new_bh)
-		brelse(new_bh);
+	brelse(new_bh);
 
 	return error;
 }
Index: linux-2.5.66/fs/ext3/xattr.c
===================================================================
--- linux-2.5.66.orig/fs/ext3/xattr.c	2003-03-24 23:00:46.000000000 +0100
+++ linux-2.5.66/fs/ext3/xattr.c	2003-04-06 04:17:31.000000000 +0200
@@ -733,7 +733,8 @@
 			 * The old block will be released after updating
 			 * the inode.
 			 */
-			ea_bdebug(new_bh, "reusing block %ld",
+			ea_bdebug(new_bh, "%s block %ld",
+				(old_bh == new_bh) ? "keeping" : "reusing",
 				new_bh->b_blocknr);
 			
 			error = -EDQUOT;
@@ -750,6 +751,7 @@
 		} else if (old_bh && header == HDR(old_bh)) {
 			/* Keep this block. */
 			new_bh = old_bh;
+			get_bh(new_bh);
 			ext3_xattr_cache_insert(new_bh);
 		} else {
 			/* We need to allocate a new block */
@@ -827,8 +829,7 @@
 	}
 
 cleanup:
-	if (old_bh != new_bh)
-		brelse(new_bh);
+	brelse(new_bh);
 
 	return error;
 }

--Boundary-00=_+HXk+roTGds4FKS--

