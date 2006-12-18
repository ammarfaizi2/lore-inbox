Return-Path: <linux-kernel-owner+w=401wt.eu-S1754279AbWLRQ4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbWLRQ4o (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 11:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754280AbWLRQ4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 11:56:43 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:32262 "EHLO
	amsfep13-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754279AbWLRQ4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 11:56:43 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <20061217154026.219b294f.akpm@osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 17:55:45 +0100
Message-Id: <1166460945.10372.84.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-17 at 15:40 -0800, Andrew Morton wrote:
> On Sun, 17 Dec 2006 15:39:32 +0200
> Andrei Popa <andrei.popa@i-neo.ro> wrote:
> 
> > I was mistaken, I'm still having file corruption with rtorrent.
> > 
> 
> Well I'm not very optimistic, but if people could try this, please...
> 
> 
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> try_to_free_buffers() clears the page's dirty state if it successfully removed
> the page's buffers.
> 
>   Background for this:
> 
>   - a process does a one-byte-write to a file on a 64k pagesize, 4k
>     blocksize ext3 filesystem.  The page is now PageDirty, !PgeUptodate and
>     has one dirty buffer and 15 not uptodate buffers.
> 
>   - kjournald writes the dirty buffer.  The page is now PageDirty,
>     !PageUptodate and has a mix of clean and not uptodate buffers.
> 
>   - try_to_free_buffers() removes the page's buffers.  It MUST now clear
>     PageDirty.  If we were to leave the page dirty then we'd have a dirty, not
>     uptodate page with no buffer_heads.
> 
>     We're screwed: we cannot write the page because we don't know which
>     sections of it contain garbage.  We cannot read the page because we don't
>     know which sections of it contain modified data.  We cannot free the page
>     because it is dirty.
> 

How about we stick something like this on top of that patch. It should
preserve the dirty state as required.

I tried to tinker with avoiding the clear/set thing but could not
convince myself it was close to safe.

This should be safe; page_mkclean walks the rmap and flips the pte's
under the pte lock and records the dirty state while iterating.
Concurrent faults will either do set_page_dirty() before we get around
to doing it or vice versa, but dirty state is not lost.

---
 mm/page-writeback.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6-git/mm/page-writeback.c
===================================================================
--- linux-2.6-git.orig/mm/page-writeback.c	2006-12-18 17:24:41.000000000 +0100
+++ linux-2.6-git/mm/page-writeback.c	2006-12-18 17:26:56.000000000 +0100
@@ -872,8 +872,9 @@ int test_clear_page_dirty(struct page *p
 		 * page is locked, which pins the address_space
 		 */
 		if (mapping_cap_account_dirty(mapping)) {
-			if (must_clean_ptes)
-				page_mkclean(page);
+			int cleaned = page_mkclean(page);
+			if (!must_clean_ptes && cleaned)
+				set_page_dirty(page);
 			dec_zone_page_state(page, NR_FILE_DIRTY);
 		}
 		return 1;


