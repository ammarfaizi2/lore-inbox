Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132168AbRANQeW>; Sun, 14 Jan 2001 11:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131845AbRANQeN>; Sun, 14 Jan 2001 11:34:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24084 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132168AbRANQeB>; Sun, 14 Jan 2001 11:34:01 -0500
Date: Sun, 14 Jan 2001 17:32:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Todd M. Roy" <troy@holstein.com>
Cc: "Heinz J. Mauelshagen" <Heinz.Mauelshagen@t-online.de>,
        linux-kernel@vger.kernel.org,
        Heinz Mauelshagen <mauelshagen@sistina.com>, lvm-devel@sistina.com
Subject: Re: lvm 0.9.1-beta1 still segfaults vgexport
Message-ID: <20010114173234.A942@athlon.random>
In-Reply-To: <3A45192F.8C149F93@softhome.net> <20001227205336.A10446@athlon.random> <200101081918.f08JIrT06681@pcx4168.holstein.com> <20010108234339.F27646@athlon.random> <3A5B3422.F63D7DDD@holstein.com> <20010109170424.A29468@athlon.random> <3A5BBD0E.9F7DA88B@holstein.com> <20010110024743.R29904@athlon.random> <3A61B841.81B1D0F5@holstein.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A61B841.81B1D0F5@holstein.com>; from troy@holstein.com on Sun, Jan 14, 2001 at 09:31:29AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 09:31:29AM -0500, Todd M. Roy wrote:
> Andrea,
>   Sorry to say but lvm 0.9.1-beta1 still segfaults
> at the same place, line 140 of pv_read_all_pv_of_vg.c
> pv_this is still null.

BTW, I can easily reproduce. I was near to go into it yesterday but got
interrupted by other issues (like the merging of the 0.9.1-beta1 kernel driver
and extraction of the strictly necessary fixes from the 0.9.1-beta1 userspace
against 0.9).

In the meantime here is the diff between my current kernel lvm driver and
0.9.1-beta1 applied on top of 2.4.1-pre3, Heinz could you merge the below
incremental fixes into your tree before merging with Linus? Thanks!

diff -urN -X /home/andrea/bin/dontdiff 2.4.1pre3-lvm-0.9.1_beta1/Documentation/Configure.help 2.4.1pre3-lvm-aa/Documentation/Configure.help
--- 2.4.1pre3-lvm-0.9.1_beta1/Documentation/Configure.help	Fri Jan 12 04:14:36 2001
+++ 2.4.1pre3-lvm-aa/Documentation/Configure.help	Sat Jan 13 16:09:24 2001
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
Binary files 2.4.1pre3-lvm-0.9.1_beta1/ID and 2.4.1pre3-lvm-aa/ID differ
diff -urN -X /home/andrea/bin/dontdiff 2.4.1pre3-lvm-0.9.1_beta1/drivers/block/ll_rw_blk.c 2.4.1pre3-lvm-aa/drivers/block/ll_rw_blk.c
--- 2.4.1pre3-lvm-0.9.1_beta1/drivers/block/ll_rw_blk.c	Tue Jan  2 17:41:15 2001
+++ 2.4.1pre3-lvm-aa/drivers/block/ll_rw_blk.c	Sun Jan 14 17:20:42 2001
@@ -38,8 +38,6 @@
 extern int mac_floppy_init(void);
 #endif
 
-extern int lvm_init(void);
-
 /*
  * For the allocated request tables
  */
@@ -1267,9 +1265,6 @@
 #endif
 #ifdef CONFIG_SUN_JSFLASH
 	jsfd_init();
-#endif
-#ifdef CONFIG_BLK_DEV_LVM
-	lvm_init();
 #endif
 	return 0;
 };
