Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUIVMaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUIVMaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 08:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUIVMaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 08:30:23 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:37584 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264937AbUIVMRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 08:17:24 -0400
Date: Wed, 22 Sep 2004 13:17:20 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 6/7] Re: [2.6-BK-URL] NTFS 2.1.18 release
In-Reply-To: <Pine.LNX.4.60.0409221316230.505@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409221316480.505@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409221308540.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221314250.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221315251.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221315460.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221316040.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221316230.505@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 6/7 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/21 1.1942.1.1)
   NTFS: - Fix endianness bug in ntfs_external_attr_find().
         - Change ntfs_{external_,}attr_find() to return 0 on success, -ENOENT
   	if the attribute is not found, and -EIO on real error.  In the case
   	of -ENOENT, the search context is updated to describe the attribute
   	before which the attribute being searched for would need to be
   	inserted if such an action were to be desired and in the case of
   	ntfs_external_attr_find() the search context is also updated to
   	indicate the attribute list entry before which the attribute list
   	entry of the attribute being searched for would need to be inserted
   	if such an action were to be desired.  Also make ntfs_find_attr()
   	static and remove its prototype from attrib.h as it is not used
   	anywhere other than attrib.c.  Update ntfs_attr_lookup() and all
   	callers of ntfs_{external,}attr_{find,lookup}() for the new return
   	values.
         - Force use of ntfs_attr_find() in ntfs_attr_lookup() when searching
   	for the attribute list attribute itself.
   
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
--- a/fs/ntfs/ChangeLog	2004-09-22 13:02:51 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-22 13:02:51 +01:00
@@ -38,6 +38,22 @@
 	- Rename {{re,}init,get,put}_attr_search_ctx() to
 	  ntfs_attr_{{re,}init,get,put}_search_ctx() as well as the type
 	  attr_search_context to ntfs_attr_search_ctx.
+	- Force use of ntfs_attr_find() in ntfs_attr_lookup() when searching
+	  for the attribute list attribute itself.
+	- Fix endianness bug in ntfs_external_attr_find().
+	- Change ntfs_{external_,}attr_find() to return 0 on success, -ENOENT
+	  if the attribute is not found, and -EIO on real error.  In the case
+	  of -ENOENT, the search context is updated to describe the attribute
+	  before which the attribute being searched for would need to be
+	  inserted if such an action were to be desired and in the case of
+	  ntfs_external_attr_find() the search context is also updated to
+	  indicate the attribute list entry before which the attribute list
+	  entry of the attribute being searched for would need to be inserted
+	  if such an action were to be desired.  Also make ntfs_find_attr()
+	  static and remove its prototype from attrib.h as it is not used
+	  anywhere other than attrib.c.  Update ntfs_attr_lookup() and all
+	  callers of ntfs_{external,}attr_{find,lookup}() for the new return
+	  values.
 
 2.1.17 - Fix bugs in mount time error code paths and other updates.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-09-22 13:02:51 +01:00
+++ b/fs/ntfs/aops.c	2004-09-22 13:02:51 +01:00
@@ -402,11 +402,10 @@
 		err = -ENOMEM;
 		goto unm_err_out;
 	}
-	if (unlikely(!ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-			CASE_SENSITIVE, 0, NULL, 0, ctx))) {
-		err = -ENOENT;
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err))
 		goto put_unm_err_out;
-	}
 
 	/* Starting position of the page within the attribute value. */
 	attr_pos = page->index << PAGE_CACHE_SHIFT;
@@ -1122,11 +1121,10 @@
 		err = -ENOMEM;
 		goto err_out;
 	}
-	if (unlikely(!ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-			CASE_SENSITIVE, 0, NULL, 0, ctx))) {
-		err = -ENOENT;
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err))
 		goto err_out;
-	}
 
 	/* Starting position of the page within the attribute value. */
 	attr_pos = page->index << PAGE_CACHE_SHIFT;
@@ -1896,11 +1894,10 @@
 		err = -ENOMEM;
 		goto err_out;
 	}
-	if (unlikely(!ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
-			CASE_SENSITIVE, 0, NULL, 0, ctx))) {
-		err = -ENOENT;
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err))
 		goto err_out;
-	}
 
 	/* Starting position of the page within the attribute value. */
 	attr_pos = page->index << PAGE_CACHE_SHIFT;
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-09-22 13:02:51 +01:00
+++ b/fs/ntfs/attrib.c	2004-09-22 13:02:51 +01:00
@@ -962,16 +962,14 @@
 	if (IS_ERR(mrec))
 		return PTR_ERR(mrec);
 	ctx = ntfs_attr_get_search_ctx(base_ni, mrec);
-	if (!ctx) {
+	if (unlikely(!ctx)) {
 		err = -ENOMEM;
 		goto err_out;
 	}
-	if (!ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
-			vcn, NULL, 0, ctx)) {
-		ntfs_attr_put_search_ctx(ctx);
-		err = -ENOENT;
-		goto err_out;
-	}
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, vcn, NULL, 0, ctx);
+	if (unlikely(err))
+		goto put_err_out;
 
 	down_write(&ni->runlist.lock);
 	/* Make sure someone else didn't do the work while we were sleeping. */
@@ -987,6 +985,7 @@
 	}
 	up_write(&ni->runlist.lock);
 
+put_err_out:
 	ntfs_attr_put_search_ctx(ctx);
 err_out:
 	unmap_mft_record(base_ni);
