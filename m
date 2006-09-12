Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWILRpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWILRpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWILRpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:45:14 -0400
Received: from waste.org ([66.93.16.53]:41883 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030286AbWILRpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:45:12 -0400
Date: Tue, 12 Sep 2006 12:43:41 -0500
From: Matt Mackall <mpm@selenic.com>
To: Aubrey <aubreylee@gmail.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org, davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator
Message-ID: <20060912174339.GA19707@waste.org>
References: <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> <17162.1157365295@warthog.cambridge.redhat.com> <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com> <3551.1157448903@warthog.cambridge.redhat.com> <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com> <44FE4222.3080106@yahoo.com.au> <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 04:07:03PM +0800, Aubrey wrote:
> On 9/6/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >Aubrey wrote:
> >
> >> Yeah, I agree with most of your opinion. Using PG_slab is really a
> >> quickest way to determine the size of the object. But I think using a
> >> flag named "PG_slab" on a memory algorithm named "slob" seems not
> >> reasonable. It may confuse the people who start to read the kernel
> >> source code. So I'm writing to ask if there is a better solution to
> >> fix the issue.
> >
> >
> >No, confusing would be a "slab replacement" that doesn't provide the same
> >API as slab and thus requires users to use ifdefs.
> >
> >I've already suggested exact same thing as David in the exact same 
> >situation
> >about 6 months ago. It is the right way to go.
> 
> OK. Here is the patch and work properly on my side.
> Welcome any suggestions and comments.
> 
> Thanks,
> -Aubrey
> =================================================================
> diff --git a/mm/slob.c b/mm/slob.c
> index 7b52b20..18ed170 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -109,6 +109,7 @@ static void *slob_alloc(size_t size, gfp
> 
> 			slob_free(cur, PAGE_SIZE);
> 			spin_lock_irqsave(&slob_lock, flags);
> +			SetPageSlab(virt_to_page(cur));
> 			cur = slobfree;
> 		}
> 	}
> @@ -162,6 +163,8 @@ void *kmalloc(size_t size, gfp_t gfp)
> 	slob_t *m;
> 	bigblock_t *bb;
> 	unsigned long flags;
> +	int i;
> +	struct page *page;
> 
> 	if (size < PAGE_SIZE - SLOB_UNIT) {
> 		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
> @@ -173,12 +176,17 @@ void *kmalloc(size_t size, gfp_t gfp)
> 		return 0;
> 
> 	bb->order = find_order(size);
> -	bb->pages = (void *)__get_free_pages(gfp, bb->order);
> +	page = alloc_pages(gfp, bb->order);
> +	bb->pages = (void *)page_address(page);

Useless (void *) casts are out of fashion. You shouldn't copy mine.

> 	if (bb->pages) {
> 		spin_lock_irqsave(&block_lock, flags);
> 		bb->next = bigblocks;
> 		bigblocks = bb;
> +		for (i = 0; i < (1 << bb->order); i++) {
> +			SetPageSlab(page);
> +			page++;
> +		}

for ( ; page < page + (1 << bb->order), page++)
      SetPageSlab(page);

I'm not sure it even makes sense to mark the bigblock pages,
especially for the purposes of kobjsize. But see below.

> 		spin_unlock_irqrestore(&block_lock, flags);
> 		return bb->pages;
> 	}
> @@ -202,8 +210,16 @@ void kfree(const void *block)
> 		spin_lock_irqsave(&block_lock, flags);
> 		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
> 			if (bb->pages == block) {
> +				struct page *page = virt_to_page(bb->pages);
> +				int i;
> +
> 				*last = bb->next;
> 				spin_unlock_irqrestore(&block_lock, flags);
> +				for (i = 0; i < (1 << bb->order); i++) {
> +					if (!TestClearPageSlab(page))
> +						BUG();
> +					page++;
> +				}

Please drop the BUG. We've already established it's on our lists by
this point.

> void kmem_cache_init(void)
> {
> +#if 0
> 	void *p = slob_alloc(PAGE_SIZE, 0, PAGE_SIZE-1);
> 
> 	if (p)
> 		free_page((unsigned long)p);
> +#endif
> 
> 	mod_timer(&slob_timer, jiffies + HZ);
> }

You just broke the bit that shrinks the arena.


I don't like this patch. We've just grown SLOB by about 10% everywhere
to make nommu happy. Is this needed because nommu is doing something
special for MMU-less machines or because it's doing something bogus?

To my eyes, the answer seems to clearly be the latter. There's nothing
nommu-specific about kobjsize at all, so it ought to be in the main
kernel if it's actually kosher. But kobjsize tries to guess the size
of an object of unknown type, which is a very suspicious business. If
you've got a pointer, I would propose you ought to know what type it
is, or ought not mess with it at all.

Looking through all the users of kobjsize, it seems we always know
what the type is (and it's usually a VMA). I instead propose we use
ksize on objects we know to be SLAB/SLOB-allocated and add a new
function (kpagesize?) to size other objects where nommu needs it.

As for whether SLOB should emulate PG_slab on general principles, as
far as I can tell, PG_slab should be considered a private debugging
aid to SLAB. All the other users look rather bogus to my eye.

If anything, SLOB should internally abuse PG_slab to mark big pages
and dispense with its bigblocks lists.

-- 
Mathematics is the supreme nostalgia of our time.