diff -urN -X /home/andrea/bin/dontdiff 2.4.1pre3-lvm-0.9.1_beta1/drivers/md/lvm-snap.c 2.4.1pre3-lvm-aa/drivers/md/lvm-snap.c
--- 2.4.1pre3-lvm-0.9.1_beta1/drivers/md/lvm-snap.c	Sat Jan 13 16:10:33 2001
+++ 2.4.1pre3-lvm-aa/drivers/md/lvm-snap.c	Sat Jan 13 16:12:22 2001
@@ -42,10 +42,6 @@
 
 static char *lvm_snap_version __attribute__ ((unused)) = "LVM 0.9 snapshot code (13/11/2000)\n";
 
-#ifndef LockPage
-#define LockPage(map) set_bit(PG_locked, &(map)->flags)
-#endif
-
 extern const char *const lvm_name;
 extern int lvm_blocksizes[];
 
@@ -469,7 +465,7 @@
 		goto out;
 
 	err = -ENOMEM;
-	iobuf->locked = 1;
+	iobuf->locked = 0;
 	iobuf->nr_pages = 0;
 	for (i = 0; i < nr_pages; i++)
 	{
@@ -480,9 +476,6 @@
 			goto out;
 
 		iobuf->maplist[i] = page;
-		/* the only point to lock the page here is to be allowed
-		   to share unmap_kiobuf() in the fail-path */
-		LockPage(page);
 		iobuf->nr_pages++;
 	}
 	iobuf->offset = 0;
diff -urN -X /home/andrea/bin/dontdiff 2.4.1pre3-lvm-0.9.1_beta1/drivers/md/lvm.c 2.4.1pre3-lvm-aa/drivers/md/lvm.c
--- 2.4.1pre3-lvm-0.9.1_beta1/drivers/md/lvm.c	Sat Jan 13 16:10:33 2001
+++ 2.4.1pre3-lvm-aa/drivers/md/lvm.c	Sun Jan 14 16:19:03 2001
@@ -148,6 +148,8 @@
  *                 procfs is always supported now. (JT)
  *    12/01/2001 - avoided flushing logical volume in case of shrinking
  *                 because of unecessary overhead in case of heavy updates
+ *    07/12/2000 - make sure lvm_make_request_fn returns correct value - 0 or 1 - NeilBrown
+ *    25/12/2000 - fix procfs #defines - Christoph Hellwig
  *
  */
 
@@ -399,7 +401,7 @@
 /*
  * Driver initialization...
  */
