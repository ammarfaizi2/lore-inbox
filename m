Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbUKJNrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUKJNrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 08:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUKJNqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:46:38 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:45259 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261889AbUKJNoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:44:46 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 6/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsm1-0006Nc-2K@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:44:33 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 6/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/25 1.2026.1.22)
   NTFS: Add attribute definition handling helpers to fs/ntfs/attrib.[hc]:
         ntfs_attr_size_bounds_check(), ntfs_attr_can_be_non_resident(), and
         ntfs_attr_can_be_resident(), which in turn use the new private helper
         ntfs_attr_find_in_attrdef().
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:44:36 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:44:36 +00:00
@@ -31,6 +31,10 @@
 	  fs/ntfs/inode.c::ntfs_truncate() to set and clear it appropriately.
 	- Fix min_size and max_size definitions in ATTR_DEF structure in
 	  fs/ntfs/layout.h to be signed.
+	- Add attribute definition handling helpers to fs/ntfs/attrib.[hc]:
+	  ntfs_attr_size_bounds_check(), ntfs_attr_can_be_non_resident(), and
+	  ntfs_attr_can_be_resident(), which in turn use the new private helper
+	  ntfs_attr_find_in_attrdef().
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-11-10 13:44:36 +00:00
+++ b/fs/ntfs/attrib.c	2004-11-10 13:44:36 +00:00
@@ -24,8 +24,10 @@
 
 #include "attrib.h"
 #include "debug.h"
+#include "layout.h"
 #include "mft.h"
 #include "ntfs.h"
