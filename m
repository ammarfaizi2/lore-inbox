Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbVHZRFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbVHZRFX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbVHZRCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:02:14 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:31637 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965114AbVHZRCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:02:07 -0400
Subject: [patch 03/18] remap_file_pages protection support: make mprotect skip pagetables on nonuniform
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:53:00 +0200
Message-Id: <20050826165300.527B9156D21@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

There is IMHO no reason to support using mprotect on non-uniform VMAs. The
only exception is to change the VMA's default protection (which is used for
non-individually remapped pages), but it must still ignore the page tables, as
done in this patch.

The only unsatisfied need is if I want to change protections without changing
the indexes, which with remap_file_pages you must do one page at a time and
re-specifying the indexes.

It is more reasonable to allow remap_file_pages to change protections on a PTE
range without changing the offsets. I've not implemented this, but if wanted I
can. For sure, UML doesn't currently need this interface.

However, for now I've implemented only this change to mprotect(), I'd like to
get some feedback about this choice.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/mprotect.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN mm/mprotect.c~rfp-mprotect-skip-pagetables-on-nonuniform mm/mprotect.c
--- linux-2.6.git/mm/mprotect.c~rfp-mprotect-skip-pagetables-on-nonuniform	2005-08-17 13:36:43.000000000 +0200
+++ linux-2.6.git-paolo/mm/mprotect.c	2005-08-17 13:36:43.000000000 +0200
@@ -86,6 +86,9 @@ static void change_protection(struct vm_
 	unsigned long start = addr;
 
 	BUG_ON(addr >= end);
+	if (vma->vm_flags & VM_NONUNIFORM)
+		return;
+
 	pgd = pgd_offset(mm, addr);
 	flush_cache_range(vma, addr, end);
 	spin_lock(&mm->page_table_lock);
_
