Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbVKGVE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVKGVE0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbVKGVE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:04:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27667 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964924AbVKGVEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:04:25 -0500
Date: Mon, 7 Nov 2005 22:04:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, ak@suse.de,
       Arnd Bergmann <arnd@arndb.de>
Subject: [2.6 patch] compat: Remove leftovers from register_ioctl32_conversion
Message-ID: <20051107210423.GT3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need the semaphore any more since we no longer
write to the ioctl32 hash table while the kernel is running.

This patch was already ACK'ed by Andi Kleen.


Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Arnd Bergmann on:
- 05 Nov 2005

 fs/compat.c             |    7 -------
 include/linux/ioctl32.h |    4 ----
 2 files changed, 11 deletions(-)

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


