Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVLISVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVLISVK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVLISUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:20:41 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:50124 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964851AbVLIST6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:19:58 -0500
Message-Id: <200512091921.45285.arnd@arndb.de>
References: <20051209180414.872465000@localhost>
Date: Fri, 9 Dec 2005 19:21:44 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 8/8] powerpc: fix large nvram access
Content-Disposition: inline
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/dev/nvram uses the user-provided read/write size
for kmalloc, which fails, if a large number is passed.
This will always use a single page at most, which
can be expected to succeed.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/kernel/nvram_64.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/kernel/nvram_64.c
+++ linux-2.6.15-rc/arch/powerpc/kernel/nvram_64.c
@@ -80,80 +80,74 @@ static loff_t dev_nvram_llseek(struct fi
 static ssize_t dev_nvram_read(struct file *file, char __user *buf,
 			  size_t count, loff_t *ppos)
 {
-	ssize_t len;
-	char *tmp_buffer;
-	int size;
+	ssize_t ret;
+	char *tmp = NULL;
+	ssize_t size;
+
+	ret = -ENODEV;
+	if (!ppc_md.nvram_size)
+		goto out;
 
-	if (ppc_md.nvram_size == NULL)
-		return -ENODEV;
+	ret = 0;
 	size = ppc_md.nvram_size();
+	if (*ppos >= size || size < 0)
+		goto out;
 
-	if (!access_ok(VERIFY_WRITE, buf, count))
-		return -EFAULT;
-	if (*ppos >= size)
-		return 0;
-	if (count > size) 
-		count = size;
-
-	tmp_buffer = (char *) kmalloc(count, GFP_KERNEL);
-	if (!tmp_buffer) {
-		printk(KERN_ERR "dev_read_nvram: kmalloc failed\n");
-		return -ENOMEM;
-	}
-
-	len = ppc_md.nvram_read(tmp_buffer, count, ppos);
-	if ((long)len <= 0) {
-		kfree(tmp_buffer);
-		return len;
-	}
-
-	if (copy_to_user(buf, tmp_buffer, len)) {
-		kfree(tmp_buffer);
-		return -EFAULT;
-	}
+	count = min_t(size_t, count, size - *ppos);
+	count = min(count, PAGE_SIZE);
 
-	kfree(tmp_buffer);
-	return len;
+	ret = -ENOMEM;
+	tmp = kmalloc(count, GFP_KERNEL);
+	if (!tmp)
+		goto out;
+
+	ret = ppc_md.nvram_read(tmp, count, ppos);
+	if (ret <= 0)
+		goto out;
+
+	if (copy_to_user(buf, tmp, ret))
+		ret = -EFAULT;
+
+out:
+	kfree(tmp);
+	return ret;
 
 }
 
 static ssize_t dev_nvram_write(struct file *file, const char __user *buf,
-			   size_t count, loff_t *ppos)
+			  size_t count, loff_t *ppos)
 {
-	ssize_t len;
-	char * tmp_buffer;
-	int size;
+	ssize_t ret;
+	char *tmp = NULL;
+	ssize_t size;
+
+	ret = -ENODEV;
+	if (!ppc_md.nvram_size)
+		goto out;
 
-	if (ppc_md.nvram_size == NULL)
-		return -ENODEV;
+	ret = 0;
 	size = ppc_md.nvram_size();
+	if (*ppos >= size || size < 0)
+		goto out;
 
-	if (!access_ok(VERIFY_READ, buf, count))
-		return -EFAULT;
-	if (*ppos >= size)
-		return 0;
-	if (count > size)
-		count = size;
-
-	tmp_buffer = (char *) kmalloc(count, GFP_KERNEL);
-	if (!tmp_buffer) {
-		printk(KERN_ERR "dev_nvram_write: kmalloc failed\n");
-		return -ENOMEM;
-	}
-	
-	if (copy_from_user(tmp_buffer, buf, count)) {
-		kfree(tmp_buffer);
-		return -EFAULT;
-	}
+	count = min_t(size_t, count, size - *ppos);
+	count = min(count, PAGE_SIZE);
 
-	len = ppc_md.nvram_write(tmp_buffer, count, ppos);
-	if ((long)len <= 0) {
-		kfree(tmp_buffer);
-		return len;
-	}
+	ret = -ENOMEM;
+	tmp = kmalloc(count, GFP_KERNEL);
+	if (!tmp)
+		goto out;
+
+	ret = -EFAULT;
+	if (copy_from_user(tmp, buf, count))
+		goto out;
+
+	ret = ppc_md.nvram_write(tmp, count, ppos);
+
+out:
+	kfree(tmp);
+	return ret;
 
-	kfree(tmp_buffer);
-	return len;
 }
 
 static int dev_nvram_ioctl(struct inode *inode, struct file *file,

--