-int __init lvm_init(void)
+int lvm_init(void)
 {
 	struct gendisk *gendisk_ptr = NULL;
 
@@ -480,7 +482,7 @@
 /*
  * cleanup...
  */
-static void __exit lvm_cleanup(void)
+static void lvm_cleanup(void)
 {
 	struct gendisk *gendisk_ptr = NULL, *gendisk_ptr_prev = NULL;
 
@@ -928,6 +930,7 @@
 		P_IOCTL("%s -- lvm_blk_ioctl -- BLKFLSBUF\n", lvm_name);
 
 		fsync_dev(inode->i_rdev);
+		invalidate_buffers(inode->i_rdev);
 		break;
 
 
@@ -1603,6 +1606,8 @@
 	if (lv->lv_access & (LV_SNAPSHOT|LV_SNAPSHOT_ORG)) {
 		/* original logical volume */
 		if (lv->lv_access & LV_SNAPSHOT_ORG) {
+			/* Serializes the access to the lv_snapshot_next list */
+			down(&lv->lv_snapshot_sem);
 			if (rw == WRITE || rw == WRITEA)
 			{
 				lv_t *lv_ptr;
@@ -1613,7 +1618,8 @@
 				     lv_ptr = lv_ptr->lv_snapshot_next) {
 					/* Check for inactive snapshot */
 					if (!(lv_ptr->lv_status & LV_ACTIVE)) continue;
-					down(&lv->lv_snapshot_org->lv_snapshot_sem);
+					/* Serializes the COW with the accesses to the snapshot device */
+					down(&lv_ptr->lv_snapshot_sem);
 					/* do we still have exception storage for this snapshot free? */
 					if (lv_ptr->lv_block_exception != NULL) {
 						rdev_sav = rdev_tmp;
@@ -1634,9 +1640,10 @@
 						rdev_tmp = rdev_sav;
 						rsector_tmp = rsector_sav;
 					}
-					up(&lv->lv_snapshot_org->lv_snapshot_sem);
+					up(&lv_ptr->lv_snapshot_sem);
 				}
 			}
+			up(&lv->lv_snapshot_sem);
 		} else {
 			/* remap snapshot logical volume */
 			down(&lv->lv_snapshot_sem);
@@ -1698,8 +1705,10 @@
 			       int rw,
 			       struct buffer_head *bh)
 {
-	lvm_map(bh, rw);
-	return 1;
+	if (lvm_map(bh, rw)<0)
+		return 0; /* failure, buffer_IO_error has been called, don't recurse */
+	else
+		return 1; /* all ok, mapping done, call lower level driver */
 }
 
 
@@ -2268,18 +2277,10 @@
 
 				lv_ptr->lv_snapshot_minor = 0;
 				lv_ptr->lv_snapshot_org = lv_ptr;
-				lv_ptr->lv_snapshot_prev = NULL;
-				/* walk thrugh the snapshot list */
-				while (lv_ptr->lv_snapshot_next != NULL)
-					lv_ptr = lv_ptr->lv_snapshot_next;
-				/* now lv_ptr points to the last existing snapshot in the chain */
-				vg_ptr->lv[l]->lv_snapshot_prev = lv_ptr;
 				/* our new one now back points to the previous last in the chain
 				   which can be the original logical volume */
 				lv_ptr = vg_ptr->lv[l];
 				/* now lv_ptr points to our new last snapshot logical volume */
-				lv_ptr->lv_snapshot_org = lv_ptr->lv_snapshot_prev->lv_snapshot_org;
-				lv_ptr->lv_snapshot_next = NULL;
 				lv_ptr->lv_current_pe = lv_ptr->lv_snapshot_org->lv_current_pe;
 				lv_ptr->lv_allocated_snapshot_le = lv_ptr->lv_allocated_le;
 				lv_ptr->lv_allocated_le = lv_ptr->lv_snapshot_org->lv_allocated_le;
@@ -2347,16 +2348,21 @@
 
 	/* optionally add our new snapshot LV */
 	if (lv_ptr->lv_access & LV_SNAPSHOT) {
+		lv_t * org = lv_ptr->lv_snapshot_org, * last;
 		/* sync the original logical volume */
-		fsync_dev(lv_ptr->lv_snapshot_org->lv_dev);
+		fsync_dev(org->lv_dev);
 #ifdef	LVM_VFS_ENHANCEMENT
 		/* VFS function call to sync and lock the filesystem */
-		fsync_dev_lockfs(lv_ptr->lv_snapshot_org->lv_dev);
+		fsync_dev_lockfs(org->lv_dev);
 #endif
-		lv_ptr->lv_snapshot_org->lv_access |= LV_SNAPSHOT_ORG;
-		lv_ptr->lv_access &= ~LV_SNAPSHOT_ORG;
-		/* put ourselve into the chain */
-		lv_ptr->lv_snapshot_prev->lv_snapshot_next = lv_ptr;
+		down(&org->lv_snapshot_sem);
+		org->lv_access |= LV_SNAPSHOT_ORG;
+		lv_ptr->lv_access &= ~LV_SNAPSHOT_ORG; /* this can only hide an userspace bug */
+		/* Link in the list of snapshot volumes */
+		for (last = org; last->lv_snapshot_next; last = last->lv_snapshot_next);
+		lv_ptr->lv_snapshot_prev = last;
+		last->lv_snapshot_next = lv_ptr;
+		up(&org->lv_snapshot_sem);
 	}
 
 	/* activate the logical volume */
@@ -2412,6 +2418,28 @@
 	    lv_ptr->lv_snapshot_next != NULL)
 		return -EPERM;
 
+	if (lv_ptr->lv_access & LV_SNAPSHOT) {
+		/*
+		 * Atomically make the the snapshot invisible
+		 * to the original lv before playing with it.
+		 */
+		lv_t * org = lv_ptr->lv_snapshot_org;
+		down(&org->lv_snapshot_sem);
+
+		/* remove this snapshot logical volume from the chain */
+		lv_ptr->lv_snapshot_prev->lv_snapshot_next = lv_ptr->lv_snapshot_next;
+		if (lv_ptr->lv_snapshot_next != NULL) {
+			lv_ptr->lv_snapshot_next->lv_snapshot_prev =
+			    lv_ptr->lv_snapshot_prev;
+		}
+		up(&org->lv_snapshot_sem);
+
+		/* no more snapshots? */
+		if (!org->lv_snapshot_next)
+			org->lv_access &= ~LV_SNAPSHOT_ORG;
+		lvm_snapshot_release(lv_ptr);
+	}
+
 	lv_ptr->lv_status |= LV_SPINDOWN;
 
 	/* sync the buffers */
@@ -2445,24 +2473,6 @@
 			}
 		}
 		vfree(lv_ptr->lv_current_pe);
