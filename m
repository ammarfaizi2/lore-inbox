Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130615AbQLYXZO>; Mon, 25 Dec 2000 18:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130884AbQLYXZE>; Mon, 25 Dec 2000 18:25:04 -0500
Received: from ns.caldera.de ([212.34.180.1]:34825 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130615AbQLYXYx>;
	Mon, 25 Dec 2000 18:24:53 -0500
Date: Mon, 25 Dec 2000 23:53:33 +0100
From: Christoph Hellwig <hch@caldera.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: [PATCH] LVM includes userlevel headers
Message-ID: <20001225235333.A22731@caldera.de>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	lvm-devel@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

LVM 0.9 that just rolled into 2.4-test includes userlevel headers -
just to use constants from there to dublicate kernel functions.

The first patch fixes that and the second changes the toplevel Makefile
to search only the kernel and gcc (for stdarg.h) includes to prevent such
accidents.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.


diff -uNr --exclude-from=dontdiff linux-2.4.0-test13-pre4/drivers/md/lvm-snap.c linux/drivers/md/lvm-snap.c
--- linux-2.4.0-test13-pre4/drivers/md/lvm-snap.c	Mon Dec 25 19:21:16 2000
+++ linux/drivers/md/lvm-snap.c	Mon Dec 25 23:59:50 2000
@@ -214,10 +214,10 @@
 	memset(lv_COW_table, 0, blksize_snap);
 	for ( ; is < lv_snap->lv_remap_ptr; is++, id++) {
 		/* store new COW_table entry */
-		lv_COW_table[id].pv_org_number = LVM_TO_DISK64(lvm_pv_get_number(vg, lv_snap->lv_block_exception[is].rdev_org));
-		lv_COW_table[id].pv_org_rsector = LVM_TO_DISK64(lv_snap->lv_block_exception[is].rsector_org);
-		lv_COW_table[id].pv_snap_number = LVM_TO_DISK64(lvm_pv_get_number(vg, lv_snap->lv_block_exception[is].rdev_new));
-		lv_COW_table[id].pv_snap_rsector = LVM_TO_DISK64(lv_snap->lv_block_exception[is].rsector_new);
+		lv_COW_table[id].pv_org_number = cpu_to_le64(lvm_pv_get_number(vg, lv_snap->lv_block_exception[is].rdev_org));
+		lv_COW_table[id].pv_org_rsector = cpu_to_le64(lv_snap->lv_block_exception[is].rsector_org);
+		lv_COW_table[id].pv_snap_number = cpu_to_le64(lvm_pv_get_number(vg, lv_snap->lv_block_exception[is].rdev_new));
+		lv_COW_table[id].pv_snap_rsector = cpu_to_le64(lv_snap->lv_block_exception[is].rsector_new);
 	}
 }
 
@@ -268,10 +268,10 @@
 	blocks[0] = (snap_pe_start + COW_table_sector_offset) >> (blksize_snap >> 10);
 
 	/* store new COW_table entry */
-	lv_COW_table[idx_COW_table].pv_org_number = LVM_TO_DISK64(lvm_pv_get_number(vg, lv_snap->lv_block_exception[idx].rdev_org));
-	lv_COW_table[idx_COW_table].pv_org_rsector = LVM_TO_DISK64(lv_snap->lv_block_exception[idx].rsector_org);
-	lv_COW_table[idx_COW_table].pv_snap_number = LVM_TO_DISK64(lvm_pv_get_number(vg, snap_phys_dev));
-	lv_COW_table[idx_COW_table].pv_snap_rsector = LVM_TO_DISK64(lv_snap->lv_block_exception[idx].rsector_new);
+	lv_COW_table[idx_COW_table].pv_org_number = cpu_to_le64(lvm_pv_get_number(vg, lv_snap->lv_block_exception[idx].rdev_org));
+	lv_COW_table[idx_COW_table].pv_org_rsector = cpu_to_le64(lv_snap->lv_block_exception[idx].rsector_org);
+	lv_COW_table[idx_COW_table].pv_snap_number = cpu_to_le64(lvm_pv_get_number(vg, snap_phys_dev));
+	lv_COW_table[idx_COW_table].pv_snap_rsector = cpu_to_le64(lv_snap->lv_block_exception[idx].rsector_new);
 
 	length_tmp = iobuf->length;
 	iobuf->length = blksize_snap;
