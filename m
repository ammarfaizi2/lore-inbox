Return-Path: <linux-kernel-owner+willy=40w.ods.org-S510396AbUKBCVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S510396AbUKBCVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 21:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S276527AbUKAXSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:18:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:10916 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S286251AbUKAV7Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:59:24 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <10993462762242@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Mon, 1 Nov 2004 13:57:56 -0800
Message-Id: <10993462761856@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2445, 2004/11/01 13:04:30-08:00, akpm@osdl.org

[PATCH] Fix race in sysfs_read_file() and sysfs_write_file()

From: Simon Derr <Simon.Derr@bull.net>

- fixes the race between threads by adding a semaphore in sysfs_buffer

- allocates the buffer upon call to pread().  We still call again
  fill_read_buffer() if the file is "rewinded" to offset zero.

- fixes the comparison in flush_read_buffer().

Signed-off-by: Simon Derr <simon.derr@bull.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/file.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)


diff -Nru a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c	2004-11-01 13:36:49 -08:00
+++ b/fs/sysfs/file.c	2004-11-01 13:36:49 -08:00
@@ -6,6 +6,7 @@
 #include <linux/dnotify.h>
 #include <linux/kobject.h>
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>
 
 #include "sysfs.h"
 
@@ -53,6 +54,7 @@
 	loff_t			pos;
 	char			* page;
 	struct sysfs_ops	* ops;
+	struct semaphore	sem;
 };
 
 
@@ -106,6 +108,9 @@
 {
 	int error;
 
+	if (*ppos > buffer->count)
+		return 0;
+
 	if (count > (buffer->count - *ppos))
 		count = buffer->count - *ppos;
 
@@ -140,13 +145,17 @@
 	struct sysfs_buffer * buffer = file->private_data;
 	ssize_t retval = 0;
 
-	if (!*ppos) {
+	down(&buffer->sem);
+	if ((!*ppos) || (!buffer->page)) {
 		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
-			return retval;
+			goto out;
 	}
 	pr_debug("%s: count = %d, ppos = %lld, buf = %s\n",
 		 __FUNCTION__,count,*ppos,buffer->page);
-	return flush_read_buffer(buffer,buf,count,ppos);
+	retval = flush_read_buffer(buffer,buf,count,ppos);
+out:
+	up(&buffer->sem);
+	return retval;
 }
 
 
@@ -220,11 +229,13 @@
 {
 	struct sysfs_buffer * buffer = file->private_data;
 
+	down(&buffer->sem);
 	count = fill_write_buffer(buffer,buf,count);
 	if (count > 0)
 		count = flush_write_buffer(file->f_dentry,buffer,count);
 	if (count > 0)
 		*ppos += count;
+	up(&buffer->sem);
 	return count;
 }
 
@@ -287,6 +298,7 @@
 	buffer = kmalloc(sizeof(struct sysfs_buffer),GFP_KERNEL);
 	if (buffer) {
 		memset(buffer,0,sizeof(struct sysfs_buffer));
+		init_MUTEX(&buffer->sem);
 		buffer->ops = ops;
 		file->private_data = buffer;
 	} else

