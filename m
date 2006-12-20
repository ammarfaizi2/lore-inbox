Return-Path: <linux-kernel-owner+w=401wt.eu-S1160996AbWLTXZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160996AbWLTXZx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWLTXZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:25:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41265 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030418AbWLTXZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:25:52 -0500
Date: Thu, 21 Dec 2006 10:24:01 +1100
From: David Chinner <dgc@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061220232401.GB44411608@melbourne.sgi.com>
References: <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org> <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com> <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com> <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com> <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org> <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 11:50:50AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 20 Dec 2006, Linus Torvalds wrote:
> > 
> > So that's why I've been harping on the fact that I think we simply do 
> > really wrong things with PG_dirty at times [ ... ]
> 
> Ok, I'll just put my money where my mouth is, and suggest a patch like 
> THIS instead.
> 
> This one clears up all the issues I find irritating:
> 
>  - "test_clear_page_dirty()" is insane, both conceptually and as an 
>    implementation. "Give me a 'C', give me an 'R', give me an 'A', give me 
>    a 'P'".
> 
>    So rip out that mindfart entirely.
> 
>  - "clear_page_dirty()" is badly named, and should be about CANCELLING the 
>    dirty bit, and must never be called with pages mapped anyway. So throw 
>    that out too, and replace it with a new function:
> 
> 	void cancel_dirty_page(struct page *page, unsigned int accounting_size);
> 
>  - "clear_page_dirty_for_io()" is fine.
> 
> And with that, I then either rip out any old users of 
> "test_clear_page_dirty()" or "clear_page_dirty()", and if appropriate (and 
> it's realy lonly appropriate for "truncate()", I replace them with the new 
> "cancel_dirty_page()". Most of the time, they should just be deleted 
> entirely.
> 
> NOTE NOTE NOTE! I _only_ did enough to make things compile for my 
> particular configuration. That means that right now the following 
> filesystems are broken with this patch (because they use the totally 
> broken old crap):
> 
> 	CIFS, FUSE, JFS, ReiserFS, XFS


XFS appears to call clear_page_dirty to get the mapping tree dirty
tag set correctly at the same time the page dirty flag is cleared. I
note that this can be done by set_page_writeback() if we clear the
dirty flag on the page first when we are writing back the entire page.

Hence it seems to me that the XFS call to clear_page_dirty() could
easily be substituted by clear_page_dirty_for_io() followed by a
call to set_page_writeback() to get the mapping tree tags set
correctly after the page has been marked clean.

Does this make sense (even without the posted patch)?

---
 fs/xfs/linux-2.6/xfs_aops.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6.x-xfs-new/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/xfs/linux-2.6/xfs_aops.c	2006-12-19 12:22:47.000000000 +1100
+++ 2.6.x-xfs-new/fs/xfs/linux-2.6/xfs_aops.c	2006-12-21 10:15:04.545375877 +1100
@@ -340,9 +340,9 @@ xfs_start_page_writeback(
 {
 	ASSERT(PageLocked(page));
 	ASSERT(!PageWriteback(page));
-	set_page_writeback(page);
 	if (clear_dirty)
-		clear_page_dirty(page);
+		clear_page_dirty_for_io(page);
+	set_page_writeback(page);
 	unlock_page(page);
 	if (!buffers) {
 		end_page_writeback(page);

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
