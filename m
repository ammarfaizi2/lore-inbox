Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932721AbWEXMbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbWEXMbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 08:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbWEXMbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 08:31:53 -0400
Received: from silver.veritas.com ([143.127.12.111]:43893 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932721AbWEXMbx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 08:31:53 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,165,1146466800"; 
   d="scan'208"; a="38465441:sNHT25381144"
Date: Wed, 24 May 2006 13:31:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH mm] swapless page migration: fix swapops.h:97 BUG
Message-ID: <Pine.LNX.4.64.0605241329010.9391@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 May 2006 12:31:52.0315 (UTC) FILETIME=[09047CB0:01C67F2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several times while testing swapless page migration (I've no NUMA, just
hacking it up to migrate recklessly while running load), I've hit the
BUG_ON(!PageLocked(p)) in migration_entry_to_page.

This comes from an orphaned migration entry, unrelated to the current
correctly locked migration, but hit by remove_anon_migration_ptes as
it checks an address in each vma of the anon_vma list.

Such an orphan may be left behind if an earlier migration raced with fork:
copy_one_pte can duplicate a migration entry from parent to child, after
remove_anon_migration_ptes has checked the child vma, but before it has
removed it from the parent vma.  (If the process were later to fault on
this orphaned entry, it would hit the same BUG from migration_entry_wait.)

This could be fixed by locking anon_vma in copy_one_pte, but we'd rather
not.  There's no such problem with file pages, because vma_prio_tree_add
adds child vma after parent vma, and the page table locking at each end
is enough to serialize.  Follow that example with anon_vma: add new vmas
to the tail instead of the head.

(There's no corresponding problem when inserting migration entries,
because a missed pte will leave the page count and mapcount high,
which is allowed for.  And there's no corresponding problem when
migrating via swap, because a leftover swap entry will be correctly
faulted.  But the swapless method has no refcounting of its entries.)

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/rmap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 2.6.17-rc4-mm3/mm/rmap.c	2006-05-22 12:19:04.000000000 +0100
+++ linux/mm/rmap.c	2006-05-22 12:51:02.000000000 +0100
@@ -103,7 +103,7 @@ int anon_vma_prepare(struct vm_area_stru
 		spin_lock(&mm->page_table_lock);
 		if (likely(!vma->anon_vma)) {
 			vma->anon_vma = anon_vma;
-			list_add(&vma->anon_vma_node, &anon_vma->head);
+			list_add_tail(&vma->anon_vma_node, &anon_vma->head);
 			allocated = NULL;
 		}
 		spin_unlock(&mm->page_table_lock);
@@ -127,7 +127,7 @@ void __anon_vma_link(struct vm_area_stru
 	struct anon_vma *anon_vma = vma->anon_vma;
 
 	if (anon_vma) {
-		list_add(&vma->anon_vma_node, &anon_vma->head);
+		list_add_tail(&vma->anon_vma_node, &anon_vma->head);
 		validate_anon_vma(vma);
 	}
 }
@@ -138,7 +138,7 @@ void anon_vma_link(struct vm_area_struct
 
 	if (anon_vma) {
 		spin_lock(&anon_vma->lock);
-		list_add(&vma->anon_vma_node, &anon_vma->head);
+		list_add_tail(&vma->anon_vma_node, &anon_vma->head);
 		validate_anon_vma(vma);
 		spin_unlock(&anon_vma->lock);
 	}
