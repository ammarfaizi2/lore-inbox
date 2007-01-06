Return-Path: <linux-kernel-owner+w=401wt.eu-S1751136AbXAFCiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbXAFCiy (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbXAFCch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:32:37 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36830 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbXAFCcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:32:18 -0500
Message-Id: <20070106023542.365678000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:31 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Linus Torvalds <torvalds@macmini.osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Martin J Bligh <mbligh@google.com>, Martin Michlmayr <tbm@cyrius.com>,
       Martin Johansson <martin@fatbob.nu>, Ingo Molnar <mingo@elte.hu>,
       Andrei Popa <andrei.popa@i-neo.ro>, High Dickins <hugh@veritas.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Guillaume Chazarain <guichaz@yahoo.fr>,
       Kenneth Cheng <kenneth.w.chen@intel.com>,
       Tobias Diedrich <ranma@tdiedrich.de>
Subject: [patch 38/50] VM: Fix nasty and subtle race in shared mmaped page writeback
Content-Disposition: inline; filename=vm-fix-nasty-and-subtle-race-in-shared-mmap-ed-page-writeback.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Linus Torvalds <torvalds@macmini.osdl.org>

The VM layer (on the face of it, fairly reasonably) expected that when
it does a ->writepage() call to the filesystem, it would write out the
full page at that point in time.  Especially since it had earlier marked
the whole page dirty with "set_page_dirty()".

But that isn't actually the case: ->writepage() does not actually write
a page, it writes the parts of the page that have been explicitly marked
dirty before, *and* that had not got written out for other reasons since
the last time we told it they were dirty.

That last caveat is the important one.

Which _most_ of the time ends up being the whole page (since we had
called "set_page_dirty()" on the page earlier), but if the filesystem
had done any dirty flushing of its own (for example, to honor some
internal write ordering guarantees), it might end up doing only a
partial page IO (or none at all) when ->writepage() is actually called.

That is the correct thing in general (since we actually often _want_
only the known-dirty parts of the page to be written out), but the
shared dirty page handling had implicitly forgotten about these details,
and had a number of cases where it was doing just the "->writepage()"
part, without telling the low-level filesystem that the whole page might
have been re-dirtied as part of being mapped writably into user space.

Since most of the time the FS did actually write out the full page, we
didn't notice this for a loong time, and this needed some really odd
patterns to trigger.  But it caused occasional corruption with rtorrent
and with the Debian "apt" database, because both use shared mmaps to
update the end result.

This fixes it. Finally. After way too much hair-pulling.

Acked-by: Nick Piggin <nickpiggin@yahoo.com.au>
Acked-by: Martin J. Bligh <mbligh@google.com>
Acked-by: Martin Michlmayr <tbm@cyrius.com>
Acked-by: Martin Johansson <martin@fatbob.nu>
Acked-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Andrei Popa <andrei.popa@i-neo.ro>
Cc: High Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>,
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>
Cc: Arjan van de Ven <arjan@infradead.org>
Cc: Gordon Farquharson <gordonfarquharson@gmail.com>
Cc: Guillaume Chazarain <guichaz@yahoo.fr>
Cc: Theodore Tso <tytso@mit.edu>
Cc: Kenneth Cheng <kenneth.w.chen@intel.com>
Cc: Tobias Diedrich <ranma@tdiedrich.de>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
[chrisw: backport to 2.6.19.1]
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 mm/page-writeback.c |   39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

--- linux-2.6.19.1.orig/mm/page-writeback.c
+++ linux-2.6.19.1/mm/page-writeback.c
@@ -893,12 +893,41 @@ int clear_page_dirty_for_io(struct page 
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
+		 * threads doing their things.
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

--
