Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUHNX33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUHNX33 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 19:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266339AbUHNX32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 19:29:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:22486 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266333AbUHNX3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 19:29:07 -0400
Date: Sat, 14 Aug 2004 16:29:06 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] use simple_read_from_buffer in proc_info_read and proc_pid_attr_read
Message-ID: <20040814162906.D1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use simple_read_from_buffer in proc_info_read and proc_pid_attr_read.
Viro had ack'd this earlier.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== fs/proc/base.c 1.71 vs edited =====
--- 1.71/fs/proc/base.c	2004-06-19 22:42:40 -07:00
+++ edited/fs/proc/base.c	2004-08-06 18:27:59 -07:00
@@ -517,7 +517,6 @@
 	struct inode * inode = file->f_dentry->d_inode;
 	unsigned long page;
 	ssize_t length;
-	ssize_t end;
 	struct task_struct *task = proc_task(inode);
 
 	if (count > PROC_BLOCK_SIZE)
@@ -527,24 +526,10 @@
 
 	length = PROC_I(inode)->op.proc_read(task, (char*)page);
 
-	if (length < 0) {
-		free_page(page);
-		return length;
-	}
-	/* Static 4kB (or whatever) block capacity */
-	if (*ppos >= length) {
-		free_page(page);
-		return 0;
-	}
-	if (count + *ppos > length)
-		count = length - *ppos;
-	end = count + *ppos;
-	if (copy_to_user(buf, (char *) page + *ppos, count))
-		count = -EFAULT;
-	else
-		*ppos = end;
+	if (length >= 0)
+		length = simple_read_from_buffer(buf, count, ppos, (char *)page, length);
 	free_page(page);
-	return count;
+	return length;
 }
 
 static struct file_operations proc_info_file_operations = {
@@ -1168,7 +1153,6 @@
 	struct inode * inode = file->f_dentry->d_inode;
 	unsigned long page;
 	ssize_t length;
-	ssize_t end;
 	struct task_struct *task = proc_task(inode);
 
 	if (count > PAGE_SIZE)
@@ -1179,24 +1163,10 @@
 	length = security_getprocattr(task, 
 				      (char*)file->f_dentry->d_name.name, 
 				      (void*)page, count);
-	if (length < 0) {
-		free_page(page);
-		return length;
-	}
-	/* Static 4kB (or whatever) block capacity */
-	if (*ppos >= length) {
-		free_page(page);
-		return 0;
-	}
-	if (count + *ppos > length)
-		count = length - *ppos;
-	end = count + *ppos;
-	if (copy_to_user(buf, (char *) page + *ppos, count))
-		count = -EFAULT;
-	else
-		*ppos = end;
+	if (length >= 0)
+		length = simple_read_from_buffer(buf, count, ppos, (char *)page, length);
 	free_page(page);
-	return count;
+	return length;
 }
 
 static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
