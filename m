Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWHZX3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWHZX3V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 19:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWHZX3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 19:29:21 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:33710 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751244AbWHZX3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 19:29:20 -0400
Message-ID: <44F0DAEF.9040403@student.ltu.se>
Date: Sun, 27 Aug 2006 01:36:15 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc4-mm2] fs/partitions: Conversion to generic boolean
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Conversion of booleans to: generic-boolean.patch (2006-08-23)

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

Compile-tested


 ldm.c |  267 ++++++++++++++++++++++++++++++++----------------------------------
 1 files changed, 131 insertions(+), 136 deletions(-)


diff --git a/fs/partitions/ldm.c b/fs/partitions/ldm.c
index 7ab1c11..1a60926 100644
--- a/fs/partitions/ldm.c
+++ b/fs/partitions/ldm.c
@@ -30,11 +30,6 @@ #include "ldm.h"
 #include "check.h"
 #include "msdos.h"
 
-typedef enum {
-	FALSE = 0,
-	TRUE  = 1
-} BOOL;
-
 /**
  * ldm_debug/info/error/crit - Output an error message
  * @f:    A printf format string containing the message
@@ -103,24 +98,24 @@ static int ldm_parse_hexbyte (const u8 *
  *
  * N.B. The GUID need not be NULL terminated.
  *
- * Return:  TRUE   @dest contains binary GUID
- *          FALSE  @dest contents are undefined
+ * Return:  'true'   @dest contains binary GUID
+ *          'false'  @dest contents are undefined
  */
-static BOOL ldm_parse_guid (const u8 *src, u8 *dest)
+static bool ldm_parse_guid (const u8 *src, u8 *dest)
 {
 	static const int size[] = { 4, 2, 2, 2, 6 };
 	int i, j, v;
 
 	if (src[8]  != '-' || src[13] != '-' ||
 	    src[18] != '-' || src[23] != '-')
-		return FALSE;
+		return false;
 
 	for (j = 0; j < 5; j++, src++)
 		for (i = 0; i < size[j]; i++, src+=2, *dest++ = v)
 			if ((v = ldm_parse_hexbyte (src)) < 0)
-				return FALSE;
+				return false;
 
-	return TRUE;
+	return true;
 }
 
 
