Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVLIVKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVLIVKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVLIVKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:10:53 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:61833 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932393AbVLIVKw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:10:52 -0500
Subject: [RFC][PATCH] Support for preadv()/pwritev()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Zach Brown <zach.brown@oracle.com>, Christoph Hellwig <hch@infradead.org>,
       akpm@osdl.org
Content-Type: multipart/mixed; boundary="=-1UejhAfHaf7SpjCwLKro"
Date: Fri, 09 Dec 2005 13:11:04 -0800
Message-Id: <1134162664.16646.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1UejhAfHaf7SpjCwLKro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Some of the database folks are looking going towards "threaded"
database model and wants support for preadv() and pwritev() -
so that they have a way of doing lseek() followed by readv/writev()
in the thread-safe way.

Here is the patch I cooked up and looking for feedback. I really
don't like adding new syscalls for this, but I don't see a way out.

Of course, database folks want aio_readv/aio_writev() support also,
which Zack is working on.

Comments ? Suggestions ? 

Thanks,
Badari




--=-1UejhAfHaf7SpjCwLKro
Content-Disposition: attachment; filename=preadv-pwritev.patch
Content-Type: text/x-patch; name=preadv-pwritev.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Narup -X dontdiff linux-2.6.15-rc5/arch/i386/kernel/syscall_table.S linux-2.6.15-rc5.preadv/arch/i386/kernel/syscall_table.S
--- linux-2.6.15-rc5/arch/i386/kernel/syscall_table.S	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5.preadv/arch/i386/kernel/syscall_table.S	2005-12-09 08:01:22.465116256 -0800
@@ -294,3 +294,5 @@ ENTRY(sys_call_table)
 	.long sys_inotify_init
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
+	.long sys_preadv
+	.long sys_pwritev
diff -Narup -X dontdiff linux-2.6.15-rc5/fs/read_write.c linux-2.6.15-rc5.preadv/fs/read_write.c
--- linux-2.6.15-rc5/fs/read_write.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5.preadv/fs/read_write.c	2005-12-09 08:02:43.590783280 -0800
@@ -622,6 +622,46 @@ sys_writev(unsigned long fd, const struc
 	return ret;
 }
 
+asmlinkage ssize_t sys_preadv(unsigned int fd, const struct iovec __user *vec,
+			     unsigned long vlen, loff_t pos)
+{
+	struct file *file;
+	ssize_t ret = -EBADF;
+	int fput_needed;
+
+	if (pos < 0)
+		return -EINVAL;
+
+	file = fget_light(fd, &fput_needed);
+	if (file) {
+		ret = -ESPIPE;
+		if (file->f_mode & FMODE_PREAD)
+			ret = vfs_readv(file, vec, vlen, &pos);
+		fput_light(file, fput_needed);
+	}
+	return ret;
+}
+
+asmlinkage ssize_t sys_pwritev(unsigned int fd, const struct iovec __user *vec,
+			     unsigned long vlen, loff_t pos)
+{
+	struct file *file;
+	ssize_t ret = -EBADF;
+	int fput_needed;
+
+	if (pos < 0)
+		return -EINVAL;
+
+	file = fget_light(fd, &fput_needed);
+	if (file) {
+		ret = -ESPIPE;
+		if (file->f_mode & FMODE_PWRITE)  
+			ret = vfs_writev(file, vec, vlen, &pos);
+		fput_light(file, fput_needed);
+	}
+	return ret;
+}
+
 static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 			   size_t count, loff_t max)
 {

--=-1UejhAfHaf7SpjCwLKro--

