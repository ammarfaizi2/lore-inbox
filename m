Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265253AbUF1WGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUF1WGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUF1WGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:06:43 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:1458 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265253AbUF1WGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:06:16 -0400
Subject: [PATCH] fix page->count discrepancy for zero page
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>,
       "BRADLEY CHRISTIANSEN [imap]" <bradc1@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-cV4YYfqp3aExvEPFBNz3"
Message-Id: <1088460353.5471.406.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 28 Jun 2004 15:05:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cV4YYfqp3aExvEPFBNz3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

While writing some analysis tools for memory hot-remove, we came across
a single page which had a ->count that always increased, without bound. 
It ended up always being the zero page, and it was caused by a leaked
reference in some do_wp_page() code that ends up avoiding PG_reserved
pages.

Basically what happens is that page_cache_release()/put_page() ignore
PG_reserved pages, while page_cache_get()/get_page() go ahead and take
the reference.  So, each time there's a COW fault on the zero-page, you
get a leaked page->count increment.

It's pretty rare to have a COW fault on anything that's PG_reserved, in
fact, I can't think of anything else that this applies to other than the
zero page.

In any case, it the bug doesn't cause any real problems, but it is a bit
of an annoyance and is obviously incorrect.  We've been running with
this patch for about 3 months now, and haven't run into any problems
with it.

Attached patch is against 2.6.7 and applies to -mm3 properly.

-- Dave

--=-cV4YYfqp3aExvEPFBNz3
Content-Disposition: attachment; filename=patch-2.6.7-zpage
Content-Type: text/x-patch; name=patch-2.6.7-zpage; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -urp linux-2.6.7/mm/memory.c linux-2.6.7-zpage/mm/memory.c
--- linux-2.6.7/mm/memory.c	Tue Jun 15 22:19:22 2004
+++ linux-2.6.7-zpage/mm/memory.c	Thu Jun 24 12:08:42 2004
@@ -1064,7 +1064,8 @@ static int do_wp_page(struct mm_struct *
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
-	page_cache_get(old_page);
+	if (!PageReserved(old_page))
+		page_cache_get(old_page);
 	spin_unlock(&mm->page_table_lock);
 
 	if (unlikely(anon_vma_prepare(vma)))

--=-cV4YYfqp3aExvEPFBNz3--

