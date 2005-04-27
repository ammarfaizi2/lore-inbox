Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVD0GiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVD0GiC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 02:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVD0GiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 02:38:02 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:24776 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261702AbVD0GhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 02:37:15 -0400
Message-ID: <426F3445.9060701@jp.fujitsu.com>
Date: Wed, 27 Apr 2005 15:42:13 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] counting bounce buffer in vmstat
Content-Type: multipart/mixed;
 boundary="------------090102000300040902030602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090102000300040902030602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This is a updated version of a patch for counting bouce buffer page.
A major change is :
/proc/vmstat is used to show usage.

Thanks
-- Kame

--------------090102000300040902030602
Content-Type: text/plain;
 name="count_bounce.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="count_bounce.patch"


This is a patch for counting the number of pages for bounce buffer.
It's shown in /proc/vmstat.

Currently, the number of bounce pages are not counted anywhere.
So, if there are many bounce pages, it seems that there are
leaked pages. And it's difficult for a user to imagine the usage of
bounce pages. So, it's meaningful to show # of bouce pages.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



---

 linux-2.6.12-rc2-mm3-kamezawa/include/linux/page-flags.h |    1 +
 linux-2.6.12-rc2-mm3-kamezawa/mm/highmem.c               |    2 ++
 linux-2.6.12-rc2-mm3-kamezawa/mm/page_alloc.c            |    1 +
 3 files changed, 4 insertions(+)

diff -puN mm/highmem.c~count_bounce mm/highmem.c
--- linux-2.6.12-rc2-mm3/mm/highmem.c~count_bounce	2005-04-25 12:04:28.000000000 +0900
+++ linux-2.6.12-rc2-mm3-kamezawa/mm/highmem.c	2005-04-27 10:25:51.000000000 +0900
@@ -325,6 +325,7 @@ static void bounce_end_io(struct bio *bi
 			continue;
 
 		mempool_free(bvec->bv_page, pool);	
+		dec_page_state(nr_bounce);
 	}
 
 	bio_endio(bio_orig, bio_orig->bi_size, err);
@@ -405,6 +406,7 @@ static void __blk_queue_bounce(request_q
 		to->bv_page = mempool_alloc(pool, q->bounce_gfp);
 		to->bv_len = from->bv_len;
 		to->bv_offset = from->bv_offset;
+		inc_page_state(nr_bounce);
 
 		if (rw == WRITE) {
 			char *vto, *vfrom;
diff -puN mm/page_alloc.c~count_bounce mm/page_alloc.c
--- linux-2.6.12-rc2-mm3/mm/page_alloc.c~count_bounce	2005-04-27 10:15:39.000000000 +0900
+++ linux-2.6.12-rc2-mm3-kamezawa/mm/page_alloc.c	2005-04-27 10:17:18.000000000 +0900
@@ -1902,6 +1902,7 @@ static char *vmstat_text[] = {
 	"nr_page_table_pages",
 	"nr_mapped",
 	"nr_slab",
+	"nr_bounce",
 
 	"pgpgin",
 	"pgpgout",
diff -puN include/linux/page-flags.h~count_bounce include/linux/page-flags.h
--- linux-2.6.12-rc2-mm3/include/linux/page-flags.h~count_bounce	2005-04-27 10:23:15.000000000 +0900
+++ linux-2.6.12-rc2-mm3-kamezawa/include/linux/page-flags.h	2005-04-27 10:24:11.000000000 +0900
@@ -89,6 +89,7 @@ struct page_state {
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
 	unsigned long nr_mapped;	/* mapped into pagetables */
 	unsigned long nr_slab;		/* In slab */
+	unsigned long nr_bounce;	/* pages for bounce buffers */
 #define GET_PAGE_STATE_LAST nr_slab
 
 	/*

_

--------------090102000300040902030602--

