Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268919AbUIXQ0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268919AbUIXQ0h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268928AbUIXQZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:25:25 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:39826 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268890AbUIXQOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:14:17 -0400
Date: Fri, 24 Sep 2004 17:14:12 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 7/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups
 and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 7/10 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/24 1.1952.1.2)
   NTFS: Continuing sparse annotations: finish data types and header files.
   
   - Add leMFT_REF data type to fs/ntfs/layout.h.
   - Update all NTFS header files with the new little endian data types.
     Affected files are fs/ntfs/layout.h, logfile.h, and time.h.
   - Do proper type casting when using ntfs_is_*_recordp() in
     fs/ntfs/logfile.c, mft.c, and super.c.
   
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
--- a/fs/ntfs/ChangeLog	2004-09-24 17:06:23 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-24 17:06:23 +01:00
@@ -43,6 +43,11 @@
 	  new types as appropriate.
 	- Do proper type casting when using sle64_to_cpup() in fs/ntfs/dir.c
 	  and index.c.
+	- Add leMFT_REF data type to fs/ntfs/layout.h.
+	- Update all NTFS header files with the new little endian data types.
+	  Affected files are fs/ntfs/layout.h, logfile.h, and time.h.
+	- Do proper type casting when using ntfs_is_*_recordp() in
+	  fs/ntfs/logfile.c, mft.c, and super.c. 
 
 2.1.18 - Fix scheduling latencies at mount time as well as an endianness bug.
 
diff -Nru a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h	2004-09-24 17:06:23 +01:00
+++ b/fs/ntfs/layout.h	2004-09-24 17:06:23 +01:00
@@ -60,18 +60,18 @@
  * BIOS parameter block (bpb) structure.
  */
 typedef struct {
-	u16 bytes_per_sector;		/* Size of a sector in bytes. */
+	le16 bytes_per_sector;		/* Size of a sector in bytes. */
 	u8  sectors_per_cluster;	/* Size of a cluster in sectors. */
-	u16 reserved_sectors;		/* zero */
+	le16 reserved_sectors;		/* zero */
 	u8  fats;			/* zero */
-	u16 root_entries;		/* zero */
-	u16 sectors;			/* zero */
+	le16 root_entries;		/* zero */
+	le16 sectors;			/* zero */
 	u8  media_type;			/* 0xf8 = hard disk */
-	u16 sectors_per_fat;		/* zero */
-	u16 sectors_per_track;		/* irrelevant */
-	u16 heads;			/* irrelevant */
-	u32 hidden_sectors;		/* zero */
-	u32 large_sectors;		/* zero */
+	le16 sectors_per_fat;		/* zero */
+	le16 sectors_per_track;		/* irrelevant */
+	le16 heads;			/* irrelevant */
+	le32 hidden_sectors;		/* zero */
+	le32 large_sectors;		/* zero */
 } __attribute__ ((__packed__)) BIOS_PARAMETER_BLOCK;
 
 /*
@@ -79,7 +79,7 @@
  */
 typedef struct {
 	u8  jump[3];			/* Irrelevant (jump to boot up code).*/
-	u64 oem_id;			/* Magic "NTFS    ". */
+	le64 oem_id;			/* Magic "NTFS    ". */
 	BIOS_PARAMETER_BLOCK bpb;	/* See BIOS_PARAMETER_BLOCK. */
 	u8  unused[4];			/* zero, NTFS diskedit.exe states that
 					   this is actually:
@@ -89,21 +89,21 @@
 									// 0x80
 						__u8 unused;		// zero
 					 */
-/*0x28*/s64 number_of_sectors;		/* Number of sectors in volume. Gives
+/*0x28*/sle64 number_of_sectors;	/* Number of sectors in volume. Gives
 					   maximum volume size of 2^63 sectors.
 					   Assuming standard sector size of 512
 					   bytes, the maximum byte size is
 					   approx. 4.7x10^21 bytes. (-; */
-	s64 mft_lcn;			/* Cluster location of mft data. */
-	s64 mftmirr_lcn;		/* Cluster location of copy of mft. */
+	sle64 mft_lcn;			/* Cluster location of mft data. */
+	sle64 mftmirr_lcn;		/* Cluster location of copy of mft. */
 	s8  clusters_per_mft_record;	/* Mft record size in clusters. */
 	u8  reserved0[3];		/* zero */
 	s8  clusters_per_index_record;	/* Index block size in clusters. */
 	u8  reserved1[3];		/* zero */
-	u64 volume_serial_number;	/* Irrelevant (serial number). */
-	u32 checksum;			/* Boot sector checksum. */
+	le64 volume_serial_number;	/* Irrelevant (serial number). */
+	le32 checksum;			/* Boot sector checksum. */
 /*0x54*/u8  bootstrap[426];		/* Irrelevant (boot up code). */
-	u16 end_of_sector_marker;	/* End of bootsector magic. Always is
+	le16 end_of_sector_marker;	/* End of bootsector magic. Always is
 					   0xaa55 in little endian. */
 /* sizeof() = 512 (0x200) bytes */
 } __attribute__ ((__packed__)) NTFS_BOOT_SECTOR;
