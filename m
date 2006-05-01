Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWEAPG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWEAPG0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 11:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWEAPGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 11:06:25 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:29922 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932135AbWEAPGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 11:06:25 -0400
Date: Mon, 1 May 2006 23:06:25 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: splice(SPLICE_F_MOVE) problems
Message-ID: <20060501190625.GA174@oleg>
References: <20060501065953.GA289@oleg> <20060501065412.GP23137@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501065412.GP23137@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01, Jens Axboe wrote:
>
> On Mon, May 01 2006, Oleg Nesterov wrote:
> > 
> > I can't understand why do we need PIPE_BUF_FLAG_STOLEN at all.
> > It seems to me we need a local boolean in pipe_to_file.
> 
> PIPE_BUF_FLAG_STOLEN used to be used in the release function as well,
> hence the flag.

Ok, but in that case

>                                               I'll make sure to clear
> the flag as well on add_to_page_cache() failure.

... it is not good to clear it in pipe_to_file(). The page remains
stolen from pipe_buf_operations pov, this flag imho should be private
to buf, and page_cache_pipe_buf_ops doesn't need it.

I think pipe_to_buf() can test 'buf->page == page' instead of
PIPE_BUF_FLAG_STOLEN.

Another question,

	__generic_file_splice_read:

		/*
		 * Initiate read-ahead on this page range. however, don't call into
		 * read-ahead if this is a non-zero offset (we are likely doing small
		 * chunk splice and the page is already there) for a single page.
		 */
		if (!loff || nr_pages > 1)
			page_cache_readahead(mapping, &in->f_ra, in, index, nr_pages);

Why this check? page_cache_readahead() should detect sub-page
reads correctly.

		page = find_get_page(mapping, index);
		if (!page) {
			page = page_cache_alloc_cold();

			add_to_page_cache_lru(page);

I think it makes sense to add handle_ra_miss() here. Otherwise,
for example, readahead could be disabled by RA_FLAG_INCACHE
forever.

If readahead doesn't work, SPLICE_F_MOVE is problematic too.
add_to_page_cache_lru()->lru_cache_add() first increments
page->count and adds this page to lru_add_pvecs. This means
page_cache_pipe_buf_steal()->remove_mapping() will probably
fail.

Oleg.