@@ -1162,10 +1161,17 @@
  *
  * ntfs_attr_find() takes a search context @ctx as parameter and searches the
  * mft record specified by @ctx->mrec, beginning at @ctx->attr, for an
- * attribute of @type, optionally @name and @val.  If found, ntfs_attr_find()
- * returns TRUE and @ctx->attr will point to the found attribute.  If not
- * found, ntfs_attr_find() returns FALSE and @ctx->attr is undefined (i.e. do
- * not rely on it not changing).
+ * attribute of @type, optionally @name and @val.
+ *
+ * If the attribute is found, ntfs_attr_find() returns 0 and @ctx->attr will
+ * point to the found attribute.
+ *
+ * If the attribute is not found, ntfs_attr_find() returns -ENOENT and
+ * @ctx->attr will point to the attribute before which the attribute being
+ * searched for would need to be inserted if such an action were to be desired.
+ *
+ * On actual error, ntfs_attr_find() returns -EIO.  In this case @ctx->attr is
+ * undefined and in particular do not rely on it not changing.
  *
  * If @ctx->is_first is TRUE, the search begins with @ctx->attr itself.  If it
  * is FALSE, the search begins after @ctx->attr.
@@ -1197,7 +1203,7 @@
  * Warning: Never use @val when looking for attribute types which can be
  *	    non-resident as this most likely will result in a crash!
  */
-BOOL ntfs_attr_find(const ATTR_TYPES type, const ntfschar *name,
+static int ntfs_attr_find(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic,
 		const u8 *val, const u32 val_len, ntfs_attr_search_ctx *ctx)
 {
@@ -1230,21 +1236,21 @@
 				le32_to_cpu(ctx->mrec->bytes_allocated))
 			break;
 		ctx->attr = a;
-		/* We catch $END with this more general check, too... */
-		if (le32_to_cpu(a->type) > le32_to_cpu(type))
-			return FALSE;
+		if (unlikely(le32_to_cpu(a->type) > le32_to_cpu(type) ||
+				a->type == AT_END))
+			return -ENOENT;
 		if (unlikely(!a->length))
 			break;
 		if (a->type != type)
 			continue;
 		/*
-		 * If @name is present, compare the two names. If @name is
+		 * If @name is present, compare the two names.  If @name is
 		 * missing, assume we want an unnamed attribute.
 		 */
 		if (!name) {
 			/* The search failed if the found attribute is named. */
 			if (a->name_length)
-				return FALSE;
+				return -ENOENT;
 		} else if (!ntfs_are_names_equal(name, name_len,
 			    (ntfschar*)((u8*)a + le16_to_cpu(a->name_offset)),
 			    a->name_length, ic, upcase, upcase_len)) {
@@ -1252,7 +1258,7 @@
 
 			rc = ntfs_collate_names(name, name_len,
 					(ntfschar*)((u8*)a +
-						le16_to_cpu(a->name_offset)),
+					le16_to_cpu(a->name_offset)),
 					a->name_length, 1, IGNORE_CASE,
 					upcase, upcase_len);
 			/*
@@ -1260,56 +1266,55 @@
 			 * matching attribute.
 			 */
 			if (rc == -1)
-				return FALSE;
+				return -ENOENT;
 			/* If the strings are not equal, continue search. */
 			if (rc)
 				continue;
 			rc = ntfs_collate_names(name, name_len,
 					(ntfschar*)((u8*)a +
-						le16_to_cpu(a->name_offset)),
+					le16_to_cpu(a->name_offset)),
 					a->name_length, 1, CASE_SENSITIVE,
 					upcase, upcase_len);
 			if (rc == -1)
-				return FALSE;
+				return -ENOENT;
 			if (rc)
 				continue;
 		}
 		/*
 		 * The names match or @name not present and attribute is
-		 * unnamed. If no @val specified, we have found the attribute
+		 * unnamed.  If no @val specified, we have found the attribute
 		 * and are done.
 		 */
 		if (!val)
-			return TRUE;
+			return 0;
 		/* @val is present; compare values. */
 		else {
-			u32 vl;
 			register int rc;
 
-			vl = le32_to_cpu(a->data.resident.value_length);
-			if (vl > val_len)
-				vl = val_len;
-
 			rc = memcmp(val, (u8*)a + le16_to_cpu(
-					a->data.resident.value_offset), vl);
+					a->data.resident.value_offset),
+					min_t(u32, val_len, le32_to_cpu(
+					a->data.resident.value_length)));
 			/*
 			 * If @val collates before the current attribute's
 			 * value, there is no matching attribute.
 			 */
 			if (!rc) {
 				register u32 avl;
+
 				avl = le32_to_cpu(
 						a->data.resident.value_length);
 				if (val_len == avl)
-					return TRUE;
+					return 0;
 				if (val_len < avl)
-					return FALSE;
+					return -ENOENT;
 			} else if (rc < 0)
-				return FALSE;
+				return -ENOENT;
 		}
 	}
