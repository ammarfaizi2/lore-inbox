Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUHWLHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUHWLHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 07:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUHWLAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 07:00:44 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:2766 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267709AbUHWKd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:33:57 -0400
Date: Mon, 23 Aug 2004 11:33:52 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 19/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231133210.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231133390.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129370.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129530.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130090.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130240.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130380.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130510.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131070.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131200.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131390.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131520.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231132080.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231132240.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231132500.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231133060.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231133210.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 19/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/08/18 1.1825)
   NTFS: - Load attribute definition table from $AttrDef at mount time.
         - Fix bugs in mount time error code paths involving (de)allocation of
           the default and volume upcase tables.
         - Remove ntfs_nr_mounts as it is no longer used.
   
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
--- a/fs/ntfs/ChangeLog	2004-08-18 20:50:47 +01:00
+++ b/fs/ntfs/ChangeLog	2004-08-18 20:50:47 +01:00
@@ -29,6 +29,10 @@
 	  runlist element containing a particular vcn.  It also takes care of
 	  mapping any needed runlist fragments.
 	- Implement cluster (de-)allocation code (fs/ntfs/lcnalloc.[hc]).
+	- Load attribute definition table from $AttrDef at mount time.
+	- Fix bugs in mount time error code paths involving (de)allocation of
+	  the default and volume upcase tables.
+	- Remove ntfs_nr_mounts as it is no longer used.
 
 2.1.16 - Implement access time updates, file sync, async io, and read/writev.
 
diff -Nru a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
--- a/fs/ntfs/ntfs.h	2004-08-18 20:50:47 +01:00
+++ b/fs/ntfs/ntfs.h	2004-08-18 20:50:47 +01:00
@@ -158,7 +158,6 @@
 #define default_upcase_len 0x10000
 extern wchar_t *default_upcase;
 extern unsigned long ntfs_nr_upcase_users;
-extern unsigned long ntfs_nr_mounts;
 extern struct semaphore ntfs_lock;
 
 typedef struct {
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-08-18 20:50:47 +01:00
+++ b/fs/ntfs/super.c	2004-08-18 20:50:47 +01:00
@@ -1164,6 +1164,66 @@
 	return TRUE;
 }
 
+/**
+ * load_and_init_attrdef - load the attribute definitions table for a volume
+ * @vol:	ntfs super block describing device whose attrdef to load
+ *
+ * Return TRUE on success or FALSE on error.
+ */
+static BOOL load_and_init_attrdef(ntfs_volume *vol)
+{
+	struct super_block *sb = vol->sb;
+	struct inode *ino;
+	struct page *page;
+	unsigned long index, max_index;
+	unsigned int size;
+
+	ntfs_debug("Entering.");
+	/* Read attrdef table and setup vol->attrdef and vol->attrdef_size. */
+	ino = ntfs_iget(sb, FILE_AttrDef);
+	if (IS_ERR(ino) || is_bad_inode(ino)) {
+		if (!IS_ERR(ino))
+			iput(ino);
+		goto failed;
+	}
+	/* The size of FILE_AttrDef must be above 0 and fit inside 31 bits. */
+	if (!ino->i_size || ino->i_size > 0x7fffffff)
+		goto iput_failed;
+	vol->attrdef = (ATTR_DEF*)ntfs_malloc_nofs(ino->i_size);
+	if (!vol->attrdef)
+		goto iput_failed;
+	index = 0;
+	max_index = ino->i_size >> PAGE_CACHE_SHIFT;
+	size = PAGE_CACHE_SIZE;
+	while (index < max_index) {
+		/* Read the attrdef table and copy it into the linear buffer. */
+read_partial_attrdef_page:
+		page = ntfs_map_page(ino->i_mapping, index);
+		if (IS_ERR(page))
+			goto free_iput_failed;
+		memcpy((u8*)vol->attrdef + (index++ << PAGE_CACHE_SHIFT),
+				page_address(page), size);
+		ntfs_unmap_page(page);
+	};
+	if (size == PAGE_CACHE_SIZE) {
+		size = ino->i_size & ~PAGE_CACHE_MASK;
+		if (size)
+			goto read_partial_attrdef_page;
+	}
+	vol->attrdef_size = ino->i_size;
+	ntfs_debug("Read %llu bytes from $AttrDef.", ino->i_size);
+	iput(ino);
+	return TRUE;
+free_iput_failed:
+	ntfs_free(vol->attrdef);
+	vol->attrdef = NULL;
+iput_failed:
+	iput(ino);
+failed:
+	ntfs_error(sb, "Failed to initialize attribute definition table.");
+	return FALSE;
+}
+
 #endif /* NTFS_RW */
 
 /**
@@ -1264,7 +1324,7 @@
 		return TRUE;
 	}
 	up(&ntfs_lock);
-	ntfs_error(sb, "Failed to initialized upcase table.");
+	ntfs_error(sb, "Failed to initialize upcase table.");
 	return FALSE;
 }
 
@@ -1280,7 +1340,6 @@
 static BOOL load_system_files(ntfs_volume *vol)
 {
 	struct super_block *sb = vol->sb;
-	struct inode *tmp_ino;
 	MFT_RECORD *m;
 	VOLUME_INFORMATION *vi;
 	attr_search_context *ctx;
@@ -1324,6 +1383,14 @@
 	/* Read upcase table and setup @vol->upcase and @vol->upcase_len. */
 	if (!load_and_init_upcase(vol))
 		goto iput_mftbmp_err_out;
