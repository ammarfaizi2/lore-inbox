Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286944AbRL1RlU>; Fri, 28 Dec 2001 12:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286938AbRL1RlM>; Fri, 28 Dec 2001 12:41:12 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:64185 "EHLO gin")
	by vger.kernel.org with ESMTP id <S286944AbRL1Rk5>;
	Fri, 28 Dec 2001 12:40:57 -0500
Date: Fri, 28 Dec 2001 18:40:54 +0100
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] 2.5.2-pre3 lvm compilefix+lv_t off stack
Message-ID: <20011228174054.GC20899@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes another lv_t on the stack (hunk 1+2)
and changes lvm_get_blksize to block_size (making lvm compile again) (hunk 3)

//anders/g

--- linux-2.5.2-pre3/drivers/md/lvm.c	Fri Dec 28 09:03:31 2001
+++ linux-2.5.2-pre3-lvmfix-reiserfix/drivers/md/lvm.c	Fri Dec 28 08:44:50 2001
@@ -549,10 +549,11 @@
 		  uint command, ulong a)
 {
 	int minor = MINOR(inode->i_rdev);
+	int ret;
 	uint extendable, l, v;
 	void *arg = (void *) a;
-	lv_t lv;
 	vg_t* vg_ptr = vg[VG_CHR(minor)];
+	lv_t *userlv;
 
 	/* otherwise cc will complain about unused variables */
 	(void) lvm_lock;
@@ -681,30 +682,43 @@
 	case LV_REDUCE:
 	case LV_REMOVE:
 	case LV_RENAME:
+		
 		/* create, extend, reduce, remove or rename a logical volume */
 		if (vg_ptr == NULL) return -ENXIO;
 		if (copy_from_user(&lv_req, arg, sizeof(lv_req)) != 0)
 			return -EFAULT;
 
+		if ((userlv = kmalloc(sizeof(lv_t),GFP_KERNEL)) == NULL) {
+			printk(KERN_CRIT
+			       "%s -- LV_RENAME: kmalloc error LV at line %d\n",
+			       lvm_name, __LINE__);
+			return -ENOMEM;
+		}
+
 		if (command != LV_REMOVE) {
-			if (copy_from_user(&lv, lv_req.lv, sizeof(lv_t)) != 0)
+			if (copy_from_user(userlv, lv_req.lv, sizeof(lv_t)) != 0)
 				return -EFAULT;
 		}
 		switch (command) {
 		case LV_CREATE:
-			return lvm_do_lv_create(minor, lv_req.lv_name, &lv);
+			ret=lvm_do_lv_create(minor, lv_req.lv_name, userlv);
 
 		case LV_EXTEND:
 		case LV_REDUCE:
-			return lvm_do_lv_extend_reduce(minor, lv_req.lv_name, &lv);
+			ret=lvm_do_lv_extend_reduce(minor, lv_req.lv_name, userlv);
+			break;
 		case LV_REMOVE:
-			return lvm_do_lv_remove(minor, lv_req.lv_name, -1);
+			ret=lvm_do_lv_remove(minor, lv_req.lv_name, -1);
+			break;
 
 		case LV_RENAME:
-			return lvm_do_lv_rename(vg_ptr, &lv_req, &lv);
+			ret=lvm_do_lv_rename(vg_ptr, &lv_req, userlv);
+			break;
+		default:
+			ret=-EINVAL;
 		}
-
-
+		kfree(userlv);
+		return ret;
 
 
 	case LV_STATUS_BYNAME:
@@ -1046,7 +1060,7 @@
 
 	memset(&bio,0,sizeof(bio));
 	bio.bi_dev = inode->i_rdev;
-	bio.bi_size = lvm_get_blksize(bio.bi_dev); /* NEEDED by bio_sectors */
+	bio.bi_size = block_size(bio.bi_dev);
  	bio.bi_sector = block * bio_sectors(&bio);
 	bio.bi_rw = READ;
 	if ((err=lvm_map(&bio)) < 0)  {



