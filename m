Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVAUWdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVAUWdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVAUVsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:48:40 -0500
Received: from fmr20.intel.com ([134.134.136.19]:60573 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262538AbVAUVor convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:44:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] sysfs write fixes
Date: Fri, 21 Jan 2005 13:44:45 -0800
Message-ID: <F3EE2A9EB4576F40AFE238EC0AC04BC50488BA12@orsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] sysfs write fixes
thread-index: AcUAAmwjAOMixeJGRZiaNsuhFGzvpA==
From: "Williams, Mitch A" <mitch.a.williams@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <greg@kroah.com>
X-OriginalArrivalTime: 21 Jan 2005 21:44:46.0451 (UTC) FILETIME=[6CC1EC30:01C50002]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects some errors that we saw while writing to sysfs
files.
 - Attempts to open the file in append mode result in error
 - Writes are buffered and flushed to the kobject owner during close
 - Attempts to seek on sysfs files result in error

Generated from 2.6.11-rc1.

It's not a big patch, but if you'd like it whacked up into smaller ones,
I'll
be glad to do so.

Signed-off-by:  Mitch Williams <mitch.a.williams@intel.com>


diff -uprN -X dontdiff linux-2.6.11-clean/fs/sysfs/file.c
linux-2.6.11/fs/sysfs/file.c
--- linux-2.6.11-clean/fs/sysfs/file.c	2004-12-24 13:33:50.000000000
-0800
+++ linux-2.6.11/fs/sysfs/file.c	2005-01-21 13:09:21.000000000
-0800
@@ -1,5 +1,11 @@
 /*
  * file.c - operations for regular (text) files.
+ *
+ * Changes:
+ * 2004/01/21 Mitch Williams <mitch.a.williams at intel.com>
+ *   - Changed llseek method to be no_llseek.
+ *   - Opening a file for append now returns an error.
+ *   - Writes are now buffered and flushed at close
  */
 
 #include <linux/module.h>
@@ -55,7 +61,8 @@ struct sysfs_buffer {
 	char			* page;
 	struct sysfs_ops	* ops;
 	struct semaphore	sem;
-	int			needs_read_fill;
+	int			read_filled;
+	int			needs_write_flush;
 };
 
 
