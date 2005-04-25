Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVDYK2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVDYK2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 06:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVDYK2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 06:28:48 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:55005 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262575AbVDYK2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 06:28:41 -0400
Message-ID: <426CC767.8050507@jp.fujitsu.com>
Date: Mon, 25 Apr 2005 19:33:11 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH] counting bounce pages.
Content-Type: multipart/mixed;
 boundary="------------060305030108020806060805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060305030108020806060805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

This is a patch for counting bounce pages.
With this, pages for bounce buffer is coutned and shown in /proc/meminfo.

Because pages for bounce buffer are not counted in anywhere,
sometimes it seems that there are many leaked pages.
ex)
I found 1.7GB of bounce buffer pages in a crash dump of ia64 kernel,
which was passed me to check memory usage. :(

BTW, I'm not sure whether # of bounce buffer should be includeded in Buffers:
of /proc/meminfo.


-- Kame <kamezawa.hiroyu@jp.fujitsu.com>


--------------060305030108020806060805
Content-Type: text/plain;
 name="count_bounce.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="count_bounce.patch"


count the number of bounce pages.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



---

 linux-2.6.12-rc2-mm3-kamezawa/fs/proc/proc_misc.c |    7 +++++--
 linux-2.6.12-rc2-mm3-kamezawa/mm/highmem.c        |    3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff -puN mm/highmem.c~count_bounce mm/highmem.c
--- linux-2.6.12-rc2-mm3/mm/highmem.c~count_bounce	2005-04-25 12:04:28.000000000 +0900
+++ linux-2.6.12-rc2-mm3-kamezawa/mm/highmem.c	2005-04-25 16:10:52.000000000 +0900
@@ -214,6 +214,7 @@ void fastcall kunmap_high(struct page *p
 EXPORT_SYMBOL(kunmap_high);
 
 #define POOL_SIZE	64
+atomic_t nr_bounce_pages = ATOMIC_INIT(0);
 
 static __init int init_emergency_pool(void)
 {
@@ -325,6 +326,7 @@ static void bounce_end_io(struct bio *bi
 			continue;
 
 		mempool_free(bvec->bv_page, pool);	
+		atomic_dec(&nr_bounce_pages);
 	}
 
 	bio_endio(bio_orig, bio_orig->bi_size, err);
@@ -405,6 +407,7 @@ static void __blk_queue_bounce(request_q
 		to->bv_page = mempool_alloc(pool, q->bounce_gfp);
 		to->bv_len = from->bv_len;
 		to->bv_offset = from->bv_offset;
+		atomic_inc(&nr_bounce_pages);
 
 		if (rw == WRITE) {
 			char *vto, *vfrom;
diff -puN fs/proc/proc_misc.c~count_bounce fs/proc/proc_misc.c
--- linux-2.6.12-rc2-mm3/fs/proc/proc_misc.c~count_bounce	2005-04-25 12:08:28.000000000 +0900
+++ linux-2.6.12-rc2-mm3-kamezawa/fs/proc/proc_misc.c	2005-04-25 16:06:39.000000000 +0900
@@ -114,7 +114,7 @@ static int uptime_read_proc(char *page, 
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
-
+extern atomic_t nr_bounce_pages;
 static int meminfo_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -128,6 +128,7 @@ static int meminfo_read_proc(char *page,
 	unsigned long allowed;
 	struct vmalloc_info vmi;
 	long cached;
+	unsigned long bounce;
 
 	get_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
@@ -147,7 +148,7 @@ static int meminfo_read_proc(char *page,
 		cached = 0;
 
 	get_vmalloc_info(&vmi);
-
+	bounce = atomic_read(&nr_bounce_pages);
 	/*
 	 * Tagged format, for easy grepping and expansion.
 	 */
@@ -169,6 +170,7 @@ static int meminfo_read_proc(char *page,
 		"Writeback:    %8lu kB\n"
 		"Mapped:       %8lu kB\n"
 		"Slab:         %8lu kB\n"
+		"Bounce :      %8lu kB\n"
 		"CommitLimit:  %8lu kB\n"
 		"Committed_AS: %8lu kB\n"
 		"PageTables:   %8lu kB\n"
@@ -192,6 +194,7 @@ static int meminfo_read_proc(char *page,
 		K(ps.nr_writeback),
 		K(ps.nr_mapped),
 		K(ps.nr_slab),
+		K(bounce),
 		K(allowed),
 		K(committed),
 		K(ps.nr_page_table_pages),

_

--------------060305030108020806060805--