-	ntfs_error(NULL, "Inode is corrupt. Run chkdsk.");
-	return FALSE;
+	ntfs_error(NULL, "Inode is corrupt.  Run chkdsk.");
+	NVolSetErrors(vol);
+	return -EIO;
 }
 
 /**
@@ -1448,15 +1453,29 @@
  * ntfs_attr_put_search_ctx() to cleanup the search context (unmapping any
  * mapped inodes, etc).
  *
- * Return TRUE if the search was successful and FALSE if not.  When TRUE,
- * @ctx->attr is the found attribute and it is in mft record @ctx->mrec.  When
- * FALSE, @ctx->attr is the attribute which collates just after the attribute
- * being searched for in the base ntfs inode, i.e. if one wants to add the
- * attribute to the mft record this is the correct place to insert it into
- * and if there is not enough space, the attribute should be placed in an
- * extent mft record.
+ * If the attribute is found, ntfs_external_attr_find() returns 0 and
+ * @ctx->attr will point to the found attribute.  @ctx->mrec will point to the
+ * mft record in which @ctx->attr is located and @ctx->al_entry will point to
+ * the attribute list entry for the attribute.
+ *
+ * If the attribute is not found, ntfs_external_attr_find() returns -ENOENT and
+ * @ctx->attr will point to the attribute in the base mft record before which
+ * the attribute being searched for would need to be inserted if such an action
+ * were to be desired.  @ctx->mrec will point to the mft record in which
+ * @ctx->attr is located and @ctx->al_entry will point to the attribute list
+ * entry of the attribute before which the attribute being searched for would
+ * need to be inserted if such an action were to be desired.
+ *
+ * Thus to insert the not found attribute, one wants to add the attribute to
+ * @ctx->mrec (the base mft record) and if there is not enough space, the
+ * attribute should be placed in a newly allocated extent mft record.  The
+ * attribute list entry for the inserted attribute should be inserted in the
+ * attribute list attribute at @ctx->al_entry.
+ *
+ * On actual error, ntfs_external_attr_find() returns -EIO.  In this case
+ * @ctx->attr is undefined and in particular do not rely on it not changing.
  */
-static BOOL ntfs_external_attr_find(const ATTR_TYPES type,
+static int ntfs_external_attr_find(const ATTR_TYPES type,
 		const ntfschar *name, const u32 name_len,
 		const IGNORE_CASE_BOOL ic, const VCN lowest_vcn,
 		const u8 *val, const u32 val_len, ntfs_attr_search_ctx *ctx)
@@ -1468,6 +1487,8 @@
 	ATTR_RECORD *a;
 	ntfschar *al_name;
 	u32 al_name_len;
+	int err = 0;
+	static const char *es = " Unmount and run chkdsk.";
 
 	ni = ctx->ntfs_ino;
 	base_ni = ctx->base_ntfs_ino;
@@ -1479,6 +1500,8 @@
 	}
 	if (ni == base_ni)
 		ctx->base_attr = ctx->attr;
+	if (type == AT_END)
+		goto not_found;
 	vol = base_ni->vol;
 	al_start = base_ni->attr_list;
 	al_end = al_start + base_ni->attr_list_size;
@@ -1515,7 +1538,7 @@
 		if (type != al_entry->type)
 			continue;
 		/*
-		 * If @name is present, compare the two names. If @name is
+		 * If @name is present, compare the two names.  If @name is
 		 * missing, assume we want an unnamed attribute.
 		 */
 		al_name_len = al_entry->name_length;
@@ -1557,8 +1580,8 @@
 		}
 		/*
 		 * The names match or @name not present and attribute is
-		 * unnamed. Now check @lowest_vcn. Continue search if the
-		 * next attribute list entry still fits @lowest_vcn. Otherwise
+		 * unnamed.  Now check @lowest_vcn.  Continue search if the
+		 * next attribute list entry still fits @lowest_vcn.  Otherwise
 		 * we have reached the right one or the search has failed.
 		 */
 		if (lowest_vcn && (u8*)next_al_entry >= al_start	    &&
@@ -1566,7 +1589,7 @@
 				(u8*)next_al_entry + le16_to_cpu(
 					next_al_entry->length) <= al_end    &&
 				sle64_to_cpu(next_al_entry->lowest_vcn) <=
-					sle64_to_cpu(lowest_vcn)	    &&
+					lowest_vcn			    &&
 				next_al_entry->type == al_entry->type	    &&
 				next_al_entry->name_length == al_name_len   &&
 				ntfs_are_names_equal((ntfschar*)((u8*)
@@ -1579,7 +1602,10 @@
 		if (MREF_LE(al_entry->mft_reference) == ni->mft_no) {
 			if (MSEQNO_LE(al_entry->mft_reference) != ni->seq_no) {
 				ntfs_error(vol->sb, "Found stale mft "
-						"reference in attribute list!");
+						"reference in attribute list "
+						"of base inode 0x%lx.%s",
+						base_ni->mft_no, es);
+				err = -EIO;
 				break;
 			}
 		} else { /* Mft references do not match. */
@@ -1597,10 +1623,16 @@
 						al_entry->mft_reference, &ni);
 				ctx->ntfs_ino = ni;
 				if (IS_ERR(ctx->mrec)) {
-					ntfs_error(vol->sb, "Failed to map mft "
-							"record, error code "
-							"%ld.",
-							-PTR_ERR(ctx->mrec));
+					ntfs_error(vol->sb, "Failed to map "
+							"extent mft record "
+							"0x%lx of base inode "
+							"0x%lx.%s",
+							MREF_LE(al_entry->
+							mft_reference),
+							base_ni->mft_no, es);
+					err = PTR_ERR(ctx->mrec);
+					if (err == -ENOENT)
+						err = -EIO;
 					break;
 				}
 			}
@@ -1613,7 +1645,7 @@
 		 * current al_entry.
 		 */
 		/*
-		 * We could call into ntfs_attr_ind() to find the right
+		 * We could call into ntfs_attr_find() to find the right
 		 * attribute in this mft record but this would be less
 		 * efficient and not quite accurate as ntfs_attr_find() ignores
 		 * the attribute instance numbers for example which become
@@ -1637,18 +1669,18 @@
 			break;
 		if (al_entry->instance != a->instance)
 			goto do_next_attr;
+		/*
+		 * If the type and/or the name are mismatched between the
+		 * attribute list entry and the attribute record, there is
+		 * corruption so we break and return error EIO.
+		 */
 		if (al_entry->type != a->type)
-			continue;
-		if (name) {
-			if (a->name_length != al_name_len)
-				continue;
-			if (!ntfs_are_names_equal((ntfschar*)((u8*)a +
-					le16_to_cpu(a->name_offset)),
-					a->name_length, al_name, al_name_len,
-					CASE_SENSITIVE, vol->upcase,
-					vol->upcase_len))
-				continue;
-		}
+			break;
+		if (!ntfs_are_names_equal((ntfschar*)((u8*)a +
+				le16_to_cpu(a->name_offset)), a->name_length,
+				al_name, al_name_len, CASE_SENSITIVE,
+				vol->upcase, vol->upcase_len))
+			break;
 		ctx->attr = a;
 		/*
 		 * If no @val specified or @val specified and it matches, we
@@ -1660,42 +1692,72 @@
 				le16_to_cpu(a->data.resident.value_offset),
 				val, val_len))) {
 			ntfs_debug("Done, found.");
-			return TRUE;
+			return 0;
 		}
 do_next_attr:
 		/* Proceed to the next attribute in the current mft record. */
 		a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length));
 		goto do_next_attr_loop;
 	}
