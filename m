Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287199AbSAGVqc>; Mon, 7 Jan 2002 16:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287196AbSAGVqW>; Mon, 7 Jan 2002 16:46:22 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:37020 "EHLO gin")
	by vger.kernel.org with ESMTP id <S287193AbSAGVqC>;
	Mon, 7 Jan 2002 16:46:02 -0500
Date: Mon, 7 Jan 2002 22:45:54 +0100
To: linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Cc: torvalds@transmeta.com, mauelshagen@sistina.com
Subject: [PATCH] 2.5.2-pre9 lvm user/kernel-space inteface fix
Message-ID: <20020107214554.GD500@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

finally i have found the time to forwardport this patch that fixes the
sizeof(lv_t) differeneces between user and kernelspace which caused
memorycorruption in the userspace-tools. The interface is kept unchanged.
By having another (smaller) lv_t exported to userspace (userlv_t) it also
removes a allocation of a >4k lv_t-object on the stack in the ioctls, which
i overlooked in the last patch. Running kernel with this patch right now,
and ioctls tested under uml.

The patch is fairly large, but most changes are just adding the
u.-substructure, the changes are just in lvm-files and it fixes crashes in
the userspacetools.

-- 

//anders/g

--- linux-2.5.2-pre9-uml/drivers/md/lvm-fs.c	Sun Jan  6 18:10:19 2002
+++ linux-2.5.2-pre9-uml-lvm/drivers/md/lvm-fs.c	Sun Jan  6 21:58:39 2002
@@ -170,11 +170,11 @@
 
 devfs_handle_t lvm_fs_create_lv(vg_t *vg_ptr, lv_t *lv) {
 	struct proc_dir_entry *pde;
-	const char *name = _basename(lv->lv_name);
+	const char *name = _basename(lv->u.lv_name);
 
-	lv_devfs_handle[minor(lv->lv_dev)] = devfs_register(
+	lv_devfs_handle[minor(lv->u.lv_dev)] = devfs_register(
 		vg_devfs_handle[vg_ptr->vg_number], name,
-		DEVFS_FL_DEFAULT, LVM_BLK_MAJOR, minor(lv->lv_dev),
+		DEVFS_FL_DEFAULT, LVM_BLK_MAJOR, minor(lv->u.lv_dev),
 		S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP,
 		&lvm_blk_dops, NULL);
 
@@ -183,15 +183,15 @@
 		pde->read_proc = _proc_read_lv;
 		pde->data = lv;
 	}
-	return lv_devfs_handle[minor(lv->lv_dev)];
+	return lv_devfs_handle[minor(lv->u.lv_dev)];
 }
 
 void lvm_fs_remove_lv(vg_t *vg_ptr, lv_t *lv) {
-	devfs_unregister(lv_devfs_handle[minor(lv->lv_dev)]);
-	lv_devfs_handle[minor(lv->lv_dev)] = NULL;
+	devfs_unregister(lv_devfs_handle[minor(lv->u.lv_dev)]);
+	lv_devfs_handle[minor(lv->u.lv_dev)] = NULL;
 
 	if(vg_ptr->lv_subdir_pde) {
-		const char *name = _basename(lv->lv_name);
+		const char *name = _basename(lv->u.lv_name);
 		remove_proc_entry(name, vg_ptr->lv_subdir_pde);
 	}
 }
@@ -269,21 +269,21 @@
 	int sz = 0;
 	lv_t *lv = data;
 
-	sz += sprintf(page + sz, "name:         %s\n", lv->lv_name);
-	sz += sprintf(page + sz, "size:         %u\n", lv->lv_size);
-	sz += sprintf(page + sz, "access:       %u\n", lv->lv_access);
-	sz += sprintf(page + sz, "status:       %u\n", lv->lv_status);
-	sz += sprintf(page + sz, "number:       %u\n", lv->lv_number);
-	sz += sprintf(page + sz, "open:         %u\n", lv->lv_open);
-	sz += sprintf(page + sz, "allocation:   %u\n", lv->lv_allocation);
-       if(lv->lv_stripes > 1) {
+	sz += sprintf(page + sz, "name:         %s\n", lv->u.lv_name);
+	sz += sprintf(page + sz, "size:         %u\n", lv->u.lv_size);
+	sz += sprintf(page + sz, "access:       %u\n", lv->u.lv_access);
+	sz += sprintf(page + sz, "status:       %u\n", lv->u.lv_status);
+	sz += sprintf(page + sz, "number:       %u\n", lv->u.lv_number);
+	sz += sprintf(page + sz, "open:         %u\n", lv->u.lv_open);
+	sz += sprintf(page + sz, "allocation:   %u\n", lv->u.lv_allocation);
+       if(lv->u.lv_stripes > 1) {
                sz += sprintf(page + sz, "stripes:      %u\n",
-                             lv->lv_stripes);
+                             lv->u.lv_stripes);
                sz += sprintf(page + sz, "stripesize:   %u\n",
-                             lv->lv_stripesize);
+                             lv->u.lv_stripesize);
        }
 	sz += sprintf(page + sz, "device:       %02u:%02u\n",
-		      major(lv->lv_dev), minor(lv->lv_dev));
+		      major(lv->u.lv_dev), minor(lv->u.lv_dev));
 
 	return sz;
 }
@@ -350,13 +350,13 @@
 			if (vg_ptr->lv_cur > 0) {
 				for (l = 0; l < vg[v]->lv_max; l++) {
 					if ((lv_ptr = vg_ptr->lv[l]) != NULL) {
-						pe_t_bytes += lv_ptr->lv_allocated_le;
+						pe_t_bytes += lv_ptr->u.lv_allocated_le;
 						hash_table_bytes += lv_ptr->lv_snapshot_hash_table_size;
-						if (lv_ptr->lv_block_exception != NULL)
-							lv_block_exception_t_bytes += lv_ptr->lv_remap_end;
-						if (lv_ptr->lv_open > 0) {
+						if (lv_ptr->u.lv_block_exception != NULL)
+							lv_block_exception_t_bytes += lv_ptr->u.lv_remap_end;
+						if (lv_ptr->u.lv_open > 0) {
 							lv_open_counter++;
-							lv_open_total += lv_ptr->lv_open;
+							lv_open_total += lv_ptr->u.lv_open;
 						}
 					}
 				}
@@ -532,16 +532,16 @@
 	char inactive_flag = 'A', allocation_flag = ' ',
 		stripes_flag = ' ', rw_flag = ' ', *basename;
 
-	if (!(lv_ptr->lv_status & LV_ACTIVE))
+	if (!(lv_ptr->u.lv_status & LV_ACTIVE))
 		inactive_flag = 'I';
 	rw_flag = 'R';
-	if (lv_ptr->lv_access & LV_WRITE)
+	if (lv_ptr->u.lv_access & LV_WRITE)
 		rw_flag = 'W';
 	allocation_flag = 'D';
-	if (lv_ptr->lv_allocation & LV_CONTIGUOUS)
+	if (lv_ptr->u.lv_allocation & LV_CONTIGUOUS)
 		allocation_flag = 'C';
 	stripes_flag = 'L';
-	if (lv_ptr->lv_stripes > 1)
+	if (lv_ptr->u.lv_stripes > 1)
 		stripes_flag = 'S';
 	sz += sprintf(buf+sz,
 		      "[%c%c%c%c",
@@ -549,29 +549,29 @@
 	 rw_flag,
 		      allocation_flag,
 		      stripes_flag);
-	if (lv_ptr->lv_stripes > 1)
+	if (lv_ptr->u.lv_stripes > 1)
 		sz += sprintf(buf+sz, "%-2d",
-			      lv_ptr->lv_stripes);
+			      lv_ptr->u.lv_stripes);
 	else
 		sz += sprintf(buf+sz, "  ");
 
 	/* FIXME: use _basename */
-	basename = strrchr(lv_ptr->lv_name, '/');
-	if ( basename == 0) basename = lv_ptr->lv_name;
+	basename = strrchr(lv_ptr->u.lv_name, '/');
+	if ( basename == 0) basename = lv_ptr->u.lv_name;
 	else                basename++;
 	sz += sprintf(buf+sz, "] %-25s", basename);
 	if (strlen(basename) > 25)
 		sz += sprintf(buf+sz,
 			      "\n                              ");
 	sz += sprintf(buf+sz, "%9d /%-6d   ",
-		      lv_ptr->lv_size >> 1,
-		      lv_ptr->lv_size / vg_ptr->pe_size);
+		      lv_ptr->u.lv_size >> 1,
+		      lv_ptr->u.lv_size / vg_ptr->pe_size);
 
-	if (lv_ptr->lv_open == 0)
+	if (lv_ptr->u.lv_open == 0)
 		sz += sprintf(buf+sz, "close");
 	else
 		sz += sprintf(buf+sz, "%dx open",
-			      lv_ptr->lv_open);
+			      lv_ptr->u.lv_open);
 
 	return sz;
 }
