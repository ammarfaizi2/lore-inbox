Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSHIX0E>; Fri, 9 Aug 2002 19:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSHIX0E>; Fri, 9 Aug 2002 19:26:04 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:27083 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316289AbSHIX0B> convert rfc822-to-8bit; Fri, 9 Aug 2002 19:26:01 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Oliver Neukum <oliver@neukum.name>
To: Alexander Viro <viro@math.psu.edu>
Subject: HFS cleanup #1 - remove partition code
Date: Sat, 10 Aug 2002 01:34:53 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208100134.54011.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this removes the independent partition code from hfs.
This is the first patch taking an axe to hfs so it'll be in shape for 2.6.
Does anybody object to it being sent to Linus ?

	Regards
		Oliver


diff -Nru a/fs/hfs/Makefile b/fs/hfs/Makefile
--- a/fs/hfs/Makefile	Sat Aug 10 01:29:42 2002
+++ b/fs/hfs/Makefile	Sat Aug 10 01:29:42 2002
@@ -7,6 +7,6 @@
 hfs-objs := balloc.o bdelete.o bfind.o bins_del.o binsert.o bitmap.o bitops.o \
 	    bnode.o brec.o btree.o catalog.o dir.o dir_cap.o dir_dbl.o \
 	    dir_nat.o extent.o file.o file_cap.o file_hdr.o inode.o mdb.o \