-	ntfs_error(base_ni->vol->sb, "Inode contains corrupt attribute list "
-			"attribute.");
+	if (!err) {
+		ntfs_error(vol->sb, "Base inode 0x%lx contains corrupt "
+				"attribute list attribute.%s", base_ni->mft_no,
+				es);
+		err = -EIO;
+	}
 	if (ni != base_ni) {
 		unmap_extent_mft_record(ni);
 		ctx->ntfs_ino = base_ni;
 		ctx->mrec = ctx->base_mrec;
 		ctx->attr = ctx->base_attr;
 	}
+	if (err != -ENOMEM)
+		NVolSetErrors(vol);
+	return err;
+not_found:
+	/*
+	 * If we were looking for AT_END, we reset the search context @ctx and
+	 * use ntfs_attr_find() to seek to the end of the base mft record.
+	 */
+	if (type == AT_END) {
+		ntfs_attr_reinit_search_ctx(ctx);
+		return ntfs_attr_find(AT_END, name, name_len, ic, val, val_len,
+				ctx);
+	}
 	/*
-	 * FIXME: We absolutely have to return ERROR status instead of just
-	 * false or we will blow up or even worse cause corruption when we add
-	 * write support and we reach this code path!
+	 * The attribute was not found.  Before we return, we want to ensure
+	 * @ctx->mrec and @ctx->attr indicate the position at which the
+	 * attribute should be inserted in the base mft record.  Since we also
+	 * want to preserve @ctx->al_entry we cannot reinitialize the search
+	 * context using ntfs_attr_reinit_search_ctx() as this would set
+	 * @ctx->al_entry to NULL.  Thus we do the necessary bits manually (see
+	 * ntfs_attr_init_search_ctx() below).  Note, we _only_ preserve
+	 * @ctx->al_entry as the remaining fields (base_*) are identical to
+	 * their non base_ counterparts and we cannot set @ctx->base_attr
+	 * correctly yet as we do not know what @ctx->attr will be set to by
+	 * the call to ntfs_attr_find() below.
 	 */
-	printk(KERN_CRIT "NTFS: FIXME: Hit unfinished error code path!!!\n");
-	return FALSE;
-not_found:
+	ctx->mrec = ctx->base_mrec;
+	ctx->attr = (ATTR_RECORD*)((u8*)ctx->mrec +
+			le16_to_cpu(ctx->mrec->attrs_offset));
+	ctx->is_first = TRUE;
+	ctx->ntfs_ino = ctx->base_ntfs_ino;
+	ctx->base_ntfs_ino = NULL;
+	ctx->base_mrec = NULL;
+	ctx->base_attr = NULL;
 	/*
-	 * Seek to the end of the base mft record, i.e. when we return false,
-	 * ctx->mrec and ctx->attr indicate where the attribute should be
-	 * inserted into the attribute record.
-	 * And of course ctx->al_entry points to the end of the attribute
-	 * list inside NTFS_I(ctx->base_vfs_ino)->attr_list.
-	 *
-	 * FIXME: Do we really want to do this here? Think about it... (AIA)
+	 * In case there are multiple matches in the base mft record, need to
+	 * keep enumerating until we get an attribute not found response (or
+	 * another error), otherwise we would keep returning the same attribute
+	 * over and over again and all programs using us for enumeration would
+	 * lock up in a tight loop.
 	 */
-	ntfs_attr_reinit_search_ctx(ctx);
-	ntfs_attr_find(type, name, name_len, ic, val, val_len, ctx);
+	do {
+		err = ntfs_attr_find(type, name, name_len, ic, val, val_len,
+				ctx);
+	} while (!err);
 	ntfs_debug("Done, not found.");
