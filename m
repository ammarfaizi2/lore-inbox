Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUHNQqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUHNQqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 12:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUHNQqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 12:46:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7090 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263980AbUHNQpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 12:45:05 -0400
Date: Sat, 14 Aug 2004 12:44:41 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <neilb@cse.unsw.edu.au>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH][LIBFS] Move transaction file ops into libfs + cleanup (update)
In-Reply-To: <Xine.LNX.4.44.0408131157350.23262-100000@dhcp83-76.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0408141231300.27007-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is an updated version of the patch, which moves duplicated
transaction-based file operation code into libfs.  Since the last post,
the patch has been through a couple of iterations with Al, who suggested a
number of cleanups including locking and interface simplification.

For filesystem writers, the interface is now much simpler.  The
simple_transaction_get() helper should be part of the file op write
method.  This safely obtains the transaction request data during write(),
allocates a page for it and stores it there.  The data is returned to the
caller for potential further processing, which then makes it available for
the next read() call via simple_transaction_set().  See the selinuxfs and
nfsctl code for examples of use.

Please review and apply.

Signed-off-by: James Morris <jmorris@redhat.com>

 fs/libfs.c                   |   55 ++++++++++++++++++++++
 fs/nfsd/nfsctl.c             |   96 +++++-----------------------------------
 include/linux/fs.h           |   26 ++++++++++
 security/selinux/selinuxfs.c |  103 ++++++-------------------------------------
 4 files changed, 110 insertions(+), 170 deletions(-)


diff -urN -X dontdiff linux-2.6.8.1.o/fs/libfs.c linux-2.6.8.1.w/fs/libfs.c
--- linux-2.6.8.1.o/fs/libfs.c	2004-08-14 10:25:42.000000000 -0400
+++ linux-2.6.8.1.w/fs/libfs.c	2004-08-14 12:57:55.654875688 -0400
@@ -456,6 +456,58 @@
 	return count;
 }
 
+/*
+ * Transaction based IO.
+ * The file expects a single write which triggers the transaction, and then
+ * possibly a read which collects the result - which is stored in a
+ * file-local buffer.
+ */
+char *simple_transaction_get(struct file *file, const char __user *buf, size_t size)
+{
+	struct simple_transaction_argresp *ar;
+	static spinlock_t simple_transaction_lock = SPIN_LOCK_UNLOCKED;
+
+	if (size > SIMPLE_TRANSACTION_LIMIT - 1)
+		return ERR_PTR(-EFBIG);
+
+	ar = (struct simple_transaction_argresp *)get_zeroed_page(GFP_KERNEL);
+	if (!ar)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock(&simple_transaction_lock);
+	
+	/* only one write allowed per open */
+	if (file->private_data) {
+		spin_unlock(&simple_transaction_lock);
+		free_page((unsigned long)ar);
+		return ERR_PTR(-EBUSY);
+	}
+
+	file->private_data = ar;
+	
+	spin_unlock(&simple_transaction_lock);
+	
+	if (copy_from_user(ar->data, buf, size))
+		return ERR_PTR(-EFAULT);
+
+	return ar->data;
+}
+
+ssize_t simple_transaction_read(struct file *file, char __user *buf, size_t size, loff_t *pos)
+{
+	struct simple_transaction_argresp *ar = file->private_data;
+	
+	if (!ar)
+		return 0;
+	return simple_read_from_buffer(buf, size, pos, ar->data, ar->size);
+}
+
+int simple_transaction_release(struct inode *inode, struct file *file)
+{
+	free_page((unsigned long)file->private_data);
+	return 0;
+}
+
 EXPORT_SYMBOL(dcache_dir_close);
 EXPORT_SYMBOL(dcache_dir_lseek);
 EXPORT_SYMBOL(dcache_dir_open);
@@ -479,3 +531,6 @@
 EXPORT_SYMBOL(simple_sync_file);
 EXPORT_SYMBOL(simple_unlink);
 EXPORT_SYMBOL(simple_read_from_buffer);
+EXPORT_SYMBOL(simple_transaction_get);
+EXPORT_SYMBOL(simple_transaction_read);
+EXPORT_SYMBOL(simple_transaction_release);
diff -urN -X dontdiff linux-2.6.8.1.o/fs/nfsd/nfsctl.c linux-2.6.8.1.w/fs/nfsd/nfsctl.c
--- linux-2.6.8.1.o/fs/nfsd/nfsctl.c	2004-08-14 10:25:42.000000000 -0400
+++ linux-2.6.8.1.w/fs/nfsd/nfsctl.c	2004-08-14 12:58:33.246160944 -0400
@@ -80,101 +80,31 @@
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
-	ssize_t rv = 0;
+	char *data;
+	ssize_t rv;
 
 	if (ino >= sizeof(write_op)/sizeof(write_op[0]) || !write_op[ino])
 		return -EINVAL;
-	if (file->private_data) 
-		return -EINVAL; /* only one write allowed per open */
-	if (size > PAGE_SIZE - sizeof(struct argresp))
-		return -EFBIG;
 
-	ar = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!ar)
-		return -ENOMEM;
-	ar->size = 0;
-	down(&file->f_dentry->d_inode->i_sem);
-	if (file->private_data)
-		rv = -EINVAL;
-	else
-		file->private_data = ar;
-	up(&file->f_dentry->d_inode->i_sem);
-	if (rv) {
-		kfree(ar);
-		return rv;
-	}
-	if (copy_from_user(ar->data, buf, size))
-		return -EFAULT;
-	
-	rv =  write_op[ino](file, ar->data, size);
+	data = simple_transaction_get(file, buf, size);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	rv =  write_op[ino](file, data, size);
 	if (rv>0) {
-		ar->size = rv;
+		simple_transaction_set(file, rv);
 		rv = size;
 	}
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
+	.read		= simple_transaction_read,
+	.release	= simple_transaction_release,
 };
 
 extern struct seq_operations nfs_exports_op;
