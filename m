Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUHNXQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUHNXQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 19:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266339AbUHNXQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 19:16:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:30927 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266295AbUHNXPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 19:15:44 -0400
Date: Sat, 14 Aug 2004 16:15:21 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@redhat.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] use simple_read_from_buffer in selinuxfs
Message-ID: <20040814161521.C1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use simple_read_from_buffer.  This also eliminates page allocation
for the sprintf buffer.  Switch to get_zeroed_page instead of
open-coding it.  Viro had ack'd this earlier.  Still applies w/
the transaction update.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== security/selinux/selinuxfs.c 1.12 vs edited =====
--- 1.12/security/selinux/selinuxfs.c	2004-06-03 18:47:11 -07:00
+++ edited/security/selinux/selinuxfs.c	2004-08-06 17:44:52 -07:00
@@ -68,40 +68,15 @@
 	SEL_DISABLE	/* disable SELinux until next reboot */
 };
 
+#define TMPBUFLEN	12
 static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	char *page;
+	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
-	ssize_t end;
-
-	if (count < 0 || count > PAGE_SIZE)
-		return -EINVAL;
-	if (!(page = (char*)__get_free_page(GFP_KERNEL)))
-		return -ENOMEM;
-	memset(page, 0, PAGE_SIZE);
-
-	length = scnprintf(page, PAGE_SIZE, "%d", selinux_enforcing);
-	if (length < 0) {
-		free_page((unsigned long)page);
-		return length;
-	}
 
-	if (*ppos >= length) {
-		free_page((unsigned long)page);
-		return 0;
-	}
-	if (count + *ppos > length)
-		count = length - *ppos;
-	end = count + *ppos;
-	if (copy_to_user(buf, (char *) page + *ppos, count)) {
-		count = -EFAULT;
-		goto out;
-	}
-	*ppos = end;
-out:
-	free_page((unsigned long)page);
-	return count;
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", selinux_enforcing);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
@@ -119,10 +94,9 @@
 		/* No partial writes. */
 		return -EINVAL;
 	}
-	page = (char*)__get_free_page(GFP_KERNEL);
+	page = (char*)get_zeroed_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
-	memset(page, 0, PAGE_SIZE);
 	length = -EFAULT;
 	if (copy_from_user(page, buf, count))
 		goto out;
@@ -170,10 +144,9 @@
 		/* No partial writes. */
 		return -EINVAL;
 	}
-	page = (char*)__get_free_page(GFP_KERNEL);
+	page = (char*)get_zeroed_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
-	memset(page, 0, PAGE_SIZE);
 	length = -EFAULT;
 	if (copy_from_user(page, buf, count))
 		goto out;
@@ -204,37 +177,11 @@
 static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
                                    size_t count, loff_t *ppos)
 {
-	char *page;
+	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
-	ssize_t end;
-
-	if (count < 0 || count > PAGE_SIZE)
-		return -EINVAL;
-	if (!(page = (char*)__get_free_page(GFP_KERNEL)))
-		return -ENOMEM;
-	memset(page, 0, PAGE_SIZE);
 
-	length = scnprintf(page, PAGE_SIZE, "%u", POLICYDB_VERSION_MAX);
-	if (length < 0) {
-		free_page((unsigned long)page);
-		return length;
-	}
-
-	if (*ppos >= length) {
-		free_page((unsigned long)page);
-		return 0;
-	}
-	if (count + *ppos > length)
-		count = length - *ppos;
-	end = count + *ppos;
-	if (copy_to_user(buf, (char *) page + *ppos, count)) {
-		count = -EFAULT;
-		goto out;
-	}
-	*ppos = end;
-out:
-	free_page((unsigned long)page);
-	return count;
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", POLICYDB_VERSION_MAX);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
 static struct file_operations sel_policyvers_ops = {
@@ -247,37 +194,11 @@
 static ssize_t sel_read_mls(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	char *page;
+	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
-	ssize_t end;
-
-	if (count < 0 || count > PAGE_SIZE)
-		return -EINVAL;
-	if (!(page = (char*)__get_free_page(GFP_KERNEL)))
-		return -ENOMEM;
-	memset(page, 0, PAGE_SIZE);
-
-	length = scnprintf(page, PAGE_SIZE, "%d", selinux_mls_enabled);
-	if (length < 0) {
-		free_page((unsigned long)page);
-		return length;
-	}
 
-	if (*ppos >= length) {
-		free_page((unsigned long)page);
-		return 0;
-	}
-	if (count + *ppos > length)
-		count = length - *ppos;
-	end = count + *ppos;
-	if (copy_to_user(buf, (char *) page + *ppos, count)) {
-		count = -EFAULT;
-		goto out;
-	}
-	*ppos = end;
-out:
-	free_page((unsigned long)page);
-	return count;
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", selinux_mls_enabled);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
 static struct file_operations sel_mls_ops = {
@@ -352,10 +273,9 @@
 		/* No partial writes. */
 		return -EINVAL;
 	}
-	page = (char*)__get_free_page(GFP_KERNEL);
+	page = (char*)get_zeroed_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
-	memset(page, 0, PAGE_SIZE);
 	length = -EFAULT;
 	if (copy_from_user(page, buf, count))
 		goto out;
@@ -766,11 +679,10 @@
 		ret = -EINVAL;
 		goto out;
 	}
-	if (!(page = (char*)__get_free_page(GFP_KERNEL))) {
+	if (!(page = (char*)get_zeroed_page(GFP_KERNEL))) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	memset(page, 0, PAGE_SIZE);
 
 	inode = filep->f_dentry->d_inode;
 	cur_enforcing = security_get_bool_value(inode->i_ino - BOOL_INO_OFFSET);
@@ -832,12 +744,11 @@
 		/* No partial writes. */
 		goto out;
 	}
-	page = (char*)__get_free_page(GFP_KERNEL);
+	page = (char*)get_zeroed_page(GFP_KERNEL);
 	if (!page) {
 		length = -ENOMEM;
 		goto out;
 	}
-	memset(page, 0, PAGE_SIZE);
 
 	if (copy_from_user(page, buf, count))
 		goto out;
@@ -891,14 +802,12 @@
 		/* No partial writes. */
 		goto out;
 	}
-	page = (char*)__get_free_page(GFP_KERNEL);
+	page = (char*)get_zeroed_page(GFP_KERNEL);
 	if (!page) {
 		length = -ENOMEM;
 		goto out;
 	}
 
-	memset(page, 0, PAGE_SIZE);
-
 	if (copy_from_user(page, buf, count))
 		goto out;
 
@@ -984,9 +893,8 @@
 
 	sel_remove_bools(dir);
 
-	if (!(page = (char*)__get_free_page(GFP_KERNEL)))
+	if (!(page = (char*)get_zeroed_page(GFP_KERNEL)))
 		return -ENOMEM;
-	memset(page, 0, PAGE_SIZE);
 
 	ret = security_get_bools(&num, &names, &values);
 	if (ret != 0)
