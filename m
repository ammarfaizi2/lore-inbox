Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVKFIVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVKFIVW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVKFIVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:21:22 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:34923 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932319AbVKFIVV (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:21:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=tErCqbe1SbvyZgP107XE4xqwDyjQsyFCiUa2LYlPh5CW1fYqyw0S6bAeTGGWb9JJOBRkeX5d4IJjQwniBGevWzDWjwuouakKRQ1CyoqBqLbVJIB3D6GhpnQZoJWbhRbYHu9MB4awsZGQznrw8rjKisbpf1SfqP8nH0SbbT4aOoE=  ;
Message-ID: <436DBD82.2070500@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:23:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 5/14] mm: set_page_refs opt
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au>
In-Reply-To: <436DBD31.8060801@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------050604050902040705010805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050604050902040705010805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

5/14

-- 
SUSE Labs, Novell Inc.


--------------050604050902040705010805
Content-Type: text/plain;
 name="mm-set_page_refs-opt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-set_page_refs-opt.patch"

Inline set_page_refs. Remove mm/internal.h

Index: linux-2.6/mm/bootmem.c
===================================================================
--- linux-2.6.orig/mm/bootmem.c
+++ linux-2.6/mm/bootmem.c
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <asm/dma.h>
 #include <asm/io.h>
-#include "internal.h"
 
 /*
  * Access to this subsystem has to be serialized externally. (this is
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -38,7 +38,6 @@
 #include <linux/vmalloc.h>
 
 #include <asm/tlbflush.h>
-#include "internal.h"
 
 /*
  * MCD - HACK: Find somewhere to initialize this EARLY, or make this
@@ -448,23 +447,6 @@ expand(struct zone *zone, struct page *p
 	return page;
 }
 
-void set_page_refs(struct page *page, int order)
-{
-#ifdef CONFIG_MMU
-	set_page_count(page, 1);
-#else
-	int i;
-
-	/*
-	 * We need to reference all the pages for this order, otherwise if
-	 * anyone accesses one of the pages with (get/put) it will be freed.
-	 * - eg: access_process_vm()
-	 */
-	for (i = 0; i < (1 << order); i++)
-		set_page_count(page + i, 1);
-#endif /* CONFIG_MMU */
-}
-
 /*
  * This page is about to be returned from the page allocator
  */
Index: linux-2.6/mm/internal.h
===================================================================
--- linux-2.6.orig/mm/internal.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* internal.h: mm/ internal definitions
- *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-/* page_alloc.c */
-extern void set_page_refs(struct page *page, int order);
Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -315,6 +315,23 @@ struct page {
 #define set_page_count(p,v) 	atomic_set(&(p)->_count, v - 1)
 #define __put_page(p)		atomic_dec(&(p)->_count)
 
+static inline void set_page_refs(struct page *page, int order)
+{
+#ifdef CONFIG_MMU
+	set_page_count(page, 1);
+#else
+	int i;
+
+	/*
+	 * We need to reference all the pages for this order, otherwise if
+	 * anyone accesses one of the pages with (get/put) it will be freed.
+	 * - eg: access_process_vm()
+	 */
+	for (i = 0; i < (1 << order); i++)
+		set_page_count(page + i, 1);
+#endif /* CONFIG_MMU */
+}
+
 extern void FASTCALL(__page_cache_release(struct page *));
 
 #ifdef CONFIG_HUGETLB_PAGE

--------------050604050902040705010805--
Send instant messages to your online friends http://au.messenger.yahoo.com 
