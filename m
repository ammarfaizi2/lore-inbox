Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWGEHKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWGEHKk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 03:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWGEHKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 03:10:40 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:24593 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S932091AbWGEHKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 03:10:39 -0400
Message-Id: <200607050701.k6571l5R018078@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH] simplfy bh_lru_install
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jes Sorensen <jes@sgi.com>
Date: Mon,  3 Jul 2006 11:37:43 -0400 (EDT)
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net>,
	<200607040519.k645JdoW014585@sullivan.realtime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, previous version forgot to do get_bh().  Still not tested.

While looking at Jes' patch "reduce IPI noise due to /dev/cdrom open/close"
I took a look at what the bh_lru code was doing.

 * The LRU management algorithm is dopey-but-simple.  Sorry.

Umm.. yes.

That in and out loop caused me to stare a bit.

lru_lookup_install, aka adding to lru cache, is building a second
array on the stack and then calling memcpy at the end to replace
the data.  Sure its in cache, but we already did all the loads 
and stores once.

The in and out arrays are always the same length, and we only allow
an entry in once.  So we know that we either push all down, and the
last one is the evictee, or we find the entry in there previously
and free that slot, leaving a copyloop.

But I'm sure the compiler can't determine that, because it doesn't
know about the insert-uniquely assertion.

It also has a special case for its already at the top.  But since
we did a lookup before __find_get_block_slow, that is surely a rare
special case.

Maybe it was designed to be called it on every lookup.

The lookup case does a move to top pulling the previous entrys down
one by one to the former spot, and inserting at the top, which is
sane.  Why not do a push down here here?

And while here, we can stop if we hit a NULL entry too, we will not
have any stragglers underneath.

Here is a totally untested patch.  Well, it compiles.  In the for
loop next is also assigned to bh for the bh = NULL case the compiler
pointed out.

Signed-off-by: Milton Miller <miltonm@bga.com>

--- linux-2.6.17/fs/buffer.c.orig	2006-07-04 00:04:16.000000000 -0400
+++ linux-2.6.17/fs/buffer.c	2006-07-05 01:50:27.000000000 -0400
@@ -1347,41 +1347,36 @@ static inline void check_irqs_on(void)
  */
 static void bh_lru_install(struct buffer_head *bh)
 {
-	struct buffer_head *evictee = NULL;
+	struct buffer_head *next, *prev;
 	struct bh_lru *lru;
+	int i;
 
 	check_irqs_on();
 	bh_lru_lock();
 	lru = &__get_cpu_var(bh_lrus);
-	if (lru->bhs[0] != bh) {
-		struct buffer_head *bhs[BH_LRU_SIZE];
-		int in;
-		int out = 0;
 
-		get_bh(bh);
-		bhs[out++] = bh;
-		for (in = 0; in < BH_LRU_SIZE; in++) {
-			struct buffer_head *bh2 = lru->bhs[in];
-
-			if (bh2 == bh) {
-				__brelse(bh2);
-			} else {
-				if (out >= BH_LRU_SIZE) {
-					BUG_ON(evictee != NULL);
-					evictee = bh2;
-				} else {
-					bhs[out++] = bh2;
-				}
-			}
-		}
-		while (out < BH_LRU_SIZE)
-			bhs[out++] = NULL;
-		memcpy(lru->bhs, bhs, sizeof(bhs));
+	get_bh(bh);
+	/* Push down, looking for duplicate as we go. last is freed */
+	for (i = 0, next = prev = bh; i < BH_LRU_SIZE && prev;
+			i++, prev = next) {
+		next = lru->bhs[i];
+		if (unlikely(next == bh))
+			break;
+		lru->bhs[i] = prev;
+	}
+
+#ifdef DEBUG
+	/* ++i to avoid finding the entry we know */
+	for (++i; i < BH_LRU_SIZE; i++) {
+		BUG_ON(lru->bhs[i] == bh);
+		if (!next)
+			BUG_ON(lru->bhs[i]);
 	}
+#endif
+
 	bh_lru_unlock();
 
-	if (evictee)
-		__brelse(evictee);
+	brelse(next);
 }
 
 /*
