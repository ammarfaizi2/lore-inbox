Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVCOTa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVCOTa5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVCOTa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:30:56 -0500
Received: from mailfe03.swip.net ([212.247.154.65]:53959 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261793AbVCOT0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:26:15 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: [PATCH] add gfp_mask to page owner
From: Alexander Nyberg <alexn@dsv.su.se>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 15 Mar 2005 21:25:23 +0100
Message-Id: <1110918323.1210.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

After looking at the recent memory leak thread I think it might have
helped having the gfp mask of the allocated pages. This makes that
available, no changes needed for the user-space sorter, same trace with
different gfp masks will be in separate chunks.

Output looks like:

4819 times:
Page allocated via order 0, mask 0x50
[0xc012b7b9] find_lock_page+25
[0xc012b8c8] find_or_create_page+152
[0xc0147d74] grow_dev_page+36
[0xc0148164] __find_get_block+84
[0xc0147ebc] __getblk_slow+124
[0xc0148164] __find_get_block+84
[0xc01481e7] __getblk+55
[0xc0185d14] do_readahead+100


If you think it might be a good idea then here it is.


Index: linux-2.6.11/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.11.orig/fs/proc/proc_misc.c	2005-03-15 21:13:43.000000000 +0100
+++ linux-2.6.11/fs/proc/proc_misc.c	2005-03-15 21:17:20.000000000 +0100
@@ -571,7 +571,8 @@
 	if (!kbuf)
 		return -ENOMEM;
 
-	ret = snprintf(kbuf, 1024, "Page allocated via order %d\n", page->order);
+	ret = snprintf(kbuf, 1024, "Page allocated via order %d, mask 0x%x\n",
+			page->order, page->gfp_mask);
 
 	for (i = 0; i < 8; i++) {
 		if (!page->trace[i])
Index: linux-2.6.11/mm/page_alloc.c
===================================================================
--- linux-2.6.11.orig/mm/page_alloc.c	2005-03-15 21:13:43.000000000 +0100
+++ linux-2.6.11/mm/page_alloc.c	2005-03-15 21:14:32.000000000 +0100
@@ -1050,6 +1050,7 @@
 	asm ("movl %%ebp, %0" : "=r" (bp) : );
 #endif
 	page->order = (int) order;
+	page->gfp_mask = gfp_mask;
 	__stack_trace(page, &address, bp);
 	}
 #endif /* CONFIG_PAGE_OWNER */
Index: linux-2.6.11/include/linux/mm.h
===================================================================
--- linux-2.6.11.orig/include/linux/mm.h	2005-03-15 21:13:43.000000000 +0100
+++ linux-2.6.11/include/linux/mm.h	2005-03-15 21:14:32.000000000 +0100
@@ -266,6 +266,7 @@
 #endif /* WANT_PAGE_VIRTUAL */
 #ifdef CONFIG_PAGE_OWNER
 	int order;
+	unsigned int gfp_mask;
 	unsigned long trace[8];
 #endif
 };




