Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTEVPgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTEVPgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:36:50 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:62598 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id S261994AbTEVPgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:36:45 -0400
Date: Thu, 22 May 2003 17:47:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@digeo.com, torvalds@transmeta.com
Subject: [PATCH] writev failures for iovec with invalid addresses.
Message-ID: <20030522154743.GA3005@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I debugged writev01 from the LTP testsuite and I found why it fails.
The third test in writev01 passes a 3 element iovec to sys_writev.
The first iovec is valid, the second points to an invalid address and
the third is valid again. As I read the specification writev should
write the first iovec and return the number of bytes in it. 2.5.69
returns -EFAULT. The reason is that filemap_copy_from_user_iovec
returns != 0 if ANY of the iovec elements is invalid. This causes
generic_file_aio_write_nolock not to write the valid elements in the
iovec. The return value will then be either too small or -EFAULT
instead of the real number of bytes that could have been written.
The attached patch should fix the problem. It changes filemap.c
to make filemap_copy_from_user/filemap_copy_from_user_iovec return
the number of successfully copied bytes instead of "page_fault".
generic_file_aio_write_nolock commits the write operation if at
least the first iovec has been valid and returns the correct number
of bytes. Comments ?

blue skies,
  Martin.
----

Fix sys_writev for vectors which contain a invalid address in the middle
of the iovec list.

diffstat:
 mm/filemap.c |   45 +++++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 20 deletions(-)

diff -urN linux-2.5.69/mm/filemap.c linux-2.5.69-s390/mm/filemap.c
--- linux-2.5.69/mm/filemap.c	Thu May 22 13:26:29 2003
+++ linux-2.5.69-s390/mm/filemap.c	Thu May 22 13:26:47 2003
@@ -1410,7 +1410,7 @@
 	}
 }
 
-static inline int
+static inline size_t
 filemap_copy_from_user(struct page *page, unsigned long offset,
 			const char __user *buf, unsigned bytes)
 {
@@ -1427,44 +1427,45 @@
 		left = __copy_from_user(kaddr + offset, buf, bytes);
 		kunmap(page);
 	}
-	return left;
+	return left ? 0 : bytes;
 }
 
-static int
+static size_t
 __filemap_copy_from_user_iovec(char *vaddr, 
 			const struct iovec *iov, size_t base, size_t bytes)
 {
-	int left = 0;
+	size_t copied = 0;
 
 	while (bytes) {
 		char __user *buf = iov->iov_base + base;
 		int copy = min(bytes, iov->iov_len - base);
 		base = 0;
-		if ((left = __copy_from_user(vaddr, buf, copy)))
+		if (__copy_from_user(vaddr, buf, copy))
 			break;
+		copied += copy;
 		bytes -= copy;
 		vaddr += copy;
 		iov++;
 	}
-	return left;
+	return copied;
 }
 
-static inline int
+static inline size_t
 filemap_copy_from_user_iovec(struct page *page, unsigned long offset,
 			const struct iovec *iov, size_t base, size_t bytes)
 {
 	char *kaddr;
-	int left;
+	size_t copied;
 
 	kaddr = kmap_atomic(page, KM_USER0);
-	left = __filemap_copy_from_user_iovec(kaddr + offset, iov, base, bytes);
+	copied = __filemap_copy_from_user_iovec(kaddr + offset, iov, base, bytes);
 	kunmap_atomic(kaddr, KM_USER0);
-	if (left != 0) {
+	if (copied != bytes) {
 		kaddr = kmap(page);
-		left = __filemap_copy_from_user_iovec(kaddr + offset, iov, base, bytes);
+		copied = __filemap_copy_from_user_iovec(kaddr + offset, iov, base, bytes);
 		kunmap(page);
 	}
-	return left;
+	return copied;
 }
 
 static inline void
@@ -1672,7 +1673,7 @@
 	do {
 		unsigned long index;
 		unsigned long offset;
-		long page_fault;
+		size_t copied;
 
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
@@ -1707,18 +1708,18 @@
 			break;
 		}
 		if (likely(nr_segs == 1))
-			page_fault = filemap_copy_from_user(page, offset,
+			copied = filemap_copy_from_user(page, offset,
 							buf, bytes);
 		else
-			page_fault = filemap_copy_from_user_iovec(page, offset,
+			copied = filemap_copy_from_user_iovec(page, offset,
 						cur_iov, iov_base, bytes);
 		flush_dcache_page(page);
-		status = a_ops->commit_write(file, page, offset, offset+bytes);
-		if (unlikely(page_fault)) {
-			status = -EFAULT;
-		} else {
+		if (likely(copied > 0)) {
+			status = a_ops->commit_write(file, page, offset,
+						     offset + copied);
+
 			if (!status)
-				status = bytes;
+				status = copied;
 
 			if (status >= 0) {
 				written += status;
@@ -1730,6 +1731,10 @@
 							&iov_base, status);
 			}
 		}
+		if (unlikely(copied != bytes))
+			if (status >= 0)
+				status = -EFAULT;
+
 		if (!PageReferenced(page))
 			SetPageReferenced(page);
 		unlock_page(page);