@@ -132,17 +127,17 @@ static BOOL ldm_parse_guid (const u8 *sr
  * This parses the LDM database PRIVHEAD structure supplied in @data and
  * sets up the in-memory privhead structure @ph with the obtained information.
  *
- * Return:  TRUE   @ph contains the PRIVHEAD data
- *          FALSE  @ph contents are undefined
+ * Return:  'true'   @ph contains the PRIVHEAD data
+ *          'false'  @ph contents are undefined
  */
-static BOOL ldm_parse_privhead (const u8 *data, struct privhead *ph)
+static bool ldm_parse_privhead (const u8 *data, struct privhead *ph)
 {
 	BUG_ON (!data || !ph);
 
 	if (MAGIC_PRIVHEAD != BE64 (data)) {
 		ldm_error ("Cannot find PRIVHEAD structure. LDM database is"
 			" corrupt. Aborting.");
-		return FALSE;
+		return false;
 	}
 
 	ph->ver_major          = BE16 (data + 0x000C);
@@ -155,7 +150,7 @@ static BOOL ldm_parse_privhead (const u8
 	if ((ph->ver_major != 2) || (ph->ver_minor != 11)) {
 		ldm_error ("Expected PRIVHEAD version %d.%d, got %d.%d."
 			" Aborting.", 2, 11, ph->ver_major, ph->ver_minor);
-		return FALSE;
+		return false;
 	}
 	if (ph->config_size != LDM_DB_SIZE) {	/* 1 MiB in sectors. */
 		/* Warn the user and continue, carefully */
@@ -166,16 +161,16 @@ static BOOL ldm_parse_privhead (const u8
 	if ((ph->logical_disk_size == 0) ||
 	    (ph->logical_disk_start + ph->logical_disk_size > ph->config_start)) {
 		ldm_error ("PRIVHEAD disk size doesn't match real disk size");
-		return FALSE;
+		return false;
 	}
 
 	if (!ldm_parse_guid (data + 0x0030, ph->disk_id)) {
 		ldm_error ("PRIVHEAD contains an invalid GUID.");
-		return FALSE;
+		return false;
 	}
 
 	ldm_debug ("Parsed PRIVHEAD successfully.");
-	return TRUE;
+	return true;
 }
 
 /**
@@ -189,16 +184,16 @@ static BOOL ldm_parse_privhead (const u8
  *
  * N.B.  The *_start and *_size values returned in @toc are not range-checked.
  *
- * Return:  TRUE   @toc contains the TOCBLOCK data
- *          FALSE  @toc contents are undefined
+ * Return:  'true'   @toc contains the TOCBLOCK data
+ *          'false'  @toc contents are undefined
  */
-static BOOL ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
+static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
 {
 	BUG_ON (!data || !toc);
 
 	if (MAGIC_TOCBLOCK != BE64 (data)) {
 		ldm_crit ("Cannot find TOCBLOCK, database may be corrupt.");
-		return FALSE;
+		return false;
 	}
 	strncpy (toc->bitmap1_name, data + 0x24, sizeof (toc->bitmap1_name));
 	toc->bitmap1_name[sizeof (toc->bitmap1_name) - 1] = 0;
@@ -209,7 +204,7 @@ static BOOL ldm_parse_tocblock (const u8
 			sizeof (toc->bitmap1_name)) != 0) {
 		ldm_crit ("TOCBLOCK's first bitmap is '%s', should be '%s'.",
 				TOC_BITMAP1, toc->bitmap1_name);
-		return FALSE;
+		return false;
 	}
 	strncpy (toc->bitmap2_name, data + 0x46, sizeof (toc->bitmap2_name));
 	toc->bitmap2_name[sizeof (toc->bitmap2_name) - 1] = 0;
@@ -219,10 +214,10 @@ static BOOL ldm_parse_tocblock (const u8
 			sizeof (toc->bitmap2_name)) != 0) {
 		ldm_crit ("TOCBLOCK's second bitmap is '%s', should be '%s'.",
 				TOC_BITMAP2, toc->bitmap2_name);
-		return FALSE;
+		return false;
 	}
 	ldm_debug ("Parsed TOCBLOCK successfully.");
-	return TRUE;
+	return true;
 }
 
 /**
@@ -235,16 +230,16 @@ static BOOL ldm_parse_tocblock (const u8
  *
  * N.B.  The *_start, *_size and *_seq values will be range-checked later.
  *
- * Return:  TRUE   @vm contains VMDB info
- *          FALSE  @vm contents are undefined
+ * Return:  'true'   @vm contains VMDB info
+ *          'false'  @vm contents are undefined
  */
-static BOOL ldm_parse_vmdb (const u8 *data, struct vmdb *vm)
+static bool ldm_parse_vmdb (const u8 *data, struct vmdb *vm)
 {
 	BUG_ON (!data || !vm);
 
 	if (MAGIC_VMDB != BE32 (data)) {
 		ldm_crit ("Cannot find the VMDB, database may be corrupt.");
-		return FALSE;
+		return false;
 	}
 
 	vm->ver_major = BE16 (data + 0x12);
@@ -252,7 +247,7 @@ static BOOL ldm_parse_vmdb (const u8 *da
 	if ((vm->ver_major != 4) || (vm->ver_minor != 10)) {
 		ldm_error ("Expected VMDB version %d.%d, got %d.%d. "
 			"Aborting.", 4, 10, vm->ver_major, vm->ver_minor);
-		return FALSE;
+		return false;
 	}
 
 	vm->vblk_size     = BE32 (data + 0x08);
@@ -260,7 +255,7 @@ static BOOL ldm_parse_vmdb (const u8 *da
 	vm->last_vblk_seq = BE32 (data + 0x04);
 
 	ldm_debug ("Parsed VMDB successfully.");
-	return TRUE;
+	return true;
 }
 
 /**
@@ -270,10 +265,10 @@ static BOOL ldm_parse_vmdb (const u8 *da
  *
  * This compares the two privhead structures @ph1 and @ph2.
  *
- * Return:  TRUE   Identical
- *          FALSE  Different
+ * Return:  'true'   Identical
+ *          'false'  Different
  */
-static BOOL ldm_compare_privheads (const struct privhead *ph1,
+static bool ldm_compare_privheads (const struct privhead *ph1,
 				   const struct privhead *ph2)
 {
 	BUG_ON (!ph1 || !ph2);
@@ -294,10 +289,10 @@ static BOOL ldm_compare_privheads (const
  *
  * This compares the two tocblock structures @toc1 and @toc2.
  *
- * Return:  TRUE   Identical
- *          FALSE  Different
+ * Return:  'true'   Identical
+ *          'false'  Different
  */
-static BOOL ldm_compare_tocblocks (const struct tocblock *toc1,
+static bool ldm_compare_tocblocks (const struct tocblock *toc1,
 				   const struct tocblock *toc2)
 {
 	BUG_ON (!toc1 || !toc2);
@@ -323,17 +318,17 @@ static BOOL ldm_compare_tocblocks (const
  * the configuration area (the database).  The values are range-checked against
  * @hd, which contains the real size of the disk.
  *
- * Return:  TRUE   Success
- *          FALSE  Error
+ * Return:  'true'   Success
+ *          'false'  Error
  */
-static BOOL ldm_validate_privheads (struct block_device *bdev,
+static bool ldm_validate_privheads (struct block_device *bdev,
 				    struct privhead *ph1)
 {
 	static const int off[3] = { OFF_PRIV1, OFF_PRIV2, OFF_PRIV3 };
 	struct privhead *ph[3] = { ph1 };
 	Sector sect;
 	u8 *data;
-	BOOL result = FALSE;
+	bool result = false;
 	long num_sects;
 	int i;
 
@@ -393,7 +388,7 @@ static BOOL ldm_validate_privheads (stru
 		goto out;
 	}*/
 	ldm_debug ("Validated PRIVHEADs successfully.");
-	result = TRUE;
+	result = true;
 out:
 	kfree (ph[1]);
 	kfree (ph[2]);
@@ -411,10 +406,10 @@ out:
  *
  * The offsets and sizes of the configs are range-checked against a privhead.
  *
- * Return:  TRUE   @toc1 contains validated TOCBLOCK info
- *          FALSE  @toc1 contents are undefined
+ * Return:  'true'   @toc1 contains validated TOCBLOCK info
+ *          'false'  @toc1 contents are undefined
  */
-static BOOL ldm_validate_tocblocks (struct block_device *bdev,
+static bool ldm_validate_tocblocks (struct block_device *bdev,
 	unsigned long base, struct ldmdb *ldb)
 {
 	static const int off[4] = { OFF_TOCB1, OFF_TOCB2, OFF_TOCB3, OFF_TOCB4};
@@ -422,7 +417,7 @@ static BOOL ldm_validate_tocblocks (stru
 	struct privhead *ph;
 	Sector sect;
 	u8 *data;
-	BOOL result = FALSE;
+	bool result = false;
 	int i;
 
 	BUG_ON (!bdev || !ldb);
@@ -465,7 +460,7 @@ static BOOL ldm_validate_tocblocks (stru
 	}
 
 	ldm_debug ("Validated TOCBLOCKs successfully.");
-	result = TRUE;
+	result = true;
 out:
 	kfree (tb[1]);
 	kfree (tb[2]);
@@ -482,15 +477,15 @@ out:
  * Find the vmdb of the LDM Database stored on @bdev and return the parsed
  * information in @ldb.
  *
- * Return:  TRUE   @ldb contains validated VBDB info
- *          FALSE  @ldb contents are undefined
+ * Return:  'true'   @ldb contains validated VBDB info
+ *          'false'  @ldb contents are undefined
  */
-static BOOL ldm_validate_vmdb (struct block_device *bdev, unsigned long base,
+static bool ldm_validate_vmdb (struct block_device *bdev, unsigned long base,
 			       struct ldmdb *ldb)
 {
 	Sector sect;
 	u8 *data;
-	BOOL result = FALSE;
+	bool result = false;
 	struct vmdb *vm;
 	struct tocblock *toc;
 
@@ -502,7 +497,7 @@ static BOOL ldm_validate_vmdb (struct bl
 	data = read_dev_sector (bdev, base + OFF_VMDB, &sect);
 	if (!data) {
 		ldm_crit ("Disk read failed.");
-		return FALSE;
+		return false;
 	}
 
 	if (!ldm_parse_vmdb (data, vm))
@@ -527,7 +522,7 @@ static BOOL ldm_validate_vmdb (struct bl
 		goto out;
 	}
 
-	result = TRUE;
+	result = true;
 out:
 	put_dev_sector (sect);
 	return result;
@@ -547,23 +542,23 @@ out:
  *       only likely to happen if the underlying device is strange.  If that IS
  *       the case we should return zero to let someone else try.
  *
- * Return:  TRUE   @bdev is a dynamic disk
- *          FALSE  @bdev is not a dynamic disk, or an error occurred
+ * Return:  'true'   @bdev is a dynamic disk
+ *          'false'  @bdev is not a dynamic disk, or an error occurred
  */
-static BOOL ldm_validate_partition_table (struct block_device *bdev)
+static bool ldm_validate_partition_table (struct block_device *bdev)
 {
 	Sector sect;
 	u8 *data;
 	struct partition *p;
 	int i;
-	BOOL result = FALSE;
+	bool result = false;
 
 	BUG_ON (!bdev);
 
 	data = read_dev_sector (bdev, 0, &sect);
 	if (!data) {
 		ldm_crit ("Disk read failed.");
-		return FALSE;
+		return false;
 	}
 
 	if (*(__le16*) (data + 0x01FE) != cpu_to_le16 (MSDOS_LABEL_MAGIC))
@@ -572,7 +567,7 @@ static BOOL ldm_validate_partition_table
 	p = (struct partition*)(data + 0x01BE);
 	for (i = 0; i < 4; i++, p++)
 		if (SYS_IND (p) == WIN2K_DYNAMIC_PARTITION) {
-			result = TRUE;
+			result = true;
 			break;
 		}
 
@@ -625,10 +620,10 @@ static struct vblk * ldm_get_disk_objid 
  * N.B.  This function creates the partitions in the order it finds partition
  *       objects in the linked list.
  *
- * Return:  TRUE   Partition created
- *          FALSE  Error, probably a range checking problem
+ * Return:  'true'   Partition created
+ *          'false'  Error, probably a range checking problem
  */
-static BOOL ldm_create_data_partitions (struct parsed_partitions *pp,
+static bool ldm_create_data_partitions (struct parsed_partitions *pp,
 					const struct ldmdb *ldb)
 {
 	struct list_head *item;
@@ -642,7 +637,7 @@ static BOOL ldm_create_data_partitions (
 	disk = ldm_get_disk_objid (ldb);
 	if (!disk) {
 		ldm_crit ("Can't find the ID of this disk in the database.");
-		return FALSE;
+		return false;
 	}
 
 	printk (" [LDM]");
@@ -661,7 +656,7 @@ static BOOL ldm_create_data_partitions (
 	}
 
 	printk ("\n");
-	return TRUE;
+	return true;
 }
 
 
@@ -766,10 +761,10 @@ static int ldm_get_vstr (const u8 *block
  *
  * Read a raw VBLK Component object (version 3) into a vblk structure.
  *
- * Return:  TRUE   @vb contains a Component VBLK
- *          FALSE  @vb contents are not defined
+ * Return:  'true'   @vb contains a Component VBLK
+ *          'false'  @vb contents are not defined
  */
-static BOOL ldm_parse_cmp3 (const u8 *buffer, int buflen, struct vblk *vb)
+static bool ldm_parse_cmp3 (const u8 *buffer, int buflen, struct vblk *vb)
 {
 	int r_objid, r_name, r_vstate, r_child, r_parent, r_stripe, r_cols, len;
 	struct vblk_comp *comp;
@@ -792,11 +787,11 @@ static BOOL ldm_parse_cmp3 (const u8 *bu
 		len = r_parent;
 	}
 	if (len < 0)
-		return FALSE;
+		return false;
 
 	len += VBLK_SIZE_CMP3;
 	if (len != BE32 (buffer + 0x14))
-		return FALSE;
+		return false;
 
 	comp = &vb->vblk.comp;
 	ldm_get_vstr (buffer + 0x18 + r_name, comp->state,
@@ -806,7 +801,7 @@ static BOOL ldm_parse_cmp3 (const u8 *bu
 	comp->parent_id = ldm_get_vnum (buffer + 0x2D + r_child);
 	comp->chunksize = r_stripe ? ldm_get_vnum (buffer+r_parent+0x2E) : 0;
 
-	return TRUE;
+	return true;
 }
 
 /**
@@ -817,8 +812,8 @@ static BOOL ldm_parse_cmp3 (const u8 *bu
  *
  * Read a raw VBLK Disk Group object (version 3) into a vblk structure.
  *
- * Return:  TRUE   @vb contains a Disk Group VBLK
- *          FALSE  @vb contents are not defined
+ * Return:  'true'   @vb contains a Disk Group VBLK
+ *          'false'  @vb contents are not defined
  */
 static int ldm_parse_dgr3 (const u8 *buffer, int buflen, struct vblk *vb)
 {
@@ -841,16 +836,16 @@ static int ldm_parse_dgr3 (const u8 *buf
 		len = r_diskid;
 	}
 	if (len < 0)
-		return FALSE;
+		return false;
 
 	len += VBLK_SIZE_DGR3;
 	if (len != BE32 (buffer + 0x14))
-		return FALSE;
+		return false;
 
 	dgrp = &vb->vblk.dgrp;
 	ldm_get_vstr (buffer + 0x18 + r_name, dgrp->disk_id,
 		sizeof (dgrp->disk_id));
-	return TRUE;
+	return true;
 }
 
 /**
@@ -861,10 +856,10 @@ static int ldm_parse_dgr3 (const u8 *buf
  *
  * Read a raw VBLK Disk Group object (version 4) into a vblk structure.
  *
- * Return:  TRUE   @vb contains a Disk Group VBLK
- *          FALSE  @vb contents are not defined
+ * Return:  'true'   @vb contains a Disk Group VBLK
+ *          'false'  @vb contents are not defined
  */
-static BOOL ldm_parse_dgr4 (const u8 *buffer, int buflen, struct vblk *vb)
+static bool ldm_parse_dgr4 (const u8 *buffer, int buflen, struct vblk *vb)
 {
 	char buf[64];
 	int r_objid, r_name, r_id1, r_id2, len;
@@ -885,16 +880,16 @@ static BOOL ldm_parse_dgr4 (const u8 *bu
 		len = r_name;
 	}
 	if (len < 0)
-		return FALSE;
+		return false;
 
 	len += VBLK_SIZE_DGR4;
 	if (len != BE32 (buffer + 0x14))
-		return FALSE;
+		return false;
 
 	dgrp = &vb->vblk.dgrp;
 
 	ldm_get_vstr (buffer + 0x18 + r_objid, buf, sizeof (buf));
-	return TRUE;
+	return true;
 }
 
 /**
@@ -905,10 +900,10 @@ static BOOL ldm_parse_dgr4 (const u8 *bu
  *
  * Read a raw VBLK Disk object (version 3) into a vblk structure.
  *
- * Return:  TRUE   @vb contains a Disk VBLK
- *          FALSE  @vb contents are not defined
+ * Return:  'true'   @vb contains a Disk VBLK
+ *          'false'  @vb contents are not defined
  */
-static BOOL ldm_parse_dsk3 (const u8 *buffer, int buflen, struct vblk *vb)
+static bool ldm_parse_dsk3 (const u8 *buffer, int buflen, struct vblk *vb)
 {
 	int r_objid, r_name, r_diskid, r_altname, len;
 	struct vblk_disk *disk;
@@ -921,19 +916,19 @@ static BOOL ldm_parse_dsk3 (const u8 *bu
 	r_altname = ldm_relative (buffer, buflen, 0x18, r_diskid);
 	len = r_altname;
 	if (len < 0)
-		return FALSE;
+		return false;
 
 	len += VBLK_SIZE_DSK3;
 	if (len != BE32 (buffer + 0x14))
-		return FALSE;
+		return false;
 
 	disk = &vb->vblk.disk;
 	ldm_get_vstr (buffer + 0x18 + r_diskid, disk->alt_name,
 		sizeof (disk->alt_name));
 	if (!ldm_parse_guid (buffer + 0x19 + r_name, disk->disk_id))
-		return FALSE;
+		return false;
 
-	return TRUE;
+	return true;
 }
 
 /**
@@ -944,10 +939,10 @@ static BOOL ldm_parse_dsk3 (const u8 *bu
  *
  * Read a raw VBLK Disk object (version 4) into a vblk structure.
  *
- * Return:  TRUE   @vb contains a Disk VBLK
- *          FALSE  @vb contents are not defined
+ * Return:  'true'   @vb contains a Disk VBLK
+ *          'false'  @vb contents are not defined
  */
-static BOOL ldm_parse_dsk4 (const u8 *buffer, int buflen, struct vblk *vb)
+static bool ldm_parse_dsk4 (const u8 *buffer, int buflen, struct vblk *vb)
 {
 	int r_objid, r_name, len;
 	struct vblk_disk *disk;
@@ -958,15 +953,15 @@ static BOOL ldm_parse_dsk4 (const u8 *bu
 	r_name  = ldm_relative (buffer, buflen, 0x18, r_objid);
 	len     = r_name;
 	if (len < 0)
-		return FALSE;
+		return false;
 
 	len += VBLK_SIZE_DSK4;
 	if (len != BE32 (buffer + 0x14))
-		return FALSE;
+		return false;
 
 	disk = &vb->vblk.disk;
 	memcpy (disk->disk_id, buffer + 0x18 + r_name, GUID_SIZE);
-	return TRUE;
+	return true;
 }
 
 /**
@@ -977,10 +972,10 @@ static BOOL ldm_parse_dsk4 (const u8 *bu
  *
  * Read a raw VBLK Partition object (version 3) into a vblk structure.
  *
- * Return:  TRUE   @vb contains a Partition VBLK
- *          FALSE  @vb contents are not defined
+ * Return:  'true'   @vb contains a Partition VBLK
+ *          'false'  @vb contents are not defined
  */
-static BOOL ldm_parse_prt3 (const u8 *buffer, int buflen, struct vblk *vb)
+static bool ldm_parse_prt3 (const u8 *buffer, int buflen, struct vblk *vb)
 {
 	int r_objid, r_name, r_size, r_parent, r_diskid, r_index, len;
 	struct vblk_part *part;
@@ -1001,11 +996,11 @@ static BOOL ldm_parse_prt3 (const u8 *bu
 		len = r_diskid;
 	}
 	if (len < 0)
-		return FALSE;
+		return false;
 
 	len += VBLK_SIZE_PRT3;
 	if (len != BE32 (buffer + 0x14))
-		return FALSE;
+		return false;
 
 	part = &vb->vblk.part;
 	part->start         = BE64         (buffer + 0x24 + r_name);
@@ -1018,7 +1013,7 @@ static BOOL ldm_parse_prt3 (const u8 *bu
 	else
 		part->partnum = 0;
 
-	return TRUE;
+	return true;
 }
 
 /**
@@ -1029,10 +1024,10 @@ static BOOL ldm_parse_prt3 (const u8 *bu
  *
  * Read a raw VBLK Volume object (version 5) into a vblk structure.
  *
- * Return:  TRUE   @vb contains a Volume VBLK
- *          FALSE  @vb contents are not defined
+ * Return:  'true'   @vb contains a Volume VBLK
+ *          'false'  @vb contents are not defined
  */
-static BOOL ldm_parse_vol5 (const u8 *buffer, int buflen, struct vblk *vb)
+static bool ldm_parse_vol5 (const u8 *buffer, int buflen, struct vblk *vb)
 {
 	int r_objid, r_name, r_vtype, r_child, r_size, r_id1, r_id2, r_size2;
 	int r_drive, len;
@@ -1068,11 +1063,11 @@ static BOOL ldm_parse_vol5 (const u8 *bu
 
 	len = r_drive;
 	if (len < 0)
-		return FALSE;
+		return false;
 
 	len += VBLK_SIZE_VOL5;
 	if (len != BE32 (buffer + 0x14))
-		return FALSE;
+		return false;
 
 	volu = &vb->vblk.volu;
 
@@ -1087,7 +1082,7 @@ static BOOL ldm_parse_vol5 (const u8 *bu
 		ldm_get_vstr (buffer + 0x53 + r_size,  volu->drive_hint,
 			sizeof (volu->drive_hint));
 	}
-	return TRUE;
+	return true;
 }
 
 /**
@@ -1100,12 +1095,12 @@ static BOOL ldm_parse_vol5 (const u8 *bu
  * information common to all VBLK types, then delegates the rest of the work to
  * helper functions: ldm_parse_*.
  *
- * Return:  TRUE   @vb contains a VBLK
- *          FALSE  @vb contents are not defined
+ * Return:  'true'   @vb contains a VBLK
+ *          'false'  @vb contents are not defined
  */
-static BOOL ldm_parse_vblk (const u8 *buf, int len, struct vblk *vb)
+static bool ldm_parse_vblk (const u8 *buf, int len, struct vblk *vb)
 {
-	BOOL result = FALSE;
+	bool result = false;
 	int r_objid;
 
 	BUG_ON (!buf || !vb);
@@ -1113,7 +1108,7 @@ static BOOL ldm_parse_vblk (const u8 *bu
 	r_objid = ldm_relative (buf, len, 0x18, 0);
 	if (r_objid < 0) {
 		ldm_error ("VBLK header is corrupt.");
-		return FALSE;
+		return false;
 	}
 
 	vb->flags  = buf[0x12];
@@ -1152,10 +1147,10 @@ static BOOL ldm_parse_vblk (const u8 *bu
  *
  * N.B.  This function does not check the validity of the VBLKs.
  *
- * Return:  TRUE   The VBLK was added
- *          FALSE  An error occurred
+ * Return:  'true'   The VBLK was added
+ *          'false'  An error occurred
  */
-static BOOL ldm_ldmdb_add (u8 *data, int len, struct ldmdb *ldb)
+static bool ldm_ldmdb_add (u8 *data, int len, struct ldmdb *ldb)
 {
 	struct vblk *vb;
 	struct list_head *item;
@@ -1165,12 +1160,12 @@ static BOOL ldm_ldmdb_add (u8 *data, int
 	vb = kmalloc (sizeof (*vb), GFP_KERNEL);
 	if (!vb) {
 		ldm_crit ("Out of memory.");
-		return FALSE;
+		return false;
 	}
 
 	if (!ldm_parse_vblk (data, len, vb)) {
 		kfree(vb);
-		return FALSE;			/* Already logged */
+		return false;			/* Already logged */
 	}
 
 	/* Put vblk into the correct list. */
@@ -1196,13 +1191,13 @@ static BOOL ldm_ldmdb_add (u8 *data, int
 			if ((v->vblk.part.disk_id == vb->vblk.part.disk_id) &&
 			    (v->vblk.part.start > vb->vblk.part.start)) {
 				list_add_tail (&vb->list, &v->list);
-				return TRUE;
+				return true;
 			}
 		}
 		list_add_tail (&vb->list, &ldb->v_part);
 		break;
 	}
-	return TRUE;
+	return true;
 }
 
 /**
@@ -1214,10 +1209,10 @@ static BOOL ldm_ldmdb_add (u8 *data, int
  * Fragmented VBLKs may not be consecutive in the database, so they are placed
  * in a list so they can be pieced together later.
  *
- * Return:  TRUE   Success, the VBLK was added to the list
- *          FALSE  Error, a problem occurred
+ * Return:  'true'   Success, the VBLK was added to the list
+ *          'false'  Error, a problem occurred
  */
-static BOOL ldm_frag_add (const u8 *data, int size, struct list_head *frags)
+static bool ldm_frag_add (const u8 *data, int size, struct list_head *frags)
 {
 	struct frag *f;
 	struct list_head *item;
@@ -1230,7 +1225,7 @@ static BOOL ldm_frag_add (const u8 *data
 	num   = BE16 (data + 0x0E);
 	if ((num < 1) || (num > 4)) {
 		ldm_error ("A VBLK claims to have %d parts.", num);
-		return FALSE;
+		return false;
 	}
 
 	list_for_each (item, frags) {
@@ -1242,7 +1237,7 @@ static BOOL ldm_frag_add (const u8 *data
 	f = kmalloc (sizeof (*f) + size*num, GFP_KERNEL);
 	if (!f) {
 		ldm_crit ("Out of memory.");
-		return FALSE;
+		return false;
 	}
 
 	f->group = group;
@@ -1255,7 +1250,7 @@ found:
 	if (f->map & (1 << rec)) {
 		ldm_error ("Duplicate VBLK, part %d.", rec);
 		f->map &= 0x7F;			/* Mark the group as broken */
-		return FALSE;
+		return false;
 	}
 
 	f->map |= (1 << rec);
@@ -1266,7 +1261,7 @@ found:
 	}
 	memcpy (f->data+rec*(size-VBLK_SIZE_HEAD)+VBLK_SIZE_HEAD, data, size);
 
-	return TRUE;
+	return true;
 }
 
 /**
@@ -1295,10 +1290,10 @@ static void ldm_frag_free (struct list_h
  * Now that all the fragmented VBLKs have been collected, they must be added to
  * the database for later use.
  *
- * Return:  TRUE   All the fragments we added successfully
- *          FALSE  One or more of the fragments we invalid
+ * Return:  'true'   All the fragments we added successfully
+ *          'false'  One or more of the fragments we invalid
  */
-static BOOL ldm_frag_commit (struct list_head *frags, struct ldmdb *ldb)
+static bool ldm_frag_commit (struct list_head *frags, struct ldmdb *ldb)
 {
 	struct frag *f;
 	struct list_head *item;
@@ -1311,13 +1306,13 @@ static BOOL ldm_frag_commit (struct list
 		if (f->map != 0xFF) {
 			ldm_error ("VBLK group %d is incomplete (0x%02x).",
 				f->group, f->map);
-			return FALSE;
+			return false;
 		}
 
 		if (!ldm_ldmdb_add (f->data, f->num*ldb->vm.vblk_size, ldb))
-			return FALSE;		/* Already logged */
+			return false;		/* Already logged */
 	}
-	return TRUE;
+	return true;
 }
 
 /**
@@ -1329,16 +1324,16 @@ static BOOL ldm_frag_commit (struct list
  * To use the information from the VBLKs, they need to be read from the disk,
  * unpacked and validated.  We cache them in @ldb according to their type.
  *
- * Return:  TRUE   All the VBLKs were read successfully
- *          FALSE  An error occurred
+ * Return:  'true'   All the VBLKs were read successfully
+ *          'false'  An error occurred
  */
-static BOOL ldm_get_vblks (struct block_device *bdev, unsigned long base,
+static bool ldm_get_vblks (struct block_device *bdev, unsigned long base,
 			   struct ldmdb *ldb)
 {
 	int size, perbuf, skip, finish, s, v, recs;
 	u8 *data = NULL;
 	Sector sect;
-	BOOL result = FALSE;
+	bool result = false;
 	LIST_HEAD (frags);
 
 	BUG_ON (!bdev || !ldb);


