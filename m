Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSKRAAN>; Sun, 17 Nov 2002 19:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSKRAAN>; Sun, 17 Nov 2002 19:00:13 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:30127 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261305AbSKRAAM>; Sun, 17 Nov 2002 19:00:12 -0500
Date: Sun, 17 Nov 2002 19:08:16 -0500
From: Doug Ledford <dledford@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Module refcounting in fs/proc/inode.c
Message-ID: <20021118000816.GN3280@redhat.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch should make module ref counting safe in the proc filesystem.  
Without it, accessing /proc/scsi/aic7xxx/0 renders the aic7xxx module 
unloadable.  However, I assume that we can call put_de() on the de we have 
at the time that the module ref inc attempt might fail.  If that's not 
right, then someone who knows de ops will have to correct this patch.



-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc-inode.patch"

===== fs/proc/inode.c 1.17 vs edited =====
--- 1.17/fs/proc/inode.c	Sat Sep 28 11:36:29 2002
+++ edited/fs/proc/inode.c	Sun Nov 17 18:22:38 2002
@@ -73,7 +73,7 @@
 	de = PROC_I(inode)->pde;
 	if (de) {
 		if (de->owner)
-			__MOD_DEC_USE_COUNT(de->owner);
+			module_put(de->owner);
 		de_put(de);
 	}
 }
@@ -201,7 +201,8 @@
 		if (de->nlink)
 			inode->i_nlink = de->nlink;
 		if (de->owner)
-			__MOD_INC_USE_COUNT(de->owner);
+			if(!try_module_get(de->owner))
+				goto out_fail;
 		if (de->proc_iops)
 			inode->i_op = de->proc_iops;
 		if (de->proc_fops)

--wac7ysb48OaltWcw--
