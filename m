Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVEWX0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVEWX0Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVEWXYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:24:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:39808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261246AbVEWXRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:17:37 -0400
Date: Mon, 23 May 2005 16:17:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [patch 01/16] Fix get_unmapped_area sanity tests
Message-ID: <20050523231711.GM27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix get_unmapped_area sanity tests

As noted by Chris Wright, we need to do the full range of tests regardless
of whether MAP_FIXED is set or not, so re-organize get_unmapped_area()
slightly to do the sanity checks unconditionally.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/linux/err.h |    4 ++-
 mm/mmap.c           |   59 +++++++++++++++++++++++++++-------------------------
 2 files changed, 34 insertions(+), 29 deletions(-)

--- linux-2.6.11.10.orig/include/linux/err.h	2005-05-16 10:51:42.000000000 -0700
+++ linux-2.6.11.10/include/linux/err.h	2005-05-20 10:14:06.838521528 -0700
@@ -13,6 +13,8 @@
  * This should be a per-architecture thing, to allow different
  * error and pointer decisions.
  */
+#define IS_ERR_VALUE(x) unlikely((x) > (unsigned long)-1000L)
+
 static inline void *ERR_PTR(long error)
 {
 	return (void *) error;
@@ -25,7 +27,7 @@
 
 static inline long IS_ERR(const void *ptr)
 {
-	return unlikely((unsigned long)ptr > (unsigned long)-1000L);
+	return IS_ERR_VALUE((unsigned long)ptr);
 }
 
 #endif /* _LINUX_ERR_H */
--- linux-2.6.11.10.orig/mm/mmap.c	2005-05-16 10:51:55.000000000 -0700
+++ linux-2.6.11.10/mm/mmap.c	2005-05-20 10:40:34.071225480 -0700
@@ -1315,37 +1315,40 @@
 get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		unsigned long pgoff, unsigned long flags)
 {
-	if (flags & MAP_FIXED) {
-		unsigned long ret;
+	unsigned long ret;
 
-		if (addr > TASK_SIZE - len)
-			return -ENOMEM;
-		if (addr & ~PAGE_MASK)
-			return -EINVAL;
-		if (file && is_file_hugepages(file))  {
-			/*
-			 * Check if the given range is hugepage aligned, and
-			 * can be made suitable for hugepages.
-			 */
-			ret = prepare_hugepage_range(addr, len);
-		} else {
-			/*
-			 * Ensure that a normal request is not falling in a
-			 * reserved hugepage range.  For some archs like IA-64,
-			 * there is a separate region for hugepages.
-			 */
-			ret = is_hugepage_only_range(addr, len);
-		}
-		if (ret)
-			return -EINVAL;
-		return addr;
-	}
+	if (!(flags & MAP_FIXED)) {
+		unsigned long (*get_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 
-	if (file && file->f_op && file->f_op->get_unmapped_area)
-		return file->f_op->get_unmapped_area(file, addr, len,
-						pgoff, flags);
+		get_area = current->mm->get_unmapped_area;
+		if (file && file->f_op && file->f_op->get_unmapped_area)
+			get_area = file->f_op->get_unmapped_area;
+		addr = get_area(file, addr, len, pgoff, flags);
+		if (IS_ERR_VALUE(addr))
+			return addr;
+	}
 
-	return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
+	if (addr > TASK_SIZE - len)
+		return -ENOMEM;
+	if (addr & ~PAGE_MASK)
+		return -EINVAL;
+	if (file && is_file_hugepages(file))  {
+		/*
+		 * Check if the given range is hugepage aligned, and
+		 * can be made suitable for hugepages.
+		 */
+		ret = prepare_hugepage_range(addr, len);
+	} else {
+		/*
+		 * Ensure that a normal request is not falling in a
+		 * reserved hugepage range.  For some archs like IA-64,
+		 * there is a separate region for hugepages.
+		 */
+		ret = is_hugepage_only_range(addr, len);
+	}
+	if (ret)
+		return -EINVAL;
+	return addr;
 }
 
 EXPORT_SYMBOL(get_unmapped_area);
