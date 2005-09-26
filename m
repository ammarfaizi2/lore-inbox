Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVIZNe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVIZNe0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 09:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVIZNe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 09:34:26 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:19850 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932127AbVIZNeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 09:34:25 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 26 Sep 2005 14:34:18 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 4/4] NTFS: More $LogFile handling fixes: when chkdsk has been
 run, it can leave the
In-Reply-To: <Pine.LNX.4.60.0509261433100.32257@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509261433530.32257@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509261427520.32257@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0509261431270.32257@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0509261432170.32257@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0509261433100.32257@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: More $LogFile handling fixes: when chkdsk has been run, it can leave the
      restart pages in the journal without multi sector transfer protection
      fixups (i.e. the update sequence array is empty and in fact does not
      exist).

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |   18 +++++++++---------
 fs/ntfs/Makefile  |    2 +-
 fs/ntfs/logfile.c |   30 +++++++++++++++++++++++++-----
 3 files changed, 35 insertions(+), 15 deletions(-)

5a8c0cc32bb6e029cd9c36f655c6b0955b0d9967
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -22,14 +22,6 @@ ToDo/Notes:
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
-2.1.25-WIP
-
-	- Fix sparse warnings that have crept in over time.
-	- Change ntfs_cluster_free() to require a write locked runlist on entry
-	  since we otherwise get into a lock reversal deadlock if a read locked
-	  runlist is passed in. In the process also change it to take an ntfs
-	  inode instead of a vfs inode as parameter.
-
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
 	- Support journals ($LogFile) which have been modified by chkdsk.  This
@@ -37,7 +29,8 @@ ToDo/Notes:
 	  The Windows boot will run chkdsk and then reboot.  The user can then
 	  immediately boot into Linux rather than having to do a full Windows
 	  boot first before rebooting into Linux and we will recognize such a
-	  journal and empty it as it is clean by definition.
+	  journal and empty it as it is clean by definition.  Note, this only
+	  works if chkdsk left the journal in an obviously clean state.
 	- Support journals ($LogFile) with only one restart page as well as
 	  journals with two different restart pages.  We sanity check both and
 	  either use the only sane one or the more recent one of the two in the
@@ -102,6 +95,13 @@ ToDo/Notes:
 	  my ways.
 	- Fix various bugs in the runlist merging code.  (Based on libntfs
 	  changes by Richard Russon.)
+	- Fix sparse warnings that have crept in over time.
+	- Change ntfs_cluster_free() to require a write locked runlist on entry
+	  since we otherwise get into a lock reversal deadlock if a read locked
+	  runlist is passed in. In the process also change it to take an ntfs
+	  inode instead of a vfs inode as parameter.
+	- Fix the definition of the CHKD ntfs record magic.  It had an off by
+	  two error causing it to be CHKB instead of CHKD.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile
+++ b/fs/ntfs/Makefile
@@ -6,7 +6,7 @@ ntfs-objs := aops.o attrib.o collate.o c
 	     index.o inode.o mft.o mst.o namei.o runlist.o super.o sysctl.o \
 	     unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.25-WIP\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.24\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -51,7 +51,8 @@ static BOOL ntfs_check_restart_page_head
 		RESTART_PAGE_HEADER *rp, s64 pos)
 {
 	u32 logfile_system_page_size, logfile_log_page_size;
-	u16 usa_count, usa_ofs, usa_end, ra_ofs;
+	u16 ra_ofs, usa_count, usa_ofs, usa_end = 0;
+	BOOL have_usa = TRUE;
 
 	ntfs_debug("Entering.");
 	/*
@@ -86,6 +87,14 @@ static BOOL ntfs_check_restart_page_head
 				(int)sle16_to_cpu(rp->minor_ver));
 		return FALSE;
 	}
+	/*
+	 * If chkdsk has been run the restart page may not be protected by an
+	 * update sequence array.
+	 */
+	if (ntfs_is_chkd_record(rp->magic) && !le16_to_cpu(rp->usa_count)) {
+		have_usa = FALSE;
+		goto skip_usa_checks;
+	}
 	/* Verify the size of the update sequence array. */
 	usa_count = 1 + (logfile_system_page_size >> NTFS_BLOCK_SIZE_BITS);
 	if (usa_count != le16_to_cpu(rp->usa_count)) {
@@ -102,6 +111,7 @@ static BOOL ntfs_check_restart_page_head
 				"inconsistent update sequence array offset.");
 		return FALSE;
 	}
+skip_usa_checks:
 	/*
 	 * Verify the position of the restart area.  It must be:
 	 *	- aligned to 8-byte boundary,
@@ -109,7 +119,8 @@ static BOOL ntfs_check_restart_page_head
 	 *	- within the system page size.
 	 */
 	ra_ofs = le16_to_cpu(rp->restart_area_offset);
-	if (ra_ofs & 7 || ra_ofs < usa_end ||
+	if (ra_ofs & 7 || (have_usa ? ra_ofs < usa_end :
+			ra_ofs < sizeof(RESTART_PAGE_HEADER)) ||
 			ra_ofs > logfile_system_page_size) {
 		ntfs_error(vi->i_sb, "$LogFile restart page specifies "
 				"inconsistent restart area offset.");
@@ -402,8 +413,12 @@ static int ntfs_check_and_load_restart_p
 			idx++;
 		} while (to_read > 0);
 	}
-	/* Perform the multi sector transfer deprotection on the buffer. */
-	if (post_read_mst_fixup((NTFS_RECORD*)trp,
+	/*
+	 * Perform the multi sector transfer deprotection on the buffer if the
+	 * restart page is protected.
+	 */
+	if ((!ntfs_is_chkd_record(trp->magic) || le16_to_cpu(trp->usa_count))
+			&& post_read_mst_fixup((NTFS_RECORD*)trp,
 			le32_to_cpu(rp->system_page_size))) {
 		/*
 		 * A multi sector tranfer error was detected.  We only need to
@@ -615,11 +630,16 @@ is_empty:
 		 * Otherwise just throw it away.
 		 */
 		if (rstr2_lsn > rstr1_lsn) {
+			ntfs_debug("Using second restart page as it is more "
+					"recent.");
 			ntfs_free(rstr1_ph);
 			rstr1_ph = rstr2_ph;
 			/* rstr1_lsn = rstr2_lsn; */
-		} else
+		} else {
+			ntfs_debug("Using first restart page as it is more "
+					"recent.");
 			ntfs_free(rstr2_ph);
+		}
 		rstr2_ph = NULL;
 	}
 	/* All consistency checks passed. */
