Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbRGPI13>; Mon, 16 Jul 2001 04:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267228AbRGPI1T>; Mon, 16 Jul 2001 04:27:19 -0400
Received: from tsukuba.m17n.org ([192.47.44.130]:52668 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S267227AbRGPI1E>;
	Mon, 16 Jul 2001 04:27:04 -0400
Date: Mon, 16 Jul 2001 17:26:50 +0900 (JST)
Message-Id: <200107160826.f6G8QoR04970@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] free_one_pgd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, in my arch (SuperH which uses two-level page table), I've
changed the function pgd_clear to zero-clear the entry.  Then, we see
memory leak.

I think that pgd_clear in free_one_pgd should be placed _after_
calling free_one_pmd.  Or else, free_one_pmd doesn't free anything.

This memory leak occurs when the architecture uses two-level page table
and non-null implementation of pgd_clear.

Index: mm/memory.c
===================================================================
RCS file: /cvsroot/linuxsh/kernel/mm/memory.c,v
retrieving revision 1.31
diff -u -p -r1.31 memory.c
--- mm/memory.c	2001/07/11 01:12:27	1.31
+++ mm/memory.c	2001/07/16 08:05:46
@@ -102,9 +102,9 @@ static inline void free_one_pgd(pgd_t * 
 		return;
 	}
 	pmd = pmd_offset(dir, 0);
-	pgd_clear(dir);
 	for (j = 0; j < PTRS_PER_PMD ; j++)
 		free_one_pmd(pmd+j);
+	pgd_clear(dir);
 	pmd_free(pmd);
 }
 
-- 
