Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbTDOEGd (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 00:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264133AbTDOEGd (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 00:06:33 -0400
Received: from holomorphy.com ([66.224.33.161]:47236 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264120AbTDOEGb (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 00:06:31 -0400
Date: Mon, 14 Apr 2003 21:17:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.67-mm3
Message-ID: <20030415041759.GA12487@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030414015313.4f6333ad.akpm@digeo.com> <20030415020057.GC706@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030415020057.GC706@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 07:00:57PM -0700, William Lee Irwin III wrote:
> Hence, this "FIXME: do not do for zone highmem". Presumably this is a

Another FIXME patch:


It's a bit of an open question as to how much of a difference this one
makes now, but it says "FIXME". fault_in_pages_writeable() and 
fault_in_pages_readable() have a limited "range" with respect to the
size of the region they can prefault; as they are now, they are only
meant to handle spanning a page boundary. This converts them to iterate
over the virtual address range specified and so touch each virtual page
within it once as specified. As per the comment within the "FIXME",
this is only an issue if PAGE_SIZE < PAGE_CACHE_SIZE.


diff -urpN mm3-2.5.67-3/include/linux/pagemap.h mm3-2.5.67-4/include/linux/pagemap.h
--- mm3-2.5.67-3/include/linux/pagemap.h	2003-04-07 10:30:34.000000000 -0700
+++ mm3-2.5.67-4/include/linux/pagemap.h	2003-04-14 19:10:17.000000000 -0700
@@ -168,46 +168,32 @@ extern void end_page_writeback(struct pa
 
 /*
  * Fault a userspace page into pagetables.  Return non-zero on a fault.
- *
- * FIXME: this assumes that two userspace pages are always sufficient.  That's
- * not true if PAGE_CACHE_SIZE > PAGE_SIZE.
+ * Both walk with stride PAGE_SIZE touching the start of the affected
+ * pages until faulting or at the start of a page beyond size from uaddr.
  */
 static inline int fault_in_pages_writeable(char *uaddr, int size)
 {
-	int ret;
+	int ret = 0;
+	unsigned long addr = (unsigned long)uaddr & PAGE_MASK;
 
 	/*
 	 * Writing zeroes into userspace here is OK, because we know that if
 	 * the zero gets there, we'll be overwriting it.
 	 */
-	ret = __put_user(0, uaddr);
-	if (ret == 0) {
-		char *end = uaddr + size - 1;
-
-		/*
-		 * If the page was already mapped, this will get a cache miss
-		 * for sure, so try to avoid doing it.
-		 */
-		if (((unsigned long)uaddr & PAGE_MASK) !=
-				((unsigned long)end & PAGE_MASK))
-		 	ret = __put_user(0, end);
-	}
+	for (; addr < (unsigned long)uaddr + size && !ret; addr += PAGE_SIZE)
+		ret = __put_user(0, (char *)max(addr, (unsigned long)uaddr));
+
 	return ret;
 }
 
 static inline void fault_in_pages_readable(const char *uaddr, int size)
 {
 	volatile char c;
-	int ret;
+	int ret = 0;
+	unsigned long addr = (unsigned long)uaddr & PAGE_MASK;
 
-	ret = __get_user(c, (char *)uaddr);
-	if (ret == 0) {
-		const char *end = uaddr + size - 1;
-
-		if (((unsigned long)uaddr & PAGE_MASK) !=
-				((unsigned long)end & PAGE_MASK))
-		 	__get_user(c, (char *)end);
-	}
+	for (; addr < (unsigned long)uaddr + size && !ret; addr += PAGE_SIZE)
+		ret = __get_user(c, (char *)addr);
 }
 
 #endif /* _LINUX_PAGEMAP_H */
