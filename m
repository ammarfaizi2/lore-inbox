Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSIEHso>; Thu, 5 Sep 2002 03:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317264AbSIEHso>; Thu, 5 Sep 2002 03:48:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53778 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317261AbSIEHsm>;
	Thu, 5 Sep 2002 03:48:42 -0400
Message-ID: <3D771064.B1E989C7@zip.com.au>
Date: Thu, 05 Sep 2002 01:05:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/3] Use an atomic kmap for generic_file_read()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch allows the kernel to hold atomic kmaps in file_read_actor().

We try to fault in the page, then take an atomic kmap.  If the atomic
copy_to_user() then faults, drop a printk and fall back to kmap().



 filemap.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 47 insertions(+), 2 deletions(-)

--- 2.5.33/mm/filemap.c~kmap_atomic_reads	Thu Sep  5 00:58:46 2002
+++ 2.5.33-akpm/mm/filemap.c	Thu Sep  5 00:58:46 2002
@@ -1036,7 +1036,37 @@ no_cached_page:
 	UPDATE_ATIME(inode);
 }
 
-int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
+/*
+ * Fault a userspace page into pagetables.  Return non-zero on a fault.
+ *
+ * FIXME: this assumes that two userspace pages are always sufficient.  That's
+ * not true if PAGE_CACHE_SIZE > PAGE_SIZE.
+ */
+static inline int fault_in_pages_writeable(char *uaddr, int size)
+{
+	int ret;
+
+	/*
+	 * Writing zeroes into userspace here is OK, because we know that if
+	 * the zero gets there, we'll be overwriting it.
+	 */
+	ret = __put_user(0, uaddr);
+	if (ret == 0) {
+		char *end = uaddr + size - 1;
+
+		/*
+		 * If the page was already mapped, this will get a cache miss
+		 * for sure, so try to avoid doing it.
+		 */
+		if (((unsigned long)uaddr & PAGE_MASK) !=
+				((unsigned long)end & PAGE_MASK))
+		 	ret = __put_user(0, end);
+	}
+	return ret;
+}
+
+int file_read_actor(read_descriptor_t *desc, struct page *page,
+			unsigned long offset, unsigned long size)
 {
 	char *kaddr;
 	unsigned long left, count = desc->count;
@@ -1044,14 +1074,29 @@ int file_read_actor(read_descriptor_t * 
 	if (size > count)
 		size = count;
 
+	/*
+	 * Faults on the destination of a read are common, so do it before
+	 * taking the kmap.
+	 */
+	if (!fault_in_pages_writeable(desc->buf, size)) {
+		kaddr = kmap_atomic(page, KM_USER0);
+		left = __copy_to_user(desc->buf, kaddr + offset, size);
+		kunmap_atomic(kaddr, KM_USER0);
+		if (left == 0)
+			goto success;
+		printk("%s: Unexpected page fault\n", __FUNCTION__);
+	}
+
+	/* Do it the slow way */
 	kaddr = kmap(page);
 	left = __copy_to_user(desc->buf, kaddr + offset, size);
 	kunmap(page);
-	
+
 	if (left) {
 		size -= left;
 		desc->error = -EFAULT;
 	}
+success:
 	desc->count = count - size;
 	desc->written += size;
 	desc->buf += size;

.