-	return FALSE;
+	return err;
 }
 
 /**
@@ -1709,7 +1771,7 @@
  * @val_len:	attribute value length
  * @ctx:	search context with mft record and attribute to search from
  *
- * Find an attribute in an ntfs inode. On first search @ctx->ntfs_ino must
+ * Find an attribute in an ntfs inode.  On first search @ctx->ntfs_ino must
  * be the base mft record and @ctx must have been obtained from a call to
  * ntfs_attr_get_search_ctx().
  *
@@ -1720,13 +1782,24 @@
  * ntfs_attr_put_search_ctx() to cleanup the search context (unmapping any
  * mapped inodes, etc).
  *
- * Return TRUE if the search was successful and FALSE if not. When TRUE,
- * @ctx->attr is the found attribute and it is in mft record @ctx->mrec. When
- * FALSE, @ctx->attr is the attribute which collates just after the attribute
- * being searched for, i.e. if one wants to add the attribute to the mft
- * record this is the correct place to insert it into.
+ * Return 0 if the search was successful and -errno if not.
+ *
+ * When 0, @ctx->attr is the found attribute and it is in mft record
+ * @ctx->mrec.  If an attribute list attribute is present, @ctx->al_entry is
+ * the attribute list entry of the found attribute.
+ *
+ * When -ENOENT, @ctx->attr is the attribute which collates just after the
+ * attribute being searched for, i.e. if one wants to add the attribute to the
+ * mft record this is the correct place to insert it into.  If an attribute
+ * list attribute is present, @ctx->al_entry is the attribute list entry which
+ * collates just after the attribute list entry of the attribute being searched
+ * for, i.e. if one wants to add the attribute to the mft record this is the
+ * correct place to insert its attribute list entry into.
+ *
+ * When -errno != -ENOENT, an error occured during the lookup.  @ctx->attr is
+ * then undefined and in particular you should not rely on it not changing.
  */
-BOOL ntfs_attr_lookup(const ATTR_TYPES type, const ntfschar *name,
+int ntfs_attr_lookup(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic,
 		const VCN lowest_vcn, const u8 *val, const u32 val_len,
 		ntfs_attr_search_ctx *ctx)
@@ -1740,7 +1813,7 @@
 		base_ni = ctx->ntfs_ino;
 	/* Sanity check, just for debugging really. */
 	BUG_ON(!base_ni);
-	if (!NInoAttrList(base_ni))
+	if (!NInoAttrList(base_ni) || type == AT_ATTRIBUTE_LIST)
 		return ntfs_attr_find(type, name, name_len, ic, val, val_len,
 				ctx);
 	return ntfs_external_attr_find(type, name, name_len, ic, lowest_vcn,
diff -Nru a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h	2004-09-22 13:02:51 +01:00
+++ b/fs/ntfs/attrib.h	2004-09-22 13:02:51 +01:00
@@ -81,11 +81,7 @@
 extern runlist_element *ntfs_find_vcn(ntfs_inode *ni, const VCN vcn,
 		const BOOL need_write);
 
-extern BOOL ntfs_attr_find(const ATTR_TYPES type, const ntfschar *name,
-		const u32 name_len, const IGNORE_CASE_BOOL ic, const u8 *val,
-		const u32 val_len, ntfs_attr_search_ctx *ctx);
-
-BOOL ntfs_attr_lookup(const ATTR_TYPES type, const ntfschar *name,
+int ntfs_attr_lookup(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic,
 		const VCN lowest_vcn, const u8 *val, const u32 val_len,
 		ntfs_attr_search_ctx *ctx);
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	2004-09-22 13:02:51 +01:00
+++ b/fs/ntfs/dir.c	2004-09-22 13:02:51 +01:00
@@ -106,11 +106,15 @@
 		goto err_out;
 	}
 	/* Find the index root attribute in the mft record. */
-	if (!ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL,
-			0, ctx)) {
-		ntfs_error(sb, "Index root attribute missing in directory "
-				"inode 0x%lx.", dir_ni->mft_no);
-		err = -EIO;
+	err = ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL,
+			0, ctx);
+	if (unlikely(err)) {
+		if (err == -ENOENT) {
+			ntfs_error(sb, "Index root attribute missing in "
+					"directory inode 0x%lx.",
+					dir_ni->mft_no);
+			err = -EIO;
+		}
 		goto err_out;
 	}
 	/* Get to the index root value (it's been verified in read_inode). */
@@ -655,11 +659,15 @@
 		goto err_out;
 	}
 	/* Find the index root attribute in the mft record. */
-	if (!ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL,
-			0, ctx)) {
-		ntfs_error(sb, "Index root attribute missing in directory "
-				"inode 0x%lx.", dir_ni->mft_no);
-		err = -EIO;
+	err = ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL,
+			0, ctx);
+	if (unlikely(err)) {
+		if (err == -ENOENT) {
+			ntfs_error(sb, "Index root attribute missing in "
+					"directory inode 0x%lx.",
+					dir_ni->mft_no);
+			err = -EIO;
+		}
 		goto err_out;
 	}
 	/* Get to the index root value (it's been verified in read_inode). */
@@ -1183,8 +1191,9 @@
 	/* Get the offset into the index root attribute. */
 	ir_pos = (s64)fpos;
 	/* Find the index root attribute in the mft record. */
