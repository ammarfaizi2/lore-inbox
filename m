Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUHMQHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUHMQHh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUHMQGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:06:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5797 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266114AbUHMQFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:05:31 -0400
Date: Fri, 13 Aug 2004 12:05:10 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Alexander Viro <aviro@redhat.com>, Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <neilb@cse.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH][LIBFS] Move transaction file ops into libfs
Message-ID: <Xine.LNX.4.44.0408131157350.23262-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves some duplicated transaction-based IO file ops into libfs,
which will also then be useful for future filesystems.  I've tested
SELinux and nfsd, and both seem ok.  Thanks to Al Viro for suggesting the
correct abstraction for transaction_write().

Please review.


 fs/libfs.c                   |  102 +++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsctl.c             |   98 +++++++----------------------------------
 include/linux/fs.h           |   16 ++++++
 security/selinux/selinuxfs.c |   96 ++++++----------------------------------
 4 files changed, 151 insertions(+), 161 deletions(-)

Signed-off-by: James Morris <jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.8-rc4.o/fs/libfs.c linux-2.6.8-rc4.w2/fs/libfs.c
--- linux-2.6.8-rc4.o/fs/libfs.c	2004-08-10 01:20:14.000000000 -0400
+++ linux-2.6.8-rc4.w2/fs/libfs.c	2004-08-13 04:27:07.583622512 -0400
@@ -456,6 +456,104 @@
 	return count;
 }
 
+/*
+ * transaction based IO methods.
+ * The file expects a single write which triggers the transaction, and then
+ * possibly a read which collects the result - which is stored in a
+ * file-local buffer.
+ */
+ssize_t transaction_write(struct file *file, const char __user *buf, size_t size)
+{
+	ssize_t ret = 0;
+	struct transaction_argresp *ar = file->private_data;
+	
+	/* only one write allowed per open */
+	if (ar) {
+		ret = -EINVAL;
+		goto out;
+	}
+	
+	if (size > PAGE_SIZE - sizeof(*ar) - 1) {
+		ret = -EFBIG;
+		goto out;
+	}
+	
+	ar = (struct transaction_argresp *)get_zeroed_page(GFP_KERNEL);
+	if (!ar) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ar->size = 0;
+	
+	down(&file->f_dentry->d_inode->i_sem);
+	if (file->private_data)
+		ret = -EINVAL;
+	else
+		file->private_data = ar;
+	up(&file->f_dentry->d_inode->i_sem);
+	
+	if (ret) {
+		free_page((unsigned long)ar);
+		goto out;
+	}
+	
+	if (copy_from_user(ar->data, buf, size))
+		ret = -EFAULT;
+out:
+	return ret;
+}
+
+ssize_t transaction_read(struct file *file, char __user *buf, size_t size, loff_t *pos)
+{
+	struct transaction_argresp *ar;
+	struct inode *inode = file->f_dentry->d_inode;
+	ssize_t rv = 0;
+	
+	BUG_ON(inode->i_fop->write == NULL);
+
+	if (file->private_data == NULL)
+		rv = inode->i_fop->write(file, buf, 0, pos);
+	if (rv < 0)
+		goto out;
+	else
+		rv = 0;
+
+	ar = file->private_data;
+	if (!ar)
+		goto out;
+
+	if (*pos >= ar->size)
+		goto out;
+
+	if (*pos + size > ar->size)
+		size = ar->size - *pos;
+
+	if (copy_to_user(buf, ar->data + *pos, size)) {
+		rv = -EFAULT;
+		goto out;
+	}
+
+	*pos += size;
+	rv = size;
+out:
+	return rv;
+}
+
+int transaction_open(struct inode *inode, struct file *file)
+{
+	file->private_data = NULL;
+	return 0;
+}
+
+int transaction_release(struct inode *inode, struct file *file)
+{
+	char *page = file->private_data;
+
+	file->private_data = NULL;
+	free_page((unsigned long)page);
+	return 0;
+}
+
 EXPORT_SYMBOL(dcache_dir_close);
 EXPORT_SYMBOL(dcache_dir_lseek);
 EXPORT_SYMBOL(dcache_dir_open);
@@ -479,3 +577,7 @@
 EXPORT_SYMBOL(simple_sync_file);
 EXPORT_SYMBOL(simple_unlink);
 EXPORT_SYMBOL(simple_read_from_buffer);
