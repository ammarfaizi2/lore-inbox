Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268210AbUJSKcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268210AbUJSKcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269398AbUJSK3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:29:06 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:43950 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268210AbUJSJqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:46:32 -0400
Date: Tue, 19 Oct 2004 10:46:27 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 31/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191046000.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191046160.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042440.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043240.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043370.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043500.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044130.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044280.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045410.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046000.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 31/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/15 1.2051)
   NTFS: Move the static inline ntfs_init_big_inode() from fs/ntfs/inode.c to
         inode.h and make fs/ntfs/inode.c::__ntfs_init_inode() non-static and
         add a declaration for it to inode.h.  Fix some compilation issues
         that resulted due to #includes and header file interdependencies.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:59 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:59 +01:00
@@ -128,6 +128,10 @@
 	  dirty state.  We cannot look at the dirty state for subsequent
 	  buffers because we might be racing with
 	  fs/ntfs/aops.c::mark_ntfs_record_dirty().
+	- Move the static inline ntfs_init_big_inode() from fs/ntfs/inode.c to
+	  inode.h and make fs/ntfs/inode.c::__ntfs_init_inode() non-static and
+	  add a declaration for it to inode.h.  Fix some compilation issues
+	  that resulted due to #includes and header file interdependencies.
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-10-19 10:14:59 +01:00
+++ b/fs/ntfs/aops.c	2004-10-19 10:14:59 +01:00
@@ -29,9 +29,11 @@
 #include <linux/writeback.h>
 
 #include "aops.h"
+#include "attrib.h"
 #include "debug.h"
 #include "inode.h"
 #include "mft.h"
+#include "runlist.h"
 #include "types.h"
 #include "ntfs.h"
 
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	2004-10-19 10:14:59 +01:00
+++ b/fs/ntfs/compress.c	2004-10-19 10:14:59 +01:00
@@ -25,6 +25,7 @@
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
 
+#include "attrib.h"
 #include "inode.h"
 #include "debug.h"
 #include "ntfs.h"
diff -Nru a/fs/ntfs/debug.h b/fs/ntfs/debug.h
--- a/fs/ntfs/debug.h	2004-10-19 10:14:59 +01:00
+++ b/fs/ntfs/debug.h	2004-10-19 10:14:59 +01:00
@@ -22,13 +22,9 @@
 #ifndef _LINUX_NTFS_DEBUG_H
 #define _LINUX_NTFS_DEBUG_H
 
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/spinlock.h>
 #include <linux/fs.h>
 
-#include "inode.h"
-#include "attrib.h"
+#include "runlist.h"
 
 #ifdef DEBUG
 
diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	2004-10-19 10:14:59 +01:00
+++ b/fs/ntfs/file.c	2004-10-19 10:14:59 +01:00
@@ -22,6 +22,7 @@
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 
+#include "inode.h"
 #include "debug.h"
 #include "ntfs.h"
 
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-10-19 10:14:59 +01:00
+++ b/fs/ntfs/inode.c	2004-10-19 10:14:59 +01:00
@@ -373,7 +373,7 @@
  *
  * Return zero on success and -ENOMEM on error.
  */
-static void __ntfs_init_inode(struct super_block *sb, ntfs_inode *ni)
+void __ntfs_init_inode(struct super_block *sb, ntfs_inode *ni)
 {
 	ntfs_debug("Entering.");
 	ni->initialized_size = ni->allocated_size = 0;
@@ -396,17 +396,6 @@
 	init_MUTEX(&ni->extent_lock);
 	ni->nr_extents = 0;
 	ni->ext.base_ntfs_ino = NULL;
-	return;
-}
-
-static inline void ntfs_init_big_inode(struct inode *vi)
-{
-	ntfs_inode *ni = NTFS_I(vi);
-
-	ntfs_debug("Entering.");
-	__ntfs_init_inode(vi->i_sb, ni);
-	ni->mft_no = vi->i_ino;
-	return;
 }
 
 inline ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	2004-10-19 10:14:59 +01:00
+++ b/fs/ntfs/inode.h	2004-10-19 10:14:59 +01:00
@@ -35,6 +35,7 @@
 #include "volume.h"
 #include "types.h"
 #include "runlist.h"
+#include "debug.h"
 
 typedef struct _ntfs_inode ntfs_inode;
 
@@ -275,6 +276,17 @@
 extern struct inode *ntfs_alloc_big_inode(struct super_block *sb);
 extern void ntfs_destroy_big_inode(struct inode *inode);
 extern void ntfs_clear_big_inode(struct inode *vi);
+
+extern void __ntfs_init_inode(struct super_block *sb, ntfs_inode *ni);
+
+static inline void ntfs_init_big_inode(struct inode *vi)
+{
+	ntfs_inode *ni = NTFS_I(vi);
+
+	ntfs_debug("Entering.");
+	__ntfs_init_inode(vi->i_sb, ni);
+	ni->mft_no = vi->i_ino;
+}
 
 extern ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
 		unsigned long mft_no);
diff -Nru a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
--- a/fs/ntfs/logfile.c	2004-10-19 10:14:59 +01:00
+++ b/fs/ntfs/logfile.c	2004-10-19 10:14:59 +01:00
@@ -27,11 +27,12 @@
 #include <linux/buffer_head.h>
 #include <linux/bitops.h>
 
-#include "logfile.h"
-#include "volume.h"
+#include "attrib.h"
 #include "aops.h"
 #include "debug.h"
+#include "logfile.h"
 #include "malloc.h"
+#include "volume.h"
 #include "ntfs.h"
 
 /**
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:14:59 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:14:59 +01:00
@@ -23,12 +23,14 @@
 #include <linux/buffer_head.h>
 #include <linux/swap.h>
 
-#include "bitmap.h"
-#include "lcnalloc.h"
+#include "attrib.h"
 #include "aops.h"
+#include "bitmap.h"
 #include "debug.h"
-#include "mft.h"
+#include "dir.h"
+#include "lcnalloc.h"
 #include "malloc.h"
+#include "mft.h"
 #include "ntfs.h"
 
 /**
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	2004-10-19 10:14:59 +01:00
+++ b/fs/ntfs/namei.c	2004-10-19 10:14:59 +01:00
@@ -23,8 +23,9 @@
 #include <linux/dcache.h>
 #include <linux/security.h>
 
-#include "dir.h"
+#include "attrib.h"
 #include "debug.h"
+#include "dir.h"
 #include "mft.h"
 #include "ntfs.h"
 
diff -Nru a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c	2004-10-19 10:14:59 +01:00
+++ b/fs/ntfs/runlist.c	2004-10-19 10:14:59 +01:00
@@ -20,8 +20,9 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include "dir.h"
 #include "debug.h"
+#include "dir.h"
+#include "endian.h"
 #include "malloc.h"
 #include "ntfs.h"
 
