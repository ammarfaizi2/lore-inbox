Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287619AbSAEJQs>; Sat, 5 Jan 2002 04:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287623AbSAEJQg>; Sat, 5 Jan 2002 04:16:36 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:44765 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S287619AbSAEJQT>; Sat, 5 Jan 2002 04:16:19 -0500
Date: Sat, 5 Jan 2002 01:16:17 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: linux-raid@vger.kernel.org, torvalds@transmeta.com
Subject: Patch: linux-2.5.2-pre8/drivers/md partial compilation fixes
Message-ID: <20020105011617.A21597@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patches fix the kdev-related compilation
errors in linux-2.5.2/drivers/md, but they do not fix the bio-related
compilation errors, which is a pretty separate task.

	Applying this patch should make life simpler for anyone
attempting to update driver/md to the new kernel.  So, if nobody
complains, I would ask that it be applied to the stock kernel.

	By the way, if possible, please ignore my previously posted
patch for linux-2.5.2-pre8/drivers/md/raid1.c, in favor of the one
included here.  The only difference is that I replaced an instance of
"dev = mk_dev(0,0)" with the more correct "dev = NODEV".  If that
is not convenenient, then feel free to ignore the raid1.c patch
in this set and I will resubmit the one different after pre9 is
released.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="raid.diffs"

diff -u -r linux-2.5.2-pre8/drivers/md/lvm-fs.c linux/drivers/md/lvm-fs.c
--- linux-2.5.2-pre8/drivers/md/lvm-fs.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/md/lvm-fs.c	Sat Jan  5 01:05:24 2002
@@ -172,9 +172,9 @@
 	struct proc_dir_entry *pde;
 	const char *name = _basename(lv->lv_name);
 
-	lv_devfs_handle[MINOR(lv->lv_dev)] = devfs_register(
+	lv_devfs_handle[minor(lv->lv_dev)] = devfs_register(
 		vg_devfs_handle[vg_ptr->vg_number], name,
-		DEVFS_FL_DEFAULT, LVM_BLK_MAJOR, MINOR(lv->lv_dev),
+		DEVFS_FL_DEFAULT, LVM_BLK_MAJOR, minor(lv->lv_dev),
 		S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP,
 		&lvm_blk_dops, NULL);
 
@@ -183,12 +183,12 @@
 		pde->read_proc = _proc_read_lv;
 		pde->data = lv;
 	}
-	return lv_devfs_handle[MINOR(lv->lv_dev)];
+	return lv_devfs_handle[minor(lv->lv_dev)];
 }
 
 void lvm_fs_remove_lv(vg_t *vg_ptr, lv_t *lv) {
-	devfs_unregister(lv_devfs_handle[MINOR(lv->lv_dev)]);
-	lv_devfs_handle[MINOR(lv->lv_dev)] = NULL;
+	devfs_unregister(lv_devfs_handle[minor(lv->lv_dev)]);
+	lv_devfs_handle[minor(lv->lv_dev)] = NULL;
 
 	if(vg_ptr->lv_subdir_pde) {
 		const char *name = _basename(lv->lv_name);
@@ -283,7 +283,7 @@
                              lv->lv_stripesize);
        }
 	sz += sprintf(page + sz, "device:       %02u:%02u\n",
-		      MAJOR(lv->lv_dev), MINOR(lv->lv_dev));
+		      major(lv->lv_dev), minor(lv->lv_dev));
 
 	return sz;
 }
@@ -304,7 +304,7 @@
 	sz += sprintf(page + sz, "PE total:     %u\n", pv->pe_total);
 	sz += sprintf(page + sz, "PE allocated: %u\n", pv->pe_allocated);
 	sz += sprintf(page + sz, "device:       %02u:%02u\n",
-                      MAJOR(pv->pv_dev), MINOR(pv->pv_dev));
+                      major(pv->pv_dev), minor(pv->pv_dev));
 
 	_show_uuid(pv->pv_uuid, uuid, uuid + sizeof(uuid));
 	sz += sprintf(page + sz, "uuid:         %s\n", uuid);
diff -u -r linux-2.5.2-pre8/drivers/md/lvm-snap.c linux/drivers/md/lvm-snap.c
--- linux-2.5.2-pre8/drivers/md/lvm-snap.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/md/lvm-snap.c	Sat Jan  5 01:05:24 2002
@@ -68,7 +68,7 @@
 		if(vg->pv[p] == NULL)
 			continue;
 
-		if(vg->pv[p]->pv_dev == rdev)
+		if(kdev_same(vg->pv[p]->pv_dev, rdev))
 			break;
 
 	}
@@ -77,7 +77,7 @@
 		/* bad news, the snapshot COW table is probably corrupt */
 		printk(KERN_ERR
 		       "%s -- _pv_get_number failed for rdev = %u\n",
-		       lvm_name, rdev);
+		       lvm_name, kdev_t_to_nr(rdev));
 		return -1;
 	}
 
