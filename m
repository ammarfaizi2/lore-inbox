Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268972AbUIXQew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268972AbUIXQew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268965AbUIXQeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:34:22 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:19859 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268899AbUIXQOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:14:49 -0400
Date: Fri, 24 Sep 2004 17:14:45 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 8/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups
 and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409241714190.19983@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 8/10 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/24 1.1952.1.3)
   NTFS: Finish off sparse annotation.
   
   - Fix all the sparse bitwise warnings.  Had to change all the enums
     storing little endian values to #defines because we cannot set enums
     to be little endian so we had lots of bitwise warnings from sparse.
   
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
--- a/fs/ntfs/ChangeLog	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-24 17:06:27 +01:00
@@ -48,6 +48,9 @@
 	  Affected files are fs/ntfs/layout.h, logfile.h, and time.h.
 	- Do proper type casting when using ntfs_is_*_recordp() in
 	  fs/ntfs/logfile.c, mft.c, and super.c. 
+	- Fix all the sparse bitwise warnings.  Had to change all the enums
+	  storing little endian values to #defines because we cannot set enums
+	  to be little endian so we had lots of bitwise warnings from sparse.
 
 2.1.18 - Fix scheduling latencies at mount time as well as an endianness bug.
 
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/attrib.c	2004-09-24 17:06:27 +01:00
@@ -1203,7 +1203,7 @@
  * Warning: Never use @val when looking for attribute types which can be
  *	    non-resident as this most likely will result in a crash!
  */
