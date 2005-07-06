Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVGFWLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVGFWLA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVGFWKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 18:10:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:60865 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262472AbVGFWJd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 18:09:33 -0400
Date: Wed, 6 Jul 2005 17:08:35 -0500
From: serue@us.ibm.com
To: Greg KH <greg@kroah.com>
Cc: James Morris <jmorris@redhat.com>, Tony Jones <tonyj@suse.de>,
       serge@hallyn.com, serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
Message-ID: <20050706220835.GA32005@serge.austin.ibm.com>
References: <20050703182505.GA29491@immunix.com> <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com> <20050703204423.GA17418@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050703204423.GA17418@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH (greg@kroah.com):
> think it could be made even smaller if you use the default read and
> write file type functions in libfs (look at the debugfs wrappers of them
> for u8, u16, etc, for examples of how to use them.)

The attached patch cleans up the securelevel code for the seclvl file.
Is this a reasonable way to go about this?  Or is there a better way to
do this?  Should these be in libfs instead?  Really I guess it would
only take very minor changes to the _attr code in libfs to forego the
need for these functions in security/inode.c.  It's mainly allowing
signed arguments, and a return value from the __set function.

But if this is ok, then it should be quick to come up with the same kind 
of thing for string arguments, so that all files for both stacker and 
seclvl should be very simple to code.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 include/linux/security.h |   24 ++++++++++
 security/inode.c         |  110 +++++++++++++++++++++++++++++++++++++++++++++++
 security/seclvl.c        |   84 +++--------------------------------
 3 files changed, 143 insertions(+), 75 deletions(-)

Index: linux-2.6.13-rc1/security/inode.c
===================================================================
--- linux-2.6.13-rc1.orig/security/inode.c	2005-07-06 19:05:38.000000000 -0500
+++ linux-2.6.13-rc1/security/inode.c	2005-07-06 19:37:16.000000000 -0500
@@ -330,6 +330,116 @@ static void __exit securityfs_exit(void)
 	subsystem_unregister(&security_subsys);
 }
 
