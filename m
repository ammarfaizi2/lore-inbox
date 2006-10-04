Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161565AbWJDQbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161565AbWJDQbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161572AbWJDQbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:31:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:1228 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161571AbWJDQbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:31:21 -0400
Message-Id: <20061004161502.008787000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.45-1
Date: Wed, 04 Oct 2006 17:26:17 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 07/14] spufs: make mailbox functions handle multiple elements
Content-Disposition: inline; filename=spufs-mbox-multiread-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since libspe2 will provide a function that can read/write
multiple mailbox elements at once, the kernel should handle
that efficiently.

read/write on the three mailbox files can now access the
spe context multiple times to operate on any number of
mailbox data elements.

If the spu application keeps writing to its outbound
mailbox, the read call will pick up all the data in a
single system call.

Unfortunately, if the user passes an invalid pointer,
we may lose a mailbox element on read, since we can't
put it back. This probably impossible to solve, if the
user also accesses the mailbox through direct register
access.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -354,27 +354,54 @@ static int spufs_pipe_open(struct inode 
 	return nonseekable_open(inode, file);
 }
 
+/*
+ * Read as many bytes from the mailbox as possible, until
+ * one of the conditions becomes true:
+ *
+ * - no more data available in the mailbox
+ * - end of the user provided buffer
+ * - end of the mapped area
+ */
 static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
-	u32 mbox_data;
-	int ret;
+	u32 mbox_data, __user *udata;
+	ssize_t count;
 
 	if (len < 4)
 		return -EINVAL;
 
+	if (!access_ok(VERIFY_WRITE, buf, len))
+		return -EFAULT;
+
+	udata = (void __user *)buf;
+
 	spu_acquire(ctx);
-	ret = ctx->ops->mbox_read(ctx, &mbox_data);
+	for (count = 0; count <= len; count += 4, udata++) {
+		int ret;
+		ret = ctx->ops->mbox_read(ctx, &mbox_data);
+		if (ret == 0)
+			break;
+
+		/*
+		 * at the end of the mapped area, we can fault
+		 * but still need to return the data we have
+		 * read successfully so far.
+		 */
+		ret = __put_user(mbox_data, udata);
+		if (ret) {
+			if (!count)
+				count = -EFAULT;
+			break;
+		}
+	}
 	spu_release(ctx);
 
-	if (!ret)
-		return -EAGAIN;
-
-	if (copy_to_user(buf, &mbox_data, sizeof mbox_data))
-		return -EFAULT;
+	if (!count)
+		count = -EAGAIN;
 
-	return 4;
+	return count;
 }
 
 static struct file_operations spufs_mbox_fops = {
@@ -430,36 +457,70 @@ void spufs_ibox_callback(struct spu *spu
 	kill_fasync(&ctx->ibox_fasync, SIGIO, POLLIN);
 }
 
+/*
+ * Read as many bytes from the interrupt mailbox as possible, until
+ * one of the conditions becomes true:
+ *
+ * - no more data available in the mailbox
+ * - end of the user provided buffer
+ * - end of the mapped area
+ *
+ * If the file is opened without O_NONBLOCK, we wait here until
+ * any data is available, but return when we have been able to
+ * read something.
+ */
 static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
-	u32 ibox_data;
-	ssize_t ret;
+	u32 ibox_data, __user *udata;
+	ssize_t count;
 
 	if (len < 4)
 		return -EINVAL;
 
+	if (!access_ok(VERIFY_WRITE, buf, len))
+		return -EFAULT;
+
+	udata = (void __user *)buf;
+
 	spu_acquire(ctx);
 
-	ret = 0;
+	/* wait only for the first element */
+	count = 0;
 	if (file->f_flags & O_NONBLOCK) {
 		if (!spu_ibox_read(ctx, &ibox_data))
-			ret = -EAGAIN;
+			count = -EAGAIN;
 	} else {
-		ret = spufs_wait(ctx->ibox_wq, spu_ibox_read(ctx, &ibox_data));
+		count = spufs_wait(ctx->ibox_wq, spu_ibox_read(ctx, &ibox_data));
 	}
+	if (count)
+		goto out;
 
-	spu_release(ctx);
+	/* if we can't write at all, return -EFAULT */
+	count = __put_user(ibox_data, udata);
+	if (count)
+		goto out;
 
-	if (ret)
-		return ret;
+	for (count = 4, udata++; (count + 4) <= len; count += 4, udata++) {
+		int ret;
+		ret = ctx->ops->ibox_read(ctx, &ibox_data);
+		if (ret == 0)
+			break;
+		/*
+		 * at the end of the mapped area, we can fault
+		 * but still need to return the data we have
+		 * read successfully so far.
+		 */
+		ret = __put_user(ibox_data, udata);
+		if (ret)
+			break;
+	}
 
-	ret = 4;
-	if (copy_to_user(buf, &ibox_data, sizeof ibox_data))
-		ret = -EFAULT;
+out:
+	spu_release(ctx);
 
-	return ret;
+	return count;
 }
 
 static unsigned int spufs_ibox_poll(struct file *file, poll_table *wait)
@@ -532,32 +593,67 @@ void spufs_wbox_callback(struct spu *spu
 	kill_fasync(&ctx->wbox_fasync, SIGIO, POLLOUT);
 }
 
+/*
+ * Write as many bytes to the interrupt mailbox as possible, until
+ * one of the conditions becomes true:
+ *
+ * - the mailbox is full
+ * - end of the user provided buffer
+ * - end of the mapped area
+ *
+ * If the file is opened without O_NONBLOCK, we wait here until
+ * space is availabyl, but return when we have been able to
+ * write something.
+ */
 static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
-	u32 wbox_data;
-	int ret;
+	u32 wbox_data, __user *udata;
+	ssize_t count;
 
 	if (len < 4)
 		return -EINVAL;
 
-	if (copy_from_user(&wbox_data, buf, sizeof wbox_data))
+	udata = (void __user *)buf;
+	if (!access_ok(VERIFY_READ, buf, len))
+		return -EFAULT;
+
+	if (__get_user(wbox_data, udata))
 		return -EFAULT;
 
 	spu_acquire(ctx);
 
-	ret = 0;
+	/*
+	 * make sure we can at least write one element, by waiting
+	 * in case of !O_NONBLOCK
+	 */
+	count = 0;
 	if (file->f_flags & O_NONBLOCK) {
 		if (!spu_wbox_write(ctx, wbox_data))
-			ret = -EAGAIN;
+			count = -EAGAIN;
 	} else {
-		ret = spufs_wait(ctx->wbox_wq, spu_wbox_write(ctx, wbox_data));
+		count = spufs_wait(ctx->wbox_wq, spu_wbox_write(ctx, wbox_data));
 	}
 
-	spu_release(ctx);
+	if (count)
+		goto out;
+
+	/* write aѕ much as possible */
+	for (count = 4, udata++; (count + 4) <= len; count += 4, udata++) {
+		int ret;
+		ret = __get_user(wbox_data, udata);
+		if (ret)
+			break;
+
+		ret = spu_wbox_write(ctx, wbox_data);
+		if (ret == 0)
+			break;
+	}
 
-	return ret ? ret : sizeof wbox_data;
+out:
+	spu_release(ctx);
+	return count;
 }
 
 static unsigned int spufs_wbox_poll(struct file *file, poll_table *wait)

--

