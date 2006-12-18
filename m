Return-Path: <linux-kernel-owner+w=401wt.eu-S1753426AbWLRHQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbWLRHQk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 02:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbWLRHQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 02:16:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39185 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426AbWLRHQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 02:16:39 -0500
Date: Sun, 17 Dec 2006 23:16:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061217231617.0726b97f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612172145250.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>
	<20061217040620.91dac272.akpm@osdl.org>
	<1166362772.8593.2.camel@localhost>
	<20061217154026.219b294f.akpm@osdl.org>
	<Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612171744360.3479@woody.osdl.org>
	<45861E68.3060403@yahoo.com.au>
	<Pine.LNX.4.64.0612172145250.3479@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2006 21:50:43 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Mon, 18 Dec 2006, Nick Piggin wrote:
> > 
> > I can't see how that's exactly a problem -- so long as the page does not
> > get reclaimed (it won't, because we have a ref on it) then all that matters
> > is that the page eventually gets marked dirty.
> 
> But the point being that "try_to_free_buffers()" marks it clean 
> AFTERWARDS.
> 
> So yes, the page gets marked dirty in the pte's - the hardware generally 
> does that for us, so we don't have to worry about that part going on.
> 
> But "try_to_free_buffers()" seems to clear those dirty bits without 
> serializing it really any way. It just says "ok, I will now clear them". 
> Without knowing whether the dirty bits got set before the IO that cleared 
> the buffer head dirty bits or not.

Yes, I can't see anything correct about the current behaviour.

But I'm going blue in the face here trying to feed try_to_free_buffers() a
page_mapped(page), without success.  pagevec_strip() presumably isn't
triggering.

> What is _that_ serialization? As far as I can see, the only way to 
> guarantee that to happen (since the dirty bits in the page tables will get 
> set without us ever even being notified) is that the page tables 
> themselves must simply never contain that page in a writable form at all.
> 
> And that seems to be lacking.
> 
> Anyway, I have what I consider a much simpler solution: just don't DO all 
> that crap in try_to_free_buffers() at all. I sent it out to some people 
> already, not not very widely. 
> 
> I reproduce my suggestion here for you (and maybe others too who weren't 
> cc'd in that other discussion group) to comment on..
>
> ...
>
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
>  out:
>  	if (buffers_to_free) {
>  		struct buffer_head *bh = buffers_to_free;

This will (at least) cause truncate to do peculiar things. 
do_invalidatepage() runs discard_buffer() against the dirty page and will
then expect try_to_free_buffers() to remove those buffers and then clean
the page.  truncate_complete_page() will clean the page, but it still has
those invalidated buffers.  We'll end up with a large number of clean,
unused pages on the LRU, with attached buffers.  These should eventually
get reaped, but it'll change the page aging dynamics.

