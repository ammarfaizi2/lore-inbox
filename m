Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVCFRw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVCFRw1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 12:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVCFRw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 12:52:27 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:18049 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261446AbVCFRv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 12:51:27 -0500
Message-ID: <422B5263.285A7928@tv-sign.ru>
Date: Sun, 06 Mar 2005 21:56:35 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/5] vmalloc: introduce __vmalloc_area() function
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 3 copy-and-paste implementations of __vmalloc() in
arch/{arm,sparc64,x86_64}/kernel/module.c.

I believe the only reason is that __vmalloc() doesn't allow
to specify parameters of __get_vm_area().

This patch splits __vmalloc() into 2 functions. The new one,
__vmalloc_area(), can be used as follows:

	vm_struct *area = __get_vm_area(...);
	void *addr = __vmalloc_area(area, gfp, prot);

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11/include/linux/0_vmalloc.h	2005-01-12 15:07:10.000000000 +0300
+++ 2.6.11/include/linux/vmalloc.h	2005-03-06 19:39:05.000000000 +0300
@@ -27,6 +27,7 @@ extern void *vmalloc(unsigned long size)
 extern void *vmalloc_exec(unsigned long size);
 extern void *vmalloc_32(unsigned long size);
 extern void *__vmalloc(unsigned long size, int gfp_mask, pgprot_t prot);
+extern void *__vmalloc_area(struct vm_struct *area, int gfp_mask, pgprot_t prot);
 extern void vfree(void *addr);
 
 extern void *vmap(struct page **pages, unsigned int count,
--- 2.6.11/mm/0_vmalloc.c	2005-02-24 22:15:03.000000000 +0300
+++ 2.6.11/mm/vmalloc.c	2005-03-06 20:31:01.000000000 +0300
@@ -456,32 +456,12 @@ void *vmap(struct page **pages, unsigned
 
 EXPORT_SYMBOL(vmap);
 
-/**
- *	__vmalloc  -  allocate virtually contiguous memory
- *
- *	@size:		allocation size
- *	@gfp_mask:	flags for the page level allocator
- *	@prot:		protection mask for the allocated pages
- *
- *	Allocate enough pages to cover @size from the page level
- *	allocator with @gfp_mask flags.  Map them into contiguous
- *	kernel virtual space, using a pagetable protection of @prot.
- */
-void *__vmalloc(unsigned long size, int gfp_mask, pgprot_t prot)
+void *__vmalloc_area(struct vm_struct *area, int gfp_mask, pgprot_t prot)
 {
-	struct vm_struct *area;
 	struct page **pages;
 	unsigned int nr_pages, array_size, i;
 
-	size = PAGE_ALIGN(size);
-	if (!size || (size >> PAGE_SHIFT) > num_physpages)
-		return NULL;
-
-	area = get_vm_area(size, VM_ALLOC);
-	if (!area)
-		return NULL;
-
-	nr_pages = size >> PAGE_SHIFT;
+	nr_pages = (area->size - PAGE_SIZE) >> PAGE_SHIFT;
 	array_size = (nr_pages * sizeof(struct page *));
 
 	area->nr_pages = nr_pages;
@@ -506,7 +486,7 @@ void *__vmalloc(unsigned long size, int 
 			goto fail;
 		}
 	}
-	
+
 	if (map_vm_area(area, prot, &pages))
 		goto fail;
 	return area->addr;
@@ -516,6 +496,32 @@ fail:
 	return NULL;
 }
 
+/**
+ *	__vmalloc  -  allocate virtually contiguous memory
+ *
+ *	@size:		allocation size
+ *	@gfp_mask:	flags for the page level allocator
+ *	@prot:		protection mask for the allocated pages
+ *
+ *	Allocate enough pages to cover @size from the page level
+ *	allocator with @gfp_mask flags.  Map them into contiguous
+ *	kernel virtual space, using a pagetable protection of @prot.
+ */
+void *__vmalloc(unsigned long size, int gfp_mask, pgprot_t prot)
+{
+	struct vm_struct *area;
+
+	size = PAGE_ALIGN(size);
+	if (!size || (size >> PAGE_SHIFT) > num_physpages)
+		return NULL;
+
+	area = get_vm_area(size, VM_ALLOC);
+	if (!area)
+		return NULL;
+
+	return __vmalloc_area(area, gfp_mask, prot);
+}
+
 EXPORT_SYMBOL(__vmalloc);
 
 /**