+#include "types.h"
 
 /**
  * ntfs_map_runlist - map (a part of) a runlist of an ntfs inode
@@ -947,6 +949,133 @@
 		unmap_extent_mft_record(ctx->ntfs_ino);
 	kmem_cache_free(ntfs_attr_ctx_cache, ctx);
 	return;
+}
+
+/**
+ * ntfs_attr_find_in_attrdef - find an attribute in the $AttrDef system file
+ * @vol:	ntfs volume to which the attribute belongs
+ * @type:	attribute type which to find
+ *
+ * Search for the attribute definition record corresponding to the attribute
+ * @type in the $AttrDef system file.
+ *
+ * Return the attribute type definition record if found and NULL if not found.
+ */
+static ATTR_DEF *ntfs_attr_find_in_attrdef(const ntfs_volume *vol,
+		const ATTR_TYPE type)
+{
+	ATTR_DEF *ad;
+
+	BUG_ON(!vol->attrdef);
+	BUG_ON(!type);
+	for (ad = vol->attrdef; (u8*)ad - (u8*)vol->attrdef <
+			vol->attrdef_size && ad->type; ++ad) {
+		/* We have not found it yet, carry on searching. */
+		if (likely(le32_to_cpu(ad->type) < le32_to_cpu(type)))
+			continue;
+		/* We found the attribute; return it. */
+		if (likely(ad->type == type))
+			return ad;
+		/* We have gone too far already.  No point in continuing. */
+		break;
+	}
+	/* Attribute not found. */
+	ntfs_debug("Attribute type 0x%x not found in $AttrDef.",
+			le32_to_cpu(type));
+	return NULL;
+}
+
+/**
+ * ntfs_attr_size_bounds_check - check a size of an attribute type for validity
+ * @vol:	ntfs volume to which the attribute belongs
+ * @type:	attribute type which to check
+ * @size:	size which to check
+ *
+ * Check whether the @size in bytes is valid for an attribute of @type on the
+ * ntfs volume @vol.  This information is obtained from $AttrDef system file.
+ *
+ * Return 0 if valid, -ERANGE if not valid, or -ENOENT if the attribute is not
+ * listed in $AttrDef.
+ */
+int ntfs_attr_size_bounds_check(const ntfs_volume *vol, const ATTR_TYPE type,
+		const s64 size)
+{
+	ATTR_DEF *ad;
+
+	BUG_ON(size < 0);
+	/*
+	 * $ATTRIBUTE_LIST has a maximum size of 256kiB, but this is not
+	 * listed in $AttrDef.
+	 */
+	if (unlikely(type == AT_ATTRIBUTE_LIST && size > 256 * 1024))
+		return -ERANGE;
+	/* Get the $AttrDef entry for the attribute @type. */
+	ad = ntfs_attr_find_in_attrdef(vol, type);
+	if (unlikely(!ad))
+		return -ENOENT;
+	/* Do the bounds check. */
+	if (((sle64_to_cpu(ad->min_size) > 0) &&
+			size < sle64_to_cpu(ad->min_size)) ||
+			((sle64_to_cpu(ad->max_size) > 0) && size >
+			sle64_to_cpu(ad->max_size)))
+		return -ERANGE;
+	return 0;
+}
+
+/**
+ * ntfs_attr_can_be_non_resident - check if an attribute can be non-resident
+ * @vol:	ntfs volume to which the attribute belongs
+ * @type:	attribute type which to check
+ *
+ * Check whether the attribute of @type on the ntfs volume @vol is allowed to
+ * be non-resident.  This information is obtained from $AttrDef system file.
+ *
+ * Return 0 if the attribute is allowed to be non-resident, -EPERM if not, or
+ * -ENOENT if the attribute is not listed in $AttrDef.
+ */
+int ntfs_attr_can_be_non_resident(const ntfs_volume *vol, const ATTR_TYPE type)
+{
+	ATTR_DEF *ad;
+
+	/*
+	 * $DATA is always allowed to be non-resident even if $AttrDef does not
+	 * specify this in the flags of the $DATA attribute definition record.
+	 */
+	if (type == AT_DATA)
+		return 0;
+	/* Find the attribute definition record in $AttrDef. */
+	ad = ntfs_attr_find_in_attrdef(vol, type);
+	if (unlikely(!ad))
+		return -ENOENT;
+	/* Check the flags and return the result. */
+	if (ad->flags & CAN_BE_NON_RESIDENT)
+		return 0;
+	return -EPERM;
+}
+
+/**
+ * ntfs_attr_can_be_resident - check if an attribute can be resident
+ * @vol:	ntfs volume to which the attribute belongs
+ * @type:	attribute type which to check
+ *
+ * Check whether the attribute of @type on the ntfs volume @vol is allowed to
+ * be resident.  This information is derived from our ntfs knowledge and may
+ * not be completely accurate, especially when user defined attributes are
+ * present.  Basically we allow everything to be resident except for index
+ * allocation and $EA attributes.
+ *
+ * Return 0 if the attribute is allowed to be non-resident and -EPERM if not.
+ *
+ * Warning: In the system file $MFT the attribute $Bitmap must be non-resident
+ *	    otherwise windows will not boot (blue screen of death)!  We cannot
+ *	    check for this here as we do not know which inode's $Bitmap is
+ *	    being asked about so the caller needs to special case this.
+ */
+int ntfs_attr_can_be_resident(const ntfs_volume *vol, const ATTR_TYPE type)
+{
+	if (type != AT_INDEX_ALLOCATION && type != AT_EA)
+		return 0;
+	return -EPERM;
 }
 
 /**
diff -Nru a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h	2004-11-10 13:44:36 +00:00
+++ b/fs/ntfs/attrib.h	2004-11-10 13:44:36 +00:00
@@ -29,6 +29,7 @@
 #include "layout.h"
 #include "inode.h"
 #include "runlist.h"
+#include "volume.h"
 
 /**
  * ntfs_attr_search_ctx - used in attribute search functions
@@ -83,6 +84,13 @@
 extern ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(ntfs_inode *ni,
 		MFT_RECORD *mrec);
 extern void ntfs_attr_put_search_ctx(ntfs_attr_search_ctx *ctx);
+
+extern int ntfs_attr_size_bounds_check(const ntfs_volume *vol,
+		const ATTR_TYPE type, const s64 size);
+extern int ntfs_attr_can_be_non_resident(const ntfs_volume *vol,
+		const ATTR_TYPE type);
+extern int ntfs_attr_can_be_resident(const ntfs_volume *vol,
+		const ATTR_TYPE type);
 
 extern int ntfs_attr_record_resize(MFT_RECORD *m, ATTR_RECORD *a, u32 new_size);
 
