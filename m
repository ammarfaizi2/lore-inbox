Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751884AbWJWKkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbWJWKkM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 06:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWJWKkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 06:40:12 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:19654 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751884AbWJWKkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 06:40:10 -0400
Date: Mon, 23 Oct 2006 19:39:33 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch](memory hotplug) __GFP_NOWARN is better for __kmalloc_section_memmap()
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20061023192830.DDB2.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.27 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This patch adds __GFP_NOWARN flag to calling of __alloc_pages()
in __kmalloc_section_memmap(). It can reduce noisy failure message.

In ia64, section size is 1 GB, this means that order 8 pages are necessary
for each section's memmap. It is often very hard requirement under
heavy memory pressure as you know. So, __alloc_pages() gives up allocation
and shows many noisy stack traces which means no page for each sections.
(Current my environment shows 32 times of stack trace....)

But, __kmalloc_section_memmap() calls vmalloc() after failure of
it, and it can succeed allocation of memmap. So, its stack trace
warning becomes just noisy. I suppose it shouldn't be shown.

This patch is for 2.6.19-rc2. And I tested this patch on PrimeQuest
with high memory pressure environment.

Please apply.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
---
 mm/sparse.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

---

Index: disable_fail_message/mm/sparse.c
===================================================================
--- disable_fail_message.orig/mm/sparse.c	2006-10-17 15:05:26.000000000 +0900
+++ disable_fail_message/mm/sparse.c	2006-10-23 17:11:26.000000000 +0900
@@ -211,7 +211,7 @@ static struct page *__kmalloc_section_me
 	struct page *page, *ret;
 	unsigned long memmap_size = sizeof(struct page) * nr_pages;
 
-	page = alloc_pages(GFP_KERNEL, get_order(memmap_size));
+	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
 	if (page)
 		goto got_map_page;
 

-- 
Yasunori Goto 


