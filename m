Return-Path: <linux-kernel-owner+w=401wt.eu-S1161017AbWLTXc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWLTXc5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbWLTXc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:32:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48483 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161017AbWLTXc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:32:56 -0500
Date: Wed, 20 Dec 2006 15:32:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
Message-Id: <20061220153207.b2a0a27f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	<1166571749.10372.178.camel@twins>
	<Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	<1166605296.10372.191.camel@twins>
	<1166607554.3365.1354.camel@laptopd505.fenrus.org>
	<1166614001.10372.205.camel@twins>
	<Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
	<1166622979.10372.224.camel@twins>
	<20061220170323.GA12989@deprecation.cyrius.com>
	<Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	<20061220175309.GT30106@deprecation.cyrius.com>
	<Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	<Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 11:50:50 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> Ok, I'll just put my money where my mouth is, and suggest a patch like 
> THIS instead.
> 
> ...
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index d1f1b54..263f88e 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2834,7 +2834,7 @@ int try_to_free_buffers(struct page *page)
>  	int ret = 0;
>  
>  	BUG_ON(!PageLocked(page));
> -	if (PageWriteback(page))
> +	if (PageDirty(page) || PageWriteback(page))
>  		return 0;
>  
>  	if (mapping == NULL) {		/* can this still happen? */
> @@ -2845,22 +2845,6 @@ int try_to_free_buffers(struct page *page)
>  	spin_lock(&mapping->private_lock);
>  	ret = drop_buffers(page, &buffers_to_free);
>  	spin_unlock(&mapping->private_lock);
> -	if (ret) {
> -		/*
> -		 * If the filesystem writes its buffers by hand (eg ext3)
> -		 * then we can have clean buffers against a dirty page.  We
> -		 * clean the page here; otherwise later reattachment of buffers
> -		 * could encounter a non-uptodate page, which is unresolvable.
> -		 * This only applies in the rare case where try_to_free_buffers
> -		 * succeeds but the page is not freed.
> -		 *
> -		 * Also, during truncate, discard_buffer will have marked all
> -		 * the page's buffers clean.  We discover that here and clean
> -		 * the page also.
> -		 */
> -		if (test_clear_page_dirty(page))
> -			task_io_account_cancelled_write(PAGE_CACHE_SIZE);
> -	}

I think this will be OK, because vmscan has just run ->writepage anyway. 
But we will need to make changes to truncate_complete_page() - make it run
cancel_dirty_page() before it runs do_invalidatepage().  


I don't think there's anything preventing zap_pte_range() or perhaps a
pagefault from coming in and dirtying this page after we've tested
PageDirty().

That could leave us with a dirty, non-uptodate page with no buffers, which
is very bad.  But this situation is hopefully impossible, because if the
page is not uptodate then the first thing a pagefault will do is bring it
uptodate, which involves locking it. And if zap_pte_range() is looking at
this page, it is uptodate.


If the page _was_ uptodate and the zap_pte_range() race happens, we'll end
up with with either a dirty page with dirty buffers or a dirty uptodate
page with no buffers, both of which are OK.



> +void cancel_dirty_page(struct page *page, unsigned int account_size)
> +{
> +	/* If we're cancelling the page, it had better not be mapped any more */
> +	if (page_mapped(page)) {
> +		static unsigned int warncount;
> +
> +		WARN_ON(++warncount < 5);
> +	}
> +		
> +	if (TestClearPageDirty(page) && account_size)
> +		task_io_account_cancelled_write(account_size);
> +}

This doesn't clear the radix-tree dirty tags.  I'm not sure what effect
that would have on a truncated mapping.  Perhaps just a bit of extra work
in radix-tree lookup during writeback.

If we _know_ that this page is about to be removed from pagecache then
radix_tree_delete() will delete the tags for us anyway, but
invalidate_inode_pages2() can decide to back out.

> @@ -386,12 +399,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>  					  PAGE_CACHE_SIZE, 0);
>  				}
>  			}
> -			was_dirty = test_clear_page_dirty(page);
> -			if (!invalidate_complete_page2(mapping, page)) {
> -				if (was_dirty)
> -					set_page_dirty(page);
> +			if (!invalidate_complete_page2(mapping, page))
>  				ret = -EIO;
> -			}
>  			unlock_page(page);

Well, it used to.

invalidate_complete_page2() is pretty gruesome.  We're handling the case
where someone went and redirtied the page (and hence its buffers) after the
invalidate_inode_pages2() caller (generic_file_direct_IO) synced it to
disk.

I'd prefer to just fail the direct-io if someone did that, but then
people's tests fail and they whine.

It's tempting to just truncate the damn page and discard the user's data -
the app is being silly.  But that would permit access to uninitialised disk
blocks.

With your change I think what'll happen is that we'll correctly handle the
case where the page and its buffers are dirty (it gets left in place), but
we'll needlessy fail in the case where the page is dirty but the buffers
are clean.  How important that will be in practice I do not know.  People
will get -EIOs where they used not to.

A suitable fix for that might to be to simply not return -EIO here.  So
some thread went and dirtied a pagecache page after
generic_file_direct_IO() synced the data.  Big deal, that's your own fault.
Usually the disk will end up getting a copy of the dirtied pagecache page
and rarely it'll get a copy of the direct-io-written page.

