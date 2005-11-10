Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbVKJByn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbVKJByn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbVKJByn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:54:43 -0500
Received: from gold.veritas.com ([143.127.12.110]:34612 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751433AbVKJByl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:54:41 -0500
Date: Thu, 10 Nov 2005 01:53:30 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Paul Mackerras <paulus@samba.org>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] mm: powerpc init_mm without ptlock
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100151450.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 01:54:41.0448 (UTC) FILETIME=[B717E280:01C5E599]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Restore an earlier mod which went missing in the powerpc reshuffle:
the 4xx mmu_mapin_ram does not need to take init_mm.page_table_lock.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/powerpc/mm/4xx_mmu.c |    4 ----
 1 files changed, 4 deletions(-)

--- mm07/arch/powerpc/mm/4xx_mmu.c	2005-11-07 07:39:05.000000000 +0000
+++ mm08/arch/powerpc/mm/4xx_mmu.c	2005-11-09 14:39:29.000000000 +0000
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
