Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWCWRVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWCWRVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWCWRVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:21:33 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:24300 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751441AbWCWRVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:21:31 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:21:20 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 02/14] NTFS: Fix an (innocent) off-by-one error in the runlist
 code.
In-Reply-To: <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix an (innocent) off-by-one error in the runlist code.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/ChangeLog |    6 ++++++
 fs/ntfs/Makefile  |    2 +-
 fs/ntfs/namei.c   |    2 +-
 fs/ntfs/runlist.c |   12 ++++++++----
 fs/ntfs/super.c   |    2 +-
 5 files changed, 17 insertions(+), 7 deletions(-)

67b1dfe77a2eb2a88b37cd77b8979cbdb7695bd6
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 9d8ffa8..3d8d60b 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -19,6 +19,12 @@ ToDo/Notes:
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
+2.1.27 - Various bug fixes.
+
+	- Fix two compiler warnings on Alpha.  Thanks to Andrew Morton for
+	  reporting them.
+	- Fix an (innocent) off-by-one error in the runlist code.
+
 2.1.26 - Minor bug fixes and updates.
 
 	- Fix a potential overflow in file.c where a cast to s64 was missing in
diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
index d95fac7..e27b4ea 100644
--- a/fs/ntfs/Makefile
+++ b/fs/ntfs/Makefile
@@ -6,7 +6,7 @@ ntfs-objs := aops.o attrib.o collate.o c
 	     index.o inode.o mft.o mst.o namei.o runlist.o super.o sysctl.o \
 	     unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.26\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.27\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 5ea9eb9..78e0cf7 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -2,7 +2,7 @@
  * namei.c - NTFS kernel directory inode operations. Part of the Linux-NTFS
  *	     project.
  *
- * Copyright (c) 2001-2004 Anton Altaparmakov
+ * Copyright (c) 2001-2006 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index 061b5ff..eb52b80 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -381,6 +381,7 @@ static inline runlist_element *ntfs_rl_i
 static inline runlist_element *ntfs_rl_replace(runlist_element *dst,
 		int dsize, runlist_element *src, int ssize, int loc)
 {
+	signed delta;
 	BOOL left = FALSE;	/* Left end of @src needs merging. */
 	BOOL right = FALSE;	/* Right end of @src needs merging. */
 	int tail;		/* Start of tail of @dst. */
@@ -396,11 +397,14 @@ static inline runlist_element *ntfs_rl_r
 		left = ntfs_are_rl_mergeable(dst + loc - 1, src);
 	/*
 	 * Allocate some space.  We will need less if the left, right, or both
-	 * ends get merged.
+	 * ends get merged.  The -1 accounts for the run being replaced.
 	 */
-	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize - left - right);
-	if (IS_ERR(dst))
-		return dst;
+	delta = ssize - 1 - left - right;
+	if (delta > 0) {
+		dst = ntfs_rl_realloc(dst, dsize, dsize + delta);
+		if (IS_ERR(dst))
+			return dst;
+	}
 	/*
 	 * We are guaranteed to succeed from here so can start modifying the
 	 * original runlists.
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 368a8ec..71c58ec 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -3234,7 +3234,7 @@ static void __exit exit_ntfs_fs(void)
 }
 
 MODULE_AUTHOR("Anton Altaparmakov <aia21@cantab.net>");
-MODULE_DESCRIPTION("NTFS 1.2/3.x driver - Copyright (c) 2001-2005 Anton Altaparmakov");
+MODULE_DESCRIPTION("NTFS 1.2/3.x driver - Copyright (c) 2001-2006 Anton Altaparmakov");
 MODULE_VERSION(NTFS_VERSION);
 MODULE_LICENSE("GPL");
 #ifdef DEBUG
-- 
1.2.3.g9821
