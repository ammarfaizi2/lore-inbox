Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWC3Man@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWC3Man (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWC3Man
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:30:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41554 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750982AbWC3Mam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:30:42 -0500
Date: Thu, 30 Mar 2006 14:30:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060330123051.GC13476@suse.de>
References: <20060330100630.GT13476@suse.de> <20060330021644.7f7c5282.akpm@osdl.org> <20060330102419.GU13476@suse.de> <20060330031643.028a28de.akpm@osdl.org> <20060330115525.GV13476@suse.de> <20060330123011.GB13476@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330123011.GB13476@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Jens Axboe wrote:
> On Thu, Mar 30 2006, Jens Axboe wrote:
> > On Thu, Mar 30 2006, Andrew Morton wrote:
> > > Jens Axboe <axboe@suse.de> wrote:
> > > >
> > > > > > +static void *page_cache_pipe_buf_map(struct file *file,
> > > >  > > +				     struct pipe_inode_info *info,
> > > >  > > +				     struct pipe_buffer *buf)
> > > >  > > +{
> > > >  > > +	struct page *page = buf->page;
> > > >  > > +
> > > >  > > +	lock_page(page);
> > > >  > > +
> > > >  > > +	if (!PageUptodate(page)) {
> > > >  > 
> > > >  >  || page->mapping == NULL
> > > > 
> > > >  Fixed
> > > 
> > > Actually that wasn't right.  If the page was truncated then we shouldn't
> > > return -EIO to userspace.  We should return zero, as this is the first
> > > page.
> > 
> > _if_ this is the first page, then agree.
> > 
> > > Which means either returning an ERR_PTR here for -EIO or re-checking i_size
> > > in the caller.   Maybe the latter?
> > 
> > The latter sounds better, I'll add that.
> 
> Actually that's a little hard, since you don't know what state buf->page
> is in - it might be page cache, it might not be. So I opted for the
> ERR_PTR approach, just returning -ENODATA on !page->mapping.

Ala

diff --git a/fs/splice.c b/fs/splice.c
index 7927dff..68b98bb 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -47,9 +47,14 @@ static void *page_cache_pipe_buf_map(str
 
 	lock_page(page);
 
-	if (!PageUptodate(page) || !page->mapping) {
+	if (!PageUptodate(page)) {
+		unlock_page(page);
+		return ERR_PTR(-EIO);
+	}
+
+	if (!page->mapping) {
 		unlock_page(page);
-		return NULL;
+		return ERR_PTR(-ENODATA);
 	}
 
 	return kmap(buf->page);
@@ -279,6 +293,7 @@ static int pipe_to_sendpage(struct pipe_
 	loff_t pos = sd->pos;
 	unsigned int offset;
 	ssize_t ret;
+	void *ptr;
 
 	/*
 	 * sub-optimal, but we are limited by the pipe ->map. we don't
@@ -286,8 +301,9 @@ static int pipe_to_sendpage(struct pipe_
 	 * have the page pinned if the pipe page originates from the
 	 * page cache
 	 */
-	if (!buf->ops->map(file, info, buf))
-		return -EIO;
+	ptr = buf->ops->map(file, info, buf);
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
 
 	offset = pos & ~PAGE_CACHE_MASK;
 
@@ -334,8 +350,8 @@ static int pipe_to_file(struct pipe_inod
 	 * after this, page will be locked and unmapped
 	 */
 	src = buf->ops->map(file, info, buf);
-	if (!src)
-		return -EIO;
+	if (IS_ERR(src))
+		return PTR_ERR(src);
 
 	index = sd->pos >> PAGE_CACHE_SHIFT;
 	offset = sd->pos & ~PAGE_CACHE_MASK;
@@ -436,7 +452,7 @@ static ssize_t move_from_pipe(struct ino
 
 			err = actor(info, buf, &sd);
 			if (err) {
-				if (!ret)
+				if (!ret && err != -ENODATA)
 					ret = err;
 
 				break;

-- 
Jens Axboe

