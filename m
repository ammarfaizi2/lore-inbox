Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130884AbQLYXbj>; Mon, 25 Dec 2000 18:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131185AbQLYXb2>; Mon, 25 Dec 2000 18:31:28 -0500
Received: from ns.caldera.de ([212.34.180.1]:37385 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130884AbQLYXbW>;
	Mon, 25 Dec 2000 18:31:22 -0500
Date: Mon, 25 Dec 2000 23:59:51 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: torvalds@transmeta.com, mauelshagen@sistina.com
Cc: linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: [PATCH][RFC] LVM proc fix
Message-ID: <20001225235950.A23247@caldera.de>
Mail-Followup-To: torvalds@transmeta.com, mauelshagen@sistina.com,
	linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus & Heinz,

there has been some discussion about the LVM /proc #ifdefs in
Linux 2.4.0-test13pre4 (LVM 0.9).  How about just removing
CONFIG_LVM_PROC_FS? - beople that use LVM and procfs usually do
not care for the few extra bytes.

Patch attached.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.


diff -uNr --exclude-from=dontdiff linux-2.4.0-test13-pre4/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.0-test13-pre4/Documentation/Configure.help	Mon Dec 25 19:21:14 2000
+++ linux/Documentation/Configure.help	Mon Dec 25 23:55:07 2000
@@ -1450,15 +1450,6 @@
   want), say M here and read Documentation/modules.txt. The module
   will be called lvm-mod.o.
 
-Logical Volume Manager /proc file system information
-CONFIG_LVM_PROC_FS
-  If you say Y here, you are able to access overall Logical Volume
-  Manager, Volume Group, Logical and Physical Volume information in
-  /proc/lvm.
-
-  To use this option, you have to check, that the "/proc file system
-  support" (CONFIG_PROC_FS) is enabled too.
-
 Multiple devices driver support
 CONFIG_BLK_DEV_MD
   This driver lets you combine several hard disk partitions into one
diff -uNr --exclude-from=dontdiff linux-2.4.0-test13-pre4/drivers/md/Config.in linux/drivers/md/Config.in
--- linux-2.4.0-test13-pre4/drivers/md/Config.in	Sun Nov 26 17:23:18 2000
+++ linux/drivers/md/Config.in	Mon Dec 25 23:55:07 2000
@@ -17,6 +17,5 @@
 fi
 
 dep_tristate ' Logical volume manager (LVM) support' CONFIG_BLK_DEV_LVM $CONFIG_MD
-dep_mbool '   LVM information in proc filesystem' CONFIG_LVM_PROC_FS $CONFIG_BLK_DEV_LVM
 
 endmenu
diff -uNr --exclude-from=dontdiff linux-2.4.0-test13-pre4/drivers/md/lvm.c linux/drivers/md/lvm.c
--- linux-2.4.0-test13-pre4/drivers/md/lvm.c	Mon Dec 25 19:21:16 2000
+++ linux/drivers/md/lvm.c	Mon Dec 25 23:55:07 2000
@@ -139,6 +139,7 @@
  *                 lvm_proc_get_global_info()
  *    02/11/2000 - implemented /proc/lvm/ hierarchy
  *    07/12/2000 - make sure lvm_make_request_fn returns correct value - 0 or 1 - NeilBrown
+ *    25/12/2000 - fix procfs #defines - Christoph Hellwig
  *
  */
 
@@ -224,7 +225,7 @@
 
 static int lvm_chr_ioctl(struct inode *, struct file *, uint, ulong);
 
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 int lvm_proc_read_vg_info(char *, char **, off_t, int, int *, void *);
 int lvm_proc_read_lv_info(char *, char **, off_t, int, int *, void *);
 int lvm_proc_read_pv_info(char *, char **, off_t, int, int *, void *);
@@ -347,7 +348,7 @@
 static spinlock_t lvm_lock = SPIN_LOCK_UNLOCKED;
 static spinlock_t lvm_snapshot_lock = SPIN_LOCK_UNLOCKED;
 
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 static struct proc_dir_entry *lvm_proc_dir = NULL;
 static struct proc_dir_entry *lvm_proc_vg_subdir = NULL;
 struct proc_dir_entry *pde = NULL;
@@ -433,7 +434,7 @@
 		&lvm_chr_fops, NULL);
 #endif
 
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 	lvm_proc_dir = create_proc_entry (LVM_DIR, S_IFDIR, &proc_root);
 	if (lvm_proc_dir != NULL) {
 		lvm_proc_vg_subdir = create_proc_entry (LVM_VG_SUBDIR, S_IFDIR, lvm_proc_dir);
@@ -521,7 +522,7 @@
 	blksize_size[MAJOR_NR] = NULL;
 	hardsect_size[MAJOR_NR] = NULL;
 
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 	remove_proc_entry(LVM_GLOBAL, lvm_proc_dir);
 	remove_proc_entry(LVM_VG_SUBDIR, lvm_proc_dir);
 	remove_proc_entry(LVM_DIR, &proc_root);
@@ -1263,7 +1264,7 @@
 }
 
 
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 /*
  * Support functions /proc-Filesystem
  */
