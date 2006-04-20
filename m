Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWDTJYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWDTJYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 05:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWDTJYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 05:24:39 -0400
Received: from ns2.suse.de ([195.135.220.15]:6031 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750778AbWDTJYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 05:24:39 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 20 Apr 2006 19:24:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17479.21320.361708.237802@cse.unsw.edu.au>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       sgunderson@bigfoot.com
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages.
In-Reply-To: message from Andrew Morton on Thursday April 20
References: <20060420160549.7637.patches@notabene>
	<1060420062955.7727@suse.de>
	<20060420003839.1a41c36f.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday April 20, akpm@osdl.org wrote:
> > Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
> > Signed-off-by: Neil Brown <neilb@suse.de>
> > 
> > ### Diffstat output
> >  ./mm/truncate.c |   10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff ./mm/truncate.c~current~ ./mm/truncate.c
> > --- ./mm/truncate.c~current~	2006-04-20 15:27:22.000000000 +1000
> > +++ ./mm/truncate.c	2006-04-20 15:38:20.000000000 +1000
> > @@ -238,13 +238,11 @@ unsigned long invalidate_mapping_pages(s
> >  		for (i = 0; i < pagevec_count(&pvec); i++) {
> >  			struct page *page = pvec.pages[i];
> >  
> > -			if (TestSetPageLocked(page)) {
> > -				next++;
> > +			next = page->index+1;
> > +
> > +			if (TestSetPageLocked(page))
> >  				continue;
> > -			}
> > -			if (page->index > next)
> > -				next = page->index;
> > -			next++;
> > +
> >  			if (PageDirty(page) || PageWriteback(page))
> >  				goto unlock;
> >  			if (page_mapped(page))
> 
> We're not supposed to look at page->index of an unlocked page.

We're not?  Does Jens know that?
__generic_file_splice_read seems to violate this principle!

Are you allowed to look at ->mapping? Or can that change magically
too?  What's the threat-model?  Is it splice(), or something more wicked?

> 
> In practice, I think it's OK - there's no _reason_ why anyone would want to
> trash the ->index of a just-truncated page.  However I think it'd be saner
> to a) only look at ->index after we've tried to lock the page and b) make
> sure that ->index is really "to the right" of where we're currently at.
> 
> How's this look?
> 

Uhmm... possibly OK, but I think I'd rather change find_get_pages to
take an index pointer like find_get_pages_tag does, and do the thing
safely.  However that started turning into a big patch (reiserfs calls
find_get_pages directly a few times, and I hadn't even got up to
callers of pagevec_lookup....

So when I have a cleared head and a bit more time I'll see if I can
come up with a better patch which only looks at ->index under
->tree_lock.

Thanks for the feedback,

NeilBrown


> --- devel/mm/truncate.c~remove-softlockup-from-invalidate_mapping_pages	2006-04-20 00:20:49.000000000 -0700
> +++ devel-akpm/mm/truncate.c	2006-04-20 00:28:18.000000000 -0700
> @@ -230,14 +230,24 @@ unsigned long invalidate_mapping_pages(s
>  			pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
> +			pgoff_t index;
> +			int locked;
>  
> -			if (TestSetPageLocked(page)) {
> -				next++;
> -				continue;
> -			}
> -			if (page->index > next)
> -				next = page->index;
> +			locked = TestSetPageLocked(page);
> +
> +			/*
> +			 * We really shouldn't be looking at the ->index of an
> +			 * unlocked page.  But we're not allowed to lock these
> +			 * pages.  So we rely upon nobody altering the ->index
> +			 * of this (pinned-by-us) page.
> +			 */
> +			index = page->index;
> +			if (index > next)
> +				next = index;
>  			next++;
> +			if (!locked)
> +				continue;
> +
>  			if (PageDirty(page) || PageWriteback(page))
>  				goto unlock;
>  			if (page_mapped(page))
> _
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
