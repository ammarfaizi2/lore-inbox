Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVHCQNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVHCQNV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 12:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVHCQNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 12:13:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50156 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262290AbVHCQNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 12:13:13 -0400
Date: Wed, 3 Aug 2005 09:12:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Hugh Dickins <hugh@veritas.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <42F09B41.3050409@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0508030902380.3341@g5.osdl.org>
References: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com>
 <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021645050.4921@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508021244250.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508022150530.10815@goblin.wat.veritas.com>
 <42F09B41.3050409@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Aug 2005, Nick Piggin wrote:
> 
> Oh, it gets rid of the -1 for VM_FAULT_OOM. Doesn't seem like there
> is a good reason for it, but might that break out of tree drivers?

Ok, I applied this because it was reasonably pretty and I liked the 
approach. It seems buggy, though, since it was using "switch ()" to test 
the bits (wrongly, afaik), and I'm going to apply the appended on top of 
it. Holler quickly if you disagreee..

		Linus
----
diff --git a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -949,6 +949,8 @@ int get_user_pages(struct task_struct *t
 
 			cond_resched_lock(&mm->page_table_lock);
 			while (!(page = follow_page(mm, start, write_access))) {
+				int ret;
+
 				/*
 				 * Shortcut for anonymous pages. We don't want
 				 * to force the creation of pages tables for
@@ -961,16 +963,18 @@ int get_user_pages(struct task_struct *t
 					break;
 				}
 				spin_unlock(&mm->page_table_lock);
-				switch (__handle_mm_fault(mm, vma, start,
-							write_access)) {
-				case VM_FAULT_WRITE:
-					/*
-					 * do_wp_page has broken COW when
-					 * necessary, even if maybe_mkwrite
-					 * decided not to set pte_write
-					 */
+				ret = __handle_mm_fault(mm, vma, start, write_access);
+
+				/*
+				 * The VM_FAULT_WRITE bit tells us that do_wp_page has
+				 * broken COW when necessary, even if maybe_mkwrite
+				 * decided not to set pte_write. We can thus safely do
+				 * subsequent page lookups as if they were reads.
+				 */
+				if (ret & VM_FAULT_WRITE)
 					write_access = 0;
-					/* FALLTHRU */
+				
+				switch (ret & ~VM_FAULT_WRITE) {
 				case VM_FAULT_MINOR:
 					tsk->min_flt++;
 					break;
