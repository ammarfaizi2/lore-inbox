Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVAIP4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVAIP4J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 10:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVAIP4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 10:56:09 -0500
Received: from fsmlabs.com ([168.103.115.128]:32412 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261480AbVAIP4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 10:56:01 -0500
Date: Sun, 9 Jan 2005 08:56:11 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Chris Wright <chrisw@osdl.org>, clameter@sgi.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fixes for prep_zero_page
In-Reply-To: <20050109014519.412688f6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501090812220.13639@montezuma.fsmlabs.com>
References: <20050108010629.M469@build.pdx.osdl.net> <20050109014519.412688f6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2005, Andrew Morton wrote:

> Well it's doing clear_highpage() before __alloc_pages() has called
> kernel_map_pages(), so CONFIG_DEBUG_PAGEALLOC is quite kaput.
> 
> So the current __GFP_ZERO buglist is:
> 
> 1: Breaks CONFIG_DEBUG_PAGEALLOC
> 
> 2: Breaks the cache aliasing protection for anonymous pages
> 
> 3: prep_zero_page() uses KM_USER0 so __GFP_ZERO from IRQ context will
>    cause rare memory corruption.

The following should take care of 1 and 3. I opted to unmap the pages 
again after the clear page so that it remains isolated and we don't have 
to make additional checks to see if we should unmap the pages.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.10-mm2/include/linux/highmem.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm2/include/linux/highmem.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 highmem.h
--- linux-2.6.10-mm2/include/linux/highmem.h	9 Jan 2005 04:51:52 -0000	1.1.1.1
+++ linux-2.6.10-mm2/include/linux/highmem.h	9 Jan 2005 15:32:17 -0000
@@ -50,6 +50,18 @@ static inline void clear_highpage(struct
 	kunmap_atomic(kaddr, KM_USER0);
 }
 
+static inline void clear_irq_highpage(struct page *page)
+{
+	char *kaddr;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	kaddr = kmap_atomic(page, KM_IRQ0);
+	clear_page(kaddr);
+	kunmap_atomic(kaddr, KM_IRQ0);
+	local_irq_restore(flags);
+}
+
 /*
  * Same but also flushes aliased cache contents to RAM.
  */
Index: linux-2.6.10-mm2/mm/page_alloc.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm2/mm/page_alloc.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 page_alloc.c
--- linux-2.6.10-mm2/mm/page_alloc.c	9 Jan 2005 04:52:40 -0000	1.1.1.1
+++ linux-2.6.10-mm2/mm/page_alloc.c	9 Jan 2005 15:46:00 -0000
@@ -691,10 +691,17 @@ perthread_pages_alloc(void)
  */
 static inline void prep_zero_page(struct page *page, int order)
 {
-	int i;
+	int i, nr_pages = (1 << order);
+	int context = in_interrupt();
 
-	for(i = 0; i < (1 << order); i++)
-		clear_highpage(page + i);
+	kernel_map_pages(page, nr_pages, 1);
+	for(i = 0; i < nr_pages; i++) {
+		if (likely(!context))
+			clear_highpage(page + i);
+		else
+			clear_irq_highpage(page + i);
+	}
+	kernel_map_pages(page, nr_pages, 0);
 }
 
 static struct page *
