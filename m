Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTEWGzS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263759AbTEWGzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:55:18 -0400
Received: from tmi.comex.ru ([217.10.33.92]:25281 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S263723AbTEWGzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:55:07 -0400
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Alex Tomas <bzzz@tmi.comex.ru>
Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Fri, 23 May 2003 11:08:44 +0000
In-Reply-To: <20030521143140.3aaa86ba.akpm@digeo.com> (Andrew Morton's
 message of "Wed, 21 May 2003 14:31:40 -0700")
Message-ID: <8765o1x6mb.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87d6igmarf.fsf@gw.home.net>
	<1053376482.11943.15.camel@sisko.scot.redhat.com>
	<87he7qe979.fsf@gw.home.net>
	<1053377493.11943.32.camel@sisko.scot.redhat.com>
	<87addhd2mc.fsf@gw.home.net> <20030521093848.59ada625.akpm@digeo.com>
	<87smr8c9le.fsf@gw.home.net> <20030521095921.4f457002.akpm@digeo.com>
	<m3brxwe2lr.fsf@lexa.home.net>
	<20030521103737.52eddeb3.akpm@digeo.com> <87n0hgc6s6.fsf@gw.home.net>
	<20030521105011.2d316baf.akpm@digeo.com> <87k7ckc5z2.fsf@gw.home.net>
	<20030521143140.3aaa86ba.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

here is small patch that intented to fix race with b_committed_data.
also, as Andrew asked I introduced new bit-based spinlock and
converted pte_chain_lock()/pte_chain_unlock() to use that one.
patch tested by dbench 1/2/4/6/8/16/24.

with best regards, Alex


diff -puNr linux-2.5.69-mm6/include/linux/rmap-locking.h b_commited_data-race/include/linux/rmap-locking.h
--- linux-2.5.69-mm6/include/linux/rmap-locking.h	Fri May 16 17:59:38 2003
+++ b_commited_data-race/include/linux/rmap-locking.h	Fri May 23 10:23:44 2003
@@ -10,32 +10,8 @@
 struct pte_chain;
 extern kmem_cache_t *pte_chain_cache;
 
-static inline void pte_chain_lock(struct page *page)
-{
-	/*
-	 * Assuming the lock is uncontended, this never enters
-	 * the body of the outer loop. If it is contended, then
-	 * within the inner loop a non-atomic test is used to
-	 * busywait with less bus contention for a good time to
-	 * attempt to acquire the lock bit.
-	 */
-	preempt_disable();
-#ifdef CONFIG_SMP
-	while (test_and_set_bit(PG_chainlock, &page->flags)) {
-		while (test_bit(PG_chainlock, &page->flags))
-			cpu_relax();
-	}
-#endif
-}
-
-static inline void pte_chain_unlock(struct page *page)
-{
-#ifdef CONFIG_SMP
-	smp_mb__before_clear_bit();
-	clear_bit(PG_chainlock, &page->flags);
-#endif
-	preempt_enable();
-}
+#define pte_chain_lock(page)	bb_spin_lock(PG_chainlock, &page->flags)
+#define pte_chain_unlock(page)	bb_spin_unlock(PG_chainlock, &page->flags)
 
 struct pte_chain *pte_chain_alloc(int gfp_flags);
 void __pte_chain_free(struct pte_chain *pte_chain);
diff -puNr linux-2.5.69-mm6/include/linux/jbd.h b_commited_data-race/include/linux/jbd.h
--- linux-2.5.69-mm6/include/linux/jbd.h	Fri May 16 17:59:41 2003
+++ b_commited_data-race/include/linux/jbd.h	Fri May 23 10:28:17 2003
@@ -292,6 +292,7 @@ enum jbd_state_bits {
 	BH_Revoked,		/* Has been revoked from the log */
 	BH_RevokeValid,		/* Revoked flag is valid */
 	BH_JBDDirty,		/* Is dirty but journaled */
+	BH_JLock,		/* Buffer is locked for short time */
 };
 
 BUFFER_FNS(JBD, jbd)
@@ -308,6 +309,9 @@ static inline struct journal_head *bh2jh
 {
 	return bh->b_private;
 }
+
+#define jbd_lock_bh(bh)		bb_spin_lock(BH_JLock, &bh->b_state)
+#define jbd_unlock_bh(bh)	bb_spin_unlock(BH_JLock, &bh->b_state)
 
 #define HAVE_JOURNAL_CALLBACK_STATUS
 /**
diff -puNr linux-2.5.69-mm6/fs/jbd/commit.c b_commited_data-race/fs/jbd/commit.c
--- linux-2.5.69-mm6/fs/jbd/commit.c	Fri May 16 18:03:20 2003
+++ b_commited_data-race/fs/jbd/commit.c	Fri May 23 10:29:20 2003
@@ -686,12 +686,14 @@ skip_commit: /* The journal should be un
 		 * Otherwise, we can just throw away the frozen data now.
 		 */
 		if (jh->b_committed_data) {
+			jbd_lock_bh(jh2bh(jh));
 			kfree(jh->b_committed_data);
 			jh->b_committed_data = NULL;
 			if (jh->b_frozen_data) {
 				jh->b_committed_data = jh->b_frozen_data;
 				jh->b_frozen_data = NULL;
 			}
+			jbd_unlock_bh(jh2bh(jh));
 		} else if (jh->b_frozen_data) {
 			kfree(jh->b_frozen_data);
 			jh->b_frozen_data = NULL;
diff -puNr linux-2.5.69-mm6/fs/ext3/balloc.c b_commited_data-race/fs/ext3/balloc.c
--- linux-2.5.69-mm6/fs/ext3/balloc.c	Sat May 17 17:52:42 2003
+++ b_commited_data-race/fs/ext3/balloc.c	Fri May 23 10:55:55 2003
@@ -185,11 +185,14 @@ do_more:
 	if (err)
 		goto error_return;
 
+	jbd_lock_bh(bitmap_bh);
+	
 	for (i = 0; i < count; i++) {
 		/*
 		 * An HJ special.  This is expensive...
 		 */
 #ifdef CONFIG_JBD_DEBUG
+		jbd_unlock_bh(bitmap_bh);
 		{
 			struct buffer_head *debug_bh;
 			debug_bh = sb_find_get_block(sb, block + i);
@@ -202,6 +205,7 @@ do_more:
 				__brelse(debug_bh);
 			}
 		}
+		jbd_lock_bh(bitmap_bh);
 #endif
 		/* @@@ This prevents newly-allocated data from being
 		 * freed and then reallocated within the same
@@ -243,6 +247,7 @@ do_more:
 			dquot_freed_blocks++;
 		}
 	}
+	jbd_unlock_bh(bitmap_bh);
 
 	spin_lock(sb_bgl_lock(sbi, block_group));
 	gdp->bg_free_blocks_count =
@@ -289,11 +294,12 @@ error_return:
  * data-writes at some point, and disable it for metadata allocations or
  * sync-data inodes.
  */
-static int ext3_test_allocatable(int nr, struct buffer_head *bh)
+static inline int ext3_test_allocatable(int nr, struct buffer_head *bh,
+					int have_access)
 {
 	if (ext3_test_bit(nr, bh->b_data))
 		return 0;
-	if (!buffer_jbd(bh) || !bh2jh(bh)->b_committed_data)
+	if (!have_access || !buffer_jbd(bh) || !bh2jh(bh)->b_committed_data)
 		return 1;
 	return !ext3_test_bit(nr, bh2jh(bh)->b_committed_data);
 }
@@ -305,8 +311,8 @@ static int ext3_test_allocatable(int nr,
  * the initial goal; then for a free byte somewhere in the bitmap; then
  * for any free bit in the bitmap.
  */
-static int find_next_usable_block(int start,
-			struct buffer_head *bh, int maxblocks)
+static int find_next_usable_block(int start, struct buffer_head *bh,
+				int maxblocks, int have_access)
 {
 	int here, next;
 	char *p, *r;
@@ -322,7 +328,8 @@ static int find_next_usable_block(int st
 		 */
 		int end_goal = (start + 63) & ~63;
 		here = ext3_find_next_zero_bit(bh->b_data, end_goal, start);
-		if (here < end_goal && ext3_test_allocatable(here, bh))
+		if (here < end_goal &&
+			ext3_test_allocatable(here, bh, have_access))
 			return here;
 		
 		ext3_debug ("Bit not found near goal\n");
@@ -345,7 +352,7 @@ static int find_next_usable_block(int st
 	r = memscan(p, 0, (maxblocks - here + 7) >> 3);
 	next = (r - ((char *) bh->b_data)) << 3;
 	
-	if (next < maxblocks && ext3_test_allocatable(next, bh))
+	if (next < maxblocks && ext3_test_allocatable(next, bh, have_access))
 		return next;
 	
 	/* The bitmap search --- search forward alternately
@@ -357,13 +364,13 @@ static int find_next_usable_block(int st
 						 maxblocks, here);
 		if (next >= maxblocks)
 			return -1;
-		if (ext3_test_allocatable(next, bh))
+		if (ext3_test_allocatable(next, bh, have_access))
 			return next;
 
-		J_ASSERT_BH(bh, bh2jh(bh)->b_committed_data);
-		here = ext3_find_next_zero_bit
-			((unsigned long *) bh2jh(bh)->b_committed_data, 
-			 maxblocks, next);
+		if (have_access)
+			here = ext3_find_next_zero_bit
+				((unsigned long *) bh2jh(bh)->b_committed_data, 
+			 	maxblocks, next);
 	}
 	return -1;
 }
@@ -402,17 +409,18 @@ ext3_try_to_allocate(struct super_block 
 
 	*errp = 0;
 
-	if (goal >= 0 && ext3_test_allocatable(goal, bitmap_bh))
+	if (goal >= 0 && ext3_test_allocatable(goal, bitmap_bh, 0))
 		goto got;
 
 repeat:
 	goal = find_next_usable_block(goal, bitmap_bh,
-				EXT3_BLOCKS_PER_GROUP(sb));
+				EXT3_BLOCKS_PER_GROUP(sb), have_access);
 	if (goal < 0)
 		goto fail;
 
 	for (i = 0;
-		i < 7 && goal > 0 && ext3_test_allocatable(goal - 1, bitmap_bh);
+		i < 7 && goal > 0 && 
+			ext3_test_allocatable(goal - 1, bitmap_bh, have_access);
 		i++, goal--);
 
 got:
@@ -429,6 +437,7 @@ got:
 			*errp = fatal;
 			goto fail;
 		}
+		jbd_lock_bh(bitmap_bh);
 		have_access = 1;
 	}
 
@@ -444,6 +453,7 @@ got:
 	}
 
 	BUFFER_TRACE(bitmap_bh, "journal_dirty_metadata for bitmap block");
+	jbd_unlock_bh(bitmap_bh);
 	fatal = ext3_journal_dirty_metadata(handle, bitmap_bh);
 	if (fatal) {
 		*errp = fatal;
@@ -454,6 +464,7 @@ got:
 fail:
 	if (have_access) {
 		BUFFER_TRACE(bitmap_bh, "journal_release_buffer");
+		jbd_unlock_bh(bitmap_bh);
 		ext3_journal_release_buffer(handle, bitmap_bh);
 	}
 	return -1;
diff -puNr linux-2.5.69-mm6/include/linux/spinlock.h b_commited_data-race/include/linux/spinlock.h
--- linux-2.5.69-mm6/include/linux/spinlock.h	Fri May 16 18:03:21 2003
+++ b_commited_data-race/include/linux/spinlock.h	Fri May 23 10:45:58 2003
@@ -540,4 +540,37 @@ do { \
 extern int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
 #endif
 
+/*
+ *  bit-based spin_lock()
+ */
+static inline void bb_spin_lock(int bitnum, unsigned long *addr)
+{
+	/*
+	 * Assuming the lock is uncontended, this never enters
+	 * the body of the outer loop. If it is contended, then
+	 * within the inner loop a non-atomic test is used to
+	 * busywait with less bus contention for a good time to
+	 * attempt to acquire the lock bit.
+	 */
+	preempt_disable();
+#ifdef CONFIG_SMP
+	while (test_and_set_bit(bitnum, addr)) {
+		while (test_bit(bitnum, addr))
+			cpu_relax();
+	}
+#endif
+}
+
+/*
+ *  bit-based spin_unlock()
+ */
+static inline void bb_spin_unlock(int bitnum, unsigned long *addr)
+{
+#ifdef CONFIG_SMP
+	smp_mb__before_clear_bit();
+	clear_bit(bitnum, addr);
+#endif
+	preempt_enable();
+}
+
 #endif /* __LINUX_SPINLOCK_H */

