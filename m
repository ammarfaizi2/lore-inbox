Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVJHUu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVJHUu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 16:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVJHUu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 16:50:27 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:47565 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751096AbVJHUu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 16:50:27 -0400
Date: Sat, 8 Oct 2005 16:50:12 -0400
From: Latchesar Ionkov <lucho@ionkov.net>
To: Andrew Morton <akpm@osdl.org>
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] v9fs: remove additional buffer allocation from v9fs_file_read and v9fs_file_write
Message-ID: <20051008205012.GA24903@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

v9fs_file_read and v9fs_file_write use kmalloc to allocate buffers as big
as the data buffer received as parameter. kmalloc cannot be used to
allocate buffers bigger than 128K, so reading/writing data in chunks bigger
than 128k fails.

This patch reorganizes v9fs_file_read and v9fs_file_write to allocate only
buffers as big as the maximum data that can be sent in one 9P message.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---
commit a91c4b160fc3a141f47c5663e8090d8a7c8ba7cd
tree 71bfc8a6cb66f9daf8a156344cb8d704f578fa35
parent c0758146adbe39514e75ac860ce7e49f865c2297
author Latchesar Ionkov <lucho@ionkov.net> Thu, 06 Oct 2005 06:45:14 -0400
committer Latchesar Ionkov <lucho@ionkov.net> Thu, 06 Oct 2005 06:45:14 -0400

 fs/9p/vfs_file.c |  114 ++++++++++++++++--------------------------------------
 1 files changed, 33 insertions(+), 81 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -175,16 +175,16 @@ static int v9fs_file_lock(struct file *f
 }
 
 /**
- * v9fs_read - read from a file (internal)
+ * v9fs_file_read - read from a file
  * @filep: file pointer to read
  * @data: data buffer to read data into
  * @count: size of buffer
  * @offset: offset at which to read data
  *
  */
-
 static ssize_t
-v9fs_read(struct file *filp, char *buffer, size_t count, loff_t * offset)
+v9fs_file_read(struct file *filp, char __user * data, size_t count,
+	       loff_t * offset)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
@@ -194,6 +194,7 @@ v9fs_read(struct file *filp, char *buffe
 	int rsize = 0;
 	int result = 0;
 	int total = 0;
+	int n;
 
 	dprintk(DEBUG_VFS, "\n");
 
@@ -216,10 +217,15 @@ v9fs_read(struct file *filp, char *buffe
 		} else
 			*offset += result;
 
-		/* XXX - extra copy */
-		memcpy(buffer, fcall->params.rread.data, result);
+		n = copy_to_user(data, fcall->params.rread.data, result);
+		if (n) {
+			dprintk(DEBUG_ERROR, "Problem copying to user %d\n", n);
+			kfree(fcall);
+			return -EFAULT;
+		}
+			
 		count -= result;
-		buffer += result;
+		data += result;
 		total += result;
 
 		kfree(fcall);
@@ -232,42 +238,7 @@ v9fs_read(struct file *filp, char *buffe
 }
 
 /**
- * v9fs_file_read - read from a file
- * @filep: file pointer to read
- * @data: data buffer to read data into
- * @count: size of buffer
- * @offset: offset at which to read data
- *
- */
-
-static ssize_t
-v9fs_file_read(struct file *filp, char __user * data, size_t count,
-	       loff_t * offset)
-{
-	int retval = -1;
-	int ret = 0;
-	char *buffer;
-
-	buffer = kmalloc(count, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
-	retval = v9fs_read(filp, buffer, count, offset);
-	if (retval > 0) {
-		if ((ret = copy_to_user(data, buffer, retval)) != 0) {
-			dprintk(DEBUG_ERROR, "Problem copying to user %d\n",
-				ret);
-			retval = ret;
-		}
-	}
-
-	kfree(buffer);
-
-	return retval;
-}
-
-/**
- * v9fs_write - write to a file
+ * v9fs_file_write - write to a file
  * @filep: file pointer to write
  * @data: data buffer to write data from
  * @count: size of buffer
@@ -276,7 +247,8 @@ v9fs_file_read(struct file *filp, char _
  */
 
 static ssize_t
-v9fs_write(struct file *filp, char *buffer, size_t count, loff_t * offset)
+v9fs_file_write(struct file *filp, const char __user * data,
+		size_t count, loff_t * offset)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
@@ -286,30 +258,42 @@ v9fs_write(struct file *filp, char *buff
 	int result = -EIO;
 	int rsize = 0;
 	int total = 0;
+	char *buf;
 
-	dprintk(DEBUG_VFS, "data %p count %d offset %x\n", buffer, (int)count,
+	dprintk(DEBUG_VFS, "data %p count %d offset %x\n", data, (int)count,
 		(int)*offset);
 	rsize = v9ses->maxdata - V9FS_IOHDRSZ;
 	if (v9fid->iounit != 0 && rsize > v9fid->iounit)
 		rsize = v9fid->iounit;
 
-	dump_data(buffer, count);
+	buf = kmalloc(v9ses->maxdata - V9FS_IOHDRSZ, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
 	do {
 		if (count < rsize)
 			rsize = count;
 
-		result =
-		    v9fs_t_write(v9ses, fid, *offset, rsize, buffer, &fcall);
+		result = copy_from_user(buf, data, rsize);
+		if (result) {
+			dprintk(DEBUG_ERROR, "Problem copying from user\n");
+			kfree(buf);
+			return -EFAULT;
+		}
+
+		dump_data(buf, rsize);
+		result = v9fs_t_write(v9ses, fid, *offset, rsize, buf, &fcall);
 		if (result < 0) {
 			eprintk(KERN_ERR, "error while writing: %s(%d)\n",
 				FCALL_ERROR(fcall), result);
 			kfree(fcall);
+			kfree(buf);
 			return result;
 		} else
 			*offset += result;
 
 		kfree(fcall);
+		fcall = NULL;
 
 		if (result != rsize) {
 			eprintk(KERN_ERR,
@@ -319,46 +303,14 @@ v9fs_write(struct file *filp, char *buff
 		}
 
 		count -= result;
-		buffer += result;
+		data += result;
 		total += result;
 	} while (count);
 
+	kfree(buf);
 	return total;
 }
 
-/**
- * v9fs_file_write - write to a file
- * @filep: file pointer to write
- * @data: data buffer to write data from
- * @count: size of buffer
- * @offset: offset at which to write data
- *
- */
-
-static ssize_t
-v9fs_file_write(struct file *filp, const char __user * data,
-		size_t count, loff_t * offset)
-{
-	int ret = -1;
-	char *buffer;
-
-	buffer = kmalloc(count, GFP_KERNEL);
-	if (buffer == NULL)
-		return -ENOMEM;
-
-	ret = copy_from_user(buffer, data, count);
-	if (ret) {
-		dprintk(DEBUG_ERROR, "Problem copying from user\n");
-		ret = -EFAULT;
-	} else {
-		ret = v9fs_write(filp, buffer, count, offset);
-	}
-
-	kfree(buffer);
-
-	return ret;
-}
-
 struct file_operations v9fs_file_operations = {
 	.llseek = generic_file_llseek,
 	.read = v9fs_file_read,
