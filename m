Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVKUWmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVKUWmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVKUWmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:42:39 -0500
Received: from silver.veritas.com ([143.127.12.111]:10641 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751199AbVKUWmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:42:37 -0500
Date: Mon, 21 Nov 2005 20:32:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mm: update split ptlock Kconfig
In-Reply-To: <Pine.LNX.4.61.0511212025220.19274@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511212031420.19274@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511212025220.19274@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Nov 2005 20:32:30.0412 (UTC) FILETIME=[B1DAE0C0:01C5EEDA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Closer attention to the arithmetic shows that neither ppc64 nor sparc
really uses one page for multiple page tables: how on earth could they,
while pte_alloc_one returns just a struct page pointer, with no offset?

Well, arm26 manages it by returning a pte_t pointer cast to a struct
page pointer, harumph, then compensating in its pmd_populate.  But
arm26 is never SMP, so it's not a problem for split ptlock either.

And the PA-RISC situation has been recently improved: CONFIG_PA20 works
without the 16-byte alignment which inflated its spinlock_t.  But the
current union of spinlock_t with private does make the 7xxx struct page
significantly larger, even without debug, so disable its split ptlock.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/Kconfig |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- 2.6.15-rc2/mm/Kconfig	2005-11-20 19:44:23.000000000 +0000
+++ linux/mm/Kconfig	2005-11-21 18:49:53.000000000 +0000
@@ -125,12 +125,10 @@ comment "Memory hotplug is currently inc
 # space can be handled with less contention: split it at this NR_CPUS.
 # Default to 4 for wider testing, though 8 might be more appropriate.
 # ARM's adjust_pte (unused if VIPT) depends on mm-wide page_table_lock.
-# PA-RISC's debug spinlock_t is too large for the 32-bit struct page.
-# ARM26 and SPARC32 and PPC64 may use one page for multiple page tables.
+# PA-RISC 7xxx's spinlock_t would enlarge struct page from 32 to 44 bytes.
 #
 config SPLIT_PTLOCK_CPUS
 	int
 	default "4096" if ARM && !CPU_CACHE_VIPT
-	default "4096" if PARISC && DEBUG_SPINLOCK && !64BIT
-	default "4096" if ARM26 || SPARC32 || PPC64
+	default "4096" if PARISC && !PA20
 	default "4"
