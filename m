Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVAYBBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVAYBBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVAYBBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 20:01:04 -0500
Received: from quark.didntduck.org ([69.55.226.66]:20651 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261755AbVAYA7L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:59:11 -0500
Message-ID: <41F5999B.3060608@didntduck.org>
Date: Mon, 24 Jan 2005 19:58:03 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Andrew Morton <akpm@zip.com.au>, linux-mm@kvack.org,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Subject: [PATCH] Remove special case in kmem_getpages()
References: <20050124165412.GL31455@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050124165412.GL31455@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/mixed;
 boundary="------------020305060806080603090303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020305060806080603090303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Matthew Wilcox wrote:
> __get_free_pages() calls alloc_pages, finds the page_address() and
> throws away the struct page *.  Slab then calls virt_to_page to get it
> back again.  Much more efficient for slab to call alloc_pages itself,
> as well as making the NUMA and non-NUMA cases more similarr to each other.

Here is a better patch:

Remove the special case of nodeid == -1.  Instead, use numa_node_id() 
when calling cache_grow().

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

--------------020305060806080603090303
Content-Type: text/plain;
 name="slab-numa"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slab-numa"

diff -urN linux-2.6.11-rc2-bk/mm/slab.c linux/mm/slab.c
--- linux-2.6.11-rc2-bk/mm/slab.c	2005-01-22 01:58:25.000000000 -0500
+++ linux/mm/slab.c	2005-01-24 15:35:08.000000000 -0500
@@ -893,17 +893,11 @@
 	int i;
 
 	flags |= cachep->gfpflags;
-	if (likely(nodeid == -1)) {
-		addr = (void*)__get_free_pages(flags, cachep->gfporder);
-		if (!addr)
-			return NULL;
-		page = virt_to_page(addr);
-	} else {
-		page = alloc_pages_node(nodeid, flags, cachep->gfporder);
-		if (!page)
-			return NULL;
-		addr = page_address(page);
-	}
+
+	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+	if (!page)
+		return NULL;
+	addr = page_address(page);
 
 	i = (1 << cachep->gfporder);
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
@@ -2065,7 +2059,7 @@
 
 	if (unlikely(!ac->avail)) {
 		int x;
-		x = cache_grow(cachep, flags, -1);
+		x = cache_grow(cachep, flags, numa_node_id());
 		
 		// cache_grow can reenable interrupts, then ac could change.
 		ac = ac_data(cachep);

--------------020305060806080603090303--
