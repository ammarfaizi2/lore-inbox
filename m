Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268551AbRHAWlw>; Wed, 1 Aug 2001 18:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268571AbRHAWlm>; Wed, 1 Aug 2001 18:41:42 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:63224 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S268551AbRHAWl1>; Wed, 1 Aug 2001 18:41:27 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108012240.f71MePUg007523@webber.adilger.int>
Subject: [PATCH] lvm debug messages cleanup
To: torvalds@transmeta.com,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Date: Wed, 1 Aug 2001 16:40:25 -0600 (MDT)
CC: Linux LVM Development list <lvm-devel@sistina.com>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
the following patch cleans up some of the debug messages in lvm.c so that
they are done my macros instead of inline #ifdef DEBUG_foo.  This code is
already in LVM CVS (and -ac as well I believe), so it also has the benefit
of converging the various code bases.

It probably doesn't hit all of the relevant "#ifdef DEBUG" pieces of code,
because there are other major differences in the codebase, but these ones
are common to both.  Also removes a couple of zero initializers on static
global variables and updates some comments (also in LVM CVS).

Cheers, Andreas
=======================  lvm-2.4.7-debug.diff ===========================
diff -ru linux-2.4.7.orig/drivers/md/lvm.c linux-2.4.7-aed/drivers/md/lvm.c
--- linux-2.4.7.orig/drivers/md/lvm.c	Tue Jul 31 15:00:11 2001
+++ linux-2.4.7-aed/drivers/md/lvm.c	Tue Jul 31 15:15:27 2001
@@ -205,6 +205,12 @@
 #else
 #define P_KFREE(fmt, args...)
 #endif
+
+#ifdef DEBUG_DEVICE
+#define P_DEV(fmt, args...) printk(KERN_DEBUG "lvm device: " fmt, ## args)
+#else
+#define P_DEV(fmt, args...)
+#endif
 
 /*
  * External function prototypes
@@ -370,10 +398,9 @@
 
 /* gendisk structures */
 static struct hd_struct lvm_hd_struct[MAX_LV];
