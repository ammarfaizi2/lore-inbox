Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWC3JPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWC3JPR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 04:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWC3JPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 04:15:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33640 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932129AbWC3JPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 04:15:15 -0500
Date: Thu, 30 Mar 2006 11:15:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060330091523.GQ13476@suse.de>
References: <20060329122841.GC8186@suse.de> <20060329143758.607c1ccc.akpm@osdl.org> <20060330074534.GL13476@suse.de> <20060330000240.156f4933.akpm@osdl.org> <20060330081008.GO13476@suse.de> <20060330002726.48cf0ffb.akpm@osdl.org> <20060330085134.GP13476@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330085134.GP13476@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Jens Axboe wrote:
> On Thu, Mar 30 2006, Andrew Morton wrote:
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > > find_get_pages() does "find me the next N pages above `index' which are
> > >  > presently in pagecache'.  So it can return an array of page*'s which do not
> > >  > represent contiguous pages in the file - there can be holes in there.
> > >  > 
> > >  > IOW: pages[n]->index !necessarily= pages[n+1]->index-1
> > >  > 
> > >  > Maybe the code handles that by making sure that all the pages in the range
> > >  > are already in pagecache - I didn't check.  But that would take some heroic
> > >  > locking.
> > > 
> > >  It doesn't, I'm assuming that find_get_pages() returns consequtive pages
> > >  atm. Would seem like the sane interface :-)
> > 
> > Yeah, sorry.  It's a "gather what's presently there" thing.  For writeback.
> > 
> > Nick has some gang-lookup-slots code.  So instead of populating an array of
> > page*'s you can populate an array of (effectively) page**'s.  Then one
> > could walk that.   All while holding ->tree_lock.    This doesn't help ;)
> > 
> > Or you could walk the pages[] array until you hit an ->index which doesn't
> > match and then toss the rest away.  That's a bit of extra work, but in the
> > common case all the pages will be good.  Perhaps.
> > 
> > >  We continue doing find_or_create_page() on the remaining, but using 'i'
> > >  as the 'index' addition. So if we had non-conseq pages, we'd be screwed.
> > 
> > Yup.
> > 
> > Probably the simplest for now is an open-coded find_get_page() loop.  Later
> > on we should optimise that into a find_get_contig_pages() which only takes
> > tree_lock a single time.
> > 
> > Doing it with a new radix_tree_gang_lookup_contig_name_me_longer() would be
> > relatively straightforward too.  It would bale out as soon as it hit a
> > not-present slot.
> 
> I'll go for the simple approach right now, going over the returned
> find_get_pages() array and moving pages around and filling holes doesn't
> sound too alluring. Thanks!

Actually it isn't so bad, how does this look?

diff --git a/fs/splice.c b/fs/splice.c
index 6327a7c..e7bb2ed 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -161,7 +161,8 @@ static int __generic_file_splice_read(st
 	struct address_space *mapping = in->f_mapping;
 	unsigned int offset, nr_pages;
 	struct page *pages[PIPE_BUFFERS];
-	pgoff_t index;
+	struct page *page;
+	pgoff_t index, pidx;
 	int i;
 
 	index = in->f_pos >> PAGE_CACHE_SHIFT;
@@ -180,30 +181,48 @@ static int __generic_file_splice_read(st
 	i = find_get_pages(mapping, index, nr_pages, pages);
 
 	/*
-	 * If not all pages were in the page-cache, we'll
-	 * just assume that the rest haven't been read in,
-	 * so we'll get the rest locked and start IO on
-	 * them if we can..
+	 * common case - we found all pages, kick it off
 	 */
-	while (i < nr_pages) {
-		struct page *page;
-		int error;
-
-		page = find_or_create_page(mapping, index + i, GFP_USER);
-		if (!page)
-			break;
+	if (i == nr_pages)
+		goto splice_them;
 
-		if (PageUptodate(page))
-			unlock_page(page);
-		else {
-			error = mapping->a_ops->readpage(in, page);
-			if (unlikely(error)) {
-				page_cache_release(page);
+	/*
+	 * find_get_pages() may not return consecutive pages, so loop
+	 * over the array moving pages and filling the rest, if need be.
+	 */
+	for (i = 0, pidx = index; i < nr_pages; pidx++, i++) {
+		if (!pages[i]) {
+			int error;
+fill_page:
+			/*
+			 * no page there, look one up / create it
+			 */
+			page = find_or_create_page(mapping, pidx, GFP_HIGHUSER);
+			if (!page)
 				break;
+
+			if (PageUptodate(page))
+				unlock_page(page);
+			else {
+				error = mapping->a_ops->readpage(in, page);
+
+				if (unlikely(error)) {
+					page_cache_release(page);
+					break;
+				}
 			}
+			pages[i] = page;
+		} else if (pages[i]->index != pidx) {
+			page = pages[i];
+			/*
+			 * page isn't in the right spot, move it and jump
+			 * back to filling this one. we know that ->index
+			 * is larger than pidx
+			 */
+			pages[i + page->index - pidx] = page;
+			pages[i] = NULL;
+			goto fill_page;
 		}
-
-		pages[i++] = page;
 	}
 
 	if (!i)
@@ -212,6 +231,7 @@ static int __generic_file_splice_read(st
 	/*
 	 * Now we splice them into the pipe..
 	 */
+splice_them:
 	return move_to_pipe(pipe, pages, i, offset, len);
 }
 

-- 
Jens Axboe

