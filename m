Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264909AbSJOXqw>; Tue, 15 Oct 2002 19:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264897AbSJOXqv>; Tue, 15 Oct 2002 19:46:51 -0400
Received: from ns.suse.de ([213.95.15.193]:56330 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264909AbSJOXqs>;
	Tue, 15 Oct 2002 19:46:48 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: tytso@mit.edu, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH 4/5] Add POSIX Access Control Lists to ext2/3
Date: Wed, 16 Oct 2002 01:52:43 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <E181a3v-0006O0-00@snap.thunk.org>
In-Reply-To: <E181a3v-0006O0-00@snap.thunk.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_VNR1T0I26LZY9CGBP102"
Message-Id: <200210160152.43903.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_VNR1T0I26LZY9CGBP102
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 16 October 2002 00:21, tytso@mit.edu wrote:
> This patch adds ACL support to the ext3 filesystem.

On Tuesday 15 October 2002 23:22, Stephen C. Tweedie wrote
[about the problems RedHat had with the patch]:
> The main problems were in standards conformance --- permissions on
> normal files not using ACLs were sometimes handled incorrectly with
> the ACL patches applied.  We also saw error-handling problems where
> non-fatal conditions (eg. truncate() to an illegal file size) were
> treated as fatal, potentially taking the whole fs offline.

The standard conformance is already fixed ("goto check_group"). This is t=
he=20
fix to the error handling.

acl-ext3-fix-tree.diff is the fix relative to the 0.8.51 bestbits patch;=20
acl-ext3-inode.c.diff includes all changes from 2.4.19. I make a 0.8.52 n=
ow.

--Andreas.
--------------Boundary-00=_VNR1T0I26LZY9CGBP102
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="acl-ext3-fix-tree.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="acl-ext3-fix-tree.diff"

diff -Nur linux-2.4.19.old/fs/ext3/inode.c linux-2.4.19.new/fs/ext3/inode.c
--- linux-2.4.19.old/fs/ext3/inode.c	2002-10-16 00:10:45.000000000 +0200
+++ linux-2.4.19.new/fs/ext3/inode.c	2002-10-16 00:32:15.000000000 +0200
@@ -2415,8 +2415,6 @@
 	}
 	
 	rc = inode_setattr(inode, attr);
-	if (!error)
-		error = rc;
 
 	/* If inode_setattr's call to ext3_truncate failed to get a
 	 * transaction handle at all, we need to clean up the in-core
@@ -2425,7 +2423,7 @@
 		ext3_orphan_del(NULL, inode);
 
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
-	if (!error && (ia_valid & ATTR_MODE)) {
+	if (!rc && (ia_valid & ATTR_MODE)) {
 		handle_t *handle;
 
 		handle = ext3_journal_start(inode, EXT3_XATTR_TRANS_BLOCKS);
@@ -2435,17 +2433,17 @@
 		}
 		if (!(ia_valid & ATTR_SIZE))
 			down(&inode->i_sem);
-		error = ext3_acl_chmod(handle, inode);
+		rc = ext3_acl_chmod(handle, inode);
 		if (!(ia_valid & ATTR_SIZE))
 			up(&inode->i_sem);
-		rc = ext3_journal_stop(handle, inode);
-		if (!error)
-			error = rc;
+		ext3_journal_stop(handle, inode);
 	}
 #endif
 
 err_out:
 	ext3_std_error(inode->i_sb, error);
+	if (!error)
+		error = rc;
 	return error;
 }
 

--------------Boundary-00=_VNR1T0I26LZY9CGBP102
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="acl-ext3-inode.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="acl-ext3-inode.c.diff"

--- linux-2.4.19/fs/ext3/inode.c	2002-10-16 01:05:24.000000000 +0200
+++ linux-2.4.19.new/fs/ext3/inode.c	2002-10-16 01:04:42.000000000 +0200
@@ -26,6 +26,8 @@
 #include <linux/sched.h>
 #include <linux/ext3_jbd.h>
 #include <linux/jbd.h>
+#include <linux/ext3_xattr.h>
+#include <linux/ext3_acl.h>
 #include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/highuid.h>
@@ -2176,6 +2178,16 @@
 		/* inode->i_attr_flags |= ATTR_FLAG_NOATIME;	unused */
 		inode->i_flags |= S_NOATIME;
 	}
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+	if (inode->u.ext3_i.i_file_acl) {
+		/* The filesystem is mounted with ACL support, and there
+		   are extended attributes for this inode. However we do
+		   not yet know whether there are actually any ACLs. */
+		inode->u.ext3_i.i_acl = EXT3_ACL_NOT_CACHED;
+		inode->u.ext3_i.i_default_acl = EXT3_ACL_NOT_CACHED;
+	}
+#endif
+
 	return;
 	
 bad_inode:
@@ -2364,10 +2376,6 @@
  * be freed, so we have a strong guarantee that no future commit will
  * leave these blocks visible to the user.)  
  *
- * This is only needed for regular files.  rmdir() has its own path, and
- * we can never truncate a direcory except on final unlink (at which
- * point i_nlink is zero so recovery is easy.)
- *
  * Called with the BKL.  
  */
 
@@ -2388,7 +2396,8 @@
 			return error;
 	}
 
-	if (attr->ia_valid & ATTR_SIZE && attr->ia_size < inode->i_size) {
+	if (S_ISREG(inode->i_mode) &&
+	    attr->ia_valid & ATTR_SIZE && attr->ia_size < inode->i_size) {
 		handle_t *handle;
 
 		handle = ext3_journal_start(inode, 3);
@@ -2410,9 +2419,27 @@
 	/* If inode_setattr's call to ext3_truncate failed to get a
 	 * transaction handle at all, we need to clean up the in-core
 	 * orphan list manually. */
-	if (inode->i_nlink)
+	if (S_ISREG(inode->i_mode) && inode->i_nlink)
 		ext3_orphan_del(NULL, inode);
 
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+	if (!rc && (ia_valid & ATTR_MODE)) {
+		handle_t *handle;
+
+		handle = ext3_journal_start(inode, EXT3_XATTR_TRANS_BLOCKS);
+		if (IS_ERR(handle)) {
+			error = PTR_ERR(handle);
+			goto err_out;
+		}
+		if (!(ia_valid & ATTR_SIZE))
+			down(&inode->i_sem);
+		rc = ext3_acl_chmod(handle, inode);
+		if (!(ia_valid & ATTR_SIZE))
+			up(&inode->i_sem);
+		ext3_journal_stop(handle, inode);
+	}
+#endif
+
 err_out:
 	ext3_std_error(inode->i_sb, error);
 	if (!error)

--------------Boundary-00=_VNR1T0I26LZY9CGBP102--