-static int lvm_blocksizes[MAX_LV] =
-{0,};
-static int lvm_size[MAX_LV] =
-{0,};
+static int lvm_blocksizes[MAX_LV];
+static int lvm_size[MAX_LV];
+
 static struct gendisk lvm_gendisk =
 {
 	MAJOR_NR,		/* major # */
@@ -523,8 +541,8 @@
 	lvm_lock = lvm_snapshot_lock = SPIN_LOCK_UNLOCKED;
 
 	pe_lock_req.lock = UNLOCK_PE;
-	pe_lock_req.data.lv_dev = \
-	pe_lock_req.data.pv_dev = \
+	pe_lock_req.data.lv_dev = 0;
+	pe_lock_req.data.pv_dev = 0;
 	pe_lock_req.data.pv_offset = 0;
 
 	/* Initialize VG pointers */
@@ -550,16 +568,12 @@
 /*
  * character device open routine
  */
-static int lvm_chr_open(struct inode *inode,
-			struct file *file)
+static int lvm_chr_open(struct inode *inode, struct file *file)
 {
 	int minor = MINOR(inode->i_rdev);
 
-#ifdef DEBUG
-	printk(KERN_DEBUG
-	 "%s -- lvm_chr_open MINOR: %d  VG#: %d  mode: 0x%X  lock: %d\n",
-	       lvm_name, minor, VG_CHR(minor), file->f_mode, lock);
-#endif
+	P_DEV("%s -- lvm_chr_open MINOR: %d  VG#: %d  mode: 0x%X  lock: %d\n",
+	      lvm_name, minor, VG_CHR(minor), file->f_mode, lock);
 
 	/* super user validation */
 	if (!capable(CAP_SYS_ADMIN)) return -EACCES;
@@ -697,7 +720,7 @@
 
 
 	case VG_STATUS_GET_NAMELIST:
-		/* get volume group count */
+		/* get volume group names */
 		for (l = v = 0; v < ABS_MAX_VG; v++) {
 			if (vg[v] != NULL) {
 				if (copy_to_user(arg + l * NAME_LEN,
@@ -752,6 +775,7 @@
 
 
 	case LV_STATUS_BYDEV:
+		/* get status of a logical volume by device */
 		return lvm_do_lv_status_bydev(vg_ptr, arg);
 
 
@@ -792,11 +810,8 @@
  */
 static int lvm_chr_close(struct inode *inode, struct file *file)
 {
-#ifdef DEBUG
-	int minor = MINOR(inode->i_rdev);
-	printk(KERN_DEBUG
-	     "%s -- lvm_chr_close   VG#: %d\n", lvm_name, VG_CHR(minor));
-#endif
+	P_DEV("chr_close MINOR: %d  VG#: %d\n",
+	      MINOR(inode->i_rdev), VG_CHR(MINOR(inode->i_rdev)));
 
 #ifdef LVM_TOTAL_RESET
 	if (lvm_reset_spindown > 0) {
@@ -833,11 +854,8 @@
 	lv_t *lv_ptr;
 	vg_t *vg_ptr = vg[VG_BLK(minor)];
 
-#ifdef DEBUG_LVM_BLK_OPEN
-	printk(KERN_DEBUG
-	  "%s -- lvm_blk_open MINOR: %d  VG#: %d  LV#: %d  mode: 0x%X\n",
-	    lvm_name, minor, VG_BLK(minor), LV_BLK(minor), file->f_mode);
-#endif
+	P_DEV("%s -- lvm_blk_open MINOR: %d  VG#: %d  LV#: %d  mode: 0x%X\n",
+	      lvm_name, minor, VG_BLK(minor), LV_BLK(minor), file->f_mode);
 
 #ifdef LVM_TOTAL_RESET
 	if (lvm_reset_spindown > 0)
@@ -867,12 +889,7 @@
 
 		MOD_INC_USE_COUNT;
 
-#ifdef DEBUG_LVM_BLK_OPEN
-		printk(KERN_DEBUG
-		       "%s -- lvm_blk_open MINOR: %d  VG#: %d  LV#: %d  size: %d\n",
-		       lvm_name, minor, VG_BLK(minor), LV_BLK(minor),
-		       lv_ptr->lv_size);
-#endif
+		P_DEV("%s -- OPEN OK, LV size %d\n", lvm_name, lv_ptr->lv_size);
 
 		return 0;
 	}
@@ -892,7 +909,7 @@
 	void *arg = (void *) a;
 	struct hd_geometry *hd = (struct hd_geometry *) a;
 
-	P_IOCTL("%s -- lvm_blk_ioctl MINOR: %d  command: 0x%X  arg: %X  "
+	P_IOCTL("%s -- lvm_blk_ioctl MINOR: %d  command: 0x%X  arg: %lX  "
 		"VG#: %dl  LV#: %d\n",
 		lvm_name, minor, command, (ulong) arg,
 		VG_BLK(minor), LV_BLK(minor));
@@ -922,8 +943,8 @@
 		/* set read ahead for block device */
 		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
 
-		P_IOCTL("%s -- lvm_blk_ioctl -- BLKRASET: %d sectors for %02X:%02X\n",
-			lvm_name, (long) arg, MAJOR(inode->i_rdev), minor);
+		P_IOCTL("%s -- lvm_blk_ioctl -- BLKRASET: %ld sectors for %s\n",
+			lvm_name, (long) arg, kdevname(inode->i_rdev));
 
 		if ((long) arg < LVM_MIN_READ_AHEAD ||
 		    (long) arg > LVM_MAX_READ_AHEAD)
@@ -960,10 +981,10 @@
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
 
 
@@ -1053,11 +1050,8 @@
 	vg_t *vg_ptr = vg[VG_BLK(minor)];
 	lv_t *lv_ptr = vg_ptr->lv[LV_BLK(minor)];
 
-#ifdef DEBUG
-	printk(KERN_DEBUG
-	       "%s -- lvm_blk_close MINOR: %d  VG#: %d  LV#: %d\n",
-	       lvm_name, minor, VG_BLK(minor), LV_BLK(minor));
-#endif
+	P_DEV("blk_close MINOR: %d  VG#: %d  LV#: %d\n",
+	      minor, VG_BLK(minor), LV_BLK(minor));
 
 	sync_dev(inode->i_rdev);
 	if (lv_ptr->lv_open == 1) vg_ptr->lv_open--;
@@ -1713,6 +1340,7 @@
 		goto lock_try_again;
 	}
 	lock = current->pid;
+	P_DEV("lvm_do_lock_lvm: locking LVM for pid %d\n", lock);
 	spin_unlock(&lvm_lock);
 	return 0;
 } /* lvm_do_lock_lvm */
@@ -2094,7 +1746,7 @@
 	pv_ptr = vg_ptr->pv[p] = kmalloc(sizeof(pv_t),GFP_KERNEL);
 	if (pv_ptr == NULL) {
 		printk(KERN_CRIT
-		       "%s -- VG_CREATE: kmalloc error PV at line %d\n",
+		       "%s -- PV_CREATE: kmalloc error PV at line %d\n",
 		       lvm_name, __LINE__);
 		return -ENOMEM;
 	}
@@ -2114,7 +1766,7 @@
 
 
 /*
- * character device support function physical volume create
+ * character device support function physical volume remove
  */
 static int lvm_do_pv_remove(vg_t *vg_ptr, ulong p) {
 	pv_t *pv_ptr = vg_ptr->pv[p];
diff -ru linux-2.4.7.orig/include/linux/lvm.h linux-2.4.7-aed/include/linux/lvm.h
--- linux-2.4.7.orig/include/linux/lvm.h	Tue Jul 31 15:00:43 2001
+++ linux-2.4.7-aed/include/linux/lvm.h	Tue Jul 31 16:22:22 2001
@@ -90,7 +90,7 @@
    #define DEBUG_READ
    #define DEBUG_GENDISK
    #define DEBUG_VG_CREATE
-   #define DEBUG_LVM_BLK_OPEN
+   #define DEBUG_DEVICE
    #define DEBUG_KFREE
  */
 #endif				/* #ifdef __KERNEL__ */
@@ -321,6 +336,9 @@
 
 /*
  * ioctls
+ * FIXME: the last parameter to _IO{W,R,WR} is a data type.  The macro will
+ *	  expand this using sizeof(), so putting "1" there is misleading
+ *	  because sizeof(1) = sizeof(int) = sizeof(2) = 4 on a 32-bit machine!
  */
 /* volume group */
 #define	VG_CREATE               _IOW ( 0xfe, 0x00, 1)
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