-	if (unlikely(!ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE,
-			0, NULL, 0, ctx))) {
+	err = ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL,
+			0, ctx);
+	if (unlikely(err)) {
 		ntfs_error(sb, "Index root attribute missing in directory "
 				"inode 0x%lx.", vdir->i_ino);
 		goto err_out;
diff -Nru a/fs/ntfs/index.c b/fs/ntfs/index.c
--- a/fs/ntfs/index.c	2004-09-22 13:02:51 +01:00
+++ b/fs/ntfs/index.c	2004-09-22 13:02:51 +01:00
@@ -125,6 +125,7 @@
 int ntfs_index_lookup(const void *key, const int key_len,
 		ntfs_index_context *ictx)
 {
+	VCN vcn, old_vcn;
 	ntfs_inode *idx_ni = ictx->idx_ni;
 	ntfs_volume *vol = idx_ni->vol;
 	struct super_block *sb = vol->sb;
@@ -133,13 +134,11 @@
 	INDEX_ROOT *ir;
 	INDEX_ENTRY *ie;
 	INDEX_ALLOCATION *ia;
-	u8 *index_end;
+	u8 *index_end, *kaddr;
 	ntfs_attr_search_ctx *actx;
-	int rc, err = 0;
-	VCN vcn, old_vcn;
 	struct address_space *ia_mapping;
 	struct page *page;
-	u8 *kaddr;
+	int rc, err = 0;
 
 	ntfs_debug("Entering.");
 	BUG_ON(!NInoAttr(idx_ni));
@@ -168,11 +167,14 @@
 		goto err_out;
 	}
 	/* Find the index root attribute in the mft record. */
-	if (!ntfs_attr_lookup(AT_INDEX_ROOT, idx_ni->name, idx_ni->name_len,
-			CASE_SENSITIVE, 0, NULL, 0, actx)) {
-		ntfs_error(sb, "Index root attribute missing in inode 0x%lx.",
-				idx_ni->mft_no);
-		err = -EIO;
+	err = ntfs_attr_lookup(AT_INDEX_ROOT, idx_ni->name, idx_ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, actx);
+	if (unlikely(err)) {
+		if (err == -ENOENT) {
+			ntfs_error(sb, "Index root attribute missing in inode "
+					"0x%lx.", idx_ni->mft_no);
+			err = -EIO;
+		}
 		goto err_out;
 	}
 	/* Get to the index root value (it has been verified in read_inode). */
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-09-22 13:02:51 +01:00
+++ b/fs/ntfs/inode.c	2004-09-22 13:02:51 +01:00
@@ -428,11 +428,11 @@
  * Return values:
  *	   1: file is in $Extend directory
  *	   0: file is not in $Extend directory
- *	-EIO: file is corrupt
+ *    -errno: failed to determine if the file is in the $Extend directory
  */
 static int ntfs_is_extended_system_file(ntfs_attr_search_ctx *ctx)
 {
-	int nr_links;
+	int nr_links, err;
 
 	/* Restart search. */
 	ntfs_attr_reinit_search_ctx(ctx);
@@ -441,7 +441,8 @@
 	nr_links = le16_to_cpu(ctx->mrec->link_count);
 
 	/* Loop through all hard links. */
-	while (ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0, NULL, 0, ctx)) {
+	while (!(err = ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0, NULL, 0,
+			ctx))) {
 		FILE_NAME_ATTR *file_name_attr;
 		ATTR_RECORD *attr = ctx->attr;
 		u8 *p, *p2;
@@ -484,7 +485,9 @@
 		if (MREF_LE(file_name_attr->parent_directory) == FILE_Extend)
 			return 1;	/* YES, it's an extended system file. */
 	}
-	if (nr_links) {
+	if (unlikely(err != -ENOENT))
+		return err;
+	if (unlikely(nr_links)) {
 		ntfs_error(ctx->ntfs_ino->vol->sb, "Inode hard link count "
 				"doesn't match number of name attributes. You "
 				"should run chkdsk.");
@@ -608,14 +611,18 @@
 	 * in fact fail if the standard information is in an extent record, but
 	 * I don't think this actually ever happens.
 	 */
-	if (!ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0, 0, 0, NULL, 0,
-			ctx)) {
-		/*
-		 * TODO: We should be performing a hot fix here (if the recover
-		 * mount option is set) by creating a new attribute.
-		 */
-		ntfs_error(vi->i_sb, "$STANDARD_INFORMATION attribute is "
-				"missing.");
+	err = ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0, 0, 0, NULL, 0,
+			ctx);
+	if (unlikely(err)) {
+		if (err == -ENOENT) {
+			/*
+			 * TODO: We should be performing a hot fix here (if the
+			 * recover mount option is set) by creating a new
+			 * attribute.
+			 */
+			ntfs_error(vi->i_sb, "$STANDARD_INFORMATION attribute "
+					"is missing.");
+		}
 		goto unm_err_out;
 	}
 	/* Get the standard information attribute value. */
@@ -647,7 +654,14 @@
 
 	/* Find the attribute list attribute if present. */
 	ntfs_attr_reinit_search_ctx(ctx);
-	if (ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx)) {
+	err = ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx);
+	if (err) {
+		if (unlikely(err != -ENOENT)) {
+			ntfs_error(vi->i_sb, "Failed to lookup attribute list "
+					"attribute. You should run chkdsk.");
+			goto unm_err_out;
+		}
+	} else /* if (!err) */ {
 		if (vi->i_ino == FILE_MFT)
 			goto skip_attr_list_load;
 		ntfs_debug("Attribute list found in inode 0x%lx.", vi->i_ino);
@@ -734,12 +748,16 @@
 
 		/* It is a directory, find index root attribute. */
 		ntfs_attr_reinit_search_ctx(ctx);
-		if (!ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0,
-				NULL, 0, ctx)) {
-			// FIXME: File is corrupt! Hot-fix with empty index
-			// root attribute if recovery option is set.
-			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is "
-					"missing.");
+		err = ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE,
+				0, NULL, 0, ctx);
+		if (unlikely(err)) {
+			if (err == -ENOENT) {
+				// FIXME: File is corrupt! Hot-fix with empty
+				// index root attribute if recovery option is
+				// set.
+				ntfs_error(vi->i_sb, "$INDEX_ROOT attribute "
+						"is missing.");
+			}
 			goto unm_err_out;
 		}
 		/* Set up the state. */
@@ -850,11 +868,18 @@
 		NInoSetIndexAllocPresent(ni);
 		/* Find index allocation attribute. */
 		ntfs_attr_reinit_search_ctx(ctx);
-		if (!ntfs_attr_lookup(AT_INDEX_ALLOCATION, I30, 4,
-				CASE_SENSITIVE, 0, NULL, 0, ctx)) {
-			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
-					"is not present but $INDEX_ROOT "
-					"indicated it is.");
+		err = ntfs_attr_lookup(AT_INDEX_ALLOCATION, I30, 4,
+				CASE_SENSITIVE, 0, NULL, 0, ctx);
+		if (unlikely(err)) {
+			if (err == -ENOENT)
+				ntfs_error(vi->i_sb, "$INDEX_ALLOCATION "
+						"attribute is not present but "
+						"$INDEX_ROOT indicated it "
+						"is.");
+			else
+				ntfs_error(vi->i_sb, "Failed to lookup "
+						"$INDEX_ALLOCATION "
+						"attribute.");
 			goto unm_err_out;
 		}
 		if (!ctx->attr->non_resident) {
@@ -946,9 +971,15 @@
 		ni->name_len = 0;
 
 		/* Find first extent of the unnamed data attribute. */
-		if (!ntfs_attr_lookup(AT_DATA, NULL, 0, 0, 0, NULL, 0, ctx)) {
+		err = ntfs_attr_lookup(AT_DATA, NULL, 0, 0, 0, NULL, 0, ctx);
+		if (unlikely(err)) {
 			vi->i_size = ni->initialized_size =
-					ni->allocated_size = 0LL;
+					ni->allocated_size = 0;
+			if (err != -ENOENT) {
+				ntfs_error(vi->i_sb, "Failed to lookup $DATA "
+						"attribute.");
+				goto unm_err_out;
+			}
 			/*
 			 * FILE_Secure does not have an unnamed $DATA
 			 * attribute, so we special case it here.
@@ -1169,8 +1200,9 @@
 	}
 
 	/* Find the attribute. */
-	if (!ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
-			0, NULL, 0, ctx))
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err))
 		goto unm_err_out;
 
 	if (!ctx->attr->non_resident) {
@@ -1425,9 +1457,12 @@
 		goto unm_err_out;
 	}
 	/* Find the index root attribute. */
-	if (!ntfs_attr_lookup(AT_INDEX_ROOT, ni->name, ni->name_len,
-			CASE_SENSITIVE, 0, NULL, 0, ctx)) {
-		ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is missing.");
+	err = ntfs_attr_lookup(AT_INDEX_ROOT, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err)) {
+		if (err == -ENOENT)
+			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is "
+					"missing.");
 		goto unm_err_out;
 	}
 	/* Set up the state. */
