Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbVKJBsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVKJBsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVKJBsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:48:20 -0500
Received: from silver.veritas.com ([143.127.12.111]:6952 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751388AbVKJBsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:48:19 -0500
Date: Thu, 10 Nov 2005 01:47:08 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] mm: update split ptlock Kconfig
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100146110.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 01:48:19.0529 (UTC) FILETIME=[D373AB90:01C5E598]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Closer attention to the arithmetic shows that neither ppc64 nor sparc
really uses one page for multiple page tables: how on earth could they,
while pte_alloc_one returns just a struct page pointer, with no offset?

Gasp, splutter... arm26 manages it by returning a pte_t pointer cast to
a struct page pointer, then compensating in its pmd_populate.  That's
almost as evil as overlaying a struct page with a spinlock_t.  But arm26
is never SMP, and we now only poison when SMP, so it's not a problem.

And the PA-RISC situation has been recently improved: CONFIG_PA20
works without the 16-byte alignment which inflated its spinlock_t.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/Kconfig |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- mm03/mm/Kconfig	2005-11-07 07:39:59.000000000 +0000
+++ mm04/mm/Kconfig	2005-11-09 14:38:32.000000000 +0000
@@ -125,14 +125,12 @@ comment "Memory hotplug is currently inc
 # space can be handled with less contention: split it at this NR_CPUS.
 # Default to 4 for wider testing, though 8 might be more appropriate.
 # ARM's adjust_pte (unused if VIPT) depends on mm-wide page_table_lock.
-# PA-RISC's debug spinlock_t is too large for the 32-bit struct page.
-# ARM26 and SPARC32 and PPC64 may use one page for multiple page tables.
+# PA-RISC 7xxx's debug spinlock_t is too large for 32-bit struct page.
 #
 config SPLIT_PTLOCK_CPUS
 	int
 	default "4096" if ARM && !CPU_CACHE_VIPT
-	default "4096" if PARISC && DEBUG_SPINLOCK && !64BIT
-	default "4096" if ARM26 || SPARC32 || PPC64
+	default "4096" if PARISC && DEBUG_SPINLOCK && !PA20
 	default "4"
 
 #
