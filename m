Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVBDCej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVBDCej (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 21:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbVBDCei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 21:34:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:12486 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262979AbVBDC34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:29:56 -0500
Date: Thu, 3 Feb 2005 18:28:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] invalidate range of pages after direct IO write
Message-Id: <20050203182854.0b36fb4d.akpm@osdl.org>
In-Reply-To: <4202D55E.5030900@oracle.com>
References: <20050129011906.29569.18736.24335@volauvent.pdx.zabbo.net>
	<20050203161927.0090655c.akpm@osdl.org>
	<4202D55E.5030900@oracle.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown <zach.brown@oracle.com> wrote:
>
> > I'll make that change and plop the patch into -mm, but we need to think
>  > about the infinite-loop problem..
> 
>  I can try hacking together that macro and auditing pagevec_lookup()
>  callers..

I'd be inclined to hold off on the macro until we actually get the
open-coded stuff right..  Sometimes the page lookup loops take an end+1
argument and sometimes they take an inclusive `end'.  I think.  That might
make it a bit messy.

How's this look?



- Don't look up more pages than we're going to use

- Don't test page->index until we've locked the page

- Check for the cursor wrapping at the end of the mapping.

--- 25/mm/truncate.c~invalidate-range-of-pages-after-direct-io-write-fix	2005-02-03 18:20:22.000000000 -0800
+++ 25-akpm/mm/truncate.c	2005-02-03 18:28:24.627796400 -0800
@@ -264,18 +264,14 @@ int invalidate_inode_pages2_range(struct
 	pagevec_init(&pvec, 0);
 	next = start;
 	while (next <= end &&
-	       !ret && pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+	       !ret && pagevec_lookup(&pvec, mapping, next,
+			min(end - next, (pgoff_t)PAGEVEC_SIZE - 1) + 1)) {
 		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 			int was_dirty;
 
-			if (page->index > end) {
-				next = page->index;
-				break;
-			}
-
 			lock_page(page);
-			if (page->mapping != mapping) {	/* truncate race? */
+			if (page->mapping != mapping || page->index > end) {
 				unlock_page(page);
 				continue;
 			}
@@ -311,6 +307,8 @@ int invalidate_inode_pages2_range(struct
 		}
 		pagevec_release(&pvec);
 		cond_resched();
+		if (next == 0)
+			break;		/* The pgoff_t wrapped */
 	}
 	return ret;
 }
_

