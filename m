Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263869AbUEXDb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbUEXDb0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 23:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUEXDb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 23:31:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:62944 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263875AbUEXDbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 23:31:18 -0400
Subject: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085369393.15315.28.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 May 2004 13:29:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(RESENT)

There is a subtle race which can cause set_pte to be called on ppc64 on
a PTE that is already present (that normally doesn't happen for us) and
which itself, in the proper race condition, can trigger a duplicate hash
entry to be added to the hash table (very bad).

This fixes it by making sure we trigger the actual flush of the batch
whenever set_pte is called on a present PTE, before putting the new PTE
in.

===== include/asm-ppc64/pgtable.h 1.32 vs edited =====
--- 1.32/include/asm-ppc64/pgtable.h	Fri Apr  9 03:30:57 2004
+++ edited/include/asm-ppc64/pgtable.h	Thu May 20 15:47:40 2004
@@ -396,8 +396,10 @@
  */
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
-	if (pte_present(*ptep))
+	if (pte_present(*ptep)) {
 		pte_clear(ptep);
+		flush_tlb_pending();
+	}
 	*ptep = __pte(pte_val(pte)) & ~_PAGE_HPTEFLAGS;
 }
 


