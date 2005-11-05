Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVKEQdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVKEQdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVKEQdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:33:25 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:20165 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751251AbVKEQdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:33:24 -0500
Message-Id: <20051105162710.209305000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:26:51 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, ak@suse.de, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/25] compat: Remove leftovers from register_ioctl32_conversion
Content-Disposition: inline; filename=ioctl32-leftover.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need the semaphore any more since we no longer
write to the ioctl32 hash table while the kernel is running.

CC: ak@suse.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6.14-rc/fs/compat.c
===================================================================
--- linux-2.6.14-rc.orig/fs/compat.c	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/fs/compat.c	2005-11-05 02:41:14.000000000 +0100
@@ -268,7 +268,6 @@
 
 #define IOCTL_HASHSIZE 256
 static struct ioctl_trans *ioctl32_hash_table[IOCTL_HASHSIZE];
-static DECLARE_RWSEM(ioctl32_sem);
 
 extern struct ioctl_trans ioctl_start[];
 extern int ioctl_table_size;
@@ -390,14 +389,10 @@
 		break;
 	}
 
-	/* When register_ioctl32_conversion is finally gone remove
-	   this lock! -AK */
-	down_read(&ioctl32_sem);
 	for (t = ioctl32_hash_table[ioctl32_hash(cmd)]; t; t = t->next) {
 		if (t->cmd == cmd)
 			goto found_handler;
 	}
-	up_read(&ioctl32_sem);
 
 	if (S_ISSOCK(filp->f_dentry->d_inode->i_mode) &&
 	    cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
@@ -417,11 +412,9 @@
 		lock_kernel();
 		error = t->handler(fd, cmd, arg, filp);
 		unlock_kernel();
-		up_read(&ioctl32_sem);
 		goto out_fput;
 	}
 
-	up_read(&ioctl32_sem);
  do_ioctl:
 	error = vfs_ioctl(filp, fd, cmd, arg);
  out_fput:
Index: linux-2.6.14-rc/include/linux/ioctl32.h
===================================================================
--- linux-2.6.14-rc.orig/include/linux/ioctl32.h	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/include/linux/ioctl32.h	2005-11-05 02:41:14.000000000 +0100
@@ -1,8 +1,6 @@
 #ifndef IOCTL32_H
 #define IOCTL32_H 1
 
-#include <linux/compiler.h>	/* for __deprecated */
-
 struct file;
 
 typedef int (*ioctl_trans_handler_t)(unsigned int, unsigned int,

--

