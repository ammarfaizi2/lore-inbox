Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbVIIJTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbVIIJTR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbVIIJTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:19:16 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:54987 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965114AbVIIJTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:19:15 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:19:11 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 1/25] NTFS: Support more clean journal ($LogFile) states.
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091018060.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Support more clean journal ($LogFile) states.

      - Support journals ($LogFile) which have been modified by chkdsk.  This
        means users can boot into Windows after we marked the volume dirty.
        The Windows boot will run chkdsk and then reboot.  The user can then
        immediately boot into Linux rather than having to do a full Windows
        boot first before rebooting into Linux and we will recognize such a
        journal and empty it as it is clean by definition.
      - Support journals ($LogFile) with only one restart page as well as
        journals with two different restart pages.  We sanity check both and
        either use the only sane one or the more recent one of the two in the
        case that both are valid.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |   13 +++
 fs/ntfs/Makefile  |    2 
 fs/ntfs/logfile.c |  255 +++++++++++++++++++++++++++++------------------------
 fs/ntfs/logfile.h |    8 +-
 fs/ntfs/super.c   |   16 ++-
 5 files changed, 169 insertions(+), 125 deletions(-)

e7a1033b946f4f2622f2b338ab107f559aad542c
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -22,6 +22,19 @@ ToDo/Notes:
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
+2.1.24-WIP
+
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
+
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
 
diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile
+++ b/fs/ntfs/Makefile
@@ -6,7 +6,7 @@ ntfs-objs := aops.o attrib.o collate.o c
 	     index.o inode.o mft.o mst.o namei.o runlist.o super.o sysctl.o \
 	     unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.23\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.24-WIP\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -121,7 +121,7 @@ static BOOL ntfs_check_restart_page_head
 	 */
 	if (!ntfs_is_chkd_record(rp->magic) && sle64_to_cpu(rp->chkdsk_lsn)) {
 		ntfs_error(vi->i_sb, "$LogFile restart page is not modified "
-				"chkdsk but a chkdsk LSN is specified.");
+				"by chkdsk but a chkdsk LSN is specified.");
 		return FALSE;
 	}
 	ntfs_debug("Done.");
@@ -312,10 +312,12 @@ err_out:
  * @vi:		$LogFile inode to which the restart page belongs
  * @rp:		restart page to check
  * @pos:	position in @vi at which the restart page resides
- * @wrp:	copy of the multi sector transfer deprotected restart page
+ * @wrp:	[OUT] copy of the multi sector transfer deprotected restart page
+ * @lsn:	[OUT] set to the current logfile lsn on success
  *
- * Check the restart page @rp for consistency and return TRUE if it is
- * consistent and FALSE otherwise.
+ * Check the restart page @rp for consistency and return 0 if it is consistent
+ * and -errno otherwise.  The restart page may have been modified by chkdsk in
+ * which case its magic is CHKD instead of RSTR.
  *
  * This function only needs NTFS_BLOCK_SIZE bytes in @rp, i.e. it does not
  * require the full restart page.
@@ -323,25 +325,33 @@ err_out:
  * If @wrp is not NULL, on success, *@wrp will point to a buffer containing a
  * copy of the complete multi sector transfer deprotected page.  On failure,
  * *@wrp is undefined.
+ *
+ * Simillarly, if @lsn is not NULL, on succes *@lsn will be set to the current
+ * logfile lsn according to this restart page.  On failure, *@lsn is undefined.
+ *
+ * The following error codes are defined:
+ *	-EINVAL	- The restart page is inconsistent.
+ *	-ENOMEM	- Not enough memory to load the restart page.
+ *	-EIO	- Failed to reading from $LogFile.
  */
