Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbULQNLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbULQNLb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 08:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbULQNLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 08:11:31 -0500
Received: from mail.renesas.com ([202.234.163.13]:39146 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262804AbULQNLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 08:11:21 -0500
Date: Fri, 17 Dec 2004 22:11:08 +0900 (JST)
Message-Id: <20041217.221108.840832167.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Update 4-level page table support
 (was Re: [PATCH 8/17] 4level support for m32r)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <417CAA05.mail3YV11VZXC@wotan.suse.de>
References: <417CAA05.mail3YV11VZXC@wotan.suse.de>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

More updates for 4-level support for m32r.
This patch is needed to fix compile error of -mm tree for m32r.
Please apply.

Regards,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

diff -ruNp a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
--- a/arch/m32r/mm/fault.c	2004-12-16 11:37:01.000000000 +0900
+++ b/arch/m32r/mm/fault.c	2004-12-16 11:37:46.000000000 +0900
@@ -122,7 +122,7 @@ asmlinkage void do_page_fault(struct pt_
 
 	/*
 	 * We fault-in kernel-space virtual memory on-demand. The
-	 * 'reference' page table is init_mm.pgd.
+	 * 'reference' page table is init_mm.pml4.
 	 *
 	 * NOTE! We MUST NOT take any locks for this case. We may
 	 * be in an interrupt or a critical region, and should
@@ -343,7 +343,7 @@ vmalloc_fault:
 
 		pgd = (pgd_t *)*(unsigned long *)MPTB;
 		pgd = offset + (pgd_t *)pgd;
-		pgd_k = init_mm.pgd + offset;
+		pgd_k = init_mm.pml4 + offset;
 
 		if (!pgd_present(*pgd_k))
 			goto no_context;
diff -ruNp a/arch/m32r/mm/init.c b/arch/m32r/mm/init.c
--- a/arch/m32r/mm/init.c	2004-12-16 11:37:01.000000000 +0900
+++ b/arch/m32r/mm/init.c	2004-12-15 13:02:27.000000000 +0900
@@ -142,7 +142,7 @@ void __init paging_init(void)
 	/* We don't need kernel mapping as hardware support that. */
 	pg_dir = swapper_pg_dir;
 
-	for (i = 0 ; i < USER_PTRS_PER_PGD * 2 ; i++)
+	for (i = 0 ; i < USER_PGDS_IN_LAST_PML4 * 2 ; i++)
 		pgd_val(pg_dir[i]) = 0;
 #endif /* CONFIG_MMU */
 	hole_pages = zone_sizes_init();

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