@@ -366,7 +296,7 @@
 	if (len)
 		return len;
 	
-	mesg = buf; len = PAGE_SIZE-sizeof(struct argresp);
+	mesg = buf; len = SIMPLE_TRANSACTION_LIMIT;
 	qword_addhex(&mesg, &len, (char*)&fh.fh_base, fh.fh_size);
 	mesg[-1] = '\n';
 	return mesg - buf;	
diff -urN -X dontdiff linux-2.6.8.1.o/include/linux/fs.h linux-2.6.8.1.w/include/linux/fs.h
--- linux-2.6.8.1.o/include/linux/fs.h	2004-08-14 10:25:44.000000000 -0400
+++ linux-2.6.8.1.w/include/linux/fs.h	2004-08-14 12:57:56.175796496 -0400
@@ -1550,6 +1550,32 @@
 /* kernel/fork.c */
 extern int unshare_files(void);
 
+/* Transaction based IO helpers */
+
+/*
+ * An argresp is stored in an allocated page and holds the 
+ * size of the argument or response, along with its content
+ */
+struct simple_transaction_argresp {
+	ssize_t size;
+	char data[0];
+};
+
+#define SIMPLE_TRANSACTION_LIMIT (PAGE_SIZE - sizeof(struct simple_transaction_argresp))
+
+char *simple_transaction_get(struct file *file, const char __user *buf, size_t size);
+ssize_t simple_transaction_read(struct file *file, char __user *buf, size_t size, loff_t *pos);
+int simple_transaction_release(struct inode *inode, struct file *file);
+
+static inline void simple_transaction_set(struct file *file, size_t n)
+{
+	struct simple_transaction_argresp *ar = file->private_data;
+	
+	BUG_ON(n > SIMPLE_TRANSACTION_LIMIT);
+	mb();
+	ar->size = n;
+}
+
 #ifdef CONFIG_SECURITY
 static inline char *alloc_secdata(void)
 {
diff -urN -X dontdiff linux-2.6.8.1.o/security/selinux/selinuxfs.c linux-2.6.8.1.w/security/selinux/selinuxfs.c
--- linux-2.6.8.1.o/security/selinux/selinuxfs.c	2004-06-16 01:20:26.000000000 -0400
+++ linux-2.6.8.1.w/security/selinux/selinuxfs.c	2004-08-14 12:58:44.667424648 -0400
@@ -390,103 +390,31 @@
 	[SEL_USER] = sel_write_user,
 };
 
-/* an argresp is stored in an allocated page and holds the
- * size of the argument or response, along with its content
- */
-struct argresp {
-	ssize_t size;
-	char data[0];
-};
-
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
-	ssize_t rv = 0;
+	char *data;
+	ssize_t rv;
 
 	if (ino >= sizeof(write_op)/sizeof(write_op[0]) || !write_op[ino])
 		return -EINVAL;
-	if (file->private_data)
-		return -EINVAL; /* only one write allowed per open */
-	if (size > PAYLOAD_SIZE - 1) /* allow one byte for null terminator */
-		return -EFBIG;
 
-	ar = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!ar)
-		return -ENOMEM;
-	memset(ar, 0, PAGE_SIZE); /* clear buffer, particularly last byte */
-	ar->size = 0;
-	down(&file->f_dentry->d_inode->i_sem);
-	if (file->private_data)
-		rv = -EINVAL;
-	else
-		file->private_data = ar;
-	up(&file->f_dentry->d_inode->i_sem);
-	if (rv) {
-		kfree(ar);
-		return rv;
-	}
-	if (copy_from_user(ar->data, buf, size))
-		return -EFAULT;
+	data = simple_transaction_get(file, buf, size);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 
-	rv =  write_op[ino](file, ar->data, size);
+	rv =  write_op[ino](file, data, size);
 	if (rv>0) {
-		ar->size = rv;
+		simple_transaction_set(file, rv);
 		rv = size;
 	}
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
+	.read		= simple_transaction_read,
+	.release	= simple_transaction_release,
 };
 
 /*
@@ -534,7 +462,8 @@
 	if (length < 0)
 		goto out2;
 
-	length = scnprintf(buf, PAYLOAD_SIZE, "%x %x %x %x %u",
+	length = scnprintf(buf, SIMPLE_TRANSACTION_LIMIT,
+			  "%x %x %x %x %u",
 			  avd.allowed, avd.decided,
 			  avd.auditallow, avd.auditdeny,
 			  avd.seqno);
@@ -588,7 +517,7 @@
 	if (length < 0)
 		goto out2;
 
-	if (len > PAYLOAD_SIZE) {
+	if (len > SIMPLE_TRANSACTION_LIMIT) {
 		printk(KERN_ERR "%s:  context size (%u) exceeds payload "
 		       "max\n", __FUNCTION__, len);
 		length = -ERANGE;
@@ -649,7 +578,7 @@
 	if (length < 0)
 		goto out2;
 
-	if (len > PAYLOAD_SIZE) {
+	if (len > SIMPLE_TRANSACTION_LIMIT) {
 		length = -ERANGE;
 		goto out3;
 	}
@@ -709,7 +638,7 @@
 			length = rc;
 			goto out3;
 		}
-		if ((length + len) >= PAYLOAD_SIZE) {
+		if ((length + len) >= SIMPLE_TRANSACTION_LIMIT) {
 			kfree(newcon);
 			length = -ERANGE;
 			goto out3;


