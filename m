Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVLTPpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVLTPpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVLTPpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:45:14 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:16789 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751103AbVLTPor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:44:47 -0500
Subject: [PATCH RT 01/02] SLOB - remove bigblock list
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       john stultz <johnstul@us.ibm.com>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134790400.13138.160.camel@localhost.localdomain>
	 <1134860251.13138.193.camel@localhost.localdomain>
	 <20051220133230.GC24408@elte.hu>
	 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
	 <20051220135725.GA29392@elte.hu>
	 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 10:44:26 -0500
Message-Id: <1135093466.13138.303.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the mem_map pages to find the bigblock descriptor for
large allocations.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.15-rc5-rt2/mm/slob.c
===================================================================
--- linux-2.6.15-rc5-rt2.orig/mm/slob.c	2005-12-19 10:45:55.000000000 -0500
+++ linux-2.6.15-rc5-rt2/mm/slob.c	2005-12-19 14:12:08.000000000 -0500
@@ -50,15 +50,42 @@
 struct bigblock {
 	int order;
 	void *pages;
-	struct bigblock *next;
 };
 typedef struct bigblock bigblock_t;
 
 static slob_t arena = { .next = &arena, .units = 1 };
 static slob_t *slobfree = &arena;
-static bigblock_t *bigblocks;
 static DEFINE_SPINLOCK(slob_lock);
-static DEFINE_SPINLOCK(block_lock);
+
+#define __get_slob_block(b) ((unsigned long)(b) & ~(PAGE_SIZE-1))
+
+static inline struct page *get_slob_page(const void *mem)
+{
+	void *virt = (void*)__get_slob_block(mem);
+
+	return virt_to_page(virt);
+}
+
+static inline void zero_slob_block(const void *b)
+{
+	struct page *page;
+	page = get_slob_page(b);
+	memset(&page->lru, 0, sizeof(page->lru));
+}
+
+static inline void *get_slob_block(const void *b)
+{
+	struct page *page;
+	page = get_slob_page(b);
+	return page->lru.next;
+}
+
+static inline void set_slob_block(const void *b, void *data)
+{
+	struct page *page;
+	page = get_slob_page(b);
+	page->lru.next = data;
+}
 
 static void slob_free(void *b, int size);
 
@@ -108,6 +135,7 @@
 			if (!cur)
 				return 0;
 
+			zero_slob_block(cur);
 			slob_free(cur, PAGE_SIZE);
 			spin_lock_irqsave(&slob_lock, flags);
 			cur = slobfree;
@@ -162,7 +190,6 @@
 {
 	slob_t *m;
 	bigblock_t *bb;
-	unsigned long flags;
 
 	if (size < PAGE_SIZE - SLOB_UNIT) {
 		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
@@ -177,10 +204,7 @@
 	bb->pages = (void *)__get_free_pages(gfp, bb->order);
 
 	if (bb->pages) {
-		spin_lock_irqsave(&block_lock, flags);
-		bb->next = bigblocks;
-		bigblocks = bb;
-		spin_unlock_irqrestore(&block_lock, flags);
+		set_slob_block(bb->pages, bb);
 		return bb->pages;
 	}
 
@@ -192,25 +216,16 @@
 
 void kfree(const void *block)
 {
-	bigblock_t *bb, **last = &bigblocks;
-	unsigned long flags;
+	bigblock_t *bb;
 
 	if (!block)
 		return;
 
-	if (!((unsigned long)block & (PAGE_SIZE-1))) {
-		/* might be on the big block list */
-		spin_lock_irqsave(&block_lock, flags);
-		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
-			if (bb->pages == block) {
-				*last = bb->next;
-				spin_unlock_irqrestore(&block_lock, flags);
-				free_pages((unsigned long)block, bb->order);
-				slob_free(bb, sizeof(bigblock_t));
-				return;
-			}
-		}
-		spin_unlock_irqrestore(&block_lock, flags);
+	bb = get_slob_block(block);
+	if (bb) {
+		free_pages((unsigned long)block, bb->order);
+		slob_free(bb, sizeof(bigblock_t));
+		return;
 	}
 
 	slob_free((slob_t *)block - 1, 0);
@@ -222,20 +237,13 @@
 unsigned int ksize(const void *block)
 {
 	bigblock_t *bb;
-	unsigned long flags;
 
 	if (!block)
 		return 0;
 
-	if (!((unsigned long)block & (PAGE_SIZE-1))) {
-		spin_lock_irqsave(&block_lock, flags);
-		for (bb = bigblocks; bb; bb = bb->next)
-			if (bb->pages == block) {
-				spin_unlock_irqrestore(&slob_lock, flags);
-				return PAGE_SIZE << bb->order;
-			}
-		spin_unlock_irqrestore(&block_lock, flags);
-	}
+	bb = get_slob_block(block);
+	if (bb)
+		return PAGE_SIZE << bb->order;
 
 	return ((slob_t *)block - 1)->units * SLOB_UNIT;
 }


