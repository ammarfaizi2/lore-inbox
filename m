Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUIVMTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUIVMTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 08:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUIVMSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 08:18:49 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:46025 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264980AbUIVMQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 08:16:26 -0400
Date: Wed, 22 Sep 2004 13:16:21 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 4/7] Re: [2.6-BK-URL] NTFS 2.1.18 release
In-Reply-To: <Pine.LNX.4.60.0409221315460.505@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409221316040.505@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409221308540.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221314250.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221315251.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221315460.505@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 4/7 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/21 1.1941)
   NTFS: Rename {find,lookup}_attr() to ntfs_attr_{find,lookup}() as well as
         find_external_attr() to ntfs_external_attr_find() to cleanup the
         namespace a bit and to be more consistent with libntfs.
   
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
--- a/fs/ntfs/ChangeLog	2004-09-22 13:02:44 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-22 13:02:44 +01:00
@@ -28,6 +28,13 @@
 	- Fix scheduling latencies in ntfs_fill_super() by dropping the BKL
 	  because the code itself is using the ntfs_lock semaphore which
 	  provides safe locking.  (Ingo Molnar)
+	- Fix a potential bug in fs/ntfs/mft.c::map_extent_mft_record() that
+	  could occur in the future for when we start closing/freeing extent
+	  inodes if we don't set base_ni->ext.extent_ntfs_inos to NULL after
+	  we free it.
+	- Rename {find,lookup}_attr() to ntfs_attr_{find,lookup}() as well as
+	  find_external_attr() to ntfs_external_attr_find() to cleanup the
+	  namespace a bit and to be more consistent with libntfs.
 
 2.1.17 - Fix bugs in mount time error code paths and other updates.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-09-22 13:02:44 +01:00
+++ b/fs/ntfs/aops.c	2004-09-22 13:02:44 +01:00
@@ -402,7 +402,7 @@
 		err = -ENOMEM;
 		goto unm_err_out;
 	}
