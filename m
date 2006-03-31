Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWCaHQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWCaHQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWCaHQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:16:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23608 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751155AbWCaHQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:16:27 -0500
Date: Fri, 31 Mar 2006 09:16:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Introduce sys_splice() system call
Message-ID: <20060331071635.GA14022@suse.de>
References: <200603302109.k2UL9Auj011419@hera.kernel.org> <20060330161240.11ee3d5f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330161240.11ee3d5f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Andrew Morton wrote:
 
> splice.c should include syscalls.h.

done

> > +	if (i && (pages[i - 1]->index == index + i - 1))
> > +		goto splice_them;
> > +
> > +	/*
> > +	 * fill shadow[] with pages at the right locations, so we only
> > +	 * have to fill holes
> > +	 */
> > +	memset(shadow, 0, i * sizeof(struct page *));
> 
> This leaves shadow[i] up to shadow[nr_pages - 1] uninitialised.
> 
> > +	for (j = 0, pidx = index; j < i; pidx++, j++)
> > +		shadow[pages[j]->index - pidx] = pages[j];
> 
> This can overindex shadow[].

This and the above was already fixed in the splice branch yesterday, it
just missed the cut for the splice #3 posting. So at least that's taken
care of :-). We need to init nr_pages of shadow of course, and don't
increment pidx in that loop (in fact, just use 'index').

> > +	/*
> > +	 * now fill in the holes
> > +	 */
> > +	for (i = 0, pidx = index; i < nr_pages; pidx++, i++) {
> 
> We've lost `i', which is the number of pages in pages[], and the number of
> initialised entries in shadow[].

Doesn't matter, we know that all entries in shadow[] are either valid or
NULL up to nr_pages which is our target.

> > +		int error;
> > +
> > +		if (shadow[i])
> > +			continue;
> 
> As this loop iterates up to nr_pages, which can be greater than the
> now-lost `i', we're playing with potentially-uninitialised entries in
> shadow[].
> 
> Doing
> 
> 	nr_pages = find_get_pages(..., nr_pages, ...)
> 
> up above would be a good start on getting this sorted out.

It should work fine with the memset() and for loop fix.

> 
> > +		/*
> > +		 * no page there, look one up / create it
> > +		 */
> > +		page = find_or_create_page(mapping, pidx,
> > +						   mapping_gfp_mask(mapping));
> > +		if (!page)
> > +			break;
> 
> So if OOM happened, we can still have NULLs and live page*'s in shadow[],
> outside `i'

Yes

> > +		if (PageUptodate(page))
> > +			unlock_page(page);
> > +		else {
> > +			error = mapping->a_ops->readpage(in, page);
> > +
> > +			if (unlikely(error)) {
> > +				page_cache_release(page);
> > +				break;
> > +			}
> > +		}
> > +		shadow[i] = page;
> > +	}
> > +
> > +	if (!i) {
> > +		for (i = 0; i < nr_pages; i++) {
> > +			 if (shadow[i])
> > +				page_cache_release(shadow[i]);
> > +		}
> > +		return 0;
> > +	}
> 
> OK.
> 
> > +	memcpy(pages, shadow, i * sizeof(struct page *));
> 
> If we hit oom above, there can be live page*'s in shadow[], between the
> current value of `i' and the now-lost return from find_get_pages().
> 
> The pages will leak.

Please check the current branch, I don't see any leaks.

> > +
> > +/*
> > + * Send 'len' bytes to socket from 'file' at position 'pos' using sendpage().
> 
> sd->len, actually.

Right, comment corrected.

> > +	ret = mapping->a_ops->prepare_write(file, page, 0, sd->len);
> > +	if (ret)
> > +		goto out;
> > +
> > +	dst = kmap_atomic(page, KM_USER0);
> > +	memcpy(dst + offset, src + buf->offset, sd->len);
> > +	flush_dcache_page(page);
> > +	kunmap_atomic(dst, KM_USER0);
> > +
> > +	ret = mapping->a_ops->commit_write(file, page, 0, sd->len);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	set_page_dirty(page);
> > +	ret = write_one_page(page, 0);
> 
> Still want to know why this is here??
> 
> > +out:
> > +	if (ret < 0)
> > +		unlock_page(page);
> 
> If write_one_page()'s call to ->writepage() failed, this will cause a
> double unlock.

Can probably be improved - can I drop write_one_page() and just unlock
the page and regular cleaning will flush it out?

-- 
Jens Axboe

