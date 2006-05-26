Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWEZTk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWEZTk6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWEZTk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:40:57 -0400
Received: from silver.veritas.com ([143.127.12.111]:46456 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751286AbWEZTk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:40:57 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,177,1146466800"; 
   d="scan'208"; a="38565033:sNHT25115324"
Date: Fri, 26 May 2006 19:26:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH mm] swapless page migration: fix fork corruption
Message-ID: <Pine.LNX.4.64.0605261923430.24818@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 May 2006 19:40:56.0603 (UTC) FILETIME=[4EA296B0:01C680FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several times while testing swapless page migration, gcc has tried to
exec a pointer instead of a string: smells like COW mappings are not
being properly write-protected on fork.

The protection in copy_one_pte looks very convincing, until at last you
realize that the second arg to make_migration_entry is a boolean "write",
and SWP_MIGRATION_READ is 30.

Anyway, it's better done like in change_pte_range, using
is_write_migration_entry and make_migration_entry_read.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
This is a fix to -mm's swapless-pm-add-r-w-migration-entries.patch

 mm/memory.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- 2.6.17-rc4-mm3/mm/memory.c	2006-05-22 12:19:00.000000000 +0100
+++ linux/mm/memory.c	2006-05-26 16:31:59.000000000 +0100
@@ -448,16 +448,13 @@ copy_one_pte(struct mm_struct *dst_mm, s
 						 &src_mm->mmlist);
 				spin_unlock(&mmlist_lock);
 			}
-			if (is_migration_entry(entry) &&
+			if (is_write_migration_entry(entry) &&
 					is_cow_mapping(vm_flags)) {
-				page = migration_entry_to_page(entry);
-
 				/*
 				 * COW mappings require pages in both parent
-				*  and child to be set to read.
+				 * and child to be set to read.
 				 */
-				entry = make_migration_entry(page,
-							SWP_MIGRATION_READ);
+				make_migration_entry_read(&entry);
 				pte = swp_entry_to_pte(entry);
 				set_pte_at(src_mm, addr, src_pte, pte);
 			}