-	/* LV_SNAPSHOT */
-	} else {
-		down(&lv_ptr->lv_snapshot_org->lv_snapshot_sem);
-
-		/* Update the VG PE(s) used by snapshot reserve space. */
-		vg[VG_CHR(minor)]->pe_allocated -= lv_ptr->lv_allocated_snapshot_le;
-
-		/* remove this snapshot logical volume from the chain */
-		lv_ptr->lv_snapshot_prev->lv_snapshot_next = lv_ptr->lv_snapshot_next;
-		if (lv_ptr->lv_snapshot_next != NULL) {
-			lv_ptr->lv_snapshot_next->lv_snapshot_prev =
-			    lv_ptr->lv_snapshot_prev;
-		}
-		/* no more snapshots? */
-		if (lv_ptr->lv_snapshot_org->lv_snapshot_next == NULL)
-			lv_ptr->lv_snapshot_org->lv_access &= ~LV_SNAPSHOT_ORG;
-		lvm_snapshot_release(lv_ptr);
-		up(&lv_ptr->lv_snapshot_org->lv_snapshot_sem);
 	}
 
 	devfs_unregister(lv_devfs_handle[lv_ptr->lv_number]);
@@ -3088,14 +3098,5 @@
 	return uuid;
 }
 
-#ifdef MODULE
-int __init init_module(void)
-{
-	return lvm_init();
-}
-
-void __exit cleanup_module(void)
-{
-	lvm_cleanup();
-}
-#endif
+module_init(lvm_init);
+module_exit(lvm_cleanup);
diff -urN -X /home/andrea/bin/dontdiff 2.4.1pre3-lvm-0.9.1_beta1/include/linux/lvm.h 2.4.1pre3-lvm-aa/include/linux/lvm.h
--- 2.4.1pre3-lvm-0.9.1_beta1/include/linux/lvm.h	Sat Jan 13 16:10:33 2001
+++ 2.4.1pre3-lvm-aa/include/linux/lvm.h	Sun Jan 14 16:35:08 2001
@@ -58,6 +58,8 @@
  *    26/06/2000 - implemented snapshot persistency and resizing support
  *    02/11/2000 - added hash table size member to lv structure
  *    12/11/2000 - removed unneeded timestamp definitions
+ *    24/12/2000 - removed LVM_TO_{CORE,DISK}*, use cpu_{from, to}_le*
+ *                 instead - Christoph Hellwig
  *
  */
 

downloadable from here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/lvm/kernel-2.4.1pre3-0.9.1_beta1-fixes-1

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
