Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317905AbSHBAJN>; Thu, 1 Aug 2002 20:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317906AbSHBAJN>; Thu, 1 Aug 2002 20:09:13 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:65253 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317905AbSHBAJM>;
	Thu, 1 Aug 2002 20:09:12 -0400
Date: Thu, 1 Aug 2002 17:12:39 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200208020012.g720CdeJ017016@napali.hpl.hp.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: adjust prefetch in free_one_pgd()
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As per an earlier discussion on the lkml, the existing prefetch in
free_one_pgd() is somewhat broken in that it prefetches further than
PREFETCH_STRIDE bytes.  The patch below fixes that.  I'm told that
this also performs better on x86 (it makes little difference on ia64,
but it is also marginally better).

	--david

diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Thu Aug  1 17:02:14 2002
+++ b/mm/memory.c	Thu Aug  1 17:02:14 2002
@@ -110,7 +110,7 @@
 	pmd = pmd_offset(dir, 0);
 	pgd_clear(dir);
 	for (j = 0; j < PTRS_PER_PMD ; j++) {
-		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
+		prefetchw(pmd + j + PREFETCH_STRIDE/sizeof(*pmd));
 		free_one_pmd(tlb, pmd+j);
 	}
 	pmd_free_tlb(tlb, pmd);
