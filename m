Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbULNO7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbULNO7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 09:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbULNO7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 09:59:23 -0500
Received: from users.ccur.com ([208.248.32.211]:14872 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261515AbULNO7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 09:59:17 -0500
Message-ID: <41BEFFBC.2040700@ccur.com>
Date: Tue, 14 Dec 2004 09:59:08 -0500
From: John Blackwood <john.blackwood@ccur.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040301
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/asm-x86_64/pgtable.h pgd_offset_gate()
References: <cpd69c$7m1$1@trex.ccur.com>
In-Reply-To: <cpd69c$7m1$1@trex.ccur.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2004 14:59:13.0695 (UTC) FILETIME=[799B82F0:01C4E1ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore my previous posting.

It turns out that there is already a fix for this problem by Andi Kleen:

# ChangeSet
#   2004/11/15 19:53:40-08:00 ak@suse.de
#   [PATCH] x86-64: Fix get_user_pages access to vsyscall page
#
#   The current kernel oopses on x86-64 when gdb steps into the vsyscall 
page.
#   This patch fixes it.
#
#   I also removed the bogus NULL checks of *_offset and replaced them with
#   proper _none checks.  I made them BUGs because vsyscall pages should be
#   always mapped.
#
#   Signed-off-by: Andi Kleen <ak@suse.de>
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
#
# mm/memory.c
#   2004/11/15 19:29:06-08:00 ak@suse.de +7 -11
#   x86-64: Fix get_user_pages access to vsyscall page
#
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c       2004-12-14 05:20:10 -08:00
+++ b/mm/memory.c       2004-12-14 05:20:10 -08:00
@@ -739,19 +739,15 @@
                         pte_t *pte;
                         if (write) /* user gate pages are read-only */
                                 return i ? : -EFAULT;
-                       pgd = pgd_offset_gate(mm, pg);
-                       if (!pgd)
-                               return i ? : -EFAULT;
+                       if (pg > TASK_SIZE)
+                               pgd = pgd_offset_k(pg);
+                       else
+                               pgd = pgd_offset_gate(mm, pg);
+                       BUG_ON(pgd_none(*pgd));
                         pmd = pmd_offset(pgd, pg);
-                       if (!pmd)
-                               return i ? : -EFAULT;
+                       BUG_ON(pmd_none(*pmd));
                         pte = pte_offset_map(pmd, pg);
-                       if (!pte)
-                               return i ? : -EFAULT;
-                       if (!pte_present(*pte)) {
-                               pte_unmap(pte);
-                               return i ? : -EFAULT;
-                       }
+                       BUG_ON(pte_none(*pte));
                         if (pages) {
                                 pages[i] = pte_page(*pte);
                                 get_page(pages[i]);

