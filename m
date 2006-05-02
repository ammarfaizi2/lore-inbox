Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWEBNyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWEBNyc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWEBNyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:54:32 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:12951 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964828AbWEBNya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:54:30 -0400
Date: Tue, 2 May 2006 15:59:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch, 2.6.17-rc3-mm1] swap-prefetch-fix.patch
Message-ID: <20060502135920.GA31564@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

fix potential swap-prefetch deadlock: swapped.lock must be taken
in an irq-safe manner, because it can be taken while holding an
irq-safe lock in the following code sequence:

 [<c014646e>] lockdep_acquire+0x69/0x82
 [<c10c4fc1>] _spin_lock+0x21/0x2f
 [<c0175e7d>] add_to_swapped_list+0x1f/0x13b
 [<c016780d>] remove_mapping+0x84/0xc3
 [<c0167c47>] shrink_inactive_list+0x3fb/0x705
 [<c016800a>] shrink_zone+0xb9/0xd8
 [<c01682bc>] kswapd+0x293/0x38a
 [<c013f271>] kthread+0xa6/0xd3

found by the locking correctness validator. The full validator
output is:

======================================================
[ BUG: hard-safe -> hard-unsafe lock order detected! ]
------------------------------------------------------
kswapd0/1173 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 (swapped.lock){--..}, at: [<c0175e7d>] add_to_swapped_list+0x1f/0x13b

and this task is already holding:
 (swapper_space.tree_lock){+...}, at: [<c01677a5>] remove_mapping+0x1c/0xc3
which would create a new lock dependency:
 (swapper_space.tree_lock){+...} -> (swapped.lock){--..}

but this new dependency connects a hard-irq-safe lock:
 (swapper_space.tree_lock){+...}
... which became hard-irq-safe at:
  [<c014646e>] lockdep_acquire+0x69/0x82
  [<c10c52a2>] _write_lock_irqsave+0x2a/0x3a
  [<c0164c6f>] test_clear_page_writeback+0x48/0xbc
  [<c0165a57>] rotate_reclaimable_page+0x8b/0xb4
  [<c015e2c3>] end_page_writeback+0x18/0x45
  [<c0173153>] end_swap_bio_write+0x28/0x36
  [<c018549a>] bio_endio+0x66/0x6e
  [<c0532613>] __end_that_request_first+0x23c/0x559
  [<c0532945>] end_that_request_first+0xb/0xd
  [<c09cae20>] ide_end_request+0xa8/0xf1
  [<c09d1c44>] ide_dma_intr+0x54/0x8f
  [<c09cc011>] ide_intr+0x147/0x1a7
  [<c015adc7>] handle_IRQ_event+0x1f/0x4f
  [<c015ae9d>] __do_IRQ+0xa6/0x111
  [<c0106287>] do_IRQ+0x8c/0xad

to a hard-irq-unsafe lock:
 (swapped.lock){--..}
... which became hard-irq-unsafe at:
...  [<c014646e>] lockdep_acquire+0x69/0x82
  [<c10c4fc1>] _spin_lock+0x21/0x2f
  [<c01763fc>] kprefetchd+0x3eb/0x40b
  [<c013f271>] kthread+0xa6/0xd3
  [<c0102005>] kernel_thread_helper+0x5/0xb

which could potentially lead to deadlocks!

other info that might help us debug this:

1 locks held by kswapd0/1173:
 #0:  (swapper_space.tree_lock){+...}, at: [<c01677a5>] remove_mapping+0x1c/0xc3

the hard-irq-safe lock's dependencies:
-> (swapper_space.tree_lock){+...} ops: 121 {
   initial-use  at:
                        [<c014646e>] lockdep_acquire+0x69/0x82
                        [<c10c505e>] _write_lock_irq+0x27/0x35
                        [<c017341a>] __add_to_swap_cache+0x65/0x149
                        [<c0173512>] move_to_swap_cache+0x14/0x62
                        [<c0178af8>] shmem_writepage+0x10c/0x1b5
                        [<c01672e9>] pageout+0x119/0x1cc
                        [<c0167b73>] shrink_inactive_list+0x327/0x705
                        [<c016800a>] shrink_zone+0xb9/0xd8
                        [<c01684f5>] try_to_free_pages+0x142/0x221
                        [<c0163e36>] __alloc_pages+0x1d9/0x325
                        [<c015f919>] generic_file_buffered_write+0x189/0x5cd
                        [<c0160f8d>] __generic_file_aio_write_nolock+0x450/0x48d
                        [<c01611fa>] generic_file_aio_write+0x6e/0xc1
                        [<c02ab0c2>] ext3_file_write+0x1a/0x8b
                        [<c017fe22>] do_sync_write+0xb1/0xe6
                        [<c01807da>] vfs_write+0xcd/0x176
                        [<c0180e7d>] sys_write+0x3b/0x71
                        [<c10c5abb>] syscall_call+0x7/0xb
   in-hardirq-W at:
                        [<c014646e>] lockdep_acquire+0x69/0x82
                        [<c10c52a2>] _write_lock_irqsave+0x2a/0x3a
                        [<c0164c6f>] test_clear_page_writeback+0x48/0xbc
                        [<c0165a57>] rotate_reclaimable_page+0x8b/0xb4
                        [<c015e2c3>] end_page_writeback+0x18/0x45
                        [<c0173153>] end_swap_bio_write+0x28/0x36
                        [<c018549a>] bio_endio+0x66/0x6e
                        [<c0532613>] __end_that_request_first+0x23c/0x559
                        [<c0532945>] end_that_request_first+0xb/0xd
                        [<c09cae20>] ide_end_request+0xa8/0xf1
                        [<c09d1c44>] ide_dma_intr+0x54/0x8f
                        [<c09cc011>] ide_intr+0x147/0x1a7
                        [<c015adc7>] handle_IRQ_event+0x1f/0x4f
                        [<c015ae9d>] __do_IRQ+0xa6/0x111
                        [<c0106287>] do_IRQ+0x8c/0xad
 }
 ... key      at: [<c14d4e64>] swapper_space+0x24/0xfc

