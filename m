Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSILNDd>; Thu, 12 Sep 2002 09:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSILNDd>; Thu, 12 Sep 2002 09:03:33 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:2056 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S315540AbSILNDb>;
	Thu, 12 Sep 2002 09:03:31 -0400
Date: Thu, 12 Sep 2002 22:00:41 +0900 (JST)
Message-Id: <20020912.220041.82105437.taka@valinux.co.jp>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janetmor@us.ibm.com
Subject: Re: [patch] readv/writev rework
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3D7EFF0F.89F7D585@digeo.com>
References: <3D7EFF0F.89F7D585@digeo.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Your readv/writev patch interested me and I checked it.
I found we also have a chance to improve normal writev.

a_ops->prepare_write() and a_ops->commit_write will have a
penalty when I/O size isn't PAGE_SIZE.
With following patch generic_file_write_nolock() will try to
make each I/O size become PAGE_SIZE.

Could you apply it?

> This is Janet Morgan's patch which converts the readv/writev code
> to submit all segments for IO before waiting on them, rather than
> submitting each segment separately.
> 
> This is a critical performance fix for O_DIRECT reads and writes.
> Prior to this change, O_DIRECT vectored IO was forced to wait for
> completion against each segment of the iovec rather than submitting all
> segments and waiting on the lot.  ie: for ten segments, this code will
> be ten times faster.

Thank you,
Hirokazu Takahashi.



--- linux-2.5.34/mm/filemap.c.ORG	Wed Sep 11 19:48:00 2030
+++ linux-2.5.34/mm/filemap.c	Thu Sep 12 21:43:02 2030
@@ -2109,14 +2109,18 @@ generic_file_write_nolock(struct file *f
 		unsigned long index;
 		unsigned long offset;
 		long page_fault;
+		unsigned rest;
+		unsigned copy;
+		unsigned off;
+		struct iovec	*work_iov;
+		char		*work_buf;
+		unsigned	 work_iov_bytes;
 
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
 		if (bytes > count)
 			bytes = count;
-		if (bytes + written > iov_bytes)
-			bytes = iov_bytes - written;
 
 		/*
 		 * Bring in the user page that we will copy from _first_.
@@ -2144,7 +2148,29 @@ generic_file_write_nolock(struct file *f
 				vmtruncate(inode, inode->i_size);
 			break;
 		}
-		page_fault = filemap_copy_from_user(page, offset, buf, bytes);
+
+		rest = bytes;
+		off = 0;
+		work_iov = cur_iov;
+		work_buf = buf;
+		work_iov_bytes = iov_bytes;
+		while (rest) {
+			copy = rest;
+			if (written + off == work_iov_bytes) {
+				work_iov++;
+				work_iov_bytes += work_iov->iov_len;
+				work_buf = work_iov->iov_base;
+			}
+			if (copy + written + off > work_iov_bytes)
+				copy = work_iov_bytes - written - off;
+
+			page_fault = filemap_copy_from_user(page, offset+off, work_buf, copy);
+			rest -= copy;
+			off += copy;
+			work_buf += copy;
+			if (unlikely(page_fault))
+				break;
+		}
 		status = a_ops->commit_write(file, page, offset, offset+bytes);
 		if (unlikely(page_fault)) {
 			status = -EFAULT;
@@ -2153,14 +2179,21 @@ generic_file_write_nolock(struct file *f
 				status = bytes;
 
 			if (status >= 0) {
-				written += status;
 				count -= status;
 				pos += status;
-				buf += status;
-				if (written == iov_bytes && count) {
-					cur_iov++;
-					iov_bytes += cur_iov->iov_len;
-					buf = cur_iov->iov_base;
+				rest = status;
+				while (rest) {
+					copy = rest;
+					if (written == iov_bytes) {
+						cur_iov++;
+						iov_bytes += cur_iov->iov_len;
+						buf = cur_iov->iov_base;
+					}
+					if (copy + written > iov_bytes)
+						copy = iov_bytes - written;
+					rest -= copy;
+					written += copy;
+					buf += copy;
 				}
 			}
 		}
