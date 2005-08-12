Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVHLStu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVHLStu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVHLStZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:49:25 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:48572 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S1750976AbVHLSsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:48:55 -0400
Subject: [patch 38/39] [RFC] remap_file_pages protection support: avoid dirtying on read faults for NONUNIFORM pages
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:36:37 +0200
Message-Id: <20050812183637.AA0DE24E7F5@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When installing pages on non-uniform VMA's, even for read faults we must
install them writable if the VMA is writable (we won't have a chance to fix
that). Normally, on write faults, we install the PTE as dirty (there's a
comment about 80386 on this), but maybe it's not needed here on read faults.

I've looked for more info about that comment - unfortunately, it's there
almost unchanged since 2.4.0, so I've found no info.

However, UML does depend on the old behaviour currently (trivial to cure,
anyway). And if other arch's don't have an hardware "dirty" bit, they'll
depend on this too.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/memory.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN mm/memory.c~rfp-fault-optim-risky mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-fault-optim-risky	2005-08-12 19:25:16.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-12 19:25:16.000000000 +0200
@@ -1899,8 +1899,10 @@ retry:
 		 * been set (we can have a writeable VMA with a read-only PTE),
 		 * so we must set the *exact* permission on fault, and avoid
 		 * calling do_wp_page on write faults. */
-		if (write_access || unlikely(vma->vm_flags & VM_NONUNIFORM))
+		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		else if (unlikely(vma->vm_flags & VM_NONUNIFORM))
+			entry = maybe_mkwrite(entry, vma);
 		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
 			lru_cache_add_active(new_page);
_
