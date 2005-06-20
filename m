Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVFUD4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVFUD4u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVFUCws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:52:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:15332 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261673AbVFTW7k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:40 -0400
Cc: arnd@arndb.de
Subject: [PATCH] libfs: add simple attribute files
In-Reply-To: <1119308367477@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:27 -0700
Message-Id: <1119308367186@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] libfs: add simple attribute files

Based on the discussion about spufs attributes, this is my suggestion
for a more generic attribute file support that can be used by both
debugfs and spufs.

Simple attribute files behave similarly to sequential files from
a kernel programmers perspective in that a standard set of file
operations is provided and only an open operation needs to
be written that registers file specific get() and set() functions.

These operations are defined as

void foo_set(void *data, u64 val); and
u64 foo_get(void *data);

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
commit acaefc25d21f850e47ecc5098d1e0bc442c526be
tree fbc7aa605c71667507b54d3b3320f9a999458dd4
parent 4109aca06cb7b042ea791d0f9d3c9615bc3bf5cd
author Arnd Bergmann <arnd@arndb.de> Wed, 18 May 2005 14:40:59 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:30 -0700

 fs/debugfs/file.c  |   67 +++++++++++++++--------------------
 fs/libfs.c         |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |   46 ++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 38 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -45,44 +45,15 @@ struct file_operations debugfs_file_oper
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
+DEFINE_SIMPLE_ATTRIBUTE(fops_u8, debugfs_u8_get, debugfs_u8_set, "%llu\n");
 
 /**
  * debugfs_create_u8 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
@@ -116,6 +87,16 @@ struct dentry *debugfs_create_u8(const c
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
+DEFINE_SIMPLE_ATTRIBUTE(fops_u16, debugfs_u16_get, debugfs_u16_set, "%llu\n");
+
 /**
  * debugfs_create_u16 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
  *
@@ -148,6 +129,16 @@ struct dentry *debugfs_create_u16(const 
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
+DEFINE_SIMPLE_ATTRIBUTE(fops_u32, debugfs_u32_get, debugfs_u32_set, "%llu\n");
+
 /**
  * debugfs_create_u32 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
  *
diff --git a/fs/libfs.c b/fs/libfs.c
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -519,6 +519,102 @@ int simple_transaction_release(struct in
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
+				 attr->fmt,
+				 (unsigned long long)attr->get(attr->data));
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
@@ -547,3 +643,7 @@ EXPORT_SYMBOL(simple_read_from_buffer);
 EXPORT_SYMBOL(simple_transaction_get);
 EXPORT_SYMBOL(simple_transaction_read);
 EXPORT_SYMBOL(simple_transaction_release);
+EXPORT_SYMBOL_GPL(simple_attr_open);
+EXPORT_SYMBOL_GPL(simple_attr_close);
+EXPORT_SYMBOL_GPL(simple_attr_read);
+EXPORT_SYMBOL_GPL(simple_attr_write);
diff --git a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1657,6 +1657,52 @@ static inline void simple_transaction_se
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
+	__simple_attr_check_format(__fmt, 0ull);			\
+	return simple_attr_open(inode, file, __get, __set, __fmt);	\
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