+#ifdef NTFS_RW
+	/*
+	 * Read attribute definitions table and setup @vol->attrdef and
+	 * @vol->attrdef_size.
+	 */
+	if (!load_and_init_attrdef(vol))
+		goto iput_upcase_err_out;
+#endif /* NTFS_RW */
 	/*
 	 * Get the cluster allocation bitmap inode and verify the size, no
 	 * need for any locking at this stage as we are already running
@@ -1339,7 +1406,7 @@
 		iput(vol->lcnbmp_ino);
 bitmap_failed:
 		ntfs_error(sb, "Failed to load $Bitmap.");
-		goto iput_mirr_err_out;
+		goto iput_attrdef_err_out;
 	}
 	/*
 	 * Get the volume inode and setup our cache of the volume flags and
@@ -1511,19 +1578,6 @@
 		NVolSetErrors(vol);
 	}
 #endif /* NTFS_RW */
-	/*
-	 * Get the inode for the attribute definitions file and parse the
-	 * attribute definitions.
-	 */
-	tmp_ino = ntfs_iget(sb, FILE_AttrDef);
-	if (IS_ERR(tmp_ino) || is_bad_inode(tmp_ino)) {
-		if (!IS_ERR(tmp_ino))
-			iput(tmp_ino);
-		ntfs_error(sb, "Failed to load $AttrDef.");
-		goto iput_logfile_err_out;
-	}
-	// FIXME: Parse the attribute definitions.
-	iput(tmp_ino);
 	/* Get the root directory inode. */
 	vol->root_ino = ntfs_iget(sb, FILE_root);
 	if (IS_ERR(vol->root_ino) || is_bad_inode(vol->root_ino)) {
@@ -1619,6 +1673,26 @@
 	iput(vol->vol_ino);
 iput_lcnbmp_err_out:
 	iput(vol->lcnbmp_ino);
+iput_attrdef_err_out:
+	vol->attrdef_size = 0;
+	if (vol->attrdef) {
+		ntfs_free(vol->attrdef);
+		vol->attrdef = NULL;
+	}
+#ifdef NTFS_RW
+iput_upcase_err_out:
+#endif /* NTFS_RW */
+	vol->upcase_len = 0;
+	down(&ntfs_lock);
+	if (vol->upcase == default_upcase) {
+		ntfs_nr_upcase_users--;
+		vol->upcase = NULL;
+	}
+	up(&ntfs_lock);
+	if (vol->upcase) {
+		ntfs_free(vol->upcase);
+		vol->upcase = NULL;
+	}
 iput_mftbmp_err_out:
 	iput(vol->mftbmp_ino);
 iput_mirr_err_out:
@@ -1790,14 +1864,18 @@
 	iput(vol->mft_ino);
 	vol->mft_ino = NULL;
 
+	/* Throw away the table of attribute definitions. */
+	vol->attrdef_size = 0;
+	if (vol->attrdef) {
+		ntfs_free(vol->attrdef);
+		vol->attrdef = NULL;
+	}
 	vol->upcase_len = 0;
 	/*
-	 * Decrease the number of mounts and destroy the global default upcase
-	 * table if necessary.  Also decrease the number of upcase users if we
-	 * are a user.
+	 * Destroy the global default upcase table if necessary.  Also decrease
+	 * the number of upcase users if we are a user.
 	 */
 	down(&ntfs_lock);
-	ntfs_nr_mounts--;
 	if (vol->upcase == default_upcase) {
 		ntfs_nr_upcase_users--;
 		vol->upcase = NULL;
@@ -2181,6 +2259,7 @@
 	memset(vol, 0, sizeof(ntfs_volume));
 	vol->sb = sb;
 	vol->upcase = NULL;
+	vol->attrdef = NULL;
 	vol->mft_ino = NULL;
 	vol->mftbmp_ino = NULL;
 	init_rwsem(&vol->mftbmp_lock);
@@ -2312,14 +2391,13 @@
 		}
 	}
 	/*
-	 * Increment the number of mounts and generate the global default
-	 * upcase table if necessary. Also temporarily increment the number of
-	 * upcase users to avoid race conditions with concurrent (u)mounts.
+	 * Generate the global default upcase table if necessary.  Also
+	 * temporarily increment the number of upcase users to avoid race
+	 * conditions with concurrent (u)mounts.
 	 */
