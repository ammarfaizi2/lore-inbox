Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267649AbUJCA1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267649AbUJCA1s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 20:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267648AbUJCA1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 20:27:48 -0400
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:38816 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267649AbUJCA13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 20:27:29 -0400
Date: Sun, 3 Oct 2004 01:27:26 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>, Dino Klein <dinoklein@hotmail.com>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: PROBLEM: 2.6.9-rc3 Bug in NTFS  code
In-Reply-To: <BAY16-F38bigPasSmz600007d7b@hotmail.com>
Message-ID: <Pine.LNX.4.60.0410030116580.24862@hermes-1.csi.cam.ac.uk>
References: <BAY16-F38bigPasSmz600007d7b@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Oct 2004, Dino Klein wrote:
> below is what I had in the logs when attempting to umount a readonly NTFS.
[snip]

I suspect that this is caused by a bug I introduced in 2.1.18 release and 
that I already fixed in my development tree.  I unfortunately completely 
forgot that the code containing the bug was already in the mainstream 
kernels so I didn't think of submitting the fix straight away.  )))-:

Linus, please do a

	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6

to apply the fix which is also shown below in diff style patch.  Thanks!

Dino, could you apply the below patch and just check that the bug goes 
away (if you prefer just add by hand the line "ctx->al_entry = NULL;" to 
fs/ntfs/attrib.c as shown at the bottom of the patch).  It is always 
possible I introduced a different bug I haven't found yet as well so it 
would be good to know that this fix fixes the problem you are 
experiencing...  Thanks!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

This will update the following files:

 Documentation/filesystems/ntfs.txt |    2 ++
 fs/ntfs/ChangeLog                  |    7 +++++++
 fs/ntfs/Makefile                   |    2 +-
 fs/ntfs/attrib.c                   |    5 +++++
 4 files changed, 15 insertions(+), 1 deletion(-)

through these ChangeSets:

<aia21@cantab.net> (04/10/03 1.2031.1.1)
   NTFS: Fix stupid bug in fs/ntfs/attrib.c::ntfs_attr_reinit_search_ctx() where
         we did not clear ctx->al_entry but it was still set due to changes in
         ntfs_attr_lookup() and ntfs_external_attr_find() in particular.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

===================================================================

diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2004-10-03 01:16:22 +01:00
+++ b/Documentation/filesystems/ntfs.txt	2004-10-03 01:16:22 +01:00
@@ -277,6 +277,8 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.1.20:
+	- Fix a stupid bug introduced in 2.1.18 release.
 2.1.19:
 	- Minor bugfix in handling of the default upcase table.
 	- Many internal cleanups and improvements.  Many thanks to Linus
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-10-03 01:16:22 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-03 01:16:22 +01:00
@@ -21,6 +21,13 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
+2.1.20 - Fix a stupid bug in ntfs_attr_reinit_search_ctx().
+
+	- Fix stupid bug in fs/ntfs/attrib.c::ntfs_attr_reinit_search_ctx()
+	  where we did not clear ctx->al_entry but it was still set due to
+	  changes in ntfs_attr_lookup() and ntfs_external_attr_find() in
+	  particular.
+
 2.1.19 - Many cleanups, improvements, and a minor bug fix.
 
 	- Update ->setattr (fs/ntfs/inode.c::ntfs_setattr()) to refuse to
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-10-03 01:16:22 +01:00
+++ b/fs/ntfs/Makefile	2004-10-03 01:16:22 +01:00
@@ -6,7 +6,7 @@
 	     index.o inode.o mft.o mst.o namei.o super.o sysctl.o unistr.o \
 	     upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.19\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.20\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-10-03 01:16:22 +01:00
+++ b/fs/ntfs/attrib.c	2004-10-03 01:16:22 +01:00
@@ -1861,6 +1861,11 @@
 		/* Sanity checks are performed elsewhere. */
 		ctx->attr = (ATTR_RECORD*)((u8*)ctx->mrec +
 				le16_to_cpu(ctx->mrec->attrs_offset));
+		/*
+		 * This needs resetting due to ntfs_external_attr_find() which
+		 * can leave it set despite having zeroed ctx->base_ntfs_ino.
+		 */
+		ctx->al_entry = NULL;
 		return;
 	} /* Attribute list. */
 	if (ctx->ntfs_ino != ctx->base_ntfs_ino)