@@ -1452,8 +1453,6 @@
 	else
 		return count;
 } /* lvm_proc_get_global_info() */
-#endif /* #if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS */
-
 
 /*
  * provide VG information
@@ -1530,7 +1529,7 @@
 
 	return sz;
 }
-
+#endif /* CONFIG_PROC_FS */
 
 /*
  * block device support function for /usr/src/linux/drivers/block/ll_rw_blk.c
@@ -1989,7 +1988,7 @@
 		&lvm_chr_fops, NULL);
 #endif
 
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 	lvm_do_create_proc_entry_of_vg ( vg_ptr);
 #endif
 
@@ -2021,7 +2020,9 @@
 		for (p = 0; p < vg_ptr->pv_max; p++) {
 			if ( ( pv_ptr = vg_ptr->pv[p]) == NULL) {
 				ret = lvm_do_pv_create(arg, vg_ptr, p);
+#ifdef CONFIG_PROC_FS
 				lvm_do_create_proc_entry_of_pv ( vg_ptr, pv_ptr);
+#endif
 				if ( ret != 0) return ret;
 	
 				/* We don't need the PE list
@@ -2091,7 +2092,7 @@
 	if (copy_from_user(vg_name, arg, sizeof(vg_name)) != 0)
 		return -EFAULT;
 
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 	lvm_do_remove_proc_entry_of_vg ( vg_ptr);
 #endif
 
@@ -2115,7 +2116,7 @@
 		strncpy(pv_ptr->vg_name, vg_name, NAME_LEN);
 	}
 
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 	lvm_do_create_proc_entry_of_vg ( vg_ptr);
 #endif
 
@@ -2179,7 +2180,7 @@
 	devfs_unregister (vg_devfs_handle[vg_ptr->vg_number]);
 #endif
 
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 	lvm_do_remove_proc_entry_of_vg ( vg_ptr);
 #endif
 
@@ -2211,7 +2212,7 @@
 		       lvm_name, __LINE__);
 		return -ENOMEM;
 	}
-	if (copy_from_user(pv_ptr, pvp, sizeof(pv_t)) != 0) {
+	if (copy_pv_from_user(pv_ptr, pvp) != 0) {
 		return -EFAULT;
 	}
 	/* We don't need the PE list
@@ -2237,7 +2238,7 @@
 static int lvm_do_pv_remove(vg_t *vg_ptr, ulong p) {
 	pv_t *pv_ptr = vg_ptr->pv[p];
 
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 	lvm_do_remove_proc_entry_of_pv ( vg_ptr, pv_ptr);
 #endif
 	vg_ptr->pe_total -=
@@ -2442,7 +2443,7 @@
 	}
 #endif
 
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 	lvm_do_create_proc_entry_of_lv ( vg_ptr, lv_ptr);
 #endif
 
@@ -2564,7 +2565,7 @@
 	devfs_unregister(lv_devfs_handle[lv_ptr->lv_number]);
 #endif
 
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 	lvm_do_remove_proc_entry_of_lv ( vg_ptr, lv_ptr);
 #endif
 
@@ -2914,13 +2915,13 @@
 		if ( (lv_ptr = vg_ptr->lv[l]) == NULL) continue;
 		if (lv_ptr->lv_dev == lv->lv_dev)
 		{
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 			lvm_do_remove_proc_entry_of_lv ( vg_ptr, lv_ptr);
 #endif
 			strncpy(lv_ptr->lv_name,
 				lv_req->lv_name,
 				NAME_LEN);
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
+#ifdef CONFIG_PROC_FS
 			lvm_do_create_proc_entry_of_lv ( vg_ptr, lv_ptr);
 #endif
 			break;
@@ -3002,7 +3003,7 @@
 } /* lvm_do_pv_status() */
 
 
-
+#ifdef CONFIG_PROC_FS
 /*
  * create a /proc entry for a logical volume
  */
@@ -3074,7 +3075,6 @@
 /*
  * create a /proc entry for a volume group
  */
-#if defined CONFIG_LVM_PROC_FS && defined CONFIG_PROC_FS
 void lvm_do_create_proc_entry_of_vg ( vg_t *vg_ptr) {
 	int l, p;
 	pv_t *pv_ptr;
@@ -3133,8 +3133,7 @@
 		remove_proc_entry(vg_ptr->vg_name, lvm_proc_vg_subdir);
 	}
 }
-#endif
-
+#endif /* CONFIG_PROC_FS */
 
 /*
  * support function initialize gendisk variables
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
