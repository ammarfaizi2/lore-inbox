Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265263AbUHNUBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUHNUBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 16:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbUHNT70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:59:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:29866 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265134AbUHNTzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:55:07 -0400
Date: Sat, 14 Aug 2004 12:55:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       neilb@cse.unsw.edu.au, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][LIBFS] Move transaction file ops into libfs + cleanup (update)
Message-ID: <20040814125501.U1973@build.pdx.osdl.net>
References: <Xine.LNX.4.44.0408131157350.23262-100000@dhcp83-76.boston.redhat.com> <Xine.LNX.4.44.0408141231300.27007-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0408141231300.27007-100000@dhcp83-76.boston.redhat.com>; from jmorris@redhat.com on Sat, Aug 14, 2004 at 12:44:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

* James Morris (jmorris@redhat.com) wrote:
> Below is an updated version of the patch, which moves duplicated
> transaction-based file operation code into libfs.  Since the last post,
> the patch has been through a couple of iterations with Al, who suggested a
> number of cleanups including locking and interface simplification.

Looks nice. I didn't realize you were working on this consolidation too.
I cooked up a similar patch.  In this case the user loads its inode
specific write_ops on open, then just uses the generic helpers.  I also
fully serialized all write/read transactions per inode.  It's lightly
tested.  If there's anything you like in there, feel free to use it.

thanks,
-chris

===== include/linux/fs.h 1.344 vs edited =====
--- 1.344/include/linux/fs.h	2004-08-09 12:05:17 -07:00
+++ edited/include/linux/fs.h	2004-08-14 11:25:29 -07:00
@@ -1107,6 +1107,15 @@
 	struct list_head fs_supers;
 };
 
+/* Transaction file */
+typedef ssize_t (*write_op_t) (struct file *, char *, size_t);
+struct TA_file {
+	size_t ops_size;
+	write_op_t *write_ops;
+	size_t ta_size;
+	char *ta_data;
+};
+
 struct super_block *get_sb_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int));
@@ -1531,6 +1540,11 @@
 extern void simple_release_fs(struct vfsmount **mount, int *count);
 
 extern ssize_t simple_read_from_buffer(void __user *, size_t, loff_t *, const void *, size_t);
+
+extern int TA_open(struct file *, write_op_t *, size_t);
+extern ssize_t TA_write(struct file *, const char __user *, size_t, loff_t *);
+extern ssize_t TA_read(struct file *, char __user *, size_t, loff_t *);
+extern int TA_release(struct inode *, struct file *);
 
 extern int inode_change_ok(struct inode *, struct iattr *);
 extern int __must_check inode_setattr(struct inode *, struct iattr *);
===== fs/libfs.c 1.33 vs edited =====
--- 1.33/fs/libfs.c	2004-08-05 23:10:54 -07:00
+++ edited/fs/libfs.c	2004-08-14 12:07:53 -07:00
@@ -456,6 +456,93 @@
 	return count;
 }
 
+int TA_open(struct file *file, write_op_t *ops, size_t ops_size)
+{
+	struct TA_file *ta;
+	ta = kmalloc(sizeof(*ta), GFP_KERNEL);
+	if (ta) {
+		ta->ops_size = ops_size;
+		ta->write_ops = ops;
+		ta->ta_size = 0;
+		ta->ta_data = NULL;
+		file->private_data = ta;
+		return 0;
+	}
+	return -ENOMEM;
+}
+
+/*
+ * transaction based IO methods.
+ * The file expects a single write which triggers the transaction, and then
+ * possibly a read which collects the result - which is stored in a 
+ * file-local buffer.
+ */
+ssize_t TA_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
+{
+	ino_t ino =  file->f_dentry->d_inode->i_ino;
+	struct TA_file *ta = file->private_data;
+	ssize_t rv = 0;
+	char *data;
+
+	if (ino >= ta->ops_size || !ta->write_ops[ino])
+		return -EINVAL;
+	if (size > PAGE_SIZE)
+		return -EFBIG;
+
+	data = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	down(&file->f_dentry->d_inode->i_sem);
+	if (!ta->ta_data)
+		ta->ta_data = data;
+	else
+		rv = -EINVAL;
+	if (rv) {
+		free_page((unsigned long)data);
+		goto out;
+	}
+	rv = -EFAULT;
+	if (copy_from_user(ta->ta_data, buf, size))
+		goto out;
+	
+	rv =  ta->write_ops[ino](file, ta->ta_data, size);
+	if (rv>0) {
+		ta->ta_size = rv;
+		rv = size;
+	}
+out:
+	up(&file->f_dentry->d_inode->i_sem);
+	return rv;
+}
+
+
+ssize_t TA_read(struct file *file, char __user *buf, size_t size, loff_t *pos)
+{
+	struct TA_file *ta;
+	ssize_t rv = 0;
+	
+	down(&file->f_dentry->d_inode->i_sem);
+	ta = file->private_data;
+	if (ta)
+		rv = simple_read_from_buffer(buf, size, pos, ta->ta_data,
+					     ta->ta_size);
+	up(&file->f_dentry->d_inode->i_sem);
+	return rv;
+}
+
+int TA_release(struct inode *inode, struct file *file)
+{
+	struct TA_file *ta;
+	char *data = NULL;
+	ta = file->private_data;
+	file->private_data = NULL;
+	if (ta)
+		data = ta->ta_data;
+	kfree(ta);
+	free_page((unsigned long)data);
+	return 0;
+}
+
 EXPORT_SYMBOL(dcache_dir_close);
 EXPORT_SYMBOL(dcache_dir_lseek);
 EXPORT_SYMBOL(dcache_dir_open);
