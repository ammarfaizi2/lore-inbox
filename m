Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVCFRwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVCFRwx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 12:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVCFRwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 12:52:53 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:21377 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261448AbVCFRvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 12:51:35 -0500
Message-ID: <422B5266.F70CFD84@tv-sign.ru>
Date: Sun, 06 Mar 2005 21:56:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/5] vmalloc: use __vmalloc_area in arch/arm
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded __vmalloc() with __vmalloc_area().

Uncompiled, untested.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11/arch/arm/kernel/module.c~	2005-03-06 18:21:21.000000000 +0300
+++ 2.6.11/arch/arm/kernel/module.c	2005-03-06 20:14:40.000000000 +0300
@@ -35,44 +35,16 @@ extern void _etext;
 void *module_alloc(unsigned long size)
 {
 	struct vm_struct *area;
-	struct page **pages;
-	unsigned int array_size, i;
 
 	size = PAGE_ALIGN(size);
 	if (!size)
-		goto out_null;
+		return NULL;
 
 	area = __get_vm_area(size, VM_ALLOC, MODULE_START, MODULE_END);
 	if (!area)
-		goto out_null;
+		return NULL;
 
-	area->nr_pages = size >> PAGE_SHIFT;
-	array_size = area->nr_pages * sizeof(struct page *);
-	area->pages = pages = kmalloc(array_size, GFP_KERNEL);
-	if (!area->pages) {
-		remove_vm_area(area->addr);
-		kfree(area);
-		goto out_null;
-	}
-
-	memset(pages, 0, array_size);
-
-	for (i = 0; i < area->nr_pages; i++) {
-		pages[i] = alloc_page(GFP_KERNEL);
-		if (unlikely(!pages[i])) {
-			area->nr_pages = i;
-			goto out_no_pages;
-		}
-	}
-
-	if (map_vm_area(area, PAGE_KERNEL, &pages))
-		goto out_no_pages;
-	return area->addr;
-
- out_no_pages:
-	vfree(area->addr);
- out_null:
-	return NULL;
+	return __vmalloc_area(area, GFP_KERNEL, PAGE_KERNEL);
 }
 
 void module_free(struct module *module, void *region)
