Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVJMTpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVJMTpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVJMTpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:45:21 -0400
Received: from jeffindy.licquia.org ([216.37.46.185]:3339 "EHLO
	jeffindy.licquia.org") by vger.kernel.org with ESMTP
	id S932168AbVJMTpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:45:20 -0400
Subject: [PATCH] 2.6.13: POSIX violation in pipes on ia64 for kernels >
	2.6.10
From: Jeff Licquia <licquia@progeny.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Oct 2005 14:44:35 -0500
Message-Id: <1129232675.4573.18.camel@laptop1>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On architectures where PAGE_SIZE > PIPE_BUF, a read of PIPE_BUF bytes
from a full pipe does not change the pipe's write state.  This behavior
is different from kernels 2.6.9 and earlier, and it triggers failures of
the LSB tests.  

This patch fixes two parts of this problem: "short" writes are allowed
to partially succeed if the whole write won't fit on the current buffer,
and the last buffer for a full pipe is "held back" and gradually
released in PIPE_BUF blocks as reads happen.  This patch has been tested
against the LSB runtime test suite, with no kernel-related failures.

A more detailed description of the problem can be found on the
linux-ia64 list:

http://marc.theaimsgroup.com/?l=linux-ia64&m=112906384826364

Please CC me on replies, thanks.

Signed-off-by: Jeff Licquia <licquia@progeny.com>

--- linux-2.6.13-orig/fs/pipe.c	2005-10-10 13:51:38.000000000 -0500
+++ linux-2.6.13/fs/pipe.c	2005-10-12 17:45:34.000000000 -0500
@@ -15,6 +15,7 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/uio.h>
 #include <linux/highmem.h>
+#include <linux/limits.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -220,11 +221,13 @@
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct pipe_inode_info *info;
+	struct pipe_buffer *buf;
 	ssize_t ret;
 	int do_wakeup;
 	struct iovec *iov = (struct iovec *)_iov;
 	size_t total_len;
 	ssize_t chars;
+	size_t last_allowed_len;
 
 	total_len = iov_length(iov, nr_segs);
 	/* Null write succeeds. */
@@ -242,16 +245,28 @@
 		goto out;
 	}
 
+	buf = info->bufs + info->curbuf;
+	last_allowed_len = buf->offset & ~(PIPE_BUF-1);
+
 	/* We try to merge small writes */
 	chars = total_len & (PAGE_SIZE-1); /* size of the last buffer */
 	if (info->nrbufs && chars != 0) {
 		int lastbuf = (info->curbuf + info->nrbufs - 1) & (PIPE_BUFFERS-1);
-		struct pipe_buffer *buf = info->bufs + lastbuf;
-		struct pipe_buf_operations *ops = buf->ops;
-		int offset = buf->offset + buf->len;
-		if (ops->can_merge && offset + chars <= PAGE_SIZE) {
+		struct pipe_buf_operations *ops;
+		int offset;
+		size_t max_write = PAGE_SIZE;
+
+		if (lastbuf == info->curbuf - 1 || lastbuf == (PIPE_BUFFERS-1))
+			max_write = last_allowed_len;
+		buf = info->bufs + lastbuf;
+		ops = buf->ops;
+		offset = buf->offset + buf->len;
+		if (ops->can_merge && offset < max_write) {
 			void *addr = ops->map(filp, info, buf);
-			int error = pipe_iov_copy_from_user(offset + addr, iov, chars);
+			int error;
+			if (chars > (max_write - offset))
+				chars = max_write - offset;
+			error = pipe_iov_copy_from_user(offset + addr, iov, chars);
 			ops->unmap(info, buf);
 			ret = error;
 			do_wakeup = 1;
@@ -275,10 +290,13 @@
 		bufs = info->nrbufs;
 		if (bufs < PIPE_BUFFERS) {
 			int newbuf = (info->curbuf + bufs) & (PIPE_BUFFERS-1);
-			struct pipe_buffer *buf = info->bufs + newbuf;
 			struct page *page = info->tmp_page;
 			int error;
+			size_t max_write = PAGE_SIZE;
 
+			if (newbuf == info->curbuf - 1 || newbuf == (PIPE_BUFFERS-1))
+				max_write = last_allowed_len;
+			buf = info->bufs + newbuf;
 			if (!page) {
 				page = alloc_page(GFP_HIGHUSER);
 				if (unlikely(!page)) {
@@ -293,7 +311,7 @@
 			 * FIXME! Is this really true?
 			 */
 			do_wakeup = 1;
-			chars = PAGE_SIZE;
+			chars = max_write;
 			if (chars > total_len)
 				chars = total_len;
 

