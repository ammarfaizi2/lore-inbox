Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWHMK2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWHMK2a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 06:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWHMK2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 06:28:30 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:62818 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750938AbWHMK2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 06:28:30 -0400
Date: Sun, 13 Aug 2006 18:28:25 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: okuji@enbug.org
Subject: Re: [PATCH] failslab - failmalloc for slab allocator
Message-ID: <20060813102825.GA8826@miraclelinux.com>
References: <20060813102219.GA8784@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813102219.GA8784@miraclelinux.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 06:22:19PM +0800, Akinobu Mita wrote:
> The idea behind failslab is to demonstrate what really happens if
> slab allocation fails. The idea of failslab is completely taken
> from failmalloc (http://www.nongnu.org/failmalloc/).

I have similar versions for vmalloc() and page_alloc().
But I couldn't find outstanding bugs.

boot options:

failvmalloc=<probability>,<interval>,<times>,<space>

fail_page_alloc=<probability>,<interval>,<times>,<space>

Index: work-failmalloc/mm/vmalloc.c
===================================================================
--- work-failmalloc.orig/mm/vmalloc.c
+++ work-failmalloc/mm/vmalloc.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 
 #include <linux/vmalloc.h>
+#include <linux/failmalloc.h>
 
 #include <asm/uaccess.h>
 #include <asm/tlbflush.h>
@@ -416,12 +417,28 @@ void *vmap(struct page **pages, unsigned
 }
 EXPORT_SYMBOL(vmap);
 
+#ifdef CONFIG_FAILMALLOC
+
+struct failmalloc_data failvmalloc;
+
+static int __init setup_failvmalloc(char *str)
+{
+	return setup_failmalloc(&failvmalloc, str);
+}
+
+__setup("failvmalloc=", setup_failvmalloc);
+
+#endif
+
 void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 				pgprot_t prot, int node)
 {
 	struct page **pages;
 	unsigned int nr_pages, array_size, i;
 
+	if (!(gfp_mask & __GFP_NOFAIL) && should_fail(&failvmalloc, area->size))
+		goto fail;
+
 	nr_pages = (area->size - PAGE_SIZE) >> PAGE_SHIFT;
 	array_size = (nr_pages * sizeof(struct page *));
 
Index: work-failmalloc/mm/page_alloc.c
===================================================================
--- work-failmalloc.orig/mm/page_alloc.c
+++ work-failmalloc/mm/page_alloc.c
@@ -37,6 +37,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mempolicy.h>
 #include <linux/stop_machine.h>
+#include <linux/failmalloc.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -903,6 +904,19 @@ get_page_from_freelist(gfp_t gfp_mask, u
 	return page;
 }
 
+#ifdef CONFIG_FAILMALLOC
+
+struct failmalloc_data fail_page_alloc;
+
+static int __init setup_fail_page_alloc(char *str)
+{
+	return setup_failmalloc(&fail_page_alloc, str);
+}
+
+__setup("fail_page_alloc=", setup_fail_page_alloc);
+
+#endif
+
 /*
  * This is the 'heart' of the zoned buddy allocator.
  */
@@ -921,6 +935,10 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 
 	might_sleep_if(wait);
 
+	if (!(gfp_mask & __GFP_NOFAIL) &&
+			should_fail(&fail_page_alloc, PAGE_SIZE << order))
+		return NULL;
+
 restart:
 	z = zonelist->zones;  /* the list of zones suitable for gfp_mask */
 
