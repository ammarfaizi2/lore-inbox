Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUFJMhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUFJMhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 08:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUFJMhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 08:37:34 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:37796 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261205AbUFJMh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 08:37:27 -0400
Date: Thu, 10 Jun 2004 13:37:25 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       Pawel Kot <pkot@bezsensu.pl>
Subject: [2.6.7-BK] NTFS 2.1.14 - Fix an NFSd caused deadlock reported by
 several users.
In-Reply-To: <Pine.SOL.4.58.0406081236450.21854@orange.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0406101336010.19036@orange.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0406081236450.21854@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Linus, please do a

	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6

Thanks!  This is an important bug fix for NTFS which fixes the NFSd caused
deadlock in NTFS which several people reported (and I was able to
reproduce easily).

The problem was that ntfs_readdir() was leaving the directory inode locked
using a NTFS private semaphore during calls to the filldir() callback and
NFSd invokes ->lookup() from its filldir() callback and ntfs_lookup()
takes the same semaphore on the directory inode since ntfs_readdir()
already holds it, we get a deadlock.  I solved this by copying the
directory index into a buffer so that I can release the semaphore before
the first invocation of filldir() and this makes it all work nicely.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    2 +
 fs/ntfs/ChangeLog                  |   10 +++++++
 fs/ntfs/Makefile                   |    2 -
 fs/ntfs/dir.c                      |   47 ++++++++++++++++++++++++-------------
 4 files changed, 44 insertions(+), 17 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/06/10 1.1753)
   NTFS: 2.1.14 - Fix an NFSd caused deadlock reported by several users.

   - Modify fs/ntfs/ntfs_readdir() to copy the index root attribute value
     to a buffer so that we can put the search context and unmap the mft
     record before calling the filldir() callback.  We need to do this
     because of NFSd which calls ->lookup() from its filldir callback()
     and this causes NTFS to deadlock as ntfs_lookup() maps the mft record
     of the directory and since ntfs_readdir() has got it mapped already
     ntfs_lookup() deadlocks.

   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2004-06-10 13:29:19 +01:00
+++ b/Documentation/filesystems/ntfs.txt	2004-06-10 13:29:19 +01:00
@@ -273,6 +273,8 @@

 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.

+2.1.14:
+	- Fix an NFSd caused deadlock reported by several users.
 2.1.13:
 	- Implement writing of inodes (access time updates are not implemented
 	  yet so mounting with -o noatime,nodiratime is enforced).
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-06-10 13:29:19 +01:00
+++ b/fs/ntfs/ChangeLog	2004-06-10 13:29:19 +01:00
@@ -35,6 +35,16 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.

+2.1.14 - Fix an NFSd caused deadlock reported by several users.
+
+	- Modify fs/ntfs/ntfs_readdir() to copy the index root attribute value
+	  to a buffer so that we can put the search context and unmap the mft
+	  record before calling the filldir() callback.  We need to do this
+	  because of NFSd which calls ->lookup() from its filldir callback()
+	  and this causes NTFS to deadlock as ntfs_lookup() maps the mft record
+	  of the directory and since ntfs_readdir() has got it mapped already
+	  ntfs_lookup() deadlocks.
+
 2.1.13 - Enable overwriting of resident files and housekeeping of system files.

 	- Implement writing of mft records (fs/ntfs/mft.[hc]), which includes
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-06-10 13:29:19 +01:00
+++ b/fs/ntfs/Makefile	2004-06-10 13:29:19 +01:00
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o unistr.o upcase.o

-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.13\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.14\"

 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	2004-06-10 13:29:19 +01:00
+++ b/fs/ntfs/dir.c	2004-06-10 13:29:19 +01:00
@@ -1067,7 +1067,7 @@
 	ntfs_inode *ndir = NTFS_I(vdir);
 	ntfs_volume *vol = NTFS_SB(sb);
 	MFT_RECORD *m;
-	INDEX_ROOT *ir;
+	INDEX_ROOT *ir = NULL;
 	INDEX_ENTRY *ie;
 	INDEX_ALLOCATION *ia;
 	u8 *name = NULL;
@@ -1139,9 +1139,29 @@
 				"inode 0x%lx.", vdir->i_ino);
 		goto err_out;
 	}
-	/* Get to the index root value (it's been verified in read_inode). */
-	ir = (INDEX_ROOT*)((u8*)ctx->attr +
-			le16_to_cpu(ctx->attr->data.resident.value_offset));
+	/*
+	 * Copy the index root attribute value to a buffer so that we can put
+	 * the search context and unmap the mft record before calling the
+	 * filldir() callback.  We need to do this because of NFSd which calls
+	 * ->lookup() from its filldir callback() and this causes NTFS to
+	 * deadlock as ntfs_lookup() maps the mft record of the directory and
+	 * we have got it mapped here already.  The only solution is for us to
+	 * unmap the mft record here so that a call to ntfs_lookup() is able to
+	 * map the mft record without deadlocking.
+	 */
+	rc = le32_to_cpu(ctx->attr->data.resident.value_length);
+	ir = (INDEX_ROOT*)kmalloc(rc, GFP_NOFS);
+	if (unlikely(!ir)) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	/* Copy the index root value (it has been verified in read_inode). */
+	memcpy(ir, (u8*)ctx->attr +
+			le16_to_cpu(ctx->attr->data.resident.value_offset), rc);
+	put_attr_search_ctx(ctx);
+	unmap_mft_record(ndir);
+	ctx = NULL;
+	m = NULL;
 	index_end = (u8*)&ir->index + le32_to_cpu(ir->index.index_length);
 	/* The first index entry. */
 	ie = (INDEX_ENTRY*)((u8*)&ir->index +
@@ -1154,7 +1174,7 @@
 	for (;; ie = (INDEX_ENTRY*)((u8*)ie + le16_to_cpu(ie->length))) {
 		ntfs_debug("In index root, offset 0x%x.", (u8*)ie - (u8*)ir);
 		/* Bounds checks. */
-		if (unlikely((u8*)ie < (u8*)ctx->mrec || (u8*)ie +
+		if (unlikely((u8*)ie < (u8*)ir || (u8*)ie +
 				sizeof(INDEX_ENTRY_HEADER) > index_end ||
 				(u8*)ie + le16_to_cpu(ie->key_length) >
 				index_end))
@@ -1169,20 +1189,13 @@
 		rc = ntfs_filldir(vol, &fpos, ndir, INDEX_TYPE_ROOT, ir, ie,
 				name, dirent, filldir);
 		if (rc) {
-			put_attr_search_ctx(ctx);
-			unmap_mft_record(ndir);
+			kfree(ir);
 			goto abort;
 		}
 	}
-	/*
-	 * We are done with the index root and the mft record for that matter.
-	 * We need to release it, otherwise we deadlock on ntfs_attr_iget()
-	 * and/or ntfs_read_page().
-	 */
-	put_attr_search_ctx(ctx);
-	unmap_mft_record(ndir);
-	m = NULL;
-	ctx = NULL;
+	/* We are done with the index root and can free the buffer. */
+	kfree(ir);
+	ir = NULL;
 	/* If there is no index allocation attribute we are finished. */
 	if (!NInoIndexAllocPresent(ndir))
 		goto EOD;
@@ -1379,6 +1392,8 @@
 		ntfs_unmap_page(bmp_page);
 	if (ia_page)
 		ntfs_unmap_page(ia_page);
+	if (ir)
+		kfree(ir);
 	if (name)
 		kfree(name);
 	if (ctx)
