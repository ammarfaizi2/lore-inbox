Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUIVMQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUIVMQv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 08:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUIVMQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 08:16:50 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:49028 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264915AbUIVMPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 08:15:54 -0400
Date: Wed, 22 Sep 2004 13:15:44 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 2/7] Re: [2.6-BK-URL] NTFS 2.1.18 release
In-Reply-To: <Pine.LNX.4.60.0409221314250.505@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409221315251.505@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409221308540.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221314250.505@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 2/7 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/14 1.1864.1.2)
   NTFS: Fix scheduling latencies in ntfs_fill_super() by dropping the BKL
         because the code itself is using the ntfs_lock semaphore which
         provides safe locking.  (Ingo Molnar)
   
   Signed-off-by: Ingo Molnar <mingo@elte.hu>
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
--- a/fs/ntfs/ChangeLog	2004-09-22 13:02:37 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-22 13:02:37 +01:00
@@ -25,6 +25,9 @@
 
 	- Remove vol->nr_mft_records as it was pretty meaningless and optimize
 	  the calculation of total/free inodes as used by statfs().
+	- Fix scheduling latencies in ntfs_fill_super() by dropping the BKL
+	  because the code itself is using the ntfs_lock semaphore which
+	  provides safe locking.  (Ingo Molnar)
 
 2.1.17 - Fix bugs in mount time error code paths and other updates.
 
diff -Nru a/fs/ntfs/debug.c b/fs/ntfs/debug.c
--- a/fs/ntfs/debug.c	2004-09-22 13:02:37 +01:00
+++ b/fs/ntfs/debug.c	2004-09-22 13:02:37 +01:00
@@ -127,7 +127,7 @@
 	va_start(args, fmt);
 	vsnprintf(err_buf, sizeof(err_buf), fmt, args);
 	va_end(args);
-	printk(KERN_DEBUG "NTFS-fs DEBUG (%s, %d): %s: %s\n",
+	printk(KERN_DEBUG "NTFS-fs DEBUG (%s, %d): %s(): %s\n",
 		file, line, flen ? function : "", err_buf);
 	spin_unlock(&err_buf_lock);
 }
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-09-22 13:02:37 +01:00
+++ b/fs/ntfs/super.c	2004-09-22 13:02:37 +01:00
@@ -29,6 +29,7 @@
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
 #include <linux/moduleparam.h>
+#include <linux/smp_lock.h>
 
 #include "ntfs.h"
 #include "sysctl.h"
@@ -2291,6 +2292,8 @@
 	vol->fmask = 0177;
 	vol->dmask = 0077;
 
+	unlock_kernel();
+
 	/* Important to get the mount options dealt with now. */
 	if (!parse_options(vol, (char*)opt))
 		goto err_out_now;
@@ -2427,6 +2430,7 @@
 		}
 		up(&ntfs_lock);
 		sb->s_export_op = &ntfs_export_ops;
+		lock_kernel();
 		return 0;
 	}
 	ntfs_error(sb, "Failed to allocate root directory.");
@@ -2530,6 +2534,7 @@
 	}
 	/* Errors at this stage are irrelevant. */
 err_out_now:
+	lock_kernel();
 	sb->s_fs_info = NULL;
 	kfree(vol);
 	ntfs_debug("Failed, returning -EINVAL.");