@@ -1506,10 +1541,16 @@
 	NInoSetIndexAllocPresent(ni);
 	/* Find index allocation attribute. */
 	ntfs_attr_reinit_search_ctx(ctx);
-	if (!ntfs_attr_lookup(AT_INDEX_ALLOCATION, ni->name, ni->name_len,
-			CASE_SENSITIVE, 0, NULL, 0, ctx)) {
-		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is not "
-				"present but $INDEX_ROOT indicated it is.");
+	err = ntfs_attr_lookup(AT_INDEX_ALLOCATION, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err)) {
+		if (err == -ENOENT)
+			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is "
+					"not present but $INDEX_ROOT "
+					"indicated it is.");
+		else
+			ntfs_error(vi->i_sb, "Failed to lookup "
+					"$INDEX_ALLOCATION attribute.");
 		goto unm_err_out;
 	}
 	if (!ctx->attr->non_resident) {
@@ -1726,7 +1767,14 @@
 	}
 
 	/* Find the attribute list attribute if present. */
-	if (ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx)) {
+	err = ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx);
+	if (err) {
+		if (unlikely(err != -ENOENT)) {
+			ntfs_error(sb, "Failed to lookup attribute list "
+					"attribute. You should run chkdsk.");
+			goto put_err_out;
+		}
+	} else /* if (!err) */ {
 		ATTR_LIST_ENTRY *al_entry, *next_al_entry;
 		u8 *al_end;
 
@@ -1860,7 +1908,8 @@
 	/* Now load all attribute extents. */
 	attr = NULL;
 	next_vcn = last_vcn = highest_vcn = 0;
-	while (ntfs_attr_lookup(AT_DATA, NULL, 0, 0, next_vcn, NULL, 0, ctx)) {
+	while (!(err = ntfs_attr_lookup(AT_DATA, NULL, 0, 0, next_vcn, NULL, 0,
+			ctx))) {
 		runlist_element *nrl;
 
 		/* Cache the current attribute. */
@@ -1991,15 +2040,20 @@
 			goto put_err_out;
 		}
 	}
+	if (err != -ENOENT) {
+		ntfs_error(sb, "Failed to lookup $MFT/$DATA attribute extent. "
+				"$MFT is corrupt. Run chkdsk.");
+		goto put_err_out;
+	}
 	if (!attr) {
 		ntfs_error(sb, "$MFT/$DATA attribute not found. $MFT is "
 				"corrupt. Run chkdsk.");
 		goto put_err_out;
 	}
 	if (highest_vcn && highest_vcn != last_vcn - 1) {
-		ntfs_error(sb, "Failed to load the complete runlist "
-				"for $MFT/$DATA. Driver bug or "
-				"corrupt $MFT. Run chkdsk.");
+		ntfs_error(sb, "Failed to load the complete runlist for "
+				"$MFT/$DATA. Driver bug or corrupt $MFT. "
+				"Run chkdsk.");
 		ntfs_debug("highest_vcn = 0x%llx, last_vcn - 1 = 0x%llx",
 				(unsigned long long)highest_vcn,
 				(unsigned long long)last_vcn - 1);
@@ -2347,10 +2401,10 @@
 		err = -ENOMEM;
 		goto unm_err_out;
 	}
-	if (unlikely(!ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0,
-			CASE_SENSITIVE, 0, NULL, 0, ctx))) {
+	err = ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err)) {
 		ntfs_attr_put_search_ctx(ctx);
-		err = -ENOENT;
 		goto unm_err_out;
 	}
 	si = (STANDARD_INFORMATION*)((u8*)ctx->attr +
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	2004-09-22 13:02:51 +01:00
+++ b/fs/ntfs/namei.c	2004-09-22 13:02:51 +01:00
@@ -197,7 +197,7 @@
 			goto err_out;
 		}
 		ctx = ntfs_attr_get_search_ctx(ni, m);
