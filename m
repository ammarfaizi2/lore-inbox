Return-Path: <linux-kernel-owner+w=401wt.eu-S1755028AbWL2Py1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbWL2Py1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 10:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755040AbWL2Py1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 10:54:27 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:42473 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024AbWL2Py0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 10:54:26 -0500
Date: Fri, 29 Dec 2006 16:54:04 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Stephen Clark <Stephen.Clark@seclark.us>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com,
       Andrew Morton <akpm@osdl.org>, a.p.zijlstra@chello.nl,
       arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
Message-ID: <20061229155404.GL2062@deprecation.cyrius.com>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org> <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org> <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org> <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org> <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org> <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org> <20061229140822.GH2062@deprecation.cyrius.com> <4595318B.10102@seclark.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4595318B.10102@seclark.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Clark <Stephen.Clark@seclark.us> [2006-12-29 10:17]:
> >It works for me now, both your testcase as well as an installation of
> >Debian on this ARM device.  I manually applied the patch to 2.6.19.
> 
> Can you post a diff against 2.6.19?

--- a/mm/page-writeback.c	2006-11-29 21:57:37.000000000 +0000
+++ b/mm/page-writeback.c	2006-12-29 11:02:55.555147896 +0000
@@ -893,16 +893,45 @@
 {
 	struct address_space *mapping = page_mapping(page);
 
-	if (mapping) {
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
 		if (TestClearPageDirty(page)) {
-			if (mapping_cap_account_dirty(mapping)) {
-				page_mkclean(page);
-				dec_zone_page_state(page, NR_FILE_DIRTY);
-			}
+			dec_zone_page_state(page, NR_FILE_DIRTY);
 			return 1;
 		}
 		return 0;
-	}
+ 	}
 	return TestClearPageDirty(page);
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);

-- 
Martin Michlmayr
http://www.cyrius.com/