@@ -105,7 +105,7 @@
 
 		exception = list_entry(next, lv_block_exception_t, hash);
 		if (exception->rsector_org == org_start &&
-		    exception->rdev_org == org_dev)
+		    kdev_same(exception->rdev_org, org_dev))
 		{
 			if (i)
 			{
@@ -169,8 +169,10 @@
        /* wipe the snapshot since it's inconsistent now */
        _disable_snapshot(vg, lv_snap);
 
-	for (i = last_dev = 0; i < lv_snap->lv_remap_ptr; i++) {
-		if ( lv_snap->lv_block_exception[i].rdev_new != last_dev) {
+	last_dev = NODEV;
+	for (i = 0; i < lv_snap->lv_remap_ptr; i++) {
+		if ( !kdev_same(lv_snap->lv_block_exception[i].rdev_new,
+				last_dev)) {
 			last_dev = lv_snap->lv_block_exception[i].rdev_new;
 			invalidate_buffers(last_dev);
 		}
@@ -213,7 +215,7 @@
 	struct buffer_head * bh;
 	int sectors_per_block, i, blksize, minor;
 
-	minor = MINOR(dev);
+	minor = minor(dev);
 	blksize = lvm_blocksizes[minor];
 	sectors_per_block = blksize >> 9;
 	nr /= sectors_per_block;
@@ -299,7 +301,8 @@
 		     vg_t *vg, lv_t* lv_snap)
 {
 	const char * reason;
-	unsigned long org_start, snap_start, snap_phys_dev, virt_start, pe_off;
+	kdev_t snap_phys_dev;
+	unsigned long org_start, snap_start, virt_start, pe_off;
 	int idx = lv_snap->lv_remap_ptr, chunk_size = lv_snap->lv_chunk_size;
 	struct kiobuf * iobuf;
 	int blksize_snap, blksize_org, min_blksize, max_blksize;
diff -u -r linux-2.5.2-pre8/drivers/md/lvm.c linux/drivers/md/lvm.c
--- linux-2.5.2-pre8/drivers/md/lvm.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/md/lvm.c	Sat Jan  5 01:05:24 2002
@@ -480,8 +480,8 @@
 	lvm_lock = lvm_snapshot_lock = SPIN_LOCK_UNLOCKED;
 
 	pe_lock_req.lock = UNLOCK_PE;
-	pe_lock_req.data.lv_dev = 0;
-	pe_lock_req.data.pv_dev = 0;
+	pe_lock_req.data.lv_dev = NODEV;
+	pe_lock_req.data.pv_dev = NODEV;
 	pe_lock_req.data.pv_offset = 0;
 
 	/* Initialize VG pointers */
@@ -512,7 +512,7 @@
  */
 static int lvm_chr_open(struct inode *inode, struct file *file)
 {
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int minor = minor(inode->i_rdev);
 
 	P_DEV("chr_open MINOR: %d  VG#: %d  mode: %s%s  lock: %d\n",
 	      minor, VG_CHR(minor), MODE_TO_STR(file->f_mode), lock);
@@ -546,7 +546,7 @@
 static int lvm_chr_ioctl(struct inode *inode, struct file *file,
 		  uint command, ulong a)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	uint extendable, l, v;
 	void *arg = (void *) a;
 	lv_t lv;
@@ -752,7 +752,7 @@
 static int lvm_chr_close(struct inode *inode, struct file *file)
 {
 	P_DEV("chr_close MINOR: %d  VG#: %d\n",
-	      MINOR(inode->i_rdev), VG_CHR(MINOR(inode->i_rdev)));
+	      minor(inode->i_rdev), VG_CHR(minor(inode->i_rdev)));
 
 #ifdef LVM_TOTAL_RESET
 	if (lvm_reset_spindown > 0) {
@@ -792,7 +792,7 @@
  */
 static int lvm_blk_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	lv_t *lv_ptr;
 	vg_t *vg_ptr = vg[VG_BLK(minor)];
 
@@ -845,7 +845,7 @@
 static int lvm_blk_ioctl(struct inode *inode, struct file *file,
 			 uint command, ulong a)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	vg_t *vg_ptr = vg[VG_BLK(minor)];
 	lv_t *lv_ptr = vg_ptr->lv[LV_BLK(minor)];
 	void *arg = (void *) a;
@@ -985,7 +985,7 @@
  */
 static int lvm_blk_close(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	vg_t *vg_ptr = vg[VG_BLK(minor)];
 	lv_t *lv_ptr = vg_ptr->lv[LV_BLK(minor)];
 
@@ -1097,7 +1097,7 @@
  */
 static inline int _should_defer(kdev_t pv, ulong sector, uint32_t pe_size) {
 	return ((pe_lock_req.lock == LOCK_PE) &&
-		(pv == pe_lock_req.data.pv_dev) &&
+		kdev_same(pv, pe_lock_req.data.pv_dev) &&
 		(sector >= pe_lock_req.data.pv_offset) &&
 		(sector < (pe_lock_req.data.pv_offset + pe_size)));
 }
@@ -1122,7 +1122,7 @@
 
 static int lvm_map(struct bio *bi)
 {
-	int minor = MINOR(bi->bi_dev);
+	int minor = minor(bi->bi_dev);
 	ulong index;
 	ulong pe_start;
 	ulong size = bio_sectors(bi);
@@ -1339,7 +1339,8 @@
 	case LOCK_PE:
 		for (p = 0; p < vg_ptr->pv_max; p++) {
 			if (vg_ptr->pv[p] != NULL &&
-			    new_lock.data.pv_dev == vg_ptr->pv[p]->pv_dev)
+			    kdev_same(new_lock.data.pv_dev,
+				      vg_ptr->pv[p]->pv_dev))
 				break;
 		}
 		if (p == vg_ptr->pv_max) return -ENXIO;
@@ -1373,8 +1374,8 @@
 	case UNLOCK_PE:
 		down_write(&_pe_lock);
 		pe_lock_req.lock = UNLOCK_PE;
-		pe_lock_req.data.lv_dev = 0;
-		pe_lock_req.data.pv_dev = 0;
+		pe_lock_req.data.lv_dev = NODEV;
+		pe_lock_req.data.pv_dev = NODEV;
 		pe_lock_req.data.pv_offset = 0;
 		bh = _dequeue_io();
 		up_write(&_pe_lock);
@@ -1409,8 +1410,8 @@
 		    strcmp(lv_ptr->lv_name,
 			       le_remap_req.lv_name) == 0) {
 			for (le = 0; le < lv_ptr->lv_allocated_le; le++) {
-				if (lv_ptr->lv_current_pe[le].dev ==
-				    le_remap_req.old_dev &&
+			  if (kdev_same(lv_ptr->lv_current_pe[le].dev,
+					le_remap_req.old_dev) &&
 				    lv_ptr->lv_current_pe[le].pe ==
 				    le_remap_req.old_pe) {
 					lv_ptr->lv_current_pe[le].dev =
@@ -1928,8 +1929,8 @@
 		for (le = 0; le < lv_ptr->lv_allocated_le; le++) {
 			vg_ptr->pe_allocated++;
 			for (p = 0; p < vg_ptr->pv_cur; p++) {
-				if (vg_ptr->pv[p]->pv_dev ==
-				    lv_ptr->lv_current_pe[le].dev)
+				if (kdev_same(vg_ptr->pv[p]->pv_dev,
+					      lv_ptr->lv_current_pe[le].dev))
 					vg_ptr->pv[p]->pe_allocated++;
 			}
 		}
@@ -2029,11 +2030,11 @@
 	} /* if ( vg[VG_CHR(minor)]->lv[l]->lv_access & LV_SNAPSHOT) */
 
 	lv_ptr = vg_ptr->lv[l];
-	lvm_gendisk.part[MINOR(lv_ptr->lv_dev)].start_sect = 0;
-	lvm_gendisk.part[MINOR(lv_ptr->lv_dev)].nr_sects = lv_ptr->lv_size;
-	lvm_size[MINOR(lv_ptr->lv_dev)] = lv_ptr->lv_size >> 1;
-	vg_lv_map[MINOR(lv_ptr->lv_dev)].vg_number = vg_ptr->vg_number;
-	vg_lv_map[MINOR(lv_ptr->lv_dev)].lv_number = lv_ptr->lv_number;
+	lvm_gendisk.part[minor(lv_ptr->lv_dev)].start_sect = 0;
+	lvm_gendisk.part[minor(lv_ptr->lv_dev)].nr_sects = lv_ptr->lv_size;
+	lvm_size[minor(lv_ptr->lv_dev)] = lv_ptr->lv_size >> 1;
+	vg_lv_map[minor(lv_ptr->lv_dev)].vg_number = vg_ptr->vg_number;
+	vg_lv_map[minor(lv_ptr->lv_dev)].lv_number = lv_ptr->lv_number;
 	LVM_CORRECT_READ_AHEAD(lv_ptr->lv_read_ahead);
 	vg_ptr->lv_cur++;
 	lv_ptr->lv_status = lv_status_save;
@@ -2081,7 +2082,7 @@
 
 	lv_ptr->vg = vg_ptr;
 
-	lvm_gendisk.part[MINOR(lv_ptr->lv_dev)].de =
+	lvm_gendisk.part[minor(lv_ptr->lv_dev)].de =
 		lvm_fs_create_lv(vg_ptr, lv_ptr);
 
 	return 0;
@@ -2161,14 +2162,14 @@
 	invalidate_buffers(lv_ptr->lv_dev);
 
 	/* reset generic hd */
-	lvm_gendisk.part[MINOR(lv_ptr->lv_dev)].start_sect = -1;
-	lvm_gendisk.part[MINOR(lv_ptr->lv_dev)].nr_sects = 0;
-	lvm_gendisk.part[MINOR(lv_ptr->lv_dev)].de = 0;
-	lvm_size[MINOR(lv_ptr->lv_dev)] = 0;
+	lvm_gendisk.part[minor(lv_ptr->lv_dev)].start_sect = -1;
+	lvm_gendisk.part[minor(lv_ptr->lv_dev)].nr_sects = 0;
+	lvm_gendisk.part[minor(lv_ptr->lv_dev)].de = 0;
+	lvm_size[minor(lv_ptr->lv_dev)] = 0;
 
 	/* reset VG/LV mapping */
-	vg_lv_map[MINOR(lv_ptr->lv_dev)].vg_number = ABS_MAX_VG;
-	vg_lv_map[MINOR(lv_ptr->lv_dev)].lv_number = -1;
+	vg_lv_map[minor(lv_ptr->lv_dev)].vg_number = ABS_MAX_VG;
+	vg_lv_map[minor(lv_ptr->lv_dev)].lv_number = -1;
 
 	/* correct the PE count in PVs if this is not a snapshot
            logical volume */
@@ -2179,8 +2180,8 @@
 		for (le = 0; le < lv_ptr->lv_allocated_le; le++) {
 			vg_ptr->pe_allocated--;
 			for (p = 0; p < vg_ptr->pv_cur; p++) {
-				if (vg_ptr->pv[p]->pv_dev ==
-				    lv_ptr->lv_current_pe[le].dev)
+				if (kdev_same(vg_ptr->pv[p]->pv_dev,
+					      lv_ptr->lv_current_pe[le].dev))
 					vg_ptr->pv[p]->pe_allocated--;
 			}
 		}
@@ -2257,8 +2258,8 @@
         for (l = 0; l < old_lv->lv_allocated_le; l++) {
                 vg_ptr->pe_allocated--;
                 for (p = 0; p < vg_ptr->pv_cur; p++) {
-                        if (vg_ptr->pv[p]->pv_dev ==
-                            old_lv->lv_current_pe[l].dev) {
+			if (kdev_same(vg_ptr->pv[p]->pv_dev,
+				      old_lv->lv_current_pe[l].dev)) {
                                 vg_ptr->pv[p]->pe_allocated--;
                                 break;
                         }
@@ -2269,8 +2270,8 @@
         for (l = 0; l < new_lv->lv_allocated_le; l++) {
                 vg_ptr->pe_allocated++;
                 for (p = 0; p < vg_ptr->pv_cur; p++) {
-                        if (vg_ptr->pv[p]->pv_dev ==
-                            new_lv->lv_current_pe[l].dev) {
+			if (kdev_same(vg_ptr->pv[p]->pv_dev,
+				      new_lv->lv_current_pe[l].dev)) {
                                 vg_ptr->pv[p]->pe_allocated++;
                                 break;
                         }
@@ -2378,9 +2379,9 @@
                 old_lv->lv_allocated_le = new_lv->lv_allocated_le;
                 old_lv->lv_current_le = new_lv->lv_current_le;
                 old_lv->lv_current_pe = new_lv->lv_current_pe;
-                lvm_gendisk.part[MINOR(old_lv->lv_dev)].nr_sects =
+                lvm_gendisk.part[minor(old_lv->lv_dev)].nr_sects =
                         old_lv->lv_size;
-                lvm_size[MINOR(old_lv->lv_dev)] = old_lv->lv_size >> 1;
+                lvm_size[minor(old_lv->lv_dev)] = old_lv->lv_size >> 1;
 
                 if (old_lv->lv_access & LV_SNAPSHOT_ORG) {
                         lv_t *snap;
@@ -2393,9 +2394,9 @@
                                 snap->lv_current_le = old_lv->lv_current_le;
                                 snap->lv_size = old_lv->lv_size;
 
-                                lvm_gendisk.part[MINOR(snap->lv_dev)].nr_sects
+                                lvm_gendisk.part[minor(snap->lv_dev)].nr_sects
                                         = old_lv->lv_size;
-                                lvm_size[MINOR(snap->lv_dev)] =
+                                lvm_size[minor(snap->lv_dev)] =
                                         old_lv->lv_size >> 1;
                                 __update_hardsectsize(snap);
 				up_write(&snap->lv_lock);
@@ -2523,7 +2524,9 @@
 
 	for ( l = 0; l < vg_ptr->lv_max; l++) {
 		if ( vg_ptr->lv[l] == NULL) continue;
-		if ( vg_ptr->lv[l]->lv_dev == lv_status_bydev_req.dev) break;
+		if ( kdev_same(vg_ptr->lv[l]->lv_dev,
+			       to_kdev_t(lv_status_bydev_req.dev)))
+			break;
 	}
 
 	if ( l == vg_ptr->lv_max) return -ENXIO;
@@ -2564,7 +2567,7 @@
 	for (l = 0; l < vg_ptr->lv_max; l++)
 	{
 		if ( (lv_ptr = vg_ptr->lv[l]) == NULL) continue;
-		if (lv_ptr->lv_dev == lv->lv_dev)
+		if (kdev_same(lv_ptr->lv_dev, lv->lv_dev))
 		{
 			lvm_fs_remove_lv(vg_ptr, lv_ptr);
 			strncpy(lv_ptr->lv_name,
diff -u -r linux-2.5.2-pre8/drivers/md/md.c linux/drivers/md/md.c
--- linux-2.5.2-pre8/drivers/md/md.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/md/md.c	Sat Jan  5 01:05:24 2002
@@ -30,6 +30,7 @@
 
 #include <linux/module.h>
 #include <linux/config.h>
+#include <linux/linkage.h>
 #include <linux/raid/md.h>
 #include <linux/sysctl.h>
 #include <linux/raid/xor.h>
@@ -139,9 +140,9 @@
 
 void add_mddev_mapping(mddev_t * mddev, kdev_t dev, void *data)
 {
-	unsigned int minor = MINOR(dev);
+	unsigned int minor = minor(dev);
 
-	if (MAJOR(dev) != MD_MAJOR) {
+	if (major(dev) != MD_MAJOR) {
 		MD_BUG();
 		return;
 	}
@@ -155,9 +156,9 @@
 
 void del_mddev_mapping(mddev_t * mddev, kdev_t dev)
 {
-	unsigned int minor = MINOR(dev);
+	unsigned int minor = minor(dev);
 
-	if (MAJOR(dev) != MD_MAJOR) {
+	if (major(dev) != MD_MAJOR) {
 		MD_BUG();
 		return;
 	}
@@ -185,7 +186,7 @@
 {
 	mddev_t *mddev;
 
-	if (MAJOR(dev) != MD_MAJOR) {
+	if (major(dev) != MD_MAJOR) {
 		MD_BUG();
 		return 0;
 	}
@@ -195,7 +196,7 @@
 
 	memset(mddev, 0, sizeof(*mddev));
 
-	mddev->__minor = MINOR(dev);
+	mddev->__minor = minor(dev);
 	init_MUTEX(&mddev->reconfig_sem);
 	init_MUTEX(&mddev->recovery_sem);
 	init_MUTEX(&mddev->resync_sem);
@@ -234,7 +235,7 @@
 	mdk_rdev_t *rdev;
 
 	ITERATE_RDEV(mddev,rdev,tmp) {
-		if (rdev->dev == dev)
+		if (kdev_same(rdev->dev, dev))
 			return rdev;
 	}
 	return NULL;
@@ -251,7 +252,7 @@
 
 	while (tmp != &device_names) {
 		dname = list_entry(tmp, dev_name_t, list);
-		if (dname->dev == dev)
+		if (kdev_same(dname->dev, dev))
 			return dname->name;
 		tmp = tmp->next;
 	}
@@ -266,7 +267,7 @@
 	hd = get_gendisk (dev);
 	dname->name = NULL;
 	if (hd)
-		dname->name = disk_name (hd, MINOR(dev), dname->namebuf);
+		dname->name = disk_name (hd, minor(dev), dname->namebuf);
 	if (!dname->name) {
 		sprintf (dname->namebuf, "[dev %s]", kdevname(dev));
 		dname->name = dname->namebuf;
@@ -284,8 +285,8 @@
 {
 	unsigned int size = 0;
 
-	if (blk_size[MAJOR(dev)])
-		size = blk_size[MAJOR(dev)][MINOR(dev)];
+	if (blk_size[major(dev)])
+		size = blk_size[major(dev)][minor(dev)];
 	if (persistent)
 		size = MD_NEW_SIZE_BLOCKS(size);
 	return size;
@@ -559,10 +560,10 @@
 	struct gendisk *hd = get_gendisk(dev);
 
 	if (!hd)
-		return 0;
+		return NODEV;
 	mask = ~((1 << hd->minor_shift) - 1);
 
-	return MKDEV(MAJOR(dev), MINOR(dev) & mask);
+	return mk_kdev(major(dev), minor(dev) & mask);
 }
 
 static mdk_rdev_t * match_dev_unit(mddev_t *mddev, kdev_t dev)
@@ -571,7 +572,7 @@
 	mdk_rdev_t *rdev;
 
 	ITERATE_RDEV(mddev,rdev,tmp)
-		if (dev_unit(rdev->dev) == dev_unit(dev))
+		if (kdev_same(dev_unit(rdev->dev), dev_unit(dev)))
 			return rdev;
 
 	return NULL;
@@ -678,7 +679,7 @@
 #ifndef MODULE
 	md_autodetect_dev(rdev->dev);
 #endif
-	rdev->dev = 0;
+	rdev->dev = NODEV;
 	rdev->faulty = 0;
 	kfree(rdev);
 }
@@ -731,7 +732,7 @@
 	while (atomic_read(&mddev->recovery_sem.count) != 1)
 		schedule();
 
-	del_mddev_mapping(mddev, MKDEV(MD_MAJOR, mdidx(mddev)));
+	del_mddev_mapping(mddev, mk_kdev(MD_MAJOR, mdidx(mddev)));
 	list_del(&mddev->all_mddevs);
 	INIT_LIST_HEAD(&mddev->all_mddevs);
 	kfree(mddev);
@@ -746,7 +747,7 @@
 static void print_desc(mdp_disk_t *desc)
 {
 	printk(" DISK<N:%d,%s(%d,%d),R:%d,S:%d>\n", desc->number,
-		partition_name(MKDEV(desc->major,desc->minor)),
+		partition_name(mk_kdev(desc->major,desc->minor)),
 		desc->major,desc->minor,desc->raid_disk,desc->state);
 }
 
@@ -880,7 +881,7 @@
 	tmp = all_raid_disks.next;
 	while (tmp != &all_raid_disks) {
 		rdev = list_entry(tmp, mdk_rdev_t, all);
-		if (rdev->dev == dev)
+		if (kdev_same(rdev->dev, dev))
 			return rdev;
 		tmp = tmp->next;
 	}
@@ -965,12 +966,12 @@
 		desc = mddev->sb->disks + i;
 #if 0
 		if (disk_faulty(desc)) {
-			if (MKDEV(desc->major,desc->minor) == rdev->dev)
+			if (mk_kdev(desc->major,desc->minor) == rdev->dev)
 				ok = 1;
 			continue;
 		}
 #endif
-		if (MKDEV(desc->major,desc->minor) == rdev->dev) {
+		if (kdev_same(mk_kdev(desc->major,desc->minor), rdev->dev)) {
 			rdev->sb->this_disk = *desc;
 			rdev->desc_nr = desc->number;
 			ok = 1;
@@ -1105,8 +1106,8 @@
 	rdev->faulty = 0;
 
 	size = 0;
-	if (blk_size[MAJOR(newdev)])
-		size = blk_size[MAJOR(newdev)][MINOR(newdev)];
+	if (blk_size[major(newdev)])
+		size = blk_size[major(newdev)][minor(newdev)];
 	if (!size) {
 		printk(KERN_WARNING "md: %s has zero size, marking faulty!\n",
 				partition_name(newdev));
@@ -1127,11 +1128,11 @@
 		}
 
 		if (rdev->sb->level != -4) {
-			rdev->old_dev = MKDEV(rdev->sb->this_disk.major,
+			rdev->old_dev = mk_kdev(rdev->sb->this_disk.major,
 						rdev->sb->this_disk.minor);
 			rdev->desc_nr = rdev->sb->this_disk.number;
 		} else {
-			rdev->old_dev = MKDEV(0, 0);
+			rdev->old_dev = NODEV;
 			rdev->desc_nr = -1;
 		}
 	}
@@ -1297,7 +1298,7 @@
 		ev2 = md_event(sb);
 		ev3 = ev2;
 		--ev3;
-		if ((rdev->dev != rdev->old_dev) &&
+		if (!kdev_same(rdev->dev, rdev->old_dev) &&
 			((ev1 == ev2) || (ev1 == ev3))) {
 			mdp_disk_t *desc;
 
@@ -1308,15 +1309,15 @@
 				goto abort;
 			}
 			desc = &sb->disks[rdev->desc_nr];
-			if (rdev->old_dev != MKDEV(desc->major, desc->minor)) {
+			if (!kdev_same( rdev->old_dev, mk_kdev(desc->major, desc->minor))) {
 				MD_BUG();
 				goto abort;
 			}
-			desc->major = MAJOR(rdev->dev);
-			desc->minor = MINOR(rdev->dev);
+			desc->major = major(rdev->dev);
+			desc->minor = minor(rdev->dev);
 			desc = &rdev->sb->this_disk;
-			desc->major = MAJOR(rdev->dev);
-			desc->minor = MINOR(rdev->dev);
+			desc->major = major(rdev->dev);
+			desc->minor = minor(rdev->dev);
 		}
 	}
 
@@ -1334,7 +1335,7 @@
 		kdev_t dev;
 
 		desc = sb->disks + i;
-		dev = MKDEV(desc->major, desc->minor);
+		dev = mk_kdev(desc->major, desc->minor);
 
 		/*
 		 * We kick faulty devices/descriptors immediately.
@@ -1356,7 +1357,7 @@
 				break;
 			}
 			if (!found) {
-				if (dev == MKDEV(0,0))
+				if (kdev_none(dev))
 					continue;
 				printk(KERN_WARNING "md%d: removing former faulty %s!\n",
 					mdidx(mddev), partition_name(dev));
@@ -1374,7 +1375,7 @@
 				remove_descriptor(desc, sb);
 		}
 
-		if (dev == MKDEV(0,0))
+		if (kdev_none(dev))
 			continue;
 		/*
 		 * Is this device present in the rdev ring?
@@ -1387,8 +1388,9 @@
 			 * we cannot check rdev->number.
 			 * We can check the device though.
 			 */
-			if ((sb->level == -4) && (rdev->dev ==
-					MKDEV(desc->major,desc->minor))) {
+			if ((sb->level == -4) &&
+			    kdev_same(rdev->dev,
+				      mk_kdev(desc->major,desc->minor))) {
 				found = 1;
 				break;
 			}
@@ -1415,9 +1417,9 @@
 		kdev_t dev;
 
 		desc = sb->disks + i;
-		dev = MKDEV(desc->major, desc->minor);
+		dev = mk_kdev(desc->major, desc->minor);
 
-		if (dev == MKDEV(0,0))
+		if (kdev_none(dev))
 			continue;
 
 		if (disk_faulty(desc)) {
@@ -1481,8 +1483,8 @@
 			 * is the device unique?
 			 */
 			ITERATE_RDEV(mddev,rdev2,tmp2) {
-				if ((rdev2 != rdev) &&
-						(rdev2->dev == rdev->dev)) {
+				if (rdev2 != rdev &&
+				    kdev_same(rdev2->dev, rdev->dev)) {
 					MD_BUG();
 					goto abort;
 				}
@@ -1732,7 +1734,7 @@
 	 * twice as large as sectors.
 	 */
 	md_hd_struct[mdidx(mddev)].start_sect = 0;
-	register_disk(&md_gendisk, MKDEV(MAJOR_NR,mdidx(mddev)),
+	register_disk(&md_gendisk, mk_kdev(MAJOR_NR,mdidx(mddev)),
 			1, &md_fops, md_size[mdidx(mddev)]<<1);
 
 	read_ahead[MD_MAJOR] = 1024;
@@ -1952,7 +1954,7 @@
 		 * mostly sane superblocks. It's time to allocate the
 		 * mddev.
 		 */
-		md_kdev = MKDEV(MD_MAJOR, rdev0->sb->md_minor);
+		md_kdev = mk_kdev(MD_MAJOR, rdev0->sb->md_minor);
 		mddev = kdev_to_mddev(md_kdev);
 		if (mddev) {
 			printk(KERN_WARNING "md: md%d already running, cannot run %s\n",
@@ -1966,7 +1968,7 @@
 			printk(KERN_ERR "md: cannot allocate memory for md drive.\n");
 			break;
 		}
-		if (md_kdev == countdev)
+		if (kdev_same(md_kdev, countdev))
 			atomic_inc(&mddev->active);
 		printk(KERN_INFO "md: created md%d\n", mdidx(mddev));
 		ITERATE_RDEV_GENERIC(candidates,pending,rdev,tmp) {
@@ -2049,11 +2051,11 @@
 		kdev_t dev;
 
 		desc = sb->disks + i;
-		dev = MKDEV(desc->major, desc->minor);
+		dev = mk_kdev(desc->major, desc->minor);
 
-		if (dev == MKDEV(0,0))
+		if (kdev_none(dev))
 			continue;
-		if (dev == startdev)
+		if (kdev_same(dev, startdev))
 			continue;
 		if (md_import_device(dev, 1)) {
 			printk(KERN_WARNING "md: could not import %s, trying to run array nevertheless.\n",
@@ -2178,7 +2180,7 @@
 	mdk_rdev_t *rdev;
 	unsigned int nr;
 	kdev_t dev;
-	dev = MKDEV(info->major,info->minor);
+	dev = mk_kdev(info->major,info->minor);
 
 	if (find_rdev_all(dev)) {
 		printk(KERN_WARNING "md: device %s already used in a RAID array!\n",
@@ -2450,8 +2452,8 @@
 	}
 
 	disk->raid_disk = disk->number;
-	disk->major = MAJOR(dev);
-	disk->minor = MINOR(dev);
+	disk->major = major(dev);
+	disk->minor = minor(dev);
 
 	if (mddev->pers->diskop(mddev, &disk, DISKOP_HOT_ADD_DISK)) {
 		MD_BUG();
@@ -2577,7 +2579,7 @@
 		return -EACCES;
 
 	dev = inode->i_rdev;
-	minor = MINOR(dev);
+	minor = minor(dev);
 	if (minor >= MAX_MD_DEVS) {
 		MD_BUG();
 		return -EINVAL;
@@ -2693,10 +2695,10 @@
 			/*
 			 * possibly make it lock the array ...
 			 */
-			err = autostart_array((kdev_t)arg, dev);
+			err = autostart_array(val_to_kdev(arg), dev);
 			if (err) {
 				printk(KERN_WARNING "md: autostart %s failed!\n",
-					partition_name((kdev_t)arg));
+					partition_name(val_to_kdev(arg)));
 				goto abort;
 			}
 			goto done;
@@ -2801,14 +2803,14 @@
 			goto done_unlock;
 		}
 		case HOT_GENERATE_ERROR:
-			err = hot_generate_error(mddev, (kdev_t)arg);
+			err = hot_generate_error(mddev, val_to_kdev(arg));
 			goto done_unlock;
 		case HOT_REMOVE_DISK:
-			err = hot_remove_disk(mddev, (kdev_t)arg);
+			err = hot_remove_disk(mddev, val_to_kdev(arg));
 			goto done_unlock;
 
 		case HOT_ADD_DISK:
-			err = hot_add_disk(mddev, (kdev_t)arg);
+			err = hot_add_disk(mddev, val_to_kdev(arg));
 			goto done_unlock;
 
 		case SET_DISK_INFO:
@@ -2828,7 +2830,7 @@
 			goto done_unlock;
 
 		case SET_DISK_FAULTY:
-			err = set_disk_faulty(mddev, (kdev_t)arg);
+			err = set_disk_faulty(mddev, val_to_kdev(arg));
 			goto done_unlock;
 
 		case RUN_ARRAY:
@@ -3046,7 +3048,7 @@
 	mdk_rdev_t * rrdev;
 
 	dprintk("md_error dev:(%d:%d), rdev:(%d:%d), (caller: %p,%p,%p,%p).\n",
-		MAJOR(dev),MINOR(dev),MAJOR(rdev),MINOR(rdev),
+		major(dev),minor(dev),major(rdev),minor(rdev),
 		__builtin_return_address(0),__builtin_return_address(1),
 		__builtin_return_address(2),__builtin_return_address(3));
 
@@ -3290,7 +3292,7 @@
 static unsigned int sync_io[DK_MAX_MAJOR][DK_MAX_DISK];
 void md_sync_acct(kdev_t dev, unsigned long nr_sectors)
 {
-	unsigned int major = MAJOR(dev);
+	unsigned int major = major(dev);
 	unsigned int index;
 
 	index = disk_index(dev);
@@ -3309,7 +3311,7 @@
 
 	idle = 1;
 	ITERATE_RDEV(mddev,rdev,tmp) {
-		int major = MAJOR(rdev->dev);
+		int major = major(rdev->dev);
 		int idx = disk_index(rdev->dev);
 
 		if ((idx >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
@@ -3533,7 +3535,7 @@
 		if (!spare)
 			continue;
 		printk(KERN_INFO "md%d: resyncing spare disk %s to replace failed disk\n",
-		       mdidx(mddev), partition_name(MKDEV(spare->major,spare->minor)));
+		       mdidx(mddev), partition_name(mk_kdev(spare->major,spare->minor)));
 		if (!mddev->pers->diskop)
 			continue;
 		if (mddev->pers->diskop(mddev, &spare, DISKOP_SPARE_WRITE))
@@ -3543,7 +3545,7 @@
 		err = md_do_sync(mddev, spare);
 		if (err == -EIO) {
 			printk(KERN_INFO "md%d: spare disk %s failed, skipping to next spare.\n",
-			       mdidx(mddev), partition_name(MKDEV(spare->major,spare->minor)));
+			       mdidx(mddev), partition_name(mk_kdev(spare->major,spare->minor)));
 			if (!disk_faulty(spare)) {
 				mddev->pers->diskop(mddev,&spare,DISKOP_SPARE_INACTIVE);
 				mark_disk_faulty(spare);
@@ -3868,7 +3870,7 @@
 			if (handle != 0) {
 				unsigned major, minor;
 				devfs_get_maj_min(handle, &major, &minor);
-				dev = MKDEV(major, minor);
+				dev = mk_kdev(major, minor);
 			}
 			if (!dev) {
 				printk(KERN_WARNING "md: Unknown device name: %s\n", devname);
@@ -3893,7 +3895,7 @@
 		}
 		printk(KERN_INFO "md: Loading md%d: %s\n", minor, md_setup_args.device_names[minor]);
 
-		mddev = alloc_mddev(MKDEV(MD_MAJOR,minor));
+		mddev = alloc_mddev(mk_kdev(MD_MAJOR,minor));
 		if (!mddev) {
 			printk(KERN_ERR "md: kmalloc failed - cannot start array %d\n", minor);
 			continue;
@@ -3920,8 +3922,8 @@
 				dinfo.number = i;
 				dinfo.raid_disk = i;
 				dinfo.state = (1<<MD_DISK_ACTIVE)|(1<<MD_DISK_SYNC);
-				dinfo.major = MAJOR(dev);
-				dinfo.minor = MINOR(dev);
+				dinfo.major = major(dev);
+				dinfo.minor = minor(dev);
 				mddev->sb->nr_disks++;
 				mddev->sb->raid_disks++;
 				mddev->sb->active_disks++;
@@ -3931,8 +3933,8 @@
 		} else {
 			/* persistent */
 			for (i = 0; (dev = devices[i]); i++) {
-				dinfo.major = MAJOR(dev);
-				dinfo.minor = MINOR(dev);
+				dinfo.major = major(dev);
+				dinfo.minor = minor(dev);
 				add_new_disk (mddev, &dinfo);
 			}
 		}
diff -u -r linux-2.5.2-pre8/drivers/md/multipath.c linux/drivers/md/multipath.c
--- linux-2.5.2-pre8/drivers/md/multipath.c	Mon Nov 12 09:51:56 2001
+++ linux/drivers/md/multipath.c	Sat Jan  5 01:05:24 2002
@@ -21,6 +21,7 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/raid/multipath.h>
 #include <asm/atomic.h>
 
@@ -353,7 +354,7 @@
 		 * which has just failed.
 		 */
 		for (i = 0; i < disks; i++) {
-			if (multipaths[i].dev==dev && !multipaths[i].operational)
+			if (kdev_same(multipaths[i].dev, dev) && !multipaths[i].operational)
 				return 0;
 		}
 		printk (LAST_DISK);
@@ -362,7 +363,7 @@
 		 * Mark disk as unusable
 		 */
 		for (i = 0; i < disks; i++) {
-			if (multipaths[i].dev==dev && multipaths[i].operational) {
+			if (kdev_same(multipaths[i].dev,dev) && multipaths[i].operational) {
 				mark_disk_bad(mddev, i);
 				break;
 			}
@@ -605,7 +606,7 @@
 
 		*d = failed_desc;
 
-		if (sdisk->dev == MKDEV(0,0))
+		if (kdev_none(sdisk->dev))
 			sdisk->used_slot = 0;
 		/*
 		 * this really activates the spare.
@@ -630,7 +631,7 @@
 			err = 1;
 			goto abort;
 		}
-		rdisk->dev = MKDEV(0,0);
+		rdisk->dev = NODEV;
 		rdisk->used_slot = 0;
 		conf->nr_disks--;
 		break;
@@ -647,7 +648,7 @@
 
 		adisk->number = added_desc->number;
 		adisk->raid_disk = added_desc->raid_disk;
-		adisk->dev = MKDEV(added_desc->major,added_desc->minor);
+		adisk->dev = mk_kdev(added_desc->major,added_desc->minor);
 
 		adisk->operational = 0;
 		adisk->spare = 1;
@@ -710,7 +711,7 @@
 		dev = bh->b_dev;
 		
 		multipath_map (mddev, &bh->b_dev);
-		if (bh->b_dev == dev) {
+		if (kdev_same(bh->b_dev, dev)) {
 			printk (IO_ERROR, partition_name(bh->b_dev), bh->b_blocknr);
 			multipath_end_bh_io(mp_bh, 0);
 		} else {
diff -u -r linux-2.5.2-pre8/drivers/md/raid1.c linux/drivers/md/raid1.c
--- linux-2.5.2-pre8/drivers/md/raid1.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/md/raid1.c	Sat Jan  5 01:05:24 2002
@@ -611,7 +611,7 @@
 	 * else mark the drive as failed
 	 */
 	for (i = 0; i < disks; i++)
-		if (mirrors[i].dev == dev && mirrors[i].operational)
+		if (kdev_same(mirrors[i].dev, dev) && mirrors[i].operational)
 			break;
 	if (i == disks)
 		return 0;
@@ -853,7 +853,7 @@
 
 		*d = failed_desc;
 
-		if (sdisk->dev == MKDEV(0,0))
+		if (kdev_none(sdisk->dev))
 			sdisk->used_slot = 0;
 		/*
 		 * this really activates the spare.
@@ -879,7 +879,7 @@
 			err = 1;
 			goto abort;
 		}
-		rdisk->dev = MKDEV(0,0);
+		rdisk->dev = NODEV;
 		rdisk->used_slot = 0;
 		conf->nr_disks--;
 		break;
@@ -896,7 +896,7 @@
 
 		adisk->number = added_desc->number;
 		adisk->raid_disk = added_desc->raid_disk;
-		adisk->dev = MKDEV(added_desc->major, added_desc->minor);
+		adisk->dev = mk_kdev(added_desc->major, added_desc->minor);
 
 		adisk->operational = 0;
 		adisk->write_only = 0;
@@ -1098,7 +1098,7 @@
 		case READA:
 			dev = bio->bi_dev;
 			map(mddev, &bio->bi_dev);
-			if (bio->bi_dev == dev) {
+			if (kdev_same(bio->bi_dev, dev)) {
 				printk(IO_ERROR, partition_name(bio->bi_dev), r1_bio->sector);
 				raid_end_bio_io(r1_bio, 0, 0);
 				break;
@@ -1428,7 +1428,7 @@
 
 			disk->number = descriptor->number;
 			disk->raid_disk = disk_idx;
-			disk->dev = MKDEV(0,0);
+			disk->dev = NODEV;
 
 			disk->operational = 0;
 			disk->write_only = 0;
diff -u -r linux-2.5.2-pre8/drivers/md/raid5.c linux/drivers/md/raid5.c
--- linux-2.5.2-pre8/drivers/md/raid5.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/md/raid5.c	Sat Jan  5 01:05:24 2002
@@ -487,7 +487,7 @@
 	PRINTK("raid5_error called\n");
 
 	for (i = 0, disk = conf->disks; i < conf->raid_disks; i++, disk++) {
-		if (disk->dev == dev) {
+		if (kdev_same(disk->dev, dev)) {
 			if (disk->operational) {
 				disk->operational = 0;
 				mark_disk_faulty(sb->disks+disk->number);
@@ -513,7 +513,7 @@
 	 */
 	if (conf->spare) {
 		disk = conf->spare;
-		if (disk->dev == dev) {
+		if (kdev_same(disk->dev, dev)) {
 			printk (KERN_ALERT
 				"raid5: Disk failure on spare %s\n",
 				partition_name (dev));
@@ -1460,7 +1460,7 @@
 
 			disk->number = desc->number;
 			disk->raid_disk = raid_disk;
-			disk->dev = MKDEV(0,0);
+			disk->dev = NODEV;
 
 			disk->operational = 0;
 			disk->write_only = 0;
@@ -1919,7 +1919,7 @@
 
 		*d = failed_desc;
 
-		if (sdisk->dev == MKDEV(0,0))
+		if (kdev_none(sdisk->dev))
 			sdisk->used_slot = 0;
 
 		/*
@@ -1947,7 +1947,7 @@
 			err = 1;
 			goto abort;
 		}
-		rdisk->dev = MKDEV(0,0);
+		rdisk->dev = NODEV;
 		rdisk->used_slot = 0;
 
 		break;
@@ -1964,7 +1964,7 @@
 
 		adisk->number = added_desc->number;
 		adisk->raid_disk = added_desc->raid_disk;
-		adisk->dev = MKDEV(added_desc->major,added_desc->minor);
+		adisk->dev = mk_kdev(added_desc->major,added_desc->minor);
 
 		adisk->operational = 0;
 		adisk->write_only = 0;
diff -u -r linux-2.5.2-pre8/drivers/md/xor.c linux/drivers/md/xor.c
--- linux-2.5.2-pre8/drivers/md/xor.c	Sun Sep 30 12:26:06 2001
+++ linux/drivers/md/xor.c	Sat Jan  5 01:05:24 2002
@@ -19,6 +19,7 @@
 #define BH_TRACE 0
 #include <linux/module.h>
 #include <linux/raid/md.h>
+#include <linux/raid/md_compatible.h>
 #include <linux/raid/xor.h>
 #include <asm/xor.h>
 

--J2SCkAp4GZ/dPZZf--