-	if (unlikely(!lookup_attr(ni->type, ni->name, ni->name_len,
+	if (unlikely(!ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
 			CASE_SENSITIVE, 0, NULL, 0, ctx))) {
 		err = -ENOENT;
 		goto put_unm_err_out;
@@ -1122,7 +1122,7 @@
 		err = -ENOMEM;
 		goto err_out;
 	}
-	if (unlikely(!lookup_attr(ni->type, ni->name, ni->name_len,
+	if (unlikely(!ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
 			CASE_SENSITIVE, 0, NULL, 0, ctx))) {
 		err = -ENOENT;
 		goto err_out;
@@ -1683,7 +1683,7 @@
 	 * We thus defer the uptodate bringing of the page region outside the
 	 * region written to to ntfs_commit_write(). The reason for doing this
 	 * is that we save one round of:
-	 *	map_mft_record(), get_attr_search_ctx(), lookup_attr(),
+	 *	map_mft_record(), get_attr_search_ctx(), ntfs_attr_lookup(),
 	 *	kmap_atomic(), kunmap_atomic(), put_attr_search_ctx(),
 	 *	unmap_mft_record().
 	 * Which is obviously a very worthwhile save.
@@ -1896,7 +1896,7 @@
 		err = -ENOMEM;
 		goto err_out;
 	}
-	if (unlikely(!lookup_attr(ni->type, ni->name, ni->name_len,
+	if (unlikely(!ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
 			CASE_SENSITIVE, 0, NULL, 0, ctx))) {
 		err = -ENOENT;
 		goto err_out;
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-09-22 13:02:44 +01:00
+++ b/fs/ntfs/attrib.c	2004-09-22 13:02:44 +01:00
@@ -966,8 +966,8 @@
 		err = -ENOMEM;
 		goto err_out;
 	}
-	if (!lookup_attr(ni->type, ni->name, ni->name_len, CASE_SENSITIVE, vcn,
-			NULL, 0, ctx)) {
+	if (!ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
+			vcn, NULL, 0, ctx)) {
 		put_attr_search_ctx(ctx);
 		err = -ENOENT;
 		goto err_out;
@@ -1148,7 +1148,7 @@
 }
 
 /**
- * find_attr - find (next) attribute in mft record
+ * ntfs_attr_find - find (next) attribute in mft record
  * @type:	attribute type to find
  * @name:	attribute name to find (optional, i.e. NULL means don't care)
  * @name_len:	attribute name length (only needed if @name present)
@@ -1157,47 +1157,49 @@
  * @val_len:	attribute value length
  * @ctx:	search context with mft record and attribute to search from
  *
- * You shouldn't need to call this function directly. Use lookup_attr() instead.
+ * You should not need to call this function directly.  Use ntfs_attr_lookup()
+ * instead.
  *
- * find_attr() takes a search context @ctx as parameter and searches the mft
- * record specified by @ctx->mrec, beginning at @ctx->attr, for an attribute of
- * @type, optionally @name and @val. If found, find_attr() returns TRUE and
- * @ctx->attr will point to the found attribute. If not found, find_attr()
- * returns FALSE and @ctx->attr is undefined (i.e. do not rely on it not
- * changing).
+ * ntfs_attr_find() takes a search context @ctx as parameter and searches the
+ * mft record specified by @ctx->mrec, beginning at @ctx->attr, for an
+ * attribute of @type, optionally @name and @val.  If found, ntfs_attr_find()
+ * returns TRUE and @ctx->attr will point to the found attribute.  If not
+ * found, ntfs_attr_find() returns FALSE and @ctx->attr is undefined (i.e. do
+ * not rely on it not changing).
  *
- * If @ctx->is_first is TRUE, the search begins with @ctx->attr itself. If it
+ * If @ctx->is_first is TRUE, the search begins with @ctx->attr itself.  If it
  * is FALSE, the search begins after @ctx->attr.
  *
  * If @ic is IGNORE_CASE, the @name comparisson is not case sensitive and
  * @ctx->ntfs_ino must be set to the ntfs inode to which the mft record
- * @ctx->mrec belongs. This is so we can get at the ntfs volume and hence at
- * the upcase table. If @ic is CASE_SENSITIVE, the comparison is case
- * sensitive. When @name is present, @name_len is the @name length in Unicode
+ * @ctx->mrec belongs.  This is so we can get at the ntfs volume and hence at
+ * the upcase table.  If @ic is CASE_SENSITIVE, the comparison is case
+ * sensitive.  When @name is present, @name_len is the @name length in Unicode
  * characters.
  *
  * If @name is not present (NULL), we assume that the unnamed attribute is
  * being searched for.
  *
- * Finally, the resident attribute value @val is looked for, if present. If @val
- * is not present (NULL), @val_len is ignored.
+ * Finally, the resident attribute value @val is looked for, if present.  If
+ * @val is not present (NULL), @val_len is ignored.
  *
- * find_attr() only searches the specified mft record and it ignores the
+ * ntfs_attr_find() only searches the specified mft record and it ignores the
  * presence of an attribute list attribute (unless it is the one being searched
- * for, obviously). If you need to take attribute lists into consideration, use
- * lookup_attr() instead (see below). This also means that you cannot use
- * find_attr() to search for extent records of non-resident attributes, as
- * extents with lowest_vcn != 0 are usually described by the attribute list
- * attribute only. - Note that it is possible that the first extent is only in
- * the attribute list while the last extent is in the base mft record, so don't
- * rely on being able to find the first extent in the base mft record.
+ * for, obviously).  If you need to take attribute lists into consideration,
+ * use ntfs_attr_lookup() instead (see below).  This also means that you cannot
+ * use ntfs_attr_find() to search for extent records of non-resident
+ * attributes, as extents with lowest_vcn != 0 are usually described by the
+ * attribute list attribute only. - Note that it is possible that the first
+ * extent is only in the attribute list while the last extent is in the base
+ * mft record, so do not rely on being able to find the first extent in the
+ * base mft record.
  *
  * Warning: Never use @val when looking for attribute types which can be
  *	    non-resident as this most likely will result in a crash!
  */
-BOOL find_attr(const ATTR_TYPES type, const ntfschar *name, const u32 name_len,
-		const IGNORE_CASE_BOOL ic, const u8 *val, const u32 val_len,
-		attr_search_context *ctx)
+BOOL ntfs_attr_find(const ATTR_TYPES type, const ntfschar *name,
+		const u32 name_len, const IGNORE_CASE_BOOL ic,
+		const u8 *val, const u32 val_len, attr_search_context *ctx)
 {
 	ATTR_RECORD *a;
 	ntfs_volume *vol;
@@ -1419,7 +1421,7 @@
 }
 
 /**
- * find_external_attr - find an attribute in the attribute list of an ntfs inode
+ * ntfs_external_attr_find - find an attribute in the attribute list of an inode
  * @type:	attribute type to find
  * @name:	attribute name to find (optional, i.e. NULL means don't care)
  * @name_len:	attribute name length (only needed if @name present)
@@ -1429,34 +1431,35 @@
  * @val_len:	attribute value length
  * @ctx:	search context with mft record and attribute to search from
  *
- * You shouldn't need to call this function directly. Use lookup_attr() instead.
+ * You should not need to call this function directly.  Use ntfs_attr_lookup()
+ * instead.
  *
  * Find an attribute by searching the attribute list for the corresponding
- * attribute list entry. Having found the entry, map the mft record for read
- * if the attribute is in a different mft record/inode, find_attr the attribute
+ * attribute list entry.  Having found the entry, map the mft record if the
+ * attribute is in a different mft record/inode, ntfs_attr_find() the attribute
  * in there and return it.
  *
  * On first search @ctx->ntfs_ino must be the base mft record and @ctx must
- * have been obtained from a call to get_attr_search_ctx(). On subsequent calls
- * @ctx->ntfs_ino can be any extent inode, too (@ctx->base_ntfs_ino is then the
- * base inode).
+ * have been obtained from a call to get_attr_search_ctx().  On subsequent
+ * calls @ctx->ntfs_ino can be any extent inode, too (@ctx->base_ntfs_ino is
+ * then the base inode).
  *
  * After finishing with the attribute/mft record you need to call
  * put_attr_search_ctx() to cleanup the search context (unmapping any mapped
  * inodes, etc).
  *
- * Return TRUE if the search was successful and FALSE if not. When TRUE,
- * @ctx->attr is the found attribute and it is in mft record @ctx->mrec. When
+ * Return TRUE if the search was successful and FALSE if not.  When TRUE,
+ * @ctx->attr is the found attribute and it is in mft record @ctx->mrec.  When
  * FALSE, @ctx->attr is the attribute which collates just after the attribute
  * being searched for in the base ntfs inode, i.e. if one wants to add the
  * attribute to the mft record this is the correct place to insert it into
  * and if there is not enough space, the attribute should be placed in an
  * extent mft record.
  */
-static BOOL find_external_attr(const ATTR_TYPES type, const ntfschar *name,
-		const u32 name_len, const IGNORE_CASE_BOOL ic,
-		const VCN lowest_vcn, const u8 *val, const u32 val_len,
-		attr_search_context *ctx)
+static BOOL ntfs_external_attr_find(const ATTR_TYPES type,
+		const ntfschar *name, const u32 name_len,
+		const IGNORE_CASE_BOOL ic, const VCN lowest_vcn,
+		const u8 *val, const u32 val_len, attr_search_context *ctx)
 {
 	ntfs_inode *base_ni, *ni;
 	ntfs_volume *vol;
@@ -1538,10 +1541,11 @@
 				continue;
 			/*
 			 * FIXME: Reverse engineering showed 0, IGNORE_CASE but
-			 * that is inconsistent with find_attr(). The subsequent
-			 * rc checks were also different. Perhaps I made a
-			 * mistake in one of the two. Need to recheck which is
-			 * correct or at least see what is going on... (AIA)
+			 * that is inconsistent with ntfs_attr_find().  The
+			 * subsequent rc checks were also different.  Perhaps I
+			 * made a mistake in one of the two.  Need to recheck
+			 * which is correct or at least see what is going on...
+			 * (AIA)
 			 */
 			rc = ntfs_collate_names(name, name_len, al_name,
 					al_name_len, 1, CASE_SENSITIVE,
@@ -1609,14 +1613,14 @@
 		 * current al_entry.
 		 */
 		/*
-		 * We could call into find_attr() to find the right attribute
-		 * in this mft record but this would be less efficient and not
-		 * quite accurate as find_attr() ignores the attribute instance
-		 * numbers for example which become important when one plays
-		 * with attribute lists. Also, because a proper match has been
-		 * found in the attribute list entry above, the comparison can
-		 * now be optimized. So it is worth re-implementing a
-		 * simplified find_attr() here.
+		 * We could call into ntfs_attr_ind() to find the right
+		 * attribute in this mft record but this would be less
+		 * efficient and not quite accurate as ntfs_attr_find() ignores
+		 * the attribute instance numbers for example which become
+		 * important when one plays with attribute lists.  Also,
+		 * because a proper match has been found in the attribute list
+		 * entry above, the comparison can now be optimized.  So it is
+		 * worth re-implementing a simplified ntfs_attr_find() here.
 		 */
 		a = ctx->attr;
 		/*
@@ -1689,13 +1693,13 @@
 	 * FIXME: Do we really want to do this here? Think about it... (AIA)
 	 */
 	reinit_attr_search_ctx(ctx);
-	find_attr(type, name, name_len, ic, val, val_len, ctx);
+	ntfs_attr_find(type, name, name_len, ic, val, val_len, ctx);
 	ntfs_debug("Done, not found.");
 	return FALSE;
 }
 
 /**
- * lookup_attr - find an attribute in an ntfs inode
+ * ntfs_attr_lookup - find an attribute in an ntfs inode
  * @type:	attribute type to find
  * @name:	attribute name to find (optional, i.e. NULL means don't care)
  * @name_len:	attribute name length (only needed if @name present)
@@ -1722,7 +1726,7 @@
  * being searched for, i.e. if one wants to add the attribute to the mft
  * record this is the correct place to insert it into.
  */
-BOOL lookup_attr(const ATTR_TYPES type, const ntfschar *name,
+BOOL ntfs_attr_lookup(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic,
 		const VCN lowest_vcn, const u8 *val, const u32 val_len,
 		attr_search_context *ctx)
@@ -1737,9 +1741,10 @@
 	/* Sanity check, just for debugging really. */
 	BUG_ON(!base_ni);
 	if (!NInoAttrList(base_ni))
-		return find_attr(type, name, name_len, ic, val, val_len, ctx);
-	return find_external_attr(type, name, name_len, ic, lowest_vcn, val,
-			val_len, ctx);
+		return ntfs_attr_find(type, name, name_len, ic, val, val_len,
+				ctx);
+	return ntfs_external_attr_find(type, name, name_len, ic, lowest_vcn,
+			val, val_len, ctx);
 }
 
 /**
diff -Nru a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h	2004-09-22 13:02:44 +01:00
+++ b/fs/ntfs/attrib.h	2004-09-22 13:02:44 +01:00
@@ -46,7 +46,7 @@
  * attr_search_context - used in attribute search functions
  * @mrec:	buffer containing mft record to search
  * @attr:	attribute record in @mrec where to begin/continue search
- * @is_first:	if true lookup_attr() begins search with @attr, else after @attr
+ * @is_first:	if true ntfs_attr_lookup() begins search with @attr, else after
  *
  * Structure must be initialized to zero before the first call to one of the
  * attribute search functions. Initialize @mrec to point to the mft record to
@@ -81,11 +81,11 @@
 extern runlist_element *ntfs_find_vcn(ntfs_inode *ni, const VCN vcn,
 		const BOOL need_write);
 
-extern BOOL find_attr(const ATTR_TYPES type, const ntfschar *name,
+extern BOOL ntfs_attr_find(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic, const u8 *val,
 		const u32 val_len, attr_search_context *ctx);
 
-BOOL lookup_attr(const ATTR_TYPES type, const ntfschar *name,
+BOOL ntfs_attr_lookup(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic,
 		const VCN lowest_vcn, const u8 *val, const u32 val_len,
 		attr_search_context *ctx);
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	2004-09-22 13:02:44 +01:00
+++ b/fs/ntfs/dir.c	2004-09-22 13:02:44 +01:00
@@ -106,8 +106,8 @@
 		goto err_out;
 	}
 	/* Find the index root attribute in the mft record. */
-	if (!lookup_attr(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL, 0,
-			ctx)) {
+	if (!ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL,
+			0, ctx)) {
 		ntfs_error(sb, "Index root attribute missing in directory "
 				"inode 0x%lx.", dir_ni->mft_no);
 		err = -EIO;
@@ -655,8 +655,8 @@
 		goto err_out;
 	}
 	/* Find the index root attribute in the mft record. */
-	if (!lookup_attr(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL, 0,
-			ctx)) {
+	if (!ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL,
+			0, ctx)) {
 		ntfs_error(sb, "Index root attribute missing in directory "
 				"inode 0x%lx.", dir_ni->mft_no);
 		err = -EIO;
@@ -1183,8 +1183,8 @@
 	/* Get the offset into the index root attribute. */
 	ir_pos = (s64)fpos;
 	/* Find the index root attribute in the mft record. */
-	if (unlikely(!lookup_attr(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0,
-			NULL, 0, ctx))) {
+	if (unlikely(!ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE,
+			0, NULL, 0, ctx))) {
 		ntfs_error(sb, "Index root attribute missing in directory "
 				"inode 0x%lx.", vdir->i_ino);
 		goto err_out;
diff -Nru a/fs/ntfs/index.c b/fs/ntfs/index.c
--- a/fs/ntfs/index.c	2004-09-22 13:02:44 +01:00
+++ b/fs/ntfs/index.c	2004-09-22 13:02:44 +01:00
@@ -168,7 +168,7 @@
 		goto err_out;
 	}
 	/* Find the index root attribute in the mft record. */
-	if (!lookup_attr(AT_INDEX_ROOT, idx_ni->name, idx_ni->name_len,
+	if (!ntfs_attr_lookup(AT_INDEX_ROOT, idx_ni->name, idx_ni->name_len,
 			CASE_SENSITIVE, 0, NULL, 0, actx)) {
 		ntfs_error(sb, "Index root attribute missing in inode 0x%lx.",
 				idx_ni->mft_no);
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-09-22 13:02:44 +01:00
+++ b/fs/ntfs/inode.c	2004-09-22 13:02:44 +01:00
@@ -441,7 +441,7 @@
 	nr_links = le16_to_cpu(ctx->mrec->link_count);
 
 	/* Loop through all hard links. */
-	while (lookup_attr(AT_FILE_NAME, NULL, 0, 0, 0, NULL, 0, ctx)) {
+	while (ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0, NULL, 0, ctx)) {
 		FILE_NAME_ATTR *file_name_attr;
 		ATTR_RECORD *attr = ctx->attr;
 		u8 *p, *p2;
@@ -608,7 +608,7 @@
 	 * in fact fail if the standard information is in an extent record, but
 	 * I don't think this actually ever happens.
 	 */
-	if (!lookup_attr(AT_STANDARD_INFORMATION, NULL, 0, 0, 0, NULL, 0,
+	if (!ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0, 0, 0, NULL, 0,
 			ctx)) {
 		/*
 		 * TODO: We should be performing a hot fix here (if the recover
@@ -647,7 +647,7 @@
 
 	/* Find the attribute list attribute if present. */
 	reinit_attr_search_ctx(ctx);
-	if (lookup_attr(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx)) {
+	if (ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx)) {
 		if (vi->i_ino == FILE_MFT)
 			goto skip_attr_list_load;
 		ntfs_debug("Attribute list found in inode 0x%lx.", vi->i_ino);
@@ -734,7 +734,7 @@
 
 		/* It is a directory, find index root attribute. */
 		reinit_attr_search_ctx(ctx);
-		if (!lookup_attr(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0,
+		if (!ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0,
 				NULL, 0, ctx)) {
 			// FIXME: File is corrupt! Hot-fix with empty index
 			// root attribute if recovery option is set.
@@ -850,8 +850,8 @@
 		NInoSetIndexAllocPresent(ni);
 		/* Find index allocation attribute. */
 		reinit_attr_search_ctx(ctx);
-		if (!lookup_attr(AT_INDEX_ALLOCATION, I30, 4, CASE_SENSITIVE,
-				0, NULL, 0, ctx)) {
+		if (!ntfs_attr_lookup(AT_INDEX_ALLOCATION, I30, 4,
+				CASE_SENSITIVE, 0, NULL, 0, ctx)) {
 			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
 					"is not present but $INDEX_ROOT "
 					"indicated it is.");
@@ -946,7 +946,7 @@
 		ni->name_len = 0;
 
 		/* Find first extent of the unnamed data attribute. */
-		if (!lookup_attr(AT_DATA, NULL, 0, 0, 0, NULL, 0, ctx)) {
+		if (!ntfs_attr_lookup(AT_DATA, NULL, 0, 0, 0, NULL, 0, ctx)) {
 			vi->i_size = ni->initialized_size =
 					ni->allocated_size = 0LL;
 			/*
@@ -1169,8 +1169,8 @@
 	}
 
 	/* Find the attribute. */
-	if (!lookup_attr(ni->type, ni->name, ni->name_len, CASE_SENSITIVE, 0,
-			NULL, 0, ctx))
+	if (!ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
+			0, NULL, 0, ctx))
 		goto unm_err_out;
 
 	if (!ctx->attr->non_resident) {
@@ -1425,8 +1425,8 @@
 		goto unm_err_out;
 	}
 	/* Find the index root attribute. */
-	if (!lookup_attr(AT_INDEX_ROOT, ni->name, ni->name_len, CASE_SENSITIVE,
-			0, NULL, 0, ctx)) {
+	if (!ntfs_attr_lookup(AT_INDEX_ROOT, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx)) {
 		ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is missing.");
 		goto unm_err_out;
 	}
@@ -1506,7 +1506,7 @@
 	NInoSetIndexAllocPresent(ni);
 	/* Find index allocation attribute. */
 	reinit_attr_search_ctx(ctx);
-	if (!lookup_attr(AT_INDEX_ALLOCATION, ni->name, ni->name_len,
+	if (!ntfs_attr_lookup(AT_INDEX_ALLOCATION, ni->name, ni->name_len,
 			CASE_SENSITIVE, 0, NULL, 0, ctx)) {
 		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is not "
 				"present but $INDEX_ROOT indicated it is.");
@@ -1619,16 +1619,16 @@
  * is not initialized and hence we cannot get at the contents of mft records
  * by calling map_mft_record*().
  *
- * Further it needs to cope with the circular references problem, i.e. can't
+ * Further it needs to cope with the circular references problem, i.e. cannot
  * load any attributes other than $ATTRIBUTE_LIST until $DATA is loaded, because
- * we don't know where the other extent mft records are yet and again, because
- * we cannot call map_mft_record*() yet. Obviously this applies only when an
+ * we do not know where the other extent mft records are yet and again, because
+ * we cannot call map_mft_record*() yet.  Obviously this applies only when an
  * attribute list is actually present in $MFT inode.
  *
  * We solve these problems by starting with the $DATA attribute before anything
- * else and iterating using lookup_attr($DATA) over all extents. As each extent
- * is found, we decompress_mapping_pairs() including the implied
- * merge_runlists(). Each step of the iteration necessarily provides
+ * else and iterating using ntfs_attr_lookup($DATA) over all extents.  As each
+ * extent is found, we decompress_mapping_pairs() including the implied
+ * ntfs_merge_runlists().  Each step of the iteration necessarily provides
  * sufficient information for the next step to complete.
  *
  * This should work but there are two possible pit falls (see inline comments
@@ -1726,7 +1726,7 @@
 	}
 
 	/* Find the attribute list attribute if present. */
-	if (lookup_attr(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx)) {
+	if (ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx)) {
 		ATTR_LIST_ENTRY *al_entry, *next_al_entry;
 		u8 *al_end;
 
@@ -1860,7 +1860,7 @@
 	/* Now load all attribute extents. */
 	attr = NULL;
 	next_vcn = last_vcn = highest_vcn = 0;
-	while (lookup_attr(AT_DATA, NULL, 0, 0, next_vcn, NULL, 0, ctx)) {
+	while (ntfs_attr_lookup(AT_DATA, NULL, 0, 0, next_vcn, NULL, 0, ctx)) {
 		runlist_element *nrl;
 
 		/* Cache the current attribute. */
@@ -2347,7 +2347,7 @@
 		err = -ENOMEM;
 		goto unm_err_out;
 	}
-	if (unlikely(!lookup_attr(AT_STANDARD_INFORMATION, NULL, 0,
+	if (unlikely(!ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0,
 			CASE_SENSITIVE, 0, NULL, 0, ctx))) {
 		put_attr_search_ctx(ctx);
 		err = -ENOENT;
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	2004-09-22 13:02:44 +01:00
+++ b/fs/ntfs/namei.c	2004-09-22 13:02:44 +01:00
@@ -205,8 +205,8 @@
 			ATTR_RECORD *a;
 			u32 val_len;
 
-			if (!lookup_attr(AT_FILE_NAME, NULL, 0, 0, 0, NULL, 0,
-					ctx)) {
+			if (!ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0,
+					NULL, 0, ctx)) {
 				ntfs_error(vol->sb, "Inode corrupt: No WIN32 "
 						"namespace counterpart to DOS "
 						"file name. Run chkdsk.");
@@ -385,8 +385,8 @@
 		return ERR_PTR(-ENOMEM);
 	}
 try_next:
-	if (unlikely(!lookup_attr(AT_FILE_NAME, NULL, 0, CASE_SENSITIVE, 0,
-			NULL, 0, ctx))) {
+	if (unlikely(!ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, CASE_SENSITIVE,
+			0, NULL, 0, ctx))) {
 		put_attr_search_ctx(ctx);
 		unmap_mft_record(ni);
 		ntfs_error(vi->i_sb, "Inode 0x%lx does not have a file name "
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-09-22 13:02:44 +01:00
+++ b/fs/ntfs/super.c	2004-09-22 13:02:44 +01:00
@@ -336,7 +336,8 @@
 		err = -ENOMEM;
 		goto put_unm_err_out;
 	}
-	if (!lookup_attr(AT_VOLUME_INFORMATION, NULL, 0, 0, 0, NULL, 0, ctx)) {
+	if (!ntfs_attr_lookup(AT_VOLUME_INFORMATION, NULL, 0, 0, 0, NULL, 0,
+			ctx)) {
 		err = -EIO;
 		goto put_unm_err_out;
 	}
@@ -1432,8 +1433,8 @@
 		ntfs_error(sb, "Failed to get attribute search context.");
 		goto get_ctx_vol_failed;
 	}
-	if (!lookup_attr(AT_VOLUME_INFORMATION, NULL, 0, 0, 0, NULL, 0, ctx) ||
-			ctx->attr->non_resident || ctx->attr->flags) {
+	if (!ntfs_attr_lookup(AT_VOLUME_INFORMATION, NULL, 0, 0, 0, NULL, 0,
+			ctx) || ctx->attr->non_resident || ctx->attr->flags) {
 err_put_vol:
 		put_attr_search_ctx(ctx);
 get_ctx_vol_failed:
