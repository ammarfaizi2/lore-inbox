Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbVIIJcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbVIIJcP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbVIIJcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:32:15 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:49875 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030192AbVIIJcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:32:13 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:32:01 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 25/25] NTFS: 2.1.24 release and some minor final fixes.
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091031260.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 25/25] NTFS: 2.1.24 release and some minor final fixes.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 Documentation/filesystems/ntfs.txt |   12 ++++++++++++
 fs/ntfs/ChangeLog                  |    4 +++-
 fs/ntfs/Makefile                   |    2 +-
 fs/ntfs/aops.c                     |   10 ++++------
 fs/ntfs/super.c                    |    2 +-
 5 files changed, 21 insertions(+), 9 deletions(-)

7d333d6c739a5cd6d60102ea1a9940cbbb0546ec
diff --git a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt
+++ b/Documentation/filesystems/ntfs.txt
@@ -439,6 +439,18 @@ ChangeLog
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.1.24:
+	- Support journals ($LogFile) which have been modified by chkdsk.  This
+	  means users can boot into Windows after we marked the volume dirty.
+	  The Windows boot will run chkdsk and then reboot.  The user can then
+	  immediately boot into Linux rather than having to do a full Windows
+	  boot first before rebooting into Linux and we will recognize such a
+	  journal and empty it as it is clean by definition.
+	- Support journals ($LogFile) with only one restart page as well as
+	  journals with two different restart pages.  We sanity check both and
+	  either use the only sane one or the more recent one of the two in the
+	  case that both are valid.
+	- Lots of bug fixes and enhancements across the board.
 2.1.23:
 	- Stamp the user space journal, aka transaction log, aka $UsnJrnl, if
 	  it is present and active thus telling Windows and applications using
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -22,7 +22,7 @@ ToDo/Notes:
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
-2.1.24-WIP
+2.1.24 - Lots of bug fixes and support more clean journal states.
 
 	- Support journals ($LogFile) which have been modified by chkdsk.  This
 	  means users can boot into Windows after we marked the volume dirty.
@@ -89,6 +89,8 @@ ToDo/Notes:
 	- In fs/ntfs/aops.c::ntfs_end_buffer_async_read(), use a bit spin lock
 	  in the first buffer head instead of a driver global spin lock to
 	  improve scalability.
+	- Minor fix to error handling and error message display in
+	  fs/ntfs/aops.c::ntfs_prepare_nonresident_write(). 
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile
+++ b/fs/ntfs/Makefile
@@ -6,7 +6,7 @@ ntfs-objs := aops.o attrib.o collate.o c
 	     index.o inode.o mft.o mst.o namei.o runlist.o super.o sysctl.o \
 	     unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.24-WIP\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.24\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1727,27 +1727,25 @@ lock_retry_remap:
 					if (likely(!err))
 						goto lock_retry_remap;
 					rl = NULL;
-					lcn = err;
 				} else if (!rl)
 					up_read(&ni->runlist.lock);
 				/*
 				 * Failed to map the buffer, even after
 				 * retrying.
 				 */
+				if (!err)
+					err = -EIO;
 				bh->b_blocknr = -1;
 				ntfs_error(vol->sb, "Failed to write to inode "
 						"0x%lx, attribute type 0x%x, "
 						"vcn 0x%llx, offset 0x%x "
 						"because its location on disk "
 						"could not be determined%s "
-						"(error code %lli).",
+						"(error code %i).",
 						ni->mft_no, ni->type,
 						(unsigned long long)vcn,
 						vcn_ofs, is_retry ? " even "
-						"after retrying" : "",
-						(long long)lcn);
-				if (!err)
-					err = -EIO;
+						"after retrying" : "", err);
 				goto err_out;
 			}
 			/* We now have a successful remap, i.e. lcn >= 0. */
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1688,9 +1688,9 @@ static BOOL load_system_files(ntfs_volum
 	struct super_block *sb = vol->sb;
 	MFT_RECORD *m;
 	VOLUME_INFORMATION *vi;
-	RESTART_PAGE_HEADER *rp;
 	ntfs_attr_search_ctx *ctx;
 #ifdef NTFS_RW
+	RESTART_PAGE_HEADER *rp;
 	int err;
 #endif /* NTFS_RW */
 
