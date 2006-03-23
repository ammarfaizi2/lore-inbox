Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbWCWR2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbWCWR2G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWCWR2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:28:06 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:22920 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932170AbWCWR2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:28:02 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:27:43 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 10/14] NTFS: Fix a bug in fs/ntfs/inode.c::ntfs_read_locked_index_inode()
In-Reply-To: <Pine.LNX.4.64.0603231726250.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231727040.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231721240.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231722330.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231723320.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724200.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724570.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231725420.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231726250.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix a bug in fs/ntfs/inode.c::ntfs_read_locked_index_inode() where we
      forgot to update a temporary variable so loading index inodes which
      have an index allocation attribute failed.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/ChangeLog |    3 +++
 fs/ntfs/inode.c   |   26 +++++++++++---------------
 fs/ntfs/mft.c     |    5 +----
 3 files changed, 15 insertions(+), 19 deletions(-)

a778f217328a7391e0919b6463ec7f143851d12d
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index a3a9d4b..5fb74e6 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -38,6 +38,9 @@ ToDo/Notes:
 	  allowed by NTFS, i.e. 255 Unicode characters, not including the
 	  terminating NULL (which is not stored on disk).
 	- Improve comments on file attribute flags in fs/ntfs/layout.h.
+	- Fix a bug in fs/ntfs/inode.c::ntfs_read_locked_index_inode() where we
+	  forgot to update a temporary variable so loading index inodes which
+	  have an index allocation attribute failed.
 
 2.1.26 - Minor bug fixes and updates.
 
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index ae34192..5f4b23d 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -19,15 +19,19 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/pagemap.h>
 #include <linux/buffer_head.h>
-#include <linux/smp_lock.h>
-#include <linux/quotaops.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
 #include <linux/mount.h>
 #include <linux/mutex.h>
+#include <linux/pagemap.h>
+#include <linux/quotaops.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
 
 #include "aops.h"
 #include "attrib.h"
+#include "bitmap.h"
 #include "dir.h"
 #include "debug.h"
 #include "inode.h"
@@ -1428,7 +1432,6 @@ err_out:
 			"Run chkdsk.", err, vi->i_ino, ni->type, ni->name_len,
 			base_vi->i_ino);
 	make_bad_inode(vi);
-	make_bad_inode(base_vi);
 	if (err != -ENOMEM)
 		NVolSetErrors(vol);
 	return err;
@@ -1613,6 +1616,7 @@ static int ntfs_read_locked_index_inode(
 					"$INDEX_ALLOCATION attribute.");
 		goto unm_err_out;
 	}
+	a = ctx->attr;
 	if (!a->non_resident) {
 		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is "
 				"resident.");
@@ -2845,11 +2849,8 @@ done:
 old_bad_out:
 	old_size = -1;
 bad_out:
-	if (err != -ENOMEM && err != -EOPNOTSUPP) {
-		make_bad_inode(vi);
-		make_bad_inode(VFS_I(base_ni));
+	if (err != -ENOMEM && err != -EOPNOTSUPP)
 		NVolSetErrors(vol);
-	}
 	if (err != -EOPNOTSUPP)
 		NInoSetTruncateFailed(ni);
 	else if (old_size >= 0)
@@ -2864,11 +2865,8 @@ out:
 	ntfs_debug("Failed.  Returning error code %i.", err);
 	return err;
 conv_err_out:
-	if (err != -ENOMEM && err != -EOPNOTSUPP) {
-		make_bad_inode(vi);
-		make_bad_inode(VFS_I(base_ni));
+	if (err != -ENOMEM && err != -EOPNOTSUPP)
 		NVolSetErrors(vol);
-	}
 	if (err != -EOPNOTSUPP)
 		NInoSetTruncateFailed(ni);
 	else
@@ -3116,9 +3114,7 @@ err_out:
 				"retries later.");
 		mark_inode_dirty(vi);
 	} else {
-		ntfs_error(vi->i_sb, "Failed (error code %i):  Marking inode "
-				"as bad.  You should run chkdsk.", -err);
-		make_bad_inode(vi);
+		ntfs_error(vi->i_sb, "Failed (error %i):  Run chkdsk.", -err);
 		NVolSetErrors(ni->vol);
 	}
 	return err;
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 7254391..eb3eb14 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -651,10 +651,7 @@ err_out:
  * fs/ntfs/aops.c::mark_ntfs_record_dirty().
  *
  * On success, clean the mft record and return 0.  On error, leave the mft
- * record dirty and return -errno.  The caller should call make_bad_inode() on
- * the base inode to ensure no more access happens to this inode.  We do not do
- * it here as the caller may want to finish writing other extent mft records
- * first to minimize on-disk metadata inconsistencies.
+ * record dirty and return -errno.
  *
  * NOTE:  We always perform synchronous i/o and ignore the @sync parameter.
  * However, if the mft record has a counterpart in the mft mirror and @sync is
-- 
1.2.3.g9821