-		if (!ctx) {
+		if (unlikely(!ctx)) {
 			err = -ENOMEM;
 			goto err_out;
 		}
@@ -205,12 +205,14 @@
 			ATTR_RECORD *a;
 			u32 val_len;
 
-			if (!ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0,
-					NULL, 0, ctx)) {
+			err = ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0,
+					NULL, 0, ctx);
+			if (unlikely(err)) {
 				ntfs_error(vol->sb, "Inode corrupt: No WIN32 "
 						"namespace counterpart to DOS "
 						"file name. Run chkdsk.");
-				err = -EIO;
+				if (err == -ENOENT)
+					err = -EIO;
 				goto err_out;
 			}
 			/* Consistency checks. */
@@ -372,6 +374,7 @@
 	struct inode *parent_vi;
 	struct dentry *parent_dent;
 	unsigned long parent_ino;
+	int err;
 
 	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
 	/* Get the mft record of the inode belonging to the child dentry. */
@@ -385,13 +388,16 @@
 		return ERR_PTR(-ENOMEM);
 	}
 try_next:
-	if (unlikely(!ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, CASE_SENSITIVE,
-			0, NULL, 0, ctx))) {
+	err = ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, CASE_SENSITIVE, 0, NULL,
+			0, ctx);
+	if (unlikely(err)) {
 		ntfs_attr_put_search_ctx(ctx);
 		unmap_mft_record(ni);
-		ntfs_error(vi->i_sb, "Inode 0x%lx does not have a file name "
-				"attribute. Run chkdsk.", vi->i_ino);
-		return ERR_PTR(-ENOENT);
+		if (err == -ENOENT)
+			ntfs_error(vi->i_sb, "Inode 0x%lx does not have a "
+					"file name attribute.  Run chkdsk.",
+					vi->i_ino);
+		return ERR_PTR(err);
 	}
 	attr = ctx->attr;
 	if (unlikely(attr->non_resident))
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-09-22 13:02:51 +01:00
+++ b/fs/ntfs/super.c	2004-09-22 13:02:51 +01:00
@@ -336,11 +336,10 @@
 		err = -ENOMEM;
 		goto put_unm_err_out;
 	}
-	if (!ntfs_attr_lookup(AT_VOLUME_INFORMATION, NULL, 0, 0, 0, NULL, 0,
-			ctx)) {
-		err = -EIO;
+	err = ntfs_attr_lookup(AT_VOLUME_INFORMATION, NULL, 0, 0, 0, NULL, 0,
+			ctx);
+	if (err)
 		goto put_unm_err_out;
-	}
 	vi = (VOLUME_INFORMATION*)((u8*)ctx->attr +
 			le16_to_cpu(ctx->attr->data.resident.value_offset));
 	vol->vol_flags = vi->flags = flags;
@@ -1433,7 +1432,7 @@
 		ntfs_error(sb, "Failed to get attribute search context.");
 		goto get_ctx_vol_failed;
 	}
-	if (!ntfs_attr_lookup(AT_VOLUME_INFORMATION, NULL, 0, 0, 0, NULL, 0,
+	if (ntfs_attr_lookup(AT_VOLUME_INFORMATION, NULL, 0, 0, 0, NULL, 0,
 			ctx) || ctx->attr->non_resident || ctx->attr->flags) {
 err_put_vol:
 		ntfs_attr_put_search_ctx(ctx);
