Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbVKUWnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVKUWnK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVKUWmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:42:40 -0500
Received: from silver.veritas.com ([143.127.12.111]:6545 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751226AbVKUWmi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:42:38 -0500
Date: Mon, 21 Nov 2005 20:36:29 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Paul Mackerras <paulus@samba.org>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] mm: powerpc init_mm without ptlock
In-Reply-To: <Pine.LNX.4.61.0511212025220.19274@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511212035060.19274@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511212025220.19274@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Nov 2005 20:36:19.0630 (UTC) FILETIME=[3A7AC4E0:01C5EEDB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Restore an earlier mod which went missing in the powerpc reshuffle:
the 4xx mmu_mapin_ram does not need to take init_mm.page_table_lock.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/powerpc/mm/4xx_mmu.c |    4 ----
 1 files changed, 4 deletions(-)

--- 2.6.15-rc2/arch/powerpc/mm/4xx_mmu.c	2005-11-20 19:43:31.000000000 +0000
+++ linux/arch/powerpc/mm/4xx_mmu.c	2005-11-21 18:51:25.000000000 +0000
@@ -110,13 +110,11 @@ unsigned long __init mmu_mapin_ram(void)
 		pmd_t *pmdp;
 		unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE;
 
-		spin_lock(&init_mm.page_table_lock);
 		pmdp = pmd_offset(pgd_offset_k(v), v);
 		pmd_val(*pmdp++) = val;
 		pmd_val(*pmdp++) = val;
 		pmd_val(*pmdp++) = val;
 		pmd_val(*pmdp++) = val;
-		spin_unlock(&init_mm.page_table_lock);
 
 		v += LARGE_PAGE_SIZE_16M;
 		p += LARGE_PAGE_SIZE_16M;
@@ -127,10 +125,8 @@ unsigned long __init mmu_mapin_ram(void)
 		pmd_t *pmdp;
 		unsigned long val = p | _PMD_SIZE_4M | _PAGE_HWEXEC | _PAGE_HWWRITE;
 
-		spin_lock(&init_mm.page_table_lock);
 		pmdp = pmd_offset(pgd_offset_k(v), v);
 		pmd_val(*pmdp) = val;
-		spin_unlock(&init_mm.page_table_lock);
 
 		v += LARGE_PAGE_SIZE_4M;
 		p += LARGE_PAGE_SIZE_4M;
