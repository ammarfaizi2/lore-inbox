Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286321AbRL0QDM>; Thu, 27 Dec 2001 11:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286324AbRL0QDE>; Thu, 27 Dec 2001 11:03:04 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:2974 "EHLO gin")
	by vger.kernel.org with ESMTP id <S286321AbRL0QCj>;
	Thu, 27 Dec 2001 11:02:39 -0500
Date: Thu, 27 Dec 2001 17:02:32 +0100
To: Jens Axboe <axboe@suse.de>
Cc: andersg@0x63.nu, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: Re: lvm in 2.5.1
Message-ID: <20011227160232.GA11106@h55p111.delphi.afb.lu.se>
In-Reply-To: <20011227084304.GA26255@h55p111.delphi.afb.lu.se> <3C2AEADB.24BEFE94@zip.com.au> <20011227122520.GA2194@h55p111.delphi.afb.lu.se> <20011227135453.GA5803@h55p111.delphi.afb.lu.se> <20011227162019.C1730@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011227162019.C1730@suse.de>
User-Agent: Mutt/1.3.24i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 04:20:19PM +0100, Jens Axboe wrote:
> You are tossing out read-ahead info here, you want to use bio_rw and not
> bio_data_dir. The former will pass back xA bits too, while bio_data_dir
> is strictly the data direction (strangely :-)

you mean like this?

-- 

//anders/g

diff -ru linux-2.5.2-pre2/drivers/md/lvm.c linux-2.5.2-pre2-lvmfix/drivers/md/lvm.c
--- linux-2.5.2-pre2/drivers/md/lvm.c	Thu Dec 27 08:28:39 2001
+++ linux-2.5.2-pre2-lvmfix/drivers/md/lvm.c	Thu Dec 27 16:43:52 2001
@@ -179,6 +179,9 @@
  *		   (Jens Axboe)
  *               - Defer writes to an extent that is being moved [JT + AD]
  *    28/05/2001 - implemented missing BLKSSZGET ioctl [AD]
+ *    28/12/2001 - buffer_head -> bio
+ *                 removed huge allocation of a lv_t on stack
+ *                 (Anders Gustafsson)
  *
  */
 
@@ -1043,7 +1046,7 @@
 
 	memset(&bio,0,sizeof(bio));
 	bio.bi_dev = inode->i_rdev;
-	bio.bi_io_vec.bv_len = lvm_get_blksize(bio.bi_dev);
+	bio.bi_size = lvm_get_blksize(bio.bi_dev); /* NEEDED by bio_sectors */
  	bio.bi_sector = block * bio_sectors(&bio);
 	bio.bi_rw = READ;
 	if ((err=lvm_map(&bio)) < 0)  {
@@ -1119,19 +1122,18 @@
 	return 0;
 }
 
