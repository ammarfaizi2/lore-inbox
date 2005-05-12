Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVELVql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVELVql (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVELVpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:45:21 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18697 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262143AbVELVm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:42:59 -0400
Date: Thu, 12 May 2005 23:42:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       Martin Bligh <mbligh@aracnet.com>
Subject: [-mm patch] mm.h: fix page_zone compile error
Message-ID: <20050512214258.GC3603@stusta.de>
References: <20050512033100.017958f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512033100.017958f6.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc3-mm3:
>...
> +sparsemem-memory-model.patch
>...
>  More sparsemem stuff
>...


This causes the following compile error with gcc 3.4 on i386:

<--  snip  -->

...
  CC      mm/hugetlb.o
mm/hugetlb.c: In function `enqueue_huge_page':
include/linux/mm.h:500: sorry, unimplemented: inlining failed in call to 
'page_zone': function not considered for inlining
mm/hugetlb.c:486: sorry, unimplemented: called from here
make[1]: *** [mm/hugetlb.o] Error 1
make: *** [mm] Error 2

<--  snip  -->


This patch fixes this compile error.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/mm.h |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.12-rc4-mm1-full/include/linux/mm.h.old	2005-05-12 22:54:04.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/include/linux/mm.h	2005-05-12 22:54:38.000000000 +0200
@@ -480,7 +480,16 @@
 {
 	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
 }
-static inline struct zone *page_zone(struct page *page);
+
+struct zone;
+extern struct zone *zone_table[];
+
+static inline struct zone *page_zone(struct page *page)
+{
+	return zone_table[(page->flags >> ZONETABLE_PGSHIFT) &
+			ZONETABLE_MASK];
+}
+
 static inline unsigned long page_to_nid(struct page *page)
 {
 	if (FLAGS_HAS_NODE)
@@ -493,15 +502,6 @@
 	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
 }
 
-struct zone;
-extern struct zone *zone_table[];
-
-static inline struct zone *page_zone(struct page *page)
-{
-	return zone_table[(page->flags >> ZONETABLE_PGSHIFT) &
-			ZONETABLE_MASK];
-}
-
 static inline void set_page_zone(struct page *page, unsigned long zone)
 {
 	page->flags &= ~(ZONES_MASK << ZONES_PGSHIFT);

