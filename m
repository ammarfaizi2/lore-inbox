Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWI0Pfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWI0Pfq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 11:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWI0Pfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 11:35:46 -0400
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:5263 "EHLO
	dell3.ogc.int") by vger.kernel.org with ESMTP id S964950AbWI0Pfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 11:35:46 -0400
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 2.6.18 ] LIB Add gen_pool_destroy().
Date: Wed, 27 Sep 2006 10:35:45 -0500
To: linux-kernel@vger.kernel.org
Cc: dcn@sgi.com, jes@trained-monkey.org, avolkov@varma-el.com
Message-Id: <20060927153545.28235.76214.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Modules using the genpool allocator need to be able to destroy the data
structure when unloading.

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
---

 include/linux/genalloc.h |    1 +
 lib/genalloc.c           |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 690c428..ca2b119 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -30,6 +30,7 @@ struct gen_pool_chunk {
 };
 
 extern struct gen_pool *gen_pool_create(int, int);
+extern void gen_pool_destroy(struct gen_pool *);
 extern int gen_pool_add(struct gen_pool *, unsigned long, size_t, int);
 extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
 extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 71338b4..c8afa10 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -36,6 +36,28 @@ EXPORT_SYMBOL(gen_pool_create);
 
 
 /*
+ * Destroy a memory pool.  Assumes the user deals with releasing the
+ * actual memory managed by the pool.  
+ *
+ * @pool: pool to destroy.
+ *
+ */
+void gen_pool_destroy(struct gen_pool *pool)
+{
+	struct list_head *_chunk, *next;
+	struct gen_pool_chunk *chunk;
+
+	list_for_each_safe(_chunk, next, &pool->chunks) {
+		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
+		kfree(chunk);
+	}
+	kfree(pool);
+	return;
+}
+EXPORT_SYMBOL(gen_pool_destroy);
+
+
+/*
  * Add a new chunk of memory to the specified pool.
  *
  * @pool: pool to add new memory chunk to