-static BOOL ntfs_check_and_load_restart_page(struct inode *vi,
-		RESTART_PAGE_HEADER *rp, s64 pos, RESTART_PAGE_HEADER **wrp)
+static int ntfs_check_and_load_restart_page(struct inode *vi,
+		RESTART_PAGE_HEADER *rp, s64 pos, RESTART_PAGE_HEADER **wrp,
+		LSN *lsn)
 {
 	RESTART_AREA *ra;
 	RESTART_PAGE_HEADER *trp;
-	int size;
-	BOOL ret;
+	int size, err;
 
 	ntfs_debug("Entering.");
 	/* Check the restart page header for consistency. */
 	if (!ntfs_check_restart_page_header(vi, rp, pos)) {
 		/* Error output already done inside the function. */
-		return FALSE;
+		return -EINVAL;
 	}
 	/* Check the restart area for consistency. */
 	if (!ntfs_check_restart_area(vi, rp)) {
 		/* Error output already done inside the function. */
-		return FALSE;
+		return -EINVAL;
 	}
 	ra = (RESTART_AREA*)((u8*)rp + le16_to_cpu(rp->restart_area_offset));
 	/*
@@ -352,7 +362,7 @@ static BOOL ntfs_check_and_load_restart_
 	if (!trp) {
 		ntfs_error(vi->i_sb, "Failed to allocate memory for $LogFile "
 				"restart page buffer.");
-		return FALSE;
+		return -ENOMEM;
 	}
 	/*
 	 * Read the whole of the restart page into the buffer.  If it fits
@@ -379,6 +389,9 @@ static BOOL ntfs_check_and_load_restart_
 			if (IS_ERR(page)) {
 				ntfs_error(vi->i_sb, "Error mapping $LogFile "
 						"page (index %lu).", idx);
+				err = PTR_ERR(page);
+				if (err != -EIO && err != -ENOMEM)
+					err = -EIO;
 				goto err_out;
 			}
 			size = min_t(int, to_read, PAGE_CACHE_SIZE);
@@ -392,29 +405,57 @@ static BOOL ntfs_check_and_load_restart_
 	/* Perform the multi sector transfer deprotection on the buffer. */
 	if (post_read_mst_fixup((NTFS_RECORD*)trp,
 			le32_to_cpu(rp->system_page_size))) {
-		ntfs_error(vi->i_sb, "Multi sector transfer error detected in "
-				"$LogFile restart page.");
-		goto err_out;
-	}
-	/* Check the log client records for consistency. */
-	ret = ntfs_check_log_client_array(vi, trp);
-	if (ret && wrp)
-		*wrp = trp;
-	else
-		ntfs_free(trp);
+		/*
+		 * A multi sector tranfer error was detected.  We only need to
+		 * abort if the restart page contents exceed the multi sector
+		 * transfer fixup of the first sector.
+		 */
+		if (le16_to_cpu(rp->restart_area_offset) +
+				le16_to_cpu(ra->restart_area_length) >
+				NTFS_BLOCK_SIZE - sizeof(u16)) {
+			ntfs_error(vi->i_sb, "Multi sector transfer error "
+					"detected in $LogFile restart page.");
+			err = -EINVAL;
+			goto err_out;
+		}
+	}
+	/*
+	 * If the restart page is modified by chkdsk or there are no active
+	 * logfile clients, the logfile is consistent.  Otherwise, need to
+	 * check the log client records for consistency, too.
+	 */
+	err = 0;
+	if (ntfs_is_rstr_record(rp->magic) &&
+			ra->client_in_use_list != LOGFILE_NO_CLIENT) {
+		if (!ntfs_check_log_client_array(vi, trp)) {
+			err = -EINVAL;
+			goto err_out;
+		}
+	}
+	if (lsn) {
+		if (ntfs_is_rstr_record(rp->magic))
+			*lsn = sle64_to_cpu(ra->current_lsn);
+		else /* if (ntfs_is_chkd_record(rp->magic)) */
+			*lsn = sle64_to_cpu(rp->chkdsk_lsn);
+	}
 	ntfs_debug("Done.");
-	return ret;
+	if (wrp)
+		*wrp = trp;
+	else {
 err_out:
-	ntfs_free(trp);
-	return FALSE;
+		ntfs_free(trp);
+	}
+	return err;
 }
 
 /**
  * ntfs_check_logfile - check the journal for consistency
  * @log_vi:	struct inode of loaded journal $LogFile to check
+ * @rp:		[OUT] on success this is a copy of the current restart page
  *
  * Check the $LogFile journal for consistency and return TRUE if it is
- * consistent and FALSE if not.
+ * consistent and FALSE if not.  On success, the current restart page is
+ * returned in *@rp.  Caller must call ntfs_free(*@rp) when finished with it.
  *
  * At present we only check the two restart pages and ignore the log record
  * pages.
@@ -424,19 +465,18 @@ err_out:
  * if the $LogFile was created on a system with a different page size to ours
  * yet and mst deprotection would fail if our page size is smaller.
  */