-	if (!ntfs_nr_mounts++)
+	if (!default_upcase)
 		default_upcase = generate_default_upcase();
 	ntfs_nr_upcase_users++;
-
 	up(&ntfs_lock);
 	/*
 	 * From now on, ignore @silent parameter. If we fail below this line,
@@ -2391,10 +2469,23 @@
 		vol->mftmirr_ino = NULL;
 	}
 #endif /* NTFS_RW */
+	/* Throw away the table of attribute definitions. */
+	vol->attrdef_size = 0;
+	if (vol->attrdef) {
+		ntfs_free(vol->attrdef);
+		vol->attrdef = NULL;
+	}
 	vol->upcase_len = 0;
-	if (vol->upcase != default_upcase)
+	down(&ntfs_lock);
+	if (vol->upcase == default_upcase) {
+		ntfs_nr_upcase_users--;
+		vol->upcase = NULL;
+	}
+	up(&ntfs_lock);
+	if (vol->upcase) {
 		ntfs_free(vol->upcase);
-	vol->upcase = NULL;
+		vol->upcase = NULL;
+	}
 	if (vol->nls_map) {
 		unload_nls(vol->nls_map);
 		vol->nls_map = NULL;
@@ -2402,11 +2493,10 @@
 	/* Error exit code path. */
 unl_upcase_iput_tmp_ino_err_out_now:
 	/*
-	 * Decrease the number of mounts and destroy the global default upcase
-	 * table if necessary.
+	 * Decrease the number of upcase users and destroy the global default
+	 * upcase table if necessary.
 	 */
 	down(&ntfs_lock);
-	ntfs_nr_mounts--;
 	if (!--ntfs_nr_upcase_users && default_upcase) {
 		ntfs_free(default_upcase);
 		default_upcase = NULL;
@@ -2474,9 +2564,6 @@
 /* A global default upcase table and a corresponding reference count. */
 wchar_t *default_upcase = NULL;
 unsigned long ntfs_nr_upcase_users = 0;
-
-/* The number of mounted filesystems. */
-unsigned long ntfs_nr_mounts = 0;
 
 /* Driver wide semaphore. */
 DECLARE_MUTEX(ntfs_lock);
diff -Nru a/fs/ntfs/volume.h b/fs/ntfs/volume.h
--- a/fs/ntfs/volume.h	2004-08-18 20:50:47 +01:00
+++ b/fs/ntfs/volume.h	2004-08-18 20:50:47 +01:00
@@ -74,6 +74,11 @@
 	u32 upcase_len;			/* Number of entries in upcase[]. */
 	ntfschar *upcase;		/* The upcase table. */
 
+	s32 attrdef_size;		/* Size of the attribute definition
+					   table in bytes. */
+	ATTR_DEF *attrdef;		/* Table of attribute definitions.
+					   Obtained from FILE_AttrDef. */
+
 #ifdef NTFS_RW
 	/* Variables used by the cluster and mft allocators. */
 	LCN mft_zone_start;		/* First cluster of the mft zone. */
