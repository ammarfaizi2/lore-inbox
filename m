Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267810AbTBVA37>; Fri, 21 Feb 2003 19:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267811AbTBVA37>; Fri, 21 Feb 2003 19:29:59 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:49386 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267810AbTBVA35>;
	Fri, 21 Feb 2003 19:29:57 -0500
Message-ID: <3E56C4FA.8010400@us.ibm.com>
Date: Fri, 21 Feb 2003 16:31:54 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Martin Bligh <mjbligh@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: [rfc][patch] clean up redundant code for alloc_pages
Content-Type: multipart/mixed;
 boundary="------------020000030803070307010401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020000030803070307010401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Well, alloc_pages() and alloc_pages_node() look *REAAALY* similar.  This 
is a really small patch to just shrink alloc_pages_node() a bit and 
point alloc_page() and alloc_pages() at alloc_pages_node() with the 
appropriate arguments.

It is a pretty trivial change, just curious if there are any violent 
objections to such a change.

[mcd@arrakis push]$ diffstat alloc_pages_cleanup-2.5.62.patch
  gfp.h |   18 +++++-------------
  1 files changed, 5 insertions(+), 13 deletions(-)

Cheers!

-Matt

--------------020000030803070307010401
Content-Type: text/plain;
 name="alloc_pages_cleanup-2.5.62.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alloc_pages_cleanup-2.5.62.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.62-vanilla/include/linux/gfp.h linux-2.5.62-alloc_pages/include/linux/gfp.h
--- linux-2.5.62-vanilla/include/linux/gfp.h	Mon Feb 17 14:56:09 2003
+++ linux-2.5.62-alloc_pages/include/linux/gfp.h	Fri Feb 21 16:15:59 2003
@@ -49,24 +49,16 @@
 extern struct page * FASTCALL(__alloc_pages(unsigned int, unsigned int, struct zonelist *));
 static inline struct page * alloc_pages_node(int nid, unsigned int gfp_mask, unsigned int order)
 {
-	struct pglist_data *pgdat = NODE_DATA(nid);
-	unsigned int idx = (gfp_mask & GFP_ZONEMASK);
-
 	if (unlikely(order >= MAX_ORDER))
 		return NULL;
-	return __alloc_pages(gfp_mask, order, pgdat->node_zonelists + idx);
-}
-static inline struct page * alloc_pages(unsigned int gfp_mask, unsigned int order)
-{
-	struct pglist_data *pgdat = NODE_DATA(numa_node_id());
-	unsigned int idx = (gfp_mask & GFP_ZONEMASK);
 
-	if (unlikely(order >= MAX_ORDER))
-		return NULL;
-	return __alloc_pages(gfp_mask, order, pgdat->node_zonelists + idx);
+	return __alloc_pages(gfp_mask, order, NODE_DATA(nid)->node_zonelists + (gfp_mask & GFP_ZONEMASK));
 }
 
-#define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
+#define alloc_pages(gfp_mask, order) \
+		alloc_pages_node(numa_node_id(), gfp_mask, order)
+#define alloc_page(gfp_mask) \
+		alloc_pages_node(numa_node_id(), gfp_mask, 0)
 
 extern unsigned long FASTCALL(__get_free_pages(unsigned int gfp_mask, unsigned int order));
 extern unsigned long FASTCALL(get_zeroed_page(unsigned int gfp_mask));

--------------020000030803070307010401--

