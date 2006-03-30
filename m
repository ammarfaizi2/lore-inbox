Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWC3JpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWC3JpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 04:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWC3JpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 04:45:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10544 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751017AbWC3JpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 04:45:14 -0500
Date: Thu, 30 Mar 2006 11:45:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060330094522.GR13476@suse.de>
References: <20060329122841.GC8186@suse.de> <20060329143758.607c1ccc.akpm@osdl.org> <20060330074534.GL13476@suse.de> <20060330000240.156f4933.akpm@osdl.org> <20060330081008.GO13476@suse.de> <20060330002726.48cf0ffb.akpm@osdl.org> <20060330085134.GP13476@suse.de> <20060330091523.GQ13476@suse.de> <20060330014024.6ada0532.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330014024.6ada0532.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > Actually it isn't so bad, how does this look?
> > 
> > ...
> >
> >  @@ -180,30 +181,48 @@ static int __generic_file_splice_read(st
> >   	i = find_get_pages(mapping, index, nr_pages, pages);
> >   
> >   	/*
> >  -	 * If not all pages were in the page-cache, we'll
> >  -	 * just assume that the rest haven't been read in,
> >  -	 * so we'll get the rest locked and start IO on
> >  -	 * them if we can..
> >  +	 * common case - we found all pages, kick it off
> >   	 */
> >  -	while (i < nr_pages) {
> >  -		struct page *page;
> >  -		int error;
> >  -
> >  -		page = find_or_create_page(mapping, index + i, GFP_USER);
> >  -		if (!page)
> >  -			break;
> >  +	if (i == nr_pages)
> >  +		goto splice_them;
> 
> The return value from find_get_pages() is "how many pages did I find" - it
> doesn't tell us whether they were contiguous.

Oh right, so there's still a hole there. The above logic foolishly
thinks that if i == nr_pages, they must be contig. But I can see that
may not be the case. Additionally, I need to init pages[] from i and
forward, since we may be looking at that in the loop.

> How about
> 
> 	if (i && (pages[i - 1]->index == index + i - 1))
> 
> <thinks>
> 
> So if we asked for N pages starting at index=10 and got
> 
> 	[11, 13]
> 
> i == 2
> pages[i-1]->index == 13
> index + i - 1 == 11.
> 
> So I think it's OK.  Yeah, it has to be - any gap at all in the returned
> page array will make pages[i-1]->index too big.

Agree, that should be sound. I'll adjust the code.

> The one-at-a-time logic looks OK from a quick scan.  Do we have logic in
> there to check that we're not overrunning i_size?  (See the pain
> do_generic_mapping_read() goes through).

do_splice_to() checks that, should I move that checking further down in
case the file is truncated?

> argh, readahead.  Really we should be kicking the readahead engine in there
> as well.  That's fairly straightforward - see do_generic_mapping_read().
> 
> Also, the code here _might_ be able to use do_page_cache_readahead() just
> to prepopulate the pages which you know you'll be needing.  There are no
> guarantees that the pages will still be there when you want them of course,
> but it's a decent way of putting a block of pages into a single BIO and
> speeding up the common case.  But if the code is calling
> page_cache_readahead() it won't need to do that.

I'll look into readahead.

-- 
Jens Axboe