@@ -479,3 +566,7 @@
 EXPORT_SYMBOL(simple_sync_file);
 EXPORT_SYMBOL(simple_unlink);
 EXPORT_SYMBOL(simple_read_from_buffer);
+EXPORT_SYMBOL(TA_open);
+EXPORT_SYMBOL(TA_write);
+EXPORT_SYMBOL(TA_read);
+EXPORT_SYMBOL(TA_release);
===== fs/nfsd/nfsctl.c 1.43 vs edited =====
--- 1.43/fs/nfsd/nfsctl.c	2004-06-30 08:29:47 -07:00
+++ edited/fs/nfsd/nfsctl.c	2004-08-14 11:25:31 -07:00
@@ -80,100 +80,15 @@
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
-{
-	ino_t ino =  file->f_dentry->d_inode->i_ino;
-	struct argresp *ar;
-	ssize_t rv = 0;
-
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
-	if (rv>0) {
-		ar->size = rv;
-		rv = size;
-	}
-	return rv;
-}
-
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
+static int nfsd_TA_open(struct inode *inode, struct file *file)
 {
-	void *p = file->private_data;
-	file->private_data = NULL;
-	kfree(p);
-	return 0;
+	return TA_open(file, write_op, sizeof(write_op)/sizeof(write_op[0]));
 }
 
 static struct file_operations transaction_ops = {
 	.write		= TA_write,
 	.read		= TA_read,
-	.open		= TA_open,
+	.open		= nfsd_TA_open,
 	.release	= TA_release,
 };
 
@@ -366,7 +281,7 @@
 	if (len)
 		return len;
 	
-	mesg = buf; len = PAGE_SIZE-sizeof(struct argresp);
+	mesg = buf; len = PAGE_SIZE;
 	qword_addhex(&mesg, &len, (char*)&fh.fh_base, fh.fh_size);
 	mesg[-1] = '\n';
 	return mesg - buf;	
===== security/selinux/selinuxfs.c 1.12 vs edited =====
--- 1.12/security/selinux/selinuxfs.c	2004-06-03 18:47:11 -07:00
+++ edited/security/selinux/selinuxfs.c	2004-08-14 11:25:30 -07:00
@@ -390,102 +390,15 @@
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
-{
-	ino_t ino =  file->f_dentry->d_inode->i_ino;
-	struct argresp *ar;
-	ssize_t rv = 0;
-
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
-	if (rv>0) {
-		ar->size = rv;
-		rv = size;
-	}
-	return rv;
-}
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
+static int sel_TA_open(struct inode *inode, struct file *file)
 {
-	void *p = file->private_data;
-	file->private_data = NULL;
-	kfree(p);
-	return 0;
+	return TA_open(file, write_op, sizeof(write_op)/sizeof(write_op[0]));
 }
 
 static struct file_operations transaction_ops = {
 	.write		= TA_write,
 	.read		= TA_read,
-	.open		= TA_open,
+	.open		= sel_TA_open,
 	.release	= TA_release,
 };
 
@@ -534,7 +447,7 @@
 	if (length < 0)
 		goto out2;
 
-	length = scnprintf(buf, PAYLOAD_SIZE, "%x %x %x %x %u",
+	length = scnprintf(buf, PAGE_SIZE, "%x %x %x %x %u",
 			  avd.allowed, avd.decided,
 			  avd.auditallow, avd.auditdeny,
 			  avd.seqno);
@@ -588,7 +501,7 @@
 	if (length < 0)
 		goto out2;
 
-	if (len > PAYLOAD_SIZE) {
+	if (len > PAGE_SIZE) {
 		printk(KERN_ERR "%s:  context size (%u) exceeds payload "
 		       "max\n", __FUNCTION__, len);
 		length = -ERANGE;
@@ -649,7 +562,7 @@
 	if (length < 0)
 		goto out2;
 
-	if (len > PAYLOAD_SIZE) {
+	if (len > PAGE_SIZE) {
 		length = -ERANGE;
 		goto out3;
 	}
@@ -709,7 +622,7 @@
 			length = rc;
 			goto out3;
 		}
-		if ((length + len) >= PAYLOAD_SIZE) {
+		if ((length + len) >= PAGE_SIZE) {
 			kfree(newcon);
 			length = -ERANGE;
 			goto out3;