+/* mostly copied from fs/libfs.c:simple_attr */
+struct secfs_int_attr {
+	int (*get)(void *);
+	int (*set)(void *, int);
+	char get_buf[24];	/* enough to store an int and "\n\0" */
+	char set_buf[24];
+	void *data;
+	const char *fmt;	/* format for read operation */
+	struct semaphore sem;	/* protects access to these buffers */
+};
+
+int open_file_int(struct inode *inode, struct file *file,
+		     int (*get)(void *), int (*set)(void *, int),
+		     const char *fmt)
+{
+	struct secfs_int_attr *attr;
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
+int close_file_int(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
+ssize_t read_file_int(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct secfs_int_attr *attr;
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
+	ret = simple_read_from_buffer(user_buf, count, ppos, attr->get_buf, size);
+	up(&attr->sem);
+	return ret;
+}
+
+ssize_t write_file_int(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct secfs_int_attr *attr;
+	int val;
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
+	size = min(sizeof(attr->set_buf) - 1, count);
+	if (copy_from_user(attr->set_buf, user_buf, size))
+		goto out;
+
+	attr->set_buf[size] = '\0';
+	val = simple_strtol(attr->set_buf, NULL, 0);
+	ret = attr->set(attr->data, val);
+	if (ret)
+		goto out;
+	ret = count; /* claim we got the whole input */
+out:
+	up(&attr->sem);
+	return ret;
+}
+
+void secfs_int_set(void *data, int val)
+{
+	*(int *)data = val;
+}
+
+int secfs_int_get(void *data)
+{
+	return *(int *)data;
+}
+
+EXPORT_SYMBOL_GPL(read_file_int);
+EXPORT_SYMBOL_GPL(close_file_int);
+EXPORT_SYMBOL_GPL(open_file_int);
+EXPORT_SYMBOL_GPL(write_file_int);
+EXPORT_SYMBOL_GPL(secfs_int_set);
+EXPORT_SYMBOL_GPL(secfs_int_get);
+
 core_initcall(securityfs_init);
 module_exit(securityfs_exit);
 MODULE_LICENSE("GPL");
Index: linux-2.6.13-rc1/include/linux/security.h
===================================================================
--- linux-2.6.13-rc1.orig/include/linux/security.h	2005-07-06 19:05:38.000000000 -0500
+++ linux-2.6.13-rc1/include/linux/security.h	2005-07-06 19:30:27.000000000 -0500
@@ -1977,6 +1977,30 @@ static inline int security_netlink_recv(
 	return security_ops->netlink_recv(skb);
 }
 
+#define SECFS_DEFINE_INT_FILE(__fops, __get, __set, __fmt)		\
+static int __fops ## _open(struct inode *inode, struct file *file)	\
+{									\
+	return open_file_int(inode, file, __get, __set, __fmt);		\
+}									\
+static struct file_operations __fops = {				\
+	.owner	 = THIS_MODULE,						\
+	.open	 = __fops ## _open,					\
+	.release = close_file_int,					\
+	.read	 = read_file_int,					\
+	.write	 = write_file_int,					\
+};
+
+int open_file_int(struct inode *inode, struct file *file,
+		     int (*get)(void *), int (*set)(void *, int),
+		     const char *fmt);
+int close_file_int(struct inode *inode, struct file *file);
+ssize_t read_file_int(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos);
+ssize_t write_file_int(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos);
+void secfs_int_set(void *data, int val);
+int secfs_int_get(void *data);
+
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
Index: linux-2.6.13-rc1/security/seclvl.c
===================================================================
--- linux-2.6.13-rc1.orig/security/seclvl.c	2005-07-06 19:05:38.000000000 -0500
+++ linux-2.6.13-rc1/security/seclvl.c	2005-07-06 19:33:01.000000000 -0500
@@ -150,33 +150,19 @@ static int seclvl_sanity(int reqlvl)
 }
 
 /**
- * Called whenever the user reads the sysfs handle to this kernel
- * object
- */
-#define TMPBUFLEN 12
-static ssize_t seclvl_read_file(struct file *filp, char __user *buf,
-					size_t count, loff_t *ppos)
-{
-	char tmpbuf[TMPBUFLEN];
-	ssize_t length;
-
-	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", seclvl);
-	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
-}
-
-/**
  * security level advancement rules:
  *   Valid levels are -1 through 2, inclusive.
  *   From -1, stuck.  [ in case compiled into kernel ]
  *   From 0 or above, can only increment.
  */
-static int do_seclvl_advance(int newlvl)
+static int do_seclvl_advance(void *data, int newlvl)
 {
-	if (newlvl <= seclvl) {
-		seclvl_printk(1, KERN_WARNING, "Cannot advance to seclvl "
-			      "[%d]\n", newlvl);
-		return -EINVAL;
-	}
+	int ret;
+	
+	ret = seclvl_sanity(newlvl);
+	if (ret)
+		return ret;
+
 	if (newlvl > 2) {
 		seclvl_printk(1, KERN_WARNING, "Cannot advance to seclvl "
 			      "[%d]\n", newlvl);
@@ -191,59 +177,7 @@ static int do_seclvl_advance(int newlvl)
 	return 0;
 }
 
-/**
- * Called whenever the user writes to the sysfs handle to this kernel
- * object (seclvl/seclvl).  It expects a single-digit number.
- */
-static ssize_t
-seclvl_write_file(struct file * file, const char __user * buf,
-			      size_t count, loff_t *ppos)
-{
-	int val;
-	int err;
-	char *page;
-
-	if (count > 2)
-		return -EINVAL;
-	if (*ppos != 0)
-		return -EINVAL;
-
-	page = (char *) get_zeroed_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	if (copy_from_user(page, buf, count)) {
-		err = -EFAULT;
-		goto out;
-	}
-
-	if (sscanf(page, "%d", &val) != 1) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	if (seclvl_sanity(val)) {
-		seclvl_printk(1, KERN_WARNING, "Illegal secure level "
-			      "requested: [%d]\n", (int)val);
-		err = -EINVAL;
-		goto out;
-	}
-	err = count;
-	if (do_seclvl_advance(val)) {
-		seclvl_printk(0, KERN_ERR, "Failure advancing security level "
-			      "to %d\n", val);
-		err = -EINVAL;
-	}
-
-out:
-	free_page((unsigned long)page);
-	return err;
-}
-
-static struct file_operations seclvl_file_ops = {
-	.read = seclvl_read_file,
-	.write = seclvl_write_file,
-};
+SECFS_DEFINE_INT_FILE(seclvl_file_ops,secfs_int_get,do_seclvl_advance,"%d\n");
 
 static unsigned char hashedPassword[SHA1_DIGEST_SIZE];
 
@@ -621,7 +555,7 @@ static int seclvlfs_register(void)
 		return -EFAULT;
 
 	seclvl_ino = securityfs_create_file("seclvl", S_IRUGO | S_IWUSR,
-				dir_ino, NULL, &seclvl_file_ops);
+				dir_ino, &seclvl, &seclvl_file_ops);
 	if (!seclvl_ino)
 		goto out_deldir;
 	if (*passwd || *sha1_passwd) {
