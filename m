Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSKYMz1>; Mon, 25 Nov 2002 07:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSKYMz1>; Mon, 25 Nov 2002 07:55:27 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:57197 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S263246AbSKYMzZ>; Mon, 25 Nov 2002 07:55:25 -0500
Date: Mon, 25 Nov 2002 13:03:45 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Robert Love <rml@tech9.net>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5: kill PF_MEMDIE
In-Reply-To: <1038205919.17472.48.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0211251243190.1117-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Nov 2002, Robert Love wrote:

> PF_MEMDIE seems to serve no needed purpose in 2.5.  In fact, it seems it
> has no point in 2.4, either.
> 
> Attached patch, against 2.5.49-mm1, makes PF_MEMDIE die.

What makes you say no needed purpose?  I agree it's screwed in 2.5,
but its purpose is to make more memory available to the OOMkilled task,
so it's not held up on its way out to freeing memory: seems reasonable.

I'm no great lover of PF_MEMDIE and PF_ flag manipulation, but let it
live until we have an alternative?  I think the better patch is not
to lose PF_MEMDIE (and conceivably others) once it has been set.

(Shall we agree to turn a blind eye to the risk of oom_kill_task
manipulating p->flags while it may be another CPU's current->flags?)

Hugh

--- 2.5.49-mm1/mm/page_alloc.c	Sat Nov 23 10:18:53 2002
+++ linux/mm/page_alloc.c	Mon Nov 25 11:54:27 2002
@@ -432,7 +432,8 @@
 
 	current->flags |= PF_MEMALLOC;
 	ret = try_to_free_pages(classzone, gfp_flags, order);
-	current->flags = cflags;
+	if (!(cflags & PF_MEMALLOC))
+		current->flags &= ~PF_MEMALLOC;
 	return ret;
 }
 
--- 2.5.49-mm1/mm/swap_state.c	Tue Nov  5 00:03:10 2002
+++ linux/mm/swap_state.c	Mon Nov 25 12:08:40 2002
@@ -120,6 +120,7 @@
 {
 	swp_entry_t entry;
 	int pf_flags;
+	int err;
 
 	if (!PageLocked(page))
 		BUG();
@@ -149,9 +150,15 @@
 		/*
 		 * Add it to the swap cache and mark it dirty
 		 */
-		switch (add_to_page_cache(page, &swapper_space, entry.val)) {
+		err = add_to_page_cache(page, &swapper_space, entry.val);
+
+		if (!(pf_flags & PF_NOWARN))
+			current->flags &= ~PF_NOWARN;
+		if (pf_flags & PF_MEMALLOC)
+			current->flags |= PF_MEMALLOC;
+
+		switch (err) {
 		case 0:				/* Success */
-			current->flags = pf_flags;
 			SetPageUptodate(page);
 			ClearPageDirty(page);
 			set_page_dirty(page);
@@ -159,13 +166,11 @@
 			return 1;
 		case -EEXIST:
 			/* Raced with "speculative" read_swap_cache_async */
-			current->flags = pf_flags;
 			INC_CACHE_INFO(exist_race);
 			swap_free(entry);
 			continue;
 		default:
 			/* -ENOMEM radix-tree allocation failure */
-			current->flags = pf_flags;
 			swap_free(entry);
 			return 0;
 		}

