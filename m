Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWJJSVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWJJSVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWJJSVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:21:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:54934 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965007AbWJJSVD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:21:03 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, Joel.Becker@oracle.com
Cc: ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Chandra Seetharaman <sekharan@us.ibm.com>
Date: Tue, 10 Oct 2006 11:20:55 -0700
Message-Id: <20061010182055.20990.77906.sendpatchset@localhost.localdomain>
In-Reply-To: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
Subject: [PATCH 2/5] Use seq_file for read side of operations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

configfs currently has a limitation that the kernel can send only 
PAGESIZE of data through a attribute.

This patch removes that limitation by using seq_file in the read side of
operations.

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
--

 fs/configfs/file.c       |  130 ++++++++++-------------------------------------
 include/linux/configfs.h |    3 -
 2 files changed, 31 insertions(+), 102 deletions(-)

Index: linux-2.6.18/fs/configfs/file.c
===================================================================
--- linux-2.6.18.orig/fs/configfs/file.c
+++ linux-2.6.18/fs/configfs/file.c
@@ -40,112 +40,33 @@ struct configfs_buffer {
 	char			* page;
 	struct configfs_item_operations	* ops;
 	struct semaphore	sem;
-	int			needs_read_fill;
+	struct dentry		* dentry;
 };
 
 
 /**
- *	fill_read_buffer - allocate and fill buffer from item.
- *	@dentry:	dentry pointer.
- *	@buffer:	data buffer for file.
- *
- *	Allocate @buffer->page, if it hasn't been already, then call the
- *	config_item's show() method to fill the buffer with this attribute's
- *	data.
- *	This is called only once, on the file's first read.
- */
-static int fill_read_buffer(struct dentry * dentry, struct configfs_buffer * buffer)
-{
-	struct configfs_attribute * attr = to_attr(dentry);
-	struct config_item * item = to_item(dentry->d_parent);
-	struct configfs_item_operations * ops = buffer->ops;
-	int ret = 0;
-	ssize_t count;
-
-	if (!buffer->page)
-		buffer->page = (char *) get_zeroed_page(GFP_KERNEL);
-	if (!buffer->page)
-		return -ENOMEM;
-
-	count = ops->show_attribute(item,attr,buffer->page);
-	buffer->needs_read_fill = 0;
-	BUG_ON(count > (ssize_t)PAGE_SIZE);
-	if (count >= 0)
-		buffer->count = count;
-	else
-		ret = count;
-	return ret;
-}
-
-
-/**
- *	flush_read_buffer - push buffer to userspace.
- *	@buffer:	data buffer for file.
- *	@userbuf:	user-passed buffer.
- *	@count:		number of bytes requested.
- *	@ppos:		file position.
- *
- *	Copy the buffer we filled in fill_read_buffer() to userspace.
- *	This is done at the reader's leisure, copying and advancing
- *	the amount they specify each time.
- *	This may be called continuously until the buffer is empty.
- */
-static int flush_read_buffer(struct configfs_buffer * buffer, char __user * buf,
-			     size_t count, loff_t * ppos)
-{
-	int error;
-
-	if (*ppos > buffer->count)
-		return 0;
-
-	if (count > (buffer->count - *ppos))
-		count = buffer->count - *ppos;
-
-	error = copy_to_user(buf,buffer->page + *ppos,count);
-	if (!error)
-		*ppos += count;
-	return error ? -EFAULT : count;
-}
-
-/**
  *	configfs_read_file - read an attribute.
- *	@file:	file pointer.
- *	@buf:	buffer to fill.
- *	@count:	number of bytes to read.
- *	@ppos:	starting offset in file.
+ *	@s:	seq_file pointer.
+ *	@v:	unused void pointer
  *
  *	Userspace wants to read an attribute file. The attribute descriptor
- *	is in the file's ->d_fsdata. The target item is in the directory's
- *	->d_fsdata.
+ *	is available through dentry, which is stored in the seq_file.
+ *	The target item is in the dentry's parent.
+ *
+ *	We just call the show() method directly.
  *
- *	We call fill_read_buffer() to allocate and fill the buffer from the
- *	item's show() method exactly once (if the read is happening from
- *	the beginning of the file). That should fill the entire buffer with
- *	all the data the item has to offer for that attribute.
- *	We then call flush_read_buffer() to copy the buffer to userspace
- *	in the increments specified.
  */