+EXPORT_SYMBOL(transaction_write);
+EXPORT_SYMBOL(transaction_read);
+EXPORT_SYMBOL(transaction_open);
+EXPORT_SYMBOL(transaction_release);
diff -urN -X dontdiff linux-2.6.8-rc4.o/fs/nfsd/nfsctl.c linux-2.6.8-rc4.w2/fs/nfsd/nfsctl.c
--- linux-2.6.8-rc4.o/fs/nfsd/nfsctl.c	2004-08-10 01:20:14.000000000 -0400
+++ linux-2.6.8-rc4.w2/fs/nfsd/nfsctl.c	2004-08-13 04:34:09.796436408 -0400
@@ -80,101 +80,37 @@
 	[NFSD_Leasetime] = write_leasetime,
 };
 
-/* an argresp is stored in an allocated page and holds the 
- * size of the argument or response, along with its content
- */
-struct argresp {
-	ssize_t size;
-	char data[0];
-};
-
-/*
- * transaction based IO methods.
- * The file expects a single write which triggers the transaction, and then
- * possibly a read which collects the result - which is stored in a 
- * file-local buffer.
- */
-static ssize_t TA_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
+static ssize_t nfsctl_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
 {
 	ino_t ino =  file->f_dentry->d_inode->i_ino;
-	struct argresp *ar;
+	struct transaction_argresp *ar;
 	ssize_t rv = 0;
 
-	if (ino >= sizeof(write_op)/sizeof(write_op[0]) || !write_op[ino])
-		return -EINVAL;
-	if (file->private_data) 
-		return -EINVAL; /* only one write allowed per open */
-	if (size > PAGE_SIZE - sizeof(struct argresp))
-		return -EFBIG;
-
-	ar = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!ar)
-		return -ENOMEM;
-	ar->size = 0;
-	down(&file->f_dentry->d_inode->i_sem);
-	if (file->private_data)
+	if (ino >= sizeof(write_op)/sizeof(write_op[0]) || !write_op[ino]) {
 		rv = -EINVAL;
-	else
-		file->private_data = ar;
-	up(&file->f_dentry->d_inode->i_sem);
-	if (rv) {
-		kfree(ar);
-		return rv;
+		goto out;
 	}
-	if (copy_from_user(ar->data, buf, size))
-		return -EFAULT;
-	
+
+	rv = transaction_write(file, buf, size);
+	if (rv)
+		goto out;
+
+	ar = file->private_data;
+
 	rv =  write_op[ino](file, ar->data, size);
 	if (rv>0) {
 		ar->size = rv;
 		rv = size;
 	}
+out:
 	return rv;
 }
 
-
-static ssize_t TA_read(struct file *file, char __user *buf, size_t size, loff_t *pos)
-{
-	struct argresp *ar;
-	ssize_t rv = 0;
-	
-	if (file->private_data == NULL)
-		rv = TA_write(file, buf, 0, pos);
-	if (rv < 0)
-		return rv;
-
-	ar = file->private_data;
-	if (!ar)
-		return 0;
-	if (*pos >= ar->size)
-		return 0;
-	if (*pos + size > ar->size)
-		size = ar->size - *pos;
-	if (copy_to_user(buf, ar->data + *pos, size))
-		return -EFAULT;
-	*pos += size;
-	return size;
-}
-
-static int TA_open(struct inode *inode, struct file *file)
-{
-	file->private_data = NULL;
-	return 0;
-}
-
-static int TA_release(struct inode *inode, struct file *file)
-{
-	void *p = file->private_data;
-	file->private_data = NULL;
-	kfree(p);
-	return 0;
-}
-
 static struct file_operations transaction_ops = {
-	.write		= TA_write,
-	.read		= TA_read,
-	.open		= TA_open,
-	.release	= TA_release,
+	.write		= nfsctl_transaction_write,
+	.read		= transaction_read,
+	.open		= transaction_open,
+	.release	= transaction_release,
 };
 
 extern struct seq_operations nfs_exports_op;
@@ -366,7 +302,7 @@
 	if (len)
 		return len;
 	
-	mesg = buf; len = PAGE_SIZE-sizeof(struct argresp);
+	mesg = buf; len = PAGE_SIZE-sizeof(struct transaction_argresp);
 	qword_addhex(&mesg, &len, (char*)&fh.fh_base, fh.fh_size);
 	mesg[-1] = '\n';
 	return mesg - buf;	
diff -urN -X dontdiff linux-2.6.8-rc4.o/include/linux/fs.h linux-2.6.8-rc4.w2/include/linux/fs.h
--- linux-2.6.8-rc4.o/include/linux/fs.h	2004-08-10 01:20:15.000000000 -0400
+++ linux-2.6.8-rc4.w2/include/linux/fs.h	2004-08-13 04:25:30.754342800 -0400
@@ -1553,6 +1553,22 @@
 /* kernel/fork.c */
 extern int unshare_files(void);
 
