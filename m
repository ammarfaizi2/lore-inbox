Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278718AbRJ1WQb>; Sun, 28 Oct 2001 17:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278714AbRJ1WO5>; Sun, 28 Oct 2001 17:14:57 -0500
Received: from [63.231.122.81] ([63.231.122.81]:26170 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S278708AbRJ1WNk>;
	Sun, 28 Oct 2001 17:13:40 -0500
Date: Sat, 27 Oct 2001 19:08:54 -0600
From: Andreas Dilger <adilger@turbolabs.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: [PATCH] lvm merge
Message-ID: <20011027190853.A4190@lynx.no>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	lvm-devel@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
the attached patch merges a whole bunch of trivial LVM changes from CVS into
the main kernel source.  They are pretty much all changes in formatting or
code reordering with no functional changes, adding comments, and similar.
I haven't checked specifically, but most (or all) of these changes should
also be in Alan's LVM sources already.

There are some one-liner fixes included such as checking for NULL values
and similar stand-alone fixes.

Cheers, Andreas
=============================================================================
--- linux.orig/drivers/md/lvm.c	Thu Oct 25 03:04:38 2001
+++ linux/drivers/md/lvm.c	Sat Oct 27 14:26:43 2001
@@ -1,7 +1,7 @@
 /*
  * kernel/lvm.c
  *
- * Copyright (C) 1997 - 2000  Heinz Mauelshagen, Sistina Software
+ * Copyright (C) 1997 - 2001  Heinz Mauelshagen, Sistina Software
  *
  * February-November 1997
  * April-May,July-August,November 1998
@@ -43,7 +43,8 @@
  *                 support for free (eg. longer) logical volume names
  *    12/05/1998 - added spin_locks (thanks to Pascal van Dam
  *                 <pascal@ramoth.xs4all.nl>)
- *    25/05/1998 - fixed handling of locked PEs in lvm_map() and lvm_chr_ioctl()
+ *    25/05/1998 - fixed handling of locked PEs in lvm_map() and
+ *                 lvm_chr_ioctl()
  *    26/05/1998 - reactivated verify_area by access_ok
  *    07/06/1998 - used vmalloc/vfree instead of kmalloc/kfree to go
  *                 beyond 128/256 KB max allocation limit per call
@@ -125,7 +126,8 @@
  *    14/02/2000 - support for 2.3.43
  *               - integrated Andrea Arcagneli's snapshot code
  *    25/06/2000 - james (chip) , IKKHAYD! roffl
- *    26/06/2000 - enhanced lv_extend_reduce for snapshot logical volume support
+ *    26/06/2000 - enhanced lv_extend_reduce for snapshot logical volume
+ *                 support
  *    06/09/2000 - added devfs support
  *    07/09/2000 - changed IOP version to 9
  *               - started to add new char ioctl LV_STATUS_BYDEV_T to support
@@ -148,6 +150,9 @@
  *                 procfs is always supported now. (JT)
  *    12/01/2001 - avoided flushing logical volume in case of shrinking
  *                 because of unecessary overhead in case of heavy updates
+ *    25/01/2001 - Allow RO open of an inactive LV so it can be reactivated.
+ *               - If you try and BMAP a snapshot you now get an -EPERM
+ *    28/02/2001 - factored lvm_get_snapshot_use_rate out of blk_ioctl [AD]
  *    05/04/2001 - lvm_map bugs: don't use b_blocknr/b_dev in lvm_map, it
  *		   destroys stacking devices. call b_end_io on failed maps.
  *		   (Jens Axboe)
@@ -188,6 +193,9 @@
 #include <linux/blkdev.h>
 #include <linux/genhd.h>
 #include <linux/locks.h>
+
+
+#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 #include <asm/ioctl.h>
 #include <asm/segment.h>
@@ -244,12 +252,12 @@
 static int lvm_blk_ioctl(struct inode *, struct file *, uint, ulong);
 static int lvm_blk_open(struct inode *, struct file *);
 
-static int lvm_chr_open(struct inode *, struct file *);
-
-static int lvm_chr_close(struct inode *, struct file *);
 static int lvm_blk_close(struct inode *, struct file *);
+static int lvm_get_snapshot_use_rate(lv_t *lv_ptr, void *arg);
 static int lvm_user_bmap(struct inode *, struct lv_bmap *);
 
+static int lvm_chr_open(struct inode *, struct file *);
+static int lvm_chr_close(struct inode *, struct file *);
 static int lvm_chr_ioctl(struct inode *, struct file *, uint, ulong);
 
 int lvm_proc_read_vg_info(char *, char **, off_t, int, int *, void *);
@@ -321,7 +329,6 @@
 static devfs_handle_t ch_devfs_handle[MAX_VG];
 static devfs_handle_t lv_devfs_handle[MAX_LV];
 
-static pv_t *pvp = NULL;
 static lv_t *lvp = NULL;
 static pe_t *pep = NULL;
 static pe_t *pep1 = NULL;
@@ -400,20 +406,25 @@
 	nr_real:	MAX_LV,
 };
 
+
 /*
  * Driver initialization...
  */
 int lvm_init(void)
 {
-	if (register_chrdev(LVM_CHAR_MAJOR, lvm_name, &lvm_chr_fops) < 0) {
-		printk(KERN_ERR "%s -- register_chrdev failed\n", lvm_name);
+	if (devfs_register_chrdev(LVM_CHAR_MAJOR,
+				  lvm_name, &lvm_chr_fops) < 0) {
+		printk(KERN_ERR "%s -- devfs_register_chrdev failed\n",
+		       lvm_name);
 		return -EIO;
 	}
-	if (register_blkdev(MAJOR_NR, lvm_name, &lvm_blk_dops) < 0)
+	if (devfs_register_blkdev(MAJOR_NR, lvm_name, &lvm_blk_dops) < 0)
 	{
-		printk("%s -- register_blkdev failed\n", lvm_name);
-		if (unregister_chrdev(LVM_CHAR_MAJOR, lvm_name) < 0)
-			printk(KERN_ERR "%s -- unregister_chrdev failed\n", lvm_name);
+		printk("%s -- devfs_register_blkdev failed\n", lvm_name);
+		if (devfs_unregister_chrdev(LVM_CHAR_MAJOR, lvm_name) < 0)
+			printk(KERN_ERR
+			       "%s -- devfs_unregister_chrdev failed\n",
+			       lvm_name);
 		return -EIO;
 	}
 
@@ -432,6 +445,7 @@
 	lvm_init_vars();
 	lvm_geninit(&lvm_gendisk);
 
+	/* insert our gendisk at the corresponding major */
 	add_gendisk(&lvm_gendisk);
 
 #ifdef LVM_HD_NAME
@@ -447,35 +461,32 @@
    if ( *rootvg != 0) vg_read_with_pv_and_lv ( rootvg, &vg);
 */
 
-	printk(KERN_INFO
-	       "%s%s -- "
 #ifdef MODULE
-	       "Module"
+	printk(KERN_INFO "%s module loaded\n", lvm_version);
 #else
-	       "Driver"
+	printk(KERN_INFO "%s\n", lvm_version);
 #endif
-	       " successfully initialized\n",
-	       lvm_version, lvm_name);
 
 	return 0;
 } /* lvm_init() */
 
-
 /*
  * cleanup...
  */
+
 static void lvm_cleanup(void)
 {
 	devfs_unregister (lvm_devfs_handle);
+	if (devfs_unregister_chrdev(LVM_CHAR_MAJOR, lvm_name) < 0)
+		printk(KERN_ERR "%s -- devfs_unregister_chrdev failed\n",
+		       lvm_name);
+	if (devfs_unregister_blkdev(MAJOR_NR, lvm_name) < 0)
+		printk(KERN_ERR "%s -- devfs_unregister_blkdev failed\n",
+		       lvm_name);
 
-	if (unregister_chrdev(LVM_CHAR_MAJOR, lvm_name) < 0) {
-		printk(KERN_ERR "%s -- unregister_chrdev failed\n", lvm_name);
-	}
-	if (unregister_blkdev(MAJOR_NR, lvm_name) < 0) {
-		printk(KERN_ERR "%s -- unregister_blkdev failed\n", lvm_name);
-	}
 
 
+	/* delete our gendisk from chain */
 	del_gendisk(&lvm_gendisk);
 
 	blk_size[MAJOR_NR] = NULL;
@@ -491,16 +502,17 @@
 	lvm_hd_name_ptr = NULL;
 #endif
 
+#ifdef MODULE
 	printk(KERN_INFO "%s -- Module successfully deactivated\n", lvm_name);
+#endif
 
 	return;
 }	/* lvm_cleanup() */
 
-
 /*
  * support function to initialize lvm variables
  */
-void __init lvm_init_vars(void)
+static void __init lvm_init_vars(void)
 {
 	int v;
 
@@ -509,8 +521,8 @@
 	lvm_lock = lvm_snapshot_lock = SPIN_LOCK_UNLOCKED;
 
 	pe_lock_req.lock = UNLOCK_PE;
-	pe_lock_req.data.lv_dev = \
-	pe_lock_req.data.pv_dev = \
+	pe_lock_req.data.lv_dev = 0;
+	pe_lock_req.data.pv_dev = 0;
 	pe_lock_req.data.pv_offset = 0;
 
 	/* Initialize VG pointers */
@@ -533,11 +545,13 @@
  *
  ********************************************************************/
 
+#define MODE_TO_STR(mode) (mode) & FMODE_READ ? "READ" : "", \
+			  (mode) & FMODE_WRITE ? "WRITE" : ""
+
 /*
  * character device open routine
  */
-static int lvm_chr_open(struct inode *inode,
-			struct file *file)
+static int lvm_chr_open(struct inode *inode, struct file *file)
 {
 	int minor = MINOR(inode->i_rdev);
 
@@ -580,9 +600,8 @@
 	/* otherwise cc will complain about unused variables */
 	(void) lvm_lock;
 
-	P_IOCTL("%s -- lvm_chr_ioctl: command: 0x%X  MINOR: %d  "
-		"VG#: %d  mode: 0x%X\n",
-		lvm_name, command, minor, VG_CHR(minor), file->f_mode);
+	P_IOCTL("chr MINOR: %d  command: 0x%X  arg: %p  VG#: %d  mode: %s%s\n",
+		minor, command, arg, VG_CHR(minor), MODE_TO_STR(file->f_mode));
 
 #ifdef LVM_TOTAL_RESET
 	if (lvm_reset_spindown > 0) return -EACCES;
@@ -683,7 +706,7 @@
 
 
 	case VG_STATUS_GET_NAMELIST:
-		/* get volume group count */
+		/* get volume group names */
 		for (l = v = 0; v < ABS_MAX_VG; v++) {
 			if (vg[v] != NULL) {
 				if (copy_to_user(arg + l * NAME_LEN,
@@ -738,6 +761,7 @@
 
 
 	case LV_STATUS_BYDEV:
+		/* get status of a logical volume by device */
 		return lvm_do_lv_status_bydev(vg_ptr, arg);
 
 
@@ -764,7 +777,7 @@
 
 	default:
 		printk(KERN_WARNING
-		       "%s -- lvm_chr_ioctl: unknown command %x\n",
+		       "%s -- lvm_chr_ioctl: unknown command 0x%x\n",
 		       lvm_name, command);
 		return -EINVAL;
 	}
@@ -779,9 +797,8 @@
 static int lvm_chr_close(struct inode *inode, struct file *file)
 {
 #ifdef DEBUG
-	int minor = MINOR(inode->i_rdev);
-	printk(KERN_DEBUG
-	     "%s -- lvm_chr_close   VG#: %d\n", lvm_name, VG_CHR(minor));
+	printk(KERN_DEBUG "%s - lvm_chr_close  VG#:\n",
+	      MINOR(inode->i_rdev), VG_CHR(MINOR(inode->i_rdev)));
 #endif
 
 #ifdef LVM_TOTAL_RESET
@@ -840,8 +859,12 @@
 		if (lv_ptr->lv_status & LV_SPINDOWN) return -EPERM;
 
 		/* Check inactive LV and open for read/write */
-		if (!(lv_ptr->lv_status & LV_ACTIVE))
-			return -EPERM;
+		/* We need to be able to "read" an inactive LV
+		   to re-activate it again */
+		if ((file->f_mode & FMODE_WRITE) &&
+		    (!(lv_ptr->lv_status & LV_ACTIVE)))
+		    return -EPERM;
+
 		if (!(lv_ptr->lv_access & LV_WRITE) &&
 		    (file->f_mode & FMODE_WRITE))
 			return -EACCES;
@@ -878,10 +896,9 @@
 	void *arg = (void *) a;
 	struct hd_geometry *hd = (struct hd_geometry *) a;
 
-	P_IOCTL("%s -- lvm_blk_ioctl MINOR: %d  command: 0x%X  arg: %X  "
-		"VG#: %dl  LV#: %d\n",
-		lvm_name, minor, command, (ulong) arg,
-		VG_BLK(minor), LV_BLK(minor));
+	P_IOCTL("blk MINOR: %d  command: 0x%X  arg: %p  VG#: %d  LV#: %d  "
+		"mode: %s%s\n", minor, command, arg, VG_BLK(minor),
+		LV_BLK(minor), MODE_TO_STR(file->f_mode));
 
 	switch (command) {
 	case BLKSSZGET:
@@ -890,23 +907,23 @@
 
 	case BLKGETSIZE:
 		/* return device size */
-		P_IOCTL("%s -- lvm_blk_ioctl -- BLKGETSIZE: %u\n",
-			lvm_name, lv_ptr->lv_size);
+		P_IOCTL("BLKGETSIZE: %u\n", lv_ptr->lv_size);
 		if (put_user(lv_ptr->lv_size, (unsigned long *)arg))
 			return -EFAULT;
 		break;
 
+#ifdef BLKGETSIZE64
 	case BLKGETSIZE64:
 		if (put_user((u64)lv_ptr->lv_size << 9, (u64 *)arg))
 			return -EFAULT;
 		break;
-
+#endif
 
 	case BLKFLSBUF:
 		/* flush buffer cache */
 		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
 
-		P_IOCTL("%s -- lvm_blk_ioctl -- BLKFLSBUF\n", lvm_name);
+		P_IOCTL("BLKFLSBUF\n");
 
 		fsync_dev(inode->i_rdev);
 		invalidate_buffers(inode->i_rdev);
@@ -917,8 +934,8 @@
 		/* set read ahead for block device */
 		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
 
-		P_IOCTL("%s -- lvm_blk_ioctl -- BLKRASET: %d sectors for %02X:%02X\n",
-			lvm_name, (long) arg, MAJOR(inode->i_rdev), minor);
+		P_IOCTL("BLKRASET: %ld sectors for %s\n",
+			(long) arg, kdevname(inode->i_rdev));
 
 		if ((long) arg < LVM_MIN_READ_AHEAD ||
 		    (long) arg > LVM_MAX_READ_AHEAD)
@@ -930,7 +947,7 @@
 
 	case BLKRAGET:
 		/* get current read ahead setting */
-		P_IOCTL("%s -- lvm_blk_ioctl -- BLKRAGET\n", lvm_name);
+		P_IOCTL("BLKRAGET %d\n", lv_ptr->lv_read_ahead);
 		if (put_user(lv_ptr->lv_read_ahead, (long *)arg))
 			return -EFAULT;
 		break;
@@ -956,10 +973,10 @@
 			    copy_to_user((long *) &hd->start, &start,
 					 sizeof(start)) != 0)
 				return -EFAULT;
-		}
 
-		P_IOCTL("%s -- lvm_blk_ioctl -- cylinders: %d\n",
-			lvm_name, lv_ptr->lv_size / heads / sectors);
+			P_IOCTL("%s -- lvm_blk_ioctl -- cylinders: %d\n",
+				lvm_name, cylinders);
+		}
 		break;
 
 
@@ -1077,6 +1093,7 @@
 	bh.b_blocknr = block;
 	bh.b_dev = bh.b_rdev = inode->i_rdev;
 	bh.b_size = lvm_get_blksize(bh.b_dev);
+	bh.b_rsector = block * (bh.b_size >> 9);
 	if ((err=lvm_map(&bh, READ)) < 0)  {
 		printk("lvm map failed: %d\n", err);
 		return -EINVAL;
@@ -1796,7 +1481,7 @@
 /*
  * character device support function VGDA create
  */
-int lvm_do_vg_create(int minor, void *arg)
+static int lvm_do_vg_create(int minor, void *arg)
 {
 	int ret = 0;
 	ulong l, ls = 0, p, size;
@@ -1804,8 +1489,6 @@
 	vg_t *vg_ptr;
 	lv_t **snap_lv_ptr;
 
-	if (vg[VG_CHR(minor)] != NULL) return -EPERM;
-
 	if ((vg_ptr = kmalloc(sizeof(vg_t),GFP_KERNEL)) == NULL) {
 		printk(KERN_CRIT
 		       "%s -- VG_CREATE: kmalloc error VG at line %d\n",
@@ -1814,35 +1497,45 @@
 	}
 	/* get the volume group structure */
 	if (copy_from_user(vg_ptr, arg, sizeof(vg_t)) != 0) {
+		P_IOCTL("lvm_do_vg_create ERROR: copy VG ptr %p (%d bytes)\n",
+			arg, sizeof(vg_t));
 		kfree(vg_ptr);
 		return -EFAULT;
 	}
 
+	/* Validate it */
+	if (vg[VG_CHR(minor)] != NULL) {
+		P_IOCTL("lvm_do_vg_create ERROR: VG %d in use\n", minor);
+		kfree(vg_ptr);
+		return -EPERM;
+	}
+
 	/* we are not that active so far... */
 	vg_ptr->vg_status &= ~VG_ACTIVE;
-	vg[VG_CHR(minor)] = vg_ptr;
-	vg[VG_CHR(minor)]->pe_allocated = 0;
+	vg_ptr->pe_allocated = 0;
 
 	if (vg_ptr->pv_max > ABS_MAX_PV) {
 		printk(KERN_WARNING
 		       "%s -- Can't activate VG: ABS_MAX_PV too small\n",
 		       lvm_name);
 		kfree(vg_ptr);
-		vg[VG_CHR(minor)] = NULL;
 		return -EPERM;
 	}
+
 	if (vg_ptr->lv_max > ABS_MAX_LV) {
 		printk(KERN_WARNING
 		"%s -- Can't activate VG: ABS_MAX_LV too small for %u\n",
 		       lvm_name, vg_ptr->lv_max);
 		kfree(vg_ptr);
-		vg_ptr = NULL;
 		return -EPERM;
 	}
 
+	vg[VG_CHR(minor)] = vg_ptr;
+
 	/* get the physical volume structures */
 	vg_ptr->pv_act = vg_ptr->pv_cur = 0;
 	for (p = 0; p < vg_ptr->pv_max; p++) {
+		pv_t *pvp;
 		/* user space address */
 		if ((pvp = vg_ptr->pv[p]) != NULL) {
 			ret = lvm_do_pv_create(pvp, vg_ptr, p);
@@ -1866,9 +1565,12 @@
 	/* get the logical volume structures */
 	vg_ptr->lv_cur = 0;
 	for (l = 0; l < vg_ptr->lv_max; l++) {
+		lv_t *lvp;
 		/* user space address */
 		if ((lvp = vg_ptr->lv[l]) != NULL) {
 			if (copy_from_user(&lv, lvp, sizeof(lv_t)) != 0) {
+				P_IOCTL("ERROR: copying LV ptr %p (%d bytes)\n",
+					lvp, sizeof(lv_t));
 				lvm_do_vg_remove(minor);
 				return -EFAULT;
 			}
@@ -1892,7 +1592,7 @@
 	/* Second path to correct snapshot logical volumes which are not
 	   in place during first path above */
 	for (l = 0; l < ls; l++) {
-		lvp = snap_lv_ptr[l];
+		lv_t *lvp = snap_lv_ptr[l];
 		if (copy_from_user(&lv, lvp, sizeof(lv_t)) != 0) {
 			lvm_do_vg_remove(minor);
 			return -EFAULT;
@@ -1986,6 +1683,9 @@
 	lv_t *lv_ptr = NULL;
 	pv_t *pv_ptr = NULL;
 
+	/* If the VG doesn't exist in the kernel then just exit */
+	if (!vg_ptr) return 0;
+
 	if (copy_from_user(vg_name, arg, sizeof(vg_name)) != 0)
 		return -EFAULT;
 
@@ -2086,44 +1784,49 @@
  * character device support function physical volume create
  */
 static int lvm_do_pv_create(pv_t *pvp, vg_t *vg_ptr, ulong p) {
-	pv_t *pv_ptr = NULL;
+	pv_t *pv;
 
-	pv_ptr = vg_ptr->pv[p] = kmalloc(sizeof(pv_t),GFP_KERNEL);
-	if (pv_ptr == NULL) {
+	pv = kmalloc(sizeof(pv_t),GFP_KERNEL);
+	if (pv == NULL) {
 		printk(KERN_CRIT
-		       "%s -- VG_CREATE: kmalloc error PV at line %d\n",
+		       "%s -- PV_CREATE: kmalloc error PV at line %d\n",
 		       lvm_name, __LINE__);
 		return -ENOMEM;
 	}
-	if (copy_from_user(pv_ptr, pvp, sizeof(pv_t)) != 0) {
+
+	memset(pv, 0, sizeof(*pv));
+
+	if (copy_from_user(pv, pvp, sizeof(pv_t)) != 0) {
+		P_IOCTL("lvm_do_pv_create ERROR: copy PV ptr %p (%d bytes)\n",
+			pvp, sizeof(pv_t));
+		kfree(pv);
 		return -EFAULT;
 	}
 	/* We don't need the PE list
 	   in kernel space as with LVs pe_t list (see below) */
-	pv_ptr->pe = NULL;
-	pv_ptr->pe_allocated = 0;
-	pv_ptr->pv_status = PV_ACTIVE;
+	pv->pe = NULL;
+	pv->pe_allocated = 0;
+	pv->pv_status = PV_ACTIVE;
 	vg_ptr->pv_act++;
 	vg_ptr->pv_cur++;
 
+	vg_ptr->pv[p] = pv;
 	return 0;
 } /* lvm_do_pv_create() */
 
 
 /*
- * character device support function physical volume create
+ * character device support function physical volume remove
  */
 static int lvm_do_pv_remove(vg_t *vg_ptr, ulong p) {
-	pv_t *pv_ptr = vg_ptr->pv[p];
+	pv_t *pv = vg_ptr->pv[p];
 
-	lvm_do_remove_proc_entry_of_pv ( vg_ptr, pv_ptr);
-	vg_ptr->pe_total -= pv_ptr->pe_total;
+	lvm_do_remove_proc_entry_of_pv ( vg_ptr, pv);
+	vg_ptr->pe_total -= pv->pe_total;
 	vg_ptr->pv_cur--;
 	vg_ptr->pv_act--;
-#ifdef LVM_GET_INODE
-	lvm_clear_inode(pv_ptr->inode);
-#endif
-	kfree(pv_ptr);
+	kfree(pv);
+
 	vg_ptr->pv[p] = NULL;
 
 	return 0;
@@ -2218,8 +1936,8 @@
 
 	lv_status_save = lv_ptr->lv_status;
 	lv_ptr->lv_status &= ~LV_ACTIVE;
-	lv_ptr->lv_snapshot_org = \
-	lv_ptr->lv_snapshot_prev = \
+	lv_ptr->lv_snapshot_org = NULL;
+	lv_ptr->lv_snapshot_prev = NULL;
 	lv_ptr->lv_snapshot_next = NULL;
 	lv_ptr->lv_block_exception = NULL;
 	lv_ptr->lv_iobuf = NULL;
@@ -2232,9 +1950,10 @@
 	vg_ptr->lv[l] = lv_ptr;
 
 	/* get the PE structures from user space if this
-	   is no snapshot logical volume */
+	   is not a snapshot logical volume */
 	if (!(lv_ptr->lv_access & LV_SNAPSHOT)) {
 		size = lv_ptr->lv_allocated_le * sizeof(pe_t);
+
 		if ((lv_ptr->lv_current_pe = vmalloc(size)) == NULL) {
 			printk(KERN_CRIT
 			       "%s -- LV_CREATE: vmalloc error LV_CURRENT_PE of %d Byte "
@@ -2254,6 +1975,8 @@
 			return -ENOMEM;
 		}
 		if (copy_from_user(lv_ptr->lv_current_pe, pep, size)) {
+			P_IOCTL("ERROR: copying PE ptr %p (%d bytes)\n",
+				pep, sizeof(size));
 			vfree(lv_ptr->lv_current_pe);
 			kfree(lv_ptr);
 			vg_ptr->lv[l] = NULL;
@@ -2275,6 +1998,15 @@
 			    vg_ptr->lv[LV_BLK(lv_ptr->lv_snapshot_minor)];
 			if (lv_ptr->lv_snapshot_org != NULL) {
 				size = lv_ptr->lv_remap_end * sizeof(lv_block_exception_t);
+
+				if (!size) {
+					printk(KERN_WARNING
+					       "%s -- zero length exception table requested\n",
+					       lvm_name);
+					kfree(lv_ptr);
+					return -EINVAL;
+				}
+
 				if ((lv_ptr->lv_block_exception = vmalloc(size)) == NULL) {
 					printk(KERN_CRIT
 					       "%s -- lvm_do_lv_create: vmalloc error LV_BLOCK_EXCEPTION "
@@ -2400,9 +2134,8 @@
 
 #ifdef	LVM_VFS_ENHANCEMENT
 /* VFS function call to unlock the filesystem */
-	if (lv_ptr->lv_access & LV_SNAPSHOT) {
+	if (lv_ptr->lv_access & LV_SNAPSHOT)
 		unlockfs(lv_ptr->lv_snapshot_org->lv_dev);
-	}
 #endif
 
 	return 0;
@@ -2848,9 +2617,7 @@
 		if (lv_ptr->lv_dev == lv->lv_dev)
 		{
 			lvm_do_remove_proc_entry_of_lv ( vg_ptr, lv_ptr);
-			strncpy(lv_ptr->lv_name,
-				lv_req->lv_name,
-				NAME_LEN);
+			strncpy(lv_ptr->lv_name, lv_req->lv_name, NAME_LEN);
 			lvm_do_create_proc_entry_of_lv ( vg_ptr, lv_ptr);
 			break;
 		}
@@ -2869,9 +2636,6 @@
 {
 	uint p;
 	pv_t *pv_ptr;
-#ifdef LVM_GET_INODE
-	struct inode *inode_sav;
-#endif
 
 	if (vg_ptr == NULL) return -ENXIO;
 	if (copy_from_user(&pv_change_req, arg,
@@ -2883,20 +2648,14 @@
 		if (pv_ptr != NULL &&
 		    strcmp(pv_ptr->pv_name,
 			       pv_change_req.pv_name) == 0) {
-#ifdef LVM_GET_INODE
-			inode_sav = pv_ptr->inode;
-#endif
 			if (copy_from_user(pv_ptr,
 					   pv_change_req.pv,
 					   sizeof(pv_t)) != 0)
 				return -EFAULT;
 
 			/* We don't need the PE list
 			   in kernel space as with LVs pe_t list */
 			pv_ptr->pe = NULL;
-#ifdef LVM_GET_INODE
-			pv_ptr->inode = inode_sav;
-#endif
 			return 0;
 		}
 	}
--- linux.orig/drivers/md/lvm-snap.c	Thu Oct 25 01:49:46 2001
+++ linux/drivers/md/lvm-snap.c	Thu Oct 25 15:00:38 2001
@@ -2,22 +2,22 @@
  * kernel/lvm-snap.c
  *
  * Copyright (C) 2000 Andrea Arcangeli <andrea@suse.de> SuSE
- *                    Heinz Mauelshagen, Sistina Software (persistent snapshots)
+ *               2000 - 2001 Heinz Mauelshagen, Sistina Software
  *
  * LVM snapshot driver is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2, or (at your option)
  * any later version.
- * 
+ *
  * LVM snapshot driver is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with GNU CC; see the file COPYING.  If not, write to
  * the Free Software Foundation, 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA. 
+ * Boston, MA 02111-1307, USA.
  *
  */
 
@@ -105,10 +143,18 @@
 	unsigned long mask = lv->lv_snapshot_hash_mask;
 	int chunk_size = lv->lv_chunk_size;
 
+	if (!hash_table)
+		BUG();
 	hash_table = &hash_table[hashfn(org_dev, org_start, mask, chunk_size)];
 	list_add(&exception->hash, hash_table);
 }
 
+/*
+ * Determine if we already have a snapshot chunk for this block.
+ * Return: 1 if it the chunk already exists
+ *         0 if we need to COW this block and allocate a new chunk
+ *        -1 if the snapshot was disabled because it ran out of space
+ */
 int lvm_snapshot_remap_block(kdev_t * org_dev, unsigned long * org_sector,
 			     unsigned long pe_start, lv_t * lv)
 {
@@ -118,6 +166,9 @@
 	int chunk_size = lv->lv_chunk_size;
 	lv_block_exception_t * exception;
 
+	if (!lv->lv_block_exception)
+		return -1;
+
 	pe_off = pe_start % chunk_size;
 	pe_adjustment = (*org_sector-pe_off) % chunk_size;
 	__org_start = *org_sector - pe_adjustment;
@@ -150,26 +204,33 @@
 	}
 
 	lvm_snapshot_release(lv_snap);
+	lv_snap->lv_status &= ~LV_ACTIVE;
 
 	printk(KERN_INFO
-	       "%s -- giving up to snapshot %s on %s due %s\n",
+	       "%s -- giving up to snapshot %s on %s: %s\n",
 	       lvm_name, lv_snap->lv_snapshot_org->lv_name, lv_snap->lv_name,
 	       reason);
 }
 
-static inline void lvm_snapshot_prepare_blocks(unsigned long * blocks,
+static inline int lvm_snapshot_prepare_blocks(unsigned long *blocks,
 					       unsigned long start,
 					       int nr_sectors,
 					       int blocksize)
 {
 	int i, sectors_per_block, nr_blocks;
 
-	sectors_per_block = blocksize >> 9;
+	sectors_per_block = blocksize / SECTOR_SIZE;
+
+	if (start & (sectors_per_block - 1))
+		return 0;
+
 	nr_blocks = nr_sectors / sectors_per_block;
 	start /= sectors_per_block;
 
 	for (i = 0; i < nr_blocks; i++)
 		blocks[i] = start++;
+
+	return 1;
 }
 
 inline int lvm_get_blksize(kdev_t dev)
@@ -211,23 +272,34 @@
 
 void lvm_snapshot_fill_COW_page(vg_t * vg, lv_t * lv_snap)
 {
-	int 	id = 0, is = lv_snap->lv_remap_ptr;
-	ulong	blksize_snap;
+	int id = 0, is = lv_snap->lv_remap_ptr;
+	ulong blksize_snap;
 	lv_COW_table_disk_t * lv_COW_table =
 	   ( lv_COW_table_disk_t *) page_address(lv_snap->lv_COW_table_page);
+
+	if (is == 0)
+		return;
 
-	if (is == 0) return;
 	is--;
-        blksize_snap = lvm_get_blksize(lv_snap->lv_block_exception[is].rdev_new);
-        is -= is % (blksize_snap / sizeof(lv_COW_table_disk_t));
+	blksize_snap =
+		lvm_get_blksize(lv_snap->lv_block_exception[is].rdev_new);
+	is -= is % (blksize_snap / sizeof(lv_COW_table_disk_t));
 
 	memset(lv_COW_table, 0, blksize_snap);
 	for ( ; is < lv_snap->lv_remap_ptr; is++, id++) {
 		/* store new COW_table entry */
-		lv_COW_table[id].pv_org_number = cpu_to_le64(lvm_pv_get_number(vg, lv_snap->lv_block_exception[is].rdev_org));
-		lv_COW_table[id].pv_org_rsector = cpu_to_le64(lv_snap->lv_block_exception[is].rsector_org);
-		lv_COW_table[id].pv_snap_number = cpu_to_le64(lvm_pv_get_number(vg, lv_snap->lv_block_exception[is].rdev_new));
-		lv_COW_table[id].pv_snap_rsector = cpu_to_le64(lv_snap->lv_block_exception[is].rsector_new);
+		lv_block_exception_t *be = lv_snap->lv_block_exception + is;
+		uint pvn;
+
+		pvn = lvm_pv_get_number(vg, be->rdev_org);
+
+		lv_COW_table[id].pv_org_number = cpu_to_le64(pvn);
+		lv_COW_table[id].pv_org_rsector = cpu_to_le64(be->rsector_org);
+
+		pvn = lvm_pv_get_number(vg, be->rdev_new);
+
+		lv_COW_table[id].pv_snap_number = cpu_to_le64(pvn);
+		lv_COW_table[id].pv_snap_rsector = cpu_to_le64(be->rsector_new);
 	}
 }
 
@@ -370,13 +369,11 @@
 #ifdef DEBUG_SNAPSHOT
 	printk(KERN_INFO
 	       "%s -- COW: "
-	       "org %02d:%02d faulting %lu start %lu, "
-	       "snap %02d:%02d start %lu, "
+	       "org %s faulting %lu start %lu, snap %s start %lu, "
 	       "size %d, pe_start %lu pe_off %lu, virt_sec %lu\n",
 	       lvm_name,
-	       MAJOR(org_phys_dev), MINOR(org_phys_dev), org_phys_sector,
-	       org_start,
-	       MAJOR(snap_phys_dev), MINOR(snap_phys_dev), snap_start,
+	       kdevname(org_phys_dev), org_phys_sector, org_start,
+	       kdevname(snap_phys_dev), snap_start,
 	       chunk_size,
 	       org_pe_start, pe_off,
 	       org_virt_sector);
@@ -434,52 +441,51 @@
 	return 0;
 
 	/* slow path */
- out:
+out:
 	lvm_drop_snapshot(lv_snap, reason);
 	return 1;
 
- fail_out_of_space:
+fail_out_of_space:
 	reason = "out of space";
 	goto out;
- fail_raw_read:
+fail_raw_read:
 	reason = "read error";
 	goto out;
- fail_raw_write:
+fail_raw_write:
 	reason = "write error";
 	goto out;
- fail_blksize:
+fail_blksize:
 	reason = "blocksize error";
 	goto out;
 }
 
 int lvm_snapshot_alloc_iobuf_pages(struct kiobuf * iobuf, int sectors)
 {
 	int bytes, nr_pages, err, i;
 
-	bytes = sectors << 9;
+	bytes = sectors * SECTOR_SIZE;
 	nr_pages = (bytes + ~PAGE_MASK) >> PAGE_SHIFT;
 	err = expand_kiobuf(iobuf, nr_pages);
-	if (err)
-		goto out;
+	if (err) goto out;
 
 	err = -ENOMEM;
 	iobuf->locked = 0;
 	iobuf->nr_pages = 0;
 	for (i = 0; i < nr_pages; i++)
 	{
 		struct page * page;
 
 		page = alloc_page(GFP_KERNEL);
-		if (!page)
-			goto out;
+		if (!page) goto out;
 
 		iobuf->maplist[i] = page;
 		iobuf->nr_pages++;
 	}
 	iobuf->offset = 0;
 
 	err = 0;
- out:
+
+out:
 	return err;
 }
 
@@ -547,41 +547,39 @@
 	while (buckets--)
 		INIT_LIST_HEAD(hash+buckets);
 	err = 0;
- out:
+out:
 	return err;
 }
 
 int lvm_snapshot_alloc(lv_t * lv_snap)
 {
-	int err, blocksize, max_sectors;
+	int ret, max_sectors;
 
-	err = alloc_kiovec(1, &lv_snap->lv_iobuf);
-	if (err)
-		goto out;
+	/* allocate kiovec to do chunk io */
+	ret = alloc_kiovec(1, &lv_snap->lv_iobuf);
+	if (ret) goto out;
 
-	blocksize = lvm_blocksizes[MINOR(lv_snap->lv_dev)];
 	max_sectors = KIO_MAX_SECTORS << (PAGE_SHIFT-9);
 
-	err = lvm_snapshot_alloc_iobuf_pages(lv_snap->lv_iobuf, max_sectors);
-	if (err)
-		goto out_free_kiovec;
-
-	err = lvm_snapshot_alloc_hash_table(lv_snap);
-	if (err)
+	ret = lvm_snapshot_alloc_iobuf_pages(lv_snap->lv_iobuf, max_sectors);
+	if (ret)
 		goto out_free_kiovec;
 
+	ret = lvm_snapshot_alloc_hash_table(lv_snap);
+	if (ret) goto out_free_kiovec;
 
-		lv_snap->lv_COW_table_page = alloc_page(GFP_KERNEL);
-		if (!lv_snap->lv_COW_table_page)
-			goto out_free_kiovec;
+	lv_snap->lv_COW_table_page = alloc_page(GFP_KERNEL);
+	if (!lv_snap->lv_COW_table_page)
+		goto out_free_kiovec;
 
- out:
-	return err;
+out:
+	return ret;
 
- out_free_kiovec:
+out_free_kiovec:
 	unmap_kiobuf(lv_snap->lv_iobuf);
 	free_kiovec(1, &lv_snap->lv_iobuf);
 	vfree(lv_snap->lv_snapshot_hash_table);
+	lv_snap->lv_iobuf = NULL;
 	lv_snap->lv_snapshot_hash_table = NULL;
 	goto out;
 }
--- linux.orig/include/linux/lvm.h	Thu Oct 25 01:50:48 2001
+++ linux/include/linux/lvm.h	Thu Oct 25 15:00:37 2001
@@ -3,28 +3,28 @@
  * kernel/lvm.h
  * tools/lib/lvm.h
  *
- * Copyright (C) 1997 - 2000  Heinz Mauelshagen, Sistina Software
+ * Copyright (C) 1997 - 2001  Heinz Mauelshagen, Sistina Software
  *
  * February-November 1997
  * May-July 1998
  * January-March,July,September,October,Dezember 1999
  * January,February,July,November 2000
- * January 2001
+ * January-March,June,July 2001
  *
  * lvm is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2, or (at your option)
  * any later version.
- * 
+ *
  * lvm is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with GNU CC; see the file COPYING.  If not, write to
  * the Free Software Foundation, 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA. 
+ * Boston, MA 02111-1307, USA.
  *
  */
 
@@ -52,7 +52,7 @@
  *    08/12/1999 - changed LVM_LV_SIZE_MAX macro to reflect current 1TB limit
  *    01/01/2000 - extended lv_v2 core structure by wait_queue member
  *    12/02/2000 - integrated Andrea Arcagnelli's snapshot work
- *    18/02/2000 - seperated user and kernel space parts by 
+ *    18/02/2000 - seperated user and kernel space parts by
  *                 #ifdef them with __KERNEL__
  *    08/03/2000 - implemented cluster/shared bits for vg_access
  *    26/06/2000 - implemented snapshot persistency and resizing support
@@ -107,6 +125,7 @@
 #include <asm/semaphore.h>
 #endif				/* #ifdef __KERNEL__ */
 
+
 #include <asm/page.h>
 
 #if !defined ( LVM_BLK_MAJOR) || !defined ( LVM_CHAR_MAJOR)
@@ -117,7 +136,7 @@
 #undef	BLOCK_SIZE
 #endif
 
-#ifdef CONFIG_ARCH_S390 
+#ifdef CONFIG_ARCH_S390
 #define BLOCK_SIZE	4096
 #else
 #define BLOCK_SIZE	1024
@@ -127,7 +146,8 @@
 #define SECTOR_SIZE	512
 #endif
 
-#define LVM_STRUCT_VERSION	1	/* structure version */
+/* structure version */
+#define LVM_STRUCT_VERSION 1
 
 #define	LVM_DIR_PREFIX	"/dev/"
 
@@ -293,6 +315,9 @@
 
 /*
  * ioctls
+ * FIXME: the last parameter to _IO{W,R,WR} is a data type.  The macro will
+ *	  expand this using sizeof(), so putting "1" there is misleading
+ *	  because sizeof(1) = sizeof(int) = sizeof(2) = 4 on a 32-bit machine!
  */
 /* volume group */
 #define	VG_CREATE               _IOW ( 0xfe, 0x00, 1)
@@ -376,7 +342,12 @@
 #endif
 
 /* lock the logical volume manager */
+#if LVM_DRIVER_IOP_VERSION > 11
+#define	LVM_LOCK_LVM            _IO ( 0xfe, 0x9A)
+#else
+/* This is actually the same as _IO ( 0xff, 0x00), oops.  Remove for IOP 12+ */
 #define	LVM_LOCK_LVM            _IO ( 0xfe, 0x100)
+#endif
 /* END ioctls */
 
 
@@ -383,6 +412,9 @@
 #define	PV_ALLOCATABLE       0x02	/* pv_allocatable */
 
 
+/* misc */
+#define LVM_SNAPSHOT_DROPPED_SECTOR 1
+
 /*
  * Structure definitions core/disk follow
  *
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

