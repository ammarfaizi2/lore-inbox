Return-Path: <linux-kernel-owner+w=401wt.eu-S932793AbWLSLw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbWLSLw2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 06:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWLSLw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 06:52:28 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:45346 "EHLO
	amsfep12-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932793AbWLSLw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 06:52:27 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <4587C5C8.2060304@yahoo.com.au>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <45876C65.7010301@yahoo.com.au>
	 <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
	 <45878BE8.8010700@yahoo.com.au>
	 <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
	 <4587B762.2030603@yahoo.com.au>  <20061219023255.f5241bb0.akpm@osdl.org>
	 <1166525535.10372.138.camel@twins>  <4587C5C8.2060304@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 12:51:09 +0100
Message-Id: <1166529069.10372.146.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 21:58 +1100, Nick Piggin wrote:
> Peter Zijlstra wrote:
> > On Tue, 2006-12-19 at 02:32 -0800, Andrew Morton wrote:
> 
> >>Well it used to be.  After 2.6.19 it can do the wrong thing for mapped
> >>pages.  But it turns out that we don't feed it mapped pages, apart from
> >>pagevec_strip() and possibly races against pagefaults.
> > 
> > 
> > So how about this:
> 
> Well that's still racy. Anyway several earlier patches (including
> the one I posted) closed this race. Some were still reported to
> trigger corruption IIRC.

I can't remember a patch that removes mapped pages from this code path,
however I could have missed it. All out removing the mapping branch in
ttfb() did also fix the problem - which is a superset of page_mapped().

I'm now building a kernel with this patch, and will submit that to
rtorrent with mem=256M on a 1k ext3 filesystem on x86_64 smp preempt.

---
 fs/buffer.c |   32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -2798,11 +2798,38 @@ static inline int buffer_busy(struct buf
 		(bh->b_state & ((1 << BH_Dirty) | (1 << BH_Lock)));
 }
 
+/*
+ * AKPM sayeth:
+ *
+ * - a process does a one-byte-write to a file on a 64k pagesize, 4k
+ *   blocksize ext3 filesystem.  The page is now PageDirty, !PgeUptodate and
+ *   has one dirty buffer and 15 not uptodate buffers.
+ *
+ * - kjournald writes the dirty buffer.  The page is now PageDirty,
+ *   !PageUptodate and has a mix of clean and not uptodate buffers.
+ *
+ * - try_to_free_buffers() removes the page's buffers.  It MUST now clear
+ *   PageDirty.  If we were to leave the page dirty then we'd have a dirty, not
+ *   uptodate page with no buffer_heads.
+ *
+ *   We're screwed: we cannot write the page because we don't know which
+ *   sections of it contain garbage.  We cannot read the page because we don't
+ *   know which sections of it contain modified data.  We cannot free the page
+ *   because it is dirty.
+ *
+ * However for mapped pages this is not true; mapped pages will be fully
+ * loaded and thus cannot have not uptodate buffers.
+ *
+ * Hence allow the PG_dirty bit to stay for pages that had no not uptodate
+ * buffers (and assert that mapped pages never have those).
+ */
+
 static int
 drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
 {
 	struct buffer_head *head = page_buffers(page);
 	struct buffer_head *bh;
+	int uptodate = 1;
 
 	bh = head;
 	do {
@@ -2818,11 +2845,14 @@ drop_buffers(struct page *page, struct b
 
 		if (!list_empty(&bh->b_assoc_buffers))
 			__remove_assoc_queue(bh);
+		if (!buffer_uptodate(bh))
+			uptodate = 0;
 		bh = next;
 	} while (bh != head);
 	*buffers_to_free = head;
 	__clear_page_buffers(page);
-	return 1;
+	VM_BUG_ON(page_mapped(page) && !uptodate);
+	return !uptodate;
 failed:
 	return 0;
 }