@@ -143,57 +143,67 @@
  * Generic magic comparison macros. Finally found a use for the ## preprocessor
  * operator! (-8
  */
-#define ntfs_is_magic(x, m)	(   (u32)(x) == magic_##m )
-#define ntfs_is_magicp(p, m)	( *(u32*)(p) == magic_##m )
+
+static inline BOOL __ntfs_is_magic(le32 x, NTFS_RECORD_TYPES r)
+{
+	return (x == (__force le32)r);
+}
+#define ntfs_is_magic(x, m)	__ntfs_is_magic(x, magic_##m)
+
+static inline BOOL __ntfs_is_magicp(le32 *p, NTFS_RECORD_TYPES r)
+{
+	return (*p == (__force le32)r);
+}
+#define ntfs_is_magicp(p, m)	__ntfs_is_magicp(p, magic_##m)
 
 /*
  * Specialised magic comparison macros for the NTFS_RECORD_TYPES defined above.
  */
-#define ntfs_is_file_record(x)	( ntfs_is_magic (x, FILE) )
-#define ntfs_is_file_recordp(p)	( ntfs_is_magicp(p, FILE) )
-#define ntfs_is_mft_record(x)	( ntfs_is_file_record(x) )
-#define ntfs_is_mft_recordp(p)	( ntfs_is_file_recordp(p) )
-#define ntfs_is_indx_record(x)	( ntfs_is_magic (x, INDX) )
-#define ntfs_is_indx_recordp(p)	( ntfs_is_magicp(p, INDX) )
-#define ntfs_is_hole_record(x)	( ntfs_is_magic (x, HOLE) )
-#define ntfs_is_hole_recordp(p)	( ntfs_is_magicp(p, HOLE) )
-
-#define ntfs_is_rstr_record(x)	( ntfs_is_magic (x, RSTR) )
-#define ntfs_is_rstr_recordp(p)	( ntfs_is_magicp(p, RSTR) )
-#define ntfs_is_rcrd_record(x)	( ntfs_is_magic (x, RCRD) )
-#define ntfs_is_rcrd_recordp(p)	( ntfs_is_magicp(p, RCRD) )
+#define ntfs_is_file_record(x)		( ntfs_is_magic (x, FILE) )
+#define ntfs_is_file_recordp(p)		( ntfs_is_magicp(p, FILE) )
+#define ntfs_is_mft_record(x)		( ntfs_is_file_record (x) )
+#define ntfs_is_mft_recordp(p)		( ntfs_is_file_recordp(p) )
+#define ntfs_is_indx_record(x)		( ntfs_is_magic (x, INDX) )
+#define ntfs_is_indx_recordp(p)		( ntfs_is_magicp(p, INDX) )
+#define ntfs_is_hole_record(x)		( ntfs_is_magic (x, HOLE) )
+#define ntfs_is_hole_recordp(p)		( ntfs_is_magicp(p, HOLE) )
+
+#define ntfs_is_rstr_record(x)		( ntfs_is_magic (x, RSTR) )
+#define ntfs_is_rstr_recordp(p)		( ntfs_is_magicp(p, RSTR) )
+#define ntfs_is_rcrd_record(x)		( ntfs_is_magic (x, RCRD) )
+#define ntfs_is_rcrd_recordp(p)		( ntfs_is_magicp(p, RCRD) )
 
-#define ntfs_is_chkd_record(x)	( ntfs_is_magic (x, CHKD) )
-#define ntfs_is_chkd_recordp(p)	( ntfs_is_magicp(p, CHKD) )
+#define ntfs_is_chkd_record(x)		( ntfs_is_magic (x, CHKD) )
+#define ntfs_is_chkd_recordp(p)		( ntfs_is_magicp(p, CHKD) )
 
-#define ntfs_is_baad_record(x)	( ntfs_is_magic (x, BAAD) )
-#define ntfs_is_baad_recordp(p)	( ntfs_is_magicp(p, BAAD) )
+#define ntfs_is_baad_record(x)		( ntfs_is_magic (x, BAAD) )
+#define ntfs_is_baad_recordp(p)		( ntfs_is_magicp(p, BAAD) )
 
 #define ntfs_is_empty_record(x)		( ntfs_is_magic (x, empty) )
 #define ntfs_is_empty_recordp(p)	( ntfs_is_magicp(p, empty) )
 
 /*
- * The Update Sequence Array (usa) is an array of the u16 values which belong
+ * The Update Sequence Array (usa) is an array of the le16 values which belong
  * to the end of each sector protected by the update sequence record in which
  * this array is contained. Note that the first entry is the Update Sequence
  * Number (usn), a cyclic counter of how many times the protected record has
  * been written to disk. The values 0 and -1 (ie. 0xffff) are not used. All
- * last u16's of each sector have to be equal to the usn (during reading) or
+ * last le16's of each sector have to be equal to the usn (during reading) or
  * are set to it (during writing). If they are not, an incomplete multi sector
  * transfer has occurred when the data was written.
  * The maximum size for the update sequence array is fixed to:
  *	maximum size = usa_ofs + (usa_count * 2) = 510 bytes
- * The 510 bytes comes from the fact that the last u16 in the array has to
- * (obviously) finish before the last u16 of the first 512-byte sector.
+ * The 510 bytes comes from the fact that the last le16 in the array has to
+ * (obviously) finish before the last le16 of the first 512-byte sector.
  * This formula can be used as a consistency check in that usa_ofs +
  * (usa_count * 2) has to be less than or equal to 510.
  */
 typedef struct {
 	NTFS_RECORD_TYPES magic;	/* A four-byte magic identifying the
 					   record type and/or status. */
-	u16 usa_ofs;		/* Offset to the Update Sequence Array (usa)
+	le16 usa_ofs;		/* Offset to the Update Sequence Array (usa)
 				   from the start of the ntfs record. */
-	u16 usa_count;		/* Number of u16 sized entries in the usa
+	le16 usa_count;		/* Number of le16 sized entries in the usa
 				   including the Update Sequence Number (usn),
 				   thus the number of fixups is the usa_count
 				   minus 1. */
@@ -305,6 +315,7 @@
 } MFT_REF_CONSTS;
 
 typedef u64 MFT_REF;
+typedef le64 leMFT_REF;
 
 #define MREF(x)		((unsigned long)((x) & MFT_REF_MASK_CPU))
 #define MSEQNO(x)	((u16)(((x) >> 48) & 0xffff))
@@ -326,17 +337,17 @@
 /*Ofs*/
 /*  0	NTFS_RECORD; -- Unfolded here as gcc doesn't like unnamed structs. */
 	NTFS_RECORD_TYPES magic;/* Usually the magic is "FILE". */
-	u16 usa_ofs;		/* See NTFS_RECORD definition above. */
-	u16 usa_count;		/* See NTFS_RECORD definition above. */
+	le16 usa_ofs;		/* See NTFS_RECORD definition above. */
+	le16 usa_count;		/* See NTFS_RECORD definition above. */
 
-/*  8*/	u64 lsn;		/* $LogFile sequence number for this record.
+/*  8*/	le64 lsn;		/* $LogFile sequence number for this record.
 				   Changed every time the record is modified. */
-/* 16*/	u16 sequence_number;	/* Number of times this mft record has been
+/* 16*/	le16 sequence_number;	/* Number of times this mft record has been
 				   reused. (See description for MFT_REF
 				   above.) NOTE: The increment (skipping zero)
 				   is done when the file is deleted. NOTE: If
 				   this is zero it is left zero. */
-/* 18*/	u16 link_count;		/* Number of hard links, i.e. the number of
+/* 18*/	le16 link_count;	/* Number of hard links, i.e. the number of
 				   directory entries referencing this record.
 				   NOTE: Only used in mft base records.
 				   NOTE: When deleting a directory entry we
@@ -346,18 +357,18 @@
 				   directory entry from the mft record and
 				   decrement the link_count.
 				   FIXME: Careful with Win32 + DOS names! */
-/* 20*/	u16 attrs_offset;	/* Byte offset to the first attribute in this
+/* 20*/	le16 attrs_offset;	/* Byte offset to the first attribute in this
 				   mft record from the start of the mft record.
 				   NOTE: Must be aligned to 8-byte boundary. */
 /* 22*/	MFT_RECORD_FLAGS flags;	/* Bit array of MFT_RECORD_FLAGS. When a file
 				   is deleted, the MFT_RECORD_IN_USE flag is
 				   set to zero. */
-/* 24*/	u32 bytes_in_use;	/* Number of bytes used in this mft record.
+/* 24*/	le32 bytes_in_use;	/* Number of bytes used in this mft record.
 				   NOTE: Must be aligned to 8-byte boundary. */
-/* 28*/	u32 bytes_allocated;	/* Number of bytes allocated for this mft
+/* 28*/	le32 bytes_allocated;	/* Number of bytes allocated for this mft
 				   record. This should be equal to the mft
 				   record size. */
-/* 32*/	MFT_REF base_mft_record; /* This is zero for base mft records.
+/* 32*/	leMFT_REF base_mft_record;/* This is zero for base mft records.
 				   When it is not zero it is a mft reference
 				   pointing to the base mft record to which
 				   this record belongs (this is then used to
@@ -369,17 +380,16 @@
 				   attribute list also means finding the other
 				   potential extents, belonging to the non-base
 				   mft record). */
-/* 40*/	u16 next_attr_instance;	/* The instance number that will be
-				   assigned to the next attribute added to this
-				   mft record. NOTE: Incremented each time
-				   after it is used. NOTE: Every time the mft
-				   record is reused this number is set to zero.
-				   NOTE: The first instance number is always 0.
-				 */
+/* 40*/	le16 next_attr_instance;/* The instance number that will be assigned to
+				   the next attribute added to this mft record.
+				   NOTE: Incremented each time after it is used.
+				   NOTE: Every time the mft record is reused
+				   this number is set to zero.  NOTE: The first
+				   instance number is always 0. */
 /* sizeof() = 42 bytes */
 /* NTFS 3.1+ (Windows XP and above) introduce the following additions. */
-/* 42*/ //u16 reserved;		/* Reserved/alignment. */
-/* 44*/ //u32 mft_record_number;/* Number of this mft record. */
+/* 42*/ //le16 reserved;	/* Reserved/alignment. */
+/* 44*/ //le32 mft_record_number;/* Number of this mft record. */
 /* sizeof() = 48 bytes */
 /*
  * When (re)using the mft record, we place the update sequence array at this
@@ -435,28 +445,28 @@
  *	unistr.c::ntfs_collate_names() and unistr.c::legal_ansi_char_array[]
  *	for what I mean but COLLATION_UNICODE_STRING would not give any special
  *	treatment to any characters at all, but this is speculation.
- * COLLATION_NTOFS_ULONG - Sorting is done according to ascending u32 key
+ * COLLATION_NTOFS_ULONG - Sorting is done according to ascending le32 key
  *	values. E.g. used for $SII index in FILE_Secure, which sorts by
- *	security_id (u32).
+ *	security_id (le32).
  * COLLATION_NTOFS_SID - Sorting is done according to ascending SID values.
  *	E.g. used for $O index in FILE_Extend/$Quota.
  * COLLATION_NTOFS_SECURITY_HASH - Sorting is done first by ascending hash
  *	values and second by ascending security_id values. E.g. used for $SDH
  *	index in FILE_Secure.
  * COLLATION_NTOFS_ULONGS - Sorting is done according to a sequence of ascending
- *	u32 key values. E.g. used for $O index in FILE_Extend/$ObjId, which
+ *	le32 key values. E.g. used for $O index in FILE_Extend/$ObjId, which
  *	sorts by object_id (16-byte), by splitting up the object_id in four
- *	u32 values and using them as individual keys. E.g. take the following
+ *	le32 values and using them as individual keys. E.g. take the following
  *	two security_ids, stored as follows on disk:
  *		1st: a1 61 65 b7 65 7b d4 11 9e 3d 00 e0 81 10 42 59
  *		2nd: 38 14 37 d2 d2 f3 d4 11 a5 21 c8 6b 79 b1 97 45
- *	To compare them, they are split into four u32 values each, like so:
+ *	To compare them, they are split into four le32 values each, like so:
  *		1st: 0xb76561a1 0x11d47b65 0xe0003d9e 0x59421081
  *		2nd: 0xd2371438 0x11d4f3d2 0x6bc821a5 0x4597b179
  *	Now, it is apparent why the 2nd object_id collates after the 1st: the
- *	first u32 value of the 1st object_id is less than the first u32 of
- *	the 2nd object_id. If the first u32 values of both object_ids were
- *	equal then the second u32 values would be compared, etc.
+ *	first le32 value of the 1st object_id is less than the first le32 of
+ *	the 2nd object_id. If the first le32 values of both object_ids were
+ *	equal then the second le32 values would be compared, etc.
  */
 typedef enum {
 	COLLATION_BINARY	 = const_cpu_to_le32(0x00), /* Collate by
@@ -507,12 +517,12 @@
 /*  0*/	ntfschar name[0x40];		/* Unicode name of the attribute. Zero
 					   terminated. */
 /* 80*/	ATTR_TYPES type;		/* Type of the attribute. */
-/* 84*/	u32 display_rule;		/* Default display rule.
+/* 84*/	le32 display_rule;		/* Default display rule.
 					   FIXME: What does it mean? (AIA) */
 /* 88*/ COLLATION_RULES collation_rule;	/* Default collation rule. */
 /* 8c*/	ATTR_DEF_FLAGS flags;		/* Flags describing the attribute. */
-/* 90*/	u64 min_size;			/* Optional minimum attribute size. */
-/* 98*/	u64 max_size;			/* Maximum size of attribute. */
+/* 90*/	le64 min_size;			/* Optional minimum attribute size. */
+/* 98*/	le64 max_size;			/* Maximum size of attribute. */
 /* sizeof() = 0xa0 or 160 bytes */
 } __attribute__ ((__packed__)) ATTR_DEF;
 
@@ -610,14 +620,14 @@
 typedef struct {
 /*Ofs*/
 /*  0*/	ATTR_TYPES type;	/* The (32-bit) type of the attribute. */
-/*  4*/	u32 length;		/* Byte size of the resident part of the
+/*  4*/	le32 length;		/* Byte size of the resident part of the
 				   attribute (aligned to 8-byte boundary).
 				   Used to get to the next attribute. */
 /*  8*/	u8 non_resident;	/* If 0, attribute is resident.
 				   If 1, attribute is non-resident. */
 /*  9*/	u8 name_length;		/* Unicode character size of name of attribute.
 				   0 if unnamed. */
-/* 10*/	u16 name_offset;	/* If name_length != 0, the byte offset to the
+/* 10*/	le16 name_offset;	/* If name_length != 0, the byte offset to the
 				   beginning of the name from the attribute
 				   record. Note that the name is stored as a
 				   Unicode string. When creating, place offset
@@ -627,15 +637,15 @@
 				   respectively, aligning to an 8-byte
 				   boundary. */
 /* 12*/	ATTR_FLAGS flags;	/* Flags describing the attribute. */
-/* 14*/	u16 instance;		/* The instance of this attribute record. This
+/* 14*/	le16 instance;		/* The instance of this attribute record. This
 				   number is unique within this mft record (see
 				   MFT_RECORD/next_attribute_instance notes in
 				   in mft.h for more details). */
 /* 16*/	union {
 		/* Resident attributes. */
 		struct {
-/* 16 */		u32 value_length; /* Byte size of attribute value. */
-/* 20 */		u16 value_offset; /* Byte offset of the attribute
+/* 16 */		le32 value_length;/* Byte size of attribute value. */
+/* 20 */		le16 value_offset;/* Byte offset of the attribute
 					     value from the start of the
 					     attribute record. When creating,
 					     align to 8-byte boundary if we
@@ -648,18 +658,18 @@
 		} __attribute__ ((__packed__)) resident;
 		/* Non-resident attributes. */
 		struct {
-/* 16*/			VCN lowest_vcn;	/* Lowest valid virtual cluster number
+/* 16*/			leVCN lowest_vcn;/* Lowest valid virtual cluster number
 				for this portion of the attribute value or
 				0 if this is the only extent (usually the
 				case). - Only when an attribute list is used
 				does lowest_vcn != 0 ever occur. */
-/* 24*/			VCN highest_vcn; /* Highest valid vcn of this extent of
+/* 24*/			leVCN highest_vcn;/* Highest valid vcn of this extent of
 				the attribute value. - Usually there is only one
 				portion, so this usually equals the attribute
 				value size in clusters minus 1. Can be -1 for
 				zero length files. Can be 0 for "single extent"
 				attributes. */
-/* 32*/			u16 mapping_pairs_offset; /* Byte offset from the
+/* 32*/			le16 mapping_pairs_offset; /* Byte offset from the
 				beginning of the structure to the mapping pairs
 				array which contains the mappings between the
 				vcns and the logical cluster numbers (lcns).
@@ -674,7 +684,7 @@
 /* 35*/			u8 reserved[5];		/* Align to 8-byte boundary. */
 /* The sizes below are only used when lowest_vcn is zero, as otherwise it would
    be difficult to keep them up-to-date.*/
-/* 40*/			s64 allocated_size;	/* Byte size of disk space
+/* 40*/			sle64 allocated_size;	/* Byte size of disk space
 				allocated to hold the attribute value. Always
 				is a multiple of the cluster size. When a file
 				is compressed, this field is a multiple of the
@@ -682,14 +692,14 @@
 				it represents the logically allocated space
 				rather than the actual on disk usage. For this
 				use the compressed_size (see below). */
-/* 48*/			s64 data_size;	/* Byte size of the attribute
+/* 48*/			sle64 data_size;	/* Byte size of the attribute
 				value. Can be larger than allocated_size if
 				attribute value is compressed or sparse. */
-/* 56*/			s64 initialized_size;	/* Byte size of initialized
+/* 56*/			sle64 initialized_size;	/* Byte size of initialized
 				portion of the attribute value. Usually equals
 				data_size. */
 /* sizeof(uncompressed attr) = 64*/
-/* 64*/			s64 compressed_size;	/* Byte size of the attribute
+/* 64*/			sle64 compressed_size;	/* Byte size of the attribute
 				value after compression. Only present when
 				compressed. Always is a multiple of the
 				cluster size. Represents the actual amount of
@@ -774,13 +784,13 @@
  */
 typedef struct {
 /*Ofs*/
-/*  0*/	s64 creation_time;		/* Time file was created. Updated when
+/*  0*/	sle64 creation_time;		/* Time file was created. Updated when
 					   a filename is changed(?). */
-/*  8*/	s64 last_data_change_time;	/* Time the data attribute was last
+/*  8*/	sle64 last_data_change_time;	/* Time the data attribute was last
 					   modified. */
-/* 16*/	s64 last_mft_change_time;	/* Time this mft record was last
+/* 16*/	sle64 last_mft_change_time;	/* Time this mft record was last
 					   modified. */
-/* 24*/	s64 last_access_time;		/* Approximate time when the file was
+/* 24*/	sle64 last_access_time;		/* Approximate time when the file was
 					   last accessed (obviously this is not
 					   updated on read-only volumes). In
 					   Windows this is only updated when
@@ -817,23 +827,23 @@
  * views that as a corruption, assuming that it behaves like this for all
  * attributes.
  */
-		/* 36*/	u32 maximum_versions;	/* Maximum allowed versions for
+		/* 36*/	le32 maximum_versions;	/* Maximum allowed versions for
 				file. Zero if version numbering is disabled. */
-		/* 40*/	u32 version_number;	/* This file's version (if any).
+		/* 40*/	le32 version_number;	/* This file's version (if any).
 				Set to zero if maximum_versions is zero. */
-		/* 44*/	u32 class_id;		/* Class id from bidirectional
+		/* 44*/	le32 class_id;		/* Class id from bidirectional
 				class id index (?). */
-		/* 48*/	u32 owner_id;		/* Owner_id of the user owning
+		/* 48*/	le32 owner_id;		/* Owner_id of the user owning
 				the file. Translate via $Q index in FILE_Extend
 				/$Quota to the quota control entry for the user
 				owning the file. Zero if quotas are disabled. */
-		/* 52*/	u32 security_id;	/* Security_id for the file.
+		/* 52*/	le32 security_id;	/* Security_id for the file.
 				Translate via $SII index and $SDS data stream
 				in FILE_Secure to the security descriptor. */
-		/* 56*/	u64 quota_charged;	/* Byte size of the charge to
+		/* 56*/	le64 quota_charged;	/* Byte size of the charge to
 				the quota for all streams of the file. Note: Is
 				zero if quotas are disabled. */
-		/* 64*/	u64 usn;		/* Last update sequence number
+		/* 64*/	le64 usn;		/* Last update sequence number
 				of the file. This is a direct index into the
 				change (aka usn) journal file. It is zero if
 				the usn journal is disabled.
@@ -887,13 +897,13 @@
 typedef struct {
 /*Ofs*/
 /*  0*/	ATTR_TYPES type;	/* Type of referenced attribute. */
-/*  4*/	u16 length;		/* Byte size of this entry (8-byte aligned). */
+/*  4*/	le16 length;		/* Byte size of this entry (8-byte aligned). */
 /*  6*/	u8 name_length;		/* Size in Unicode chars of the name of the
 				   attribute or 0 if unnamed. */
 /*  7*/	u8 name_offset;		/* Byte offset to beginning of attribute name
 				   (always set this to where the name would
 				   start even if unnamed). */
-/*  8*/	VCN lowest_vcn;		/* Lowest virtual cluster number of this portion
+/*  8*/	leVCN lowest_vcn;	/* Lowest virtual cluster number of this portion
 				   of the attribute value. This is usually 0. It
 				   is non-zero for the case where one attribute
 				   does not fit into one mft record and thus
@@ -905,10 +915,10 @@
 				   value! The windows driver uses cmp, followed
 				   by jg when comparing this, thus it treats it
 				   as signed. */
-/* 16*/	MFT_REF mft_reference;	/* The reference of the mft record holding
+/* 16*/	leMFT_REF mft_reference;/* The reference of the mft record holding
 				   the ATTR_RECORD for this portion of the
 				   attribute value. */
-/* 24*/	u16 instance;		/* If lowest_vcn = 0, the instance of the
+/* 24*/	le16 instance;		/* If lowest_vcn = 0, the instance of the
 				   attribute being referenced; otherwise 0. */
 /* 26*/	ntfschar name[0];	/* Use when creating only. When reading use
 				   name_offset to determine the location of the
@@ -962,30 +972,30 @@
  */
 typedef struct {
 /*hex ofs*/
-/*  0*/	MFT_REF parent_directory;	/* Directory this filename is
+/*  0*/	leMFT_REF parent_directory;	/* Directory this filename is
 					   referenced from. */
-/*  8*/	s64 creation_time;		/* Time file was created. */
-/* 10*/	s64 last_data_change_time;	/* Time the data attribute was last
+/*  8*/	sle64 creation_time;		/* Time file was created. */
+/* 10*/	sle64 last_data_change_time;	/* Time the data attribute was last
 					   modified. */
-/* 18*/	s64 last_mft_change_time;	/* Time this mft record was last
+/* 18*/	sle64 last_mft_change_time;	/* Time this mft record was last
 					   modified. */
-/* 20*/	s64 last_access_time;		/* Time this mft record was last
+/* 20*/	sle64 last_access_time;		/* Time this mft record was last
 					   accessed. */
-/* 28*/	s64 allocated_size;		/* Byte size of allocated space for the
+/* 28*/	sle64 allocated_size;		/* Byte size of allocated space for the
 					   data attribute. NOTE: Is a multiple
 					   of the cluster size. */
-/* 30*/	s64 data_size;			/* Byte size of actual data in data
+/* 30*/	sle64 data_size;		/* Byte size of actual data in data
 					   attribute. */
 /* 38*/	FILE_ATTR_FLAGS file_attributes;	/* Flags describing the file. */
 /* 3c*/	union {
 	/* 3c*/	struct {
-		/* 3c*/	u16 packed_ea_size;	/* Size of the buffer needed to
+		/* 3c*/	le16 packed_ea_size;	/* Size of the buffer needed to
 						   pack the extended attributes
 						   (EAs), if such are present.*/
-		/* 3e*/	u16 reserved;		/* Reserved for alignment. */
+		/* 3e*/	le16 reserved;		/* Reserved for alignment. */
 		} __attribute__ ((__packed__)) ea;
 	/* 3c*/	struct {
-		/* 3c*/	u32 reparse_point_tag;	/* Type of reparse point,
+		/* 3c*/	le32 reparse_point_tag;	/* Type of reparse point,
 						   present only in reparse
 						   points and only if there are
 						   no EAs. */
@@ -1007,9 +1017,9 @@
  *	1F010768-5A73-BC91-0010A52216A7
  */
 typedef struct {
-	u32 data1;	/* The first eight hexadecimal digits of the GUID. */
-	u16 data2;	/* The first group of four hexadecimal digits. */
-	u16 data3;	/* The second group of four hexadecimal digits. */
+	le32 data1;	/* The first eight hexadecimal digits of the GUID. */
+	le16 data2;	/* The first group of four hexadecimal digits. */
+	le16 data3;	/* The second group of four hexadecimal digits. */
 	u8 data4[8];	/* The first two bytes are the third group of four
 			   hexadecimal digits. The remaining six bytes are the
 			   final 12 hexadecimal digits. */
@@ -1027,7 +1037,7 @@
  *	domain_id	- Reserved (always zero).
  */
 typedef struct {
-	MFT_REF mft_reference;	/* Mft record containing the object_id in
+	leMFT_REF mft_reference;/* Mft record containing the object_id in
 				   the index entry key. */
 	union {
 		struct {
@@ -1195,13 +1205,16 @@
 
 /*
  * The SID_IDENTIFIER_AUTHORITY is a 48-bit value used in the SID structure.
+ *
+ * NOTE: This is stored as a big endian number, hence the high_part comes
+ * before the low_part.
  */
 typedef union {
 	struct {
-		u32 low;	/* Low 32-bits. */
-		u16 high;	/* High 16-bits. */
+		u16 high_part;	/* High 16-bits. */
+		u32 low_part;	/* Low 32-bits. */
 	} __attribute__ ((__packed__)) parts;
-	u8 value[6];			/* Value as individual bytes. */
+	u8 value[6];		/* Value as individual bytes. */
 } __attribute__ ((__packed__)) SID_IDENTIFIER_AUTHORITY;
 
 /*
@@ -1232,7 +1245,7 @@
 	u8 revision;
 	u8 sub_authority_count;
 	SID_IDENTIFIER_AUTHORITY identifier_authority;
-	u32 sub_authority[1];		/* At least one sub_authority. */
+	le32 sub_authority[1];		/* At least one sub_authority. */
 } __attribute__ ((__packed__)) SID;
 
 /*
@@ -1312,7 +1325,7 @@
 /*Ofs*/
 /*  0*/	ACE_TYPES type;		/* Type of the ACE. */
 /*  1*/	ACE_FLAGS flags;	/* Flags describing the ACE. */
-/*  2*/	u16 size;		/* Size in bytes of the ACE. */
+/*  2*/	le16 size;		/* Size in bytes of the ACE. */
 } __attribute__ ((__packed__)) ACE_HEADER;
 
 /*
@@ -1472,7 +1485,7 @@
 /*  0	ACE_HEADER; -- Unfolded here as gcc doesn't like unnamed structs. */
 	ACE_TYPES type;		/* Type of the ACE. */
 	ACE_FLAGS flags;	/* Flags describing the ACE. */
-	u16 size;		/* Size in bytes of the ACE. */
+	le16 size;		/* Size in bytes of the ACE. */
 /*  4*/	ACCESS_MASK mask;	/* Access mask associated with the ACE. */
 
 /*  8*/	SID sid;		/* The SID associated with the ACE. */
@@ -1491,7 +1504,7 @@
 /*  0	ACE_HEADER; -- Unfolded here as gcc doesn't like unnamed structs. */
 	ACE_TYPES type;		/* Type of the ACE. */
 	ACE_FLAGS flags;	/* Flags describing the ACE. */
-	u16 size;		/* Size in bytes of the ACE. */
+	le16 size;		/* Size in bytes of the ACE. */
 /*  4*/	ACCESS_MASK mask;	/* Access mask associated with the ACE. */
 
 /*  8*/	OBJECT_ACE_FLAGS object_flags;	/* Flags describing the object ACE. */
@@ -1514,10 +1527,10 @@
 typedef struct {
 	u8 revision;	/* Revision of this ACL. */
 	u8 alignment1;
-	u16 size;	/* Allocated space in bytes for ACL. Includes this
+	le16 size;	/* Allocated space in bytes for ACL. Includes this
 			   header, the ACEs and the remaining free space. */
-	u16 ace_count;	/* Number of ACEs in the ACL. */
-	u16 alignment2;
+	le16 ace_count;	/* Number of ACEs in the ACL. */
+	le16 alignment2;
 /* sizeof() = 8 bytes */
 } __attribute__ ((__packed__)) ACL;
 
@@ -1608,17 +1621,17 @@
 	u8 alignment;
 	SECURITY_DESCRIPTOR_CONTROL control; /* Flags qualifying the type of
 			   the descriptor as well as the following fields. */
-	u32 owner;	/* Byte offset to a SID representing an object's
+	le32 owner;	/* Byte offset to a SID representing an object's
 			   owner. If this is NULL, no owner SID is present in
 			   the descriptor. */
-	u32 group;	/* Byte offset to a SID representing an object's
+	le32 group;	/* Byte offset to a SID representing an object's
 			   primary group. If this is NULL, no primary group
 			   SID is present in the descriptor. */
-	u32 sacl;	/* Byte offset to a system ACL. Only valid, if
+	le32 sacl;	/* Byte offset to a system ACL. Only valid, if
 			   SE_SACL_PRESENT is set in the control field. If
 			   SE_SACL_PRESENT is set but sacl is NULL, a NULL ACL
 			   is specified. */
-	u32 dacl;	/* Byte offset to a discretionary ACL. Only valid, if
+	le32 dacl;	/* Byte offset to a discretionary ACL. Only valid, if
 			   SE_DACL_PRESENT is set in the control field. If
 			   SE_DACL_PRESENT is set but dacl is NULL, a NULL ACL
 			   (unconditionally granting access) is specified. */
@@ -1721,10 +1734,10 @@
  * This is also the index entry data part of both the $SII and $SDH indexes.
  */
 typedef struct {
-	u32 hash;	   /* Hash of the security descriptor. */
-	u32 security_id;   /* The security_id assigned to the descriptor. */
-	u64 offset;	   /* Byte offset of this entry in the $SDS stream. */
-	u32 length;	   /* Size in bytes of this entry in $SDS stream. */
+	le32 hash;	  /* Hash of the security descriptor. */
+	le32 security_id; /* The security_id assigned to the descriptor. */
+	le64 offset;	  /* Byte offset of this entry in the $SDS stream. */
+	le32 length;	  /* Size in bytes of this entry in $SDS stream. */
 } __attribute__ ((__packed__)) SECURITY_DESCRIPTOR_HEADER;
 
 /*
@@ -1742,10 +1755,10 @@
 /*Ofs*/
 /*  0	SECURITY_DESCRIPTOR_HEADER; -- Unfolded here as gcc doesn't like
 				       unnamed structs. */
-	u32 hash;	   /* Hash of the security descriptor. */
-	u32 security_id;   /* The security_id assigned to the descriptor. */
-	u64 offset;	   /* Byte offset of this entry in the $SDS stream. */
-	u32 length;	   /* Size in bytes of this entry in $SDS stream. */
+	le32 hash;	  /* Hash of the security descriptor. */
+	le32 security_id; /* The security_id assigned to the descriptor. */
+	le64 offset;	  /* Byte offset of this entry in the $SDS stream. */
+	le32 length;	  /* Size in bytes of this entry in $SDS stream. */
 /* 20*/	SECURITY_DESCRIPTOR_RELATIVE sid; /* The self-relative security
 					     descriptor. */
 } __attribute__ ((__packed__)) SDS_ENTRY;
@@ -1755,7 +1768,7 @@
  * COLLATION_NTOFS_ULONG.
  */
 typedef struct {
-	u32 security_id; /* The security_id assigned to the descriptor. */
+	le32 security_id; /* The security_id assigned to the descriptor. */
 } __attribute__ ((__packed__)) SII_INDEX_KEY;
 
 /*
@@ -1764,8 +1777,8 @@
  * COLLATION_NTOFS_SECURITY_HASH.
  */
 typedef struct {
-	u32 hash;	   /* Hash of the security descriptor. */
-	u32 security_id;   /* The security_id assigned to the descriptor. */
+	le32 hash;	  /* Hash of the security descriptor. */
+	le32 security_id; /* The security_id assigned to the descriptor. */
 } __attribute__ ((__packed__)) SDH_INDEX_KEY;
 
 /*
@@ -1804,7 +1817,7 @@
  *	 NTFS 1.2. I haven't personally seen other values yet.
  */
 typedef struct {
-	u64 reserved;		/* Not used (yet?). */
+	le64 reserved;		/* Not used (yet?). */
 	u8 major_ver;		/* Major version of the ntfs format. */
 	u8 minor_ver;		/* Minor version of the ntfs format. */
 	VOLUME_FLAGS flags;	/* Bit array of VOLUME_* flags. */
@@ -1853,12 +1866,12 @@
  * start of the index root or index allocation structures themselves.
  */
 typedef struct {
-	u32 entries_offset;		/* Byte offset to first INDEX_ENTRY
+	le32 entries_offset;		/* Byte offset to first INDEX_ENTRY
 					   aligned to 8-byte boundary. */
-	u32 index_length;		/* Data size of the index in bytes,
+	le32 index_length;		/* Data size of the index in bytes,
 					   i.e. bytes used from allocated
 					   size, aligned to 8-byte boundary. */
-	u32 allocated_size;		/* Byte size of this index (block),
+	le32 allocated_size;		/* Byte size of this index (block),
 					   multiple of 8 bytes. */
 	/* NOTE: For the index root attribute, the above two numbers are always
 	   equal, as the attribute is resident and it is resized as needed. In
@@ -1898,7 +1911,7 @@
 	COLLATION_RULES collation_rule;	/* Collation rule used to sort the
 					   index entries. If type is $FILE_NAME,
 					   this must be COLLATION_FILE_NAME. */
-	u32 index_block_size;		/* Size of each index block in bytes (in
+	le32 index_block_size;		/* Size of each index block in bytes (in
 					   the index allocation attribute). */
 	u8 clusters_per_index_block;	/* Cluster size of each index block (in
 					   the index allocation attribute), when
@@ -1925,12 +1938,12 @@
 typedef struct {
 /*  0	NTFS_RECORD; -- Unfolded here as gcc doesn't like unnamed structs. */
 	NTFS_RECORD_TYPES magic;/* Magic is "INDX". */
-	u16 usa_ofs;		/* See NTFS_RECORD definition. */
-	u16 usa_count;		/* See NTFS_RECORD definition. */
+	le16 usa_ofs;		/* See NTFS_RECORD definition. */
+	le16 usa_count;		/* See NTFS_RECORD definition. */
 
-/*  8*/	s64 lsn;		/* $LogFile sequence number of the last
+/*  8*/	sle64 lsn;		/* $LogFile sequence number of the last
 				   modification of this index block. */
-/* 16*/	VCN index_block_vcn;	/* Virtual cluster number of the index block.
+/* 16*/	leVCN index_block_vcn;	/* Virtual cluster number of the index block.
 				   If the cluster_size on the volume is <= the
 				   index_block_size of the directory,
 				   index_block_vcn counts in units of clusters,
@@ -1960,8 +1973,8 @@
  * primary key / is not a key at all. (AIA)
  */
 typedef struct {
-	u32 reparse_tag;	/* Reparse point type (inc. flags). */
-	MFT_REF file_id;	/* Mft record of the file containing the
+	le32 reparse_tag;	/* Reparse point type (inc. flags). */
+	leMFT_REF file_id;	/* Mft record of the file containing the
 				   reparse point attribute. */
 } __attribute__ ((__packed__)) REPARSE_INDEX_KEY;
 
@@ -2011,13 +2024,13 @@
  * The $Q index entry data is the quota control entry and is defined below.
  */
 typedef struct {
-	u32 version;		/* Currently equals 2. */
+	le32 version;		/* Currently equals 2. */
 	QUOTA_FLAGS flags;	/* Flags describing this quota entry. */
-	u64 bytes_used;		/* How many bytes of the quota are in use. */
-	s64 change_time;	/* Last time this quota entry was changed. */
-	s64 threshold;		/* Soft quota (-1 if not limited). */
-	s64 limit;		/* Hard quota (-1 if not limited). */
-	s64 exceeded_time;	/* How long the soft quota has been exceeded. */
+	le64 bytes_used;	/* How many bytes of the quota are in use. */
+	sle64 change_time;	/* Last time this quota entry was changed. */
+	sle64 threshold;	/* Soft quota (-1 if not limited). */
+	sle64 limit;		/* Hard quota (-1 if not limited). */
+	sle64 exceeded_time;	/* How long the soft quota has been exceeded. */
 	SID sid;		/* The SID of the user/object associated with
 				   this quota entry.  Equals zero for the quota
 				   defaults entry (and in fact on a WinXP
@@ -2063,26 +2076,26 @@
 typedef struct {
 /*  0*/	union {
 		struct { /* Only valid when INDEX_ENTRY_END is not set. */
-			MFT_REF indexed_file;	/* The mft reference of the file
+			leMFT_REF indexed_file;	/* The mft reference of the file
 						   described by this index
 						   entry. Used for directory
 						   indexes. */
 		} __attribute__ ((__packed__)) dir;
 		struct { /* Used for views/indexes to find the entry's data. */
-			u16 data_offset;	/* Data byte offset from this
+			le16 data_offset;	/* Data byte offset from this
 						   INDEX_ENTRY. Follows the
 						   index key. */
-			u16 data_length;	/* Data length in bytes. */
-			u32 reservedV;		/* Reserved (zero). */
+			le16 data_length;	/* Data length in bytes. */
+			le32 reservedV;		/* Reserved (zero). */
 		} __attribute__ ((__packed__)) vi;
 	} __attribute__ ((__packed__)) data;
-/*  8*/	u16 length;		 /* Byte size of this index entry, multiple of
+/*  8*/	le16 length;		 /* Byte size of this index entry, multiple of
 				    8-bytes. */
-/* 10*/	u16 key_length;		 /* Byte size of the key value, which is in the
+/* 10*/	le16 key_length;	 /* Byte size of the key value, which is in the
 				    index entry. It follows field reserved. Not
 				    multiple of 8-bytes. */
 /* 12*/	INDEX_ENTRY_FLAGS flags; /* Bit field of INDEX_ENTRY_* flags. */
-/* 14*/	u16 reserved;		 /* Reserved/align to 8-byte boundary. */
+/* 14*/	le16 reserved;		 /* Reserved/align to 8-byte boundary. */
 /* sizeof() = 16 bytes */
 } __attribute__ ((__packed__)) INDEX_ENTRY_HEADER;
 
@@ -2098,26 +2111,26 @@
 /*  0	INDEX_ENTRY_HEADER; -- Unfolded here as gcc dislikes unnamed structs. */
 	union {
 		struct { /* Only valid when INDEX_ENTRY_END is not set. */
-			MFT_REF indexed_file;	/* The mft reference of the file
+			leMFT_REF indexed_file;	/* The mft reference of the file
 						   described by this index
 						   entry. Used for directory
 						   indexes. */
 		} __attribute__ ((__packed__)) dir;
 		struct { /* Used for views/indexes to find the entry's data. */
-			u16 data_offset;	/* Data byte offset from this
+			le16 data_offset;	/* Data byte offset from this
 						   INDEX_ENTRY. Follows the
 						   index key. */
-			u16 data_length;	/* Data length in bytes. */
-			u32 reservedV;		/* Reserved (zero). */
+			le16 data_length;	/* Data length in bytes. */
+			le32 reservedV;		/* Reserved (zero). */
 		} __attribute__ ((__packed__)) vi;
 	} __attribute__ ((__packed__)) data;
-	u16 length;		 /* Byte size of this index entry, multiple of
+	le16 length;		 /* Byte size of this index entry, multiple of
 				    8-bytes. */
-	u16 key_length;		 /* Byte size of the key value, which is in the
+	le16 key_length;	 /* Byte size of the key value, which is in the
 				    index entry. It follows field reserved. Not
 				    multiple of 8-bytes. */
 	INDEX_ENTRY_FLAGS flags; /* Bit field of INDEX_ENTRY_* flags. */
-	u16 reserved;		 /* Reserved/align to 8-byte boundary. */
+	le16 reserved;		 /* Reserved/align to 8-byte boundary. */
 
 /* 16*/	union {		/* The key of the indexed attribute. NOTE: Only present
 			   if INDEX_ENTRY_END bit in flags is not set. NOTE: On
@@ -2134,13 +2147,13 @@
 						   FILE_Extend/$Reparse. */
 		SID sid;		/* $O index in FILE_Extend/$Quota:
 					   SID of the owner of the user_id. */
-		u32 owner_id;		/* $Q index in FILE_Extend/$Quota:
+		le32 owner_id;		/* $Q index in FILE_Extend/$Quota:
 					   user_id of the owner of the quota
 					   control entry in the data part of
 					   the index. */
 	} __attribute__ ((__packed__)) key;
 	/* The (optional) index data is inserted here when creating. */
-	// VCN vcn;	/* If INDEX_ENTRY_NODE bit in flags is set, the last
+	// leVCN vcn;	/* If INDEX_ENTRY_NODE bit in flags is set, the last
 	//		   eight bytes of this index entry contain the virtual
 	//		   cluster number of the index block that holds the
 	//		   entries immediately preceding the current entry (the
@@ -2215,9 +2228,9 @@
  * NOTE: Can be resident or non-resident.
  */
 typedef struct {
-	u32 reparse_tag;		/* Reparse point type (inc. flags). */
-	u16 reparse_data_length;	/* Byte size of reparse data. */
-	u16 reserved;			/* Align to 8-byte boundary. */
+	le32 reparse_tag;		/* Reparse point type (inc. flags). */
+	le16 reparse_data_length;	/* Byte size of reparse data. */
+	le16 reserved;			/* Align to 8-byte boundary. */
 	u8 reparse_data[0];		/* Meaning depends on reparse_tag. */
 } __attribute__ ((__packed__)) REPARSE_POINT;
 
@@ -2227,11 +2240,11 @@
  * NOTE: Always resident. (Is this true???)
  */
 typedef struct {
-	u16 ea_length;		/* Byte size of the packed extended
+	le16 ea_length;		/* Byte size of the packed extended
 				   attributes. */
-	u16 need_ea_count;	/* The number of extended attributes which have
+	le16 need_ea_count;	/* The number of extended attributes which have
 				   the NEED_EA bit set. */
-	u32 ea_query_length;	/* Byte size of the buffer required to query
+	le32 ea_query_length;	/* Byte size of the buffer required to query
 				   the extended attributes when calling
 				   ZwQueryEaFile() in Windows NT/2k. I.e. the
 				   byte size of the unpacked extended
@@ -2256,10 +2269,10 @@
  * FIXME: It appears weird that the EA name is not unicode. Is it true?
  */
 typedef struct {
-	u32 next_entry_offset;	/* Offset to the next EA_ATTR. */
+	le32 next_entry_offset;	/* Offset to the next EA_ATTR. */
 	EA_FLAGS flags;		/* Flags describing the EA. */
 	u8 ea_name_length;	/* Length of the name of the EA in bytes. */
-	u16 ea_value_length;	/* Byte size of the EA's value. */
+	le16 ea_value_length;	/* Byte size of the EA's value. */
 	u8 ea_name[0];		/* Name of the EA. */
 	u8 ea_value[0];		/* The value of the EA. Immediately follows
 				   the name. */
diff -Nru a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
--- a/fs/ntfs/logfile.c	2004-09-24 17:06:23 +01:00
+++ b/fs/ntfs/logfile.c	2004-09-24 17:06:23 +01:00
@@ -497,7 +497,7 @@
 		 * empty block after a non-empty block has been encountered
 		 * means we are done.
 		 */
-		if (!ntfs_is_empty_recordp(kaddr))
+		if (!ntfs_is_empty_recordp((le32*)kaddr))
 			logfile_is_empty = FALSE;
 		else if (!logfile_is_empty)
 			break;
@@ -505,20 +505,20 @@
 		 * A log record page means there cannot be a restart page after
 		 * this so no need to continue searching.
 		 */
-		if (ntfs_is_rcrd_recordp(kaddr))
+		if (ntfs_is_rcrd_recordp((le32*)kaddr))
 			break;
 		/*
 		 * A modified by chkdsk restart page means we cannot handle
 		 * this log file.
 		 */
-		if (ntfs_is_chkd_recordp(kaddr)) {
+		if (ntfs_is_chkd_recordp((le32*)kaddr)) {
 			ntfs_error(vol->sb, "$LogFile has been modified by "
 					"chkdsk.  Mount this volume in "
 					"Windows.");
 			goto err_out;
 		}
 		/* If not a restart page, continue. */
-		if (!ntfs_is_rstr_recordp(kaddr)) {
+		if (!ntfs_is_rstr_recordp((le32*)kaddr)) {
 			/* Skip to the minimum page size for the next one. */
 			if (!pos)
 				pos = NTFS_BLOCK_SIZE >> 1;
diff -Nru a/fs/ntfs/logfile.h b/fs/ntfs/logfile.h
--- a/fs/ntfs/logfile.h	2004-09-24 17:06:23 +01:00
+++ b/fs/ntfs/logfile.h	2004-09-24 17:06:23 +01:00
@@ -68,33 +68,33 @@
 /*Ofs*/
 /*  0	NTFS_RECORD; -- Unfolded here as gcc doesn't like unnamed structs. */
 /*  0*/	NTFS_RECORD_TYPES magic;/* The magic is "RSTR". */
-/*  4*/	u16 usa_ofs;		/* See NTFS_RECORD definition in layout.h.
+/*  4*/	le16 usa_ofs;		/* See NTFS_RECORD definition in layout.h.
 				   When creating, set this to be immediately
 				   after this header structure (without any
 				   alignment). */
-/*  6*/	u16 usa_count;		/* See NTFS_RECORD definition in layout.h. */
+/*  6*/	le16 usa_count;		/* See NTFS_RECORD definition in layout.h. */
 
-/*  8*/	LSN chkdsk_lsn;		/* The last log file sequence number found by
+/*  8*/	leLSN chkdsk_lsn;	/* The last log file sequence number found by
 				   chkdsk.  Only used when the magic is changed
 				   to "CHKD".  Otherwise this is zero. */
-/* 16*/	u32 system_page_size;	/* Byte size of system pages when the log file
+/* 16*/	le32 system_page_size;	/* Byte size of system pages when the log file
 				   was created, has to be >= 512 and a power of
 				   2.  Use this to calculate the required size
 				   of the usa (usa_count) and add it to usa_ofs.
 				   Then verify that the result is less than the
 				   value of the restart_area_offset. */
-/* 20*/	u32 log_page_size;	/* Byte size of log file pages, has to be >=
+/* 20*/	le32 log_page_size;	/* Byte size of log file pages, has to be >=
 				   512 and a power of 2.  The default is 4096
 				   and is used when the system page size is
 				   between 4096 and 8192.  Otherwise this is
 				   set to the system page size instead. */
-/* 24*/	u16 restart_area_offset;/* Byte offset from the start of this header to
+/* 24*/	le16 restart_area_offset;/* Byte offset from the start of this header to
 				   the RESTART_AREA.  Value has to be aligned
 				   to 8-byte boundary.  When creating, set this
 				   to be after the usa. */
-/* 26*/	s16 minor_ver;		/* Log file minor version.  Only check if major
+/* 26*/	sle16 minor_ver;	/* Log file minor version.  Only check if major
 				   version is 1. */
-/* 28*/	s16 major_ver;		/* Log file major version.  We only support
+/* 28*/	sle16 major_ver;	/* Log file major version.  We only support
 				   version 1.1. */
 /* sizeof() = 30 (0x1e) bytes */
 } __attribute__ ((__packed__)) RESTART_PAGE_HEADER;
@@ -123,16 +123,16 @@
  */
 typedef struct {
 /*Ofs*/
-/*  0*/	LSN current_lsn;	/* The current, i.e. last LSN inside the log
+/*  0*/	leLSN current_lsn;	/* The current, i.e. last LSN inside the log
 				   when the restart area was last written.
 				   This happens often but what is the interval?
 				   Is it just fixed time or is it every time a
 				   check point is written or somethine else?
 				   On create set to 0. */
-/*  8*/	u16 log_clients;	/* Number of log client records in the array of
+/*  8*/	le16 log_clients;	/* Number of log client records in the array of
 				   log client records which follows this
 				   restart area.  Must be 1.  */
-/* 10*/	u16 client_free_list;	/* The index of the first free log client record
+/* 10*/	le16 client_free_list;	/* The index of the first free log client record
 				   in the array of log client records.
 				   LOGFILE_NO_CLIENT means that there are no
 				   free log client records in the array.
@@ -148,7 +148,7 @@
 				   and presumably later, the logfile is always
 				   open, even on clean shutdown so this should
 				   always be LOGFILE_NO_CLIENT. */
-/* 12*/	u16 client_in_use_list;	/* The index of the first in-use log client
+/* 12*/	le16 client_in_use_list;/* The index of the first in-use log client
 				   record in the array of log client records.
 				   LOGFILE_NO_CLIENT means that there are no
 				   in-use log client records in the array.  If
@@ -181,13 +181,13 @@
 				   clean.  If on the other hand the logfile is
 				   open and this bit is clear, we can be almost
 				   certain that the logfile is dirty. */
-/* 16*/	u32 seq_number_bits;	/* How many bits to use for the sequence
+/* 16*/	le32 seq_number_bits;	/* How many bits to use for the sequence
 				   number.  This is calculated as 67 - the
 				   number of bits required to store the logfile
 				   size in bytes and this can be used in with
 				   the specified file_size as a consistency
 				   check. */
-/* 20*/	u16 restart_area_length;/* Length of the restart area including the
+/* 20*/	le16 restart_area_length;/* Length of the restart area including the
 				   client array.  Following checks required if
 				   version matches.  Otherwise, skip them.
 				   restart_area_offset + restart_area_length
@@ -195,7 +195,7 @@
 				   restart_area_length has to be >=
 				   client_array_offset + (log_clients *
 				   sizeof(log client record)). */
-/* 22*/	u16 client_array_offset;/* Offset from the start of this record to
+/* 22*/	le16 client_array_offset;/* Offset from the start of this record to
 				   the first log client record if versions are
 				   matched.  When creating, set this to be
 				   after this restart area structure, aligned
@@ -217,7 +217,7 @@
 				   the client array.  This probably means that
 				   the RESTART_AREA record is actually bigger
 				   in WinXP and later. */
-/* 24*/	s64 file_size;		/* Usable byte size of the log file.  If the
+/* 24*/	sle64 file_size;	/* Usable byte size of the log file.  If the
 				   restart_area_offset + the offset of the
 				   file_size are > 510 then corruption has
 				   occured.  This is the very first check when
@@ -230,28 +230,28 @@
 				   then it has to be at least big enough to
 				   store the two restart pages and 48 (0x30)
 				   log record pages. */
-/* 32*/	u32 last_lsn_data_length;/* Length of data of last LSN, not including
+/* 32*/	le32 last_lsn_data_length;/* Length of data of last LSN, not including
 				   the log record header.  On create set to
 				   0. */
-/* 36*/	u16 log_record_header_length;/* Byte size of the log record header.  If
-				   the version matches then check that the
+/* 36*/	le16 log_record_header_length;/* Byte size of the log record header.
+				   If the version matches then check that the
 				   value of log_record_header_length is a
 				   multiple of 8, i.e.
 				   (log_record_header_length + 7) & ~7 ==
 				   log_record_header_length.  When creating set
 				   it to sizeof(LOG_RECORD_HEADER), aligned to
 				   8 bytes. */
-/* 38*/	u16 log_page_data_offset;/* Offset to the start of data in a log record
+/* 38*/	le16 log_page_data_offset;/* Offset to the start of data in a log record
 				   page.  Must be a multiple of 8.  On create
 				   set it to immediately after the update
 				   sequence array of the log record page. */
-/* 40*/	u32 restart_log_open_count;/* A counter that gets incremented every time
-				   the logfile is restarted which happens at
-				   mount time when the logfile is opened.  When
-				   creating set to a random value.  Win2k sets
-				   it to the low 32 bits of the current system
-				   time in NTFS format (see time.h). */
-/* 44*/	u32 reserved;		/* Reserved/alignment to 8-byte boundary. */
+/* 40*/	le32 restart_log_open_count;/* A counter that gets incremented every
+				   time the logfile is restarted which happens
+				   at mount time when the logfile is opened.
+				   When creating set to a random value.  Win2k
+				   sets it to the low 32 bits of the current
+				   system time in NTFS format (see time.h). */
+/* 44*/	le32 reserved;		/* Reserved/alignment to 8-byte boundary. */
 /* sizeof() = 48 (0x30) bytes */
 } __attribute__ ((__packed__)) RESTART_AREA;
 
@@ -261,32 +261,32 @@
  */
 typedef struct {
 /*Ofs*/
-/*  0*/	LSN oldest_lsn;		/* Oldest LSN needed by this client.  On create
+/*  0*/	leLSN oldest_lsn;	/* Oldest LSN needed by this client.  On create
 				   set to 0. */
-/*  8*/	LSN client_restart_lsn;	/* LSN at which this client needs to restart
+/*  8*/	leLSN client_restart_lsn;/* LSN at which this client needs to restart
 				   the volume, i.e. the current position within
 				   the log file.  At present, if clean this
 				   should = current_lsn in restart area but it
 				   probably also = current_lsn when dirty most
 				   of the time.  At create set to 0. */
-/* 16*/	u16 prev_client;	/* The offset to the previous log client record
+/* 16*/	le16 prev_client;	/* The offset to the previous log client record
 				   in the array of log client records.
 				   LOGFILE_NO_CLIENT means there is no previous
 				   client record, i.e. this is the first one.
 				   This is always LOGFILE_NO_CLIENT. */
-/* 18*/	u16 next_client;	/* The offset to the next log client record in
+/* 18*/	le16 next_client;	/* The offset to the next log client record in
 				   the array of log client records.
 				   LOGFILE_NO_CLIENT means there are no next
 				   client records, i.e. this is the last one.
 				   This is always LOGFILE_NO_CLIENT. */
-/* 20*/	u16 seq_number;		/* On Win2k and presumably earlier, this is set
+/* 20*/	le16 seq_number;	/* On Win2k and presumably earlier, this is set
 				   to zero every time the logfile is restarted
 				   and it is incremented when the logfile is
 				   closed at dismount time.  Thus it is 0 when
 				   dirty and 1 when clean.  On WinXP and
 				   presumably later, this is always 0. */
 /* 22*/	u8 reserved[6];		/* Reserved/alignment. */
-/* 28*/	u32 client_name_length; /* Length of client name in bytes.  Should
+/* 28*/	le32 client_name_length;/* Length of client name in bytes.  Should
 				   always be 8. */
 /* 32*/	ntfschar client_name[64];/* Name of the client in Unicode.  Should
 				   always be "NTFS" with the remaining bytes
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-09-24 17:06:23 +01:00
+++ b/fs/ntfs/mft.c	2004-09-24 17:06:23 +01:00
@@ -980,7 +980,7 @@
 		ntfs_debug("Inode 0x%lx is not in icache.", mft_no);
 		/* The inode is not in icache. */
 		/* Skip the record if it is not a mft record (type "FILE"). */
-		if (!ntfs_is_mft_recordp(maddr)) {
+		if (!ntfs_is_mft_recordp((le32*)maddr)) {
 			ntfs_debug("Mft record 0x%lx is not a FILE record, "
 					"continuing search.", mft_no);
 			continue;
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-09-24 17:06:23 +01:00
+++ b/fs/ntfs/super.c	2004-09-24 17:06:23 +01:00
@@ -511,8 +511,10 @@
 	 * field. If checksum is zero, no checking is done.
 	 */
 	if ((void*)b < (void*)&b->checksum && b->checksum) {
-		u32 i, *u;
-		for (i = 0, u = (u32*)b; u < (u32*)(&b->checksum); ++u)
+		le32 *u;
+		u32 i;
+
+		for (i = 0, u = (le32*)b; u < (le32*)(&b->checksum); ++u)
 			i += le32_to_cpup(u);
 		if (le32_to_cpu(b->checksum) != i)
 			goto not_ntfs;
@@ -521,7 +523,7 @@
 	if (b->oem_id != magicNTFS)
 		goto not_ntfs;
 	/* Check bytes per sector value is between 256 and 4096. */
-	if (le16_to_cpu(b->bpb.bytes_per_sector) <  0x100 ||
+	if (le16_to_cpu(b->bpb.bytes_per_sector) < 0x100 ||
 			le16_to_cpu(b->bpb.bytes_per_sector) > 0x1000)
 		goto not_ntfs;
 	/* Check sectors per cluster value is valid. */
@@ -1003,7 +1005,7 @@
 			++index;
 		}
 		/* Make sure the record is ok. */
-		if (ntfs_is_baad_recordp(kmft)) {
+		if (ntfs_is_baad_recordp((le32*)kmft)) {
 			ntfs_error(sb, "Incomplete multi sector transfer "
 					"detected in mft record %i.", i);
 mm_unmap_out:
@@ -1012,7 +1014,7 @@
 			ntfs_unmap_page(mft_page);
 			return FALSE;
 		}
-		if (ntfs_is_baad_recordp(kmirr)) {
+		if (ntfs_is_baad_recordp((le32*)kmirr)) {
 			ntfs_error(sb, "Incomplete multi sector transfer "
 					"detected in mft mirror record %i.", i);
 			goto mm_unmap_out;
diff -Nru a/fs/ntfs/time.h b/fs/ntfs/time.h
--- a/fs/ntfs/time.h	2004-09-24 17:06:23 +01:00
+++ b/fs/ntfs/time.h	2004-09-24 17:06:23 +01:00
@@ -45,7 +45,7 @@
  * measured as the number of 100-nano-second intervals since 1st January 1601,
  * 00:00:00 UTC.
  */
-static inline s64 utc2ntfs(const struct timespec ts)
+static inline sle64 utc2ntfs(const struct timespec ts)
 {
 	/*
 	 * Convert the seconds to 100ns intervals, add the nano-seconds
@@ -61,7 +61,7 @@
  * Get the current time from the Linux kernel, convert it to its corresponding
  * NTFS time and return that in little endian format.
  */
-static inline s64 get_current_ntfs_time(void)
+static inline sle64 get_current_ntfs_time(void)
 {
 	return utc2ntfs(current_kernel_time());
 }
@@ -82,7 +82,7 @@
  * measured as the number of 100 nano-second intervals since 1st January 1601,
  * 00:00:00 UTC.
  */
-static inline struct timespec ntfs2utc(const s64 time)
+static inline struct timespec ntfs2utc(const sle64 time)
 {
 	struct timespec ts;
 