-BOOL ntfs_check_logfile(struct inode *log_vi)
+BOOL ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 {
-	s64 size, pos, rstr1_pos, rstr2_pos;
+	s64 size, pos;
+	LSN rstr1_lsn, rstr2_lsn;
 	ntfs_volume *vol = NTFS_SB(log_vi->i_sb);
 	struct address_space *mapping = log_vi->i_mapping;
 	struct page *page = NULL;
 	u8 *kaddr = NULL;
 	RESTART_PAGE_HEADER *rstr1_ph = NULL;
 	RESTART_PAGE_HEADER *rstr2_ph = NULL;
-	int log_page_size, log_page_mask, ofs;
+	int log_page_size, log_page_mask, err;
 	BOOL logfile_is_empty = TRUE;
-	BOOL rstr1_found = FALSE;
-	BOOL rstr2_found = FALSE;
 	u8 log_page_bits;
 
 	ntfs_debug("Entering.");
@@ -491,7 +531,7 @@ BOOL ntfs_check_logfile(struct inode *lo
 			if (IS_ERR(page)) {
 				ntfs_error(vol->sb, "Error mapping $LogFile "
 						"page (index %lu).", idx);
-				return FALSE;
+				goto err_out;
 			}
 		}
 		kaddr = (u8*)page_address(page) + (pos & ~PAGE_CACHE_MASK);
@@ -510,99 +550,95 @@ BOOL ntfs_check_logfile(struct inode *lo
 		 */
 		if (ntfs_is_rcrd_recordp((le32*)kaddr))
 			break;
-		/*
-		 * A modified by chkdsk restart page means we cannot handle
-		 * this log file.
-		 */
-		if (ntfs_is_chkd_recordp((le32*)kaddr)) {
-			ntfs_error(vol->sb, "$LogFile has been modified by "
-					"chkdsk.  Mount this volume in "
-					"Windows.");
-			goto err_out;
-		}
-		/* If not a restart page, continue. */
-		if (!ntfs_is_rstr_recordp((le32*)kaddr)) {
-			/* Skip to the minimum page size for the next one. */
+		/* If not a (modified by chkdsk) restart page, continue. */
+		if (!ntfs_is_rstr_recordp((le32*)kaddr) &&
+				!ntfs_is_chkd_recordp((le32*)kaddr)) {
 			if (!pos)
 				pos = NTFS_BLOCK_SIZE >> 1;
 			continue;
 		}
-		/* We now know we have a restart page. */
-		if (!pos) {
-			rstr1_found = TRUE;
-			rstr1_pos = pos;
-		} else {
-			if (rstr2_found) {
-				ntfs_error(vol->sb, "Found more than two "
-						"restart pages in $LogFile.");
-				goto err_out;
-			}
-			rstr2_found = TRUE;
-			rstr2_pos = pos;
-		}
 		/*
-		 * Check the restart page for consistency and get a copy of the
-		 * complete multi sector transfer deprotected restart page.
+		 * Check the (modified by chkdsk) restart page for consistency
+		 * and get a copy of the complete multi sector transfer
+		 * deprotected restart page.
 		 */
-		if (!ntfs_check_and_load_restart_page(log_vi,
+		err = ntfs_check_and_load_restart_page(log_vi,
 				(RESTART_PAGE_HEADER*)kaddr, pos,
-				!pos ? &rstr1_ph : &rstr2_ph)) {
-			/* Error output already done inside the function. */
-			goto err_out;
+				!rstr1_ph ? &rstr1_ph : &rstr2_ph,
+				!rstr1_ph ? &rstr1_lsn : &rstr2_lsn);
+		if (!err) {
+			/*
+			 * If we have now found the first (modified by chkdsk)
+			 * restart page, continue looking for the second one.
+			 */
+			if (!pos) {
+				pos = NTFS_BLOCK_SIZE >> 1;
+				continue;
+			}
+			/*
+			 * We have now found the second (modified by chkdsk)
+			 * restart page, so we can stop looking.
+			 */
+			break;
 		}
 		/*
-		 * We have a valid restart page.  The next one must be after
-		 * a whole system page size as specified by the valid restart
-		 * page.
+		 * Error output already done inside the function.  Note, we do
+		 * not abort if the restart page was invalid as we might still
+		 * find a valid one further in the file.
 		 */
+		if (err != -EINVAL) {
+			ntfs_unmap_page(page);
+			goto err_out;
+		}
+		/* Continue looking. */
 		if (!pos)
-			pos = le32_to_cpu(rstr1_ph->system_page_size) >> 1;
+			pos = NTFS_BLOCK_SIZE >> 1;
 	}
-	if (page) {
+	if (page)
 		ntfs_unmap_page(page);
-		page = NULL;
-	}
 	if (logfile_is_empty) {
 		NVolSetLogFileEmpty(vol);
 is_empty:
 		ntfs_debug("Done.  ($LogFile is empty.)");
 		return TRUE;
 	}
-	if (!rstr1_found || !rstr2_found) {
-		ntfs_error(vol->sb, "Did not find two restart pages in "
-				"$LogFile.");
-		goto err_out;
-	}
-	/*
-	 * The two restart areas must be identical except for the update
-	 * sequence number.
-	 */
-	ofs = le16_to_cpu(rstr1_ph->usa_ofs);
-	if (memcmp(rstr1_ph, rstr2_ph, ofs) || (ofs += sizeof(u16),
-			memcmp((u8*)rstr1_ph + ofs, (u8*)rstr2_ph + ofs,
-			le32_to_cpu(rstr1_ph->system_page_size) - ofs))) {
-		ntfs_error(vol->sb, "The two restart pages in $LogFile do not "
-				"match.");
-		goto err_out;
+	if (!rstr1_ph) {
+		BUG_ON(rstr2_ph);
+		ntfs_error(vol->sb, "Did not find any restart pages in "
+				"$LogFile and it was not empty.");
+		return FALSE;
+	}
+	/* If both restart pages were found, use the more recent one. */
+	if (rstr2_ph) {
+		/*
+		 * If the second restart area is more recent, switch to it.
+		 * Otherwise just throw it away.
+		 */
+		if (rstr2_lsn > rstr1_lsn) {
+			ntfs_free(rstr1_ph);
+			rstr1_ph = rstr2_ph;
+			/* rstr1_lsn = rstr2_lsn; */
+		} else
+			ntfs_free(rstr2_ph);
+		rstr2_ph = NULL;
 	}
-	ntfs_free(rstr1_ph);
-	ntfs_free(rstr2_ph);
 	/* All consistency checks passed. */
+	if (rp)
+		*rp = rstr1_ph;
+	else
+		ntfs_free(rstr1_ph);
 	ntfs_debug("Done.");
 	return TRUE;
 err_out:
-	if (page)
-		ntfs_unmap_page(page);
 	if (rstr1_ph)
 		ntfs_free(rstr1_ph);
-	if (rstr2_ph)
-		ntfs_free(rstr2_ph);
 	return FALSE;
 }
 
 /**
  * ntfs_is_logfile_clean - check in the journal if the volume is clean
  * @log_vi:	struct inode of loaded journal $LogFile to check
+ * @rp:		copy of the current restart page
  *
  * Analyze the $LogFile journal and return TRUE if it indicates the volume was
  * shutdown cleanly and FALSE if not.
@@ -619,11 +655,9 @@ err_out:
  * is empty this function requires that NVolLogFileEmpty() is true otherwise an
  * empty volume will be reported as dirty.
  */
-BOOL ntfs_is_logfile_clean(struct inode *log_vi)
+BOOL ntfs_is_logfile_clean(struct inode *log_vi, const RESTART_PAGE_HEADER *rp)
 {
 	ntfs_volume *vol = NTFS_SB(log_vi->i_sb);
-	struct page *page;
-	RESTART_PAGE_HEADER *rp;
 	RESTART_AREA *ra;
 
 	ntfs_debug("Entering.");
@@ -632,23 +666,14 @@ BOOL ntfs_is_logfile_clean(struct inode 
 		ntfs_debug("Done.  ($LogFile is empty.)");
 		return TRUE;
 	}
-	/*
-	 * Read the first restart page.  It will be possibly incomplete and
-	 * will not be multi sector transfer deprotected but we only need the
-	 * first NTFS_BLOCK_SIZE bytes so it does not matter.
-	 */
-	page = ntfs_map_page(log_vi->i_mapping, 0);
-	if (IS_ERR(page)) {
-		ntfs_error(vol->sb, "Error mapping $LogFile page (index 0).");
-		return FALSE;
-	}
-	rp = (RESTART_PAGE_HEADER*)page_address(page);
-	if (!ntfs_is_rstr_record(rp->magic)) {
-		ntfs_error(vol->sb, "No restart page found at offset zero in "
-				"$LogFile.  This is probably a bug in that "
-				"the $LogFile should have been consistency "
-				"checked before calling this function.");
-		goto err_out;
+	BUG_ON(!rp);
+	if (!ntfs_is_rstr_record(rp->magic) &&
+			!ntfs_is_chkd_record(rp->magic)) {
+		ntfs_error(vol->sb, "Restart page buffer is invalid.  This is "
+				"probably a bug in that the $LogFile should "
+				"have been consistency checked before calling "
+				"this function.");
+		return FALSE;
 	}
 	ra = (RESTART_AREA*)((u8*)rp + le16_to_cpu(rp->restart_area_offset));
 	/*
@@ -659,15 +684,11 @@ BOOL ntfs_is_logfile_clean(struct inode 
 	if (ra->client_in_use_list != LOGFILE_NO_CLIENT &&
 			!(ra->flags & RESTART_VOLUME_IS_CLEAN)) {
 		ntfs_debug("Done.  $LogFile indicates a dirty shutdown.");
-		goto err_out;
+		return FALSE;
 	}
-	ntfs_unmap_page(page);
 	/* $LogFile indicates a clean shutdown. */
 	ntfs_debug("Done.  $LogFile indicates a clean shutdown.");
 	return TRUE;
-err_out:
-	ntfs_unmap_page(page);
-	return FALSE;
 }
 
 /**
diff --git a/fs/ntfs/logfile.h b/fs/ntfs/logfile.h
--- a/fs/ntfs/logfile.h
+++ b/fs/ntfs/logfile.h
@@ -2,7 +2,7 @@
  * logfile.h - Defines for NTFS kernel journal ($LogFile) handling.  Part of
  *	       the Linux-NTFS project.
  *
- * Copyright (c) 2000-2004 Anton Altaparmakov
+ * Copyright (c) 2000-2005 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -296,9 +296,11 @@ typedef struct {
 /* sizeof() = 160 (0xa0) bytes */
 } __attribute__ ((__packed__)) LOG_CLIENT_RECORD;
 
-extern BOOL ntfs_check_logfile(struct inode *log_vi);
+extern BOOL ntfs_check_logfile(struct inode *log_vi,
+		RESTART_PAGE_HEADER **rp);
 
-extern BOOL ntfs_is_logfile_clean(struct inode *log_vi);
+extern BOOL ntfs_is_logfile_clean(struct inode *log_vi,
+		const RESTART_PAGE_HEADER *rp);
 
 extern BOOL ntfs_empty_logfile(struct inode *log_vi);
 
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1133,7 +1133,8 @@ mft_unmap_out:
  *
  * Return TRUE on success or FALSE on error.
  */
-static BOOL load_and_check_logfile(ntfs_volume *vol)
+static BOOL load_and_check_logfile(ntfs_volume *vol,
+		RESTART_PAGE_HEADER **rp)
 {
 	struct inode *tmp_ino;
 
@@ -1145,7 +1146,7 @@ static BOOL load_and_check_logfile(ntfs_
 		/* Caller will display error message. */
 		return FALSE;
 	}
-	if (!ntfs_check_logfile(tmp_ino)) {
+	if (!ntfs_check_logfile(tmp_ino, rp)) {
 		iput(tmp_ino);
 		/* ntfs_check_logfile() will have displayed error output. */
 		return FALSE;
@@ -1687,6 +1688,7 @@ static BOOL load_system_files(ntfs_volum
 	struct super_block *sb = vol->sb;
 	MFT_RECORD *m;
 	VOLUME_INFORMATION *vi;
+	RESTART_PAGE_HEADER *rp;
 	ntfs_attr_search_ctx *ctx;
 #ifdef NTFS_RW
 	int err;
@@ -1841,8 +1843,9 @@ get_ctx_vol_failed:
 	 * Get the inode for the logfile, check it and determine if the volume
 	 * was shutdown cleanly.
 	 */
-	if (!load_and_check_logfile(vol) ||
-			!ntfs_is_logfile_clean(vol->logfile_ino)) {
+	rp = NULL;
+	if (!load_and_check_logfile(vol, &rp) ||
+			!ntfs_is_logfile_clean(vol->logfile_ino, rp)) {
 		static const char *es1a = "Failed to load $LogFile";
 		static const char *es1b = "$LogFile is not clean";
 		static const char *es2 = ".  Mount in Windows.";
@@ -1857,6 +1860,10 @@ get_ctx_vol_failed:
 						"continue nor on_errors="
 						"remount-ro was specified%s",
 						es1, es2);
+				if (vol->logfile_ino) {
+					BUG_ON(!rp);
+					ntfs_free(rp);
+				}
 				goto iput_logfile_err_out;
 			}
 			sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
@@ -1867,6 +1874,7 @@ get_ctx_vol_failed:
 		/* This will prevent a read-write remount. */
 		NVolSetErrors(vol);
 	}
+	ntfs_free(rp);
 #endif /* NTFS_RW */
 	/* Get the root directory inode so we can do path lookups. */
 	vol->root_ino = ntfs_iget(sb, FILE_root);


