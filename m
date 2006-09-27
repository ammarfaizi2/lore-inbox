Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030725AbWI0TwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030725AbWI0TwI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030728AbWI0TwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:52:08 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21985 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030725AbWI0TwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:52:04 -0400
Date: Wed, 27 Sep 2006 14:51:56 -0500
From: Dean Nelson <dcn@sgi.com>
To: Steve Wise <swise@opengridcomputing.com>
Cc: jes@trained-monkey.org, avolkov@varma-el.com, rdunlap@xenotime.net,
       linux-kernel@vger.kernel.org, dcn@sgi.com
Subject: Re: [PATCH 2.6.18 ] LIB Add gen_pool_destroy().
Message-ID: <20060927195156.GA3283@sgi.com>
References: <20060927153545.28235.76214.stgit@dell3.ogc.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927153545.28235.76214.stgit@dell3.ogc.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modules using the genpool allocator need to be able to destroy the data
structure when unloading.

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Dean Nelson <dcn@sgi.com>

---

Hi Steve,

I agree that the ability to destroy the allocated structures is
necessary. Thanks for doing the work. I do think it appropriate
to ensure that there are no outstanding allocations (to avoid use
after free issues) and have added that check in this new patch.
This patch has not been tested, though it does compile. I don't
have the time today. I hope you don't mind testing it? :-)

It also looks like I need to straighten out the kernel-doc
aspects of this file. I'll tackle that as a separate patch.

Thanks,
Dean


 include/linux/genalloc.h |    1 +
 lib/genalloc.c           |   29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)


Index: linux-2.6/lib/genalloc.c
===================================================================
--- linux-2.6.orig/lib/genalloc.c	2006-09-27 13:42:35.000000000 -0500
+++ linux-2.6/lib/genalloc.c	2006-09-27 14:31:56.816523882 -0500
@@ -71,6 +71,35 @@
 
 
 /*
+ * Destroy a memory pool.
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
