Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWC3TTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWC3TTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWC3TTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:19:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750770AbWC3TTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:19:39 -0500
Date: Thu, 30 Mar 2006 11:19:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] splice support #2
Message-Id: <20060330111917.3b19f69c.akpm@osdl.org>
In-Reply-To: <20060330123011.GB13476@suse.de>
References: <20060330100630.GT13476@suse.de>
	<20060330021644.7f7c5282.akpm@osdl.org>
	<20060330102419.GU13476@suse.de>
	<20060330031643.028a28de.akpm@osdl.org>
	<20060330115525.GV13476@suse.de>
	<20060330123011.GB13476@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
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
> 

That's good, because the recheck-i_size idea was racy too.  If another
thread were to do a quick truncate-then-extend then there's a window where
we'd see a truncated page, return NULL from page_cache_pipe_buf_map() and
then by the time i_size is re-checked, i_size has grown again so we end up
deciding it must have been an IO error.

