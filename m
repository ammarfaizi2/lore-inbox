Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWDTJxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWDTJxL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 05:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWDTJxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 05:53:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750802AbWDTJxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 05:53:09 -0400
Date: Thu, 20 Apr 2006 02:52:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, sgunderson@bigfoot.com
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages.
Message-Id: <20060420025211.784222d5.akpm@osdl.org>
In-Reply-To: <17479.21320.361708.237802@cse.unsw.edu.au>
References: <20060420160549.7637.patches@notabene>
	<1060420062955.7727@suse.de>
	<20060420003839.1a41c36f.akpm@osdl.org>
	<17479.21320.361708.237802@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
>
> On Thursday April 20, akpm@osdl.org wrote:
> > > Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
> > > Signed-off-by: Neil Brown <neilb@suse.de>
> > > 
> > > ### Diffstat output
> > >  ./mm/truncate.c |   10 ++++------
> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > > 
> > > diff ./mm/truncate.c~current~ ./mm/truncate.c
> > > --- ./mm/truncate.c~current~	2006-04-20 15:27:22.000000000 +1000
> > > +++ ./mm/truncate.c	2006-04-20 15:38:20.000000000 +1000
> > > @@ -238,13 +238,11 @@ unsigned long invalidate_mapping_pages(s
> > >  		for (i = 0; i < pagevec_count(&pvec); i++) {
> > >  			struct page *page = pvec.pages[i];
> > >  
> > > -			if (TestSetPageLocked(page)) {
> > > -				next++;
> > > +			next = page->index+1;
> > > +
> > > +			if (TestSetPageLocked(page))
> > >  				continue;
> > > -			}
> > > -			if (page->index > next)
> > > -				next = page->index;
> > > -			next++;
> > > +
> > >  			if (PageDirty(page) || PageWriteback(page))
> > >  				goto unlock;
> > >  			if (page_mapped(page))
> > 
> > We're not supposed to look at page->index of an unlocked page.
> 
> We're not?

We've avoided it.  But I think we could change the rules.

>  Does Jens know that?
> __generic_file_splice_read seems to violate this principle!

It looks OK from a quick read (but the code duplication is saddening)

> Are you allowed to look at ->mapping? Or can that change magically
> too?

No.  ->mapping can be set to NULL by truncate.   That's why everyone does

	get_page(page);
	lock_page(page);
	if (page->mapping == NULL)
		someone_just_truncated_this_page();

But truncate doesn't alter ->index.  And I think we can assume that.

>  What's the threat-model?  Is it splice(), or something more wicked?

truncate.

> > 
> > In practice, I think it's OK - there's no _reason_ why anyone would want to
> > trash the ->index of a just-truncated page.  However I think it'd be saner
> > to a) only look at ->index after we've tried to lock the page and b) make
> > sure that ->index is really "to the right" of where we're currently at.
> > 
> > How's this look?
> > 
> 
> Uhmm... possibly OK, but I think I'd rather change find_get_pages to
> take an index pointer like find_get_pages_tag does, and do the thing
> safely.  However that started turning into a big patch (reiserfs calls
> find_get_pages directly a few times, and I hadn't even got up to
> callers of pagevec_lookup....

Yes, that could get involved.

> So when I have a cleared head and a bit more time I'll see if I can
> come up with a better patch which only looks at ->index under
> ->tree_lock.

tree_lock will stabilise ->index, yes.

But I think we'd be OK assuming that ->index is stable.  Although that may
break if splice() is concurrently pulling the page out of pagecache and
stuffing it into a pipe.  

