Return-Path: <linux-kernel-owner+w=401wt.eu-S1751564AbWL2KuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWL2KuA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 05:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWL2KuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 05:50:00 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47411 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbWL2Kto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 05:49:44 -0500
Date: Fri, 29 Dec 2006 02:48:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com,
       Andrew Morton <akpm@osdl.org>, a.p.zijlstra@chello.nl, tbm@cyrius.com,
       arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
In-Reply-To: <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
 <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
 <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
 <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2006, Linus Torvalds wrote:
> 
> Hmm? I'd love it if somebody else wrote the patch and tested it, because 
> I'm getting sick and tired of this bug ;)

Who the hell am I kidding? I haven't been able to sleep right for the last 
few days over this bug. It was really getting to me.

And putting on the thinking cap, there's actually a fairly simple an 
nonintrusive patch. It still has a tiny tiny race (see the comment), but I 
bet nobody can really hit it in real life anyway, and I know several ways 
to fix it, so I'm not really _that_ worried about it.

The patch is mostly a comment. The "real" meat of it is actually just a 
few lines.

Can anybody get corruption with this thing applied? It goes on top of 
plain v2.6.20-rc2.

		Linus

----
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b3a198c..ec01da1 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -862,17 +862,46 @@ int clear_page_dirty_for_io(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 
-	if (!mapping)
-		return TestClearPageDirty(page);
-
-	if (TestClearPageDirty(page)) {
-		if (mapping_cap_account_dirty(mapping)) {
-			page_mkclean(page);
+	if (mapping && mapping_cap_account_dirty(mapping)) {
+		/*
+		 * Yes, Virginia, this is indeed insane.
+		 *
+		 * We use this sequence to make sure that
+		 *  (a) we account for dirty stats properly
+		 *  (b) we tell the low-level filesystem to
+		 *      mark the whole page dirty if it was
+		 *      dirty in a pagetable. Only to then
+		 *  (c) clean the page again and return 1 to
+		 *      cause the writeback.
+		 *
+		 * This way we avoid all nasty races with the
+		 * dirty bit in multiple places and clearing
+		 * them concurrently from different threads.
+		 *
+		 * Note! Normally the "set_page_dirty(page)"
+		 * has no effect on the actual dirty bit - since
+		 * that will already usually be set. But we
+		 * need the side effects, and it can help us
+		 * avoid races.
+		 *
+		 * We basically use the page "master dirty bit"
+		 * as a serialization point for all the different
+		 * threds doing their things.
+		 *
+		 * FIXME! We still have a race here: if somebody
+		 * adds the page back to the page tables in
+		 * between the "page_mkclean()" and the "TestClearPageDirty()",
+		 * we might have it mapped without the dirty bit set.
+		 */
+		if (page_mkclean(page))
+			set_page_dirty(page);
+		if (TestClearPageDirty(page)) {
 			dec_zone_page_state(page, NR_FILE_DIRTY);
+			return 1;
 		}
-		return 1;
+		return 0;
 	}
-	return 0;
+	return TestClearPageDirty(page);
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);
 
