Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUIAIVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUIAIVC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 04:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUIAIUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 04:20:48 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:19664 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263024AbUIAISP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 04:18:15 -0400
Date: Wed, 1 Sep 2004 10:17:50 +0200 (DFT)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@isabelle.frec.bull.fr
To: greg@kroah.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Possible race in sysfs_read_file() and sysfs_write_file()
Message-ID: <Pine.A41.4.53.0409010924250.122970@isabelle.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I think there is a possibility for two threads from a single process to
race in sysfs_read_file() if they call read() on the same file at the same
time.

Supposing no read() has been done on this file previously, the two threads
could end allocating each a new page in fill_read_buffer() for
buffer->page, and one of these pages would be lost forever.

The same applies to write().

This patch adds a semaphore in struct sysfs_buffer to fix this issue.

Now it should be sufficient, to fix this memory leak, to protect only the
call to get_zeroed_page() in fill_read_buffer() with the semaphore.

Instead, this patch holds the semaphore during the whole
sysfs_read_file().

The reason is that there is also a risk, with the current code, of having
one thread in flush_read_buffer() while the another is in
fill_read_buffer()/ops->show(), and then maybe read()  returning garbage.

This is more likely to happen actually if two threads call write() at the
same time with different data, with one thread using the data of the
buffer->page in ops->store(), and another thread overwriting that data in
fill_write_buffer(), thus maybe having ops->store() using corrupted data.

Of course in this case, the multithreaded application is broken and should
not expect a correct kernel behaviour... so maybe only protection around
get_zeroed_page() is needed.

	Simon.

This patch is against 2.6.9-rc1-mm2.


Signed-off-by: Simon Derr <simon.derr@bull.net>

Index: 269mm2kdb/fs/sysfs/file.c
===================================================================
--- 269mm2kdb.orig/fs/sysfs/file.c	2004-08-31 11:29:16.000000000 +0200
+++ 269mm2kdb/fs/sysfs/file.c	2004-09-01 10:00:57.582251616 +0200
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


@@ -140,13 +142,17 @@
 	struct sysfs_buffer * buffer = file->private_data;
 	ssize_t retval = 0;

+	down(&buffer->sem);
 	if (!*ppos) {
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


@@ -220,11 +226,13 @@
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

@@ -287,6 +295,7 @@
 	buffer = kmalloc(sizeof(struct sysfs_buffer),GFP_KERNEL);
 	if (buffer) {
 		memset(buffer,0,sizeof(struct sysfs_buffer));
+		init_MUTEX(&buffer->sem);
 		buffer->ops = ops;
 		file->private_data = buffer;
 	} else