+/* Transaction based IO helpers */
+
+/*
+ * An argresp is stored in an allocated page and holds the 
+ * size of the argument or response, along with its content
+ */
+struct transaction_argresp {
+	ssize_t size;
+	char data[0];
+};
+
+ssize_t transaction_write(struct file *file, const char __user *buf, size_t size);
+ssize_t transaction_read(struct file *file, char __user *buf, size_t size, loff_t *pos);
+int transaction_open(struct inode *inode, struct file *file);
+int transaction_release(struct inode *inode, struct file *file);
+
 #ifdef CONFIG_SECURITY
 static inline char *alloc_secdata(void)
 {
diff -urN -X dontdiff linux-2.6.8-rc4.o/security/selinux/selinuxfs.c linux-2.6.8-rc4.w2/security/selinux/selinuxfs.c
--- linux-2.6.8-rc4.o/security/selinux/selinuxfs.c	2004-06-16 01:20:26.000000000 -0400
+++ linux-2.6.8-rc4.w2/security/selinux/selinuxfs.c	2004-08-13 04:33:10.895390728 -0400
@@ -390,103 +390,39 @@
 	[SEL_USER] = sel_write_user,
 };
 
-/* an argresp is stored in an allocated page and holds the
- * size of the argument or response, along with its content
- */
-struct argresp {
-	ssize_t size;
-	char data[0];
-};
+#define PAYLOAD_SIZE (PAGE_SIZE - sizeof(struct transaction_argresp))
 
-#define PAYLOAD_SIZE (PAGE_SIZE - sizeof(struct argresp))
-
-/*
- * transaction based IO methods.
- * The file expects a single write which triggers the transaction, and then
- * possibly a read which collects the result - which is stored in a
- * file-local buffer.
- */
-static ssize_t TA_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
+static ssize_t selinux_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
 {
 	ino_t ino =  file->f_dentry->d_inode->i_ino;
-	struct argresp *ar;
+	struct transaction_argresp *ar;
 	ssize_t rv = 0;
 
-	if (ino >= sizeof(write_op)/sizeof(write_op[0]) || !write_op[ino])
-		return -EINVAL;
-	if (file->private_data)
-		return -EINVAL; /* only one write allowed per open */
-	if (size > PAYLOAD_SIZE - 1) /* allow one byte for null terminator */
-		return -EFBIG;
-
-	ar = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!ar)
-		return -ENOMEM;
-	memset(ar, 0, PAGE_SIZE); /* clear buffer, particularly last byte */
-	ar->size = 0;
-	down(&file->f_dentry->d_inode->i_sem);
-	if (file->private_data)
+	if (ino >= sizeof(write_op)/sizeof(write_op[0]) || !write_op[ino]) {
 		rv = -EINVAL;
-	else
-		file->private_data = ar;
-	up(&file->f_dentry->d_inode->i_sem);
-	if (rv) {
-		kfree(ar);
-		return rv;
+		goto out;
 	}
-	if (copy_from_user(ar->data, buf, size))
-		return -EFAULT;
+
+	rv = transaction_write(file, buf, size);
+	if (rv)
+		goto out;
+
+	ar = file->private_data;
 
 	rv =  write_op[ino](file, ar->data, size);
 	if (rv>0) {
 		ar->size = rv;
 		rv = size;
 	}
+out:
 	return rv;
 }
 
-static ssize_t TA_read(struct file *file, char __user *buf, size_t size, loff_t *pos)
-{
-	struct argresp *ar;
-	ssize_t rv = 0;
-
-	if (file->private_data == NULL)
-		rv = TA_write(file, buf, 0, pos);
-	if (rv < 0)
-		return rv;
-
-	ar = file->private_data;
-	if (!ar)
-		return 0;
-	if (*pos >= ar->size)
-		return 0;
-	if (*pos + size > ar->size)
-		size = ar->size - *pos;
-	if (copy_to_user(buf, ar->data + *pos, size))
-		return -EFAULT;
-	*pos += size;
-	return size;
-}
-
-static int TA_open(struct inode *inode, struct file *file)
-{
-	file->private_data = NULL;
-	return 0;
-}
-
-static int TA_release(struct inode *inode, struct file *file)
-{
-	void *p = file->private_data;
-	file->private_data = NULL;
-	kfree(p);
-	return 0;
-}
-
 static struct file_operations transaction_ops = {
-	.write		= TA_write,
-	.read		= TA_read,
-	.open		= TA_open,
-	.release	= TA_release,
+	.write		= selinux_transaction_write,
+	.read		= transaction_read,
+	.open		= transaction_open,
+	.release	= transaction_release,
 };
 
 /*



