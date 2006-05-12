Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWELOOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWELOOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWELOOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:14:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932087AbWELOOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:14:18 -0400
Date: Fri, 12 May 2006 07:11:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] FS-Cache: Release page->private in failed
 readahead [try #8]
Message-Id: <20060512071100.5c5d52e9.akpm@osdl.org>
In-Reply-To: <11334.1147437245@warthog.cambridge.redhat.com>
References: <20060511104038.4ecad038.akpm@osdl.org>
	<20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com>
	<20060510160148.9058.81776.stgit@warthog.cambridge.redhat.com>
	<11334.1147437245@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > The above code is identical to the below code, so a new helper function
> > would be appropriate.
> > ...
> > I think the above will be called against an unlocked page, in which case
> > the ->releasepage() implementation might choose to go BUG, or something.
> > I suppose locking the page here will suffice.
> 
> I'll move that bit of code into a helper function, along with the
> page_cache_release() and call it from both places.  I'll also call
> try_to_release_page() as you suggest rather than going directly.  I'll lock
> the page too:
> 
> static inline void read_cache_pages_release_page(struct address_space *mapping,
> 						 struct page *page)
> {
> 	if (PagePrivate(page)) {
> 		page->mapping = mapping;
> 		SetPageLocked(page);

	if (TestSetPagLocked(page))
		BUG();

would make me more comfortable..

> 		try_to_release_page(page, GFP_KERNEL);
> 		page->mapping = NULL;
> 	}
> 
> 	page_cache_release(page);
> }
> 
> > But it all seems a bit abusive of what ->releasepage() is supposed to do.
> 
> Where else should I do it?  I'm using releasepage() to break the association
> that the cache has made with a page.  If I don't do this, the cache may wind
> up retaining metadata unnecessarily.
> 
> I suppose I could add another address space op to do this, and have
> page_cache_release() check page->mapping->a_ops->destroypage(), and then force
> the mapping to be passed through to page_cache_release() where necessary.
> 
> > add_to_page_cache() won't set PagePrivate() anyway, so what point is there
> > in the first hunk?
> 
> The PagePrivate() bit is already set before read_cache_pages() is called.
> What happens is that the cache is invoked first: it sets to read any pages it
> can satisfy from the data it holds, and marks those pages for which it has
> allocated buffer space; the unsatisfied pages are then returned to NFS, which
> then calls read_cache_pages() to invoke readpage() serially - but if any pages
> get discarded, the cache metadata _also_ needs to be discarded.
> 
> > For the second hunk, is it not possible to do this cleanup in the callback
> > function?
> 
> Which callback function?

I was referring to the filler_t thingy.  Is it not possible to get control
of that?

>  The cleanup must be done before the page is returned
> to the page allocator, and since that is performed by read_cache_pages(), in
> read_cache_pages() the cleanup must be done.  The other option is to not use
> read_cache_pages(), I suppose.

hm.  There's a whole pile of stuff in this email which you're the only
person in the world who knows.  But a lot of people need to be able to
read, understand and work upon mm/readahead.c without having to intimately
understand the internals of cachefs behaviour.

So please, can we have some comments in there which describe the new
behaviour in a manner sufficient for a maintainer to follow so people don't
break your stuff?

> > If read_cache_pages() needs this treatment, shouldn't we also do it in
> > read_pages()?
> 
> Because read_pages() doesn't give the filesystem a chance to know about pages
> between it allocating them and it releasing them when add_to_page_cache()
> fails.  Although it calls readpage(), if that fails it should clean up for
> itself.
> 
> read_cache_pages() does not allocate the pages for itself.  It's called from a
> filesystem's readpages() op, which gives the filesystem ample opportunity to
> know about the pages that read_pages() doesn't afford it.
> 
> > And in mpage_readpages()?
> 
> mpage_readpages() uses PG_private for its own purposes, and so keying on that
> for any purpose but holding buffers is impossible, and if mpage_readpages()
> needs to clean those up, it must do so already.

OK.

> However, you've raised a good point, and it's one that'll need to be solved if
> I want to do caching on ISOFS and suchlike.
> 
> > Again, as this appears to be some special treatment for cachefs wouldn't it
> > be better to keep this special handling within cachefs?
> 
> How?  CacheFS can't practically monitor the pages it has been told about just
> in case they've been given back.  The netfs has to drive that end of things.
> 
> I could copy read_cache_pages() and place that in fscache and change it
> thusly, but there's no requirement that a netfs should use PG_private for
> marking cached pages - that just happens to be the way I've done it in NFS and
> AFS, but it can't be the way I do it in ISOFS.
> 
> Out of interest, why do we need PG_private to say there's something in
> page->private?  Can't it just be assumed either that if page->private is
> non-zero or that if a_ops->releasepage() is non-NULL, then we need to
> "release" the page?

page->private is an unsigned long, not a pointer.  The core kernel hence
cannot determine from its value whether or not it is live.  For example, the fs
might choose to treat it as a bitmap of which-blocks-are-uptodate and
which-blocks-are-dirty.
