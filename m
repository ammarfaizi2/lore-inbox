Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUCKTwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbUCKTwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:52:35 -0500
Received: from ns.suse.de ([195.135.220.2]:40336 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261690AbUCKTwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:52:23 -0500
Date: Thu, 11 Mar 2004 20:52:21 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Save some memory in mem_map on x86-64
Message-ID: <20040311195221.GD15071@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch saves 2MB of memory on a 1GB x86-64 machine, 20MB on a 10GB 
machine. It does this by eliminating 8 bytes of useless padding 
in struct page.

This resurrects an older patch in a hopefully cleaner form.

-Andi

diff -u linux/include/asm-x86_64/bitops.h-o linux/include/asm-x86_64/bitops.h
--- linux/include/asm-x86_64/bitops.h-o	2004-03-11 16:40:40.000000000 +0100
+++ linux/include/asm-x86_64/bitops.h	2004-03-18 06:55:05.000000000 +0100
@@ -503,6 +503,8 @@
 /* find last set bit */
 #define fls(x) generic_fls(x)
 
+#define ARCH_HAS_ATOMIC_UNSIGNED 1
+
 #endif /* __KERNEL__ */
 
 #endif /* _X86_64_BITOPS_H */
diff -u linux/include/linux/mm.h-o linux/include/linux/mm.h
--- linux/include/linux/mm.h-o	2004-03-18 01:21:40.000000000 +0100
+++ linux/include/linux/mm.h	2004-03-18 06:55:08.000000000 +0100
@@ -153,6 +153,12 @@
 struct mmu_gather;
 struct inode;
 
+#ifdef ARCH_HAS_ATOMIC_UNSIGNED
+typedef unsigned page_flags_t; 
+#else
+typedef unsigned long page_flags_t;
+#endif
+
 /*
  * Each physical page in the system has a struct page associated with
  * it to keep track of whatever it is we are using the page for at the
@@ -169,7 +175,7 @@
  * TODO: make this structure smaller, it could be as small as 32 bytes.
  */
 struct page {
-	unsigned long flags;		/* atomic flags, some possibly
+	page_flags_t flags;		/* atomic flags, some possibly
 					   updated asynchronously */
 	atomic_t count;			/* Usage count, see below. */
 	struct list_head list;		/* ->mapping has some page lists. */
@@ -335,7 +341,7 @@
  * We'll have up to (MAX_NUMNODES * MAX_NR_ZONES) zones total,
  * so we use (MAX_NODES_SHIFT + MAX_ZONES_SHIFT) here to get enough bits.
  */
-#define NODEZONE_SHIFT (BITS_PER_LONG - MAX_NODES_SHIFT - MAX_ZONES_SHIFT)
+#define NODEZONE_SHIFT (sizeof(page_flags_t)*8 - MAX_NODES_SHIFT - MAX_ZONES_SHIFT)
 #define NODEZONE(node, zone)	((node << ZONES_SHIFT) | zone)
 
 static inline unsigned long page_zonenum(struct page *page)
diff -u linux/include/linux/rmap-locking.h-o linux/include/linux/rmap-locking.h
--- linux/include/linux/rmap-locking.h-o	2004-03-11 16:40:40.000000000 +0100
+++ linux/include/linux/rmap-locking.h	2004-03-18 06:59:07.000000000 +0100
@@ -10,8 +10,8 @@
 struct pte_chain;
 extern kmem_cache_t *pte_chain_cache;
 
-#define pte_chain_lock(page)	bit_spin_lock(PG_chainlock, &page->flags)
-#define pte_chain_unlock(page)	bit_spin_unlock(PG_chainlock, &page->flags)
+#define pte_chain_lock(page)	bit_spin_lock(PG_chainlock, (unsigned long *)&page->flags)
+#define pte_chain_unlock(page)	bit_spin_unlock(PG_chainlock, (unsigned long *)&page->flags)
 
 struct pte_chain *pte_chain_alloc(int gfp_flags);
 void __pte_chain_free(struct pte_chain *pte_chain);
diff -u linux/include/linux/mmzone.h-o linux/include/linux/mmzone.h
--- linux/include/linux/mmzone.h-o	2004-03-17 12:18:01.000000000 +0100
+++ linux/include/linux/mmzone.h	2004-03-18 07:57:15.000000000 +0100
@@ -310,7 +310,7 @@
 
 #include <asm/mmzone.h>
 
-#if BITS_PER_LONG == 32
+#if BITS_PER_LONG == 32 || defined(ARCH_HAS_ATOMIC_UNSIGNED)
 /*
  * with 32 bit page->flags field, we reserve 8 bits for node/zone info.
  * there are 3 zones (2 bits) and this leaves 8-2=6 bits for nodes.
