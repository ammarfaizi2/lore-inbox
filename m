Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWCYSse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWCYSse (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWCYSse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:48:34 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47745 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932230AbWCYSs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:48:29 -0500
Date: Sat, 25 Mar 2006 19:45:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: [patch 02/10] PI-futex: introduce debug_check_no_locks_freed()
Message-ID: <20060325184552.GC16724@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4904]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


add debug_check_no_locks_freed(), as a central inline to add
bad-lock-free-debugging functionality to.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

----

 arch/i386/mm/pageattr.c |    4 ++--
 include/linux/mm.h      |   10 ++++++++--
 mm/page_alloc.c         |    4 ++--
 mm/slab.c               |    2 +-
 4 files changed, 13 insertions(+), 7 deletions(-)

Index: linux-pi-futex.mm.q/arch/i386/mm/pageattr.c
===================================================================
--- linux-pi-futex.mm.q.orig/arch/i386/mm/pageattr.c
+++ linux-pi-futex.mm.q/arch/i386/mm/pageattr.c
@@ -229,8 +229,8 @@ void kernel_map_pages(struct page *page,
 	if (PageHighMem(page))
 		return;
 	if (!enable)
-		mutex_debug_check_no_locks_freed(page_address(page),
-						 numpages * PAGE_SIZE);
+		debug_check_no_locks_freed(page_address(page),
+					   numpages * PAGE_SIZE);
 
 	/* the return value is ignored - the calls cannot fail,
 	 * large pages are disabled at boot time.
Index: linux-pi-futex.mm.q/include/linux/mm.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/mm.h
+++ linux-pi-futex.mm.q/include/linux/mm.h
@@ -1066,13 +1066,19 @@ static inline void vm_stat_account(struc
 }
 #endif /* CONFIG_PROC_FS */
 
+static inline void
+debug_check_no_locks_freed(const void *from, unsigned long len)
+{
+	mutex_debug_check_no_locks_freed(from, len);
+}
+
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable)
 {
 	if (!PageHighMem(page) && !enable)
-		mutex_debug_check_no_locks_freed(page_address(page),
-						 numpages * PAGE_SIZE);
+		debug_check_no_locks_freed(page_address(page),
+					   numpages * PAGE_SIZE);
 }
 #endif
 
Index: linux-pi-futex.mm.q/mm/page_alloc.c
===================================================================
--- linux-pi-futex.mm.q.orig/mm/page_alloc.c
+++ linux-pi-futex.mm.q/mm/page_alloc.c
@@ -447,8 +447,8 @@ static void __free_pages_ok(struct page 
 
 	arch_free_page(page, order);
 	if (!PageHighMem(page))
-		mutex_debug_check_no_locks_freed(page_address(page),
-						 PAGE_SIZE<<order);
+		debug_check_no_locks_freed(page_address(page),
+					   PAGE_SIZE<<order);
 
 	for (i = 0 ; i < (1 << order) ; ++i)
 		reserved += free_pages_check(page + i);
Index: linux-pi-futex.mm.q/mm/slab.c
===================================================================
--- linux-pi-futex.mm.q.orig/mm/slab.c
+++ linux-pi-futex.mm.q/mm/slab.c
@@ -3390,7 +3390,7 @@ void kfree(const void *objp)
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = virt_to_cache(objp);
-	mutex_debug_check_no_locks_freed(objp, obj_size(c));
+	debug_check_no_locks_freed(objp, obj_size(c));
 	__cache_free(c, (void *)objp);
 	local_irq_restore(flags);
 }