diff -uNr --exclude-from=dontdiff linux-2.4.0-test13-pre4/include/linux/lvm.h linux/include/linux/lvm.h
--- linux-2.4.0-test13-pre4/include/linux/lvm.h	Mon Dec 25 19:21:15 2000
+++ linux/include/linux/lvm.h	Tue Dec 26 00:01:23 2000
@@ -57,6 +57,8 @@
  *    26/06/2000 - implemented snapshot persistency and resizing support
  *    02/11/2000 - added hash table size member to lv structure
  *    12/11/2000 - removed unneeded timestamp definitions
+ *    24/12/2000 - removed LVM_TO_{CORE,DISK}*, use cpu_{from, to}_le*
+ *                 instead - Christoph Hellwig
  *
  */
 
@@ -67,7 +69,6 @@
 #define	_LVM_KERNEL_H_VERSION	"LVM 0.9 (13/11/2000)"
 
 #include <linux/version.h>
-#include <endian.h>
 
 /*
  * preprocessor definitions
@@ -323,51 +324,6 @@
 	COW_table_entries_per_PE = LVM_GET_COW_TABLE_CHUNKS_PER_PE(vg, lv); \
 	COW_table_chunks_per_PE = ( COW_table_entries_per_PE * sizeof(lv_COW_table_disk_t) / SECTOR_SIZE + lv->lv_chunk_size - 1) / lv->lv_chunk_size; \
 	COW_table_entries_per_PE - COW_table_chunks_per_PE;})
-
-
-/* to disk and to core data conversion macros */
-#if __BYTE_ORDER == __BIG_ENDIAN
-
-#define LVM_TO_CORE16(x) ( \
-        ((uint16_t)((((uint16_t)(x) & 0x00FFU) << 8) | \
-                    (((uint16_t)(x) & 0xFF00U) >> 8))))
-
-#define LVM_TO_DISK16(x) LVM_TO_CORE16(x)
-
-#define LVM_TO_CORE32(x) ( \
-        ((uint32_t)((((uint32_t)(x) & 0x000000FFU) << 24) | \
-                    (((uint32_t)(x) & 0x0000FF00U) << 8))) \
-                    (((uint32_t)(x) & 0x00FF0000U) >> 8))) \
-                    (((uint32_t)(x) & 0xFF000000U) >> 24))))
-
-#define LVM_TO_DISK32(x) LVM_TO_CORE32(x)
-
-#define LVM_TO_CORE64(x) \
-        ((uint64_t)((((uint64_t)(x) & 0x00000000000000FFULL) << 56) | \
-                    (((uint64_t)(x) & 0x000000000000FF00ULL) << 40) | \
-                    (((uint64_t)(x) & 0x0000000000FF0000ULL) << 24) | \
-                    (((uint64_t)(x) & 0x00000000FF000000ULL) <<  8) | \
-                    (((uint64_t)(x) & 0x000000FF00000000ULL) >>  8) | \
-                    (((uint64_t)(x) & 0x0000FF0000000000ULL) >> 24) | \
-                    (((uint64_t)(x) & 0x00FF000000000000ULL) >> 40) | \
-                    (((uint64_t)(x) & 0xFF00000000000000ULL) >> 56))) 
-
-#define LVM_TO_DISK64(x) LVM_TO_CORE64(x)
-
-#elif __BYTE_ORDER == __LITTLE_ENDIAN
-
-#define LVM_TO_CORE16(x) x
-#define LVM_TO_DISK16(x) x
-#define LVM_TO_CORE32(x) x
-#define LVM_TO_DISK32(x) x
-#define LVM_TO_CORE64(x) x
-#define LVM_TO_DISK64(x) x
-
-#else
-
-#error "__BYTE_ORDER must be defined as __LITTLE_ENDIAN or __BIG_ENDIAN"
-
-#endif /* #if __BYTE_ORDER == __BIG_ENDIAN */
 
 
 /*


--- linux-2.4.0-test13-pre4/Makefile	Mon Dec 25 19:21:14 2000
+++ linux/Makefile	Mon Dec 25 23:30:03 2000
@@ -85,7 +85,8 @@
 # standard CFLAGS
 #
 
-CPPFLAGS := -D__KERNEL__ -I$(HPATH)
+GCCINCDIR = $(shell gcc -print-search-dirs | sed -ne 's/install: \(.*\)/\1include/gp')
+CPPFLAGS := -D__KERNEL__ -nostdinc -I$(HPATH) -I$(GCCINCDIR)
 
 CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