-
-static ssize_t
-configfs_read_file(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+static int
+configfs_read_file(struct seq_file *s, void *v)
 {
-	struct configfs_buffer * buffer = file->private_data;
-	ssize_t retval = 0;
+	struct configfs_buffer * buffer = s->private;
+	struct configfs_item_operations * ops = buffer->ops;
+	struct configfs_attribute * attr = to_attr(buffer->dentry);
+	struct config_item * item = to_item(buffer->dentry->d_parent);
 
-	down(&buffer->sem);
-	if (buffer->needs_read_fill) {
-		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
-			goto out;
-	}
-	pr_debug("%s: count = %d, ppos = %lld, buf = %s\n",
-		 __FUNCTION__,count,*ppos,buffer->page);
-	retval = flush_read_buffer(buffer,buf,count,ppos);
-out:
-	up(&buffer->sem);
-	return retval;
+	return ops->show_attribute(item, attr, s);
 }
 
-
 /**
  *	fill_write_buffer - copy buffer from userspace.
  *	@buffer:	data buffer for file.
@@ -169,7 +90,6 @@ fill_write_buffer(struct configfs_buffer
 	if (count > PAGE_SIZE)
 		count = PAGE_SIZE;
 	error = copy_from_user(buffer->page,buf,count);
-	buffer->needs_read_fill = 1;
 	return error ? -EFAULT : count;
 }
 
@@ -216,7 +136,8 @@ flush_write_buffer(struct dentry * dentr
 static ssize_t
 configfs_write_file(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
-	struct configfs_buffer * buffer = file->private_data;
+	struct configfs_buffer * buffer =
+			((struct seq_file *)file->private_data)->private;
 	ssize_t len;
 
 	down(&buffer->sem);
@@ -281,9 +202,14 @@ static int check_perm(struct inode * ino
 	}
 	memset(buffer,0,sizeof(struct configfs_buffer));
 	init_MUTEX(&buffer->sem);
-	buffer->needs_read_fill = 1;
 	buffer->ops = ops;
-	file->private_data = buffer;
+	buffer->dentry = file->f_dentry;
+
+	error = single_open(file, configfs_read_file, buffer);
+	if (error) {
+		kfree(buffer);
+		goto Enomem;
+	}
 	goto Done;
 
  Einval:
@@ -309,7 +235,8 @@ static int configfs_release(struct inode
 	struct config_item * item = to_item(filp->f_dentry->d_parent);
 	struct configfs_attribute * attr = to_attr(filp->f_dentry);
 	struct module * owner = attr->ca_owner;
-	struct configfs_buffer * buffer = filp->private_data;
+	struct configfs_buffer * buffer =
+			((struct seq_file *)filp->private_data)->private;
 
 	if (item)
 		config_item_put(item);
@@ -321,13 +248,14 @@ static int configfs_release(struct inode
 			free_page((unsigned long)buffer->page);
 		kfree(buffer);
 	}
-	return 0;
+
+	return single_release(inode, filp);
 }
 
 const struct file_operations configfs_file_operations = {
-	.read		= configfs_read_file,
+	.read		= seq_read,
 	.write		= configfs_write_file,
-	.llseek		= generic_file_llseek,
+	.llseek		= seq_lseek,
 	.open		= configfs_open_file,
 	.release	= configfs_release,
 };
Index: linux-2.6.18/include/linux/configfs.h
===================================================================
--- linux-2.6.18.orig/include/linux/configfs.h
+++ linux-2.6.18/include/linux/configfs.h
@@ -40,6 +40,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/kref.h>
+#include <linux/seq_file.h>
 
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
@@ -147,7 +148,7 @@ struct configfs_attribute {
  */
 struct configfs_item_operations {
 	void (*release)(struct config_item *);
-	ssize_t	(*show_attribute)(struct config_item *, struct configfs_attribute *,char *);
+	int	(*show_attribute)(struct config_item *, struct configfs_attribute *,struct seq_file *);
 	ssize_t	(*store_attribute)(struct config_item *,struct configfs_attribute *,const char *, size_t);
 	int (*allow_link)(struct config_item *src, struct config_item *target);
 	int (*drop_link)(struct config_item *src, struct config_item *target);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
