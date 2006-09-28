Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWI1Psw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWI1Psw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWI1Psw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:48:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:35248 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964962AbWI1Psv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:48:51 -0400
Date: Thu, 28 Sep 2006 10:48:49 -0500
From: Dean Nelson <dcn@sgi.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, holt@sgi.com, swise@opengridcomputing.com,
       rdunlap@xenotime.net, jes@trained-monkey.org, avolkov@varma-el.com,
       dcn@sgi.com
Subject: Re: [PATCH] add gen_pool_destroy()
Message-ID: <20060928154849.GA10434@sgi.com>
References: <20060927153545.28235.76214.stgit@dell3.ogc.int> <20060927195156.GA3283@sgi.com> <1159391380.10663.62.camel@stevo-desktop> <20060928131614.GA3232@sgi.com> <20060928145142.GA6715@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928145142.GA6715@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modules using the genpool allocator need to be able to kfree() the memory
used for the genpool data structures when unloading.

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Dean Nelson <dcn@sgi.com>

---

On Thu, Sep 28, 2006 at 09:51:42AM -0500, Robin Holt wrote:
> Nack this.
> 
> Dean, you changed the list_for_each to list_for_each_safe where it was
> not needed.  I think you only needed to change that in the remove path.
> IIRC, list_for_each_safe is intended for walking a list where you unlink
> the entry as part of your operation.  Keep it for the gen_pool_destroy
> function since you are using kfree on those objects and somebody else
> could reuse them (sort of a list delete), but do not change them for
> the other case.  The list_for_each does an explicit prefetch which will
> improve performance in many cases.

Thanks Robin.

Linus, here's a new version of the patch which corrects the
issue that Robin Holt pointed out.

Again, there is an issue with the block comments not being up to
kernel-doc standards that plagues the entire file, which I will
remedy in a followup patch.

Thanks,
Dean


 include/linux/genalloc.h |    1 +
 lib/genalloc.c           |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)


Index: linux-2.6/lib/genalloc.c
===================================================================
--- linux-2.6.orig/lib/genalloc.c	2006-09-28 09:53:53.372104302 -0500
+++ linux-2.6/lib/genalloc.c	2006-09-28 10:42:47.627258805 -0500
@@ -71,6 +71,36 @@
 
 
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
+		list_del(&chunk->next_chunk);
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
--- linux-2.6.orig/include/linux/genalloc.h	2006-09-28 09:53:53.372104302 -0500
+++ linux-2.6/include/linux/genalloc.h	2006-09-28 09:53:55.200331504 -0500
@@ -31,5 +31,6 @@
 
 extern struct gen_pool *gen_pool_create(int, int);
 extern int gen_pool_add(struct gen_pool *, unsigned long, size_t, int);
+extern void gen_pool_destroy(struct gen_pool *);
 extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
 extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