@@ -83,7 +90,7 @@ static int fill_read_buffer(struct dentr
 		return -ENOMEM;
 
 	count = ops->show(kobj,attr,buffer->page);
-	buffer->needs_read_fill = 0;
+	buffer->read_filled = 1;
 	BUG_ON(count > (ssize_t)PAGE_SIZE);
 	if (count >= 0)
 		buffer->count = count;
@@ -148,7 +155,7 @@ sysfs_read_file(struct file *file, char 
 	ssize_t retval = 0;
 
 	down(&buffer->sem);
-	if (buffer->needs_read_fill) {
+	if (!buffer->read_filled) {
 		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
 			goto out;
 	}
@@ -172,7 +179,8 @@ out:
  */
 
 static int 
-fill_write_buffer(struct sysfs_buffer * buffer, const char __user *
buf, size_t count)
+fill_write_buffer(struct sysfs_buffer *buffer, const char __user * buf,
+		  size_t count, size_t pos)
 {
 	int error;
 
@@ -181,10 +189,11 @@ fill_write_buffer(struct sysfs_buffer * 
 	if (!buffer->page)
 		return -ENOMEM;
 
-	if (count >= PAGE_SIZE)
-		count = PAGE_SIZE - 1;
+	if (count + pos > PAGE_SIZE)
+		count = (PAGE_SIZE - 1) - pos;
 	error = copy_from_user(buffer->page,buf,count);
-	buffer->needs_read_fill = 1;
+	buffer->needs_write_flush = 1;
+        buffer->count = pos + count;
 	return error ? -EFAULT : count;
 }
 
@@ -200,13 +209,13 @@ fill_write_buffer(struct sysfs_buffer * 
  */
 
 static int 
-flush_write_buffer(struct dentry * dentry, struct sysfs_buffer *
buffer, size_t count)
+flush_write_buffer(struct dentry * dentry, struct sysfs_buffer *
buffer)
 {
 	struct attribute * attr = to_attr(dentry);
 	struct kobject * kobj = to_kobj(dentry->d_parent);
 	struct sysfs_ops * ops = buffer->ops;
 
-	return ops->store(kobj,attr,buffer->page,count);
+	return ops->store(kobj,attr, buffer->page, buffer->count);
 }
 
 
@@ -219,12 +228,9 @@ flush_write_buffer(struct dentry * dentr
  *
  *	Similar to sysfs_read_file(), though working in the opposite
direction.
  *	We allocate and fill the data from the user in
fill_write_buffer(),
- *	then push it to the kobject in flush_write_buffer().
- *	There is no easy way for us to know if userspace is only doing a
partial
- *	write, so we don't support them. We expect the entire buffer to
come
- *	on the first write. 
- *	Hint: if you're writing a value, first read the file, modify
only the
- *	the value you're changing, then write entire buffer back. 
+ *	but don't push it to the kobject until the file is closed.
+ *      This allows for buffered writes, but unfortunately also hides
error
+ *      codes returned individual store functions until close time.
  */
 
 static ssize_t
@@ -232,10 +238,10 @@ sysfs_write_file(struct file *file, cons
 {
 	struct sysfs_buffer * buffer = file->private_data;
 
+	if (*ppos >= PAGE_SIZE)
+		return -ENOSPC;
 	down(&buffer->sem);
-	count = fill_write_buffer(buffer,buf,count);
-	if (count > 0)
-		count = flush_write_buffer(file->f_dentry,buffer,count);
+	count = fill_write_buffer(buffer, buf, count, *ppos);
 	if (count > 0)
 		*ppos += count;
 	up(&buffer->sem);
@@ -275,6 +281,11 @@ static int check_perm(struct inode * ino
 	if (!ops)
 		goto Eaccess;
 
+	/* Is the file is open for append?  Sorry, we don't do that. */
+	if (file->f_flags & O_APPEND) {
+		goto Einval;
+	}
+
 	/* File needs write support.
 	 * The inode's perms must say it's ok, 
 	 * and we must have a store method.
@@ -302,11 +313,14 @@ static int check_perm(struct inode * ino
 	if (buffer) {
 		memset(buffer,0,sizeof(struct sysfs_buffer));
 		init_MUTEX(&buffer->sem);
-		buffer->needs_read_fill = 1;
 		buffer->ops = ops;
 		file->private_data = buffer;
 	} else
 		error = -ENOMEM;
+
+	/*  Set mode bits to disallow seeking.  */
+	file->f_mode &= ~(FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
+
 	goto Done;
 
  Einval:
@@ -332,6 +346,17 @@ static int sysfs_release(struct inode * 
 	struct attribute * attr = to_attr(filp->f_dentry);
 	struct module * owner = attr->owner;
 	struct sysfs_buffer * buffer = filp->private_data;
+        int ret;
+
+	/* If data has been written to the file, then flush it
+	 * back to the kobject's store function here.
+	 */
+	if (buffer && kobj) {
+		down(&buffer->sem);
+		if (buffer->needs_write_flush)
+			ret = flush_write_buffer(filp->f_dentry,
buffer);
+		up(&buffer->sem);
+	}
 
 	if (kobj) 
 		kobject_put(kobj);
@@ -343,13 +368,16 @@ static int sysfs_release(struct inode * 
 			free_page((unsigned long)buffer->page);
 		kfree(buffer);
 	}
-	return 0;
+	/* If flush_write_buffer returned an error, pass it up.
+	 * Otherwise, return success.
+	 */
+	return (ret < 0 ? ret : 0);
 }
 
 struct file_operations sysfs_file_operations = {
 	.read		= sysfs_read_file,
 	.write		= sysfs_write_file,
-	.llseek		= generic_file_llseek,
+	.llseek		= no_llseek,
 	.open		= sysfs_open_file,
 	.release	= sysfs_release,
 };