--- linux-2.5.2-pre9-uml/drivers/md/lvm-snap.c	Sun Jan  6 18:10:19 2002
+++ linux-2.5.2-pre9-uml-lvm/drivers/md/lvm-snap.c	Sun Jan  6 21:48:08 2002
@@ -93,7 +93,7 @@
 {
 	struct list_head * hash_table = lv->lv_snapshot_hash_table, * next;
 	unsigned long mask = lv->lv_snapshot_hash_mask;
-	int chunk_size = lv->lv_chunk_size;
+	int chunk_size = lv->u.lv_chunk_size;
 	lv_block_exception_t * ret;
 	int i = 0;
 
@@ -127,7 +127,7 @@
 {
 	struct list_head * hash_table = lv->lv_snapshot_hash_table;
 	unsigned long mask = lv->lv_snapshot_hash_mask;
-	int chunk_size = lv->lv_chunk_size;
+	int chunk_size = lv->u.lv_chunk_size;
 
 	hash_table = &hash_table[hashfn(org_dev, org_start, mask, chunk_size)];
 	list_add(&exception->hash, hash_table);
@@ -139,7 +139,7 @@
 	int ret;
 	unsigned long pe_off, pe_adjustment, __org_start;
 	kdev_t __org_dev;
-	int chunk_size = lv->lv_chunk_size;
+	int chunk_size = lv->u.lv_chunk_size;
 	lv_block_exception_t * exception;
 
 	pe_off = pe_start % chunk_size;
@@ -164,26 +164,26 @@
 
 	/* no exception storage space available for this snapshot
 	   or error on this snapshot --> release it */
-	invalidate_buffers(lv_snap->lv_dev);
+	invalidate_buffers(lv_snap->u.lv_dev);
 
        /* wipe the snapshot since it's inconsistent now */
        _disable_snapshot(vg, lv_snap);
 
 	last_dev = NODEV;
-	for (i = 0; i < lv_snap->lv_remap_ptr; i++) {
-		if ( !kdev_same(lv_snap->lv_block_exception[i].rdev_new,
+	for (i = 0; i < lv_snap->u.lv_remap_ptr; i++) {
+		if ( !kdev_same(lv_snap->u.lv_block_exception[i].rdev_new,
 				last_dev)) {
-			last_dev = lv_snap->lv_block_exception[i].rdev_new;
+			last_dev = lv_snap->u.lv_block_exception[i].rdev_new;
 			invalidate_buffers(last_dev);
 		}
 	}
 
 	lvm_snapshot_release(lv_snap);
-	lv_snap->lv_status &= ~LV_ACTIVE;
+	lv_snap->u.lv_status &= ~LV_ACTIVE;
 
 	printk(KERN_INFO
 	       "%s -- giving up to snapshot %s on %s: %s\n",
-	       lvm_name, lv_snap->lv_snapshot_org->lv_name, lv_snap->lv_name,
+	       lvm_name, lv_snap->u.lv_snapshot_org->u.lv_name, lv_snap->u.lv_name,
 	       reason);
 }
 
@@ -234,7 +234,7 @@
 int lvm_snapshot_fill_COW_page(vg_t * vg, lv_t * lv_snap)
 {
        uint pvn;
-       int id = 0, is = lv_snap->lv_remap_ptr;
+       int id = 0, is = lv_snap->u.lv_remap_ptr;
        ulong blksize_snap;
        lv_COW_table_disk_t * lv_COW_table = (lv_COW_table_disk_t *)
                page_address(lv_snap->lv_COW_table_iobuf->maplist[0]);
@@ -244,13 +244,13 @@
 
 	is--;
         blksize_snap =
-               block_size(lv_snap->lv_block_exception[is].rdev_new);
+               block_size(lv_snap->u.lv_block_exception[is].rdev_new);
         is -= is % (blksize_snap / sizeof(lv_COW_table_disk_t));
 
 	memset(lv_COW_table, 0, blksize_snap);
-	for ( ; is < lv_snap->lv_remap_ptr; is++, id++) {
+	for ( ; is < lv_snap->u.lv_remap_ptr; is++, id++) {
 		/* store new COW_table entry */
-               lv_block_exception_t *be = lv_snap->lv_block_exception + is;
+               lv_block_exception_t *be = lv_snap->u.lv_block_exception + is;
                if(_pv_get_number(vg, be->rdev_org, &pvn))
                        goto bad;
 
@@ -281,7 +281,7 @@
 	int r;
 	const char *err;
 	if((r = _write_COW_table_block(vg, lv_snap,
-				       lv_snap->lv_remap_ptr - 1, &err)))
+				       lv_snap->u.lv_remap_ptr - 1, &err)))
 		lvm_drop_snapshot(vg, lv_snap, err);
 	return r;
 }
@@ -303,13 +303,13 @@
 	const char * reason;
 	kdev_t snap_phys_dev;
 	unsigned long org_start, snap_start, virt_start, pe_off;
-	int idx = lv_snap->lv_remap_ptr, chunk_size = lv_snap->lv_chunk_size;
+	int idx = lv_snap->u.lv_remap_ptr, chunk_size = lv_snap->u.lv_chunk_size;
 	struct kiobuf * iobuf;
 	int blksize_snap, blksize_org, min_blksize, max_blksize;
 	int max_sectors, nr_sectors;
 
 	/* check if we are out of snapshot space */
-	if (idx >= lv_snap->lv_remap_end)
+	if (idx >= lv_snap->u.lv_remap_end)
 		goto fail_out_of_space;
 
 	/* calculate physical boundaries of source chunk */
@@ -318,8 +318,8 @@
 	virt_start = org_virt_sector - (org_phys_sector - org_start);
 
 	/* calculate physical boundaries of destination chunk */
-	snap_phys_dev = lv_snap->lv_block_exception[idx].rdev_new;
-	snap_start = lv_snap->lv_block_exception[idx].rsector_new;
+	snap_phys_dev = lv_snap->u.lv_block_exception[idx].rdev_new;
+	snap_start = lv_snap->u.lv_block_exception[idx].rsector_new;
 
 #ifdef DEBUG_SNAPSHOT
 	printk(KERN_INFO
@@ -371,20 +371,20 @@
 
 #ifdef DEBUG_SNAPSHOT
 	/* invalidate the logical snapshot buffer cache */
-	invalidate_snap_cache(virt_start, lv_snap->lv_chunk_size,
-			      lv_snap->lv_dev);
+	invalidate_snap_cache(virt_start, lv_snap->u.lv_chunk_size,
+			      lv_snap->u.lv_dev);
 #endif
 
 	/* the original chunk is now stored on the snapshot volume
 	   so update the execption table */
-	lv_snap->lv_block_exception[idx].rdev_org = org_phys_dev;
-	lv_snap->lv_block_exception[idx].rsector_org = org_start;
+	lv_snap->u.lv_block_exception[idx].rdev_org = org_phys_dev;
+	lv_snap->u.lv_block_exception[idx].rsector_org = org_start;
 
-	lvm_hash_link(lv_snap->lv_block_exception + idx,
+	lvm_hash_link(lv_snap->u.lv_block_exception + idx,
 		      org_phys_dev, org_start, lv_snap);
-	lv_snap->lv_remap_ptr = idx + 1;
+	lv_snap->u.lv_remap_ptr = idx + 1;
 	if (lv_snap->lv_snapshot_use_rate > 0) {
-		if (lv_snap->lv_remap_ptr * 100 / lv_snap->lv_remap_end >= lv_snap->lv_snapshot_use_rate)
+		if (lv_snap->u.lv_remap_ptr * 100 / lv_snap->u.lv_remap_end >= lv_snap->lv_snapshot_use_rate)
 			wake_up_interruptible(&lv_snap->lv_snapshot_wait);
 	}
 	return 0;
@@ -462,7 +462,7 @@
 	unsigned long buckets, max_buckets, size;
 	struct list_head * hash;
 
-	buckets = lv->lv_remap_end;
+	buckets = lv->u.lv_remap_end;
 	max_buckets = calc_max_buckets();
 	buckets = min(buckets, max_buckets);
 	while (buckets & (buckets-1))
@@ -531,10 +531,10 @@
 
 void lvm_snapshot_release(lv_t * lv)
 {
-	if (lv->lv_block_exception)
+	if (lv->u.lv_block_exception)
 	{
-		vfree(lv->lv_block_exception);
-		lv->lv_block_exception = NULL;
+		vfree(lv->u.lv_block_exception);
+		lv->u.lv_block_exception = NULL;
 	}
 	if (lv->lv_snapshot_hash_table)
 	{
@@ -578,8 +578,8 @@
 	COW_entries_per_pe = LVM_GET_COW_TABLE_ENTRIES_PER_PE(vg, lv_snap);
 
 	/* get physical addresse of destination chunk */
-	snap_phys_dev = lv_snap->lv_block_exception[idx].rdev_new;
-	snap_pe_start = lv_snap->lv_block_exception[idx - (idx % COW_entries_per_pe)].rsector_new - lv_snap->lv_chunk_size;
+	snap_phys_dev = lv_snap->u.lv_block_exception[idx].rdev_new;
+	snap_pe_start = lv_snap->u.lv_block_exception[idx - (idx % COW_entries_per_pe)].rsector_new - lv_snap->u.lv_chunk_size;
 
 	blksize_snap = block_size(snap_phys_dev);
 
@@ -595,7 +595,7 @@
 	blocks[0] = (snap_pe_start + COW_table_sector_offset) >> (blksize_snap >> 10);
 
 	/* store new COW_table entry */
-       be = lv_snap->lv_block_exception + idx;
+       be = lv_snap->u.lv_block_exception + idx;
        if(_pv_get_number(vg, be->rdev_org, &pvn))
                goto fail_pv_get_number;
 
@@ -620,15 +620,15 @@
 	if (idx_COW_table % COW_entries_per_block == COW_entries_per_block - 1 || end_of_table)
 	{
 		/* don't go beyond the end */
-               if (idx + 1 >= lv_snap->lv_remap_end) goto out;
+               if (idx + 1 >= lv_snap->u.lv_remap_end) goto out;
 
 		memset(lv_COW_table, 0, blksize_snap);
 
 		if (end_of_table)
 		{
 			idx++;
-			snap_phys_dev = lv_snap->lv_block_exception[idx].rdev_new;
-			snap_pe_start = lv_snap->lv_block_exception[idx - (idx % COW_entries_per_pe)].rsector_new - lv_snap->lv_chunk_size;
+			snap_phys_dev = lv_snap->u.lv_block_exception[idx].rdev_new;
+			snap_pe_start = lv_snap->u.lv_block_exception[idx - (idx % COW_entries_per_pe)].rsector_new - lv_snap->u.lv_chunk_size;
 			blksize_snap = block_size(snap_phys_dev);
 			blocks[0] = snap_pe_start >> (blksize_snap >> 10);
 		} else blocks[0]++;
@@ -664,7 +664,7 @@
 
 static void _disable_snapshot(vg_t *vg, lv_t *lv) {
 	const char *err;
-	lv->lv_block_exception[0].rsector_org = LVM_SNAPSHOT_DROPPED_SECTOR;
+	lv->u.lv_block_exception[0].rsector_org = LVM_SNAPSHOT_DROPPED_SECTOR;
 	if(_write_COW_table_block(vg, lv, 0, &err) < 0) {
 		printk(KERN_ERR "%s -- couldn't disable snapshot: %s\n",
 		       lvm_name, err);
--- linux-2.5.2-pre9-uml/drivers/md/lvm.c	Sun Jan  6 18:10:19 2002
+++ linux-2.5.2-pre9-uml-lvm/drivers/md/lvm.c	Mon Jan  7 22:00:45 2002
@@ -182,6 +182,9 @@
  *    28/12/2001 - buffer_head -> bio
  *                 removed huge allocation of a lv_t on stack
  *                 (Anders Gustafsson)
+ *    07/01/2002 - fixed sizeof(lv_t) differences in user/kernel-space
+ *                 removed another huge allocation of a lv_t on stack
+ *                 (Anders Gustafsson)
  *
  */
 
@@ -270,10 +273,10 @@
 
 static int lvm_do_pv_create(pv_t *, vg_t *, ulong);
 static int lvm_do_pv_remove(vg_t *, ulong);
-static int lvm_do_lv_create(int, char *, lv_t *);
-static int lvm_do_lv_extend_reduce(int, char *, lv_t *);
+static int lvm_do_lv_create(int, char *, userlv_t *);
+static int lvm_do_lv_extend_reduce(int, char *, userlv_t *);
 static int lvm_do_lv_remove(int, char *, int);
-static int lvm_do_lv_rename(vg_t *, lv_req_t *, lv_t *);
+static int lvm_do_lv_rename(vg_t *, lv_req_t *, userlv_t *);
 static int lvm_do_lv_status_byname(vg_t *r, void *);
 static int lvm_do_lv_status_byindex(vg_t *, void *);
 static int lvm_do_lv_status_bydev(vg_t *, void *);
@@ -549,7 +552,7 @@
 	int minor = minor(inode->i_rdev);
 	uint extendable, l, v;
 	void *arg = (void *) a;
-	lv_t lv;
+	userlv_t ulv;
 	vg_t* vg_ptr = vg[VG_CHR(minor)];
 
 	/* otherwise cc will complain about unused variables */
@@ -685,21 +688,21 @@
 			return -EFAULT;
 
 		if (command != LV_REMOVE) {
-			if (copy_from_user(&lv, lv_req.lv, sizeof(lv_t)) != 0)
+			if (copy_from_user(&ulv, lv_req.lv, sizeof(userlv_t)) != 0)
 				return -EFAULT;
 		}
 		switch (command) {
 		case LV_CREATE:
-			return lvm_do_lv_create(minor, lv_req.lv_name, &lv);
+			return lvm_do_lv_create(minor, lv_req.lv_name, &ulv);
 
 		case LV_EXTEND:
 		case LV_REDUCE:
-			return lvm_do_lv_extend_reduce(minor, lv_req.lv_name, &lv);
+			return lvm_do_lv_extend_reduce(minor, lv_req.lv_name, &ulv);
 		case LV_REMOVE:
 			return lvm_do_lv_remove(minor, lv_req.lv_name, -1);
 
 		case LV_RENAME:
-			return lvm_do_lv_rename(vg_ptr, &lv_req, &lv);
+			return lvm_do_lv_rename(vg_ptr, &lv_req, &ulv);
 		}
 
 
@@ -811,27 +814,27 @@
 	    LV_BLK(minor) < vg_ptr->lv_max) {
 
 		/* Check parallel LV spindown (LV remove) */
-		if (lv_ptr->lv_status & LV_SPINDOWN) return -EPERM;
+		if (lv_ptr->u.lv_status & LV_SPINDOWN) return -EPERM;
 
 		/* Check inactive LV and open for read/write */
 		/* We need to be able to "read" an inactive LV
 		   to re-activate it again */
 		if ((file->f_mode & FMODE_WRITE) &&
-		    (!(lv_ptr->lv_status & LV_ACTIVE)))
+		    (!(lv_ptr->u.lv_status & LV_ACTIVE)))
 		    return -EPERM;
 
-		if (!(lv_ptr->lv_access & LV_WRITE) &&
+		if (!(lv_ptr->u.lv_access & LV_WRITE) &&
 		    (file->f_mode & FMODE_WRITE))
 			return -EACCES;
 
 
                 /* be sure to increment VG counter */
-		if (lv_ptr->lv_open == 0) vg_ptr->lv_open++;
-		lv_ptr->lv_open++;
+		if (lv_ptr->u.lv_open == 0) vg_ptr->lv_open++;
+		lv_ptr->u.lv_open++;
 
 		MOD_INC_USE_COUNT;
 
-		P_DEV("blk_open OK, LV size %d\n", lv_ptr->lv_size);
+		P_DEV("blk_open OK, LV size %d\n", lv_ptr->u.lv_size);
 
 		return 0;
 	}
@@ -862,13 +865,13 @@
 
 	case BLKGETSIZE:
 		/* return device size */
-		P_IOCTL("BLKGETSIZE: %u\n", lv_ptr->lv_size);
-		if (put_user(lv_ptr->lv_size, (unsigned long *)arg))
+		P_IOCTL("BLKGETSIZE: %u\n", lv_ptr->u.lv_size);
+		if (put_user(lv_ptr->u.lv_size, (unsigned long *)arg))
 			return -EFAULT;
 		break;
 
 	case BLKGETSIZE64:
-		if (put_user((u64)lv_ptr->lv_size << 9, (u64 *)arg))
+		if (put_user((u64)lv_ptr->u.lv_size << 9, (u64 *)arg))
 			return -EFAULT;
 		break;
 
@@ -894,14 +897,14 @@
 		if ((long) arg < LVM_MIN_READ_AHEAD ||
 		    (long) arg > LVM_MAX_READ_AHEAD)
 			return -EINVAL;
-		lv_ptr->lv_read_ahead = (long) arg;
+		lv_ptr->u.lv_read_ahead = (long) arg;
 		break;
 
 
 	case BLKRAGET:
 		/* get current read ahead setting */
-		P_IOCTL("BLKRAGET %d\n", lv_ptr->lv_read_ahead);
-		if (put_user(lv_ptr->lv_read_ahead, (long *)arg))
+		P_IOCTL("BLKRAGET %d\n", lv_ptr->u.lv_read_ahead);
+		if (put_user(lv_ptr->u.lv_read_ahead, (long *)arg))
 			return -EFAULT;
 		break;
 
@@ -915,7 +918,7 @@
 			unsigned char heads = 64;
 			unsigned char sectors = 32;
 			long start = 0;
-			short cylinders = lv_ptr->lv_size / heads / sectors;
+			short cylinders = lv_ptr->u.lv_size / heads / sectors;
 
 			if (copy_to_user((char *) &hd->heads, &heads,
 					 sizeof(heads)) != 0 ||
@@ -936,26 +939,26 @@
 	case LV_SET_ACCESS:
 		/* set access flags of a logical volume */
 		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-		lv_ptr->lv_access = (ulong) arg;
-		if ( lv_ptr->lv_access & LV_WRITE)
-			set_device_ro(lv_ptr->lv_dev, 0);
+		lv_ptr->u.lv_access = (ulong) arg;
+		if ( lv_ptr->u.lv_access & LV_WRITE)
+			set_device_ro(lv_ptr->u.lv_dev, 0);
 		else
-			set_device_ro(lv_ptr->lv_dev, 1);
+			set_device_ro(lv_ptr->u.lv_dev, 1);
 		break;
 
 
 	case LV_SET_STATUS:
 		/* set status flags of a logical volume */
 		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-		if (!((ulong) arg & LV_ACTIVE) && lv_ptr->lv_open > 1)
+		if (!((ulong) arg & LV_ACTIVE) && lv_ptr->u.lv_open > 1)
 			return -EPERM;
-		lv_ptr->lv_status = (ulong) arg;
+		lv_ptr->u.lv_status = (ulong) arg;
 		break;
 
 	case LV_BMAP:
                 /* turn logical block into (dev_t, block).  non privileged. */
                 /* don't bmap a snapshot, since the mapping can change */
-		if(lv_ptr->lv_access & LV_SNAPSHOT)
+		if(lv_ptr->u.lv_access & LV_SNAPSHOT)
 			return -EPERM;
 
 		return lvm_user_bmap(inode, (struct lv_bmap *) arg);
@@ -963,7 +966,7 @@
 	case LV_SET_ALLOCATION:
 		/* set allocation flags of a logical volume */
 		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-		lv_ptr->lv_allocation = (ulong) arg;
+		lv_ptr->u.lv_allocation = (ulong) arg;
 		break;
 
 	case LV_SNAPSHOT_USE_RATE:
@@ -992,8 +995,8 @@
 	P_DEV("blk_close MINOR: %d  VG#: %d  LV#: %d\n",
 	      minor, VG_BLK(minor), LV_BLK(minor));
 
-	if (lv_ptr->lv_open == 1) vg_ptr->lv_open--;
-	lv_ptr->lv_open--;
+	if (lv_ptr->u.lv_open == 1) vg_ptr->lv_open--;
+	lv_ptr->u.lv_open--;
 
 	MOD_DEC_USE_COUNT;
 
@@ -1004,7 +1007,7 @@
 {
 	lv_snapshot_use_rate_req_t lv_rate_req;
 
-	if (!(lv->lv_access & LV_SNAPSHOT))
+	if (!(lv->u.lv_access & LV_SNAPSHOT))
 		return -EPERM;
 
 	if (copy_from_user(&lv_rate_req, arg, sizeof(lv_rate_req)))
@@ -1016,7 +1019,7 @@
 	switch (lv_rate_req.block) {
 	case 0:
 		lv->lv_snapshot_use_rate = lv_rate_req.rate;
-		if (lv->lv_remap_ptr * 100 / lv->lv_remap_end <
+		if (lv->u.lv_remap_ptr * 100 / lv->u.lv_remap_end <
 		    lv->lv_snapshot_use_rate)
 			interruptible_sleep_on(&lv->lv_snapshot_wait);
 		break;
@@ -1027,7 +1030,7 @@
 	default:
 		return -EINVAL;
 	}
-	lv_rate_req.rate = lv->lv_remap_ptr * 100 / lv->lv_remap_end;
+	lv_rate_req.rate = lv->u.lv_remap_ptr * 100 / lv->u.lv_remap_end;
 
 	return copy_to_user(arg, &lv_rate_req,
 			    sizeof(lv_rate_req)) ? -EFAULT : 0;
@@ -1044,7 +1047,7 @@
 
 	memset(&bio,0,sizeof(bio));
 	bio.bi_dev = inode->i_rdev;
-	bio.bi_size = lvm_get_blksize(bio.bi_dev); /* NEEDED by bio_sectors */
+	bio.bi_size = block_size(bio.bi_dev); /* NEEDED by bio_sectors */
  	bio.bi_sector = block * bio_sectors(&bio);
 	bio.bi_rw = READ;
 	if ((err=lvm_map(&bio)) < 0)  {
@@ -1134,18 +1137,18 @@
 	int rw = bio_rw(bi);
 
 	down_read(&lv->lv_lock);
-	if (!(lv->lv_status & LV_ACTIVE)) {
+	if (!(lv->u.lv_status & LV_ACTIVE)) {
 		printk(KERN_ALERT
 		       "%s - lvm_map: ll_rw_blk for inactive LV %s\n",
-		       lvm_name, lv->lv_name);
+		       lvm_name, lv->u.lv_name);
 		goto bad;
 	}
 
 	if ((rw == WRITE || rw == WRITEA) &&
-	    !(lv->lv_access & LV_WRITE)) {
+	    !(lv->u.lv_access & LV_WRITE)) {
 		printk(KERN_CRIT
 		       "%s - lvm_map: ll_rw_blk write for readonly LV %s\n",
-		       lvm_name, lv->lv_name);
+		       lvm_name, lv->u.lv_name);
 		goto bad;
 	}
 
@@ -1154,7 +1157,7 @@
 	      kdevname(bi->bi_dev),
 	      rsector_org, size);
 
-	if (rsector_org + size > lv->lv_size) {
+	if (rsector_org + size > lv->u.lv_size) {
 		printk(KERN_ALERT
 		       "%s - lvm_map access beyond end of device; *rsector: "
                        "%lu or size: %lu wrong for minor: %2d\n",
@@ -1163,39 +1166,39 @@
 	}
 
 
-	if (lv->lv_stripes < 2) { /* linear mapping */
+	if (lv->u.lv_stripes < 2) { /* linear mapping */
 		/* get the index */
 		index = rsector_org / vg_this->pe_size;
-		pe_start = lv->lv_current_pe[index].pe;
-		rsector_map = lv->lv_current_pe[index].pe +
+		pe_start = lv->u.lv_current_pe[index].pe;
+		rsector_map = lv->u.lv_current_pe[index].pe +
 			(rsector_org % vg_this->pe_size);
-		rdev_map = lv->lv_current_pe[index].dev;
+		rdev_map = lv->u.lv_current_pe[index].dev;
 
-		P_MAP("lv_current_pe[%ld].pe: %d  rdev: %s  rsector:%ld\n",
-		      index, lv->lv_current_pe[index].pe,
+		P_MAP("u.lv_current_pe[%ld].pe: %d  rdev: %s  rsector:%ld\n",
+		      index, lv->u.lv_current_pe[index].pe,
 		      kdevname(rdev_map), rsector_map);
 
 	} else {		/* striped mapping */
 		ulong stripe_index;
 		ulong stripe_length;
 
-		stripe_length = vg_this->pe_size * lv->lv_stripes;
+		stripe_length = vg_this->pe_size * lv->u.lv_stripes;
 		stripe_index = (rsector_org % stripe_length) /
-			lv->lv_stripesize;
+			lv->u.lv_stripesize;
 		index = rsector_org / stripe_length +
-			(stripe_index % lv->lv_stripes) *
-			(lv->lv_allocated_le / lv->lv_stripes);
-		pe_start = lv->lv_current_pe[index].pe;
-		rsector_map = lv->lv_current_pe[index].pe +
+			(stripe_index % lv->u.lv_stripes) *
+			(lv->u.lv_allocated_le / lv->u.lv_stripes);
+		pe_start = lv->u.lv_current_pe[index].pe;
+		rsector_map = lv->u.lv_current_pe[index].pe +
 			(rsector_org % stripe_length) -
-			(stripe_index % lv->lv_stripes) * lv->lv_stripesize -
-			stripe_index / lv->lv_stripes *
-			(lv->lv_stripes - 1) * lv->lv_stripesize;
-		rdev_map = lv->lv_current_pe[index].dev;
+			(stripe_index % lv->u.lv_stripes) * lv->u.lv_stripesize -
+			stripe_index / lv->u.lv_stripes *
+			(lv->u.lv_stripes - 1) * lv->u.lv_stripesize;
+		rdev_map = lv->u.lv_current_pe[index].dev;
 
-		P_MAP("lv_current_pe[%ld].pe: %d  rdev: %s  rsector:%ld\n"
+		P_MAP("u.lv_current_pe[%ld].pe: %d  rdev: %s  rsector:%ld\n"
 		      "stripe_length: %ld  stripe_index: %ld\n",
-		      index, lv->lv_current_pe[index].pe, kdevname(rdev_map),
+		      index, lv->u.lv_current_pe[index].pe, kdevname(rdev_map),
 		      rsector_map, stripe_length, stripe_index);
 	}
 
@@ -1212,16 +1215,16 @@
 			return 0;
 		}
 
-		lv->lv_current_pe[index].writes++;	/* statistic */
+		lv->u.lv_current_pe[index].writes++;	/* statistic */
 	} else
-		lv->lv_current_pe[index].reads++;	/* statistic */
+		lv->u.lv_current_pe[index].reads++;	/* statistic */
 
 	/* snapshot volume exception handling on physical device address base */
-	if (!(lv->lv_access & (LV_SNAPSHOT|LV_SNAPSHOT_ORG)))
+	if (!(lv->u.lv_access & (LV_SNAPSHOT|LV_SNAPSHOT_ORG)))
 		goto out;
 
-	if (lv->lv_access & LV_SNAPSHOT) { /* remap snapshot */
-		if (lv->lv_block_exception)
+	if (lv->u.lv_access & LV_SNAPSHOT) { /* remap snapshot */
+		if (lv->u.lv_block_exception)
 			lvm_snapshot_remap_block(&rdev_map, &rsector_map,
 						 pe_start, lv);
 		else
@@ -1232,10 +1235,10 @@
 
 		/* start with first snapshot and loop through all of
 		   them */
-		for (snap = lv->lv_snapshot_next; snap;
-		     snap = snap->lv_snapshot_next) {
+		for (snap = lv->u.lv_snapshot_next; snap;
+		     snap = snap->u.lv_snapshot_next) {
 			/* Check for inactive snapshot */
-			if (!(snap->lv_status & LV_ACTIVE))
+			if (!(snap->u.lv_status & LV_ACTIVE))
 				continue;
 
 			/* Serializes the COW with the accesses to the
@@ -1274,8 +1277,8 @@
 	if (vg[VG_BLK(minor)] == NULL ||
 	    (lv_ptr = vg[VG_BLK(minor)]->lv[LV_BLK(minor)]) == NULL)
 		return;
-	len = strlen(lv_ptr->lv_name) - 5;
-	memcpy(buf, &lv_ptr->lv_name[5], len);
+	len = strlen(lv_ptr->u.lv_name) - 5;
+	memcpy(buf, &lv_ptr->u.lv_name[5], len);
 	buf[len] = 0;
 	return;
 }
@@ -1360,7 +1363,7 @@
 			return -EBUSY;
 		}
 
-		/* Should we do to_kdev_t() on the pv_dev and lv_dev??? */
+		/* Should we do to_kdev_t() on the pv_dev and u.lv_dev??? */
 		pe_lock_req.lock = LOCK_PE;
 		pe_lock_req.data.lv_dev = new_lock.data.lv_dev;
 		pe_lock_req.data.pv_dev = new_lock.data.pv_dev;
@@ -1407,16 +1410,16 @@
 	for (l = 0; l < vg_ptr->lv_max; l++) {
 		lv_ptr = vg_ptr->lv[l];
 		if (lv_ptr != NULL &&
-		    strcmp(lv_ptr->lv_name,
+		    strcmp(lv_ptr->u.lv_name,
 			       le_remap_req.lv_name) == 0) {
-			for (le = 0; le < lv_ptr->lv_allocated_le; le++) {
-			  if (kdev_same(lv_ptr->lv_current_pe[le].dev,
+			for (le = 0; le < lv_ptr->u.lv_allocated_le; le++) {
+			  if (kdev_same(lv_ptr->u.lv_current_pe[le].dev,
 					le_remap_req.old_dev) &&
-				    lv_ptr->lv_current_pe[le].pe ==
+				    lv_ptr->u.lv_current_pe[le].pe ==
 				    le_remap_req.old_pe) {
-					lv_ptr->lv_current_pe[le].dev =
+					lv_ptr->u.lv_current_pe[le].dev =
 					    le_remap_req.new_dev;
-					lv_ptr->lv_current_pe[le].pe =
+					lv_ptr->u.lv_current_pe[le].pe =
 					    le_remap_req.new_pe;
 
 					__update_hardsectsize(lv_ptr);
@@ -1532,7 +1535,7 @@
 		
 		/* user space address */
 		if ((lvp = vg_ptr->lv[l]) != NULL) {
-			if (copy_from_user(tmplv, lvp, sizeof(lv_t)) != 0) {
+			if (copy_from_user(tmplv, lvp, sizeof(userlv_t)) != 0) {
 				P_IOCTL("ERROR: copying LV ptr %p (%d bytes)\n",
 					lvp, sizeof(lv_t));
 				lvm_do_vg_remove(minor);
@@ -1540,7 +1543,7 @@
 				kfree(tmplv);
 				return -EFAULT;
 			}
-			if ( tmplv->lv_access & LV_SNAPSHOT) {
+			if ( tmplv->u.lv_access & LV_SNAPSHOT) {
 				snap_lv_ptr[ls] = lvp;
 				vg_ptr->lv[l] = NULL;
 				ls++;
@@ -1548,7 +1551,7 @@
 			}
 			vg_ptr->lv[l] = NULL;
 			/* only create original logical volumes for now */
-			if (lvm_do_lv_create(minor, tmplv->lv_name, tmplv) != 0) {
+			if (lvm_do_lv_create(minor, tmplv->u.lv_name, &tmplv->u) != 0) {
 				lvm_do_vg_remove(minor);
 				vfree(snap_lv_ptr);
 				kfree(tmplv);
@@ -1561,13 +1564,13 @@
 	   in place during first path above */
 	for (l = 0; l < ls; l++) {
 		lv_t *lvp = snap_lv_ptr[l];
-		if (copy_from_user(tmplv, lvp, sizeof(lv_t)) != 0) {
+		if (copy_from_user(tmplv, lvp, sizeof(userlv_t)) != 0) {
 			lvm_do_vg_remove(minor);
 			vfree(snap_lv_ptr);
 			kfree(tmplv);
 			return -EFAULT;
 		}
-		if (lvm_do_lv_create(minor, tmplv->lv_name, tmplv) != 0) {
+		if (lvm_do_lv_create(minor, tmplv->u.lv_name, &tmplv->u) != 0) {
 			lvm_do_vg_remove(minor);
 			vfree(snap_lv_ptr);
 			kfree(tmplv);
@@ -1666,15 +1669,15 @@
 	for ( l = 0; l < vg_ptr->lv_max; l++)
 	{
 		if ((lv_ptr = vg_ptr->lv[l]) == NULL) continue;
-		strncpy(lv_ptr->vg_name, vg_name, sizeof ( vg_name));
-		ptr = strrchr(lv_ptr->lv_name, '/');
-		if (ptr == NULL) ptr = lv_ptr->lv_name;
+		strncpy(lv_ptr->u.vg_name, vg_name, sizeof ( vg_name));
+		ptr = strrchr(lv_ptr->u.lv_name, '/');
+		if (ptr == NULL) ptr = lv_ptr->u.lv_name;
 		strncpy(lv_name, ptr, sizeof ( lv_name));
 		len = sizeof(LVM_DIR_PREFIX);
-		strcpy(lv_ptr->lv_name, LVM_DIR_PREFIX);
-		strncat(lv_ptr->lv_name, vg_name, NAME_LEN - len);
+		strcpy(lv_ptr->u.lv_name, LVM_DIR_PREFIX);
+		strncat(lv_ptr->u.lv_name, vg_name, NAME_LEN - len);
 		len += strlen ( vg_name);
-		strncat(lv_ptr->lv_name, lv_name, NAME_LEN - len);
+		strncat(lv_ptr->u.lv_name, lv_name, NAME_LEN - len);
 	}
 	for ( p = 0; p < vg_ptr->pv_max; p++)
 	{
@@ -1716,7 +1719,7 @@
 	/* first free snapshot logical volumes */
 	for (i = 0; i < vg_ptr->lv_max; i++) {
 		if (vg_ptr->lv[i] != NULL &&
-		    vg_ptr->lv[i]->lv_access & LV_SNAPSHOT) {
+		    vg_ptr->lv[i]->u.lv_access & LV_SNAPSHOT) {
 			lvm_do_lv_remove(minor, NULL, i);
 			current->state = TASK_UNINTERRUPTIBLE;
 			schedule_timeout(1);
@@ -1819,8 +1822,8 @@
 	int le, e;
 	int max_hardsectsize = 0, hardsectsize;
 
-	for (le = 0; le < lv->lv_allocated_le; le++) {
-		hardsectsize = get_hardsect_size(lv->lv_current_pe[le].dev);
+	for (le = 0; le < lv->u.lv_allocated_le; le++) {
+		hardsectsize = get_hardsect_size(lv->u.lv_current_pe[le].dev);
 		if (hardsectsize == 0)
 			hardsectsize = 512;
 		if (hardsectsize > max_hardsectsize)
@@ -1828,10 +1831,10 @@
 	}
 
 	/* only perform this operation on active snapshots */
-	if ((lv->lv_access & LV_SNAPSHOT) &&
-	    (lv->lv_status & LV_ACTIVE)) {
-		for (e = 0; e < lv->lv_remap_end; e++) {
-			hardsectsize = get_hardsect_size( lv->lv_block_exception[e].rdev_new);
+	if ((lv->u.lv_access & LV_SNAPSHOT) &&
+	    (lv->u.lv_status & LV_ACTIVE)) {
+		for (e = 0; e < lv->u.lv_remap_end; e++) {
+			hardsectsize = get_hardsect_size( lv->u.lv_block_exception[e].rdev_new);
 			if (hardsectsize == 0)
 				hardsectsize = 512;
 			if (hardsectsize > max_hardsectsize)
@@ -1843,31 +1846,31 @@
 /*
  * character device support function logical volume create
  */
-static int lvm_do_lv_create(int minor, char *lv_name, lv_t *lv)
+static int lvm_do_lv_create(int minor, char *lv_name, userlv_t *ulv)
 {
 	int e, ret, l, le, l_new, p, size, activate = 1;
 	ulong lv_status_save;
-	lv_block_exception_t *lvbe = lv->lv_block_exception;
+	lv_block_exception_t *lvbe = ulv->lv_block_exception;
 	vg_t *vg_ptr = vg[VG_CHR(minor)];
 	lv_t *lv_ptr = NULL;
 	pe_t *pep;
 
-	if (!(pep = lv->lv_current_pe))
+	if (!(pep = ulv->lv_current_pe))
 		return -EINVAL;
 
-	if (_sectors_to_k(lv->lv_chunk_size) > LVM_SNAPSHOT_MAX_CHUNK)
+	if (_sectors_to_k(ulv->lv_chunk_size) > LVM_SNAPSHOT_MAX_CHUNK)
 		return -EINVAL;
 
 	for (l = 0; l < vg_ptr->lv_cur; l++) {
 		if (vg_ptr->lv[l] != NULL &&
-		    strcmp(vg_ptr->lv[l]->lv_name, lv_name) == 0)
+		    strcmp(vg_ptr->lv[l]->u.lv_name, lv_name) == 0)
 			return -EEXIST;
 	}
 
 	/* in case of lv_remove(), lv_create() pair */
 	l_new = -1;
-	if (vg_ptr->lv[lv->lv_number] == NULL)
-		l_new = lv->lv_number;
+	if (vg_ptr->lv[ulv->lv_number] == NULL)
+		l_new = ulv->lv_number;
 	else {
 		for (l = 0; l < vg_ptr->lv_max; l++) {
 			if (vg_ptr->lv[l] == NULL)
@@ -1883,16 +1886,16 @@
 		return -ENOMEM;
 	}
 	/* copy preloaded LV */
-	memcpy((char *) lv_ptr, (char *) lv, sizeof(lv_t));
+	memcpy((char *) lv_ptr, (char *) ulv, sizeof(userlv_t));
 
-	lv_status_save = lv_ptr->lv_status;
-	lv_ptr->lv_status &= ~LV_ACTIVE;
-	lv_ptr->lv_snapshot_org = NULL;
-	lv_ptr->lv_snapshot_prev = NULL;
-	lv_ptr->lv_snapshot_next = NULL;
-	lv_ptr->lv_block_exception = NULL;
+	lv_status_save = lv_ptr->u.lv_status;
+	lv_ptr->u.lv_status &= ~LV_ACTIVE;
+	lv_ptr->u.lv_snapshot_org = NULL;
+	lv_ptr->u.lv_snapshot_prev = NULL;
+	lv_ptr->u.lv_snapshot_next = NULL;
+	lv_ptr->u.lv_block_exception = NULL;
 	lv_ptr->lv_iobuf = NULL;
-       lv_ptr->lv_COW_table_iobuf = NULL;
+	lv_ptr->lv_COW_table_iobuf = NULL;
 	lv_ptr->lv_snapshot_hash_table = NULL;
 	lv_ptr->lv_snapshot_hash_table_size = 0;
 	lv_ptr->lv_snapshot_hash_mask = 0;
@@ -1904,10 +1907,10 @@
 
 	/* get the PE structures from user space if this
 	   is not a snapshot logical volume */
-	if (!(lv_ptr->lv_access & LV_SNAPSHOT)) {
-		size = lv_ptr->lv_allocated_le * sizeof(pe_t);
+	if (!(lv_ptr->u.lv_access & LV_SNAPSHOT)) {
+		size = lv_ptr->u.lv_allocated_le * sizeof(pe_t);
 
-		if ((lv_ptr->lv_current_pe = vmalloc(size)) == NULL) {
+		if ((lv_ptr->u.lv_current_pe = vmalloc(size)) == NULL) {
 			printk(KERN_CRIT
 			       "%s -- LV_CREATE: vmalloc error LV_CURRENT_PE of %d Byte "
 			       "at line %d\n",
@@ -1917,30 +1920,30 @@
 			vg_ptr->lv[l] = NULL;
 			return -ENOMEM;
 		}
-		if (copy_from_user(lv_ptr->lv_current_pe, pep, size)) {
+		if (copy_from_user(lv_ptr->u.lv_current_pe, pep, size)) {
 			P_IOCTL("ERROR: copying PE ptr %p (%d bytes)\n",
 				pep, sizeof(size));
-			vfree(lv_ptr->lv_current_pe);
+			vfree(lv_ptr->u.lv_current_pe);
 			kfree(lv_ptr);
 			vg_ptr->lv[l] = NULL;
 			return -EFAULT;
 		}
 		/* correct the PE count in PVs */
-		for (le = 0; le < lv_ptr->lv_allocated_le; le++) {
+		for (le = 0; le < lv_ptr->u.lv_allocated_le; le++) {
 			vg_ptr->pe_allocated++;
 			for (p = 0; p < vg_ptr->pv_cur; p++) {
 				if (kdev_same(vg_ptr->pv[p]->pv_dev,
-					      lv_ptr->lv_current_pe[le].dev))
+					      lv_ptr->u.lv_current_pe[le].dev))
 					vg_ptr->pv[p]->pe_allocated++;
 			}
 		}
 	} else {
 		/* Get snapshot exception data and block list */
 		if (lvbe != NULL) {
-			lv_ptr->lv_snapshot_org =
-			    vg_ptr->lv[LV_BLK(lv_ptr->lv_snapshot_minor)];
-			if (lv_ptr->lv_snapshot_org != NULL) {
-				size = lv_ptr->lv_remap_end * sizeof(lv_block_exception_t);
+			lv_ptr->u.lv_snapshot_org =
+			    vg_ptr->lv[LV_BLK(lv_ptr->u.lv_snapshot_minor)];
+			if (lv_ptr->u.lv_snapshot_org != NULL) {
+				size = lv_ptr->u.lv_remap_end * sizeof(lv_block_exception_t);
 
 				if(!size) {
 					printk(KERN_WARNING
@@ -1950,7 +1953,7 @@
 					return -EINVAL;
 				}
 
-				if ((lv_ptr->lv_block_exception = vmalloc(size)) == NULL) {
+				if ((lv_ptr->u.lv_block_exception = vmalloc(size)) == NULL) {
 					printk(KERN_CRIT
 					       "%s -- lvm_do_lv_create: vmalloc error LV_BLOCK_EXCEPTION "
 					       "of %d byte at line %d\n",
@@ -1961,14 +1964,14 @@
 					vg_ptr->lv[l] = NULL;
 					return -ENOMEM;
 				}
-				if (copy_from_user(lv_ptr->lv_block_exception, lvbe, size)) {
-					vfree(lv_ptr->lv_block_exception);
+				if (copy_from_user(lv_ptr->u.lv_block_exception, lvbe, size)) {
+					vfree(lv_ptr->u.lv_block_exception);
 					kfree(lv_ptr);
 					vg_ptr->lv[l] = NULL;
 					return -EFAULT;
 				}
 
-				if(lv_ptr->lv_block_exception[0].rsector_org ==
+				if(lv_ptr->u.lv_block_exception[0].rsector_org ==
 				   LVM_SNAPSHOT_DROPPED_SECTOR)
 				{
 					printk(KERN_WARNING
@@ -1979,36 +1982,36 @@
 
 
 				/* point to the original logical volume */
-				lv_ptr = lv_ptr->lv_snapshot_org;
+				lv_ptr = lv_ptr->u.lv_snapshot_org;
 
-				lv_ptr->lv_snapshot_minor = 0;
-				lv_ptr->lv_snapshot_org = lv_ptr;
+				lv_ptr->u.lv_snapshot_minor = 0;
+				lv_ptr->u.lv_snapshot_org = lv_ptr;
 				/* our new one now back points to the previous last in the chain
 				   which can be the original logical volume */
 				lv_ptr = vg_ptr->lv[l];
 				/* now lv_ptr points to our new last snapshot logical volume */
-				lv_ptr->lv_current_pe = lv_ptr->lv_snapshot_org->lv_current_pe;
-				lv_ptr->lv_allocated_snapshot_le = lv_ptr->lv_allocated_le;
-				lv_ptr->lv_allocated_le = lv_ptr->lv_snapshot_org->lv_allocated_le;
-				lv_ptr->lv_current_le = lv_ptr->lv_snapshot_org->lv_current_le;
-				lv_ptr->lv_size = lv_ptr->lv_snapshot_org->lv_size;
-				lv_ptr->lv_stripes = lv_ptr->lv_snapshot_org->lv_stripes;
-				lv_ptr->lv_stripesize = lv_ptr->lv_snapshot_org->lv_stripesize;
+				lv_ptr->u.lv_current_pe = lv_ptr->u.lv_snapshot_org->u.lv_current_pe;
+				lv_ptr->lv_allocated_snapshot_le = lv_ptr->u.lv_allocated_le;
+				lv_ptr->u.lv_allocated_le = lv_ptr->u.lv_snapshot_org->u.lv_allocated_le;
+				lv_ptr->u.lv_current_le = lv_ptr->u.lv_snapshot_org->u.lv_current_le;
+				lv_ptr->u.lv_size = lv_ptr->u.lv_snapshot_org->u.lv_size;
+				lv_ptr->u.lv_stripes = lv_ptr->u.lv_snapshot_org->u.lv_stripes;
+				lv_ptr->u.lv_stripesize = lv_ptr->u.lv_snapshot_org->u.lv_stripesize;
 
 				/* Update the VG PE(s) used by snapshot reserve space. */
 				vg_ptr->pe_allocated += lv_ptr->lv_allocated_snapshot_le;
 
 				if ((ret = lvm_snapshot_alloc(lv_ptr)) != 0)
 				{
-					vfree(lv_ptr->lv_block_exception);
+					vfree(lv_ptr->u.lv_block_exception);
 					kfree(lv_ptr);
 					vg_ptr->lv[l] = NULL;
 					return ret;
 				}
-				for ( e = 0; e < lv_ptr->lv_remap_ptr; e++)
-					lvm_hash_link (lv_ptr->lv_block_exception + e,
-						       lv_ptr->lv_block_exception[e].rdev_org,
-						       lv_ptr->lv_block_exception[e].rsector_org, lv_ptr);
+				for ( e = 0; e < lv_ptr->u.lv_remap_ptr; e++)
+					lvm_hash_link (lv_ptr->u.lv_block_exception + e,
+						       lv_ptr->u.lv_block_exception[e].rdev_org,
+						       lv_ptr->u.lv_block_exception[e].rsector_org, lv_ptr);
 				/* need to fill the COW exception table data
 				   into the page for disk i/o */
                                if(lvm_snapshot_fill_COW_page(vg_ptr, lv_ptr)) {
@@ -2027,62 +2030,62 @@
 			vg_ptr->lv[l] = NULL;
 			return -EINVAL;
 		}
-	} /* if ( vg[VG_CHR(minor)]->lv[l]->lv_access & LV_SNAPSHOT) */
+	} /* if ( vg[VG_CHR(minor)]->lv[l]->u.lv_access & LV_SNAPSHOT) */
 
 	lv_ptr = vg_ptr->lv[l];
-	lvm_gendisk.part[minor(lv_ptr->lv_dev)].start_sect = 0;
-	lvm_gendisk.part[minor(lv_ptr->lv_dev)].nr_sects = lv_ptr->lv_size;
-	lvm_size[minor(lv_ptr->lv_dev)] = lv_ptr->lv_size >> 1;
-	vg_lv_map[minor(lv_ptr->lv_dev)].vg_number = vg_ptr->vg_number;
-	vg_lv_map[minor(lv_ptr->lv_dev)].lv_number = lv_ptr->lv_number;
-	LVM_CORRECT_READ_AHEAD(lv_ptr->lv_read_ahead);
+	lvm_gendisk.part[minor(lv_ptr->u.lv_dev)].start_sect = 0;
+	lvm_gendisk.part[minor(lv_ptr->u.lv_dev)].nr_sects = lv_ptr->u.lv_size;
+	lvm_size[minor(lv_ptr->u.lv_dev)] = lv_ptr->u.lv_size >> 1;
+	vg_lv_map[minor(lv_ptr->u.lv_dev)].vg_number = vg_ptr->vg_number;
+	vg_lv_map[minor(lv_ptr->u.lv_dev)].lv_number = lv_ptr->u.lv_number;
+	LVM_CORRECT_READ_AHEAD(lv_ptr->u.lv_read_ahead);
 	vg_ptr->lv_cur++;
-	lv_ptr->lv_status = lv_status_save;
+	lv_ptr->u.lv_status = lv_status_save;
 
 	__update_hardsectsize(lv_ptr);
 
 	/* optionally add our new snapshot LV */
-	if (lv_ptr->lv_access & LV_SNAPSHOT) {
-		lv_t *org = lv_ptr->lv_snapshot_org, *last;
+	if (lv_ptr->u.lv_access & LV_SNAPSHOT) {
+		lv_t *org = lv_ptr->u.lv_snapshot_org, *last;
 
 		/* sync the original logical volume */
-		fsync_dev(org->lv_dev);
+		fsync_dev(org->u.lv_dev);
 #ifdef	LVM_VFS_ENHANCEMENT
 		/* VFS function call to sync and lock the filesystem */
-		fsync_dev_lockfs(org->lv_dev);
+		fsync_dev_lockfs(org->u.lv_dev);
 #endif
 
 		down_write(&org->lv_lock);
-		org->lv_access |= LV_SNAPSHOT_ORG;
-		lv_ptr->lv_access &= ~LV_SNAPSHOT_ORG; /* this can only hide an userspace bug */
+		org->u.lv_access |= LV_SNAPSHOT_ORG;
+		lv_ptr->u.lv_access &= ~LV_SNAPSHOT_ORG; /* this can only hide an userspace bug */
 
 		/* Link in the list of snapshot volumes */
-		for (last = org; last->lv_snapshot_next; last = last->lv_snapshot_next);
-		lv_ptr->lv_snapshot_prev = last;
-		last->lv_snapshot_next = lv_ptr;
+		for (last = org; last->u.lv_snapshot_next; last = last->u.lv_snapshot_next);
+		lv_ptr->u.lv_snapshot_prev = last;
+		last->u.lv_snapshot_next = lv_ptr;
 		up_write(&org->lv_lock);
 	}
 
 	/* activate the logical volume */
 	if(activate)
-		lv_ptr->lv_status |= LV_ACTIVE;
+		lv_ptr->u.lv_status |= LV_ACTIVE;
 	else
-		lv_ptr->lv_status &= ~LV_ACTIVE;
+		lv_ptr->u.lv_status &= ~LV_ACTIVE;
 
-	if ( lv_ptr->lv_access & LV_WRITE)
-		set_device_ro(lv_ptr->lv_dev, 0);
+	if ( lv_ptr->u.lv_access & LV_WRITE)
+		set_device_ro(lv_ptr->u.lv_dev, 0);
 	else
-		set_device_ro(lv_ptr->lv_dev, 1);
+		set_device_ro(lv_ptr->u.lv_dev, 1);
 
 #ifdef	LVM_VFS_ENHANCEMENT
 /* VFS function call to unlock the filesystem */
-	if (lv_ptr->lv_access & LV_SNAPSHOT)
-		unlockfs(lv_ptr->lv_snapshot_org->lv_dev);
+	if (lv_ptr->u.lv_access & LV_SNAPSHOT)
+		unlockfs(lv_ptr->u.lv_snapshot_org->u.lv_dev);
 #endif
 
 	lv_ptr->vg = vg_ptr;
 
-	lvm_gendisk.part[minor(lv_ptr->lv_dev)].de =
+	lvm_gendisk.part[minor(lv_ptr->u.lv_dev)].de =
 		lvm_fs_create_lv(vg_ptr, lv_ptr);
 
 	return 0;
@@ -2101,7 +2104,7 @@
 	if (l == -1) {
 		for (l = 0; l < vg_ptr->lv_max; l++) {
 			if (vg_ptr->lv[l] != NULL &&
-			    strcmp(vg_ptr->lv[l]->lv_name, lv_name) == 0) {
+			    strcmp(vg_ptr->lv[l]->u.lv_name, lv_name) == 0) {
 				break;
 			}
 		}
@@ -2110,38 +2113,38 @@
 
 	lv_ptr = vg_ptr->lv[l];
 #ifdef LVM_TOTAL_RESET
-	if (lv_ptr->lv_open > 0 && lvm_reset_spindown == 0)
+	if (lv_ptr->u.lv_open > 0 && lvm_reset_spindown == 0)
 #else
-	if (lv_ptr->lv_open > 0)
+	if (lv_ptr->u.lv_open > 0)
 #endif
 		return -EBUSY;
 
 	/* check for deletion of snapshot source while
 	   snapshot volume still exists */
-	if ((lv_ptr->lv_access & LV_SNAPSHOT_ORG) &&
-	    lv_ptr->lv_snapshot_next != NULL)
+	if ((lv_ptr->u.lv_access & LV_SNAPSHOT_ORG) &&
+	    lv_ptr->u.lv_snapshot_next != NULL)
 		return -EPERM;
 
 	lvm_fs_remove_lv(vg_ptr, lv_ptr);
 
-	if (lv_ptr->lv_access & LV_SNAPSHOT) {
+	if (lv_ptr->u.lv_access & LV_SNAPSHOT) {
 		/*
 		 * Atomically make the the snapshot invisible
 		 * to the original lv before playing with it.
 		 */
-		lv_t * org = lv_ptr->lv_snapshot_org;
+		lv_t * org = lv_ptr->u.lv_snapshot_org;
 		down_write(&org->lv_lock);
 
 		/* remove this snapshot logical volume from the chain */
-		lv_ptr->lv_snapshot_prev->lv_snapshot_next = lv_ptr->lv_snapshot_next;
-		if (lv_ptr->lv_snapshot_next != NULL) {
-			lv_ptr->lv_snapshot_next->lv_snapshot_prev =
-			    lv_ptr->lv_snapshot_prev;
+		lv_ptr->u.lv_snapshot_prev->u.lv_snapshot_next = lv_ptr->u.lv_snapshot_next;
+		if (lv_ptr->u.lv_snapshot_next != NULL) {
+			lv_ptr->u.lv_snapshot_next->u.lv_snapshot_prev =
+			    lv_ptr->u.lv_snapshot_prev;
 		}
 
 		/* no more snapshots? */
-		if (!org->lv_snapshot_next) {
-			org->lv_access &= ~LV_SNAPSHOT_ORG;
+		if (!org->u.lv_snapshot_next) {
+			org->u.lv_access &= ~LV_SNAPSHOT_ORG;
 		}
 		up_write(&org->lv_lock);
 
@@ -2151,41 +2154,41 @@
 		vg_ptr->pe_allocated -= lv_ptr->lv_allocated_snapshot_le;
 	}
 
-	lv_ptr->lv_status |= LV_SPINDOWN;
+	lv_ptr->u.lv_status |= LV_SPINDOWN;
 
 	/* sync the buffers */
-	fsync_dev(lv_ptr->lv_dev);
+	fsync_dev(lv_ptr->u.lv_dev);
 
-	lv_ptr->lv_status &= ~LV_ACTIVE;
+	lv_ptr->u.lv_status &= ~LV_ACTIVE;
 
 	/* invalidate the buffers */
-	invalidate_buffers(lv_ptr->lv_dev);
+	invalidate_buffers(lv_ptr->u.lv_dev);
 
 	/* reset generic hd */
-	lvm_gendisk.part[minor(lv_ptr->lv_dev)].start_sect = -1;
-	lvm_gendisk.part[minor(lv_ptr->lv_dev)].nr_sects = 0;
-	lvm_gendisk.part[minor(lv_ptr->lv_dev)].de = 0;
-	lvm_size[minor(lv_ptr->lv_dev)] = 0;
+	lvm_gendisk.part[minor(lv_ptr->u.lv_dev)].start_sect = -1;
+	lvm_gendisk.part[minor(lv_ptr->u.lv_dev)].nr_sects = 0;
+	lvm_gendisk.part[minor(lv_ptr->u.lv_dev)].de = 0;
+	lvm_size[minor(lv_ptr->u.lv_dev)] = 0;
 
 	/* reset VG/LV mapping */
-	vg_lv_map[minor(lv_ptr->lv_dev)].vg_number = ABS_MAX_VG;
-	vg_lv_map[minor(lv_ptr->lv_dev)].lv_number = -1;
+	vg_lv_map[minor(lv_ptr->u.lv_dev)].vg_number = ABS_MAX_VG;
+	vg_lv_map[minor(lv_ptr->u.lv_dev)].lv_number = -1;
 
 	/* correct the PE count in PVs if this is not a snapshot
            logical volume */
-	if (!(lv_ptr->lv_access & LV_SNAPSHOT)) {
+	if (!(lv_ptr->u.lv_access & LV_SNAPSHOT)) {
 		/* only if this is no snapshot logical volume because
-		   we share the lv_current_pe[] structs with the
+		   we share the u.lv_current_pe[] structs with the
 		   original logical volume */
-		for (le = 0; le < lv_ptr->lv_allocated_le; le++) {
+		for (le = 0; le < lv_ptr->u.lv_allocated_le; le++) {
 			vg_ptr->pe_allocated--;
 			for (p = 0; p < vg_ptr->pv_cur; p++) {
 				if (kdev_same(vg_ptr->pv[p]->pv_dev,
-					      lv_ptr->lv_current_pe[le].dev))
+					      lv_ptr->u.lv_current_pe[le].dev))
 					vg_ptr->pv[p]->pe_allocated--;
 			}
 		}
-		vfree(lv_ptr->lv_current_pe);
+		vfree(lv_ptr->u.lv_current_pe);
 	}
 
 	P_KFREE("%s -- kfree %d\n", lvm_name, __LINE__);
@@ -2203,10 +2206,10 @@
         ulong size;
         lv_block_exception_t *lvbe;
 
-        if (!new_lv->lv_block_exception)
+        if (!new_lv->u.lv_block_exception)
                 return -ENXIO;
 
-        size = new_lv->lv_remap_end * sizeof(lv_block_exception_t);
+        size = new_lv->u.lv_remap_end * sizeof(lv_block_exception_t);
         if ((lvbe = vmalloc(size)) == NULL) {
                 printk(KERN_CRIT
                        "%s -- lvm_do_lv_extend_reduce: vmalloc "
@@ -2215,15 +2218,15 @@
                 return -ENOMEM;
         }
 
-        if ((new_lv->lv_remap_end > old_lv->lv_remap_end) &&
-            (copy_from_user(lvbe, new_lv->lv_block_exception, size))) {
+        if ((new_lv->u.lv_remap_end > old_lv->u.lv_remap_end) &&
+            (copy_from_user(lvbe, new_lv->u.lv_block_exception, size))) {
                 vfree(lvbe);
                 return -EFAULT;
         }
-        new_lv->lv_block_exception = lvbe;
+        new_lv->u.lv_block_exception = lvbe;
 
         if (lvm_snapshot_alloc_hash_table(new_lv)) {
-                vfree(new_lv->lv_block_exception);
+                vfree(new_lv->u.lv_block_exception);
                 return -ENOMEM;
         }
 
@@ -2235,7 +2238,7 @@
         pe_t *pe;
 
         /* allocate space for new pe structures */
-        size = new_lv->lv_current_le * sizeof(pe_t);
+        size = new_lv->u.lv_current_le * sizeof(pe_t);
         if ((pe = vmalloc(size)) == NULL) {
                 printk(KERN_CRIT
                        "%s -- lvm_do_lv_extend_reduce: "
@@ -2245,21 +2248,21 @@
         }
 
         /* get the PE structures from user space */
-        if (copy_from_user(pe, new_lv->lv_current_pe, size)) {
-                if(old_lv->lv_access & LV_SNAPSHOT)
+        if (copy_from_user(pe, new_lv->u.lv_current_pe, size)) {
+                if(old_lv->u.lv_access & LV_SNAPSHOT)
                         vfree(new_lv->lv_snapshot_hash_table);
                 vfree(pe);
                 return -EFAULT;
         }
 
-        new_lv->lv_current_pe = pe;
+        new_lv->u.lv_current_pe = pe;
 
         /* reduce allocation counters on PV(s) */
-        for (l = 0; l < old_lv->lv_allocated_le; l++) {
+        for (l = 0; l < old_lv->u.lv_allocated_le; l++) {
                 vg_ptr->pe_allocated--;
                 for (p = 0; p < vg_ptr->pv_cur; p++) {
 			if (kdev_same(vg_ptr->pv[p]->pv_dev,
-				      old_lv->lv_current_pe[l].dev)) {
+				      old_lv->u.lv_current_pe[l].dev)) {
                                 vg_ptr->pv[p]->pe_allocated--;
                                 break;
                         }
@@ -2267,11 +2270,11 @@
         }
 
         /* extend the PE count in PVs */
-        for (l = 0; l < new_lv->lv_allocated_le; l++) {
+        for (l = 0; l < new_lv->u.lv_allocated_le; l++) {
                 vg_ptr->pe_allocated++;
                 for (p = 0; p < vg_ptr->pv_cur; p++) {
 			if (kdev_same(vg_ptr->pv[p]->pv_dev,
-				      new_lv->lv_current_pe[l].dev)) {
+				      new_lv->u.lv_current_pe[l].dev)) {
                                 vg_ptr->pv[p]->pe_allocated++;
                                 break;
                         }
@@ -2279,30 +2282,30 @@
         }
 
         /* save availiable i/o statistic data */
-        if (old_lv->lv_stripes < 2) {   /* linear logical volume */
-                end = min(old_lv->lv_current_le, new_lv->lv_current_le);
+        if (old_lv->u.lv_stripes < 2) {   /* linear logical volume */
+                end = min(old_lv->u.lv_current_le, new_lv->u.lv_current_le);
                 for (l = 0; l < end; l++) {
-                        new_lv->lv_current_pe[l].reads +=
-                                old_lv->lv_current_pe[l].reads;
+                        new_lv->u.lv_current_pe[l].reads +=
+                                old_lv->u.lv_current_pe[l].reads;
 
-                        new_lv->lv_current_pe[l].writes +=
-                                old_lv->lv_current_pe[l].writes;
+                        new_lv->u.lv_current_pe[l].writes +=
+                                old_lv->u.lv_current_pe[l].writes;
                 }
 
         } else {                /* striped logical volume */
                 uint i, j, source, dest, end, old_stripe_size, new_stripe_size;
 
-                old_stripe_size = old_lv->lv_allocated_le / old_lv->lv_stripes;
-                new_stripe_size = new_lv->lv_allocated_le / new_lv->lv_stripes;
+                old_stripe_size = old_lv->u.lv_allocated_le / old_lv->u.lv_stripes;
+                new_stripe_size = new_lv->u.lv_allocated_le / new_lv->u.lv_stripes;
                 end = min(old_stripe_size, new_stripe_size);
 
                 for (i = source = dest = 0;
-                     i < new_lv->lv_stripes; i++) {
+                     i < new_lv->u.lv_stripes; i++) {
                         for (j = 0; j < end; j++) {
-                                new_lv->lv_current_pe[dest + j].reads +=
-                                    old_lv->lv_current_pe[source + j].reads;
-                                new_lv->lv_current_pe[dest + j].writes +=
-                                    old_lv->lv_current_pe[source + j].writes;
+                                new_lv->u.lv_current_pe[dest + j].reads +=
+                                    old_lv->u.lv_current_pe[source + j].reads;
+                                new_lv->u.lv_current_pe[dest + j].writes +=
+                                    old_lv->u.lv_current_pe[source + j].writes;
                         }
                         source += old_stripe_size;
                         dest += new_stripe_size;
@@ -2312,19 +2315,29 @@
         return 0;
 }
 
-static int lvm_do_lv_extend_reduce(int minor, char *lv_name, lv_t *new_lv)
+static int lvm_do_lv_extend_reduce(int minor, char *lv_name, userlv_t *ulv)
 {
         int r;
         ulong l, e, size;
         vg_t *vg_ptr = vg[VG_CHR(minor)];
         lv_t *old_lv;
+	lv_t *new_lv;
         pe_t *pe;
 
-        if ((pe = new_lv->lv_current_pe) == NULL)
+	if((new_lv = kmalloc(sizeof(lv_t),GFP_KERNEL)) == NULL){
+		printk(KERN_CRIT 
+		       "%s -- LV_EXTEND/REDUCE: kmallor error LV at line %d\n",
+		       lvm_name,__LINE__);
+		return -ENOMEM;
+	}
+	memset(new_lv,0,sizeof(lv_t));
+	memcpy(&new_lv->u,ulv,sizeof(userlv_t));
+
+        if ((pe = new_lv->u.lv_current_pe) == NULL)
                 return -EINVAL;
 
         for (l = 0; l < vg_ptr->lv_max; l++)
-                if (vg_ptr->lv[l] && !strcmp(vg_ptr->lv[l]->lv_name, lv_name))
+                if (vg_ptr->lv[l] && !strcmp(vg_ptr->lv[l]->u.lv_name, lv_name))
                         break;
 
         if (l == vg_ptr->lv_max)
@@ -2332,9 +2345,9 @@
 
         old_lv = vg_ptr->lv[l];
 
-	if (old_lv->lv_access & LV_SNAPSHOT) {
+	if (old_lv->u.lv_access & LV_SNAPSHOT) {
 		/* only perform this operation on active snapshots */
-		if (old_lv->lv_status & LV_ACTIVE)
+		if (old_lv->u.lv_status & LV_ACTIVE)
                 r = __extend_reduce_snapshot(vg_ptr, old_lv, new_lv);
         else
 			r = -EPERM;
@@ -2348,15 +2361,15 @@
         /* copy relevent fields */
 	down_write(&old_lv->lv_lock);
 
-        if(new_lv->lv_access & LV_SNAPSHOT) {
-                size = (new_lv->lv_remap_end > old_lv->lv_remap_end) ?
-                        old_lv->lv_remap_ptr : new_lv->lv_remap_end;
+        if(new_lv->u.lv_access & LV_SNAPSHOT) {
+                size = (new_lv->u.lv_remap_end > old_lv->u.lv_remap_end) ?
+                        old_lv->u.lv_remap_ptr : new_lv->u.lv_remap_end;
                 size *= sizeof(lv_block_exception_t);
-                memcpy(new_lv->lv_block_exception,
-                       old_lv->lv_block_exception, size);
+                memcpy(new_lv->u.lv_block_exception,
+                       old_lv->u.lv_block_exception, size);
 
-                old_lv->lv_remap_end = new_lv->lv_remap_end;
-                old_lv->lv_block_exception = new_lv->lv_block_exception;
+                old_lv->u.lv_remap_end = new_lv->u.lv_remap_end;
+                old_lv->u.lv_block_exception = new_lv->u.lv_block_exception;
                 old_lv->lv_snapshot_hash_table =
                         new_lv->lv_snapshot_hash_table;
                 old_lv->lv_snapshot_hash_table_size =
@@ -2364,40 +2377,40 @@
                 old_lv->lv_snapshot_hash_mask =
                         new_lv->lv_snapshot_hash_mask;
 
-                for (e = 0; e < new_lv->lv_remap_ptr; e++)
-                        lvm_hash_link(new_lv->lv_block_exception + e,
-                                      new_lv->lv_block_exception[e].rdev_org,
-                                    new_lv->lv_block_exception[e].rsector_org,
+                for (e = 0; e < new_lv->u.lv_remap_ptr; e++)
+                        lvm_hash_link(new_lv->u.lv_block_exception + e,
+                                      new_lv->u.lv_block_exception[e].rdev_org,
+                                    new_lv->u.lv_block_exception[e].rsector_org,
                                       new_lv);
 
         } else {
 
-                vfree(old_lv->lv_current_pe);
+                vfree(old_lv->u.lv_current_pe);
                 vfree(old_lv->lv_snapshot_hash_table);
 
-                old_lv->lv_size = new_lv->lv_size;
-                old_lv->lv_allocated_le = new_lv->lv_allocated_le;
-                old_lv->lv_current_le = new_lv->lv_current_le;
-                old_lv->lv_current_pe = new_lv->lv_current_pe;
-                lvm_gendisk.part[minor(old_lv->lv_dev)].nr_sects =
-                        old_lv->lv_size;
-                lvm_size[minor(old_lv->lv_dev)] = old_lv->lv_size >> 1;
+                old_lv->u.lv_size = new_lv->u.lv_size;
+                old_lv->u.lv_allocated_le = new_lv->u.lv_allocated_le;
+                old_lv->u.lv_current_le = new_lv->u.lv_current_le;
+                old_lv->u.lv_current_pe = new_lv->u.lv_current_pe;
+                lvm_gendisk.part[minor(old_lv->u.lv_dev)].nr_sects =
+                        old_lv->u.lv_size;
+                lvm_size[minor(old_lv->u.lv_dev)] = old_lv->u.lv_size >> 1;
 
-                if (old_lv->lv_access & LV_SNAPSHOT_ORG) {
+                if (old_lv->u.lv_access & LV_SNAPSHOT_ORG) {
                         lv_t *snap;
-                        for(snap = old_lv->lv_snapshot_next; snap;
-                            snap = snap->lv_snapshot_next) {
+                        for(snap = old_lv->u.lv_snapshot_next; snap;
+                            snap = snap->u.lv_snapshot_next) {
 				down_write(&snap->lv_lock);
-                                snap->lv_current_pe = old_lv->lv_current_pe;
-                                snap->lv_allocated_le =
-                                        old_lv->lv_allocated_le;
-                                snap->lv_current_le = old_lv->lv_current_le;
-                                snap->lv_size = old_lv->lv_size;
-
-                                lvm_gendisk.part[minor(snap->lv_dev)].nr_sects
-                                        = old_lv->lv_size;
-                                lvm_size[minor(snap->lv_dev)] =
-                                        old_lv->lv_size >> 1;
+                                snap->u.lv_current_pe = old_lv->u.lv_current_pe;
+                                snap->u.lv_allocated_le =
+                                        old_lv->u.lv_allocated_le;
+                                snap->u.lv_current_le = old_lv->u.lv_current_le;
+                                snap->u.lv_size = old_lv->u.lv_size;
+
+                                lvm_gendisk.part[minor(snap->u.lv_dev)].nr_sects
+                                        = old_lv->u.lv_size;
+                                lvm_size[minor(snap->u.lv_dev)] =
+                                        old_lv->u.lv_size >> 1;
                                 __update_hardsectsize(snap);
 				up_write(&snap->lv_lock);
                         }
@@ -2431,27 +2444,27 @@
 
 	for (l = 0; l < vg_ptr->lv_max; l++) {
 		if ((lv_ptr = vg_ptr->lv[l]) != NULL &&
-		    strcmp(lv_ptr->lv_name,
+		    strcmp(lv_ptr->u.lv_name,
 			   lv_status_byname_req.lv_name) == 0) {
 		        /* Save usermode pointers */
-		        if (copy_from_user(&saved_ptr1, &lv_status_byname_req.lv->lv_current_pe, sizeof(void*)) != 0)
+		        if (copy_from_user(&saved_ptr1, &lv_status_byname_req.lv->u.lv_current_pe, sizeof(void*)) != 0)
 				return -EFAULT;
-			if (copy_from_user(&saved_ptr2, &lv_status_byname_req.lv->lv_block_exception, sizeof(void*)) != 0)
+			if (copy_from_user(&saved_ptr2, &lv_status_byname_req.lv->u.lv_block_exception, sizeof(void*)) != 0)
 			        return -EFAULT;
 		        if (copy_to_user(lv_status_byname_req.lv,
 					 lv_ptr,
-					 sizeof(lv_t)) != 0)
+					 sizeof(userlv_t)) != 0)
 				return -EFAULT;
 
 			if (saved_ptr1 != NULL) {
 				if (copy_to_user(saved_ptr1,
-						 lv_ptr->lv_current_pe,
-						 lv_ptr->lv_allocated_le *
+						 lv_ptr->u.lv_current_pe,
+						 lv_ptr->u.lv_allocated_le *
 				       		 sizeof(pe_t)) != 0)
 					return -EFAULT;
 			}
 			/* Restore usermode pointers */
-			if (copy_to_user(&lv_status_byname_req.lv->lv_current_pe, &saved_ptr1, sizeof(void*)) != 0)
+			if (copy_to_user(&lv_status_byname_req.lv->u.lv_current_pe, &saved_ptr1, sizeof(void*)) != 0)
 			        return -EFAULT;
 			return 0;
 		}
@@ -2484,23 +2497,23 @@
 		return -ENXIO;
 
 	/* Save usermode pointers */
-	if (copy_from_user(&saved_ptr1, &lv_status_byindex_req.lv->lv_current_pe, sizeof(void*)) != 0)
+	if (copy_from_user(&saved_ptr1, &lv_status_byindex_req.lv->u.lv_current_pe, sizeof(void*)) != 0)
 	        return -EFAULT;
-	if (copy_from_user(&saved_ptr2, &lv_status_byindex_req.lv->lv_block_exception, sizeof(void*)) != 0)
+	if (copy_from_user(&saved_ptr2, &lv_status_byindex_req.lv->u.lv_block_exception, sizeof(void*)) != 0)
 	        return -EFAULT;
 
-	if (copy_to_user(lv_status_byindex_req.lv, lv_ptr, sizeof(lv_t)) != 0)
+	if (copy_to_user(lv_status_byindex_req.lv, lv_ptr, sizeof(userlv_t)) != 0)
 		return -EFAULT;
 	if (saved_ptr1 != NULL) {
 		if (copy_to_user(saved_ptr1,
-				 lv_ptr->lv_current_pe,
-				 lv_ptr->lv_allocated_le *
+				 lv_ptr->u.lv_current_pe,
+				 lv_ptr->u.lv_allocated_le *
 		       		 sizeof(pe_t)) != 0)
 			return -EFAULT;
 	}
 
 	/* Restore usermode pointers */
-	if (copy_to_user(&lv_status_byindex_req.lv->lv_current_pe, &saved_ptr1, sizeof(void *)) != 0)
+	if (copy_to_user(&lv_status_byindex_req.lv->u.lv_current_pe, &saved_ptr1, sizeof(void *)) != 0)
 	        return -EFAULT;
 
 	return 0;
@@ -2524,7 +2537,7 @@
 
 	for ( l = 0; l < vg_ptr->lv_max; l++) {
 		if ( vg_ptr->lv[l] == NULL) continue;
-		if ( kdev_same(vg_ptr->lv[l]->lv_dev,
+		if ( kdev_same(vg_ptr->lv[l]->u.lv_dev,
 			       to_kdev_t(lv_status_bydev_req.dev)))
 			break;
 	}
@@ -2533,22 +2546,22 @@
 	lv_ptr = vg_ptr->lv[l];
 
 	/* Save usermode pointers */
-	if (copy_from_user(&saved_ptr1, &lv_status_bydev_req.lv->lv_current_pe, sizeof(void*)) != 0)
+	if (copy_from_user(&saved_ptr1, &lv_status_bydev_req.lv->u.lv_current_pe, sizeof(void*)) != 0)
 	        return -EFAULT;
-	if (copy_from_user(&saved_ptr2, &lv_status_bydev_req.lv->lv_block_exception, sizeof(void*)) != 0)
+	if (copy_from_user(&saved_ptr2, &lv_status_bydev_req.lv->u.lv_block_exception, sizeof(void*)) != 0)
 	        return -EFAULT;
 
 	if (copy_to_user(lv_status_bydev_req.lv, lv_ptr, sizeof(lv_t)) != 0)
 		return -EFAULT;
 	if (saved_ptr1 != NULL) {
 		if (copy_to_user(saved_ptr1,
-				 lv_ptr->lv_current_pe,
-				 lv_ptr->lv_allocated_le *
+				 lv_ptr->u.lv_current_pe,
+				 lv_ptr->u.lv_allocated_le *
 		       		 sizeof(pe_t)) != 0)
 			return -EFAULT;
 	}
 	/* Restore usermode pointers */
-	if (copy_to_user(&lv_status_bydev_req.lv->lv_current_pe, &saved_ptr1, sizeof(void *)) != 0)
+	if (copy_to_user(&lv_status_bydev_req.lv->u.lv_current_pe, &saved_ptr1, sizeof(void *)) != 0)
 	        return -EFAULT;
 
 	return 0;
@@ -2558,7 +2571,7 @@
 /*
  * character device support function rename a logical volume
  */
-static int lvm_do_lv_rename(vg_t *vg_ptr, lv_req_t *lv_req, lv_t *lv)
+static int lvm_do_lv_rename(vg_t *vg_ptr, lv_req_t *lv_req, userlv_t *ulv)
 {
 	int l = 0;
 	int ret = 0;
@@ -2567,10 +2580,10 @@
 	for (l = 0; l < vg_ptr->lv_max; l++)
 	{
 		if ( (lv_ptr = vg_ptr->lv[l]) == NULL) continue;
-		if (kdev_same(lv_ptr->lv_dev, lv->lv_dev))
+		if (kdev_same(lv_ptr->u.lv_dev, ulv->lv_dev))
 		{
 			lvm_fs_remove_lv(vg_ptr, lv_ptr);
-			strncpy(lv_ptr->lv_name,
+			strncpy(lv_ptr->u.lv_name,
 				lv_req->lv_name,
 				NAME_LEN);
 			lvm_fs_create_lv(vg_ptr, lv_ptr);
--- linux-2.5.2-pre9-uml/include/linux/lvm.h	Mon Jan  7 21:57:11 2002
+++ linux-2.5.2-pre9-uml-lvm/include/linux/lvm.h	Sun Jan  6 22:35:46 2002
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
 
