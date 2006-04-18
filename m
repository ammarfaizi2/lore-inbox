Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWDRA2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWDRA2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 20:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWDRA2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 20:28:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54962 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751380AbWDRA2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 20:28:03 -0400
Date: Mon, 17 Apr 2006 17:27:48 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
In-Reply-To: <20060418090439.3e2f0df4.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0604171724070.2752@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
 <20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
 <20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604140945320.18453@schroedinger.engr.sgi.com>
 <20060415090639.dde469e8.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604151040450.25886@schroedinger.engr.sgi.com>
 <20060417091830.bca60006.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604170958100.29732@schroedinger.engr.sgi.com>
 <20060418090439.3e2f0df4.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2006, KAMEZAWA Hiroyuki wrote:

> Then,
> 
> if (is_migration_entry(entry)) {
> 	change_to_read_migration_entry(entry);
> 	copy_entry(entry);
> }
> 
> is sane.

Hmmm... Looks like I need to do the patch. Is the following okay? This 
will also only work on cow mappings.



Read/Write migration entries: Implement correct behavior in copy_one_pte

Migration entries with write permission must become SWP_MIGRATION_READ
entries if a COW mapping is processed. The migration entries from which
the copy is being made must also become SWP_MIGRATION_READ. This mimicks
the copying of pte for an anonymous page.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc1-mm2/mm/memory.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/memory.c	2006-04-17 16:23:50.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/memory.c	2006-04-17 17:25:50.000000000 -0700
@@ -434,7 +434,9 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	/* pte contains position in swap or file, so copy. */
 	if (unlikely(!pte_present(pte))) {
 		if (!pte_file(pte)) {
-			swap_duplicate(pte_to_swp_entry(pte));
+			swp_entry_t entry = pte_to_swp_entry(pte);
+
+			swap_duplicate(entry);
 			/* make sure dst_mm is on swapoff's mmlist. */
 			if (unlikely(list_empty(&dst_mm->mmlist))) {
 				spin_lock(&mmlist_lock);
@@ -443,6 +445,19 @@ copy_one_pte(struct mm_struct *dst_mm, s
 						 &src_mm->mmlist);
 				spin_unlock(&mmlist_lock);
 			}
+			if (is_migration_entry(entry) &&
+					is_cow_mapping(vm_flags)) {
+				page = migration_entry_to_page(entry);
+
+				/*
+				 * COW mappings require pages in both parent
+				*  and child to be set to read.
+				 */
+				entry = make_migration_entry(page,
+	`					SWP_MIGRATION_READ);
+				pte = swp_entry_to_pte(entry);
+				set_pte_at(src_mm, addr, src_pte, pte);
+			}
 		}
 		goto out_set_pte;
 	}