the hard-irq-unsafe lock's dependencies:
-> (swapped.lock){--..} ops: 2 {
   initial-use  at:
                        [<c014646e>] lockdep_acquire+0x69/0x82
                        [<c10c4fc1>] _spin_lock+0x21/0x2f
                        [<c01763fc>] kprefetchd+0x3eb/0x40b
                        [<c013f271>] kthread+0xa6/0xd3
                        [<c0102005>] kernel_thread_helper+0x5/0xb
   softirq-on-W at:
                        [<c014646e>] lockdep_acquire+0x69/0x82
                        [<c10c4fc1>] _spin_lock+0x21/0x2f
                        [<c01763fc>] kprefetchd+0x3eb/0x40b
                        [<c013f271>] kthread+0xa6/0xd3
                        [<c0102005>] kernel_thread_helper+0x5/0xb
   hardirq-on-W at:
                        [<c014646e>] lockdep_acquire+0x69/0x82
                        [<c10c4fc1>] _spin_lock+0x21/0x2f
                        [<c01763fc>] kprefetchd+0x3eb/0x40b
                        [<c013f271>] kthread+0xa6/0xd3
                        [<c0102005>] kernel_thread_helper+0x5/0xb
 }
 ... key      at: [<c14d5658>] swapped+0x18/0x60

stack backtrace:
 [<c0104e7f>] show_trace+0xd/0xf
 [<c0104e96>] dump_stack+0x15/0x17
 [<c0144cd3>] check_usage+0x1f4/0x201
 [<c0146238>] __lockdep_acquire+0x873/0xa40
 [<c014646e>] lockdep_acquire+0x69/0x82
 [<c10c4fc1>] _spin_lock+0x21/0x2f
 [<c0175e7d>] add_to_swapped_list+0x1f/0x13b
 [<c016780d>] remove_mapping+0x84/0xc3
 [<c0167c47>] shrink_inactive_list+0x3fb/0x705
 [<c016800a>] shrink_zone+0xb9/0xd8
 [<c01682bc>] kswapd+0x293/0x38a
 [<c013f271>] kthread+0xa6/0xd3
 [<c0102005>] kernel_thread_helper+0x5/0xb

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

---
 mm/swap_prefetch.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

Index: linux/mm/swap_prefetch.c
===================================================================
--- linux.orig/mm/swap_prefetch.c
+++ linux/mm/swap_prefetch.c
@@ -65,7 +65,7 @@ inline void delay_swap_prefetch(void)
 void add_to_swapped_list(struct page *page)
 {
 	struct swapped_entry *entry;
-	unsigned long index;
+	unsigned long index, flags;
 	int wakeup;
 
 	if (!swap_prefetch)
@@ -73,7 +73,7 @@ void add_to_swapped_list(struct page *pa
 
 	wakeup = 0;
 
-	spin_lock(&swapped.lock);
+	spin_lock_irqsave(&swapped.lock, flags);
 	if (swapped.count >= swapped.maxcount) {
 		/*
 		 * We limit the number of entries to 2/3 of physical ram.
@@ -112,7 +112,7 @@ void add_to_swapped_list(struct page *pa
 	}
 
 out_locked:
-	spin_unlock(&swapped.lock);
+	spin_unlock_irqrestore(&swapped.lock, flags);
 
 	/* Do the wakeup outside the lock to shorten lock hold time. */
 	if (wakeup)
@@ -433,6 +433,7 @@ static enum trickle_return trickle_swap(
 {
 	enum trickle_return ret = TRICKLE_DELAY;
 	struct swapped_entry *entry;
+	unsigned long flags;
 
 	/*
 	 * If laptop_mode is enabled don't prefetch to avoid hard drives
@@ -451,10 +452,10 @@ static enum trickle_return trickle_swap(
 		if (!prefetch_suitable())
 			break;
 
-		spin_lock(&swapped.lock);
+		spin_lock_irqsave(&swapped.lock, flags);
 		if (list_empty(&swapped.list)) {
 			ret = TRICKLE_FAILED;
-			spin_unlock(&swapped.lock);
+			spin_unlock_irqrestore(&swapped.lock, flags);
 			break;
 		}
 
@@ -473,7 +474,7 @@ static enum trickle_return trickle_swap(
 			 * be a reason we could not swap them back in so
 			 * delay attempting further prefetching.
 			 */
-			spin_unlock(&swapped.lock);
+			spin_unlock_irqrestore(&swapped.lock, flags);
 			break;
 		}
 
@@ -484,12 +485,12 @@ static enum trickle_return trickle_swap(
 			 * not suitable for prefetching so skip it.
 			 */
 			entry = prev_swapped_entry(entry);
-			spin_unlock(&swapped.lock);
+			spin_unlock_irqrestore(&swapped.lock, flags);
 			continue;
 		}
 		swp_entry = entry->swp_entry;
 		entry = prev_swapped_entry(entry);
-		spin_unlock(&swapped.lock);
+		spin_unlock_irqrestore(&swapped.lock, flags);
 
 		if (trickle_swap_cache_async(swp_entry, node) == TRICKLE_DELAY)
 			break;
