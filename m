Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268907AbUIXQSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268907AbUIXQSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268902AbUIXQQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:16:01 -0400
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:25731 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268886AbUIXQN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:13:27 -0400
Date: Fri, 24 Sep 2004 17:13:20 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 4/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups
 and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 4/10 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/23 1.1951)
   NTFS: Change '\0' and L'\0' to simply 0 as per advice from Linus Torvalds.
   
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
--- a/fs/ntfs/ChangeLog	2004-09-24 17:06:12 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-24 17:06:12 +01:00
@@ -30,6 +30,7 @@
 	  kernel.
 	- Get rid of the ugly transparent union in fs/ntfs/dir.c::ntfs_readdir()
 	  and ntfs_filldir() as per suggestion from Al Viro.
+	- Change '\0' and L'\0' to simply 0 as per advice from Linus Torvalds.
 
 2.1.18 - Fix scheduling latencies at mount time as well as an endianness bug.
 
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-09-24 17:06:12 +01:00
+++ b/fs/ntfs/inode.c	2004-09-24 17:06:12 +01:00
@@ -130,7 +130,7 @@
 		if (!ni->name)
 			return -ENOMEM;
 		memcpy(ni->name, na->name, i);
-		ni->name[i] = cpu_to_le16(L'\0');
+		ni->name[i] = cpu_to_le16(0);
 	}
 	return 0;
 }
@@ -2270,6 +2270,12 @@
  *
  * We don't support i_size changes yet.
  *
+ * The kernel guarantees that @vi is a regular file (S_ISREG() is true) and
+ * that the change is allowed.
+ *
+ * This implies for us that @vi is a file inode rather than a directory, index,
+ * or attribute inode as well as that @vi is a base inode.
+ *
  * Called with ->i_sem held.  In all but one case ->i_alloc_sem is held for
  * writing.  The only case where ->i_alloc_sem is not held is
  * mm/filemap.c::generic_file_buffered_write() where vmtruncate() is called
@@ -2279,10 +2285,10 @@
 void ntfs_truncate(struct inode *vi)
 {
 	// TODO: Implement...
-	ntfs_warning(vi->i_sb, "Eeek: i_size may have changed! If you see "
+	ntfs_warning(vi->i_sb, "Eeek: i_size may have changed!  If you see "
 			"this right after a message from "
-			"ntfs_{prepare,commit}_{,nonresident_}write() then "
-			"just ignore it. Otherwise it is bad news.");
+			"ntfs_prepare_{,nonresident_}write() then just ignore "
+			"it.  Otherwise it is bad news.");
 	// TODO: reset i_size now!
 	return;
 }
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-09-24 17:06:12 +01:00
+++ b/fs/ntfs/super.c	2004-09-24 17:06:12 +01:00
@@ -145,7 +145,7 @@
 	ntfs_debug("Entering with mount options string: %s", opt);
 	while ((p = strsep(&opt, ","))) {
 		if ((v = strchr(p, '=')))
-			*v++ = '\0';
+			*v++ = 0;
 		NTFS_GETOPT("uid", uid)
 		else NTFS_GETOPT("gid", gid)
 		else NTFS_GETOPT("umask", fmask = dmask)
diff -Nru a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
--- a/fs/ntfs/unistr.c	2004-09-24 17:06:12 +01:00
+++ b/fs/ntfs/unistr.c	2004-09-24 17:06:12 +01:00
@@ -276,7 +276,7 @@
 				} /* else (wc_len < 0) */
 				goto conversion_err;
 			}
-			ucs[o] = cpu_to_le16('\0');
+			ucs[o] = cpu_to_le16(0);
 			*outs = ucs;
 			return o;
 		} /* else (!ucs) */
@@ -362,7 +362,7 @@
 			} /* wc < 0, real error. */
 			goto conversion_err;
 		}
-		ns[o] = '\0';
+		ns[o] = 0;
 		*outs = ns;
 		return o;
 	} /* else (!ins) */
