Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292357AbSBUMyH>; Thu, 21 Feb 2002 07:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291625AbSBUMx6>; Thu, 21 Feb 2002 07:53:58 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:7829 "EHLO gin")
	by vger.kernel.org with ESMTP id <S291463AbSBUMxm>;
	Thu, 21 Feb 2002 07:53:42 -0500
Date: Thu, 21 Feb 2002 13:53:31 +0100
To: torvalds@transmeta.com
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] missing chunk in lvm-fixes in 2.5.5
Message-ID: <20020221125331.GA12452@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the lvm-patch that went into 2.5.5 missed the changes in lvm.h and is
still not compileable. This patch adds those changes. The kernel i'm
running right now has this patch and /var and /home on lvm.

-- 

//anders/g

--- linux-2.5.5/include/linux/lvm.h	Thu Feb 21 12:43:30 2002
+++ linux-2.5.5-lvm/include/linux/lvm.h	Thu Feb 21 12:50:59 2002
@@ -477,8 +477,16 @@
  * Structure Logical Volume (LV) Version 3
  */
 
-/* core */
-typedef struct lv_v5 {
+struct kern_lv_v5;
+struct user_lv_v5;
+typedef struct user_lv_v5 userlv_t;
+#ifdef __KERNEL__
+typedef struct kern_lv_v5 lv_t;
+#else
+typedef struct user_lv_v5 lv_t;
+#endif
+
+struct user_lv_v5 {
 	char lv_name[NAME_LEN];
 	char vg_name[NAME_LEN];
 	uint lv_access;
@@ -501,15 +509,18 @@
 	uint lv_read_ahead;
 
 	/* delta to version 1 starts here */
-       struct lv_v5 *lv_snapshot_org;
-       struct lv_v5 *lv_snapshot_prev;
-       struct lv_v5 *lv_snapshot_next;
+	lv_t *lv_snapshot_org;
+	lv_t *lv_snapshot_prev;
+	lv_t *lv_snapshot_next;
 	lv_block_exception_t *lv_block_exception;
 	uint lv_remap_ptr;
 	uint lv_remap_end;
 	uint lv_chunk_size;
 	uint lv_snapshot_minor;
-#ifdef __KERNEL__
+};
+
+struct kern_lv_v5{
+	struct user_lv_v5 u;
 	struct kiobuf *lv_iobuf;
 	sector_t blocks[LVM_MAX_SECTORS];
 	struct kiobuf *lv_COW_table_iobuf;
@@ -520,12 +531,8 @@
 	wait_queue_head_t lv_snapshot_wait;
 	int	lv_snapshot_use_rate;
 	struct vg_v3	*vg;
-
 	uint lv_allocated_snapshot_le;
-#else
-	char dummy[200];
-#endif
-} lv_t;
+};
 
 /* disk */
 typedef struct lv_disk_v3 {
@@ -679,13 +686,13 @@
 }
 
 static int inline LVM_GET_COW_TABLE_CHUNKS_PER_PE(vg_t *vg, lv_t *lv) {
-	return vg->pe_size / lv->lv_chunk_size;
+	return vg->pe_size / lv->u.lv_chunk_size;
 }
 
 static int inline LVM_GET_COW_TABLE_ENTRIES_PER_PE(vg_t *vg, lv_t *lv) {
-	ulong chunks = vg->pe_size / lv->lv_chunk_size;
+	ulong chunks = vg->pe_size / lv->u.lv_chunk_size;
 	ulong entry_size = sizeof(lv_COW_table_disk_t);
-	ulong chunk_size = lv->lv_chunk_size * SECTOR_SIZE;
+	ulong chunk_size = lv->u.lv_chunk_size * SECTOR_SIZE;
 	ulong entries = (vg->pe_size * SECTOR_SIZE) /
 		(entry_size + chunk_size);
 