-static int ntfs_attr_find(const ATTR_TYPES type, const ntfschar *name,
+static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic,
 		const u8 *val, const u32 val_len, ntfs_attr_search_ctx *ctx)
 {
@@ -1475,7 +1475,7 @@
  * On actual error, ntfs_external_attr_find() returns -EIO.  In this case
  * @ctx->attr is undefined and in particular do not rely on it not changing.
  */
-static int ntfs_external_attr_find(const ATTR_TYPES type,
+static int ntfs_external_attr_find(const ATTR_TYPE type,
 		const ntfschar *name, const u32 name_len,
 		const IGNORE_CASE_BOOL ic, const VCN lowest_vcn,
 		const u8 *val, const u32 val_len, ntfs_attr_search_ctx *ctx)
@@ -1620,7 +1620,8 @@
 			} else {
 				/* We want an extent record. */
 				ctx->mrec = map_extent_mft_record(base_ni,
-						al_entry->mft_reference, &ni);
+						le64_to_cpu(
+						al_entry->mft_reference), &ni);
 				ctx->ntfs_ino = ni;
 				if (IS_ERR(ctx->mrec)) {
 					ntfs_error(vol->sb, "Failed to map "
@@ -1799,7 +1800,7 @@
  * When -errno != -ENOENT, an error occured during the lookup.  @ctx->attr is
  * then undefined and in particular you should not rely on it not changing.
  */
-int ntfs_attr_lookup(const ATTR_TYPES type, const ntfschar *name,
+int ntfs_attr_lookup(const ATTR_TYPE type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic,
 		const VCN lowest_vcn, const u8 *val, const u32 val_len,
 		ntfs_attr_search_ctx *ctx)
diff -Nru a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/attrib.h	2004-09-24 17:06:27 +01:00
@@ -81,7 +81,7 @@
 extern runlist_element *ntfs_find_vcn(ntfs_inode *ni, const VCN vcn,
 		const BOOL need_write);
 
-int ntfs_attr_lookup(const ATTR_TYPES type, const ntfschar *name,
+int ntfs_attr_lookup(const ATTR_TYPE type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic,
 		const VCN lowest_vcn, const u8 *val, const u32 val_len,
 		ntfs_attr_search_ctx *ctx);
diff -Nru a/fs/ntfs/collate.c b/fs/ntfs/collate.c
--- a/fs/ntfs/collate.c	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/collate.c	2004-09-24 17:06:27 +01:00
@@ -97,24 +97,26 @@
  * For speed we use the collation rule @cr as an index into two tables of
  * function pointers to call the appropriate collation function.
  */
-int ntfs_collate(ntfs_volume *vol, COLLATION_RULES cr,
+int ntfs_collate(ntfs_volume *vol, COLLATION_RULE cr,
 		const void *data1, const int data1_len,
 		const void *data2, const int data2_len) {
+	int i;
+
 	ntfs_debug("Entering.");
 	/*
 	 * FIXME:  At the moment we only support COLLATION_BINARY and
 	 * COLLATION_NTOFS_ULONG, so we BUG() for everything else for now.
 	 */
 	BUG_ON(cr != COLLATION_BINARY && cr != COLLATION_NTOFS_ULONG);
-	cr = le32_to_cpu(cr);
-	BUG_ON(cr < 0);
-	if (cr <= 0x02)
-		return ntfs_do_collate0x0[cr](vol, data1, data1_len,
+	i = le32_to_cpu(cr);
+	BUG_ON(i < 0);
+	if (i <= 0x02)
+		return ntfs_do_collate0x0[i](vol, data1, data1_len,
 				data2, data2_len);
-	BUG_ON(cr < 0x10);
-	cr -= 0x10;
-	if (likely(cr <= 3))
-		return ntfs_do_collate0x1[cr](vol, data1, data1_len,
+	BUG_ON(i < 0x10);
+	i -= 0x10;
+	if (likely(i <= 3))
+		return ntfs_do_collate0x1[i](vol, data1, data1_len,
 				data2, data2_len);
 	BUG();
 	return 0;
diff -Nru a/fs/ntfs/collate.h b/fs/ntfs/collate.h
--- a/fs/ntfs/collate.h	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/collate.h	2004-09-24 17:06:27 +01:00
@@ -26,7 +26,9 @@
 #include "types.h"
 #include "volume.h"
 
-static inline BOOL ntfs_is_collation_rule_supported(COLLATION_RULES cr) {
+static inline BOOL ntfs_is_collation_rule_supported(COLLATION_RULE cr) {
+	int i;
+
 	/*
 	 * FIXME:  At the moment we only support COLLATION_BINARY and
 	 * COLLATION_NTOFS_ULONG, so we return false for everything else for
@@ -34,14 +36,14 @@
 	 */
 	if (unlikely(cr != COLLATION_BINARY && cr != COLLATION_NTOFS_ULONG))
 		return FALSE;
-	cr = le32_to_cpu(cr);
-	if (likely(((cr >= 0) && (cr <= 0x02)) ||
-			((cr >= 0x10) && (cr <= 0x13))))
+	i = le32_to_cpu(cr);
+	if (likely(((i >= 0) && (i <= 0x02)) ||
+			((i >= 0x10) && (i <= 0x13))))
 		return TRUE;
 	return FALSE;
 }
 
-extern int ntfs_collate(ntfs_volume *vol, COLLATION_RULES cr,
+extern int ntfs_collate(ntfs_volume *vol, COLLATION_RULE cr,
 		const void *data1, const int data1_len,
 		const void *data2, const int data2_len);
 
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/compress.c	2004-09-24 17:06:27 +01:00
@@ -203,7 +203,7 @@
 	 * position in the compression block is one byte before its end so the
 	 * first two checks do not detect it.
 	 */
-	if (cb == cb_end || !le16_to_cpup((u16*)cb) ||
+	if (cb == cb_end || !le16_to_cpup((le16*)cb) ||
 			(*dest_index == dest_max_index &&
 			*dest_ofs == dest_max_ofs)) {
 		int i;
@@ -255,7 +255,7 @@
 
 	/* Setup the current sub-block source pointers and validate range. */
 	cb_sb_start = cb;
-	cb_sb_end = cb_sb_start + (le16_to_cpup((u16*)cb) & NTFS_SB_SIZE_MASK)
+	cb_sb_end = cb_sb_start + (le16_to_cpup((le16*)cb) & NTFS_SB_SIZE_MASK)
 			+ 3;
 	if (cb_sb_end > cb_end)
 		goto return_overflow;
@@ -277,7 +277,7 @@
 	dp_addr = (u8*)page_address(dp) + do_sb_start;
 
 	/* Now, we are ready to process the current sub-block (sb). */
-	if (!(le16_to_cpup((u16*)cb) & NTFS_SB_IS_COMPRESSED)) {
+	if (!(le16_to_cpup((le16*)cb) & NTFS_SB_IS_COMPRESSED)) {
 		ntfs_debug("Found uncompressed sub-block.");
 		/* This sb is not compressed, just copy it into destination. */
 
@@ -382,7 +382,7 @@
 			lg++;
 
 		/* Get the phrase token into i. */
-		pt = le16_to_cpup((u16*)cb);
+		pt = le16_to_cpup((le16*)cb);
 
 		/*
 		 * Calculate starting position of the byte sequence in
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/inode.c	2004-09-24 17:06:27 +01:00
@@ -214,7 +214,7 @@
  * value with IS_ERR() and if true, the function failed and the error code is
  * obtained from PTR_ERR().
  */
-struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPES type,
+struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
 		ntfschar *name, u32 name_len)
 {
 	struct inode *vi;
@@ -2404,7 +2404,7 @@
  */
 int ntfs_write_inode(struct inode *vi, int sync)
 {
-	s64 nt;
+	sle64 nt;
 	ntfs_inode *ni = NTFS_I(vi);
 	ntfs_attr_search_ctx *ctx;
 	MFT_RECORD *m;
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/inode.h	2004-09-24 17:06:27 +01:00
@@ -53,7 +53,7 @@
 	 * name_len = 0 for files and name = I30 (global constant) and
 	 * name_len = 4 for directories.
 	 */
-	ATTR_TYPES type;	/* Attribute type of this fake inode. */
+	ATTR_TYPE type;	/* Attribute type of this fake inode. */
 	ntfschar *name;		/* Attribute name of this fake inode. */
 	u32 name_len;		/* Attribute name length of this fake inode. */
 	runlist runlist;	/* If state has the NI_NonResident bit set,
@@ -96,7 +96,7 @@
 			u32 block_size;		/* Size of an index block. */
 			u32 vcn_size;		/* Size of a vcn in this
 						   index. */
-			COLLATION_RULES collation_rule; /* The collation rule
+			COLLATION_RULE collation_rule; /* The collation rule
 						   for the index. */
 			u8 block_size_bits; 	/* Log2 of the above. */
 			u8 vcn_size_bits;	/* Log2 of the above. */
@@ -252,7 +252,7 @@
 	unsigned long mft_no;
 	ntfschar *name;
 	u32 name_len;
-	ATTR_TYPES type;
+	ATTR_TYPE type;
 } ntfs_attr;
 
 typedef int (*test_t)(struct inode *, void *);
@@ -260,7 +260,7 @@
 extern int ntfs_test_inode(struct inode *vi, ntfs_attr *na);
 
 extern struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no);
-extern struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPES type,
+extern struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
 		ntfschar *name, u32 name_len);
 extern struct inode *ntfs_index_iget(struct inode *base_vi, ntfschar *name,
 		u32 name_len);
diff -Nru a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/layout.h	2004-09-24 17:06:27 +01:00
@@ -112,52 +112,49 @@
  * Magic identifiers present at the beginning of all ntfs record containing
  * records (like mft records for example).
  */
-typedef enum {
-	/* Found in $MFT/$DATA. */
-	magic_FILE = const_cpu_to_le32(0x454c4946), /* Mft entry. */
-	magic_INDX = const_cpu_to_le32(0x58444e49), /* Index buffer. */
-	magic_HOLE = const_cpu_to_le32(0x454c4f48), /* ? (NTFS 3.0+?) */
-
-	/* Found in $LogFile/$DATA. */
-	magic_RSTR = const_cpu_to_le32(0x52545352), /* Restart page. */
-	magic_RCRD = const_cpu_to_le32(0x44524352), /* Log record page. */
-
-	/* Found in $LogFile/$DATA.  (May be found in $MFT/$DATA, also?) */
-	magic_CHKD = const_cpu_to_le32(0x424b4843), /* Modified by chkdsk. */
-
-	/* Found in all ntfs record containing records. */
-	magic_BAAD = const_cpu_to_le32(0x44414142), /* Failed multi sector
-						       transfer was detected. */
-
-	/*
-	 * Found in $LogFile/$DATA when a page is full or 0xff bytes and is
-	 * thus not initialized.  User has to initialize the page before using
-	 * it.
-	 */
-	magic_empty = const_cpu_to_le32(0xffffffff),/* Record is empty and has
-						       to be initialized before
-						       it can be used. */
-} NTFS_RECORD_TYPES;
+/* Found in $MFT/$DATA. */
+#define magic_FILE const_cpu_to_le32(0x454c4946) /* Mft entry. */
+#define magic_INDX const_cpu_to_le32(0x58444e49) /* Index buffer. */
+#define magic_HOLE const_cpu_to_le32(0x454c4f48) /* ? (NTFS 3.0+?) */
+
+/* Found in $LogFile/$DATA. */
+#define magic_RSTR const_cpu_to_le32(0x52545352) /* Restart page. */
+#define magic_RCRD const_cpu_to_le32(0x44524352) /* Log record page. */
+
+/* Found in $LogFile/$DATA.  (May be found in $MFT/$DATA, also?) */
+#define magic_CHKD const_cpu_to_le32(0x424b4843) /* Modified by chkdsk. */
+
+/* Found in all ntfs record containing records. */
+#define magic_BAAD const_cpu_to_le32(0x44414142) /* Failed multi sector
+						    transfer was detected. */
+/*
+ * Found in $LogFile/$DATA when a page is full or 0xff bytes and is thus not
+ * initialized.  User has to initialize the page before using it.
+ */
+#define magic_empty const_cpu_to_le32(0xffffffff)/* Record is empty and has to
+						    be initialized before it
+						    can be used. */
+typedef le32 NTFS_RECORD_TYPE;
 
 /*
  * Generic magic comparison macros. Finally found a use for the ## preprocessor
  * operator! (-8
  */
 
-static inline BOOL __ntfs_is_magic(le32 x, NTFS_RECORD_TYPES r)
+static inline BOOL __ntfs_is_magic(le32 x, NTFS_RECORD_TYPE r)
 {
 	return (x == (__force le32)r);
 }
 #define ntfs_is_magic(x, m)	__ntfs_is_magic(x, magic_##m)
 
-static inline BOOL __ntfs_is_magicp(le32 *p, NTFS_RECORD_TYPES r)
+static inline BOOL __ntfs_is_magicp(le32 *p, NTFS_RECORD_TYPE r)
 {
 	return (*p == (__force le32)r);
 }
 #define ntfs_is_magicp(p, m)	__ntfs_is_magicp(p, magic_##m)
 
 /*
- * Specialised magic comparison macros for the NTFS_RECORD_TYPES defined above.
+ * Specialised magic comparison macros for the NTFS_RECORD_TYPEs defined above.
  */
 #define ntfs_is_file_record(x)		( ntfs_is_magic (x, FILE) )
 #define ntfs_is_file_recordp(p)		( ntfs_is_magicp(p, FILE) )
@@ -199,8 +196,8 @@
  * (usa_count * 2) has to be less than or equal to 510.
  */
 typedef struct {
-	NTFS_RECORD_TYPES magic;	/* A four-byte magic identifying the
-					   record type and/or status. */
+	NTFS_RECORD_TYPE magic;	/* A four-byte magic identifying the record
+				   type and/or status. */
 	le16 usa_ofs;		/* Offset to the Update Sequence Array (usa)
 				   from the start of the ntfs record. */
 	le16 usa_count;		/* Number of le16 sized entries in the usa
@@ -259,11 +256,10 @@
  * These are the so far known MFT_RECORD_* flags (16-bit) which contain
  * information about the mft record in which they are present.
  */
-typedef enum {
-	MFT_RECORD_IN_USE	= const_cpu_to_le16(0x0001),
-	MFT_RECORD_IS_DIRECTORY	= const_cpu_to_le16(0x0002),
-	MFT_REC_SPACE_FILLER	= 0xffff	/* Just to make flags 16-bit. */
-} __attribute__ ((__packed__)) MFT_RECORD_FLAGS;
+#define MFT_RECORD_IN_USE	const_cpu_to_le16(0x0001)
+#define MFT_RECORD_IS_DIRECTORY	const_cpu_to_le16(0x0002)
+
+typedef le16 MFT_RECORD_FLAGS;
 
 /*
  * mft references (aka file references or file record segment references) are
@@ -336,7 +332,7 @@
 typedef struct {
 /*Ofs*/
 /*  0	NTFS_RECORD; -- Unfolded here as gcc doesn't like unnamed structs. */
-	NTFS_RECORD_TYPES magic;/* Usually the magic is "FILE". */
+	NTFS_RECORD_TYPE magic;	/* Usually the magic is "FILE". */
 	le16 usa_ofs;		/* See NTFS_RECORD definition above. */
 	le16 usa_count;		/* See NTFS_RECORD definition above. */
 
@@ -403,38 +399,40 @@
 } __attribute__ ((__packed__)) MFT_RECORD;
 
 /*
- * System defined attributes (32-bit). Each attribute type has a corresponding
+ * System defined attributes (32-bit).  Each attribute type has a corresponding
  * attribute name (Unicode string of maximum 64 character length) as described
  * by the attribute definitions present in the data attribute of the $AttrDef
- * system file. On NTFS 3.0 volumes the names are just as the types are named
- * in the below enum exchanging AT_ for the dollar sign ($). If that isn't a
- * revealing choice of symbol... (-;
- */
-typedef enum {
-	AT_UNUSED			= const_cpu_to_le32(	     0),
-	AT_STANDARD_INFORMATION		= const_cpu_to_le32(      0x10),
-	AT_ATTRIBUTE_LIST		= const_cpu_to_le32(      0x20),
-	AT_FILE_NAME			= const_cpu_to_le32(      0x30),
-	AT_OBJECT_ID			= const_cpu_to_le32(      0x40),
-	AT_SECURITY_DESCRIPTOR		= const_cpu_to_le32(      0x50),
-	AT_VOLUME_NAME			= const_cpu_to_le32(      0x60),
-	AT_VOLUME_INFORMATION		= const_cpu_to_le32(      0x70),
-	AT_DATA				= const_cpu_to_le32(      0x80),
-	AT_INDEX_ROOT			= const_cpu_to_le32(      0x90),
-	AT_INDEX_ALLOCATION		= const_cpu_to_le32(      0xa0),
-	AT_BITMAP			= const_cpu_to_le32(      0xb0),
-	AT_REPARSE_POINT		= const_cpu_to_le32(      0xc0),
-	AT_EA_INFORMATION		= const_cpu_to_le32(      0xd0),
-	AT_EA				= const_cpu_to_le32(      0xe0),
-	AT_PROPERTY_SET			= const_cpu_to_le32(      0xf0),
-	AT_LOGGED_UTILITY_STREAM	= const_cpu_to_le32(     0x100),
-	AT_FIRST_USER_DEFINED_ATTRIBUTE	= const_cpu_to_le32(    0x1000),
-	AT_END				= const_cpu_to_le32(0xffffffff),
-} ATTR_TYPES;
+ * system file.  On NTFS 3.0 volumes the names are just as the types are named
+ * in the below defines exchanging AT_ for the dollar sign ($).  If that is not
+ * a revealing choice of symbol I do not know what is... (-;
+ */
+#define AT_UNUSED			const_cpu_to_le32(         0)
+#define AT_STANDARD_INFORMATION		const_cpu_to_le32(      0x10)
+#define AT_ATTRIBUTE_LIST		const_cpu_to_le32(      0x20)
+#define AT_FILE_NAME			const_cpu_to_le32(      0x30)
+#define AT_OBJECT_ID			const_cpu_to_le32(      0x40)
+#define AT_SECURITY_DESCRIPTOR		const_cpu_to_le32(      0x50)
+#define AT_VOLUME_NAME			const_cpu_to_le32(      0x60)
+#define AT_VOLUME_INFORMATION		const_cpu_to_le32(      0x70)
+#define AT_DATA				const_cpu_to_le32(      0x80)
+#define AT_INDEX_ROOT			const_cpu_to_le32(      0x90)
+#define AT_INDEX_ALLOCATION		const_cpu_to_le32(      0xa0)
+#define AT_BITMAP			const_cpu_to_le32(      0xb0)
+#define AT_REPARSE_POINT		const_cpu_to_le32(      0xc0)
+#define AT_EA_INFORMATION		const_cpu_to_le32(      0xd0)
+#define AT_EA				const_cpu_to_le32(      0xe0)
+#define AT_PROPERTY_SET			const_cpu_to_le32(      0xf0)
+#define AT_LOGGED_UTILITY_STREAM	const_cpu_to_le32(     0x100)
+#define AT_FIRST_USER_DEFINED_ATTRIBUTE	const_cpu_to_le32(    0x1000)
+#define AT_END				const_cpu_to_le32(0xffffffff)
+
+typedef le32 ATTR_TYPE;
 
 /*
  * The collation rules for sorting views/indexes/etc (32-bit).
  *
+ * COLLATION_BINARY - Collate by binary compare where the first byte is most
+ *	significant.
  * COLLATION_UNICODE_STRING - Collate Unicode strings by comparing their binary
  *	Unicode values, except that when a character can be uppercased, the
  *	upper case value collates before the lower case one.
@@ -468,40 +466,32 @@
  *	the 2nd object_id. If the first le32 values of both object_ids were
  *	equal then the second le32 values would be compared, etc.
  */
-typedef enum {
-	COLLATION_BINARY	 = const_cpu_to_le32(0x00), /* Collate by
-					binary compare where the first byte is
-					most significant. */
-	COLLATION_FILE_NAME	 = const_cpu_to_le32(0x01), /* Collate file
-					names as Unicode strings. */
-	COLLATION_UNICODE_STRING = const_cpu_to_le32(0x02), /* Collate Unicode
-					strings by comparing their binary
-					Unicode values, except that when a
-					character can be uppercased, the upper
-					case value collates before the lower
-					case one. */
-	COLLATION_NTOFS_ULONG		= const_cpu_to_le32(0x10),
-	COLLATION_NTOFS_SID		= const_cpu_to_le32(0x11),
-	COLLATION_NTOFS_SECURITY_HASH	= const_cpu_to_le32(0x12),
-	COLLATION_NTOFS_ULONGS		= const_cpu_to_le32(0x13),
-} COLLATION_RULES;
+#define COLLATION_BINARY		const_cpu_to_le32(0x00)
+#define COLLATION_FILE_NAME		const_cpu_to_le32(0x01)
+#define COLLATION_UNICODE_STRING	const_cpu_to_le32(0x02)
+#define COLLATION_NTOFS_ULONG		const_cpu_to_le32(0x10)
+#define COLLATION_NTOFS_SID		const_cpu_to_le32(0x11)
+#define COLLATION_NTOFS_SECURITY_HASH	const_cpu_to_le32(0x12)
+#define COLLATION_NTOFS_ULONGS		const_cpu_to_le32(0x13)
+
+typedef le32 COLLATION_RULE;
 
 /*
  * The flags (32-bit) describing attribute properties in the attribute
- * definition structure. FIXME: This information is from Regis's information
+ * definition structure.  FIXME: This information is from Regis's information
  * and, according to him, it is not certain and probably incomplete.
  * The INDEXABLE flag is fairly certainly correct as only the file name
  * attribute has this flag set and this is the only attribute indexed in NT4.
  */
-typedef enum {
-	INDEXABLE	    = const_cpu_to_le32(0x02),	/* Attribute can be
-							   indexed. */
-	NEED_TO_REGENERATE  = const_cpu_to_le32(0x40),	/* Need to regenerate
-							   during regeneration
-							   phase. */
-	CAN_BE_NON_RESIDENT = const_cpu_to_le32(0x80),	/* Attribute can be
-							   non-resident. */
-} ATTR_DEF_FLAGS;
+#define INDEXABLE	    const_cpu_to_le32(0x02) /* Attribute can be
+						       indexed. */
+#define NEED_TO_REGENERATE  const_cpu_to_le32(0x40) /* Need to regenerate
+						       during regeneration
+						       phase. */
+#define CAN_BE_NON_RESIDENT const_cpu_to_le32(0x80) /* Attribute can be
+						       non-resident. */
+
+typedef le32 ATTR_DEF_FLAGS;
 
 /*
  * The data attribute of FILE_AttrDef contains a sequence of attribute
@@ -516,10 +506,10 @@
 /*hex ofs*/
 /*  0*/	ntfschar name[0x40];		/* Unicode name of the attribute. Zero
 					   terminated. */
-/* 80*/	ATTR_TYPES type;		/* Type of the attribute. */
+/* 80*/	ATTR_TYPE type;			/* Type of the attribute. */
 /* 84*/	le32 display_rule;		/* Default display rule.
 					   FIXME: What does it mean? (AIA) */
-/* 88*/ COLLATION_RULES collation_rule;	/* Default collation rule. */
+/* 88*/ COLLATION_RULE collation_rule;	/* Default collation rule. */
 /* 8c*/	ATTR_DEF_FLAGS flags;		/* Flags describing the attribute. */
 /* 90*/	le64 min_size;			/* Optional minimum attribute size. */
 /* 98*/	le64 max_size;			/* Maximum size of attribute. */
@@ -529,14 +519,14 @@
 /*
  * Attribute flags (16-bit).
  */
-typedef enum {
-	ATTR_IS_COMPRESSED	= const_cpu_to_le16(0x0001),
-	ATTR_COMPRESSION_MASK	= const_cpu_to_le16(0x00ff),  /* Compression
-						method mask. Also, first
-						illegal value. */
-	ATTR_IS_ENCRYPTED	= const_cpu_to_le16(0x4000),
-	ATTR_IS_SPARSE		= const_cpu_to_le16(0x8000),
-} __attribute__ ((__packed__)) ATTR_FLAGS;
+#define ATTR_IS_COMPRESSED    const_cpu_to_le16(0x0001)
+#define	ATTR_COMPRESSION_MASK const_cpu_to_le16(0x00ff) /* Compression method
+							   mask.  Also, first
+							   illegal value. */
+#define ATTR_IS_ENCRYPTED     const_cpu_to_le16(0x4000)
+#define ATTR_IS_SPARSE	      const_cpu_to_le16(0x8000)
+
+typedef le16 ATTR_FLAGS;
 
 /*
  * Attribute compression.
@@ -608,18 +598,18 @@
 /*
  * Flags of resident attributes (8-bit).
  */
-typedef enum {
-	RESIDENT_ATTR_IS_INDEXED = 0x01, /* Attribute is referenced in an index
-					    (has implications for deleting and
-					    modifying the attribute). */
-} __attribute__ ((__packed__)) RESIDENT_ATTR_FLAGS;
+#define RESIDENT_ATTR_IS_INDEXED 0x01 /* Attribute is referenced in an index
+					 (has implications for deleting and
+					 modifying the attribute). */
+
+typedef u8 RESIDENT_ATTR_FLAGS;
 
 /*
  * Attribute record header. Always aligned to 8-byte boundary.
  */
 typedef struct {
 /*Ofs*/
-/*  0*/	ATTR_TYPES type;	/* The (32-bit) type of the attribute. */
+/*  0*/	ATTR_TYPE type;		/* The (32-bit) type of the attribute. */
 /*  4*/	le32 length;		/* Byte size of the resident part of the
 				   attribute (aligned to 8-byte boundary).
 				   Used to get to the next attribute. */
@@ -713,57 +703,56 @@
 
 /*
  * File attribute flags (32-bit).
+ *
+ * The following flags are only present in the STANDARD_INFORMATION attribute
+ * (in the field file_attributes).
  */
-typedef enum {
-	/*
-	 * These flags are only present in the STANDARD_INFORMATION attribute
-	 * (in the field file_attributes).
-	 */
-	FILE_ATTR_READONLY		= const_cpu_to_le32(0x00000001),
-	FILE_ATTR_HIDDEN		= const_cpu_to_le32(0x00000002),
-	FILE_ATTR_SYSTEM		= const_cpu_to_le32(0x00000004),
-	/* Old DOS volid. Unused in NT.	= cpu_to_le32(0x00000008), */
-
-	FILE_ATTR_DIRECTORY		= const_cpu_to_le32(0x00000010),
-	/* FILE_ATTR_DIRECTORY is not considered valid in NT. It is reserved
-	   for the DOS SUBDIRECTORY flag. */
-	FILE_ATTR_ARCHIVE		= const_cpu_to_le32(0x00000020),
-	FILE_ATTR_DEVICE		= const_cpu_to_le32(0x00000040),
-	FILE_ATTR_NORMAL		= const_cpu_to_le32(0x00000080),
-
-	FILE_ATTR_TEMPORARY		= const_cpu_to_le32(0x00000100),
-	FILE_ATTR_SPARSE_FILE		= const_cpu_to_le32(0x00000200),
-	FILE_ATTR_REPARSE_POINT		= const_cpu_to_le32(0x00000400),
-	FILE_ATTR_COMPRESSED		= const_cpu_to_le32(0x00000800),
-
-	FILE_ATTR_OFFLINE		= const_cpu_to_le32(0x00001000),
-	FILE_ATTR_NOT_CONTENT_INDEXED	= const_cpu_to_le32(0x00002000),
-	FILE_ATTR_ENCRYPTED		= const_cpu_to_le32(0x00004000),
-
-	FILE_ATTR_VALID_FLAGS		= const_cpu_to_le32(0x00007fb7),
-	/* FILE_ATTR_VALID_FLAGS masks out the old DOS VolId and the
-	   FILE_ATTR_DEVICE and preserves everything else. This mask
-	   is used to obtain all flags that are valid for reading. */
-	FILE_ATTR_VALID_SET_FLAGS	= const_cpu_to_le32(0x000031a7),
-	/* FILE_ATTR_VALID_SET_FLAGS masks out the old DOS VolId, the
-	   F_A_DEVICE, F_A_DIRECTORY, F_A_SPARSE_FILE, F_A_REPARSE_POINT,
-	   F_A_COMPRESSED and F_A_ENCRYPTED and preserves the rest. This mask
-	   is used to to obtain all flags that are valid for setting. */
+#define	FILE_ATTR_READONLY		const_cpu_to_le32(0x00000001)
+#define	FILE_ATTR_HIDDEN		const_cpu_to_le32(0x00000002)
+#define	FILE_ATTR_SYSTEM		const_cpu_to_le32(0x00000004)
+/* Old DOS volid. Unused in NT.	= cpu_to_le32(0x00000008), */
+
+#define FILE_ATTR_DIRECTORY		const_cpu_to_le32(0x00000010)
+/* FILE_ATTR_DIRECTORY is not considered valid in NT.  It is reserved for the
+   DOS SUBDIRECTORY flag. */
+#define FILE_ATTR_ARCHIVE		const_cpu_to_le32(0x00000020)
+#define FILE_ATTR_DEVICE		const_cpu_to_le32(0x00000040)
+#define FILE_ATTR_NORMAL		const_cpu_to_le32(0x00000080)
+
+#define FILE_ATTR_TEMPORARY		const_cpu_to_le32(0x00000100)
+#define FILE_ATTR_SPARSE_FILE		const_cpu_to_le32(0x00000200)
+#define FILE_ATTR_REPARSE_POINT		const_cpu_to_le32(0x00000400)
+#define FILE_ATTR_COMPRESSED		const_cpu_to_le32(0x00000800)
+
+#define FILE_ATTR_OFFLINE		const_cpu_to_le32(0x00001000)
+#define FILE_ATTR_NOT_CONTENT_INDEXED	const_cpu_to_le32(0x00002000)
+#define FILE_ATTR_ENCRYPTED		const_cpu_to_le32(0x00004000)
+
+#define FILE_ATTR_VALID_FLAGS		const_cpu_to_le32(0x00007fb7)
+/* FILE_ATTR_VALID_FLAGS masks out the old DOS VolId and the FILE_ATTR_DEVICE
+   and preserves everything else.  This mask is used to obtain all flags that
+   are valid for reading. */
+#define FILE_ATTR_VALID_SET_FLAGS	const_cpu_to_le32(0x000031a7)
+/* FILE_ATTR_VALID_SET_FLAGS masks out the old DOS VolId, the F_A_DEVICE,
+   F_A_DIRECTORY, F_A_SPARSE_FILE, F_A_REPARSE_POINT, F_A_COMPRESSED, and
+   F_A_ENCRYPTED and preserves the rest.  This mask is used to to obtain all
+   flags that are valid for setting. */
+
+/*
+ * The following flags are only present in the FILE_NAME attribute (in the
+ * field file_attributes).
+ */
+#define FILE_ATTR_DUP_FILE_NAME_INDEX_PRESENT	const_cpu_to_le32(0x10000000)
+/* This is a copy of the corresponding bit from the mft record, telling us
+   whether this is a directory or not, i.e. whether it has an index root
+   attribute or not. */
+#define FILE_ATTR_DUP_VIEW_INDEX_PRESENT	const_cpu_to_le32(0x20000000)
+/* This is a copy of the corresponding bit from the mft record, telling us
+   whether this file has a view index present (eg. object id index, quota
+   index, one of the security indexes or the encrypting file system related
+   indexes). */
 
-	/*
-	 * These flags are only present in the FILE_NAME attribute (in the
-	 * field file_attributes).
-	 */
-	FILE_ATTR_DUP_FILE_NAME_INDEX_PRESENT	= const_cpu_to_le32(0x10000000),
-	/* This is a copy of the corresponding bit from the mft record, telling
-	   us whether this is a directory or not, i.e. whether it has an
-	   index root attribute or not. */
-	FILE_ATTR_DUP_VIEW_INDEX_PRESENT	= const_cpu_to_le32(0x20000000),
-	/* This is a copy of the corresponding bit from the mft record, telling
-	   us whether this file has a view index present (eg. object id index,
-	   quota index, one of the security indexes or the encrypting file
-	   system related indexes). */
-} FILE_ATTR_FLAGS;
+typedef le32 FILE_ATTR_FLAGS;
 
 /*
  * NOTE on times in NTFS: All times are in MS standard time format, i.e. they
@@ -896,7 +885,7 @@
  */
 typedef struct {
 /*Ofs*/
-/*  0*/	ATTR_TYPES type;	/* Type of referenced attribute. */
+/*  0*/	ATTR_TYPE type;		/* Type of referenced attribute. */
 /*  4*/	le16 length;		/* Byte size of this entry (8-byte aligned). */
 /*  6*/	u8 name_length;		/* Size in Unicode chars of the name of the
 				   attribute or 0 if unnamed. */
@@ -934,28 +923,26 @@
 /*
  * Possible namespaces for filenames in ntfs (8-bit).
  */
-typedef enum {
-	FILE_NAME_POSIX			= 0x00,
-		/* This is the largest namespace. It is case sensitive and
-		   allows all Unicode characters except for: '\0' and '/'.
-		   Beware that in WinNT/2k files which eg have the same name
-		   except for their case will not be distinguished by the
-		   standard utilities and thus a "del filename" will delete
-		   both "filename" and "fileName" without warning. */
-	FILE_NAME_WIN32			= 0x01,
-		/* The standard WinNT/2k NTFS long filenames. Case insensitive.
-		   All Unicode chars except: '\0', '"', '*', '/', ':', '<',
-		   '>', '?', '\' and '|'. Further, names cannot end with a '.'
-		   or a space. */
-	FILE_NAME_DOS			= 0x02,
-		/* The standard DOS filenames (8.3 format). Uppercase only.
-		   All 8-bit characters greater space, except: '"', '*', '+',
-		   ',', '/', ':', ';', '<', '=', '>', '?' and '\'. */
-	FILE_NAME_WIN32_AND_DOS		= 0x03,
-		/* 3 means that both the Win32 and the DOS filenames are
-		   identical and hence have been saved in this single filename
-		   record. */
-} __attribute__ ((__packed__)) FILE_NAME_TYPE_FLAGS;
+#define FILE_NAME_POSIX		0x00
+	/* This is the largest namespace. It is case sensitive and allows all
+	   Unicode characters except for: '\0' and '/'.  Beware that in
+	   WinNT/2k files which eg have the same name except for their case
+	   will not be distinguished by the standard utilities and thus a "del
+	   filename" will delete both "filename" and "fileName" without
+	   warning. */
+#define FILE_NAME_WIN32		0x01
+	/* The standard WinNT/2k NTFS long filenames. Case insensitive.  All
+	   Unicode chars except: '\0', '"', '*', '/', ':', '<', '>', '?', '\',
+	   and '|'.  Further, names cannot end with a '.' or a space. */
+#define FILE_NAME_DOS		0x02
+	/* The standard DOS filenames (8.3 format). Uppercase only.  All 8-bit
+	   characters greater space, except: '"', '*', '+', ',', '/', ':', ';',
+	   '<', '=', '>', '?', and '\'. */
+#define FILE_NAME_WIN32_AND_DOS	0x03
+	/* 3 means that both the Win32 and the DOS filenames are identical and
+	   hence have been saved in this single filename record. */
+
+typedef u8 FILE_NAME_TYPE_FLAGS;
 
 /*
  * Attribute: Filename (0x30).
@@ -1261,30 +1248,31 @@
 /*
  * The predefined ACE types (8-bit, see below).
  */
-typedef enum {
-	ACCESS_MIN_MS_ACE_TYPE		= 0,
-	ACCESS_ALLOWED_ACE_TYPE		= 0,
-	ACCESS_DENIED_ACE_TYPE		= 1,
-	SYSTEM_AUDIT_ACE_TYPE		= 2,
-	SYSTEM_ALARM_ACE_TYPE		= 3, /* Not implemented as of Win2k. */
-	ACCESS_MAX_MS_V2_ACE_TYPE	= 3,
-
-	ACCESS_ALLOWED_COMPOUND_ACE_TYPE= 4,
-	ACCESS_MAX_MS_V3_ACE_TYPE	= 4,
-
-	/* The following are Win2k only. */
-	ACCESS_MIN_MS_OBJECT_ACE_TYPE	= 5,
-	ACCESS_ALLOWED_OBJECT_ACE_TYPE	= 5,
-	ACCESS_DENIED_OBJECT_ACE_TYPE	= 6,
-	SYSTEM_AUDIT_OBJECT_ACE_TYPE	= 7,
-	SYSTEM_ALARM_OBJECT_ACE_TYPE	= 8,
-	ACCESS_MAX_MS_OBJECT_ACE_TYPE	= 8,
-
-	ACCESS_MAX_MS_V4_ACE_TYPE	= 8,
-
-	/* This one is for WinNT&2k. */
-	ACCESS_MAX_MS_ACE_TYPE		= 8,
-} __attribute__ ((__packed__)) ACE_TYPES;
+#define ACCESS_MIN_MS_ACE_TYPE			0
+#define ACCESS_ALLOWED_ACE_TYPE			0
+#define ACCESS_DENIED_ACE_TYPE			1
+#define SYSTEM_AUDIT_ACE_TYPE			2
+#define SYSTEM_ALARM_ACE_TYPE			3 /* Not implemented as of
+						     Win2k. */
+#define ACCESS_MAX_MS_V2_ACE_TYPE		3
+
+#define ACCESS_ALLOWED_COMPOUND_ACE_TYPE	4
+#define ACCESS_MAX_MS_V3_ACE_TYPE		4
+
+/* The following are Win2k only. */
+#define ACCESS_MIN_MS_OBJECT_ACE_TYPE		5
+#define ACCESS_ALLOWED_OBJECT_ACE_TYPE		5
+#define ACCESS_DENIED_OBJECT_ACE_TYPE		6
+#define SYSTEM_AUDIT_OBJECT_ACE_TYPE		7
+#define SYSTEM_ALARM_OBJECT_ACE_TYPE		8
+#define ACCESS_MAX_MS_OBJECT_ACE_TYPE		8
+
+#define ACCESS_MAX_MS_V4_ACE_TYPE		8
+
+/* This one is for WinNT/2k. */
+#define	ACCESS_MAX_MS_ACE_TYPE			8
+
+typedef u8 ACE_TYPES;
 
 /*
  * The ACE flags (8-bit) for audit and inheritance (see below).
@@ -1296,19 +1284,19 @@
  * FAILED_ACCESS_ACE_FLAG is only used with system audit and alarm ACE types
  * to indicate that a message is generated (in Windows!) for failed accesses.
  */
-typedef enum {
-	/* The inheritance flags. */
-	OBJECT_INHERIT_ACE		= 0x01,
-	CONTAINER_INHERIT_ACE		= 0x02,
-	NO_PROPAGATE_INHERIT_ACE	= 0x04,
-	INHERIT_ONLY_ACE		= 0x08,
-	INHERITED_ACE			= 0x10,	/* Win2k only. */
-	VALID_INHERIT_FLAGS		= 0x1f,
-
-	/* The audit flags. */
-	SUCCESSFUL_ACCESS_ACE_FLAG	= 0x40,
-	FAILED_ACCESS_ACE_FLAG		= 0x80,
-} __attribute__ ((__packed__)) ACE_FLAGS;
+/* The inheritance flags. */
+#define OBJECT_INHERIT_ACE		0x01
+#define CONTAINER_INHERIT_ACE		0x02
+#define NO_PROPAGATE_INHERIT_ACE	0x04
+#define INHERIT_ONLY_ACE		0x08
+#define INHERITED_ACE			0x10	/* Win2k only. */
+#define VALID_INHERIT_FLAGS		0x1f
+
+/* The audit flags. */
+#define SUCCESSFUL_ACCESS_ACE_FLAG	0x40
+#define FAILED_ACCESS_ACE_FLAG		0x80
+
+typedef u8 ACE_FLAGS;
 
 /*
  * An ACE is an access-control entry in an access-control list (ACL).
@@ -1330,136 +1318,135 @@
 
 /*
  * The access mask (32-bit). Defines the access rights.
+ *
+ * The specific rights (bits 0 to 15).  These depend on the type of the object
+ * being secured by the ACE.
  */
-typedef enum {
-	/*
-	 * The specific rights (bits 0 to 15). Depend on the type of the
-	 * object being secured by the ACE.
-	 */
 
-	/* Specific rights for files and directories are as follows: */
+/* Specific rights for files and directories are as follows: */
 
-	/* Right to read data from the file. (FILE) */
-	FILE_READ_DATA			= const_cpu_to_le32(0x00000001),
-	/* Right to list contents of a directory. (DIRECTORY) */
-	FILE_LIST_DIRECTORY		= const_cpu_to_le32(0x00000001),
-
-	/* Right to write data to the file. (FILE) */
-	FILE_WRITE_DATA			= const_cpu_to_le32(0x00000002),
-	/* Right to create a file in the directory. (DIRECTORY) */
-	FILE_ADD_FILE			= const_cpu_to_le32(0x00000002),
-
-	/* Right to append data to the file. (FILE) */
-	FILE_APPEND_DATA		= const_cpu_to_le32(0x00000004),
-	/* Right to create a subdirectory. (DIRECTORY) */
-	FILE_ADD_SUBDIRECTORY		= const_cpu_to_le32(0x00000004),
-
-	/* Right to read extended attributes. (FILE/DIRECTORY) */
-	FILE_READ_EA			= const_cpu_to_le32(0x00000008),
-
-	/* Right to write extended attributes. (FILE/DIRECTORY) */
-	FILE_WRITE_EA			= const_cpu_to_le32(0x00000010),
-
-	/* Right to execute a file. (FILE) */
-	FILE_EXECUTE			= const_cpu_to_le32(0x00000020),
-	/* Right to traverse the directory. (DIRECTORY) */
-	FILE_TRAVERSE			= const_cpu_to_le32(0x00000020),
+/* Right to read data from the file. (FILE) */
+#define FILE_READ_DATA			const_cpu_to_le32(0x00000001)
+/* Right to list contents of a directory. (DIRECTORY) */
+#define FILE_LIST_DIRECTORY		const_cpu_to_le32(0x00000001)
 
-	/*
-	 * Right to delete a directory and all the files it contains (its
-	 * children), even if the files are read-only. (DIRECTORY)
-	 */
-	FILE_DELETE_CHILD		= const_cpu_to_le32(0x00000040),
+/* Right to write data to the file. (FILE) */
+#define FILE_WRITE_DATA			const_cpu_to_le32(0x00000002)
+/* Right to create a file in the directory. (DIRECTORY) */
+#define FILE_ADD_FILE			const_cpu_to_le32(0x00000002)
 
-	/* Right to read file attributes. (FILE/DIRECTORY) */
-	FILE_READ_ATTRIBUTES		= const_cpu_to_le32(0x00000080),
+/* Right to append data to the file. (FILE) */
+#define FILE_APPEND_DATA		const_cpu_to_le32(0x00000004)
+/* Right to create a subdirectory. (DIRECTORY) */
+#define FILE_ADD_SUBDIRECTORY		const_cpu_to_le32(0x00000004)
 
-	/* Right to change file attributes. (FILE/DIRECTORY) */
-	FILE_WRITE_ATTRIBUTES		= const_cpu_to_le32(0x00000100),
+/* Right to read extended attributes. (FILE/DIRECTORY) */
+#define FILE_READ_EA			const_cpu_to_le32(0x00000008)
 
-	/*
-	 * The standard rights (bits 16 to 23). Are independent of the type of
-	 * object being secured.
-	 */
+/* Right to write extended attributes. (FILE/DIRECTORY) */
+#define FILE_WRITE_EA			const_cpu_to_le32(0x00000010)
 
-	/* Right to delete the object. */
-	DELETE				= const_cpu_to_le32(0x00010000),
+/* Right to execute a file. (FILE) */
+#define FILE_EXECUTE			const_cpu_to_le32(0x00000020)
+/* Right to traverse the directory. (DIRECTORY) */
+#define FILE_TRAVERSE			const_cpu_to_le32(0x00000020)
 
-	/*
-	 * Right to read the information in the object's security descriptor,
-	 * not including the information in the SACL. I.e. right to read the
-	 * security descriptor and owner.
-	 */
-	READ_CONTROL			= const_cpu_to_le32(0x00020000),
+/*
+ * Right to delete a directory and all the files it contains (its children),
+ * even if the files are read-only. (DIRECTORY)
+ */
+#define FILE_DELETE_CHILD		const_cpu_to_le32(0x00000040)
 
-	/* Right to modify the DACL in the object's security descriptor. */
-	WRITE_DAC			= const_cpu_to_le32(0x00040000),
+/* Right to read file attributes. (FILE/DIRECTORY) */
+#define FILE_READ_ATTRIBUTES		const_cpu_to_le32(0x00000080)
 
-	/* Right to change the owner in the object's security descriptor. */
-	WRITE_OWNER			= const_cpu_to_le32(0x00080000),
+/* Right to change file attributes. (FILE/DIRECTORY) */
+#define FILE_WRITE_ATTRIBUTES		const_cpu_to_le32(0x00000100)
 
-	/*
-	 * Right to use the object for synchronization. Enables a process to
-	 * wait until the object is in the signalled state. Some object types
-	 * do not support this access right.
-	 */
-	SYNCHRONIZE			= const_cpu_to_le32(0x00100000),
+/*
+ * The standard rights (bits 16 to 23).  These are independent of the type of
+ * object being secured.
+ */
 
-	/*
-	 * The following STANDARD_RIGHTS_* are combinations of the above for
-	 * convenience and are defined by the Win32 API.
-	 */
+/* Right to delete the object. */
+#define DELETE				const_cpu_to_le32(0x00010000)
 
-	/* These are currently defined to READ_CONTROL. */
-	STANDARD_RIGHTS_READ		= const_cpu_to_le32(0x00020000),
-	STANDARD_RIGHTS_WRITE		= const_cpu_to_le32(0x00020000),
-	STANDARD_RIGHTS_EXECUTE		= const_cpu_to_le32(0x00020000),
+/*
+ * Right to read the information in the object's security descriptor, not
+ * including the information in the SACL. I.e. right to read the security
+ * descriptor and owner.
+ */
+#define READ_CONTROL			const_cpu_to_le32(0x00020000)
 
-	/* Combines DELETE, READ_CONTROL, WRITE_DAC, and WRITE_OWNER access. */
-	STANDARD_RIGHTS_REQUIRED	= const_cpu_to_le32(0x000f0000),
+/* Right to modify the DACL in the object's security descriptor. */
+#define WRITE_DAC			const_cpu_to_le32(0x00040000)
 
-	/*
-	 * Combines DELETE, READ_CONTROL, WRITE_DAC, WRITE_OWNER, and
-	 * SYNCHRONIZE access.
-	 */
-	STANDARD_RIGHTS_ALL		= const_cpu_to_le32(0x001f0000),
+/* Right to change the owner in the object's security descriptor. */
+#define WRITE_OWNER			const_cpu_to_le32(0x00080000)
 
-	/*
-	 * The access system ACL and maximum allowed access types (bits 24 to
-	 * 25, bits 26 to 27 are reserved).
-	 */
-	ACCESS_SYSTEM_SECURITY		= const_cpu_to_le32(0x01000000),
-	MAXIMUM_ALLOWED			= const_cpu_to_le32(0x02000000),
+/*
+ * Right to use the object for synchronization. Enables a process to wait until
+ * the object is in the signalled state. Some object types do not support this
+ * access right.
+ */
+#define SYNCHRONIZE			const_cpu_to_le32(0x00100000)
 
-	/*
-	 * The generic rights (bits 28 to 31). These map onto the standard and
-	 * specific rights.
-	 */
+/*
+ * The following STANDARD_RIGHTS_* are combinations of the above for
+ * convenience and are defined by the Win32 API.
+ */
 
-	/* Read, write, and execute access. */
-	GENERIC_ALL			= const_cpu_to_le32(0x10000000),
+/* These are currently defined to READ_CONTROL. */
+#define STANDARD_RIGHTS_READ		const_cpu_to_le32(0x00020000)
+#define STANDARD_RIGHTS_WRITE		const_cpu_to_le32(0x00020000)
+#define STANDARD_RIGHTS_EXECUTE		const_cpu_to_le32(0x00020000)
 
-	/* Execute access. */
-	GENERIC_EXECUTE			= const_cpu_to_le32(0x20000000),
+/* Combines DELETE, READ_CONTROL, WRITE_DAC, and WRITE_OWNER access. */
+#define STANDARD_RIGHTS_REQUIRED	const_cpu_to_le32(0x000f0000)
 
-	/*
-	 * Write access. For files, this maps onto:
-	 *	FILE_APPEND_DATA | FILE_WRITE_ATTRIBUTES | FILE_WRITE_DATA |
-	 *	FILE_WRITE_EA | STANDARD_RIGHTS_WRITE | SYNCHRONIZE
-	 * For directories, the mapping has the same numberical value. See
-	 * above for the descriptions of the rights granted.
-	 */
-	GENERIC_WRITE			= const_cpu_to_le32(0x40000000),
+/*
+ * Combines DELETE, READ_CONTROL, WRITE_DAC, WRITE_OWNER, and
+ * SYNCHRONIZE access.
+ */
+#define STANDARD_RIGHTS_ALL		const_cpu_to_le32(0x001f0000)
 
-	/*
-	 * Read access. For files, this maps onto:
-	 *	FILE_READ_ATTRIBUTES | FILE_READ_DATA | FILE_READ_EA |
-	 *	STANDARD_RIGHTS_READ | SYNCHRONIZE
-	 * For directories, the mapping has the same numberical value. See
-	 * above for the descriptions of the rights granted.
-	 */
-	GENERIC_READ			= const_cpu_to_le32(0x80000000),
-} ACCESS_MASK;
+/*
+ * The access system ACL and maximum allowed access types (bits 24 to
+ * 25, bits 26 to 27 are reserved).
+ */
+#define ACCESS_SYSTEM_SECURITY		const_cpu_to_le32(0x01000000)
+#define MAXIMUM_ALLOWED			const_cpu_to_le32(0x02000000)
+
+/*
+ * The generic rights (bits 28 to 31). These map onto the standard and specific
+ * rights.
+ */
+
+/* Read, write, and execute access. */
+#define GENERIC_ALL			const_cpu_to_le32(0x10000000)
+
+/* Execute access. */
+#define GENERIC_EXECUTE			const_cpu_to_le32(0x20000000)
+
+/*
+ * Write access. For files, this maps onto:
+ *	FILE_APPEND_DATA | FILE_WRITE_ATTRIBUTES | FILE_WRITE_DATA |
+ *	FILE_WRITE_EA | STANDARD_RIGHTS_WRITE | SYNCHRONIZE
+ * For directories, the mapping has the same numberical value.  See above for
+ * the descriptions of the rights granted.
+ */
+#define GENERIC_WRITE			const_cpu_to_le32(0x40000000)
+
+/*
+ * Read access. For files, this maps onto:
+ *	FILE_READ_ATTRIBUTES | FILE_READ_DATA | FILE_READ_EA |
+ *	STANDARD_RIGHTS_READ | SYNCHRONIZE
+ * For directories, the mapping has the same numberical value.  See above for
+ * the descriptions of the rights granted.
+ */
+#define GENERIC_READ			const_cpu_to_le32(0x80000000)
+
+typedef le32 ACCESS_MASK;
 
 /*
  * The generic mapping array. Used to denote the mapping of each generic
@@ -1495,10 +1482,10 @@
 /*
  * The object ACE flags (32-bit).
  */
-typedef enum {
-	ACE_OBJECT_TYPE_PRESENT			= const_cpu_to_le32(1),
-	ACE_INHERITED_OBJECT_TYPE_PRESENT	= const_cpu_to_le32(2),
-} OBJECT_ACE_FLAGS;
+#define ACE_OBJECT_TYPE_PRESENT			const_cpu_to_le32(1)
+#define ACE_INHERITED_OBJECT_TYPE_PRESENT	const_cpu_to_le32(2)
+
+typedef le32 OBJECT_ACE_FLAGS;
 
 typedef struct {
 /*  0	ACE_HEADER; -- Unfolded here as gcc doesn't like unnamed structs. */
@@ -1595,22 +1582,22 @@
  *	security descriptor are contiguous in memory and all pointer fields are
  *	expressed as offsets from the beginning of the security descriptor.
  */
-typedef enum {
-	SE_OWNER_DEFAULTED		= const_cpu_to_le16(0x0001),
-	SE_GROUP_DEFAULTED		= const_cpu_to_le16(0x0002),
-	SE_DACL_PRESENT			= const_cpu_to_le16(0x0004),
-	SE_DACL_DEFAULTED		= const_cpu_to_le16(0x0008),
-	SE_SACL_PRESENT			= const_cpu_to_le16(0x0010),
-	SE_SACL_DEFAULTED		= const_cpu_to_le16(0x0020),
-	SE_DACL_AUTO_INHERIT_REQ	= const_cpu_to_le16(0x0100),
-	SE_SACL_AUTO_INHERIT_REQ	= const_cpu_to_le16(0x0200),
-	SE_DACL_AUTO_INHERITED		= const_cpu_to_le16(0x0400),
-	SE_SACL_AUTO_INHERITED		= const_cpu_to_le16(0x0800),
-	SE_DACL_PROTECTED		= const_cpu_to_le16(0x1000),
-	SE_SACL_PROTECTED		= const_cpu_to_le16(0x2000),
-	SE_RM_CONTROL_VALID		= const_cpu_to_le16(0x4000),
-	SE_SELF_RELATIVE		= const_cpu_to_le16(0x8000),
-} __attribute__ ((__packed__)) SECURITY_DESCRIPTOR_CONTROL;
+#define SE_OWNER_DEFAULTED		const_cpu_to_le16(0x0001)
+#define SE_GROUP_DEFAULTED		const_cpu_to_le16(0x0002)
+#define SE_DACL_PRESENT			const_cpu_to_le16(0x0004)
+#define SE_DACL_DEFAULTED		const_cpu_to_le16(0x0008)
+#define SE_SACL_PRESENT			const_cpu_to_le16(0x0010)
+#define SE_SACL_DEFAULTED		const_cpu_to_le16(0x0020)
+#define SE_DACL_AUTO_INHERIT_REQ	const_cpu_to_le16(0x0100)
+#define SE_SACL_AUTO_INHERIT_REQ	const_cpu_to_le16(0x0200)
+#define SE_DACL_AUTO_INHERITED		const_cpu_to_le16(0x0400)
+#define SE_SACL_AUTO_INHERITED		const_cpu_to_le16(0x0800)
+#define SE_DACL_PROTECTED		const_cpu_to_le16(0x1000)
+#define SE_SACL_PROTECTED		const_cpu_to_le16(0x2000)
+#define SE_RM_CONTROL_VALID		const_cpu_to_le16(0x4000)
+#define SE_SELF_RELATIVE		const_cpu_to_le16(0x8000)
+
+typedef le16 SECURITY_DESCRIPTOR_CONTROL;
 
 /*
  * Self-relative security descriptor. Contains the owner and group SIDs as well
@@ -1794,19 +1781,19 @@
 /*
  * Possible flags for the volume (16-bit).
  */
-typedef enum {
-	VOLUME_IS_DIRTY			= const_cpu_to_le16(0x0001),
-	VOLUME_RESIZE_LOG_FILE		= const_cpu_to_le16(0x0002),
-	VOLUME_UPGRADE_ON_MOUNT		= const_cpu_to_le16(0x0004),
-	VOLUME_MOUNTED_ON_NT4		= const_cpu_to_le16(0x0008),
-	VOLUME_DELETE_USN_UNDERWAY	= const_cpu_to_le16(0x0010),
-	VOLUME_REPAIR_OBJECT_ID		= const_cpu_to_le16(0x0020),
-	VOLUME_MODIFIED_BY_CHKDSK	= const_cpu_to_le16(0x8000),
-	VOLUME_FLAGS_MASK		= const_cpu_to_le16(0x803f),
-
-	/* To make our life easier when checking if we must mount read-only. */
-	VOLUME_MUST_MOUNT_RO_MASK	= const_cpu_to_le16(0x8037),
-} __attribute__ ((__packed__)) VOLUME_FLAGS;
+#define VOLUME_IS_DIRTY			const_cpu_to_le16(0x0001)
+#define VOLUME_RESIZE_LOG_FILE		const_cpu_to_le16(0x0002)
+#define VOLUME_UPGRADE_ON_MOUNT		const_cpu_to_le16(0x0004)
+#define VOLUME_MOUNTED_ON_NT4		const_cpu_to_le16(0x0008)
+#define VOLUME_DELETE_USN_UNDERWAY	const_cpu_to_le16(0x0010)
+#define VOLUME_REPAIR_OBJECT_ID		const_cpu_to_le16(0x0020)
+#define VOLUME_MODIFIED_BY_CHKDSK	const_cpu_to_le16(0x8000)
+#define VOLUME_FLAGS_MASK		const_cpu_to_le16(0x803f)
+
+/* To make our life easier when checking if we must mount read-only. */
+#define VOLUME_MUST_MOUNT_RO_MASK	const_cpu_to_le16(0x8037)
+
+typedef le16 VOLUME_FLAGS;
 
 /*
  * Attribute: Volume information (0x70).
@@ -1836,25 +1823,26 @@
 
 /*
  * Index header flags (8-bit).
+ *
+ * When index header is in an index root attribute:
  */
-typedef enum {
-	/* When index header is in an index root attribute: */
-	SMALL_INDEX	= 0, /* The index is small enough to fit inside the
-				index root attribute and there is no index
-				allocation attribute present. */
-	LARGE_INDEX	= 1, /* The index is too large to fit in the index
-				root attribute and/or an index allocation
-				attribute is present. */
-	/*
-	 * When index header is in an index block, i.e. is part of index
-	 * allocation attribute:
-	 */
-	LEAF_NODE	= 0, /* This is a leaf node, i.e. there are no more
-				nodes branching off it. */
-	INDEX_NODE	= 1, /* This node indexes other nodes, i.e. is not a
-				leaf node. */
-	NODE_MASK	= 1, /* Mask for accessing the *_NODE bits. */
-} __attribute__ ((__packed__)) INDEX_HEADER_FLAGS;
+#define SMALL_INDEX 0 /* The index is small enough to fit inside the index root
+			 attribute and there is no index allocation attribute
+			 present. */
+#define LARGE_INDEX 1 /* The index is too large to fit in the index root
+			 attribute and/or an index allocation attribute is
+			 present. */
+/*
+ * When index header is in an index block, i.e. is part of index allocation
+ * attribute:
+ */
+#define LEAF_NODE  0 /* This is a leaf node, i.e. there are no more nodes
+			branching off it. */
+#define INDEX_NODE 1 /* This node indexes other nodes, i.e. it is not a leaf
+			node. */
+#define NODE_MASK  1 /* Mask for accessing the *_NODE bits. */
+
+typedef u8 INDEX_HEADER_FLAGS;
 
 /*
  * This is the header for indexes, describing the INDEX_ENTRY records, which
@@ -1904,11 +1892,11 @@
  * dircetories do not contain entries for themselves, though.
  */
 typedef struct {
-	ATTR_TYPES type;		/* Type of the indexed attribute. Is
+	ATTR_TYPE type;			/* Type of the indexed attribute. Is
 					   $FILE_NAME for directories, zero
 					   for view indexes. No other values
 					   allowed. */
-	COLLATION_RULES collation_rule;	/* Collation rule used to sort the
+	COLLATION_RULE collation_rule;	/* Collation rule used to sort the
 					   index entries. If type is $FILE_NAME,
 					   this must be COLLATION_FILE_NAME. */
 	le32 index_block_size;		/* Size of each index block in bytes (in
@@ -1937,7 +1925,7 @@
  */
 typedef struct {
 /*  0	NTFS_RECORD; -- Unfolded here as gcc doesn't like unnamed structs. */
-	NTFS_RECORD_TYPES magic;/* Magic is "INDX". */
+	NTFS_RECORD_TYPE magic;	/* Magic is "INDX". */
 	le16 usa_ofs;		/* See NTFS_RECORD definition. */
 	le16 usa_count;		/* See NTFS_RECORD definition. */
 
@@ -1980,27 +1968,28 @@
 
 /*
  * Quota flags (32-bit).
+ *
+ * The user quota flags.  Names explain meaning.
  */
-typedef enum {
-	/* The user quota flags. Names explain meaning. */
-	QUOTA_FLAG_DEFAULT_LIMITS	= const_cpu_to_le32(0x00000001),
-	QUOTA_FLAG_LIMIT_REACHED	= const_cpu_to_le32(0x00000002),
-	QUOTA_FLAG_ID_DELETED		= const_cpu_to_le32(0x00000004),
-
-	QUOTA_FLAG_USER_MASK		= const_cpu_to_le32(0x00000007),
-		/* Bit mask for user quota flags. */
-
-	/* These flags are only present in the quota defaults index entry,
-	   i.e. in the entry where owner_id = QUOTA_DEFAULTS_ID. */
-	QUOTA_FLAG_TRACKING_ENABLED	= const_cpu_to_le32(0x00000010),
-	QUOTA_FLAG_ENFORCEMENT_ENABLED	= const_cpu_to_le32(0x00000020),
-	QUOTA_FLAG_TRACKING_REQUESTED	= const_cpu_to_le32(0x00000040),
-	QUOTA_FLAG_LOG_THRESHOLD	= const_cpu_to_le32(0x00000080),
-	QUOTA_FLAG_LOG_LIMIT		= const_cpu_to_le32(0x00000100),
-	QUOTA_FLAG_OUT_OF_DATE		= const_cpu_to_le32(0x00000200),
-	QUOTA_FLAG_CORRUPT		= const_cpu_to_le32(0x00000400),
-	QUOTA_FLAG_PENDING_DELETES	= const_cpu_to_le32(0x00000800),
-} QUOTA_FLAGS;
+#define QUOTA_FLAG_DEFAULT_LIMITS	const_cpu_to_le32(0x00000001)
+#define QUOTA_FLAG_LIMIT_REACHED	const_cpu_to_le32(0x00000002)
+#define QUOTA_FLAG_ID_DELETED		const_cpu_to_le32(0x00000004)
+
+#define QUOTA_FLAG_USER_MASK		const_cpu_to_le32(0x00000007)
+	/* Bit mask for user quota flags. */
+
+/* These flags are only present in the quota defaults index entry, i.e. in the
+   entry where owner_id = QUOTA_DEFAULTS_ID. */
+#define QUOTA_FLAG_TRACKING_ENABLED	const_cpu_to_le32(0x00000010)
+#define QUOTA_FLAG_ENFORCEMENT_ENABLED	const_cpu_to_le32(0x00000020)
+#define QUOTA_FLAG_TRACKING_REQUESTED	const_cpu_to_le32(0x00000040)
+#define QUOTA_FLAG_LOG_THRESHOLD	const_cpu_to_le32(0x00000080)
+#define QUOTA_FLAG_LOG_LIMIT		const_cpu_to_le32(0x00000100)
+#define QUOTA_FLAG_OUT_OF_DATE		const_cpu_to_le32(0x00000200)
+#define QUOTA_FLAG_CORRUPT		const_cpu_to_le32(0x00000400)
+#define QUOTA_FLAG_PENDING_DELETES	const_cpu_to_le32(0x00000800)
+
+typedef le32 QUOTA_FLAGS;
 
 /*
  * The system file FILE_Extend/$Quota contains two indexes $O and $Q. Quotas
@@ -2040,11 +2029,9 @@
 /*
  * Predefined owner_id values (32-bit).
  */
-typedef enum {
-	QUOTA_INVALID_ID	= const_cpu_to_le32(0x00000000),
-	QUOTA_DEFAULTS_ID	= const_cpu_to_le32(0x00000001),
-	QUOTA_FIRST_USER_ID	= const_cpu_to_le32(0x00000100),
-} PREDEFINED_OWNER_IDS;
+#define QUOTA_INVALID_ID	const_cpu_to_le32(0x00000000)
+#define QUOTA_DEFAULTS_ID	const_cpu_to_le32(0x00000001)
+#define QUOTA_FIRST_USER_ID	const_cpu_to_le32(0x00000100)
 
 /*
  * Current constants for quota control entries.
@@ -2057,18 +2044,14 @@
 /*
  * Index entry flags (16-bit).
  */
-typedef enum {
-	INDEX_ENTRY_NODE = const_cpu_to_le16(1), /* This entry contains a
-					      sub-node, i.e. a reference to an
-					      index block in form of a virtual
-					      cluster number (see below). */
-	INDEX_ENTRY_END  = const_cpu_to_le16(2), /* This signifies the last
-					      entry in an index block.  The
-					      index entry does not represent a
-					      file but it can point to a
-					      sub-node. */
-	INDEX_ENTRY_SPACE_FILLER = 0xffff, /* Just to force 16-bit width. */
-} __attribute__ ((__packed__)) INDEX_ENTRY_FLAGS;
+#define INDEX_ENTRY_NODE const_cpu_to_le16(1) /* This entry contains a
+			sub-node, i.e. a reference to an index block in form of
+			a virtual cluster number (see below). */
+#define INDEX_ENTRY_END  const_cpu_to_le16(2) /* This signifies the last entry
+			in an index block.  The index entry does not represent
+			a file but it can point to a sub-node. */
+
+typedef le16 INDEX_ENTRY_FLAGS;
 
 /*
  * This the index entry header (see below).
@@ -2198,29 +2181,29 @@
  *		be slow. (E.g. the data is stored on a tape drive.)
  *	bit 31: Microsoft bit. If set, the tag is owned by Microsoft. User
  *		defined tags have to use zero here.
+ *
+ * These are the predefined reparse point tags:
  */
-typedef enum {
-	IO_REPARSE_TAG_IS_ALIAS		= const_cpu_to_le32(0x20000000),
-	IO_REPARSE_TAG_IS_HIGH_LATENCY	= const_cpu_to_le32(0x40000000),
-	IO_REPARSE_TAG_IS_MICROSOFT	= const_cpu_to_le32(0x80000000),
+#define IO_REPARSE_TAG_IS_ALIAS		const_cpu_to_le32(0x20000000)
+#define IO_REPARSE_TAG_IS_HIGH_LATENCY	const_cpu_to_le32(0x40000000)
+#define IO_REPARSE_TAG_IS_MICROSOFT	const_cpu_to_le32(0x80000000)
 
-	IO_REPARSE_TAG_RESERVED_ZERO	= const_cpu_to_le32(0x00000000),
-	IO_REPARSE_TAG_RESERVED_ONE	= const_cpu_to_le32(0x00000001),
-	IO_REPARSE_TAG_RESERVED_RANGE	= const_cpu_to_le32(0x00000001),
+#define IO_REPARSE_TAG_RESERVED_ZERO	const_cpu_to_le32(0x00000000)
+#define IO_REPARSE_TAG_RESERVED_ONE	const_cpu_to_le32(0x00000001)
+#define IO_REPARSE_TAG_RESERVED_RANGE	const_cpu_to_le32(0x00000001)
 
-	IO_REPARSE_TAG_NSS		= const_cpu_to_le32(0x68000005),
-	IO_REPARSE_TAG_NSS_RECOVER	= const_cpu_to_le32(0x68000006),
-	IO_REPARSE_TAG_SIS		= const_cpu_to_le32(0x68000007),
-	IO_REPARSE_TAG_DFS		= const_cpu_to_le32(0x68000008),
+#define IO_REPARSE_TAG_NSS		const_cpu_to_le32(0x68000005)
+#define IO_REPARSE_TAG_NSS_RECOVER	const_cpu_to_le32(0x68000006)
+#define IO_REPARSE_TAG_SIS		const_cpu_to_le32(0x68000007)
+#define IO_REPARSE_TAG_DFS		const_cpu_to_le32(0x68000008)
 
-	IO_REPARSE_TAG_MOUNT_POINT	= const_cpu_to_le32(0x88000003),
+#define IO_REPARSE_TAG_MOUNT_POINT	const_cpu_to_le32(0x88000003)
 
-	IO_REPARSE_TAG_HSM		= const_cpu_to_le32(0xa8000004),
+#define IO_REPARSE_TAG_HSM		const_cpu_to_le32(0xa8000004)
 
-	IO_REPARSE_TAG_SYMBOLIC_LINK	= const_cpu_to_le32(0xe8000000),
+#define IO_REPARSE_TAG_SYMBOLIC_LINK	const_cpu_to_le32(0xe8000000)
 
-	IO_REPARSE_TAG_VALID_VALUES	= const_cpu_to_le32(0xe000ffff),
-} PREDEFINED_REPARSE_TAGS;
+#define IO_REPARSE_TAG_VALID_VALUES	const_cpu_to_le32(0xe000ffff)
 
 /*
  * Attribute: Reparse point (0xc0).
@@ -2254,9 +2237,9 @@
 /*
  * Extended attribute flags (8-bit).
  */
-typedef enum {
-	NEED_EA	= 0x80,
-} __attribute__ ((__packed__)) EA_FLAGS;
+#define NEED_EA	0x80
+
+typedef u8 EA_FLAGS;
 
 /*
  * Attribute: Extended attribute (EA) (0xe0).
diff -Nru a/fs/ntfs/logfile.h b/fs/ntfs/logfile.h
--- a/fs/ntfs/logfile.h	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/logfile.h	2004-09-24 17:06:27 +01:00
@@ -67,7 +67,7 @@
 typedef struct {
 /*Ofs*/
 /*  0	NTFS_RECORD; -- Unfolded here as gcc doesn't like unnamed structs. */
-/*  0*/	NTFS_RECORD_TYPES magic;/* The magic is "RSTR". */
+/*  0*/	NTFS_RECORD_TYPE magic;	/* The magic is "RSTR". */
 /*  4*/	le16 usa_ofs;		/* See NTFS_RECORD definition in layout.h.
 				   When creating, set this to be immediately
 				   after this header structure (without any
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/mft.c	2004-09-24 17:06:27 +01:00
@@ -44,7 +44,7 @@
 	m->usa_ofs = cpu_to_le16((sizeof(MFT_RECORD) + 1) & ~1);
 	m->usa_count = cpu_to_le16(size / NTFS_BLOCK_SIZE + 1);
 	/* Set the update sequence number to 1. */
-	*(u16*)((char*)m + ((sizeof(MFT_RECORD) + 1) & ~1)) = cpu_to_le16(1);
+	*(le16*)((char*)m + ((sizeof(MFT_RECORD) + 1) & ~1)) = cpu_to_le16(1);
 	m->lsn = cpu_to_le64(0LL);
 	m->sequence_number = cpu_to_le16(1);
 	m->link_count = cpu_to_le16(0);
@@ -311,11 +311,11 @@
 /**
  * map_extent_mft_record - load an extent inode and attach it to its base
  * @base_ni:	base ntfs inode
- * @mref:	mft reference of the extent inode to load (in little endian)
+ * @mref:	mft reference of the extent inode to load
  * @ntfs_ino:	on successful return, pointer to the ntfs_inode structure
  *
  * Load the extent mft record @mref and attach it to its base inode @base_ni.
- * Return the mapped extent mft record if IS_ERR(result) is false. Otherwise
+ * Return the mapped extent mft record if IS_ERR(result) is false.  Otherwise
  * PTR_ERR(result) gives the negative error code.
  *
  * On successful return, @ntfs_ino contains a pointer to the ntfs_inode
@@ -328,8 +328,8 @@
 	ntfs_inode *ni = NULL;
 	ntfs_inode **extent_nis = NULL;
 	int i;
-	unsigned long mft_no = MREF_LE(mref);
-	u16 seq_no = MSEQNO_LE(mref);
+	unsigned long mft_no = MREF(mref);
+	u16 seq_no = MSEQNO(mref);
 	BOOL destroy_ni = FALSE;
 
 	ntfs_debug("Mapping extent mft record 0x%lx (base mft record 0x%lx).",
diff -Nru a/fs/ntfs/mst.c b/fs/ntfs/mst.c
--- a/fs/ntfs/mst.c	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/mst.c	2004-09-24 17:06:27 +01:00
@@ -122,8 +122,9 @@
  */
 int pre_write_mst_fixup(NTFS_RECORD *b, const u32 size)
 {
+	le16 *usa_pos, *data_pos;
 	u16 usa_ofs, usa_count, usn;
-	u16 *usa_pos, *data_pos;
+	le16 le_usn;
 
 	/* Sanity check + only fixup if it makes sense. */
 	if (!b || ntfs_is_baad_record(b->magic) ||
@@ -140,7 +141,7 @@
 	     (size >> NTFS_BLOCK_SIZE_BITS) != usa_count)
 		return -EINVAL;
 	/* Position of usn in update sequence array. */
-	usa_pos = (u16*)((u8*)b + usa_ofs);
+	usa_pos = (le16*)((u8*)b + usa_ofs);
 	/*
 	 * Cyclically increment the update sequence number
 	 * (skipping 0 and -1, i.e. 0xffff).
@@ -148,10 +149,10 @@
 	usn = le16_to_cpup(usa_pos) + 1;
 	if (usn == 0xffff || !usn)
 		usn = 1;
-	usn = cpu_to_le16(usn);
-	*usa_pos = usn;
+	le_usn = cpu_to_le16(usn);
+	*usa_pos = le_usn;
 	/* Position in data of first u16 that needs fixing up. */
-	data_pos = (u16*)b + NTFS_BLOCK_SIZE/sizeof(u16) - 1;
+	data_pos = (le16*)b + NTFS_BLOCK_SIZE/sizeof(le16) - 1;
 	/* Fixup all sectors. */
 	while (usa_count--) {
 		/*
@@ -160,9 +161,9 @@
 		 */
 		*(++usa_pos) = *data_pos;
 		/* Apply fixup to data. */
-		*data_pos = usn;
+		*data_pos = le_usn;
 		/* Increment position in data as well. */
-		data_pos += NTFS_BLOCK_SIZE/sizeof(u16);
+		data_pos += NTFS_BLOCK_SIZE/sizeof(le16);
 	}
 	return 0;
 }
@@ -177,16 +178,16 @@
  */
 void post_write_mst_fixup(NTFS_RECORD *b)
 {
-	u16 *usa_pos, *data_pos;
+	le16 *usa_pos, *data_pos;
 
 	u16 usa_ofs = le16_to_cpu(b->usa_ofs);
 	u16 usa_count = le16_to_cpu(b->usa_count) - 1;
 
 	/* Position of usn in update sequence array. */
-	usa_pos = (u16*)b + usa_ofs/sizeof(u16);
+	usa_pos = (le16*)b + usa_ofs/sizeof(le16);
 
 	/* Position in protected data of first u16 that needs fixing up. */
-	data_pos = (u16*)b + NTFS_BLOCK_SIZE/sizeof(u16) - 1;
+	data_pos = (le16*)b + NTFS_BLOCK_SIZE/sizeof(le16) - 1;
 
 	/* Fixup all sectors. */
 	while (usa_count--) {
@@ -197,6 +198,6 @@
 		*data_pos = *(++usa_pos);
 
 		/* Increment position in data as well. */
-		data_pos += NTFS_BLOCK_SIZE/sizeof(u16);
+		data_pos += NTFS_BLOCK_SIZE/sizeof(le16);
 	}
 }
diff -Nru a/fs/ntfs/quota.c b/fs/ntfs/quota.c
--- a/fs/ntfs/quota.c	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/quota.c	2004-09-24 17:06:27 +01:00
@@ -37,7 +37,7 @@
 {
 	ntfs_index_context *ictx;
 	QUOTA_CONTROL_ENTRY *qce;
-	const u32 qid = QUOTA_DEFAULTS_ID;
+	const le32 qid = QUOTA_DEFAULTS_ID;
 	int err;
 
 	ntfs_debug("Entering.");
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/super.c	2004-09-24 17:06:27 +01:00
@@ -322,7 +322,7 @@
 	int err;
 
 	ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
-			vol->vol_flags, flags);
+			le16_to_cpu(vol->vol_flags), le16_to_cpu(flags));
 	if (vol->vol_flags == flags)
 		goto done;
 	BUG_ON(!ni);
@@ -386,7 +386,8 @@
 static inline int ntfs_clear_volume_flags(ntfs_volume *vol, VOLUME_FLAGS flags)
 {
 	flags &= VOLUME_FLAGS_MASK;
-	return ntfs_write_volume_flags(vol, vol->vol_flags & ~flags);
+	flags = vol->vol_flags & cpu_to_le16(~le16_to_cpu(flags));
+	return ntfs_write_volume_flags(vol, flags);
 }
 
 #endif /* NTFS_RW */
diff -Nru a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
--- a/fs/ntfs/unistr.c	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/unistr.c	2004-09-24 17:06:27 +01:00
@@ -96,7 +96,7 @@
 		const ntfschar *upcase, const u32 upcase_len)
 {
 	u32 cnt, min_len;
-	ntfschar c1, c2;
+	u16 c1, c2;
 
 	min_len = name1_len;
 	if (name1_len > name2_len)
@@ -144,7 +144,7 @@
  */
 int ntfs_ucsncmp(const ntfschar *s1, const ntfschar *s2, size_t n)
 {
-	ntfschar c1, c2;
+	u16 c1, c2;
 	size_t i;
 
 	for (i = 0; i < n; ++i) {
@@ -181,8 +181,8 @@
 int ntfs_ucsncasecmp(const ntfschar *s1, const ntfschar *s2, size_t n,
 		const ntfschar *upcase, const u32 upcase_size)
 {
-	ntfschar c1, c2;
 	size_t i;
+	u16 c1, c2;
 
 	for (i = 0; i < n; ++i) {
 		if ((c1 = le16_to_cpu(s1[i])) < upcase_size)
@@ -203,7 +203,7 @@
 		const u32 upcase_len)
 {
 	u32 i;
-	ntfschar u;
+	u16 u;
 
 	for (i = 0; i < name_len; i++)
 		if ((u = le16_to_cpu(name[i])) < upcase_len)
diff -Nru a/fs/ntfs/upcase.c b/fs/ntfs/upcase.c
--- a/fs/ntfs/upcase.c	2004-09-24 17:06:27 +01:00
+++ b/fs/ntfs/upcase.c	2004-09-24 17:06:27 +01:00
@@ -3,7 +3,7 @@
  *	      Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001 Richard Russon <ntfs@flatcap.org>
- * Copyright (c) 2001-2003 Anton Altaparmakov
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  *
  * Modified for mkntfs inclusion 9 June 2001 by Anton Altaparmakov.
  * Modified for kernel inclusion 10 September 2001 by Anton Altparmakov.
@@ -87,4 +87,3 @@
 		uc[uc_word_table[r][0]] = cpu_to_le16(uc_word_table[r][1]);
 	return uc;
 }
-
