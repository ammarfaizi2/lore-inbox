Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266230AbVBDXcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266230AbVBDXcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbVBDXci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:32:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:11751 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262102AbVBDXah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:30:37 -0500
Date: Fri, 4 Feb 2005 15:35:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] invalidate range of pages after direct IO write
Message-Id: <20050204153530.0409744b.akpm@osdl.org>
In-Reply-To: <42040176.1030703@oracle.com>
References: <20050129011906.29569.18736.24335@volauvent.pdx.zabbo.net>
	<20050203161927.0090655c.akpm@osdl.org>
	<4202D55E.5030900@oracle.com>
	<20050203182854.0b36fb4d.akpm@osdl.org>
	<42040176.1030703@oracle.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown <zach.brown@oracle.com> wrote:
>
> Andrew Morton wrote:
> 
> > I'd be inclined to hold off on the macro until we actually get the
> > open-coded stuff right..  Sometimes the page lookup loops take an end+1
> > argument and sometimes they take an inclusive `end'.  I think.  That might
> > make it a bit messy.
> > 
> > How's this look?
> 
> Looks good.  It certainly stops the worst behaviour we were worried
> about.  I wonder about 2 things:
> 
> 1) Now that we're calculating a specifc length for pagevec_lookup(), is
> testing that page->index > end still needed for pages that get remapped
> somewhere weird before we locked?  If it is, I imagine we should test
> for < start as well.

Nope.  We're guaranteed that the pages which pagevec_lookup() returned are

a) at or beyond `start' and

b) in ascending pgoff_t order, although not necessarily contiguous. 
   There will be gaps for not-present pages.  It's just an in-order gather.

So we need the `page->index > end' test to cope with the situation where a
request for three pages returned the three pages at indices 10, 11 and
3,000,000.

> 2) If we get a pagevec full of pages that fail the != mapping test we
> will probably just try again, not having changed next.  This is fine, we
> won't find them in our mapping again.

Yes, good point.  That page should go away once we drop our ref, and
it's not in the radix tree any more.

>  But this won't happen if next
> started as 0 and we didn't update it.  I don't know if retrying is the
> intended behaviour or if we care that the start == 0 case doesn't do it.

Good point.  Let's make it explicit?

--- 25/mm/truncate.c~invalidate-range-of-pages-after-direct-io-write-fix-fix	Fri Feb  4 15:33:52 2005
+++ 25-akpm/mm/truncate.c	Fri Feb  4 15:34:47 2005
@@ -260,11 +260,12 @@ int invalidate_inode_pages2_range(struct
 	int i;
 	int ret = 0;
 	int did_range_unmap = 0;
+	int wrapped = 0;
 
 	pagevec_init(&pvec, 0);
 	next = start;
-	while (next <= end &&
-	       !ret && pagevec_lookup(&pvec, mapping, next,
+	while (next <= end && !ret && !wrapped &&
+		pagevec_lookup(&pvec, mapping, next,
 			min(end - next, (pgoff_t)PAGEVEC_SIZE - 1) + 1)) {
 		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
@@ -277,6 +278,8 @@ int invalidate_inode_pages2_range(struct
 			}
 			wait_on_page_writeback(page);
 			next = page->index + 1;
+			if (next == 0)
+				wrapped = 1;
 			while (page_mapped(page)) {
 				if (!did_range_unmap) {
 					/*
@@ -307,8 +310,6 @@ int invalidate_inode_pages2_range(struct
 		}
 		pagevec_release(&pvec);
 		cond_resched();
-		if (next == 0)
-			break;		/* The pgoff_t wrapped */
 	}
 	return ret;
 }
_

> I'm being less excited by the iterating macro the more I think about it.
>    Tearing down the pagevec in some complicated for(;;) doesn't sound
> reliable and I fear that some function that takes a per-page callback
> function pointer from the caller will turn people's stomachs.

heh, OK.

