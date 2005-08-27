Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbVH0FpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbVH0FpL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 01:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVH0FpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 01:45:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15795 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1030314AbVH0FpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 01:45:10 -0400
Date: Sat, 27 Aug 2005 06:48:15 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com
Subject: [PATCH] mmaper_kern.c fixes [buffer overruns]
Message-ID: <20050827054815.GC9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* copy_from_user() can fail; ->write() must check its return
value.
	* severe buffer overruns both in ->read() and ->write() - lseek
to the end (i.e. to mmapper_size) and
	if(count + *ppos > mmapper_size)
		count = count + *ppos - mmapper_size;
will do absolutely nothing.  Then it will call
	copy_to_user(buf,&v_buf[*ppos],count);
with obvious results (similar for ->write()).
	Fixed by turning read to simple_read_from_buffer() and by doing
normal limiting of count in ->write().
	* gratitious lock_kernel() in ->mmap() - it's useless there.
	* lots of gratitious includes.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-base/arch/um/drivers/mmapper_kern.c current/arch/um/drivers/mmapper_kern.c
--- RC13-rc7-base/arch/um/drivers/mmapper_kern.c	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/um/drivers/mmapper_kern.c	2005-08-27 01:25:20.000000000 -0400
@@ -9,19 +9,11 @@
  *
  */
 
-#include <linux/types.h>
-#include <linux/kdev_t.h>
-#include <linux/time.h>
-#include <linux/devfs_fs_kernel.h>
+#include <linux/init.h> 
 #include <linux/module.h>
 #include <linux/mm.h> 
-#include <linux/slab.h>
-#include <linux/init.h> 
-#include <linux/smp_lock.h>
 #include <linux/miscdevice.h>
 #include <asm/uaccess.h>
-#include <asm/irq.h>
-#include <asm/pgtable.h>
 #include "mem_user.h"
 #include "user_util.h"
  
@@ -31,35 +23,22 @@
 static char *v_buf = NULL;
 
 static ssize_t
-mmapper_read(struct file *file, char *buf, size_t count, loff_t *ppos)
+mmapper_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
-	if(*ppos > mmapper_size)
-		return -EINVAL;
-
-	if(count + *ppos > mmapper_size)
-		count = count + *ppos - mmapper_size;
-
-	if(count < 0)
-		return -EINVAL;
- 
-	copy_to_user(buf,&v_buf[*ppos],count);
-	
-	return count;
+	return simple_read_from_buffer(buf, count, ppos, v_buf, mmapper_size);
 }
 
 static ssize_t
-mmapper_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+mmapper_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
-	if(*ppos > mmapper_size)
+	if (*ppos > mmapper_size)
 		return -EINVAL;
 
-	if(count + *ppos > mmapper_size)
-		count = count + *ppos - mmapper_size;
-
-	if(count < 0)
-		return -EINVAL;
+	if (count > mmapper_size - *ppos)
+		count = mmapper_size - *ppos;
 
-	copy_from_user(&v_buf[*ppos],buf,count);
+	if (copy_from_user(&v_buf[*ppos], buf, count))
+		return -EFAULT;
 	
 	return count;
 }
@@ -77,7 +56,6 @@
 	int ret = -EINVAL;
 	int size;
 
-	lock_kernel();
 	if (vma->vm_pgoff != 0)
 		goto out;
 	
@@ -92,7 +70,6 @@
 		goto out;
 	ret = 0;
 out:
-	unlock_kernel();
 	return ret;
 }
 