-static int lvm_map(struct bio *bh)
+static int lvm_map(struct bio *bi)
 {
-	int minor = MINOR(bh->bi_dev);
+	int minor = MINOR(bi->bi_dev);
 	ulong index;
 	ulong pe_start;
-	ulong size = bio_sectors(bh);
-	ulong rsector_org = bh->bi_sector;
+	ulong size = bio_sectors(bi);
+	ulong rsector_org = bi->bi_sector;
 	ulong rsector_map;
 	kdev_t rdev_map;
 	vg_t *vg_this = vg[VG_BLK(minor)];
 	lv_t *lv = vg_this->lv[LV_BLK(minor)];
-	int rw = bio_data_dir(bh);
-
+	int rw = bio_rw(bi);
 
 	down_read(&lv->lv_lock);
 	if (!(lv->lv_status & LV_ACTIVE)) {
@@ -1151,7 +1153,7 @@
 
 	P_MAP("%s - lvm_map minor: %d  *rdev: %s  *rsector: %lu  size:%lu\n",
 	      lvm_name, minor,
-	      kdevname(bh->bi_dev),
+	      kdevname(bi->bi_dev),
 	      rsector_org, size);
 
 	if (rsector_org + size > lv->lv_size) {
@@ -1205,7 +1207,7 @@
 	 * we need to queue this request, because this is in the fast path.
 	 */
 	if (rw == WRITE || rw == WRITEA) {
-		if(_defer_extent(bh, rw, rdev_map,
+		if(_defer_extent(bi, rw, rdev_map,
 				 rsector_map, vg_this->pe_size)) {
 
 			up_read(&lv->lv_lock);
@@ -1246,13 +1248,13 @@
  	}
 
  out:
-	bh->bi_dev = rdev_map;
-	bh->bi_sector = rsector_map;
+	bi->bi_dev = rdev_map;
+	bi->bi_sector = rsector_map;
 	up_read(&lv->lv_lock);
 	return 1;
 
  bad:
-	bio_io_error(bh);
+	bio_io_error(bi);
 	up_read(&lv->lv_lock);
 	return -1;
 } /* lvm_map() */
@@ -1436,9 +1438,9 @@
 {
 	int ret = 0;
 	ulong l, ls = 0, p, size;
-	lv_t lv;
 	vg_t *vg_ptr;
 	lv_t **snap_lv_ptr;
+	lv_t *tmplv;
 
 	if ((vg_ptr = kmalloc(sizeof(vg_t),GFP_KERNEL)) == NULL) {
 		printk(KERN_CRIT
@@ -1446,6 +1448,7 @@
 		       lvm_name, __LINE__);
 		return -ENOMEM;
 	}
+
 	/* get the volume group structure */
 	if (copy_from_user(vg_ptr, arg, sizeof(vg_t)) != 0) {
 		P_IOCTL("lvm_do_vg_create ERROR: copy VG ptr %p (%d bytes)\n",
@@ -1454,6 +1457,8 @@
 		return -EFAULT;
 	}
 
+
+
         /* VG_CREATE now uses minor number in VG structure */
         if (minor == -1) minor = vg_ptr->vg_number;
 
@@ -1513,19 +1518,30 @@
 	}
 	memset(snap_lv_ptr, 0, size);
 
+	if ((tmplv = kmalloc(sizeof(lv_t),GFP_KERNEL)) == NULL) {
+		printk(KERN_CRIT
+		       "%s -- VG_CREATE: kmalloc error LV at line %d\n",
+		       lvm_name, __LINE__);
+		vfree(snap_lv_ptr);
+		return -ENOMEM;
+	}
+
 	/* get the logical volume structures */
 	vg_ptr->lv_cur = 0;
 	for (l = 0; l < vg_ptr->lv_max; l++) {
 		lv_t *lvp;
+		
 		/* user space address */
 		if ((lvp = vg_ptr->lv[l]) != NULL) {
-			if (copy_from_user(&lv, lvp, sizeof(lv_t)) != 0) {
+			if (copy_from_user(tmplv, lvp, sizeof(lv_t)) != 0) {
 				P_IOCTL("ERROR: copying LV ptr %p (%d bytes)\n",
 					lvp, sizeof(lv_t));
 				lvm_do_vg_remove(minor);
+				vfree(snap_lv_ptr);
+				kfree(tmplv);
 				return -EFAULT;
 			}
-			if ( lv.lv_access & LV_SNAPSHOT) {
+			if ( tmplv->lv_access & LV_SNAPSHOT) {
 				snap_lv_ptr[ls] = lvp;
 				vg_ptr->lv[l] = NULL;
 				ls++;
@@ -1533,8 +1549,10 @@
 			}
 			vg_ptr->lv[l] = NULL;
 			/* only create original logical volumes for now */
-			if (lvm_do_lv_create(minor, lv.lv_name, &lv) != 0) {
+			if (lvm_do_lv_create(minor, tmplv->lv_name, tmplv) != 0) {
 				lvm_do_vg_remove(minor);
+				vfree(snap_lv_ptr);
+				kfree(tmplv);
 				return -EFAULT;
 			}
 		}
@@ -1544,18 +1562,22 @@
 	   in place during first path above */
 	for (l = 0; l < ls; l++) {
 		lv_t *lvp = snap_lv_ptr[l];
-		if (copy_from_user(&lv, lvp, sizeof(lv_t)) != 0) {
+		if (copy_from_user(tmplv, lvp, sizeof(lv_t)) != 0) {
 			lvm_do_vg_remove(minor);
+			vfree(snap_lv_ptr);
+			kfree(tmplv);
 			return -EFAULT;
 		}
-		if (lvm_do_lv_create(minor, lv.lv_name, &lv) != 0) {
+		if (lvm_do_lv_create(minor, tmplv->lv_name, tmplv) != 0) {
 			lvm_do_vg_remove(minor);
+			vfree(snap_lv_ptr);
+			kfree(tmplv);
 			return -EFAULT;
 		}
 	}
 
 	vfree(snap_lv_ptr);
-
+	kfree(tmplv);
 	vg_count++;

