Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbRC3OBX>; Fri, 30 Mar 2001 09:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131460AbRC3OBN>; Fri, 30 Mar 2001 09:01:13 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:15761 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S131459AbRC3OBI>; Fri, 30 Mar 2001 09:01:08 -0500
Date: Fri, 30 Mar 2001 15:01:13 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
   linux-kernel@vger.kernel.org
Subject: [PATCH] PAE zap_low_mappings no-op
In-Reply-To: <Pine.LNX.4.30.0103251643070.6469-200000@elte.hu>
Message-ID: <Pine.LNX.4.21.0103301457460.1080-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 pgd_clear() is now a no-op with PAE as without:
so zap_low_mappings() isn't zapping in the PAE case.
Patch below against 2.4.3, or 2.4.2-ac28 offset 1 line.

Hugh

--- 2.4.3/arch/i386/mm/init.c	Mon Mar 26 20:01:56 2001
+++ linux/arch/i386/mm/init.c	Fri Mar 30 14:46:34 2001
@@ -309,14 +309,11 @@
 	 * Zap initial low-memory mappings.
 	 *
 	 * Note that "pgd_clear()" doesn't do it for
-	 * us in this case, because pgd_clear() is a
-	 * no-op in the 2-level case (pmd_clear() is
-	 * the thing that clears the page-tables in
-	 * that case).
+	 * us, because pgd_clear() is a no-op on i386.
 	 */
 	for (i = 0; i < USER_PTRS_PER_PGD; i++)
 #if CONFIG_X86_PAE
-		pgd_clear(swapper_pg_dir+i);
+		set_pgd(swapper_pg_dir+i, __pgd(1 + __pa(empty_zero_page)));
 #else
 		set_pgd(swapper_pg_dir+i, __pgd(0));
 #endif

