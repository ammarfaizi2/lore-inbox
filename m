Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVERM6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVERM6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 08:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVERM6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 08:58:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:8425 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261514AbVERM5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 08:57:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg KH <greg@kroah.com>
Subject: [PATCH] libfs: add simple attribute files
Date: Wed, 18 May 2005 14:40:59 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <200505132117.37461.arnd@arndb.de> <200505132129.07603.arnd@arndb.de> <20050514074524.GC20021@kroah.com>
In-Reply-To: <20050514074524.GC20021@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505181441.01495.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

---
 fs/debugfs/file.c  |   74 +++++++++++++++++++----------------------
 fs/libfs.c         |   94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |   48 +++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 39 deletions(-)

fs/libfs.c: needs update
Index: linus-2.5/include/linux/fs.h
===================================================================
--- linus-2.5.orig/include/linux/fs.h	2005-05-18 10:58:52.000000000 +0200
+++ linus-2.5/include/linux/fs.h	2005-05-18 14:07:10.000000000 +0200
@@ -1657,6 +1657,55 @@
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
+ * All spufs attributes contain a text representation of a numeric value
+ * that are accessed with the get() and set() functions.
+ *
+ * Perhaps these file operations could be put in debugfs or libfs instead,
+ * they are not really SPU specific.
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
+		long (*get)(void *), void (*set)(void *, long),
+		const char *fmt);
+int simple_attr_close(struct inode *inode, struct file *file);
+ssize_t simple_attr_read(struct file *file, char __user *buf,
+					size_t len, loff_t *ppos);
+ssize_t simple_attr_write(struct file *file, const char __user *buf,
+					size_t len, loff_t *ppos);
+
+
 #ifdef CONFIG_SECURITY
 static inline char *alloc_secdata(void)
 {
Index: linus-2.5/fs/libfs.c
===================================================================
--- linus-2.5.orig/fs/libfs.c	2005-05-18 10:58:52.000000000 +0200
+++ linus-2.5/fs/libfs.c	2005-05-18 12:06:49.000000000 +0200
@@ -519,6 +519,100 @@
 	return 0;
 }
 
+/* Simple attribute files */
+
+struct simple_attr {
+	long (*get)(void *);
+	void (*set)(void *, long);
+	char get_buf[24]; /* enough to store a long and "\n\0" */
+	char set_buf[24];
+	void *data;
+	const char *fmt; /* format for read operation */
+	struct semaphore sem; /* protects access to these buffers */
+};
+
+/* simple_attr_open is called by an actual attribute open file operation
+ * to set the attribute specific access operations. */
+int simple_attr_open(struct inode *inode, struct file *file,
+		long (*get)(void *), void (*set)(void *, long),
+		const char *fmt)
+{
+	struct simple_attr *attr;
+
+	attr = kmalloc(sizeof *attr, GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	/* reading/writing needs the respective get/set operation */
+	if (((file->f_mode & FMODE_READ)  && !get) ||
+	    ((file->f_mode & FMODE_WRITE) && !set))
+		return -EACCES;
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
+					size_t len, loff_t *ppos)
+{
+	struct simple_attr *attr;
+	size_t size;
+	ssize_t ret;
+
+	attr = file->private_data;
+
+	down(&attr->sem);
+	if (*ppos) /* continued read */
+		size = strlen(attr->get_buf);
+	else	  /* first read */
+		size = scnprintf(attr->get_buf, sizeof (attr->get_buf),
+				 attr->fmt, attr->get(attr->data));
+
+	ret = simple_read_from_buffer(buf, len, ppos, attr->get_buf, size);
+	up(&attr->sem);
+	return ret;
+}
+
+/* interpret the buffer as a number to call the set function with */
+ssize_t simple_attr_write(struct file *file, const char __user *buf,
+					size_t len, loff_t *ppos)
+{
+	struct simple_attr *attr;
+	long val;
+	size_t size;
+	ssize_t ret;
+
+	attr = file->private_data;
+
+	down(&attr->sem);
+	ret = -EFAULT;
+	size = min(sizeof (attr->set_buf) - 1, len);
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
Index: linus-2.5/fs/debugfs/file.c
===================================================================
--- linus-2.5.orig/fs/debugfs/file.c	2005-05-18 10:58:52.000000000 +0200
+++ linus-2.5/fs/debugfs/file.c	2005-05-18 12:22:16.000000000 +0200
@@ -45,45 +45,6 @@
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
-
 /**
  * debugfs_create_u8 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
  *
@@ -109,6 +70,18 @@
  * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
  * code.
  */
+static void debugfs_u8_set(void *data, long val)
+{
+	*(u8 *)data = val;
+}
+
+static long debugfs_u8_get(void *data)
+{
+	return *(u8 *)data;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_u8, debugfs_u8_get, debugfs_u8_set, "%lu\n");
+
 struct dentry *debugfs_create_u8(const char *name, mode_t mode,
 				 struct dentry *parent, u8 *value)
 {
@@ -141,6 +114,17 @@
  * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
  * code.
  */
+static void debugfs_u16_set(void *data, long val)
+{
+	*(u16 *)data = val;
+}
+
+static long debugfs_u16_get(void *data)
+{
+	return *(u16 *)data;
+}
+DEFINE_SIMPLE_ATTRIBUTE(fops_u16, debugfs_u16_get, debugfs_u16_set, "%lu\n");
+
 struct dentry *debugfs_create_u16(const char *name, mode_t mode,
 				  struct dentry *parent, u16 *value)
 {
@@ -173,6 +157,18 @@
  * NULL or !NULL instead as to eliminate the need for #ifdef in the calling
  * code.
  */
+static void debugfs_u32_set(void *data, long val)
+{
+	*(u32 *)data = val;
+}
+
+static long debugfs_u32_get(void *data)
+{
+	return *(u32 *)data;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_u32, debugfs_u32_get, debugfs_u32_set, "%lu\n");
+
 struct dentry *debugfs_create_u32(const char *name, mode_t mode,
 				 struct dentry *parent, u32 *value)
 {
