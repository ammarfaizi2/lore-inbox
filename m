Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWI1NQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWI1NQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWI1NQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:16:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:24471 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750823AbWI1NQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:16:26 -0400
Date: Thu, 28 Sep 2006 08:16:14 -0500
From: Dean Nelson <dcn@sgi.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, swise@opengridcomputing.com,
       rdunlap@xenotime.net, jes@trained-monkey.org, avolkov@varma-el.com,
       dcn@sgi.com
Subject: [PATCH] add gen_pool_destroy()
Message-ID: <20060928131614.GA3232@sgi.com>
References: <20060927153545.28235.76214.stgit@dell3.ogc.int> <20060927195156.GA3283@sgi.com> <1159391380.10663.62.camel@stevo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159391380.10663.62.camel@stevo-desktop>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modules using the genpool allocator need to be able to kfree() the memory
used for the genpool data structures when unloading.

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Dean Nelson <dcn@sgi.com>

---

Hi Linus,

Would you please accept this patch against the genpool allocator?

There is still an issue with the block comments not being up to
kernel-doc standards that plagues the entire file, which I will
remedy in a followup patch.

Thanks,
Dean

 include/linux/genalloc.h |    1 +
 lib/genalloc.c           |   37 +++++++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)


Index: linux-2.6/lib/genalloc.c
===================================================================
--- linux-2.6.orig/lib/genalloc.c	2006-09-27 13:42:35.000000000 -0500
+++ linux-2.6/lib/genalloc.c	2006-09-28 07:49:05.948568928 -0500
@@ -71,6 +71,35 @@
 
 
 /*
+ * Destroy a memory pool. Verifies that there are no outstanding allocations.
+ *
+ * @pool: pool to destroy
+ */
+void gen_pool_destroy(struct gen_pool *pool)
+{
+	struct list_head *_chunk, *_next_chunk;
+	struct gen_pool_chunk *chunk;
+	int order = pool->min_alloc_order;
+	int bit, end_bit;
+
+
+	write_lock(&pool->lock);
+	list_for_each_safe(_chunk, _next_chunk, &pool->chunks) {
+		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
+
+		end_bit = (chunk->end_addr - chunk->start_addr) >> order;
+		bit = find_next_bit(chunk->bits, end_bit, 0);
+		BUG_ON(bit < end_bit);
+
+		kfree(chunk);
+	}
+	kfree(pool);
+	return;
+}
+EXPORT_SYMBOL(gen_pool_destroy);
+
+
+/*
  * Allocate the requested number of bytes from the specified pool.
  * Uses a first-fit algorithm.
  *
@@ -79,7 +108,7 @@
  */
 unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
 {
-	struct list_head *_chunk;
+	struct list_head *_chunk, *_next_chunk;
 	struct gen_pool_chunk *chunk;
 	unsigned long addr, flags;
 	int order = pool->min_alloc_order;
@@ -91,7 +120,7 @@
 	nbits = (size + (1UL << order) - 1) >> order;
 
 	read_lock(&pool->lock);
-	list_for_each(_chunk, &pool->chunks) {
+	list_for_each_safe(_chunk, _next_chunk, &pool->chunks) {
 		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
 
 		end_bit = (chunk->end_addr - chunk->start_addr) >> order;
@@ -137,7 +166,7 @@
  */
 void gen_pool_free(struct gen_pool *pool, unsigned long addr, size_t size)
 {
-	struct list_head *_chunk;
+	struct list_head *_chunk, *_next_chunk;
 	struct gen_pool_chunk *chunk;
 	unsigned long flags;
 	int order = pool->min_alloc_order;
@@ -146,7 +175,7 @@
 	nbits = (size + (1UL << order) - 1) >> order;
 
 	read_lock(&pool->lock);
-	list_for_each(_chunk, &pool->chunks) {
+	list_for_each_safe(_chunk, _next_chunk, &pool->chunks) {
 		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
 
 		if (addr >= chunk->start_addr && addr < chunk->end_addr) {
Index: linux-2.6/include/linux/genalloc.h
===================================================================
--- linux-2.6.orig/include/linux/genalloc.h	2006-09-27 13:42:34.000000000 -0500
+++ linux-2.6/include/linux/genalloc.h	2006-09-27 14:18:31.807816652 -0500
@@ -31,5 +31,6 @@
 
 extern struct gen_pool *gen_pool_create(int, int);
 extern int gen_pool_add(struct gen_pool *, unsigned long, size_t, int);
+extern void gen_pool_destroy(struct gen_pool *);
 extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
 extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