-            part_tbl.o string.o super.o sysdep.o trans.o version.o
+            string.o super.o sysdep.o trans.o version.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/fs/hfs/part_tbl.c b/fs/hfs/part_tbl.c
--- a/fs/hfs/part_tbl.c	Sat Aug 10 01:29:42 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,244 +0,0 @@
-/*
- * linux/fs/hfs/part_tbl.c
- *
- * Copyright (C) 1996-1997  Paul H. Hargrove
- * This file may be distributed under the terms of the GNU General Public License.
- *
- * Original code to handle the new style Mac partition table based on
- * a patch contributed by Holger Schemel (aeglos@valinor.owl.de).
- *
- * "XXX" in a comment is a note to myself to consider changing something.
- *
- * In function preconditions the term "valid" applied to a pointer to
- * a structure means that the pointer is non-NULL and the structure it
- * points to has all fields initialized to consistent values.
- *
- * The code in this file initializes some structures which contain
- * pointers by calling memset(&foo, 0, sizeof(foo)).
- * This produces the desired behavior only due to the non-ANSI
- * assumption that the machine representation of NULL is all zeros.
- */
-
-#include "hfs.h"
-
-/*================ File-local data types ================*/
-
-/*
- * The Macintosh Driver Descriptor Block
- *
- * On partitioned Macintosh media this is block 0.
- * We really only need the "magic number" to check for partitioned media.
- */
-struct hfs_drvr_desc {
-	hfs_word_t	ddSig;		/* The signature word */
-	/* a bunch more stuff we don't need */
-};
-
-/* 
- * The new style Mac partition map
- *
- * For each partition on the media there is a physical block (512-byte
- * block) containing one of these structures.  These blocks are
- * contiguous starting at block 1.
- */
-struct new_pmap {
-	hfs_word_t	pmSig;		/* Signature bytes to verify
-					   that this is a partition
-					   map block */
-	hfs_word_t	reSigPad;	/* padding */
-	hfs_lword_t	pmMapBlkCnt;	/* (At least in block 1) this
-					   is the number of partition
-					   map blocks */
-	hfs_lword_t	pmPyPartStart;	/* The physical block number
-					   of the first block in this
-					   partition */
-	hfs_lword_t	pmPartBlkCnt;	/* The number of physical
-					   blocks in this partition */
-	hfs_byte_t	pmPartName[32];	/* (null terminated?) string
-					   giving the name of this
-					   partition */
-	hfs_byte_t	pmPartType[32];	/* (null terminated?) string
-					   giving the type of this
-					   partition */
-	/* a bunch more stuff we don't need */
-};
-
-/* 
- * The old style Mac partition map
- *
- * The partition map consists for a 2-byte signature followed by an
- * array of these structures.  The map is terminated with an all-zero
- * one of these.
- */
-struct old_pmap {
-	hfs_word_t		pdSig;	/* Signature bytes */
-	struct 	old_pmap_entry {
-		hfs_lword_t	pdStart;
-		hfs_lword_t	pdSize;
-		hfs_lword_t	pdFSID;
-	}	pdEntry[42];
-} __attribute__((packed));
-
-/*================ File-local functions ================*/
-
-/*
- * parse_new_part_table()
- *
- * Parse a new style partition map looking for the
- * start and length of the 'part'th HFS partition.
- */
-static int parse_new_part_table(hfs_sysmdb sys_mdb, hfs_buffer buf,
-				int part, hfs_s32 *size, hfs_s32 *start)
-{
-	struct new_pmap *pm = (struct new_pmap *)hfs_buffer_data(buf);
-	hfs_u32 pmap_entries = hfs_get_hl(pm->pmMapBlkCnt);
-	int hfs_part = 0;
-	int entry;
-
-	for (entry = 0; (entry < pmap_entries) && !(*start); ++entry) {
-		if (entry) {
-			/* read the next partition map entry */
-			buf = hfs_buffer_get(sys_mdb, HFS_PMAP_BLK + entry, 1);
-			if (!hfs_buffer_ok(buf)) {
-				hfs_warn("hfs_fs: unable to "
-				         "read partition map.\n");
-				goto bail;
-			}
-			pm = (struct new_pmap *)hfs_buffer_data(buf);
-			if (hfs_get_ns(pm->pmSig) !=
-						htons(HFS_NEW_PMAP_MAGIC)) {
-				hfs_warn("hfs_fs: invalid "
-				         "entry in partition map\n");
-				hfs_buffer_put(buf);
-				goto bail;
-			}
-		}
-
-		/* look for an HFS partition */
-		if (!memcmp(pm->pmPartType,"Apple_HFS",9) && 
-		    ((hfs_part++) == part)) {
-			/* Found it! */
-			*start = hfs_get_hl(pm->pmPyPartStart);
-			*size = hfs_get_hl(pm->pmPartBlkCnt);
-		}
-
-		hfs_buffer_put(buf);
-	}
-
-	return 0;
-
-bail:
-	return 1;
-}
-
-/*
- * parse_old_part_table()
- *
- * Parse a old style partition map looking for the
- * start and length of the 'part'th HFS partition.
- */
-static int parse_old_part_table(hfs_sysmdb sys_mdb, hfs_buffer buf,
-				int part, hfs_s32 *size, hfs_s32 *start)
-{
-	struct old_pmap *pm = (struct old_pmap *)hfs_buffer_data(buf);
-	struct old_pmap_entry *p = &pm->pdEntry[0];
-	int hfs_part = 0;
-
-	while ((p->pdStart || p->pdSize || p->pdFSID) && !(*start)) {
-		/* look for an HFS partition */
-		if ((hfs_get_nl(p->pdFSID) == htonl(0x54465331)/*"TFS1"*/) &&
-		    ((hfs_part++) == part)) {
-			/* Found it! */
-			*start = hfs_get_hl(p->pdStart);
-			*size = hfs_get_hl(p->pdSize);
-		}
-		++p;
-	}
-	hfs_buffer_put(buf);
-
-	return 0;
-}
-
-/*================ Global functions ================*/
-
-/*
- * hfs_part_find()
- *
- * Parse the partition map looking for the
- * start and length of the 'part'th HFS partition.
- */
-int hfs_part_find(hfs_sysmdb sys_mdb, int part, int silent,
-		  hfs_s32 *size, hfs_s32 *start)
-{
-	hfs_buffer buf;
-	hfs_u16 sig;
-	int dd_found = 0;
-	int retval = 1;
-
-	/* Read block 0 to see if this media is partitioned */
-	buf = hfs_buffer_get(sys_mdb, HFS_DD_BLK, 1);
-	if (!hfs_buffer_ok(buf)) {
-		hfs_warn("hfs_fs: Unable to read block 0.\n");
-		goto done;
-	}
-	sig = hfs_get_ns(((struct hfs_drvr_desc *)hfs_buffer_data(buf))->ddSig);
-	hfs_buffer_put(buf);
-
-        if (sig == htons(HFS_DRVR_DESC_MAGIC)) {
-		/* We are definitely on partitioned media. */
-		dd_found = 1;
-	}
-
-	buf = hfs_buffer_get(sys_mdb, HFS_PMAP_BLK, 1);
-	if (!hfs_buffer_ok(buf)) {
-		hfs_warn("hfs_fs: Unable to read block 1.\n");
-		goto done;
-	}
-
-	*size = *start = 0;
-
-	switch (hfs_get_ns(hfs_buffer_data(buf))) {
-	case __constant_htons(HFS_OLD_PMAP_MAGIC):
-		retval = parse_old_part_table(sys_mdb, buf, part, size, start);
-		break;
-
-	case __constant_htons(HFS_NEW_PMAP_MAGIC):
-		retval = parse_new_part_table(sys_mdb, buf, part, size, start);
-		break;
-
-	default:
-		if (dd_found) {
-			/* The media claimed to have a partition map */
-			if (!silent) {
-				hfs_warn("hfs_fs: This disk has an "
-					 "unrecognized partition map type.\n");
-			}
-		} else {
-			/* Conclude that the media is not partitioned */
-			retval = 0;
-		}
-		goto done;
-	}
-
-	if (!retval) {
-		if (*start == 0) {
-			if (part) {
-				hfs_warn("hfs_fs: unable to locate "
-				         "HFS partition number %d.\n", part);
-			} else {
-				hfs_warn("hfs_fs: unable to locate any "
-					 "HFS partitions.\n");
-			}
-			retval = 1;
-		} else if (*size < 0) {
-			hfs_warn("hfs_fs: Partition size > 1 Terabyte.\n");
-			retval = 1;
-		} else if (*start < 0) {
-			hfs_warn("hfs_fs: Partition begins beyond 1 "
-				 "Terabyte.\n");
-			retval = 1;
-		}
-	}
-done:
-	return retval;
-}
diff -Nru a/fs/hfs/super.c b/fs/hfs/super.c
--- a/fs/hfs/super.c	Sat Aug 10 01:29:42 2002
+++ b/fs/hfs/super.c	Sat Aug 10 01:29:42 2002
@@ -470,24 +470,7 @@
 	/* set the device driver to 512-byte blocks */
 	sb_set_blocksize(s, HFS_SECTOR_SIZE);
 
-#ifdef CONFIG_MAC_PARTITION
-	/* check to see if we're in a partition */
 	mdb = hfs_mdb_get(s, s->s_flags & MS_RDONLY, 0);
-
-	/* erk. try parsing the partition table ourselves */
-	if (!mdb) {
-		if (hfs_part_find(s, part, silent, &part_size, &part_start)) {
-	    		goto bail2;
-	  	}
-	  	mdb = hfs_mdb_get(s, s->s_flags & MS_RDONLY, part_start);
-	}
-#else
-	if (hfs_part_find(s, part, silent, &part_size, &part_start)) {
-		goto bail2;
-	}
-
-	mdb = hfs_mdb_get(s, s->s_flags & MS_RDONLY, part_start);
-#endif
 
 	if (!mdb) {
 		if (!silent) {

