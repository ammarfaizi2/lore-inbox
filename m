Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVERUUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVERUUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 16:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVERUTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 16:19:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:39569 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262333AbVERUTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 16:19:09 -0400
Date: Wed, 18 May 2005 13:24:46 -0700
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] libfs: add simple attribute files
Message-ID: <20050518202446.GA20041@kroah.com>
References: <200505132117.37461.arnd@arndb.de> <200505132129.07603.arnd@arndb.de> <20050514074524.GC20021@kroah.com> <200505181441.01495.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505181441.01495.arnd@arndb.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 02:40:59PM +0200, Arnd Bergmann wrote:
> Based on the discussion about spufs attributes, this is my suggestion
> for a more generic attribute file support that can be used by both
> debugfs and spufs.

Thanks for the patch.  I've cleaned it up a bit (drop the spufs
comments, changed the access check, and made the val be u64, and
exported the symbols and cleaned up the debugfs portion) and added it to
my tree.  It should show up in the next -mm release.  I've included the
patch below so you can see my
changes.

thanks,

greg k-h

---------------

Based on the discussion about spufs attributes, this is my suggestion
for a more generic attribute file support that can be used by both
debugfs and spufs.

Simple attribute files behave similarly to sequential files from
a kernel programmers perspective in that a standard set of file
operations is provided and only an open operation needs to
be written that registers file specific get() and set() functions.

These operations are defined as

void foo_set(void *data, long val); and
long foo_get(void *data);

where data is the inode->u.generic_ip pointer of the file and the
operations just need to make send of that pointer. The infrastructure
makes sure this works correctly with concurrent access and partial
read calls.

A macro named DEFINE_SIMPLE_ATTRIBUTE is provided to further simplify
using the attributes.

This patch already contains the changes for debugfs to use attributes
for its internal file operations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/debugfs/file.c  |   67 +++++++++++++++--------------------
 fs/libfs.c         |   99 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |   46 ++++++++++++++++++++++++
 3 files changed, 174 insertions(+), 38 deletions(-)

--- gregkh-2.6.orig/include/linux/fs.h	2005-05-18 11:16:39.000000000 -0700
+++ gregkh-2.6/include/linux/fs.h	2005-05-18 11:16:51.000000000 -0700
@@ -1657,6 +1657,52 @@
 	ar->size = n;
 }
 
+/*
+ * simple attribute files
+ *
+ * These attributes behave similar to those in sysfs:
+ *
+ * Writing to an attribute immediately sets a value, an open file can be
+ * written to multiple times.
+ *
+ * Reading from an attribute creates a buffer from the value that might get
+ * read with multiple read calls. When the attribute has been read
+ * completely, no further read calls are possible until the file is opened
+ * again.
+ *
+ * All attributes contain a text representation of a numeric value
+ * that are accessed with the get() and set() functions.
+ */
+#define DEFINE_SIMPLE_ATTRIBUTE(__fops, __get, __set, __fmt)		\
+static int __fops ## _open(struct inode *inode, struct file *file)	\
+{									\
+	__simple_attr_check_format(__fmt, 0ul);				\
+	return simple_attr_open(inode, file, &__get, &__set, __fmt);	\
+}									\
+static struct file_operations __fops = {				\
+	.owner	 = THIS_MODULE,						\
+	.open	 = __fops ## _open,					\
+	.release = simple_attr_close,					\
+	.read	 = simple_attr_read,					\
+	.write	 = simple_attr_write,					\
+};
+
+static inline void __attribute__((format(printf, 1, 2)))
+__simple_attr_check_format(const char *fmt, ...)
+{
+	/* don't do anything, just let the compiler check the arguments; */
+}
+
+int simple_attr_open(struct inode *inode, struct file *file,
+		     u64 (*get)(void *), void (*set)(void *, u64),
+		     const char *fmt);
+int simple_attr_close(struct inode *inode, struct file *file);
+ssize_t simple_attr_read(struct file *file, char __user *buf,
+			 size_t len, loff_t *ppos);
+ssize_t simple_attr_write(struct file *file, const char __user *buf,
+			  size_t len, loff_t *ppos);
+
+
 #ifdef CONFIG_SECURITY
 static inline char *alloc_secdata(void)
 {
--- gregkh-2.6.orig/fs/libfs.c	2005-05-18 11:16:39.000000000 -0700
+++ gregkh-2.6/fs/libfs.c	2005-05-18 11:19:09.000000000 -0700
@@ -519,6 +519,101 @@
 	return 0;
 }
 
