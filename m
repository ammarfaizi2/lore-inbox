Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbUKXOz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbUKXOz7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUKXOzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:55:02 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:16512 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262701AbUKXOxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 09:53:04 -0500
Subject: Suspend 2 merge: 28/51: Suspend memory pool hooks.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101297022.5805.302.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:59:32 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We save the image in two pages (LRU and the rest). In order to maintain
a consistent image, we satisfy all page allocations from our own memory
pool while saving the image and reloading the LRU. This allows us to
safely use high level routines which might allocate slab etc and not
free it again by the time we do our atomic copy. We simply save all of
the pages in the pool when making our atomic copy of the non-LRU pages,
without having to worry about exactly how they were or weren't used.

diff -ruN 815-add-suspend-memory-pool-hooks-old/mm/page_alloc.c 815-add-suspend-memory-pool-hooks-new/mm/page_alloc.c
--- 815-add-suspend-memory-pool-hooks-old/mm/page_alloc.c	2004-11-06 09:26:49.168250960 +1100
+++ 815-add-suspend-memory-pool-hooks-new/mm/page_alloc.c	2004-11-04 16:27:41.000000000 +1100
@@ -277,6 +277,11 @@
 
 	arch_free_page(page, order);
 
+	if (unlikely(test_suspend_state(SUSPEND_USE_MEMORY_POOL))) {
+		suspend2_free_pool_pages(page, order);
+		return;
+	}
+
 	mod_page_state(pgfree, 1 << order);
 	for (i = 0 ; i < (1 << order) ; ++i)
 		free_pages_check(__FUNCTION__, page + i);
@@ -507,6 +512,11 @@
 
 	arch_free_page(page, 0);
 
+	if (unlikely(test_suspend_state(SUSPEND_USE_MEMORY_POOL))) {
+		suspend2_free_pool_pages(page, 0);
+		return;
+	}
+
 	kernel_map_pages(page, 1, 0);
 	inc_page_state(pgfree);
 	if (PageAnon(page))
@@ -609,6 +619,20 @@
 	int do_retry;
 	int can_try_harder;
 
+	if (unlikely(test_suspend_state(SUSPEND_USE_MEMORY_POOL))) {
+		/*
+		 * When pool enabled, processes get allocations
+		 * from a special pool so the image size doesn't
+		 * vary (all the pages in the pool are saved, 
+		 * used or not).
+		 *
+		 * The only process that should be running is
+		 * suspend, so the demand should be very
+		 * predicatable.
+		 */
+		return suspend2_get_pool_pages(gfp_mask, order);
+	}
+
 	might_sleep_if(wait);
 
 	/*


