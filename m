Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbTIUW6l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 18:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTIUW6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 18:58:41 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:6837 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S262597AbTIUW6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 18:58:39 -0400
Date: Mon, 22 Sep 2003 02:58:32 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       mauelshagen@sistina.com
Subject: [PATCH] [2.4] fix LVM memleaks.
Message-ID: <20030921225832.GA12040@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There are two error patchs in lvm code, that leads to leaking memory.
   One if creating too many volume gropups and one if incorrect
   buffer from userspace was passed.
   Fixes are trivial. Please apply.

   Found with help of smatch.


===== drivers/md/lvm.c 1.20 vs edited =====
--- 1.20/drivers/md/lvm.c	Mon Mar 10 17:55:46 2003
+++ edited/drivers/md/lvm.c	Mon Sep 22 02:53:54 2003
@@ -1584,8 +1584,10 @@
 		minor = vg_ptr->vg_number;
 
 	/* check limits */
-	if (minor >= ABS_MAX_VG)
+	if (minor >= ABS_MAX_VG) {
+		kfree(vg_ptr);
 		return -EFAULT;
+	}
 
 	/* Validate it */
 	if (vg[VG_CHR(minor)] != NULL) {
@@ -1653,8 +1655,7 @@
 				P_IOCTL
 				    ("ERROR: copying LV ptr %p (%d bytes)\n",
 				     lvp, sizeof(lv_t));
-				lvm_do_vg_remove(minor);
-				return -EFAULT;
+				goto copy_fault;
 			}
 			if (lv.lv_access & LV_SNAPSHOT) {
 				snap_lv_ptr[ls] = lvp;
@@ -1665,8 +1666,7 @@
 			vg_ptr->lv[l] = NULL;
 			/* only create original logical volumes for now */
 			if (lvm_do_lv_create(minor, lv.lv_name, &lv) != 0) {
-				lvm_do_vg_remove(minor);
-				return -EFAULT;
+				goto copy_fault;
 			}
 		}
 	}
@@ -1676,12 +1676,10 @@
 	for (l = 0; l < ls; l++) {
 		lv_t *lvp = snap_lv_ptr[l];
 		if (copy_from_user(&lv, lvp, sizeof(lv_t)) != 0) {
-			lvm_do_vg_remove(minor);
-			return -EFAULT;
+			goto copy_fault;
 		}
 		if (lvm_do_lv_create(minor, lv.lv_name, &lv) != 0) {
-			lvm_do_vg_remove(minor);
-			return -EFAULT;
+			goto copy_fault;
 		}
 	}
 
@@ -1696,6 +1694,10 @@
 	vg_ptr->vg_status |= VG_ACTIVE;
 
 	return 0;
+copy_fault:
+	lvm_do_vg_remove(minor);
+	vfree(snap_lv_ptr);
+	return -EFAULT;
 }				/* lvm_do_vg_create() */
 
 