+/* Simple attribute files */
+
+struct simple_attr {
+	u64 (*get)(void *);
+	void (*set)(void *, u64);
+	char get_buf[24];	/* enough to store a u64 and "\n\0" */
+	char set_buf[24];
+	void *data;
+	const char *fmt;	/* format for read operation */
+	struct semaphore sem;	/* protects access to these buffers */
+};
+
+/* simple_attr_open is called by an actual attribute open file operation
+ * to set the attribute specific access operations. */
+int simple_attr_open(struct inode *inode, struct file *file,
+		     u64 (*get)(void *), void (*set)(void *, u64),
+		     const char *fmt)
+{
+	struct simple_attr *attr;
+
+	attr = kmalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	attr->get = get;
+	attr->set = set;
+	attr->data = inode->u.generic_ip;
+	attr->fmt = fmt;
+	init_MUTEX(&attr->sem);
+
+	file->private_data = attr;
+
+	return nonseekable_open(inode, file);
+}
+
+int simple_attr_close(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
+/* read from the buffer that is filled with the get function */
+ssize_t simple_attr_read(struct file *file, char __user *buf,
+			 size_t len, loff_t *ppos)
+{
+	struct simple_attr *attr;
+	size_t size;
+	ssize_t ret;
+
+	attr = file->private_data;
+
+	if (!attr->get)
+		return -EACCES;
+
+	down(&attr->sem);
+	if (*ppos) /* continued read */
+		size = strlen(attr->get_buf);
+	else	  /* first read */
+		size = scnprintf(attr->get_buf, sizeof(attr->get_buf),
+				 attr->fmt, attr->get(attr->data));
+
+	ret = simple_read_from_buffer(buf, len, ppos, attr->get_buf, size);
+	up(&attr->sem);
+	return ret;
+}
+
+/* interpret the buffer as a number to call the set function with */
+ssize_t simple_attr_write(struct file *file, const char __user *buf,
+			  size_t len, loff_t *ppos)
+{
+	struct simple_attr *attr;
+	u64 val;
+	size_t size;
+	ssize_t ret;
+
+	attr = file->private_data;
+
+	if (!attr->set)
+		return -EACCES;
+
+	down(&attr->sem);
+	ret = -EFAULT;
+	size = min(sizeof(attr->set_buf) - 1, len);
+	if (copy_from_user(attr->set_buf, buf, size))
+		goto out;
+
+	ret = len; /* claim we got the whole input */
+	attr->set_buf[size] = '\0';
+	val = simple_strtol(attr->set_buf, NULL, 0);
+	attr->set(attr->data, val);
+out:
+	up(&attr->sem);
+	return ret;
+}
+
 EXPORT_SYMBOL(dcache_dir_close);
 EXPORT_SYMBOL(dcache_dir_lseek);
 EXPORT_SYMBOL(dcache_dir_open);
@@ -547,3 +642,7 @@
 EXPORT_SYMBOL(simple_transaction_get);
 EXPORT_SYMBOL(simple_transaction_read);
 EXPORT_SYMBOL(simple_transaction_release);
+EXPORT_SYMBOL_GPL(simple_attr_open);
+EXPORT_SYMBOL_GPL(simple_attr_close);
+EXPORT_SYMBOL_GPL(simple_attr_read);
+EXPORT_SYMBOL_GPL(simple_attr_write);
--- gregkh-2.6.orig/fs/debugfs/file.c	2005-05-18 11:16:39.000000000 -0700
+++ gregkh-2.6/fs/debugfs/file.c	2005-05-18 11:18:35.000000000 -0700
@@ -45,44 +45,15 @@
 	.open =		default_open,
 };
 
-#define simple_type(type, format, temptype, strtolfn)				\
-static ssize_t read_file_##type(struct file *file, char __user *user_buf,	\
-				size_t count, loff_t *ppos)			\
-{										\
-	char buf[32];								\
-	type *val = file->private_data;						\
-										\
-	snprintf(buf, sizeof(buf), format "\n", *val);				\
-	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));\
-}										\
-static ssize_t write_file_##type(struct file *file, const char __user *user_buf,\
-				 size_t count, loff_t *ppos)			\
-{										\
-	char *endp;								\
-	char buf[32];								\
-	int buf_size;								\
-	type *val = file->private_data;						\
-	temptype tmp;								\
-										\
-	memset(buf, 0x00, sizeof(buf));						\
-	buf_size = min(count, (sizeof(buf)-1));					\
-	if (copy_from_user(buf, user_buf, buf_size))				\
-		return -EFAULT;							\
-										\
-	tmp = strtolfn(buf, &endp, 0);						\
-	if ((endp == buf) || ((type)tmp != tmp))				\
-		return -EINVAL;							\
-	*val = tmp;								\
-	return count;								\
-}										\
-static struct file_operations fops_##type = {					\
-	.read =		read_file_##type,					\
-	.write =	write_file_##type,					\
-	.open =		default_open,						\
-};
-simple_type(u8, "%c", unsigned long, simple_strtoul);
-simple_type(u16, "%hi", unsigned long, simple_strtoul);
-simple_type(u32, "%i", unsigned long, simple_strtoul);
+static void debugfs_u8_set(void *data, u64 val)
+{
+	*(u8 *)data = val;
+}
+static u64 debugfs_u8_get(void *data)
+{
+	return *(u8 *)data;
+}
+DEFINE_SIMPLE_ATTRIBUTE(fops_u8, debugfs_u8_get, debugfs_u8_set, "%lu\n");
 
 /**
  * debugfs_create_u8 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
@@ -116,6 +87,16 @@
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u8);
 
+static void debugfs_u16_set(void *data, u64 val)
+{
+	*(u16 *)data = val;
+}
+static u64 debugfs_u16_get(void *data)
+{
+	return *(u16 *)data;
+}
+DEFINE_SIMPLE_ATTRIBUTE(fops_u16, debugfs_u16_get, debugfs_u16_set, "%lu\n");
+
 /**
  * debugfs_create_u16 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
  *
@@ -148,6 +129,16 @@
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u16);
 
+static void debugfs_u32_set(void *data, u64 val)
+{
+	*(u32 *)data = val;
+}
+static u64 debugfs_u32_get(void *data)
+{
+	return *(u32 *)data;
+}
+DEFINE_SIMPLE_ATTRIBUTE(fops_u32, debugfs_u32_get, debugfs_u32_set, "%lu\n");
+
 /**
  * debugfs_create_u32 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
  *
